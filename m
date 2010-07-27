From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 1/4] tests: implicitly skip SYMLINKS tests using <prereq>
Date: Tue, 27 Jul 2010 21:14:10 +0000
Message-ID: <1280265254-19642-2-git-send-email-avarab@gmail.com>
References: <1280265254-19642-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 27 23:14:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdrU0-0007sc-4N
	for gcvg-git-2@lo.gmane.org; Tue, 27 Jul 2010 23:14:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752526Ab0G0VOa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Jul 2010 17:14:30 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:42099 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751308Ab0G0VO3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jul 2010 17:14:29 -0400
Received: by mail-bw0-f46.google.com with SMTP id 1so3597805bwz.19
        for <git@vger.kernel.org>; Tue, 27 Jul 2010 14:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=d/g4nF+Yy+y31vpixGZrwe5rYbx/ZNl8ldHPCzoACj0=;
        b=vA2uVMQ3MhjcKC1tCR8TmG8fiNfopbJCSlL4EzOGUjhpLIWXmT306oBHkGTRI63oBN
         gm0vVkVqv6ArB7CqZsvwXXonwa3C7vxwPgDHhAMJFdswY73oJ05k/vp2kEzruhUrpVMo
         gehnq5p+TybTPK1TyNZvCYHdEurKEtRuewXMQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=QM8uYpqfIqfMn0t8tp6jOFimZhc3jCWD+2tq2pTBYQDPsywPZ/3wZI9xoRO2SbHdDv
         0dj6P4WgOMxko2f3XAh8vDUL7HBtL6KOEe9F0gqtjUIvQCt3+cgCDWPwgNIUAKmpg2Jx
         xabYx1AIbTJ+EqSl3XuEYlLS2t5chMpOvHV3Q=
Received: by 10.204.133.91 with SMTP id e27mr4535692bkt.197.1280265267801;
        Tue, 27 Jul 2010 14:14:27 -0700 (PDT)
Received: from localhost.localdomain (dslb-088-067-237-210.pools.arcor-ip.net [88.67.237.210])
        by mx.google.com with ESMTPS id y2sm4172562bkx.20.2010.07.27.14.14.25
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 27 Jul 2010 14:14:26 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <1280265254-19642-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151991>

Change the tests that skipped due to unavailable SYMLINKS support to
use the three-arg prereq form of test_expect_success.

Now we get an indication of how many tests that need symlinks are
being skipped on platforms that don't support them.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 t/t2007-checkout-symlink.sh       |   14 ++++----------
 t/t4004-diff-rename-symlink.sh    |   18 +++++++-----------
 t/t4011-diff-symlink.sh           |   18 ++++++------------
 t/t4023-diff-rename-typechange.sh |   14 ++++----------
 t/t4114-apply-typechange.sh       |   28 +++++++++++-----------------
 t/t4115-apply-symlink.sh          |   12 +++---------
 t/t4122-apply-symlink-inside.sh   |   12 +++---------
 t/t5522-pull-symlink.sh           |   14 ++++----------
 t/t6035-merge-dir-to-symlink.sh   |   20 +++++++-------------
 9 files changed, 49 insertions(+), 101 deletions(-)

diff --git a/t/t2007-checkout-symlink.sh b/t/t2007-checkout-symlink.sh
index 05cc8fd..a74ee22 100755
--- a/t/t2007-checkout-symlink.sh
+++ b/t/t2007-checkout-symlink.sh
@@ -6,13 +6,7 @@ test_description=3D'git checkout to switch between bra=
nches with symlink<->dir'
=20
 . ./test-lib.sh
=20
-if ! test_have_prereq SYMLINKS
-then
-	skip_all=3D"symbolic links not supported - skipping tests"
-	test_done
-fi
-
-test_expect_success setup '
+test_expect_success SYMLINKS setup '
=20
 	mkdir frotz &&
 	echo hello >frotz/filfre &&
@@ -38,18 +32,18 @@ test_expect_success setup '
=20
 '
=20
-test_expect_success 'switch from symlink to dir' '
+test_expect_success SYMLINKS 'switch from symlink to dir' '
=20
 	git checkout master
=20
 '
=20
-test_expect_success 'Remove temporary directories & switch to master' =
'
+test_expect_success SYMLINKS 'Remove temporary directories & switch to=
 master' '
 	rm -fr frotz xyzzy nitfol &&
 	git checkout -f master
 '
=20
-test_expect_success 'switch from dir to symlink' '
+test_expect_success SYMLINKS 'switch from dir to symlink' '
=20
 	git checkout side
=20
diff --git a/t/t4004-diff-rename-symlink.sh b/t/t4004-diff-rename-symli=
nk.sh
index 1a09e8d..85a77b3 100755
--- a/t/t4004-diff-rename-symlink.sh
+++ b/t/t4004-diff-rename-symlink.sh
@@ -12,13 +12,7 @@ by an edit for them.
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/diff-lib.sh
=20
-if ! test_have_prereq SYMLINKS
-then
-	skip_all=3D'Symbolic links not supported, skipping tests.'
-	test_done
-fi
-
-test_expect_success \
+test_expect_success SYMLINKS \
     'prepare reference tree' \
     'echo xyzzy | tr -d '\\\\'012 >yomin &&
      ln -s xyzzy frotz &&
@@ -26,7 +20,7 @@ test_expect_success \
     tree=3D$(git write-tree) &&
     echo $tree'
=20
-test_expect_success \
+test_expect_success SYMLINKS \
     'prepare work tree' \
     'mv frotz rezrov &&
      rm -f yomin &&
@@ -40,8 +34,9 @@ test_expect_success \
 # rezrov and nitfol are rename/copy of frotz and bozbar should be
 # a new creation.
=20
-GIT_DIFF_OPTS=3D--unified=3D0 git diff-index -M -p $tree >current
-cat >expected <<\EOF
+test_expect_success SYMLINKS 'setup diff output' "
+    GIT_DIFF_OPTS=3D--unified=3D0 git diff-index -M -p $tree >current
+    cat >expected <<\EOF
 diff --git a/bozbar b/bozbar
 new file mode 120000
 --- /dev/null
@@ -65,8 +60,9 @@ deleted file mode 100644
 -xyzzy
 \ No newline at end of file
 EOF
+"
=20
-test_expect_success \
+test_expect_success SYMLINKS \
     'validate diff output' \
     'compare_diff_patch current expected'
=20
diff --git a/t/t4011-diff-symlink.sh b/t/t4011-diff-symlink.sh
index 918a21a..6f69489 100755
--- a/t/t4011-diff-symlink.sh
+++ b/t/t4011-diff-symlink.sh
@@ -9,12 +9,6 @@ test_description=3D'Test diff of symlinks.
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/diff-lib.sh
=20
-if ! test_have_prereq SYMLINKS
-then
-	skip_all=3D'Symbolic links not supported, skipping tests.'
-	test_done
-fi
-
 cat > expected << EOF
 diff --git a/frotz b/frotz
 new file mode 120000
@@ -26,7 +20,7 @@ index 0000000..7c465af
 \ No newline at end of file
 EOF
=20
-test_expect_success \
+test_expect_success SYMLINKS \
     'diff new symlink' \
     'ln -s xyzzy frotz &&
     git update-index &&
@@ -35,7 +29,7 @@ test_expect_success \
     GIT_DIFF_OPTS=3D--unified=3D0 git diff-index -M -p $tree > current=
 &&
     compare_diff_patch current expected'
=20
-test_expect_success \
+test_expect_success SYMLINKS \
     'diff unchanged symlink' \
     'tree=3D$(git write-tree) &&
     git update-index frotz &&
@@ -52,7 +46,7 @@ index 7c465af..0000000
 \ No newline at end of file
 EOF
=20
-test_expect_success \
+test_expect_success SYMLINKS \
     'diff removed symlink' \
     'mv frotz frotz2 &&
     git diff-index -M -p $tree > current &&
@@ -62,7 +56,7 @@ cat > expected << EOF
 diff --git a/frotz b/frotz
 EOF
=20
-test_expect_success \
+test_expect_success SYMLINKS \
     'diff identical, but newly created symlink' \
     'ln -s xyzzy frotz &&
     git diff-index -M -p $tree > current &&
@@ -80,14 +74,14 @@ index 7c465af..df1db54 120000
 \ No newline at end of file
 EOF
=20
-test_expect_success \
+test_expect_success SYMLINKS \
     'diff different symlink' \
     'rm frotz &&
     ln -s yxyyz frotz &&
     git diff-index -M -p $tree > current &&
     compare_diff_patch current expected'
=20
-test_expect_success \
+test_expect_success SYMLINKS \
     'diff symlinks with non-existing targets' \
     'ln -s narf pinky &&
     ln -s take\ over brain &&
diff --git a/t/t4023-diff-rename-typechange.sh b/t/t4023-diff-rename-ty=
pechange.sh
index 40a95a1..5d20acf 100755
--- a/t/t4023-diff-rename-typechange.sh
+++ b/t/t4023-diff-rename-typechange.sh
@@ -4,13 +4,7 @@ test_description=3D'typechange rename detection'
=20
 . ./test-lib.sh
=20
-if ! test_have_prereq SYMLINKS
-then
-	skip_all=3D'Symbolic links not supported, skipping tests.'
-	test_done
-fi
-
-test_expect_success setup '
+test_expect_success SYMLINKS setup '
=20
 	rm -f foo bar &&
 	cat "$TEST_DIRECTORY"/../COPYING >foo &&
@@ -56,7 +50,7 @@ test_expect_success setup '
=20
 '
=20
-test_expect_success 'cross renames to be detected for regular files' '
+test_expect_success SYMLINKS 'cross renames to be detected for regular=
 files' '
=20
 	git diff-tree five six -r --name-status -B -M | sort >actual &&
 	{
@@ -67,7 +61,7 @@ test_expect_success 'cross renames to be detected for=
 regular files' '
=20
 '
=20
-test_expect_success 'cross renames to be detected for typechange' '
+test_expect_success SYMLINKS 'cross renames to be detected for typecha=
nge' '
=20
 	git diff-tree one two -r --name-status -B -M | sort >actual &&
 	{
@@ -78,7 +72,7 @@ test_expect_success 'cross renames to be detected for=
 typechange' '
=20
 '
=20
-test_expect_success 'moves and renames' '
+test_expect_success SYMLINKS 'moves and renames' '
=20
 	git diff-tree three four -r --name-status -B -M | sort >actual &&
 	{
diff --git a/t/t4114-apply-typechange.sh b/t/t4114-apply-typechange.sh
index 164d58c..f12826f 100755
--- a/t/t4114-apply-typechange.sh
+++ b/t/t4114-apply-typechange.sh
@@ -9,13 +9,7 @@ test_description=3D'git apply should not get confused =
with type changes.
=20
 . ./test-lib.sh
=20
-if ! test_have_prereq SYMLINKS
-then
-	skip_all=3D'Symbolic links not supported, skipping tests.'
-	test_done
-fi
-
-test_expect_success 'setup repository and commits' '
+test_expect_success SYMLINKS 'setup repository and commits' '
 	echo "hello world" > foo &&
 	echo "hi planet" > bar &&
 	git update-index --add foo bar &&
@@ -48,7 +42,7 @@ test_expect_success 'setup repository and commits' '
 	git branch foo-baz-renamed-from-foo
 	'
=20
-test_expect_success 'file renamed from foo to foo/baz' '
+test_expect_success SYMLINKS 'file renamed from foo to foo/baz' '
 	git checkout -f initial &&
 	git diff-tree -M -p HEAD foo-baz-renamed-from-foo > patch &&
 	git apply --index < patch
@@ -56,7 +50,7 @@ test_expect_success 'file renamed from foo to foo/baz=
' '
 test_debug 'cat patch'
=20
=20
-test_expect_success 'file renamed from foo/baz to foo' '
+test_expect_success SYMLINKS 'file renamed from foo/baz to foo' '
 	git checkout -f foo-baz-renamed-from-foo &&
 	git diff-tree -M -p HEAD initial > patch &&
 	git apply --index < patch
@@ -64,7 +58,7 @@ test_expect_success 'file renamed from foo/baz to foo=
' '
 test_debug 'cat patch'
=20
=20
-test_expect_success 'directory becomes file' '
+test_expect_success SYMLINKS 'directory becomes file' '
 	git checkout -f foo-becomes-a-directory &&
 	git diff-tree -p HEAD initial > patch &&
 	git apply --index < patch
@@ -72,7 +66,7 @@ test_expect_success 'directory becomes file' '
 test_debug 'cat patch'
=20
=20
-test_expect_success 'file becomes directory' '
+test_expect_success SYMLINKS 'file becomes directory' '
 	git checkout -f initial &&
 	git diff-tree -p HEAD foo-becomes-a-directory > patch &&
 	git apply --index < patch
@@ -80,7 +74,7 @@ test_expect_success 'file becomes directory' '
 test_debug 'cat patch'
=20
=20
-test_expect_success 'file becomes symlink' '
+test_expect_success SYMLINKS 'file becomes symlink' '
 	git checkout -f initial &&
 	git diff-tree -p HEAD foo-symlinked-to-bar > patch &&
 	git apply --index < patch
@@ -88,21 +82,21 @@ test_expect_success 'file becomes symlink' '
 test_debug 'cat patch'
=20
=20
-test_expect_success 'symlink becomes file' '
+test_expect_success SYMLINKS 'symlink becomes file' '
 	git checkout -f foo-symlinked-to-bar &&
 	git diff-tree -p HEAD foo-back-to-file > patch &&
 	git apply --index < patch
 	'
 test_debug 'cat patch'
=20
-test_expect_success 'binary file becomes symlink' '
+test_expect_success SYMLINKS 'binary file becomes symlink' '
 	git checkout -f foo-becomes-binary &&
 	git diff-tree -p --binary HEAD foo-symlinked-to-bar > patch &&
 	git apply --index < patch
 	'
 test_debug 'cat patch'
=20
-test_expect_success 'symlink becomes binary file' '
+test_expect_success SYMLINKS 'symlink becomes binary file' '
 	git checkout -f foo-symlinked-to-bar &&
 	git diff-tree -p --binary HEAD foo-becomes-binary > patch &&
 	git apply --index < patch
@@ -110,7 +104,7 @@ test_expect_success 'symlink becomes binary file' '
 test_debug 'cat patch'
=20
=20
-test_expect_success 'symlink becomes directory' '
+test_expect_success SYMLINKS 'symlink becomes directory' '
 	git checkout -f foo-symlinked-to-bar &&
 	git diff-tree -p HEAD foo-becomes-a-directory > patch &&
 	git apply --index < patch
@@ -118,7 +112,7 @@ test_expect_success 'symlink becomes directory' '
 test_debug 'cat patch'
=20
=20
-test_expect_success 'directory becomes symlink' '
+test_expect_success SYMLINKS 'directory becomes symlink' '
 	git checkout -f foo-becomes-a-directory &&
 	git diff-tree -p HEAD foo-symlinked-to-bar > patch &&
 	git apply --index < patch
diff --git a/t/t4115-apply-symlink.sh b/t/t4115-apply-symlink.sh
index aff4348..7674dd2 100755
--- a/t/t4115-apply-symlink.sh
+++ b/t/t4115-apply-symlink.sh
@@ -9,13 +9,7 @@ test_description=3D'git apply symlinks and partial fil=
es
=20
 . ./test-lib.sh
=20
-if ! test_have_prereq SYMLINKS
-then
-	skip_all=3D'Symbolic links not supported, skipping tests.'
-	test_done
-fi
-
-test_expect_success setup '
+test_expect_success SYMLINKS setup '
=20
 	ln -s path1/path2/path3/path4/path5 link1 &&
 	git add link? &&
@@ -34,7 +28,7 @@ test_expect_success setup '
=20
 '
=20
-test_expect_success 'apply symlink patch' '
+test_expect_success SYMLINKS 'apply symlink patch' '
=20
 	git checkout side &&
 	git apply patch &&
@@ -43,7 +37,7 @@ test_expect_success 'apply symlink patch' '
=20
 '
=20
-test_expect_success 'apply --index symlink patch' '
+test_expect_success SYMLINKS 'apply --index symlink patch' '
=20
 	git checkout -f side &&
 	git apply --index patch &&
diff --git a/t/t4122-apply-symlink-inside.sh b/t/t4122-apply-symlink-in=
side.sh
index 923fcab..3940737 100755
--- a/t/t4122-apply-symlink-inside.sh
+++ b/t/t4122-apply-symlink-inside.sh
@@ -3,12 +3,6 @@
 test_description=3D'apply to deeper directory without getting fooled w=
ith symlink'
 . ./test-lib.sh
=20
-if ! test_have_prereq SYMLINKS
-then
-	skip_all=3D'Symbolic links not supported, skipping tests.'
-	test_done
-fi
-
 lecho () {
 	for l_
 	do
@@ -16,7 +10,7 @@ lecho () {
 	done
 }
=20
-test_expect_success setup '
+test_expect_success SYMLINKS setup '
=20
 	mkdir -p arch/i386/boot arch/x86_64 &&
 	lecho 1 2 3 4 5 >arch/i386/boot/Makefile &&
@@ -37,7 +31,7 @@ test_expect_success setup '
=20
 '
=20
-test_expect_success apply '
+test_expect_success SYMLINKS apply '
=20
 	git checkout test &&
 	git diff --exit-code test &&
@@ -46,7 +40,7 @@ test_expect_success apply '
=20
 '
=20
-test_expect_success 'check result' '
+test_expect_success SYMLINKS 'check result' '
=20
 	git diff --exit-code master &&
 	git diff --exit-code --cached master &&
diff --git a/t/t5522-pull-symlink.sh b/t/t5522-pull-symlink.sh
index 298200f..8e9b204 100755
--- a/t/t5522-pull-symlink.sh
+++ b/t/t5522-pull-symlink.sh
@@ -4,12 +4,6 @@ test_description=3D'pulling from symlinked subdir'
=20
 . ./test-lib.sh
=20
-if ! test_have_prereq SYMLINKS
-then
-	skip_all=3D'Symbolic links not supported, skipping tests.'
-	test_done
-fi
-
 # The scenario we are building:
 #
 #   trash\ directory/
@@ -20,7 +14,7 @@ fi
 #
 # The working directory is subdir-link.
=20
-test_expect_success setup '
+test_expect_success SYMLINKS setup '
 	mkdir subdir &&
 	echo file >subdir/file &&
 	git add subdir/file &&
@@ -36,7 +30,7 @@ test_expect_success setup '
=20
 # Demonstrate that things work if we just avoid the symlink
 #
-test_expect_success 'pulling from real subdir' '
+test_expect_success SYMLINKS 'pulling from real subdir' '
 	(
 		echo real >subdir/file &&
 		git commit -m real subdir/file &&
@@ -64,7 +58,7 @@ test_expect_success 'pulling from real subdir' '
 # directory.  A POSIX shell's "cd" works a little differently
 # than chdir() in C; "cd -P" is much closer to chdir().
 #
-test_expect_success 'pulling from symlinked subdir' '
+test_expect_success SYMLINKS 'pulling from symlinked subdir' '
 	(
 		echo link >subdir/file &&
 		git commit -m link subdir/file &&
@@ -77,7 +71,7 @@ test_expect_success 'pulling from symlinked subdir' '
 # Prove that the remote end really is a repo, and other commands
 # work fine in this context.  It's just that "git pull" breaks.
 #
-test_expect_success 'pushing from symlinked subdir' '
+test_expect_success SYMLINKS 'pushing from symlinked subdir' '
 	(
 		cd subdir-link/ &&
 		echo push >file &&
diff --git a/t/t6035-merge-dir-to-symlink.sh b/t/t6035-merge-dir-to-sym=
link.sh
index cd3190c..28e8f2a 100755
--- a/t/t6035-merge-dir-to-symlink.sh
+++ b/t/t6035-merge-dir-to-symlink.sh
@@ -3,13 +3,7 @@
 test_description=3D'merging when a directory was replaced with a symli=
nk'
 . ./test-lib.sh
=20
-if ! test_have_prereq SYMLINKS
-then
-	skip_all=3D'Symbolic links not supported, skipping tests.'
-	test_done
-fi
-
-test_expect_success 'create a commit where dir a/b changed to symlink'=
 '
+test_expect_success SYMLINKS 'create a commit where dir a/b changed to=
 symlink' '
 	mkdir -p a/b/c a/b-2/c &&
 	> a/b/c/d &&
 	> a/b-2/c/d &&
@@ -23,7 +17,7 @@ test_expect_success 'create a commit where dir a/b ch=
anged to symlink' '
 	git commit -m "dir to symlink"
 '
=20
-test_expect_success 'keep a/b-2/c/d across checkout' '
+test_expect_success SYMLINKS 'keep a/b-2/c/d across checkout' '
 	git checkout HEAD^0 &&
 	git reset --hard master &&
 	git rm --cached a/b &&
@@ -32,14 +26,14 @@ test_expect_success 'keep a/b-2/c/d across checkout=
' '
 	 test -f a/b-2/c/d
 '
=20
-test_expect_success 'checkout should not have deleted a/b-2/c/d' '
+test_expect_success SYMLINKS 'checkout should not have deleted a/b-2/c=
/d' '
 	git checkout HEAD^0 &&
 	git reset --hard master &&
 	 git checkout start^0 &&
 	 test -f a/b-2/c/d
 '
=20
-test_expect_success 'setup for merge test' '
+test_expect_success SYMLINKS 'setup for merge test' '
 	git reset --hard &&
 	test -f a/b-2/c/d &&
 	echo x > a/x &&
@@ -48,7 +42,7 @@ test_expect_success 'setup for merge test' '
 	git tag baseline
 '
=20
-test_expect_success 'do not lose a/b-2/c/d in merge (resolve)' '
+test_expect_success SYMLINKS 'do not lose a/b-2/c/d in merge (resolve)=
' '
 	git reset --hard &&
 	git checkout baseline^0 &&
 	git merge -s resolve master &&
@@ -64,7 +58,7 @@ test_expect_failure 'do not lose a/b-2/c/d in merge (=
recursive)' '
 	test -f a/b-2/c/d
 '
=20
-test_expect_success 'setup a merge where dir a/b-2 changed to symlink'=
 '
+test_expect_success SYMLINKS 'setup a merge where dir a/b-2 changed to=
 symlink' '
 	git reset --hard &&
 	git checkout start^0 &&
 	rm -rf a/b-2 &&
@@ -74,7 +68,7 @@ test_expect_success 'setup a merge where dir a/b-2 ch=
anged to symlink' '
 	git tag test2
 '
=20
-test_expect_success 'merge should not have conflicts (resolve)' '
+test_expect_success SYMLINKS 'merge should not have conflicts (resolve=
)' '
 	git reset --hard &&
 	git checkout baseline^0 &&
 	git merge -s resolve test2 &&
--=20
1.7.0.4
