Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6571D5CD1
	for <git@vger.kernel.org>; Mon, 30 Mar 2026 13:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774876670; cv=none; b=FniebQnG0PYzBI88qzztRQLtOdMPVEmMFWIp90qq0TAZGLt7LWD5P5r4ohb0bjGn8MUe95wET+ZHqyitENoW8xWNEG/PLUHMQ1Bbx8/3cE8Q0lKdygVlbBT8Q//5C5FJxgCHls44bftBHBG5+Y2Zn22TqZuvxf2O6KxoZ6bN3TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774876670; c=relaxed/simple;
	bh=s3Ffq0gK5hIF06P6WlTgL1v2P8zwJg+Uz+mUpIWDh1k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N1339S1HTqqLXp2Ie93TDWipoXMEd37eOtNcQWa23KUEF2o5YzbojCMhlR8aGZgyiP2sOGtmEPXgULJf1QC+HkuEcdxkRf24hs1bb2Nj1+M+SkOlKzu58DXoPjPUPLPqXd3BLUVEdlt+Oc8DDwyj0L5yUli1OnwhygI4hWBrlU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=V5dc4vbB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=B8Z9z9Zv; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="V5dc4vbB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="B8Z9z9Zv"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id ECC9B7A00B6
	for <git@vger.kernel.org>; Mon, 30 Mar 2026 09:17:47 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 30 Mar 2026 09:17:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1774876667;
	 x=1774963067; bh=mUp+W5fBFGMGx6d4PUEWHOA7PlOqPTmSlKNbpcDk9ak=; b=
	V5dc4vbBcTarZUCEnOHgFuwzxsOqhZRfFU1xMdxBmjXSzCCBdTQKRtzw1RWZavYr
	55uvljU5ONZwp36ASCxtQYuvVDC+aJ9kDmmg8CsKpcttznq9WNO1GqVjekA2HCqy
	D+aFP2ZMtMttN2p+Ai3YEwkbXuqxfiQ2NyM5ASy0T/AROcjZzUqTmBV0ieCpCX7M
	Qd0q4PN1V8PlGZ0UBRJdAaLSzC5uapUWxiailPOoIRvPIKNzyCWq7h57g1Iqe7yn
	PUHsWfYWI/fgJKSF03mZ1JuyLnQtMaDLqS0a9CTnVJYK5UrJPgi6Y7uux0jFgPW+
	ptY5oLUMxFNq0NUo+sMTqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774876667; x=
	1774963067; bh=mUp+W5fBFGMGx6d4PUEWHOA7PlOqPTmSlKNbpcDk9ak=; b=B
	8Z9z9ZvdXqNy6Xcc/8c0/T2lSU7d1FaHldeHTZGN6VFUljIPjyEF3YNf2o/WoeO9
	LftTtGzw/eZaqjEYfS89ZxKeDw7cM2lRDcVL6kg2grvqJ7IAw5y4c/PnH/Ho31mb
	R1HwDEitaP05YKLJXyUkPicj8KAZWZLEPUfvUj2fNqBNV6ZWeaNV1sNOXoiG/QI8
	pWPThcl4gcPvxAwR62TBsCgsqr1yxzkGCaCmHKSFYlGAt3xpwBoewFJ3PkrmpKHO
	Vr9GYTM4DFeGxfsyXQySGSNPl98Fan7z69k5wMwj1bVfF5osLECke+Ku4J30WPmy
	m0X8AHhB6l97H/U9E4M5A==
X-ME-Sender: <xms:-3fKabEO-cJg9FtCWyIDYgkKgrN3o694sjFzo6jbm4Z-betuJOqcQg>
    <xme:-3fKafRbCneIe3rZSB-R0Q0LYwgfO6KaNRFAdC0u4F2ifO69dqm0oR0I59SvBkAAa
    0ArBJzH6Dtc4o3rx4zjj4-nME5O5rpJCee-Fhx9z4FtVjUVREx0bKs>
X-ME-Received: <xmr:-3fKaSzKGNdyCPsKbhdnutHF_wRzyTj3ThguK7M9LUHLqgEsW3illa8IdoJRuLesq-8UEkPSoGrNq98iAYmgf8FrV4hb_ac_vU89C6EyR4vUOw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeffeeltdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:-3fKaeMdN8wStbNEOnPpimyazMaSUr3SrfyIX91GjobgFXkUigCi-A>
    <xmx:-3fKaROhuoAIApFk5M7pFNmnZ-xV_-sVd6dVhFXpxRQr390VObixgg>
    <xmx:-3fKaQSUXDW7WxhsIml-wz1s-ggnP9THBkAxGdMqstvrOoG_6mFIww>
    <xmx:-3fKaTCnFeBmDDyCqDWdhaEMcdZE5A6vJ-h__11n57YILG82n0Wc5Q>
    <xmx:-3fKaRWsClW0u7Y5fMxdcEtEoomus7EYB5SXMFx2t5A5-RbI-hIWtXL7>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 30 Mar 2026 09:17:47 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9f547591 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 30 Mar 2026 13:17:46 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 30 Mar 2026 15:17:23 +0200
Subject: [PATCH 01/18] setup: replace use of `the_repository` in static
 functions
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260330-pks-setup-wo-the-repository-v1-1-0d2e822837aa@pks.im>
References: <20260330-pks-setup-wo-the-repository-v1-0-0d2e822837aa@pks.im>
In-Reply-To: <20260330-pks-setup-wo-the-repository-v1-0-0d2e822837aa@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.0

Replace the use of `the_repository` in "setup.c" for all static
functions. For now, we simply add `the_repository` to invocations of
these functions. This will be addressed in subsequent commits, where
we'll move up `the_repository` one more layer to callers of "setup.c".

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 setup.c | 188 ++++++++++++++++++++++++++++++++++------------------------------
 1 file changed, 100 insertions(+), 88 deletions(-)

diff --git a/setup.c b/setup.c
index 7ec4427368..ba2898473a 100644
--- a/setup.c
+++ b/setup.c
@@ -50,13 +50,13 @@ const char *tmp_original_cwd;
  * /dir/repolink/file     (repolink points to /dir/repo) -> file
  * /dir/repo              (exactly equal to work tree)   -> (empty string)
  */
-static int abspath_part_inside_repo(char *path)
+static int abspath_part_inside_repo(struct repository *repo, char *path)
 {
 	size_t len;
 	size_t wtlen;
 	char *path0;
 	int off;
-	const char *work_tree = precompose_string_if_needed(repo_get_work_tree(the_repository));
+	const char *work_tree = precompose_string_if_needed(repo_get_work_tree(repo));
 	struct strbuf realpath = STRBUF_INIT;
 
 	if (!work_tree)
@@ -132,7 +132,7 @@ char *prefix_path_gently(const char *prefix, int len,
 			free(sanitized);
 			return NULL;
 		}
-		if (abspath_part_inside_repo(sanitized)) {
+		if (abspath_part_inside_repo(the_repository, sanitized)) {
 			free(sanitized);
 			return NULL;
 		}
@@ -509,7 +509,7 @@ void setup_work_tree(void)
 	initialized = 1;
 }
 
-static void setup_original_cwd(void)
+static void setup_original_cwd(struct repository *repo)
 {
 	struct strbuf tmp = STRBUF_INIT;
 	const char *worktree = NULL;
@@ -535,9 +535,9 @@ static void setup_original_cwd(void)
 
 	/* Normalize the directory */
 	if (!strbuf_realpath(&tmp, tmp_original_cwd, 0)) {
-		trace2_data_string("setup", the_repository,
+		trace2_data_string("setup", repo,
 				   "realpath-path", tmp_original_cwd);
-		trace2_data_string("setup", the_repository,
+		trace2_data_string("setup", repo,
 				   "realpath-failure", strerror(errno));
 		free((char*)tmp_original_cwd);
 		tmp_original_cwd = NULL;
@@ -552,7 +552,7 @@ static void setup_original_cwd(void)
 	 * Get our worktree; we only protect the current working directory
 	 * if it's in the worktree.
 	 */
-	worktree = repo_get_work_tree(the_repository);
+	worktree = repo_get_work_tree(repo);
 	if (!worktree)
 		goto no_prevention_needed;
 
@@ -747,7 +747,10 @@ static int check_repo_format(const char *var, const char *value,
 	return read_worktree_config(var, value, ctx, vdata);
 }
 
-static int check_repository_format_gently(const char *gitdir, struct repository_format *candidate, int *nongit_ok)
+static int check_repository_format_gently(struct repository *repo,
+					  const char *gitdir,
+					  struct repository_format *candidate,
+					  int *nongit_ok)
 {
 	struct strbuf sb = STRBUF_INIT;
 	struct strbuf err = STRBUF_INIT;
@@ -776,7 +779,7 @@ static int check_repository_format_gently(const char *gitdir, struct repository_
 		die("%s", err.buf);
 	}
 
-	the_repository->repository_format_precious_objects = candidate->precious_objects;
+	repo->repository_format_precious_objects = candidate->precious_objects;
 
 	string_list_clear(&candidate->unknown_extensions, 0);
 	string_list_clear(&candidate->v1_only_extensions, 0);
@@ -1034,7 +1037,8 @@ const char *read_gitfile_gently(const char *path, int *return_error_code)
 	return error_code ? NULL : path;
 }
 
-static void setup_git_env_internal(const char *git_dir,
+static void setup_git_env_internal(struct repository *repo,
+				   const char *git_dir,
 				   bool skip_initializing_odb)
 {
 	char *git_replace_ref_base;
@@ -1052,7 +1056,7 @@ static void setup_git_env_internal(const char *git_dir,
 		args.disable_ref_updates = true;
 	args.skip_initializing_odb = skip_initializing_odb;
 
-	repo_set_gitdir(the_repository, git_dir, &args);
+	repo_set_gitdir(repo, git_dir, &args);
 	strvec_clear(&to_free);
 
 	if (getenv(NO_REPLACE_OBJECTS_ENVIRONMENT))
@@ -1064,7 +1068,7 @@ static void setup_git_env_internal(const char *git_dir,
 
 	shallow_file = getenv(GIT_SHALLOW_FILE_ENVIRONMENT);
 	if (shallow_file)
-		set_alternate_shallow_file(the_repository, shallow_file, 0);
+		set_alternate_shallow_file(repo, shallow_file, 0);
 
 	if (git_env_bool(NO_LAZY_FETCH_ENVIRONMENT, 0))
 		fetch_if_missing = 0;
@@ -1072,30 +1076,31 @@ static void setup_git_env_internal(const char *git_dir,
 
 void setup_git_env(const char *git_dir)
 {
-	setup_git_env_internal(git_dir, false);
+	setup_git_env_internal(the_repository, git_dir, false);
 }
 
-static void set_git_dir_1(const char *path, bool skip_initializing_odb)
+static void set_git_dir_1(struct repository *repo, const char *path, bool skip_initializing_odb)
 {
 	xsetenv(GIT_DIR_ENVIRONMENT, path, 1);
-	setup_git_env_internal(path, skip_initializing_odb);
+	setup_git_env_internal(repo, path, skip_initializing_odb);
 }
 
 static void update_relative_gitdir(const char *name UNUSED,
 				   const char *old_cwd,
 				   const char *new_cwd,
-				   void *data UNUSED)
+				   void *data)
 {
+	struct repository *repo = data;
 	char *path = reparent_relative_path(old_cwd, new_cwd,
-					    repo_get_git_dir(the_repository));
+					    repo_get_git_dir(repo));
 	trace_printf_key(&trace_setup_key,
 			 "setup: move $GIT_DIR to '%s'",
 			 path);
-	set_git_dir_1(path, true);
+	set_git_dir_1(repo, path, true);
 	free(path);
 }
 
-static void set_git_dir(const char *path, int make_realpath)
+static void set_git_dir(struct repository *repo, const char *path, int make_realpath)
 {
 	struct strbuf realpath = STRBUF_INIT;
 
@@ -1104,14 +1109,15 @@ static void set_git_dir(const char *path, int make_realpath)
 		path = realpath.buf;
 	}
 
-	set_git_dir_1(path, false);
+	set_git_dir_1(repo, path, false);
 	if (!is_absolute_path(path))
-		chdir_notify_register(NULL, update_relative_gitdir, NULL);
+		chdir_notify_register(NULL, update_relative_gitdir, repo);
 
 	strbuf_release(&realpath);
 }
 
-static const char *setup_explicit_git_dir(const char *gitdirenv,
+static const char *setup_explicit_git_dir(struct repository *repo,
+					  const char *gitdirenv,
 					  struct strbuf *cwd,
 					  struct repository_format *repo_fmt,
 					  int *nongit_ok)
@@ -1139,7 +1145,7 @@ static const char *setup_explicit_git_dir(const char *gitdirenv,
 		die(_("not a git repository: '%s'"), gitdirenv);
 	}
 
-	if (check_repository_format_gently(gitdirenv, repo_fmt, nongit_ok)) {
+	if (check_repository_format_gently(repo, gitdirenv, repo_fmt, nongit_ok)) {
 		free(gitfile);
 		return NULL;
 	}
@@ -1155,7 +1161,7 @@ static const char *setup_explicit_git_dir(const char *gitdirenv,
 		}
 
 		/* #18, #26 */
-		set_git_dir(gitdirenv, 0);
+		set_git_dir(repo, gitdirenv, 0);
 		free(gitfile);
 		return NULL;
 	}
@@ -1177,7 +1183,7 @@ static const char *setup_explicit_git_dir(const char *gitdirenv,
 	}
 	else if (!git_env_bool(GIT_IMPLICIT_WORK_TREE_ENVIRONMENT, 1)) {
 		/* #16d */
-		set_git_dir(gitdirenv, 0);
+		set_git_dir(repo, gitdirenv, 0);
 		free(gitfile);
 		return NULL;
 	}
@@ -1185,18 +1191,18 @@ static const char *setup_explicit_git_dir(const char *gitdirenv,
 		set_git_work_tree(".");
 
 	/* set_git_work_tree() must have been called by now */
-	worktree = repo_get_work_tree(the_repository);
+	worktree = repo_get_work_tree(repo);
 
 	/* both repo_get_work_tree() and cwd are already normalized */
 	if (!strcmp(cwd->buf, worktree)) { /* cwd == worktree */
-		set_git_dir(gitdirenv, 0);
+		set_git_dir(repo, gitdirenv, 0);
 		free(gitfile);
 		return NULL;
 	}
 
 	offset = dir_inside_of(cwd->buf, worktree);
 	if (offset >= 0) {	/* cwd inside worktree? */
-		set_git_dir(gitdirenv, 1);
+		set_git_dir(repo, gitdirenv, 1);
 		if (chdir(worktree))
 			die_errno(_("cannot chdir to '%s'"), worktree);
 		strbuf_addch(cwd, '/');
@@ -1205,17 +1211,18 @@ static const char *setup_explicit_git_dir(const char *gitdirenv,
 	}
 
 	/* cwd outside worktree */
-	set_git_dir(gitdirenv, 0);
+	set_git_dir(repo, gitdirenv, 0);
 	free(gitfile);
 	return NULL;
 }
 
-static const char *setup_discovered_git_dir(const char *gitdir,
+static const char *setup_discovered_git_dir(struct repository *repo,
+					    const char *gitdir,
 					    struct strbuf *cwd, int offset,
 					    struct repository_format *repo_fmt,
 					    int *nongit_ok)
 {
-	if (check_repository_format_gently(gitdir, repo_fmt, nongit_ok))
+	if (check_repository_format_gently(repo, gitdir, repo_fmt, nongit_ok))
 		return NULL;
 
 	/* --work-tree is set without --git-dir; use discovered one */
@@ -1227,14 +1234,14 @@ static const char *setup_discovered_git_dir(const char *gitdir,
 			gitdir = to_free = real_pathdup(gitdir, 1);
 		if (chdir(cwd->buf))
 			die_errno(_("cannot come back to cwd"));
-		ret = setup_explicit_git_dir(gitdir, cwd, repo_fmt, nongit_ok);
+		ret = setup_explicit_git_dir(repo, gitdir, cwd, repo_fmt, nongit_ok);
 		free(to_free);
 		return ret;
 	}
 
 	/* #16.2, #17.2, #20.2, #21.2, #24, #25, #28, #29 (see t1510) */
 	if (is_bare_repository_cfg > 0) {
-		set_git_dir(gitdir, (offset != cwd->len));
+		set_git_dir(repo, gitdir, (offset != cwd->len));
 		if (chdir(cwd->buf))
 			die_errno(_("cannot come back to cwd"));
 		return NULL;
@@ -1243,7 +1250,7 @@ static const char *setup_discovered_git_dir(const char *gitdir,
 	/* #0, #1, #5, #8, #9, #12, #13 */
 	set_git_work_tree(".");
 	if (strcmp(gitdir, DEFAULT_GIT_DIR_ENVIRONMENT))
-		set_git_dir(gitdir, 0);
+		set_git_dir(repo, gitdir, 0);
 	inside_git_dir = 0;
 	inside_work_tree = 1;
 	if (offset >= cwd->len)
@@ -1258,13 +1265,14 @@ static const char *setup_discovered_git_dir(const char *gitdir,
 }
 
 /* #16.1, #17.1, #20.1, #21.1, #22.1 (see t1510) */
-static const char *setup_bare_git_dir(struct strbuf *cwd, int offset,
+static const char *setup_bare_git_dir(struct repository *repo,
+				      struct strbuf *cwd, int offset,
 				      struct repository_format *repo_fmt,
 				      int *nongit_ok)
 {
 	int root_len;
 
-	if (check_repository_format_gently(".", repo_fmt, nongit_ok))
+	if (check_repository_format_gently(repo, ".", repo_fmt, nongit_ok))
 		return NULL;
 
 	setenv(GIT_IMPLICIT_WORK_TREE_ENVIRONMENT, "0", 1);
@@ -1276,7 +1284,7 @@ static const char *setup_bare_git_dir(struct strbuf *cwd, int offset,
 		gitdir = offset == cwd->len ? "." : xmemdupz(cwd->buf, offset);
 		if (chdir(cwd->buf))
 			die_errno(_("cannot come back to cwd"));
-		return setup_explicit_git_dir(gitdir, cwd, repo_fmt, nongit_ok);
+		return setup_explicit_git_dir(repo, gitdir, cwd, repo_fmt, nongit_ok);
 	}
 
 	inside_git_dir = 1;
@@ -1286,10 +1294,10 @@ static const char *setup_bare_git_dir(struct strbuf *cwd, int offset,
 			die_errno(_("cannot come back to cwd"));
 		root_len = offset_1st_component(cwd->buf);
 		strbuf_setlen(cwd, offset > root_len ? offset : root_len);
-		set_git_dir(cwd->buf, 0);
+		set_git_dir(repo, cwd->buf, 0);
 	}
 	else
-		set_git_dir(".", 0);
+		set_git_dir(repo, ".", 0);
 	return NULL;
 }
 
@@ -1827,7 +1835,7 @@ const char *enter_repo(const char *path, unsigned flags)
 	}
 
 	if (is_git_directory(".")) {
-		set_git_dir(".", 0);
+		set_git_dir(the_repository, ".", 0);
 		check_repository_format(NULL);
 		return path;
 	}
@@ -1891,18 +1899,18 @@ const char *setup_git_directory_gently(int *nongit_ok)
 
 	switch (setup_git_directory_gently_1(&dir, &gitdir, &report, 1)) {
 	case GIT_DIR_EXPLICIT:
-		prefix = setup_explicit_git_dir(gitdir.buf, &cwd, &repo_fmt, nongit_ok);
+		prefix = setup_explicit_git_dir(the_repository, gitdir.buf, &cwd, &repo_fmt, nongit_ok);
 		break;
 	case GIT_DIR_DISCOVERED:
 		if (dir.len < cwd.len && chdir(dir.buf))
 			die(_("cannot change to '%s'"), dir.buf);
-		prefix = setup_discovered_git_dir(gitdir.buf, &cwd, dir.len,
+		prefix = setup_discovered_git_dir(the_repository, gitdir.buf, &cwd, dir.len,
 						  &repo_fmt, nongit_ok);
 		break;
 	case GIT_DIR_BARE:
 		if (dir.len < cwd.len && chdir(dir.buf))
 			die(_("cannot change to '%s'"), dir.buf);
-		prefix = setup_bare_git_dir(&cwd, dir.len, &repo_fmt, nongit_ok);
+		prefix = setup_bare_git_dir(the_repository, &cwd, dir.len, &repo_fmt, nongit_ok);
 		break;
 	case GIT_DIR_HIT_CEILING:
 		if (!nongit_ok)
@@ -2044,7 +2052,7 @@ const char *setup_git_directory_gently(int *nongit_ok)
 		free(payload);
 	}
 
-	setup_original_cwd();
+	setup_original_cwd(the_repository);
 
 	strbuf_release(&dir);
 	strbuf_release(&gitdir);
@@ -2110,7 +2118,7 @@ void check_repository_format(struct repository_format *fmt)
 	struct repository_format repo_fmt = REPOSITORY_FORMAT_INIT;
 	if (!fmt)
 		fmt = &repo_fmt;
-	check_repository_format_gently(repo_get_git_dir(the_repository), fmt, NULL);
+	check_repository_format_gently(the_repository, repo_get_git_dir(the_repository), fmt, NULL);
 	startup_info->have_repository = 1;
 	repo_set_hash_algo(the_repository, fmt->hash_algo);
 	repo_set_compat_hash_algo(the_repository, fmt->compat_hash_algo);
@@ -2239,7 +2247,9 @@ const char *get_template_dir(const char *option_template)
 
 #define GIT_DEFAULT_HASH_ENVIRONMENT "GIT_DEFAULT_HASH"
 
-static void copy_templates_1(struct strbuf *path, struct strbuf *template_path,
+static void copy_templates_1(struct repository *repo,
+			     struct strbuf *path,
+			     struct strbuf *template_path,
 			     DIR *dir)
 {
 	size_t path_baselen = path->len;
@@ -2253,7 +2263,7 @@ static void copy_templates_1(struct strbuf *path, struct strbuf *template_path,
 	 * with the way the namespace under .git/ is organized, should
 	 * be really carefully chosen.
 	 */
-	safe_create_dir(the_repository, path->buf, 1);
+	safe_create_dir(repo, path->buf, 1);
 	while ((de = readdir(dir)) != NULL) {
 		struct stat st_git, st_template;
 		int exists = 0;
@@ -2281,7 +2291,7 @@ static void copy_templates_1(struct strbuf *path, struct strbuf *template_path,
 				die_errno(_("cannot opendir '%s'"), template_path->buf);
 			strbuf_addch(path, '/');
 			strbuf_addch(template_path, '/');
-			copy_templates_1(path, template_path, subdir);
+			copy_templates_1(repo, path, template_path, subdir);
 			closedir(subdir);
 		}
 		else if (exists)
@@ -2306,7 +2316,7 @@ static void copy_templates_1(struct strbuf *path, struct strbuf *template_path,
 	}
 }
 
-static void copy_templates(const char *option_template)
+static void copy_templates(struct repository *repo, const char *option_template)
 {
 	const char *template_dir = get_template_dir(option_template);
 	struct strbuf path = STRBUF_INIT;
@@ -2347,9 +2357,9 @@ static void copy_templates(const char *option_template)
 		goto close_free_return;
 	}
 
-	strbuf_addstr(&path, repo_get_common_dir(the_repository));
+	strbuf_addstr(&path, repo_get_common_dir(repo));
 	strbuf_complete(&path, '/');
-	copy_templates_1(&path, &template_path, dir);
+	copy_templates_1(repo, &path, &template_path, dir);
 close_free_return:
 	closedir(dir);
 free_return:
@@ -2443,13 +2453,13 @@ void initialize_repository_version(int hash_algo,
 	strbuf_release(&repo_version);
 }
 
-static int is_reinit(void)
+static int is_reinit(struct repository *repo)
 {
 	struct strbuf buf = STRBUF_INIT;
 	char junk[2];
 	int ret;
 
-	repo_git_path_replace(the_repository, &buf, "HEAD");
+	repo_git_path_replace(repo, &buf, "HEAD");
 	ret = !access(buf.buf, R_OK) || readlink(buf.buf, junk, sizeof(junk) - 1) != -1;
 	strbuf_release(&buf);
 	return ret;
@@ -2459,7 +2469,7 @@ void create_reference_database(const char *initial_branch, int quiet)
 {
 	struct strbuf err = STRBUF_INIT;
 	char *to_free = NULL;
-	int reinit = is_reinit();
+	int reinit = is_reinit(the_repository);
 
 	if (ref_store_create_on_disk(get_main_ref_store(the_repository), 0, &err))
 		die("failed to set up refs db: %s", err.buf);
@@ -2493,7 +2503,8 @@ void create_reference_database(const char *initial_branch, int quiet)
 	free(to_free);
 }
 
-static int create_default_files(const char *template_path,
+static int create_default_files(struct repository *repo,
+				const char *template_path,
 				const char *original_git_dir,
 				const struct repository_format *fmt,
 				int init_shared_repository)
@@ -2502,7 +2513,7 @@ static int create_default_files(const char *template_path,
 	struct strbuf path = STRBUF_INIT;
 	int reinit;
 	int filemode;
-	const char *work_tree = repo_get_work_tree(the_repository);
+	const char *work_tree = repo_get_work_tree(repo);
 
 	/*
 	 * First copy the templates -- we might have the default
@@ -2513,19 +2524,19 @@ static int create_default_files(const char *template_path,
 	 * values (since we've just potentially changed what's available on
 	 * disk).
 	 */
-	copy_templates(template_path);
-	repo_config_clear(the_repository);
-	repo_settings_reset_shared_repository(the_repository);
-	repo_config(the_repository, git_default_config, NULL);
+	copy_templates(repo, template_path);
+	repo_config_clear(repo);
+	repo_settings_reset_shared_repository(repo);
+	repo_config(repo, git_default_config, NULL);
 
-	reinit = is_reinit();
+	reinit = is_reinit(repo);
 
 	/*
 	 * We must make sure command-line options continue to override any
 	 * values we might have just re-read from the config.
 	 */
 	if (init_shared_repository != -1)
-		repo_settings_set_shared_repository(the_repository,
+		repo_settings_set_shared_repository(repo,
 						    init_shared_repository);
 
 	is_bare_repository_cfg = !work_tree;
@@ -2534,14 +2545,14 @@ static int create_default_files(const char *template_path,
 	 * We would have created the above under user's umask -- under
 	 * shared-repository settings, we would need to fix them up.
 	 */
-	if (repo_settings_get_shared_repository(the_repository)) {
-		adjust_shared_perm(the_repository, repo_get_git_dir(the_repository));
+	if (repo_settings_get_shared_repository(repo)) {
+		adjust_shared_perm(repo, repo_get_git_dir(repo));
 	}
 
 	initialize_repository_version(fmt->hash_algo, fmt->ref_storage_format, reinit);
 
 	/* Check filemode trustability */
-	repo_git_path_replace(the_repository, &path, "config");
+	repo_git_path_replace(repo, &path, "config");
 	filemode = TEST_FILEMODE;
 	if (TEST_FILEMODE && !lstat(path.buf, &st1)) {
 		struct stat st2;
@@ -2552,22 +2563,22 @@ static int create_default_files(const char *template_path,
 		if (filemode && !reinit && (st1.st_mode & S_IXUSR))
 			filemode = 0;
 	}
-	repo_config_set(the_repository, "core.filemode", filemode ? "true" : "false");
+	repo_config_set(repo, "core.filemode", filemode ? "true" : "false");
 
 	if (is_bare_repository())
-		repo_config_set(the_repository, "core.bare", "true");
+		repo_config_set(repo, "core.bare", "true");
 	else {
-		repo_config_set(the_repository, "core.bare", "false");
+		repo_config_set(repo, "core.bare", "false");
 		/* allow template config file to override the default */
-		if (repo_settings_get_log_all_ref_updates(the_repository) == LOG_REFS_UNSET)
-			repo_config_set(the_repository, "core.logallrefupdates", "true");
+		if (repo_settings_get_log_all_ref_updates(repo) == LOG_REFS_UNSET)
+			repo_config_set(repo, "core.logallrefupdates", "true");
 		if (needs_work_tree_config(original_git_dir, work_tree))
-			repo_config_set(the_repository, "core.worktree", work_tree);
+			repo_config_set(repo, "core.worktree", work_tree);
 	}
 
 	if (!reinit) {
 		/* Check if symlink is supported in the work tree */
-		repo_git_path_replace(the_repository, &path, "tXXXXXX");
+		repo_git_path_replace(repo, &path, "tXXXXXX");
 		if (!close(xmkstemp(path.buf)) &&
 		    !unlink(path.buf) &&
 		    !symlink("testing", path.buf) &&
@@ -2575,12 +2586,12 @@ static int create_default_files(const char *template_path,
 		    S_ISLNK(st1.st_mode))
 			unlink(path.buf); /* good */
 		else
-			repo_config_set(the_repository, "core.symlinks", "false");
+			repo_config_set(repo, "core.symlinks", "false");
 
 		/* Check if the filesystem is case-insensitive */
-		repo_git_path_replace(the_repository, &path, "CoNfIg");
+		repo_git_path_replace(repo, &path, "CoNfIg");
 		if (!access(path.buf, F_OK))
-			repo_config_set(the_repository, "core.ignorecase", "true");
+			repo_config_set(repo, "core.ignorecase", "true");
 		probe_utf8_pathname_composition();
 	}
 
@@ -2588,23 +2599,23 @@ static int create_default_files(const char *template_path,
 	return reinit;
 }
 
-static void create_object_directory(void)
+static void create_object_directory(struct repository *repo)
 {
 	struct strbuf path = STRBUF_INIT;
 	size_t baselen;
 
-	strbuf_addstr(&path, repo_get_object_directory(the_repository));
+	strbuf_addstr(&path, repo_get_object_directory(repo));
 	baselen = path.len;
 
-	safe_create_dir(the_repository, path.buf, 1);
+	safe_create_dir(repo, path.buf, 1);
 
 	strbuf_setlen(&path, baselen);
 	strbuf_addstr(&path, "/pack");
-	safe_create_dir(the_repository, path.buf, 1);
+	safe_create_dir(repo, path.buf, 1);
 
 	strbuf_setlen(&path, baselen);
 	strbuf_addstr(&path, "/info");
-	safe_create_dir(the_repository, path.buf, 1);
+	safe_create_dir(repo, path.buf, 1);
 
 	strbuf_release(&path);
 }
@@ -2682,7 +2693,8 @@ static int read_default_format_config(const char *key, const char *value,
 	return ret;
 }
 
-static void repository_format_configure(struct repository_format *repo_fmt,
+static void repository_format_configure(struct repository *repo,
+					struct repository_format *repo_fmt,
 					int hash, enum ref_storage_format ref_format)
 {
 	struct default_format_config cfg = {
@@ -2719,7 +2731,7 @@ static void repository_format_configure(struct repository_format *repo_fmt,
 	} else if (cfg.hash != GIT_HASH_UNKNOWN) {
 		repo_fmt->hash_algo = cfg.hash;
 	}
-	repo_set_hash_algo(the_repository, repo_fmt->hash_algo);
+	repo_set_hash_algo(repo, repo_fmt->hash_algo);
 
 	env = getenv("GIT_DEFAULT_REF_FORMAT");
 	if (repo_fmt->version >= 0 &&
@@ -2758,7 +2770,7 @@ static void repository_format_configure(struct repository_format *repo_fmt,
 		free(backend);
 	}
 
-	repo_set_ref_storage_format(the_repository, repo_fmt->ref_storage_format,
+	repo_set_ref_storage_format(repo, repo_fmt->ref_storage_format,
 				    repo_fmt->ref_storage_payload);
 }
 
@@ -2782,12 +2794,12 @@ int init_db(const char *git_dir, const char *real_git_dir,
 		if (!exist_ok && !stat(real_git_dir, &st))
 			die(_("%s already exists"), real_git_dir);
 
-		set_git_dir(real_git_dir, 1);
+		set_git_dir(the_repository, real_git_dir, 1);
 		git_dir = repo_get_git_dir(the_repository);
 		separate_git_dir(git_dir, original_git_dir);
 	}
 	else {
-		set_git_dir(git_dir, 1);
+		set_git_dir(the_repository, git_dir, 1);
 		git_dir = repo_get_git_dir(the_repository);
 	}
 	startup_info->have_repository = 1;
@@ -2800,7 +2812,7 @@ int init_db(const char *git_dir, const char *real_git_dir,
 	 */
 	check_repository_format(&repo_fmt);
 
-	repository_format_configure(&repo_fmt, hash, ref_storage_format);
+	repository_format_configure(the_repository, &repo_fmt, hash, ref_storage_format);
 
 	/*
 	 * Ensure `core.hidedotfiles` is processed. This must happen after we
@@ -2811,12 +2823,12 @@ int init_db(const char *git_dir, const char *real_git_dir,
 
 	safe_create_dir(the_repository, git_dir, 0);
 
-	reinit = create_default_files(template_dir, original_git_dir,
+	reinit = create_default_files(the_repository, template_dir, original_git_dir,
 				      &repo_fmt, init_shared_repository);
 
 	if (!(flags & INIT_DB_SKIP_REFDB))
 		create_reference_database(initial_branch, flags & INIT_DB_QUIET);
-	create_object_directory();
+	create_object_directory(the_repository);
 
 	if (repo_settings_get_shared_repository(the_repository)) {
 		char buf[10];

-- 
2.53.0.1185.g05d4b7b318.dirty

