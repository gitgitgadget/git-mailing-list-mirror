Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15425C433FE
	for <git@archiver.kernel.org>; Fri,  3 Dec 2021 21:16:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383208AbhLCVTo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Dec 2021 16:19:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383198AbhLCVTk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Dec 2021 16:19:40 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 715BDC0611F7
        for <git@vger.kernel.org>; Fri,  3 Dec 2021 13:16:15 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id k37-20020a05600c1ca500b00330cb84834fso5864691wms.2
        for <git@vger.kernel.org>; Fri, 03 Dec 2021 13:16:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=KJSSw8wLQl29emn+b7bo5RHNpEJ8F+oMMnMemV7dCdQ=;
        b=ZYhf0dRh4N5peUDIWGt4EIPr9EjW46XcR3+HtAE4rssrkitgA8w6W8M4RlATPXgF+e
         +8jQPoJZ+MtHYzo7vi4zRMh4wt3OCNfeWSTEdcyLlBKp1/fyQYC0c3SWXt1JZqimhQYm
         /w68TvU1/CquJa7bWfc5C+4D8PV4B4gVSqYJ5JmHyQLWgU8/jz7JRAIzENrX+0e0xkHJ
         TfdiI0PT5925ISrM+JdbQHO4EK7l9OY7+oS6xyBLV3xoVS+jz/VKYmb9h/rIJ96s91Wg
         7sT6hC+ZYabEUYHcFdeKTf2Yj+EXDxQTcFanFOcWAl0ZmmO8QLvu+EWuJ7hk0LJG4EK5
         uIEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=KJSSw8wLQl29emn+b7bo5RHNpEJ8F+oMMnMemV7dCdQ=;
        b=cr7MZuSJL8P2LsSmlDC9pvcX1D8ID8XZVOyPijlu3kTYZX3VKyGCtFD25ckboe25tH
         z43pfv5WNkZ08ERyHra3Lhtr8DgdCS6CjKWlIFQZsPs554UfHFKRgQkPyM/wzQ5ZJ9AP
         hwKsVS8JPrITUDpVhaRWhfdypx1kxAEeSiOdTCXFPWI2XinfMZX7QUTX1SMrKGu6ZEgC
         XcpjVaCkbhbPhDbA44byn6gHod3wvMgT2/sHD6KJQWM7ig4hz3YxREr48SEiyDkss8UL
         AaPc733n+odaLUjg9w0fap5clnbmHMsf0KSXQP2MWjlJ3aFUedS8+wI6+gcuwzFgSDQL
         dl7w==
X-Gm-Message-State: AOAM533ASlLp+9TCebYBK7dyqMa+hJN3pSUZJSuWYmihq6PODBKqRcEC
        QLa+498DwbxKHfC80qnc/YOl/f2Z6zM=
X-Google-Smtp-Source: ABdhPJwMNrI6AUTBIpgeuRjIJA/vPVYSIgQRNYezIjGcMWLHvJoFuGpXhNZu5Red4tJreDmIG95E4g==
X-Received: by 2002:a05:600c:24c:: with SMTP id 12mr17565400wmj.124.1638566173859;
        Fri, 03 Dec 2021 13:16:13 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z6sm4445079wmp.9.2021.12.03.13.16.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 13:16:13 -0800 (PST)
Message-Id: <4f16366e5adfd47094f971f8611533a85955aa54.1638566165.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1050.v5.git.1638566165.gitgitgadget@gmail.com>
References: <pull.1050.v4.git.1637620958.gitgitgadget@gmail.com>
        <pull.1050.v5.git.1638566165.gitgitgadget@gmail.com>
From:   "Lessley Dennington via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 03 Dec 2021 21:16:04 +0000
Subject: [PATCH v5 6/7] diff: enable and test the sparse index
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
already safely integrates with the sparse index because it shares code
with the 'git status' and 'git checkout' commands that were already
integrated.  For more details see:

d76723ee53 (status: use sparse-index throughout, 2021-07-14)
1ba5f45132 (checkout: stop expanding sparse indexes, 2021-06-29)

The most interesting thing to do is to add tests that verify that 'git
diff' behaves correctly when the sparse index is enabled. These cases are:

1. The index is not expanded for 'diff' and 'diff --staged'
2. 'diff' and 'diff --staged' behave the same in full checkout, sparse
checkout, and sparse index repositories in the following partially-staged
scenarios (i.e. the index, HEAD, and working directory differ at a given
path):
    1. Path is within sparse-checkout cone
    2. Path is outside sparse-checkout cone
    3. A merge conflict exists for paths outside sparse-checkout cone

The `p2000` tests demonstrate a ~44% execution time reduction for 'git
diff' and a ~86% execution time reduction for 'git diff --staged' using a
sparse index:

Test                                      before  after
-------------------------------------------------------------
2000.30: git diff (full-v3)               0.33    0.34 +3.0%
2000.31: git diff (full-v4)               0.33    0.35 +6.1%
2000.32: git diff (sparse-v3)             0.53    0.31 -41.5%
2000.33: git diff (sparse-v4)             0.54    0.29 -46.3%
2000.34: git diff --cached (full-v3)      0.07    0.07 +0.0%
2000.35: git diff --cached (full-v4)      0.07    0.08 +14.3%
2000.36: git diff --cached (sparse-v3)    0.28    0.04 -85.7%
2000.37: git diff --cached (sparse-v4)    0.23    0.03 -87.0%

Co-authored-by: Derrick Stolee <dstolee@microsoft.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
Signed-off-by: Lessley Dennington <lessleydennington@gmail.com>
---
 builtin/diff.c                           |  5 +++
 t/perf/p2000-sparse-operations.sh        |  2 ++
 t/t1092-sparse-checkout-compatibility.sh | 46 ++++++++++++++++++++++++
 3 files changed, 53 insertions(+)

diff --git a/builtin/diff.c b/builtin/diff.c
index dd8ce688ba7..fa4683377eb 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -437,6 +437,11 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 
 	prefix = setup_git_directory_gently(&nongit);
 
+	if (!nongit) {
+		prepare_repo_settings(the_repository);
+		the_repository->settings.command_requires_full_index = 0;
+	}
+
 	if (!no_index) {
 		/*
 		 * Treat git diff with at least one path outside of the
diff --git a/t/perf/p2000-sparse-operations.sh b/t/perf/p2000-sparse-operations.sh
index bfd332120c8..5cf94627383 100755
--- a/t/perf/p2000-sparse-operations.sh
+++ b/t/perf/p2000-sparse-operations.sh
@@ -113,5 +113,7 @@ test_perf_on_all git checkout -f -
 test_perf_on_all git reset
 test_perf_on_all git reset --hard
 test_perf_on_all git reset -- does-not-exist
+test_perf_on_all git diff
+test_perf_on_all git diff --cached
 
 test_done
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 203a594fa45..abfb4994bb9 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -846,6 +846,52 @@ test_expect_success 'sparse-index is not expanded: merge conflict in cone' '
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
+	test_all_match git diff --cached &&
+	ensure_not_expanded diff &&
+	ensure_not_expanded diff --cached &&
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
+	test_all_match git diff --cached &&
+	ensure_not_expanded diff &&
+	ensure_not_expanded diff --cached &&
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
+	test_all_match git diff --cached &&
+	ensure_not_expanded diff &&
+	ensure_not_expanded diff --cached
+'
+
 # NEEDSWORK: a sparse-checkout behaves differently from a full checkout
 # in this scenario, but it shouldn't.
 test_expect_success 'reset mixed and checkout orphan' '
-- 
gitgitgadget

