Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B399BC77B71
	for <git@archiver.kernel.org>; Sun, 16 Apr 2023 03:04:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbjDPDES (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 Apr 2023 23:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbjDPDDw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Apr 2023 23:03:52 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21C3D35AA
        for <git@vger.kernel.org>; Sat, 15 Apr 2023 20:03:40 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-2f771d17409so369475f8f.1
        for <git@vger.kernel.org>; Sat, 15 Apr 2023 20:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681614218; x=1684206218;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ujdgogjwo5a/GoFw2T6ZNDHzRlcXZgJwPUxuSeev76s=;
        b=RHLv1/6QjC+fWqHo771dGwD8KFQrytVqRtQE3z5gOHwqXJYetSrkM63NgVNun7io9w
         kk85oCGA+HoNL1aONMnGb8ol1tQ6qpAKYTs1VU6O0CT/7vg0tM3F2uD6KZqXMlSOzobr
         SH8Hl74uNGHW1iK8ve3mMeXsRBvOqONFhVXd44ImZhefAoajPNBlWF05LZvTWV5/bMct
         /2vcxjEuxMzxeJlLydUegVSajm0mU9WVVUlYoVbFrgyoHVugoyMl1umX6TYwQnh1kcMB
         h4fcwesWxK5MIHZuDqAQQMkCgdMYfrBU6hd6TVcfq2hcSUgE8DuAVCs2LYglHr0bXIur
         b9Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681614218; x=1684206218;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ujdgogjwo5a/GoFw2T6ZNDHzRlcXZgJwPUxuSeev76s=;
        b=bl5TalE/p2LcVV3+XUzd83/+/VOe3rZpeTCDbujytFmBv77LAqSdRBJUnRsHDGe3a5
         SNiSqP5gOtZnSzzEwnC04Tnjmg3nu773Ni2yfIF3HB2ZFhvdvtZVEINLIo2yftwu7Tq0
         r5gg6Q2AKtdyvRYuhee5tGlbXKGoWwxZ2ObIY6Y7YrDb5r0RMszPoKpocvK1i9qM4JmN
         E88/g3JMZSCz6I2m3qUzmOkpIbTM352MMaTX4PUunmO2nG4+SyGhVWXigfdpEjEKeSaV
         n7XFw1jGgXXtT9Gf4hrhsVx040XVk2qxc1ewk5JsqunuixILy1ZA7GtDeirMy0ihQxEH
         j+2A==
X-Gm-Message-State: AAQBX9db3yDDgGFyxxhwYfuynN44D0TXcCCqstkzcSISuzAbJu5kKBH0
        mT2sGt4kMFjAfynWlVzMp8mmo/5tlXs=
X-Google-Smtp-Source: AKy350afwoqtiR7WWO+yzIqa3mVBJDI14lpdhcAzaG73udZ2oI8MuCa6xAvbfOPa/uiAR5DYSIWMXQ==
X-Received: by 2002:a5d:4d44:0:b0:2f2:7adf:3c67 with SMTP id a4-20020a5d4d44000000b002f27adf3c67mr2090934wru.61.1681614218457;
        Sat, 15 Apr 2023 20:03:38 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v14-20020a5d678e000000b002f2b8cb5d9csm7009699wru.28.2023.04.15.20.03.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Apr 2023 20:03:38 -0700 (PDT)
Message-Id: <c72cc0dab90efe7daba56a3d20f6e16f1054ea86.1681614206.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1517.git.1681614205.gitgitgadget@gmail.com>
References: <pull.1517.git.1681614205.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 16 Apr 2023 03:03:18 +0000
Subject: [PATCH 16/23] cache,tree: move basic name compare functions from
 read-cache to tree
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

