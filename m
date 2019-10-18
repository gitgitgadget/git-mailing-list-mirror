Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD6731F4C0
	for <e@80x24.org>; Fri, 18 Oct 2019 22:04:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728438AbfJRWEi (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Oct 2019 18:04:38 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46587 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728389AbfJRWEh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Oct 2019 18:04:37 -0400
Received: by mail-pl1-f193.google.com with SMTP id q24so3470937plr.13
        for <git@vger.kernel.org>; Fri, 18 Oct 2019 15:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ak+lTrf00kbfLeAZYGinrBzu7iQVjhs52xLhRN1MjMU=;
        b=Hjq8nv8HDXX6zcfLcTNUKHi5cJu4EWMjhDtCQFbXV7/ADQYhWegiMud/tGmQzOJczl
         NAmN+0YuUP+YDAjzToi0U3SBEXK6t9kDLj8ToPekOxPbrY82QarDQQHN4xS/ADDyqanw
         9GrSfggsLQ8vUMneyx/yMZ4l/JolXO6CtjuNxoUnbPGa7tfmkKsUA8XpvqiczqeX0TQA
         XudhmWdLebuAHOQjrboYcVyzEhRhcTKfBbyxEd8fP4rBKWshMba9bT3KTCIQH0+q9c9u
         0Fr1ggdVmnePEgdtYyOfj51ejgVwWrm77D6ixRzo/rqRUm6cy+sb/qIt6q3P6TNu9YEv
         Zkcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ak+lTrf00kbfLeAZYGinrBzu7iQVjhs52xLhRN1MjMU=;
        b=tlqVAWVEWBiU67lmrhPTKUiQSYxpILdDuyott9SClmyl6dPaGmMdEWiFNcbrQQnrGK
         ra9tzBhz2VMM2rnKevUhUG5ZaQ4vkLeOQD5FAstdq8GG5YgsWD6f2iGEiY50ju090TGU
         lKWqbQ+JuwxYcostJfhGSZ16qH5EHv3BEFNLE1vvATSNAG167TsrqqWYaPXv9OzCTsSv
         nEGcU4vKvkM4X+qaqR1IuwdbUBhtKFLG4cIh+MZN2u9i76kpesNRrOlzEWtJig23Gfc+
         va7mT32IFYMSRiSK9cKDP3vU8xWJYtQAvReV9IPfP2wkNi7f+KvZPhmA533BL3B9G9qx
         PWaA==
X-Gm-Message-State: APjAAAXfLToIp98AJHhtSz+HjAo9GxEmEC2vi0CgqJ/Nd23zZy8c84VZ
        0AjiOIOW7SP6BQ50CbiBIQE/Yk0n
X-Google-Smtp-Source: APXvYqy/eViCNpfJv3rHTqcvElNT0FqrMwJJz2vlU8zcZzj10odJI13068P8wGIuusnxQu0eCSI6rQ==
X-Received: by 2002:a17:902:9b85:: with SMTP id y5mr12260478plp.138.1571436275665;
        Fri, 18 Oct 2019 15:04:35 -0700 (PDT)
Received: from generichostname ([204.14.239.54])
        by smtp.gmail.com with ESMTPSA id x139sm9227434pgx.92.2019.10.18.15.04.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2019 15:04:34 -0700 (PDT)
Date:   Fri, 18 Oct 2019 15:04:32 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 11/15] t5520: test single-line files by git with test_cmp
Message-ID: <52cf4f0d0fbab70ed90e24bba9271521d3e55d5b.1571435195.git.liu.denton@gmail.com>
References: <cover.1571354136.git.liu.denton@gmail.com>
 <cover.1571435195.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1571435195.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In case an invocation of a Git command fails within the subshell, the
failure will be masked. Replace the subshell with a file-redirection and
a call to test_cmp.

This change was done with the following GNU sed expressions:

	s/\(\s*\)test \([^ ]*\) = "$(\(git [^)]*\))"/\1echo \2 >expect \&\&\n\1\3 >actual \&\&\n\1test_cmp expect actual/
	s/\(\s*\)test "$(\(git [^)]*\))" = \([^ ]*\)/\1echo \3 >expect \&\&\n\1\2 >actual \&\&\n\1test_cmp expect actual/

A future patch will clean up situations where we have multiple duplicate
statements within a test case. This is done to keep this patch purely
mechanical.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t5520-pull.sh | 64 ++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 48 insertions(+), 16 deletions(-)

diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 1af6ea06ee..8b7e7ae55d 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -255,7 +255,9 @@ test_expect_success '--rebase' '
 	git tag before-rebase &&
 	git pull --rebase . copy &&
 	test_cmp_rev HEAD^ copy &&
-	test new = "$(git show HEAD:file2)"
+	echo new >expect &&
+	git show HEAD:file2 >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success '--rebase fast forward' '
@@ -330,7 +332,9 @@ test_expect_success '--rebase fails with multiple branches' '
 	test_must_fail git pull --rebase . copy master 2>err &&
 	test_cmp_rev HEAD before-rebase &&
 	test_i18ngrep "Cannot rebase onto multiple branches" err &&
-	test modified = "$(git show HEAD:file)"
+	echo modified >expect &&
+	git show HEAD:file >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success 'pull --rebase succeeds with dirty working directory and rebase.autostash set' '
@@ -381,7 +385,9 @@ test_expect_success 'pull.rebase' '
 	test_config pull.rebase true &&
 	git pull . copy &&
 	test_cmp_rev HEAD^ copy &&
-	test new = "$(git show HEAD:file2)"
+	echo new >expect &&
+	git show HEAD:file2 >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success 'pull --autostash & pull.rebase=true' '
@@ -399,7 +405,9 @@ test_expect_success 'branch.to-rebase.rebase' '
 	test_config branch.to-rebase.rebase true &&
 	git pull . copy &&
 	test_cmp_rev HEAD^ copy &&
-	test new = "$(git show HEAD:file2)"
+	echo new >expect &&
+	git show HEAD:file2 >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success 'branch.to-rebase.rebase should override pull.rebase' '
@@ -408,14 +416,18 @@ test_expect_success 'branch.to-rebase.rebase should override pull.rebase' '
 	test_config branch.to-rebase.rebase false &&
 	git pull . copy &&
 	test_cmp_rev ! HEAD^ copy &&
-	test new = "$(git show HEAD:file2)"
+	echo new >expect &&
+	git show HEAD:file2 >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success 'pull --rebase warns on --verify-signatures' '
 	git reset --hard before-rebase &&
 	git pull --rebase --verify-signatures . copy 2>err &&
 	test_cmp_rev HEAD^ copy &&
-	test new = "$(git show HEAD:file2)" &&
+	echo new >expect &&
+	git show HEAD:file2 >actual &&
+	test_cmp expect actual &&
 	test_i18ngrep "ignoring --verify-signatures for rebase" err
 '
 
@@ -423,7 +435,9 @@ test_expect_success 'pull --rebase does not warn on --no-verify-signatures' '
 	git reset --hard before-rebase &&
 	git pull --rebase --no-verify-signatures . copy 2>err &&
 	test_cmp_rev HEAD^ copy &&
-	test new = "$(git show HEAD:file2)" &&
+	echo new >expect &&
+	git show HEAD:file2 >actual &&
+	test_cmp expect actual &&
 	test_i18ngrep ! "verify-signatures" err
 '
 
@@ -445,7 +459,9 @@ test_expect_success 'pull.rebase=false create a new merge commit' '
 	git pull . copy &&
 	test_cmp_rev HEAD^1 before-preserve-rebase &&
 	test_cmp_rev HEAD^2 copy &&
-	test file3 = "$(git show HEAD:file3.t)"
+	echo file3 >expect &&
+	git show HEAD:file3.t >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success 'pull.rebase=true flattens keep-merge' '
@@ -453,7 +469,9 @@ test_expect_success 'pull.rebase=true flattens keep-merge' '
 	test_config pull.rebase true &&
 	git pull . copy &&
 	test_cmp_rev HEAD^^ copy &&
-	test file3 = "$(git show HEAD:file3.t)"
+	echo file3 >expect &&
+	git show HEAD:file3.t >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success 'pull.rebase=1 is treated as true and flattens keep-merge' '
@@ -461,7 +479,9 @@ test_expect_success 'pull.rebase=1 is treated as true and flattens keep-merge' '
 	test_config pull.rebase 1 &&
 	git pull . copy &&
 	test_cmp_rev HEAD^^ copy &&
-	test file3 = "$(git show HEAD:file3.t)"
+	echo file3 >expect &&
+	git show HEAD:file3.t >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success REBASE_P \
@@ -507,7 +527,9 @@ test_expect_success '--rebase=false create a new merge commit' '
 	git pull --rebase=false . copy &&
 	test_cmp_rev HEAD^1 before-preserve-rebase &&
 	test_cmp_rev HEAD^2 copy &&
-	test file3 = "$(git show HEAD:file3.t)"
+	echo file3 >expect &&
+	git show HEAD:file3.t >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success '--rebase=true rebases and flattens keep-merge' '
@@ -515,7 +537,9 @@ test_expect_success '--rebase=true rebases and flattens keep-merge' '
 	test_config pull.rebase preserve &&
 	git pull --rebase=true . copy &&
 	test_cmp_rev HEAD^^ copy &&
-	test file3 = "$(git show HEAD:file3.t)"
+	echo file3 >expect &&
+	git show HEAD:file3.t >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success REBASE_P \
@@ -537,7 +561,9 @@ test_expect_success '--rebase overrides pull.rebase=preserve and flattens keep-m
 	test_config pull.rebase preserve &&
 	git pull --rebase . copy &&
 	test_cmp_rev HEAD^^ copy &&
-	test file3 = "$(git show HEAD:file3.t)"
+	echo file3 >expect &&
+	git show HEAD:file3.t >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success '--rebase with rebased upstream' '
@@ -622,10 +648,16 @@ test_expect_success 'pull --rebase fails on unborn branch with staged changes' '
 		cd empty_repo2 &&
 		echo staged-file >staged-file &&
 		git add staged-file &&
-		test "$(git ls-files)" = staged-file &&
+		echo staged-file >expect &&
+		git ls-files >actual &&
+		test_cmp expect actual &&
 		test_must_fail git pull --rebase .. master 2>err &&
-		test "$(git ls-files)" = staged-file &&
-		test "$(git show :staged-file)" = staged-file &&
+		echo staged-file >expect &&
+		git ls-files >actual &&
+		test_cmp expect actual &&
+		echo staged-file >expect &&
+		git show :staged-file >actual &&
+		test_cmp expect actual &&
 		test_i18ngrep "unborn branch with changes added to the index" err
 	)
 '
-- 
2.23.0.897.g0a19638b1e

