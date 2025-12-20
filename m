Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23963093DF
	for <git@vger.kernel.org>; Sat, 20 Dec 2025 10:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766225793; cv=pass; b=NMbpXBJXa5vUeZiVbiv8NWTkJNh0DV9TC0Nwx1FDveFhydq+AnZoEy91bMNaiHoyTAuR50rt2eiLgdaKl8+fIWOvvLkdppYtfCmtM6vEDWVv63B912kllAj/V3cIKbj5d43DDAq5cYMW1dTAT9JnJ9tEMLwU9nwNhqbn2T+DcgU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766225793; c=relaxed/simple;
	bh=TrpTj171YrS7xcB0vaasT+sJ9eg/rZ+BVz6Y5WO7eP8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oXxSyxfq/GIePLBaM+/7bUWzDhOums5bAKNlqWT/ExlDrgJEqlAj3PwLqDJobTIrpmG0YyLRpvr1i6p4QHWSJjliag0m0ORSU2abR/IGuJZWRX5Xoa3iGWpa2Xgyf29jccNMLAT11z2SXaiic8YFZWAIs4dSwa5KlWwFxb9037o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=lP0Y14EX; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="lP0Y14EX"
ARC-Seal: i=1; a=rsa-sha256; t=1766225743; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=hN4rMRz8hwaKdQoO7FPcZEMFOgtcTHYcY1XibNnDGpmKBmk9HBLlSh6E/ZuluPEckcnRAQGbmHm9QgkW71A15x7uAppSuUq8TwYTCe3pe5Tii51ri2RmMfL3siVr2jnYETlHFrVx6PgrdiXLxKmhYC5oyA+HgjOIor+YUN3fnKM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1766225743; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=7QGRa+oNSIwhHxztU52s4nHP/bEE5XTpVrTJTusYfrw=; 
	b=MNJ7Mc5YUr/kAhf7c6RQ1gWoSNZePPTpTek6eHzxOqtOImc3M1rhMqv3nfhiylvnZ7baFwobmqbsrWuIhSJCcmZ4aZXiwkbNz2sJTVl2xJiYnNBl6vveL2Q0kye0ToZ5zhmJCboOwXxe/RlIPO7qk/+SedyRwlthrMzZwfpJvHQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1766225743;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=7QGRa+oNSIwhHxztU52s4nHP/bEE5XTpVrTJTusYfrw=;
	b=lP0Y14EXbJD6+csQ3e3J9VfGCUC2rlK8XJ8I6ma5RTQj9ZC5Xr1Qh+b78kizu1xY
	0z5xS6Fu7HW9gxHtM66Mnqba1w2qQuirr0BrgH5p4M+6gMygMuMBJJLz+98fxalX5Xl
	VuEUergSkLMLXkR3o4lcAOi3Kz6TBsoxtsywaICw=
Received: by mx.zohomail.com with SMTPS id 1766225741413640.3122409643751;
	Sat, 20 Dec 2025 02:15:41 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: git@vger.kernel.org
Cc: Emily Shaffer <emilyshaffer@google.com>,
	Rodrigo Damazio Bovendorp <rdamazio@google.com>,
	Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Aaron Schrab <aaron@schrab.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Josh Steadmon <steadmon@google.com>,
	Ben Knoble <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Adrian Ratiu <adrian.ratiu@collabora.com>
Subject: [PATCH v7 00/11] Add submodulePathConfig extension and gitdir encoding
Date: Sat, 20 Dec 2025 12:15:17 +0200
Message-ID: <20251220101528.1227487-1-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Hello everyone,

For those new to the series, we're implementing a submodule gitdir
extension which allows us to have a unified way to determine gitdirs
and do things like encode submodule paths to avoid FS conflicts.

v7 addresses all feedback received in v6, containing just iterative
improvements to code, tests and documentation without any big design
changes this time.

Patches 1-6 implement the basic mechanisms of the new extension.
Patches 7-11 improve filesystem conflict detection and resolution.

As always, this is based on the latest master branch, I've checkd
for conflicts with next/seen, pushed to Github [1] and succesfully
ran the CI [2].

1: https://github.com/10ne1/git/tree/dev/aratiu/encoding-v7
2: https://github.com/10ne1/git/actions/runs/20384003122

Changes in v7:
* Simplified submodule_name_to_gitdir() code structure. Logically it still is
  the same like in v6, just easier to read. (Patrick)
* Reworked the global config to enable the extension only for new repos
  during clone and init operations (Patrick, Junio)
* Improved validation of existing submodules with encoded names (Josh, Emily)
* Added more tests for init, clone w/o --recurse-submodules and a conflict (Josh)
* Migration command creates gitdir configs before enabling the extension (Patrick)
* Reworded and reformatted the extension doc (Junio, Ben)
* Reworded submodule.<name>.gitdir documentation for clarity (Patrick)
* Added references to extensions.submodulePathConfig in error msgs (Junio, Patrick)
* Minor whitespace fixes and others nits (Patrick)

Range-diff v6 -> v7:
 1:  a6024a7569 =  1:  a6024a7569 submodule--helper: use submodule_name_to_gitdir in add_submodule
 2:  59058180eb =  2:  59058180eb submodule: always validate gitdirs inside submodule_name_to_gitdir
 3:  b685f4f9ff =  3:  b685f4f9ff builtin/submodule--helper: add gitdir command
 4:  0247c28cbc !  4:  a5d6db00ac submodule: introduce extensions.submodulePathConfig
    @@ Documentation/config/extensions.adoc: relativeWorktrees:::
      	`worktree.useRelativePaths` config set to `true`.
      
     +submodulePathConfig:::
    -+	If enabled, the submodule.<name>.gitdir config is the single source of
    -+	truth for submodule gitdir paths and is always set for new submodules.
    -+	Git will error if a module does not have submodule.<name>.gitdir set.
    -+	Existing pre-extension submodules need to be migrated by adding the
    -+	missing config entries. This is done manually for now, e.g. for each
    -+	submodule: "git config submodule.<name>.gitdir .git/modules/<name>".
    ++	This extension is for the minority of users who:
    +++
    ++--
    ++* Encounter errors like	`refusing to create ... in another submodule's git dir`
    ++  due to a number of reasons, like case-insensitive filesystem conflicts when
    ++  creating modules named `foo` and `Foo`.
    ++* Require more flexible submodule layouts, for example due to nested names like
    ++  `foo`, `foo/bar` and `foo/baz` not supported by the default gitdir mechanism
    ++  which uses `.git/modules/<plain-name>` locations, causing further conflicts.
    ++--
    +++
    ++When `extensions.submodulePathConfig` is enabled, the `submodule.<name>.gitdir`
    ++config becomes the single source of truth for all submodule gitdir paths and is
    ++automatically set for all new submodules both during clone and init operations.
    +++
    ++Git will error out if a module does not have a corresponding
    ++`submodule.<name>.gitdir` set.
    +++
    ++Existing (pre-extension) submodules need to be migrated by adding the missing
    ++config entries. This is done manually for now, e.g. for each submodule:
    ++`git config submodule.<name>.gitdir .git/modules/<name>`.
     +
      worktreeConfig:::
      	If enabled, then worktrees will load config settings from the
    @@ Documentation/config/submodule.adoc: submodule.<name>.active::
      	details.
      
     +submodule.<name>.gitdir::
    -+	This sets the gitdir path for submodule <name>. It only works when
    -+	`extensions.submodulePathConfig` is enabled, otherwise it does nothing.
    -+	When the extension is enabled, this config is the single source of truth
    -+	for submodule gitdir paths and git will throw an error if it is missing.
    ++	This sets the gitdir path for submodule <name>. This configuration is
    ++	respected when `extensions.submodulePathConfig` is enabled, otherwise it
    ++	has no effect. When enabled, this config becomes the single source of
    ++	truth for submodule gitdir paths and git will error if it is missing.
     +	See linkgit:git-config[1] for details.
     +
      submodule.active::
    @@ builtin/submodule--helper.c: struct init_cb {
     +
     +	 key = xstrfmt("submodule.%s.gitdir", submodule_name);
     +
    -+	 /* Nothing to do if the config already exists. */
    ++	/* Nothing to do if the config already exists. */
     +	if (!repo_config_get_string_tmp(the_repository, key, &value)) {
     +		free(key);
     +		return 0;
    @@ builtin/submodule--helper.c: struct init_cb {
     +{
     +	struct strbuf gitdir_path = STRBUF_INIT;
     +
    -+	/* The config is set only when extensions.submodulePathConfig is enabled */
    -+	if (!the_repository->repository_format_submodule_path_cfg)
    -+		return;
    -+
     +	repo_git_path_append(the_repository, &gitdir_path, "modules/%s", submodule_name);
     +	if (!validate_and_set_submodule_gitdir(&gitdir_path, submodule_name)) {
     +		strbuf_release(&gitdir_path);
    @@ builtin/submodule--helper.c: static void init_submodule(const char *path, const
      			die(_("Failed to register update mode for submodule path '%s'"), displaypath);
      	}
     +
    -+	create_default_gitdir_config(sub->name);
    ++	if (the_repository->repository_format_submodule_path_cfg)
    ++		create_default_gitdir_config(sub->name);
     +
      	strbuf_release(&sb);
      	free(displaypath);
      	free(url);
    +@@ builtin/submodule--helper.c: static int clone_submodule(const struct module_clone_data *clone_data,
    + 		char *head = xstrfmt("%s/HEAD", sm_gitdir);
    + 		unlink(head);
    + 		free(head);
    +-		die(_("refusing to create/use '%s' in another submodule's "
    +-		      "git dir"), sm_gitdir);
    ++		die(_("refusing to create/use '%s' in another submodule's git dir. "
    ++		      "Enabling extensions.submodulePathConfig should fix this."),
    ++		    sm_gitdir);
    + 	}
    + 
    + 	connect_work_tree_and_git_dir(clone_data_path, sm_gitdir, 0);
     @@ builtin/submodule--helper.c: static int module_add(int argc, const char **argv, const char *prefix,
      	add_data.progress = !!progress;
      	add_data.dissociate = !!dissociate;
      
    -+	create_default_gitdir_config(add_data.sm_name);
    ++	if (the_repository->repository_format_submodule_path_cfg)
    ++		create_default_gitdir_config(add_data.sm_name);
     +
      	if (add_submodule(&add_data))
      		goto cleanup;
    @@ setup.h: struct repository_format {
      	int compat_hash_algo;
     
      ## submodule.c ##
    +@@ submodule.c: int submodule_move_head(const char *path, const char *super_prefix,
    + 				if (validate_submodule_git_dir(git_dir,
    + 							       sub->name) < 0)
    + 					die(_("refusing to create/use '%s' in "
    +-					      "another submodule's git dir"),
    +-					    git_dir);
    ++					      "another submodule's git dir. "
    ++					      "Enabling extensions.submodulePathConfig "
    ++					      "should fix this."), git_dir);
    + 				free(git_dir);
    + 			}
    + 		} else {
     @@ submodule.c: int submodule_to_gitdir(struct repository *repo,
      void submodule_name_to_gitdir(struct strbuf *buf, struct repository *r,
      			      const char *submodule_name)
    @@ submodule.c: int submodule_to_gitdir(struct repository *repo,
     -	 */
     -	repo_git_path_append(r, buf, "modules/");
     -	strbuf_addstr(buf, submodule_name);
    -+	const char *gitdir;
    -+	char *key;
    -+	int ret;
    -+
    -+	/* If extensions.submodulePathConfig is disabled, continue to use the plain path */
     +	if (!r->repository_format_submodule_path_cfg) {
    ++		/*
    ++		 * If extensions.submodulePathConfig is disabled,
    ++		 * continue to use the plain path.
    ++		 */
     +		repo_git_path_append(r, buf, "modules/%s", submodule_name);
    -+		if (validate_submodule_git_dir(buf->buf, submodule_name) < 0)
    -+			die(_("refusing to create/use '%s' in another submodule's "
    -+			      "git dir"), buf->buf);
    ++	} else {
    ++		const char *gitdir;
    ++		char *key;
    ++		int ret;
    ++
    ++		/* Otherwise the extension is enabled, so use the gitdir config. */
    ++		key = xstrfmt("submodule.%s.gitdir", submodule_name);
    ++		ret = repo_config_get_string_tmp(r, key, &gitdir);
    ++		FREE_AND_NULL(key);
    ++
    ++		if (ret)
    ++			die(_("the 'submodule.%s.gitdir' config does not exist for module '%s'. "
    ++			      "Please ensure it is set, for example by running something like: "
    ++			      "'git config submodule.%s.gitdir .git/modules/%s'. For details "
    ++			      "see the extensions.submodulePathConfig documentation."),
    ++			    submodule_name, submodule_name, submodule_name, submodule_name);
     +
    -+		return; /* plain gitdir is valid for use */
    -+	}
    -+
    -+	/* Extension is enabled: use the gitdir config if it exists */
    -+	key = xstrfmt("submodule.%s.gitdir", submodule_name);
    -+	ret = repo_config_get_string_tmp(r, key, &gitdir);
    -+	FREE_AND_NULL(key);
    -+
    -+	if (!ret) {
     +		strbuf_addstr(buf, gitdir);
    -+
    -+		/* validate because users might have modified the config */
    -+		if (validate_submodule_git_dir(buf->buf, submodule_name))
    -+			die(_("invalid 'submodule.%s.gitdir' config: '%s' please check "
    -+			      "if it is unique or conflicts with another module"),
    -+			    submodule_name, gitdir);
    -+
    -+		return; /* gitdir from config is valid for use */
     +	}
      
     -	if (validate_submodule_git_dir(buf->buf, submodule_name) < 0)
     -		die(_("refusing to create/use '%s' in another submodule's "
     -		      "git dir"), buf->buf);
    -+	die(_("the 'submodule.%s.gitdir' config does not exist for module '%s'. "
    -+	      "Please ensure it is set, for example by running something like: "
    -+	      "'git config submodule.%s.gitdir .git/modules/%s'"),
    -+	    submodule_name, submodule_name, submodule_name, submodule_name);
    ++	/* validate because users might have modified the config */
    ++	if (validate_submodule_git_dir(buf->buf, submodule_name))
    ++		die(_("invalid 'submodule.%s.gitdir' config: '%s' please check "
    ++		      "if it is unique or conflicts with another module"),
    ++		    submodule_name, buf->buf);
      }
     
      ## t/lib-verify-submodule-gitdir-path.sh (new) ##
 5:  486dd2c45c <  -:  ---------- submodule: allow runtime enabling extensions.submodulePathConfig
 -:  ---------- >  5:  6ee88ee00a submodule: allow runtime enabling extensions.submodulePathConfig
 6:  9d5e050701 !  6:  7f93a5cee0 submodule--helper: add gitdir migration command
    @@ Commit message
         Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
     
      ## Documentation/config/extensions.adoc ##
    -@@ Documentation/config/extensions.adoc: submodulePathConfig:::
    - 	This extension can also be enabled as a global runtime config, with
    - 	the local repository config having precedence (overwrites it).
    - 	Existing pre-extension submodules need to be migrated by adding the
    --	missing config entries. This is done manually for now, e.g. for each
    --	submodule: "git config submodule.<name>.gitdir .git/modules/<name>".
    -+	missing config entries. This can be done manually, e.g. for each
    -+	submodule: "git config submodule.<name>.gitdir .git/modules/<name>",
    -+	or via the "git submodule--helper migrate-gitdir-configs" command
    -+	which iterates over all submodules and attempts to migrate them.
    - 
    - worktreeConfig:::
    - 	If enabled, then worktrees will load config settings from the
    +@@ Documentation/config/extensions.adoc: Git will error out if a module does not have a corresponding
    + `submodule.<name>.gitdir` set.
    + +
    + Existing (pre-extension) submodules need to be migrated by adding the missing
    +-config entries. This is done manually for now, e.g. for each submodule:
    +-`git config submodule.<name>.gitdir .git/modules/<name>`.
    ++config entries. This can be done manually, e.g. for each submodule:
    ++`git config submodule.<name>.gitdir .git/modules/<name>`, or via the
    ++`git submodule--helper migrate-gitdir-configs` command which iterates over all
    ++submodules and attempts to migrate them.
    + +
    + The extension can be enabled automatically for new repositories by setting
    + `init.autoSetupSubmodulePathConfig` to `true`, for example by running
     
      ## builtin/submodule--helper.c ##
     @@ builtin/submodule--helper.c: static int module_gitdir(int argc, const char **argv, const char *prefix UNUSED,
    @@ builtin/submodule--helper.c: static int module_gitdir(int argc, const char **arg
     +	DIR *dir;
     +	struct dirent *de;
     +
    -+	if (repo_config_set_gently(repo, "core.repositoryformatversion", "1"))
    -+		die(_("could not set core.repositoryformatversion to 1. "
    -+		      "Please enable it for migration to work, for example: "
    -+		      "git config core.repositoryformatversion 1"));
    -+
    -+	if (repo_config_set_gently(repo, "extensions.submodulePathConfig", "true"))
    -+		die(_("could not enable submodulePathConfig extension. It is required "
    -+		      "for migration to work. Please enable it in the root repo: "
    -+		      "git config extensions.submodulePathConfig true"));
    -+
    -+	repo->repository_format_submodule_path_cfg = 1;
    -+
     +	repo_git_path_append(repo, &module_dir, "modules/");
     +
     +	dir = opendir(module_dir.buf);
    @@ builtin/submodule--helper.c: static int module_gitdir(int argc, const char **arg
     +	closedir(dir);
     +	strbuf_release(&module_dir);
     +
    ++	if (repo_config_set_gently(repo, "core.repositoryformatversion", "1"))
    ++		die(_("could not set core.repositoryformatversion to 1. "
    ++		      "Please enable it for migration to work, for example: "
    ++		      "git config core.repositoryformatversion 1"));
    ++
    ++	if (repo_config_set_gently(repo, "extensions.submodulePathConfig", "true"))
    ++		die(_("could not enable submodulePathConfig extension. It is required "
    ++		      "for migration to work. Please enable it in the root repo: "
    ++		      "git config extensions.submodulePathConfig true"));
    ++
    ++	repo->repository_format_submodule_path_cfg = 1;
    ++
     +	return 0;
     +}
     +
    @@ builtin/submodule--helper.c: int cmd_submodule__helper(int argc,
      		OPT_SUBCOMMAND("add", &fn, module_add),
     
      ## t/t7425-submodule-gitdir-path-extension.sh ##
    -@@ t/t7425-submodule-gitdir-path-extension.sh: test_expect_success 'runtime config extensions.submodulePathConfig on existing r
    - 	)
    +@@ t/t7425-submodule-gitdir-path-extension.sh: test_expect_success '`git clone --recurse-submodules` respects init.autoSetupSub
    + 	git config --global --unset init.autoSetupSubmodulePathConfig
      '
      
     +test_expect_success 'submodule--helper migrates legacy modules' '
    -+	git init sm-repo-1 &&
    -+	test_commit -C sm-repo-1 initial-1 &&
    -+	git init sm-repo-2 &&
    -+	test_commit -C sm-repo-2 initial-2 &&
    -+
    -+	# ensure the global config is disabled so we can actually test migration
    -+	git config --global extensions.submodulePathConfig false &&
    -+
    -+	git init -b main migrate-test &&
     +	(
    -+		cd migrate-test &&
    -+
    -+		git submodule add ../sm-repo-1 sub1 &&
    -+		git submodule add ../sm-repo-2 sub2 &&
    -+		test_commit add-submodules &&
    ++		cd upstream &&
     +
    -+		# gitdir configs should not exist
    ++		# previous submodules exist and were not migrated yet
     +		test_must_fail git config submodule.sub1.gitdir &&
     +		test_must_fail git config submodule.sub2.gitdir &&
    ++		test_path_is_dir .git/modules/sub1 &&
    ++		test_path_is_dir .git/modules/sub2 &&
     +
    ++		# run migration
     +		git submodule--helper migrate-gitdir-configs &&
     +
    -+		# gitdir configs must exist after migration
    ++		# test that migration worked
     +		git config submodule.sub1.gitdir >actual &&
     +		echo ".git/modules/sub1" >expect &&
     +		test_cmp expect actual &&
    -+
     +		git config submodule.sub2.gitdir >actual &&
     +		echo ".git/modules/sub2" >expect &&
    ++		test_cmp expect actual &&
    ++
    ++		# repository extension is enabled after migration
    ++		git config extensions.submodulePathConfig > actual &&
    ++		echo "true" > expect &&
     +		test_cmp expect actual
     +	)
     +'
    ++
    ++test_expect_success '`git clone --recurse-submodules` works after migration' '
    ++	test_when_finished "rm -rf repo-clone-recursive" &&
    ++
    ++	# test with extension disabled after the upstream repo was migrated
    ++	git clone --recurse-submodules upstream repo-clone-recursive &&
    ++	(
    ++		cd repo-clone-recursive &&
    ++
    ++		# init.autoSetupSubmodulePathConfig was disabled before clone, so
    ++		# the repo extension config should also be off, the migration ignored
    ++		test_must_fail git config extensions.submodulePathConfig &&
    ++
    ++		# modules should look like there was no migration done
    ++		test_must_fail git config submodule.sub1.gitdir &&
    ++		test_must_fail git config submodule.sub2.gitdir &&
    ++		test_path_is_dir .git/modules/sub1 &&
    ++		test_path_is_dir .git/modules/sub2
    ++	) &&
    ++	rm -rf repo-clone-recursive &&
    ++
    ++	# enable the extension, then retry the clone
    ++	git config --global init.autoSetupSubmodulePathConfig true &&
    ++	git clone --recurse-submodules upstream repo-clone-recursive &&
    ++	(
    ++		cd repo-clone-recursive &&
    ++
    ++		# repository extension is enabled
    ++		git config extensions.submodulePathConfig > actual &&
    ++		echo "true" > expect &&
    ++		test_cmp expect actual &&
    ++
    ++		# gitdir configs exist for submodules
    ++		git config submodule.sub1.gitdir &&
    ++		git config submodule.sub2.gitdir &&
    ++		test_path_is_dir .git/modules/sub1 &&
    ++		test_path_is_dir .git/modules/sub2
    ++	)
    ++'
     +
      test_done
 7:  a164370edc =  7:  2e55521bbf builtin/credential-store: move is_rfc3986_unreserved to url.[ch]
 8:  94f785817a !  8:  7fd920aa70 submodule--helper: fix filesystem collisions by encoding gitdir paths
    @@ builtin/submodule--helper.c
      #define OPT_QUIET (1 << 0)
      #define OPT_CACHED (1 << 1)
     @@ builtin/submodule--helper.c: static void create_default_gitdir_config(const char *submodule_name)
    - 	    !submodule_path_config_enabled)
    - 		return;
    + {
    + 	struct strbuf gitdir_path = STRBUF_INIT;
      
     +	/* Case 1: try the plain module name */
      	repo_git_path_append(the_repository, &gitdir_path, "modules/%s", submodule_name);
    @@ submodule.c
      #include "setup.h"
     +#include "url.h"
      
    - int submodule_path_config_enabled;
    - 
    + static int config_update_recurse_submodules = RECURSE_SUBMODULES_OFF;
    + static int initialized_fetch_ref_tips;
     @@ submodule.c: int submodule_move_head(const char *path, const char *super_prefix,
      	return ret;
      }
    @@ submodule.c: int validate_submodule_git_dir(char *git_dir, const char *submodule
      	char *p = xstrdup(path);
     
      ## t/t7425-submodule-gitdir-path-extension.sh ##
    -@@ t/t7425-submodule-gitdir-path-extension.sh: test_expect_success 'submodule--helper migrates legacy modules' '
    +@@ t/t7425-submodule-gitdir-path-extension.sh: test_expect_success '`git clone --recurse-submodules` works after migration' '
      	)
      '
      
    @@ t/t7425-submodule-gitdir-path-extension.sh: test_expect_success 'submodule--help
     +	(
     +		cd clone_nested &&
     +		# disable extension and verify failure
    -+		git config extensions.submodulePathConfig false &&
    ++		git config --replace-all extensions.submodulePathConfig false &&
     +		test_must_fail git submodule add ./thing2 hippo/foobar &&
     +		# re-enable extension and verify it works
    -+		git config extensions.submodulePathConfig true &&
    ++		git config --replace-all extensions.submodulePathConfig true &&
     +		git submodule add ./thing2 hippo/foobar
     +	)
     +'
 9:  0061979221 =  9:  e21656aad4 submodule: fix case-folding gitdir filesystem collisions
10:  6d71434f39 ! 10:  9e3da1c585 submodule: hash the submodule name for the gitdir path
    @@ builtin/submodule--helper.c: static int validate_and_set_submodule_gitdir(struct
     +	unsigned char raw_name_hash[GIT_MAX_RAWSZ];
     +	int header_len;
      
    - 	/* The config is set only when extensions.submodulePathConfig is enabled */
    - 	if (!the_repository->repository_format_submodule_path_cfg &&
    + 	/* Case 1: try the plain module name */
    + 	repo_git_path_append(the_repository, &gitdir_path, "modules/%s", submodule_name);
     @@ builtin/submodule--helper.c: static void create_default_gitdir_config(const char *submodule_name)
      			return;
      	}
 -:  ---------- > 11:  56bca88799 submodule: detect conflicts with existing gitdir configs

Adrian Ratiu (11):
  submodule--helper: use submodule_name_to_gitdir in add_submodule
  submodule: always validate gitdirs inside submodule_name_to_gitdir
  builtin/submodule--helper: add gitdir command
  submodule: introduce extensions.submodulePathConfig
  submodule: allow runtime enabling extensions.submodulePathConfig
  submodule--helper: add gitdir migration command
  builtin/credential-store: move is_rfc3986_unreserved to url.[ch]
  submodule--helper: fix filesystem collisions by encoding gitdir paths
  submodule: fix case-folding gitdir filesystem collisions
  submodule: hash the submodule name for the gitdir path
  submodule: detect conflicts with existing gitdir configs

 Documentation/config/extensions.adoc       |  29 ++
 Documentation/config/init.adoc             |   6 +
 Documentation/config/submodule.adoc        |   7 +
 builtin/credential-store.c                 |   7 +-
 builtin/submodule--helper.c                | 201 +++++++-
 repository.c                               |   1 +
 repository.h                               |   1 +
 setup.c                                    |  19 +-
 setup.h                                    |   1 +
 submodule.c                                | 219 +++++++--
 t/lib-verify-submodule-gitdir-path.sh      |  24 +
 t/meson.build                              |   1 +
 t/t7425-submodule-gitdir-path-extension.sh | 508 +++++++++++++++++++++
 t/t9902-completion.sh                      |   1 +
 url.c                                      |  13 +
 url.h                                      |  14 +
 16 files changed, 1000 insertions(+), 52 deletions(-)
 create mode 100644 t/lib-verify-submodule-gitdir-path.sh
 create mode 100755 t/t7425-submodule-gitdir-path-extension.sh

-- 
2.51.2

