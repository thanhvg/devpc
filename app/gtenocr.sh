#!/bin/bash 
# https://askubuntu.com/questions/280475/how-can-instantaneously-extract-text-from-a-screen-area-using-ocr-tools/280713#280713

# Dependencies: tesseract-ocr imagemagick scrot xsel

# when called from gnome shortcut, should delay a bit to scrot won't be confused by gnome
sleep .3

# quick language menu, add more if you need other languages.
# select tesseract_lang in eng rus equ ;do break;done

SCR_IMG=`mktemp`
trap "rm $SCR_IMG*" EXIT

# increase image quality with option -q from default 75 to 100
scrot -s $SCR_IMG.png -q 100    

# should increase detection rate
mogrify -modulate 100,0 -resize 400% $SCR_IMG.png 

tesseract $SCR_IMG.png $SCR_IMG &> /dev/null
cat $SCR_IMG.txt | xsel -bi

exit
