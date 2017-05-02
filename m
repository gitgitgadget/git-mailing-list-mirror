Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 325F1207E3
	for <e@80x24.org>; Tue,  2 May 2017 22:24:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751760AbdEBWYM (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 May 2017 18:24:12 -0400
Received: from mail-pg0-f48.google.com ([74.125.83.48]:34835 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751700AbdEBWXq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2017 18:23:46 -0400
Received: by mail-pg0-f48.google.com with SMTP id o3so62834918pgn.2
        for <git@vger.kernel.org>; Tue, 02 May 2017 15:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pHpPDJWWRUaFFct9APB6ar2+mwM8S69A3fjr6d+oGSM=;
        b=Ts7TjLGTxeHclf2+mHQoLbZZrO6cijGYL3A247a1NhjUZ1XkBXM9bOky/OUnVvXvSH
         10K18GO6NPWkyVpGYDs12PtrlLVXr5E2/jO2y5q0V1plpnyfIm8R4FihYr+HAmGeFtQ4
         2yLRFTKDQPotsy9Vpsn2EyhORHlo+qbV8m5Ub8I3b/XD8GlYGvkaZi6ZAuKJSYeXc1Nz
         VQKmh/VhNj8pZx9OEMExpbjzZMKR724+JhYg1Bl7PDk5uziQB4REL6n2l+32bdEZZbLe
         HbXhNZqxnXBsSuUqqokhvga+cLhQ9C/2c+KUSZfDPmjhgACxMRgBZBhHhXNSpZLhT4Zz
         gj5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pHpPDJWWRUaFFct9APB6ar2+mwM8S69A3fjr6d+oGSM=;
        b=PznYE0rCnym2od//9p50r3nGn6/oykLHBLRYcPPl68kiaGqIxP27Lr6298f49n4sro
         i489ZLC5LjvqYTC2+tyfonDUB+YQE+pTcQgybgfjgFyYRw+IEBMnfawiGtEewWjcds3D
         HEBJbllT+9/fEzNWB54UQ2o1SPZdXxE8nWj0nJdZxmg7rtBCSOm97w85atTM+2Fb84de
         JRQi7Lh6KFK1DfqhX4na7/IQdUN4EWqcR5PoIQ8utoCQ6mtHasJ7y8Qpd+6XRV4UzYns
         zmyjehJ/1TSWw+cLOQRVpJl7pDlx/ZsL9yjg+S3OBtgjhzlTaOQAn0dwjvBlO6MG4MQ2
         dMuw==
X-Gm-Message-State: AN3rC/4s9opB9ZmBsksvVF6QexUJEbqXnjaZpIV3mQimBczLE8nvGuL/
        A8j1Ny7BDrRzO0UVUeqo7Q==
X-Received: by 10.84.142.101 with SMTP id 92mr45521362plw.112.1493763825623;
        Tue, 02 May 2017 15:23:45 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:c805:cf1:74c5:2e74])
        by smtp.gmail.com with ESMTPSA id y78sm674933pff.107.2017.05.02.15.23.44
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 02 May 2017 15:23:45 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, git@jeffhostetler.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH 14/24] cache.h: drop cache_name_pos
Date:   Tue,  2 May 2017 15:23:12 -0700
Message-Id: <20170502222322.21055-15-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.rc1.39.ga6db8bfa24
In-Reply-To: <20170502222322.21055-1-sbeller@google.com>
References: <20170502222322.21055-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

coccinelle patch:
@@ expression name, namelen; @@
-cache_name_pos(name, namelen)
+index_name_pos(&the_index, name, namelen)

Additionally manual editing:
 * drop the define from cache.h.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 apply.c                  |  9 +++++----
 builtin/blame.c          |  4 ++--
 builtin/checkout-index.c |  2 +-
 builtin/checkout.c       |  2 +-
 builtin/ls-files.c       |  7 ++++---
 builtin/merge-index.c    |  2 +-
 builtin/mv.c             |  8 ++++----
 builtin/rm.c             |  4 ++--
 builtin/update-index.c   | 10 +++++-----
 cache.h                  |  1 -
 diff.c                   |  2 +-
 dir.c                    |  8 ++++----
 merge-recursive.c        |  4 ++--
 pathspec.c               |  2 +-
 rerere.c                 |  2 +-
 sha1_name.c              |  6 +++---
 submodule.c              |  2 +-
 wt-status.c              |  4 ++--
 18 files changed, 40 insertions(+), 39 deletions(-)

diff --git a/apply.c b/apply.c
index eb8eaeabec..bb1cd77c66 100644
--- a/apply.c
+++ b/apply.c
@@ -3496,7 +3496,7 @@ static int load_current(struct apply_state *state,
 	if (!patch->is_new)
 		die("BUG: patch to %s is not a creation", patch->old_name);
 
-	pos = cache_name_pos(name, strlen(name));
+	pos = index_name_pos(&the_index, name, strlen(name));
 	if (pos < 0)
 		return error(_("%s: does not exist in index"), name);
 	ce = the_index.cache[pos];
@@ -3665,7 +3665,8 @@ static int check_preimage(struct apply_state *state,
 	}
 
 	if (state->check_index && !previous) {
-		int pos = cache_name_pos(old_name, strlen(old_name));
+		int pos = index_name_pos(&the_index, old_name,
+					 strlen(old_name));
 		if (pos < 0) {
 			if (patch->is_new < 0)
 				goto is_new;
@@ -3721,7 +3722,7 @@ static int check_to_create(struct apply_state *state,
 	struct stat nst;
 
 	if (state->check_index &&
-	    cache_name_pos(new_name, strlen(new_name)) >= 0 &&
+	    index_name_pos(&the_index, new_name, strlen(new_name)) >= 0 &&
 	    !ok_if_exists)
 		return EXISTS_IN_INDEX;
 	if (state->cached)
@@ -3998,7 +3999,7 @@ static int get_current_oid(struct apply_state *state, const char *path,
 
 	if (read_apply_cache(state) < 0)
 		return -1;
-	pos = cache_name_pos(path, strlen(path));
+	pos = index_name_pos(&the_index, path, strlen(path));
 	if (pos < 0)
 		return -1;
 	oidcpy(oid, &the_index.cache[pos]->oid);
diff --git a/builtin/blame.c b/builtin/blame.c
index b47aae25d4..c71d9a3340 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -2239,7 +2239,7 @@ static void verify_working_tree_path(struct commit *work_tree, const char *path)
 			return;
 	}
 
-	pos = cache_name_pos(path, strlen(path));
+	pos = index_name_pos(&the_index, path, strlen(path));
 	if (pos >= 0)
 		; /* path is in the index */
 	else if (-1 - pos < the_index.cache_nr &&
@@ -2399,7 +2399,7 @@ static struct commit *fake_working_tree_commit(struct diff_options *opt,
 
 	len = strlen(path);
 	if (!mode) {
-		int pos = cache_name_pos(path, len);
+		int pos = index_name_pos(&the_index, path, len);
 		if (0 <= pos)
 			mode = the_index.cache[pos]->ce_mode;
 		else
diff --git a/builtin/checkout-index.c b/builtin/checkout-index.c
index 1c3dcc1a8b..e8fc24b2ce 100644
--- a/builtin/checkout-index.c
+++ b/builtin/checkout-index.c
@@ -46,7 +46,7 @@ static void write_tempfile_record(const char *name, const char *prefix)
 static int checkout_file(const char *name, const char *prefix)
 {
 	int namelen = strlen(name);
-	int pos = cache_name_pos(name, namelen);
+	int pos = index_name_pos(&the_index, name, namelen);
 	int has_same_name = 0;
 	int did_checkout = 0;
 	int errs = 0;
diff --git a/builtin/checkout.c b/builtin/checkout.c
index a6cd8c0f37..039d3d296b 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -107,7 +107,7 @@ static int update_some(const unsigned char *sha1, struct strbuf *base,
 	 * entry in place. Whether it is UPTODATE or not, checkout_entry will
 	 * do the right thing.
 	 */
-	pos = cache_name_pos(ce->name, ce->ce_namelen);
+	pos = index_name_pos(&the_index, ce->name, ce->ce_namelen);
 	if (pos >= 0) {
 		struct cache_entry *old = the_index.cache[pos];
 		if (ce->ce_mode == old->ce_mode &&
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 6f7ecec1b0..3507490d3e 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -134,7 +134,8 @@ static void show_killed_files(struct dir_struct *dir)
 				/* If ent->name is prefix of an entry in the
 				 * cache, it will be killed.
 				 */
-				pos = cache_name_pos(ent->name, ent->len);
+				pos = index_name_pos(&the_index, ent->name,
+						     ent->len);
 				if (0 <= pos)
 					die("BUG: killed-file %.*s not found",
 						ent->len, ent->name);
@@ -156,7 +157,7 @@ static void show_killed_files(struct dir_struct *dir)
 					killed = 1;
 				break;
 			}
-			if (0 <= cache_name_pos(ent->name, sp - ent->name)) {
+			if (0 <= index_name_pos(&the_index, ent->name, sp - ent->name)) {
 				/* If any of the leading directories in
 				 * ent->name is registered in the cache,
 				 * ent->name will be killed.
@@ -384,7 +385,7 @@ static void prune_cache(const char *prefix, size_t prefixlen)
 
 	if (!prefix)
 		return;
-	pos = cache_name_pos(prefix, prefixlen);
+	pos = index_name_pos(&the_index, prefix, prefixlen);
 	if (pos < 0)
 		pos = -pos-1;
 	first = pos;
diff --git a/builtin/merge-index.c b/builtin/merge-index.c
index d867ee73f0..ec7104614c 100644
--- a/builtin/merge-index.c
+++ b/builtin/merge-index.c
@@ -44,7 +44,7 @@ static int merge_entry(int pos, const char *path)
 
 static void merge_one_path(const char *path)
 {
-	int pos = cache_name_pos(path, strlen(path));
+	int pos = index_name_pos(&the_index, path, strlen(path));
 
 	/*
 	 * If it already exists in the cache as stage0, it's
diff --git a/builtin/mv.c b/builtin/mv.c
index 3b887a9490..40e40bb098 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -97,7 +97,7 @@ static int index_range_of_same_dir(const char *src, int length,
 	const char *src_w_slash = add_slash(src);
 	int first, last, len_w_slash = length + 1;
 
-	first = cache_name_pos(src_w_slash, len_w_slash);
+	first = index_name_pos(&the_index, src_w_slash, len_w_slash);
 	if (first >= 0)
 		die(_("%.*s is in index"), len_w_slash, src_w_slash);
 
@@ -187,7 +187,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 				&& lstat(dst, &st) == 0)
 			bad = _("cannot move directory over file");
 		else if (src_is_dir) {
-			int first = cache_name_pos(src, length), last;
+			int first = index_name_pos(&the_index, src, length), last;
 
 			if (first >= 0)
 				prepare_move_submodule(src, first,
@@ -218,7 +218,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 				}
 				argc += last - first;
 			}
-		} else if (cache_name_pos(src, length) < 0)
+		} else if (index_name_pos(&the_index, src, length) < 0)
 			bad = _("not under version control");
 		else if (lstat(dst, &st) == 0 &&
 			 (!ignore_case || strcasecmp(src, dst))) {
@@ -284,7 +284,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 		if (mode == WORKING_DIRECTORY)
 			continue;
 
-		pos = cache_name_pos(src, strlen(src));
+		pos = index_name_pos(&the_index, src, strlen(src));
 		assert(pos >= 0);
 		if (!show_only)
 			rename_cache_entry_at(pos, dst);
diff --git a/builtin/rm.c b/builtin/rm.c
index 0813d0a853..c77c941ef0 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -67,7 +67,7 @@ static void submodules_absorb_gitdir_if_needed(const char *prefix)
 		int pos;
 		const struct cache_entry *ce;
 
-		pos = cache_name_pos(name, strlen(name));
+		pos = index_name_pos(&the_index, name, strlen(name));
 		if (pos < 0) {
 			pos = get_ours_cache_pos(name, pos);
 			if (pos < 0)
@@ -112,7 +112,7 @@ static int check_local_mod(struct object_id *head, int index_only)
 		int local_changes = 0;
 		int staged_changes = 0;
 
-		pos = cache_name_pos(name, strlen(name));
+		pos = index_name_pos(&the_index, name, strlen(name));
 		if (pos < 0) {
 			/*
 			 * Skip unmerged entries except for populated submodules
diff --git a/builtin/update-index.c b/builtin/update-index.c
index c9f06169c0..d7a117c674 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -225,7 +225,7 @@ static int test_if_untracked_cache_is_supported(void)
 static int mark_ce_flags(const char *path, int flag, int mark)
 {
 	int namelen = strlen(path);
-	int pos = cache_name_pos(path, namelen);
+	int pos = index_name_pos(&the_index, path, namelen);
 	if (0 <= pos) {
 		if (mark)
 			the_index.cache[pos]->ce_flags |= flag;
@@ -317,7 +317,7 @@ static int add_one_path(const struct cache_entry *old, const char *path, int len
 static int process_directory(const char *path, int len, struct stat *st)
 {
 	struct object_id oid;
-	int pos = cache_name_pos(path, len);
+	int pos = index_name_pos(&the_index, path, len);
 
 	/* Exact match: file or existing gitlink */
 	if (pos >= 0) {
@@ -368,7 +368,7 @@ static int process_path(const char *path)
 	if (has_symlink_leading_path(path, len))
 		return error("'%s' is beyond a symbolic link", path);
 
-	pos = cache_name_pos(path, len);
+	pos = index_name_pos(&the_index, path, len);
 	ce = pos < 0 ? NULL : the_index.cache[pos];
 	if (ce && ce_skip_worktree(ce)) {
 		/*
@@ -428,7 +428,7 @@ static void chmod_path(char flip, const char *path)
 	int pos;
 	struct cache_entry *ce;
 
-	pos = cache_name_pos(path, strlen(path));
+	pos = index_name_pos(&the_index, path, strlen(path));
 	if (pos < 0)
 		goto fail;
 	ce = the_index.cache[pos];
@@ -610,7 +610,7 @@ static int unresolve_one(const char *path)
 	struct cache_entry *ce_2 = NULL, *ce_3 = NULL;
 
 	/* See if there is such entry in the index. */
-	pos = cache_name_pos(path, namelen);
+	pos = index_name_pos(&the_index, path, namelen);
 	if (0 <= pos) {
 		/* already merged */
 		pos = unmerge_index_entry_at(&the_index, pos);
diff --git a/cache.h b/cache.h
index a021d6e988..a18ebf263a 100644
--- a/cache.h
+++ b/cache.h
@@ -354,7 +354,6 @@ extern void free_name_hash(struct index_state *istate);
 
 
 #ifndef NO_THE_INDEX_COMPATIBILITY_MACROS
-#define cache_name_pos(name, namelen) index_name_pos(&the_index,(name),(namelen))
 #define add_cache_entry(ce, option) add_index_entry(&the_index, (ce), (option))
 #define rename_cache_entry_at(pos, new_name) rename_index_entry_at(&the_index, (pos), (new_name))
 #define remove_cache_entry_at(pos) remove_index_entry_at(&the_index, (pos))
diff --git a/diff.c b/diff.c
index 37083914c5..f2ee40fe21 100644
--- a/diff.c
+++ b/diff.c
@@ -2759,7 +2759,7 @@ static int reuse_worktree_file(const char *name, const unsigned char *sha1, int
 		return 0;
 
 	len = strlen(name);
-	pos = cache_name_pos(name, len);
+	pos = index_name_pos(&the_index, name, len);
 	if (pos < 0)
 		return 0;
 	ce = the_index.cache[pos];
diff --git a/dir.c b/dir.c
index 63edaec2ef..47890b3d3b 100644
--- a/dir.c
+++ b/dir.c
@@ -596,7 +596,7 @@ static void *read_skip_worktree_file_from_index(const char *path, size_t *size,
 	void *data;
 
 	len = strlen(path);
-	pos = cache_name_pos(path, len);
+	pos = index_name_pos(&the_index, path, len);
 	if (pos < 0)
 		return NULL;
 	if (!ce_skip_worktree(the_index.cache[pos]))
@@ -785,7 +785,7 @@ static int add_excludes(const char *fname, const char *base, int baselen,
 			    !match_stat_data_racy(&the_index, &sha1_stat->stat, &st))
 				; /* no content change, ss->sha1 still good */
 			else if (check_index &&
-				 (pos = cache_name_pos(fname, strlen(fname))) >= 0 &&
+				 (pos = index_name_pos(&the_index, fname, strlen(fname))) >= 0 &&
 				 !ce_stage(the_index.cache[pos]) &&
 				 ce_uptodate(the_index.cache[pos]) &&
 				 !would_convert_to_git(fname))
@@ -1290,7 +1290,7 @@ static enum exist_status directory_exists_in_index(const char *dirname, int len)
 	if (ignore_case)
 		return directory_exists_in_index_icase(dirname, len);
 
-	pos = cache_name_pos(dirname, len);
+	pos = index_name_pos(&the_index, dirname, len);
 	if (pos < 0)
 		pos = -pos-1;
 	while (pos < the_index.cache_nr) {
@@ -1474,7 +1474,7 @@ static int get_index_dtype(const char *path, int len)
 	}
 
 	/* Try to look it up as a directory */
-	pos = cache_name_pos(path, len);
+	pos = index_name_pos(&the_index, path, len);
 	if (pos >= 0)
 		return DT_UNKNOWN;
 	pos = -pos-1;
diff --git a/merge-recursive.c b/merge-recursive.c
index eb0f0c6960..163d37866e 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -680,7 +680,7 @@ static int dir_in_way(const char *path, int check_working_copy, int empty_ok)
 	strbuf_addstr(&dirpath, path);
 	strbuf_addch(&dirpath, '/');
 
-	pos = cache_name_pos(dirpath.buf, dirpath.len);
+	pos = index_name_pos(&the_index, dirpath.buf, dirpath.len);
 
 	if (pos < 0)
 		pos = -1 - pos;
@@ -697,7 +697,7 @@ static int dir_in_way(const char *path, int check_working_copy, int empty_ok)
 
 static int was_tracked(const char *path)
 {
-	int pos = cache_name_pos(path, strlen(path));
+	int pos = index_name_pos(&the_index, path, strlen(path));
 
 	if (0 <= pos)
 		/* we have been tracking this path */
diff --git a/pathspec.c b/pathspec.c
index 25c2afef30..28b5f8b606 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -389,7 +389,7 @@ static const char *parse_element_magic(unsigned *magic, int *prefix_len,
 static void strip_submodule_slash_cheap(struct pathspec_item *item)
 {
 	if (item->len >= 1 && item->match[item->len - 1] == '/') {
-		int i = cache_name_pos(item->match, item->len - 1);
+		int i = index_name_pos(&the_index, item->match, item->len - 1);
 
 		if (i >= 0 && S_ISGITLINK(the_index.cache[i]->ce_mode)) {
 			item->len--;
diff --git a/rerere.c b/rerere.c
index 03218166ab..b6d84b8461 100644
--- a/rerere.c
+++ b/rerere.c
@@ -966,7 +966,7 @@ static int handle_cache(const char *path, unsigned char *sha1, const char *outpu
 	 * Reproduce the conflicted merge in-core
 	 */
 	len = strlen(path);
-	pos = cache_name_pos(path, len);
+	pos = index_name_pos(&the_index, path, len);
 	if (0 <= pos)
 		return -1;
 	pos = -pos - 1;
diff --git a/sha1_name.c b/sha1_name.c
index b73e261498..41ab9d9f1a 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -1441,7 +1441,7 @@ static void diagnose_invalid_index_path(int stage,
 		prefix = "";
 
 	/* Wrong stage number? */
-	pos = cache_name_pos(filename, namelen);
+	pos = index_name_pos(&the_index, filename, namelen);
 	if (pos < 0)
 		pos = -pos - 1;
 	if (pos < the_index.cache_nr) {
@@ -1457,7 +1457,7 @@ static void diagnose_invalid_index_path(int stage,
 	/* Confusion between relative and absolute filenames? */
 	strbuf_addstr(&fullname, prefix);
 	strbuf_addstr(&fullname, filename);
-	pos = cache_name_pos(fullname.buf, fullname.len);
+	pos = index_name_pos(&the_index, fullname.buf, fullname.len);
 	if (pos < 0)
 		pos = -pos - 1;
 	if (pos < the_index.cache_nr) {
@@ -1553,7 +1553,7 @@ static int get_sha1_with_context_1(const char *name,
 
 		if (!the_index.cache)
 			read_index(&the_index);
-		pos = cache_name_pos(cp, namelen);
+		pos = index_name_pos(&the_index, cp, namelen);
 		if (pos < 0)
 			pos = -pos - 1;
 		while (pos < the_index.cache_nr) {
diff --git a/submodule.c b/submodule.c
index b225ff6d1f..148194831d 100644
--- a/submodule.c
+++ b/submodule.c
@@ -179,7 +179,7 @@ void gitmodules_config(void)
 		strbuf_addstr(&gitmodules_path, "/.gitmodules");
 		if (read_index(&the_index) < 0)
 			die("index file corrupt");
-		pos = cache_name_pos(".gitmodules", 11);
+		pos = index_name_pos(&the_index, ".gitmodules", 11);
 		if (pos < 0) { /* .gitmodules not found or isn't merged */
 			pos = -1 - pos;
 			if (the_index.cache_nr > pos) {  /* there is a .gitmodules */
diff --git a/wt-status.c b/wt-status.c
index d17d4cb6ca..59cdf09a07 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -481,7 +481,7 @@ static int unmerged_mask(const char *path)
 	int pos, mask;
 	const struct cache_entry *ce;
 
-	pos = cache_name_pos(path, strlen(path));
+	pos = index_name_pos(&the_index, path, strlen(path));
 	if (0 <= pos)
 		return 0;
 
@@ -2096,7 +2096,7 @@ static void wt_porcelain_v2_print_unmerged_entry(
 	 */
 	memset(stages, 0, sizeof(stages));
 	sum = 0;
-	pos = cache_name_pos(it->string, strlen(it->string));
+	pos = index_name_pos(&the_index, it->string, strlen(it->string));
 	assert(pos < 0);
 	pos = -pos-1;
 	while (pos < the_index.cache_nr) {
-- 
2.13.0.rc1.39.ga6db8bfa24

