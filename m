From: Torsten =?utf-8?q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH 3/8] t9402: Dont use test_must_fail cvs
Date: Sat, 8 Dec 2012 22:34:15 +0100
Message-ID: <201212082234.15716.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tboegi@web.de, mmogilvi_git@miniinfo.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 08 22:34:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ThS2h-00010Y-CU
	for gcvg-git-2@plane.gmane.org; Sat, 08 Dec 2012 22:34:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758188Ab2LHVeX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 8 Dec 2012 16:34:23 -0500
Received: from mout.web.de ([212.227.17.12]:60542 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752066Ab2LHVeW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 8 Dec 2012 16:34:22 -0500
Received: from appes.localnet ([195.67.191.23]) by smtp.web.de (mrweb103) with
 ESMTPA (Nemesis) id 0LxOHm-1T5OFS2dA2-016v9H; Sat, 08 Dec 2012 22:34:20 +0100
X-Provags-ID: V02:K0:4aO4SDq3mqaBGCCAuPLefvGkyXMjYQ0k15D4gCQFMcX
 Gh/yABW7NqLTs7cuEJfh2M395HT00M+u8UbQZECg0fTEEMd4dx
 GBOO7XcF8CY/2ZCqPgy5Ay3/B4EBHSRGKONVuf5HSw1JGctZpr
 5h7UiAOMxCGY3vyt+Y9rRFcMDBYQzm7YKZb8Xzzzwla4/+g4w6
 9lZcn9ronVYglQN6y6LwQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211217>

Replace "test_must_fail cvs" with "! cvs"

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
 t/t9402-git-cvsserver-refs.sh | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/t/t9402-git-cvsserver-refs.sh b/t/t9402-git-cvsserver-refs=
=2Esh
index f1bea0f..21000ec 100755
--- a/t/t9402-git-cvsserver-refs.sh
+++ b/t/t9402-git-cvsserver-refs.sh
@@ -156,7 +156,7 @@ test_expect_success 'edit cvswork3 and save diff' '
       rm t2 &&
       cvs -f add adir/afile5 &&
       cvs -f rm t2 &&
-      test_must_fail cvs -f diff -N -u >"$WORKDIR/cvswork3edit.diff"
+      ! cvs -f diff -N -u >"$WORKDIR/cvswork3edit.diff"
     )
 '
=20
@@ -281,7 +281,7 @@ test_expect_success 'cvs co b2 [into cvswork2]' '
 test_expect_success 'root dir edit [cvswork2]' '
     ( cd cvswork2 &&
       echo "Line 2" >> textfile.c &&
-      test_must_fail cvs -f diff -u >"$WORKDIR/cvsEdit1.diff" &&
+      ! cvs -f diff -u >"$WORKDIR/cvsEdit1.diff" &&
       cvs -f commit -m "edit textfile.c" textfile.c
     ) >cvsEdit1.log 2>&1
 '
@@ -290,7 +290,7 @@ test_expect_success 'root dir rm file [cvswork2]' '
     ( cd cvswork2 &&
       cvs -f rm -f t2 &&
       cvs -f diff -u > ../cvsEdit2-empty.diff &&
-      test_must_fail cvs -f diff -N -u >"$WORKDIR/cvsEdit2-N.diff" &&
+      ! cvs -f diff -N -u >"$WORKDIR/cvsEdit2-N.diff" &&
       cvs -f commit -m "rm t2"
     ) > cvsEdit2.log 2>&1
 '
@@ -304,11 +304,11 @@ test_expect_success 'subdir edit/add/rm files [cv=
swork2' '
       cvs -f rm bdir/b2file &&
       echo "4th file" > bdir/b4file &&
       cvs -f add bdir/b4file &&
-      test_must_fail cvs -f diff -N -u >"$WORKDIR/cvsEdit3.diff" &&
+      ! cvs -f diff -N -u >"$WORKDIR/cvsEdit3.diff" &&
       git fetch gitcvs.git b2:b2 &&
       ( cd .. &&
-	test_must_fail cvs -f diff -u -N -r v1.2 >"$WORKDIR/cvsEdit3-v1.2.dif=
f" &&
-	test_must_fail cvs -f diff -u -N -r v1.2 -r v1 >"$WORKDIR/cvsEdit3-v1=
=2E2-v1.diff"
+	! cvs -f diff -u -N -r v1.2 >"$WORKDIR/cvsEdit3-v1.2.diff" &&
+	! cvs -f diff -u -N -r v1.2 -r v1 >"$WORKDIR/cvsEdit3-v1.2-v1.diff"
       ) &&
       cvs -f commit -m "various add/rm/edit"
     ) >cvs.log 2>&1
@@ -468,7 +468,7 @@ test_expect_success 'cvs diff -r v1 -u' '
=20
 test_expect_success 'cvs diff -N -r v2 -u' '
     ( cd cvswork &&
-      test_must_fail cvs -f diff -N -r v2 -u ) >cvsDiff.out 2>cvs.log =
&&
+      ! cvs -f diff -N -r v2 -u ) >cvsDiff.out 2>cvs.log &&
     test ! -s cvs.log &&
     test -s cvsDiff.out &&
     check_diff cvsDiff.out v2 v1 > check_diff.out 2>&1
@@ -476,7 +476,7 @@ test_expect_success 'cvs diff -N -r v2 -u' '
=20
 test_expect_success 'cvs diff -N -r v2 -r v1.2' '
     ( cd cvswork &&
-      test_must_fail cvs -f diff -N -r v2 -r v1.2 -u ) >cvsDiff.out 2>=
cvs.log &&
+      ! cvs -f diff -N -r v2 -r v1.2 -u ) >cvsDiff.out 2>cvs.log &&
     test ! -s cvs.log &&
     test -s cvsDiff.out &&
     check_diff cvsDiff.out v2 v1.2 > check_diff.out 2>&1
@@ -494,7 +494,7 @@ test_expect_success 'apply early [cvswork3] diff to=
 b3' '
=20
 test_expect_success 'check [cvswork3] diff' '
     ( cd cvswork3 &&
-      test_must_fail cvs -f diff -N -u ) >"$WORKDIR/cvsDiff.out" 2>cvs=
=2Elog &&
+      ! cvs -f diff -N -u ) >"$WORKDIR/cvsDiff.out" 2>cvs.log &&
     test ! -s cvs.log &&
     test -s cvsDiff.out &&
     test $(grep Index: cvsDiff.out | wc -l) =3D 3 &&
@@ -517,7 +517,7 @@ test_expect_success 'merge early [cvswork3] b3 with=
 b1' '
 test_expect_success 'cvs up dirty [cvswork3]' '
     ( cd cvswork3 &&
       cvs -f up &&
-      test_must_fail cvs -f diff -N -u >"$WORKDIR/cvsDiff.out" ) >cvs.=
log 2>&1 &&
+      ! cvs -f diff -N -u >"$WORKDIR/cvsDiff.out" ) >cvs.log 2>&1 &&
     test -s cvsDiff.out &&
     test $(grep Index: cvsDiff.out | wc -l) =3D 2
     check_start_tree cvswork3 &&
--=20
1.8.0.197.g5a90748
