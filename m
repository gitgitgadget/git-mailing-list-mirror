Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7B5DC77B70
	for <git@archiver.kernel.org>; Sun, 16 Apr 2023 03:04:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbjDPDEP (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 Apr 2023 23:04:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbjDPDDw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Apr 2023 23:03:52 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B2533589
        for <git@vger.kernel.org>; Sat, 15 Apr 2023 20:03:39 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id o6-20020a05600c4fc600b003ef6e6754c5so9925020wmq.5
        for <git@vger.kernel.org>; Sat, 15 Apr 2023 20:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681614218; x=1684206218;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R/HFi0ckZ9f9c5JKPjheBJUsZjbIUK6v4/Q3vTbJKY0=;
        b=AHfdPSGIwAjFDJEyh33ENEfB4gokc/bVm0tYa9eMqQfl0moCv3M0cfNH+pElTH2zLF
         1Tdh+ef+Z66p9pO/NLzEmgzrRydYRQugxguGV85rrIxiuOzS2qUP0hJAT63BfPu8vUaF
         rHrDbJZNTxS01JPm62lgaZOm+yr9JM2OgyWaOXfoVuy1oVDTuqsZrCmi/NnftpUhLwLx
         ZTaz70qoY1+vZkwEknpz239MoNhJTyM+osXfwCMyjbYwJ5BNYZgscuUtVQQFcfV2mQb/
         jWeCw0vQOvvXrMFkDRsKsKOjq8FpISaKJ34Z3Rg6jPX/cmo0hc+SOfgiZo0yRoQoAb1E
         mh6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681614218; x=1684206218;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R/HFi0ckZ9f9c5JKPjheBJUsZjbIUK6v4/Q3vTbJKY0=;
        b=Yi1pxMNXSfV0gPTgkJQ0MfASR+vJ5c8wqKKTjvhApG8lFb8cUbbiYMnpHDMiEnEnyI
         BPiuCgM/818xpuukL6utytLziR1/w3cnEr7M4NBbg9EF4Cj0g0njB2KTWjqpBQW2tFgL
         ngTh/Bprlx3oEehaYvh8pyBb48nUWViTNiKo8HDYYQj7mTgEIbiiOku8nYBGgsENflT9
         FVudQq6PhTtqWOp6Pj7HCqYxp3b2XxkQz1FkMbQgayso5bFPyZAAczACA9bzuDV5Uexn
         AepXfJF/HFsOv9mlRUyxeRn0gpFa/KrNaMIsV4x09VnQLKtZzL0LeQYdannMNf2mQRAp
         Vybg==
X-Gm-Message-State: AAQBX9eXK4CF2pjWBhu/qTGQqH9Oo68Sh2VWSvwA7ycJ7kdUbVVmGmTT
        NlptxW2kSuIJR8Eem8nMII3dDHLjXtQ=
X-Google-Smtp-Source: AKy350a6VSx9dbeGKqF1YE0y0h7hfA9jTJ9cJ89IUzDfvjRAFU3FU+rpORT2fg/AkPgjHMKBp8Mv/g==
X-Received: by 2002:a7b:c4d5:0:b0:3f1:71d2:da3a with SMTP id g21-20020a7bc4d5000000b003f171d2da3amr469855wmk.30.1681614217835;
        Sat, 15 Apr 2023 20:03:37 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z8-20020a7bc7c8000000b003f07f0405b5sm8032264wmk.43.2023.04.15.20.03.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Apr 2023 20:03:37 -0700 (PDT)
Message-Id: <e1983d51c05cf85f4ee094a26663b94b99f20c02.1681614206.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1517.git.1681614205.gitgitgadget@gmail.com>
References: <pull.1517.git.1681614205.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 16 Apr 2023 03:03:17 +0000
Subject: [PATCH 15/23] cache,tree: move cmp_cache_name_compare from tree.[ch]
 to read-cache.c
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Since cmp_cache_name_compare() was comparing cache_entry structs, it
was associated with the cache rather than with trees.  Move the
function.  As a side effect, we can make cache_name_stage_compare()
static as well.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 cache.h      |  2 +-
 read-cache.c | 13 ++++++++++++-
 tree.c       | 10 ----------
 tree.h       |  1 -
 4 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/cache.h b/cache.h
index 7a46f300d9b..502e4c0b11a 100644
--- a/cache.h
+++ b/cache.h
@@ -562,7 +562,7 @@ int base_name_compare(const char *name1, size_t len1, int mode1,
 int df_name_compare(const char *name1, size_t len1, int mode1,
 		    const char *name2, size_t len2, int mode2);
 int name_compare(const char *name1, size_t len1, const char *name2, size_t len2);
-int cache_name_stage_compare(const char *name1, int len1, int stage1, const char *name2, int len2, int stage2);
+int cmp_cache_name_compare(const void *a_, const void *b_);
 
 /* add */
 /*
diff --git a/read-cache.c b/read-cache.c
index 206c003e558..8f00da4bf7a 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -567,7 +567,8 @@ int name_compare(const char *name1, size_t len1, const char *name2, size_t len2)
 	return 0;
 }
 
-int cache_name_stage_compare(const char *name1, int len1, int stage1, const char *name2, int len2, int stage2)
+static int cache_name_stage_compare(const char *name1, int len1, int stage1,
+				    const char *name2, int len2, int stage2)
 {
 	int cmp;
 
@@ -582,6 +583,16 @@ int cache_name_stage_compare(const char *name1, int len1, int stage1, const char
 	return 0;
 }
 
+int cmp_cache_name_compare(const void *a_, const void *b_)
+{
+	const struct cache_entry *ce1, *ce2;
+
+	ce1 = *((const struct cache_entry **)a_);
+	ce2 = *((const struct cache_entry **)b_);
+	return cache_name_stage_compare(ce1->name, ce1->ce_namelen, ce_stage(ce1),
+				  ce2->name, ce2->ce_namelen, ce_stage(ce2));
+}
+
 static int index_name_stage_pos(struct index_state *istate,
 				const char *name, int namelen,
 				int stage,
diff --git a/tree.c b/tree.c
index e9d51ce2e00..896b7f4776b 100644
--- a/tree.c
+++ b/tree.c
@@ -94,16 +94,6 @@ int read_tree(struct repository *r,
 	return ret;
 }
 
-int cmp_cache_name_compare(const void *a_, const void *b_)
-{
-	const struct cache_entry *ce1, *ce2;
-
-	ce1 = *((const struct cache_entry **)a_);
-	ce2 = *((const struct cache_entry **)b_);
-	return cache_name_stage_compare(ce1->name, ce1->ce_namelen, ce_stage(ce1),
-				  ce2->name, ce2->ce_namelen, ce_stage(ce2));
-}
-
 struct tree *lookup_tree(struct repository *r, const struct object_id *oid)
 {
 	struct object *obj = lookup_object(r, oid);
diff --git a/tree.h b/tree.h
index 0499ad01aa7..8e3c6d441cc 100644
--- a/tree.h
+++ b/tree.h
@@ -29,7 +29,6 @@ void free_tree_buffer(struct tree *tree);
 /* Parses and returns the tree in the given ent, chasing tags and commits. */
 struct tree *parse_tree_indirect(const struct object_id *oid);
 
-int cmp_cache_name_compare(const void *a_, const void *b_);
 
 #define READ_TREE_RECURSIVE 1
 typedef int (*read_tree_fn_t)(const struct object_id *, struct strbuf *, const char *, unsigned int, void *);
-- 
gitgitgadget

