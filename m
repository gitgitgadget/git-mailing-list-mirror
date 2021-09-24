Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 643A5C433EF
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 15:39:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D72B61241
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 15:39:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347278AbhIXPlJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Sep 2021 11:41:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347210AbhIXPk6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Sep 2021 11:40:58 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30DBCC061767
        for <git@vger.kernel.org>; Fri, 24 Sep 2021 08:39:22 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id r23so3403699wra.6
        for <git@vger.kernel.org>; Fri, 24 Sep 2021 08:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=wOwNNxQQ+mcgo4o3C4W2z+jVMvVl7HqRUJZg2LK5z54=;
        b=WnY4+XYvxZqOYxbe++i1TenavZOgA5Fwe/y2umWpVWQRhAG+EePJOxi4w0ReFIhEGo
         U2bGLRb4y+vlKxiSqW4JfEVhc/+2YYbF3NRlI2Dd7QRDBlTSsyPc5InL0idjCgxmNGhi
         exVQNESLIY0u8GAFEculTikKk5oIKKbgxdCAF3drEV5r3p69qtXqyzU3IzjAcQUv1+sA
         zbgj/O1D7EBntC9ZL/it/bVy0pZky+Ka4tsgT4SxEZSQmt2V2WUIqTcoDhRsqv8YkY/m
         eKrc2ZQ2b9YSJ3ytKy0meGIaAYp/DhDhgqHhGEaqb3ks3jslgzTRdfXXF0BaAfzNAqfD
         1QEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=wOwNNxQQ+mcgo4o3C4W2z+jVMvVl7HqRUJZg2LK5z54=;
        b=nhqcnV1a/hKq/syBAiUAbHZm7FHqg0b5J9lrXCi5fqsdoGssjIMlR+aa76P+HXSoCP
         Xm80W2MMf4f15hEu9uSU0AsLp84awup/1ZwdPuNY7AaMTwMqrE9MLtDG2xPeiXJ05gao
         fHjIkTKkbPcGHgWLP7QDLk8RBCx8WhICKMP2XXhoerZZz0zyU3tmKfFQjVAjJWpAG1GP
         +sRnTWSNSqvCOEDgwugslavMyw8/Rx60/DuE9bJhHdqZoNhg8fCSY4roWhEDd16JW/p7
         UqkFLfXhV2lm3e7aSB5xMVROGln4t1u5enQEf3Kl9hXPaAweHAHXfFUAT3wON6tbN99H
         +EGw==
X-Gm-Message-State: AOAM5325StLH0uStrh9J0BfOzzLkrzTdVxvjYuaAQOqZz0vHU2aue3JZ
        GGGdyqv9ka3ZKFo/DBL3OkxUDhuNNYA=
X-Google-Smtp-Source: ABdhPJzzptxLYB6GskHeUdG1Hwx/KBG7/vgSFWjD+KRqcPTnSvHKwLgIb5BBcY7fGRcpbCbsQY0Zsg==
X-Received: by 2002:a5d:58cd:: with SMTP id o13mr12551243wrf.416.1632497960864;
        Fri, 24 Sep 2021 08:39:20 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j21sm9328330wmj.40.2021.09.24.08.39.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 08:39:20 -0700 (PDT)
Message-Id: <30ec60969399e2d876d34fdf2150e4152bb9438a.1632497954.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1018.v4.git.1632497954.gitgitgadget@gmail.com>
References: <pull.1018.v3.git.1632159937.gitgitgadget@gmail.com>
        <pull.1018.v4.git.1632497954.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 24 Sep 2021 15:39:10 +0000
Subject: [PATCH v4 09/13] add: update --renormalize to skip sparse paths
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, gitster@pobox.com, matheus.bernardino@usp.br,
        stolee@gmail.com, vdye@github.com,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

We added checks for path_in_sparse_checkout() to portions of 'git add'
that add warnings and prevent stagins a modification, but we skipped the
--renormalize mode. Update renormalize_tracked_files() to ignore cache
entries whose path is outside of the sparse-checkout cone (unless
--sparse is provided). Add a test in t3705.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/add.c                  |  4 +++-
 t/t3705-add-sparse-checkout.sh | 12 +++++++++++-
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index f87b8134b67..f8f0dfa4046 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -154,7 +154,9 @@ static int renormalize_tracked_files(const struct pathspec *pathspec, int flags)
 	for (i = 0; i < active_nr; i++) {
 		struct cache_entry *ce = active_cache[i];
 
-		if (ce_skip_worktree(ce))
+		if (!include_sparse &&
+		    (ce_skip_worktree(ce) ||
+		     !path_in_sparse_checkout(ce->name, &the_index)))
 			continue;
 		if (ce_stage(ce))
 			continue; /* do not touch unmerged paths */
diff --git a/t/t3705-add-sparse-checkout.sh b/t/t3705-add-sparse-checkout.sh
index 0ae674a17a9..339ec0ed2d6 100755
--- a/t/t3705-add-sparse-checkout.sh
+++ b/t/t3705-add-sparse-checkout.sh
@@ -172,6 +172,9 @@ test_expect_success 'git add fails outside of sparse-checkout definition' '
 	test_must_fail git add --chmod=+x sparse_entry &&
 	test_sparse_entry_unstaged &&
 
+	test_must_fail git add --renormalize sparse_entry &&
+	test_sparse_entry_unstaged &&
+
 	# Avoid munging CRLFs to avoid an error message
 	git -c core.autocrlf=input add --sparse sparse_entry 2>stderr &&
 	test_must_be_empty stderr &&
@@ -181,7 +184,14 @@ test_expect_success 'git add fails outside of sparse-checkout definition' '
 	git add --sparse --chmod=+x sparse_entry 2>stderr &&
 	test_must_be_empty stderr &&
 	test-tool read-cache --table >actual &&
-	grep "^100755 blob.*sparse_entry\$" actual
+	grep "^100755 blob.*sparse_entry\$" actual &&
+
+	git reset &&
+
+	# This will print a message over stderr on Windows.
+	git add --sparse --renormalize sparse_entry &&
+	git status --porcelain >actual &&
+	grep "^M  sparse_entry\$" actual
 '
 
 test_expect_success 'add obeys advice.updateSparsePath' '
-- 
gitgitgadget

