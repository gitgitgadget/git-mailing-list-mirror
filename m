Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 108C2C77B7C
	for <git@archiver.kernel.org>; Sun,  7 May 2023 03:46:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbjEGDqQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 May 2023 23:46:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbjEGDqB (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 May 2023 23:46:01 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46BFB6E97
        for <git@vger.kernel.org>; Sat,  6 May 2023 20:45:59 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-306dbad5182so2056982f8f.1
        for <git@vger.kernel.org>; Sat, 06 May 2023 20:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683431157; x=1686023157;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sJkdwMdZjbvXjbYbGMDvUZ/CtlyY7I5G8aheyrEfFHc=;
        b=k12Vz+hqwiAvtqMaUag+4W/hp6IbRhhTWEPRzUrQZw4XoPnvCaPF1tTIhwk0yIHNv/
         k6vzUw1WLuQNIAZKC2bksTp0NahZO1kkA6/rd9+RPCUP/Bi4WE2pRtTk8vyMRdAVHo9d
         ACWxkgQuWvUq/iCMriH+D1zPp9xCHurFKINVAbKBI4+JFdA86Zq3KwKu5ATwDyxgL6Nl
         o72MrFLExAnOHsr77J5I7I/gaT4bZEzlKhceaSyB4CLOi2yjH+5ZevQ0nb/eVFCZteJq
         NbFecGDs3LkN6Sw8HMUYVoXrg0rBTggRr2tXa0puBErwY4vwNupwcWx+8Ta+vWekpYAv
         8g6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683431157; x=1686023157;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sJkdwMdZjbvXjbYbGMDvUZ/CtlyY7I5G8aheyrEfFHc=;
        b=WeDxdwS9VBI5Tc72UI5ZaXS6Yux91nA11LzS9SyTFrabXfOdY0X36JMv2vEjO502E9
         lfrft/5JpqhK91yIVsoPL3Gi7x9Rc8a35K+sOfG8D5REJX/iedY81539nEYX6zmMuEE7
         gpFNxwQcsATh3wWv3pr5+TsSf1G6/SgRGcmMg+cMCniAciY1Iqv2Ply4NGYllegfuiji
         7DyHGfac9vtQsynRqT7ho3d9DxzavC2C+uzjRnDAFQVc3/iYTFk14E5+pFuNGD9VV4jW
         2V67b87BSGf31im/QDninxJ9ZElvrUZqAciYrabpug3/pLm6GdnUN+l5hrU7uogxtzXn
         IrQg==
X-Gm-Message-State: AC+VfDw32ZM0voIlcprdkZWntte8Gd9n42A+Y5GATD1afrR2JnZ4FltM
        Gwpr9sEUJ3IRPruBv31ppZIQGITaA2Q=
X-Google-Smtp-Source: ACHHUZ51nVfhiCHM9BgNzJURFwo+bEMjvZfquCRcPvjd4J1EbFalk0LVjHB3l3MCfGD4q4M54IwwTw==
X-Received: by 2002:adf:f985:0:b0:307:8555:35e1 with SMTP id f5-20020adff985000000b00307855535e1mr3194170wrr.19.1683431157394;
        Sat, 06 May 2023 20:45:57 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j10-20020adff54a000000b00304b5b2f5ffsm7005060wrp.53.2023.05.06.20.45.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 May 2023 20:45:57 -0700 (PDT)
Message-Id: <d5a5b511f6ddb7bad9c723581c8c83ae0644f3b8.1683431151.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1525.git.1683431149.gitgitgadget@gmail.com>
References: <pull.1525.git.1683431149.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 07 May 2023 03:45:29 +0000
Subject: [PATCH 04/24] read-cache: move shared commit and ls-files code
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
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

