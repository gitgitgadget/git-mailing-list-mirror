Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 157631FAED
	for <e@80x24.org>; Fri, 27 Oct 2017 15:06:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751980AbdJ0PGu (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Oct 2017 11:06:50 -0400
Received: from a7-19.smtp-out.eu-west-1.amazonses.com ([54.240.7.19]:37526
        "EHLO a7-19.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751587AbdJ0PGj (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 27 Oct 2017 11:06:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=shh3fegwg5fppqsuzphvschd53n6ihuv; d=amazonses.com; t=1509116798;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=/iWSlrVsoBkp2huVcRAandR0kHb3bZoZr9tqrW02axE=;
        b=CQ91xUmboKH8yht3iAePqvceO8tsW4YBcNPKr+UvcVrmSqj42D9EMnPcDasjUVw5
        fGsT653/7lbKuUmV7QunBZqbEcmOquuS/ewRq7If3ZgzIGKt/qTIpLnhPTcvA/Mjmrr
        0KubBh+CXNLos1TONC8grUSSJbsnWTaJCO46e8qU=
From:   Pranit Bauva <pranit.bauva@gmail.com>
To:     git@vger.kernel.org
Message-ID: <0102015f5e5ee2f8-9c3b0a3a-ba4f-4a50-8791-69fa5e336b7e-000000@eu-west-1.amazonses.com>
In-Reply-To: <0102015f5e5ee171-f30f4868-886f-47a1-a4e4-b4936afc545d-000000@eu-west-1.amazonses.com>
References: <0102015f5e5ee171-f30f4868-886f-47a1-a4e4-b4936afc545d-000000@eu-west-1.amazonses.com>
Subject: [PATCH v16 Part II 8/8] t6030: make various test to pass
 GETTEXT_POISON tests
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Fri, 27 Oct 2017 15:06:37 +0000
X-SES-Outgoing: 2017.10.27-54.240.7.19
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
---
 t/t6030-bisect-porcelain.sh | 120 ++++++++++++++++++++++----------------------
 1 file changed, 60 insertions(+), 60 deletions(-)

diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index 55835ee4a4715..f9e61c6540e57 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -133,21 +133,21 @@ test_expect_success 'bisect reset removes bisect state after --no-checkout' '
 
 test_expect_success 'bisect start: back in good branch' '
 	git branch > branch.output &&
-	grep "* other" branch.output > /dev/null &&
+	test_i18ngrep "* other" branch.output > /dev/null &&
 	git bisect start $HASH4 $HASH1 -- &&
 	git bisect good &&
 	git bisect start $HASH4 $HASH1 -- &&
 	git bisect bad &&
 	git bisect reset &&
 	git branch > branch.output &&
-	grep "* other" branch.output > /dev/null
+	test_i18ngrep "* other" branch.output > /dev/null
 '
 
 test_expect_success 'bisect start: no ".git/BISECT_START" created if junk rev' '
 	git bisect reset &&
 	test_must_fail git bisect start $HASH4 foo -- &&
 	git branch > branch.output &&
-	grep "* other" branch.output > /dev/null &&
+	test_i18ngrep "* other" branch.output > /dev/null &&
 	test_must_fail test -e .git/BISECT_START
 '
 
@@ -158,14 +158,14 @@ test_expect_success 'bisect start: existing ".git/BISECT_START" not modified if
 	test_must_fail git bisect start $HASH4 foo -- &&
 	git branch > branch.output &&
 	test_i18ngrep "* (no branch, bisect started on other)" branch.output > /dev/null &&
-	test_cmp saved .git/BISECT_START
+	test_i18ncmp saved .git/BISECT_START
 '
 test_expect_success 'bisect start: no ".git/BISECT_START" if mistaken rev' '
 	git bisect start $HASH4 $HASH1 -- &&
 	git bisect good &&
 	test_must_fail git bisect start $HASH1 $HASH4 -- &&
 	git branch > branch.output &&
-	grep "* other" branch.output > /dev/null &&
+	test_i18ngrep "* other" branch.output > /dev/null &&
 	test_must_fail test -e .git/BISECT_START
 '
 
@@ -174,7 +174,7 @@ test_expect_success 'bisect start: no ".git/BISECT_START" if checkout error' '
 	test_must_fail git bisect start $HASH4 $HASH1 -- &&
 	git branch &&
 	git branch > branch.output &&
-	grep "* other" branch.output > /dev/null &&
+	test_i18ngrep "* other" branch.output > /dev/null &&
 	test_must_fail test -e .git/BISECT_START &&
 	test -z "$(git for-each-ref "refs/bisect/*")" &&
 	git checkout HEAD hello
@@ -189,7 +189,7 @@ test_expect_success 'bisect skip: successful result' '
 	git bisect start $HASH4 $HASH1 &&
 	git bisect skip &&
 	git bisect bad > my_bisect_log.txt &&
-	grep "$HASH2 is the first bad commit" my_bisect_log.txt
+	test_i18ngrep "$HASH2 is the first bad commit" my_bisect_log.txt
 '
 
 # $HASH1 is good, $HASH4 is bad, we skip $HASH3 and $HASH2
@@ -200,11 +200,11 @@ test_expect_success 'bisect skip: cannot tell between 3 commits' '
 	git bisect start $HASH4 $HASH1 &&
 	git bisect skip &&
 	test_expect_code 2 git bisect skip >my_bisect_log.txt &&
-	grep "first bad commit could be any of" my_bisect_log.txt &&
+	test_i18ngrep "first bad commit could be any of" my_bisect_log.txt &&
 	! grep $HASH1 my_bisect_log.txt &&
-	grep $HASH2 my_bisect_log.txt &&
-	grep $HASH3 my_bisect_log.txt &&
-	grep $HASH4 my_bisect_log.txt
+	test_i18ngrep $HASH2 my_bisect_log.txt &&
+	test_i18ngrep $HASH3 my_bisect_log.txt &&
+	test_i18ngrep $HASH4 my_bisect_log.txt
 '
 
 # $HASH1 is good, $HASH4 is bad, we skip $HASH3
@@ -216,11 +216,11 @@ test_expect_success 'bisect skip: cannot tell between 2 commits' '
 	git bisect start $HASH4 $HASH1 &&
 	git bisect skip &&
 	test_expect_code 2 git bisect good >my_bisect_log.txt &&
-	grep "first bad commit could be any of" my_bisect_log.txt &&
+	test_i18ngrep "first bad commit could be any of" my_bisect_log.txt &&
 	! grep $HASH1 my_bisect_log.txt &&
 	! grep $HASH2 my_bisect_log.txt &&
-	grep $HASH3 my_bisect_log.txt &&
-	grep $HASH4 my_bisect_log.txt
+	test_i18ngrep $HASH3 my_bisect_log.txt &&
+	test_i18ngrep $HASH4 my_bisect_log.txt
 '
 
 # $HASH1 is good, $HASH4 is both skipped and bad, we skip $HASH3
@@ -235,11 +235,11 @@ test_expect_success 'bisect skip: with commit both bad and skipped' '
 	git bisect good $HASH1 &&
 	git bisect skip &&
 	test_expect_code 2 git bisect good >my_bisect_log.txt &&
-	grep "first bad commit could be any of" my_bisect_log.txt &&
+	test_i18ngrep "first bad commit could be any of" my_bisect_log.txt &&
 	! grep $HASH1 my_bisect_log.txt &&
-	! grep $HASH2 my_bisect_log.txt &&
-	grep $HASH3 my_bisect_log.txt &&
-	grep $HASH4 my_bisect_log.txt
+	! rep $HASH2 my_bisect_log.txt &&
+	test_i18ngrep $HASH3 my_bisect_log.txt &&
+	test_i18ngrep $HASH4 my_bisect_log.txt
 '
 
 # We want to automatically find the commit that
@@ -254,7 +254,7 @@ test_expect_success \
      git bisect good $HASH1 &&
      git bisect bad $HASH4 &&
      git bisect run ./test_script.sh > my_bisect_log.txt &&
-     grep "$HASH3 is the first bad commit" my_bisect_log.txt &&
+     test_i18ngrep "$HASH3 is the first bad commit" my_bisect_log.txt &&
      git bisect reset'
 
 # We want to automatically find the commit that
@@ -267,7 +267,7 @@ test_expect_success \
      chmod +x test_script.sh &&
      git bisect start $HASH4 $HASH1 &&
      git bisect run ./test_script.sh > my_bisect_log.txt &&
-     grep "$HASH4 is the first bad commit" my_bisect_log.txt &&
+     test_i18ngrep "$HASH4 is the first bad commit" my_bisect_log.txt &&
      git bisect reset'
 
 # $HASH1 is good, $HASH5 is bad, we skip $HASH3
@@ -280,14 +280,14 @@ test_expect_success 'bisect skip: add line and then a new test' '
 	git bisect start $HASH5 $HASH1 &&
 	git bisect skip &&
 	git bisect good > my_bisect_log.txt &&
-	grep "$HASH5 is the first bad commit" my_bisect_log.txt &&
+	test_i18ngrep "$HASH5 is the first bad commit" my_bisect_log.txt &&
 	git bisect log > log_to_replay.txt &&
 	git bisect reset
 '
 
 test_expect_success 'bisect skip and bisect replay' '
 	git bisect replay log_to_replay.txt > my_bisect_log.txt &&
-	grep "$HASH5 is the first bad commit" my_bisect_log.txt &&
+	test_i18ngrep "$HASH5 is the first bad commit" my_bisect_log.txt &&
 	git bisect reset
 '
 
@@ -307,11 +307,11 @@ test_expect_success 'bisect run & skip: cannot tell between 2' '
 		false
 	else
 		test $? -eq 2 &&
-		grep "first bad commit could be any of" my_bisect_log.txt &&
+		test_i18ngrep "first bad commit could be any of" my_bisect_log.txt &&
 		! grep $HASH3 my_bisect_log.txt &&
 		! grep $HASH6 my_bisect_log.txt &&
-		grep $HASH4 my_bisect_log.txt &&
-		grep $HASH5 my_bisect_log.txt
+		test_i18ngrep $HASH4 my_bisect_log.txt &&
+		test_i18ngrep $HASH5 my_bisect_log.txt
 	fi
 '
 
@@ -328,7 +328,7 @@ test_expect_success 'bisect run & skip: find first bad' '
 	chmod +x test_script.sh &&
 	git bisect start $HASH7 $HASH1 &&
 	git bisect run ./test_script.sh > my_bisect_log.txt &&
-	grep "$HASH6 is the first bad commit" my_bisect_log.txt
+	test_i18ngrep "$HASH6 is the first bad commit" my_bisect_log.txt
 '
 
 test_expect_success 'bisect skip only one range' '
@@ -337,7 +337,7 @@ test_expect_success 'bisect skip only one range' '
 	git bisect skip $HASH1..$HASH5 &&
 	test "$HASH6" = "$(git rev-parse --verify HEAD)" &&
 	test_must_fail git bisect bad > my_bisect_log.txt &&
-	grep "first bad commit could be any of" my_bisect_log.txt
+	test_i18ngrep "first bad commit could be any of" my_bisect_log.txt
 '
 
 test_expect_success 'bisect skip many ranges' '
@@ -346,7 +346,7 @@ test_expect_success 'bisect skip many ranges' '
 	git bisect skip $HASH2 $HASH2.. ..$HASH5 &&
 	test "$HASH6" = "$(git rev-parse --verify HEAD)" &&
 	test_must_fail git bisect bad > my_bisect_log.txt &&
-	grep "first bad commit could be any of" my_bisect_log.txt
+	test_i18ngrep "first bad commit could be any of" my_bisect_log.txt
 '
 
 test_expect_success 'bisect starting with a detached HEAD' '
@@ -378,7 +378,7 @@ test_expect_success 'bisect does not create a "bisect" branch' '
 	rev_hash6=$(git rev-parse --verify HEAD) &&
 	test "$rev_hash6" = "$HASH6" &&
 	git bisect good > my_bisect_log.txt &&
-	grep "$HASH7 is the first bad commit" my_bisect_log.txt &&
+	test_i18ngrep "$HASH7 is the first bad commit" my_bisect_log.txt &&
 	git bisect reset &&
 	rev_hash6=$(git rev-parse --verify bisect) &&
 	test "$rev_hash6" = "$HASH6" &&
@@ -405,26 +405,26 @@ test_expect_success 'side branch creation' '
 test_expect_success 'good merge base when good and bad are siblings' '
 	git bisect start "$HASH7" "$SIDE_HASH7" > my_bisect_log.txt &&
 	test_i18ngrep "merge base must be tested" my_bisect_log.txt &&
-	grep $HASH4 my_bisect_log.txt &&
+	test_i18ngrep $HASH4 my_bisect_log.txt &&
 	git bisect good > my_bisect_log.txt &&
 	! grep "merge base must be tested" my_bisect_log.txt &&
-	grep $HASH6 my_bisect_log.txt &&
+	test_i18ngrep $HASH6 my_bisect_log.txt &&
 	git bisect reset
 '
 test_expect_success 'skipped merge base when good and bad are siblings' '
 	git bisect start "$SIDE_HASH7" "$HASH7" > my_bisect_log.txt &&
 	test_i18ngrep "merge base must be tested" my_bisect_log.txt &&
-	grep $HASH4 my_bisect_log.txt &&
+	test_i18ngrep $HASH4 my_bisect_log.txt &&
 	git bisect skip > my_bisect_log.txt 2>&1 &&
-	grep "warning" my_bisect_log.txt &&
-	grep $SIDE_HASH6 my_bisect_log.txt &&
+	test_i18ngrep "warning" my_bisect_log.txt &&
+	test_i18ngrep $SIDE_HASH6 my_bisect_log.txt &&
 	git bisect reset
 '
 
 test_expect_success 'bad merge base when good and bad are siblings' '
 	git bisect start "$HASH7" HEAD > my_bisect_log.txt &&
 	test_i18ngrep "merge base must be tested" my_bisect_log.txt &&
-	grep $HASH4 my_bisect_log.txt &&
+	test_i18ngrep $HASH4 my_bisect_log.txt &&
 	test_must_fail git bisect bad > my_bisect_log.txt 2>&1 &&
 	test_i18ngrep "merge base $HASH4 is bad" my_bisect_log.txt &&
 	test_i18ngrep "fixed between $HASH4 and \[$SIDE_HASH7\]" my_bisect_log.txt &&
@@ -454,8 +454,8 @@ test_expect_success 'many merge bases creation' '
 	B_HASH=$(git rev-parse --verify HEAD) &&
 	git merge-base --all "$A_HASH" "$B_HASH" > merge_bases.txt &&
 	test_line_count = 2 merge_bases.txt &&
-	grep "$HASH5" merge_bases.txt &&
-	grep "$SIDE_HASH5" merge_bases.txt
+	test_i18ngrep "$HASH5" merge_bases.txt &&
+	test_i18ngrep "$SIDE_HASH5" merge_bases.txt
 '
 
 test_expect_success 'good merge bases when good and bad are siblings' '
@@ -465,11 +465,11 @@ test_expect_success 'good merge bases when good and bad are siblings' '
 	test_i18ngrep "merge base must be tested" my_bisect_log2.txt &&
 	{
 		{
-			grep "$SIDE_HASH5" my_bisect_log.txt &&
-			grep "$HASH5" my_bisect_log2.txt
+			test_i18ngrep "$SIDE_HASH5" my_bisect_log.txt &&
+			test_i18ngrep "$HASH5" my_bisect_log2.txt
 		} || {
-			grep "$SIDE_HASH5" my_bisect_log2.txt &&
-			grep "$HASH5" my_bisect_log.txt
+			test_i18ngrep "$SIDE_HASH5" my_bisect_log2.txt &&
+			test_i18ngrep "$HASH5" my_bisect_log.txt
 		}
 	} &&
 	git bisect reset
@@ -478,7 +478,7 @@ test_expect_success 'good merge bases when good and bad are siblings' '
 test_expect_success 'optimized merge base checks' '
 	git bisect start "$HASH7" "$SIDE_HASH7" > my_bisect_log.txt &&
 	test_i18ngrep "merge base must be tested" my_bisect_log.txt &&
-	grep "$HASH4" my_bisect_log.txt &&
+	test_i18ngrep "$HASH4" my_bisect_log.txt &&
 	git bisect good > my_bisect_log2.txt &&
 	test -f ".git/BISECT_ANCESTORS_OK" &&
 	test "$HASH6" = $(git rev-parse --verify HEAD) &&
@@ -527,7 +527,7 @@ test_expect_success 'restricting bisection on one dir' '
 	para1=$(git rev-parse --verify HEAD) &&
 	test "$para1" = "$PARA_HASH1" &&
 	git bisect bad > my_bisect_log.txt &&
-	grep "$PARA_HASH1 is the first bad commit" my_bisect_log.txt
+	test_i18ngrep "$PARA_HASH1 is the first bad commit" my_bisect_log.txt
 '
 
 test_expect_success 'restricting bisection on one dir and a file' '
@@ -545,7 +545,7 @@ test_expect_success 'restricting bisection on one dir and a file' '
 	para1=$(git rev-parse --verify HEAD) &&
 	test "$para1" = "$PARA_HASH1" &&
 	git bisect good > my_bisect_log.txt &&
-	grep "$PARA_HASH4 is the first bad commit" my_bisect_log.txt
+	test_i18ngrep "$PARA_HASH4 is the first bad commit" my_bisect_log.txt
 '
 
 test_expect_success 'skipping away from skipped commit' '
@@ -576,7 +576,7 @@ test_expect_success 'test bisection on bare repo - --no-checkout specified' '
 			"test \$(git rev-list BISECT_HEAD ^$HASH2 --max-count=1 | wc -l) = 0" \
 			>../nocheckout.log
 	) &&
-	grep "$HASH3 is the first bad commit" nocheckout.log
+	test_i18ngrep "$HASH3 is the first bad commit" nocheckout.log
 '
 
 
@@ -591,7 +591,7 @@ test_expect_success 'test bisection on bare repo - --no-checkout defaulted' '
 			"test \$(git rev-list BISECT_HEAD ^$HASH2 --max-count=1 | wc -l) = 0" \
 			>../defaulted.log
 	) &&
-	grep "$HASH3 is the first bad commit" defaulted.log
+	test_i18ngrep "$HASH3 is the first bad commit" defaulted.log
 '
 
 #
@@ -633,7 +633,7 @@ EOF
 test_expect_success 'bisect fails if tree is broken on start commit' '
 	git bisect reset &&
 	test_must_fail git bisect start BROKEN_HASH7 BROKEN_HASH4 2>error.txt &&
-	test_cmp expected.missing-tree.default error.txt
+	test_i18ncmp expected.missing-tree.default error.txt
 '
 
 test_expect_success 'bisect fails if tree is broken on trial commit' '
@@ -641,7 +641,7 @@ test_expect_success 'bisect fails if tree is broken on trial commit' '
 	test_must_fail git bisect start BROKEN_HASH9 BROKEN_HASH4 2>error.txt &&
 	git reset --hard broken &&
 	git checkout broken &&
-	test_cmp expected.missing-tree.default error.txt
+	test_i18ncmp expected.missing-tree.default error.txt
 '
 
 check_same()
@@ -726,7 +726,7 @@ test_expect_success 'bisect log: successful result' '
 	git bisect start $HASH4 $HASH2 &&
 	git bisect good &&
 	git bisect log >bisect-log.txt &&
-	test_cmp expected.bisect-log bisect-log.txt &&
+	test_i18ncmp expected.bisect-log bisect-log.txt &&
 	git bisect reset
 '
 
@@ -746,7 +746,7 @@ test_expect_success 'bisect log: only skip commits left' '
 	git bisect start $HASH4 $HASH2 &&
 	test_must_fail git bisect skip &&
 	git bisect log >bisect-skip-log.txt &&
-	test_cmp expected.bisect-skip-log bisect-skip-log.txt &&
+	test_i18ncmp expected.bisect-skip-log bisect-skip-log.txt &&
 	git bisect reset
 '
 
@@ -780,14 +780,14 @@ test_expect_success 'bisect start with one new and old' '
 	git bisect new $HASH4 &&
 	git bisect new &&
 	git bisect new >bisect_result &&
-	grep "$HASH2 is the first new commit" bisect_result &&
+	test_i18ngrep "$HASH2 is the first new commit" bisect_result &&
 	git bisect log >log_to_replay.txt &&
 	git bisect reset
 '
 
 test_expect_success 'bisect replay with old and new' '
 	git bisect replay log_to_replay.txt >bisect_result &&
-	grep "$HASH2 is the first new commit" bisect_result &&
+	test_i18ngrep "$HASH2 is the first new commit" bisect_result &&
 	git bisect reset
 '
 
@@ -811,10 +811,10 @@ test_expect_success 'bisect terms shows good/bad after start' '
 	git bisect start HEAD $HASH1 &&
 	git bisect terms --term-good >actual &&
 	echo good >expected &&
-	test_cmp expected actual &&
+	test_i18ncmp expected actual &&
 	git bisect terms --term-bad >actual &&
 	echo bad >expected &&
-	test_cmp expected actual
+	test_i18ncmp expected actual
 '
 
 test_expect_success 'bisect start with one term1 and term2' '
@@ -824,14 +824,14 @@ test_expect_success 'bisect start with one term1 and term2' '
 	git bisect term1 $HASH4 &&
 	git bisect term1 &&
 	git bisect term1 >bisect_result &&
-	grep "$HASH2 is the first term1 commit" bisect_result &&
+	test_i18ngrep "$HASH2 is the first term1 commit" bisect_result &&
 	git bisect log >log_to_replay.txt &&
 	git bisect reset
 '
 
 test_expect_success 'bisect replay with term1 and term2' '
 	git bisect replay log_to_replay.txt >bisect_result &&
-	grep "$HASH2 is the first term1 commit" bisect_result &&
+	test_i18ngrep "$HASH2 is the first term1 commit" bisect_result &&
 	git bisect reset
 '
 
@@ -840,7 +840,7 @@ test_expect_success 'bisect start term1 term2' '
 	git bisect start --term-new term1 --term-old term2 $HASH4 $HASH1 &&
 	git bisect term1 &&
 	git bisect term1 >bisect_result &&
-	grep "$HASH2 is the first term1 commit" bisect_result &&
+	test_i18ngrep "$HASH2 is the first term1 commit" bisect_result &&
 	git bisect log >log_to_replay.txt &&
 	git bisect reset
 '
@@ -878,10 +878,10 @@ test_expect_success 'bisect start --term-* does store terms' '
 	test_i18ncmp expected actual &&
 	git bisect terms --term-bad >actual &&
 	echo one >expected &&
-	test_cmp expected actual &&
+	test_i18ncmp expected actual &&
 	git bisect terms --term-good >actual &&
 	echo two >expected &&
-	test_cmp expected actual
+	test_i18ncmp expected actual
 '
 
 test_expect_success 'bisect start takes options and revs in any order' '
@@ -891,7 +891,7 @@ test_expect_success 'bisect start takes options and revs in any order' '
 		$HASH1 --term-good three -- &&
 	(git bisect terms --term-bad && git bisect terms --term-good) >actual &&
 	printf "%s\n%s\n" bad-term three >expected &&
-	test_cmp expected actual
+	test_i18ncmp expected actual
 '
 
 test_expect_success 'git bisect reset cleans bisection state properly' '

--
https://github.com/git/git/pull/420
