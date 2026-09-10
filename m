Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B743E3166
	for <git@vger.kernel.org>; Thu, 10 Sep 2026 15:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789052972; cv=none; b=XBp4HZFhdeejrrcyX78QJD0rNrQHpVmeI5poMUZCQ26fdvPwc3G5exe1bYEc4lF1fmEFqB/jJKoEpKL4gCy/ILd0zXkrkPgeNurSMAitop3F2poFXTAFiqLAn/gdSr2SsShcS3YcphfpKC5j1HfQlPu4zwzWfDzyCy5zqod2kqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789052972; c=relaxed/simple;
	bh=9ZRdbQWVMtzIRPtr+qEEasksfVO5B/rYChz3E3fQs1U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IU8fa7DoN9+qEfr56s/ljRPdA9bZz6Mw5MF10bn9e3k5WnR/hLC/M3mDe0zF4fJCLA6AMHNIrAONd7XRdGc6r/+lvnC7VSPVLkRi9xrvqgGlD7BOPSvQ5LsMPcJIG+r0V8j90JhbtjqNVIEaN030YjINd57neqBGbgdZ1L8evQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=aO57byp7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XvkXWwoO; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="aO57byp7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XvkXWwoO"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8612D14000C4;
	Thu, 10 Sep 2026 11:09:20 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 10 Sep 2026 11:09:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1789052960;
	 x=1789139360; bh=DmKPKSQVa0LeSt8XJYSRcYB6E1DLIM8AQW3YZOhtwlc=; b=
	aO57byp7Eh0VdvyAqFK8ZK+5DqkBcewmZdmwHulZApjjsOYwlPoaTeCPJvhpcIXk
	eVJgyZeBLIloDgBgbnrTzc97yhO+f2QxcI/YQni6b/59t0KN5Xe9QDiqoAQAUrZU
	g0p1sS6N1pPiG86ikk06DlRMQPGsKymMCTWXFwPk2XvH5SKV/3cTGJJrYKq9Xebm
	go+Tdi6wsZQiOkbSjsQrvQuo0CIC7g0HDnb1u6/THVQd7mX0uVK0JzlaC6mRihfK
	CBECXKy5frbJPH7eFqedJCFClbo2LgFAmtxD0A+wv4KLlntmFyWqqVcJCUdDiG9N
	oM4w5RTgtueHDGU5csSU6w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1789052960; x=
	1789139360; bh=DmKPKSQVa0LeSt8XJYSRcYB6E1DLIM8AQW3YZOhtwlc=; b=X
	vkXWwoOFBmcFq9/5b2BkAxmX3q3JFJ1ZuiD3dIjoqaoVbdz7mneZFaQEqfrK5v2h
	OYcw8FgNIXMCXmr0IQfgoDEQj/G/MxiuUooA1xOH6qPdvT+qsIIcyQGlPV3HHj9v
	TyEM1Sg9g3+b9Xw2HrC+W+vnFtpS0X6TESi5lLgq2F2M9HKSBolQujEcfMz4zuQu
	Oe2X/gvjfuNDrHeEFD1/om4bfIVbl1JxghzoJSn37h+u1VNQ9JxUJV3MLXASbqUR
	DeKgadacjdXlz7zgirsKpCdfTUMRfPtUaMSk18ndE3cB99gRTDRI63eM195B2YNt
	WqmSVlDQCSqRu3OsQeHBQ==
X-ME-Sender: <xms:IMiiauZ_WysOnExG01u7HWJZ0O6oqkw45XpZjBmMeWemTXxy2oP4GQ>
    <xme:IMiiaoT_EiILAEcxfo1ZTvsHSR0MKxHKZahrwSyG1jYK46WvA7pQOY0-ETCixcMoF
    4ptcL2vMdHH944ivL8dY4_3nEoPBFlsjjn8hx9LDiRIF8AE9aUsmA0>
X-ME-Received: <xmr:IMiiahT2aTwGTtq9lNlZJ1_dKSuZFoUTtTNMVL-NLkOBS6OByvwE-A>
X-ME-Proxy-Cause: dmFkZTFjMmORKiXYV5v4c7NqnDJufwejPDJi1cfPFm3mx0u8apQc0AvUhXFmyzPKLwg8qv
    gQxPujDla2ha2YRE4ueBGSHTp2xHkvls64y8wjIVNLvc9l/sEDZfcXZap63aj3KkvUT9tA
    H2U0ckPWE/epx57Ag4Ss/N1/kA7as8GrJQMRCubUFIbNx/x2/MBs1looTD1hAugKQeEImK
    WDDPtry92G1OoHWjevAppdv0F7IFYLEnNTxCW6tl/avjrRnkRSojpVwSaHdeKJpTM5NZO5
    tVPOhv3o3xBm0EQ9pB/dAdKzLgiyjpPlwQRjb18DWYa10wiyqKzjezMdYFE0HJJO4z6vib
    4aCF+Ym1RRdFHCMeBex09JveKBIU2vP35BAveWvmxcH8B6rto7p9CjKKlKvd6S2yn2kpn9
    pqUfCvlByEzmH15a6uVW9Ev0ANidGJONAEKNXFEo5IS3x17jlwnvKt7bbMKpHb2vaLhMYm
    B4L8vV0BIE7oX83PCGV+g0yfs7SV4EyJVPPwt0vAXpDsf61jeVM78HigWwX3y6C/x21YkT
    BCzsGPIX2vjbDD+7kuDiAc2Cv5xfNK6Av0X5qqb4PJEZ837rEpwbh7EX90Jn/1M7LtW+H5
    6mohu5x8nC0VX5tB7BjE8EvtFASWs+U9excklBw2iwkzcYqnQYKjuoDV708w
X-ME-Proxy: <xmx:IMiiasToRKRomRl9mEU4YO_aLQ6-E1mOQCwAdjR2Jmvpdf3CFLmUaw>
    <xmx:IMiiam7wPJwZzy1ZT003qobNsnJnHJzoUpN4V2cP8g3jPwEMyqbDYQ>
    <xmx:IMiiao2MWVMMbtN5mZJ5qDvO2ozvgFHUT2cBUGJvkadnSMBre_LvGA>
    <xmx:IMiiahDOnB_V54ZDY3Ktb6BNpLAP0CVj1JNMndtlU70GC3Z5p2E5JQ>
    <xmx:IMiians2BiyRmWPcwathhfOekpOXyv-0WzZI3pzrrrVJJh3hDWQm3PRV>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Sep 2026 11:09:19 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 606fb115 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 10 Sep 2026 15:09:18 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 10 Sep 2026 17:09:11 +0200
Subject: [PATCH v5 1/9] setup: split up concerns of `init_db()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260910-pks-odb-write-alternates-at-creation-time-v5-1-8d10c4238edc@pks.im>
References: <20260910-pks-odb-write-alternates-at-creation-time-v5-0-8d10c4238edc@pks.im>
In-Reply-To: <20260910-pks-odb-write-alternates-at-creation-time-v5-0-8d10c4238edc@pks.im>
To: git@vger.kernel.org
Cc: Toon Claes <toon@iotcl.com>, Junio C Hamano <gitster@pobox.com>, 
 Justin Tobler <jltobler@gmail.com>, Karthik Nayak <karthik.188@gmail.com>
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
 setup.h           | 45 +++++++++++++++++++++++++++++++++------------
 4 files changed, 79 insertions(+), 61 deletions(-)

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
index 763fd384e8..f1c1ed65fb 100644
--- a/setup.h
+++ b/setup.h
@@ -256,24 +256,45 @@ int apply_repository_format(struct repository *repo,
 
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
+/*
+ * Create the repository by creating the necessary directory structures,
+ * setting up the configuration and configuring the repository's format. If
+ * `template_dir` is set, copy over templates from that directory. Furthermore,
+ * if and only if `reinit_ok` is a non-NULL pointer, then the function may
+ * reinitialize a preexisting repository. In that case, the pointer will be set
+ * to `1` in case the repo was reinitialized and `0` if it didn't exist yet.
+ *
+ * Note that this function does not create the reference and object databases.
+ */
+void create_repository(struct repository *repo,
+		       const char *git_dir,
+		       const char *real_git_dir,
+		       const char *worktree,
+		       const char *template_dir,
+		       int hash_algo,
+		       enum ref_storage_format ref_storage_format,
+		       int init_shared_repository,
+		       int *reinit_ok);
+
 void initialize_repository_version(struct repository *repo,
 				   int hash_algo,
 				   enum ref_storage_format ref_storage_format,
 				   int reinit);
+
+/*
+ * Create the reference database for the repository. The repository and its ref
+ * storage format must have already been configured properly before calling
+ * this function. When set, `initial_branch` overrides the default branch that
+ * HEAD will point to.
+ */
 void create_reference_database(struct repository *repo, const char *initial_branch, int quiet);
 
+/*
+ * Create the object database for the repository. The repository must have
+ * already been configured properly before calling this function.
+ */
+void create_object_database(struct repository *repo);
+
 /*
  * NOTE NOTE NOTE!!
  *

-- 
2.55.0.1074.ge7621b4bad.dirty

