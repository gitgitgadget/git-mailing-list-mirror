Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CEEE30BB84
	for <git@vger.kernel.org>; Fri,  6 Feb 2026 13:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770383436; cv=none; b=pYSjw/64jdrBUfanGi6gI21fpmevxYpJnCBciJkb5PyguH1W+srbyvMMCDl9RIvetb29dbk5zgWYmw4sl6s4BFaQ7UociFEnxMkik9yVjaQ9rjzIGNzrbNVJQrgdVYkNFPkmHdtQmve6aB3bz7VJbWeBgvPEzqo8tjd+s2JaR9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770383436; c=relaxed/simple;
	bh=+IauysjqERvgNGlVT6/1W5iCpWedgyvsh4s2hm7yIjk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U3yrWzWItiOHTkFDlAiUuYqXjintVy4ARkj8dwuBLSStrWpjOw6IOZLxPxGRwue62c0r2FddD6r5hD/zvsNvLv+8eBIm/F6wI//7w0n4m8f7fdvonOHVLYi/MYEpVr73xMXfKJG1Wa960r0vFjf1mqNRA01f477N6xtRjgdHnzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cFvRR5al; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cFvRR5al"
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-2a7d98c1879so13292785ad.3
        for <git@vger.kernel.org>; Fri, 06 Feb 2026 05:10:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770383436; x=1770988236; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NUD97xCVC3Dfa0tMovIS+I+cT1GhPHEkKB0KUnoCVmg=;
        b=cFvRR5al2TmwxNJeqXFK/LLh3TsJNo45M+zDpTn4YMmE6UrhIeqPY9ecTjNWAXoiOg
         Md0JcYX1GJkVOpWJqDmEscNdentQHP3ZJuUgpwbHV1krpyrSK1Wvml21AkFy/tllD5Pi
         nwn5CLJtwZLpW7K7zXBiBcl8EDyWLEPPAQVfNf49pYuchJETBgDHBu4AsMpIk+G3yzVB
         S1u14wuMGlgADOYUvtLTxjwVoli+u2whLmibBvghkuJkWjF0NyK1DwBiNHqfh79jQoko
         Vr3Z7YxoVCk1aA0c27KLBiJyZbILCBDW0SJSsfTc4kiVNn7f3QFXviVPH9RFecNmWKpn
         I18g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770383436; x=1770988236;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NUD97xCVC3Dfa0tMovIS+I+cT1GhPHEkKB0KUnoCVmg=;
        b=CV9+ljoCw9ttiOAyuG3sI6xj6pbRHce/mDxIFHclPmA1EQqvjYkMH99Hk/dD/5odAW
         tNJFLBwrPS5BE7Vfzy5psuTkuDrDpNfzvmEv5H+RMZ8I1/sVqVAd4ZvAqco620yYfjge
         a+P5Zh2/ra83kTq6R2M3VQpmcQ1sCP1aLEXhvFRyGLGFHMWXW4FPkgKBJkagV3PBH3fI
         Klg10vuYjKgjTpqTqX5sk8hc44IMqSYWTn2l92Lxngm2Mdc4xHOWpl0D8vHAoavsneOP
         M655OnuNo+n0YaFjjE5XgUnph6myOL6qzFBSLYzcsSJF+oLKdRPWK25P+eODKeE4rqo4
         3Ezg==
X-Gm-Message-State: AOJu0YxBU50sBp2ngD2YDdNw+yGj6lkjeJA+CinhduzSPbbPRfGrMGlR
	9mgDCBVs5Qt+LbC+Qx7MZf18uCSFkM7fuIle8A5mmnnkhVZ69GKVIBMrflJWBLIY
X-Gm-Gg: AZuq6aJ+v0Sr7P5PxH1W0DG3jRtpSRVEIEpsn9bVJis4BbJkgzKnhaGruIQ/PGPoKl6
	6N4MlqPA183mCyuSUenRNbPY870riPQv7NDWrlUK/nt6VRvAuyCP7T9ZsK/w8e6LBMlfTy+x3fH
	i1CN45UQnslkVAJrM+7dFcDstVhwfzaeSdl6dl0jzGneOhtxIAKwBdmqQ6dVdFEC/iAK3qco6dq
	SD/zVm7roq84WkaTcAv80qAUTx/bAhIjwG7J391o2c9nw2dUFlQwc6AfHFUsKqc6ydr5nhXZPbe
	OwDOoCEr4TAy3XGTguDWYQ3nBMlNfa7gusZe+2A15++5jSPWtr0jO1C2ccAlXfcq3DowA2D06s+
	Emkw8w5IS5tGKfZLxUIsJLmuVI5rgldj1NdnrLhrqQW1LYzY9EpV4bZsmC5iEFHRpI8jFWcg36j
	X1zl7iEbaYY4s8gPTueSOub93fX2hdgeEtAfm8ZNtPySYJzhM=
X-Received: by 2002:a17:902:f60b:b0:2a7:c8db:488a with SMTP id d9443c01a7336-2a95161f2b8mr29104455ad.7.1770383435681;
        Fri, 06 Feb 2026 05:10:35 -0800 (PST)
Received: from Shreyansh-PC.domain.name ([2401:4900:1cd6:312c:2479:7de1:4f9f:e55e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a951a638a1sm24268105ad.17.2026.02.06.05.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 05:10:35 -0800 (PST)
From: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	karthik.188@gmail.com,
	phillip.wood123@gmail.com,
	Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
Subject: Re: [PATCH V2 2/3] wt-status: pass struct repository and wt_status through function parameters
Date: Fri,  6 Feb 2026 18:27:54 +0530
Message-ID: <20260206131017.1199921-1-shreyanshpaliwalcmsmn@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260206093257.1178858-1-shreyanshpaliwalcmsmn@gmail.com>
References: <20260206093257.1178858-1-shreyanshpaliwalcmsmn@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I tried this out below, and it showed no fails in tests.
After this we can just directly replace all the_repository with 'r' or 's->repo'
without the hassle of checking the worktree is defined or not.
Let me know what you think.
Thanks.

Signed-off-by: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
---
 branch.c    |  4 ++--
 worktree.c  |  4 ++--
 wt-status.c | 48 +++++++++++++++++++++++++-----------------------
 wt-status.h |  6 ++++--
 4 files changed, 33 insertions(+), 29 deletions(-)

diff --git a/branch.c b/branch.c
index 243db7d0fc..0a0097dd85 100644
--- a/branch.c
+++ b/branch.c
@@ -412,7 +412,7 @@ static void prepare_checked_out_branches(void)
 			free(old);
 		}
 
-		if (wt_status_check_rebase(wt, &state) &&
+		if (wt_status_check_rebase(the_repository, wt, &state) &&
 		    (state.rebase_in_progress || state.rebase_interactive_in_progress) &&
 		    state.branch) {
 			struct strbuf ref = STRBUF_INIT;
@@ -425,7 +425,7 @@ static void prepare_checked_out_branches(void)
 		}
 		wt_status_state_free_buffers(&state);
 
-		if (wt_status_check_bisect(wt, &state) &&
+		if (wt_status_check_bisect(the_repository, wt, &state) &&
 		    state.bisecting_from) {
 			struct strbuf ref = STRBUF_INIT;
 			strbuf_addf(&ref, "refs/heads/%s", state.bisecting_from);
diff --git a/worktree.c b/worktree.c
index 9308389cb6..86eff384ae 100644
--- a/worktree.c
+++ b/worktree.c
@@ -443,7 +443,7 @@ int is_worktree_being_rebased(const struct worktree *wt,
 	int found_rebase;
 
 	memset(&state, 0, sizeof(state));
-	found_rebase = wt_status_check_rebase(wt, &state) &&
+	found_rebase = wt_status_check_rebase(the_repository, wt, &state) &&
 		       (state.rebase_in_progress ||
 			state.rebase_interactive_in_progress) &&
 		       state.branch &&
@@ -460,7 +460,7 @@ int is_worktree_being_bisected(const struct worktree *wt,
 	int found_bisect;
 
 	memset(&state, 0, sizeof(state));
-	found_bisect = wt_status_check_bisect(wt, &state) &&
+	found_bisect = wt_status_check_bisect(the_repository, wt, &state) &&
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

