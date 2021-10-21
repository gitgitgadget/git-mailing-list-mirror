Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B89E3C433F5
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 20:48:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D40C60FD9
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 20:48:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232054AbhJUUuw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Oct 2021 16:50:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231430AbhJUUur (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Oct 2021 16:50:47 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39CB0C061764
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 13:48:31 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id r7so93938wrc.10
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 13:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=8+fO11HluaG7aIPXrE/bW7qpEHv4I6moGjjB4jGT/3Q=;
        b=SMKjnglo+5e4C8ZCElxumJZrMygbt90fybhnVyDD+ZZFM9uzJDGpFgvwa5DoWlD4QI
         Yg7xbRtCwW93IwlnNQzQTwD5uDXgQHXjCDuSYFnWiktcquD8laFuLeXbXriF2oGhkKm7
         XmQRcm0NERXvlUjXRN44+bKMf3P/xrXGDBqFudl24ZxKJzaavivNwr3jjDyGBqN8Xhmr
         Ybc8kDm0DQfAi4UQ6wLCBrr+TzCdvYd30/Lwz6is2kCMp+4wiC5656bYogW9g3KClQ9P
         F+fB45uXeUiMkx6ceaDvLZMfB4X/OSoMRkaJQaI25Wt23651Rocc4ijIjoMrKxE9a8yh
         mO6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=8+fO11HluaG7aIPXrE/bW7qpEHv4I6moGjjB4jGT/3Q=;
        b=MGjDmfcG2lO7BVp7MhyHjka/igLkqipgHR9iJOj4wjRlnOHAmxKeQ3uioGMMQkbpdJ
         g/0AfqRrJ+rAhBW467qE3A6/DrBYENpH3bwu1pO0BC7JgqiF7ExyL2OABi60MsNVyMg+
         o/ojCjfN5udwftbAleLOItuVKoTlfnt1KT63Kito7hCS0Z4xaC/B+uNabwE5ZQhQ6m1o
         XaqGgFygre9ueM8pniiYJpIfFPumGd+EcGSqHENTIxPL7rie9lfk3Vk1Wrip2H+WZy0p
         86O4wbKq2scu+rHKp0df6JsGGsUYR/KmXfWLK7alZF1Tnv5m6pq3ru5YC1Z5AewzvDHL
         RkPw==
X-Gm-Message-State: AOAM533QEvZ+N9PrK9yJwo23ARB/plctE9po7QnXps6Ri5kd0vox/kjP
        ld7PR5fBaB0g84z+O5p2Ca5sRhuirbM=
X-Google-Smtp-Source: ABdhPJzIwQOlq0iZoK7WBSnQ1xopCLMjEchIOLIp0ZjZMCMs60Fg67EvqNaMzP0PRvDsSbfyYe1KfA==
X-Received: by 2002:adf:9c11:: with SMTP id f17mr10417757wrc.147.1634849309649;
        Thu, 21 Oct 2021 13:48:29 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i9sm1745431wmb.22.2021.10.21.13.48.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 13:48:29 -0700 (PDT)
Message-Id: <0b6e6633bb2b9f21a79625ace6db9509c48bd819.1634849307.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1059.v2.git.1634849307.gitgitgadget@gmail.com>
References: <pull.1059.git.1634327697.gitgitgadget@gmail.com>
        <pull.1059.v2.git.1634849307.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 21 Oct 2021 20:48:25 +0000
Subject: [PATCH v2 2/3] sparse-index: add ensure_correct_sparsity function
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, gitster@pobox.com,
        Victoria Dye <vdye@github.com>, Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

The purpose of the `ensure_correct_sparsity` function is to provide a means
of aligning the in-core index with the sparsity required by the repository
settings and other properties of the index. The function will first attempt
to convert the index to sparse, now with a "SPARSE_INDEX_VERIFY_ALLOWED"
flag that forces the function to return a nonzero value if repository
settings do not allow use of a sparse index. If a nonzero value is returned,
the index is expanded to full with `ensure_full_index`.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Victoria Dye <vdye@github.com>
---
 sparse-index.c | 42 +++++++++++++++++++++++++++++++++++++++---
 sparse-index.h |  2 ++
 2 files changed, 41 insertions(+), 3 deletions(-)

diff --git a/sparse-index.c b/sparse-index.c
index 7b7ff79e044..4273453e078 100644
--- a/sparse-index.c
+++ b/sparse-index.c
@@ -122,11 +122,10 @@ static int index_has_unmerged_entries(struct index_state *istate)
 	return 0;
 }
 
-int convert_to_sparse(struct index_state *istate, int flags)
+static int can_convert_to_sparse(struct index_state *istate, int flags)
 {
 	int test_env;
-	if (istate->sparse_index || !istate->cache_nr ||
-	    !core_apply_sparse_checkout || !core_sparse_checkout_cone)
+	if (!core_apply_sparse_checkout || !core_sparse_checkout_cone)
 		return 0;
 
 	if (!istate->repo)
@@ -187,6 +186,30 @@ int convert_to_sparse(struct index_state *istate, int flags)
 	if (cache_tree_update(istate, WRITE_TREE_MISSING_OK))
 		return 0;
 
+	return 1;
+}
+
+int convert_to_sparse(struct index_state *istate, int flags)
+{
+	int verify = flags & SPARSE_INDEX_VERIFY_ALLOWED;
+
+	/*
+	 * If validating with strict checks against whether the sparse index is
+	 * allowed, we want to check `can_convert_to_sparse` *before* exiting
+	 * early due to an already sparse or empty index.
+	 *
+	 * If not performing strict validation, the order is reversed to avoid
+	 * the more expensive checks in `can_convert_to_sparse` whenver possible.
+	 */
+	if (verify) {
+		if (!can_convert_to_sparse(istate, flags))
+			return -1;
+		else if (istate->sparse_index || !istate->cache_nr)
+			return 0;
+	} else if (istate->sparse_index || !istate->cache_nr ||
+		   !can_convert_to_sparse(istate, flags))
+		return 0;
+
 	remove_fsmonitor(istate);
 
 	trace2_region_enter("index", "convert_to_sparse", istate->repo);
@@ -313,6 +336,19 @@ void ensure_full_index(struct index_state *istate)
 	trace2_region_leave("index", "ensure_full_index", istate->repo);
 }
 
+void ensure_correct_sparsity(struct index_state *istate)
+{
+	/*
+	 * First check whether the index can be converted to sparse by attempting
+	 * to convert it with the SPARSE_INDEX_VERIFY_ALLOWED flag. If the
+	 * SPARSE_INDEX_VERIFY_ALLOWED checks indicate that the index cannot
+	 * be converted because repository settings and/or index properties
+	 * do not allow it, expand the index to full.
+	 */
+	if (convert_to_sparse(istate, SPARSE_INDEX_VERIFY_ALLOWED))
+		ensure_full_index(istate);
+}
+
 /*
  * This static global helps avoid infinite recursion between
  * expand_to_path() and index_file_exists().
diff --git a/sparse-index.h b/sparse-index.h
index 9f3d7bc7faf..b61754f1f76 100644
--- a/sparse-index.h
+++ b/sparse-index.h
@@ -3,7 +3,9 @@
 
 struct index_state;
 #define SPARSE_INDEX_MEMORY_ONLY (1 << 0)
+#define SPARSE_INDEX_VERIFY_ALLOWED (1 << 1)
 int convert_to_sparse(struct index_state *istate, int flags);
+void ensure_correct_sparsity(struct index_state *istate);
 
 /*
  * Some places in the codebase expect to search for a specific path.
-- 
gitgitgadget

