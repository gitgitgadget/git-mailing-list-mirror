Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250EF1917ED
	for <git@vger.kernel.org>; Wed,  6 Nov 2024 20:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730926090; cv=none; b=Cg6cDePSP4M6Z7Wy51MBU8QqkZPdKfgTDPocd9q8+aULejr5157Qt0hejXm+nrpqbgb4gWQJmtA59LK5rIu/VuwJI8p3Iibr7pdFc5JwiDRIrRkPDAYx5TQj3+Y5h0jnQ/7YHA/AFgMqQJP9fseysQITL+cmbQLeNSnF2+kdoIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730926090; c=relaxed/simple;
	bh=K7+3Vaq14db8THXVsJqRJdtjQzGcNElNocKeAC4pYKY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=pev9LaHmH9co5XraQ0i8G8I76AXgknoBjKBpJud4RcZkE7w8oIzyrk6NZbWzxq1Q7g++12PoeTcb/Fj8r09cndumYM9mrr40G7LnX6RlGGUL6QkLq9nCX61JL7lv1vm4Y2xm9QDQ1dki/eX5cg7NjlLvVzPYS8ixH5VDgOMKaI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VbxPIE4n; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VbxPIE4n"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4314b316495so2226965e9.2
        for <git@vger.kernel.org>; Wed, 06 Nov 2024 12:48:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730926086; x=1731530886; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RdKVMcJhAsu/u1UxmXPdzxLQkgryIkz3wGQb+ZcJ+gM=;
        b=VbxPIE4nY5hNxHBnI50pyabJmEzkvRIz87C+mSHe4jLBIPmCm5YkrcaGqPEjb6+ANv
         0U+lXIVILCG3CzaMcSLgtJ/Ky6ZpGAOd6obS8lhW5eVi3Gf196AsRosXVi21q/ZVFyR2
         MDM96tlL+XhuF76kYDjXUP2Ai3I1CZzIUevYD94N70Ow3fgfelmXDpK3SAz2HcdzFEfF
         90xvLAf8HTyusgvMbUichnw5/rsc3yPHLyVJzURwRjFsD+qrGzscaQOx+0hjFi7cMadQ
         OVJRbGyb3N6mA+dc7qnLfZfY3kM/oXiucasH9GgV8bh+DxudX5XAW6nKmdtPuTdZp6GW
         GIqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730926086; x=1731530886;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RdKVMcJhAsu/u1UxmXPdzxLQkgryIkz3wGQb+ZcJ+gM=;
        b=v/oOpSG9ZnK/XvcOOtu3UjiaxjSAxCVJ1T7n3radp0Jr+Ek+KyyLkekWp/IREWVjBG
         4QB8I2ImkrYHCkA7BV9kvsioVsF+QghUQNeoi5Y92ExIpuh7jq4YjP5fneAKnIWrVUnq
         9DDlxN3QmJ8tfVtx2i1CHcAnUMUStBtO28EiLqDdbJKzGBB6ebfxg7UdeBaVJ0oeePFg
         TU0OnXIPQqp0ySQl0LktFAFfj16/y/aqWO41eWy0jhKy0sVInOEs6m8PeQ5ZUX6cw8kn
         xgwyLl38CWatK6A9GwEMHWIXF68UIjeJXAC7PFxzXeVWY1et1sj9BVV/Z+yqugiut+KB
         WB1g==
X-Gm-Message-State: AOJu0YyETwQuTBxEjCXuOlFT2/v7h9D+172Ftrb8mfb59rJ0C4kzXESD
	emQKXI+1cCRwq+JMcPqo31O+/Xfqq8x4e3raJPlAs+h1aU1iAjWVyvVytg==
X-Google-Smtp-Source: AGHT+IGpEJQVc9L7QG5PynDj33kWdjfVJAfzVs0uMGAJucrOf+VhrZh3C65QDbuR7+uadhQPHnG48w==
X-Received: by 2002:a05:6000:18ad:b0:381:d890:b554 with SMTP id ffacd0b85a97d-381d890b5c7mr11205694f8f.53.1730926085583;
        Wed, 06 Nov 2024 12:48:05 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c113dd7fsm20383112f8f.70.2024.11.06.12.48.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 12:48:04 -0800 (PST)
Message-Id: <3d341a9ae4ef1d2776734fa82a45913f91e6083c.1730926082.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1826.git.git.1730926082.gitgitgadget@gmail.com>
References: <pull.1826.git.git.1730926082.gitgitgadget@gmail.com>
From: "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 06 Nov 2024 20:48:00 +0000
Subject: [PATCH 1/3] git: remove is_bare_repository_cfg global variable
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: John Cai <johncai86@gmail.com>,
    John Cai <johncai86@gmail.com>

From: John Cai <johncai86@gmail.com>

The is_bare_repository_cfg global variable is used for storing a bare
repository setting, either through the config, an env var, or the
commandline. This variable is global, and hence introduces global state
everywhere it is used.

In order to reduce global state, add a member to the repository struct
to keep track of the setting there. For now, the_repository is what's
used to set the member, which still represents global state. However,
there is a parallel effort to replace calls to the_repository with a
repository struct that is passed into builtins, see [1]. Hence, this
change will help the overall effort in reducing global state.

1. 9b1cb5070f (builtin: add a repository parameter for builtin
   functions, Fri Sep 13 21:16:14 2024 +0000)

Signed-off-by: John Cai <johncai86@gmail.com>
---
 attr.c                        |  4 ++--
 builtin/bisect.c              |  2 +-
 builtin/blame.c               |  2 +-
 builtin/check-attr.c          |  2 +-
 builtin/clone.c               |  4 ++--
 builtin/gc.c                  |  2 +-
 builtin/init-db.c             | 14 +++++++-------
 builtin/repack.c              |  2 +-
 builtin/reset.c               |  2 +-
 builtin/rev-parse.c           |  2 +-
 builtin/submodule--helper.c   |  2 +-
 config.c                      |  2 +-
 dir.c                         |  2 +-
 environment.c                 |  7 -------
 environment.h                 |  3 +--
 git.c                         |  2 +-
 mailmap.c                     |  4 ++--
 refs/files-backend.c          |  2 +-
 refs/reftable-backend.c       |  2 +-
 repository.c                  | 21 +++++++++++++++++----
 repository.h                  | 12 +++++++++++-
 scalar.c                      |  2 +-
 setup.c                       | 12 ++++++------
 submodule.c                   |  2 +-
 t/helper/test-partial-clone.c |  2 +-
 t/helper/test-repository.c    |  4 ++--
 transport.c                   |  4 ++--
 worktree.c                    |  4 ++--
 28 files changed, 70 insertions(+), 55 deletions(-)

diff --git a/attr.c b/attr.c
index c605d2c1703..053cd59af26 100644
--- a/attr.c
+++ b/attr.c
@@ -716,7 +716,7 @@ static enum git_attr_direction direction;
 
 void git_attr_set_direction(enum git_attr_direction new_direction)
 {
-	if (is_bare_repository() && new_direction != GIT_ATTR_INDEX)
+	if (repo_is_bare(the_repository) && new_direction != GIT_ATTR_INDEX)
 		BUG("non-INDEX attr direction in a bare repo");
 
 	if (new_direction != direction)
@@ -883,7 +883,7 @@ static struct attr_stack *read_attr(struct index_state *istate,
 		res = read_attr_from_index(istate, path, flags);
 	} else if (tree_oid) {
 		res = read_attr_from_blob(istate, tree_oid, path, flags);
-	} else if (!is_bare_repository()) {
+	} else if (!repo_is_bare(the_repository)) {
 		if (direction == GIT_ATTR_CHECKOUT) {
 			res = read_attr_from_index(istate, path, flags);
 			if (!res)
diff --git a/builtin/bisect.c b/builtin/bisect.c
index 21d17a6c1a8..b794a84528f 100644
--- a/builtin/bisect.c
+++ b/builtin/bisect.c
@@ -705,7 +705,7 @@ static enum bisect_error bisect_start(struct bisect_terms *terms, int argc,
 	struct object_id oid;
 	const char *head;
 
-	if (is_bare_repository())
+	if (repo_is_bare(the_repository))
 		no_checkout = 1;
 
 	/*
diff --git a/builtin/blame.c b/builtin/blame.c
index e407a22da3b..5365c3d4594 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -1092,7 +1092,7 @@ parse_done:
 
 	revs.disable_stdin = 1;
 	setup_revisions(argc, argv, &revs, NULL);
-	if (!revs.pending.nr && is_bare_repository()) {
+	if (!revs.pending.nr && repo_is_bare(the_repository)) {
 		struct commit *head_commit;
 		struct object_id head_oid;
 
diff --git a/builtin/check-attr.c b/builtin/check-attr.c
index 7cf275b8937..37baf64f949 100644
--- a/builtin/check-attr.c
+++ b/builtin/check-attr.c
@@ -116,7 +116,7 @@ int cmd_check_attr(int argc,
 	struct object_id initialized_oid;
 	int cnt, i, doubledash, filei;
 
-	if (!is_bare_repository())
+	if (!repo_is_bare(the_repository))
 		setup_work_tree();
 
 	git_config(git_default_config, NULL);
diff --git a/builtin/clone.c b/builtin/clone.c
index 59fcb317a68..80b594c6011 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -1415,7 +1415,7 @@ int cmd_clone(int argc,
 		repo_clear(the_repository);
 
 		/* At this point, we need the_repository to match the cloned repo. */
-		if (repo_init(the_repository, git_dir, work_tree))
+		if (repo_init(the_repository, git_dir, work_tree, -1))
 			warning(_("failed to initialize the repo, skipping bundle URI"));
 		else if (fetch_bundle_uri(the_repository, bundle_uri, &has_heuristic))
 			warning(_("failed to fetch objects from bundle URI '%s'"),
@@ -1446,7 +1446,7 @@ int cmd_clone(int argc,
 			repo_clear(the_repository);
 
 			/* At this point, we need the_repository to match the cloned repo. */
-			if (repo_init(the_repository, git_dir, work_tree))
+			if (repo_init(the_repository, git_dir, work_tree, -1))
 				warning(_("failed to initialize the repo, skipping bundle URI"));
 			else if (fetch_bundle_list(the_repository,
 						   transport->bundles))
diff --git a/builtin/gc.c b/builtin/gc.c
index d52735354c9..e43219e1c17 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -712,7 +712,7 @@ struct repository *repo UNUSED)
 		die(_("failed to parse gc.logExpiry value %s"), cfg.gc_log_expire);
 
 	if (cfg.pack_refs < 0)
-		cfg.pack_refs = !is_bare_repository();
+		cfg.pack_refs = !repo_is_bare(the_repository);
 
 	argc = parse_options(argc, argv, prefix, builtin_gc_options,
 			     builtin_gc_usage, 0);
diff --git a/builtin/init-db.c b/builtin/init-db.c
index 7e00d57d654..901bf30b508 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -89,7 +89,7 @@ int cmd_init_db(int argc,
 	const struct option init_db_options[] = {
 		OPT_STRING(0, "template", &template_dir, N_("template-directory"),
 				N_("directory from which templates will be used")),
-		OPT_SET_INT(0, "bare", &is_bare_repository_cfg,
+		OPT_SET_INT(0, "bare", &the_repository->is_bare_cfg,
 				N_("create a bare repository"), 1),
 		{ OPTION_CALLBACK, 0, "shared", &init_shared_repository,
 			N_("permissions"),
@@ -109,7 +109,7 @@ int cmd_init_db(int argc,
 
 	argc = parse_options(argc, argv, prefix, init_db_options, init_db_usage, 0);
 
-	if (real_git_dir && is_bare_repository_cfg == 1)
+	if (real_git_dir && the_repository->is_bare_cfg == 1)
 		die(_("options '%s' and '%s' cannot be used together"), "--separate-git-dir", "--bare");
 
 	if (real_git_dir && !is_absolute_path(real_git_dir))
@@ -155,7 +155,7 @@ int cmd_init_db(int argc,
 	} else if (0 < argc) {
 		usage(init_db_usage[0]);
 	}
-	if (is_bare_repository_cfg == 1) {
+	if (the_repository->is_bare_cfg == 1) {
 		char *cwd = xgetcwd();
 		setenv(GIT_DIR_ENVIRONMENT, cwd, argc > 0);
 		free(cwd);
@@ -182,7 +182,7 @@ int cmd_init_db(int argc,
 	 */
 	git_dir = xstrdup_or_null(getenv(GIT_DIR_ENVIRONMENT));
 	work_tree = xstrdup_or_null(getenv(GIT_WORK_TREE_ENVIRONMENT));
-	if ((!git_dir || is_bare_repository_cfg == 1) && work_tree)
+	if ((!git_dir || the_repository->is_bare_cfg == 1) && work_tree)
 		die(_("%s (or --work-tree=<directory>) not allowed without "
 			  "specifying %s (or --git-dir=<directory>)"),
 		    GIT_WORK_TREE_ENVIRONMENT,
@@ -218,10 +218,10 @@ int cmd_init_db(int argc,
 		strbuf_release(&sb);
 	}
 
-	if (is_bare_repository_cfg < 0)
-		is_bare_repository_cfg = guess_repository_type(git_dir);
+	if (the_repository->is_bare_cfg < 0)
+		the_repository->is_bare_cfg = guess_repository_type(git_dir);
 
-	if (!is_bare_repository_cfg) {
+	if (!the_repository->is_bare_cfg) {
 		const char *git_dir_parent = strrchr(git_dir, '/');
 		if (git_dir_parent) {
 			char *rel = xstrndup(git_dir, git_dir_parent - git_dir);
diff --git a/builtin/repack.c b/builtin/repack.c
index d6bb37e84ae..45621f70c5b 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -1266,7 +1266,7 @@ int cmd_repack(int argc,
 
 	if (write_bitmaps < 0) {
 		if (!write_midx &&
-		    (!(pack_everything & ALL_INTO_ONE) || !is_bare_repository()))
+		    (!(pack_everything & ALL_INTO_ONE) || !repo_is_bare(the_repository)))
 			write_bitmaps = 0;
 	}
 	if (pack_kept_objects < 0)
diff --git a/builtin/reset.c b/builtin/reset.c
index 7154f88826d..dccd5d95dae 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -448,7 +448,7 @@ int cmd_reset(int argc,
 	if (reset_type != SOFT && (reset_type != MIXED || repo_get_work_tree(the_repository)))
 		setup_work_tree();
 
-	if (reset_type == MIXED && is_bare_repository())
+	if (reset_type == MIXED && repo_is_bare(the_repository))
 		die(_("%s reset is not allowed in a bare repository"),
 		    _(reset_type_names[reset_type]));
 
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 8401b4d7ab6..281b557483e 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -1063,7 +1063,7 @@ int cmd_rev_parse(int argc,
 				continue;
 			}
 			if (!strcmp(arg, "--is-bare-repository")) {
-				printf("%s\n", is_bare_repository() ? "true"
+				printf("%s\n", repo_is_bare(the_repository) ? "true"
 						: "false");
 				continue;
 			}
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index b6b5f1ebde7..7bff99bf08f 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1591,7 +1591,7 @@ static int add_possible_reference_from_superproject(
 		struct strbuf err = STRBUF_INIT;
 		strbuf_add(&sb, odb->path, len);
 
-		if (repo_init(&alternate, sb.buf, NULL) < 0)
+		if (repo_init(&alternate, sb.buf, NULL, the_repository->is_bare_cfg) < 0)
 			die(_("could not get a repository handle for gitdir '%s'"),
 			    sb.buf);
 
diff --git a/config.c b/config.c
index a11bb85da30..c1b14c89947 100644
--- a/config.c
+++ b/config.c
@@ -1441,7 +1441,7 @@ static int git_default_core_config(const char *var, const char *value,
 	}
 
 	if (!strcmp(var, "core.bare")) {
-		is_bare_repository_cfg = git_config_bool(var, value);
+		the_repository->is_bare_cfg = git_config_bool(var, value);
 		return 0;
 	}
 
diff --git a/dir.c b/dir.c
index e3ddd5b5296..c995668e54c 100644
--- a/dir.c
+++ b/dir.c
@@ -4008,7 +4008,7 @@ static void connect_wt_gitdir_in_nested(const char *sub_worktree,
 	const struct submodule *sub;
 
 	/* If the submodule has no working tree, we can ignore it. */
-	if (repo_init(&subrepo, sub_gitdir, sub_worktree))
+	if (repo_init(&subrepo, sub_gitdir, sub_worktree, the_repository->is_bare_cfg))
 		return;
 
 	if (repo_read_index(&subrepo) < 0)
diff --git a/environment.c b/environment.c
index a2ce9980818..9af20d5e34e 100644
--- a/environment.c
+++ b/environment.c
@@ -34,7 +34,6 @@ int has_symlinks = 1;
 int minimum_abbrev = 4, default_abbrev = -1;
 int ignore_case;
 int assume_unchanged;
-int is_bare_repository_cfg = -1; /* unspecified */
 int warn_on_object_refname_ambiguity = 1;
 int repository_format_precious_objects;
 char *git_commit_encoding;
@@ -146,12 +145,6 @@ const char *getenv_safe(struct strvec *argv, const char *name)
 	return argv->v[argv->nr - 1];
 }
 
-int is_bare_repository(void)
-{
-	/* if core.bare is not 'false', let's see if there is a work tree */
-	return is_bare_repository_cfg && !repo_get_work_tree(the_repository);
-}
-
 int have_git_dir(void)
 {
 	return startup_info->have_repository
diff --git a/environment.h b/environment.h
index 923e12661e1..23f29a4df05 100644
--- a/environment.h
+++ b/environment.h
@@ -144,8 +144,7 @@ void set_shared_repository(int value);
 int get_shared_repository(void);
 void reset_shared_repository(void);
 
-extern int is_bare_repository_cfg;
-int is_bare_repository(void);
+int is_bare_repository(struct repository *repo);
 extern char *git_work_tree_cfg;
 
 /* Environment bits from configuration mechanism */
diff --git a/git.c b/git.c
index c2c1b8e22c2..c8ed29b2295 100644
--- a/git.c
+++ b/git.c
@@ -251,7 +251,7 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 				*envchanged = 1;
 		} else if (!strcmp(cmd, "--bare")) {
 			char *cwd = xgetcwd();
-			is_bare_repository_cfg = 1;
+			the_repository->is_bare_cfg = 1;
 			setenv(GIT_DIR_ENVIRONMENT, cwd, 0);
 			free(cwd);
 			setenv(GIT_IMPLICIT_WORK_TREE_ENVIRONMENT, "0", 1);
diff --git a/mailmap.c b/mailmap.c
index 9f9fa3199a8..65fdd853a8e 100644
--- a/mailmap.c
+++ b/mailmap.c
@@ -216,10 +216,10 @@ int read_mailmap(struct string_list *map)
 	map->strdup_strings = 1;
 	map->cmp = namemap_cmp;
 
-	if (!git_mailmap_blob && is_bare_repository())
+	if (!git_mailmap_blob && repo_is_bare(the_repository))
 		git_mailmap_blob = xstrdup("HEAD:.mailmap");
 
-	if (!startup_info->have_repository || !is_bare_repository())
+	if (!startup_info->have_repository || !repo_is_bare(the_repository))
 		err |= read_mailmap_file(map, ".mailmap",
 					 startup_info->have_repository ?
 					 MAILMAP_NOFOLLOW : 0);
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 0824c0b8a94..7310dc0b332 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1779,7 +1779,7 @@ static int log_ref_setup(struct files_ref_store *refs,
 	char *logfile;
 
 	if (log_refs_cfg == LOG_REFS_UNSET)
-		log_refs_cfg = is_bare_repository() ? LOG_REFS_NONE : LOG_REFS_NORMAL;
+		log_refs_cfg = repo_is_bare(refs->base.repo) ? LOG_REFS_NONE : LOG_REFS_NORMAL;
 
 	files_reflog_path(refs, &logfile_sb, refname);
 	logfile = strbuf_detach(&logfile_sb, NULL);
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 38eb14d591e..f3b875726cb 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -163,7 +163,7 @@ static int should_write_log(struct reftable_ref_store *refs, const char *refname
 {
 	enum log_refs_config log_refs_cfg = refs->log_all_ref_updates;
 	if (log_refs_cfg == LOG_REFS_UNSET)
-		log_refs_cfg = is_bare_repository() ? LOG_REFS_NONE : LOG_REFS_NORMAL;
+		log_refs_cfg = repo_is_bare(refs->base.repo) ? LOG_REFS_NONE : LOG_REFS_NORMAL;
 
 	switch (log_refs_cfg) {
 	case LOG_REFS_NONE:
diff --git a/repository.c b/repository.c
index f988b8ae68a..96608058b61 100644
--- a/repository.c
+++ b/repository.c
@@ -25,7 +25,9 @@
 extern struct repository *the_repository;
 
 /* The main repository */
-static struct repository the_repo;
+static struct repository the_repo = {
+	.is_bare_cfg = -1,
+};
 struct repository *the_repository = &the_repo;
 
 /*
@@ -263,10 +265,13 @@ static int read_and_verify_repository_format(struct repository_format *format,
 /*
  * Initialize 'repo' based on the provided 'gitdir'.
  * Return 0 upon success and a non-zero value upon failure.
+ * is_bare can be passed to indicate whether or not the repository should be
+ * treated as bare when repo_init() is used to initiate a secondary repository.
  */
 int repo_init(struct repository *repo,
 	      const char *gitdir,
-	      const char *worktree)
+	      const char *worktree,
+	      int is_bare)
 {
 	struct repository_format format = REPOSITORY_FORMAT_INIT;
 	memset(repo, 0, sizeof(*repo));
@@ -283,6 +288,8 @@ int repo_init(struct repository *repo,
 	repo_set_compat_hash_algo(repo, format.compat_hash_algo);
 	repo_set_ref_storage_format(repo, format.ref_storage_format);
 	repo->repository_format_worktree_config = format.worktree_config;
+	if (is_bare > 0)
+		repo->is_bare_cfg = is_bare;
 
 	/* take ownership of format.partial_clone */
 	repo->repository_format_partial_clone = format.partial_clone;
@@ -314,7 +321,7 @@ int repo_submodule_init(struct repository *subrepo,
 	strbuf_repo_worktree_path(&gitdir, superproject, "%s/.git", path);
 	strbuf_repo_worktree_path(&worktree, superproject, "%s", path);
 
-	if (repo_init(subrepo, gitdir.buf, worktree.buf)) {
+	if (repo_init(subrepo, gitdir.buf, worktree.buf, superproject->is_bare_cfg)) {
 		/*
 		 * If initialization fails then it may be due to the submodule
 		 * not being populated in the superproject's worktree.  Instead
@@ -332,7 +339,7 @@ int repo_submodule_init(struct repository *subrepo,
 		strbuf_reset(&gitdir);
 		submodule_name_to_gitdir(&gitdir, superproject, sub->name);
 
-		if (repo_init(subrepo, gitdir.buf, NULL)) {
+		if (repo_init(subrepo, gitdir.buf, NULL, superproject->is_bare_cfg)) {
 			ret = -1;
 			goto out;
 		}
@@ -453,3 +460,9 @@ int repo_hold_locked_index(struct repository *repo,
 		BUG("the repo hasn't been setup");
 	return hold_lock_file_for_update(lf, repo->index_file, flags);
 }
+
+int repo_is_bare(struct repository *repo)
+{
+	/* if core.bare is not 'false', let's see if there is a work tree */
+	return repo->is_bare_cfg && !repo_get_work_tree(repo);
+}
diff --git a/repository.h b/repository.h
index 24a66a496a6..c243653492b 100644
--- a/repository.h
+++ b/repository.h
@@ -153,6 +153,14 @@ struct repository {
 
 	/* Indicate if a repository has a different 'commondir' from 'gitdir' */
 	unsigned different_commondir:1;
+
+	/*
+	 * Indicates if the repository is set to be treated as a bare repository,
+	 * through a command line argument, configuration, or environment
+	 * variable.
+	 * -1 means unspecified, 0 indicates non-bare, and 1 indicates bare.
+	 */
+	int is_bare_cfg;
 };
 
 #ifdef USE_THE_REPOSITORY_VARIABLE
@@ -188,7 +196,7 @@ void repo_set_ref_storage_format(struct repository *repo,
 				 enum ref_storage_format format);
 void initialize_repository(struct repository *repo);
 RESULT_MUST_BE_USED
-int repo_init(struct repository *r, const char *gitdir, const char *worktree);
+int repo_init(struct repository *r, const char *gitdir, const char *worktree, int is_bare);
 
 /*
  * Initialize the repository 'subrepo' as the submodule at the given path. If
@@ -232,4 +240,6 @@ void repo_update_index_if_able(struct repository *, struct lock_file *);
  */
 int upgrade_repository_format(int target_version);
 
+int repo_is_bare(struct repository *repo);
+
 #endif /* REPOSITORY_H */
diff --git a/scalar.c b/scalar.c
index ac0cb579d3f..c2ec1f3e745 100644
--- a/scalar.c
+++ b/scalar.c
@@ -722,7 +722,7 @@ static int cmd_reconfigure(int argc, const char **argv)
 
 		git_config_clear();
 
-		if (repo_init(&r, gitdir.buf, commondir.buf))
+		if (repo_init(&r, gitdir.buf, commondir.buf, the_repository->is_bare_cfg))
 			goto loop_end;
 
 		old_repo = the_repository;
diff --git a/setup.c b/setup.c
index 7b648de0279..6bc4aef3a8b 100644
--- a/setup.c
+++ b/setup.c
@@ -766,8 +766,8 @@ static int check_repository_format_gently(const char *gitdir, struct repository_
 
 	if (!has_common) {
 		if (candidate->is_bare != -1) {
-			is_bare_repository_cfg = candidate->is_bare;
-			if (is_bare_repository_cfg == 1)
+			the_repository->is_bare_cfg = candidate->is_bare;
+			if (the_repository->is_bare_cfg == 1)
 				inside_work_tree = -1;
 		}
 		if (candidate->work_tree) {
@@ -1030,7 +1030,7 @@ static const char *setup_explicit_git_dir(const char *gitdirenv,
 	/* #3, #7, #11, #15, #19, #23, #27, #31 (see t1510) */
 	if (work_tree_env)
 		set_git_work_tree(work_tree_env);
-	else if (is_bare_repository_cfg > 0) {
+	else if (the_repository->is_bare_cfg > 0) {
 		if (git_work_tree_cfg) {
 			/* #22.2, #30 */
 			warning("core.bare and core.worktree do not make sense");
@@ -1116,7 +1116,7 @@ static const char *setup_discovered_git_dir(const char *gitdir,
 	}
 
 	/* #16.2, #17.2, #20.2, #21.2, #24, #25, #28, #29 (see t1510) */
-	if (is_bare_repository_cfg > 0) {
+	if (the_repository->is_bare_cfg > 0) {
 		set_git_dir(gitdir, (offset != cwd->len));
 		if (chdir(cwd->buf))
 			die_errno(_("cannot come back to cwd"));
@@ -2323,7 +2323,7 @@ static int create_default_files(const char *template_path,
 	if (init_shared_repository != -1)
 		set_shared_repository(init_shared_repository);
 
-	is_bare_repository_cfg = !work_tree;
+	the_repository->is_bare_cfg = !work_tree;
 
 	/*
 	 * We would have created the above under user's umask -- under
@@ -2349,7 +2349,7 @@ static int create_default_files(const char *template_path,
 	}
 	git_config_set("core.filemode", filemode ? "true" : "false");
 
-	if (is_bare_repository())
+	if (repo_is_bare(the_repository))
 		git_config_set("core.bare", "true");
 	else {
 		git_config_set("core.bare", "false");
diff --git a/submodule.c b/submodule.c
index 74d5766f07c..059b9d32dcb 100644
--- a/submodule.c
+++ b/submodule.c
@@ -535,7 +535,7 @@ static struct repository *open_submodule(const char *path)
 	struct strbuf sb = STRBUF_INIT;
 	struct repository *out = xmalloc(sizeof(*out));
 
-	if (submodule_to_gitdir(&sb, path) || repo_init(out, sb.buf, NULL)) {
+	if (submodule_to_gitdir(&sb, path) || repo_init(out, sb.buf, NULL, -1)) {
 		strbuf_release(&sb);
 		free(out);
 		return NULL;
diff --git a/t/helper/test-partial-clone.c b/t/helper/test-partial-clone.c
index a1af9710c31..66d9390dae1 100644
--- a/t/helper/test-partial-clone.c
+++ b/t/helper/test-partial-clone.c
@@ -19,7 +19,7 @@ static void object_info(const char *gitdir, const char *oid_hex)
 	struct object_info oi = {.sizep = &size};
 	const char *p;
 
-	if (repo_init(&r, gitdir, NULL))
+	if (repo_init(&r, gitdir, NULL, -1))
 		die("could not init repo");
 	if (parse_oid_hex_algop(oid_hex, &oid, &p, r.hash_algo))
 		die("could not parse oid");
diff --git a/t/helper/test-repository.c b/t/helper/test-repository.c
index 63c37de33d2..90d58190c37 100644
--- a/t/helper/test-repository.c
+++ b/t/helper/test-repository.c
@@ -21,7 +21,7 @@ static void test_parse_commit_in_graph(const char *gitdir, const char *worktree,
 
 	repo_clear(the_repository);
 
-	if (repo_init(&r, gitdir, worktree))
+	if (repo_init(&r, gitdir, worktree, -1))
 		die("Couldn't init repo");
 
 	repo_set_hash_algo(the_repository, hash_algo_by_ptr(r.hash_algo));
@@ -51,7 +51,7 @@ static void test_get_commit_tree_in_graph(const char *gitdir,
 
 	repo_clear(the_repository);
 
-	if (repo_init(&r, gitdir, worktree))
+	if (repo_init(&r, gitdir, worktree, -1))
 		die("Couldn't init repo");
 
 	repo_set_hash_algo(the_repository, hash_algo_by_ptr(r.hash_algo));
diff --git a/transport.c b/transport.c
index 47fda6a7732..d72b8380846 100644
--- a/transport.c
+++ b/transport.c
@@ -1428,7 +1428,7 @@ int transport_push(struct repository *r,
 
 	if ((flags & (TRANSPORT_RECURSE_SUBMODULES_ON_DEMAND |
 		      TRANSPORT_RECURSE_SUBMODULES_ONLY)) &&
-	    !is_bare_repository()) {
+	    !repo_is_bare(r)) {
 		struct ref *ref = remote_refs;
 		struct oid_array commits = OID_ARRAY_INIT;
 
@@ -1455,7 +1455,7 @@ int transport_push(struct repository *r,
 	if (((flags & TRANSPORT_RECURSE_SUBMODULES_CHECK) ||
 	     ((flags & (TRANSPORT_RECURSE_SUBMODULES_ON_DEMAND |
 			TRANSPORT_RECURSE_SUBMODULES_ONLY)) &&
-	      !pretend)) && !is_bare_repository()) {
+	      !pretend)) && !repo_is_bare(r)) {
 		struct ref *ref = remote_refs;
 		struct string_list needs_pushing = STRING_LIST_INIT_DUP;
 		struct oid_array commits = OID_ARRAY_INIT;
diff --git a/worktree.c b/worktree.c
index 77ff484d3ec..c9d5b228959 100644
--- a/worktree.c
+++ b/worktree.c
@@ -85,8 +85,8 @@ static struct worktree *get_main_worktree(int skip_reading_head)
 	 * This means that worktree->is_bare may be set to 0 even if the main
 	 * worktree is configured to be bare.
 	 */
-	worktree->is_bare = (is_bare_repository_cfg == 1) ||
-		is_bare_repository();
+
+	worktree->is_bare = the_repository->is_bare_cfg == 1;
 	worktree->is_current = is_current_worktree(worktree);
 	if (!skip_reading_head)
 		add_head_info(worktree);
-- 
gitgitgadget

