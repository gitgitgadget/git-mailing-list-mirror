Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16CCB20DD75
	for <git@vger.kernel.org>; Thu,  5 Feb 2026 10:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770286549; cv=none; b=b/bGgJ0vnQP4uAq4H1CoGCm10KfzsJT3PRD9/2JjWpY21O5xklFffJeIOGxfLRtmeiqN3MqNKaSKn+E5OmvQ/BDPvJSbdK0g957jDWF1VfOIbYAztVDCjk6qCyUN0ZBspYTPWGSyAuuKkPzlr4gFAm4uP+lwdeYG9UoENCeantA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770286549; c=relaxed/simple;
	bh=mLUouOjENPLpWh1wfZt9O7ry+CwzTfKGE2M8NKAUlwE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H9SmzV1QQ/Cw5kae7pbSR6lCeFALDzGASi2SjnOot+OmHZEUqErx6o3AFatexuFIyEfC+QeL0bQnuw5WOCdXeZ3dCRKFLPWoH089GgLB0tJ66LP4DqmohH0vW256cuTD1biNGl9q9lYFYFWQs0iudSqpxwrNXqCXrHdLvHUvmZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RDRoMauL; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RDRoMauL"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-352e2c59264so476799a91.0
        for <git@vger.kernel.org>; Thu, 05 Feb 2026 02:15:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770286548; x=1770891348; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0b2QrqpN0yQDXtEoEoPQ9z8amjzjqNn4JtR/PxFAQtg=;
        b=RDRoMauLNn3fDzZukYU7ndIyxIkR8w4ibUKfnez6qjsjo4yS4Ii+vn5Bwh959ZS4VO
         8hR1ERIAUAarnqy8mpdFNbCfSzATIGp+skLwNRN5CBi/Ycs0cNTeTgyXR/q/0e/qFCI9
         D8cT486rTuwJHIy64FfFGIVvNEePKv0G19U9151AcnLINlTZyVCMzJy1iGxydwMaiTLq
         +h/Wwn4h9HL5IyPnZ1TPaiZnVvu9u04lwXbjhsrrI1AuJMZ8pSWmSuRipB07uOMFyETT
         orLOOO5VnGiFVqm3fWd8prI27b5y8FCUJnhMmwide2tcqRtPRyStaDCwxIrMpyMOQvy9
         q0uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770286548; x=1770891348;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0b2QrqpN0yQDXtEoEoPQ9z8amjzjqNn4JtR/PxFAQtg=;
        b=nr7HvJzQkYzKeFUQEho5X6eaTN6aFQMivOmMnknzrIvmwNEbg/MihPtDV5E9NDNCmn
         VoLzaJU3lpGAvBPrTvE4z2i8x70P8cvyvzLJ+MTXlCi75qa8sQPXRAJO5lOl5ZaE3VBs
         jMPf9ltpzHQh8bSyn9Ijk5kgWLa/W8kAjb6qG57WDf5BOlUt/V36PX+NJEl3+hHzcQgO
         zexRB9iqi9g4F0JyRcqVJ5piVjpXm8YeXUFVV9qm4sfGBvfMPS3UqKjE8We/sDikk1mp
         rp4bK/EORceFtj+k3Ah2PTDZH+cRHPymP4cwDKGusdnCIDhfo1Eguhg/nhbOvz92GKD9
         Nzgg==
X-Gm-Message-State: AOJu0YzDcCTl2fKWz+eeIcFm006YqL87VSRahfCgYUwlOQP0LfHldCf8
	zSKB+l6Ew3hFGDUYtZuRdoLbQNfQrHeqhsgawjEVVNFJA/XbO12esRu3wAxJyg==
X-Gm-Gg: AZuq6aLl9jxTz9YlIgtrItLbo73qdxNjoxPzPSNqKasFyrE3A50COMmMd9EyY3v+X9a
	dEt0QrFhEL2rVlZ+lC9/t7rXeLGqBGf07jhfQhaU91mEOqG9UNMHMNtAjqFDmjgEflZpeCH8ox3
	2beK8Mapky+kYtXCik3C2pD8H+jI7B9aJyEc/21CRsswrO+QKJe2NjXEVfYw8HYxK5xZ5MlXkZ3
	Oz0oZbDdZsgBEkHqmG4Ph8aX3gN8o/QMn6IoUvd6zqxzfvOJlFRzA01LbLvpzy82WUHpCeG7FQ7
	8JogdjykT/cARKUoj3Wg0q7m6nyINBGpQXYnDUNa53mVUIDxkJRDzXF5HdI1NJYsEYmDFG6NQjx
	2O3rh63n5PblqCrZtzwu+POoNweIqna15/lp48GNItN0Y6EgWtW5RHPhSsz5Uuau6qhwe+RGAn1
	nxkW8hLfpEJGar0aVZCHod/y2Q4whWmcPBrigMzd/0TVEWlg==
X-Received: by 2002:a17:90b:50c7:b0:354:83c1:9f0a with SMTP id 98e67ed59e1d1-354871b86a5mr4748700a91.29.1770286548035;
        Thu, 05 Feb 2026 02:15:48 -0800 (PST)
Received: from Shreyansh-PC.domain.name ([2401:4900:1cd6:312c:1078:b5ff:8b66:3ef8])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3549c09ff2fsm2071223a91.2.2026.02.05.02.15.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 02:15:47 -0800 (PST)
From: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	karthik.188@gmail.com,
	phillip.wood123@gmail.com,
	Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
Subject: [PATCH V2 1/3] wt-status: replace uses of the_repository with local repository instances
Date: Thu,  5 Feb 2026 15:43:11 +0530
Message-ID: <20260205101524.125452-2-shreyanshpaliwalcmsmn@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260205101524.125452-1-shreyanshpaliwalcmsmn@gmail.com>
References: <20260131190106.389289-1-shreyanshpaliwalcmsmn@gmail.com>
 <20260205101524.125452-1-shreyanshpaliwalcmsmn@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

wt-status.c uses the global the_repository in several places even when
a repository instance is already available via struct wt_status or
struct worktree.

Replace these direct uses of the_repository with the repository carried
by the local structs (e.g. s->repo, wt->repo).

The replacements of all the_repository with s->repo are mostly
to cases where a repository instance is already available via
struct wt_status. All functions operating on struct wt_status *s
are only used after s is initialized by wt_status_prepare(),
which sets s->repo from the repository provided by the caller.
As a result, s->repo is guaranteed to be available and consistent
whenever these functions are invoked.

This reduces reliance on global state and keeps wt-status consistent,
though many functions operating on struct wt_status *s
are called via commit.c and it still relies on the_repository,
but within wt-status.c the local repository pointer
refers to the same underlying repository object.

Signed-off-by: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
---
 wt-status.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index e12adb26b9..f71addc35f 100644
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
+	s->index_file = repo_get_index_file(s->repo);
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
@@ -1146,7 +1146,7 @@ static void wt_longstatus_print_verbose(struct wt_status *s)
 	rev.diffopt.ita_invisible_in_index = 1;
 
 	memset(&opt, 0, sizeof(opt));
-	opt.def = s->is_initial ? empty_tree_oid_hex(the_repository->hash_algo) : s->reference;
+	opt.def = s->is_initial ? empty_tree_oid_hex(s->repo->hash_algo) : s->reference;
 	setup_revisions(0, NULL, &rev, &opt);
 
 	rev.diffopt.output_format |= DIFF_FORMAT_PATCH;
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
@@ -1624,7 +1624,7 @@ static char *get_branch(const struct worktree *wt, const char *path)
 	struct object_id oid;
 	const char *branch_name;
 
-	if (strbuf_read_file(&sb, worktree_git_path(the_repository, wt, "%s", path), 0) <= 0)
+	if (strbuf_read_file(&sb, worktree_git_path(wt->repo, wt, "%s", path), 0) <= 0)
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
@@ -1750,7 +1750,7 @@ int wt_status_check_bisect(const struct worktree *wt,
 {
 	struct stat st;
 
-	if (!stat(worktree_git_path(the_repository, wt, "BISECT_LOG"), &st)) {
+	if (!stat(worktree_git_path(wt->repo, wt, "BISECT_LOG"), &st)) {
 		state->bisect_in_progress = 1;
 		state->bisecting_from = get_branch(wt, "BISECT_START");
 		return 1;
@@ -2099,7 +2099,7 @@ static void wt_shortstatus_print_tracking(struct wt_status *s)
 		upstream_is_gone = 1;
 	}
 
-	short_base = refs_shorten_unambiguous_ref(get_main_ref_store(the_repository),
+	short_base = refs_shorten_unambiguous_ref(get_main_ref_store(s->repo),
 						  base, 0);
 	color_fprintf(s->fp, header_color, "...");
 	color_fprintf(s->fp, branch_color_remote, "%s", short_base);
@@ -2233,7 +2233,7 @@ static void wt_porcelain_v2_print_tracking(struct wt_status *s)
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
