From: Thomas Rast <tr@thomasrast.ch>
Subject: [PATCH v3 2/3] Documentation: convert to --option=arg form where possible
Date: Sat, 16 Nov 2013 18:37:56 +0100
Message-ID: <db303f8f29be249d804b08f4f57cb9099860c535.1384622379.git.tr@thomasrast.ch>
References: <874n7ywpnd.fsf@thomasrast.ch> <cover.1384622379.git.tr@thomasrast.ch>
Cc: Paul Mackerras <paulus@samba.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 16 18:38:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VhjpC-0007WZ-88
	for gcvg-git-2@plane.gmane.org; Sat, 16 Nov 2013 18:38:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752765Ab3KPRiQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Nov 2013 12:38:16 -0500
Received: from psi.thgersdorf.net ([176.9.98.78]:38516 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751953Ab3KPRiH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Nov 2013 12:38:07 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id D5E7D4D6414;
	Sat, 16 Nov 2013 18:38:05 +0100 (CET)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id UApS1OGozDGM; Sat, 16 Nov 2013 18:38:04 +0100 (CET)
Received: from linux-k42r.v.cablecom.net (unknown [213.55.184.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id B6B784D6581;
	Sat, 16 Nov 2013 18:38:02 +0100 (CET)
X-Mailer: git-send-email 1.8.5.rc2.348.gb73b695
In-Reply-To: <cover.1384622379.git.tr@thomasrast.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237939>

We generally encourage the stuck form (that is, -oarg or
--option=arg), for example gitcli(7) says

  when a command line option takes an argument, use the stuck form
  [...] An option that takes optional option-argument must be written
  in the stuck form.

However the manpages do not express the options in this form in many
places.  Switch the long option descriptions to use --option=arg where
possible.  The short options are a more difficult choice, so this
patch leaves them unchanged.  In particular it's not clear whether the
readability tradeoff is worth it for mandatory arguments, where -o foo
is equally valid and sets 'foo' off visually from the option.

I found the possible matches by running

  git grep '^--[^,]* .*::'

The following are not fixed by this patch:

* git-filter-branch
* git-quiltimport
* git-rev-parse

All of them have an ad-hoc parser that does not understand stuck
forms.

The following are fixes beyond the pure choice of style:

* git-grep actually uses parseopt to take an optional argument for
  --open-files-in-pager.  Therefore the unstuck form was not valid to
  begin with.

* In git-revert.txt, added <...> to signal that <parent-number> is a
  placeholder (all other options in the file already use this style).

Signed-off-by: Thomas Rast <tr@thomasrast.ch>
---
 Documentation/blame-options.txt        |  4 ++--
 Documentation/fetch-options.txt        |  2 +-
 Documentation/git-branch.txt           |  6 +++---
 Documentation/git-checkout.txt         |  2 +-
 Documentation/git-cherry-pick.txt      |  2 +-
 Documentation/git-clone.txt            | 18 +++++++++---------
 Documentation/git-config.txt           |  4 ++--
 Documentation/git-credential-cache.txt |  4 ++--
 Documentation/git-cvsserver.txt        |  2 +-
 Documentation/git-describe.txt         |  2 +-
 Documentation/git-fmt-merge-msg.txt    |  4 ++--
 Documentation/git-format-patch.txt     |  4 ++--
 Documentation/git-grep.txt             | 10 +++++-----
 Documentation/git-notes.txt            |  2 +-
 Documentation/git-p4.txt               | 14 +++++++-------
 Documentation/git-prune.txt            |  4 ++--
 Documentation/git-rebase.txt           |  4 ++--
 Documentation/git-replace.txt          |  2 +-
 Documentation/git-revert.txt           |  6 +++---
 git-cvsserver.perl                     |  2 +-
 20 files changed, 49 insertions(+), 49 deletions(-)

diff --git a/Documentation/blame-options.txt b/Documentation/blame-options.txt
index 0cebc4f..3d768f1 100644
--- a/Documentation/blame-options.txt
+++ b/Documentation/blame-options.txt
@@ -55,14 +55,14 @@ include::line-range-format.txt[]
 	discussion about encoding in the linkgit:git-log[1]
 	manual page.
 
---contents <file>::
+--contents=<file>::
 	When <rev> is not specified, the command annotates the
 	changes starting backwards from the working tree copy.
 	This flag makes the command pretend as if the working
 	tree copy has the contents of the named file (specify
 	`-` to make the command read from the standard input).
 
---date <format>::
+--date=<format>::
 	The value is one of the following alternatives:
 	{relative,local,default,iso,rfc,short}. If --date is not
 	provided, the value of the blame.date config variable is
diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
index f0ef7d0..4a03e06 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -109,7 +109,7 @@ endif::git-pull[]
 	implementing your own Porcelain you are not supposed to
 	use it.
 
---upload-pack <upload-pack>::
+--upload-pack=<upload-pack>::
 	When given, and the repository to fetch from is handled
 	by 'git fetch-pack', '--exec=<upload-pack>' is passed to
 	the command to specify non-default path for the command
diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index 311b336..91fc23f 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -195,15 +195,15 @@ start-point is either a local or remote-tracking branch.
 	Open an editor and edit the text to explain what the branch is
 	for, to be used by various other commands (e.g. `request-pull`).
 
---contains [<commit>]::
+--contains[=<commit>]::
 	Only list branches which contain the specified commit (HEAD
 	if not specified). Implies `--list`.
 
---merged [<commit>]::
+--merged[=<commit>]::
 	Only list branches whose tips are reachable from the
 	specified commit (HEAD if not specified). Implies `--list`.
 
---no-merged [<commit>]::
+--no-merged[=<commit>]::
 	Only list branches whose tips are not reachable from the
 	specified commit (HEAD if not specified). Implies `--list`.
 
diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index 91294f8..c95aed2 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -157,7 +157,7 @@ explicitly give a name with '-b' in such a case.
 	<commit> is not a branch name.  See the "DETACHED HEAD" section
 	below for details.
 
---orphan <new_branch>::
+--orphan=<new_branch>::
 	Create a new 'orphan' branch, named <new_branch>, started from
 	<start_point> and switch to it.  The first commit made on this
 	new branch will have no parents and it will be the root of a new
diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cherry-pick.txt
index c205d23..7b54d88 100644
--- a/Documentation/git-cherry-pick.txt
+++ b/Documentation/git-cherry-pick.txt
@@ -76,7 +76,7 @@ OPTIONS
 	default is not to do `-x` so this option is a no-op.
 
 -m parent-number::
---mainline parent-number::
+--mainline=<parent-number>::
 	Usually you cannot cherry-pick a merge because you do not know which
 	side of the merge should be considered the mainline.  This
 	option specifies the parent number (starting from 1) of
diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 450f158..a77f645 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -11,9 +11,9 @@ SYNOPSIS
 [verse]
 'git clone' [--template=<template_directory>]
 	  [-l] [-s] [--no-hardlinks] [-q] [-n] [--bare] [--mirror]
-	  [-o <name>] [-b <name>] [-u <upload-pack>] [--reference <repository>]
-	  [--separate-git-dir <git dir>]
-	  [--depth <depth>] [--[no-]single-branch]
+	  [-o <name>] [-b <name>] [-u <upload-pack>] [--reference=<repository>]
+	  [--separate-git-dir=<git dir>]
+	  [--depth=<depth>] [--[no-]single-branch]
 	  [--recursive | --recurse-submodules] [--] <repository>
 	  [<directory>]
 
@@ -93,7 +93,7 @@ If you want to break the dependency of a repository cloned with `-s` on
 its source repository, you can simply run `git repack -a` to copy all
 objects from the source repository into a pack in the cloned repository.
 
---reference <repository>::
+--reference=<repository>::
 	If the reference repository is on the local machine,
 	automatically setup `.git/objects/info/alternates` to
 	obtain objects from the reference repository.  Using
@@ -144,12 +144,12 @@ objects from the source repository into a pack in the cloned repository.
 	that all these refs are overwritten by a `git remote update` in the
 	target repository.
 
---origin <name>::
+--origin=<name>::
 -o <name>::
 	Instead of using the remote name `origin` to keep track
 	of the upstream repository, use `<name>`.
 
---branch <name>::
+--branch=<name>::
 -b <name>::
 	Instead of pointing the newly created HEAD to the branch pointed
 	to by the cloned repository's HEAD, point to `<name>` branch
@@ -158,7 +158,7 @@ objects from the source repository into a pack in the cloned repository.
 	`--branch` can also take tags and detaches the HEAD at that commit
 	in the resulting repository.
 
---upload-pack <upload-pack>::
+--upload-pack=<upload-pack>::
 -u <upload-pack>::
 	When given, and the repository to clone from is accessed
 	via ssh, this specifies a non-default path for the command
@@ -168,7 +168,7 @@ objects from the source repository into a pack in the cloned repository.
 	Specify the directory from which templates will be used;
 	(See the "TEMPLATE DIRECTORY" section of linkgit:git-init[1].)
 
---config <key>=<value>::
+--config=<key>=<value>::
 -c <key>=<value>::
 	Set a configuration variable in the newly-created repository;
 	this takes effect immediately after the repository is
@@ -179,7 +179,7 @@ objects from the source repository into a pack in the cloned repository.
 	the config file. This makes it safe, for example, to add
 	additional fetch refspecs to the origin remote.
 
---depth <depth>::
+--depth=<depth>::
 	Create a 'shallow' clone with a history truncated to the
 	specified number of revisions.  A shallow repository has a
 	number of limitations (you cannot clone or fetch from
diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index e9917b8..6b21a3a 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -135,10 +135,10 @@ from all available files.
 See also <<FILES>>.
 
 -f config-file::
---file config-file::
+--file=config-file::
 	Use the given config file instead of the one specified by GIT_CONFIG.
 
---blob blob::
+--blob=blob::
 	Similar to '--file' but use the given blob instead of a file. E.g.
 	you can use 'master:.gitmodules' to read values from the file
 	'.gitmodules' in the master branch. See "SPECIFYING REVISIONS"
diff --git a/Documentation/git-credential-cache.txt b/Documentation/git-credential-cache.txt
index 89b7306..5155dd3 100644
--- a/Documentation/git-credential-cache.txt
+++ b/Documentation/git-credential-cache.txt
@@ -26,11 +26,11 @@ linkgit:gitcredentials[7] or `EXAMPLES` below.
 OPTIONS
 -------
 
---timeout <seconds>::
+--timeout=<seconds>::
 
 	Number of seconds to cache credentials (default: 900).
 
---socket <path>::
+--socket=<path>::
 
 	Use `<path>` to contact a running cache daemon (or start a new
 	cache daemon if one is not started). Defaults to
diff --git a/Documentation/git-cvsserver.txt b/Documentation/git-cvsserver.txt
index 472f5cb..cd8fc0a 100644
--- a/Documentation/git-cvsserver.txt
+++ b/Documentation/git-cvsserver.txt
@@ -31,7 +31,7 @@ All these options obviously only make sense if enforced by the server side.
 They have been implemented to resemble the linkgit:git-daemon[1] options as
 closely as possible.
 
---base-path <path>::
+--base-path=<path>::
 Prepend 'path' to requested CVSROOT
 
 --strict-paths::
diff --git a/Documentation/git-describe.txt b/Documentation/git-describe.txt
index d20ca40..4211c0e 100644
--- a/Documentation/git-describe.txt
+++ b/Documentation/git-describe.txt
@@ -80,7 +80,7 @@ OPTIONS
 	describe such a commit as v1.2-0-gdeadbee (0th commit since tag v1.2
 	that points at object deadbee....).
 
---match <pattern>::
+--match=<pattern>::
 	Only consider tags matching the given `glob(7)` pattern,
 	excluding the "refs/tags/" prefix.  This can be used to avoid
 	leaking private tags from the repository.
diff --git a/Documentation/git-fmt-merge-msg.txt b/Documentation/git-fmt-merge-msg.txt
index bb1232a..415fda3 100644
--- a/Documentation/git-fmt-merge-msg.txt
+++ b/Documentation/git-fmt-merge-msg.txt
@@ -40,12 +40,12 @@ OPTIONS
 	removed in the future.
 
 -m <message>::
---message <message>::
+--message=<message>::
 	Use <message> instead of the branch names for the first line
 	of the log message.  For use with `--log`.
 
 -F <file>::
---file <file>::
+--file=<file>::
 	Take the list of merged objects from <file> instead of
 	stdin.
 
diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 5c0a4ab..9ada261 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -80,7 +80,7 @@ include::diff-options.txt[]
 	Prepare patches from the topmost <n> commits.
 
 -o <dir>::
---output-directory <dir>::
+--output-directory=<dir>::
 	Use <dir> to store the resulting files, instead of the
 	current working directory.
 
@@ -92,7 +92,7 @@ include::diff-options.txt[]
 --no-numbered::
 	Name output in '[PATCH]' format.
 
---start-number <n>::
+--start-number=<n>::
 	Start numbering the patches at <n> instead of 1.
 
 --numbered-files::
diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index f837334..ee474c1 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -95,7 +95,7 @@ OPTIONS
 -I::
 	Don't match the pattern in binary files.
 
---max-depth <depth>::
+--max-depth=<depth>::
 	For each <pathspec> given on command line, descend at most <depth>
 	levels of directories. A negative value means no limit.
 	This option is ignored if <pathspec> contains active wildcards.
@@ -158,7 +158,7 @@ OPTIONS
 	synonym for `--files-with-matches`.
 
 -O [<pager>]::
---open-files-in-pager [<pager>]::
+--open-files-in-pager[=<pager>]::
 	Open the matching files in the pager (not the output of 'grep').
 	If the pager happens to be "less" or "vi", and the user
 	specified only one pattern, the first file is positioned at
@@ -200,17 +200,17 @@ OPTIONS
 
 -<num>::
 -C <num>::
---context <num>::
+--context=<num>::
 	Show <num> leading and trailing lines, and place a line
 	containing `--` between contiguous groups of matches.
 
 -A <num>::
---after-context <num>::
+--after-context=<num>::
 	Show <num> trailing lines, and place a line containing
 	`--` between contiguous groups of matches.
 
 -B <num>::
---before-context <num>::
+--before-context=<num>::
 	Show <num> leading lines, and place a line containing
 	`--` between contiguous groups of matches.
 
diff --git a/Documentation/git-notes.txt b/Documentation/git-notes.txt
index 46ef046..0d23aaa 100644
--- a/Documentation/git-notes.txt
+++ b/Documentation/git-notes.txt
@@ -155,7 +155,7 @@ OPTIONS
 	Like '-C', but with '-c' the editor is invoked, so that
 	the user can further edit the note message.
 
---ref <ref>::
+--ref=<ref>::
 	Manipulate the notes tree in <ref>.  This overrides
 	'GIT_NOTES_REF' and the "core.notesRef" configuration.  The ref
 	is taken to be in `refs/notes/` if it is not qualified.
diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
index 8cba16d..04ea627 100644
--- a/Documentation/git-p4.txt
+++ b/Documentation/git-p4.txt
@@ -165,7 +165,7 @@ General options
 ~~~~~~~~~~~~~~~
 All commands except clone accept these options.
 
---git-dir <dir>::
+--git-dir=<dir>::
 	Set the 'GIT_DIR' environment variable.  See linkgit:git[1].
 
 --verbose, -v::
@@ -176,7 +176,7 @@ Sync options
 These options can be used in the initial 'clone' as well as in
 subsequent 'sync' operations.
 
---branch <ref>::
+--branch=<ref>::
 	Import changes into <ref> instead of refs/remotes/p4/master.
 	If <ref> starts with refs/, it is used as is.  Otherwise, if
 	it does not start with p4/, that prefix is added.
@@ -199,7 +199,7 @@ Git repository:
 	Use the branch detection algorithm to find new paths in p4.  It is
 	documented below in "BRANCH DETECTION".
 
---changesfile <file>::
+--changesfile=<file>::
 	Import exactly the p4 change numbers listed in 'file', one per
 	line.  Normally, 'git p4' inspects the current p4 repository
 	state and detects the changes it should import.
@@ -223,7 +223,7 @@ Git repository:
 	sync operations must specify '--import-local' as well so that
 	they can find the p4 branches in refs/heads.
 
---max-changes <n>::
+--max-changes=<n>::
 	Limit the number of imported changes to 'n'.  Useful to
 	limit the amount of history when using the '@all' p4 revision
 	specifier.
@@ -245,7 +245,7 @@ Clone options
 These options can be used in an initial 'clone', along with the 'sync'
 options described above.
 
---destination <directory>::
+--destination=<directory>::
 	Where to create the Git repository.  If not provided, the last
 	component in the p4 depot path is used to create a new
 	directory.
@@ -260,7 +260,7 @@ Submit options
 ~~~~~~~~~~~~~~
 These options can be used to modify 'git p4 submit' behavior.
 
---origin <commit>::
+--origin=<commit>::
 	Upstream location from which commits are identified to submit to
 	p4.  By default, this is the most recent p4 commit reachable
 	from 'HEAD'.
@@ -297,7 +297,7 @@ These options can be used to modify 'git p4 submit' behavior.
 	to bypass the prompt, causing conflicting commits to be automatically
 	skipped, or to quit trying to apply commits, without prompting.
 
---branch <branch>::
+--branch=<branch>::
 	After submitting, sync this named branch instead of the default
 	p4/master.  See the "Sync options" section above for more
 	information.
diff --git a/Documentation/git-prune.txt b/Documentation/git-prune.txt
index bf82410..604c378 100644
--- a/Documentation/git-prune.txt
+++ b/Documentation/git-prune.txt
@@ -9,7 +9,7 @@ git-prune - Prune all unreachable objects from the object database
 SYNOPSIS
 --------
 [verse]
-'git prune' [-n] [-v] [--expire <expire>] [--] [<head>...]
+'git prune' [-n] [-v] [--expire=<expire>] [--] [<head>...]
 
 DESCRIPTION
 -----------
@@ -43,7 +43,7 @@ OPTIONS
 \--::
 	Do not interpret any more arguments as options.
 
---expire <time>::
+--expire=<time>::
 	Only expire loose objects older than <time>.
 
 <head>...::
diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 94e07fd..35d121b 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -213,7 +213,7 @@ rebase.autostash::
 
 OPTIONS
 -------
---onto <newbase>::
+--onto=<newbase>::
 	Starting point at which to create the new commits. If the
 	--onto option is not specified, the starting point is
 	<upstream>.  May be any valid commit, and not just an
@@ -351,7 +351,7 @@ with the `--interactive` option explicitly is generally not a good
 idea unless you know what you are doing (see BUGS below).
 
 -x <cmd>::
---exec <cmd>::
+--exec=<cmd>::
 	Append "exec <cmd>" after each line creating a commit in the
 	final history. <cmd> will be interpreted as one or more shell
 	commands.
diff --git a/Documentation/git-replace.txt b/Documentation/git-replace.txt
index f373ab4..a82a36c 100644
--- a/Documentation/git-replace.txt
+++ b/Documentation/git-replace.txt
@@ -64,7 +64,7 @@ OPTIONS
 	Delete existing replace refs for the given objects.
 
 -l <pattern>::
---list <pattern>::
+--list=<pattern>::
 	List replace refs for objects that match the given pattern (or
 	all if no pattern is given).
 	Typing "git replace" without arguments, also lists all replace
diff --git a/Documentation/git-revert.txt b/Documentation/git-revert.txt
index 2de67a5..3ddd242 100644
--- a/Documentation/git-revert.txt
+++ b/Documentation/git-revert.txt
@@ -8,7 +8,7 @@ git-revert - Revert some existing commits
 SYNOPSIS
 --------
 [verse]
-'git revert' [--[no-]edit] [-n] [-m parent-number] [-s] <commit>...
+'git revert' [--[no-]edit] [-n] [-m <parent-number>] [-s] <commit>...
 'git revert' --continue
 'git revert' --quit
 'git revert' --abort
@@ -46,8 +46,8 @@ OPTIONS
 	message prior to committing the revert. This is the default if
 	you run the command from a terminal.
 
--m parent-number::
---mainline parent-number::
+-m <parent-number>::
+--mainline=<parent-number>::
 	Usually you cannot revert a merge because you do not know which
 	side of the merge should be considered the mainline.  This
 	option specifies the parent number (starting from 1) of
diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index 95e69b1..cde9cc4 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -108,7 +108,7 @@
 
 my $usage =
     "usage: git cvsserver [options] [pserver|server] [<directory> ...]\n".
-    "    --base-path <path>  : Prepend to requested CVSROOT\n".
+    "    --base-path=<path>  : Prepend to requested CVSROOT\n".
     "                          Can be read from GIT_CVSSERVER_BASE_PATH\n".
     "    --strict-paths      : Don't allow recursing into subdirectories\n".
     "    --export-all        : Don't check for gitcvs.enabled in config\n".
-- 
1.8.5.rc2.348.gb73b695
