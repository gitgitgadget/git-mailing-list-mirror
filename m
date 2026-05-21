Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAEF839EB73
	for <git@vger.kernel.org>; Thu, 21 May 2026 07:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779349367; cv=none; b=JhHgkH0WRHaoDwf4WHKQiTm2fZhSGSH9t3slz+uAxPaIbV4iEo0P+HiI/8qpfX8QCqZtDbgut1KsF7eY2QNOW3EfTnaQn85iu9m6LovFJ6TuaHgCI0NgBbpO2AxdUGIJNQ5a+vId6ry9jZ9OMeNQ6FrPvgZEgTCLlI35KNhVIsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779349367; c=relaxed/simple;
	bh=G6Fj2vvN24IXZN04+pZePR2R+ojaxdNre97SR5rkwQQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Lw3I0SQ/A/GHoclN5evnwbqLy+zjpkPJVa6ijHBD7FoJ03ckrwWgIVevqwJxO3KRPCh96kYsthcROf1KWwG/LkVYKZGkS7bUt+QKLcDCxI+y/t8oyrIJOExVM7IuBc0tJHl2QNNWholjCufrOvJe+syGnv4ybzh2UV9Y3ixGbpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=N52c5J0P; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GUEykLlz; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="N52c5J0P";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GUEykLlz"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id ED4241400070
	for <git@vger.kernel.org>; Thu, 21 May 2026 03:42:44 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 21 May 2026 03:42:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1779349364;
	 x=1779435764; bh=m6QtGbKpmeifbne1ATPWDzIvnA6POwCZR4E9kUSNZ20=; b=
	N52c5J0PKPl2C9QMMXZZjDubJ4ryZACE5RRcATgCXqCzR+2+KxBP/HFbBgWvElMu
	e7QwczAf0r8F5iBQRTCHQcsE4CLPR/GmTQud+LZy1rcyUHR/xhU5NPJvfLwseAIV
	l/ViS8ScCxs3NvqhsYbhc6Q6faRU8jyaJJ1MYUXs1CqpDqLabyzdmIJ9uMshW08C
	JQQ1+SYvgMX29p34cIenYAKM3iyYXtj3/wi+ihVfWdopoyIOjuC06qiqo9rvm2q8
	/w8HyRdy51o8TkQwMTj5UchbijVsGVl+hq7YsLjm0J7FcfycgGxRoyrLJ2J5tZL7
	luwFKJYieH+YqrGKT7N5mQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779349364; x=
	1779435764; bh=m6QtGbKpmeifbne1ATPWDzIvnA6POwCZR4E9kUSNZ20=; b=G
	UEykLlzM2vf8iqTIoju9I35VcSFKfvalmvIqJ0Vsb7vFLk4lBcuClsWV5J+4KJ2a
	6z7f0c6Z9ah/AF7Hc5R2uETXh0y2WzeFMhZ4BiIBu9GJQyZ0pWIvRS3AdW/2LlgK
	x9E0mkYN2kcfW6jwGRbS2g3pcMKz58SJLwn23tFkC4hSwxVUIyBcAMlQdQ8saEcW
	V0i10vdN1N3pHWj1Uc5DAKxdvut/rE0fIhbdXRj5FEUynRVS9e0I7K4nZtOdnQnP
	XNuw2ydmmsgRB5BZZ3nM6cy57zaV0S2wbKBxvmpD+jra0bdWe4lVsobZp26rPQhj
	MMbAolABWex5WHDKyVocQ==
X-ME-Sender: <xms:dLcOagHhDN1T27HMVHuyLPUvh0q7qCA_xY5EBz813qMGop7giX80Cg>
    <xme:dLcOagTILqI5e_a83L0Gk_E1iYnpVKVMVYDTeWYFflNk04Z0uQqEboU5C7DY5YSQM
    mPK2xySlEWTFOhtq0q5EKdI7AycdpwkddCQz5ImJEFcxOf1edrFHQ>
X-ME-Received: <xmr:dLcOavwscW2BbPxZy1_4Kw0Dxp7EHyAJNWt4DjMlcKEjB8ySiGNmgi1aalsd1Nzc_WCvJbMWZ_MYqCUW64Bt6zTgv2Is5DC2NX11R07Lmr8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeeileegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepudenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:dLcOanMQYLBE7zM_461xQsFZYC8JoxeZ8iui_esBl01mqWRbdK7dSA>
    <xmx:dLcOamNI1-yiVeK3yPVhaMytEAn5ybi1hQUNajnahpeLnf0ox_rPjA>
    <xmx:dLcOahSxoZlvWplECt5T1PG1ttBjUb4UHX54qTB1439uavanyhEXzg>
    <xmx:dLcOagBnX1S0C01AEvX2ZnSvIeqy0Q2mAih-1y7XKT-xkoDlg7EIhQ>
    <xmx:dLcOaqVilX4Iae41JZk6NjUsAan-BfAdIey40czb6Rge2z4eYZ_Qc0K8>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 21 May 2026 03:42:44 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 33c29f90 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 21 May 2026 07:42:43 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 21 May 2026 09:42:30 +0200
Subject: [PATCH 3/8] setup: deduplicate logic to apply repository format
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260521-b4-pks-setup-centralize-odb-creation-v1-3-f130d2a7e8ae@pks.im>
References: <20260521-b4-pks-setup-centralize-odb-creation-v1-0-f130d2a7e8ae@pks.im>
In-Reply-To: <20260521-b4-pks-setup-centralize-odb-creation-v1-0-f130d2a7e8ae@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

After having discovered the repository format we then apply it to the
repository so that it knows to use the proper repository extensions. The
logic to apply the format is duplicated across three callsites, which
makes it rather painfull to add new extensions.

Introduce a new function `apply_repository_format()` that takes a repo
and applies a given format to it and adapt all callsites to use it.
While at it, rename `check_repository_format()` to clarify that it
doesn't only _check_ the format, but that it also applies it.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 repository.c | 31 +++++++-------------
 setup.c      | 93 ++++++++++++++++++++++++++++++++----------------------------
 setup.h      |  9 ++++++
 3 files changed, 70 insertions(+), 63 deletions(-)

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
index 9409326fe4..5ed92f53fa 100644
--- a/setup.h
+++ b/setup.h
@@ -221,6 +221,15 @@ void clear_repository_format(struct repository_format *format);
 int verify_repository_format(const struct repository_format *format,
 			     struct strbuf *err);
 
+/*
+ * Apply the given repository format to the repo. This initializes extensions
+ * and basic data structures required for normal operation. Returns 0 on
+ * success, a negative error code otherwise.
+ */
+int apply_repository_format(struct repository *repo,
+			    const struct repository_format *format,
+			    struct strbuf *err);
+
 const char *get_template_dir(const char *option_template);
 
 #define INIT_DB_QUIET      (1 << 0)

-- 
2.54.0.771.g3ed373ac14.dirty

