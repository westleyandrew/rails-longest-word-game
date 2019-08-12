require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = []
    @alphabet = ('A'..'Z').to_a
    10.times do
      @letters << @alphabet.sample
    end
      session[:current_score] = 0
      binding.pry
  end

  def score
    @word = params[:word].upcase
    @letters = params[:letters].upcase
    @word_array = @word.upcase.chars
    @letters_array = @letters.chars
    @return_text = ''

    if @word.length > @letters.length
      @return_text = "Sorry but #{@word} cannot be made out of #{@letters}"
    end

    @word_array.each do |letter|
      if @word_array.count(letter) > @letters.count(letter)
        @return_text = "Sorry but #{@word} cannot be made out of #{@letters}"
      end
    end

    url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    word_result_serialized = open(url).read
    word_check_result = JSON.parse(word_result_serialized)
    word_ok = word_check_result['found']

    if word_ok && @return_text == ''
      @return_text = "Congratulations. #{@word} is a valid english word!"
    elsif @return_text == ''
      @return_text = "Sorry but #{@word} is not a valid english word"
    end
  end

end
