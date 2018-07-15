Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.0 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_06_12,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 58B631F597
	for <e@80x24.org>; Sun, 15 Jul 2018 21:56:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727128AbeGOWVG (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Jul 2018 18:21:06 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:47019 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726940AbeGOWVG (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Jul 2018 18:21:06 -0400
Received: by mail-pl0-f68.google.com with SMTP id 30-v6so14390139pld.13
        for <git@vger.kernel.org>; Sun, 15 Jul 2018 14:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ryXdL16oENh+mHpPax9pPLEP98YQcWFsXPRo3ix9Yl0=;
        b=rb4wXoYdBkTXk1l2pUQw6zdPtWKBZ0pwVq7umEm5Buy7l+oe1OZ6XLWC1jCz5aiYfy
         vAkTFmTj5rbbJ33TV1zBjk0ePhDlEAIaTZ3Mth/5klrCfYd4Mq7QbJ2qnV3LLSIEVbYP
         Jc4ESNlzd4TLzJUu5wPoYFTtMc7zDBIUEL/j8lIo511yaL3ZCMTNjP8+9MATfp+opSBk
         T/NeCrr/Xv+B8Mv/f7HW5Zibv22qPbMU45S1JA+O9m44FUfRSCzvq/3scTxV5nBNdIhW
         g2+C00ppqlOVtIop8s/e2Es9SdknqnkG0+h/8IuIb1U2KYgpjlKCM0tkyxIjYO1Ytx/7
         At4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ryXdL16oENh+mHpPax9pPLEP98YQcWFsXPRo3ix9Yl0=;
        b=DNlUsUfram5XJPPOZsm2YpPJxAfqLOQ8P3qtiHG13pMOZtx8KsTr8HlaUJoLsNOnCl
         i+6omGHmtChZLrsD7p+UxNWe7KP+EWt2MiPZqj8XTyGGFyHZxlnr4wcF/Gl4vbvkBWin
         2W0ekR7majGgDLBupuhA224rNPmXLs3xdQQnZUEftv16cwgP46d5R0+zu41AMt8l8YHY
         u6naIy327J9c5Fd0BOWzFRJMBq0DV7APD7HmVK05VqGZ3A3hCTeSA9I9rn0bLEZr6iYF
         8MwndicE4wcXtZGMk9oKsld185Qr9o4p+a0XW7D8GI6SYGdKahuy6yGb3gj/H84PCHzR
         bA/w==
X-Gm-Message-State: AOUpUlHQZj08iKNghBEFHZizICh0HjxKzKuoRjnVAwG5gIjbFp5GkOvj
        xkYQ3xBegfoDwdc0xp85SLzksz14
X-Google-Smtp-Source: AAOMgpfOu+uu7CDNh3TWbPbUnYbG0O5EojuYNthOqUqrCznZCTRLpvbHTOTJY1aTy5CAC9sc0Pzorw==
X-Received: by 2002:a17:902:280b:: with SMTP id e11-v6mr14352867plb.298.1531691805922;
        Sun, 15 Jul 2018 14:56:45 -0700 (PDT)
Received: from localhost.localdomain (adsl-76-236-28-204.dsl.chi2ca.sbcglobal.net. [76.236.28.204])
        by smtp.gmail.com with ESMTPSA id e82-v6sm81924819pfk.87.2018.07.15.14.56.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Jul 2018 14:56:45 -0700 (PDT)
From:   Samuel Lijin <sxlijin@gmail.com>
To:     git@vger.kernel.org
Cc:     Samuel Lijin <sxlijin@gmail.com>
Subject: [PATCH v3 1/3] t7501: add merge conflict tests for dry run
Date:   Sun, 15 Jul 2018 07:08:05 -0400
Message-Id: <20180715110807.25544-2-sxlijin@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180426092524.25264-1-sxlijin@gmail.com>
References: <20180426092524.25264-1-sxlijin@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The behavior of git commit when doing a dry run changes if there are
unfixed/fixed merge conflits, but the test suite currently only asserts
that `git commit --dry-run` succeeds when all merge conflicts are fixed.

Add tests to document the behavior of all flags which imply a dry run
when (1) there is at least one unfixed merge conflict and (2) when all
merge conflicts are all fixed.

Signed-off-by: Samuel Lijin <sxlijin@gmail.com>
---
 t/t7501-commit.sh | 45 ++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 40 insertions(+), 5 deletions(-)

diff --git a/t/t7501-commit.sh b/t/t7501-commit.sh
index fa61b1a4e..be087e73f 100755
--- a/t/t7501-commit.sh
+++ b/t/t7501-commit.sh
@@ -652,7 +652,8 @@ test_expect_success '--only works on to-be-born branch' '
 	test_cmp expected actual
 '
 
-test_expect_success '--dry-run with conflicts fixed from a merge' '
+# set up env for tests of --dry-run given fixed/unfixed merge conflicts
+test_expect_success 'setup env with unfixed merge conflicts' '
 	# setup two branches with conflicting information
 	# in the same file, resolve the conflict,
 	# call commit with --dry-run
@@ -665,11 +666,45 @@ test_expect_success '--dry-run with conflicts fixed from a merge' '
 	git checkout -b branch-2 HEAD^1 &&
 	echo "commit-2-state" >test-file &&
 	git commit -m "commit 2" -i test-file &&
-	! $(git merge --no-commit commit-1) &&
-	echo "commit-2-state" >test-file &&
+	test_expect_code 1 git merge --no-commit commit-1
+'
+
+test_expect_success '--dry-run with unfixed merge conflicts' '
+	test_expect_code 1 git commit --dry-run
+'
+
+test_expect_success '--short with unfixed merge conflicts' '
+	test_expect_code 1 git commit --short
+'
+
+test_expect_success '--porcelain with unfixed merge conflicts' '
+	test_expect_code 1 git commit --porcelain
+'
+
+test_expect_success '--long with unfixed merge conflicts' '
+	test_expect_code 1 git commit --long
+'
+
+test_expect_success '--dry-run with conflicts fixed from a merge' '
+	echo "merge-conflicts-fixed" >test-file &&
 	git add test-file &&
-	git commit --dry-run &&
-	git commit -m "conflicts fixed from merge."
+	git commit --dry-run
+'
+
+test_expect_failure '--short with conflicts fixed from a merge' '
+	git commit --short
+'
+
+test_expect_failure '--porcelain with conflicts fixed from a merge' '
+	git commit --porcelain
+'
+
+test_expect_success '--long with conflicts fixed from a merge' '
+	git commit --long
+'
+
+test_expect_success '--message with conflicts fixed from a merge' '
+	git commit --message "conflicts fixed from merge."
 '
 
 test_done
-- 
2.18.0

