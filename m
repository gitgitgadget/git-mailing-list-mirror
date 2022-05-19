Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F8BCC433FE
	for <git@archiver.kernel.org>; Thu, 19 May 2022 17:53:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243489AbiESRxn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 May 2022 13:53:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243370AbiESRx2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 May 2022 13:53:28 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 615AD1DB
        for <git@vger.kernel.org>; Thu, 19 May 2022 10:52:45 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id j24so8275014wrb.1
        for <git@vger.kernel.org>; Thu, 19 May 2022 10:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=RbG1UlqErvQan6gdcTmNiHSlUALQ7je4x8pZnwNuqD4=;
        b=Ak+qZdBp337gCNgI3rcoCLVGy7N5ihSSsekez2DoEgSg1VAsZp5QX9H7tF/leGzn8J
         wDUstfUQ3E4kF3kPQW4m5cn9OacSzIG3u/aPOYyh/3bG890UwXJM9+qgwJFUBEKkyacf
         cl/oUQ1Arq4Kb6+DM3iobaxjibKl8kASP1oXyCoXHATTThUEDZShGEwWduv1xHoMhhT2
         8s/yQzZ36A9wo4AT05QAHm4aj/r6a03B+iffyrnN5eYIyQzkHoskLZaR4fS8ZS+F4Fv0
         zdsPvMyJwX/aQgdxSGvlYLx5gd47Df7pJv4BMTFH6blM3rqOBeoui3FZGNU5EWzzanQP
         E0kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=RbG1UlqErvQan6gdcTmNiHSlUALQ7je4x8pZnwNuqD4=;
        b=akF2ZVYxfbVSqQVp+RnzwvwBadPIG0Wen3Oi/KIWCktbw9wxHFMCO3OBVGeZN/s0Gn
         B72qaQaTuXB8LieATY+UB37MKSTMf0I15AJH1YEunDBXjJlc3XJL8JV0i3f3/QAguOCd
         OniqcWVPAYdaM+LlX7KStvJghAb4pgDi5CH8HGCbuoQK4URec04SklI8o65FgWXxwNTm
         odoPDx2RPXTT845zB+XbcgbX48Uvuox0ACFmuTY7qR6c/ffenEYq/Dnq4SfjVCXGZU0s
         fYg2vQ3zK86mueUQDVkeZUNF/vXwYp2YJOIuZw5U+6WUPCGkUBrE+ZS1syx4PZzXZJIk
         cKEw==
X-Gm-Message-State: AOAM532vqc/xVYInvRuqaxNU8Z/d2Jv7VU/Xu1mEqyN7i4Z7O6QYto1m
        bjhLpT0SIkQ1C2O4ugqwsVqaOI1H69A=
X-Google-Smtp-Source: ABdhPJxjQr+oLQKCnb6Ic1CMNPmjESh+updEz1K0fvIpcd2b8GQEUu2o+yDlt9X3ufxBfdws2asJ2A==
X-Received: by 2002:a5d:5187:0:b0:20d:dfc:c333 with SMTP id k7-20020a5d5187000000b0020d0dfcc333mr5099329wrv.623.1652982763577;
        Thu, 19 May 2022 10:52:43 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p10-20020adfba8a000000b0020cf41017b4sm240092wrg.19.2022.05.19.10.52.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 10:52:43 -0700 (PDT)
Message-Id: <d15338573e570aebe239dacdd8c2aba275ff61b9.1652982758.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1208.v2.git.1652982758.gitgitgadget@gmail.com>
References: <pull.1208.git.1652724693.gitgitgadget@gmail.com>
        <pull.1208.v2.git.1652982758.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 19 May 2022 17:52:31 +0000
Subject: [PATCH v2 03/10] sparse-index: create expand_to_pattern_list()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, vdye@github.com, shaoxuan.yuan02@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

This is the first change in a series to allow modifying the
sparse-checkout pattern set without expanding a sparse index to a full
one in the process. Here, we focus on the problem of expanding the
pattern set through a command like 'git sparse-checkout add <path>'
which needs to create new index entries for the paths now being written
to the worktree.

To achieve this, we need to be able to replace sparse directory entries
with their contained files and subdirectories. Once this is complete,
other code paths can discover those cache entries and write the
corresponding files to disk before committing the index.

We already have logic in ensure_full_index() that expands the index
entries, so we will use that as our base. Create a new method,
expand_to_pattern_list(), which takes a pattern list, but for now mostly
ignores it. The current implementation is only correct when the pattern
list is NULL as that does the same as ensure_full_index(). In fact,
ensure_full_index() is converted to a shim over
expand_to_pattern_list().

A future update will actually implement expand_to_pattern_list() to its
full capabilities. For now, it is created and documented.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 sparse-index.c | 35 ++++++++++++++++++++++++++++++++---
 sparse-index.h | 14 ++++++++++++++
 2 files changed, 46 insertions(+), 3 deletions(-)

diff --git a/sparse-index.c b/sparse-index.c
index 8636af72de5..2a06ef58051 100644
--- a/sparse-index.c
+++ b/sparse-index.c
@@ -248,19 +248,41 @@ static int add_path_to_index(const struct object_id *oid,
 	return 0;
 }
 
-void ensure_full_index(struct index_state *istate)
+void expand_to_pattern_list(struct index_state *istate,
+			    struct pattern_list *pl)
 {
 	int i;
 	struct index_state *full;
 	struct strbuf base = STRBUF_INIT;
 
+	/*
+	 * If the index is already full, then keep it full. We will convert
+	 * it to a sparse index on write, if possible.
+	 */
 	if (!istate || !istate->sparse_index)
 		return;
 
+	/*
+	 * If our index is sparse, but our new pattern set does not use
+	 * cone mode patterns, then we need to expand the index before we
+	 * continue. A NULL pattern set indicates a full expansion to a
+	 * full index.
+	 */
+	if (pl && !pl->use_cone_patterns)
+		pl = NULL;
+
 	if (!istate->repo)
 		istate->repo = the_repository;
 
-	trace2_region_enter("index", "ensure_full_index", istate->repo);
+	/*
+	 * A NULL pattern set indicates we are expanding a full index, so
+	 * we use a special region name that indicates the full expansion.
+	 * This is used by test cases, but also helps to differentiate the
+	 * two cases.
+	 */
+	trace2_region_enter("index",
+			    pl ? "expand_to_pattern_list" : "ensure_full_index",
+			    istate->repo);
 
 	/* initialize basics of new index */
 	full = xcalloc(1, sizeof(struct index_state));
@@ -322,7 +344,14 @@ void ensure_full_index(struct index_state *istate)
 	cache_tree_free(&istate->cache_tree);
 	cache_tree_update(istate, 0);
 
-	trace2_region_leave("index", "ensure_full_index", istate->repo);
+	trace2_region_leave("index",
+			    pl ? "expand_to_pattern_list" : "ensure_full_index",
+			    istate->repo);
+}
+
+void ensure_full_index(struct index_state *istate)
+{
+	expand_to_pattern_list(istate, NULL);
 }
 
 void ensure_correct_sparsity(struct index_state *istate)
diff --git a/sparse-index.h b/sparse-index.h
index 633d4fb7e31..037b541f49d 100644
--- a/sparse-index.h
+++ b/sparse-index.h
@@ -23,4 +23,18 @@ void expand_to_path(struct index_state *istate,
 struct repository;
 int set_sparse_index_config(struct repository *repo, int enable);
 
+struct pattern_list;
+
+/**
+ * Scan the given index and compare its entries to the given pattern list.
+ * If the index is sparse and the pattern list uses cone mode patterns,
+ * then modify the index to contain the all of the file entries within that
+ * new pattern list. This expands sparse directories only as far as needed.
+ *
+ * If the pattern list is NULL or does not use cone mode patterns, then the
+ * index is expanded to a full index.
+ */
+void expand_to_pattern_list(struct index_state *istate,
+			      struct pattern_list *pl);
+
 #endif
-- 
gitgitgadget

