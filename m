Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3AB45203C1
	for <e@80x24.org>; Mon, 12 Dec 2016 23:55:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932119AbcLLXzC (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Dec 2016 18:55:02 -0500
Received: from mail-pg0-f48.google.com ([74.125.83.48]:36269 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752690AbcLLXzB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Dec 2016 18:55:01 -0500
Received: by mail-pg0-f48.google.com with SMTP id f188so40460656pgc.3
        for <git@vger.kernel.org>; Mon, 12 Dec 2016 15:55:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=b/Y9q9p3UWPtYeSBQQH4WCQNrv0UoYUniAiIcO2FXWA=;
        b=VqhK6VvI1U+rDK2Ujwfi4Ps3ylLGOlgpSXkzJHCOkMJ9hJJViV1dthQDQOo/+8ekp2
         OyyqJGF765HyWB+jDAk+15ea+PdWHqh8fklLSsx+gToqZY4HFTKwQzMMFHXZ5PLlGdR7
         KkuTizCBBLeNEHvybkzZ/47NVH39heCJGM2bSGGB2RjnufaBfiUI8YaY6B5YhZ8y80kz
         3LUfpaPjVq9CXS/Q4zCJd1qD7kh0MFEeUnKCPjVFn2N7BWvhz/LeEytlzz3CKJN6sjOz
         pw0umrFsD9hqrdFlrwLR2tPIgCWxxmn1/pmKk0m7Nm7Cb0Wsw2eeAp27VauvOeLOx4QL
         sL9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=b/Y9q9p3UWPtYeSBQQH4WCQNrv0UoYUniAiIcO2FXWA=;
        b=ZdQeZT8ysQs6v3Dv0xwctAWubV7synqTTKALg6qbpHNELSg0AJCYFh4ir99oEPJ73z
         S12LUn2Ja+FRdqsb6rgqvK5xJPsUkhXqOulMLaNONBk48Ya+Vs1tp5/J1AjF04TJnzgB
         xP5nYUTqt2kQuvxxRkg7edbkHxAbZ730awcxiYmTcegjUNW+215I874bWm+Xvq1S0Rgx
         5KvnYrrUwZ9ssUDU8Azv5iidW8r8nixn53rZHqK6kl73HvPth3UP3p2AUnfRgUGGn7h+
         S0yOJsCWXWXxXYo2XGWkE394S1U9abIqE8MFlFuwfctAmmFNpY6S0KHLLIroFqvtWa4X
         zrYA==
X-Gm-Message-State: AKaTC01z0CscQsilVK8CZhW0ScnErNgNuOVBRBxRZHXB8j5BRZN8NobphXCRGX2jTD0cq1w2
X-Received: by 10.99.122.92 with SMTP id j28mr170179763pgn.64.1481586899947;
        Mon, 12 Dec 2016 15:54:59 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:642c:37a4:3709:a2b3])
        by smtp.gmail.com with ESMTPSA id w125sm77976343pfb.8.2016.12.12.15.54.59
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 12 Dec 2016 15:54:59 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH] t3600: slightly modernize style
Date:   Mon, 12 Dec 2016 15:54:55 -0800
Message-Id: <20161212235455.13796-1-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.rc2.36.g286df6e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove the space between redirection and file name.
Also remove unnecessary invocations of subshells, such as

	(cd submod &&
		echo X >untracked
	) &&

as there is no point of having the shell for functional purposes.
In case of a single Git command use the `-C` option to let Git cd into
the directory.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 t/t3600-rm.sh | 122 ++++++++++++++++++++++++----------------------------------
 1 file changed, 50 insertions(+), 72 deletions(-)
 
 I came across this test script while developing the checkout series.
 This motivated me to modernize the style while reading it.
 
 The removal of spawning subshells for just one command could be argued to be
 a performance gain as well, though I did not measure it.
 
 Thanks,
 Stefan 

diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
index 14f0edca2b..5e5a16c863 100755
--- a/t/t3600-rm.sh
+++ b/t/t3600-rm.sh
@@ -111,21 +111,21 @@ test_expect_success 'Remove nonexistent file with --ignore-unmatch' '
 '
 
 test_expect_success '"rm" command printed' '
-	echo frotz > test-file &&
+	echo frotz >test-file &&
 	git add test-file &&
 	git commit -m "add file for rm test" &&
-	git rm test-file > rm-output &&
+	git rm test-file >rm-output &&
 	test $(grep "^rm " rm-output | wc -l) = 1 &&
 	rm -f test-file rm-output &&
 	git commit -m "remove file from rm test"
 '
 
 test_expect_success '"rm" command suppressed with --quiet' '
-	echo frotz > test-file &&
+	echo frotz >test-file &&
 	git add test-file &&
 	git commit -m "add file for rm --quiet test" &&
-	git rm --quiet test-file > rm-output &&
-	test $(wc -l < rm-output) = 0 &&
+	git rm --quiet test-file >rm-output &&
+	test_must_be_empty rm-output &&
 	rm -f test-file rm-output &&
 	git commit -m "remove file from rm --quiet test"
 '
@@ -221,7 +221,7 @@ test_expect_success 'Call "rm" from outside the work tree' '
 	mkdir repo &&
 	(cd repo &&
 	 git init &&
-	 echo something > somefile &&
+	 echo something >somefile &&
 	 git add somefile &&
 	 git commit -m "add a file" &&
 	 (cd .. &&
@@ -287,7 +287,7 @@ test_expect_success 'rm removes empty submodules from work tree' '
 	git commit -m "add submodule" &&
 	git rm submod &&
 	test ! -e submod &&
-	git status -s -uno --ignore-submodules=none > actual &&
+	git status -s -uno --ignore-submodules=none >actual &&
 	test_cmp expect actual &&
 	test_must_fail git config -f .gitmodules submodule.sub.url &&
 	test_must_fail git config -f .gitmodules submodule.sub.path
@@ -298,7 +298,7 @@ test_expect_success 'rm removes removed submodule from index and .gitmodules' '
 	git submodule update &&
 	rm -rf submod &&
 	git rm submod &&
-	git status -s -uno --ignore-submodules=none > actual &&
+	git status -s -uno --ignore-submodules=none >actual &&
 	test_cmp expect actual &&
 	test_must_fail git config -f .gitmodules submodule.sub.url &&
 	test_must_fail git config -f .gitmodules submodule.sub.path
@@ -309,7 +309,7 @@ test_expect_success 'rm removes work tree of unmodified submodules' '
 	git submodule update &&
 	git rm submod &&
 	test ! -d submod &&
-	git status -s -uno --ignore-submodules=none > actual &&
+	git status -s -uno --ignore-submodules=none >actual &&
 	test_cmp expect actual &&
 	test_must_fail git config -f .gitmodules submodule.sub.url &&
 	test_must_fail git config -f .gitmodules submodule.sub.path
@@ -320,7 +320,7 @@ test_expect_success 'rm removes a submodule with a trailing /' '
 	git submodule update &&
 	git rm submod/ &&
 	test ! -d submod &&
-	git status -s -uno --ignore-submodules=none > actual &&
+	git status -s -uno --ignore-submodules=none >actual &&
 	test_cmp expect actual
 '
 
@@ -335,17 +335,15 @@ test_expect_success 'rm succeeds when given a directory with a trailing /' '
 test_expect_success 'rm of a populated submodule with different HEAD fails unless forced' '
 	git reset --hard &&
 	git submodule update &&
-	(cd submod &&
-		git checkout HEAD^
-	) &&
+	git -C submod checkout HEAD^ &&
 	test_must_fail git rm submod &&
 	test -d submod &&
 	test -f submod/.git &&
-	git status -s -uno --ignore-submodules=none > actual &&
+	git status -s -uno --ignore-submodules=none >actual &&
 	test_cmp expect.modified actual &&
 	git rm -f submod &&
 	test ! -d submod &&
-	git status -s -uno --ignore-submodules=none > actual &&
+	git status -s -uno --ignore-submodules=none >actual &&
 	test_cmp expect actual &&
 	test_must_fail git config -f .gitmodules submodule.sub.url &&
 	test_must_fail git config -f .gitmodules submodule.sub.path
@@ -418,34 +416,30 @@ test_expect_success 'rm issues a warning when section is not found in .gitmodule
 test_expect_success 'rm of a populated submodule with modifications fails unless forced' '
 	git reset --hard &&
 	git submodule update &&
-	(cd submod &&
-		echo X >empty
-	) &&
+	echo X >submod/empty &&
 	test_must_fail git rm submod &&
 	test -d submod &&
 	test -f submod/.git &&
-	git status -s -uno --ignore-submodules=none > actual &&
+	git status -s -uno --ignore-submodules=none >actual &&
 	test_cmp expect.modified actual &&
 	git rm -f submod &&
 	test ! -d submod &&
-	git status -s -uno --ignore-submodules=none > actual &&
+	git status -s -uno --ignore-submodules=none >actual &&
 	test_cmp expect actual
 '
 
 test_expect_success 'rm of a populated submodule with untracked files fails unless forced' '
 	git reset --hard &&
 	git submodule update &&
-	(cd submod &&
-		echo X >untracked
-	) &&
+	echo X >submod/untracked &&
 	test_must_fail git rm submod &&
 	test -d submod &&
 	test -f submod/.git &&
-	git status -s -uno --ignore-submodules=none > actual &&
+	git status -s -uno --ignore-submodules=none >actual &&
 	test_cmp expect.modified actual &&
 	git rm -f submod &&
 	test ! -d submod &&
-	git status -s -uno --ignore-submodules=none > actual &&
+	git status -s -uno --ignore-submodules=none >actual &&
 	test_cmp expect actual
 '
 
@@ -461,16 +455,12 @@ test_expect_success 'setup submodule conflict' '
 	git add nitfol &&
 	git commit -m "added nitfol 2" &&
 	git checkout -b conflict1 master &&
-	(cd submod &&
-		git fetch &&
-		git checkout branch1
-	) &&
+	git -C submod fetch &&
+	git -C submod checkout branch1 &&
 	git add submod &&
 	git commit -m "submod 1" &&
 	git checkout -b conflict2 master &&
-	(cd submod &&
-		git checkout branch2
-	) &&
+	git -C submod checkout branch2 &&
 	git add submod &&
 	git commit -m "submod 2"
 '
@@ -486,7 +476,7 @@ test_expect_success 'rm removes work tree of unmodified conflicted submodule' '
 	test_must_fail git merge conflict2 &&
 	git rm submod &&
 	test ! -d submod &&
-	git status -s -uno --ignore-submodules=none > actual &&
+	git status -s -uno --ignore-submodules=none >actual &&
 	test_cmp expect actual
 '
 
@@ -494,18 +484,16 @@ test_expect_success 'rm of a conflicted populated submodule with different HEAD
 	git checkout conflict1 &&
 	git reset --hard &&
 	git submodule update &&
-	(cd submod &&
-		git checkout HEAD^
-	) &&
+	git -C submod checkout HEAD^ &&
 	test_must_fail git merge conflict2 &&
 	test_must_fail git rm submod &&
 	test -d submod &&
 	test -f submod/.git &&
-	git status -s -uno --ignore-submodules=none > actual &&
+	git status -s -uno --ignore-submodules=none >actual &&
 	test_cmp expect.conflict actual &&
 	git rm -f submod &&
 	test ! -d submod &&
-	git status -s -uno --ignore-submodules=none > actual &&
+	git status -s -uno --ignore-submodules=none >actual &&
 	test_cmp expect actual &&
 	test_must_fail git config -f .gitmodules submodule.sub.url &&
 	test_must_fail git config -f .gitmodules submodule.sub.path
@@ -515,18 +503,16 @@ test_expect_success 'rm of a conflicted populated submodule with modifications f
 	git checkout conflict1 &&
 	git reset --hard &&
 	git submodule update &&
-	(cd submod &&
-		echo X >empty
-	) &&
+	echo X >submod/empty &&
 	test_must_fail git merge conflict2 &&
 	test_must_fail git rm submod &&
 	test -d submod &&
 	test -f submod/.git &&
-	git status -s -uno --ignore-submodules=none > actual &&
+	git status -s -uno --ignore-submodules=none >actual &&
 	test_cmp expect.conflict actual &&
 	git rm -f submod &&
 	test ! -d submod &&
-	git status -s -uno --ignore-submodules=none > actual &&
+	git status -s -uno --ignore-submodules=none >actual &&
 	test_cmp expect actual &&
 	test_must_fail git config -f .gitmodules submodule.sub.url &&
 	test_must_fail git config -f .gitmodules submodule.sub.path
@@ -536,18 +522,16 @@ test_expect_success 'rm of a conflicted populated submodule with untracked files
 	git checkout conflict1 &&
 	git reset --hard &&
 	git submodule update &&
-	(cd submod &&
-		echo X >untracked
-	) &&
+	echo X >submod/untracked &&
 	test_must_fail git merge conflict2 &&
 	test_must_fail git rm submod &&
 	test -d submod &&
 	test -f submod/.git &&
-	git status -s -uno --ignore-submodules=none > actual &&
+	git status -s -uno --ignore-submodules=none >actual &&
 	test_cmp expect.conflict actual &&
 	git rm -f submod &&
 	test ! -d submod &&
-	git status -s -uno --ignore-submodules=none > actual &&
+	git status -s -uno --ignore-submodules=none >actual &&
 	test_cmp expect actual
 '
 
@@ -564,12 +548,12 @@ test_expect_success 'rm of a conflicted populated submodule with a .git director
 	test_must_fail git rm submod &&
 	test -d submod &&
 	test -d submod/.git &&
-	git status -s -uno --ignore-submodules=none > actual &&
+	git status -s -uno --ignore-submodules=none >actual &&
 	test_cmp expect.conflict actual &&
 	test_must_fail git rm -f submod &&
 	test -d submod &&
 	test -d submod/.git &&
-	git status -s -uno --ignore-submodules=none > actual &&
+	git status -s -uno --ignore-submodules=none >actual &&
 	test_cmp expect.conflict actual &&
 	git merge --abort &&
 	rm -rf submod
@@ -581,7 +565,7 @@ test_expect_success 'rm of a conflicted unpopulated submodule succeeds' '
 	test_must_fail git merge conflict2 &&
 	git rm submod &&
 	test ! -d submod &&
-	git status -s -uno --ignore-submodules=none > actual &&
+	git status -s -uno --ignore-submodules=none >actual &&
 	test_cmp expect actual
 '
 
@@ -597,12 +581,12 @@ test_expect_success 'rm of a populated submodule with a .git directory fails eve
 	test_must_fail git rm submod &&
 	test -d submod &&
 	test -d submod/.git &&
-	git status -s -uno --ignore-submodules=none > actual &&
+	git status -s -uno --ignore-submodules=none >actual &&
 	! test -s actual &&
 	test_must_fail git rm -f submod &&
 	test -d submod &&
 	test -d submod/.git &&
-	git status -s -uno --ignore-submodules=none > actual &&
+	git status -s -uno --ignore-submodules=none >actual &&
 	! test -s actual &&
 	rm -rf submod
 '
@@ -629,58 +613,52 @@ test_expect_success 'setup subsubmodule' '
 test_expect_success 'rm recursively removes work tree of unmodified submodules' '
 	git rm submod &&
 	test ! -d submod &&
-	git status -s -uno --ignore-submodules=none > actual &&
+	git status -s -uno --ignore-submodules=none >actual &&
 	test_cmp expect actual
 '
 
 test_expect_success 'rm of a populated nested submodule with different nested HEAD fails unless forced' '
 	git reset --hard &&
 	git submodule update --recursive &&
-	(cd submod/subsubmod &&
-		git checkout HEAD^
-	) &&
+	git -C submod/subsubmod checkout HEAD^ &&
 	test_must_fail git rm submod &&
 	test -d submod &&
 	test -f submod/.git &&
-	git status -s -uno --ignore-submodules=none > actual &&
+	git status -s -uno --ignore-submodules=none >actual &&
 	test_cmp expect.modified actual &&
 	git rm -f submod &&
 	test ! -d submod &&
-	git status -s -uno --ignore-submodules=none > actual &&
+	git status -s -uno --ignore-submodules=none >actual &&
 	test_cmp expect actual
 '
 
 test_expect_success 'rm of a populated nested submodule with nested modifications fails unless forced' '
 	git reset --hard &&
 	git submodule update --recursive &&
-	(cd submod/subsubmod &&
-		echo X >empty
-	) &&
+	echo X >submod/subsubmod/empty &&
 	test_must_fail git rm submod &&
 	test -d submod &&
 	test -f submod/.git &&
-	git status -s -uno --ignore-submodules=none > actual &&
+	git status -s -uno --ignore-submodules=none >actual &&
 	test_cmp expect.modified actual &&
 	git rm -f submod &&
 	test ! -d submod &&
-	git status -s -uno --ignore-submodules=none > actual &&
+	git status -s -uno --ignore-submodules=none >actual &&
 	test_cmp expect actual
 '
 
 test_expect_success 'rm of a populated nested submodule with nested untracked files fails unless forced' '
 	git reset --hard &&
 	git submodule update --recursive &&
-	(cd submod/subsubmod &&
-		echo X >untracked
-	) &&
+	echo X >submod/subsubmod/untracked &&
 	test_must_fail git rm submod &&
 	test -d submod &&
 	test -f submod/.git &&
-	git status -s -uno --ignore-submodules=none > actual &&
+	git status -s -uno --ignore-submodules=none >actual &&
 	test_cmp expect.modified actual &&
 	git rm -f submod &&
 	test ! -d submod &&
-	git status -s -uno --ignore-submodules=none > actual &&
+	git status -s -uno --ignore-submodules=none >actual &&
 	test_cmp expect actual
 '
 
@@ -695,12 +673,12 @@ test_expect_success 'rm of a populated nested submodule with a nested .git direc
 	test_must_fail git rm submod &&
 	test -d submod &&
 	test -d submod/subsubmod/.git &&
-	git status -s -uno --ignore-submodules=none > actual &&
+	git status -s -uno --ignore-submodules=none >actual &&
 	! test -s actual &&
 	test_must_fail git rm -f submod &&
 	test -d submod &&
 	test -d submod/subsubmod/.git &&
-	git status -s -uno --ignore-submodules=none > actual &&
+	git status -s -uno --ignore-submodules=none >actual &&
 	! test -s actual &&
 	rm -rf submod
 '
@@ -716,7 +694,7 @@ test_expect_success 'checking out a commit after submodule removal needs manual
 	echo "?? submod/" >expected &&
 	test_cmp expected actual &&
 	rm -rf submod &&
-	git status -s -uno --ignore-submodules=none > actual &&
+	git status -s -uno --ignore-submodules=none >actual &&
 	! test -s actual
 '
 
-- 
2.11.0.rc2.55.g1345a36.dirty

