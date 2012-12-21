From: Martin von Zweigbergk <martinvonz@gmail.com>
Subject: [PATCH 1/2] tests: move test_cmp_rev to test-lib-functions
Date: Fri, 21 Dec 2012 11:10:10 -0800
Message-ID: <1356117013-20613-1-git-send-email-martinvonz@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Martin von Zweigbergk <martinvonz@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 21 20:10:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tm7zV-0005mS-5x
	for gcvg-git-2@plane.gmane.org; Fri, 21 Dec 2012 20:10:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752052Ab2LUTKY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Dec 2012 14:10:24 -0500
Received: from mail-vb0-f74.google.com ([209.85.212.74]:51703 "EHLO
	mail-vb0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752016Ab2LUTKW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Dec 2012 14:10:22 -0500
Received: by mail-vb0-f74.google.com with SMTP id s24so508815vbi.1
        for <git@vger.kernel.org>; Fri, 21 Dec 2012 11:10:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer
         :x-gm-message-state;
        bh=NDKJsOIY10SWRLjMC6gv4zjGuHHfBGv75WNvkBEBYmc=;
        b=bmq0W7TB2wQALSv3ERt3oP8I8mtcpqreqd88GYnIqeBb9yWnzs2731+1kxah63TAb0
         K3GWXwocbXClwnOYdpXHjxR7adEMoPHCPsg3p8oUYxyHnxCe2MKVbQI26ZPoA4/CWCm8
         KYYYPCcN+TTo8wng8+kH9awR9cDllS5MECSqZm0quMicCWYMSI0y9n4TL3FVAPj12QKQ
         SuEJk7cypKkEhkWrtZsEtoIQii2tt+8lpqIPLmcuwF09ZPoHVAUumLTA2yLTr8rZXzOo
         UGRb6wiZw5iLIaB8kcHLwHG2AInqXzy11n1fsiYPpE4SlzTGW18YrCtdUmA5BORIdg5Q
         ze3w==
X-Received: by 10.236.116.10 with SMTP id f10mr5966126yhh.9.1356117020361;
        Fri, 21 Dec 2012 11:10:20 -0800 (PST)
Received: from wpzn3.hot.corp.google.com (216-239-44-65.google.com [216.239.44.65])
        by gmr-mx.google.com with ESMTPS id r10si605185ann.1.2012.12.21.11.10.20
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Fri, 21 Dec 2012 11:10:20 -0800 (PST)
Received: from handduk2.mtv.corp.google.com (handduk2.mtv.corp.google.com [172.18.144.137])
	by wpzn3.hot.corp.google.com (Postfix) with ESMTP id 22AAC10004D;
	Fri, 21 Dec 2012 11:10:20 -0800 (PST)
Received: by handduk2.mtv.corp.google.com (Postfix, from userid 151024)
	id 8D46E101386; Fri, 21 Dec 2012 11:10:19 -0800 (PST)
X-Mailer: git-send-email 1.8.0.1.240.ge8a1f5a
X-Gm-Message-State: ALoCoQnq4ds4KAkf+zFtWtfd767kb0Kjutdm7ihUUnMa8VrY3pfw2QBZc1GdUAWVHKPKALY/clq8BZNgRykeEhWnBOE8GxWe8EBLm/QuLMZ+ejd2M7vBUSl9KhqqexEGU/WazLlvmyfHHbukBY4mlJn8Lp3SUuf67fnUcSa4fFstwZlKLiAuv8DSUN6vma3/uHFMss+xlH87
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212004>

A function for checking that two given parameters refer to the same
revision was defined in several places, so move the definition to
test-lib-functions.sh instead.

Signed-off-by: Martin von Zweigbergk <martinvonz@gmail.com>
---
 t/t1505-rev-parse-last.sh           | 18 +++++-------------
 t/t3404-rebase-interactive.sh       |  6 ------
 t/t3507-cherry-pick-conflict.sh     |  6 ------
 t/t3508-cherry-pick-many-commits.sh |  8 ++------
 t/t3510-cherry-pick-sequence.sh     |  6 ------
 t/t6030-bisect-porcelain.sh         |  4 +---
 t/test-lib-functions.sh             |  7 +++++++
 7 files changed, 15 insertions(+), 40 deletions(-)

diff --git a/t/t1505-rev-parse-last.sh b/t/t1505-rev-parse-last.sh
index d709ecf..4969edb 100755
--- a/t/t1505-rev-parse-last.sh
+++ b/t/t1505-rev-parse-last.sh
@@ -32,32 +32,24 @@ test_expect_success 'setup' '
 #
 # and 'side' should be the last branch
 
-test_rev_equivalent () {
-
-	git rev-parse "$1" > expect &&
-	git rev-parse "$2" > output &&
-	test_cmp expect output
-
-}
-
 test_expect_success '@{-1} works' '
-	test_rev_equivalent side @{-1}
+	test_cmp_rev side @{-1}
 '
 
 test_expect_success '@{-1}~2 works' '
-	test_rev_equivalent side~2 @{-1}~2
+	test_cmp_rev side~2 @{-1}~2
 '
 
 test_expect_success '@{-1}^2 works' '
-	test_rev_equivalent side^2 @{-1}^2
+	test_cmp_rev side^2 @{-1}^2
 '
 
 test_expect_success '@{-1}@{1} works' '
-	test_rev_equivalent side@{1} @{-1}@{1}
+	test_cmp_rev side@{1} @{-1}@{1}
 '
 
 test_expect_success '@{-2} works' '
-	test_rev_equivalent master @{-2}
+	test_cmp_rev master @{-2}
 '
 
 test_expect_success '@{-3} fails' '
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 32fdc99..8462be1 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -29,12 +29,6 @@ Initial setup:
 
 . "$TEST_DIRECTORY"/lib-rebase.sh
 
-test_cmp_rev () {
-	git rev-parse --verify "$1" >expect.rev &&
-	git rev-parse --verify "$2" >actual.rev &&
-	test_cmp expect.rev actual.rev
-}
-
 set_fake_editor
 
 # WARNING: Modifications to the initial repository can change the SHA ID used
diff --git a/t/t3507-cherry-pick-conflict.sh b/t/t3507-cherry-pick-conflict.sh
index c82f721..223b984 100755
--- a/t/t3507-cherry-pick-conflict.sh
+++ b/t/t3507-cherry-pick-conflict.sh
@@ -11,12 +11,6 @@ test_description='test cherry-pick and revert with conflicts
 
 . ./test-lib.sh
 
-test_cmp_rev () {
-	git rev-parse --verify "$1" >expect.rev &&
-	git rev-parse --verify "$2" >actual.rev &&
-	test_cmp expect.rev actual.rev
-}
-
 pristine_detach () {
 	git checkout -f "$1^0" &&
 	git read-tree -u --reset HEAD &&
diff --git a/t/t3508-cherry-pick-many-commits.sh b/t/t3508-cherry-pick-many-commits.sh
index 340afc7..4e7136b 100755
--- a/t/t3508-cherry-pick-many-commits.sh
+++ b/t/t3508-cherry-pick-many-commits.sh
@@ -5,15 +5,11 @@ test_description='test cherry-picking many commits'
 . ./test-lib.sh
 
 check_head_differs_from() {
-	head=$(git rev-parse --verify HEAD) &&
-	arg=$(git rev-parse --verify "$1") &&
-	test "$head" != "$arg"
+	! test_cmp_rev HEAD "$1"
 }
 
 check_head_equals() {
-	head=$(git rev-parse --verify HEAD) &&
-	arg=$(git rev-parse --verify "$1") &&
-	test "$head" = "$arg"
+	test_cmp_rev HEAD "$1"
 }
 
 test_expect_success setup '
diff --git a/t/t3510-cherry-pick-sequence.sh b/t/t3510-cherry-pick-sequence.sh
index b5fb527..7b7a89d 100755
--- a/t/t3510-cherry-pick-sequence.sh
+++ b/t/t3510-cherry-pick-sequence.sh
@@ -24,12 +24,6 @@ pristine_detach () {
 	git clean -d -f -f -q -x
 }
 
-test_cmp_rev () {
-	git rev-parse --verify "$1" >expect.rev &&
-	git rev-parse --verify "$2" >actual.rev &&
-	test_cmp expect.rev actual.rev
-}
-
 test_expect_success setup '
 	git config advice.detachedhead false &&
 	echo unrelated >unrelated &&
diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index 72e28ee..3e0e15f 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -676,9 +676,7 @@ test_expect_success 'bisect fails if tree is broken on trial commit' '
 check_same()
 {
 	echo "Checking $1 is the same as $2" &&
-	git rev-parse "$1" > expected.same &&
-	git rev-parse "$2" > expected.actual &&
-	test_cmp expected.same expected.actual
+	test_cmp_rev "$1" "$2"
 }
 
 test_expect_success 'bisect: --no-checkout - start commit bad' '
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 22a4f8f..fa62d01 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -602,6 +602,13 @@ test_cmp() {
 	$GIT_TEST_CMP "$@"
 }
 
+# Tests that its two parameters refer to the same revision
+test_cmp_rev () {
+	git rev-parse --verify "$1" >expect.rev &&
+	git rev-parse --verify "$2" >actual.rev &&
+	test_cmp expect.rev actual.rev
+}
+
 # Print a sequence of numbers or letters in increasing order.  This is
 # similar to GNU seq(1), but the latter might not be available
 # everywhere (and does not do letters).  It may be used like:
-- 
1.8.0.1.240.ge8a1f5a
