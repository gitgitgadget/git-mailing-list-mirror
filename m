From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git gui: Possible to see which commands are executed?
Date: Sun, 18 May 2008 22:21:25 -0400
Message-ID: <20080519022125.GV29038@spearce.org>
References: <48301B17.30309@dirk.my1.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Dirk =?utf-8?Q?S=C3=BCsserott?= <newsletter@dirk.my1.cc>
X-From: git-owner@vger.kernel.org Mon May 19 04:23:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jxv1N-0005cP-4z
	for gcvg-git-2@gmane.org; Mon, 19 May 2008 04:22:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753829AbYESCVv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 May 2008 22:21:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753822AbYESCVv
	(ORCPT <rfc822;git-outgoing>); Sun, 18 May 2008 22:21:51 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:55057 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753160AbYESCV3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 May 2008 22:21:29 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1Jxuzy-0000tT-Um; Sun, 18 May 2008 22:21:15 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 7FAFA20FBAE; Sun, 18 May 2008 22:21:25 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <48301B17.30309@dirk.my1.cc>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82403>

Dirk Ssserott <newsletter@dirk.my1.cc> wrote:
> Is it possible to see which commands are executed by git-gui?
...
> It would be really cool when git-gui could show the command
> in a different window *before* it is executed. Some database
> frontends have an option "show SQL statement", but I think
> that would be demanded too much.

Not presently, no.  People have asked for this in the past, but
its not as easy as it sounds.  git-gui tries to drive the plumbing
commands when possible, not the porcelain that most humans use.
Consequently the stream of commands that git-gui issues is quite
different from what a human would type on the command line, yet
the end result is equivilant.

I hacked this up earlier today on my Cygwin system, just to show you
what I mean.  With the attached patch applied I restarted git-gui
with `git gui --trace` (which this patch introduces) and then used
git-gui to commit this patch to its own repository.

Stop me when you see a command you might type yourself.  ;-)

  C:/cygwin/usr/local/git/bin/git.exe --version
  < git version 1.5.5.1.450.gee27
  C:/cygwin/usr/local/git/bin/git.exe --exec-path
  < /usr/local/git/bin
  C:/cygwin/usr/local/git/bin/git-rev-parse.exe --git-dir
  < .git
  C:/cygwin/usr/local/git/bin/git-rev-parse.exe --show-prefix
  < 
  C:/cygwin/usr/local/git/bin/git-config.exe --null --list
  C:/cygwin/usr/local/git/bin/git-rev-parse.exe --verify HEAD
  < 76bb40cde0e15e8d0e8493abb0bd18a5d6386ad7
  C:/cygwin/usr/local/git/bin/git-update-index.exe -q --unmerged --ignore-missing --refresh
  C:/cygwin/usr/local/git/bin/git-diff-index.exe --cached -z 76bb40cde0e15e8d0e8493abb0bd18a5d6386ad7
  C:/cygwin/usr/local/git/bin/git-diff-files.exe -z
  C:/cygwin/usr/local/git/bin/git-ls-files.exe --others -z --exclude-per-directory=.gitignore --exclude-from=.git/info/exclude
  C:/cygwin/usr/local/git/bin/git-rev-parse.exe --verify HEAD
  < 76bb40cde0e15e8d0e8493abb0bd18a5d6386ad7
  C:/cygwin/usr/local/git/bin/git-update-index.exe -q --unmerged --ignore-missing --refresh
  C:/cygwin/usr/local/git/bin/git-diff-index.exe --cached -z 76bb40cde0e15e8d0e8493abb0bd18a5d6386ad7
  C:/cygwin/usr/local/git/bin/git-diff-files.exe -z
  C:/cygwin/usr/local/git/bin/git-ls-files.exe --others -z --exclude-per-directory=.gitignore --exclude-from=.git/info/exclude
  C:/cygwin/usr/local/git/bin/git-update-index.exe --add --remove -z --stdin
  C:/cygwin/usr/local/git/bin/git-var.exe GIT_COMMITTER_IDENT
  < Shawn O. Pearce <spearce@spearce.org> 1211130496 -0400
  C:/cygwin/usr/local/git/bin/git-rev-parse.exe --verify HEAD
  < 76bb40cde0e15e8d0e8493abb0bd18a5d6386ad7
  C:/cygwin/bin/sh.exe -c 'if test -x "$1";then exec "$@";fi'
  C:/cygwin/bin/sh.exe .git/hooks/pre-commit 2>@1
  C:/cygwin/bin/sh.exe -c 'if test -x "$1";then exec "$@";fi'
  C:/cygwin/bin/sh.exe .git/hooks/commit-msg .git/GITGUI_EDITMSG 2>@1
  C:/cygwin/usr/local/git/bin/git-write-tree.exe
  C:/cygwin/usr/local/git/bin/git-cat-file.exe commit 76bb40cde0e15e8d0e8493abb0bd18a5d6386ad7
  C:/cygwin/usr/local/git/bin/git-commit-tree.exe 26a475c0a74f51872513993c41e8e15286df9fa5 -p 76bb40cde0e15e8d0e8493abb0bd18a5d6386ad7 <.git/GITGUI_EDITMSG
  < cc33ff6ec3582522edaae00354d9b96a797ecf09
  C:/cygwin/usr/local/git/bin/git-update-ref.exe -m 'commit: git-gui: Add a --trace command line option' HEAD cc33ff6ec3582522edaae00354d9b96a797ecf09 76bb40cde0e15e8d0e8493abb0bd18a5d6386ad7
  < 
  C:/cygwin/bin/sh.exe -c 'if test -x "$1";then exec "$@";fi'
  C:/cygwin/bin/sh.exe .git/hooks/post-commit 2>@1

Right.  So I'm not certain how useful this patch really is.  It is
fairly short as all calls to git go through one of three procedures.


--8<--
git-gui: Add a --trace command line option

---
 git-gui.sh |   47 +++++++++++++++++++++++++++++++++++++++--------
 1 files changed, 39 insertions(+), 8 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index 9df4971..6a8831a 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -122,6 +122,14 @@ set _reponame {}
 set _iscygwin {}
 set _search_path {}
 
+set _trace [lsearch -exact $argv --trace]
+if {$_trace >= 0} {
+	set argv [lreplace $argv $_trace $_trace]
+	set _trace 1
+} else {
+	set _trace 0
+}
+
 proc appname {} {
 	global _appname
 	return $_appname
@@ -245,6 +253,21 @@ proc get_config {name} {
 ##
 ## handy utils
 
+proc _trace_exec {cmd} {
+	if {!$::_trace} return
+	set d {}
+	foreach v $cmd {
+		if {$d ne {}} {
+			append d { }
+		}
+		if {[regexp {[ \t\r\n'"$?*]} $v]} {
+			set v [sq $v]
+		}
+		append d $v
+	}
+	puts stderr $d
+}
+
 proc _git_cmd {name} {
 	global _git_cmd_path
 
@@ -339,7 +362,7 @@ proc _lappend_nice {cmd_var} {
 }
 
 proc git {args} {
-	set opt [list exec]
+	set opt [list]
 
 	while {1} {
 		switch -- [lindex $args 0] {
@@ -359,12 +382,18 @@ proc git {args} {
 	set cmdp [_git_cmd [lindex $args 0]]
 	set args [lrange $args 1 end]
 
-	return [eval $opt $cmdp $args]
+	_trace_exec [concat $opt $cmdp $args]
+	set result [eval exec $opt $cmdp $args]
+	if {$::_trace} {
+		puts stderr "< $result"
+	}
+	return $result
 }
 
 proc _open_stdout_stderr {cmd} {
+	_trace_exec $cmd
 	if {[catch {
-			set fd [open $cmd r]
+			set fd [open [concat [list | ] $cmd] r]
 		} err]} {
 		if {   [lindex $cmd end] eq {2>@1}
 		    && $err eq {can not find channel named "1"}
@@ -375,6 +404,7 @@ proc _open_stdout_stderr {cmd} {
 			# to try to start it a second time.
 			#
 			set fd [open [concat \
+				[list | ] \
 				[lrange $cmd 0 end-1] \
 				[list |& cat] \
 				] r]
@@ -387,7 +417,7 @@ proc _open_stdout_stderr {cmd} {
 }
 
 proc git_read {args} {
-	set opt [list |]
+	set opt [list]
 
 	while {1} {
 		switch -- [lindex $args 0] {
@@ -415,7 +445,7 @@ proc git_read {args} {
 }
 
 proc git_write {args} {
-	set opt [list |]
+	set opt [list]
 
 	while {1} {
 		switch -- [lindex $args 0] {
@@ -435,7 +465,8 @@ proc git_write {args} {
 	set cmdp [_git_cmd [lindex $args 0]]
 	set args [lrange $args 1 end]
 
-	return [open [concat $opt $cmdp $args] w]
+	_trace_exec [concat $opt $cmdp $args]
+	return [open [concat [list | ] $opt $cmdp $args] w]
 }
 
 proc githook_read {hook_name args} {
@@ -455,12 +486,12 @@ proc githook_read {hook_name args} {
 		}
 
 		set scr {if test -x "$1";then exec "$@";fi}
-		set sh_c [list | $interp -c $scr $interp $pchook]
+		set sh_c [list $interp -c $scr $interp $pchook]
 		return [_open_stdout_stderr [concat $sh_c $args]]
 	}
 
 	if {[file executable $pchook]} {
-		return [_open_stdout_stderr [concat [list | $pchook] $args]]
+		return [_open_stdout_stderr [concat [list $pchook] $args]]
 	}
 
 	return {}
-- 
1.5.5.1.450.gee27


-- 
Shawn.
