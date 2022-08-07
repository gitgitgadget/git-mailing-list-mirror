Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EC9BC19F2D
	for <git@archiver.kernel.org>; Sun,  7 Aug 2022 02:57:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231629AbiHGC5a (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 Aug 2022 22:57:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiHGC5V (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Aug 2022 22:57:21 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21E38EE1B
        for <git@vger.kernel.org>; Sat,  6 Aug 2022 19:57:20 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id h13so7310918wrf.6
        for <git@vger.kernel.org>; Sat, 06 Aug 2022 19:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=RN7TN5jW6MXYECT/zRsWN1eJzIQFWq7DDC/kGd44N5g=;
        b=bZlTQ7/wFgqvsmKWderSznjhVY83Qn+fflSRL/Ian/fD4QgKoUdGIoyZXJZ5H8nhwd
         uU0uYz30Obul/RluB0OlR2VU59vgn0vZQqvhEyk11EWClQV5Hm62+FsrK13lAMTJZlge
         1fE05Mjq+grLFo7g+gx2Wl6Awh9zIW/FG+1O5k7km9y4YH0m1ap2gv9bBZslCo7XiZPj
         r+5PzJCchGlzVScuEDv0kJj+PnzI9d7KBPtsAkPBBMqrAqMrkiHdKmVeHWxyIXjzZy/D
         ML6xv1k+0CGUjgfYNsLu7YAEwLFsfr9SfUMkBrztQEnTvlu9D5L/KCmjWD1fUQMIMgYU
         nwxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=RN7TN5jW6MXYECT/zRsWN1eJzIQFWq7DDC/kGd44N5g=;
        b=6mO3TMgTmT9fOHC0oH3q3oG6sqILzgiXSXF7B9jhmnQZTsfUdNFi7NF1GSyAI4PhS7
         fsh/mQMQOkpj8kUZ1O0DmJSO4dMsT86kPCIYBis6TvXTYblQfZSXzY+PsnJcQKMi9NP1
         O06bAuRTS4JCsrm5sWnD8ka1uSMNHQDeT5tcgd6NBh780eIbQ5C6AiqxtuONVt2ElzPT
         hVTBxOpxNLqlhvTVI0qr/QpO6QX0Ox1JOTuyIzPKAftulHdzPXN4eFU1U7iEfp3QX0aa
         tBRDLeAAGXnjtoHfmKIQ6vryrF5BDvwLfm9c/b/rwI1YsRDrHj7w3KN4JqauOKehphqA
         Vufg==
X-Gm-Message-State: ACgBeo2sdOSvPAz7erfx2MBI8A+5NWqbgvqbgwJOiHczhfMHqwUCNDOg
        BnQJUf4wFs3ZvWhzmnqdWXHVsYpIQLA=
X-Google-Smtp-Source: AA6agR45FMtHtRrjDdHIHpNMJR8Ct+SVFcQ9VbZsMbn1W74V32rhcAt11wqr0s0FFXViUz2LaqzfsA==
X-Received: by 2002:adf:fb43:0:b0:21a:22eb:da43 with SMTP id c3-20020adffb43000000b0021a22ebda43mr7724778wrs.347.1659841038072;
        Sat, 06 Aug 2022 19:57:18 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f13-20020a05600c4e8d00b003a319b67f64sm36785367wmq.0.2022.08.06.19.57.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Aug 2022 19:57:17 -0700 (PDT)
Message-Id: <97ca668102cdade9501996af4d31e38dc7420a29.1659841030.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1312.v2.git.1659841030.gitgitgadget@gmail.com>
References: <pull.1312.git.1659645967.gitgitgadget@gmail.com>
        <pull.1312.v2.git.1659841030.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 07 Aug 2022 02:57:09 +0000
Subject: [PATCH v2 4/4] unpack-trees: unpack new trees as sparse directories
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     derrickstolee@github.com, shaoxuan.yuan02@gmail.com,
        newren@gmail.com, gitster@pobox.com,
        Victoria Dye <vdye@github.com>, Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

If 'unpack_single_entry()' is unpacking a new directory tree (that is, one
not already present in the index) into a sparse index, unpack the tree as a
sparse directory rather than traversing its contents and unpacking each file
individually. This helps keep the sparse index as collapsed as possible in
cases such as 'git reset --hard' restoring a outside-of-cone directory
removed with 'git rm -r --sparse'.

Without this patch, 'unpack_single_entry()' will only unpack a directory
into the index as a sparse directory (rather than traversing into it and
unpacking its files one-by-one) if an entry with the same name already
exists in the index. This patch allows sparse directory unpacking without a
matching index entry when the following conditions are met:

1. the directory's path is outside the sparse cone, and
2. there are no children of the directory in the index

If a directory meets these requirements (as determined by
'is_new_sparse_dir()'), 'unpack_single_entry()' unpacks the sparse directory
index entry and propagates the decision back up to 'unpack_callback()' to
prevent unnecessary tree traversal into the unpacked directory.

Reported-by: Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Signed-off-by: Victoria Dye <vdye@github.com>
---
 t/t1092-sparse-checkout-compatibility.sh |  17 ++++
 unpack-trees.c                           | 106 ++++++++++++++++++++---
 2 files changed, 113 insertions(+), 10 deletions(-)

diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 99a1425a929..eb5edebfa5d 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -695,6 +695,23 @@ test_expect_success 'reset with wildcard pathspec' '
 	test_all_match git ls-files -s -- folder1
 '
 
+test_expect_success 'reset hard with removed sparse dir' '
+	init_repos &&
+
+	test_all_match git rm -r --sparse folder1 &&
+	test_all_match git status --porcelain=v2 &&
+
+	test_all_match git reset --hard &&
+	test_all_match git status --porcelain=v2 &&
+
+	cat >expect <<-\EOF &&
+	folder1/
+	EOF
+
+	git -C sparse-index ls-files --sparse folder1 >out &&
+	test_cmp expect out
+'
+
 test_expect_success 'update-index modify outside sparse definition' '
 	init_repos &&
 
diff --git a/unpack-trees.c b/unpack-trees.c
index 8a454e03bff..90b92114be8 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1069,6 +1069,67 @@ static struct cache_entry *create_ce_entry(const struct traverse_info *info,
 	return ce;
 }
 
+/*
+ * Determine whether the path specified by 'p' should be unpacked as a new
+ * sparse directory in a sparse index. A new sparse directory 'A/':
+ * - must be outside the sparse cone.
+ * - must not already be in the index (i.e., no index entry with name 'A/'
+ *   exists).
+ * - must not have any child entries in the index (i.e., no index entry
+ *   'A/<something>' exists).
+ * If 'p' meets the above requirements, return 1; otherwise, return 0.
+ */
+static int entry_is_new_sparse_dir(const struct traverse_info *info,
+				   const struct name_entry *p)
+{
+	int res, pos;
+	struct strbuf dirpath = STRBUF_INIT;
+	struct unpack_trees_options *o = info->data;
+
+	if (!S_ISDIR(p->mode))
+		return 0;
+
+	/*
+	 * If the path is inside the sparse cone, it can't be a sparse directory.
+	 */
+	strbuf_add(&dirpath, info->traverse_path, info->pathlen);
+	strbuf_add(&dirpath, p->path, p->pathlen);
+	strbuf_addch(&dirpath, '/');
+	if (path_in_cone_mode_sparse_checkout(dirpath.buf, o->src_index)) {
+		res = 0;
+		goto cleanup;
+	}
+
+	pos = index_name_pos_sparse(o->src_index, dirpath.buf, dirpath.len);
+	if (pos >= 0) {
+		/* Path is already in the index, not a new sparse dir */
+		res = 0;
+		goto cleanup;
+	}
+
+	/* Where would this sparse dir be inserted into the index? */
+	pos = -pos - 1;
+	if (pos >= o->src_index->cache_nr) {
+		/*
+		 * Sparse dir would be inserted at the end of the index, so we
+		 * know it has no child entries.
+		 */
+		res = 1;
+		goto cleanup;
+	}
+
+	/*
+	 * If the dir has child entries in the index, the first would be at the
+	 * position the sparse directory would be inserted. If the entry at this
+	 * position is inside the dir, not a new sparse dir.
+	 */
+	res = strncmp(o->src_index->cache[pos]->name, dirpath.buf, dirpath.len);
+
+cleanup:
+	strbuf_release(&dirpath);
+	return res;
+}
+
 /*
  * Note that traverse_by_cache_tree() duplicates some logic in this function
  * without actually calling it. If you change the logic here you may need to
@@ -1078,21 +1139,44 @@ static int unpack_single_entry(int n, unsigned long mask,
 			       unsigned long dirmask,
 			       struct cache_entry **src,
 			       const struct name_entry *names,
-			       const struct traverse_info *info)
+			       const struct traverse_info *info,
+			       int *is_new_sparse_dir)
 {
 	int i;
 	struct unpack_trees_options *o = info->data;
 	unsigned long conflicts = info->df_conflicts | dirmask;
+	const struct name_entry *p = names;
 
-	if (mask == dirmask && !src[0])
-		return 0;
+	*is_new_sparse_dir = 0;
+	if (mask == dirmask && !src[0]) {
+		/*
+		 * If we're not in a sparse index, we can't unpack a directory
+		 * without recursing into it, so we return.
+		 */
+		if (!o->src_index->sparse_index)
+			return 0;
+
+		/* Find first entry with a real name (we could use "mask" too) */
+		while (!p->mode)
+			p++;
+
+		/*
+		 * If the directory is completely missing from the index but
+		 * would otherwise be a sparse directory, we should unpack it.
+		 * If not, we'll return and continue recursively traversing the
+		 * tree.
+		 */
+		*is_new_sparse_dir = entry_is_new_sparse_dir(info, p);
+		if (!*is_new_sparse_dir)
+			return 0;
+	}
 
 	/*
-	 * When we have a sparse directory entry for src[0],
-	 * then this isn't necessarily a directory-file conflict.
+	 * When we are unpacking a sparse directory, then this isn't necessarily
+	 * a directory-file conflict.
 	 */
-	if (mask == dirmask && src[0] &&
-	    S_ISSPARSEDIR(src[0]->ce_mode))
+	if (mask == dirmask &&
+	    (*is_new_sparse_dir || (src[0] && S_ISSPARSEDIR(src[0]->ce_mode))))
 		conflicts = 0;
 
 	/*
@@ -1352,7 +1436,7 @@ static int unpack_sparse_callback(int n, unsigned long mask, unsigned long dirma
 {
 	struct cache_entry *src[MAX_UNPACK_TREES + 1] = { NULL, };
 	struct unpack_trees_options *o = info->data;
-	int ret;
+	int ret, is_new_sparse_dir;
 
 	assert(o->merge);
 
@@ -1376,7 +1460,7 @@ static int unpack_sparse_callback(int n, unsigned long mask, unsigned long dirma
 	 * "index" tree (i.e., names[0]) and adjust 'names', 'n', 'mask', and
 	 * 'dirmask' accordingly.
 	 */
-	ret = unpack_single_entry(n - 1, mask >> 1, dirmask >> 1, src, names + 1, info);
+	ret = unpack_single_entry(n - 1, mask >> 1, dirmask >> 1, src, names + 1, info, &is_new_sparse_dir);
 
 	if (src[0])
 		discard_cache_entry(src[0]);
@@ -1394,6 +1478,7 @@ static int unpack_callback(int n, unsigned long mask, unsigned long dirmask, str
 	struct cache_entry *src[MAX_UNPACK_TREES + 1] = { NULL, };
 	struct unpack_trees_options *o = info->data;
 	const struct name_entry *p = names;
+	int is_new_sparse_dir;
 
 	/* Find first entry with a real name (we could use "mask" too) */
 	while (!p->mode)
@@ -1440,7 +1525,7 @@ static int unpack_callback(int n, unsigned long mask, unsigned long dirmask, str
 		}
 	}
 
-	if (unpack_single_entry(n, mask, dirmask, src, names, info) < 0)
+	if (unpack_single_entry(n, mask, dirmask, src, names, info, &is_new_sparse_dir))
 		return -1;
 
 	if (o->merge && src[0]) {
@@ -1478,6 +1563,7 @@ static int unpack_callback(int n, unsigned long mask, unsigned long dirmask, str
 		}
 
 		if (!is_sparse_directory_entry(src[0], names, info) &&
+		    !is_new_sparse_dir &&
 		    traverse_trees_recursive(n, dirmask, mask & ~dirmask,
 						    names, info) < 0) {
 			return -1;
-- 
gitgitgadget
