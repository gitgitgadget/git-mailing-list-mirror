From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Rename ".dotest/" to ".git/rebase" and ".dotest-merge" to
 "rebase-merge"
Date: Wed, 16 Jul 2008 02:47:33 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807160245440.2841@eeepc-johanness>
References: <73fd69b50807151408i6a916da6p7b89fe81e65fc717@mail.gmail.com> <20080715212211.GL6244@leksak.fem-net> <487D1B3D.70500@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="658432-1017878369-1216169254=:2841"
Cc: Stephan Beyer <s-beyer@gmx.net>,
	Joe Fiorini <joe@faithfulgeek.org>, git@vger.kernel.org,
	Jari Aalto <jari.aalto@cante.net>
To: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Jul 16 02:48:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIvBW-0007ux-UG
	for gcvg-git-2@gmane.org; Wed, 16 Jul 2008 02:47:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754246AbYGPAq7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2008 20:46:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754299AbYGPAq7
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jul 2008 20:46:59 -0400
Received: from mail.gmx.net ([213.165.64.20]:52052 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754239AbYGPAq5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2008 20:46:57 -0400
Received: (qmail invoked by alias); 16 Jul 2008 00:46:55 -0000
Received: from 88-107-142-10.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.142.10]
  by mail.gmx.net (mp034) with SMTP; 16 Jul 2008 02:46:55 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/EcmhJKjTEFgyoVBeFLTlQrEEVTofD0iOzc7V3C4
	A92N4ZoFYi7yOO
X-X-Sender: user@eeepc-johanness
In-Reply-To: <487D1B3D.70500@lsrfire.ath.cx>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.47
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88617>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--658432-1017878369-1216169254=:2841
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT


Since the files generated and used during a rebase are never to be
tracked, they should live in $GIT_DIR.  While at it, avoid the rather
meaningless term "dotest" to "rebase", and unhide ".dotest-merge".

This was wished for on the mailing list, but so far unimplemented.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	On Tue, 15 Jul 2008, René Scharfe wrote:

	> Stephan Beyer schrieb:
	> > git-rebase (without -i/-m) generates a directory called 
	> > ".dotest/" to save temporary stuff like the commits you want to 
	> > rebase.
	> 
	> In February it was discussed to move .dotest below $GIT_DIR.  
	> There was even a patch (to rename it to .git-dotest).  I suspect the 
	> upcoming version 1.6.0 is a good opportunity to finally remove this 
	> wart.

	I kind of expected this to be a good opportunity to increase the 
	track record for a certain GSoC project, but here you have it.

 Documentation/SubmittingPatches        |    2 +-
 Documentation/git-am.txt               |    4 +-
 Documentation/git-rebase.txt           |    2 +-
 Documentation/user-manual.txt          |    2 +-
 contrib/emacs/git.el                   |    8 +++---
 git-am.sh                              |    6 ++--
 git-completion.bash                    |   20 +++++++-------
 git-quiltimport.sh                     |    2 +-
 git-rebase--interactive.sh             |    2 +-
 git-rebase.sh                          |   46 ++++++++++++++++----------------
 t/t3401-rebase-partial.sh              |    4 +-
 t/t3404-rebase-interactive.sh          |    8 +++---
 t/t3407-rebase-abort.sh                |    4 +-
 t/t4150-am.sh                          |   22 +++++++-------
 t/t9106-git-svn-commit-diff-clobber.sh |    2 +-
 15 files changed, 67 insertions(+), 67 deletions(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index b116475..fdfa536 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -301,7 +301,7 @@ If it does not apply correctly, there can be various reasons.
   patch appropriately.
 
 * Your MUA corrupted your patch; "am" would complain that
-  the patch does not apply.  Look at .dotest/ subdirectory and
+  the patch does not apply.  Look at .git/rebase/ subdirectory and
   see what 'patch' file contains and check for the common
   corruption patterns mentioned above.
 
diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
index 3863eeb..5b800d3 100644
--- a/Documentation/git-am.txt
+++ b/Documentation/git-am.txt
@@ -140,9 +140,9 @@ aborts in the middle,.  You can recover from this in one of two ways:
   the index file to bring it in a state that the patch should
   have produced.  Then run the command with '--resolved' option.
 
-The command refuses to process new mailboxes while `.dotest`
+The command refuses to process new mailboxes while `.git/rebase`
 directory exists, so if you decide to start over from scratch,
-run `rm -f -r .dotest` before running the command with mailbox
+run `rm -f -r .git/rebase` before running the command with mailbox
 names.
 
 
diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index f3459c7..c645073 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -38,7 +38,7 @@ It is possible that a merge failure will prevent this process from being
 completely automatic.  You will have to resolve any such merge failure
 and run `git rebase --continue`.  Another option is to bypass the commit
 that caused the merge failure with `git rebase --skip`.  To restore the
-original <branch> and remove the .dotest working files, use the command
+original <branch> and remove the .git/rebase working files, use the command
 `git rebase --abort` instead.
 
 Assume the following history exists and the current branch is "topic":
diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 01c1af6..94c9a58 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -2431,7 +2431,7 @@ $ git rebase origin
 -------------------------------------------------
 
 This will remove each of your commits from mywork, temporarily saving
-them as patches (in a directory named ".dotest"), update mywork to
+them as patches (in a directory named ".git/rebase"), update mywork to
 point at the latest version of origin, then apply each of the saved
 patches to the new mywork.  The result will look like:
 
diff --git a/contrib/emacs/git.el b/contrib/emacs/git.el
index 4fa853f..43b059b 100644
--- a/contrib/emacs/git.el
+++ b/contrib/emacs/git.el
@@ -1252,8 +1252,8 @@ Return the list of files that haven't been handled."
        "\n")
       (when subject (insert subject "\n\n"))
       (cond (msg (insert msg "\n"))
-            ((file-readable-p ".dotest/msg")
-             (insert-file-contents ".dotest/msg"))
+            ((file-readable-p ".git/rebase/msg")
+             (insert-file-contents ".git/rebase/msg"))
             ((file-readable-p ".git/MERGE_MSG")
              (insert-file-contents ".git/MERGE_MSG")))
       ; delete empty lines at end
@@ -1272,9 +1272,9 @@ Return the list of files that haven't been handled."
           (coding-system (git-get-commits-coding-system))
           author-name author-email subject date)
       (when (eq 0 (buffer-size buffer))
-        (when (file-readable-p ".dotest/info")
+        (when (file-readable-p ".git/rebase/info")
           (with-temp-buffer
-            (insert-file-contents ".dotest/info")
+            (insert-file-contents ".git/rebase/info")
             (goto-char (point-min))
             (when (re-search-forward "^Author: \\(.*\\)\nEmail: \\(.*\\)$" nil t)
               (setq author-name (match-string 1))
diff --git a/git-am.sh b/git-am.sh
index fe53608..3a11f8b 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -118,7 +118,7 @@ It does not apply to blobs recorded in its index."
 }
 
 prec=4
-dotest=".dotest"
+dotest="$GIT_DIR/rebase"
 sign= utf8=t keep= skip= interactive= resolved= binary= rebasing=
 resolvemsg= resume=
 git_apply_opt=
@@ -194,7 +194,7 @@ then
 		false
 		;;
 	esac ||
-	die "previous dotest directory $dotest still exists but mbox given."
+	die "previous rebase directory $dotest still exists but mbox given."
 	resume=yes
 else
 	# Make sure we are not given --skip nor --resolved
@@ -324,7 +324,7 @@ do
 			<"$dotest"/info >/dev/null &&
 			go_next && continue
 
-		test -s $dotest/patch || {
+		test -s "$dotest/patch" || {
 			echo "Patch is empty.  Was it split wrong?"
 			stop_here $this
 		}
diff --git a/git-completion.bash b/git-completion.bash
index 04e2ef5..8c8af4f 100755
--- a/git-completion.bash
+++ b/git-completion.bash
@@ -68,26 +68,26 @@ __git_ps1 ()
 	if [ -n "$g" ]; then
 		local r
 		local b
-		if [ -d "$g/../.dotest" ]
+		if [ -d "$g/rebase" ]
 		then
-			if test -f "$g/../.dotest/rebasing"
+			if test -f "$g/rebase/rebasing"
 			then
 				r="|REBASE"
-			elif test -f "$g/../.dotest/applying"
+			elif test -f "$g/rebase/applying"
 			then
 				r="|AM"
 			else
 				r="|AM/REBASE"
 			fi
 			b="$(git symbolic-ref HEAD 2>/dev/null)"
-		elif [ -f "$g/.dotest-merge/interactive" ]
+		elif [ -f "$g/rebase-merge/interactive" ]
 		then
 			r="|REBASE-i"
-			b="$(cat "$g/.dotest-merge/head-name")"
-		elif [ -d "$g/.dotest-merge" ]
+			b="$(cat "$g/rebase-merge/head-name")"
+		elif [ -d "$g/rebase-merge" ]
 		then
 			r="|REBASE-m"
-			b="$(cat "$g/.dotest-merge/head-name")"
+			b="$(cat "$g/rebase-merge/head-name")"
 		elif [ -f "$g/MERGE_HEAD" ]
 		then
 			r="|MERGING"
@@ -455,8 +455,8 @@ __git_whitespacelist="nowarn warn error error-all strip"
 
 _git_am ()
 {
-	local cur="${COMP_WORDS[COMP_CWORD]}"
-	if [ -d .dotest ]; then
+	local cur="${COMP_WORDS[COMP_CWORD]}" dir="$(__gitdir)"
+	if [ -d "$dir"/rebase ]; then
 		__gitcomp "--skip --resolved"
 		return
 	fi
@@ -864,7 +864,7 @@ _git_push ()
 _git_rebase ()
 {
 	local cur="${COMP_WORDS[COMP_CWORD]}" dir="$(__gitdir)"
-	if [ -d .dotest ] || [ -d "$dir"/.dotest-merge ]; then
+	if [ -d "$dir"/rebase ] || [ -d "$dir"/rebase-merge ]; then
 		__gitcomp "--continue --skip --abort"
 		return
 	fi
diff --git a/git-quiltimport.sh b/git-quiltimport.sh
index 7cd8f71..d1efa1d 100755
--- a/git-quiltimport.sh
+++ b/git-quiltimport.sh
@@ -53,7 +53,7 @@ if ! [ -d "$QUILT_PATCHES" ] ; then
 fi
 
 # Temporary directories
-tmp_dir=.dotest
+tmp_dir="$GIT_DIR"/rebase
 tmp_msg="$tmp_dir/msg"
 tmp_patch="$tmp_dir/patch"
 tmp_info="$tmp_dir/info"
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 297b646..dd01a45 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -17,7 +17,7 @@ OPTIONS_SPEC=
 . git-sh-setup
 require_work_tree
 
-DOTEST="$GIT_DIR/.dotest-merge"
+DOTEST="$GIT_DIR/rebase-merge"
 TODO="$DOTEST"/git-rebase-todo
 DONE="$DOTEST"/done
 MSG="$DOTEST"/message
diff --git a/git-rebase.sh b/git-rebase.sh
index bf0e7a9..74ff873 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -14,7 +14,7 @@ It is possible that a merge failure will prevent this process from being
 completely automatic.  You will have to resolve any such merge failure
 and run git rebase --continue.  Another option is to bypass the commit
 that caused the merge failure with git rebase --skip.  To restore the
-original <branch> and remove the .dotest working files, use the command
+original <branch> and remove the .git/rebase working files, use the command
 git rebase --abort instead.
 
 Note that if <branch> is not specified on the command line, the
@@ -42,7 +42,7 @@ To restore the original branch and stop rebasing run \"git rebase --abort\".
 unset newbase
 strategy=recursive
 do_merge=
-dotest=$GIT_DIR/.dotest-merge
+dotest="$GIT_DIR"/rebase-merge
 prec=4
 verbose=
 git_am_opt=
@@ -150,7 +150,7 @@ while test $# != 0
 do
 	case "$1" in
 	--continue)
-		test -d "$dotest" -o -d .dotest ||
+		test -d "$dotest" -o -d "$GIT_DIR"/rebase ||
 			die "No rebase in progress?"
 
 		git diff-files --quiet --ignore-submodules || {
@@ -173,15 +173,15 @@ do
 			finish_rb_merge
 			exit
 		fi
-		head_name=$(cat .dotest/head-name) &&
-		onto=$(cat .dotest/onto) &&
-		orig_head=$(cat .dotest/orig-head) &&
+		head_name=$(cat "$GIT_DIR"/rebase/head-name) &&
+		onto=$(cat "$GIT_DIR"/rebase/onto) &&
+		orig_head=$(cat "$GIT_DIR"/rebase/orig-head) &&
 		git am --resolved --3way --resolvemsg="$RESOLVEMSG" &&
 		move_to_original_branch
 		exit
 		;;
 	--skip)
-		test -d "$dotest" -o -d .dotest ||
+		test -d "$dotest" -o -d "$GIT_DIR"/rebase ||
 			die "No rebase in progress?"
 
 		git reset --hard HEAD || exit $?
@@ -200,19 +200,19 @@ do
 			done
 			finish_rb_merge
 			exit
-		elif ! test -d .dotest
+		elif ! test -d "$GIT_DIR"/rebase
 		then
 			die "No rebase in progress?"
 		fi
-		head_name=$(cat .dotest/head-name) &&
-		onto=$(cat .dotest/onto) &&
-		orig_head=$(cat .dotest/orig-head) &&
+		head_name=$(cat "$GIT_DIR"/rebase/head-name) &&
+		onto=$(cat "$GIT_DIR"/rebase/onto) &&
+		orig_head=$(cat "$GIT_DIR"/rebase/orig-head) &&
 		git am -3 --skip --resolvemsg="$RESOLVEMSG" &&
 		move_to_original_branch
 		exit
 		;;
 	--abort)
-		test -d "$dotest" -o -d .dotest ||
+		test -d "$dotest" -o -d "$GIT_DIR"/rebase ||
 			die "No rebase in progress?"
 
 		git rerere clear
@@ -220,7 +220,7 @@ do
 		then
 			move_to_original_branch
 		else
-			dotest=.dotest
+			dotest="$GIT_DIR"/rebase
 			move_to_original_branch
 		fi
 		git reset --hard $(cat "$dotest/orig-head")
@@ -268,24 +268,24 @@ do
 	shift
 done
 
-# Make sure we do not have .dotest
+# Make sure we do not have $GIT_DIR/rebase
 if test -z "$do_merge"
 then
-	if mkdir .dotest
+	if mkdir "$GIT_DIR"/rebase
 	then
-		rmdir .dotest
+		rmdir "$GIT_DIR"/rebase
 	else
 		echo >&2 '
-It seems that I cannot create a .dotest directory, and I wonder if you
+It seems that I cannot create a .git/rebase directory, and I wonder if you
 are in the middle of patch application or another rebase.  If that is not
-the case, please rm -fr .dotest and run me again.  I am stopping in case
+the case, please rm -fr .git/rebase and run me again.  I am stopping in case
 you still have something valuable there.'
 		exit 1
 	fi
 else
 	if test -d "$dotest"
 	then
-		die "previous dotest directory $dotest still exists." \
+		die "previous rebase directory $dotest still exists." \
 			'try git-rebase < --continue | --abort >'
 	fi
 fi
@@ -399,10 +399,10 @@ then
 	git am $git_am_opt --rebasing --resolvemsg="$RESOLVEMSG" &&
 	move_to_original_branch
 	ret=$?
-	test 0 != $ret -a -d .dotest &&
-		echo $head_name > .dotest/head-name &&
-		echo $onto > .dotest/onto &&
-		echo $orig_head > .dotest/orig-head
+	test 0 != $ret -a -d "$GIT_DIR"/rebase &&
+		echo $head_name > "$GIT_DIR"/rebase/head-name &&
+		echo $onto > "$GIT_DIR"/rebase/onto &&
+		echo $orig_head > "$GIT_DIR"/rebase/orig-head
 	exit $ret
 fi
 
diff --git a/t/t3401-rebase-partial.sh b/t/t3401-rebase-partial.sh
index 4934a4e..36d9a2a 100755
--- a/t/t3401-rebase-partial.sh
+++ b/t/t3401-rebase-partial.sh
@@ -50,12 +50,12 @@ test_debug \
 
 test_expect_success \
     'rebase topic branch against new master and check git-am did not get halted' \
-    'git-rebase master && test ! -d .dotest'
+    'git-rebase master && test ! -d .git/rebase'
 
 test_expect_success \
 	'rebase --merge topic branch that was partially merged upstream' \
 	'git-checkout -f my-topic-branch-merge &&
 	 git-rebase --merge master-merge &&
-	 test ! -d .git/.dotest-merge'
+	 test ! -d .git/rebase-merge'
 
 test_done
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 1c80148..d27554e 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -159,19 +159,19 @@ test_expect_success 'stop on conflicting pick' '
 	git tag new-branch1 &&
 	test_must_fail git rebase -i master &&
 	test "$(git rev-parse HEAD~3)" = "$(git rev-parse master)" &&
-	test_cmp expect .git/.dotest-merge/patch &&
+	test_cmp expect .git/rebase-merge/patch &&
 	test_cmp expect2 file1 &&
 	test "$(git-diff --name-status |
 		sed -n -e "/^U/s/^U[^a-z]*//p")" = file1 &&
-	test 4 = $(grep -v "^#" < .git/.dotest-merge/done | wc -l) &&
-	test 0 = $(grep -c "^[^#]" < .git/.dotest-merge/git-rebase-todo)
+	test 4 = $(grep -v "^#" < .git/rebase-merge/done | wc -l) &&
+	test 0 = $(grep -c "^[^#]" < .git/rebase-merge/git-rebase-todo)
 '
 
 test_expect_success 'abort' '
 	git rebase --abort &&
 	test $(git rev-parse new-branch1) = $(git rev-parse HEAD) &&
 	test "$(git symbolic-ref -q HEAD)" = "refs/heads/branch1" &&
-	! test -d .git/.dotest-merge
+	! test -d .git/rebase-merge
 '
 
 test_expect_success 'retain authorship' '
diff --git a/t/t3407-rebase-abort.sh b/t/t3407-rebase-abort.sh
index 1777ffe..12c8804 100755
--- a/t/t3407-rebase-abort.sh
+++ b/t/t3407-rebase-abort.sh
@@ -74,7 +74,7 @@ testrebase() {
 	'
 }
 
-testrebase "" .dotest
-testrebase " --merge" .git/.dotest-merge
+testrebase "" .git/rebase
+testrebase " --merge" .git/rebase-merge
 
 test_done
diff --git a/t/t4150-am.sh b/t/t4150-am.sh
index bc98260..5cbd5ef 100755
--- a/t/t4150-am.sh
+++ b/t/t4150-am.sh
@@ -102,7 +102,7 @@ test_expect_success 'am applies patch correctly' '
 	git checkout first &&
 	test_tick &&
 	git am <patch1 &&
-	! test -d .dotest &&
+	! test -d .git/rebase &&
 	test -z "$(git diff second)" &&
 	test "$(git rev-parse second)" = "$(git rev-parse HEAD)" &&
 	test "$(git rev-parse second^)" = "$(git rev-parse HEAD^)"
@@ -123,7 +123,7 @@ test_expect_success 'am changes committer and keeps author' '
 	test_tick &&
 	git checkout first &&
 	git am patch2 &&
-	! test -d .dotest &&
+	! test -d .git/rebase &&
 	test "$(git rev-parse master^^)" = "$(git rev-parse HEAD^^)" &&
 	test -z "$(git diff master..HEAD)" &&
 	test -z "$(git diff master^..HEAD^)" &&
@@ -163,7 +163,7 @@ test_expect_success 'am without --keep removes Re: and [PATCH] stuff' '
 test_expect_success 'am --keep really keeps the subject' '
 	git checkout HEAD^ &&
 	git am --keep patch4 &&
-	! test -d .dotest &&
+	! test -d .git/rebase &&
 	git-cat-file commit HEAD |
 		grep -q -F "Re: Re: Re: [PATCH 1/5 v2] third"
 '
@@ -176,19 +176,19 @@ test_expect_success 'am -3 falls back to 3-way merge' '
 	test_tick &&
 	git commit -m "copied stuff" &&
 	git am -3 lorem-move.patch &&
-	! test -d .dotest &&
+	! test -d .git/rebase &&
 	test -z "$(git diff lorem)"
 '
 
 test_expect_success 'am pauses on conflict' '
 	git checkout lorem2^^ &&
 	! git am lorem-move.patch &&
-	test -d .dotest
+	test -d .git/rebase
 '
 
 test_expect_success 'am --skip works' '
 	git am --skip &&
-	! test -d .dotest &&
+	! test -d .git/rebase &&
 	test -z "$(git diff lorem2^^ -- file)" &&
 	test goodbye = "$(cat another)"
 '
@@ -196,31 +196,31 @@ test_expect_success 'am --skip works' '
 test_expect_success 'am --resolved works' '
 	git checkout lorem2^^ &&
 	! git am lorem-move.patch &&
-	test -d .dotest &&
+	test -d .git/rebase &&
 	echo resolved >>file &&
 	git add file &&
 	git am --resolved &&
-	! test -d .dotest &&
+	! test -d .git/rebase &&
 	test goodbye = "$(cat another)"
 '
 
 test_expect_success 'am takes patches from a Pine mailbox' '
 	git checkout first &&
 	cat pine patch1 | git am &&
-	! test -d .dotest &&
+	! test -d .git/rebase &&
 	test -z "$(git diff master^..HEAD)"
 '
 
 test_expect_success 'am fails on mail without patch' '
 	! git am <failmail &&
-	rm -r .dotest/
+	rm -r .git/rebase/
 '
 
 test_expect_success 'am fails on empty patch' '
 	echo "---" >>failmail &&
 	! git am <failmail &&
 	git am --skip &&
-	! test -d .dotest
+	! test -d .git/rebase
 '
 
 test_expect_success 'am works from stdin in subdirectory' '
diff --git a/t/t9106-git-svn-commit-diff-clobber.sh b/t/t9106-git-svn-commit-diff-clobber.sh
index 58a3a7b..27a65e0 100755
--- a/t/t9106-git-svn-commit-diff-clobber.sh
+++ b/t/t9106-git-svn-commit-diff-clobber.sh
@@ -87,7 +87,7 @@ test_expect_success 'multiple dcommit from git-svn will not clobber svn' "
 	"
 
 
-test_expect_success 'check that rebase really failed' 'test -d .dotest'
+test_expect_success 'check that rebase really failed' 'test -d .git/rebase'
 
 test_expect_success 'resolve, continue the rebase and dcommit' "
 	echo clobber and I really mean it > file &&
-- 
1.5.6.2.449.g342381.dirty

--658432-1017878369-1216169254=:2841--
