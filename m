Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD18F2D6E4B
	for <git@vger.kernel.org>; Sat,  7 Feb 2026 10:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770458630; cv=none; b=e1+m0Bl8c7gV0B3VPCa43br8JK+lYp9BW/EvNF92xDD9LyN3GXFD3Y7p6wPtnlhUhhUTA1q3sQFhnGCq2uNnzDCgzm/+d5ACfbtrliLF25h7M4Pr1Y3KOEBGq3dnrlUSvvbZXOtVHLamV0UEX05pQFgqlqbpoLY8G1smUdcffsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770458630; c=relaxed/simple;
	bh=ct3mlwIJ0zk3iFN50ss+bcZAqL93qB4f+HEgjMfVplY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LvTx/tu3ySrFAtY+sUujeN5YM5+Y8gwvCvzXe0jZXOjikSW/Pa35TGP0P7hyakWCgQDID6FFRPLZUFIp9IZembD36YzY+iNWQF43zvpviGujNo7qjgrruxCWcr2KDtRpCx4c6Xy5Cgdwv4vCPGLtWZIqgJ9XlSexjXdCbO7bdzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cbtM2uVi; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cbtM2uVi"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-82318702afbso1202362b3a.1
        for <git@vger.kernel.org>; Sat, 07 Feb 2026 02:03:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770458630; x=1771063430; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dzG0kdAqGYbYJEwNyIpUvFl+o5VSVKbitWTJ3Jxe+Ms=;
        b=cbtM2uViwowhr86rdSLbivDjfFKzTPWu1g2OnfQC2KEUB2bx/KdcK7CvH4CZe8exCf
         aFcvP1xkZq8TznhxyYTn00ZG7CcTgqeKCocy+ftIifnRUNY/hq97nIcaJe6lexeTpt6/
         nf45/5vnegiad/DD2DogEWqBTV5R80AVis/AlCotlmhKjsEv+myNVJigIy+YGS7Ic+PB
         3g9zlLE3Bn5QwfsLoI+RUOePtZY0/jFb/uv8JJzCNgVcNPA19oXaH1Q6FVgIgcuhsaUv
         8ukD3cq5Z8cXYI5Oshy9cdJ6lNmd8fAFNbkkfm+PL9KdhQQmjs2sPku0Irn5OryIr3EU
         eq1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770458630; x=1771063430;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dzG0kdAqGYbYJEwNyIpUvFl+o5VSVKbitWTJ3Jxe+Ms=;
        b=lXHRhJM0y9OeMpKAFkm/HoVc7viB6WLehVo2T05Q0QCeQtZW/hLDymqvsDQPBsiEgj
         T+Ul6bNYX1MnyZRTY12WmhahjZjCEaPoLwAilslikqLjoO6LQWCH+ln6MkOdGyyZI8ie
         bGBboZM/bYylTam1Wg06jgDPa/4VK4lbSEZ4xscIybQUXUSQPMDvH8GaQs8f9XMSdBns
         I6/PKBStWCuDuCNx0X4OrV/j1vWn9Ae6VFnDVsycvJwp0/RNHicicxcg9OwT2ffp5FUp
         MGV8ZL2QvV8THffDWlipwb+13u0VpuMKGchTyFEYrjMXWToM0fmzi0YJhRdifX2U/eli
         qG2Q==
X-Gm-Message-State: AOJu0YwNU6YbQ63eRgeHS7QFYRTgr9mlLNRglv7Fitqh8radH/EjVmIM
	nnYajzyYMPXZqrhqm6TT8+eqVXNg8dQfq8FSrULdoxaFvDhe1hUP4FRD7FJLVQ==
X-Gm-Gg: AZuq6aLswSTj6O7vK7r9JZyfMNq5n+C/sGSyPbs6JBJJYykELhTkmnbi69JV4ig+7NA
	6dQ7U/xz6gtRG6yUgM6mtLsEqrGGjhYgCPzgYr0T4v1MN9IvGT4haMc3SdAvB1BHYq93EhaHY6A
	EVXP4agXGN7wj4Zfkd/fFydLNjW2Nf7LP57fEYVxuwj+j1Cp4SbGwZ1UVtS0uCsD6X1B0NLkwVY
	d6aGtefr6MsfoLMFf7Naou4kfFY5UsqhquzsY1TR33iYC99kE4L2fKdyGzbBVhH03/HrjS76FqJ
	XZ9iPBQDYxbLS3JgMrpkjUpA97kbzcG1rxWd7Kuf4inP0tzvCtWMicUjeXnoQshtokldIearAMx
	f/6IeovzfkxG/SGqagiQLGH+eqxtqRuL06I45TQ54+4PYKzxAONKrER1q9gU198PPNqMK/DSK8y
	LWgAxcYHpaBGXTVCgSE3U04ESt5KgVdARicMaLe2EqtibOQw==
X-Received: by 2002:a05:6a00:4205:b0:823:1cc6:d60a with SMTP id d2e1a72fcca58-8244160d2abmr5134338b3a.2.1770458629871;
        Sat, 07 Feb 2026 02:03:49 -0800 (PST)
Received: from Shreyansh-PC.domain.name ([2401:4900:1cd6:312c:b151:d56:3281:2879])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-824418bf024sm4435362b3a.56.2026.02.07.02.03.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Feb 2026 02:03:49 -0800 (PST)
From: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	karthik.188@gmail.com,
	phillip.wood123@gmail.com,
	Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
Subject: [PATCH v3 2/3] wt-status: replace uses of the_repository with local repository instances
Date: Sat,  7 Feb 2026 15:30:47 +0530
Message-ID: <20260207100322.1786368-3-shreyanshpaliwalcmsmn@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260207100322.1786368-1-shreyanshpaliwalcmsmn@gmail.com>
References: <20260205101524.125452-1-shreyanshpaliwalcmsmn@gmail.com>
 <20260207100322.1786368-1-shreyanshpaliwalcmsmn@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

wt-status.c uses the global the_repository in several places even when
a repository instance is already available via struct wt_status *s or
struct repository *r.

Replace these uses of the_repository with the repository available
in the local context (eg. s->repo or r).

The replacements of all the_repository with s->repo are mostly
to cases where a repository instance is already available via
struct wt_status *s and struct repository *r, all functions operating on
struct wt_status *s are only used after s is initialized by wt_status_prepare(),
which sets s->repo from the repository provided by the caller.
As a result, s->repo is guaranteed to be available and consistent whenever
these functions are invoked.

This reduces reliance on global state and keeps wt-status consistent,
though many functions operating on struct wt_status *s
are called via commit.c and it still relies on the_repository,
but within wt-status.c the local repository pointer
refers to the same underlying repository object.

Signed-off-by: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
---
 wt-status.c | 48 ++++++++++++++++++++++++------------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index ea81418bdd..0270d544d9 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -150,11 +150,11 @@ void wt_status_prepare(struct repository *r, struct wt_status *s)
 	s->show_untracked_files = SHOW_NORMAL_UNTRACKED_FILES;
 	s->use_color = GIT_COLOR_UNKNOWN;
 	s->relative_paths = 1;
-	s->branch = refs_resolve_refdup(get_main_ref_store(the_repository),
+	s->branch = refs_resolve_refdup(get_main_ref_store(r),
 					"HEAD", 0, NULL, NULL);
 	s->reference = "HEAD";
 	s->fp = stdout;
-	s->index_file = repo_get_index_file(the_repository);
+	s->index_file = repo_get_index_file(r);
 	s->change.strdup_strings = 1;
 	s->untracked.strdup_strings = 1;
 	s->ignored.strdup_strings = 1;
@@ -646,7 +646,7 @@ static void wt_status_collect_changes_index(struct wt_status *s)
 
 	repo_init_revisions(s->repo, &rev, NULL);
 	memset(&opt, 0, sizeof(opt));
-	opt.def = s->is_initial ? empty_tree_oid_hex(the_repository->hash_algo) : s->reference;
+	opt.def = s->is_initial ? empty_tree_oid_hex(s->repo->hash_algo) : s->reference;
 	setup_revisions(0, NULL, &rev, &opt);
 
 	rev.diffopt.flags.override_submodule_config = 1;
@@ -987,7 +987,7 @@ static int stash_count_refs(const char *refname UNUSED,
 static int count_stash_entries(struct repository *r)
 {
 	int n = 0;
-	refs_for_each_reflog_ent(get_main_ref_store(the_repository),
+	refs_for_each_reflog_ent(get_main_ref_store(r),
 				 "refs/stash", stash_count_refs, &n);
 	return n;
 }
@@ -1146,7 +1146,7 @@ static void wt_longstatus_print_verbose(struct wt_status *s)
 	rev.diffopt.ita_invisible_in_index = 1;
 
 	memset(&opt, 0, sizeof(opt));
-	opt.def = s->is_initial ? empty_tree_oid_hex(the_repository->hash_algo) : s->reference;
+	opt.def = s->is_initial ? empty_tree_oid_hex(s->repo->hash_algo) : s->reference;
 	setup_revisions(0, NULL, &rev, &opt);
 
 	rev.diffopt.output_format |= DIFF_FORMAT_PATCH;
@@ -1290,7 +1290,7 @@ static void show_am_in_progress(struct wt_status *s,
 static char *read_line_from_git_path(struct repository *r, char *filename)
 {
 	struct strbuf buf = STRBUF_INIT;
-	FILE *fp = fopen_or_warn(repo_git_path_append(the_repository, &buf,
+	FILE *fp = fopen_or_warn(repo_git_path_append(r, &buf,
 						      "%s", filename), "r");
 
 	if (!fp) {
@@ -1317,9 +1317,9 @@ static int split_commit_in_progress(struct wt_status *s)
 	    !s->branch || strcmp(s->branch, "HEAD"))
 		return 0;
 
-	if (refs_read_ref_full(get_main_ref_store(the_repository), "HEAD", RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE,
+	if (refs_read_ref_full(get_main_ref_store(s->repo), "HEAD", RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE,
 			       &head_oid, &head_flags) ||
-	    refs_read_ref_full(get_main_ref_store(the_repository), "ORIG_HEAD", RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE,
+	    refs_read_ref_full(get_main_ref_store(s->repo), "ORIG_HEAD", RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE,
 			       &orig_head_oid, &orig_head_flags))
 		return 0;
 	if (head_flags & REF_ISSYMREF || orig_head_flags & REF_ISSYMREF)
@@ -1362,7 +1362,7 @@ static void abbrev_oid_in_line(struct repository *r, struct strbuf *line)
 		return;
 
 	if ((2 <= string_list_split(&split, line->buf, " ", 2)) &&
-	    !repo_get_oid(the_repository, split.items[1].string, &oid)) {
+	    !repo_get_oid(r, split.items[1].string, &oid)) {
 		strbuf_reset(line);
 		strbuf_addf(line, "%s ", split.items[0].string);
 		strbuf_add_unique_abbrev(line, &oid, DEFAULT_ABBREV);
@@ -1375,7 +1375,7 @@ static void abbrev_oid_in_line(struct repository *r, struct strbuf *line)
 static int read_rebase_todolist(struct repository *r, char *fname, struct string_list *lines)
 {
 	struct strbuf buf = STRBUF_INIT;
-	FILE *f = fopen(repo_git_path_append(the_repository, &buf, "%s", fname), "r");
+	FILE *f = fopen(repo_git_path_append(r, &buf, "%s", fname), "r");
 	int ret;
 
 	if (!f) {
@@ -1384,7 +1384,7 @@ static int read_rebase_todolist(struct repository *r, char *fname, struct string
 			goto out;
 		}
 		die_errno("Could not open file %s for reading",
-			  repo_git_path_replace(the_repository, &buf, "%s", fname));
+			  repo_git_path_replace(r, &buf, "%s", fname));
 	}
 	while (!strbuf_getline_lf(&buf, f)) {
 		if (starts_with(buf.buf, comment_line_str))
@@ -1432,7 +1432,7 @@ static void show_rebase_information(struct wt_status *s,
 				i++)
 				status_printf_ln(s, color, "   %s", have_done.items[i].string);
 			if (have_done.nr > nr_lines_to_show && s->hints) {
-				char *path = repo_git_path(the_repository, "rebase-merge/done");
+				char *path = repo_git_path(s->repo, "rebase-merge/done");
 				status_printf_ln(s, color,
 					_("  (see more in file %s)"), path);
 				free(path);
@@ -1534,7 +1534,7 @@ static void show_cherry_pick_in_progress(struct wt_status *s,
 	else
 		status_printf_ln(s, color,
 			_("You are currently cherry-picking commit %s."),
-			repo_find_unique_abbrev(the_repository, &s->state.cherry_pick_head_oid,
+			repo_find_unique_abbrev(s->repo, &s->state.cherry_pick_head_oid,
 						DEFAULT_ABBREV));
 
 	if (s->hints) {
@@ -1564,7 +1564,7 @@ static void show_revert_in_progress(struct wt_status *s,
 	else
 		status_printf_ln(s, color,
 			_("You are currently reverting commit %s."),
-			repo_find_unique_abbrev(the_repository, &s->state.revert_head_oid,
+			repo_find_unique_abbrev(s->repo, &s->state.revert_head_oid,
 						DEFAULT_ABBREV));
 	if (s->hints) {
 		if (has_unmerged(s))
@@ -1624,7 +1624,7 @@ static char *get_branch(struct repository *r, struct worktree *wt, const char *p
 	struct object_id oid;
 	const char *branch_name;
 
-	if (strbuf_read_file(&sb, worktree_git_path(the_repository, wt, "%s", path), 0) <= 0)
+	if (strbuf_read_file(&sb, worktree_git_path(r, wt, "%s", path), 0) <= 0)
 		goto got_nothing;
 
 	while (sb.len && sb.buf[sb.len - 1] == '\n')
@@ -1691,7 +1691,7 @@ static void wt_status_get_detached_from(struct repository *r,
 	char *ref = NULL;
 
 	strbuf_init(&cb.buf, 0);
-	if (refs_for_each_reflog_ent_reverse(get_main_ref_store(the_repository), "HEAD", grab_1st_switch, &cb) <= 0) {
+	if (refs_for_each_reflog_ent_reverse(get_main_ref_store(r), "HEAD", grab_1st_switch, &cb) <= 0) {
 		strbuf_release(&cb.buf);
 		return;
 	}
@@ -1724,18 +1724,18 @@ int wt_status_check_rebase(struct repository *r,
 {
 	struct stat st;
 
-	if (!stat(worktree_git_path(the_repository, wt, "rebase-apply"), &st)) {
-		if (!stat(worktree_git_path(the_repository, wt, "rebase-apply/applying"), &st)) {
+	if (!stat(worktree_git_path(r, wt, "rebase-apply"), &st)) {
+		if (!stat(worktree_git_path(r, wt, "rebase-apply/applying"), &st)) {
 			state->am_in_progress = 1;
-			if (!stat(worktree_git_path(the_repository, wt, "rebase-apply/patch"), &st) && !st.st_size)
+			if (!stat(worktree_git_path(r, wt, "rebase-apply/patch"), &st) && !st.st_size)
 				state->am_empty_patch = 1;
 		} else {
 			state->rebase_in_progress = 1;
 			state->branch = get_branch(r, wt, "rebase-apply/head-name");
 			state->onto = get_branch(r, wt, "rebase-apply/onto");
 		}
-	} else if (!stat(worktree_git_path(the_repository, wt, "rebase-merge"), &st)) {
-		if (!stat(worktree_git_path(the_repository, wt, "rebase-merge/interactive"), &st))
+	} else if (!stat(worktree_git_path(r, wt, "rebase-merge"), &st)) {
+		if (!stat(worktree_git_path(r, wt, "rebase-merge/interactive"), &st))
 			state->rebase_interactive_in_progress = 1;
 		else
 			state->rebase_in_progress = 1;
@@ -1752,7 +1752,7 @@ int wt_status_check_bisect(struct repository *r,
 {
 	struct stat st;
 
-	if (!stat(worktree_git_path(the_repository, wt, "BISECT_LOG"), &st)) {
+	if (!stat(worktree_git_path(r, wt, "BISECT_LOG"), &st)) {
 		state->bisect_in_progress = 1;
 		state->bisecting_from = get_branch(r, wt, "BISECT_START");
 		return 1;
@@ -2101,7 +2101,7 @@ static void wt_shortstatus_print_tracking(struct wt_status *s)
 		upstream_is_gone = 1;
 	}
 
-	short_base = refs_shorten_unambiguous_ref(get_main_ref_store(the_repository),
+	short_base = refs_shorten_unambiguous_ref(get_main_ref_store(s->repo),
 						  base, 0);
 	color_fprintf(s->fp, header_color, "...");
 	color_fprintf(s->fp, branch_color_remote, "%s", short_base);
@@ -2235,7 +2235,7 @@ static void wt_porcelain_v2_print_tracking(struct wt_status *s)
 		ab_info = stat_tracking_info(branch, &nr_ahead, &nr_behind,
 					     &base, 0, s->ahead_behind_flags);
 		if (base) {
-			base = refs_shorten_unambiguous_ref(get_main_ref_store(the_repository),
+			base = refs_shorten_unambiguous_ref(get_main_ref_store(s->repo),
 							    base, 0);
 			fprintf(s->fp, "# branch.upstream %s%c", base, eol);
 			free((char *)base);
-- 
2.52.0

