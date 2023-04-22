Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5679C77B78
	for <git@archiver.kernel.org>; Sat, 22 Apr 2023 20:18:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbjDVUSI (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Apr 2023 16:18:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbjDVURt (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Apr 2023 16:17:49 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 139792680
        for <git@vger.kernel.org>; Sat, 22 Apr 2023 13:17:46 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3f09b4a156eso19327085e9.3
        for <git@vger.kernel.org>; Sat, 22 Apr 2023 13:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682194664; x=1684786664;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R/HFi0ckZ9f9c5JKPjheBJUsZjbIUK6v4/Q3vTbJKY0=;
        b=SkgTBztC8tj6LKC0MoqO/MgFL6oph+J6UvS3VuLt2s+BxLT1+xEuNK3OfrLE/UjzJk
         PuQ9yjDm1fJX/phTOIWHRfJ4O7NOGRdMnwW8zvjQvuMoL88XeBtszto0sxuxh5j4ABYN
         OCNBzIIEONzYBM0HA+KnoEPWY6V/M9ZkPG4oXnvd4Nh4rbU1F0YNBIqYSWa4vW2KM0pf
         Hu9LheW4C5Wl+cjQ2Ou7Q4rjLaighRfX9lGqZC81YEAMFGZa/9f1gOlu/YavvAG9XUw9
         Uc7MhCqmMXiVxR3zZDQ7gwGwcca2iiveyNxYm4Ndlsaotz958a7EcZs0hgHVc/bUalp/
         1jdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682194664; x=1684786664;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R/HFi0ckZ9f9c5JKPjheBJUsZjbIUK6v4/Q3vTbJKY0=;
        b=HEvF+VR6ar4ecxhIzCIAMkxU6p1qjYVWRxFBZJsEjaI942cy2Njmmh7d4Z7IaslEAX
         RlCHiOc8DDhS9FBsDHPhH9ScAAd2oMiAEGKhKmh0iBeRo21HNjZ+vtNUS9OWRQMmeNQN
         VRv2w3e8fNHUx+POiLqDR3/dsRDqQb60Eflvso3/fsZNYrARJ4xpy2bgCUqQVPLjNFiX
         NUPWd9jV9q5CT5ZmGrmsbONeG8r9UknxOStXudBf2vxcGe9mz9XaKxXjUJgdffCoVncu
         kYDO6gEUp5wZrNKRDEg3QrH4vWbr8mgvTgDJnAkMem1OlMRIdSo1loabnSewStTgBOqi
         wtlQ==
X-Gm-Message-State: AAQBX9cc5mwAdv5FST8U56o0Kk/Uu5HFrSLuX41dBV4xZhD9xlS38Wv5
        0qjVJA1X7i0GqXXM3ef5qwfOsrdsopI=
X-Google-Smtp-Source: AKy350ZKShebpGp/lSigNN5lJLZxY7VTfzg6l5yoVUzYIS+AizmYDO5YfSFIAP4R3yEII2fupFMYhw==
X-Received: by 2002:a7b:c4c4:0:b0:3f1:70e8:c1ac with SMTP id g4-20020a7bc4c4000000b003f170e8c1acmr4833116wmk.8.1682194663937;
        Sat, 22 Apr 2023 13:17:43 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n20-20020a7bc5d4000000b003f17b96793dsm11359229wmk.37.2023.04.22.13.17.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Apr 2023 13:17:43 -0700 (PDT)
Message-Id: <5ef0e17d0aa068bc4b1d78456932d3611098c5f6.1682194652.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1517.v2.git.1682194649.gitgitgadget@gmail.com>
References: <pull.1517.git.1681614205.gitgitgadget@gmail.com>
        <pull.1517.v2.git.1682194649.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 22 Apr 2023 20:17:21 +0000
Subject: [PATCH v2 14/22] cache,tree: move cmp_cache_name_compare from
 tree.[ch] to read-cache.c
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        Glen Choo <chooglen@google.com>,
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

