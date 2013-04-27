From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 2/2] complete: zsh: use zsh completion for the main cmd
Date: Sat, 27 Apr 2013 15:34:06 -0500
Message-ID: <1367094846-9830-3-git-send-email-felipe.contreras@gmail.com>
References: <1367094846-9830-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 27 22:35:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWBqW-0006Cb-2P
	for gcvg-git-2@plane.gmane.org; Sat, 27 Apr 2013 22:35:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755458Ab3D0Ufk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Apr 2013 16:35:40 -0400
Received: from mail-ob0-f175.google.com ([209.85.214.175]:46585 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755099Ab3D0Ufa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Apr 2013 16:35:30 -0400
Received: by mail-ob0-f175.google.com with SMTP id wp18so4417167obc.6
        for <git@vger.kernel.org>; Sat, 27 Apr 2013 13:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=+veyCmoKlh70NymeHYIwWrZpYUFwZXiscqJVA20k1qw=;
        b=Uu1r7jNKHmVG0a2l/hnENblHRAPnTyufyqkzj5DhwjuTolP4Hd1wyMuYFE20pTm/aU
         l1y20Ci7tWhdooRcDX7fgJBBlTgEKCBTj3fDzWmd5vQWTkPYbrWLLKLwDutRJZWlbYcm
         KxWzeISZYLMtladrLvBuw4QFTWX/ohnq1ykgLLi/77zTdHcwDze0yvhZkDtcROPffmzA
         QoetoIKLFIO/HOcE30T+q5nyIht1u9omlnO4XjakUb0A15N5CKAxZJvIPtxTL0ulkX+E
         AcDNfbodMXgyVTv8pAIAEws6+j1MohNsMLFwHfk4JZzpkSz8DJjpiLY5vs8Hrqyi7XfQ
         oVKA==
X-Received: by 10.182.164.8 with SMTP id ym8mr25015695obb.68.1367094930229;
        Sat, 27 Apr 2013 13:35:30 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id zc8sm13412427obc.8.2013.04.27.13.35.28
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 27 Apr 2013 13:35:29 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.1031.g2ee5873
In-Reply-To: <1367094846-9830-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222697>

So that we can have a nice zsh completion output:

% git <tab>
add       -- add file contents to the index
bisect    -- find by binary search the change that introduced a bug
branch    -- list, create, or delete branches
checkout  -- checkout a branch or paths to the working tree
clone     -- clone a repository into a new directory
commit    -- record changes to the repository
diff      -- show changes between commits, commit and working tree, etc
fetch     -- download objects and refs from another repository
grep      -- print lines matching a pattern
init      -- create an empty Git repository or reinitialize an existing one
log       -- show commit logs
merge     -- join two or more development histories together
mv        -- move or rename a file, a directory, or a symlink
pull      -- fetch from and merge with another repository or a local branch
push      -- update remote refs along with associated objects
rebase    -- forward-port local commits to the updated upstream head
reset     -- reset current HEAD to the specified state
rm        -- remove files from the working tree and from the index
show      -- show various types of objects
status    -- show the working tree status
tag       -- create, list, delete or verify a tag object signed with GPG

And other niceties, like 'git --git-dir=<tab>' showing only directories.

For the rest, the bash completion stuff is still used.

Also, add my copyright, since this more than a thin wrapper.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.zsh | 120 +++++++++++++++++++++++++++++++++-
 1 file changed, 119 insertions(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index 93d8f42..49f0cb8 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -2,6 +2,8 @@
 
 # zsh completion wrapper for git
 #
+# Copyright (c) 2012-2013 Felipe Contreras <felipe.contreras@gmail.com>
+#
 # You need git's bash completion script installed somewhere, by default on the
 # same directory as this script.
 #
@@ -21,6 +23,9 @@ complete ()
 	return 0
 }
 
+zstyle -T ':completion:*:*:git:*' tag-order && \
+	zstyle ':completion:*:*:git:*' tag-order 'common-commands'
+
 zstyle -s ":completion:*:*:git:*" script script
 test -z "$script" && script="$(dirname ${funcsourcetrace[1]%:*})"/git-completion.bash
 ZSH_VERSION='' . "$script"
@@ -69,6 +74,115 @@ __gitcomp_file ()
 	compadd -Q -p "${2-}" -f -- ${=1} && _ret=0
 }
 
+__git_zsh_bash_func ()
+{
+	emulate -L ksh
+
+	local command=$1
+
+	local completion_func="_git_${command//-/_}"
+	declare -f $completion_func >/dev/null && $completion_func && return
+
+	local expansion=$(__git_aliased_command "$command")
+	if [ -n "$expansion" ]; then
+		completion_func="_git_${expansion//-/_}"
+		declare -f $completion_func >/dev/null && $completion_func
+	fi
+}
+
+__git_zsh_cmd_common ()
+{
+	local -a list
+	list=(
+	add:'add file contents to the index'
+	bisect:'find by binary search the change that introduced a bug'
+	branch:'list, create, or delete branches'
+	checkout:'checkout a branch or paths to the working tree'
+	clone:'clone a repository into a new directory'
+	commit:'record changes to the repository'
+	diff:'show changes between commits, commit and working tree, etc'
+	fetch:'download objects and refs from another repository'
+	grep:'print lines matching a pattern'
+	init:'create an empty Git repository or reinitialize an existing one'
+	log:'show commit logs'
+	merge:'join two or more development histories together'
+	mv:'move or rename a file, a directory, or a symlink'
+	pull:'fetch from and merge with another repository or a local branch'
+	push:'update remote refs along with associated objects'
+	rebase:'forward-port local commits to the updated upstream head'
+	reset:'reset current HEAD to the specified state'
+	rm:'remove files from the working tree and from the index'
+	show:'show various types of objects'
+	status:'show the working tree status'
+	tag:'create, list, delete or verify a tag object signed with GPG')
+	_describe -t common-commands 'common commands' list && _ret=0
+}
+
+__git_zsh_cmd_alias ()
+{
+	local -a list
+	list=(${${${(0)"$(git config -z --get-regexp '^alias\.')"}#alias.}%$'\n'*})
+	_describe -t alias-commands 'aliases' list $* && _ret=0
+}
+
+__git_zsh_cmd_all ()
+{
+	local -a list
+	emulate ksh -c __git_compute_all_commands
+	list=( ${=__git_all_commands} )
+	_describe -t all-commands 'all commands' list && _ret=0
+}
+
+__git_zsh_main ()
+{
+	local curcontext="$curcontext" state state_descr line
+	typeset -A opt_args
+	local -a orig_words
+
+	orig_words=( ${words[@]} )
+
+	_arguments -C \
+		'(-p --paginate --no-pager)'{-p,--paginate}'[pipe all output into ''less'']' \
+		'(-p --paginate)--no-pager[do not pipe git output into a pager]' \
+		'--git-dir=-[set the path to the repository]: :_directories' \
+		'--bare[treat the repository as a bare repository]' \
+		'(- :)--version[prints the git suite version]' \
+		'--exec-path=-[path to where your core git programs are installed]:: :_directories' \
+		'--html-path[print the path where git''s HTML documentation is installed]' \
+		'--info-path[print the path where the Info files are installed]' \
+		'--man-path[print the manpath (see `man(1)`) for the man pages]' \
+		'--work-tree=-[set the path to the working tree]: :_directories' \
+		'--namespace=-[set the git namespace]' \
+		'--no-replace-objects[do not use replacement refs to replace git objects]' \
+		'(- :)--help[prints the synopsis and a list of the most commonly used commands]: :->arg' \
+		'(-): :->command' \
+		'(-)*:: :->arg' && return
+
+	case $state in
+	(command)
+		_alternative \
+                         'alias-commands:alias:__git_zsh_cmd_alias' \
+                         'common-commands:common:__git_zsh_cmd_common' \
+                         'all-commands:all:__git_zsh_cmd_all' && _ret=0
+		;;
+	(arg)
+		local command="${words[1]}" __git_dir
+
+		if (( $+opt_args[--bare] )); then
+			__git_dir='.'
+		else
+			__git_dir=${opt_args[--git-dir]}
+		fi
+
+		(( $+opt_args[--help] )) && command='help'
+
+		words=( ${orig_words[@]} )
+
+		__git_zsh_bash_func $command
+		;;
+	esac
+}
+
 _git ()
 {
 	local _ret=1
@@ -78,7 +192,11 @@ _git ()
 	prev=${words[CURRENT-1]}
 	let cword=CURRENT-1
 
-	emulate ksh -c __${service}_main
+	if (( $+functions[__${service}_zsh_main] )); then
+		__${service}_zsh_main
+	else
+		emulate ksh -c __${service}_main
+	fi
 
 	let _ret && _default -S '' && _ret=0
 	return _ret
-- 
1.8.2.1.1031.g2ee5873
