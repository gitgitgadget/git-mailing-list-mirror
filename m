Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3758369D7A
	for <git@vger.kernel.org>; Thu,  4 Jun 2026 07:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780559209; cv=none; b=lxby3ZcTCXzqgkXqZKtP+OhAJmUvXYD4m7NRvR3qvNBeZvL3G0IdAcbSQwUpU5wK7yoTPb3uKtzBOrW/S2hfCGnRyovfEU3ffx1x0eST64tdb7BDbXfzTRpdlYy5j11PVjetrJSQvk5qXz1Q0LccHdh9Y/wMuPSNpMvgrNXwscM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780559209; c=relaxed/simple;
	bh=YGfNisCjXDI7ruEEYO22sALnN2+MF/1Zt0/EX6mXJ4Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cAYerSCF9+BYHx0+LO35Lip+Cq09L2lorQ1nXu4LLjp9lzhDBd2BtUJqosMvJywQhRz9VAM5dercTdPxD2LBoa2L/kJEiY0uq29S+YCL9v/e5T78RxEQKCoXYZJxSoHTQWYqOAxnilmmiIU77e0sd22wyTcWvjEoX5YXlhiae04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mF6Y/jBR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NZLJ89Mj; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mF6Y/jBR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NZLJ89Mj"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1B50114000F9;
	Thu,  4 Jun 2026 03:46:47 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 04 Jun 2026 03:46:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1780559207;
	 x=1780645607; bh=HQ3Cvg9+kDby7X1y2OpjYDl5Kbb9mHXt7Om6IkjmK2k=; b=
	mF6Y/jBRT6Va3DGzyUkSIHfJYVCmrjqEuULdTU5yVMsfFQO5AW2kP2WVBl5rq8wy
	XqcfDXKT1qxQ7mjBGGdru04fBsNoI572QvuDRJPAuREcZMwYo2QkmSvrKOVbG+xa
	VmRmfCyxN6cKEUYrGbNUD2rv1IXost+Mp8FWkdkQ8tvGC2lrHTtiN2cj1F4bgIIo
	2pyv7xaWNd5SedpBDkdgcyb2NdYePtEMOLmePoIlJ9K4izmsq12KGK4QjJch5df3
	RH9EEbVc6+WrY6EzdAw0ujGMIwLBOYr+AI98jlGKp9mgw7JvUQe+A9af9QF94CuM
	nupGGhwWL/DXgQYho/a9hg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780559207; x=
	1780645607; bh=HQ3Cvg9+kDby7X1y2OpjYDl5Kbb9mHXt7Om6IkjmK2k=; b=N
	ZLJ89MjSYxmzLNWf56iqLiORN4buwNxxTzyhE1q/tuUxviYAjN0cAHsCAXp/FzFe
	O2rQWj2lAwD+xwedZm3pp6VU7hlDGSpQ59+/zB3y+v7hkqywiVKHRdQedeHGYyZu
	Qw2CJcj5BZ/04i2XlUQxZuKhgL/i6glpKa/+OpeCl2KN7sEWlXKALEKkQ+K6zT4O
	2XYS4ni9pG8wguW8SnuqEz1oNz45iSoil/gHMsDlolrIEyvwCMK6waUdbJpLHpbN
	v7CRy9pMKArSNONU43F6K+K46eTne1C4KDW6f8dzUCRzHbZmNHl0NKD9/XJJVxAX
	i6cWUAgT/mMMX2Fu+jIDw==
X-ME-Sender: <xms:Zy0hajGy07GtvzO7V4JAOUk3jLKW2GnKzmhADWNw0LwtpqthAXqJFQ>
    <xme:Zy0hanWllQ8BL5lX5xg_uFxQINwX-pb3LuSeGsOKRIYl56J5xc2Jmf_t4RToyvQHO
    jueJ5pA_4lav5OZY2HblBXQsMcwKP28crAGHnXNVxFSLK4VaUByxQ>
X-ME-Received: <xmr:Zy0haqKeJIE48RReX5y1PJo7Pwc4US2kLHyGiP2ixcrKFujIQkjLBpqAG81gnS-caNqtlLQFkCCN_U3VkrVHygoLfMoOfciI3P7qkCAwyW8>
X-ME-Proxy-Cause: dmFkZTEd/wZLSFtwQVPACQsVX2yDwAf383Bdc0tR+p5729Mhi1e1AtQtMA/g4VsWVwTHWh
    qNGwVXDbahu4NS5MYTuI9+B1lU0FBMXXLiwn9ZqB110XnpphPlKVjFK3FhLqRHKvjreL1U
    yuoB+rAmnu1kGr6OEVbLdtfFIPdukJpb2g+cdusvr+IsCsfFhyCkU6GEnIeasfFMr6lZSb
    +QF/0+sNY7nCuL1JSEVuSB9JACtDjtW1A3ItArUYDI94gYKQXlalAIgs1sw1gOr6oAP8m7
    imLnOAyRssO3edUNJEt3F6n1O+rJ72/l35UYyExqEDoPNd76lDZol9HoPYjXnUtpTaCXeE
    MMZn7X/F3v0AiQZT97pZ7GkemsSiCPk72aCyRAmA67+sYc76SZCi6aIO662N2KDlOtaP/Q
    xMm7qxQHUnLByEJTMfUjA2cd9ZBoO3s1yD10FjGQl2d4fUi88YKlYJJ08HcQSZAsjQq9l5
    V6hsUcyKraZeyaegDNdEaxpf9nLe2UzPL5DBTI0YYIQDXduKz/H8Exzg8rqiGhIHypNlTT
    IIgJyth3wy9gMTQFqp2c3axeJ0hTtXU4rtW4YFUMW0o8rAYmDk3afbtxoHajbHD940CtlP
    KxYdfK40XUv+nRpCBxQk2ofDqYM6ckobsJUAOUw7+qX8LGeO3WUdm8XGWYlA
X-ME-Proxy: <xmx:Zy0hav8klXXsxJomNmN6cj3BNk1olwafZcDV1nd7UabRyjSKUQR_gQ>
    <xmx:Zy0halIQE_q6zORIySGKctyFEnegP5mTaPDvIl4XsWv_YoUq64QkYw>
    <xmx:Zy0hasns9RCpytuyRcVettYRSpyKJ9-jWjDLzQSYrtvOyHWvfD0DMA>
    <xmx:Zy0hahN7qUrlnyluDuA71V-mxqA40yQ4DE-iu9hzCYK_f-yhJhq0wg>
    <xmx:Zy0halqjYTRek9eNkPs7PVfxTMzWajb9Y8ai0iaSHjipcKVmGyjesDxz>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Jun 2026 03:46:46 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6f4768df (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 4 Jun 2026 07:46:45 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 04 Jun 2026 09:46:27 +0200
Subject: [PATCH v3 3/8] setup: deduplicate logic to apply repository format
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260604-b4-pks-setup-centralize-odb-creation-v3-3-0691834f318a@pks.im>
References: <20260604-b4-pks-setup-centralize-odb-creation-v3-0-0691834f318a@pks.im>
In-Reply-To: <20260604-b4-pks-setup-centralize-odb-creation-v3-0-0691834f318a@pks.im>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15.2

After having discovered the repository format we then apply it to the
repository so that it knows to use the proper repository extensions. The
logic to apply the format is duplicated across three callsites, which
makes it rather painfull to add new extensions.

Introduce a new function `apply_repository_format()` that takes a repo
and applies a given format to it and adapt all callsites to use it.
This function is also the new caller of `verify_repository_format()` so
that we can ensure that we never apply an invalid repository format.
The verification we have in `read_and_verify_repository_format()` is
thus redundant now and dropped.

Rename `read_and_verify_repository_format()` accordingly. While at it,
also rename `check_repository_format()` to clarify that it doesn't only
_check_ the format, but that it also applies it.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 repository.c | 31 +++++++-------------
 setup.c      | 93 ++++++++++++++++++++++++++++++++----------------------------
 setup.h      | 10 +++++++
 3 files changed, 71 insertions(+), 63 deletions(-)

diff --git a/repository.c b/repository.c
index db57b8308b..58a13f7c4f 100644
--- a/repository.c
+++ b/repository.c
@@ -262,8 +262,8 @@ void repo_set_worktree(struct repository *repo, const char *path)
 	trace2_def_repo(repo);
 }
 
-static int read_and_verify_repository_format(struct repository_format *format,
-					     const char *commondir)
+static int read_repository_format_from_commondir(struct repository_format *format,
+						 const char *commondir)
 {
 	int ret = 0;
 	struct strbuf sb = STRBUF_INIT;
@@ -272,11 +272,6 @@ static int read_and_verify_repository_format(struct repository_format *format,
 	read_repository_format(format, sb.buf);
 	strbuf_reset(&sb);
 
-	if (verify_repository_format(format, &sb) < 0) {
-		warning("%s", sb.buf);
-		ret = -1;
-	}
-
 	strbuf_release(&sb);
 	return ret;
 }
@@ -290,6 +285,8 @@ int repo_init(struct repository *repo,
 	      const char *worktree)
 {
 	struct repository_format format = REPOSITORY_FORMAT_INIT;
+	struct strbuf err = STRBUF_INIT;
+
 	memset(repo, 0, sizeof(*repo));
 
 	initialize_repository(repo);
@@ -297,21 +294,13 @@ int repo_init(struct repository *repo,
 	if (repo_init_gitdir(repo, gitdir))
 		goto error;
 
-	if (read_and_verify_repository_format(&format, repo->commondir))
+	if (read_repository_format_from_commondir(&format, repo->commondir))
 		goto error;
 
-	repo_set_hash_algo(repo, format.hash_algo);
-	repo_set_compat_hash_algo(repo, format.compat_hash_algo);
-	repo_set_ref_storage_format(repo, format.ref_storage_format,
-				    format.ref_storage_payload);
-	repo->repository_format_worktree_config = format.worktree_config;
-	repo->repository_format_relative_worktrees = format.relative_worktrees;
-	repo->repository_format_precious_objects = format.precious_objects;
-	repo->repository_format_submodule_path_cfg = format.submodule_path_cfg;
-
-	/* take ownership of format.partial_clone */
-	repo->repository_format_partial_clone = format.partial_clone;
-	format.partial_clone = NULL;
+	if (apply_repository_format(repo, &format, &err) < 0) {
+		warning("%s", err.buf);
+		goto error;
+	}
 
 	if (worktree)
 		repo_set_worktree(repo, worktree);
@@ -320,10 +309,12 @@ int repo_init(struct repository *repo,
 		repo_read_loose_object_map(repo);
 
 	clear_repository_format(&format);
+	strbuf_release(&err);
 	return 0;
 
 error:
 	clear_repository_format(&format);
+	strbuf_release(&err);
 	repo_clear(repo);
 	return -1;
 }
diff --git a/setup.c b/setup.c
index 252b443117..c5015923f1 100644
--- a/setup.c
+++ b/setup.c
@@ -750,8 +750,7 @@ static int check_repo_format(const char *var, const char *value,
 	return read_worktree_config(var, value, ctx, vdata);
 }
 
-static int check_repository_format_gently(struct repository *repo,
-					  const char *gitdir,
+static int check_repository_format_gently(const char *gitdir,
 					  struct repository_format *candidate,
 					  int *nongit_ok)
 {
@@ -765,7 +764,7 @@ static int check_repository_format_gently(struct repository *repo,
 	strbuf_release(&sb);
 
 	/*
-	 * For historical use of check_repository_format() in git-init,
+	 * For historical use of check_and_apply_repository_format() in git-init,
 	 * we treat a missing config as a silent "ok", even when nongit_ok
 	 * is unset.
 	 */
@@ -782,8 +781,6 @@ static int check_repository_format_gently(struct repository *repo,
 		die("%s", err.buf);
 	}
 
-	repo->repository_format_precious_objects = candidate->precious_objects;
-
 	string_list_clear(&candidate->unknown_extensions, 0);
 	string_list_clear(&candidate->v1_only_extensions, 0);
 
@@ -1140,7 +1137,7 @@ static const char *setup_explicit_git_dir(struct repository *repo,
 		die(_("not a git repository: '%s'"), gitdirenv);
 	}
 
-	if (check_repository_format_gently(repo, gitdirenv, repo_fmt, nongit_ok)) {
+	if (check_repository_format_gently(gitdirenv, repo_fmt, nongit_ok)) {
 		free(gitfile);
 		return NULL;
 	}
@@ -1217,7 +1214,7 @@ static const char *setup_discovered_git_dir(struct repository *repo,
 					    struct repository_format *repo_fmt,
 					    int *nongit_ok)
 {
-	if (check_repository_format_gently(repo, gitdir, repo_fmt, nongit_ok))
+	if (check_repository_format_gently(gitdir, repo_fmt, nongit_ok))
 		return NULL;
 
 	/* --work-tree is set without --git-dir; use discovered one */
@@ -1265,7 +1262,7 @@ static const char *setup_bare_git_dir(struct repository *repo,
 {
 	int root_len;
 
-	if (check_repository_format_gently(repo, ".", repo_fmt, nongit_ok))
+	if (check_repository_format_gently(".", repo_fmt, nongit_ok))
 		return NULL;
 
 	setenv(GIT_IMPLICIT_WORK_TREE_ENVIRONMENT, "0", 1);
@@ -1757,6 +1754,32 @@ enum discovery_result discover_git_directory_reason(struct strbuf *commondir,
 	return result;
 }
 
+int apply_repository_format(struct repository *repo,
+			    const struct repository_format *format,
+			    struct strbuf *err)
+{
+	if (verify_repository_format(format, err) < 0)
+		return -1;
+
+	repo_set_hash_algo(repo, format->hash_algo);
+	repo_set_compat_hash_algo(repo, format->compat_hash_algo);
+	repo_set_ref_storage_format(repo,
+				    format->ref_storage_format,
+				    format->ref_storage_payload);
+	repo->repository_format_worktree_config =
+		format->worktree_config;
+	repo->repository_format_submodule_path_cfg =
+		format->submodule_path_cfg;
+	repo->repository_format_relative_worktrees =
+		format->relative_worktrees;
+	repo->repository_format_partial_clone =
+		xstrdup_or_null(format->partial_clone);
+	repo->repository_format_precious_objects =
+		format->precious_objects;
+
+	return 0;
+}
+
 /*
  * Check the repository format version in the path found in repo_get_git_dir(repo),
  * and die if it is a version we don't understand. Generally one would
@@ -1765,26 +1788,20 @@ enum discovery_result discover_git_directory_reason(struct strbuf *commondir,
  *
  * If successful and fmt is not NULL, fill fmt with data.
  */
-static void check_repository_format(struct repository *repo, struct repository_format *fmt)
+static void check_and_apply_repository_format(struct repository *repo,
+					      struct repository_format *fmt)
 {
 	struct repository_format repo_fmt = REPOSITORY_FORMAT_INIT;
+	struct strbuf err = STRBUF_INIT;
+
 	if (!fmt)
 		fmt = &repo_fmt;
-	check_repository_format_gently(repo, repo_get_git_dir(repo), fmt, NULL);
+
+	check_repository_format_gently(repo_get_git_dir(repo), fmt, NULL);
+	if (apply_repository_format(repo, fmt, &err) < 0)
+		die("%s", err.buf);
 	startup_info->have_repository = 1;
-	repo_set_hash_algo(repo, fmt->hash_algo);
-	repo_set_compat_hash_algo(repo, fmt->compat_hash_algo);
-	repo_set_ref_storage_format(repo,
-				    fmt->ref_storage_format,
-				    fmt->ref_storage_payload);
-	repo->repository_format_worktree_config =
-		fmt->worktree_config;
-	repo->repository_format_submodule_path_cfg =
-		fmt->submodule_path_cfg;
-	repo->repository_format_relative_worktrees =
-		fmt->relative_worktrees;
-	repo->repository_format_partial_clone =
-		xstrdup_or_null(fmt->partial_clone);
+
 	clear_repository_format(&repo_fmt);
 }
 
@@ -1862,7 +1879,7 @@ const char *enter_repo(struct repository *repo, const char *path, unsigned flags
 
 	if (is_git_directory(".")) {
 		set_git_dir(repo, ".", 0);
-		check_repository_format(repo, NULL);
+		check_and_apply_repository_format(repo, NULL);
 		return path;
 	}
 
@@ -2020,25 +2037,15 @@ const char *setup_git_directory_gently(struct repository *repo, int *nongit_ok)
 				gitdir = DEFAULT_GIT_DIR_ENVIRONMENT;
 			setup_git_env_internal(repo, gitdir, false);
 		}
+
 		if (startup_info->have_repository) {
-			repo_set_hash_algo(repo, repo_fmt.hash_algo);
-			repo_set_compat_hash_algo(repo,
-						  repo_fmt.compat_hash_algo);
-			repo_set_ref_storage_format(repo,
-						    repo_fmt.ref_storage_format,
-						    repo_fmt.ref_storage_payload);
-			repo->repository_format_worktree_config =
-				repo_fmt.worktree_config;
-			repo->repository_format_relative_worktrees =
-				repo_fmt.relative_worktrees;
-			repo->repository_format_submodule_path_cfg =
-				repo_fmt.submodule_path_cfg;
-			/* take ownership of repo_fmt.partial_clone */
-			repo->repository_format_partial_clone =
-				repo_fmt.partial_clone;
-			repo_fmt.partial_clone = NULL;
-			repo->repository_format_precious_objects =
-				repo_fmt.precious_objects;
+			struct strbuf err = STRBUF_INIT;
+
+			if (apply_repository_format(repo, &repo_fmt, &err) < 0)
+				die("%s", err.buf);
+
+			clear_repository_format(&repo_fmt);
+			strbuf_release(&err);
 		}
 	}
 	/*
@@ -2814,7 +2821,7 @@ int init_db(struct repository *repo,
 	 * config file, so this will not fail.  What we are catching
 	 * is an attempt to reinitialize new repository with an old tool.
 	 */
-	check_repository_format(repo, &repo_fmt);
+	check_and_apply_repository_format(repo, &repo_fmt);
 
 	repository_format_configure(repo, &repo_fmt, hash, ref_storage_format);
 
diff --git a/setup.h b/setup.h
index 9409326fe4..efbb82fdbf 100644
--- a/setup.h
+++ b/setup.h
@@ -221,6 +221,16 @@ void clear_repository_format(struct repository_format *format);
 int verify_repository_format(const struct repository_format *format,
 			     struct strbuf *err);
 
+/*
+ * Apply the given repository format to the repo. This initializes extensions
+ * and basic data structures required for normal operation. Returns 0 on
+ * success, a negative error code when the format is not valid as determined by
+ * `verify_repository_format()`.
+ */
+int apply_repository_format(struct repository *repo,
+			    const struct repository_format *format,
+			    struct strbuf *err);
+
 const char *get_template_dir(const char *option_template);
 
 #define INIT_DB_QUIET      (1 << 0)

-- 
2.54.0.1064.gd145956f57.dirty

