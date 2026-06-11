Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39A435F191
	for <git@vger.kernel.org>; Thu, 11 Jun 2026 06:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781160299; cv=none; b=jhkKGVFx0RWNasl3sGHhRvPtCFhxESjt0ZHc2hUMP0YQNJBlf714jnPxVRXNQ+9TT3GAHFlA6b2lmpqUZfsNyArRH2ij/3au8Vw1aRGJPRDXXNNGiWJjzjbDhTQtVnFLxe7yMubb/80UWxEAqx2dcPVVdpYkRU41lMf20OasjcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781160299; c=relaxed/simple;
	bh=wHKafm47JQS76k7jJmUNXiah0xVHlKwdnNrHvIAuFMk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SNLgpD7iEQyxH5C1mB2ytOXYWaVL0AkN4pn5/gONglNPw+cCxwVK+zsq30Zt0CgkA0FOWL0Y6F3Jkkk9hzKtT/0L0P+2r+SIDApqH/obR/SYSulCDrmNtxxfBs8MIvlA8iikWTOojfNcrQ0q//BECi/Qb4uaYdSXqEEXjJPV53Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=sc4lt7oz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=U6jX3076; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="sc4lt7oz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="U6jX3076"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4151D7A00FD;
	Thu, 11 Jun 2026 02:44:57 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 11 Jun 2026 02:44:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781160297;
	 x=1781246697; bh=KosdnOqL5W4UaCbbaNmHF/jDBH/wNucmeZ/3DeI2eww=; b=
	sc4lt7ozOs9hRHp0BdSHDk32D4Mb5dt/dedohRsNBFH0tR01o+Os3pXiYE/yNZ5t
	Ky2vah1qmDlc0GKTrr9t3i9E0kmYcsb0IH9m45/SNRB3KY8iUaIHReRZjQe8BEr0
	k/DajaAbcig0pCjaym2WBZwseTF560XxpH/asUoG6ghzYCGQvOd1Ix9VfR8HnZ2/
	sAqDFxhcpBWRWQYrASB8p0ar2hllaoP90wChwl9j4pmCnCYXl1hQHwpnBdXEZNl/
	RyMFrr/7jfDmPBC78F/Rl8tLFIbEYP1s9jCa+FXCZywM0paFzqLBkJWq17W+qyv8
	lYdod/jUPXDb46aPPB5jJQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781160297; x=
	1781246697; bh=KosdnOqL5W4UaCbbaNmHF/jDBH/wNucmeZ/3DeI2eww=; b=U
	6jX307639Q97qkWP1kz1uI7c+8dwSJkv7W6fNtBiWvP24PwoQT2m+TRJbH3qhWWO
	2ySXV2ndxd5wpuT7dF6QD/8tFZfWKjmzpHmjk41sRgRwX3xRWXwwLLb2z836kRHF
	wZnY776mmC/wwL1q27J9Uqn1G3Q6aIeo/NpQnCRuKSBkynTvFR7QAUqgJklR6W38
	R46J1Z3IrM/cdCoDXkMdag1K7N3k35fe5AfQRI6ZnVTOb8atYSmkvpAX1kwyFk1m
	yRo0YiWzjjZfnA9RLYIbO1vuEpDlL7X8eCiY3Clj1GymDVLRiheVsY1gnv1V8sQR
	mfmU+ICouc867yr9xXMgQ==
X-ME-Sender: <xms:aVkqaluB-w9BjDuomRo5CJ-ph8a5CO3cFqCQD8rqNfA1rZybFAKxMw>
    <xme:aVkqakd1xcZAdrNT-jxDSQLluJbchQeG6WCs-Pw_XeXVtOVlOnz9cSmdSbov1YKSg
    Zea3QbKuuusi-CB7_2QCdmr-PP7C4zdO4_L6jO8ipDl69ikO4vq>
X-ME-Received: <xmr:aVkqamavLe2pDmQKcR2yRt-uykdmvf_rp-gaNbVGgTlhpxFyju7ZWMuQWPT4r0SZw6SKcpvMKTUsrnyBEic28RukuzJmI_Dbix4XzwqfjIR1>
X-ME-Proxy-Cause: dmFkZTF/+amKZAWEfZ0XKC1clGzeEdUQ0sbNVPmfkao1bjuFszGMFlLsNP6VIL6nYaFhf8
    KuZOlpXDb1+t+UjZzn+rooZ63IyyiHIGHw09HoJoH9KXxBBj+o6sqMXMiAdGpIbsou6I7U
    7SECo8r2jLbqxNxaKEsfWCXGgIZJehesKiCeieg9aFozFaYm4wMsH6ArmFJuaSmaDJUEuX
    X0++evCOGiHAiDfyOmSU+MO7I8nUHuXRF43lJrXyZVLyGz+nBstf2CfiAOFg8A9zs/xB1H
    x33NIndHuVLmXhfJridtUEJvT8M5hbXbLkM+mlDXo3gtSuC3qLjhY4A9mkeHuuoK9wvjsK
    +Zb6kqCsj5TiLTmocYy+mNnHdjVaUMMIYQ7b6GQvnIQWhBUPAJmW8gjGZtDcn23o9Xfqwk
    ofe0xigXmCx4CFfv8793KWffwooop6b9vCz7ui80AKskJO7D1vV97nmTwxwRkGCwV0ichH
    pelahfZz5ROCYwAYaFkKNICzO9lkcDyI4xpcpT66k8YvU0XwM5DwkcLlP11Cregw4erVn1
    4y6wjNNLyLWxQAM+yDnXb3vY6O5Y0DE+Mwhil7bvrXy/UesBTMp46f/1pl22A8ZlsAQEbI
    0nZfbP7MH2/DFmPKaSTzc9RQDJ12KCPE0AJhjQp/tXRn8SaI+tOoThqa0Lqg
X-ME-Proxy: <xmx:aVkqanWb61U4F6vZg6vNt753PqS74LePDuNlhSDWfdGzaDNRTiPh3A>
    <xmx:aVkqaojMnvK1fvKKQh_hPOVBFTGcYG4rYhzliV2WwEk5ofxi9S0WfQ>
    <xmx:aVkqalUxVxSnxnU9ZmQuxO1LJ_QI_C6Cik2haabKC20N8J2LoADgZA>
    <xmx:aVkqavMRYwtlmoa9QJ58Y3poakhfTVwH6XAHt-5buPx-2-6s3ArN7A>
    <xmx:aVkqagfamYcThk-5-wD07d7YvG_jSvSSimYH7is_DKWW7OqxRHnV7ALd>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Jun 2026 02:44:56 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 457a4951 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 11 Jun 2026 06:44:55 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 11 Jun 2026 08:44:43 +0200
Subject: [PATCH v2 5/7] environment: split up concerns of
 `is_bare_repository_cfg`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260611-b4-pks-setup-drop-global-state-v2-5-a6f7269c841d@pks.im>
References: <20260611-b4-pks-setup-drop-global-state-v2-0-a6f7269c841d@pks.im>
In-Reply-To: <20260611-b4-pks-setup-drop-global-state-v2-0-a6f7269c841d@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.15.2

The `is_bare_repository_cfg` variable tracks two different pieces of
information:

  - It tracks whether the user has invoked git with the "--bare" flag,
    which makes us treat any discovered Git repository as if it was a
    bare repository.

  - Otherwise it tracks whether the discovered `the_repository` is bare.

This makes the flag extremely confusing and creates a bit of a challenge
when handling multiple repositories in the same process.

Split up the concerns of this variable into two pieces:

  - `startup_info.force_bare_repository` tracks whether the user has
    passed the "--bare" flag. This is used as a hint to treat newly set
    up repositories as bare regardless of whether or not they have a
    worktree.

  - `struct repository::bare_cfg` tracks whether or not a repository is
    considered bare. This takes into account both whether the user has
    passed "--bare" and the discovered state of the repository itself.

Whether or not a repository is bare is now resolved when checking the
repository's format, and is then later applied to the repository itself
via `apply_repository_format()`.

This enables a subsequent change where we make `is_bare_repository()`
not depend on global state anymore.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/init-db.c |  2 +-
 environment.c     |  5 ++---
 environment.h     |  1 -
 git.c             |  2 +-
 repository.c      |  1 +
 repository.h      |  7 +++++++
 setup.c           | 27 ++++++++++++++++++++-------
 setup.h           |  6 ++++++
 worktree.c        |  2 +-
 9 files changed, 39 insertions(+), 14 deletions(-)

diff --git a/builtin/init-db.c b/builtin/init-db.c
index 52aa92fb0a..566732c9f4 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -81,7 +81,7 @@ int cmd_init_db(int argc,
 	const char *template_dir = NULL;
 	char *template_dir_to_free = NULL;
 	unsigned int flags = 0;
-	int bare = is_bare_repository_cfg;
+	int bare = startup_info->force_bare_repository ? 1 : -1;
 	const char *object_format = NULL;
 	const char *ref_format = NULL;
 	const char *initial_branch = NULL;
diff --git a/environment.c b/environment.c
index 4e86335f25..9d7c908c55 100644
--- a/environment.c
+++ b/environment.c
@@ -48,7 +48,6 @@ int has_symlinks = 1;
 int minimum_abbrev = 4, default_abbrev = -1;
 int ignore_case;
 int assume_unchanged;
-int is_bare_repository_cfg = -1; /* unspecified */
 int warn_on_object_refname_ambiguity = 1;
 char *git_commit_encoding;
 char *git_log_output_encoding;
@@ -136,7 +135,7 @@ const char *getenv_safe(struct strvec *argv, const char *name)
 int is_bare_repository(void)
 {
 	/* if core.bare is not 'false', let's see if there is a work tree */
-	return is_bare_repository_cfg && !repo_get_work_tree(the_repository);
+	return the_repository->bare_cfg && !repo_get_work_tree(the_repository);
 }
 
 int have_git_dir(void)
@@ -342,7 +341,7 @@ int git_default_core_config(const char *var, const char *value,
 	}
 
 	if (!strcmp(var, "core.bare")) {
-		is_bare_repository_cfg = git_config_bool(var, value);
+		the_repository->bare_cfg = git_config_bool(var, value);
 		return 0;
 	}
 
diff --git a/environment.h b/environment.h
index 5d6e4e6c1b..afb5bcf197 100644
--- a/environment.h
+++ b/environment.h
@@ -147,7 +147,6 @@ void repo_config_values_init(struct repo_config_values *cfg);
  */
 int have_git_dir(void);
 
-extern int is_bare_repository_cfg;
 int is_bare_repository(void);
 
 /* Environment bits from configuration mechanism */
diff --git a/git.c b/git.c
index 36f08891ef..387eabe38c 100644
--- a/git.c
+++ b/git.c
@@ -255,7 +255,7 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 				*envchanged = 1;
 		} else if (!strcmp(cmd, "--bare")) {
 			char *cwd = xgetcwd();
-			is_bare_repository_cfg = 1;
+			startup_info->force_bare_repository = true;
 			setenv(GIT_DIR_ENVIRONMENT, cwd, 0);
 			free(cwd);
 			setenv(GIT_IMPLICIT_WORK_TREE_ENVIRONMENT, "0", 1);
diff --git a/repository.c b/repository.c
index 187dd471c4..c1e91eb0da 100644
--- a/repository.c
+++ b/repository.c
@@ -73,6 +73,7 @@ void initialize_repository(struct repository *repo)
 	ALLOC_ARRAY(repo->index, 1);
 	index_state_init(repo->index, repo);
 	repo->check_deprecated_config = true;
+	repo->bare_cfg = -1;
 	repo_config_values_init(&repo->config_values_private_);
 
 	/*
diff --git a/repository.h b/repository.h
index 36e2db2633..7d649e32e7 100644
--- a/repository.h
+++ b/repository.h
@@ -117,6 +117,13 @@ struct repository {
 	bool worktree_initialized;
 	bool worktree_config_is_bogus;
 
+	/*
+	 * Whether the repository is bare, as set by "core.bare" config or
+	 * inferred during repository discovery. -1 means unset/unknown, 0
+	 * means non-bare, 1 means bare.
+	 */
+	int bare_cfg;
+
 	/*
 	 * Path from the root of the top-level superproject down to this
 	 * repository.  This is only non-NULL if the repository is initialized
diff --git a/setup.c b/setup.c
index 71fc6b33da..32f14a8688 100644
--- a/setup.c
+++ b/setup.c
@@ -795,10 +795,22 @@ static int check_repository_format_gently(const char *gitdir,
 		has_common = 0;
 	}
 
-	if (!has_common) {
-		if (candidate->is_bare != -1)
-			is_bare_repository_cfg = candidate->is_bare;
-	} else {
+	if (startup_info->force_bare_repository) {
+		candidate->is_bare = 1;
+		FREE_AND_NULL(candidate->work_tree);
+	} else if (has_common) {
+		/*
+		 * When sharing a common dir with another repository (e.g. a
+		 * linked worktree), do not let this repository's config
+		 * dictate bareness; it is inherited from the main worktree.
+		 */
+		candidate->is_bare = -1;
+
+		/*
+		 * Furthermore, "core.worktree" is supposed to be ignored when
+		 * we have a commondir configured, unless it comes from the
+		 * per-worktree configuration.
+		 */
 		FREE_AND_NULL(candidate->work_tree);
 	}
 
@@ -1138,7 +1150,7 @@ static const char *setup_explicit_git_dir(struct repository *repo,
 	/* #3, #7, #11, #15, #19, #23, #27, #31 (see t1510) */
 	if (work_tree_env)
 		set_git_work_tree(repo, work_tree_env);
-	else if (is_bare_repository_cfg > 0) {
+	else if (repo_fmt->is_bare > 0) {
 		if (repo_fmt->work_tree) {
 			/* #22.2, #30 */
 			warning("core.bare and core.worktree do not make sense");
@@ -1225,7 +1237,7 @@ static const char *setup_discovered_git_dir(struct repository *repo,
 	}
 
 	/* #16.2, #17.2, #20.2, #21.2, #24, #25, #28, #29 (see t1510) */
-	if (is_bare_repository_cfg > 0) {
+	if (repo_fmt->is_bare > 0) {
 		set_git_dir(repo, gitdir, (offset != cwd->len));
 		if (chdir(cwd->buf))
 			die_errno(_("cannot come back to cwd"));
@@ -1762,6 +1774,7 @@ int apply_repository_format(struct repository *repo,
 		alternate_object_directories = xstrdup_or_null(getenv(ALTERNATE_DB_ENVIRONMENT));
 	}
 
+	repo->bare_cfg = format->is_bare;
 	repo_set_hash_algo(repo, format->hash_algo);
 	repo->objects = odb_new(repo, object_directory,
 				alternate_object_directories);
@@ -2571,7 +2584,7 @@ static int create_default_files(struct repository *repo,
 		repo_settings_set_shared_repository(repo,
 						    init_shared_repository);
 
-	is_bare_repository_cfg = !work_tree;
+	repo->bare_cfg = !work_tree;
 
 	/*
 	 * We would have created the above under user's umask -- under
diff --git a/setup.h b/setup.h
index 705d1d6ff7..b9fd96bea6 100644
--- a/setup.h
+++ b/setup.h
@@ -292,6 +292,12 @@ enum sharedrepo {
 int git_config_perm(const char *var, const char *value);
 
 struct startup_info {
+	/*
+	 * Whether the user is asking us to treat the repository as bare via
+	 * `git --bare`, even if it's not.
+	 */
+	bool force_bare_repository;
+
 	int have_repository;
 	const char *prefix;
 	const char *original_cwd;
diff --git a/worktree.c b/worktree.c
index 97eddc3916..7d70f2c1da 100644
--- a/worktree.c
+++ b/worktree.c
@@ -123,7 +123,7 @@ static struct worktree *get_main_worktree(int skip_reading_head)
 	worktree->repo = the_repository;
 	worktree->path = strbuf_detach(&worktree_path, NULL);
 	worktree->is_current = is_current_worktree(worktree);
-	worktree->is_bare = (is_bare_repository_cfg == 1) ||
+	worktree->is_bare = (the_repository->bare_cfg == 1) ||
 		is_bare_repository() ||
 		/*
 		 * When in a secondary worktree we have to also verify if the main

-- 
2.54.0.1189.g8c84645362.dirty

