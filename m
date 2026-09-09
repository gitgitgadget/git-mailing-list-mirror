Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7046334A79D
	for <git@vger.kernel.org>; Wed,  9 Sep 2026 05:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788932942; cv=none; b=OZO3P/fQ3OXWqmGjMww1NuCUTMkpRfAi1sT/LF7Gom/7Znxmx82+o3BcHkzO5TsMvvsVbIa5Zm+z5yFCQRHgv2GVXbrIsZVXP12bUKNZaE9V2Vh5aabf7zQAk+rssGJjYOxpbG5jfQn3BUW95G4nqVPnCiBZEEK4UDb/CaEDGjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788932942; c=relaxed/simple;
	bh=9ZRdbQWVMtzIRPtr+qEEasksfVO5B/rYChz3E3fQs1U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kVtNg149PnAAqQcFTs5UG/ThxpgWk7UAsKrnZ4BDXwvfJWXNsgzmhGzCte0vfPpZ0rjxZLF+EKxlteMFfUo2AW6Dg2Vg5liyzW88XSjjNxfoo7hqlFCGSo+6bcc1PsCX2pXRV18DrVlkilMcWO5q4t4suzgwFcmlOUpqifuqrhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=uEff1liG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oSSRh1lt; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="uEff1liG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oSSRh1lt"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A902C7A0121;
	Wed,  9 Sep 2026 01:48:58 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Wed, 09 Sep 2026 01:48:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1788932938;
	 x=1789019338; bh=DmKPKSQVa0LeSt8XJYSRcYB6E1DLIM8AQW3YZOhtwlc=; b=
	uEff1liGK7RPTDI2NgJRikdawAtHgjvNEmnfF/gXZf2DUJs+lT7OBn6jtmvlgv/w
	32lEn6aMFRak5QFrkW5NuCves6akTazdmjblJgHxUpRmnW+viZQZ51POcugxS0Sf
	NbBpmi5GWwoEM8G1UOI5yxJABSd+5GPhX5NKcDnWdXaTlXbgDpkFJy5bC+jmlu3j
	uUNsUZAjEXuO708XCOFw+qPuJ6ItCoJ2cAyObLJcq+BKbsMpC7/gxswff4rM0KvR
	8bknh95K+I/Cboluq8mQWG3W7kNrdCqqDlERtn83QhdLTdzSuDXfUwyf7NwPV25h
	kfDBWJBWCVJZDtjoQxYu6A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788932938; x=
	1789019338; bh=DmKPKSQVa0LeSt8XJYSRcYB6E1DLIM8AQW3YZOhtwlc=; b=o
	SSRh1ltJsxG0dSoXEsJ2APQNHXdPVV/5GF1TQxkolLw01pEFh8KTK2BqSJH4m0Nc
	ofhkuKCJl4WoPWoUYHhXjOZn82r9v2ONMqensIuIAb7lhbbguLFxA67mMXpE3ir6
	ulU8Fk3lY/kp1KzNNuFigRa/6L4G0e9VOfBXvOpSkVhL5HdkG/fJjJUt5xabPTlb
	8sw1Umn5Cw12iSW7MzHghDon7ugHZxYq0MtReC6sAHpGCS8wpCZ+jZbyjMp0c4VB
	ZnyLyE3iwBMzKEOqdB/Fbh99aTtFOqVoNtKfD3cL05RopT6+fDAxY/lszimcXgbo
	DBCKgH4IozOEci5KwwRJA==
X-ME-Sender: <xms:SvOgat1ckzQAKey6KSGmkV0b3K47hdpFK65F5tMakjblpQYmsmH51g>
    <xme:SvOgarHYF20CRO9OwRvCNvwYwTV2LwNaUlWAOi7OYt7sY8YgDp2kbiqwBg8flf-tl
    bzvM51DtnxUiGEKBau8EBx2hYT6BzDPoYjWehY_kf3dHCEnKUykhpc>
X-ME-Received: <xmr:SvOgai5X7I5Sei3rvSdIwwsK696Cw1h5qLp0ob-JGipw1GoPrDlpwijYlHrHJUSPWQIGMQ>
X-ME-Proxy-Cause: dmFkZTFXt+ytk4rlkNiuM5WrB42V+I4qeJ8jlsI0QV4Yv6YD6470gWTmbybr0T3TZ1Vr0c
    DNilgtxSLWygTPt9KmuWKyE7paPRRcCeOqJEV75x4jbTNhvk9p0eixXhmCcfYzzjqjoi0X
    xA83xZND48Rl6qoTT403R/Oc0x+DzxuRSR5+9K97jl7veaucM2r37NdRYP1E9yUc+LKF4h
    I41BFtzpc6Te9Fa7VyPhuxgLf2F2nCa9P8PlU5Y7wjchKQ14SuUwLrTp1VaF02fnZcY4Nt
    lzo7vLYDJoTGwCYR6ObBKaD8OsHvfkM+yl4rGb7S14qHAAQeSEwmSvQvLaDz/HiXOuZAeb
    7a7PQNBlKRNWWPqSD71itTGrRXO7+1a8zmcuQdPMTryGqhHke+MwgsMM8FI38W7C0Lu0JD
    /JYwPM/rHWu5iLGRAU/iZ8TF6s2EXjpRm4IjKNP7qYBZVT625//dxNLDf0i77pKFTGbSJs
    6AnlmX4aA3mXcMOHyMyP8icdJhINYa/NKB4BUz99QIHDt0HGrq2zweuV03McOFENXFPjSH
    N64jIqsehgc6f1QQXIxAF9rLIzmJf20NrbPbPtXLcyrFlXGY62yijwYEnyalY33cHUt8Oj
    VXk8zmjaOKGM1lIyoOP73Z//v/491JuQPVTW7912HgzWud0l1jH/tq5dK6dg
X-ME-Proxy: <xmx:SvOgapuAfEyNhegikqKzmfyO9RDnUnfe3QxGG42u1GGfg9DJM6TIYQ>
    <xmx:SvOgar45sxIsR6aB43JoSFz6N_fGuzO1RXJ8ejAb5wwu0iVqzHaIug>
    <xmx:SvOgasWX7klwZNUNRH6qUbqdLvSq6ELuwJchZ55T8_1K1Doq-1m6Xw>
    <xmx:SvOgal-weB7gDI73hDsMXIusFT0E1156tnrssMHuYkz13wMo2l2ybw>
    <xmx:SvOgag5EsD1tVSN90118miSMTvwaCL7VjQkRCpj7dmJD-f5GudSdVRqs>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Sep 2026 01:48:57 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a531afd0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 9 Sep 2026 05:48:56 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 09 Sep 2026 07:48:43 +0200
Subject: [PATCH v4 1/9] setup: split up concerns of `init_db()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260909-pks-odb-write-alternates-at-creation-time-v4-1-d8a78ffc32e4@pks.im>
References: <20260909-pks-odb-write-alternates-at-creation-time-v4-0-d8a78ffc32e4@pks.im>
In-Reply-To: <20260909-pks-odb-write-alternates-at-creation-time-v4-0-d8a78ffc32e4@pks.im>
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

