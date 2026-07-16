Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EFA029B78F
	for <git@vger.kernel.org>; Thu, 16 Jul 2026 05:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784180008; cv=none; b=Di86zf+tp94H728n6b7cP4+3Lw3Jf/MsMyoGPi1qF4ZU2S42sevuCmkIXJKD7Q18HmFlbXUFxuvrHolyBE3vuVi1TrJb4wR73gz/Dns9ZAJubI4V78gUvvxbpGsC1yTRPRF4kgmTRQjvaZfLeGPAcDdySvdSpErhy/X6Jwkdv2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784180008; c=relaxed/simple;
	bh=773LiMCiS2DuHlY0vqzMuMt8RtIZhffCFz+6wbPGKew=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VSvTtZt3RW0Da/TyYeYiStqlBpKGZ/v+b8fPbc/IVgFB3RKZWBgYJ6rR5Wuk874x24y0XIE4gza1UBDo/d9OqjNAj9vlV5cDqBQbplnYh8KJJPxqxB6j8CEe2Q2FgSrNxzNn/UMsEh0biKtxTze4QzNv93JgLvlAbN8uqE6wr+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZBRXWqIM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=U7bpGy9S; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZBRXWqIM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="U7bpGy9S"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id B17271D00109;
	Thu, 16 Jul 2026 01:33:25 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 16 Jul 2026 01:33:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1784180005;
	 x=1784266405; bh=E7HX01K21JfZ5I622oBQtMC13CHImMlviIbGKl8hJ2Y=; b=
	ZBRXWqIMGCE4VKR1vDXoevPauM19TzDMvzrmJMrJxbyXOr/YTgoYE+bb25gKgvl6
	2NMOmSoeW5ir6a+XpiBqFaUc43Np/z/0sm39X8aBwYKpZn7k/2yV408Q05fUPHrV
	0H6SOxPzjB2LB4NoMS9JPVQj76bIHnHAWe0PYU6iNkpcYt5Vf6f1n2UxCDWVvQ3P
	RApHPNAUsy8c7YyOxyk714LS4d6dw6lDBbf/Ikn2bHRmPj4sUW2YYTre3cVNvA8P
	XdwKoxv7mKzlPrG8w5BIPTu1aFiTgXGFpwmaGeiJq17ii7SUAxc7RnhzpiGgkn/X
	elQQIzXLY6EeXkUbncST3g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784180005; x=
	1784266405; bh=E7HX01K21JfZ5I622oBQtMC13CHImMlviIbGKl8hJ2Y=; b=U
	7bpGy9Sm6/EXRD+V947SQyjqSqJd0KKaoHwc/4nZpz4XIGQVrACwXMDwBb9fwtnU
	1hHfd7BmNMRPDscHmotNG8NDOdE+Ke+g8jmzfZ/GZ9ro7L8jszBMN9IYNM0lFdBo
	kJdyUtw8xOzX7AT2ybX1e8/uPnvA/jpMy8Pt6a3rm6pdX8v9xNwYJZqq6bz8Yp1H
	Zw23Tm8m9shCXVhHtEeMp9o3vrjzePASUEiXhHk4lyRCUKaqsf+89800TvdgCrEA
	EZxSbGMDQIdJ16w+lDpUXVNzeC9lgWu/RGxvHMo1KTRcziW2M9uuipVQZVW2QSuS
	6VYAvonVxPJf/CWYLIqPw==
X-ME-Sender: <xms:JW1Yauk9YM566I_soLnVB_4mqLRymEgO1HUEzNqXcSS9aFFkPsOdmA>
    <xme:JW1YatSpNymwK4P0giof-XL-tmVtEwYt1LPIF7EHuwLOYAj4wJ6pmIhw_KSFzYxiI
    u1HUHBMFGG-cy8o_LFhs3F828sGOLyDj69QIJVQbMGZ-PnMu303xQ>
X-ME-Received: <xmr:JW1YaqDPNSsqYYYEYZdnGkmlHdLLDPvn38daqFu88bERNtcCN74ywKuRlEw5ZgZcJYHB5ICRsEnp8JPn-NQZ8tkX0rLgRew6rcBYxvSd>
X-ME-Proxy-Cause: dmFkZTEQVvnycNv4EXQVSrGvhY+5oFOPQLrghyNRtpnNl3PNLQaFTGAFZFKo2PBhfIUAaI
    N1j0Z521RNZXbuS+rt7EPo12N/7AAabi4FHzQJ1Z0rFjkJns90zhp9OSGsNwH2wn1oMDfX
    0xDWy5KHrkjBSchCml2vcYvJdIdwGtipBpcsVoZHzCi6ryd7RZvUESuaXj2gPbPoVkS8Fo
    0cj0R0GCVut7NGGCoCooj8QCIAjUBl2f4KNjJxVmTId5RpyCEWcSKwyVYAjStCQ+3Ev52p
    2NwGSv+Dqmbt2JNc/Atmb6PB4mGaSuXjbja9QQRs2GseMlistiJL+Oxhno5RpMrfNGYti6
    LRheNJhvYH217tdtXLdAifgoNnktbkTiaRWp8BcpzC/xON1Svcz90s8E0WbgneOGBXxV6e
    SB1UrelRjSdZJX7lN5D8S4RMXH3XJJI1S5Z6gAJd9PY1pEoTqiJRtOayoIAx6jBAepnE6U
    JYAbGemVTzNgpeFKN9HSUq5fAKXTY2e/eT7Dx4VMbnp/VelQ+zA7b33BHm+1rM8tVIydfQ
    l4eT/fiLutMGSPx1DASZK4mXWn3O9SUYj0rz3CE1WtifLcgjR8rXuB5T9lPHcKDR2ZWG29
    wch14TWSx5ttyHvh/Odwfsn7UI0RhpF2r0qgCMsELdi3XSvACKi+N9kgFGag
X-ME-Proxy: <xmx:JW1YasSqvc75t7KeVUNFtOVuGtD3Zhzx66G6pYgZuAnAXwGEJYXhFQ>
    <xmx:JW1YagpJPz1h7aFMtRMN9RBYmOEkCS84qvstrqV7RRCS58MNth5Pbw>
    <xmx:JW1YamyWWvsJdflTvB8Axg9WRCwid5Qrbm6AtMqNzjpYfCNCh5snZw>
    <xmx:JW1YatIdGirQX8FZvEI6sughMKdeup6PesTEnd-CLe0uHIJv-mva2Q>
    <xmx:JW1Yam6BFcw2g-iTiAX4Zj7kBTqI2Bj43egay6R4TbXSwjVrgAhTGBpl>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jul 2026 01:33:24 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id af3557df (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 16 Jul 2026 05:33:23 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 16 Jul 2026 07:33:05 +0200
Subject: [PATCH v3 4/6] worktree: pass repository to file-local functions
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260716-pks-refs-wo-the-repository-v3-4-db0a804e0224@pks.im>
References: <20260716-pks-refs-wo-the-repository-v3-0-db0a804e0224@pks.im>
In-Reply-To: <20260716-pks-refs-wo-the-repository-v3-0-db0a804e0224@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Toon Claes <toon@iotcl.com>
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
2.55.0.313.g8d093f411d.dirty

