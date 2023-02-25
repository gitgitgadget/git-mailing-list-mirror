Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7B90C64ED8
	for <git@archiver.kernel.org>; Sat, 25 Feb 2023 02:26:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbjBYC0g (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Feb 2023 21:26:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjBYC01 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2023 21:26:27 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D0E34617A
        for <git@vger.kernel.org>; Fri, 24 Feb 2023 18:26:11 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id l1so1029934wry.10
        for <git@vger.kernel.org>; Fri, 24 Feb 2023 18:26:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dMbb9MPRJd861S/IpqkPMj7e9HmpWFjSVOIHk/6QDEQ=;
        b=kVo3Mzwjch8Kmk+7HDawzvnPYriYOozsiu7Y00EmlY55b3FFU6W9PJ/bZheMsJgFTt
         jitPMO+3XaZv6C/HKZtV71IKueaBgmOmh08n4H4nilcOKElzaxKVvCVc50ZXYbWf4yhA
         IEc74dFOUeVq+MVBQZWhDyt5Gp4AB77CXGRm/Q86otYQmA1fKHu+jD1ZHRRVLL9O+cR+
         k0OBDdjz6vVfHaqeDglrpoOtyEaQSqij+IFtChzo34Z0iokwKUdPcS4hmAgMCc7kPtwe
         H+cG6dSFopkZzagFHPAeXAO+b50nBhNvew+afC/HFplI4OP8mJDuEjIneQ73lUlRpJqI
         Nt7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dMbb9MPRJd861S/IpqkPMj7e9HmpWFjSVOIHk/6QDEQ=;
        b=ZUGoY6RcSqOgbiRufeVgX/sYbf7UA+Mp+nAxkx84IRpkfF3ld7jHGj8ihF9ux96rd2
         +pRi4eHgeEuMsVCWG25IhUUy5+yiTj1j68FZzYNZxbKwovVmDeik9nUp/j8QA0MekTeo
         fqI6IY+LraxOutyaBZx3VUSXMIuJnkVALMezHaLdOuT+yX3Lwtl2sSHWfNbxBIEOfjUx
         Kpml+F8jWcHDkUgeDQX+jLOb810iuW/woV1OwxnjKkrZL8fefDDFzPDIbre1L1Uv94/X
         5LQ0QVOZgYoNZYr6z3fSD9P0gUaFEuktzf1hjPI8TAwGVN6NjKHriqud7yrlC9YdjBeJ
         F53w==
X-Gm-Message-State: AO0yUKWCgokp+zTnNIMYOHtk22wufHjzzC1fRaDFx8m7H3bDDg68ZQUf
        U1woX0DfuaeeuctLb/yBdaX1kbjS5wQ=
X-Google-Smtp-Source: AK7set8NcvpaRYzzIrGX/3S2nzAF4OlEGIDVjrBI7xPIP7Zh36OM4yYKTdAi/giIOhAaBdopo5tP7Q==
X-Received: by 2002:a05:6000:1008:b0:2c5:7f21:1277 with SMTP id a8-20020a056000100800b002c57f211277mr17448171wrx.68.1677291969195;
        Fri, 24 Feb 2023 18:26:09 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o18-20020a05600c4fd200b003eaf666cbe0sm975085wmq.27.2023.02.24.18.26.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 18:26:08 -0800 (PST)
Message-Id: <8ecb24a45f08e58c081a53557eb147b5e65a42cf.1677291961.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1149.v2.git.1677291960.gitgitgadget@gmail.com>
References: <pull.1149.git.1677143700.gitgitgadget@gmail.com>
        <pull.1149.v2.git.1677291960.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 25 Feb 2023 02:25:57 +0000
Subject: [PATCH v2 08/11] unpack-trees: mark fields only used internally as
 internal
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Continue the work from the previous patch by finding additional fields
which are only used internally but not yet explicitly marked as such,
and include them in the internal fields struct.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 unpack-trees.c | 159 +++++++++++++++++++++++++------------------------
 unpack-trees.h |  26 ++++----
 2 files changed, 95 insertions(+), 90 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index c659af67c62..f5294194aa1 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -66,8 +66,8 @@ static const char *unpack_plumbing_errors[NB_UNPACK_TREES_WARNING_TYPES] = {
 };
 
 #define ERRORMSG(o,type) \
-	( ((o) && (o)->msgs[(type)]) \
-	  ? ((o)->msgs[(type)])      \
+	( ((o) && (o)->internal.msgs[(type)]) \
+	  ? ((o)->internal.msgs[(type)])      \
 	  : (unpack_plumbing_errors[(type)]) )
 
 static const char *super_prefixed(const char *path, const char *super_prefix)
@@ -108,10 +108,10 @@ void setup_unpack_trees_porcelain(struct unpack_trees_options *opts,
 				  const char *cmd)
 {
 	int i;
-	const char **msgs = opts->msgs;
+	const char **msgs = opts->internal.msgs;
 	const char *msg;
 
-	strvec_init(&opts->msgs_to_free);
+	strvec_init(&opts->internal.msgs_to_free);
 
 	if (!strcmp(cmd, "checkout"))
 		msg = advice_enabled(ADVICE_COMMIT_BEFORE_MERGE)
@@ -129,7 +129,7 @@ void setup_unpack_trees_porcelain(struct unpack_trees_options *opts,
 			  "Please commit your changes or stash them before you %s.")
 		      : _("Your local changes to the following files would be overwritten by %s:\n%%s");
 	msgs[ERROR_WOULD_OVERWRITE] = msgs[ERROR_NOT_UPTODATE_FILE] =
-		strvec_pushf(&opts->msgs_to_free, msg, cmd, cmd);
+		strvec_pushf(&opts->internal.msgs_to_free, msg, cmd, cmd);
 
 	msgs[ERROR_NOT_UPTODATE_DIR] =
 		_("Updating the following directories would lose untracked files in them:\n%s");
@@ -153,7 +153,7 @@ void setup_unpack_trees_porcelain(struct unpack_trees_options *opts,
 			  "Please move or remove them before you %s.")
 		      : _("The following untracked working tree files would be removed by %s:\n%%s");
 	msgs[ERROR_WOULD_LOSE_UNTRACKED_REMOVED] =
-		strvec_pushf(&opts->msgs_to_free, msg, cmd, cmd);
+		strvec_pushf(&opts->internal.msgs_to_free, msg, cmd, cmd);
 
 	if (!strcmp(cmd, "checkout"))
 		msg = advice_enabled(ADVICE_COMMIT_BEFORE_MERGE)
@@ -171,7 +171,7 @@ void setup_unpack_trees_porcelain(struct unpack_trees_options *opts,
 			  "Please move or remove them before you %s.")
 		      : _("The following untracked working tree files would be overwritten by %s:\n%%s");
 	msgs[ERROR_WOULD_LOSE_UNTRACKED_OVERWRITTEN] =
-		strvec_pushf(&opts->msgs_to_free, msg, cmd, cmd);
+		strvec_pushf(&opts->internal.msgs_to_free, msg, cmd, cmd);
 
 	/*
 	 * Special case: ERROR_BIND_OVERLAP refers to a pair of paths, we
@@ -189,16 +189,16 @@ void setup_unpack_trees_porcelain(struct unpack_trees_options *opts,
 	msgs[WARNING_SPARSE_ORPHANED_NOT_OVERWRITTEN] =
 		_("The following paths were already present and thus not updated despite sparse patterns:\n%s");
 
-	opts->show_all_errors = 1;
+	opts->internal.show_all_errors = 1;
 	/* rejected paths may not have a static buffer */
-	for (i = 0; i < ARRAY_SIZE(opts->unpack_rejects); i++)
-		opts->unpack_rejects[i].strdup_strings = 1;
+	for (i = 0; i < ARRAY_SIZE(opts->internal.unpack_rejects); i++)
+		opts->internal.unpack_rejects[i].strdup_strings = 1;
 }
 
 void clear_unpack_trees_porcelain(struct unpack_trees_options *opts)
 {
-	strvec_clear(&opts->msgs_to_free);
-	memset(opts->msgs, 0, sizeof(opts->msgs));
+	strvec_clear(&opts->internal.msgs_to_free);
+	memset(opts->internal.msgs, 0, sizeof(opts->internal.msgs));
 }
 
 static int do_add_entry(struct unpack_trees_options *o, struct cache_entry *ce,
@@ -210,7 +210,7 @@ static int do_add_entry(struct unpack_trees_options *o, struct cache_entry *ce,
 		set |= CE_WT_REMOVE;
 
 	ce->ce_flags = (ce->ce_flags & ~clear) | set;
-	return add_index_entry(&o->result, ce,
+	return add_index_entry(&o->internal.result, ce,
 			       ADD_CACHE_OK_TO_ADD | ADD_CACHE_OK_TO_REPLACE);
 }
 
@@ -218,7 +218,7 @@ static void add_entry(struct unpack_trees_options *o,
 		      const struct cache_entry *ce,
 		      unsigned int set, unsigned int clear)
 {
-	do_add_entry(o, dup_cache_entry(ce, &o->result), set, clear);
+	do_add_entry(o, dup_cache_entry(ce, &o->internal.result), set, clear);
 }
 
 /*
@@ -233,7 +233,7 @@ static int add_rejected_path(struct unpack_trees_options *o,
 	if (o->quiet)
 		return -1;
 
-	if (!o->show_all_errors)
+	if (!o->internal.show_all_errors)
 		return error(ERRORMSG(o, e), super_prefixed(path,
 							    o->super_prefix));
 
@@ -241,7 +241,7 @@ static int add_rejected_path(struct unpack_trees_options *o,
 	 * Otherwise, insert in a list for future display by
 	 * display_(error|warning)_msgs()
 	 */
-	string_list_append(&o->unpack_rejects[e], path);
+	string_list_append(&o->internal.unpack_rejects[e], path);
 	return -1;
 }
 
@@ -253,7 +253,7 @@ static void display_error_msgs(struct unpack_trees_options *o)
 	int e;
 	unsigned error_displayed = 0;
 	for (e = 0; e < NB_UNPACK_TREES_ERROR_TYPES; e++) {
-		struct string_list *rejects = &o->unpack_rejects[e];
+		struct string_list *rejects = &o->internal.unpack_rejects[e];
 
 		if (rejects->nr > 0) {
 			int i;
@@ -281,7 +281,7 @@ static void display_warning_msgs(struct unpack_trees_options *o)
 	unsigned warning_displayed = 0;
 	for (e = NB_UNPACK_TREES_ERROR_TYPES + 1;
 	     e < NB_UNPACK_TREES_WARNING_TYPES; e++) {
-		struct string_list *rejects = &o->unpack_rejects[e];
+		struct string_list *rejects = &o->internal.unpack_rejects[e];
 
 		if (rejects->nr > 0) {
 			int i;
@@ -600,13 +600,14 @@ static void mark_ce_used(struct cache_entry *ce, struct unpack_trees_options *o)
 {
 	ce->ce_flags |= CE_UNPACKED;
 
-	if (o->cache_bottom < o->src_index->cache_nr &&
-	    o->src_index->cache[o->cache_bottom] == ce) {
-		int bottom = o->cache_bottom;
+	if (o->internal.cache_bottom < o->src_index->cache_nr &&
+	    o->src_index->cache[o->internal.cache_bottom] == ce) {
+		int bottom = o->internal.cache_bottom;
+
 		while (bottom < o->src_index->cache_nr &&
 		       o->src_index->cache[bottom]->ce_flags & CE_UNPACKED)
 			bottom++;
-		o->cache_bottom = bottom;
+		o->internal.cache_bottom = bottom;
 	}
 }
 
@@ -652,7 +653,7 @@ static void mark_ce_used_same_name(struct cache_entry *ce,
 static struct cache_entry *next_cache_entry(struct unpack_trees_options *o)
 {
 	const struct index_state *index = o->src_index;
-	int pos = o->cache_bottom;
+	int pos = o->internal.cache_bottom;
 
 	while (pos < index->cache_nr) {
 		struct cache_entry *ce = index->cache[pos];
@@ -711,7 +712,7 @@ static void restore_cache_bottom(struct traverse_info *info, int bottom)
 
 	if (o->diff_index_cached)
 		return;
-	o->cache_bottom = bottom;
+	o->internal.cache_bottom = bottom;
 }
 
 static int switch_cache_bottom(struct traverse_info *info)
@@ -721,13 +722,13 @@ static int switch_cache_bottom(struct traverse_info *info)
 
 	if (o->diff_index_cached)
 		return 0;
-	ret = o->cache_bottom;
+	ret = o->internal.cache_bottom;
 	pos = find_cache_pos(info->prev, info->name, info->namelen);
 
 	if (pos < -1)
-		o->cache_bottom = -2 - pos;
+		o->internal.cache_bottom = -2 - pos;
 	else if (pos < 0)
-		o->cache_bottom = o->src_index->cache_nr;
+		o->internal.cache_bottom = o->src_index->cache_nr;
 	return ret;
 }
 
@@ -873,9 +874,9 @@ static int traverse_trees_recursive(int n, unsigned long dirmask,
 		 * save and restore cache_bottom anyway to not miss
 		 * unprocessed entries before 'pos'.
 		 */
-		bottom = o->cache_bottom;
+		bottom = o->internal.cache_bottom;
 		ret = traverse_by_cache_tree(pos, nr_entries, n, info);
-		o->cache_bottom = bottom;
+		o->internal.cache_bottom = bottom;
 		return ret;
 	}
 
@@ -1212,7 +1213,7 @@ static int unpack_single_entry(int n, unsigned long mask,
 		 * cache entry from the index aware logic.
 		 */
 		src[i + o->merge] = create_ce_entry(info, names + i, stage,
-						    &o->result, o->merge,
+						    &o->internal.result, o->merge,
 						    bit & dirmask);
 	}
 
@@ -1237,7 +1238,7 @@ static int unpack_single_entry(int n, unsigned long mask,
 
 static int unpack_failed(struct unpack_trees_options *o, const char *message)
 {
-	discard_index(&o->result);
+	discard_index(&o->internal.result);
 	if (!o->quiet && !o->exiting_early) {
 		if (message)
 			return error("%s", message);
@@ -1260,7 +1261,7 @@ static int find_cache_pos(struct traverse_info *info,
 	struct index_state *index = o->src_index;
 	int pfxlen = info->pathlen;
 
-	for (pos = o->cache_bottom; pos < index->cache_nr; pos++) {
+	for (pos = o->internal.cache_bottom; pos < index->cache_nr; pos++) {
 		const struct cache_entry *ce = index->cache[pos];
 		const char *ce_name, *ce_slash;
 		int cmp, ce_len;
@@ -1271,8 +1272,8 @@ static int find_cache_pos(struct traverse_info *info,
 			 * we can never match it; don't check it
 			 * again.
 			 */
-			if (pos == o->cache_bottom)
-				++o->cache_bottom;
+			if (pos == o->internal.cache_bottom)
+				++o->internal.cache_bottom;
 			continue;
 		}
 		if (!ce_in_traverse_path(ce, info)) {
@@ -1450,7 +1451,7 @@ static int unpack_sparse_callback(int n, unsigned long mask, unsigned long dirma
 	 */
 	if (!is_null_oid(&names[0].oid)) {
 		src[0] = create_ce_entry(info, &names[0], 0,
-					&o->result, 1,
+					&o->internal.result, 1,
 					dirmask & (1ul << 0));
 		src[0]->ce_flags |= (CE_SKIP_WORKTREE | CE_NEW_SKIP_WORKTREE);
 	}
@@ -1560,7 +1561,7 @@ static int unpack_callback(int n, unsigned long mask, unsigned long dirmask, str
 				 * in 'mark_ce_used()'
 				 */
 				if (!src[0] || !S_ISSPARSEDIR(src[0]->ce_mode))
-					o->cache_bottom += matches;
+					o->internal.cache_bottom += matches;
 				return mask;
 			}
 		}
@@ -1907,37 +1908,37 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 		populate_from_existing_patterns(o, &pl);
 	}
 
-	index_state_init(&o->result, o->src_index->repo);
-	o->result.initialized = 1;
-	o->result.timestamp.sec = o->src_index->timestamp.sec;
-	o->result.timestamp.nsec = o->src_index->timestamp.nsec;
-	o->result.version = o->src_index->version;
+	index_state_init(&o->internal.result, o->src_index->repo);
+	o->internal.result.initialized = 1;
+	o->internal.result.timestamp.sec = o->src_index->timestamp.sec;
+	o->internal.result.timestamp.nsec = o->src_index->timestamp.nsec;
+	o->internal.result.version = o->src_index->version;
 	if (!o->src_index->split_index) {
-		o->result.split_index = NULL;
+		o->internal.result.split_index = NULL;
 	} else if (o->src_index == o->dst_index) {
 		/*
 		 * o->dst_index (and thus o->src_index) will be discarded
-		 * and overwritten with o->result at the end of this function,
+		 * and overwritten with o->internal.result at the end of this function,
 		 * so just use src_index's split_index to avoid having to
 		 * create a new one.
 		 */
-		o->result.split_index = o->src_index->split_index;
-		o->result.split_index->refcount++;
+		o->internal.result.split_index = o->src_index->split_index;
+		o->internal.result.split_index->refcount++;
 	} else {
-		o->result.split_index = init_split_index(&o->result);
+		o->internal.result.split_index = init_split_index(&o->internal.result);
 	}
-	oidcpy(&o->result.oid, &o->src_index->oid);
+	oidcpy(&o->internal.result.oid, &o->src_index->oid);
 	o->merge_size = len;
 	mark_all_ce_unused(o->src_index);
 
-	o->result.fsmonitor_last_update =
+	o->internal.result.fsmonitor_last_update =
 		xstrdup_or_null(o->src_index->fsmonitor_last_update);
-	o->result.fsmonitor_has_run_once = o->src_index->fsmonitor_has_run_once;
+	o->internal.result.fsmonitor_has_run_once = o->src_index->fsmonitor_has_run_once;
 
 	if (!o->src_index->initialized &&
 	    !repo->settings.command_requires_full_index &&
-	    is_sparse_index_allowed(&o->result, 0))
-		o->result.sparse_index = 1;
+	    is_sparse_index_allowed(&o->internal.result, 0))
+		o->internal.result.sparse_index = 1;
 
 	/*
 	 * Sparse checkout loop #1: set NEW_SKIP_WORKTREE on existing entries
@@ -1957,7 +1958,7 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 		setup_traverse_info(&info, prefix);
 		info.fn = unpack_callback;
 		info.data = o;
-		info.show_all_errors = o->show_all_errors;
+		info.show_all_errors = o->internal.show_all_errors;
 		info.pathspec = o->pathspec;
 
 		if (o->prefix) {
@@ -1998,7 +1999,7 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 	}
 	mark_all_ce_unused(o->src_index);
 
-	if (o->trivial_merges_only && o->nontrivial_merge) {
+	if (o->trivial_merges_only && o->internal.nontrivial_merge) {
 		ret = unpack_failed(o, "Merge requires file-level merging");
 		goto done;
 	}
@@ -2009,13 +2010,13 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 		 * If they will have NEW_SKIP_WORKTREE, also set CE_SKIP_WORKTREE
 		 * so apply_sparse_checkout() won't attempt to remove it from worktree
 		 */
-		mark_new_skip_worktree(o->internal.pl, &o->result,
+		mark_new_skip_worktree(o->internal.pl, &o->internal.result,
 				       CE_ADDED, CE_SKIP_WORKTREE | CE_NEW_SKIP_WORKTREE,
 				       o->verbose_update);
 
 		ret = 0;
-		for (i = 0; i < o->result.cache_nr; i++) {
-			struct cache_entry *ce = o->result.cache[i];
+		for (i = 0; i < o->internal.result.cache_nr; i++) {
+			struct cache_entry *ce = o->internal.result.cache[i];
 
 			/*
 			 * Entries marked with CE_ADDED in merged_entry() do not have
@@ -2029,7 +2030,7 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 			    verify_absent(ce, WARNING_SPARSE_ORPHANED_NOT_OVERWRITTEN, o))
 				ret = 1;
 
-			if (apply_sparse_checkout(&o->result, ce, o))
+			if (apply_sparse_checkout(&o->internal.result, ce, o))
 				ret = 1;
 		}
 		if (ret == 1) {
@@ -2037,30 +2038,30 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 			 * Inability to sparsify or de-sparsify individual
 			 * paths is not an error, but just a warning.
 			 */
-			if (o->show_all_errors)
+			if (o->internal.show_all_errors)
 				display_warning_msgs(o);
 			ret = 0;
 		}
 	}
 
-	ret = check_updates(o, &o->result) ? (-2) : 0;
+	ret = check_updates(o, &o->internal.result) ? (-2) : 0;
 	if (o->dst_index) {
-		move_index_extensions(&o->result, o->src_index);
+		move_index_extensions(&o->internal.result, o->src_index);
 		if (!ret) {
 			if (git_env_bool("GIT_TEST_CHECK_CACHE_TREE", 0))
-				cache_tree_verify(the_repository, &o->result);
+				cache_tree_verify(the_repository, &o->internal.result);
 			if (!o->skip_cache_tree_update &&
-			    !cache_tree_fully_valid(o->result.cache_tree))
-				cache_tree_update(&o->result,
+			    !cache_tree_fully_valid(o->internal.result.cache_tree))
+				cache_tree_update(&o->internal.result,
 						  WRITE_TREE_SILENT |
 						  WRITE_TREE_REPAIR);
 		}
 
-		o->result.updated_workdir = 1;
+		o->internal.result.updated_workdir = 1;
 		discard_index(o->dst_index);
-		*o->dst_index = o->result;
+		*o->dst_index = o->internal.result;
 	} else {
-		discard_index(&o->result);
+		discard_index(&o->internal.result);
 	}
 	o->src_index = NULL;
 
@@ -2076,7 +2077,7 @@ done:
 	return ret;
 
 return_failed:
-	if (o->show_all_errors)
+	if (o->internal.show_all_errors)
 		display_error_msgs(o);
 	mark_all_ce_unused(o->src_index);
 	ret = unpack_failed(o, NULL);
@@ -2099,9 +2100,9 @@ enum update_sparsity_result update_sparsity(struct unpack_trees_options *o,
 	unsigned old_show_all_errors;
 	int free_pattern_list = 0;
 
-	old_show_all_errors = o->show_all_errors;
-	o->show_all_errors = 1;
-	index_state_init(&o->result, o->src_index->repo);
+	old_show_all_errors = o->internal.show_all_errors;
+	o->internal.show_all_errors = 1;
+	index_state_init(&o->internal.result, o->src_index->repo);
 
 	/* Sanity checks */
 	if (!o->update || o->index_only || o->skip_sparse_checkout)
@@ -2148,7 +2149,7 @@ enum update_sparsity_result update_sparsity(struct unpack_trees_options *o,
 		ret = UPDATE_SPARSITY_WORKTREE_UPDATE_FAILURES;
 
 	display_warning_msgs(o);
-	o->show_all_errors = old_show_all_errors;
+	o->internal.show_all_errors = old_show_all_errors;
 	if (free_pattern_list) {
 		clear_pattern_list(pl);
 		free(pl);
@@ -2248,15 +2249,15 @@ static int verify_uptodate_sparse(const struct cache_entry *ce,
 }
 
 /*
- * TODO: We should actually invalidate o->result, not src_index [1].
+ * TODO: We should actually invalidate o->internal.result, not src_index [1].
  * But since cache tree and untracked cache both are not copied to
- * o->result until unpacking is complete, we invalidate them on
+ * o->internal.result until unpacking is complete, we invalidate them on
  * src_index instead with the assumption that they will be copied to
  * dst_index at the end.
  *
  * [1] src_index->cache_tree is also used in unpack_callback() so if
- * we invalidate o->result, we need to update it to use
- * o->result.cache_tree as well.
+ * we invalidate o->internal.result, we need to update it to use
+ * o->internal.result.cache_tree as well.
  */
 static void invalidate_ce_path(const struct cache_entry *ce,
 			       struct unpack_trees_options *o)
@@ -2424,7 +2425,7 @@ static int check_ok_to_remove(const char *name, int len, int dtype,
 	 * delete this path, which is in a subdirectory that
 	 * is being replaced with a blob.
 	 */
-	result = index_file_exists(&o->result, name, len, 0);
+	result = index_file_exists(&o->internal.result, name, len, 0);
 	if (result) {
 		if (result->ce_flags & CE_REMOVE)
 			return 0;
@@ -2525,7 +2526,7 @@ static int merged_entry(const struct cache_entry *ce,
 			struct unpack_trees_options *o)
 {
 	int update = CE_UPDATE;
-	struct cache_entry *merge = dup_cache_entry(ce, &o->result);
+	struct cache_entry *merge = dup_cache_entry(ce, &o->internal.result);
 
 	if (!old) {
 		/*
@@ -2620,7 +2621,7 @@ static int merged_sparse_dir(const struct cache_entry * const *src, int n,
 	setup_traverse_info(&info, src[0]->name);
 	info.fn = unpack_sparse_callback;
 	info.data = o;
-	info.show_all_errors = o->show_all_errors;
+	info.show_all_errors = o->internal.show_all_errors;
 	info.pathspec = o->pathspec;
 
 	/* Get the tree descriptors of the sparse directory in each of the merging trees */
@@ -2838,7 +2839,7 @@ int threeway_merge(const struct cache_entry * const *stages,
 			return -1;
 	}
 
-	o->nontrivial_merge = 1;
+	o->internal.nontrivial_merge = 1;
 
 	/* #2, #3, #4, #6, #7, #9, #10, #11. */
 	count = 0;
diff --git a/unpack-trees.h b/unpack-trees.h
index 5c1a9314a06..0335c89bc75 100644
--- a/unpack-trees.h
+++ b/unpack-trees.h
@@ -59,7 +59,6 @@ struct unpack_trees_options {
 		     preserve_ignored,
 		     clone,
 		     index_only,
-		     nontrivial_merge,
 		     trivial_merges_only,
 		     verbose_update,
 		     aggressive,
@@ -70,22 +69,13 @@ struct unpack_trees_options {
 		     skip_sparse_checkout,
 		     quiet,
 		     exiting_early,
-		     show_all_errors,
 		     dry_run,
 		     skip_cache_tree_update;
 	enum unpack_trees_reset_type reset;
 	const char *prefix;
 	const char *super_prefix;
-	int cache_bottom;
 	struct pathspec *pathspec;
 	merge_fn_t fn;
-	const char *msgs[NB_UNPACK_TREES_WARNING_TYPES];
-	struct strvec msgs_to_free;
-	/*
-	 * Store error messages in an array, each case
-	 * corresponding to a error message type
-	 */
-	struct string_list unpack_rejects[NB_UNPACK_TREES_WARNING_TYPES];
 
 	int head_idx;
 	int merge_size;
@@ -95,11 +85,25 @@ struct unpack_trees_options {
 
 	struct index_state *dst_index;
 	struct index_state *src_index;
-	struct index_state result;
 
 	struct checkout_metadata meta;
 
 	struct unpack_trees_options_internal {
+		unsigned int nontrivial_merge,
+			     show_all_errors;
+
+		int cache_bottom;
+		const char *msgs[NB_UNPACK_TREES_WARNING_TYPES];
+		struct strvec msgs_to_free;
+
+		/*
+		 * Store error messages in an array, each case
+		 * corresponding to a error message type
+		 */
+		struct string_list unpack_rejects[NB_UNPACK_TREES_WARNING_TYPES];
+
+		struct index_state result;
+
 		struct pattern_list *pl;
 		struct dir_struct *dir;
 	} internal;
-- 
gitgitgadget

