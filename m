Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A31D382290
	for <git@vger.kernel.org>; Wed, 10 Jun 2026 06:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781074630; cv=none; b=pv5tFnMYONOnyL+eTwP06xmFF5fgWQGbUl3eVZm3Km3UdqHs8VcSmhR32ezfBDuU0+21zPWPRf+VOez/dVl0/fPkOQV1ny9Z3a1k6ZV5bUP7onmqMQcYAnCCz61ZHZTq1QW8QkfgLcZkcjm2TpityfIDDuCRhZkAvXE34PQ7pbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781074630; c=relaxed/simple;
	bh=aCZpaOEChFNDH9zKyo51aSK5DGB1VPHDKHUDVfxTFNA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DA/1xnKXfD1BSU/uWP5PMsK+9xJ2lPeuTHsHgjdRtkzDNTuGuUZ17kHHyqRIatgIC6m1quBApOEzxe54jBdKqCd95DfXwOXdzjrq3yFkW05EJQZUwkGgt99h/YjMWUYzC91Dm2lzvzxQ3jiz24s1glaKWyJ8ggo7LPxco94YYao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=EZb3biEF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GcKsBufQ; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="EZb3biEF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GcKsBufQ"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id 9FB721D00041
	for <git@vger.kernel.org>; Wed, 10 Jun 2026 02:57:08 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Wed, 10 Jun 2026 02:57:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781074628;
	 x=1781161028; bh=vU0AmV+dFEdTjFdElH7+gXKolShg2LcZy2LCZXLjjdo=; b=
	EZb3biEFHRv1/qpV2ma3SPDv+4AYLIwD5QHuw6csdfkfOR43mhWhV/bKef1yRlJF
	lFu8wfoeLSxfcrnQoHz34HL88CokIFdQzYoY4ylPTZJzRAdRA78BtM6EaLlWYaVr
	Zu0OPmalvs0vr7qdd0HlLumTd3U6JgvqZdLaLD4vra8wuToxS2lHDbn3iBSqB/T8
	W66NHMe1hDkf/MHq8QCtb9yjUNsdmCpUix2WRU/QIlpW2yYiLnCNIfw6CSCI6zq3
	aDFuuptpx/CGM2RtfCEod7cnaAm7+4A7GxS6FCyoUCYshzre6qWcGwzKD/OWe9wd
	vHwJLuwrXWw4N+phLE7esQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781074628; x=
	1781161028; bh=vU0AmV+dFEdTjFdElH7+gXKolShg2LcZy2LCZXLjjdo=; b=G
	cKsBufQciWSURYBFc0evOKXJ2aeG9+BLX/fKsegwJsYq6s8pKFp6F1seQiPvq1pz
	mBxsA3UxOUzba2IhnnInRSs2gUShmvG+jAVw5wq8YNkN7YYDAzRYaXd2sskiSC8V
	2waRVgAOWF97htUoR7Kczh9JUxTBWz2T1tnBcaGWhUyjeFxIxNo/eXynVB0zVP9D
	/u/akutPN0oPfvRsfr0DVKc+MrcORyjHRVCm7JG/qaLAzhe9UpDPdMH7OMvzbGfm
	lqRYgGyZHqB2ZsfBobcas3bMaI8za1T0fE4YUKxFZZ4HMFaKLbmBZruUCB6IhKmr
	SSWLQPjWeOiOuh/l1NwBQ==
X-ME-Sender: <xms:xAopakAk19biTdgz7Diorj6msGWJLs8_g64VbEh3kGNzNvVGdg7A9w>
    <xme:xAopatcDzFWPTZGQ-h1XtirqhBJidfKiIL_cscFOkZo4x4d8zWm-1uoQmpTsOI52F
    0AKU4KX-kr02XufG4U4diDnvwviUyWW2dAuG_1KHtogb3G_Fk5Qxw>
X-ME-Received: <xmr:xAopatM3p0t1ZnUw-28ioaqBw0tcXrLOP1oiQXEdFBn_Ab-KIL4QtEs-QvOjtQfJreeBFpG6J2TWGyl1DUmZ7WBspxxQf8Kl9HU8AFw4fg>
X-ME-Proxy-Cause: dmFkZTFJQyD/VDIFXGhA/jRdOE7X0CWqy4qn5bLIQ65+hJjnYMEZatWqVuJesENoaQuPko
    Q5yf9Ry5wPhjX33q2dK9sHGnfBKOzkBg0Fwf0Euz1csXFFXOoVZSdIt9bU96CpPP96cxvm
    iUoOvM9A2npWuhPfuaDrI9ga5F+8qrLiKhqumx6Qwll+m5rKkfyYq5hI7mi04n/AN6ouVj
    q07bwAnUH38srt2quBUglYFlAN96lY7NECZcAUdi7SoKR9VCqz6AG5eO7qBO0c4Sk6Jr/+
    UL6aIQZZDbChCYhzkgC4nhrWfVxUsoXxklal67cwhekFk2m5OdrYlWhx8ceK8l3d8VOJG8
    gpOUIgXpBJwG1cxNMuBsYlXWLmlDoTQoimfrRLcdsotVHO//u7/+F17rNKx+opR/+jf3y4
    wwnTe3kiWREivNESiyzXLKcvUk97nNccCRMrUZDVOVUybhpc7iSALW2LbahpQoJRamUWIB
    w3HMJynz5J0hh25Qrkymg6CqIYpGk04cORrT3QiT+5Eow/zEbdSFvB6TmworuNpvI59iy7
    dcurwyOYJ/aGVdrAM4t7M3w1NoykVIlJ0ZbbV124J/HejNOMmOKFX8tl7BQAzsLl4QI1Re
    9P7nPhrWjRywxUIDuqUhoK1md1oiXzFObdQwe3dYGi9BQ3dAx58Nvwly+OyA
X-ME-Proxy: <xmx:xAopav7XU0uuWBVSKM0zD89G-CBqR5LPcym_CSMcNppAjG0VvuAvBg>
    <xmx:xAopapIgDmo8uXT1nsRp2H9IqFngxfs7IS4mtk4T4bFjkMqtdpdwVQ>
    <xmx:xAopahf3iT2t15mW9nFsPhSe2fFKAOp33xR9OZgYNBBaO-GHKeJJzw>
    <xmx:xAopakfo7_EuaAnBj-131Axzdq5GecU4t9GcrQy6N4i06NOaQvlTZw>
    <xmx:xAopavAiBkkjIYSHNB6w2D2Uj2tiKqhGN7hTnOx7-tW071FEUQYwc4w_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 10 Jun 2026 02:57:07 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 104c04d6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 10 Jun 2026 06:57:07 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 10 Jun 2026 08:56:50 +0200
Subject: [PATCH 5/7] environment: split up concerns of
 `is_bare_repository_cfg`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260610-b4-pks-setup-drop-global-state-v1-5-5dff3eec8f06@pks.im>
References: <20260610-b4-pks-setup-drop-global-state-v1-0-5dff3eec8f06@pks.im>
In-Reply-To: <20260610-b4-pks-setup-drop-global-state-v1-0-5dff3eec8f06@pks.im>
To: git@vger.kernel.org
Cc: 
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
 setup.c           | 21 ++++++++++++++-------
 setup.h           |  6 ++++++
 worktree.c        |  2 +-
 9 files changed, 33 insertions(+), 14 deletions(-)

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
index 71fc6b33da..2b690da8ca 100644
--- a/setup.c
+++ b/setup.c
@@ -795,10 +795,16 @@ static int check_repository_format_gently(const char *gitdir,
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
 		FREE_AND_NULL(candidate->work_tree);
 	}
 
@@ -1138,7 +1144,7 @@ static const char *setup_explicit_git_dir(struct repository *repo,
 	/* #3, #7, #11, #15, #19, #23, #27, #31 (see t1510) */
 	if (work_tree_env)
 		set_git_work_tree(repo, work_tree_env);
-	else if (is_bare_repository_cfg > 0) {
+	else if (repo_fmt->is_bare > 0) {
 		if (repo_fmt->work_tree) {
 			/* #22.2, #30 */
 			warning("core.bare and core.worktree do not make sense");
@@ -1225,7 +1231,7 @@ static const char *setup_discovered_git_dir(struct repository *repo,
 	}
 
 	/* #16.2, #17.2, #20.2, #21.2, #24, #25, #28, #29 (see t1510) */
-	if (is_bare_repository_cfg > 0) {
+	if (repo_fmt->is_bare > 0) {
 		set_git_dir(repo, gitdir, (offset != cwd->len));
 		if (chdir(cwd->buf))
 			die_errno(_("cannot come back to cwd"));
@@ -1762,6 +1768,7 @@ int apply_repository_format(struct repository *repo,
 		alternate_object_directories = xstrdup_or_null(getenv(ALTERNATE_DB_ENVIRONMENT));
 	}
 
+	repo->bare_cfg = format->is_bare;
 	repo_set_hash_algo(repo, format->hash_algo);
 	repo->objects = odb_new(repo, object_directory,
 				alternate_object_directories);
@@ -2571,7 +2578,7 @@ static int create_default_files(struct repository *repo,
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

