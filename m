Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9743C18C347
	for <git@vger.kernel.org>; Thu, 29 Aug 2024 09:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724924308; cv=none; b=NYAa6psvI8WqKQgsN2Q9XMa694gS9J9KNtMlUPH+5PITL1kK/ShZaWX0XZa5tfF0aHqFoVNQ85gcKxG1FA5iu7Qc5L+TSMJtlaq4AWwt6cqMRlTLBS/ZmWQ7Ycw+ca0gq8u6q1nzNCA4hm5nrP4WtZDmKux/yOvV2MDBKp/4mJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724924308; c=relaxed/simple;
	bh=XLNWRAc5tbEsgVhtOZVSFf/ScF1d8CzqiMR9pSA4qyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ewR0PqA6XUw7lCFkqGyIB7VHML3eplcNCMFblKMSsbmlAHQnd18XGAKUNli4S1ugafRaWsy3SVIWGacG/4AuoMfeC6zr5Jmp82jRFL+eTiVmQXdo5pURrZrTjXbkdIhLLZBbtDckHQJQ8PCgzDUYZHPk0SdLC7VnALqN8UbB+G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=iEg8wTo2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YvRnu69i; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="iEg8wTo2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YvRnu69i"
Received: from phl-compute-05.internal (phl-compute-05.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id BD6A41151CA6;
	Thu, 29 Aug 2024 05:38:24 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 29 Aug 2024 05:38:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724924304; x=1725010704; bh=yuv4dqsRDo
	3T3dt+LBkW8KisRbylQwe3zqsWZcfWPd0=; b=iEg8wTo2qMene15cLQTDPTnSGE
	VeA/2yBXAgwTSYu2Lc9GSx+MZT4JuJeA6nX73HGhTf16Q8I4Bc1Vur/bZn/IY8zF
	FeYGWxTC2wM9zT/eaFrROpPAGJ+p2on3Iqrrb8RDy+5BrOuGFmMJfVC9kvRXgWJQ
	casmqgXMGpGyMojmdp4SitvVCLumtrvzd6rNhkHYluxXI0OlZQZKrFeVhmofn7fg
	VS5IAOa/MDd+RlqzsnOY2KEF9RtKo/sA7dBxypWdg0pnGFUp+mLW8+Ddk0hR1fAd
	u00eYMPZe4FyJwfiz1S5huyLyOwtkR8lMMdhYbeLQ0BKGQ6CXC6ifFkA/cKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724924304; x=1725010704; bh=yuv4dqsRDo3T3dt+LBkW8KisRbyl
	Qwe3zqsWZcfWPd0=; b=YvRnu69iqdpo0NBsHrICucMVAP9bO90iULtJJQB0Otxx
	dZsYZi+IDh5QMmBwxk7c6O+CiFrMK+oy64/KfZxBRrowbDeKFxPCiGFjY7c6dMeB
	eI0DkXcQkw6FftC4umcErKYtxBr7RBXi7IrmFB/rXV214dYLPVFc3WfDeMWSvwmE
	mP/RN4SnYXocy2IYGcpYsWxB8iwRdwg+XVvw1w1JYPcH3gR1/PCdmXtT2Gn1Y0tJ
	5RhvDlkvfRwszKadMuuTo4BkVR2Fwfo0gZw/tgvPoc+vdw0X0Md4G0wCeOsvU4ll
	S+BevY2WeuarIWfMMwSazQpsQJtF5wqXgs40er4aRQ==
X-ME-Sender: <xms:kEHQZhC3ZWLkMGiRcj2NyJs2u-QhjAZlsY2W5cAjEt3pJGI21vRnuA>
    <xme:kEHQZvhtfTLssFKOtLVJ3jlIRv-4TuIA80nrzwFV7nGIW3DwpCbLRKdXUDmo6Rzxf
    aLnGlxwfR-oj52gOA>
X-ME-Received: <xmr:kEHQZsn6NJgz5-8LPugWerBVaq-wB58O7E-X8jMUkeYgpW24DRo3o6fm4PMWVFe5fmpk3eHoSTNyeLEJTg5AKdT_c9ms5WGMNpv6cAG6sfKdvq0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudefgedgudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepieduieeitdehieeutdejudehkedvgfejudefgfeiuefg
    jeekudegfefgffeftdehnecuffhomhgrihhnpehgnhhurdhorhhgnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgs
    pghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheptggrlhhvih
    hnfigrnhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrgh
X-ME-Proxy: <xmx:kEHQZrzJDiyPWcWZBy6rVn_y_-QON4P9yz4mILWR7tLEXROqDEC-vQ>
    <xmx:kEHQZmSRHkkfGkY9dzNryY0lNto9kYv1VhMnAbyDylRNN5c55yJm2A>
    <xmx:kEHQZuZbutny-Sj1yrRojC76dSq4f1C1F5swqMJb_RSF2wk05JF6RQ>
    <xmx:kEHQZnRWj8EJ04EHfD1M1zhxLK7MqsmEUGggSEraxHsIEs4pfwBvzg>
    <xmx:kEHQZhfnfEVzTOznsJK0M7s1i1Hm2n_0VfjQX6WKkjkPFSTgXDnnJwV0>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Aug 2024 05:38:23 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 791947e7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 29 Aug 2024 09:38:15 +0000 (UTC)
Date: Thu, 29 Aug 2024 11:38:22 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Calvin Wan <calvinwan@google.com>
Subject: [PATCH 01/21] environment: make `get_git_dir()` accept a repository
Message-ID: <0fe3e3e1cccf2eae7d81ccecf431da623b39fa79.1724923648.git.ps@pks.im>
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

The `get_git_dir()` function retrieves the path to the Git directory for
`the_repository`. Make it accept a `struct repository` such that it can
work on arbitrary repositories and make it part of the repository
subsystem. This reduces our reliance on `the_repository` and clarifies
scope.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 apply.c                     |  2 +-
 builtin/am.c                |  5 +++--
 builtin/commit.c            |  6 +++---
 builtin/config.c            |  2 +-
 builtin/difftool.c          |  4 ++--
 builtin/fsmonitor--daemon.c |  3 ++-
 builtin/merge.c             |  3 ++-
 builtin/stash.c             |  2 +-
 cache-tree.c                |  3 ++-
 config.c                    |  4 +++-
 environment.c               | 10 ++--------
 environment.h               |  1 -
 pathspec.c                  |  2 +-
 read-cache.c                |  5 +++--
 repository.c                |  7 +++++++
 repository.h                |  2 ++
 setup.c                     | 12 ++++++------
 setup.h                     |  2 +-
 trace.c                     |  4 +++-
 transport-helper.c          |  2 +-
 worktree.c                  |  4 ++--
 21 files changed, 48 insertions(+), 37 deletions(-)

diff --git a/apply.c b/apply.c
index 6e1060a952c..19fbb8fb93f 100644
--- a/apply.c
+++ b/apply.c
@@ -4111,7 +4111,7 @@ static int read_apply_cache(struct apply_state *state)
 {
 	if (state->index_file)
 		return read_index_from(state->repo->index, state->index_file,
-				       get_git_dir());
+				       repo_get_git_dir(the_repository));
 	else
 		return repo_read_index(state->repo);
 }
diff --git a/builtin/am.c b/builtin/am.c
index d8875ad4022..405214e242a 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1544,7 +1544,8 @@ static int run_apply(const struct am_state *state, const char *index_file)
 	if (index_file) {
 		/* Reload index as apply_all_patches() will have modified it. */
 		discard_index(the_repository->index);
-		read_index_from(the_repository->index, index_file, get_git_dir());
+		read_index_from(the_repository->index, index_file,
+				repo_get_git_dir(the_repository));
 	}
 
 	return 0;
@@ -1587,7 +1588,7 @@ static int fall_back_threeway(const struct am_state *state, const char *index_pa
 		return error("could not build fake ancestor");
 
 	discard_index(the_repository->index);
-	read_index_from(the_repository->index, index_path, get_git_dir());
+	read_index_from(the_repository->index, index_path, repo_get_git_dir(the_repository));
 
 	if (write_index_as_tree(&bases[0], the_repository->index, index_path, 0, NULL))
 		return error(_("Repository lacks necessary blobs to fall back on 3-way merge."));
diff --git a/builtin/commit.c b/builtin/commit.c
index b2033c48877..55124ee28f0 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -407,7 +407,7 @@ static const char *prepare_index(const char **argv, const char *prefix,
 
 		discard_index(the_repository->index);
 		read_index_from(the_repository->index, get_lock_file_path(&index_lock),
-				get_git_dir());
+				repo_get_git_dir(the_repository));
 		if (cache_tree_update(the_repository->index, WRITE_TREE_SILENT) == 0) {
 			if (reopen_lock_file(&index_lock) < 0)
 				die(_("unable to write index file"));
@@ -534,7 +534,7 @@ static const char *prepare_index(const char **argv, const char *prefix,
 
 	discard_index(the_repository->index);
 	ret = get_lock_file_path(&false_lock);
-	read_index_from(the_repository->index, ret, get_git_dir());
+	read_index_from(the_repository->index, ret, repo_get_git_dir(the_repository));
 out:
 	string_list_clear(&partial, 0);
 	clear_pathspec(&pathspec);
@@ -1072,7 +1072,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		 */
 		discard_index(the_repository->index);
 	}
-	read_index_from(the_repository->index, index_file, get_git_dir());
+	read_index_from(the_repository->index, index_file, repo_get_git_dir(the_repository));
 
 	if (cache_tree_update(the_repository->index, 0)) {
 		error(_("Error building trees"));
diff --git a/builtin/config.c b/builtin/config.c
index e00d983596b..c10697a2efb 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -808,7 +808,7 @@ static void location_options_init(struct config_location_options *opts,
 		opts->options.respect_includes = opts->respect_includes_opt;
 	if (startup_info->have_repository) {
 		opts->options.commondir = get_git_common_dir();
-		opts->options.git_dir = get_git_dir();
+		opts->options.git_dir = repo_get_git_dir(the_repository);
 	}
 }
 
diff --git a/builtin/difftool.c b/builtin/difftool.c
index dcc68e190c2..da9315e84d4 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -214,7 +214,7 @@ static void changed_files(struct hashmap *result, const char *index_path,
 	struct child_process update_index = CHILD_PROCESS_INIT;
 	struct child_process diff_files = CHILD_PROCESS_INIT;
 	struct strbuf buf = STRBUF_INIT;
-	const char *git_dir = absolute_path(get_git_dir());
+	const char *git_dir = absolute_path(repo_get_git_dir(the_repository));
 	FILE *fp;
 
 	strvec_pushl(&update_index.args,
@@ -737,7 +737,7 @@ int cmd_difftool(int argc, const char **argv, const char *prefix)
 
 	if (!no_index){
 		setup_work_tree();
-		setenv(GIT_DIR_ENVIRONMENT, absolute_path(get_git_dir()), 1);
+		setenv(GIT_DIR_ENVIRONMENT, absolute_path(repo_get_git_dir(the_repository)), 1);
 		setenv(GIT_WORK_TREE_ENVIRONMENT, absolute_path(get_git_work_tree()), 1);
 	} else if (dir_diff)
 		die(_("options '%s' and '%s' cannot be used together"), "--dir-diff", "--no-index");
diff --git a/builtin/fsmonitor--daemon.c b/builtin/fsmonitor--daemon.c
index 1593713f4cb..c54e736716a 100644
--- a/builtin/fsmonitor--daemon.c
+++ b/builtin/fsmonitor--daemon.c
@@ -1311,7 +1311,8 @@ static int fsmonitor_run_daemon(void)
 	strbuf_addstr(&state.path_gitdir_watch, "/.git");
 	if (!is_directory(state.path_gitdir_watch.buf)) {
 		strbuf_reset(&state.path_gitdir_watch);
-		strbuf_addstr(&state.path_gitdir_watch, absolute_path(get_git_dir()));
+		strbuf_addstr(&state.path_gitdir_watch,
+			      absolute_path(repo_get_git_dir(the_repository)));
 		state.nr_paths_watching = 2;
 	}
 
diff --git a/builtin/merge.c b/builtin/merge.c
index 662a49a0e8c..6c22912b63c 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -855,7 +855,8 @@ static void prepare_to_commit(struct commit_list *remoteheads)
 		if (invoked_hook)
 			discard_index(the_repository->index);
 	}
-	read_index_from(the_repository->index, index_file, get_git_dir());
+	read_index_from(the_repository->index, index_file,
+			repo_get_git_dir(the_repository));
 	strbuf_addbuf(&msg, &merge_msg);
 	if (squash)
 		BUG("the control must not reach here under --squash");
diff --git a/builtin/stash.c b/builtin/stash.c
index fcfd97972a4..ed56299098e 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -642,7 +642,7 @@ static int do_apply_stash(const char *prefix, struct stash_info *info,
 		strvec_pushf(&cp.env, GIT_WORK_TREE_ENVIRONMENT"=%s",
 			     absolute_path(get_git_work_tree()));
 		strvec_pushf(&cp.env, GIT_DIR_ENVIRONMENT"=%s",
-			     absolute_path(get_git_dir()));
+			     absolute_path(repo_get_git_dir(the_repository)));
 		strvec_push(&cp.args, "status");
 		run_command(&cp);
 	}
diff --git a/cache-tree.c b/cache-tree.c
index 50610c3f3cb..4e7ef7a7656 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -725,7 +725,8 @@ int write_index_as_tree(struct object_id *oid, struct index_state *index_state,
 
 	hold_lock_file_for_update(&lock_file, index_path, LOCK_DIE_ON_ERROR);
 
-	entries = read_index_from(index_state, index_path, get_git_dir());
+	entries = read_index_from(index_state, index_path,
+				  repo_get_git_dir(the_repository));
 	if (entries < 0) {
 		ret = WRITE_TREE_UNREADABLE_INDEX;
 		goto out;
diff --git a/config.c b/config.c
index 56b5862e59d..1733ba85dcd 100644
--- a/config.c
+++ b/config.c
@@ -6,6 +6,8 @@
  *
  */
 
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "abspath.h"
 #include "advice.h"
@@ -2212,7 +2214,7 @@ void read_early_config(config_fn_t cb, void *data)
 
 	if (have_git_dir()) {
 		opts.commondir = get_git_common_dir();
-		opts.git_dir = get_git_dir();
+		opts.git_dir = repo_get_git_dir(the_repository);
 	/*
 	 * When setup_git_directory() was not yet asked to discover the
 	 * GIT_DIR, we ask discover_git_directory() to figure out whether there
diff --git a/environment.c b/environment.c
index 1d6c48b52df..040b1ff1ba8 100644
--- a/environment.c
+++ b/environment.c
@@ -228,13 +228,6 @@ int have_git_dir(void)
 		|| the_repository->gitdir;
 }
 
-const char *get_git_dir(void)
-{
-	if (!the_repository->gitdir)
-		BUG("git environment hasn't been setup");
-	return the_repository->gitdir;
-}
-
 const char *get_git_common_dir(void)
 {
 	if (!the_repository->commondir)
@@ -352,7 +345,8 @@ static void update_relative_gitdir(const char *name UNUSED,
 				   const char *new_cwd,
 				   void *data UNUSED)
 {
-	char *path = reparent_relative_path(old_cwd, new_cwd, get_git_dir());
+	char *path = reparent_relative_path(old_cwd, new_cwd,
+					    repo_get_git_dir(the_repository));
 	struct tmp_objdir *tmp_objdir = tmp_objdir_unapply_primary_odb();
 
 	trace_printf_key(&trace_setup_key,
diff --git a/environment.h b/environment.h
index 0148738ed63..06d37d5c82b 100644
--- a/environment.h
+++ b/environment.h
@@ -106,7 +106,6 @@ int have_git_dir(void);
 extern int is_bare_repository_cfg;
 int is_bare_repository(void);
 extern char *git_work_tree_cfg;
-const char *get_git_dir(void);
 const char *get_git_common_dir(void);
 const char *get_object_directory(void);
 char *get_index_file(void);
diff --git a/pathspec.c b/pathspec.c
index fe1f0f41af0..416fe1e3dcc 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -497,7 +497,7 @@ static void init_pathspec_item(struct pathspec_item *item, unsigned flags,
 				    copyfrom);
 			hint_path = get_git_work_tree();
 			if (!hint_path)
-				hint_path = get_git_dir();
+				hint_path = repo_get_git_dir(the_repository);
 			die(_("%s: '%s' is outside repository at '%s'"), elt,
 			    copyfrom, absolute_path(hint_path));
 		}
diff --git a/read-cache.c b/read-cache.c
index 4e67dc182e7..c5794fbf2c9 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -3238,10 +3238,11 @@ static int should_delete_shared_index(const char *shared_index_path)
 static int clean_shared_index_files(const char *current_hex)
 {
 	struct dirent *de;
-	DIR *dir = opendir(get_git_dir());
+	DIR *dir = opendir(repo_get_git_dir(the_repository));
 
 	if (!dir)
-		return error_errno(_("unable to open git dir: %s"), get_git_dir());
+		return error_errno(_("unable to open git dir: %s"),
+				   repo_get_git_dir(the_repository));
 
 	while ((de = readdir(dir)) != NULL) {
 		const char *sha1_hex;
diff --git a/repository.c b/repository.c
index 9825a308993..6f43f2e8344 100644
--- a/repository.c
+++ b/repository.c
@@ -91,6 +91,13 @@ static void expand_base_dir(char **out, const char *in,
 		*out = xstrfmt("%s/%s", base_dir, def_in);
 }
 
+const char *repo_get_git_dir(struct repository *repo)
+{
+	if (!repo->gitdir)
+		BUG("git environment hasn't been setup");
+	return repo->gitdir;
+}
+
 static void repo_set_commondir(struct repository *repo,
 			       const char *commondir)
 {
diff --git a/repository.h b/repository.h
index af6ea0a62cd..cf2172c0aa5 100644
--- a/repository.h
+++ b/repository.h
@@ -206,6 +206,8 @@ struct repository {
 extern struct repository *the_repository;
 #endif
 
+const char *repo_get_git_dir(struct repository *repo);
+
 /*
  * Define a custom repository layout. Any field can be NULL, which
  * will default back to the path according to the default layout.
diff --git a/setup.c b/setup.c
index 29f86739212..4a9c60922e7 100644
--- a/setup.c
+++ b/setup.c
@@ -149,7 +149,7 @@ char *prefix_path(const char *prefix, int len, const char *path)
 	if (!r) {
 		const char *hint_path = get_git_work_tree();
 		if (!hint_path)
-			hint_path = get_git_dir();
+			hint_path = repo_get_git_dir(the_repository);
 		die(_("'%s' is outside repository at '%s'"), path,
 		    absolute_path(hint_path));
 	}
@@ -468,7 +468,7 @@ int is_nonbare_repository_dir(struct strbuf *path)
 int is_inside_git_dir(void)
 {
 	if (inside_git_dir < 0)
-		inside_git_dir = is_inside_dir(get_git_dir());
+		inside_git_dir = is_inside_dir(repo_get_git_dir(the_repository));
 	return inside_git_dir;
 }
 
@@ -1836,7 +1836,7 @@ void check_repository_format(struct repository_format *fmt)
 	struct repository_format repo_fmt = REPOSITORY_FORMAT_INIT;
 	if (!fmt)
 		fmt = &repo_fmt;
-	check_repository_format_gently(get_git_dir(), fmt, NULL);
+	check_repository_format_gently(repo_get_git_dir(the_repository), fmt, NULL);
 	startup_info->have_repository = 1;
 	repo_set_hash_algo(the_repository, fmt->hash_algo);
 	repo_set_compat_hash_algo(the_repository, fmt->compat_hash_algo);
@@ -2224,7 +2224,7 @@ static int create_default_files(const char *template_path,
 	 * shared-repository settings, we would need to fix them up.
 	 */
 	if (get_shared_repository()) {
-		adjust_shared_perm(get_git_dir());
+		adjust_shared_perm(repo_get_git_dir(the_repository));
 	}
 
 	initialize_repository_version(fmt->hash_algo, fmt->ref_storage_format, 0);
@@ -2434,12 +2434,12 @@ int init_db(const char *git_dir, const char *real_git_dir,
 			die(_("%s already exists"), real_git_dir);
 
 		set_git_dir(real_git_dir, 1);
-		git_dir = get_git_dir();
+		git_dir = repo_get_git_dir(the_repository);
 		separate_git_dir(git_dir, original_git_dir);
 	}
 	else {
 		set_git_dir(git_dir, 1);
-		git_dir = get_git_dir();
+		git_dir = repo_get_git_dir(the_repository);
 	}
 	startup_info->have_repository = 1;
 
diff --git a/setup.h b/setup.h
index cd8dbc24976..fd2df7cd525 100644
--- a/setup.h
+++ b/setup.h
@@ -176,7 +176,7 @@ int verify_repository_format(const struct repository_format *format,
 			     struct strbuf *err);
 
 /*
- * Check the repository format version in the path found in get_git_dir(),
+ * Check the repository format version in the path found in repo_get_git_dir(the_repository),
  * and die if it is a version we don't understand. Generally one would
  * set_git_dir() before calling this, and use it only for "are we in a valid
  * repo?".
diff --git a/trace.c b/trace.c
index 8669ddfca25..988b494a954 100644
--- a/trace.c
+++ b/trace.c
@@ -21,6 +21,8 @@
  *  along with this program; if not, see <https://www.gnu.org/licenses/>.
  */
 
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "abspath.h"
 #include "environment.h"
@@ -311,7 +313,7 @@ void trace_repo_setup(void)
 	if (!startup_info->prefix)
 		prefix = "(null)";
 
-	trace_printf_key(&trace_setup_key, "setup: git_dir: %s\n", quote_crnl(get_git_dir()));
+	trace_printf_key(&trace_setup_key, "setup: git_dir: %s\n", quote_crnl(repo_get_git_dir(the_repository)));
 	trace_printf_key(&trace_setup_key, "setup: git_common_dir: %s\n", quote_crnl(get_git_common_dir()));
 	trace_printf_key(&trace_setup_key, "setup: worktree: %s\n", quote_crnl(git_work_tree));
 	trace_printf_key(&trace_setup_key, "setup: cwd: %s\n", quote_crnl(cwd));
diff --git a/transport-helper.c b/transport-helper.c
index 09b3560ffdc..abe16eea651 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -143,7 +143,7 @@ static struct child_process *get_helper(struct transport *transport)
 
 	if (have_git_dir())
 		strvec_pushf(&helper->env, "%s=%s",
-			     GIT_DIR_ENVIRONMENT, get_git_dir());
+			     GIT_DIR_ENVIRONMENT, repo_get_git_dir(the_repository));
 
 	helper->trace2_child_class = helper->args.v[0]; /* "remote-<name>" */
 
diff --git a/worktree.c b/worktree.c
index 30a947426ee..11335c5d9a3 100644
--- a/worktree.c
+++ b/worktree.c
@@ -57,7 +57,7 @@ static void add_head_info(struct worktree *wt)
 
 static int is_current_worktree(struct worktree *wt)
 {
-	char *git_dir = absolute_pathdup(get_git_dir());
+	char *git_dir = absolute_pathdup(repo_get_git_dir(the_repository));
 	const char *wt_git_dir = get_worktree_git_dir(wt);
 	int is_current = !fspathcmp(git_dir, absolute_path(wt_git_dir));
 	free(git_dir);
@@ -171,7 +171,7 @@ struct worktree **get_worktrees(void)
 const char *get_worktree_git_dir(const struct worktree *wt)
 {
 	if (!wt)
-		return get_git_dir();
+		return repo_get_git_dir(the_repository);
 	else if (!wt->id)
 		return get_git_common_dir();
 	else
-- 
2.46.0.421.g159f2d50e7.dirty

