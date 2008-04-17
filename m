From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 5/5] Use test_cmp instead of diff -u in the test suite
Date: Thu, 17 Apr 2008 23:13:10 +0200
Message-ID: <20080417211310.12809.2112.stgit@yoghurt>
References: <20080417210137.12809.88457.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 17 23:29:26 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JmbQs-0005C6-Vy
	for gcvg-git-2@gmane.org; Thu, 17 Apr 2008 23:14:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753899AbYDQVNR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Apr 2008 17:13:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753711AbYDQVNQ
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Apr 2008 17:13:16 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4512 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753454AbYDQVNP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Apr 2008 17:13:15 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1JmbPp-0003eO-00; Thu, 17 Apr 2008 22:13:10 +0100
In-Reply-To: <20080417210137.12809.88457.stgit@yoghurt>
User-Agent: StGIT/0.14.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79828>

Since diff -u isn't available everywhere, and the user might want to
use something else.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 t/t0002-status.sh        |   32 ++++++++++++++++----------------
 t/t1201-pull-trailing.sh |    2 +-
 t/t2700-refresh.sh       |   12 ++++++------
 t/t2800-goto-subdir.sh   |    8 ++++----
 4 files changed, 27 insertions(+), 27 deletions(-)


diff --git a/t/t0002-status.sh b/t/t0002-status.sh
index 0a70f15..4364709 100755
--- a/t/t0002-status.sh
+++ b/t/t0002-status.sh
@@ -20,7 +20,7 @@ cat > expected.txt <<EOF
 EOF
 test_expect_success 'Run status on empty' '
     stg status > output.txt &&
-    diff -u expected.txt output.txt
+    test_cmp expected.txt output.txt
 '
=20
 cat > expected.txt <<EOF
@@ -29,7 +29,7 @@ EOF
 test_expect_success 'Status with an untracked file' '
     touch foo &&
     stg status > output.txt &&
-    diff -u expected.txt output.txt
+    test_cmp expected.txt output.txt
 '
 rm -f foo
=20
@@ -38,7 +38,7 @@ EOF
 test_expect_success 'Status with an empty directory' '
     mkdir foo &&
     stg status > output.txt &&
-    diff -u expected.txt output.txt
+    test_cmp expected.txt output.txt
 '
=20
 cat > expected.txt <<EOF
@@ -47,7 +47,7 @@ EOF
 test_expect_success 'Status with an untracked file in a subdir' '
     touch foo/bar &&
     stg status > output.txt &&
-    diff -u expected.txt output.txt
+    test_cmp expected.txt output.txt
 '
=20
 cat > expected.txt <<EOF
@@ -56,7 +56,7 @@ EOF
 test_expect_success 'Status with an added file' '
     git add foo &&
     stg status > output.txt &&
-    diff -u expected.txt output.txt
+    test_cmp expected.txt output.txt
 '
=20
 cat > expected.txt <<EOF
@@ -64,7 +64,7 @@ foo/bar
 EOF
 test_expect_success 'Status with an added file and -n option' '
     stg status -n > output.txt &&
-    diff -u expected.txt output.txt
+    test_cmp expected.txt output.txt
 '
=20
 cat > expected.txt <<EOF
@@ -73,7 +73,7 @@ test_expect_success 'Status after refresh' '
     stg new -m "first patch" &&
     stg refresh &&
     stg status > output.txt &&
-    diff -u expected.txt output.txt
+    test_cmp expected.txt output.txt
 '
=20
 cat > expected.txt <<EOF
@@ -82,7 +82,7 @@ EOF
 test_expect_success 'Status after modification' '
     echo "wee" >> foo/bar &&
     stg status > output.txt &&
-    diff -u expected.txt output.txt
+    test_cmp expected.txt output.txt
 '
=20
 cat > expected.txt <<EOF
@@ -90,7 +90,7 @@ EOF
 test_expect_success 'Status after refresh' '
     stg new -m "second patch" && stg refresh &&
     stg status > output.txt &&
-    diff -u expected.txt output.txt
+    test_cmp expected.txt output.txt
 '
=20
 test_expect_success 'Add another file' '
@@ -116,7 +116,7 @@ EOF
 test_expect_success 'Status after conflicting push' '
     ! stg push &&
     stg status > output.txt &&
-    diff -u expected.txt output.txt
+    test_cmp expected.txt output.txt
 '
=20
 cat > expected.txt <<EOF
@@ -124,7 +124,7 @@ C foo/bar
 EOF
 test_expect_success 'Status of file' '
     stg status foo/bar > output.txt &&
-    diff -u expected.txt output.txt
+    test_cmp expected.txt output.txt
 '
=20
 cat > expected.txt <<EOF
@@ -132,7 +132,7 @@ C foo/bar
 EOF
 test_expect_success 'Status of dir' '
     stg status foo > output.txt &&
-    diff -u expected.txt output.txt
+    test_cmp expected.txt output.txt
 '
=20
 cat > expected.txt <<EOF
@@ -140,7 +140,7 @@ A fie
 EOF
 test_expect_success 'Status of other file' '
     stg status fie > output.txt &&
-    diff -u expected.txt output.txt
+    test_cmp expected.txt output.txt
 '
=20
 cat > expected.txt <<EOF
@@ -150,7 +150,7 @@ EOF
 test_expect_success 'Status after resolving the push' '
     stg resolved -a &&
     stg status > output.txt &&
-    diff -u expected.txt output.txt
+    test_cmp expected.txt output.txt
 '
=20
 cat > expected.txt <<EOF
@@ -160,7 +160,7 @@ EOF
 test_expect_success 'Status after deleting a file' '
     rm foo/bar &&
     stg status > output.txt &&
-    diff -u expected.txt output.txt
+    test_cmp expected.txt output.txt
 '
=20
 cat > expected.txt <<EOF
@@ -172,7 +172,7 @@ test_expect_success 'Status of disappeared newborn'=
 '
     git add foo/bar &&
     rm foo/bar &&
     stg status > output.txt &&
-    diff -u expected.txt output.txt
+    test_cmp expected.txt output.txt
 '
=20
 test_done
diff --git a/t/t1201-pull-trailing.sh b/t/t1201-pull-trailing.sh
index 46d9f82..9d70fe0 100755
--- a/t/t1201-pull-trailing.sh
+++ b/t/t1201-pull-trailing.sh
@@ -55,7 +55,7 @@ test_expect_success \
=20
 test_expect_success \
     'Check that all went well' \
-    "diff -u foo/file bar/file
+    "test_cmp foo/file bar/file
 "
=20
 test_done
diff --git a/t/t2700-refresh.sh b/t/t2700-refresh.sh
index 9eae85d..3759d0e 100755
--- a/t/t2700-refresh.sh
+++ b/t/t2700-refresh.sh
@@ -33,7 +33,7 @@ test_expect_success 'Refresh top patch' '
     stg status &&
     test -z "$(stg status)" &&
     stg patches foo3.txt > patches.txt &&
-    diff -u expected.txt patches.txt
+    test_cmp expected.txt patches.txt
 '
=20
 cat > expected.txt <<EOF
@@ -47,7 +47,7 @@ test_expect_success 'Refresh middle patch' '
     stg status &&
     test -z "$(stg status)" &&
     stg patches foo2.txt > patches.txt &&
-    diff -u expected.txt patches.txt
+    test_cmp expected.txt patches.txt
 '
=20
 cat > expected.txt <<EOF
@@ -61,7 +61,7 @@ test_expect_success 'Refresh bottom patch' '
     stg status &&
     test -z "$(stg status)" &&
     stg patches foo1.txt > patches.txt &&
-    diff -u expected.txt patches.txt
+    test_cmp expected.txt patches.txt
 '
=20
 cat > expected.txt <<EOF
@@ -111,9 +111,9 @@ test_expect_success 'Refresh --index' '
     stg patches foo1.txt > patches.txt &&
     git diff HEAD^..HEAD > show.txt &&
     stg diff > diff.txt &&
-    diff -u expected.txt patches.txt &&
-    diff -u expected2.txt show.txt &&
-    diff -u expected3.txt diff.txt &&
+    test_cmp expected.txt patches.txt &&
+    test_cmp expected2.txt show.txt &&
+    test_cmp expected3.txt diff.txt &&
     stg new p5 -m "cleanup again" &&
     stg refresh
 '
diff --git a/t/t2800-goto-subdir.sh b/t/t2800-goto-subdir.sh
index fcad7da..28b8292 100755
--- a/t/t2800-goto-subdir.sh
+++ b/t/t2800-goto-subdir.sh
@@ -27,9 +27,9 @@ EOF
 test_expect_success 'Goto in subdirectory (just pop)' '
     (cd foo && stg goto p1) &&
     cat foo/bar > actual.txt &&
-    diff -u expected1.txt actual.txt &&
+    test_cmp expected1.txt actual.txt &&
     ls foo > actual.txt &&
-    diff -u expected2.txt actual.txt
+    test_cmp expected2.txt actual.txt
 '
=20
 test_expect_success 'Prepare conflicting goto' '
@@ -51,9 +51,9 @@ test_expect_success 'Goto in subdirectory (conflictin=
g push)' '
     (cd foo && stg goto p3) ;
     [ $? -eq 3 ] &&
     cat foo/bar > actual.txt &&
-    diff -u expected1.txt actual.txt &&
+    test_cmp expected1.txt actual.txt &&
     ls foo > actual.txt &&
-    diff -u expected2.txt actual.txt
+    test_cmp expected2.txt actual.txt
 '
=20
 test_done
