Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75F418E341
	for <git@vger.kernel.org>; Thu, 29 Aug 2024 09:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724924327; cv=none; b=RvzRRKRAP+XrobrCyK1AN0nmzeH2pyRscUr1cJWI9QevyGxkZrENT+FehUON0Db4/NvFbY0bovu8J2v0iikachF8lIX/lVqrWsGd1KDLTPVJgkd1z2aSn2/B/E54mQ413OD3O4bVE/wMjFVJd0WS5g2hGBqhksOoQtMWprzLsYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724924327; c=relaxed/simple;
	bh=arbiSBanJoSm/KZMSnKDTyeTJffbk2EK4C083YLZdt8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MnLG834hToTCSnEW4kWNF4h0fPnbQDOuUyELdFGYZVa7BUvVli08eYJFyY+Uk1Awa9/5EkxIGWQyVwJeBJ0XAx9ORByjNQZjDuD5PsPzTyRQX6ctTi2aRVbMMOnlDxR/nfMgkVoP4CYJSWhqDnU1/0wrVd4Igoo8oAv63OpM6NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=rY3B3ILf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZzJz7QFW; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="rY3B3ILf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZzJz7QFW"
Received: from phl-compute-04.internal (phl-compute-04.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id 07CDD1390140;
	Thu, 29 Aug 2024 05:38:44 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 29 Aug 2024 05:38:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724924324; x=1725010724; bh=9XmY1xeDnb
	KPYTcbeywNYPz7FP32soIeJ9RndrWmoR0=; b=rY3B3ILfde9sDCFK0aalAwVLwM
	A0St31YKLwD2v53v+ST3p/VobAYsXzuIhbkvJwDntzVNwnKBUZ4jUf36GiSwQ9th
	04Vt+zsoU7+7Vi+QH5NOyYptMZYZy1IMclZrUTtrozowl6Im4Yz4nS8Irs8ulXrS
	55CY4ZNBUqcUDO77iIWsYxQLcsGXJ71ceWlhUxhp7FKEOYv29ngO9GNGqsOM1oZo
	1Mt+Mq6qDi0lZNn8r0XkjIzOHuzkDjqBKdgnJinYpEdcGCOJ2ckdv1uvqRVuVsXb
	YplVEJ4+GsMr8UbyAXXeeQla/aKcvZdbzceKCk+fNhKe0p3kO949ccGk6j8Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724924324; x=1725010724; bh=9XmY1xeDnbKPYTcbeywNYPz7FP32
	soIeJ9RndrWmoR0=; b=ZzJz7QFWHZys1RlIvHMjAXQYvfuU/W1s1Ul3O448xIMk
	AyXOBGspAspm8OYm+FtGaYuiOuK3AHzX6HjnYCGlh6wIovn+Ut+0Iwp3HTKbqTKY
	oH3zVdcRMD7WRqKOA9jKPj2xImyQcId/eSjaaXEVtO+zTbNEi05CrbfSYEWoUyxv
	Y9+PNsowzuisBKeX5iIXYer8s+hbaogTV0myMsmbErNTpXwFSGNFZzLvnI1hxga0
	HAR2J/VTNFPydXge2QEpHvDfRRBFFRpL0qulBEOxE/lnImlPvnKeenUTQIGK9fsL
	X70DiSEdbOBCCBYamJXYl/zJ0disZtyeDbf5wPN4ZQ==
X-ME-Sender: <xms:o0HQZhZC-D_lQOD-GdzjkPOEe8rU70dVUgMdQT9HGPceNGd5ezZAZA>
    <xme:o0HQZoYDUpCfxctgaO4IczaZIr0U2sZH9t19JgE9q6u7OUKmu1WFHGWzBlGdDI-IF
    8yUplxPw1TW48hWIQ>
X-ME-Received: <xmr:o0HQZj88_owOeyuaVEi6vw7ZwwrVVwuJ8Z7cjWUPkL4RJ2t2jy9xhhLIuz4_r_vPRmXAqmJgPVIEwxuEgsVjTlj3sOZvUZ9F6-Xdt40LIO7vjM8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudefgedgudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheptggrlhhvihhnfigrnhesghhoohhglhgvrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:o0HQZvqsV-MY0d0-A-fRWP-3EFuNcTSgaK3EyqXGVMee-9qrboriFg>
    <xmx:o0HQZsoGeRDysV0-30PklKZiN_DpybKGND_s9qP97DiX-ouBVAzQ1Q>
    <xmx:o0HQZlT8v66qWFUrOM2YuoU3gDn32JSrG6cH_bnZvEpgvsFltfMleg>
    <xmx:o0HQZkp5f8xgLrBSA8WLTReU3acJ35-prSL41DZ1DTs0giEzAeynfQ>
    <xmx:o0HQZj1jznjXsNNz1XdEDS6Fcq_-mDHdSBkyt3fMBkAM_3iVxwEKNsVr>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Aug 2024 05:38:43 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id eb3589f6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 29 Aug 2024 09:38:34 +0000 (UTC)
Date: Thu, 29 Aug 2024 11:38:41 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Calvin Wan <calvinwan@google.com>
Subject: [PATCH 06/21] environment: make `get_git_work_tree()` accept a
 repository
Message-ID: <7fc346d3bb5c470a373d089b60f10204d3fd8efb.1724923648.git.ps@pks.im>
References: <cover.1724923648.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1724923648.git.ps@pks.im>

The `get_git_work_tree()` function retrieves the path of the work tree
of `the_repository`. Make it accept a `struct repository` such that it
can work on arbitrary repositories and make it part of the repository
subsystem. This reduces our reliance on `the_repository` and clarifies
scope.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/blame.c             |  2 +-
 builtin/difftool.c          |  4 ++--
 builtin/fsmonitor--daemon.c |  3 ++-
 builtin/init-db.c           |  4 ++--
 builtin/reset.c             |  4 ++--
 builtin/rev-parse.c         |  4 ++--
 builtin/stash.c             |  2 +-
 builtin/submodule--helper.c |  2 +-
 builtin/update-index.c      |  2 +-
 dir.c                       |  2 +-
 environment.c               |  7 +------
 environment.h               |  1 -
 fsmonitor.c                 |  2 +-
 pathspec.c                  |  2 +-
 repository.c                |  5 +++++
 repository.h                |  1 +
 setup.c                     | 16 ++++++++--------
 trace.c                     |  2 +-
 18 files changed, 33 insertions(+), 32 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 35e975fb132..1ffdda50904 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -1081,7 +1081,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 			path = add_prefix(prefix, argv[1]);
 			argv[1] = argv[2];
 		} else {	/* (2a) */
-			if (argc == 2 && is_a_rev(argv[1]) && !get_git_work_tree())
+			if (argc == 2 && is_a_rev(argv[1]) && !repo_get_work_tree(the_repository))
 				die("missing <path> to blame");
 			path = add_prefix(prefix, argv[argc - 1]);
 		}
diff --git a/builtin/difftool.c b/builtin/difftool.c
index da9315e84d4..7c16c55baaf 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -377,7 +377,7 @@ static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
 	struct hashmap wt_modified, tmp_modified;
 	int indices_loaded = 0;
 
-	workdir = get_git_work_tree();
+	workdir = repo_get_work_tree(the_repository);
 
 	/* Setup temp directories */
 	tmp = getenv("TMPDIR");
@@ -738,7 +738,7 @@ int cmd_difftool(int argc, const char **argv, const char *prefix)
 	if (!no_index){
 		setup_work_tree();
 		setenv(GIT_DIR_ENVIRONMENT, absolute_path(repo_get_git_dir(the_repository)), 1);
-		setenv(GIT_WORK_TREE_ENVIRONMENT, absolute_path(get_git_work_tree()), 1);
+		setenv(GIT_WORK_TREE_ENVIRONMENT, absolute_path(repo_get_work_tree(the_repository)), 1);
 	} else if (dir_diff)
 		die(_("options '%s' and '%s' cannot be used together"), "--dir-diff", "--no-index");
 
diff --git a/builtin/fsmonitor--daemon.c b/builtin/fsmonitor--daemon.c
index c54e736716a..d7de0427845 100644
--- a/builtin/fsmonitor--daemon.c
+++ b/builtin/fsmonitor--daemon.c
@@ -1291,7 +1291,8 @@ static int fsmonitor_run_daemon(void)
 
 	/* Prepare to (recursively) watch the <worktree-root> directory. */
 	strbuf_init(&state.path_worktree_watch, 0);
-	strbuf_addstr(&state.path_worktree_watch, absolute_path(get_git_work_tree()));
+	strbuf_addstr(&state.path_worktree_watch,
+		      absolute_path(repo_get_work_tree(the_repository)));
 	state.nr_paths_watching = 1;
 
 	strbuf_init(&state.alias.alias, 0);
diff --git a/builtin/init-db.c b/builtin/init-db.c
index 582dcf20f86..fb04962dcea 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -231,9 +231,9 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
 			set_git_work_tree(work_tree);
 		else
 			set_git_work_tree(git_work_tree_cfg);
-		if (access(get_git_work_tree(), X_OK))
+		if (access(repo_get_work_tree(the_repository), X_OK))
 			die_errno (_("Cannot access work tree '%s'"),
-				   get_git_work_tree());
+				   repo_get_work_tree(the_repository));
 	}
 	else {
 		if (real_git_dir)
diff --git a/builtin/reset.c b/builtin/reset.c
index 5f941fb3a29..2e5f477339b 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -441,7 +441,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 	else
 		trace2_cmd_mode(reset_type_names[reset_type]);
 
-	if (reset_type != SOFT && (reset_type != MIXED || get_git_work_tree()))
+	if (reset_type != SOFT && (reset_type != MIXED || repo_get_work_tree(the_repository)))
 		setup_work_tree();
 
 	if (reset_type == MIXED && is_bare_repository())
@@ -474,7 +474,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 				goto cleanup;
 			}
 			the_repository->index->updated_skipworktree = 1;
-			if (!no_refresh && get_git_work_tree()) {
+			if (!no_refresh && repo_get_work_tree(the_repository)) {
 				uint64_t t_begin, t_delta_in_ms;
 
 				t_begin = getnanotime();
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 4308a2a8549..65b0b5e2c0a 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -966,7 +966,7 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 				continue;
 			}
 			if (!strcmp(arg, "--show-toplevel")) {
-				const char *work_tree = get_git_work_tree();
+				const char *work_tree = repo_get_work_tree(the_repository);
 				if (work_tree)
 					print_path(work_tree, prefix, format, DEFAULT_UNMODIFIED);
 				else
@@ -991,7 +991,7 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 				const char *pfx = prefix;
 				if (!is_inside_work_tree()) {
 					const char *work_tree =
-						get_git_work_tree();
+						repo_get_work_tree(the_repository);
 					if (work_tree)
 						printf("%s\n", work_tree);
 					continue;
diff --git a/builtin/stash.c b/builtin/stash.c
index ae42da02b97..bc22164dd75 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -640,7 +640,7 @@ static int do_apply_stash(const char *prefix, struct stash_info *info,
 		cp.git_cmd = 1;
 		cp.dir = prefix;
 		strvec_pushf(&cp.env, GIT_WORK_TREE_ENVIRONMENT"=%s",
-			     absolute_path(get_git_work_tree()));
+			     absolute_path(repo_get_work_tree(the_repository)));
 		strvec_pushf(&cp.env, GIT_DIR_ENVIRONMENT"=%s",
 			     absolute_path(repo_get_git_dir(the_repository)));
 		strvec_push(&cp.args, "status");
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 85fb23dee84..865b454d693 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1709,7 +1709,7 @@ static int clone_submodule(const struct module_clone_data *clone_data,
 		exit(128);
 
 	if (!is_absolute_path(clone_data->path))
-		clone_data_path = to_free = xstrfmt("%s/%s", get_git_work_tree(),
+		clone_data_path = to_free = xstrfmt("%s/%s", repo_get_work_tree(the_repository),
 						    clone_data->path);
 
 	if (validate_submodule_git_dir(sm_gitdir, clone_data->name) < 0)
diff --git a/builtin/update-index.c b/builtin/update-index.c
index 86c5d40e400..8baa2256194 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -1194,7 +1194,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 				  "remove or change it, if you really want to "
 				  "enable the untracked cache"));
 		add_untracked_cache(the_repository->index);
-		report(_("Untracked cache enabled for '%s'"), get_git_work_tree());
+		report(_("Untracked cache enabled for '%s'"), repo_get_work_tree(the_repository));
 		break;
 	default:
 		BUG("bad untracked_cache value: %d", untracked_cache);
diff --git a/dir.c b/dir.c
index 5a23376bdae..2a8690dadd0 100644
--- a/dir.c
+++ b/dir.c
@@ -2838,7 +2838,7 @@ static const char *get_ident_string(void)
 		return sb.buf;
 	if (uname(&uts) < 0)
 		die_errno(_("failed to get kernel name and information"));
-	strbuf_addf(&sb, "Location %s, system %s", get_git_work_tree(),
+	strbuf_addf(&sb, "Location %s, system %s", repo_get_work_tree(the_repository),
 		    uts.sysname);
 	return sb.buf;
 }
diff --git a/environment.c b/environment.c
index 371f01a705d..4d0637b3822 100644
--- a/environment.c
+++ b/environment.c
@@ -219,7 +219,7 @@ void setup_git_env(const char *git_dir)
 int is_bare_repository(void)
 {
 	/* if core.bare is not 'false', let's see if there is a work tree */
-	return is_bare_repository_cfg && !get_git_work_tree();
+	return is_bare_repository_cfg && !repo_get_work_tree(the_repository);
 }
 
 int have_git_dir(void)
@@ -268,11 +268,6 @@ void set_git_work_tree(const char *new_work_tree)
 	repo_set_worktree(the_repository, new_work_tree);
 }
 
-const char *get_git_work_tree(void)
-{
-	return the_repository->worktree;
-}
-
 int odb_mkstemp(struct strbuf *temp_filename, const char *pattern)
 {
 	int fd;
diff --git a/environment.h b/environment.h
index d12c48481b6..52e1803aba6 100644
--- a/environment.h
+++ b/environment.h
@@ -108,7 +108,6 @@ extern char *git_work_tree_cfg;
 void set_git_dir(const char *path, int make_realpath);
 const char *get_git_namespace(void);
 const char *strip_namespace(const char *namespaced_ref);
-const char *get_git_work_tree(void);
 void set_git_work_tree(const char *tree);
 
 #define ALTERNATE_DB_ENVIRONMENT "GIT_ALTERNATE_OBJECT_DIRECTORIES"
diff --git a/fsmonitor.c b/fsmonitor.c
index 28130f748f7..cbc12f060e2 100644
--- a/fsmonitor.c
+++ b/fsmonitor.c
@@ -169,7 +169,7 @@ static int query_fsmonitor_hook(struct repository *r,
 	strvec_pushf(&cp.args, "%d", version);
 	strvec_pushf(&cp.args, "%s", last_update);
 	cp.use_shell = 1;
-	cp.dir = get_git_work_tree();
+	cp.dir = repo_get_work_tree(the_repository);
 
 	trace2_region_enter("fsm_hook", "query", NULL);
 
diff --git a/pathspec.c b/pathspec.c
index 416fe1e3dcc..0fc6f84a6e6 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -495,7 +495,7 @@ static void init_pathspec_item(struct pathspec_item *item, unsigned flags,
 			if (!have_git_dir())
 				die(_("'%s' is outside the directory tree"),
 				    copyfrom);
-			hint_path = get_git_work_tree();
+			hint_path = repo_get_work_tree(the_repository);
 			if (!hint_path)
 				hint_path = repo_get_git_dir(the_repository);
 			die(_("%s: '%s' is outside repository at '%s'"), elt,
diff --git a/repository.c b/repository.c
index cdefcb4002d..92238da3d9e 100644
--- a/repository.c
+++ b/repository.c
@@ -126,6 +126,11 @@ const char *repo_get_graft_file(struct repository *repo)
 	return repo->graft_file;
 }
 
+const char *repo_get_work_tree(struct repository *repo)
+{
+	return repo->worktree;
+}
+
 static void repo_set_commondir(struct repository *repo,
 			       const char *commondir)
 {
diff --git a/repository.h b/repository.h
index ad0f984b444..c603e969ae7 100644
--- a/repository.h
+++ b/repository.h
@@ -211,6 +211,7 @@ const char *repo_get_common_dir(struct repository *repo);
 const char *repo_get_object_directory(struct repository *repo);
 const char *repo_get_index_file(struct repository *repo);
 const char *repo_get_graft_file(struct repository *repo);
+const char *repo_get_work_tree(struct repository *repo);
 
 /*
  * Define a custom repository layout. Any field can be NULL, which
diff --git a/setup.c b/setup.c
index 1ebcab625fe..1bfec288ab6 100644
--- a/setup.c
+++ b/setup.c
@@ -51,7 +51,7 @@ static int abspath_part_inside_repo(char *path)
 	size_t wtlen;
 	char *path0;
 	int off;
-	const char *work_tree = precompose_string_if_needed(get_git_work_tree());
+	const char *work_tree = precompose_string_if_needed(repo_get_work_tree(the_repository));
 	struct strbuf realpath = STRBUF_INIT;
 
 	if (!work_tree)
@@ -147,7 +147,7 @@ char *prefix_path(const char *prefix, int len, const char *path)
 {
 	char *r = prefix_path_gently(prefix, len, NULL, path);
 	if (!r) {
-		const char *hint_path = get_git_work_tree();
+		const char *hint_path = repo_get_work_tree(the_repository);
 		if (!hint_path)
 			hint_path = repo_get_git_dir(the_repository);
 		die(_("'%s' is outside repository at '%s'"), path,
@@ -475,7 +475,7 @@ int is_inside_git_dir(void)
 int is_inside_work_tree(void)
 {
 	if (inside_work_tree < 0)
-		inside_work_tree = is_inside_dir(get_git_work_tree());
+		inside_work_tree = is_inside_dir(repo_get_work_tree(the_repository));
 	return inside_work_tree;
 }
 
@@ -490,7 +490,7 @@ void setup_work_tree(void)
 	if (work_tree_config_is_bogus)
 		die(_("unable to set up work tree using invalid config"));
 
-	work_tree = get_git_work_tree();
+	work_tree = repo_get_work_tree(the_repository);
 	if (!work_tree || chdir_notify(work_tree))
 		die(_("this operation must be run in a work tree"));
 
@@ -547,7 +547,7 @@ static void setup_original_cwd(void)
 	 * Get our worktree; we only protect the current working directory
 	 * if it's in the worktree.
 	 */
-	worktree = get_git_work_tree();
+	worktree = repo_get_work_tree(the_repository);
 	if (!worktree)
 		goto no_prevention_needed;
 
@@ -1062,9 +1062,9 @@ static const char *setup_explicit_git_dir(const char *gitdirenv,
 		set_git_work_tree(".");
 
 	/* set_git_work_tree() must have been called by now */
-	worktree = get_git_work_tree();
+	worktree = repo_get_work_tree(the_repository);
 
-	/* both get_git_work_tree() and cwd are already normalized */
+	/* both repo_get_work_tree() and cwd are already normalized */
 	if (!strcmp(cwd->buf, worktree)) { /* cwd == worktree */
 		set_git_dir(gitdirenv, 0);
 		free(gitfile);
@@ -2192,7 +2192,7 @@ static int create_default_files(const char *template_path,
 	char *path;
 	int reinit;
 	int filemode;
-	const char *work_tree = get_git_work_tree();
+	const char *work_tree = repo_get_work_tree(the_repository);
 
 	/*
 	 * First copy the templates -- we might have the default
diff --git a/trace.c b/trace.c
index 2d9ae1c1525..094588c2165 100644
--- a/trace.c
+++ b/trace.c
@@ -307,7 +307,7 @@ void trace_repo_setup(void)
 
 	cwd = xgetcwd();
 
-	if (!(git_work_tree = get_git_work_tree()))
+	if (!(git_work_tree = repo_get_work_tree(the_repository)))
 		git_work_tree = "(null)";
 
 	if (!startup_info->prefix)
-- 
2.46.0.421.g159f2d50e7.dirty

