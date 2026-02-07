Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C4B2D6E4B
	for <git@vger.kernel.org>; Sat,  7 Feb 2026 10:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770458625; cv=none; b=B6bHMFYixWEkQ6Q0nQ1zRkbdSgxNB0xsaJmo1ZODkTebB4MyQal1d1AJBr/RvwOWINarjhejc+zdNxmCPRuRA9mTuaxNU2FPh3YDOe9siiQXikQoE2/p9QdXu4eA95RKCf5vYZ6oA7bnO7IkCe85ONTHBZs17rgqd0GWO4NfzRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770458625; c=relaxed/simple;
	bh=URkr3wJiN2dvvNuOLZVzjpmVMJCfGDhOihRsNArvdow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gM71sq/kV9KOcFm9saJ3oU+ENmzT5nEiNBYXrUBfv4KAOF3i1xPLBuixavfGS2Es8WZ+onNvdBds6z/+1i5UmKCaoabvu9C9lgjw2PTKCdH/Dy1zPb4jdJnSN8Xg01/xYxgvNkKbETO0aLhBG4rLnpH6KBSIvaPGsNIgmLeM+4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SfPe6b4s; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SfPe6b4s"
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-81ed3e6b8e3so747733b3a.2
        for <git@vger.kernel.org>; Sat, 07 Feb 2026 02:03:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770458625; x=1771063425; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wnHg0cXc3iuPTDsDauA9xEGLN2PbSq6KIRjZMGso1TY=;
        b=SfPe6b4sJZIyL9E2Ucc48hSFdVkibzlaWMj9ipK0FiPYjYod9g47EcTi0V2uF281kk
         Dv0QrYCBWceM5ZfiV4vz3DMskfKziUf64PGgPDfqh7MW9kJh57uX6qUouj+DrKhjE7Lv
         rYqoeE4GjBBPqzKNVEJzd5YP7qOz3DFLO/sRcfTljMHWAZh2dFElLhAsQXTSAi3/kwWp
         hK8eUbIQx/ALhDATDf0aVbEdFe+dCGjB1izzas+FZ/PuyjN6if6Dbg8N7Jc80ZRAcK1i
         yQfvpzzXDXvRFBgHIL2q7IoQ1xeMHekQihVfIfg2cZ9aLWi1COsSRLIMlndDSb0gBiHL
         FxPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770458625; x=1771063425;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wnHg0cXc3iuPTDsDauA9xEGLN2PbSq6KIRjZMGso1TY=;
        b=k5Dkv2JPzL3v4K+Lk6SvDYt06yDXwD+95INiY5T41y0GCI1wNSnf1nbvK68DaMDFtR
         pApbw6TH+1h+KpWc97y2UWdTaYYPf3p3LI2iUsyU+yd1YNpEuYsaVBeJvG3GDjQNF2iH
         YDVngG9EOOs4griYAbR5Ie7tVeeFiPfbfqb1buSzpSdV7nMFdILk9SqF3pLmRnSiGoPa
         alonmHt5PxJW/bnQUnGjXW84jBydXls/gtjcsudpuK6bagyP+j9hwRKD4sRJXPvJKQ3g
         qiXngUBpend5IpQVnK0hBtmnYDsoM0tt4NhEX03NjptiUmVEwmfto/PGLmx7pHcwFzOG
         UT2w==
X-Gm-Message-State: AOJu0YxjN4x01PgIav42wBnF00OiEwhx/314rwispVkae75j+rXNqM4Y
	B2QJoYKNpJ+WGcJxlI88wcBEZttvTVF8ci3u6wId+VTndgBgHjJjnQ5V9KJyvtyY
X-Gm-Gg: AZuq6aLb407Gnso+VOMi9IiJfl6HgrH2fEczhETKCttJuX9l8PHVkwVYjkFlfidXh6B
	GGlUuy2vYb9QNZF90577FLasw3NV/2R2RC3ucnbZzVM6dJHD8141BmJeYogZkgtTm8ZNRoVdwi/
	PYyK02r4i4s5gaBGyLGsHWuMxCykyi+SUlmuTQbVomQ9R9naofQRagUXVoE6OUdk/88AxrjgcmJ
	iQIii6tlkTAUHfDHAC3UsqSACoH2T2f5xjci3CE7qpyUTwlkj0VMKs7UY8ahQclQdXvwe8ZKxNS
	mO7k/ixkJoPD5WO0LUzua3YCGIO8vIfHPLaQw9X7UHfJjc3LZSyj7cpE7wf2YzPeUqK4/hLXplW
	6N+G0/BfIwF8ahdvT1ZaFl4EPob6cElSBIgTrlCoBAuxQ/UfMVQ2MliswHND2cLYldAABxHVWlu
	CKSFTWTb405BJHWbgT5Bn9c6zrb9Qu47sG2gyATXyNMVmTQQ==
X-Received: by 2002:a05:6a00:3d47:b0:81f:852b:a939 with SMTP id d2e1a72fcca58-824417b475dmr5144451b3a.63.1770458624784;
        Sat, 07 Feb 2026 02:03:44 -0800 (PST)
Received: from Shreyansh-PC.domain.name ([2401:4900:1cd6:312c:b151:d56:3281:2879])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-824418bf024sm4435362b3a.56.2026.02.07.02.03.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Feb 2026 02:03:44 -0800 (PST)
From: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	karthik.188@gmail.com,
	phillip.wood123@gmail.com,
	Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
Subject: [PATCH v3 1/3] wt-status: pass struct repository through function parameters
Date: Sat,  7 Feb 2026 15:30:46 +0530
Message-ID: <20260207100322.1786368-2-shreyanshpaliwalcmsmn@gmail.com>
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

Some functions in wt-status.c (count_stash_entries(),
read_line_from_git_path(), abbrev_oid_in_line(), read_rebase_todolist())
do not have access to a local repository instance and rely on the_repository.

Add a struct repository *r parameter to these functions, and pass the local
repository through the callers.

get_branch(), wt_status_check_rebase() and wt_status_check_bisect() already
receive a struct worktree *, which can provide access to the repository.
However, some callers pass NULL as the worktree like in wt_status_get_state(),
which would make using wt->repo unsafe and lead to segfault issues.
Add an explicit struct repository * parameter to these functions as well,
and pass the repository through the callers.

Both wt_status_check_rebase() and  wt_status_check_bisect() are called from
branch.c and worktree.c,

* In branch.c, wt is always non-NULL as the functions are called within an
interation over worktrees in prepare_checked_out_branches().

* In worktree.c the functions are called from is_worktree_being_rebased() and
is_worktree_being_bisected() respectively which are further called from
builtin/branch.c in reject_rebase_or_bisect_branch() which has a non-NULL
worktree as it is called inside an iteration over worktrees as well.

Signed-off-by: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
---
 branch.c    |  4 ++--
 worktree.c  |  4 ++--
 wt-status.c | 48 +++++++++++++++++++++++++-----------------------
 wt-status.h |  6 ++++--
 4 files changed, 33 insertions(+), 29 deletions(-)

diff --git a/branch.c b/branch.c
index 243db7d0fc..e3cf273339 100644
--- a/branch.c
+++ b/branch.c
@@ -412,7 +412,7 @@ static void prepare_checked_out_branches(void)
 			free(old);
 		}
 
-		if (wt_status_check_rebase(wt, &state) &&
+		if (wt_status_check_rebase(wt->repo, wt, &state) &&
 		    (state.rebase_in_progress || state.rebase_interactive_in_progress) &&
 		    state.branch) {
 			struct strbuf ref = STRBUF_INIT;
@@ -425,7 +425,7 @@ static void prepare_checked_out_branches(void)
 		}
 		wt_status_state_free_buffers(&state);
 
-		if (wt_status_check_bisect(wt, &state) &&
+		if (wt_status_check_bisect(wt->repo, wt, &state) &&
 		    state.bisecting_from) {
 			struct strbuf ref = STRBUF_INIT;
 			strbuf_addf(&ref, "refs/heads/%s", state.bisecting_from);
diff --git a/worktree.c b/worktree.c
index 9308389cb6..0708d202cc 100644
--- a/worktree.c
+++ b/worktree.c
@@ -443,7 +443,7 @@ int is_worktree_being_rebased(const struct worktree *wt,
 	int found_rebase;
 
 	memset(&state, 0, sizeof(state));
-	found_rebase = wt_status_check_rebase(wt, &state) &&
+	found_rebase = wt_status_check_rebase(wt->repo, wt, &state) &&
 		       (state.rebase_in_progress ||
 			state.rebase_interactive_in_progress) &&
 		       state.branch &&
@@ -460,7 +460,7 @@ int is_worktree_being_bisected(const struct worktree *wt,
 	int found_bisect;
 
 	memset(&state, 0, sizeof(state));
-	found_bisect = wt_status_check_bisect(wt, &state) &&
+	found_bisect = wt_status_check_bisect(wt->repo, wt, &state) &&
 		       state.bisecting_from &&
 		       skip_prefix(target, "refs/heads/", &target) &&
 		       !strcmp(state.bisecting_from, target);
diff --git a/wt-status.c b/wt-status.c
index e12adb26b9..ea81418bdd 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -984,7 +984,7 @@ static int stash_count_refs(const char *refname UNUSED,
 	return 0;
 }
 
-static int count_stash_entries(void)
+static int count_stash_entries(struct repository *r)
 {
 	int n = 0;
 	refs_for_each_reflog_ent(get_main_ref_store(the_repository),
@@ -994,7 +994,7 @@ static int count_stash_entries(void)
 
 static void wt_longstatus_print_stash_summary(struct wt_status *s)
 {
-	int stash_count = count_stash_entries();
+	int stash_count = count_stash_entries(s->repo);
 
 	if (stash_count > 0)
 		status_printf_ln(s, GIT_COLOR_NORMAL,
@@ -1287,7 +1287,7 @@ static void show_am_in_progress(struct wt_status *s,
 	wt_longstatus_print_trailer(s);
 }
 
-static char *read_line_from_git_path(const char *filename)
+static char *read_line_from_git_path(struct repository *r, char *filename)
 {
 	struct strbuf buf = STRBUF_INIT;
 	FILE *fp = fopen_or_warn(repo_git_path_append(the_repository, &buf,
@@ -1325,8 +1325,8 @@ static int split_commit_in_progress(struct wt_status *s)
 	if (head_flags & REF_ISSYMREF || orig_head_flags & REF_ISSYMREF)
 		return 0;
 
-	rebase_amend = read_line_from_git_path("rebase-merge/amend");
-	rebase_orig_head = read_line_from_git_path("rebase-merge/orig-head");
+	rebase_amend = read_line_from_git_path(s->repo, "rebase-merge/amend");
+	rebase_orig_head = read_line_from_git_path(s->repo, "rebase-merge/orig-head");
 
 	if (!rebase_amend || !rebase_orig_head)
 		; /* fall through, no split in progress */
@@ -1350,7 +1350,7 @@ static int split_commit_in_progress(struct wt_status *s)
  * The function assumes that the line does not contain useless spaces
  * before or after the command.
  */
-static void abbrev_oid_in_line(struct strbuf *line)
+static void abbrev_oid_in_line(struct repository *r, struct strbuf *line)
 {
 	struct string_list split = STRING_LIST_INIT_DUP;
 	struct object_id oid;
@@ -1372,7 +1372,7 @@ static void abbrev_oid_in_line(struct strbuf *line)
 	string_list_clear(&split, 0);
 }
 
-static int read_rebase_todolist(const char *fname, struct string_list *lines)
+static int read_rebase_todolist(struct repository *r, char *fname, struct string_list *lines)
 {
 	struct strbuf buf = STRBUF_INIT;
 	FILE *f = fopen(repo_git_path_append(the_repository, &buf, "%s", fname), "r");
@@ -1392,7 +1392,7 @@ static int read_rebase_todolist(const char *fname, struct string_list *lines)
 		strbuf_trim(&buf);
 		if (!buf.len)
 			continue;
-		abbrev_oid_in_line(&buf);
+		abbrev_oid_in_line(r, &buf);
 		string_list_append(lines, buf.buf);
 	}
 	fclose(f);
@@ -1413,8 +1413,8 @@ static void show_rebase_information(struct wt_status *s,
 		struct string_list have_done = STRING_LIST_INIT_DUP;
 		struct string_list yet_to_do = STRING_LIST_INIT_DUP;
 
-		read_rebase_todolist("rebase-merge/done", &have_done);
-		if (read_rebase_todolist("rebase-merge/git-rebase-todo",
+		read_rebase_todolist(s->repo, "rebase-merge/done", &have_done);
+		if (read_rebase_todolist(s->repo, "rebase-merge/git-rebase-todo",
 					 &yet_to_do))
 			status_printf_ln(s, color,
 				_("git-rebase-todo is missing."));
@@ -1618,7 +1618,7 @@ static void show_sparse_checkout_in_use(struct wt_status *s,
 /*
  * Extract branch information from rebase/bisect
  */
-static char *get_branch(const struct worktree *wt, const char *path)
+static char *get_branch(struct repository *r, struct worktree *wt, const char *path)
 {
 	struct strbuf sb = STRBUF_INIT;
 	struct object_id oid;
@@ -1718,8 +1718,9 @@ static void wt_status_get_detached_from(struct repository *r,
 	strbuf_release(&cb.buf);
 }
 
-int wt_status_check_rebase(const struct worktree *wt,
-			   struct wt_status_state *state)
+int wt_status_check_rebase(struct repository *r,
+	 			const struct worktree *wt,
+			    struct wt_status_state *state)
 {
 	struct stat st;
 
@@ -1730,29 +1731,30 @@ int wt_status_check_rebase(const struct worktree *wt,
 				state->am_empty_patch = 1;
 		} else {
 			state->rebase_in_progress = 1;
-			state->branch = get_branch(wt, "rebase-apply/head-name");
-			state->onto = get_branch(wt, "rebase-apply/onto");
+			state->branch = get_branch(r, wt, "rebase-apply/head-name");
+			state->onto = get_branch(r, wt, "rebase-apply/onto");
 		}
 	} else if (!stat(worktree_git_path(the_repository, wt, "rebase-merge"), &st)) {
 		if (!stat(worktree_git_path(the_repository, wt, "rebase-merge/interactive"), &st))
 			state->rebase_interactive_in_progress = 1;
 		else
 			state->rebase_in_progress = 1;
-		state->branch = get_branch(wt, "rebase-merge/head-name");
-		state->onto = get_branch(wt, "rebase-merge/onto");
+		state->branch = get_branch(r, wt, "rebase-merge/head-name");
+		state->onto = get_branch(r, wt, "rebase-merge/onto");
 	} else
 		return 0;
 	return 1;
 }
 
-int wt_status_check_bisect(const struct worktree *wt,
+int wt_status_check_bisect(struct repository *r, 
+			   struct worktree *wt,
 			   struct wt_status_state *state)
 {
 	struct stat st;
 
 	if (!stat(worktree_git_path(the_repository, wt, "BISECT_LOG"), &st)) {
 		state->bisect_in_progress = 1;
-		state->bisecting_from = get_branch(wt, "BISECT_START");
+		state->bisecting_from = get_branch(r, wt, "BISECT_START");
 		return 1;
 	}
 	return 0;
@@ -1797,16 +1799,16 @@ void wt_status_get_state(struct repository *r,
 	enum replay_action action;
 
 	if (!stat(git_path_merge_head(r), &st)) {
-		wt_status_check_rebase(NULL, state);
+		wt_status_check_rebase(r, NULL, state);
 		state->merge_in_progress = 1;
-	} else if (wt_status_check_rebase(NULL, state)) {
+	} else if (wt_status_check_rebase(r, NULL, state)) {
 		;		/* all set */
 	} else if (refs_ref_exists(get_main_ref_store(r), "CHERRY_PICK_HEAD") &&
 		   !repo_get_oid(r, "CHERRY_PICK_HEAD", &oid)) {
 		state->cherry_pick_in_progress = 1;
 		oidcpy(&state->cherry_pick_head_oid, &oid);
 	}
-	wt_status_check_bisect(NULL, state);
+	wt_status_check_bisect(r, NULL, state);
 	if (refs_ref_exists(get_main_ref_store(r), "REVERT_HEAD") &&
 	    !repo_get_oid(r, "REVERT_HEAD", &oid)) {
 		state->revert_in_progress = 1;
@@ -2259,7 +2261,7 @@ static void wt_porcelain_v2_print_tracking(struct wt_status *s)
  */
 static void wt_porcelain_v2_print_stash(struct wt_status *s)
 {
-	int stash_count = count_stash_entries();
+	int stash_count = count_stash_entries(s->repo);
 	char eol = s->null_termination ? '\0' : '\n';
 
 	if (stash_count > 0)
diff --git a/wt-status.h b/wt-status.h
index e40a27214a..5ac3d96210 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -164,9 +164,11 @@ void wt_status_state_free_buffers(struct wt_status_state *s);
 void wt_status_get_state(struct repository *repo,
 			 struct wt_status_state *state,
 			 int get_detached_from);
-int wt_status_check_rebase(const struct worktree *wt,
+int wt_status_check_rebase(struct repository *r,
+			   struct worktree *wt,
 			   struct wt_status_state *state);
-int wt_status_check_bisect(const struct worktree *wt,
+int wt_status_check_bisect(struct repository *r,
+			   struct worktree *wt,
 			   struct wt_status_state *state);
 
 __attribute__((format (printf, 3, 4)))
-- 
2.52.0

