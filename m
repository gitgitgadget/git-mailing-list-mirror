From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: [PATCH 2/6] t9300, t9301: use "git fast-import/fast-export" without dash
Date: Wed, 10 Sep 2008 06:25:25 +0900
Message-ID: <20080910062525.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 09 23:28:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdAkg-0007Te-PF
	for gcvg-git-2@gmane.org; Tue, 09 Sep 2008 23:27:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753250AbYIIV0W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Sep 2008 17:26:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753228AbYIIV0W
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Sep 2008 17:26:22 -0400
Received: from karen.lavabit.com ([72.249.41.33]:33442 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752811AbYIIV0V (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Sep 2008 17:26:21 -0400
Received: from e.earth.lavabit.com (e.earth.lavabit.com [192.168.111.14])
	by karen.lavabit.com (Postfix) with ESMTP id AD8C1C89DA;
	Tue,  9 Sep 2008 16:26:11 -0500 (CDT)
Received: from 9677.lavabit.com (212.62.97.21)
	by lavabit.com with ESMTP id BFWCBB3H0QP1; Tue, 09 Sep 2008 16:26:20 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=f54zqLo/0ZXE6D8naf0gnpyBifTQ1TFSv9EUSsX+FLCxVSZcnd8BmKDgj7pTkZaSHlo9A9hvq4t+NaYD3m0RwfJ3wXe+Wua0h/LfdIWCrI0SXABrzYu+BtUYgb+Gt5107p2tC14POCDpU0JzlxEdSBUB0Iixx8cBVFSueUr31CM=;
  h=From:To:Cc:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:Message-Id;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95438>

Also use "git hash-object" and "git rev-parse" without dash.

Signed-off-by: Nanako Shiraishi <nanako3@lavabit.com>
---
 t/t9300-fast-import.sh |   80 ++++++++++++++++++++++++------------------------
 t/t9301-fast-export.sh |    2 +-
 2 files changed, 41 insertions(+), 41 deletions(-)

diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index bd5d5af..328444a 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -3,7 +3,7 @@
 # Copyright (c) 2007 Shawn Pearce
 #
 
-test_description='test git-fast-import utility'
+test_description='test git fast-import utility'
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/diff-lib.sh ;# test-lib chdir's into trash
 
@@ -59,7 +59,7 @@ M 755 :4 file4
 INPUT_END
 test_expect_success \
     'A: create pack from stdin' \
-    'git-fast-import --export-marks=marks.out <input &&
+    'git fast-import --export-marks=marks.out <input &&
 	 git whatchanged master'
 test_expect_success \
 	'A: verify pack' \
@@ -113,7 +113,7 @@ test_expect_success \
 
 test_expect_success \
 	'A: verify marks import' \
-	'git-fast-import \
+	'git fast-import \
 		--import-marks=marks.out \
 		--export-marks=marks.new \
 		</dev/null &&
@@ -133,7 +133,7 @@ M 755 :2 copy-of-file2
 INPUT_END
 test_expect_success \
 	'A: verify marks import does not crash' \
-	'git-fast-import --import-marks=marks.out <input &&
+	'git fast-import --import-marks=marks.out <input &&
 	 git whatchanged verify--import-marks'
 test_expect_success \
 	'A: verify pack' \
@@ -166,7 +166,7 @@ M 755 0000000000000000000000000000000000000001 zero1
 
 INPUT_END
 test_expect_success 'B: fail on invalid blob sha1' '
-    test_must_fail git-fast-import <input
+    test_must_fail git fast-import <input
 '
 rm -f .git/objects/pack_* .git/objects/index_*
 
@@ -181,7 +181,7 @@ from refs/heads/master
 
 INPUT_END
 test_expect_success 'B: fail on invalid branch name ".badbranchname"' '
-    test_must_fail git-fast-import <input
+    test_must_fail git fast-import <input
 '
 rm -f .git/objects/pack_* .git/objects/index_*
 
@@ -196,7 +196,7 @@ from refs/heads/master
 
 INPUT_END
 test_expect_success 'B: fail on invalid branch name "bad[branch]name"' '
-    test_must_fail git-fast-import <input
+    test_must_fail git fast-import <input
 '
 rm -f .git/objects/pack_* .git/objects/index_*
 
@@ -212,7 +212,7 @@ from refs/heads/master
 INPUT_END
 test_expect_success \
     'B: accept branch name "TEMP_TAG"' \
-    'git-fast-import <input &&
+    'git fast-import <input &&
 	 test -f .git/TEMP_TAG &&
 	 test `git rev-parse master` = `git rev-parse TEMP_TAG^`'
 rm -f .git/TEMP_TAG
@@ -221,7 +221,7 @@ rm -f .git/TEMP_TAG
 ### series C
 ###
 
-newf=`echo hi newf | git-hash-object -w --stdin`
+newf=`echo hi newf | git hash-object -w --stdin`
 oldf=`git rev-parse --verify master:file2`
 test_tick
 cat >input <<INPUT_END
@@ -239,7 +239,7 @@ D file3
 INPUT_END
 test_expect_success \
     'C: incremental import create pack from stdin' \
-    'git-fast-import <input &&
+    'git fast-import <input &&
 	 git whatchanged branch'
 test_expect_success \
 	'C: verify pack' \
@@ -297,7 +297,7 @@ EOF
 INPUT_END
 test_expect_success \
     'D: inline data in commit' \
-    'git-fast-import <input &&
+    'git fast-import <input &&
 	 git whatchanged branch'
 test_expect_success \
 	'D: verify pack' \
@@ -340,11 +340,11 @@ from refs/heads/branch^0
 
 INPUT_END
 test_expect_success 'E: rfc2822 date, --date-format=raw' '
-    test_must_fail git-fast-import --date-format=raw <input
+    test_must_fail git fast-import --date-format=raw <input
 '
 test_expect_success \
     'E: rfc2822 date, --date-format=rfc2822' \
-    'git-fast-import --date-format=rfc2822 <input'
+    'git fast-import --date-format=rfc2822 <input'
 test_expect_success \
 	'E: verify pack' \
 	'for p in .git/objects/pack/*.pack;do git verify-pack $p||exit;done'
@@ -381,7 +381,7 @@ from refs/heads/branch
 INPUT_END
 test_expect_success \
     'F: non-fast-forward update skips' \
-    'if git-fast-import <input
+    'if git fast-import <input
 	 then
 		echo BAD gfi did not fail
 		return 1
@@ -431,7 +431,7 @@ from refs/heads/branch~1
 INPUT_END
 test_expect_success \
     'G: non-fast-forward update forced' \
-    'git-fast-import --force <input'
+    'git fast-import --force <input'
 test_expect_success \
 	'G: verify pack' \
 	'for p in .git/objects/pack/*.pack;do git verify-pack $p||exit;done'
@@ -467,7 +467,7 @@ EOF
 INPUT_END
 test_expect_success \
     'H: deletall, add 1' \
-    'git-fast-import <input &&
+    'git fast-import <input &&
 	 git whatchanged H'
 test_expect_success \
 	'H: verify pack' \
@@ -507,7 +507,7 @@ from refs/heads/branch
 INPUT_END
 test_expect_success \
     'I: export-pack-edges' \
-    'git-fast-import --export-pack-edges=edges.list <input'
+    'git fast-import --export-pack-edges=edges.list <input'
 
 cat >expect <<EOF
 .git/objects/pack/pack-.pack: `git rev-parse --verify export-boundary`
@@ -541,7 +541,7 @@ COMMIT
 INPUT_END
 test_expect_success \
     'J: reset existing branch creates empty commit' \
-    'git-fast-import <input'
+    'git fast-import <input'
 test_expect_success \
 	'J: branch has 1 commit, empty tree' \
 	'test 1 = `git rev-list J | wc -l` &&
@@ -571,7 +571,7 @@ from refs/heads/branch^1
 INPUT_END
 test_expect_success \
     'K: reinit branch with from' \
-    'git-fast-import <input'
+    'git fast-import <input'
 test_expect_success \
     'K: verify K^1 = branch^1' \
     'test `git rev-parse --verify branch^1` \
@@ -623,7 +623,7 @@ EXPECT_END
 
 test_expect_success \
     'L: verify internal tree sorting' \
-	'git-fast-import <input &&
+	'git fast-import <input &&
 	 git diff-tree --abbrev --raw L^ L >output &&
 	 test_cmp expect output'
 
@@ -649,7 +649,7 @@ cat >expect <<EOF
 EOF
 test_expect_success \
 	'M: rename file in same subdirectory' \
-	'git-fast-import <input &&
+	'git fast-import <input &&
 	 git diff-tree -M -r M1^ M1 >actual &&
 	 compare_diff_raw expect actual'
 
@@ -670,7 +670,7 @@ cat >expect <<EOF
 EOF
 test_expect_success \
 	'M: rename file to new subdirectory' \
-	'git-fast-import <input &&
+	'git fast-import <input &&
 	 git diff-tree -M -r M2^ M2 >actual &&
 	 compare_diff_raw expect actual'
 
@@ -691,7 +691,7 @@ cat >expect <<EOF
 EOF
 test_expect_success \
 	'M: rename subdirectory to new subdirectory' \
-	'git-fast-import <input &&
+	'git fast-import <input &&
 	 git diff-tree -M -r M3^ M3 >actual &&
 	 compare_diff_raw expect actual'
 
@@ -717,7 +717,7 @@ cat >expect <<EOF
 EOF
 test_expect_success \
 	'N: copy file in same subdirectory' \
-	'git-fast-import <input &&
+	'git fast-import <input &&
 	 git diff-tree -C --find-copies-harder -r N1^ N1 >actual &&
 	 compare_diff_raw expect actual'
 
@@ -751,7 +751,7 @@ cat >expect <<EOF
 EOF
 test_expect_success \
 	'N: copy then modify subdirectory' \
-	'git-fast-import <input &&
+	'git fast-import <input &&
 	 git diff-tree -C --find-copies-harder -r N2^^ N2 >actual &&
 	 compare_diff_raw expect actual'
 
@@ -775,8 +775,8 @@ INPUT_END
 
 test_expect_success \
 	'N: copy dirty subdirectory' \
-	'git-fast-import <input &&
-	 test `git-rev-parse N2^{tree}` = `git-rev-parse N3^{tree}`'
+	'git fast-import <input &&
+	 test `git rev-parse N2^{tree}` = `git rev-parse N3^{tree}`'
 
 ###
 ### series O
@@ -815,8 +815,8 @@ INPUT_END
 
 test_expect_success \
 	'O: comments are all skipped' \
-	'git-fast-import <input &&
-	 test `git-rev-parse N3` = `git-rev-parse O1`'
+	'git fast-import <input &&
+	 test `git rev-parse N3` = `git rev-parse O1`'
 
 cat >input <<INPUT_END
 commit refs/heads/O2
@@ -836,8 +836,8 @@ INPUT_END
 
 test_expect_success \
 	'O: blank lines not necessary after data commands' \
-	'git-fast-import <input &&
-	 test `git-rev-parse N3` = `git-rev-parse O2`'
+	'git fast-import <input &&
+	 test `git rev-parse N3` = `git rev-parse O2`'
 
 test_expect_success \
 	'O: repack before next test' \
@@ -881,7 +881,7 @@ commits
 INPUT_END
 test_expect_success \
 	'O: blank lines not necessary after other commands' \
-	'git-fast-import <input &&
+	'git fast-import <input &&
 	 test 8 = `find .git/objects/pack -type f | wc -l` &&
 	 test `git rev-parse refs/tags/O3-2nd` = `git rev-parse O3^` &&
 	 git log --reverse --pretty=oneline O3 | sed s/^.*z// >actual &&
@@ -914,7 +914,7 @@ progress I'm done!
 INPUT_END
 test_expect_success \
 	'O: progress outputs as requested by input' \
-	'git-fast-import <input >actual &&
+	'git fast-import <input >actual &&
 	 grep "progress " <input >expect &&
 	 test_cmp expect actual'
 
@@ -979,7 +979,7 @@ INPUT_END
 
 test_expect_success \
 	'P: supermodule & submodule mix' \
-	'git-fast-import <input &&
+	'git fast-import <input &&
 	 git checkout subuse1 &&
 	 rm -rf sub && mkdir sub && cd sub &&
 	 git init &&
@@ -989,8 +989,8 @@ test_expect_success \
 	 git submodule init &&
 	 git submodule update'
 
-SUBLAST=$(git-rev-parse --verify sub)
-SUBPREV=$(git-rev-parse --verify sub^)
+SUBLAST=$(git rev-parse --verify sub)
+SUBPREV=$(git rev-parse --verify sub^)
 
 cat >input <<INPUT_END
 blob
@@ -1024,8 +1024,8 @@ test_expect_success \
 	'P: verbatim SHA gitlinks' \
 	'git branch -D sub &&
 	 git gc && git prune &&
-	 git-fast-import <input &&
-	 test $(git-rev-parse --verify subuse2) = $(git-rev-parse --verify subuse1)'
+	 git fast-import <input &&
+	 test $(git rev-parse --verify subuse2) = $(git rev-parse --verify subuse1)'
 
 test_tick
 cat >input <<INPUT_END
@@ -1045,7 +1045,7 @@ DATA
 INPUT_END
 
 test_expect_success 'P: fail on inline gitlink' '
-    test_must_fail git-fast-import <input'
+    test_must_fail git fast-import <input'
 
 test_tick
 cat >input <<INPUT_END
@@ -1068,6 +1068,6 @@ M 160000 :1 sub
 INPUT_END
 
 test_expect_success 'P: fail on blob mark in gitlink' '
-    test_must_fail git-fast-import <input'
+    test_must_fail git fast-import <input'
 
 test_done
diff --git a/t/t9301-fast-export.sh b/t/t9301-fast-export.sh
index 3cb9f80..6ddd7c1 100755
--- a/t/t9301-fast-export.sh
+++ b/t/t9301-fast-export.sh
@@ -3,7 +3,7 @@
 # Copyright (c) 2007 Johannes E. Schindelin
 #
 
-test_description='git-fast-export'
+test_description='git fast-export'
 . ./test-lib.sh
 
 test_expect_success 'setup' '
-- 
1.6.0.1


-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
