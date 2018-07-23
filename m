Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-0.4 required=3.0 tests=BAYES_00,DATE_IN_PAST_96_XX,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 01F2C1F597
	for <e@80x24.org>; Sun, 29 Jul 2018 00:43:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731655AbeG2CLC (ORCPT <rfc822;e@80x24.org>);
        Sat, 28 Jul 2018 22:11:02 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:36722 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731550AbeG2CLB (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Jul 2018 22:11:01 -0400
Received: by mail-pl0-f65.google.com with SMTP id e11-v6so3882424plb.3
        for <git@vger.kernel.org>; Sat, 28 Jul 2018 17:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YavvN6EoC+BK4WCPpt04NcCxhIVwJ5TEvqWsRz+dVqU=;
        b=Fl5VFShWu+D0lrBxtP13Uxvo42A8vl9/0fRz2NVnDHe/+SrmV3cQiZuqUN5ZWM4umw
         Nzrcccmqbnb4PDaPMiU4ivonOcC9SofmUL8ZKeRgPcrE8FCfbPHWTjZncBcZr8agPYoL
         FWYvM3R4xzruyU5MQwt5qcZMZu9F0ZKiuPq5BO2ZHsRdnmHXuVFBS439ueT8EhCnffVt
         tqhOiqRYvZN+OKDlrpMVVmnlPXdVyqD8mMgq3ipA78XUiI9imiVh9MphaN3gHeVtokhq
         XQLGtbMJN/FKvZSBwsL8wTUbmOVh48g8LKmSzx+EXQ0VVEJ5uJ/8lggYQYazhsUFCK3e
         prbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YavvN6EoC+BK4WCPpt04NcCxhIVwJ5TEvqWsRz+dVqU=;
        b=qiNXOYktHDek2mqcLrvLQ9XrwRvcqTOdG2Q1cIpo66sHdXgcpjw0Mio4gCdqqD7+o3
         3MbEs+p00CzL5umFMGfAr7BKdpYbG9+beH8exDGIMkiju7MR27JS95Gtc6GWbhRLJ4zF
         hXe1C7++x4WPla8EUoHgk8sktlHemhxiCaxXr2fSbxUjkdVJpSbLL4mZ2vW99GKjvXuF
         3UjmywmvpxVou82qbwZDJmFSP2LcYUMuKXxMjTKwkHxxzaSLq6hSR+ggtBQbvKOfXJjF
         a1csXPHGg9W4xM5bWuJYVRddJCoHOoQvUW4ZZv4Nx1wzv0OrxeKpjsyaPfYuqIm2NhN9
         RHDw==
X-Gm-Message-State: AOUpUlGjCA5eKAxdB0Oe+yojndsDfWGDr7otU79t9LEauMUfN//8V5aL
        GmgmXuS6BssAn5xmeAeL3HJzRERd
X-Google-Smtp-Source: AAOMgpcRICFxOhp+iNx+Us4WLGh2iDyzB5+qMs1ygIT5oMxbP4Y9AAi0q4tptLjrA2hrEvjSoaCORw==
X-Received: by 2002:a17:902:740a:: with SMTP id g10-v6mr11321310pll.204.1532824956694;
        Sat, 28 Jul 2018 17:42:36 -0700 (PDT)
Received: from localhost.localdomain ([104.132.11.104])
        by smtp.gmail.com with ESMTPSA id a17-v6sm13034856pfg.106.2018.07.28.17.42.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 28 Jul 2018 17:42:36 -0700 (PDT)
From:   Samuel Lijin <sxlijin@gmail.com>
To:     git@vger.kernel.org
Cc:     Samuel Lijin <sxlijin@gmail.com>
Subject: [PATCH v4 1/4] t7501: add coverage for flags which imply dry runs
Date:   Sun, 22 Jul 2018 22:09:00 -0400
Message-Id: <20180723020903.22435-2-sxlijin@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180715110807.25544-1-sxlijin@gmail.com>
References: <20180715110807.25544-1-sxlijin@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The behavior of git commit, when doing a dry run, changes if there are
unresolved/resolved merge conflicts, but the test suite currently only
asserts that `git commit --dry-run` succeeds when all merge conflicts
are resolved.

Add tests to document the behavior of all flags (i.e. `--dry-run`,
`--short`, `--porcelain`, and `--long`) which imply a dry run when (1)
there are only unresolved merge conflicts, (2) when there are both
unresolved and resolved merge conflicts, and (3) when all merge
conflicts are resolved.

When testing behavior involving resolved merge conflicts, resolve merge
conflicts by replacing each merge conflict with completely new contents,
rather than choosing the contents associated with one of the parent
commits, since the latter decision has no bearing on the behavior of a
dry run commit invocation.

Verify that a dry run invocation of git commit does not create a new
commit by asserting that HEAD has not changed, instead of by crafting
the commit.

Signed-off-by: Samuel Lijin <sxlijin@gmail.com>
---
 t/t7501-commit.sh | 146 +++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 132 insertions(+), 14 deletions(-)

diff --git a/t/t7501-commit.sh b/t/t7501-commit.sh
index 9dbbd01fc..e49dfd0a2 100755
--- a/t/t7501-commit.sh
+++ b/t/t7501-commit.sh
@@ -664,24 +664,142 @@ test_expect_success '--only works on to-be-born branch' '
 	test_cmp expected actual
 '
 
-test_expect_success '--dry-run with conflicts fixed from a merge' '
-	# setup two branches with conflicting information
-	# in the same file, resolve the conflict,
-	# call commit with --dry-run
-	echo "Initial contents, unimportant" >test-file &&
-	git add test-file &&
+test_expect_success 'prepare commits that can be used to trigger a merge conflict' '
+	# setup two branches with conflicting contents in two paths
+	echo "Initial contents, unimportant" | tee test-file1 test-file2 &&
+	git add test-file1 test-file2 &&
 	git commit -m "Initial commit" &&
-	echo "commit-1-state" >test-file &&
-	git commit -m "commit 1" -i test-file &&
+	echo "commit-1-state" | tee test-file1 test-file2 &&
+	git commit -m "commit 1" -i test-file1 test-file2 &&
 	git tag commit-1 &&
 	git checkout -b branch-2 HEAD^1 &&
-	echo "commit-2-state" >test-file &&
-	git commit -m "commit 2" -i test-file &&
-	! $(git merge --no-commit commit-1) &&
-	echo "commit-2-state" >test-file &&
-	git add test-file &&
+	echo "commit-2-state" | tee test-file1 test-file2 &&
+	git commit -m "commit 2" -i test-file1 test-file2 &&
+	git tag commit-2
+'
+
+test_expect_success '--dry-run with only unresolved merge conflicts' '
+	git reset --hard commit-2 &&
+	test_must_fail git merge --no-commit commit-1 &&
+	test_must_fail git commit --dry-run &&
+	git rev-parse commit-2 >expected &&
+	git rev-parse HEAD >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success '--short with only unresolved merge conflicts' '
+	git reset --hard commit-2 &&
+	test_must_fail git merge --no-commit commit-1 &&
+	test_must_fail git commit --short &&
+	git rev-parse commit-2 >expected &&
+	git rev-parse HEAD >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success '--porcelain with only unresolved merge conflicts' '
+	git reset --hard commit-2 &&
+	test_must_fail git merge --no-commit commit-1 &&
+	test_must_fail git commit --porcelain &&
+	git rev-parse commit-2 >expected &&
+	git rev-parse HEAD >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success '--long with only unresolved merge conflicts' '
+	git reset --hard commit-2 &&
+	test_must_fail git merge --no-commit commit-1 &&
+	test_must_fail git commit --long &&
+	git rev-parse commit-2 >expected &&
+	git rev-parse HEAD >actual &&
+	test_cmp expected actual
+'
+
+test_expect_failure '--dry-run with resolved and unresolved merge conflicts' '
+	git reset --hard commit-2 &&
+	test_must_fail git merge --no-commit commit-1 &&
+	echo "resolve one merge conflict" >test-file1 &&
+	git add test-file1 &&
+	test_must_fail git commit --dry-run &&
+	git rev-parse commit-2 >expected &&
+	git rev-parse HEAD >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success '--short with resolved and unresolved merge conflicts' '
+	git reset --hard commit-2 &&
+	test_must_fail git merge --no-commit commit-1 &&
+	echo "resolve one merge conflict" >test-file1 &&
+	git add test-file1 &&
+	test_must_fail git commit --short &&
+	git rev-parse commit-2 >expected &&
+	git rev-parse HEAD >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success '--porcelain with resolved and unresolved merge conflicts' '
+	git reset --hard commit-2 &&
+	test_must_fail git merge --no-commit commit-1 &&
+	echo "resolve one merge conflict" >test-file1 &&
+	git add test-file1 &&
+	test_must_fail git commit --porcelain &&
+	git rev-parse commit-2 >expected &&
+	git rev-parse HEAD >actual &&
+	test_cmp expected actual
+'
+
+test_expect_failure '--long with resolved and unresolved merge conflicts' '
+	git reset --hard commit-2 &&
+	test_must_fail git merge --no-commit commit-1 &&
+	echo "resolve one merge conflict" >test-file1 &&
+	git add test-file1 &&
+	test_must_fail git commit --long &&
+	git rev-parse commit-2 >expected &&
+	git rev-parse HEAD >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success '--dry-run with only resolved merge conflicts' '
+	git reset --hard commit-2 &&
+	test_must_fail git merge --no-commit commit-1 &&
+	echo "resolve all merge conflicts" | tee test-file1 test-file2 &&
+	git add test-file1 test-file2 &&
 	git commit --dry-run &&
-	git commit -m "conflicts fixed from merge."
+	git rev-parse commit-2 >expected &&
+	git rev-parse HEAD >actual &&
+	test_cmp expected actual
+'
+
+test_expect_failure '--short with only resolved merge conflicts' '
+	git reset --hard commit-2 &&
+	test_must_fail git merge --no-commit commit-1 &&
+	echo "resolve all merge conflicts" | tee test-file1 test-file2 &&
+	git add test-file1 test-file2 &&
+	git commit --short &&
+	git rev-parse commit-2 >expected &&
+	git rev-parse HEAD >actual &&
+	test_cmp expected actual
+'
+
+test_expect_failure '--porcelain with only resolved merge conflicts' '
+	git reset --hard commit-2 &&
+	test_must_fail git merge --no-commit commit-1 &&
+	echo "resolve all merge conflicts" | tee test-file1 test-file2 &&
+	git add test-file1 test-file2 &&
+	git commit --porcelain &&
+	git rev-parse commit-2 >expected &&
+	git rev-parse HEAD >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success '--long with only resolved merge conflicts' '
+	git reset --hard commit-2 &&
+	test_must_fail git merge --no-commit commit-1 &&
+	echo "resolve all merge conflicts" | tee test-file1 test-file2 &&
+	git add test-file1 test-file2 &&
+	git commit --long &&
+	git rev-parse commit-2 >expected &&
+	git rev-parse HEAD >actual &&
+	test_cmp expected actual
 '
 
 test_done
-- 
2.18.0

