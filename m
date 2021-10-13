Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5657C433F5
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 19:31:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB1A2611CA
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 19:31:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237644AbhJMTdo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Oct 2021 15:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234531AbhJMTdm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Oct 2021 15:33:42 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE827C061760
        for <git@vger.kernel.org>; Wed, 13 Oct 2021 12:31:38 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id e6-20020a637446000000b002993ba24bbaso2035152pgn.12
        for <git@vger.kernel.org>; Wed, 13 Oct 2021 12:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=hJ7XGOItW0YvxIxckAA1mNWSbcVvgLV14g/GLHLWu3k=;
        b=P0OxkS7gdhpsc5Lwpdt4sCqKBmY0PJ6D4tZcuzgOENg/7n7jcU+mCWpXyk5ikgr72m
         8gtkRI/S5ozt2Kwqv73Q2e/JJW4T+un5+ozJy827OyyAqawaJ59dHeqBIz28Fbk9XNne
         PTqrOQa91J5/Ck9/Ik2y1ZKKdGtwMAIArignG1BMxTxJSfhE7PDCup/aMjtwCUFCZxFU
         J1cwLIj8QfpbYhhbBx2evEreaJfIFP/a4xOQynZZb2wqQWsE7wwPX6jEBquu5wW2DfW+
         JQXCmITSHwDCjPDJtxcurAJb3nacwygxADzta9h34q0On2YnhZ52q5EXgWofcVmnSMcI
         waUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=hJ7XGOItW0YvxIxckAA1mNWSbcVvgLV14g/GLHLWu3k=;
        b=2bhEnSVKUDBe2eT5uE2eNvdH+rvdaukXKh+IkoCS5oXZalIeqWXZL4YP0qIBQtWpXV
         oLVTXAiLI3A6ANPQrEoGD+yIhlsNQpJ+3mo6uXKZ3WC4en+gY8mSIYOSHlSX3NFjaDCs
         yCPQZDFyCKvbipqejk+OxOP/dZ05c+q7NBW/jR0Q/NZE4UEKmo2KNNrirP9m3vgyzeYU
         DdDPLRF0i3hsx0q8Kw8ItIa14PqQDmvbi2QDEFn/1pKu7wk8Uy+6qUo+Edl/E5BH+4e4
         YJEQmMhrBCIJAofM+86azZn9b6ny4TW8fHb89HAOyP3WQ4sJz9mWYUflOcvOGXhfT3nt
         pWdQ==
X-Gm-Message-State: AOAM5317sBr+lmT7UT+5fUE21Wl8N8qRX0/dlrTZD0NoHkBbB/JIAivd
        rDZJZAwzcSZG0Azq3qW9RNv8pUq0lNLUqr9ZEV3BPnZ0L+QD57L/s4uM4fpDkx7W1cI5N0DyVaY
        BES0bpf2XBw+zqCGoRR9k/krg5IWfUSQgP0bGm1v1ve2J96/8UqMYOcEgy5x8ofE=
X-Google-Smtp-Source: ABdhPJyE5h1J7iylHNiOkrken5D8HbsVeXrMlncHk7+6snFDkaBCbckk3uadXdQbcs44Gx9+sDuDIHevNBs/iw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90a:5895:: with SMTP id
 j21mr15630814pji.99.1634153498213; Wed, 13 Oct 2021 12:31:38 -0700 (PDT)
Date:   Wed, 13 Oct 2021 12:31:27 -0700
In-Reply-To: <20211013193127.76537-1-chooglen@google.com>
Message-Id: <20211013193127.76537-4-chooglen@google.com>
Mime-Version: 1.0
References: <pull.1103.git.git.1633633635.gitgitgadget@gmail.com> <20211013193127.76537-1-chooglen@google.com>
X-Mailer: git-send-email 2.33.0.882.g93a45727a2-goog
Subject: [PATCH v2 3/3] remote: add struct repository parameter to external functions
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Glen Choo <chooglen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Finish plumbing remote_state by adding a struct repository
parameter to repo_* functions. While this removes all references to
the_repository->remote_state, certain functions still use the_repository
to parse oids.

Signed-off-by: Glen Choo <chooglen@google.com>
---
 remote.c | 111 ++++++++++++++++++++++++++++++-------------------------
 remote.h |  96 +++++++++++++++++++++++++++++++++++++++--------
 2 files changed, 142 insertions(+), 65 deletions(-)

diff --git a/remote.c b/remote.c
index 850ccd8eff..be0889c53b 100644
--- a/remote.c
+++ b/remote.c
@@ -495,7 +495,8 @@ static int valid_remote_nick(const char *name)
 	return 1;
 }
 
-const char *remote_for_branch(struct branch *branch, int *explicit)
+const char *repo_remote_for_branch(struct repository *repo,
+				   struct branch *branch, int *explicit)
 {
 	if (branch && branch->remote_name) {
 		if (explicit)
@@ -507,22 +508,24 @@ const char *remote_for_branch(struct branch *branch, int *explicit)
 	return "origin";
 }
 
-const char *pushremote_for_branch(struct branch *branch, int *explicit)
+const char *repo_pushremote_for_branch(struct repository *repo,
+				       struct branch *branch, int *explicit)
 {
 	if (branch && branch->pushremote_name) {
 		if (explicit)
 			*explicit = 1;
 		return branch->pushremote_name;
 	}
-	if (the_repository->remote_state->pushremote_name) {
+	if (repo->remote_state->pushremote_name) {
 		if (explicit)
 			*explicit = 1;
-		return the_repository->remote_state->pushremote_name;
+		return repo->remote_state->pushremote_name;
 	}
-	return remote_for_branch(branch, explicit);
+	return repo_remote_for_branch(repo, branch, explicit);
 }
 
-const char *remote_ref_for_branch(struct branch *branch, int for_push)
+const char *repo_remote_ref_for_branch(struct repository *repo,
+				       struct branch *branch, int for_push)
 {
 	if (branch) {
 		if (!for_push) {
@@ -530,9 +533,11 @@ const char *remote_ref_for_branch(struct branch *branch, int for_push)
 				return branch->merge_name[0];
 			}
 		} else {
-			const char *dst, *remote_name =
-				pushremote_for_branch(branch, NULL);
-			struct remote *remote = remote_get(remote_name);
+			const char *dst,
+				*remote_name = repo_pushremote_for_branch(
+					repo, branch, NULL);
+			struct remote *remote =
+				repo_remote_get(repo, remote_name);
 
 			if (remote && remote->push.nr &&
 			    (dst = apply_refspecs(&remote->push,
@@ -544,42 +549,43 @@ const char *remote_ref_for_branch(struct branch *branch, int for_push)
 	return NULL;
 }
 
-static struct remote *remote_get_1(const char *name,
-				   const char *(*get_default)(struct branch *, int *))
+static struct remote *repo_remote_get_1(
+	struct repository *repo, const char *name,
+	const char *(*get_default)(struct repository *, struct branch *, int *))
 {
 	struct remote *ret;
 	int name_given = 0;
 
-	read_config(the_repository->remote_state);
+	read_config(repo->remote_state);
 
 	if (name)
 		name_given = 1;
 	else
-		name = get_default(the_repository->remote_state->current_branch,
+		name = get_default(repo, repo->remote_state->current_branch,
 				   &name_given);
 
-	ret = make_remote(the_repository->remote_state, name, 0);
+	ret = make_remote(repo->remote_state, name, 0);
 	if (valid_remote_nick(name) && have_git_dir()) {
 		if (!valid_remote(ret))
-			read_remotes_file(the_repository->remote_state, ret);
+			read_remotes_file(repo->remote_state, ret);
 		if (!valid_remote(ret))
-			read_branches_file(the_repository->remote_state, ret);
+			read_branches_file(repo->remote_state, ret);
 	}
 	if (name_given && !valid_remote(ret))
-		add_url_alias(the_repository->remote_state, ret, name);
+		add_url_alias(repo->remote_state, ret, name);
 	if (!valid_remote(ret))
 		return NULL;
 	return ret;
 }
 
-struct remote *remote_get(const char *name)
+struct remote *repo_remote_get(struct repository *repo, const char *name)
 {
-	return remote_get_1(name, remote_for_branch);
+	return repo_remote_get_1(repo, name, repo_remote_for_branch);
 }
 
-struct remote *pushremote_get(const char *name)
+struct remote *repo_pushremote_get(struct repository *repo, const char *name)
 {
-	return remote_get_1(name, pushremote_for_branch);
+	return repo_remote_get_1(repo, name, repo_pushremote_for_branch);
 }
 
 int remote_is_configured(struct remote *remote, int in_repo)
@@ -591,14 +597,12 @@ int remote_is_configured(struct remote *remote, int in_repo)
 	return !!remote->origin;
 }
 
-int for_each_remote(each_remote_fn fn, void *priv)
+int repo_for_each_remote(struct repository *repo, each_remote_fn fn, void *priv)
 {
 	int i, result = 0;
-	read_config(the_repository->remote_state);
-	for (i = 0; i < the_repository->remote_state->remotes_nr && !result;
-	     i++) {
-		struct remote *remote =
-			the_repository->remote_state->remotes[i];
+	read_config(repo->remote_state);
+	for (i = 0; i < repo->remote_state->remotes_nr && !result; i++) {
+		struct remote *remote = repo->remote_state->remotes[i];
 		if (!remote)
 			continue;
 		result = fn(remote, priv);
@@ -1666,7 +1670,7 @@ void set_ref_status_for_push(struct ref *remote_refs, int send_mirror,
 	}
 }
 
-static void set_merge(struct branch *ret)
+static void set_merge(struct repository *repository, struct branch *ret)
 {
 	struct remote *remote;
 	char *ref;
@@ -1686,7 +1690,7 @@ static void set_merge(struct branch *ret)
 		return;
 	}
 
-	remote = remote_get(ret->remote_name);
+	remote = repo_remote_get(repository, ret->remote_name);
 
 	CALLOC_ARRAY(ret->merge, ret->merge_nr);
 	for (i = 0; i < ret->merge_nr; i++) {
@@ -1703,17 +1707,16 @@ static void set_merge(struct branch *ret)
 	}
 }
 
-struct branch *branch_get(const char *name)
+struct branch *repo_branch_get(struct repository *repo, const char *name)
 {
 	struct branch *ret;
 
-	read_config(the_repository->remote_state);
+	read_config(repo->remote_state);
 	if (!name || !*name || !strcmp(name, "HEAD"))
-		ret = the_repository->remote_state->current_branch;
+		ret = repo->remote_state->current_branch;
 	else
-		ret = make_branch(the_repository->remote_state, name,
-				  strlen(name));
-	set_merge(ret);
+		ret = make_branch(repo->remote_state, name, strlen(name));
+	set_merge(repo, ret);
 	return ret;
 }
 
@@ -1743,7 +1746,8 @@ static const char *error_buf(struct strbuf *err, const char *fmt, ...)
 	return NULL;
 }
 
-const char *branch_get_upstream(struct branch *branch, struct strbuf *err)
+const char *repo_branch_get_upstream(struct repository *repo,
+				     struct branch *branch, struct strbuf *err)
 {
 	if (!branch)
 		return error_buf(err, _("HEAD does not point to a branch"));
@@ -1784,11 +1788,14 @@ static const char *tracking_for_push_dest(struct remote *remote,
 	return ret;
 }
 
-static const char *branch_get_push_1(struct branch *branch, struct strbuf *err)
+static const char *repo_branch_get_push_1(struct repository *repo,
+					  struct branch *branch,
+					  struct strbuf *err)
 {
 	struct remote *remote;
 
-	remote = remote_get(pushremote_for_branch(branch, NULL));
+	remote = repo_remote_get(repo, repo_pushremote_for_branch(repo, branch,
+								  NULL));
 	if (!remote)
 		return error_buf(err,
 				 _("branch '%s' has no remote for pushing"),
@@ -1821,14 +1828,14 @@ static const char *branch_get_push_1(struct branch *branch, struct strbuf *err)
 		return tracking_for_push_dest(remote, branch->refname, err);
 
 	case PUSH_DEFAULT_UPSTREAM:
-		return branch_get_upstream(branch, err);
+		return repo_branch_get_upstream(repo, branch, err);
 
 	case PUSH_DEFAULT_UNSPECIFIED:
 	case PUSH_DEFAULT_SIMPLE:
 		{
 			const char *up, *cur;
 
-			up = branch_get_upstream(branch, err);
+			up = repo_branch_get_upstream(repo, branch, err);
 			if (!up)
 				return NULL;
 			cur = tracking_for_push_dest(remote, branch->refname, err);
@@ -1844,13 +1851,15 @@ static const char *branch_get_push_1(struct branch *branch, struct strbuf *err)
 	BUG("unhandled push situation");
 }
 
-const char *branch_get_push(struct branch *branch, struct strbuf *err)
+const char *repo_branch_get_push(struct repository *repo, struct branch *branch,
+				 struct strbuf *err)
 {
 	if (!branch)
 		return error_buf(err, _("HEAD does not point to a branch"));
 
 	if (!branch->push_tracking_ref)
-		branch->push_tracking_ref = branch_get_push_1(branch, err);
+		branch->push_tracking_ref =
+			repo_branch_get_push_1(repo, branch, err);
 	return branch->push_tracking_ref;
 }
 
@@ -2103,15 +2112,16 @@ static int stat_branch_pair(const char *branch_name, const char *base,
  * upstream defined, or ref does not exist).  Returns 0 if the commits are
  * identical.  Returns 1 if commits are different.
  */
-int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs,
-		       const char **tracking_name, int for_push,
-		       enum ahead_behind_flags abf)
+int repo_stat_tracking_info(struct repository *repo, struct branch *branch,
+			    int *num_ours, int *num_theirs,
+			    const char **tracking_name, int for_push,
+			    enum ahead_behind_flags abf)
 {
 	const char *base;
 
 	/* Cannot stat unless we are marked to build on top of somebody else. */
-	base = for_push ? branch_get_push(branch, NULL) :
-		branch_get_upstream(branch, NULL);
+	base = for_push ? repo_branch_get_push(repo, branch, NULL) :
+				repo_branch_get_upstream(repo, branch, NULL);
 	if (tracking_name)
 		*tracking_name = base;
 	if (!base)
@@ -2123,15 +2133,16 @@ int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs,
 /*
  * Return true when there is anything to report, otherwise false.
  */
-int format_tracking_info(struct branch *branch, struct strbuf *sb,
-			 enum ahead_behind_flags abf)
+int repo_format_tracking_info(struct repository *repo, struct branch *branch,
+			      struct strbuf *sb, enum ahead_behind_flags abf)
 {
 	int ours, theirs, sti;
 	const char *full_base;
 	char *base;
 	int upstream_is_gone = 0;
 
-	sti = stat_tracking_info(branch, &ours, &theirs, &full_base, 0, abf);
+	sti = repo_stat_tracking_info(repo, branch, &ours, &theirs, &full_base,
+				      0, abf);
 	if (sti < 0) {
 		if (!full_base)
 			return 0;
diff --git a/remote.h b/remote.h
index 184d14af3d..a1cf86f973 100644
--- a/remote.h
+++ b/remote.h
@@ -117,15 +117,28 @@ struct remote {
  * remote_get(NULL) will return the default remote, given the current branch
  * and configuration.
  */
-struct remote *remote_get(const char *name);
-
-struct remote *pushremote_get(const char *name);
+struct remote *repo_remote_get(struct repository *repo, const char *name);
+static inline struct remote *remote_get(const char *name)
+{
+	return repo_remote_get(the_repository, name);
+}
+
+struct remote *repo_pushremote_get(struct repository *repo, const char *name);
+static inline struct remote *pushremote_get(const char *name)
+{
+	return repo_pushremote_get(the_repository, name);
+}
 int remote_is_configured(struct remote *remote, int in_repo);
 
 typedef int each_remote_fn(struct remote *remote, void *priv);
 
 /* iterate through struct remotes */
-int for_each_remote(each_remote_fn fn, void *priv);
+int repo_for_each_remote(struct repository *repo, each_remote_fn fn,
+			 void *priv);
+static inline int for_each_remote(each_remote_fn fn, void *priv)
+{
+	return repo_for_each_remote(the_repository, fn, priv);
+}
 
 int remote_has_url(struct remote *remote, const char *url);
 
@@ -320,10 +333,35 @@ struct branch {
 	const char *push_tracking_ref;
 };
 
-struct branch *branch_get(const char *name);
-const char *remote_for_branch(struct branch *branch, int *explicit);
-const char *pushremote_for_branch(struct branch *branch, int *explicit);
-const char *remote_ref_for_branch(struct branch *branch, int for_push);
+struct branch *repo_branch_get(struct repository *repo, const char *name);
+static inline struct branch *branch_get(const char *name)
+{
+	return repo_branch_get(the_repository, name);
+}
+
+const char *repo_remote_for_branch(struct repository *repo,
+				   struct branch *branch, int *explicit);
+static inline const char *remote_for_branch(struct branch *branch,
+					    int *explicit)
+{
+	return repo_remote_for_branch(the_repository, branch, explicit);
+}
+
+const char *repo_pushremote_for_branch(struct repository *repo,
+				       struct branch *branch, int *explicit);
+static inline const char *pushremote_for_branch(struct branch *branch,
+						int *explicit)
+{
+	return repo_pushremote_for_branch(the_repository, branch, explicit);
+}
+
+const char *repo_remote_ref_for_branch(struct repository *repo,
+				       struct branch *branch, int for_push);
+static inline const char *remote_ref_for_branch(struct branch *branch,
+						int for_push)
+{
+	return repo_remote_ref_for_branch(the_repository, branch, for_push);
+}
 
 /* returns true if the given branch has merge configuration given. */
 int branch_has_merge_config(struct branch *branch);
@@ -339,7 +377,13 @@ int branch_merge_matches(struct branch *, int n, const char *);
  * message is recorded there (if the function does not return NULL, then
  * `err` is not touched).
  */
-const char *branch_get_upstream(struct branch *branch, struct strbuf *err);
+const char *repo_branch_get_upstream(struct repository *repo,
+				     struct branch *branch, struct strbuf *err);
+static inline const char *branch_get_upstream(struct branch *branch,
+					      struct strbuf *err)
+{
+	return repo_branch_get_upstream(the_repository, branch, err);
+}
 
 /**
  * Return the tracking branch that corresponds to the ref we would push to
@@ -347,7 +391,13 @@ const char *branch_get_upstream(struct branch *branch, struct strbuf *err);
  *
  * The return value and `err` conventions match those of `branch_get_upstream`.
  */
-const char *branch_get_push(struct branch *branch, struct strbuf *err);
+const char *repo_branch_get_push(struct repository *repo, struct branch *branch,
+				 struct strbuf *err);
+static inline const char *branch_get_push(struct branch *branch,
+					  struct strbuf *err)
+{
+	return repo_branch_get_push(the_repository, branch, err);
+}
 
 /* Flags to match_refs. */
 enum match_refs_flags {
@@ -366,11 +416,27 @@ enum ahead_behind_flags {
 };
 
 /* Reporting of tracking info */
-int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs,
-		       const char **upstream_name, int for_push,
-		       enum ahead_behind_flags abf);
-int format_tracking_info(struct branch *branch, struct strbuf *sb,
-			 enum ahead_behind_flags abf);
+int repo_stat_tracking_info(struct repository *repo, struct branch *branch,
+			    int *num_ours, int *num_theirs,
+			    const char **upstream_name, int for_push,
+			    enum ahead_behind_flags abf);
+static inline int stat_tracking_info(struct branch *branch, int *num_ours,
+				     int *num_theirs,
+				     const char **upstream_name, int for_push,
+				     enum ahead_behind_flags abf)
+{
+	return repo_stat_tracking_info(the_repository, branch, num_ours,
+				       num_theirs, upstream_name, for_push,
+				       abf);
+}
+
+int repo_format_tracking_info(struct repository *repo, struct branch *branch,
+			      struct strbuf *sb, enum ahead_behind_flags abf);
+static inline int format_tracking_info(struct branch *branch, struct strbuf *sb,
+				       enum ahead_behind_flags abf)
+{
+	return repo_format_tracking_info(the_repository, branch, sb, abf);
+}
 
 struct ref *get_local_heads(void);
 /*
-- 
2.33.0.882.g93a45727a2-goog

