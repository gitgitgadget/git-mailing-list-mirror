Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5513E3321A2
	for <git@vger.kernel.org>; Sat,  7 Feb 2026 10:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770458616; cv=none; b=DF0t80UzUyh1BmEXEbeQBRgi4sIZWnw6ienas3E/G2a0ph1H3Q44ByV4wFqbPVxg2wC+cjzvjA07Vn3c9uYOGfAy9giDecg7i4a2kM41KS7EC3kgFKLts1//DkvZjKtLQiGgZfa3O4s8Aky4lwbV8jIeXXTfSlpsMASzO8/mMoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770458616; c=relaxed/simple;
	bh=yucvmuTYRGUofvCAbIVu0TdWAqr6iGLPOvahzW1mwc4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qfnDYUltmlkA0p4Lv2UqGbAdjcJn0ZLWNt4l8Qx+l2057izbptL5IlpfnzrFU5mFS/pZw1nSu4yrae2sUZDQh9bV7mezknHxc7vx8qyLestURdR8wIdA0kG2EA3KvvRCLjXiLBcFbhOyNgmG6lHIFkHvYMLarT+Ylfmma3Issr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mi6yk9fa; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mi6yk9fa"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-823075fed75so1750313b3a.1
        for <git@vger.kernel.org>; Sat, 07 Feb 2026 02:03:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770458615; x=1771063415; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VaEJHtFGLhkvEyjb/X3R6PvMbRrDm6BdvkcQcEIDE3U=;
        b=Mi6yk9faayLIipCNdAXsM4XpX1ntlYMk4FvwgzisCWGiuODRvc8k4Oocza6hx624D2
         kLM3MVF7EOlJCkxAPH2MgdCwIl9ELEwbhWuhEdfDgFKe5h5BN0KJq63IudVD7JyG+Bhl
         AqGnh67b6weqG0CCb2XjcQIPh9sF9WFkouJoyuXPdBUg/keMSd8FZmVKp6+F1rzpSU7U
         iPDrrOSsL6ofUnZ5vGAy30k9NIN4k4RlQCtq8WrioGC8eqmjn6XkVt/hcBubMkoEfuJG
         29IsGHeEfVC0ruazhHQJ7UxiBqczveHXiGlXPJs3VVwluhkI6Fs2E8ZQy/1FmsM2aKrP
         VxLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770458615; x=1771063415;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VaEJHtFGLhkvEyjb/X3R6PvMbRrDm6BdvkcQcEIDE3U=;
        b=YPing0rhs8TWvFgdX0yuQDcvQgUqI8PN3Y9KnPSEGLQlC74yq+JdFzxS/uQMdWknrw
         PHYMceZyRxYSBegMOgQrO0QH68NCxsW/eVNVdpcSLZmdXmOTloWBnsNjBhBLe/QWuMmV
         KME0v3PMG9umrF04Pz4FX1wrBDj4UyZAWcFhzx6miKHAAPttpno5b/V78jiL0Z36N/Ck
         ksex9mHBHGhxcGJkKqvMONAbsXPNGNWFQmrsL8wG6Y4nJbbraguQaRMCRExR22PYpHuC
         je4SH4di8ONwCh31gLYR/nw1kg+EHkxqXf1TsaTBZ4c7yYDYCfJrZ4sIXolEv0TfBL4w
         zv+g==
X-Gm-Message-State: AOJu0YxKY7ZEiEfSz+RaABspiiYXY7dE9+BAcoI7SaqgoelJAuUekZ6F
	dkMPFiJZVdDWRIAdOnbBtH4+3gR3BjuEq/1YVTSMD5IrVSItlcUlpYY7SKxbJA==
X-Gm-Gg: AZuq6aLV+8Nj8kXI5JfiwXIU+vovimuUHPJ6JrwZksunHDHSFdO43VGmCFkEiwtlwWO
	Ng7q4JYJYPWSVuVWfUD7OPDA3Fc2tLNQBv696PBVAi5XginsXsdP50DzNEhw5Fnu/6Hxu3BB3fv
	S57T0+78K1fruUWVa7OmZbqo8y8tOEIWMb1Q95sGSBVHxrnVo4TLawn6WPjKcimiXVtZOLYQ70h
	aOC1Z21yZ9HJmzoI8hViJMyGFefAroVDlHMNKyLlURkAUb9z9j+JrICUBXcJoCZgwqCUuCnvCPu
	dwUM2GiH5TuzmU+u4nES4oeoCzmYvTnX5m+8WzI28dIwW9MJRgR5Ay9l1aQLHjYlCMNsGO4nsTU
	+UwXHghTJ2RS064sysVV1OCQaCQBSBbDBrI/TXOPtAy3hLyp1Mfs0hqMy8sQJBGxKqg+2Eu9fGF
	RmKlGWsezJBZYf67ciDgKjxla4CXFGne2xKD+f+eVGPt++uA==
X-Received: by 2002:a05:6a00:3c85:b0:81f:ac1c:709e with SMTP id d2e1a72fcca58-82440de80aemr4869805b3a.31.1770458615259;
        Sat, 07 Feb 2026 02:03:35 -0800 (PST)
Received: from Shreyansh-PC.domain.name ([2401:4900:1cd6:312c:b151:d56:3281:2879])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-824418bf024sm4435362b3a.56.2026.02.07.02.03.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Feb 2026 02:03:34 -0800 (PST)
From: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	karthik.188@gmail.com,
	phillip.wood123@gmail.com,
	Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
Subject: [PATCH v3 0/3] wt-status: reduce reliance on global state
Date: Sat,  7 Feb 2026 15:30:45 +0530
Message-ID: <20260207100322.1786368-1-shreyanshpaliwalcmsmn@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260205101524.125452-1-shreyanshpaliwalcmsmn@gmail.com>
References: <20260205101524.125452-1-shreyanshpaliwalcmsmn@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In wt-status.c code still relies on some global variables, including
the_repository and the_hash_algo, even in cases where a repository
instance is already available via struct wt_status or struct worktree.

In patch 1/3, update function parameters and callers to pass struct
repository where no local repository access was available.

In patch 2/3, replace direct uses of the_repository with repository
instances already available in local structs.

In patch 3/3, replace remaining uses of the global the_hash_algo with the
hash algorithm stored in the respective repository instance.

These changes remove all direct uses of the_repository and
the_hash_algo from wt-status.c and reduce its dependence on global state.

The 'USE_THE_REPOSITORY_VARIABLE' macro cannot yet be removed, since these
patches only eliminate direct uses of the_repository and the_hash_algo,
while other global variables are still referenced.

In particular wt-status.c still relies on the following globals,

* core_apply_sparse_checkout, this is already being addressed in an
ongoing patch series [1].

* comment_line_str and DEFAULT_ABBREV, these both still are used in
wt-status.c but they dont have any equivalent local instances.

[1]- https://lore.kernel.org/git/5e56e1cc4172cfff9e917a068184e102aa70bf1d.1769256839.git.belkid98@gmail.com/t/#u

Shreyansh Paliwal (3):
  wt-status: pass struct repository through function parameters
  wt-status: replace uses of the_repository with local repository instances
  wt-status: use hash_algo from local repository instead of global the_hash_algo

 branch.c    |   4 +--
 worktree.c  |   4 +--
 wt-status.c | 102 ++++++++++++++++++++++++++--------------------------
 wt-status.h |   6 ++--
 4 files changed, 60 insertions(+), 56 deletions(-)

---
Changes in v2:
 - Reordered the first 2 patches for better flow.
 - Instead of relying on wt->repo in wt_status_check_rebase() and
    wt_status_check_bisect() addded struct repository.
 - Added extra explainations in the commit message for the usage of wt
    and being it not NULL.

Range-diff against v2:
2:  2af0113f6f ! 1:  960216e45c wt-status: pass struct repository and wt_status through function parameters
    @@ Metadata
     Author: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
     
      ## Commit message ##
    -    wt-status: pass struct repository and wt_status through function parameters
    +    wt-status: pass struct repository through function parameters
     
    -    Some functions in wt-status.c relied on the_repository because no
    -    repository instance was available in their local scope.
    -    There is also a specific case in wt_status_check_rebase() where the
    -    worktree can be NULL, so accessing wt->repo may lead to a segfault.
    +    Some functions in wt-status.c (count_stash_entries(),
    +    read_line_from_git_path(), abbrev_oid_in_line(), read_rebase_todolist())
    +    do not have access to a local repository instance and rely on the_repository.
     
    -    Update these functions to accept a struct repository or struct
    -    wt_status parameter, and adjust callers accordingly. Replace the
    -    remaining uses of the_repository in these functions with the
    -    passed-in repository instance.
    +    Add a struct repository *r parameter to these functions, and pass the local
    +    repository through the callers.
     
    -    This removes the use of the_repository global variable from
    -    wt-status.c completely.
    +    get_branch(), wt_status_check_rebase() and wt_status_check_bisect() already
    +    receive a struct worktree *, which can provide access to the repository.
    +    However, some callers pass NULL as the worktree like in wt_status_get_state(),
    +    which would make using wt->repo unsafe and lead to segfault issues.
    +    Add an explicit struct repository * parameter to these functions as well,
    +    and pass the repository through the callers.
    +
    +    Both wt_status_check_rebase() and  wt_status_check_bisect() are called from
    +    branch.c and worktree.c,
    +
    +    * In branch.c, wt is always non-NULL as the functions are called within an
    +    interation over worktrees in prepare_checked_out_branches().
    +    * In worktree.c the functions are called from is_worktree_being_rebased() and
    +    is_worktree_being_bisected() respectively which are further called from
    +    builtin/branch.c in reject_rebase_or_bisect_branch() which has a non-NULL
    +    worktree as it is called inside an iteration over worktrees as well.
     
         Signed-off-by: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
     
    @@ branch.c: static void prepare_checked_out_branches(void)
      		    (state.rebase_in_progress || state.rebase_interactive_in_progress) &&
      		    state.branch) {
      			struct strbuf ref = STRBUF_INIT;
    +@@ branch.c: static void prepare_checked_out_branches(void)
    + 		}
    + 		wt_status_state_free_buffers(&state);
    + 
    +-		if (wt_status_check_bisect(wt, &state) &&
    ++		if (wt_status_check_bisect(wt->repo, wt, &state) &&
    + 		    state.bisecting_from) {
    + 			struct strbuf ref = STRBUF_INIT;
    + 			strbuf_addf(&ref, "refs/heads/%s", state.bisecting_from);
     
      ## worktree.c ##
     @@ worktree.c: int is_worktree_being_rebased(const struct worktree *wt,
    @@ worktree.c: int is_worktree_being_rebased(const struct worktree *wt,
      		       (state.rebase_in_progress ||
      			state.rebase_interactive_in_progress) &&
      		       state.branch &&
    +@@ worktree.c: int is_worktree_being_bisected(const struct worktree *wt,
    + 	int found_bisect;
    + 
    + 	memset(&state, 0, sizeof(state));
    +-	found_bisect = wt_status_check_bisect(wt, &state) &&
    ++	found_bisect = wt_status_check_bisect(wt->repo, wt, &state) &&
    + 		       state.bisecting_from &&
    + 		       skip_prefix(target, "refs/heads/", &target) &&
    + 		       !strcmp(state.bisecting_from, target);
     
      ## wt-status.c ##
     @@ wt-status.c: static int stash_count_refs(const char *refname UNUSED,
    @@ wt-status.c: static int stash_count_refs(const char *refname UNUSED,
     +static int count_stash_entries(struct repository *r)
      {
      	int n = 0;
    --	refs_for_each_reflog_ent(get_main_ref_store(the_repository),
    -+	refs_for_each_reflog_ent(get_main_ref_store(r),
    - 				 "refs/stash", stash_count_refs, &n);
    - 	return n;
    - }
    + 	refs_for_each_reflog_ent(get_main_ref_store(the_repository),
    +@@ wt-status.c: static int count_stash_entries(void)
      
      static void wt_longstatus_print_stash_summary(struct wt_status *s)
      {
    @@ wt-status.c: static void show_am_in_progress(struct wt_status *s,
      }
      
     -static char *read_line_from_git_path(const char *filename)
    -+static char *read_line_from_git_path(struct repository *r, const char *filename)
    ++static char *read_line_from_git_path(struct repository *r, char *filename)
      {
      	struct strbuf buf = STRBUF_INIT;
    --	FILE *fp = fopen_or_warn(repo_git_path_append(the_repository, &buf,
    -+	FILE *fp = fopen_or_warn(repo_git_path_append(r, &buf,
    - 						      "%s", filename), "r");
    - 
    - 	if (!fp) {
    + 	FILE *fp = fopen_or_warn(repo_git_path_append(the_repository, &buf,
     @@ wt-status.c: static int split_commit_in_progress(struct wt_status *s)
      	if (head_flags & REF_ISSYMREF || orig_head_flags & REF_ISSYMREF)
      		return 0;
    @@ wt-status.c: static int split_commit_in_progress(struct wt_status *s)
      {
      	struct string_list split = STRING_LIST_INIT_DUP;
      	struct object_id oid;
    -@@ wt-status.c: static void abbrev_oid_in_line(struct strbuf *line)
    - 		return;
    - 
    - 	if ((2 <= string_list_split(&split, line->buf, " ", 2)) &&
    --	    !repo_get_oid(the_repository, split.items[1].string, &oid)) {
    -+	    !repo_get_oid(r, split.items[1].string, &oid)) {
    - 		strbuf_reset(line);
    - 		strbuf_addf(line, "%s ", split.items[0].string);
    - 		strbuf_add_unique_abbrev(line, &oid, DEFAULT_ABBREV);
     @@ wt-status.c: static void abbrev_oid_in_line(struct strbuf *line)
      	string_list_clear(&split, 0);
      }
      
     -static int read_rebase_todolist(const char *fname, struct string_list *lines)
    -+static int read_rebase_todolist(struct repository *r, const char *fname, struct string_list *lines)
    ++static int read_rebase_todolist(struct repository *r, char *fname, struct string_list *lines)
      {
      	struct strbuf buf = STRBUF_INIT;
    --	FILE *f = fopen(repo_git_path_append(the_repository, &buf, "%s", fname), "r");
    -+	FILE *f = fopen(repo_git_path_append(r, &buf, "%s", fname), "r");
    - 	int ret;
    - 
    - 	if (!f) {
    -@@ wt-status.c: static int read_rebase_todolist(const char *fname, struct string_list *lines)
    - 			goto out;
    - 		}
    - 		die_errno("Could not open file %s for reading",
    --			  repo_git_path_replace(the_repository, &buf, "%s", fname));
    -+			  repo_git_path_replace(r, &buf, "%s", fname));
    - 	}
    - 	while (!strbuf_getline_lf(&buf, f)) {
    - 		if (starts_with(buf.buf, comment_line_str))
    + 	FILE *f = fopen(repo_git_path_append(the_repository, &buf, "%s", fname), "r");
     @@ wt-status.c: static int read_rebase_todolist(const char *fname, struct string_list *lines)
      		strbuf_trim(&buf);
      		if (!buf.len)
    @@ wt-status.c: static void show_rebase_information(struct wt_status *s,
      					 &yet_to_do))
      			status_printf_ln(s, color,
      				_("git-rebase-todo is missing."));
    +@@ wt-status.c: static void show_sparse_checkout_in_use(struct wt_status *s,
    + /*
    +  * Extract branch information from rebase/bisect
    +  */
    +-static char *get_branch(const struct worktree *wt, const char *path)
    ++static char *get_branch(struct repository *r, struct worktree *wt, const char *path)
    + {
    + 	struct strbuf sb = STRBUF_INIT;
    + 	struct object_id oid;
     @@ wt-status.c: static void wt_status_get_detached_from(struct repository *r,
      	strbuf_release(&cb.buf);
      }
    @@ wt-status.c: static void wt_status_get_detached_from(struct repository *r,
     -int wt_status_check_rebase(const struct worktree *wt,
     -			   struct wt_status_state *state)
     +int wt_status_check_rebase(struct repository *r,
    -+			 const struct worktree *wt,
    -+			 struct wt_status_state *state)
    ++	 			const struct worktree *wt,
    ++			    struct wt_status_state *state)
      {
      	struct stat st;
      
    --	if (!stat(worktree_git_path(the_repository, wt, "rebase-apply"), &st)) {
    --		if (!stat(worktree_git_path(the_repository, wt, "rebase-apply/applying"), &st)) {
    -+	if (!stat(worktree_git_path(r, wt, "rebase-apply"), &st)) {
    -+		if (!stat(worktree_git_path(r, wt, "rebase-apply/applying"), &st)) {
    - 			state->am_in_progress = 1;
    --			if (!stat(worktree_git_path(the_repository, wt, "rebase-apply/patch"), &st) && !st.st_size)
    -+			if (!stat(worktree_git_path(r, wt, "rebase-apply/patch"), &st) && !st.st_size)
    +@@ wt-status.c: int wt_status_check_rebase(const struct worktree *wt,
      				state->am_empty_patch = 1;
      		} else {
      			state->rebase_in_progress = 1;
    - 			state->branch = get_branch(wt, "rebase-apply/head-name");
    - 			state->onto = get_branch(wt, "rebase-apply/onto");
    +-			state->branch = get_branch(wt, "rebase-apply/head-name");
    +-			state->onto = get_branch(wt, "rebase-apply/onto");
    ++			state->branch = get_branch(r, wt, "rebase-apply/head-name");
    ++			state->onto = get_branch(r, wt, "rebase-apply/onto");
      		}
    --	} else if (!stat(worktree_git_path(the_repository, wt, "rebase-merge"), &st)) {
    --		if (!stat(worktree_git_path(the_repository, wt, "rebase-merge/interactive"), &st))
    -+	} else if (!stat(worktree_git_path(r, wt, "rebase-merge"), &st)) {
    -+		if (!stat(worktree_git_path(r, wt, "rebase-merge/interactive"), &st))
    + 	} else if (!stat(worktree_git_path(the_repository, wt, "rebase-merge"), &st)) {
    + 		if (!stat(worktree_git_path(the_repository, wt, "rebase-merge/interactive"), &st))
      			state->rebase_interactive_in_progress = 1;
      		else
      			state->rebase_in_progress = 1;
    +-		state->branch = get_branch(wt, "rebase-merge/head-name");
    +-		state->onto = get_branch(wt, "rebase-merge/onto");
    ++		state->branch = get_branch(r, wt, "rebase-merge/head-name");
    ++		state->onto = get_branch(r, wt, "rebase-merge/onto");
    + 	} else
    + 		return 0;
    + 	return 1;
    + }
    + 
    +-int wt_status_check_bisect(const struct worktree *wt,
    ++int wt_status_check_bisect(struct repository *r, 
    ++			   struct worktree *wt,
    + 			   struct wt_status_state *state)
    + {
    + 	struct stat st;
    + 
    + 	if (!stat(worktree_git_path(the_repository, wt, "BISECT_LOG"), &st)) {
    + 		state->bisect_in_progress = 1;
    +-		state->bisecting_from = get_branch(wt, "BISECT_START");
    ++		state->bisecting_from = get_branch(r, wt, "BISECT_START");
    + 		return 1;
    + 	}
    + 	return 0;
     @@ wt-status.c: void wt_status_get_state(struct repository *r,
      	enum replay_action action;
      
    @@ wt-status.c: void wt_status_get_state(struct repository *r,
      		;		/* all set */
      	} else if (refs_ref_exists(get_main_ref_store(r), "CHERRY_PICK_HEAD") &&
      		   !repo_get_oid(r, "CHERRY_PICK_HEAD", &oid)) {
    + 		state->cherry_pick_in_progress = 1;
    + 		oidcpy(&state->cherry_pick_head_oid, &oid);
    + 	}
    +-	wt_status_check_bisect(NULL, state);
    ++	wt_status_check_bisect(r, NULL, state);
    + 	if (refs_ref_exists(get_main_ref_store(r), "REVERT_HEAD") &&
    + 	    !repo_get_oid(r, "REVERT_HEAD", &oid)) {
    + 		state->revert_in_progress = 1;
     @@ wt-status.c: static void wt_porcelain_v2_print_tracking(struct wt_status *s)
       */
      static void wt_porcelain_v2_print_stash(struct wt_status *s)
    @@ wt-status.h: void wt_status_state_free_buffers(struct wt_status_state *s);
      			 struct wt_status_state *state,
      			 int get_detached_from);
     -int wt_status_check_rebase(const struct worktree *wt,
    --			   struct wt_status_state *state);
     +int wt_status_check_rebase(struct repository *r,
    -+			 const struct worktree *wt,
    -+			 struct wt_status_state *state);
    - int wt_status_check_bisect(const struct worktree *wt,
    ++			   struct worktree *wt,
    + 			   struct wt_status_state *state);
    +-int wt_status_check_bisect(const struct worktree *wt,
    ++int wt_status_check_bisect(struct repository *r,
    ++			   struct worktree *wt,
      			   struct wt_status_state *state);
      
    + __attribute__((format (printf, 3, 4)))
1:  556735dfd4 ! 2:  906e682cd7 wt-status: replace uses of the_repository with local repository instances
    @@ Commit message
         wt-status: replace uses of the_repository with local repository instances
     
         wt-status.c uses the global the_repository in several places even when
    -    a repository instance is already available via struct wt_status or
    -    struct worktree.
    +    a repository instance is already available via struct wt_status *s or
    +    struct repository *r.
     
    -    Replace these direct uses of the_repository with the repository carried
    -    by the local structs (e.g. s->repo, wt->repo).
    +    Replace these uses of the_repository with the repository available
    +    in the local context (eg. s->repo or r).
     
         The replacements of all the_repository with s->repo are mostly
         to cases where a repository instance is already available via
    -    struct wt_status. All functions operating on struct wt_status *s
    -    are only used after s is initialized by wt_status_prepare(),
    +    struct wt_status *s and struct repository *r, all functions operating on
    +    struct wt_status *s are only used after s is initialized by wt_status_prepare(),
         which sets s->repo from the repository provided by the caller.
    -    As a result, s->repo is guaranteed to be available and consistent
    -    whenever these functions are invoked.
    +    As a result, s->repo is guaranteed to be available and consistent whenever
    +    these functions are invoked.
     
         This reduces reliance on global state and keeps wt-status consistent,
         though many functions operating on struct wt_status *s
    @@ wt-status.c: void wt_status_prepare(struct repository *r, struct wt_status *s)
      	s->reference = "HEAD";
      	s->fp = stdout;
     -	s->index_file = repo_get_index_file(the_repository);
    -+	s->index_file = repo_get_index_file(s->repo);
    ++	s->index_file = repo_get_index_file(r);
      	s->change.strdup_strings = 1;
      	s->untracked.strdup_strings = 1;
      	s->ignored.strdup_strings = 1;
    @@ wt-status.c: static void wt_status_collect_changes_index(struct wt_status *s)
      	setup_revisions(0, NULL, &rev, &opt);
      
      	rev.diffopt.flags.override_submodule_config = 1;
    +@@ wt-status.c: static int stash_count_refs(const char *refname UNUSED,
    + static int count_stash_entries(struct repository *r)
    + {
    + 	int n = 0;
    +-	refs_for_each_reflog_ent(get_main_ref_store(the_repository),
    ++	refs_for_each_reflog_ent(get_main_ref_store(r),
    + 				 "refs/stash", stash_count_refs, &n);
    + 	return n;
    + }
     @@ wt-status.c: static void wt_longstatus_print_verbose(struct wt_status *s)
      	rev.diffopt.ita_invisible_in_index = 1;
      
    @@ wt-status.c: static void wt_longstatus_print_verbose(struct wt_status *s)
      	setup_revisions(0, NULL, &rev, &opt);
      
      	rev.diffopt.output_format |= DIFF_FORMAT_PATCH;
    +@@ wt-status.c: static void show_am_in_progress(struct wt_status *s,
    + static char *read_line_from_git_path(struct repository *r, char *filename)
    + {
    + 	struct strbuf buf = STRBUF_INIT;
    +-	FILE *fp = fopen_or_warn(repo_git_path_append(the_repository, &buf,
    ++	FILE *fp = fopen_or_warn(repo_git_path_append(r, &buf,
    + 						      "%s", filename), "r");
    + 
    + 	if (!fp) {
     @@ wt-status.c: static int split_commit_in_progress(struct wt_status *s)
      	    !s->branch || strcmp(s->branch, "HEAD"))
      		return 0;
    @@ wt-status.c: static int split_commit_in_progress(struct wt_status *s)
      			       &orig_head_oid, &orig_head_flags))
      		return 0;
      	if (head_flags & REF_ISSYMREF || orig_head_flags & REF_ISSYMREF)
    +@@ wt-status.c: static void abbrev_oid_in_line(struct repository *r, struct strbuf *line)
    + 		return;
    + 
    + 	if ((2 <= string_list_split(&split, line->buf, " ", 2)) &&
    +-	    !repo_get_oid(the_repository, split.items[1].string, &oid)) {
    ++	    !repo_get_oid(r, split.items[1].string, &oid)) {
    + 		strbuf_reset(line);
    + 		strbuf_addf(line, "%s ", split.items[0].string);
    + 		strbuf_add_unique_abbrev(line, &oid, DEFAULT_ABBREV);
    +@@ wt-status.c: static void abbrev_oid_in_line(struct repository *r, struct strbuf *line)
    + static int read_rebase_todolist(struct repository *r, char *fname, struct string_list *lines)
    + {
    + 	struct strbuf buf = STRBUF_INIT;
    +-	FILE *f = fopen(repo_git_path_append(the_repository, &buf, "%s", fname), "r");
    ++	FILE *f = fopen(repo_git_path_append(r, &buf, "%s", fname), "r");
    + 	int ret;
    + 
    + 	if (!f) {
    +@@ wt-status.c: static int read_rebase_todolist(struct repository *r, char *fname, struct string
    + 			goto out;
    + 		}
    + 		die_errno("Could not open file %s for reading",
    +-			  repo_git_path_replace(the_repository, &buf, "%s", fname));
    ++			  repo_git_path_replace(r, &buf, "%s", fname));
    + 	}
    + 	while (!strbuf_getline_lf(&buf, f)) {
    + 		if (starts_with(buf.buf, comment_line_str))
     @@ wt-status.c: static void show_rebase_information(struct wt_status *s,
      				i++)
      				status_printf_ln(s, color, "   %s", have_done.items[i].string);
    @@ wt-status.c: static void show_revert_in_progress(struct wt_status *s,
      						DEFAULT_ABBREV));
      	if (s->hints) {
      		if (has_unmerged(s))
    -@@ wt-status.c: static char *get_branch(const struct worktree *wt, const char *path)
    +@@ wt-status.c: static char *get_branch(struct repository *r, struct worktree *wt, const char *p
      	struct object_id oid;
      	const char *branch_name;
      
     -	if (strbuf_read_file(&sb, worktree_git_path(the_repository, wt, "%s", path), 0) <= 0)
    -+	if (strbuf_read_file(&sb, worktree_git_path(wt->repo, wt, "%s", path), 0) <= 0)
    ++	if (strbuf_read_file(&sb, worktree_git_path(r, wt, "%s", path), 0) <= 0)
      		goto got_nothing;
      
      	while (sb.len && sb.buf[sb.len - 1] == '\n')
    @@ wt-status.c: static void wt_status_get_detached_from(struct repository *r,
      		strbuf_release(&cb.buf);
      		return;
      	}
    -@@ wt-status.c: int wt_status_check_bisect(const struct worktree *wt,
    +@@ wt-status.c: int wt_status_check_rebase(struct repository *r,
    + {
    + 	struct stat st;
    + 
    +-	if (!stat(worktree_git_path(the_repository, wt, "rebase-apply"), &st)) {
    +-		if (!stat(worktree_git_path(the_repository, wt, "rebase-apply/applying"), &st)) {
    ++	if (!stat(worktree_git_path(r, wt, "rebase-apply"), &st)) {
    ++		if (!stat(worktree_git_path(r, wt, "rebase-apply/applying"), &st)) {
    + 			state->am_in_progress = 1;
    +-			if (!stat(worktree_git_path(the_repository, wt, "rebase-apply/patch"), &st) && !st.st_size)
    ++			if (!stat(worktree_git_path(r, wt, "rebase-apply/patch"), &st) && !st.st_size)
    + 				state->am_empty_patch = 1;
    + 		} else {
    + 			state->rebase_in_progress = 1;
    + 			state->branch = get_branch(r, wt, "rebase-apply/head-name");
    + 			state->onto = get_branch(r, wt, "rebase-apply/onto");
    + 		}
    +-	} else if (!stat(worktree_git_path(the_repository, wt, "rebase-merge"), &st)) {
    +-		if (!stat(worktree_git_path(the_repository, wt, "rebase-merge/interactive"), &st))
    ++	} else if (!stat(worktree_git_path(r, wt, "rebase-merge"), &st)) {
    ++		if (!stat(worktree_git_path(r, wt, "rebase-merge/interactive"), &st))
    + 			state->rebase_interactive_in_progress = 1;
    + 		else
    + 			state->rebase_in_progress = 1;
    +@@ wt-status.c: int wt_status_check_bisect(struct repository *r,
      {
      	struct stat st;
      
     -	if (!stat(worktree_git_path(the_repository, wt, "BISECT_LOG"), &st)) {
    -+	if (!stat(worktree_git_path(wt->repo, wt, "BISECT_LOG"), &st)) {
    ++	if (!stat(worktree_git_path(r, wt, "BISECT_LOG"), &st)) {
      		state->bisect_in_progress = 1;
    - 		state->bisecting_from = get_branch(wt, "BISECT_START");
    + 		state->bisecting_from = get_branch(r, wt, "BISECT_START");
      		return 1;
     @@ wt-status.c: static void wt_shortstatus_print_tracking(struct wt_status *s)
      		upstream_is_gone = 1;
3:  b745a08d96 = 3:  9c0a1d82ad wt-status: use hash_algo from local repository instead of global the_hash_algo
-- 
2.52.0

