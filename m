Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB502DCF46
	for <git@vger.kernel.org>; Sat, 31 Jan 2026 19:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769886098; cv=none; b=O+duB1lZnsW/q/hYPkp/NiHvNHmyuub6NjLyKE+ndhxRxlD9sTNdWDEoOBjym6595GKKvxnMUl0zRK7GWec2eA9sBfmsOlOhGuXaQ7XKMvpK1oPF4Y5jfKukly5X7atzXgkVpLbvpuZCZ7mCT0nC7+OMWVpz1cYkQ0fLHAY8h6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769886098; c=relaxed/simple;
	bh=VSlgOctRK22tTrwO9cTz3VP4/LXMgyv3M8qID2RJ/fA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tFEtd8aWZIosvuyaWAWdhespLwjEjo86+B8nLVyx9QrlQmy+cYjso0tHI7XhKtNDo67sgW48vtv0jhnLqvJNVTfxy55/ItKLJKYRSZriWtMj4pa+sxVBP8pumH9wdiTOEKc14MTgjTH338SFYxSigUflb98JMKQDY0t6Pn05bS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YgP+zKG8; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YgP+zKG8"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c62239decbeso1260704a12.2
        for <git@vger.kernel.org>; Sat, 31 Jan 2026 11:01:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769886097; x=1770490897; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mDxEouQG7DSRgKHQXCjZVm/yeOkmad++aspxKo6ZoR4=;
        b=YgP+zKG8po20PY4770238WP1p86NYKTmEs8YVamnFif1p723+4NMV8sSsVfiuphGe3
         xAHOSxENubN4+kVc+oxJtMV7Nm1EcGnqjUg451qCQhFh012FCN/QpGLGrEZjgOj6ZboC
         WfZ8TWYg62qA9LFeWRB524vSUR24iQBB4PoqM8dIB4wlvkdw+HA+1k3NAju/hgocYJSI
         lOydwXlmdhZgeBzOzha4/cb47aWfrste/lQQWuWafaa1o1VZtkPcEsm+BkE/tojDBFNp
         pI3qoLABZEFe4VZlJTuKypaBkUNDTo8fQSGUbzMJcrdh6v4kpC8fVwflhyGN/XBwoY+7
         At3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769886097; x=1770490897;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mDxEouQG7DSRgKHQXCjZVm/yeOkmad++aspxKo6ZoR4=;
        b=FprtmOzDmXakGhTJX3k6DbF1YlBDKZQj5ToqaEFUF8JbTF2pQTKq5tvTwaojoToX7h
         Li94uzMhMHhxN2NzdznPEWIqEQOmHd6IU445pH8JBNXewbsUZg3QXB/WWTMxs936UFpC
         TJCwGACYfYql7+jhgVQfwz8A3WGmSTFOxPGbeVfnOPt3cVRGotVEUL/KzZMSIscH/Nfi
         vOHu8k8v7i6jYsaBjoCJMfsQ0I0ZGuImh1sFO7FnBuNCib8RVQBu2OgSo8D66jktLzO+
         N55ZzldkHjHxgiT6R1btXr5lU5XqpFUz18nBRJLr5lBBoDPok6tN44s2JVgA83w7r2DD
         yGjw==
X-Gm-Message-State: AOJu0YxeB0+mvbavX+Bvy0Of4rMTGJKYYsqDzQidfix8Wq4krKYYKrVh
	4WyZEsoCscTWHbhJmjTUKbeQmyW1ZGYO1JxJLURrLJswar3VtL5FAyTt8N90IA==
X-Gm-Gg: AZuq6aIb+IfLEvTD68T9PwEnAKiaBth3FibuuGk/kyN3MuaIa5A4d6hvv+iNSmk8Dwv
	C2Id0gAIZjkg3Iov3qWryZzfXbjRW0ba4p2ApnbhvfEHXqQ9Nrt01jum4XNtbMy4C6dhRvKdKN+
	e6bRoAOVQDaxuMMfgb5A/2PM/ltd0gSNIBaoI4dk55IUkxqTcf0ZtBpE8RsTbNU33Qu1pbMGAIp
	dN6wkpj3ZMRov32e8WdFK2lhOXoOMis3oAg3IjsQwKtshC0aXfMcrOgD3U9s/VFPYzJNAUDSsb7
	rKCJS98Sq53XGkKnJJ3ZqC1vlumoIS4TYQOUxjlJwcddxbHBYQV/VY8cRRpROeCwnJly79ljSpk
	r6QMUOgogKhVlYRr889Dt19jAoyDM64jks8wWiR+OCiR7eqq67rZ8OOVC2gC1MzX8vk9f7FyFTU
	d17OtS3kc4+8UwZdB0UnYKG0Jrb3XTtxI34t1GbuQ9rYQ9
X-Received: by 2002:a17:90b:2712:b0:353:2e1:95f2 with SMTP id 98e67ed59e1d1-3543b2ebe34mr5842814a91.8.1769886096693;
        Sat, 31 Jan 2026 11:01:36 -0800 (PST)
Received: from Shreyansh-PC.domain.name ([2401:4900:1cd6:312c:c36:249a:cab4:59a4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3540f2cb419sm11151747a91.1.2026.01.31.11.01.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Jan 2026 11:01:36 -0800 (PST)
From: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
Subject: [PATCH 1/3] wt-status: replace uses of the_repository with local repository instances
Date: Sun,  1 Feb 2026 00:27:37 +0530
Message-ID: <20260131190106.389289-2-shreyanshpaliwalcmsmn@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260131190106.389289-1-shreyanshpaliwalcmsmn@gmail.com>
References: <20260131190106.389289-1-shreyanshpaliwalcmsmn@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Many instances of the_repository are used in wt-status.c even when a
local repository is already available via struct wt_status or struct
worktree.

Replace direct uses of the global the_repository with the repository
instance carried by the local structs (e.g. s->repo, wt->repo).

This helps reduce reliance on global repository state.

Signed-off-by: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
---
 wt-status.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index e12adb26b9..9f4d8fda7f 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -150,11 +150,11 @@ void wt_status_prepare(struct repository *r, struct wt_status *s)
 	s->show_untracked_files = SHOW_NORMAL_UNTRACKED_FILES;
 	s->use_color = GIT_COLOR_UNKNOWN;
 	s->relative_paths = 1;
-	s->branch = refs_resolve_refdup(get_main_ref_store(the_repository),
+	s->branch = refs_resolve_refdup(get_main_ref_store(s->repo),
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
@@ -1723,18 +1723,18 @@ int wt_status_check_rebase(const struct worktree *wt,
 {
 	struct stat st;
 
-	if (!stat(worktree_git_path(the_repository, wt, "rebase-apply"), &st)) {
-		if (!stat(worktree_git_path(the_repository, wt, "rebase-apply/applying"), &st)) {
+	if (!stat(worktree_git_path(wt->repo, wt, "rebase-apply"), &st)) {
+		if (!stat(worktree_git_path(wt->repo, wt, "rebase-apply/applying"), &st)) {
 			state->am_in_progress = 1;
-			if (!stat(worktree_git_path(the_repository, wt, "rebase-apply/patch"), &st) && !st.st_size)
+			if (!stat(worktree_git_path(wt->repo, wt, "rebase-apply/patch"), &st) && !st.st_size)
 				state->am_empty_patch = 1;
 		} else {
 			state->rebase_in_progress = 1;
 			state->branch = get_branch(wt, "rebase-apply/head-name");
 			state->onto = get_branch(wt, "rebase-apply/onto");
 		}
-	} else if (!stat(worktree_git_path(the_repository, wt, "rebase-merge"), &st)) {
-		if (!stat(worktree_git_path(the_repository, wt, "rebase-merge/interactive"), &st))
+	} else if (!stat(worktree_git_path(wt->repo, wt, "rebase-merge"), &st)) {
+		if (!stat(worktree_git_path(wt->repo, wt, "rebase-merge/interactive"), &st))
 			state->rebase_interactive_in_progress = 1;
 		else
 			state->rebase_in_progress = 1;
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
