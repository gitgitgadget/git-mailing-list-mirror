Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A60D5C77B75
	for <git@archiver.kernel.org>; Fri, 12 May 2023 07:05:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239897AbjELHFE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 May 2023 03:05:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240058AbjELHEp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2023 03:04:45 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87A9265B9
        for <git@vger.kernel.org>; Fri, 12 May 2023 00:04:43 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-306dbad5182so6290299f8f.1
        for <git@vger.kernel.org>; Fri, 12 May 2023 00:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683875082; x=1686467082;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sJkdwMdZjbvXjbYbGMDvUZ/CtlyY7I5G8aheyrEfFHc=;
        b=ooJIuD60BwNGRg7IINMJvqAldMhRSj4KWIrnku4YBM3mQG6CVJN/CBn3hurCnKGMPv
         /dcupizVatrDkBrh3+PTs956fhLuypHeZhUfTZSLEjJiVD2rOnEtJilX3kyd2jYT6sna
         2dnJZjiU5HNQpBwpl7IvD2gEV3NADIHUrauFStvpRigu5tlTy5hSSNSXYEkpcD+FfhRG
         pPOp/AifCLRnGZEED1KEZBwGvqvG3uUofRUemSx9nR/DV27Fo1HkVlYxVkK0aymgyRyV
         jV1I9AlbsZAMGmUXoxUSOr0sYg5q0MA888xht25X2yXgmOApViJzH+/ZnlG6yHx/d2u1
         NScA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683875082; x=1686467082;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sJkdwMdZjbvXjbYbGMDvUZ/CtlyY7I5G8aheyrEfFHc=;
        b=i9mMiBuAf9/IIBWgr1p39MF7vqDnMLRp37EehNH45dIrs6HdbxsPQJ24vz9V6e6cy8
         u2Jc6gexXJlWuXUhR2mrZ5TKnXjLsLBTyb/ekq/RYsZn/hZ+XSwAklUyxq0xPlbdwfEA
         iIa6acPqaS4KoHEHnSPxmtXqMqI5G1ykzrDoj9ihU44RvqzvxR7NeO5VOy38A30i0if7
         pOelk4hUU41WlvLKYHy8ceHWZBg8NHl1uIQjIYzb/XnHOLDk5clcQanIgoRk1vDvTS15
         opZ2GJKZnXye+ey8sEGyoZIBw2eGJf4rk5tgJnZ89ws1IWOGKUyLoo5rPeXfYO5v54N6
         nZ+A==
X-Gm-Message-State: AC+VfDyQrcD6cUVJW5tNgcpuv4GsqcHzsy6t4QndjNTs/ut7d6dMuUfb
        0djE37Ieziw1umiLXgPhIN9lNEabpZ0=
X-Google-Smtp-Source: ACHHUZ6SLyC6XCB6UdW5EPqkDQnzNxqU5O5YocKXYAB6JCnHY0+8HkM6Fz9vj5Cy6ate+QfAnTVYpQ==
X-Received: by 2002:a5d:51c4:0:b0:306:37ec:656c with SMTP id n4-20020a5d51c4000000b0030637ec656cmr16306648wrv.66.1683875081766;
        Fri, 12 May 2023 00:04:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c17-20020a5d4f11000000b003079986fd71sm13378045wru.88.2023.05.12.00.04.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 00:04:41 -0700 (PDT)
Message-Id: <ced75f464447f77fc8d89b5cc97477352f6bfd02.1683875070.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1525.v2.git.1683875068.gitgitgadget@gmail.com>
References: <pull.1525.git.1683431149.gitgitgadget@gmail.com>
        <pull.1525.v2.git.1683875068.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 12 May 2023 07:04:06 +0000
Subject: [PATCH v2 05/27] read-cache: move shared commit and ls-files code
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Calvin Wan <calvinwan@google.com>, Jeff King <peff@peff.net>,
        Glen Choo <chooglen@google.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

The function overlay_tree_on_index(), plus associated helper functions,
were defined in builtin/ls-files.c, but also shared with
builtin/commit.c.  Move these shared functions to read-cache.c.

Diff best viewed with `--color-moved`.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/ls-files.c | 137 ---------------------------------------------
 read-cache.c       | 137 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 137 insertions(+), 137 deletions(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 625f48f0d61..069b28bd484 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -516,143 +516,6 @@ static int get_common_prefix_len(const char *common_prefix)
 	return common_prefix_len;
 }
 
-static int read_one_entry_opt(struct index_state *istate,
-			      const struct object_id *oid,
-			      struct strbuf *base,
-			      const char *pathname,
-			      unsigned mode, int opt)
-{
-	int len;
-	struct cache_entry *ce;
-
-	if (S_ISDIR(mode))
-		return READ_TREE_RECURSIVE;
-
-	len = strlen(pathname);
-	ce = make_empty_cache_entry(istate, base->len + len);
-
-	ce->ce_mode = create_ce_mode(mode);
-	ce->ce_flags = create_ce_flags(1);
-	ce->ce_namelen = base->len + len;
-	memcpy(ce->name, base->buf, base->len);
-	memcpy(ce->name + base->len, pathname, len+1);
-	oidcpy(&ce->oid, oid);
-	return add_index_entry(istate, ce, opt);
-}
-
-static int read_one_entry(const struct object_id *oid, struct strbuf *base,
-			  const char *pathname, unsigned mode,
-			  void *context)
-{
-	struct index_state *istate = context;
-	return read_one_entry_opt(istate, oid, base, pathname,
-				  mode,
-				  ADD_CACHE_OK_TO_ADD|ADD_CACHE_SKIP_DFCHECK);
-}
-
-/*
- * This is used when the caller knows there is no existing entries at
- * the stage that will conflict with the entry being added.
- */
-static int read_one_entry_quick(const struct object_id *oid, struct strbuf *base,
-				const char *pathname, unsigned mode,
-				void *context)
-{
-	struct index_state *istate = context;
-	return read_one_entry_opt(istate, oid, base, pathname,
-				  mode, ADD_CACHE_JUST_APPEND);
-}
-
-/*
- * Read the tree specified with --with-tree option
- * (typically, HEAD) into stage #1 and then
- * squash them down to stage #0.  This is used for
- * --error-unmatch to list and check the path patterns
- * that were given from the command line.  We are not
- * going to write this index out.
- */
-void overlay_tree_on_index(struct index_state *istate,
-			   const char *tree_name, const char *prefix)
-{
-	struct tree *tree;
-	struct object_id oid;
-	struct pathspec pathspec;
-	struct cache_entry *last_stage0 = NULL;
-	int i;
-	read_tree_fn_t fn = NULL;
-	int err;
-
-	if (repo_get_oid(the_repository, tree_name, &oid))
-		die("tree-ish %s not found.", tree_name);
-	tree = parse_tree_indirect(&oid);
-	if (!tree)
-		die("bad tree-ish %s", tree_name);
-
-	/* Hoist the unmerged entries up to stage #3 to make room */
-	/* TODO: audit for interaction with sparse-index. */
-	ensure_full_index(istate);
-	for (i = 0; i < istate->cache_nr; i++) {
-		struct cache_entry *ce = istate->cache[i];
-		if (!ce_stage(ce))
-			continue;
-		ce->ce_flags |= CE_STAGEMASK;
-	}
-
-	if (prefix) {
-		static const char *(matchbuf[1]);
-		matchbuf[0] = NULL;
-		parse_pathspec(&pathspec, PATHSPEC_ALL_MAGIC,
-			       PATHSPEC_PREFER_CWD, prefix, matchbuf);
-	} else
-		memset(&pathspec, 0, sizeof(pathspec));
-
-	/*
-	 * See if we have cache entry at the stage.  If so,
-	 * do it the original slow way, otherwise, append and then
-	 * sort at the end.
-	 */
-	for (i = 0; !fn && i < istate->cache_nr; i++) {
-		const struct cache_entry *ce = istate->cache[i];
-		if (ce_stage(ce) == 1)
-			fn = read_one_entry;
-	}
-
-	if (!fn)
-		fn = read_one_entry_quick;
-	err = read_tree(the_repository, tree, &pathspec, fn, istate);
-	clear_pathspec(&pathspec);
-	if (err)
-		die("unable to read tree entries %s", tree_name);
-
-	/*
-	 * Sort the cache entry -- we need to nuke the cache tree, though.
-	 */
-	if (fn == read_one_entry_quick) {
-		cache_tree_free(&istate->cache_tree);
-		QSORT(istate->cache, istate->cache_nr, cmp_cache_name_compare);
-	}
-
-	for (i = 0; i < istate->cache_nr; i++) {
-		struct cache_entry *ce = istate->cache[i];
-		switch (ce_stage(ce)) {
-		case 0:
-			last_stage0 = ce;
-			/* fallthru */
-		default:
-			continue;
-		case 1:
-			/*
-			 * If there is stage #0 entry for this, we do not
-			 * need to show it.  We use CE_UPDATE bit to mark
-			 * such an entry.
-			 */
-			if (last_stage0 &&
-			    !strcmp(last_stage0->name, ce->name))
-				ce->ce_flags |= CE_UPDATE;
-		}
-	}
-}
-
 static const char * const ls_files_usage[] = {
 	N_("git ls-files [<options>] [<file>...]"),
 	NULL
diff --git a/read-cache.c b/read-cache.c
index f4c31a68c85..c0df4586c9b 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -3806,3 +3806,140 @@ void prefetch_cache_entries(const struct index_state *istate,
 				   to_fetch.oid, to_fetch.nr);
 	oid_array_clear(&to_fetch);
 }
+
+static int read_one_entry_opt(struct index_state *istate,
+			      const struct object_id *oid,
+			      struct strbuf *base,
+			      const char *pathname,
+			      unsigned mode, int opt)
+{
+	int len;
+	struct cache_entry *ce;
+
+	if (S_ISDIR(mode))
+		return READ_TREE_RECURSIVE;
+
+	len = strlen(pathname);
+	ce = make_empty_cache_entry(istate, base->len + len);
+
+	ce->ce_mode = create_ce_mode(mode);
+	ce->ce_flags = create_ce_flags(1);
+	ce->ce_namelen = base->len + len;
+	memcpy(ce->name, base->buf, base->len);
+	memcpy(ce->name + base->len, pathname, len+1);
+	oidcpy(&ce->oid, oid);
+	return add_index_entry(istate, ce, opt);
+}
+
+static int read_one_entry(const struct object_id *oid, struct strbuf *base,
+			  const char *pathname, unsigned mode,
+			  void *context)
+{
+	struct index_state *istate = context;
+	return read_one_entry_opt(istate, oid, base, pathname,
+				  mode,
+				  ADD_CACHE_OK_TO_ADD|ADD_CACHE_SKIP_DFCHECK);
+}
+
+/*
+ * This is used when the caller knows there is no existing entries at
+ * the stage that will conflict with the entry being added.
+ */
+static int read_one_entry_quick(const struct object_id *oid, struct strbuf *base,
+				const char *pathname, unsigned mode,
+				void *context)
+{
+	struct index_state *istate = context;
+	return read_one_entry_opt(istate, oid, base, pathname,
+				  mode, ADD_CACHE_JUST_APPEND);
+}
+
+/*
+ * Read the tree specified with --with-tree option
+ * (typically, HEAD) into stage #1 and then
+ * squash them down to stage #0.  This is used for
+ * --error-unmatch to list and check the path patterns
+ * that were given from the command line.  We are not
+ * going to write this index out.
+ */
+void overlay_tree_on_index(struct index_state *istate,
+			   const char *tree_name, const char *prefix)
+{
+	struct tree *tree;
+	struct object_id oid;
+	struct pathspec pathspec;
+	struct cache_entry *last_stage0 = NULL;
+	int i;
+	read_tree_fn_t fn = NULL;
+	int err;
+
+	if (repo_get_oid(the_repository, tree_name, &oid))
+		die("tree-ish %s not found.", tree_name);
+	tree = parse_tree_indirect(&oid);
+	if (!tree)
+		die("bad tree-ish %s", tree_name);
+
+	/* Hoist the unmerged entries up to stage #3 to make room */
+	/* TODO: audit for interaction with sparse-index. */
+	ensure_full_index(istate);
+	for (i = 0; i < istate->cache_nr; i++) {
+		struct cache_entry *ce = istate->cache[i];
+		if (!ce_stage(ce))
+			continue;
+		ce->ce_flags |= CE_STAGEMASK;
+	}
+
+	if (prefix) {
+		static const char *(matchbuf[1]);
+		matchbuf[0] = NULL;
+		parse_pathspec(&pathspec, PATHSPEC_ALL_MAGIC,
+			       PATHSPEC_PREFER_CWD, prefix, matchbuf);
+	} else
+		memset(&pathspec, 0, sizeof(pathspec));
+
+	/*
+	 * See if we have cache entry at the stage.  If so,
+	 * do it the original slow way, otherwise, append and then
+	 * sort at the end.
+	 */
+	for (i = 0; !fn && i < istate->cache_nr; i++) {
+		const struct cache_entry *ce = istate->cache[i];
+		if (ce_stage(ce) == 1)
+			fn = read_one_entry;
+	}
+
+	if (!fn)
+		fn = read_one_entry_quick;
+	err = read_tree(the_repository, tree, &pathspec, fn, istate);
+	clear_pathspec(&pathspec);
+	if (err)
+		die("unable to read tree entries %s", tree_name);
+
+	/*
+	 * Sort the cache entry -- we need to nuke the cache tree, though.
+	 */
+	if (fn == read_one_entry_quick) {
+		cache_tree_free(&istate->cache_tree);
+		QSORT(istate->cache, istate->cache_nr, cmp_cache_name_compare);
+	}
+
+	for (i = 0; i < istate->cache_nr; i++) {
+		struct cache_entry *ce = istate->cache[i];
+		switch (ce_stage(ce)) {
+		case 0:
+			last_stage0 = ce;
+			/* fallthru */
+		default:
+			continue;
+		case 1:
+			/*
+			 * If there is stage #0 entry for this, we do not
+			 * need to show it.  We use CE_UPDATE bit to mark
+			 * such an entry.
+			 */
+			if (last_stage0 &&
+			    !strcmp(last_stage0->name, ce->name))
+				ce->ce_flags |= CE_UPDATE;
+		}
+	}
+}
-- 
gitgitgadget

