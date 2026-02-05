Received: from mail-pj1-f65.google.com (mail-pj1-f65.google.com [209.85.216.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC74D20DD75
	for <git@vger.kernel.org>; Thu,  5 Feb 2026 10:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770286552; cv=none; b=XyxooHjcqSqPb7tmQbV9Qb4qb5+NtproCyXf6pAXnGDk7c8Op25EADUbGLI1rdL5HINalwGfcodt5azx8alv7iBiXKq5pv+HnoMtRutZR38R5At9ei+5mRR17bZcFVLDA699C8RYp4DlEtbIihE9zp33kuy5SvWppoXp/cb7UYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770286552; c=relaxed/simple;
	bh=oELSP5s0GwJKR+oWPW3pKUJn0wfNlQH9qZjrpvvVViw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BKFuLrtQ4kcm9LbCQE6/jBRE8AGq1kKbeSTVdrvnuuf8TMKpRy4a+5mPhjiqxY5VWzLL7JE6H+v2IhsEiXyiv4xeFdLD+Wdsq2onzdRnjSwtRX9ktnba7EcLH8ITfZAZKtC0Pv9Kr28KESEq1LPteDwiUQnuv0IrSnu57ZXOOHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WMnq6H+/; arc=none smtp.client-ip=209.85.216.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WMnq6H+/"
Received: by mail-pj1-f65.google.com with SMTP id 98e67ed59e1d1-34c2f335681so374613a91.1
        for <git@vger.kernel.org>; Thu, 05 Feb 2026 02:15:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770286552; x=1770891352; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8b0EgegcMRpN8GrO41r1fOal9fpoeDtpbduAAB7DlW0=;
        b=WMnq6H+/gWxatGlIsCO/9vsG5uOQ2UkxEjIzZzEgWRfYowFhFA5apK0O2c16v3kiNv
         Zs2SYUZN0mfpeNn+JTQ9i/bGA+EmMCjqZXHvqEwO2uUrbpyoHdd5haFJb6Uxga0uOHI+
         rZzAdRIa/LJTpZ5LKpkW9qLlr9EWvQiyjthPkwnjT2uVlAgQr+mq9gyi+1ds6Ra56IBW
         hCRAjif1XPRf9+YyxgpSmuwYzOHXZpHm2QtI6QU0SzBBX9FLqYhUpW30CzYQzAsO0IMG
         1m7BSYvUSNVzMDT3uOlagpcQ/T6lDIWp/sf8+FilWcclnAyRYHU6J2Jivd9ilF+3uJ9e
         45yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770286552; x=1770891352;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8b0EgegcMRpN8GrO41r1fOal9fpoeDtpbduAAB7DlW0=;
        b=ZiIQI7xC6TqMXcMTANVoUOwGVvxe9e9IU+wdibBje/K41glrYgKei8Uz9GUUyq7CvX
         +ar2pcaki12LALeSL3FyTCgo1yUe/QRhKgAwPLu4kG+y6SJy6XDJQ+DDgQAj1WUNL/cS
         VKup1YpVunyVnk7GTl0D+dPLxNhP+9y2Dh3SUeVdm2rgVORCbSpzx8HSggW86e1kSKat
         HgcR88JyT1JiTyVhYAMXeMjXFBBuHNtnPDiEx4INBJEc+WteHm7J6qmWhHHXvVuqIw+T
         uckt72h9MahuZZ6P676UtBz9p5Gc9Ned6JBPPIvqVcVNHnhc1S4sPlCZ201WGXhht/je
         NFvw==
X-Gm-Message-State: AOJu0Yyk/ECbSpFW9H0fOHZFB8AnmxWRgOb3kOVmKYy1flOnXwo7yhj8
	z+v0AFspfk7983UoS/30aBW/I9AE5O4ZmA5V6PepqtY8eBwBve/1++aqOCa0Y2qS
X-Gm-Gg: AZuq6aKTzda2nvKZpPEwLjGgsuxqhp5HGy51CmWpqKCY8IZ6crwfBebbQLxJSlsFiL2
	TX/jR6LZ+b3xYQm5ToGkqyYOUzgRfZbjY0z6imyZjcUXQoyp+vb+JrLC332270ThGXpAzDkglj/
	E4XRWl3CGDOrgms7tysDKOPnCq8FpAaCArM9qWOQTBjsLhNpnDrAvzHx062DCkL2zXuK395aMhd
	MWlJUu8FMA1aHs80AYsWct/NlmpkghDad7dPjDYx23WUlBS0u+M2M0YXcpGRxW7aNyeQSmZ6WtS
	k11vuY81lFWyEe3LPlxXs8OqjNm5wHKbDmlj/Ne4jxhtof7Wj4Rk0Wu13uOMGrWW8rM1s65Zqac
	6VmcfXq+Ft57vWI3jdAPRe/Yro87G+GZnocyfvgMbXMblxVC2C4fy1htQucAOHJ6OnO3OH5EgWZ
	ZieA37sn6ZNkzRbJkfjXvtWUh9dCDuKAtxL92Oybt3HIUJfg==
X-Received: by 2002:a17:90b:2243:b0:354:7c90:8a0 with SMTP id 98e67ed59e1d1-354871bd573mr5743125a91.24.1770286551910;
        Thu, 05 Feb 2026 02:15:51 -0800 (PST)
Received: from Shreyansh-PC.domain.name ([2401:4900:1cd6:312c:1078:b5ff:8b66:3ef8])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3549c09ff2fsm2071223a91.2.2026.02.05.02.15.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 02:15:51 -0800 (PST)
From: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	karthik.188@gmail.com,
	phillip.wood123@gmail.com,
	Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
Subject: [PATCH V2 2/3] wt-status: pass struct repository and wt_status through function parameters
Date: Thu,  5 Feb 2026 15:43:12 +0530
Message-ID: <20260205101524.125452-3-shreyanshpaliwalcmsmn@gmail.com>
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

Some functions in wt-status.c relied on the_repository because no
repository instance was available in their local scope.
There is also a specific case in wt_status_check_rebase() where the
worktree can be NULL, so accessing wt->repo may lead to a segfault.

Update these functions to accept a struct repository or struct
wt_status parameter, and adjust callers accordingly. Replace the
remaining uses of the_repository in these functions with the
passed-in repository instance.

This removes the use of the_repository global variable from
wt-status.c completely.

Signed-off-by: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
---
 branch.c    |  2 +-
 worktree.c  |  2 +-
 wt-status.c | 51 ++++++++++++++++++++++++++-------------------------
 wt-status.h |  5 +++--
 4 files changed, 31 insertions(+), 29 deletions(-)

diff --git a/branch.c b/branch.c
index 243db7d0fc..9fe2df8cef 100644
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
diff --git a/worktree.c b/worktree.c
index 9308389cb6..d05531813c 100644
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
diff --git a/wt-status.c b/wt-status.c
index f71addc35f..b008682043 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -984,17 +984,17 @@ static int stash_count_refs(const char *refname UNUSED,
 	return 0;
 }
 
-static int count_stash_entries(void)
+static int count_stash_entries(struct repository *r)
 {
 	int n = 0;
-	refs_for_each_reflog_ent(get_main_ref_store(the_repository),
+	refs_for_each_reflog_ent(get_main_ref_store(r),
 				 "refs/stash", stash_count_refs, &n);
 	return n;
 }
 
 static void wt_longstatus_print_stash_summary(struct wt_status *s)
 {
-	int stash_count = count_stash_entries();
+	int stash_count = count_stash_entries(s->repo);
 
 	if (stash_count > 0)
 		status_printf_ln(s, GIT_COLOR_NORMAL,
@@ -1287,10 +1287,10 @@ static void show_am_in_progress(struct wt_status *s,
 	wt_longstatus_print_trailer(s);
 }
 
-static char *read_line_from_git_path(const char *filename)
+static char *read_line_from_git_path(struct repository *r, const char *filename)
 {
 	struct strbuf buf = STRBUF_INIT;
-	FILE *fp = fopen_or_warn(repo_git_path_append(the_repository, &buf,
+	FILE *fp = fopen_or_warn(repo_git_path_append(r, &buf,
 						      "%s", filename), "r");
 
 	if (!fp) {
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
@@ -1362,7 +1362,7 @@ static void abbrev_oid_in_line(struct strbuf *line)
 		return;
 
 	if ((2 <= string_list_split(&split, line->buf, " ", 2)) &&
-	    !repo_get_oid(the_repository, split.items[1].string, &oid)) {
+	    !repo_get_oid(r, split.items[1].string, &oid)) {
 		strbuf_reset(line);
 		strbuf_addf(line, "%s ", split.items[0].string);
 		strbuf_add_unique_abbrev(line, &oid, DEFAULT_ABBREV);
@@ -1372,10 +1372,10 @@ static void abbrev_oid_in_line(struct strbuf *line)
 	string_list_clear(&split, 0);
 }
 
-static int read_rebase_todolist(const char *fname, struct string_list *lines)
+static int read_rebase_todolist(struct repository *r, const char *fname, struct string_list *lines)
 {
 	struct strbuf buf = STRBUF_INIT;
-	FILE *f = fopen(repo_git_path_append(the_repository, &buf, "%s", fname), "r");
+	FILE *f = fopen(repo_git_path_append(r, &buf, "%s", fname), "r");
 	int ret;
 
 	if (!f) {
@@ -1384,7 +1384,7 @@ static int read_rebase_todolist(const char *fname, struct string_list *lines)
 			goto out;
 		}
 		die_errno("Could not open file %s for reading",
-			  repo_git_path_replace(the_repository, &buf, "%s", fname));
+			  repo_git_path_replace(r, &buf, "%s", fname));
 	}
 	while (!strbuf_getline_lf(&buf, f)) {
 		if (starts_with(buf.buf, comment_line_str))
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
@@ -1718,23 +1718,24 @@ static void wt_status_get_detached_from(struct repository *r,
 	strbuf_release(&cb.buf);
 }
 
-int wt_status_check_rebase(const struct worktree *wt,
-			   struct wt_status_state *state)
+int wt_status_check_rebase(struct repository *r,
+			 const struct worktree *wt,
+			 struct wt_status_state *state)
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
 			state->branch = get_branch(wt, "rebase-apply/head-name");
 			state->onto = get_branch(wt, "rebase-apply/onto");
 		}
-	} else if (!stat(worktree_git_path(the_repository, wt, "rebase-merge"), &st)) {
-		if (!stat(worktree_git_path(the_repository, wt, "rebase-merge/interactive"), &st))
+	} else if (!stat(worktree_git_path(r, wt, "rebase-merge"), &st)) {
+		if (!stat(worktree_git_path(r, wt, "rebase-merge/interactive"), &st))
 			state->rebase_interactive_in_progress = 1;
 		else
 			state->rebase_in_progress = 1;
@@ -1797,9 +1798,9 @@ void wt_status_get_state(struct repository *r,
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
@@ -2259,7 +2260,7 @@ static void wt_porcelain_v2_print_tracking(struct wt_status *s)
  */
 static void wt_porcelain_v2_print_stash(struct wt_status *s)
 {
-	int stash_count = count_stash_entries();
+	int stash_count = count_stash_entries(s->repo);
 	char eol = s->null_termination ? '\0' : '\n';
 
 	if (stash_count > 0)
diff --git a/wt-status.h b/wt-status.h
index e40a27214a..110e3907f8 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -164,8 +164,9 @@ void wt_status_state_free_buffers(struct wt_status_state *s);
 void wt_status_get_state(struct repository *repo,
 			 struct wt_status_state *state,
 			 int get_detached_from);
-int wt_status_check_rebase(const struct worktree *wt,
-			   struct wt_status_state *state);
+int wt_status_check_rebase(struct repository *r,
+			 const struct worktree *wt,
+			 struct wt_status_state *state);
 int wt_status_check_bisect(const struct worktree *wt,
 			   struct wt_status_state *state);
 
-- 
2.52.0
