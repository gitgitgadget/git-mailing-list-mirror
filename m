From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH] t/: Replace diff [-u|-U0] with test_cmp to allow compilation
 with old diff
Date: Tue, 22 Jul 2008 16:17:43 -0500
Message-ID: <E23rxnPh0xeYPsUuTseZ3Y6bteX3uHIcbLzTlyVPsX_N5fqcvRp1vA@cipher.nrlssc.navy.mil>
References: <0GfECozN3g0ZvAESKMi76RyOVHEb2OhhwET9GWmEm7pbzYQJub50UlWpZtBa7MGn1UGb-7mzbzE@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 22 23:19:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLPGE-00084W-1S
	for gcvg-git-2@gmane.org; Tue, 22 Jul 2008 23:19:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756955AbYGVVSI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2008 17:18:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755286AbYGVVSH
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jul 2008 17:18:07 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:42874 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757432AbYGVVSB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2008 17:18:01 -0400
Received: by mail.nrlssc.navy.mil id m6MLHi4I020704; Tue, 22 Jul 2008 16:17:44 -0500
In-Reply-To: <0GfECozN3g0ZvAESKMi76RyOVHEb2OhhwET9GWmEm7pbzYQJub50UlWpZtBa7MGn1UGb-7mzbzE@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 22 Jul 2008 21:17:44.0148 (UTC) FILETIME=[61B6A140:01C8EC40]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89536>

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---
 t/t0002-gitfile.sh               |    2 +-
 t/t1002-read-tree-m-u-2way.sh    |   12 ++++++------
 t/t2201-add-update-typechange.sh |   10 +++++-----
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/t/t0002-gitfile.sh b/t/t0002-gitfile.sh
index c5dbc72..4db4ac4 100755
--- a/t/t0002-gitfile.sh
+++ b/t/t0002-gitfile.sh
@@ -66,7 +66,7 @@ test_expect_success 'check hash-object' '
 
 test_expect_success 'check cat-file' '
 	git cat-file blob $SHA >actual &&
-	diff -u bar actual
+	test_cmp bar actual
 '
 
 test_expect_success 'check update-index' '
diff --git a/t/t1002-read-tree-m-u-2way.sh b/t/t1002-read-tree-m-u-2way.sh
index e04990e..aa9dd58 100755
--- a/t/t1002-read-tree-m-u-2way.sh
+++ b/t/t1002-read-tree-m-u-2way.sh
@@ -112,7 +112,7 @@ test_expect_success \
      git update-index --add frotz &&
      git read-tree -m -u $treeH $treeM &&
      git ls-files --stage >6.out &&
-     diff -U0 M.out 6.out &&
+     test_cmp M.out 6.out &&
      check_cache_at frotz clean &&
      sum bozbar frotz nitfol >actual3.sum &&
      cmp M.sum actual3.sum &&
@@ -129,7 +129,7 @@ test_expect_success \
      echo frotz frotz >frotz &&
      git read-tree -m -u $treeH $treeM &&
      git ls-files --stage >7.out &&
-     diff -U0 M.out 7.out &&
+     test_cmp M.out 7.out &&
      check_cache_at frotz dirty &&
      sum bozbar frotz nitfol >actual7.sum &&
      if cmp M.sum actual7.sum; then false; else :; fi &&
@@ -264,7 +264,7 @@ test_expect_success \
      git update-index --add bozbar &&
      git read-tree -m -u $treeH $treeM &&
      git ls-files --stage >18.out &&
-     diff -U0 M.out 18.out &&
+     test_cmp M.out 18.out &&
      check_cache_at bozbar clean &&
      sum bozbar frotz nitfol >actual18.sum &&
      cmp M.sum actual18.sum'
@@ -278,7 +278,7 @@ test_expect_success \
      echo gnusto gnusto >bozbar &&
      git read-tree -m -u $treeH $treeM &&
      git ls-files --stage >19.out &&
-     diff -U0 M.out 19.out &&
+     test_cmp M.out 19.out &&
      check_cache_at bozbar dirty &&
      sum frotz nitfol >actual19.sum &&
      grep -v bozbar  M.sum > expected19.sum &&
@@ -297,7 +297,7 @@ test_expect_success \
      git update-index --add bozbar &&
      git read-tree -m -u $treeH $treeM &&
      git ls-files --stage >20.out &&
-     diff -U0 M.out 20.out &&
+     test_cmp M.out 20.out &&
      check_cache_at bozbar clean &&
      sum bozbar frotz nitfol >actual20.sum &&
      cmp M.sum actual20.sum'
@@ -338,7 +338,7 @@ test_expect_success \
      git update-index --add DF &&
      git read-tree -m -u $treeDF $treeDFDF &&
      git ls-files --stage >DFDFcheck.out &&
-     diff -U0 DFDF.out DFDFcheck.out &&
+     test_cmp DFDF.out DFDFcheck.out &&
      check_cache_at DF/DF clean'
 
 test_done
diff --git a/t/t2201-add-update-typechange.sh b/t/t2201-add-update-typechange.sh
index e15e3eb..d24c7d9 100755
--- a/t/t2201-add-update-typechange.sh
+++ b/t/t2201-add-update-typechange.sh
@@ -106,12 +106,12 @@ test_expect_success modify '
 
 test_expect_success diff-files '
 	git diff-files --raw >actual &&
-	diff -u expect-files actual
+	test_cmp expect-files actual
 '
 
 test_expect_success diff-index '
 	git diff-index --raw HEAD -- >actual &&
-	diff -u expect-index actual
+	test_cmp expect-index actual
 '
 
 test_expect_success 'add -u' '
@@ -119,7 +119,7 @@ test_expect_success 'add -u' '
 	cp -p ".git/index" ".git/saved-index" &&
 	git add -u &&
 	git ls-files -s >actual &&
-	diff -u expect-final actual
+	test_cmp expect-final actual
 '
 
 test_expect_success 'commit -a' '
@@ -130,11 +130,11 @@ test_expect_success 'commit -a' '
 	fi &&
 	git commit -m "second" -a &&
 	git ls-files -s >actual &&
-	diff -u expect-final actual &&
+	test_cmp expect-final actual &&
 	rm -f .git/index &&
 	git read-tree HEAD &&
 	git ls-files -s >actual &&
-	diff -u expect-final actual
+	test_cmp expect-final actual
 '
 
 test_done
-- 
1.6.0.rc0.38.g8b8fb7
