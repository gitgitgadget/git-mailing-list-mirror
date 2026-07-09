Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE1D3EDE6A
	for <git@vger.kernel.org>; Thu,  9 Jul 2026 08:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783585787; cv=none; b=I+RNq7Wd1X/08r5VU7AXL6WEU9Pr3QnrpSaEhODsmJYh0HLKrdKxSoMSl3xsfntMAv933LF5ZEYsNrFQIC0ES1vkLG+LzR6BlzH+WbhfI4d0XcCKUoGsjVaO8sRMuPiLueDxhkV3RELLcDqc4uaZrCSo6JF3eKa3oHeIF20GB8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783585787; c=relaxed/simple;
	bh=120qwO0NFrizt1bpZCQUzEbZXatOt1vt6fd8flzWTbQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b/vBRACVcXsSz2y4qVdkvgfcuMZ631kqL2+8Abhz1BCYFnsbQ2O9uL+9AETKjhsp2VwTRgY/I7J+yGYXpS7fuRkIwYflCEKK69VcWsyzmkHO0ayYE8dJQ/Pjz8746dFgYJXhj9HtiqNJVlGLZ2NLCTb8iCS00g6jWov9fZfJCwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=CF7RClKu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HxWbOOXx; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="CF7RClKu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HxWbOOXx"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7B89A7A0018
	for <git@vger.kernel.org>; Thu,  9 Jul 2026 04:29:45 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 09 Jul 2026 04:29:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1783585785;
	 x=1783672185; bh=zY1/MUOnbec7Ad9Ox8OifCfrYEaF92hYk8UhtlAJsBk=; b=
	CF7RClKuzlmgwHSyy9MfKA37giz+rbqGBqTK5FM3a8OD5D+8ldjsLLm7pSTb49N/
	O93hSfT7CH5MMDGu6f8Lkb/T0z5Gjh8TNqOkmkk/sBD14BPF29rOPUc8A79yFXba
	de+QJ5Uuo00GA+bAy3GO9N/qVGlJVvtAGKvlH6U+2/ag2F3l5ktgoal1WKrANWnj
	knB5FRUj6xiXIHzWuUBbiINNzMG+Q7Gd1FtlCaMpZYAAnxFQsLiMIhYnszVplKMM
	OM8NDRqWbNzTVE8TNMSmQUXB+l333n8u/2Rov9VpMYIuxAgsqn2D+14I8dIWM++p
	hE4bLV+8CbUtFNVGRvfYQg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783585785; x=
	1783672185; bh=zY1/MUOnbec7Ad9Ox8OifCfrYEaF92hYk8UhtlAJsBk=; b=H
	xWbOOXxAAEz/EmfH7jYDGRxV7EYmAGq4RyouZ/tiC8fBty/0SBQF3lhejHaMnJ/2
	9hpaICWqD5qncjG046Ul3v+kKTLfRCnuVuLfp2hEh43YAk+eEgrcz4N28CoeIzR/
	mxLwzuUTx7vQhGWOhxORCJQp+vasEG5KEDsu3n6y5+a2P42Es74qysBIkL3DJLc3
	FYBmX2flwldUJTgnzd6/R1gJqqy5kedLQr4YCrdTAwztRB69ZtbbyPXgqM0pcTUs
	CFTk6AaYqc1ZtrtNMW0eDPJ28J1CoqIweOmgW/12n8EdRamQdpWDYrg0dzLQYzjZ
	UxrQ2FUl6lrc46wOrG25Q==
X-ME-Sender: <xms:-VtPakUeOu87GQhTyj1xqjzozKFQMJgwGqow0TPRtgtviojTf4ATKw>
    <xme:-VtPavj1LHfzKfaFH--_WQ7bQ0w54ydgdfsQu31LEtZxrtqHsGrHfyaZZu--77FVx
    wvbN3QbxX8e1WlAPfmeRlpW-lSCpWgGADl1Y2bcRZejmnVBxSSBmzw>
X-ME-Received: <xmr:-VtPauD1429xLxw-qoRnnCVOtGLRbXRj_NZy3DkzQL2KZz7UK5PPtkTipaDo9jdm8pFHGQijzQ8Gqe7ILyuXmjZ0BJ1uRi6MLRqxD8RkqQ>
X-ME-Proxy-Cause: dmFkZTGVX3wGpxpiSCWJAJLYw56uc7AsI8lzGGtirC1PyeoNkmCS9OJmVpj2C4zgT0w4Bv
    fRRIRvb2Zgw11cWYDofZgFH3L8ZF9LsrJVYGp6LyzbEvhWT3LGZdU4A11BhGzHT71Yozqo
    8bJhwHECnddG8lIqfrPNfvCfxUxE/oS1mFXHxRylUQj1j9URASU8hVG3yejfXf6fflQiuS
    bLeSzH21T8lGztv+qF6FixffIjzLX7LOEToB+wMzSeOPg+ZmdRQOrM2RnxJ5HFz8KjjTBj
    pcZnHacq2D3zm2wPW5y60IfhSgZnCjs5gOfOMOVVOkwDcsrHxYXboZUOONGkZnkoLLnIbE
    DEoGSUmI+o0nUCMbG257mfZl1tJOipmtEyalw6AVNmy0DN2o8YIbVSvuogU+4ETFMpq89J
    Kx37Ikzc80WSaPNOhrv/lU6IzvdDiLjmsQU5mXOlSdEGciLbeFFylaz9jhMV0alxQxMbOq
    vOqO7K6zJuEUHGfzxKlhIj2AIkDGjkcSwvqqnxdVfb6L3v7Zis+AAeQ19yUc0ijd7JukUo
    P6W2C3uyD8WtxCyMRVwnTv7+wUnJodlIB9ZuT4r+RnGXbJf+95fBwg5tzRWPygQn1Es8rz
    8y+zQBERrDsLFRSJiYf9vJOHj4y0z2xocE/R1Q2L0TZbiMoMpaFtLnNFP/lQ
X-ME-Proxy: <xmx:-VtPaodx7MXCwUA2OwbIwkFoVoMcHe0aLsfFRdLeObCr7KEnAng0cA>
    <xmx:-VtPaueVRA-gYh-xdqmpy7YnolYcCrEV7kBUxm4i4-YS9hcIhFZYjg>
    <xmx:-VtPakhKgGNThOenUfzfZZTdA54KDAJVTt9zwWQBBWiQT2I7Q4WLFg>
    <xmx:-VtPaiRau5mdtiaUGtYpYkQYC3H4lCxt97ZmUpLrmu-rHTWc0YDumA>
    <xmx:-VtParkwDI0Ian45gryKynmRc9smNAd5ozVZ9gw5UA-dvElAoWdmjN2I>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 9 Jul 2026 04:29:44 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5a7b0f8c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 9 Jul 2026 08:29:44 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 09 Jul 2026 10:29:16 +0200
Subject: [PATCH 5/7] worktree: pass repository to file-local functions
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-pks-refs-wo-the-repository-v1-5-1ad6f27529c9@pks.im>
References: <20260709-pks-refs-wo-the-repository-v1-0-1ad6f27529c9@pks.im>
In-Reply-To: <20260709-pks-refs-wo-the-repository-v1-0-1ad6f27529c9@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

We have a bunch of file-local functions that use `the_repository`.
Adapt them so that the repository is instead passed as a parameter so
that we can get rid of this dependency.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 worktree.c | 47 ++++++++++++++++++++++++++---------------------
 1 file changed, 26 insertions(+), 21 deletions(-)

diff --git a/worktree.c b/worktree.c
index 8b10dea179..ebbf9e27e9 100644
--- a/worktree.c
+++ b/worktree.c
@@ -111,27 +111,28 @@ static int is_main_worktree_bare(struct repository *repo)
 /**
  * get the main worktree
  */
-static struct worktree *get_main_worktree(int skip_reading_head)
+static struct worktree *get_main_worktree(struct repository *repo,
+					  int skip_reading_head)
 {
 	struct worktree *worktree = NULL;
 	struct strbuf worktree_path = STRBUF_INIT;
 
-	strbuf_add_real_path(&worktree_path, repo_get_common_dir(the_repository));
+	strbuf_add_real_path(&worktree_path, repo_get_common_dir(repo));
 	strbuf_strip_suffix(&worktree_path, "/.git");
 
 	CALLOC_ARRAY(worktree, 1);
-	worktree->repo = the_repository;
+	worktree->repo = repo;
 	worktree->path = strbuf_detach(&worktree_path, NULL);
 	worktree->is_current = is_current_worktree(worktree);
-	worktree->is_bare = (the_repository->bare_cfg == 1) ||
-		is_bare_repository(the_repository) ||
+	worktree->is_bare = (repo->bare_cfg == 1) ||
+		is_bare_repository(repo) ||
 		/*
 		 * When in a secondary worktree we have to also verify if the main
 		 * worktree is bare in $commondir/config.worktree.
 		 * This check is unnecessary if we're currently in the main worktree,
 		 * as prior checks already consulted all configs of the current worktree.
 		 */
-		(!worktree->is_current && is_main_worktree_bare(the_repository));
+		(!worktree->is_current && is_main_worktree_bare(repo));
 
 	if (!skip_reading_head)
 		add_head_info(worktree);
@@ -182,7 +183,8 @@ struct worktree *get_linked_worktree(const char *id,
  * retrieving worktree metadata that could be used when the worktree is known
  * to not be in a healthy state, e.g. when creating or repairing it.
  */
-static struct worktree **get_worktrees_internal(int skip_reading_head)
+static struct worktree **get_worktrees_internal(struct repository *repo,
+						int skip_reading_head)
 {
 	struct worktree **list = NULL;
 	struct strbuf path = STRBUF_INIT;
@@ -192,9 +194,9 @@ static struct worktree **get_worktrees_internal(int skip_reading_head)
 
 	ALLOC_ARRAY(list, alloc);
 
-	list[counter++] = get_main_worktree(skip_reading_head);
+	list[counter++] = get_main_worktree(repo, skip_reading_head);
 
-	strbuf_addf(&path, "%s/worktrees", repo_get_common_dir(the_repository));
+	strbuf_addf(&path, "%s/worktrees", repo_get_common_dir(repo));
 	dir = opendir(path.buf);
 	strbuf_release(&path);
 	if (dir) {
@@ -216,12 +218,12 @@ static struct worktree **get_worktrees_internal(int skip_reading_head)
 
 struct worktree **get_worktrees(void)
 {
-	return get_worktrees_internal(0);
+	return get_worktrees_internal(the_repository, 0);
 }
 
 struct worktree **get_worktrees_without_reading_head(void)
 {
-	return get_worktrees_internal(1);
+	return get_worktrees_internal(the_repository, 1);
 }
 
 char *get_worktree_git_dir(const struct worktree *wt)
@@ -707,7 +709,7 @@ static void repair_noop(int iserr UNUSED,
 
 void repair_worktrees(worktree_repair_fn fn, void *cb_data, int use_relative_paths)
 {
-	struct worktree **worktrees = get_worktrees_internal(1);
+	struct worktree **worktrees = get_worktrees_internal(the_repository, 1);
 	struct worktree **wt = worktrees + 1; /* +1 skips main worktree */
 
 	if (!fn)
@@ -752,7 +754,7 @@ void repair_worktree_after_gitdir_move(struct worktree *wt, const char *old_path
 
 void repair_worktrees_after_gitdir_move(const char *old_path)
 {
-	struct worktree **worktrees = get_worktrees_internal(1);
+	struct worktree **worktrees = get_worktrees_internal(the_repository, 1);
 	struct worktree **wt = worktrees + 1; /* +1 skips main worktree */
 
 	for (; *wt; wt++)
@@ -786,7 +788,9 @@ static int is_main_worktree_path(const char *path)
  *
  * Returns -1 on failure and strbuf.len on success.
  */
-static ssize_t infer_backlink(const char *gitfile, struct strbuf *inferred)
+static ssize_t infer_backlink(struct repository *repo,
+			      const char *gitfile,
+			      struct strbuf *inferred)
 {
 	struct strbuf actual = STRBUF_INIT;
 	const char *id;
@@ -801,7 +805,7 @@ static ssize_t infer_backlink(const char *gitfile, struct strbuf *inferred)
 	id++; /* advance past '/' to point at <id> */
 	if (!*id)
 		goto error;
-	repo_common_path_replace(the_repository, inferred, "worktrees/%s", id);
+	repo_common_path_replace(repo, inferred, "worktrees/%s", id);
 	if (!is_directory(inferred->buf))
 		goto error;
 
@@ -842,7 +846,7 @@ void repair_worktree_at_path(const char *path,
 		goto done;
 	}
 
-	infer_backlink(dotgit.buf, &inferred_backlink);
+	infer_backlink(the_repository, dotgit.buf, &inferred_backlink);
 	strbuf_realpath_forgiving(&inferred_backlink, inferred_backlink.buf, 0);
 	dotgit_contents = xstrdup_or_null(read_gitfile_gently(dotgit.buf, &err));
 	if (dotgit_contents) {
@@ -1017,12 +1021,13 @@ int should_prune_worktree(const char *id, struct strbuf *reason, char **wtpath,
 	return rc;
 }
 
-static int move_config_setting(const char *key, const char *value,
+static int move_config_setting(struct repository *repo,
+			       const char *key, const char *value,
 			       const char *from_file, const char *to_file)
 {
-	if (repo_config_set_in_file_gently(the_repository, to_file, key, NULL, value))
+	if (repo_config_set_in_file_gently(repo, to_file, key, NULL, value))
 		return error(_("unable to set %s in '%s'"), key, to_file);
-	if (repo_config_set_in_file_gently(the_repository, from_file, key, NULL, NULL))
+	if (repo_config_set_in_file_gently(repo, from_file, key, NULL, NULL))
 		return error(_("unable to unset %s in '%s'"), key, from_file);
 	return 0;
 }
@@ -1058,7 +1063,7 @@ int init_worktree_config(struct repository *r)
 	 * _could_ be negating a global core.bare=true.
 	 */
 	if (!git_configset_get_bool(&cs, "core.bare", &bare) && bare) {
-		if ((res = move_config_setting("core.bare", "true",
+		if ((res = move_config_setting(r, "core.bare", "true",
 					       common_config_file,
 					       main_worktree_file)))
 			goto cleanup;
@@ -1070,7 +1075,7 @@ int init_worktree_config(struct repository *r)
 	 * upgrade to worktree config.
 	 */
 	if (!git_configset_get_value(&cs, "core.worktree", &core_worktree, NULL)) {
-		if ((res = move_config_setting("core.worktree", core_worktree,
+		if ((res = move_config_setting(r, "core.worktree", core_worktree,
 					       common_config_file,
 					       main_worktree_file)))
 			goto cleanup;

-- 
2.55.0.175.ge4962bd3d5.dirty

