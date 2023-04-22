Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC31CC7618E
	for <git@archiver.kernel.org>; Sat, 22 Apr 2023 20:18:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229451AbjDVUSK (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Apr 2023 16:18:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbjDVURt (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Apr 2023 16:17:49 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEA5226B2
        for <git@vger.kernel.org>; Sat, 22 Apr 2023 13:17:45 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3f19afc4fd8so3325145e9.2
        for <git@vger.kernel.org>; Sat, 22 Apr 2023 13:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682194665; x=1684786665;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ujdgogjwo5a/GoFw2T6ZNDHzRlcXZgJwPUxuSeev76s=;
        b=KKn2UwH52sOxMz3HPt7F3ThPF2wIYlX+DKl9kmeIh63BWKfUAGuM0E698JS6pNACd2
         /q2XzozjOPJy896Q8RhgXTaqdeEWMOUdeXi5ubdj9Bqoja4gyjIxXZFIAMR5woXiaWeQ
         yQPX8xHdaOZb2aTM9K2uGWOjhOCLXdWePqQKsEsY6MTGhxVVRYNTfIYcY8ZtMmL1991T
         PS02WKUQHJJG7VBs63uKNwByZ6s+p2053FKdhWaMJ3DsxQ9SQgNRQlOhvXGUF1QQmile
         WVL3JyurKeXdxgSJmdOtn0GWsrE9FEC1a4zBEM1uLJOz6ftSCwSjJn5XmPe83Gw3X5Y1
         wSzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682194665; x=1684786665;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ujdgogjwo5a/GoFw2T6ZNDHzRlcXZgJwPUxuSeev76s=;
        b=Rg/UO8iCgiJSEyib+y8r6STWmTuhAqgGgkVpzbmGTCHGAnQ9rEmzsL1N4ueviiwmOX
         Fg58RlY4gIsXkpLYXBjfu6J3D9aDn04wfenl/+S30ymG8gtfk6ab+I3YojF34wnCNYgK
         9JeVrhuO70K12ZjuTzZgylBmysgeU1PfQyvj9HIna5YSr+r/Ga86aUUbiZXBlcvGPHFF
         tnef0EXvMG8SurxqMcnx7Km4L1wmhVMzzcl421D+/Usr8LcUqM+0u5sqYYFW9miEyOyQ
         jl+J1LsJ1SO7PtGb4A9E9fZCnnlyxuKEQFU15+VQH2UYDW9q6BAVus22HCNIP+b5XIbO
         d7Vg==
X-Gm-Message-State: AAQBX9ffbkNrLzwqpeVOXk0EPEx3HjjhukmHzv8c8vjKexhN/IcIlYDT
        rVmV5CyNXFTovlNU6nF5KCCmfFM/ZzI=
X-Google-Smtp-Source: AKy350bQvj0iSKUnfthaa9/9+TqJRN9VW1EV5nwmtTg++TanWMkWnE0L+MwNDXcVrM7DNoDPGBVd2w==
X-Received: by 2002:a1c:f715:0:b0:3f1:4971:5cd1 with SMTP id v21-20020a1cf715000000b003f149715cd1mr4570067wmh.21.1682194664806;
        Sat, 22 Apr 2023 13:17:44 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v16-20020a05600c471000b003ede3f5c81fsm11548387wmo.41.2023.04.22.13.17.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Apr 2023 13:17:44 -0700 (PDT)
Message-Id: <cc28613351394344893a4dbedce081cc6bd26e31.1682194652.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1517.v2.git.1682194649.gitgitgadget@gmail.com>
References: <pull.1517.git.1681614205.gitgitgadget@gmail.com>
        <pull.1517.v2.git.1682194649.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 22 Apr 2023 20:17:22 +0000
Subject: [PATCH v2 15/22] cache,tree: move basic name compare functions from
 read-cache to tree
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

None of base_name_compare(), df_name_compare(), or name_compare()
depended upon a cache_entry or index_state in any way.  By moving these
functions to tree.h, half a dozen other files can stop depending upon
cache.h (though that change will be made in a later commit).

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 cache.h      |  5 ----
 read-cache.c | 68 ----------------------------------------------------
 tree.c       | 68 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 tree.h       |  9 +++++++
 4 files changed, 77 insertions(+), 73 deletions(-)

diff --git a/cache.h b/cache.h
index 502e4c0b11a..591c67b0595 100644
--- a/cache.h
+++ b/cache.h
@@ -557,11 +557,6 @@ extern int verify_ce_order;
 #define DATA_CHANGED    0x0020
 #define TYPE_CHANGED    0x0040
 
-int base_name_compare(const char *name1, size_t len1, int mode1,
-		      const char *name2, size_t len2, int mode2);
-int df_name_compare(const char *name1, size_t len1, int mode1,
-		    const char *name2, size_t len2, int mode2);
-int name_compare(const char *name1, size_t len1, const char *name2, size_t len2);
 int cmp_cache_name_compare(const void *a_, const void *b_);
 
 /* add */
diff --git a/read-cache.c b/read-cache.c
index 8f00da4bf7a..b3e2917ddc9 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -499,74 +499,6 @@ int ie_modified(struct index_state *istate,
 	return 0;
 }
 
-int base_name_compare(const char *name1, size_t len1, int mode1,
-		      const char *name2, size_t len2, int mode2)
-{
-	unsigned char c1, c2;
-	size_t len = len1 < len2 ? len1 : len2;
-	int cmp;
-
-	cmp = memcmp(name1, name2, len);
-	if (cmp)
-		return cmp;
-	c1 = name1[len];
-	c2 = name2[len];
-	if (!c1 && S_ISDIR(mode1))
-		c1 = '/';
-	if (!c2 && S_ISDIR(mode2))
-		c2 = '/';
-	return (c1 < c2) ? -1 : (c1 > c2) ? 1 : 0;
-}
-
-/*
- * df_name_compare() is identical to base_name_compare(), except it
- * compares conflicting directory/file entries as equal. Note that
- * while a directory name compares as equal to a regular file, they
- * then individually compare _differently_ to a filename that has
- * a dot after the basename (because '\0' < '.' < '/').
- *
- * This is used by routines that want to traverse the git namespace
- * but then handle conflicting entries together when possible.
- */
-int df_name_compare(const char *name1, size_t len1, int mode1,
-		    const char *name2, size_t len2, int mode2)
-{
-	unsigned char c1, c2;
-	size_t len = len1 < len2 ? len1 : len2;
-	int cmp;
-
-	cmp = memcmp(name1, name2, len);
-	if (cmp)
-		return cmp;
-	/* Directories and files compare equal (same length, same name) */
-	if (len1 == len2)
-		return 0;
-	c1 = name1[len];
-	if (!c1 && S_ISDIR(mode1))
-		c1 = '/';
-	c2 = name2[len];
-	if (!c2 && S_ISDIR(mode2))
-		c2 = '/';
-	if (c1 == '/' && !c2)
-		return 0;
-	if (c2 == '/' && !c1)
-		return 0;
-	return c1 - c2;
-}
-
-int name_compare(const char *name1, size_t len1, const char *name2, size_t len2)
-{
-	size_t min_len = (len1 < len2) ? len1 : len2;
-	int cmp = memcmp(name1, name2, min_len);
-	if (cmp)
-		return cmp;
-	if (len1 < len2)
-		return -1;
-	if (len1 > len2)
-		return 1;
-	return 0;
-}
-
 static int cache_name_stage_compare(const char *name1, int len1, int stage1,
 				    const char *name2, int len2, int stage2)
 {
diff --git a/tree.c b/tree.c
index 896b7f4776b..f242a7ab691 100644
--- a/tree.c
+++ b/tree.c
@@ -94,6 +94,74 @@ int read_tree(struct repository *r,
 	return ret;
 }
 
+int base_name_compare(const char *name1, size_t len1, int mode1,
+		      const char *name2, size_t len2, int mode2)
+{
+	unsigned char c1, c2;
+	size_t len = len1 < len2 ? len1 : len2;
+	int cmp;
+
+	cmp = memcmp(name1, name2, len);
+	if (cmp)
+		return cmp;
+	c1 = name1[len];
+	c2 = name2[len];
+	if (!c1 && S_ISDIR(mode1))
+		c1 = '/';
+	if (!c2 && S_ISDIR(mode2))
+		c2 = '/';
+	return (c1 < c2) ? -1 : (c1 > c2) ? 1 : 0;
+}
+
+/*
+ * df_name_compare() is identical to base_name_compare(), except it
+ * compares conflicting directory/file entries as equal. Note that
+ * while a directory name compares as equal to a regular file, they
+ * then individually compare _differently_ to a filename that has
+ * a dot after the basename (because '\0' < '.' < '/').
+ *
+ * This is used by routines that want to traverse the git namespace
+ * but then handle conflicting entries together when possible.
+ */
+int df_name_compare(const char *name1, size_t len1, int mode1,
+		    const char *name2, size_t len2, int mode2)
+{
+	unsigned char c1, c2;
+	size_t len = len1 < len2 ? len1 : len2;
+	int cmp;
+
+	cmp = memcmp(name1, name2, len);
+	if (cmp)
+		return cmp;
+	/* Directories and files compare equal (same length, same name) */
+	if (len1 == len2)
+		return 0;
+	c1 = name1[len];
+	if (!c1 && S_ISDIR(mode1))
+		c1 = '/';
+	c2 = name2[len];
+	if (!c2 && S_ISDIR(mode2))
+		c2 = '/';
+	if (c1 == '/' && !c2)
+		return 0;
+	if (c2 == '/' && !c1)
+		return 0;
+	return c1 - c2;
+}
+
+int name_compare(const char *name1, size_t len1, const char *name2, size_t len2)
+{
+	size_t min_len = (len1 < len2) ? len1 : len2;
+	int cmp = memcmp(name1, name2, min_len);
+	if (cmp)
+		return cmp;
+	if (len1 < len2)
+		return -1;
+	if (len1 > len2)
+		return 1;
+	return 0;
+}
+
 struct tree *lookup_tree(struct repository *r, const struct object_id *oid)
 {
 	struct object *obj = lookup_object(r, oid);
diff --git a/tree.h b/tree.h
index 8e3c6d441cc..1b5ecbda6b3 100644
--- a/tree.h
+++ b/tree.h
@@ -29,6 +29,15 @@ void free_tree_buffer(struct tree *tree);
 /* Parses and returns the tree in the given ent, chasing tags and commits. */
 struct tree *parse_tree_indirect(const struct object_id *oid);
 
+/*
+ * Functions for comparing pathnames
+ */
+int base_name_compare(const char *name1, size_t len1, int mode1,
+		      const char *name2, size_t len2, int mode2);
+int df_name_compare(const char *name1, size_t len1, int mode1,
+		    const char *name2, size_t len2, int mode2);
+int name_compare(const char *name1, size_t len1,
+		 const char *name2, size_t len2);
 
 #define READ_TREE_RECURSIVE 1
 typedef int (*read_tree_fn_t)(const struct object_id *, struct strbuf *, const char *, unsigned int, void *);
-- 
gitgitgadget

