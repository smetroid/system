# .bashrc

# User specific aliases and functions

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi
#Cygwin specific configuration
alias ls='ls --color=auto'
LS_COLORS=$LS_COLORS:'di=0;35:' ; export LS_COLORS

# User specific environment and startup programs
parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
export PS1="\u@\h \[\033[31m\]\w\[\033[33m\]\$(parse_git_branch)\[\033[00m\] $ "

command_exists(){
  type "$1" &> /dev/null ;
}

# if vimx available enable it
if command_exists vimx; then
  alias vim='vimx'
fi


export GOROOT=/usr/local/go
export GOPATH=~/projects/go
export PATH=$PATH:$HOME/projects/go/bin:/usr/local/go/bin

# adding xbind keys
xbindkeys -f ~/.xbindkeysrc

# Bash completion for kubernetes
#. /usr/local/etc/profile.d/bash_completion.sh
#source <(kubectl completion bash)


### Bash History ####
#Bash history specific
export PATH=$HOME/bin:$PATH
#source <(kubectl completion bash)
# Maximum number of history lines in memory
export HISTSIZE=50000
# Maximum number of history lines on disk
export HISTFILESIZE=50000
# Ignore duplicate lines
export HISTCONTROL=ignoredups:erasedups
# When the shell exits, append to the history file
#  instead of overwriting it
shopt -s histappend

# After each command, append to the history file
#  and reread it
export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r"
### Bash History ####

### Pet specific commands ###
function prev() {
  PREV=$(echo `history | tail -n2 | head -n1` | sed 's/[0-9]* //')
  sh -c "pet new `printf %q "$PREV"`"
}

function pet-select() {
  BUFFER=$(pet search --query "$READLINE_LINE")
  READLINE_LINE=$BUFFER
  READLINE_POINT=${#BUFFER}
}
bind -x '"\C-x\C-r": pet-select'
### Pet Specific commands ###


### v to vim ###
# fasd related
alias v='f -e vim' # quick opening files with vim
### v to vim ###
bindkey '^X^A' fasd-complete


### exa ###
alias ll='exa -al'
### exa ###
### renaming cat to bat ###
alias cat='bat'
### renaming cat to bat ###
### fasd_entry ###
eval "$(fasd --init auto)"
### fasd_entry ###
### powerline-shell ###
function _update_ps1() {
  PS1=$(powerline-shell $?)
}

if [[ $TERM != linux && ! $PROMPT_COMMAND =~ _update_ps1 ]]; then
  PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
fi
### powerline-shell ###
# BEGIN ANSIBLE MANAGED BLOCK
function _update_ps1() {
  PS1=$(powerline-shell $?)
}

if [[ $TERM != linux && ! $PROMPT_COMMAND =~ _update_ps1 ]]; then
  PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
fi
# END ANSIBLE MANAGED BLOCK
