From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH] Don't use the dashed for of git commands
Date: Wed, 27 Aug 2008 02:30:59 +0200
Message-ID: <20080827002827.14720.45394.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 27 02:32:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KY8xQ-0005Ad-Si
	for gcvg-git-2@gmane.org; Wed, 27 Aug 2008 02:32:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752423AbYH0AbP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 Aug 2008 20:31:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752426AbYH0AbP
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Aug 2008 20:31:15 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4131 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752418AbYH0AbO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2008 20:31:14 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1KY9Hf-0002Ik-00; Wed, 27 Aug 2008 01:53:16 +0100
User-Agent: StGIT/0.14.3.232.g9dfa
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93841>

With the release of git 1.6.0, the dashed forms of the git commands
are no longer installed in $PATH by default, so trying to use them is
likely to fail. This patch replaces all remaining dashed git calls by
their dashless equivalents -- even in comments and docs, for
consistency and to aid grepping.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

This is for the stable branch. kha/safe contains a merge of this into
the master branch, which you might want to steal since there were a
fair amount of conflicts to resolve.

 .mailmap                    |    2 +-
 Documentation/tutorial.txt  |    2 +-
 contrib/release/post-update |    2 +-
 contrib/release/release.sh  |    2 +-
 contrib/release/snapshot.sh |    2 +-
 contrib/stg-cvs             |    8 ++++----
 contrib/stg-gitk            |    6 +++---
 contrib/stg-whatchanged     |    2 +-
 contrib/stgbashprompt.sh    |    4 ++--
 examples/gitconfig          |    8 ++++----
 stgit/commands/diff.py      |    2 +-
 stgit/commands/edit.py      |    2 +-
 stgit/commands/export.py    |    2 +-
 stgit/commands/files.py     |    2 +-
 stgit/commands/mail.py      |    2 +-
 stgit/commands/pick.py      |    2 +-
 stgit/gitmergeonefile.py    |    2 +-
 t/README                    |   18 +++++++++---------
 t/t1200-push-modified.sh    |    4 ++--
 t/t1201-pull-trailing.sh    |    4 ++--
 t/t1302-repair-interop.sh   |    6 +++---
 t/test-lib.sh               |    8 ++++----
 22 files changed, 46 insertions(+), 46 deletions(-)


diff --git a/.mailmap b/.mailmap
index ecaafff..cdb1beb 100644
--- a/.mailmap
+++ b/.mailmap
@@ -1,4 +1,4 @@
-# This list is used by git-shortlog to fix a few botched name
+# This list is used by various git commands to fix a few botched name
 # translations in the StGIT repository.
=20
 Bryan Larsen <bryan.larsen@gmail.com>
diff --git a/Documentation/tutorial.txt b/Documentation/tutorial.txt
index 2b8e4e7..b040d29 100644
--- a/Documentation/tutorial.txt
+++ b/Documentation/tutorial.txt
@@ -32,7 +32,7 @@ Repository initialisation
 -------------------------
=20
 In stand-alone mode, StGIT is used in conjunction with a GIT repositor=
y
-that is already initialised (using 'git-init-db'). StGIT cannot be use=
d
+that is already initialised (using 'git init'). StGIT cannot be used
 outside of a GIT repository.
 Any branch in a GIT repository may be managed by StGIT. Each branch
 managed by StGIT contains an independent series of StGIT patches.
diff --git a/contrib/release/post-update b/contrib/release/post-update
index d7ae4ca..6cbad71 100755
--- a/contrib/release/post-update
+++ b/contrib/release/post-update
@@ -6,7 +6,7 @@
 # To enable this hook, make this file executable by "chmod +x post-upd=
ate".
=20
 git repack -d
-git-update-server-info
+git update-server-info
=20
 # FTP upload
 lftp ftp://your-ftp-site/stgit.git -u username,password -e " \
diff --git a/contrib/release/release.sh b/contrib/release/release.sh
index 7c2d0b9..7fada5d 100755
--- a/contrib/release/release.sh
+++ b/contrib/release/release.sh
@@ -13,7 +13,7 @@ BINRPM=3Ddist/stgit-$VERSION-1.noarch.rpm
 SRCRPM=3Ddist/stgit-$VERSION-1.src.rpm
 DEBPKG=3D../stgit_$VERSION-0_all.deb
=20
-git-rev-list --pretty HEAD > ChangeLog
+git rev-list --pretty HEAD > ChangeLog
=20
 rm -f MANIFEST
=20
diff --git a/contrib/release/snapshot.sh b/contrib/release/snapshot.sh
index a81df52..71b447f 100755
--- a/contrib/release/snapshot.sh
+++ b/contrib/release/snapshot.sh
@@ -5,7 +5,7 @@
 VERSION=3D`date "+%Y%m%d"`
 SNAPSHOT=3Ddist/stgit-$VERSION.tar.gz
=20
-git-rev-list --pretty HEAD > ChangeLog
+git rev-list --pretty HEAD > ChangeLog
=20
 mv stgit/version.py stgit/version.py-
 echo "version =3D '$VERSION'" > stgit/version.py
diff --git a/contrib/stg-cvs b/contrib/stg-cvs
index 582f4f2..393c982 100755
--- a/contrib/stg-cvs
+++ b/contrib/stg-cvs
@@ -39,11 +39,11 @@ set -e
 #   VCS
 # - lacks synchronisation of .cvsignore <-> .gitignore
 # - no support for filenames with spaces (stg lacks --zero output form=
at)
-# - git-commit is too chatty when it finds nothing to commit
+# - git commit is too chatty when it finds nothing to commit
 # - lacks a "quick cvs commit" feature
=20
 # DESIGN FLAWS
-# - while fetching, if a file change was not git-update-index'd when
+# - while fetching, if a file change was not git update-index'd when
 #   cvs-update'd (eg. because of a stg-cvs bug), it is not seen on fur=
ther
 #   fetches until it changes again, since we scan "cvs update" output.
 #   This yields possible inconsistencies with CVS.
@@ -116,7 +116,7 @@ cvs_add_dir()
=20
 # get context
 branch=3D$(stg branch)
-parent=3D$(git-config "branch.${branch}.stgit.parentbranch") ||=20
+parent=3D$(git config "branch.${branch}.stgit.parentbranch") ||=20
     usage "no declared parent for '$branch' - set branch.${branch}.stg=
it.parentbranch"
=20
 # extract command
@@ -165,7 +165,7 @@ commit)
=20
     # sync the parent branch
     stg branch "$parent"
-    git-cherry-pick "patches/${branch}/${patch}"
+    git cherry-pick "patches/${branch}/${patch}"
     stg branch "${branch}"
=20
     # update
diff --git a/contrib/stg-gitk b/contrib/stg-gitk
index cb264e5..e3ddfb1 100755
--- a/contrib/stg-gitk
+++ b/contrib/stg-gitk
@@ -40,7 +40,7 @@ if [ $allbranches =3D 1 ] && [ "$branches" !=3D "" ];=
 then
     usage
 fi
=20
-GIT_DIR=3D$(git-rev-parse --git-dir)
+GIT_DIR=3D$(git rev-parse --git-dir)
 GIT_DIR_SPKIPLEN=3D$(printf "$GIT_DIR/X" | wc -c)
=20
 refdirs=3D''
@@ -64,9 +64,9 @@ else
 	elif [ -e "$GIT_DIR/refs/heads/$b" ]; then
 	    # other GIT branch
 	    refdirs=3D"$refdirs $GIT_DIR/refs/heads/$b"
-	elif [ $(git-for-each-ref "refs/$b" | wc -l) !=3D 0 ]; then
+	elif [ $(git for-each-ref "refs/$b" | wc -l) !=3D 0 ]; then
 	    # other ref
-	    refdirs=3D"$refdirs $(git-for-each-ref --format=3D"$GIT_DIR/%(ref=
name)" "refs/$b")"
+	    refdirs=3D"$refdirs $(git for-each-ref --format=3D"$GIT_DIR/%(ref=
name)" "refs/$b")"
 	else
 	    echo >&2 "ERROR: no such ref '$b'"
 	    usage
diff --git a/contrib/stg-whatchanged b/contrib/stg-whatchanged
index afeda2c..f1f5308 100755
--- a/contrib/stg-whatchanged
+++ b/contrib/stg-whatchanged
@@ -23,7 +23,7 @@ fi
=20
 # Merges via "push" leave top=3Dbottom so we must look at old patch
 # in this case (unlike, eg., "pick --fold")
-patchdir=3D"$(git-rev-parse --git-dir)/patches/$(stg branch)/patches/$=
(stg top)"
+patchdir=3D"$(git rev-parse --git-dir)/patches/$(stg branch)/patches/$=
(stg top)"
 case $(stg log | head -n1) in
     *push\(c\)*) former=3D"//top.old" ;;
     *) former=3D"//top" ;;
diff --git a/contrib/stgbashprompt.sh b/contrib/stgbashprompt.sh
index 5927e67..d5c4994 100755
--- a/contrib/stgbashprompt.sh
+++ b/contrib/stgbashprompt.sh
@@ -5,8 +5,8 @@ if [ "$PS1" ]; then
 	function __prompt_git()
 	{
 		local git_dir ref br top;
-		git_dir=3D$(git-rev-parse --git-dir 2> /dev/null) || return
-		ref=3D$(git-symbolic-ref HEAD 2> /dev/null) || return
+		git_dir=3D$(git rev-parse --git-dir 2> /dev/null) || return
+		ref=3D$(git symbolic-ref HEAD 2> /dev/null) || return
 		br=3D${ref#refs/heads/}
 		top=3D$(tail -n 1 $git_dir/patches/$br/applied 2>/dev/null) \
 		top=3D${top:-(none)}
diff --git a/examples/gitconfig b/examples/gitconfig
index 52d2a69..b7a6629 100644
--- a/examples/gitconfig
+++ b/examples/gitconfig
@@ -42,14 +42,14 @@
 	#pager =3D filterdiff --annotate | colordiff | less -FRX
=20
 	# GIT pull and fetch commands (should take the same arguments as
-	# git-fetch or git-pull).  By default:
-	#pullcmd =3D git-pull
-	#fetchcmd =3D git-fetch
+	# git fetch or git pull).  By default:
+	#pullcmd =3D git pull
+	#fetchcmd =3D git fetch
=20
 	# Rebase command. Note that this command is internally implemented in
 	# a different way. Only define this option if a different rebase
 	# is needed (i.e. 'git svn rebase')
-	#rebasecmd =3D git-reset
+	#rebasecmd =3D git reset
=20
 	# "stg pull" policy.  This is the repository default, which can be
 	# overriden on a per-branch basis using branch.*.stgit.pull-policy
diff --git a/stgit/commands/diff.py b/stgit/commands/diff.py
index 1425518..791b1ce 100644
--- a/stgit/commands/diff.py
+++ b/stgit/commands/diff.py
@@ -47,7 +47,7 @@ options =3D [make_option('-r', '--range',
                        metavar =3D 'rev1[..[rev2]]', dest =3D 'revs',
                        help =3D 'show the diff between revisions'),
            make_option('-O', '--diff-opts',
-                       help =3D 'options to pass to git-diff'),
+                       help =3D 'options to pass to git diff'),
            make_option('-s', '--stat',
                        help =3D 'show the stat instead of the diff',
                        action =3D 'store_true')]
diff --git a/stgit/commands/edit.py b/stgit/commands/edit.py
index a4d8f96..36d2e01 100644
--- a/stgit/commands/edit.py
+++ b/stgit/commands/edit.py
@@ -64,7 +64,7 @@ options =3D [make_option('-d', '--diff',
            make_option('-f', '--file',
                        help =3D 'use FILE instead of invoking the edit=
or'),
            make_option('-O', '--diff-opts',
-                       help =3D 'options to pass to git-diff'),
+                       help =3D 'options to pass to git diff'),
            make_option('--undo',
                        help =3D 'revert the commit generated by the la=
st edit',
                        action =3D 'store_true'),
diff --git a/stgit/commands/export.py b/stgit/commands/export.py
index 4e52598..c4fb7e3 100644
--- a/stgit/commands/export.py
+++ b/stgit/commands/export.py
@@ -65,7 +65,7 @@ options =3D [make_option('-d', '--dir',
            make_option('-b', '--branch',
                        help =3D 'use BRANCH instead of the default one=
'),
            make_option('-O', '--diff-opts',
-                       help =3D 'options to pass to git-diff'),
+                       help =3D 'options to pass to git diff'),
            make_option('-s', '--stdout',
                        help =3D 'dump the patches to the standard outp=
ut',
                        action =3D 'store_true')]
diff --git a/stgit/commands/files.py b/stgit/commands/files.py
index 4550251..cc9ed30 100644
--- a/stgit/commands/files.py
+++ b/stgit/commands/files.py
@@ -41,7 +41,7 @@ options =3D [make_option('-s', '--stat',
            make_option('-b', '--branch',
                        help =3D 'use BRANCH instead of the default one=
'),
            make_option('-O', '--diff-opts',
-                       help =3D 'options to pass to git-diff'),
+                       help =3D 'options to pass to git diff'),
            make_option('--bare',
                        help =3D 'bare file names (useful for scripting=
)',
                        action =3D 'store_true')]
diff --git a/stgit/commands/mail.py b/stgit/commands/mail.py
index 54ab5c9..05c905b 100644
--- a/stgit/commands/mail.py
+++ b/stgit/commands/mail.py
@@ -145,7 +145,7 @@ options =3D [make_option('-a', '--all',
            make_option('-b', '--branch',
                        help =3D 'use BRANCH instead of the default one=
'),
            make_option('-O', '--diff-opts',
-                       help =3D 'options to pass to git-diff'),
+                       help =3D 'options to pass to git diff'),
            make_option('-m', '--mbox',
                        help =3D 'generate an mbox file instead of send=
ing',
                        action =3D 'store_true')]
diff --git a/stgit/commands/pick.py b/stgit/commands/pick.py
index f9ee7c2..add2a33 100644
--- a/stgit/commands/pick.py
+++ b/stgit/commands/pick.py
@@ -81,7 +81,7 @@ def __pick_commit(commit_id, patchname, options):
     if options.fold:
         out.start('Folding commit %s' % commit_id)
=20
-        # try a direct git-apply first
+        # try a direct git apply first
         if not git.apply_diff(bottom, top):
             git.merge(bottom, git.get_head(), top, recursive =3D True)
=20
diff --git a/stgit/gitmergeonefile.py b/stgit/gitmergeonefile.py
index 4c90e1a..c1af2f8 100644
--- a/stgit/gitmergeonefile.py
+++ b/stgit/gitmergeonefile.py
@@ -159,7 +159,7 @@ def merge(orig_hash, file1_hash, file2_hash,
     if orig_hash:
         # modified in both
         if file1_hash and file2_hash:
-            # if modes are the same (git-read-tree probably dealt with=
 it)
+            # if modes are the same (git read-tree probably dealt with=
 it)
             if file1_hash =3D=3D file2_hash:
                 if os.system('git update-index --cacheinfo %s %s %s'
                              % (file1_mode, file1_hash, path)) !=3D 0:
diff --git a/t/README b/t/README
index 77f0b6c..ffb3c66 100644
--- a/t/README
+++ b/t/README
@@ -22,11 +22,11 @@ The easiest way to run tests is to say "make -C t".=
  This runs all
 the tests.
=20
     *** t0000-basic.sh ***
-    *   ok 1: .git/objects should be empty after git-init-db in an emp=
ty repo.
+    *   ok 1: .git/objects should be empty after git init in an empty =
repo.
     *   ok 2: .git/objects should have 256 subdirectories.
-    *   ok 3: git-update-index without --add should fail adding.
+    *   ok 3: git update-index without --add should fail adding.
     ...
-    *   ok 23: no diff after checkout and git-update-index --refresh.
+    *   ok 23: no diff after checkout and git update-index --refresh.
     * passed all 23 test(s)
     *** t0100-environment-names.sh ***
     *   ok 1: using old names should issue warnings.
@@ -37,9 +37,9 @@ Or you can run each test individually from command li=
ne, like
 this:
=20
     $ sh ./t3001-ls-files-killed.sh
-    *   ok 1: git-update-index --add to add various paths.
-    *   ok 2: git-ls-files -k to show killed files.
-    *   ok 3: validate git-ls-files -k output.
+    *   ok 1: git update-index --add to add various paths.
+    *   ok 2: git ls-files -k to show killed files.
+    *   ok 3: validate git ls-files -k output.
     * passed all 3 test(s)
=20
 You can pass --verbose (or -v), --debug (or -d), and --immediate
@@ -105,7 +105,7 @@ assignment to variable 'test_description', like thi=
s:
 	test_description=3D'xxx test (option --frotz)
=20
 	This test registers the following structure in the cache
-	and tries to run git-ls-files with option --frotz.'
+	and tries to run git ls-files with option --frotz.'
=20
=20
 Source 'test-lib.sh'
@@ -154,8 +154,8 @@ library for your script to use.
    Example:
=20
 	test_expect_success \
-	    'git-write-tree should be able to write an empty tree.' \
-	    'tree=3D$(git-write-tree)'
+	    'git write-tree should be able to write an empty tree.' \
+	    'tree=3D$(git write-tree)'
=20
  - test_expect_failure <message> <script>
=20
diff --git a/t/t1200-push-modified.sh b/t/t1200-push-modified.sh
index cfec696..647c200 100755
--- a/t/t1200-push-modified.sh
+++ b/t/t1200-push-modified.sh
@@ -35,8 +35,8 @@ test_expect_success \
     'Port those patches to orig tree' '
     (
         cd foo &&
-        GIT_DIR=3D../bar/.git git-format-patch --stdout \
-          $(cd ../bar && stg id base@master)..HEAD | git-am -3 -k
+        GIT_DIR=3D../bar/.git git format-patch --stdout \
+          $(cd ../bar && stg id base@master)..HEAD | git am -3 -k
     )
 '
=20
diff --git a/t/t1201-pull-trailing.sh b/t/t1201-pull-trailing.sh
index 46d9f82..805e805 100755
--- a/t/t1201-pull-trailing.sh
+++ b/t/t1201-pull-trailing.sh
@@ -29,9 +29,9 @@ test_expect_success \
 test_expect_success \
     'Port those patches to orig tree' \
     '(cd foo &&
-      GIT_DIR=3D../bar/.git git-format-patch --stdout \
+      GIT_DIR=3D../bar/.git git format-patch --stdout \
           $(cd ../bar && stg id base@master)..HEAD |
-      git-am -3 -k
+      git am -3 -k
      )
     '
=20
diff --git a/t/t1302-repair-interop.sh b/t/t1302-repair-interop.sh
index 82c5ed2..910b23a 100755
--- a/t/t1302-repair-interop.sh
+++ b/t/t1302-repair-interop.sh
@@ -25,7 +25,7 @@ test_expect_success 'Create five patches' '
     [ "$(echo $(stg unapplied))" =3D "" ]
 '
=20
-test_expect_success 'Pop two patches with git-reset' '
+test_expect_success 'Pop two patches with git reset' '
     git reset --hard HEAD~2 &&
     ! stg refresh &&
     stg repair &&
@@ -40,7 +40,7 @@ test_expect_success 'Create a new patch' '
     [ "$(echo $(stg unapplied))" =3D "p3 p4" ]
 '
=20
-test_expect_success 'Go to an unapplied patch with with git-reset' '
+test_expect_success 'Go to an unapplied patch with with git reset' '
     git reset --hard $(stg id p3) &&
     ! stg refresh &&
     stg repair &&
@@ -49,7 +49,7 @@ test_expect_success 'Go to an unapplied patch with wi=
th git-reset' '
     [ "$(echo $(stg unapplied))" =3D "q0 p4" ]
 '
=20
-test_expect_success 'Go back to below the stack base with git-reset' '
+test_expect_success 'Go back to below the stack base with git reset' '
     git reset --hard foo-tag &&
     stg repair &&
     [ "$(echo $(stg applied))" =3D "" ] &&
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 2d12f1b..3d114a2 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -226,12 +226,12 @@ test_create_repo () {
 	repo=3D"$1"
 	mkdir "$repo"
 	cd "$repo" || error "Cannot setup test environment"
-	git-init >/dev/null 2>&1 ||
-	error "cannot run git-init -- have you installed git-core?"
+	git init >/dev/null 2>&1 ||
+	error "cannot run git init -- have you installed git-core?"
 	mkdir .git/info
 	echo "empty start" |
-	git-commit-tree `git-write-tree` >.git/refs/heads/master 2>&4 ||
-	error "cannot run git-commit -- is your git-core functioning?"
+	git commit-tree `git write-tree` >.git/refs/heads/master 2>&4 ||
+	error "cannot run git commit -- is your git-core functioning?"
 	cd "$owd"
 }
=20
