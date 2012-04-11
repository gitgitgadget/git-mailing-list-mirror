From: Stefano Lattarini <stefano.lattarini@gmail.com>
Subject: [PATCH] tests: modernise style: more uses of test_line_count
Date: Wed, 11 Apr 2012 13:24:01 +0200
Message-ID: <e701486509c3306420e6bcf82e7d0d79fb2e7ae1.1334143281.git.stefano.lattarini@gmail.com>
Cc: gitster@pobox.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 11 13:24:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHvf1-00035m-Lb
	for gcvg-git-2@plane.gmane.org; Wed, 11 Apr 2012 13:24:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757569Ab2DKLYX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Apr 2012 07:24:23 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:53625 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751899Ab2DKLYV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2012 07:24:21 -0400
Received: by eaaq12 with SMTP id q12so181134eaa.19
        for <git@vger.kernel.org>; Wed, 11 Apr 2012 04:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=//6pFV/kzfBbv61O3zlt6IeSaWLk7v8IEY2mz+w6lV8=;
        b=PNvo6/paF5eM5FMTMJUVPtjPC2zcKzDQp3nuZdpGyx1tpJVvAcM6Fz2eZs0LnEbvCX
         sGpgCjRFrVaQNVhZfK9Mj4d1+/+IVcDK3mpcOgGBgOGy57oXd01NdlNs6+ui3zcO63u9
         WKUw3EUfLp5NpaTTi7QlUouUx3RKx/E2YMJN19VcUoUgtSiPaia2fDumPFhh54zmQY3P
         nW6mvjrVB9dcgpn4YPo/iKetpZkRkeQ92+DWkPBVUJZVGZDFyX/k3iMeIJON/NIrwmrv
         v6HMT9CcShyGjkFeOrc9s6e5qfMXvsWGamwINXjMUKGSXDbo5szLCLUqAYnjud9AyRDM
         KFnA==
Received: by 10.14.187.142 with SMTP id y14mr1861800eem.111.1334143460212;
        Wed, 11 Apr 2012 04:24:20 -0700 (PDT)
Received: from localhost.localdomain (host201-30-dynamic.60-82-r.retail.telecomitalia.it. [82.60.30.201])
        by mx.google.com with ESMTPS id z47sm11024821een.5.2012.04.11.04.24.15
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 11 Apr 2012 04:24:18 -0700 (PDT)
X-Mailer: git-send-email 1.7.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195168>

Prefer:

  test_line_count <OP> COUNT FILE

over:

  test $(wc -l <FILE) <OP> COUNT

(or similar usages) in several tests.

Signed-off-by: Stefano Lattarini <stefano.lattarini@gmail.com>
---

 This is a re-roll of a patch I first sent a month ago:
 <http://comments.gmane.org/gmane.comp.version-control.git/192745>
 
 That patch was stalled as "not appropriate for this part of the release
 cycle"; since Git 1.7.10 has now been released, I'm re-sending the patch,
 after having rebased it on latest master.

 Regards,
   Stefano
 
 t/t1410-reflog.sh                    |   26 ++++++++------------------
 t/t2004-checkout-cache-temp.sh       |   20 ++++++++++----------
 t/t2030-unresolve-info.sh            |    2 +-
 t/t3415-rebase-autosquash.sh         |   16 ++++++++--------
 t/t3900-i18n-commit.sh               |    2 +-
 t/t4035-diff-quiet.sh                |   26 +++++++++++++-------------
 t/t5100-mailinfo.sh                  |    2 +-
 t/t5700-clone-reference.sh           |    4 ++--
 t/t5710-info-alternate.sh            |    2 +-
 t/t6006-rev-list-format.sh           |   13 +++++++------
 t/t6030-bisect-porcelain.sh          |    2 +-
 t/t6032-merge-large-rename.sh        |    2 +-
 t/t6042-merge-rename-corner-cases.sh |    2 +-
 t/t7201-co.sh                        |    4 ++--
 t/t7400-submodule-basic.sh           |    2 +-
 t/t7408-submodule-reference.sh       |    4 ++--
 t/t7502-commit.sh                    |    2 +-
 t/t9350-fast-export.sh               |    4 ++--
 t/t9400-git-cvsserver-server.sh      |    4 ++--
 19 files changed, 65 insertions(+), 74 deletions(-)

diff --git a/t/t1410-reflog.sh b/t/t1410-reflog.sh
index 252fc82..236b13a 100755
--- a/t/t1410-reflog.sh
+++ b/t/t1410-reflog.sh
@@ -100,8 +100,7 @@ test_expect_success setup '
 
 	check_fsck &&
 
-	loglen=$(wc -l <.git/logs/refs/heads/master) &&
-	test $loglen = 4
+	test_line_count = 4 .git/logs/refs/heads/master
 '
 
 test_expect_success rewind '
@@ -117,8 +116,7 @@ test_expect_success rewind '
 
 	check_have A B C D E F G H I J K L &&
 
-	loglen=$(wc -l <.git/logs/refs/heads/master) &&
-	test $loglen = 5
+	test_line_count = 5 .git/logs/refs/heads/master
 '
 
 test_expect_success 'corrupt and check' '
@@ -136,8 +134,7 @@ test_expect_success 'reflog expire --dry-run should not touch reflog' '
 		--stale-fix \
 		--all &&
 
-	loglen=$(wc -l <.git/logs/refs/heads/master) &&
-	test $loglen = 5 &&
+	test_line_count = 5 .git/logs/refs/heads/master &&
 
 	check_fsck "missing blob $F"
 '
@@ -150,8 +147,7 @@ test_expect_success 'reflog expire' '
 		--stale-fix \
 		--all &&
 
-	loglen=$(wc -l <.git/logs/refs/heads/master) &&
-	test $loglen = 2 &&
+	test_line_count = 2 .git/logs/refs/heads/master &&
 
 	check_fsck "dangling commit $K"
 '
@@ -217,9 +213,7 @@ test_expect_success 'delete' '
 test_expect_success 'rewind2' '
 
 	test_tick && git reset --hard HEAD~2 &&
-	loglen=$(wc -l <.git/logs/refs/heads/master) &&
-	test $loglen = 4
-
+	test_line_count = 4 .git/logs/refs/heads/master
 '
 
 test_expect_success '--expire=never' '
@@ -228,9 +222,7 @@ test_expect_success '--expire=never' '
 		--expire=never \
 		--expire-unreachable=never \
 		--all &&
-	loglen=$(wc -l <.git/logs/refs/heads/master) &&
-	test $loglen = 4
-
+	test_line_count = 4 .git/logs/refs/heads/master
 '
 
 test_expect_success 'gc.reflogexpire=never' '
@@ -238,8 +230,7 @@ test_expect_success 'gc.reflogexpire=never' '
 	git config gc.reflogexpire never &&
 	git config gc.reflogexpireunreachable never &&
 	git reflog expire --verbose --all &&
-	loglen=$(wc -l <.git/logs/refs/heads/master) &&
-	test $loglen = 4
+	test_line_count = 4 .git/logs/refs/heads/master
 '
 
 test_expect_success 'gc.reflogexpire=false' '
@@ -247,8 +238,7 @@ test_expect_success 'gc.reflogexpire=false' '
 	git config gc.reflogexpire false &&
 	git config gc.reflogexpireunreachable false &&
 	git reflog expire --verbose --all &&
-	loglen=$(wc -l <.git/logs/refs/heads/master) &&
-	test $loglen = 4 &&
+	test_line_count = 4 .git/logs/refs/heads/master &&
 
 	git config --unset gc.reflogexpire &&
 	git config --unset gc.reflogexpireunreachable
diff --git a/t/t2004-checkout-cache-temp.sh b/t/t2004-checkout-cache-temp.sh
index 36cca14..0f4b289 100755
--- a/t/t2004-checkout-cache-temp.sh
+++ b/t/t2004-checkout-cache-temp.sh
@@ -40,7 +40,7 @@ test_expect_success \
 rm -f path* .merge_* out .git/index &&
 git read-tree $t1 &&
 git checkout-index --temp -- path1 >out &&
-test $(wc -l <out) = 1 &&
+test_line_count = 1 out &&
 test $(cut "-d	" -f2 out) = path1 &&
 p=$(cut "-d	" -f1 out) &&
 test -f $p &&
@@ -51,7 +51,7 @@ test_expect_success \
 rm -f path* .merge_* out .git/index &&
 git read-tree $t1 &&
 git checkout-index -a --temp >out &&
-test $(wc -l <out) = 5 &&
+test_line_count = 5 out &&
 for f in path0 path1 path3 path4 asubdir/path5
 do
 	test $(grep $f out | cut "-d	" -f2) = $f &&
@@ -69,7 +69,7 @@ test_expect_success \
 'checkout one stage 2 to temporary file' '
 rm -f path* .merge_* out &&
 git checkout-index --stage=2 --temp -- path1 >out &&
-test $(wc -l <out) = 1 &&
+test_line_count = 1 out &&
 test $(cut "-d	" -f2 out) = path1 &&
 p=$(cut "-d	" -f1 out) &&
 test -f $p &&
@@ -79,7 +79,7 @@ test_expect_success \
 'checkout all stage 2 to temporary files' '
 rm -f path* .merge_* out &&
 git checkout-index --all --stage=2 --temp >out &&
-test $(wc -l <out) = 3 &&
+test_line_count = 3 out &&
 for f in path1 path2 path4
 do
 	test $(grep $f out | cut "-d	" -f2) = $f &&
@@ -92,13 +92,13 @@ test_expect_success \
 'checkout all stages/one file to nothing' '
 rm -f path* .merge_* out &&
 git checkout-index --stage=all --temp -- path0 >out &&
-test $(wc -l <out) = 0'
+test_line_count = 0 out'
 
 test_expect_success \
 'checkout all stages/one file to temporary files' '
 rm -f path* .merge_* out &&
 git checkout-index --stage=all --temp -- path1 >out &&
-test $(wc -l <out) = 1 &&
+test_line_count = 1 out &&
 test $(cut "-d	" -f2 out) = path1 &&
 cut "-d	" -f1 out | (read s1 s2 s3 &&
 test -f $s1 &&
@@ -112,7 +112,7 @@ test_expect_success \
 'checkout some stages/one file to temporary files' '
 rm -f path* .merge_* out &&
 git checkout-index --stage=all --temp -- path2 >out &&
-test $(wc -l <out) = 1 &&
+test_line_count = 1 out &&
 test $(cut "-d	" -f2 out) = path2 &&
 cut "-d	" -f1 out | (read s1 s2 s3 &&
 test $s1 = . &&
@@ -125,7 +125,7 @@ test_expect_success \
 'checkout all stages/all files to temporary files' '
 rm -f path* .merge_* out &&
 git checkout-index -a --stage=all --temp >out &&
-test $(wc -l <out) = 5'
+test_line_count = 5 out'
 
 test_expect_success \
 '-- path0: no entry' '
@@ -185,7 +185,7 @@ test_expect_success \
 'checkout --temp within subdir' '
 (cd asubdir &&
  git checkout-index -a --stage=all >out &&
- test $(wc -l <out) = 1 &&
+ test_line_count = 1 out &&
  test $(grep path5 out | cut "-d	" -f2) = path5 &&
  grep path5 out | cut "-d	" -f1 | (read s1 s2 s3 &&
  test -f ../$s1 &&
@@ -203,7 +203,7 @@ t4=$(git write-tree) &&
 rm -f .git/index &&
 git read-tree $t4 &&
 git checkout-index --temp -a >out &&
-test $(wc -l <out) = 1 &&
+test_line_count = 1 out &&
 test $(cut "-d	" -f2 out) = a &&
 p=$(cut "-d	" -f1 out) &&
 test -f $p &&
diff --git a/t/t2030-unresolve-info.sh b/t/t2030-unresolve-info.sh
index cb7effe..f262065 100755
--- a/t/t2030-unresolve-info.sh
+++ b/t/t2030-unresolve-info.sh
@@ -113,7 +113,7 @@ test_expect_success 'unmerge with plumbing' '
 	prime_resolve_undo &&
 	git update-index --unresolve fi/le &&
 	git ls-files -u >actual &&
-	test $(wc -l <actual) = 3
+	test_line_count = 3 actual
 '
 
 test_expect_success 'rerere and rerere forget' '
diff --git a/t/t3415-rebase-autosquash.sh b/t/t3415-rebase-autosquash.sh
index b38be8e..5fc366a 100755
--- a/t/t3415-rebase-autosquash.sh
+++ b/t/t3415-rebase-autosquash.sh
@@ -33,7 +33,7 @@ test_auto_fixup () {
 	test_tick &&
 	git rebase $2 -i HEAD^^^ &&
 	git log --oneline >actual &&
-	test 3 = $(wc -l <actual) &&
+	test_line_count = 3 actual
 	git diff --exit-code $1 &&
 	test 1 = "$(git cat-file blob HEAD^:file1)" &&
 	test 1 = $(git cat-file commit HEAD^ | grep first | wc -l)
@@ -62,7 +62,7 @@ test_auto_squash () {
 	test_tick &&
 	git rebase $2 -i HEAD^^^ &&
 	git log --oneline >actual &&
-	test 3 = $(wc -l <actual) &&
+	test_line_count = 3 actual
 	git diff --exit-code $1 &&
 	test 1 = "$(git cat-file blob HEAD^:file1)" &&
 	test 2 = $(git cat-file commit HEAD^ | grep first | wc -l)
@@ -90,7 +90,7 @@ test_expect_success 'misspelled auto squash' '
 	test_tick &&
 	git rebase --autosquash -i HEAD^^^ &&
 	git log --oneline >actual &&
-	test 4 = $(wc -l <actual) &&
+	test_line_count = 4 actual &&
 	git diff --exit-code final-missquash &&
 	test 0 = $(git rev-list final-missquash...HEAD | wc -l)
 '
@@ -109,7 +109,7 @@ test_expect_success 'auto squash that matches 2 commits' '
 	test_tick &&
 	git rebase --autosquash -i HEAD~4 &&
 	git log --oneline >actual &&
-	test 4 = $(wc -l <actual) &&
+	test_line_count = 4 actual &&
 	git diff --exit-code final-multisquash &&
 	test 1 = "$(git cat-file blob HEAD^^:file1)" &&
 	test 2 = $(git cat-file commit HEAD^^ | grep first | wc -l) &&
@@ -130,7 +130,7 @@ test_expect_success 'auto squash that matches a commit after the squash' '
 	test_tick &&
 	git rebase --autosquash -i HEAD~4 &&
 	git log --oneline >actual &&
-	test 5 = $(wc -l <actual) &&
+	test_line_count = 5 actual &&
 	git diff --exit-code final-presquash &&
 	test 0 = "$(git cat-file blob HEAD^^:file1)" &&
 	test 1 = "$(git cat-file blob HEAD^:file1)" &&
@@ -147,7 +147,7 @@ test_expect_success 'auto squash that matches a sha1' '
 	test_tick &&
 	git rebase --autosquash -i HEAD^^^ &&
 	git log --oneline >actual &&
-	test 3 = $(wc -l <actual) &&
+	test_line_count = 3 actual &&
 	git diff --exit-code final-shasquash &&
 	test 1 = "$(git cat-file blob HEAD^:file1)" &&
 	test 1 = $(git cat-file commit HEAD^ | grep squash | wc -l)
@@ -163,7 +163,7 @@ test_expect_success 'auto squash that matches longer sha1' '
 	test_tick &&
 	git rebase --autosquash -i HEAD^^^ &&
 	git log --oneline >actual &&
-	test 3 = $(wc -l <actual) &&
+	test_line_count = 3 actual &&
 	git diff --exit-code final-longshasquash &&
 	test 1 = "$(git cat-file blob HEAD^:file1)" &&
 	test 1 = $(git cat-file commit HEAD^ | grep squash | wc -l)
@@ -179,7 +179,7 @@ test_auto_commit_flags () {
 	test_tick &&
 	git rebase --autosquash -i HEAD^^^ &&
 	git log --oneline >actual &&
-	test 3 = $(wc -l <actual) &&
+	test_line_count = 3 actual &&
 	git diff --exit-code final-commit-$1 &&
 	test 1 = "$(git cat-file blob HEAD^:file1)" &&
 	test $2 = $(git cat-file commit HEAD^ | grep first | wc -l)
diff --git a/t/t3900-i18n-commit.sh b/t/t3900-i18n-commit.sh
index d48a7c0..37ddabb 100755
--- a/t/t3900-i18n-commit.sh
+++ b/t/t3900-i18n-commit.sh
@@ -160,7 +160,7 @@ test_commit_autosquash_flags () {
 		git config --unset-all i18n.commitencoding &&
 		git rebase --autosquash -i HEAD^^^ &&
 		git log --oneline >actual &&
-		test 3 = $(wc -l <actual)
+		test_line_count = 3 actual
 	'
 }
 
diff --git a/t/t4035-diff-quiet.sh b/t/t4035-diff-quiet.sh
index e747e84..cdb9202 100755
--- a/t/t4035-diff-quiet.sh
+++ b/t/t4035-diff-quiet.sh
@@ -15,65 +15,65 @@ test_expect_success 'setup' '
 
 test_expect_success 'git diff-tree HEAD^ HEAD' '
 	git diff-tree --quiet HEAD^ HEAD >cnt
-	test $? = 1 && test $(wc -l <cnt) = 0
+	test $? = 1 && test_line_count = 0 cnt
 '
 test_expect_success 'git diff-tree HEAD^ HEAD -- a' '
 	git diff-tree --quiet HEAD^ HEAD -- a >cnt
-	test $? = 0 && test $(wc -l <cnt) = 0
+	test $? = 0 && test_line_count = 0 cnt
 '
 test_expect_success 'git diff-tree HEAD^ HEAD -- b' '
 	git diff-tree --quiet HEAD^ HEAD -- b >cnt
-	test $? = 1 && test $(wc -l <cnt) = 0
+	test $? = 1 && test_line_count = 0 cnt
 '
 # this diff outputs one line: sha1 of the given head
 test_expect_success 'echo HEAD | git diff-tree --stdin' '
 	echo $(git rev-parse HEAD) | git diff-tree --quiet --stdin >cnt
-	test $? = 1 && test $(wc -l <cnt) = 1
+	test $? = 1 && test_line_count = 1 cnt
 '
 test_expect_success 'git diff-tree HEAD HEAD' '
 	git diff-tree --quiet HEAD HEAD >cnt
-	test $? = 0 && test $(wc -l <cnt) = 0
+	test $? = 0 && test_line_count = 0 cnt
 '
 test_expect_success 'git diff-files' '
 	git diff-files --quiet >cnt
-	test $? = 0 && test $(wc -l <cnt) = 0
+	test $? = 0 && test_line_count = 0 cnt
 '
 test_expect_success 'git diff-index --cached HEAD' '
 	git diff-index --quiet --cached HEAD >cnt
-	test $? = 0 && test $(wc -l <cnt) = 0
+	test $? = 0 && test_line_count = 0 cnt
 '
 test_expect_success 'git diff-index --cached HEAD^' '
 	git diff-index --quiet --cached HEAD^ >cnt
-	test $? = 1 && test $(wc -l <cnt) = 0
+	test $? = 1 && test_line_count = 0 cnt
 '
 test_expect_success 'git diff-index --cached HEAD^' '
 	echo text >>b &&
 	echo 3 >c &&
 	git add . && {
 		git diff-index --quiet --cached HEAD^ >cnt
-		test $? = 1 && test $(wc -l <cnt) = 0
+		test $? = 1 && test_line_count = 0 cnt
 	}
 '
 test_expect_success 'git diff-tree -Stext HEAD^ HEAD -- b' '
 	git commit -m "text in b" && {
 		git diff-tree --quiet -Stext HEAD^ HEAD -- b >cnt
-		test $? = 1 && test $(wc -l <cnt) = 0
+		test $? = 1 && test_line_count = 0 cnt
 	}
 '
 test_expect_success 'git diff-tree -Snot-found HEAD^ HEAD -- b' '
 	git diff-tree --quiet -Snot-found HEAD^ HEAD -- b >cnt
-	test $? = 0 && test $(wc -l <cnt) = 0
+	test $? = 0 && test_line_count = 0 cnt
 '
 test_expect_success 'git diff-files' '
 	echo 3 >>c && {
 		git diff-files --quiet >cnt
-		test $? = 1 && test $(wc -l <cnt) = 0
+		test $? = 1 && test_line_count = 0 cnt
 	}
 '
 test_expect_success 'git diff-index --cached HEAD' '
 	git update-index c && {
 		git diff-index --quiet --cached HEAD >cnt
-		test $? = 1 && test $(wc -l <cnt) = 0
+		test $? = 1 && test_line_count = 0 cnt
 	}
 '
 
diff --git a/t/t5100-mailinfo.sh b/t/t5100-mailinfo.sh
index ebc36c1..81904d9 100755
--- a/t/t5100-mailinfo.sh
+++ b/t/t5100-mailinfo.sh
@@ -65,7 +65,7 @@ test_expect_success 'respect NULs' '
 	git mailsplit -d3 -o. "$TEST_DIRECTORY"/t5100/nul-plain &&
 	test_cmp "$TEST_DIRECTORY"/t5100/nul-plain 001 &&
 	(cat 001 | git mailinfo msg patch) &&
-	test 4 = $(wc -l < patch)
+	test_line_count = 4 patch
 
 '
 
diff --git a/t/t5700-clone-reference.sh b/t/t5700-clone-reference.sh
index bbc4691..c47d450 100755
--- a/t/t5700-clone-reference.sh
+++ b/t/t5700-clone-reference.sh
@@ -34,7 +34,7 @@ test_expect_success 'cloning with reference (-l -s)' \
 cd "$base_dir"
 
 test_expect_success 'existence of info/alternates' \
-'test `wc -l <C/.git/objects/info/alternates` = 2'
+'test_line_count = 2 C/.git/objects/info/alternates'
 
 cd "$base_dir"
 
@@ -63,7 +63,7 @@ test_expect_success 'fetched no objects' \
 cd "$base_dir"
 
 test_expect_success 'existence of info/alternates' \
-'test `wc -l <D/.git/objects/info/alternates` = 1'
+'test_line_count = 1 D/.git/objects/info/alternates'
 
 cd "$base_dir"
 
diff --git a/t/t5710-info-alternate.sh b/t/t5710-info-alternate.sh
index ef7127c..aa04529 100755
--- a/t/t5710-info-alternate.sh
+++ b/t/t5710-info-alternate.sh
@@ -18,7 +18,7 @@ reachable_via() {
 
 test_valid_repo() {
 	git fsck --full > fsck.log &&
-	test `wc -l < fsck.log` = 0
+	test_line_count = 0 fsck.log
 }
 
 base_dir=`pwd`
diff --git a/t/t6006-rev-list-format.sh b/t/t6006-rev-list-format.sh
index 4442790..a01d244 100755
--- a/t/t6006-rev-list-format.sh
+++ b/t/t6006-rev-list-format.sh
@@ -188,23 +188,23 @@ test_expect_success 'empty email' '
 
 test_expect_success 'del LF before empty (1)' '
 	git show -s --pretty=format:"%s%n%-b%nThanks%n" HEAD^^ >actual &&
-	test $(wc -l <actual) = 2
+	test_line_count = 2 actual
 '
 
 test_expect_success 'del LF before empty (2)' '
 	git show -s --pretty=format:"%s%n%-b%nThanks%n" HEAD >actual &&
-	test $(wc -l <actual) = 6 &&
+	test_line_count = 6 actual &&
 	grep "^$" actual
 '
 
 test_expect_success 'add LF before non-empty (1)' '
 	git show -s --pretty=format:"%s%+b%nThanks%n" HEAD^^ >actual &&
-	test $(wc -l <actual) = 2
+	test_line_count = 2 actual
 '
 
 test_expect_success 'add LF before non-empty (2)' '
 	git show -s --pretty=format:"%s%+b%nThanks%n" HEAD >actual &&
-	test $(wc -l <actual) = 6 &&
+	test_line_count = 6 actual &&
 	grep "^$" actual
 '
 
@@ -278,8 +278,9 @@ test_expect_success 'oneline with empty message' '
 	git commit -m "dummy" --allow-empty &&
 	git filter-branch --msg-filter "sed -e s/dummy//" HEAD^^.. &&
 	git rev-list --oneline HEAD >test.txt &&
-	test $(git rev-list --oneline HEAD | wc -l) -eq 5 &&
-	test $(git rev-list --oneline --graph HEAD | wc -l) -eq 5
+	test_line_count = 5 test.txt &&
+	git rev-list --oneline --graph HEAD >testg.txt &&
+	test_line_count = 5 testg.txt
 '
 
 test_done
diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index 691e4a4..72e28ee 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -480,7 +480,7 @@ test_expect_success 'many merge bases creation' '
 	git merge -m "merge HASH7 and SIDE_HASH7" "$HASH7" &&
 	B_HASH=$(git rev-parse --verify HEAD) &&
 	git merge-base --all "$A_HASH" "$B_HASH" > merge_bases.txt &&
-	test $(wc -l < merge_bases.txt) = "2" &&
+	test_line_count = 2 merge_bases.txt &&
 	grep "$HASH5" merge_bases.txt &&
 	grep "$SIDE_HASH5" merge_bases.txt
 '
diff --git a/t/t6032-merge-large-rename.sh b/t/t6032-merge-large-rename.sh
index 94f010b..15beecc 100755
--- a/t/t6032-merge-large-rename.sh
+++ b/t/t6032-merge-large-rename.sh
@@ -97,7 +97,7 @@ test_expect_success 'setup large simple rename' '
 test_expect_success 'massive simple rename does not spam added files' '
 	sane_unset GIT_MERGE_VERBOSITY &&
 	git merge --no-stat simple-rename | grep -v Removing >output &&
-	test 5 -gt "$(wc -l < output)"
+	test_line_count -lt 5 output
 '
 
 test_done
diff --git a/t/t6042-merge-rename-corner-cases.sh b/t/t6042-merge-rename-corner-cases.sh
index 32591f9..b8d15fc 100755
--- a/t/t6042-merge-rename-corner-cases.sh
+++ b/t/t6042-merge-rename-corner-cases.sh
@@ -104,7 +104,7 @@ test_expect_failure 'conflict caused if rename not detected' '
 	test 0 -eq $(git ls-files -u | wc -l) &&
 	test 0 -eq $(git ls-files -o | wc -l) &&
 
-	test 6 -eq $(wc -l < c) &&
+	test_line_count = 6 c
 	test $(git rev-parse HEAD:a) = $(git rev-parse B:a) &&
 	test $(git rev-parse HEAD:b) = $(git rev-parse A:b)
 '
diff --git a/t/t7201-co.sh b/t/t7201-co.sh
index 07fb53a..be9672e 100755
--- a/t/t7201-co.sh
+++ b/t/t7201-co.sh
@@ -229,7 +229,7 @@ test_expect_success 'checkout to detach HEAD (with advice declined)' '
 	git checkout -f renamer && git clean -f &&
 	git checkout renamer^ 2>messages &&
 	test_i18ngrep "HEAD is now at 7329388" messages &&
-	test 1 -eq $(wc -l <messages) &&
+	test_line_count = 1 messages &&
 	H=$(git rev-parse --verify HEAD) &&
 	M=$(git show-ref -s --verify refs/heads/master) &&
 	test "z$H" = "z$M" &&
@@ -247,7 +247,7 @@ test_expect_success 'checkout to detach HEAD' '
 	git checkout -f renamer && git clean -f &&
 	git checkout renamer^ 2>messages &&
 	test_i18ngrep "HEAD is now at 7329388" messages &&
-	test 1 -lt $(wc -l <messages) &&
+	test_line_count -gt 1 messages &&
 	H=$(git rev-parse --verify HEAD) &&
 	M=$(git show-ref -s --verify refs/heads/master) &&
 	test "z$H" = "z$M" &&
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index b377a7a..81827e6 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -234,7 +234,7 @@ EOF
 
 test_expect_success 'status should only print one line' '
 	git submodule status >lines &&
-	test $(wc -l <lines) = 1
+	test_line_count = 1 lines
 '
 
 test_expect_success 'setup - fetch commit name from submodule' '
diff --git a/t/t7408-submodule-reference.sh b/t/t7408-submodule-reference.sh
index ab37c36..a45fadc 100755
--- a/t/t7408-submodule-reference.sh
+++ b/t/t7408-submodule-reference.sh
@@ -43,7 +43,7 @@ git commit -m B-super-added'
 cd "$base_dir"
 
 test_expect_success 'after add: existence of info/alternates' \
-'test `wc -l <super/.git/modules/sub/objects/info/alternates` = 1'
+'test_line_count = 1 super/.git/modules/sub/objects/info/alternates'
 
 cd "$base_dir"
 
@@ -66,7 +66,7 @@ test_expect_success 'update with reference' \
 cd "$base_dir"
 
 test_expect_success 'after update: existence of info/alternates' \
-'test `wc -l <super-clone/.git/modules/sub/objects/info/alternates` = 1'
+'test_line_count = 1 super-clone/.git/modules/sub/objects/info/alternates'
 
 cd "$base_dir"
 
diff --git a/t/t7502-commit.sh b/t/t7502-commit.sh
index 3f3adc3..181456a 100755
--- a/t/t7502-commit.sh
+++ b/t/t7502-commit.sh
@@ -335,7 +335,7 @@ test_expect_success 'A single-liner subject with a token plus colon is not a foo
 	git reset --hard &&
 	git commit -s -m "hello: kitty" --allow-empty &&
 	git cat-file commit HEAD | sed -e "1,/^$/d" >actual &&
-	test $(wc -l <actual) = 3
+	test_line_count = 3 actual
 
 '
 
diff --git a/t/t9350-fast-export.sh b/t/t9350-fast-export.sh
index 950d0ff..b00196b 100755
--- a/t/t9350-fast-export.sh
+++ b/t/t9350-fast-export.sh
@@ -86,7 +86,7 @@ test_expect_success 'import/export-marks' '
 	git checkout -b marks master &&
 	git fast-export --export-marks=tmp-marks HEAD &&
 	test -s tmp-marks &&
-	test $(wc -l < tmp-marks) -eq 3 &&
+	test_line_count = 3 tmp-marks &&
 	test $(
 		git fast-export --import-marks=tmp-marks\
 		--export-marks=tmp-marks HEAD |
@@ -101,7 +101,7 @@ test_expect_success 'import/export-marks' '
 		grep ^commit\  |
 		wc -l) \
 	-eq 1 &&
-	test $(wc -l < tmp-marks) -eq 4
+	test_line_count = 4 tmp-marks
 
 '
 
diff --git a/t/t9400-git-cvsserver-server.sh b/t/t9400-git-cvsserver-server.sh
index 9199550..d3e88f8 100755
--- a/t/t9400-git-cvsserver-server.sh
+++ b/t/t9400-git-cvsserver-server.sh
@@ -476,14 +476,14 @@ test_expect_success 'cvs status' '
     cd cvswork &&
     GIT_CONFIG="$git_config" cvs update &&
     GIT_CONFIG="$git_config" cvs status | grep "^File: status.file" >../out &&
-    test $(wc -l <../out) = 2
+    test_line_count = 2 ../out
 '
 
 cd "$WORKDIR"
 test_expect_success 'cvs status (nonrecursive)' '
     cd cvswork &&
     GIT_CONFIG="$git_config" cvs status -l | grep "^File: status.file" >../out &&
-    test $(wc -l <../out) = 1
+    test_line_count = 1 ../out
 '
 
 cd "$WORKDIR"
-- 
1.7.9
