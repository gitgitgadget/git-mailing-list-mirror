From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: [PATCH] git-bisect: call the found commit "*the* first bad commit"
Date: Wed, 26 Aug 2009 17:38:50 +0900
Message-ID: <20090826173850.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 26 10:39:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MgE2X-0002cb-So
	for gcvg-git-2@lo.gmane.org; Wed, 26 Aug 2009 10:39:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752562AbZHZIjM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Aug 2009 04:39:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752021AbZHZIjM
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Aug 2009 04:39:12 -0400
Received: from karen.lavabit.com ([72.249.41.33]:42331 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751811AbZHZIjL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Aug 2009 04:39:11 -0400
Received: from e.earth.lavabit.com (e.earth.lavabit.com [192.168.111.14])
	by karen.lavabit.com (Postfix) with ESMTP id 7F97811B887;
	Wed, 26 Aug 2009 03:39:13 -0500 (CDT)
Received: from 9378.lavabit.com (212.62.97.23)
	by lavabit.com with ESMTP id HJFZXRQ85E6Z; Wed, 26 Aug 2009 03:39:13 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=XCtjXrGw6F6bHY7H2YjKyqygxr67l/g1qZWMiYLoNFqrCOf3X5iJkNGlUbGFmJXd5RhiAc9eFR46B6w4qzqo+w4Xhe+l2JCtwQlgIXzRB9Jc9LmVfkaWMC5oRv1h0dL+niBYbwhr/wocTHNU1bGkEKrOlGMbkNauAY5VD5Tbnb8=;
  h=From:To:Cc:Subject:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127069>

.. as we learned in the school ;-)

Signed-off-by: Nanako Shiraishi <nanako3@lavabit.com>
---
 bisect.c                    |    2 +-
 git-bisect.sh               |    2 +-
 t/t6030-bisect-porcelain.sh |   18 +++++++++---------
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/bisect.c b/bisect.c
index 7f20acb..dc18db8 100644
--- a/bisect.c
+++ b/bisect.c
@@ -991,7 +991,7 @@ int bisect_next_all(const char *prefix)
 
 	if (!hashcmp(bisect_rev, current_bad_sha1)) {
 		exit_if_skipped_commits(tried, current_bad_sha1);
-		printf("%s is first bad commit\n", bisect_rev_hex);
+		printf("%s is the first bad commit\n", bisect_rev_hex);
 		show_diff_tree(prefix, revs.commits->item);
 		/* This means the bisection process succeeded. */
 		exit(10);
diff --git a/git-bisect.sh b/git-bisect.sh
index 8969553..6f6f039 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -405,7 +405,7 @@ bisect_run () {
 	  exit $res
       fi
 
-      if grep "is first bad commit" "$GIT_DIR/BISECT_RUN" > /dev/null; then
+      if grep "is the first bad commit" "$GIT_DIR/BISECT_RUN" > /dev/null; then
 	  echo "bisect run success"
 	  exit 0;
       fi
diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index 1315bab..def397c 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -175,7 +175,7 @@ test_expect_success 'bisect skip: successfull result' '
 	git bisect start $HASH4 $HASH1 &&
 	git bisect skip &&
 	git bisect bad > my_bisect_log.txt &&
-	grep "$HASH2 is first bad commit" my_bisect_log.txt &&
+	grep "$HASH2 is the first bad commit" my_bisect_log.txt &&
 	git bisect reset
 '
 
@@ -261,7 +261,7 @@ test_expect_success \
      git bisect good $HASH1 &&
      git bisect bad $HASH4 &&
      git bisect run ./test_script.sh > my_bisect_log.txt &&
-     grep "$HASH3 is first bad commit" my_bisect_log.txt &&
+     grep "$HASH3 is the first bad commit" my_bisect_log.txt &&
      git bisect reset'
 
 # We want to automatically find the commit that
@@ -274,7 +274,7 @@ test_expect_success \
      chmod +x test_script.sh &&
      git bisect start $HASH4 $HASH1 &&
      git bisect run ./test_script.sh > my_bisect_log.txt &&
-     grep "$HASH4 is first bad commit" my_bisect_log.txt &&
+     grep "$HASH4 is the first bad commit" my_bisect_log.txt &&
      git bisect reset'
 
 # $HASH1 is good, $HASH5 is bad, we skip $HASH3
@@ -287,14 +287,14 @@ test_expect_success 'bisect skip: add line and then a new test' '
 	git bisect start $HASH5 $HASH1 &&
 	git bisect skip &&
 	git bisect good > my_bisect_log.txt &&
-	grep "$HASH5 is first bad commit" my_bisect_log.txt &&
+	grep "$HASH5 is the first bad commit" my_bisect_log.txt &&
 	git bisect log > log_to_replay.txt &&
 	git bisect reset
 '
 
 test_expect_success 'bisect skip and bisect replay' '
 	git bisect replay log_to_replay.txt > my_bisect_log.txt &&
-	grep "$HASH5 is first bad commit" my_bisect_log.txt &&
+	grep "$HASH5 is the first bad commit" my_bisect_log.txt &&
 	git bisect reset
 '
 
@@ -335,7 +335,7 @@ test_expect_success 'bisect run & skip: find first bad' '
 	chmod +x test_script.sh &&
 	git bisect start $HASH7 $HASH1 &&
 	git bisect run ./test_script.sh > my_bisect_log.txt &&
-	grep "$HASH6 is first bad commit" my_bisect_log.txt
+	grep "$HASH6 is the first bad commit" my_bisect_log.txt
 '
 
 test_expect_success 'bisect skip only one range' '
@@ -385,7 +385,7 @@ test_expect_success 'bisect does not create a "bisect" branch' '
 	rev_hash6=$(git rev-parse --verify HEAD) &&
 	test "$rev_hash6" = "$HASH6" &&
 	git bisect good > my_bisect_log.txt &&
-	grep "$HASH7 is first bad commit" my_bisect_log.txt &&
+	grep "$HASH7 is the first bad commit" my_bisect_log.txt &&
 	git bisect reset &&
 	rev_hash6=$(git rev-parse --verify bisect) &&
 	test "$rev_hash6" = "$HASH6" &&
@@ -534,7 +534,7 @@ test_expect_success 'restricting bisection on one dir' '
 	para1=$(git rev-parse --verify HEAD) &&
 	test "$para1" = "$PARA_HASH1" &&
 	git bisect bad > my_bisect_log.txt &&
-	grep "$PARA_HASH1 is first bad commit" my_bisect_log.txt
+	grep "$PARA_HASH1 is the first bad commit" my_bisect_log.txt
 '
 
 test_expect_success 'restricting bisection on one dir and a file' '
@@ -552,7 +552,7 @@ test_expect_success 'restricting bisection on one dir and a file' '
 	para1=$(git rev-parse --verify HEAD) &&
 	test "$para1" = "$PARA_HASH1" &&
 	git bisect good > my_bisect_log.txt &&
-	grep "$PARA_HASH4 is first bad commit" my_bisect_log.txt
+	grep "$PARA_HASH4 is the first bad commit" my_bisect_log.txt
 '
 
 test_expect_success 'skipping away from skipped commit' '
-- 
1.6.4.1

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
