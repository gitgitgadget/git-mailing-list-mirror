Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A461C433FE
	for <git@archiver.kernel.org>; Mon,  1 Nov 2021 21:27:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67EAC60F02
	for <git@archiver.kernel.org>; Mon,  1 Nov 2021 21:27:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231683AbhKAVa2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Nov 2021 17:30:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231367AbhKAVa1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Nov 2021 17:30:27 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C5FDC061714
        for <git@vger.kernel.org>; Mon,  1 Nov 2021 14:27:53 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id m22so30284857wrb.0
        for <git@vger.kernel.org>; Mon, 01 Nov 2021 14:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=q1eCX0HMwF4sFiVykW/Npl5A3gXYkPLtA2Grr9KldQk=;
        b=EIT4dtwqWXFTPR69ZRC3cfw8GS9y/r5406tUN9IpDn1lj2MFOALhEX0Ygf4eLdpaz7
         +VBm+K2Fl4n7Lf3CYXniHauGbcBIt3//J/9BtGvYeBcBW9W7lSM1EKWUilZ9AjrxDnwj
         xLzR1HNtRQZPFShdZCNkg4DkhulNtrMMw1uWxY/EZRFYlAa0UVKoN7Vjv/6pkHENZ+gY
         GtY482es70mmmusqgDrP4c0j6MCsRseAZEfGxtbdVd0OfGgODLzO/IGFUCTJtOwNwAqv
         F0j6GxpM65xtfOHawr6MAgiMK4lPuyLRcuHLnZgyq5Y//Gv64Nq0or6BLyHgW7PI3uaa
         zjJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=q1eCX0HMwF4sFiVykW/Npl5A3gXYkPLtA2Grr9KldQk=;
        b=V3zXff4VX9tW651r4gVoS0lZDKL6HURnXgOGVHyeF3+vcUPDuBXuxKQFJ8DA2Xy4+C
         dQIYE2Rh7WR8LDaykaoYMED8Yx2DXmyClv59mNC4e1JeWIgnmcuAgVS212fbqqKRO3El
         LhH8uDUOf2VilrQWNg9b8Py+DJ010fKj9c/VbzG5Bm8jjNhLaGLLSVORdEFj8RskHOf2
         /FsPK9FORi41qd5TKt5Y9J9wAyagHvz16dWwgaFrec6lw5jn7D8KwO/DOSiAT2em3Lmz
         8d2wG/ExCbBt2S6HXQmarxElBkH3EWCA+xGuCLdsUZQMpK/02LfF1PqNwziJFwKbZboS
         zkfg==
X-Gm-Message-State: AOAM532+y0/Yv/optP0iCAof8kuQBM3YNC8zhytxdhqEqv8CIjC2kjew
        GmsCqH+Nhc8l/3uaeo7+Ffb7RSsEnuI=
X-Google-Smtp-Source: ABdhPJzu3/G0l2IZzx6vyLt8yrXXusC94l/PCVrIrRnDknclfEW781q8rzfMZkxe8oJzflWi5lDoyw==
X-Received: by 2002:a05:600c:354d:: with SMTP id i13mr1668903wmq.189.1635802071921;
        Mon, 01 Nov 2021 14:27:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u19sm662578wmm.5.2021.11.01.14.27.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 14:27:51 -0700 (PDT)
Message-Id: <991aaad37b41f71faa19fdef4373ccc115edcc40.1635802069.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1050.v3.git.1635802069.gitgitgadget@gmail.com>
References: <pull.1050.v2.git.1634332835.gitgitgadget@gmail.com>
        <pull.1050.v3.git.1635802069.gitgitgadget@gmail.com>
From:   "Lessley Dennington via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 01 Nov 2021 21:27:48 +0000
Subject: [PATCH v3 1/2] diff: enable and test the sparse index
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, gitster@pobox.com, newren@gmail.com,
        Taylor Blau <me@ttaylorr.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lessley Dennington <lessleydennington@gmail.com>

Enable the sparse index within the 'git diff' command. Its implementation
already safely integrates with the sparse index because it shares code with
the 'git status' and 'git checkout' commands that were already integrated.
For more details see:

d76723ee53 (status: use sparse-index throughout, 2021-07-14)
1ba5f45132 (checkout: stop expanding sparse indexes, 2021-06-29)

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
 t/t1092-sparse-checkout-compatibility.sh | 46 ++++++++++++++++++++++++
 3 files changed, 51 insertions(+)

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
index 44d5e11c762..53524660759 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -832,6 +832,52 @@ test_expect_success 'sparse-index is not expanded: merge conflict in cone' '
 	)
 '
 
+test_expect_success 'sparse index is not expanded: diff' '
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
+	ensure_not_expanded diff &&
+	ensure_not_expanded diff --staged &&
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
+	ensure_not_expanded diff &&
+	ensure_not_expanded diff --staged &&
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
+	test_all_match git diff --staged &&
+	ensure_not_expanded diff &&
+	ensure_not_expanded diff --staged
+'
+
 # NEEDSWORK: a sparse-checkout behaves differently from a full checkout
 # in this scenario, but it shouldn't.
 test_expect_success 'reset mixed and checkout orphan' '
-- 
gitgitgadget

