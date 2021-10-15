Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C43DC433EF
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 21:20:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 451E260F8F
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 21:20:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238599AbhJOVWr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Oct 2021 17:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238628AbhJOVWp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Oct 2021 17:22:45 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED03EC061764
        for <git@vger.kernel.org>; Fri, 15 Oct 2021 14:20:38 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id m42so3483626wms.2
        for <git@vger.kernel.org>; Fri, 15 Oct 2021 14:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=oMoEAJB9Amd4QhjoGX1trHUOf4fDE2EV7IM+wPIpj2k=;
        b=QWd6jpoXFG5eudCrrsTTV3GvhvJRKgftQN7cB2l5nqyiAl5dIagZRCYNxXVtVMSLa1
         P5MDcqwByhsqV2h5BzlUd0wAwFaPTX4flvuOW5MWgxMeyvi8LbfhCbJbRgUUr8RSsa1L
         1gufvt+pp56lO52Qy5K1zbrWXWlUDyaXUdK2nLm6H0HLOG2psRfDken6fic1Fc3oGjnK
         WDulkrRU7I2d2B490E97SKU6+Qr60xxdr/LkfCxPUkCP2mSm+gGHQeVxlQF38SAp+FFq
         qcatCT69qpasaaSfzuYX6yraj3s40z/TzPnohHykcbNpmCTLr3HcoXb39aVl59v5mDZI
         7yKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=oMoEAJB9Amd4QhjoGX1trHUOf4fDE2EV7IM+wPIpj2k=;
        b=MoMc3pP4Ssm8qv1jCjsVJnKSEuopAq7QeMXRfPVeCnTVbB+APb1qEZZZFEUJ4cKC7l
         hlwTXy+liiYVIdExk4ldO7+vQ9klVN+oUkzcWRscSmv51ux7ZwicnfpawkK8HfxgsWDs
         4jlO+uZNbTYSdJKZRw+E4GjegFxKxoHKJDPmHXgj52C7/EDhyk3YtxotOxOgd7wGSzeZ
         lLkAMpX0JYpv7vEGUXSXL/32eanrHJL5PIEixyXNTS7N1F5b+QWFoqIs1kYIZTedG+Xc
         yLFOGU8dKNqlEOIAatIMkZkLngR49NVl7zyXHnjVkPca07OohgOqk0BKOZlgd1nGZs6e
         sbQA==
X-Gm-Message-State: AOAM531ZMoQeM6X1UXIN5oqQ2Lkg77pY2GZjpre1c16GKfqMJjrHUgnN
        iS6/dbzqmabC/ebnVVouM1nuTmlj6ps=
X-Google-Smtp-Source: ABdhPJzKrVvgiKCYZFVAsY4Oh9gcZJ1vcWz8glb1Fh2HrtEHlUz6VxoaYdlLqwUcLCZzmgxk38nqyA==
X-Received: by 2002:a1c:a1c2:: with SMTP id k185mr3754042wme.144.1634332837619;
        Fri, 15 Oct 2021 14:20:37 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a16sm5777180wrs.30.2021.10.15.14.20.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 14:20:37 -0700 (PDT)
Message-Id: <ac33159d020cc0c0f6fbee36eb74fff773cb8f9f.1634332836.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1050.v2.git.1634332835.gitgitgadget@gmail.com>
References: <pull.1050.git.1634232352.gitgitgadget@gmail.com>
        <pull.1050.v2.git.1634332835.gitgitgadget@gmail.com>
From:   "Lessley Dennington via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 15 Oct 2021 21:20:34 +0000
Subject: [PATCH v2 1/2] diff: enable and test the sparse index
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, gitster@pobox.com, newren@gmail.com,
        Lessley Dennington <lessleydennington@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lessley Dennington <lessleydennington@gmail.com>

Enable the sparse index within the 'git diff' command. Its implementation
already safely integrates with the sparse index because it shares code with
the 'git status' and 'git checkout' commands that were already integrated.
The most interesting thing to do is to add tests that verify that 'git diff'
behaves correctly when the sparse index is enabled. These cases are:

1. The index is not expanded for 'diff' and 'diff --staged'
2. 'diff' and 'diff --staged' behave the same in full checkout, sparse
checkout, and sparse index repositories in the following partially-staged
scenarios (i.e. the index, HEAD, and working directory differ at a given
path):
    1. Path is within sparse-checkout cone
    2. Path is outside sparse-checkout cone
    3. A merge conflict exists for paths outside sparse-checkout cone

The `p2000` tests demonstrate a ~30% execution time reduction for 'git
diff' and a ~75% execution time reduction for 'git diff --staged' using a
sparse index:

Test                                      before  after
-------------------------------------------------------------
2000.30: git diff (full-v3)               0.37    0.36 -2.7%
2000.31: git diff (full-v4)               0.36    0.35 -2.8%
2000.32: git diff (sparse-v3)             0.46    0.30 -34.8%
2000.33: git diff (sparse-v4)             0.43    0.31 -27.9%
2000.34: git diff --staged (full-v3)      0.08    0.08 +0.0%
2000.35: git diff --staged (full-v4)      0.08    0.08 +0.0%
2000.36: git diff --staged (sparse-v3)    0.17    0.04 -76.5%
2000.37: git diff --staged (sparse-v4)    0.16    0.04 -75.0%

Co-authored-by: Derrick Stolee <dstolee@microsoft.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
Signed-off-by: Lessley Dennington <lessleydennington@gmail.com>
---
 builtin/diff.c                           |  3 ++
 t/perf/p2000-sparse-operations.sh        |  2 ++
 t/t1092-sparse-checkout-compatibility.sh | 45 ++++++++++++++++++++++++
 3 files changed, 50 insertions(+)

diff --git a/builtin/diff.c b/builtin/diff.c
index dd8ce688ba7..cbf7b51c7c0 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -437,6 +437,9 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 
 	prefix = setup_git_directory_gently(&nongit);
 
+	prepare_repo_settings(the_repository);
+	the_repository->settings.command_requires_full_index = 0;
+
 	if (!no_index) {
 		/*
 		 * Treat git diff with at least one path outside of the
diff --git a/t/perf/p2000-sparse-operations.sh b/t/perf/p2000-sparse-operations.sh
index bfd332120c8..bff93f16e93 100755
--- a/t/perf/p2000-sparse-operations.sh
+++ b/t/perf/p2000-sparse-operations.sh
@@ -113,5 +113,7 @@ test_perf_on_all git checkout -f -
 test_perf_on_all git reset
 test_perf_on_all git reset --hard
 test_perf_on_all git reset -- does-not-exist
+test_perf_on_all git diff
+test_perf_on_all git diff --staged
 
 test_done
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index f19c1b3e2eb..e5d15be9d45 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -386,6 +386,46 @@ test_expect_success 'diff --staged' '
 	test_all_match git diff --staged
 '
 
+test_expect_success 'diff partially-staged' '
+	init_repos &&
+
+	write_script edit-contents <<-\EOF &&
+	echo text >>$1
+	EOF
+
+	# Add file within cone
+	test_sparse_match git sparse-checkout set deep &&
+	run_on_all ../edit-contents deep/testfile &&
+	test_all_match git add deep/testfile &&
+	run_on_all ../edit-contents deep/testfile &&
+
+	test_all_match git diff &&
+	test_all_match git diff --staged &&
+
+	# Add file outside cone
+	test_all_match git reset --hard &&
+	run_on_all mkdir newdirectory &&
+	run_on_all ../edit-contents newdirectory/testfile &&
+	test_sparse_match git sparse-checkout set newdirectory &&
+	test_all_match git add newdirectory/testfile &&
+	run_on_all ../edit-contents newdirectory/testfile &&
+	test_sparse_match git sparse-checkout set &&
+
+	test_all_match git diff &&
+	test_all_match git diff --staged &&
+
+	# Merge conflict outside cone
+	# The sparse checkout will report a warning that is not in the
+	# full checkout, so we use `run_on_all` instead of
+	# `test_all_match`
+	run_on_all git reset --hard &&
+	test_all_match git checkout merge-left &&
+	test_all_match test_must_fail git merge merge-right &&
+
+	test_all_match git diff &&
+	test_all_match git diff --staged
+'
+
 # NEEDSWORK: sparse-checkout behaves differently from full-checkout when
 # running this test with 'df-conflict-2' after 'df-conflict-1'.
 test_expect_success 'diff with renames and conflicts' '
@@ -800,6 +840,11 @@ test_expect_success 'sparse-index is not expanded' '
 	# Wildcard identifies only full sparse directories, no index expansion
 	ensure_not_expanded reset deepest -- folder\* &&
 
+	echo a test change >>sparse-index/README.md &&
+	ensure_not_expanded diff &&
+	git -C sparse-index add README.md &&
+	ensure_not_expanded diff --staged &&
+
 	ensure_not_expanded checkout -f update-deep &&
 	test_config -C sparse-index pull.twohead ort &&
 	(
-- 
gitgitgadget

