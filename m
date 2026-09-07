Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D8943BDB4
	for <git@vger.kernel.org>; Mon,  7 Sep 2026 08:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788769553; cv=none; b=CF+T4n19wIJbHEgQcUirYkCG468txU9UAAkY7Za80F6XIGmz5iZOBVCK/jwwTKWhQYkFQWTaW2N3ClV39QkmG9f0eIuvZk18Gj+aeKD5r0WhBwlUa0EieAFj+LXQmwWZwJQUdVh+Nd8IK8VsEQvEkmL9E/UkOzSGzN1zCUlroYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788769553; c=relaxed/simple;
	bh=fnIcn9xNAgVohwbvzYW7dtQeWtsWO3SHduk06bdS5HE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pqvmt7kbBz2frzhmfNvy1fIKsfyfQLUGU7o0NGx3JSMGPsDG1s9p05IlXeAgrLmlhe+CMBfoepziHnY/UkRW+tyhrOPPE2wPLAiIRjGfI4srEXcx7XL1KprdEZfbwPFiBC15lu2IQzPgyCwrfZZM7yC8m8PUtS8Ly4onXFwhi30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=n547X7/I; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MkLcxiX2; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="n547X7/I";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MkLcxiX2"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1F3ED1400210;
	Mon,  7 Sep 2026 04:25:51 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 07 Sep 2026 04:25:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1788769551;
	 x=1788855951; bh=345Yzcu1dl0idWcL6fRX0e1V5v8w9n3e1PDHU3puzlk=; b=
	n547X7/IY269WLxJ05qAXiIP/kAquaUEc/6NBuiEg+Wqtyu4tCbwa8usqFW3lMTw
	NEZlO5j9JPSPj291AudwF1IIbshj5CLQjxer5QiPQQsDcS8WaoVapLgcMh6xel9/
	NW1qi8vrmRFQodT4pxMnPxDaefzjjou5lXlolNK92On2Htv4n8DCThrjbHb4epMF
	Ny0aq8tibxffY6tLQ7Bxw5hXmmTJ9EbEF0d3jtb4CIg3C1ET8yNS3gAxpq3EmSqx
	Fo7TBlNGLiJdBuM7BGEaUTelVBCBJbMugdgzbxlIN0v/ZJSbnzXCA4RClPkcBMm6
	G5ad8kkoBq8EJ7RsFDKfpQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788769551; x=
	1788855951; bh=345Yzcu1dl0idWcL6fRX0e1V5v8w9n3e1PDHU3puzlk=; b=M
	kLcxiX2rrNLzwYlA2n1d6CkO/3dbWwckewJ3NIPv8VzRsQiWyZ94IYoP9atKXx81
	PY9CZFy/SHHVM2BFLzKYuzPMMd2bgKoU1N4T8tM8Q7tRNGPc6sNN41pzjL33vbqN
	/CYIcRffOxQnagxqr2xjvYzqTBnpOVr/RWuDwoz5bUq9skfh1bWThl4rcHz2XtT7
	68g6ZKucxVU4npzjYQ48IuSIHHWrh7ieD2MxlXvu+kzeB0WXQImRm/tzUrVzvmGW
	WvtocWmK9KFLbsH3TfeefZ+UOVQ1vzbxZ3qakDMRB8/+YEdm0s4exl8NtJq59n0R
	RqoVstYeecLGLar7DNPlA==
X-ME-Sender: <xms:D3Weas-m4N1AtDzJvvEtNMkbdMzUxaC2eJuZLcsDCjCHGq6031deIQ>
    <xme:D3WearvAh_qQY9gkvGkHV3PVNfMkHqY9x890jE8A-RqNP4ZJFYPaV2yhdGKzEKhww
    g77yHurkno2_ggaajlQPt-Q21GuHVLBNVFH5-Sth6Pg5nwdFQY4Ig>
X-ME-Received: <xmr:D3WeanAfQ-eGNrnXadzDIFFurvJxqsZ8Nzu7BLP4BwWYKD4Th2n77A>
X-ME-Proxy-Cause: dmFkZTFyLnsnXJs777FxsqcHvlzsV4urKyexW3K0A8vOJAOpgvOc5x5wNV4lt+eIqFqGzl
    8eYKtuoNlkVgnNv7hhczE9YTTY8alxBLhhMhaOVxF56CvA8MajbHzByNeaNbgZhKoQ83X+
    kjdUZ26eZD7TYJAMfdiA7fOK/MJXPy6/tKVB7bc10vvxuQEX/JY07OcGV4T4akvwWw02v6
    0h7HUid6hlebYTHq8zGUk91cgHbiDyLqAYAn5s7gtO6upjjSgB28oiJEbkELaS3X3XYC3q
    FXDNx12rxyDpcBPASmj4RYqLexG5z2LibBtD7BQ7+XIABMrkBSfZP1jUp0D7ex5HjpgPOX
    8WLLoP8QxxvbV56NVAfZfMZXT2y5VRt1xPaJFpEiPIZbCPeOCsSB2w128pdBlGsqZ2vVUO
    ree13fBPsipmL92iuJXGgOEKa6sdz/TvlPdnpkGjtmRuDt+tkaWASTMow6iGyGVpwIskFe
    7z6L/zJYVlTwsWRwxK6fXa40mecBJudMIyHvlfvbnwE/oNPHulTnTRLs27+h5VqByjejnu
    9/F7CEC2l6r9VUJrIoWV5qoQvF4zhnqaiih0/o8TuQJl5SIz+FKE6O1Y6khNPjv9mjcA1s
    7zDYqAEbE0ZXLhuxl71p2iI2qjYaeZNh1xGBRfsJkpdvc/eM88Mqnc2i7eOg
X-ME-Proxy: <xmx:D3WearUQM7pc6vaWmnzy3-Exfyog7RvqVeBwJAcUUI_qOMLGOMETXg>
    <xmx:D3WeatDw3TJb5D-mLSm6Ny0N4oFo6frpUjeBRAx8G7LFruRz89EUNw>
    <xmx:D3Weam-2ML2b3S4NxltgniVjUfpIoStoGd02KNzx0blgHJmkZpTUPA>
    <xmx:D3WeasF65EkAusP1QvwgoJK3s56_oSVDjuUj0Nt59z2tfwyR1n6v9A>
    <xmx:D3WeajCX0xNb6o7Dute8viNPcuV1-_ml8zQ9S6d1kKEL9BJfJoi_wOoL>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Sep 2026 04:25:50 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e2b2e1ef (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 7 Sep 2026 08:25:49 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 07 Sep 2026 10:25:38 +0200
Subject: [PATCH v3 1/9] setup: split up concerns of `init_db()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260907-pks-odb-write-alternates-at-creation-time-v3-1-735d0b5b3e00@pks.im>
References: <20260907-pks-odb-write-alternates-at-creation-time-v3-0-735d0b5b3e00@pks.im>
In-Reply-To: <20260907-pks-odb-write-alternates-at-creation-time-v3-0-735d0b5b3e00@pks.im>
To: git@vger.kernel.org
Cc: Toon Claes <toon@iotcl.com>, Junio C Hamano <gitster@pobox.com>, 
 Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.15.2

The function `init_db()` is responsible for creating the on-disk
directory structure required for a Git repository. It is used by both
git-init(1) and git-clone(1), and because their expected behaviour is
different we support a couple of flags:

  - The `QUIET` flag controls whether the command is quiet or not. For
    git-init(1) this is user-controllable, whereas for git-clone(1)
    we're always quiet.

  - The `EXIST_OK` flag controls whether a preexisting repository is
    okay or not. For git-init(1) it is, for git-clone(1) it's not.

  - The `SKIP_REFDB` flag controls whether the reference database should
    already be created or not. For git-init(1) we do, but for
    git-clone(1) we don't because it does not yet know about the default
    branch and about the remote object hash.

Furthermore, we're about to add another divergence in behaviour, where
we have to also skip creation of the object database in git-clone(1).
This is becoming quite cumbersome though.

Instead of introducing another flag, start to split up concerns of the
function so that we never create the reference or object database. This
becomes the responsibility of the caller, which is thus free to defer
their creation to a later point in time. This lets us get rid of most of
the divergent behaviour:

  - We don't need the `SKIP_REFDB` and a potential `SKIP_ODB` flags
    anymore.

  - We don't need the `QUIET` flag anymore, as nothing prints output
    except for the final status message that tells the user that the
    repository has been (re)initialized. But as this message is specific
    to git-init(1), we can easily move it there.

The only piece of information we still have to convey is whether or not
reinitialization of a preexisting repository is okay. This is handled by
a new `reinit_ok` pointer that, if non-`NULL`, indicates that it is okay
to reinitialize the repository. Furthermore, the pointer will be written
to to indicate whether the repository was reinitialized or not, which we
need in git-init(1) to print the correct initialization message.

With these refactorings, `init_db()` is named quite misleadingly though,
as we don't create any of the reference or object databases anymore.
Rename it to `create_repository()`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/clone.c   |  9 +++++----
 builtin/init-db.c | 32 ++++++++++++++++++++++++--------
 setup.c           | 54 +++++++++++++++++-------------------------------------
 setup.h           | 22 ++++++++++------------
 4 files changed, 56 insertions(+), 61 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 5b25cca510..904d2d859f 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -1185,10 +1185,10 @@ int cmd_clone(int argc,
 	 * repository, and reference backends may persist that information into
 	 * their on-disk data structures.
 	 */
-	init_db(the_repository, git_dir, real_git_dir, work_tree, option_template,
-		GIT_HASH_UNKNOWN, ref_storage_format, NULL,
-		do_not_override_repo_unix_permissions,
-		INIT_DB_QUIET | INIT_DB_SKIP_REFDB);
+	create_repository(the_repository, git_dir, real_git_dir, work_tree,
+			  option_template, GIT_HASH_UNKNOWN, ref_storage_format,
+			  do_not_override_repo_unix_permissions, NULL);
+	create_object_database(the_repository);
 
 	if (real_git_dir) {
 		free((char *)git_dir);
@@ -1445,6 +1445,7 @@ int cmd_clone(int argc,
 	initialize_repository_version(the_repository, hash_algo, the_repository->ref_storage_format, 1);
 	repo_set_hash_algo(the_repository, hash_algo);
 	create_reference_database(the_repository, NULL, 1);
+	startup_info->have_repository = 1;
 
 	/*
 	 * Before fetching from the remote, download and install bundle
diff --git a/builtin/init-db.c b/builtin/init-db.c
index e96b1283b7..f2c7e3be6d 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -80,7 +80,7 @@ int cmd_init_db(int argc,
 	char *work_tree = NULL;
 	const char *template_dir = NULL;
 	char *template_dir_to_free = NULL;
-	unsigned int flags = 0;
+	int quiet = 0;
 	int bare = startup_info->force_bare_repository ? 1 : -1;
 	const char *object_format = NULL;
 	const char *ref_format = NULL;
@@ -102,7 +102,7 @@ int cmd_init_db(int argc,
 			.flags = PARSE_OPT_OPTARG | PARSE_OPT_NONEG,
 			.callback = shared_callback
 		},
-		OPT_BIT('q', "quiet", &flags, N_("be quiet"), INIT_DB_QUIET),
+		OPT_BOOL('q', "quiet", &quiet, N_("be quiet")),
 		OPT_STRING(0, "separate-git-dir", &real_git_dir, N_("gitdir"),
 			   N_("separate git dir from working tree")),
 		OPT_STRING('b', "initial-branch", &initial_branch, N_("name"),
@@ -113,7 +113,7 @@ int cmd_init_db(int argc,
 			   N_("specify the reference format to use")),
 		OPT_END()
 	};
-	int ret;
+	int reinit;
 
 	argc = parse_options(argc, argv, prefix, init_db_options, init_db_usage, 0);
 
@@ -247,14 +247,30 @@ int cmd_init_db(int argc,
 		die(_("--separate-git-dir incompatible with bare repository"));
 	}
 
-	flags |= INIT_DB_EXIST_OK;
-	ret = init_db(the_repository, git_dir, real_git_dir, work_tree,
-		      template_dir, hash_algo, ref_storage_format, initial_branch,
-		      init_shared_repository, flags);
+	create_repository(the_repository, git_dir, real_git_dir, work_tree,
+			  template_dir, hash_algo, ref_storage_format,
+			  init_shared_repository, &reinit);
+	create_reference_database(the_repository, initial_branch, quiet);
+	create_object_database(the_repository);
+
+	if (!quiet) {
+		int len = strlen(git_dir);
+
+		if (reinit)
+			printf(repo_settings_get_shared_repository(the_repository)
+			       ? _("Reinitialized existing shared Git repository in %s%s\n")
+			       : _("Reinitialized existing Git repository in %s%s\n"),
+			       git_dir, len && git_dir[len-1] != '/' ? "/" : "");
+		else
+			printf(repo_settings_get_shared_repository(the_repository)
+			       ? _("Initialized empty shared Git repository in %s%s\n")
+			       : _("Initialized empty Git repository in %s%s\n"),
+			       git_dir, len && git_dir[len-1] != '/' ? "/" : "");
+	}
 
 	free(template_dir_to_free);
 	free(real_git_dir_to_free);
 	free(work_tree);
 	free(git_dir);
-	return ret;
+	return 0;
 }
diff --git a/setup.c b/setup.c
index d90654f584..8c7b97f92e 100644
--- a/setup.c
+++ b/setup.c
@@ -2647,7 +2647,7 @@ static int create_default_files(struct repository *repo,
 	return reinit;
 }
 
-static void create_object_database(struct repository *repo)
+void create_object_database(struct repository *repo)
 {
 	/*
 	 * Create the "objects" directory in the common directory. This is done
@@ -2822,17 +2822,17 @@ static void repository_format_configure(struct repository_format *repo_fmt,
 	}
 }
 
-int init_db(struct repository *repo,
-	    const char *git_dir,
-	    const char *real_git_dir,
-	    const char *worktree,
-	    const char *template_dir, int hash,
-	    enum ref_storage_format ref_storage_format,
-	    const char *initial_branch,
-	    int init_shared_repository, unsigned int flags)
+void create_repository(struct repository *repo,
+		       const char *git_dir,
+		       const char *real_git_dir,
+		       const char *worktree,
+		       const char *template_dir,
+		       int hash,
+		       enum ref_storage_format ref_storage_format,
+		       int init_shared_repository,
+		       int *reinit_ok)
 {
-	int reinit;
-	int exist_ok = flags & INIT_DB_EXIST_OK;
+	int reinit_ignored;
 	char *original_git_dir = real_pathdup(git_dir, 1);
 	struct repository_format repo_fmt = REPOSITORY_FORMAT_INIT;
 	struct strbuf err = STRBUF_INIT;
@@ -2840,10 +2840,10 @@ int init_db(struct repository *repo,
 	if (real_git_dir) {
 		struct stat st;
 
-		if (!exist_ok && !stat(git_dir, &st))
+		if (!reinit_ok && !stat(git_dir, &st))
 			die(_("%s already exists"), git_dir);
 
-		if (!exist_ok && !stat(real_git_dir, &st))
+		if (!reinit_ok && !stat(real_git_dir, &st))
 			die(_("%s already exists"), real_git_dir);
 
 		apply_and_export_relative_gitdir(repo, real_git_dir, 1);
@@ -2877,8 +2877,10 @@ int init_db(struct repository *repo,
 
 	safe_create_dir(repo, git_dir, 0);
 
-	reinit = create_default_files(repo, template_dir, original_git_dir,
-				      &repo_fmt, init_shared_repository);
+	if (!reinit_ok)
+		reinit_ok = &reinit_ignored;
+	*reinit_ok = create_default_files(repo, template_dir, original_git_dir,
+					  &repo_fmt, init_shared_repository);
 
 	if (repo_settings_get_shared_repository(repo)) {
 		char buf[10];
@@ -2901,29 +2903,7 @@ int init_db(struct repository *repo,
 		repo_config_set(repo, "receive.denyNonFastforwards", "true");
 	}
 
-	if (!(flags & INIT_DB_SKIP_REFDB))
-		create_reference_database(repo, initial_branch, flags & INIT_DB_QUIET);
-	create_object_database(repo);
-
-	startup_info->have_repository = 1;
-
-	if (!(flags & INIT_DB_QUIET)) {
-		int len = strlen(git_dir);
-
-		if (reinit)
-			printf(repo_settings_get_shared_repository(repo)
-			       ? _("Reinitialized existing shared Git repository in %s%s\n")
-			       : _("Reinitialized existing Git repository in %s%s\n"),
-			       git_dir, len && git_dir[len-1] != '/' ? "/" : "");
-		else
-			printf(repo_settings_get_shared_repository(repo)
-			       ? _("Initialized empty shared Git repository in %s%s\n")
-			       : _("Initialized empty Git repository in %s%s\n"),
-			       git_dir, len && git_dir[len-1] != '/' ? "/" : "");
-	}
-
 	clear_repository_format(&repo_fmt);
 	strbuf_release(&err);
 	free(original_git_dir);
-	return 0;
 }
diff --git a/setup.h b/setup.h
index 763fd384e8..c4aa464caa 100644
--- a/setup.h
+++ b/setup.h
@@ -256,23 +256,21 @@ int apply_repository_format(struct repository *repo,
 
 const char *get_template_dir(const char *option_template);
 
-#define INIT_DB_QUIET      (1 << 0)
-#define INIT_DB_EXIST_OK   (1 << 1)
-#define INIT_DB_SKIP_REFDB (1 << 2)
-
-int init_db(struct repository *repo,
-	    const char *git_dir,
-	    const char *real_git_dir,
-	    const char *worktree,
-	    const char *template_dir, int hash_algo,
-	    enum ref_storage_format ref_storage_format,
-	    const char *initial_branch, int init_shared_repository,
-	    unsigned int flags);
+void create_repository(struct repository *repo,
+		       const char *git_dir,
+		       const char *real_git_dir,
+		       const char *worktree,
+		       const char *template_dir,
+		       int hash_algo,
+		       enum ref_storage_format ref_storage_format,
+		       int init_shared_repository,
+		       int *reinit_ok);
 void initialize_repository_version(struct repository *repo,
 				   int hash_algo,
 				   enum ref_storage_format ref_storage_format,
 				   int reinit);
 void create_reference_database(struct repository *repo, const char *initial_branch, int quiet);
+void create_object_database(struct repository *repo);
 
 /*
  * NOTE NOTE NOTE!!

-- 
2.55.0.1007.g17ff1f9808.dirty

