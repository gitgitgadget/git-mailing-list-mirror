Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6FB125A9
	for <git@vger.kernel.org>; Wed,  7 Jan 2026 23:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767826976; cv=pass; b=jxrJdCW0BQfK9OW0zI83mEAQy14CAMDqzT6o48ZIjbUEocj4MBipGbtm8jZ28sOGR/OjSL3Lp7TWZrBQgHJhW045K0WraUeCDXCQnAMpXt3UDO+DiOiaaGPJLbjVju7fNn/FDbGUL9VbiZiWLXWCF2K2Wc+2OLS+h68GCnJq220=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767826976; c=relaxed/simple;
	bh=NMlvLxTxAUl5x+ZUqank/zq73lzEhnjV2kiOouH2B2o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OFG9Pq1OPmHHT6425ZudfmAdU2KpCouVZC6VkgYyoBlp6XrcvBW8JNRo7ofGzZUtxIUHwGDQhv+eY7UYqRfU66CGYS6niFLr2qx+iISEWabU5TG944cTXTtjgItY0pdK4JRnqN0ZeJnZugBmh223IGX+1GHmcQe/kvgYNp6ZURk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=WdHtjnv5; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="WdHtjnv5"
ARC-Seal: i=1; a=rsa-sha256; t=1767826956; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=KFiaaou7HefzCe88f5xYDpvHzh3PpC5zFliCRG1ryUt/FmuuGHIvfLA/afQUyA+p/JT9dzlIDU/Xz7SqMm01jXwDR0ZVUf85CcKO8XdTlDKS3rzoL2xT/or6j9a5V/Zh7WraP8XlBCRTXw+vdDHjH/23z5nX9g8/e1bPHNJbooM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1767826956; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=AeK0tUsoeQ3vsY5rQYbRYwlg3ZrXDxaRrjs9faiRUxc=; 
	b=DSTT3HV+8WAYJszq37bP74dXgvdmfwow0fqg8AbpJwHOGSWvln3vuXQs5rARI8UftgwtU+UWBT/tSmIPoDsjBqJQgOMYF8KQ/+9ebvBxnvLEqWt99TDsRmev96BpEjXzWRxp6F00lolL7iwBN7BOg14jquV8x5n3wz84qNzGz18=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1767826956;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=AeK0tUsoeQ3vsY5rQYbRYwlg3ZrXDxaRrjs9faiRUxc=;
	b=WdHtjnv5/kYJWXAInvM9e45hVU6Nw5YtJElSKJPB6kboIn55bV77xxgIw0TofGqN
	2mPK0/zXRdoZXpyhK/gqYG879RLaxVbxB6quV12hn2MirN+DmxhqgC1eIzhkKNWrVyL
	JK8Lir//YgDGErVabpFYXLb9E0mgIEnMj+iumvQw=
Received: by mx.zohomail.com with SMTPS id 1767826954577456.8929128633065;
	Wed, 7 Jan 2026 15:02:34 -0800 (PST)
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
Subject: [PATCH v8 00/11] Add submodulePathConfig extension and gitdir encoding
Date: Thu,  8 Jan 2026 01:01:34 +0200
Message-ID: <20260107230145.517562-1-adrian.ratiu@collabora.com>
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

v8 addresses nits and small code improvements, no more design changes
as the series is quieting down. Most of the range-diff is whitespace
fixes this time. :)

Patches 1-6 implement the basic mechanisms of the new extension.
Patches 7-11 improve filesystem conflict detection and resolution.

As always, this is based on the latest master branch, I've checkd
for conflicts with next/seen, pushed to Github [1] and succesfully
ran the CI [2].

1: https://github.com/10ne1/git/tree/dev/aratiu/encoding-v8
2: https://github.com/10ne1/git/actions/runs/20798198092

Changes in v8:
* Added a new test to ensure gitdir config path is relative (Patrick)
* Improved gitdir validation error message and added advice (Patrick)
* Renamed init.autoSetupSubmodulePathConfig to init.defaultSubmodulePathConfig
  and moved its init logic to initialize_repository_version() (Patrick)
* repositoryformatversion is only set to 1 if it's 0, so it doesn't
  overwrite potential future higher versions (Patrick)
* Fixed global init.defaultSubmodulePathConfig leak between tests (Adrian)
* Whitespace and other minor fixes (Junio, Patrick)

Range-diff between v7 -> v8:
 1:  87bdd023f8 =  1:  5aae0df74b submodule--helper: use submodule_name_to_gitdir in add_submodule
 2:  8ea022eb6f =  2:  041d921487 submodule: always validate gitdirs inside submodule_name_to_gitdir
 3:  2092faf443 =  3:  12ff77be2d builtin/submodule--helper: add gitdir command
 4:  b72e8d3610 !  4:  faaea085d2 submodule: introduce extensions.submodulePathConfig
    @@ Documentation/config/extensions.adoc: relativeWorktrees:::
     +	This extension is for the minority of users who:
     ++
     +--
    -+* Encounter errors like	`refusing to create ... in another submodule's git dir`
    ++* Encounter errors like `refusing to create ... in another submodule's git dir`
     +  due to a number of reasons, like case-insensitive filesystem conflicts when
     +  creating modules named `foo` and `Foo`.
     +* Require more flexible submodule layouts, for example due to nested names like
    @@ Documentation/config/submodule.adoc: submodule.<name>.active::
     +	This sets the gitdir path for submodule <name>. This configuration is
     +	respected when `extensions.submodulePathConfig` is enabled, otherwise it
     +	has no effect. When enabled, this config becomes the single source of
    -+	truth for submodule gitdir paths and git will error if it is missing.
    ++	truth for submodule gitdir paths and Git will error if it is missing.
     +	See linkgit:git-config[1] for details.
     +
      submodule.active::
    @@ builtin/submodule--helper.c: struct init_cb {
     +	if (validate_submodule_git_dir(gitdir_path->buf, submodule_name))
     +		return -1;
     +
    -+	 key = xstrfmt("submodule.%s.gitdir", submodule_name);
    ++	key = xstrfmt("submodule.%s.gitdir", submodule_name);
     +
     +	/* Nothing to do if the config already exists. */
     +	if (!repo_config_get_string_tmp(the_repository, key, &value)) {
    @@ setup.h: struct repository_format {
      	int compat_hash_algo;
     
      ## submodule.c ##
    +@@
    + #include "commit-reach.h"
    + #include "read-cache-ll.h"
    + #include "setup.h"
    ++#include "advice.h"
    + 
    + static int config_update_recurse_submodules = RECURSE_SUBMODULES_OFF;
    + static int initialized_fetch_ref_tips;
     @@ submodule.c: int submodule_move_head(const char *path, const char *super_prefix,
      				if (validate_submodule_git_dir(git_dir,
      							       sub->name) < 0)
    @@ submodule.c: int submodule_to_gitdir(struct repository *repo,
     +		const char *gitdir;
     +		char *key;
     +		int ret;
    -+
    + 
    +-	if (validate_submodule_git_dir(buf->buf, submodule_name) < 0)
     +		/* Otherwise the extension is enabled, so use the gitdir config. */
     +		key = xstrfmt("submodule.%s.gitdir", submodule_name);
     +		ret = repo_config_get_string_tmp(r, key, &gitdir);
    @@ submodule.c: int submodule_to_gitdir(struct repository *repo,
     +
     +		strbuf_addstr(buf, gitdir);
     +	}
    - 
    --	if (validate_submodule_git_dir(buf->buf, submodule_name) < 0)
    --		die(_("refusing to create/use '%s' in another submodule's "
    --		      "git dir"), buf->buf);
    ++
     +	/* validate because users might have modified the config */
    -+	if (validate_submodule_git_dir(buf->buf, submodule_name))
    -+		die(_("invalid 'submodule.%s.gitdir' config: '%s' please check "
    -+		      "if it is unique or conflicts with another module"),
    -+		    submodule_name, buf->buf);
    ++	if (validate_submodule_git_dir(buf->buf, submodule_name)) {
    ++		advise(_("enabling extensions.submodulePathConfig might fix the "
    ++			 "following error, if it's not already enabled."));
    + 		die(_("refusing to create/use '%s' in another submodule's "
    +-		      "git dir"), buf->buf);
    ++		      " git dir."), buf->buf);
    ++	}
      }
     
      ## t/lib-verify-submodule-gitdir-path.sh (new) ##
    @@ t/lib-verify-submodule-gitdir-path.sh (new)
     +# might or might not exist (e.g. when adding a new submodule), so this only
     +# checks the expected configuration path, which might be overridden by the user.
     +
    -+verify_submodule_gitdir_path() {
    ++verify_submodule_gitdir_path () {
     +	repo="$1" &&
     +	name="$2" &&
     +	path="$3" &&
    @@ t/t7425-submodule-gitdir-path-extension.sh (new)
     +'
     +
     +test_expect_success 'verify new submodule gitdir config' '
    -+	git -C main config submodule."New Sub".gitdir > actual &&
    -+	echo ".git/modules/New Sub" > expect &&
    ++	git -C main config submodule."New Sub".gitdir >actual &&
    ++	echo ".git/modules/New Sub" >expect &&
     +	test_cmp expect actual &&
     +	verify_submodule_gitdir_path main "New Sub" "modules/New Sub"
     +'
    @@ t/t7425-submodule-gitdir-path-extension.sh (new)
     +	# was added before the extension was enabled. Add and test it.
     +	test_must_fail git -C main config submodule.legacy.gitdir &&
     +	git -C main config submodule.legacy.gitdir .git/modules/legacy &&
    -+	git -C main config submodule.legacy.gitdir > actual &&
    -+	echo ".git/modules/legacy" > expect &&
    ++	git -C main config submodule.legacy.gitdir >actual &&
    ++	echo ".git/modules/legacy" >expect &&
     +	test_cmp expect actual &&
     +	verify_submodule_gitdir_path main "legacy" "modules/legacy"
     +'
     +
    ++test_expect_success 'gitdir config path is relative for both absolute and relative urls' '
    ++	test_when_finished "rm -rf relative-cfg-path-test" &&
    ++	git init -b main relative-cfg-path-test &&
    ++	(
    ++		cd relative-cfg-path-test &&
    ++		git config core.repositoryformatversion 1 &&
    ++		git config extensions.submodulePathConfig true &&
    ++
    ++		# Test with absolute URL
    ++		git submodule add "$TRASH_DIRECTORY/new-sub" sub-abs &&
    ++		git config submodule.sub-abs.gitdir >actual &&
    ++		echo ".git/modules/sub-abs" >expect &&
    ++		test_cmp expect actual &&
    ++
    ++		# Test with relative URL
    ++		git submodule add ../new-sub sub-rel &&
    ++		git config submodule.sub-rel.gitdir >actual &&
    ++		echo ".git/modules/sub-rel" >expect &&
    ++		test_cmp expect actual
    ++	)
    ++'
    ++
     +test_expect_success 'clone from repo with both legacy and new-style submodules' '
     +	git clone --recurse-submodules main cloned-non-extension &&
     +	(
 5:  8017e1ca16 !  5:  3a65c86a38 submodule: allow runtime enabling extensions.submodulePathConfig
    @@ Metadata
      ## Commit message ##
         submodule: allow runtime enabling extensions.submodulePathConfig
     
    -    Add a new config `init.autoSetupSubmodulePathConfig` which allows
    +    Add a new config `init.defaultSubmodulePathConfig` which allows
         enabling `extensions.submodulePathConfig` for new submodules by
         default (those created via git init or clone).
     
    -    Important: setting init.autoSetupSubmodulePathConfig = true does
    +    Important: setting init.defaultSubmodulePathConfig = true does
         not globally enable `extensions.submodulePathConfig`. Existing
         repositories will still have the extension disabled and will
         require migration (for example via git submodule--helper command
    @@ Documentation/config/extensions.adoc: Git will error out if a module does not ha
      `git config submodule.<name>.gitdir .git/modules/<name>`.
     ++
     +The extension can be enabled automatically for new repositories by setting
    -+`init.autoSetupSubmodulePathConfig` to `true`, for example by running
    -+`git config --global init.autoSetupSubmodulePathConfig true`.
    ++`init.defaultSubmodulePathConfig` to `true`, for example by running
    ++`git config --global init.defaultSubmodulePathConfig true`.
      
      worktreeConfig:::
      	If enabled, then worktrees will load config settings from the
    @@ Documentation/config/init.adoc: endif::[]
      	option and the `GIT_DEFAULT_REF_FORMAT` environment variable take
      	precedence over this config.
     +
    -+init.autoSetupSubmodulePathConfig::
    ++init.defaultSubmodulePathConfig::
     +	A boolean that specifies if `git init` and `git clone` should
     +	automatically set `extensions.submodulePathConfig` to `true`. This
     +	allows all new repositories to automatically use the submodule path
     +	extension. Defaults to `false` when unset.
     
      ## setup.c ##
    -@@ setup.c: int init_db(const char *git_dir, const char *real_git_dir,
    - 	    const char *initial_branch,
    - 	    int init_shared_repository, unsigned int flags)
    +@@ setup.c: void initialize_repository_version(int hash_algo,
      {
    --	int reinit;
    -+	int reinit, auto_setup_submodule_path_config = 0;
    - 	int exist_ok = flags & INIT_DB_EXIST_OK;
    - 	char *original_git_dir = real_pathdup(git_dir, 1);
    - 	struct repository_format repo_fmt = REPOSITORY_FORMAT_INIT;
    -@@ setup.c: int init_db(const char *git_dir, const char *real_git_dir,
    - 					  initial_branch, flags & INIT_DB_QUIET);
    - 	create_object_directory();
    + 	struct strbuf repo_version = STRBUF_INIT;
    + 	int target_version = GIT_REPO_VERSION;
    ++	int default_submodule_path_config = 0;
      
    -+	repo_config_get_bool(the_repository, "init.autoSetupSubmodulePathConfig",
    -+			     &auto_setup_submodule_path_config);
    -+	if (auto_setup_submodule_path_config) {
    -+		int version = 0;
    -+		repo_config_get_int(the_repository, "core.repositoryformatversion", &version);
    -+		if (version < 1)
    -+			repo_config_set(the_repository, "core.repositoryformatversion", "1");
    + 	/*
    + 	 * Note that we initialize the repository version to 1 when the ref
    +@@ setup.c: void initialize_repository_version(int hash_algo,
    + 		clear_repository_format(&repo_fmt);
    + 	}
    + 
    ++	repo_config_get_bool(the_repository, "init.defaultSubmodulePathConfig",
    ++			     &default_submodule_path_config);
    ++	if (default_submodule_path_config) {
    ++		/* extensions.submodulepathconfig requires at least version 1 */
    ++		if (target_version == 0)
    ++			target_version = 1;
     +		repo_config_set(the_repository, "extensions.submodulepathconfig", "true");
     +	}
     +
    - 	if (repo_settings_get_shared_repository(the_repository)) {
    - 		char buf[10];
    - 		/* We do not spell "group" and such, so that
    + 	strbuf_addf(&repo_version, "%d", target_version);
    + 	repo_config_set(the_repository, "core.repositoryformatversion", repo_version.buf);
    + 
     
      ## t/t7425-submodule-gitdir-path-extension.sh ##
     @@ t/t7425-submodule-gitdir-path-extension.sh: test_expect_success 'fetch mixed submodule changes and verify updates' '
      	)
      '
      
    -+test_expect_success '`git init` respects init.autoSetupSubmodulePathConfig' '
    -+	git config --global init.autoSetupSubmodulePathConfig true &&
    ++test_expect_success '`git init` respects init.defaultSubmodulePathConfig' '
    ++	git config --global init.defaultSubmodulePathConfig true &&
     +	git init repo-init &&
     +	git -C repo-init config extensions.submodulePathConfig > actual &&
     +	echo true > expect &&
    @@ t/t7425-submodule-gitdir-path-extension.sh: test_expect_success 'fetch mixed sub
     +		echo ".git/modules/sub" > expect &&
     +		test_cmp expect actual
     +	) &&
    -+	git config --global --unset init.autoSetupSubmodulePathConfig
    ++	git config --global --unset init.defaultSubmodulePathConfig
     +'
     +
     +test_expect_success '`git init` does not set extension by default' '
    @@ t/t7425-submodule-gitdir-path-extension.sh: test_expect_success 'fetch mixed sub
     +
     +'
     +
    -+test_expect_success '`git clone` respects init.autoSetupSubmodulePathConfig' '
    ++test_expect_success '`git clone` respects init.defaultSubmodulePathConfig' '
     +	test_when_finished "rm -rf repo-clone" &&
    -+	git config --global init.autoSetupSubmodulePathConfig true &&
    ++	git config --global init.defaultSubmodulePathConfig true &&
     +	git clone upstream repo-clone &&
     +	(
     +		cd repo-clone &&
    @@ t/t7425-submodule-gitdir-path-extension.sh: test_expect_success 'fetch mixed sub
     +		echo ".git/modules/sub" > expect &&
     +		test_cmp expect actual
     +	) &&
    -+	git config --global --unset init.autoSetupSubmodulePathConfig
    ++	git config --global --unset init.defaultSubmodulePathConfig
     +'
     +
    -+test_expect_success '`git clone --recurse-submodules` respects init.autoSetupSubmodulePathConfig' '
    ++test_expect_success '`git clone --recurse-submodules` respects init.defaultSubmodulePathConfig' '
     +	test_when_finished "rm -rf repo-clone-recursive" &&
    -+	git config --global init.autoSetupSubmodulePathConfig true &&
    ++	git config --global init.defaultSubmodulePathConfig true &&
     +	git clone  --recurse-submodules upstream repo-clone-recursive &&
     +	(
     +		cd repo-clone-recursive &&
    @@ t/t7425-submodule-gitdir-path-extension.sh: test_expect_success 'fetch mixed sub
     +		echo ".git/modules/new-sub" > expect &&
     +		test_cmp expect actual
     +	) &&
    -+	git config --global --unset init.autoSetupSubmodulePathConfig
    ++	git config --global --unset init.defaultSubmodulePathConfig
     +'
     +
      test_done
 6:  ce96f85456 !  6:  c62db6b32f submodule--helper: add gitdir migration command
    @@ Documentation/config/extensions.adoc: Git will error out if a module does not ha
     +submodules and attempts to migrate them.
      +
      The extension can be enabled automatically for new repositories by setting
    - `init.autoSetupSubmodulePathConfig` to `true`, for example by running
    + `init.defaultSubmodulePathConfig` to `true`, for example by running
     
      ## builtin/submodule--helper.c ##
     @@ builtin/submodule--helper.c: static int module_gitdir(int argc, const char **argv, const char *prefix UNUSED,
    @@ builtin/submodule--helper.c: static int module_gitdir(int argc, const char **arg
     +	struct strbuf module_dir = STRBUF_INIT;
     +	DIR *dir;
     +	struct dirent *de;
    ++	int repo_version = 0;
     +
     +	repo_git_path_append(repo, &module_dir, "modules/");
     +
    @@ builtin/submodule--helper.c: static int module_gitdir(int argc, const char **arg
     +	closedir(dir);
     +	strbuf_release(&module_dir);
     +
    -+	if (repo_config_set_gently(repo, "core.repositoryformatversion", "1"))
    ++	repo_config_get_int(the_repository, "core.repositoryformatversion", &repo_version);
    ++	if (repo_version == 0 &&
    ++	    repo_config_set_gently(repo, "core.repositoryformatversion", "1"))
     +		die(_("could not set core.repositoryformatversion to 1. "
    -+		      "Please enable it for migration to work, for example: "
    ++		      "Please set it for migration to work, for example: "
     +		      "git config core.repositoryformatversion 1"));
     +
     +	if (repo_config_set_gently(repo, "extensions.submodulePathConfig", "true"))
    @@ builtin/submodule--helper.c: int cmd_submodule__helper(int argc,
      		OPT_SUBCOMMAND("add", &fn, module_add),
     
      ## t/t7425-submodule-gitdir-path-extension.sh ##
    -@@ t/t7425-submodule-gitdir-path-extension.sh: test_expect_success '`git clone --recurse-submodules` respects init.autoSetupSub
    - 	git config --global --unset init.autoSetupSubmodulePathConfig
    +@@ t/t7425-submodule-gitdir-path-extension.sh: test_expect_success 'fetch mixed submodule changes and verify updates' '
    + test_expect_success '`git init` respects init.defaultSubmodulePathConfig' '
    + 	git config --global init.defaultSubmodulePathConfig true &&
    + 	git init repo-init &&
    +-	git -C repo-init config extensions.submodulePathConfig > actual &&
    +-	echo true > expect &&
    ++	git -C repo-init config extensions.submodulePathConfig >actual &&
    ++	echo true >expect &&
    + 	test_cmp expect actual &&
    + 	# create a submodule and check gitdir
    + 	(
    +@@ t/t7425-submodule-gitdir-path-extension.sh: test_expect_success '`git init` respects init.defaultSubmodulePathConfig' '
    + 		git init -b main sub &&
    + 		test_commit -C sub sub-initial &&
    + 		git submodule add ./sub sub &&
    +-		git config submodule.sub.gitdir > actual &&
    +-		echo ".git/modules/sub" > expect &&
    ++		git config submodule.sub.gitdir >actual &&
    ++		echo ".git/modules/sub" >expect &&
    + 		test_cmp expect actual
    + 	) &&
    + 	git config --global --unset init.defaultSubmodulePathConfig
    +@@ t/t7425-submodule-gitdir-path-extension.sh: test_expect_success '`git clone` respects init.defaultSubmodulePathConfig' '
    + 		cd repo-clone &&
    + 
    + 		# verify new repo extension is inherited from global config
    +-		git config extensions.submodulePathConfig > actual &&
    +-		echo true > expect &&
    ++		git config extensions.submodulePathConfig >actual &&
    ++		echo true >expect &&
    + 		test_cmp expect actual &&
    + 
    + 		# new submodule has a gitdir config
    + 		git submodule add ../sub sub &&
    + 		test_path_is_dir .git/modules/sub &&
    +-		git config submodule.sub.gitdir > actual &&
    +-		echo ".git/modules/sub" > expect &&
    ++		git config submodule.sub.gitdir >actual &&
    ++		echo ".git/modules/sub" >expect &&
    + 		test_cmp expect actual
    + 	) &&
    + 	git config --global --unset init.defaultSubmodulePathConfig
    +@@ t/t7425-submodule-gitdir-path-extension.sh: test_expect_success '`git clone --recurse-submodules` respects init.defaultSubmo
    + 		cd repo-clone-recursive &&
    + 
    + 		# verify new repo extension is inherited from global config
    +-		git config extensions.submodulePathConfig > actual &&
    +-		echo true > expect &&
    ++		git config extensions.submodulePathConfig >actual &&
    ++		echo true >expect &&
    + 		test_cmp expect actual &&
    + 
    + 		# previous submodules should exist
    +@@ t/t7425-submodule-gitdir-path-extension.sh: test_expect_success '`git clone --recurse-submodules` respects init.defaultSubmo
    + 		# create another submodule and check that gitdir is created
    + 		git submodule add ../sub new-sub &&
    + 		test_path_is_dir .git/modules/new-sub &&
    +-		git config submodule.new-sub.gitdir > actual &&
    +-		echo ".git/modules/new-sub" > expect &&
    ++		git config submodule.new-sub.gitdir >actual &&
    ++		echo ".git/modules/new-sub" >expect &&
    + 		test_cmp expect actual
    + 	) &&
    + 	git config --global --unset init.defaultSubmodulePathConfig
      '
      
     +test_expect_success 'submodule--helper migrates legacy modules' '
    @@ t/t7425-submodule-gitdir-path-extension.sh: test_expect_success '`git clone --re
     +		test_cmp expect actual &&
     +
     +		# repository extension is enabled after migration
    -+		git config extensions.submodulePathConfig > actual &&
    -+		echo "true" > expect &&
    ++		git config extensions.submodulePathConfig >actual &&
    ++		echo "true" >expect &&
     +		test_cmp expect actual
     +	)
     +'
    @@ t/t7425-submodule-gitdir-path-extension.sh: test_expect_success '`git clone --re
     +	(
     +		cd repo-clone-recursive &&
     +
    -+		# init.autoSetupSubmodulePathConfig was disabled before clone, so
    ++		# init.defaultSubmodulePathConfig was disabled before clone, so
     +		# the repo extension config should also be off, the migration ignored
     +		test_must_fail git config extensions.submodulePathConfig &&
     +
    @@ t/t7425-submodule-gitdir-path-extension.sh: test_expect_success '`git clone --re
     +	rm -rf repo-clone-recursive &&
     +
     +	# enable the extension, then retry the clone
    -+	git config --global init.autoSetupSubmodulePathConfig true &&
    ++	git config --global init.defaultSubmodulePathConfig true &&
     +	git clone --recurse-submodules upstream repo-clone-recursive &&
     +	(
     +		cd repo-clone-recursive &&
     +
     +		# repository extension is enabled
    -+		git config extensions.submodulePathConfig > actual &&
    -+		echo "true" > expect &&
    ++		git config extensions.submodulePathConfig >actual &&
    ++		echo "true" >expect &&
     +		test_cmp expect actual &&
     +
     +		# gitdir configs exist for submodules
    @@ t/t7425-submodule-gitdir-path-extension.sh: test_expect_success '`git clone --re
     +		git config submodule.sub2.gitdir &&
     +		test_path_is_dir .git/modules/sub1 &&
     +		test_path_is_dir .git/modules/sub2
    -+	)
    ++	) &&
    ++	git config --global --unset init.defaultSubmodulePathConfig
     +'
     +
      test_done
 7:  2f96ff248f =  7:  c554017f83 builtin/credential-store: move is_rfc3986_unreserved to url.[ch]
 8:  5aa986bd40 !  8:  7a794b9b61 submodule--helper: fix filesystem collisions by encoding gitdir paths
    @@ builtin/submodule--helper.c: static void create_default_gitdir_config(const char
     
      ## submodule.c ##
     @@
    - #include "commit-reach.h"
      #include "read-cache-ll.h"
      #include "setup.h"
    + #include "advice.h"
     +#include "url.h"
      
      static int config_update_recurse_submodules = RECURSE_SUBMODULES_OFF;
    @@ submodule.c: int validate_submodule_git_dir(char *git_dir, const char *submodule
     
      ## t/t7425-submodule-gitdir-path-extension.sh ##
     @@ t/t7425-submodule-gitdir-path-extension.sh: test_expect_success '`git clone --recurse-submodules` works after migration' '
    - 	)
    + 	git config --global --unset init.defaultSubmodulePathConfig
      '
      
     +test_expect_success 'setup submodules with nested git dirs' '
    @@ t/t7425-submodule-gitdir-path-extension.sh: test_expect_success '`git clone --re
     +	git clone -c extensions.submodulePathConfig=true --recurse-submodules nested clone_nested &&
     +
     +	verify_submodule_gitdir_path clone_nested hippo modules/hippo &&
    -+	git -C clone_nested config submodule.hippo.gitdir > actual &&
    ++	git -C clone_nested config submodule.hippo.gitdir >actual &&
     +	test_grep "\.git/modules/hippo$" actual &&
     +
     +	verify_submodule_gitdir_path clone_nested hippo/hooks modules/hippo%2fhooks &&
    -+	git -C clone_nested config submodule.hippo/hooks.gitdir > actual &&
    ++	git -C clone_nested config submodule.hippo/hooks.gitdir >actual &&
     +	test_grep "\.git/modules/hippo%2fhooks$" actual
     +'
     +
    @@ t/t7425-submodule-gitdir-path-extension.sh: test_expect_success '`git clone --re
     +	git clone -c extensions.submodulePathConfig=true --recurse-submodules --jobs=2 nested clone_parallel &&
     +
     +	verify_submodule_gitdir_path clone_parallel hippo modules/hippo &&
    -+	git -C clone_nested config submodule.hippo.gitdir > actual &&
    ++	git -C clone_nested config submodule.hippo.gitdir >actual &&
     +	test_grep "\.git/modules/hippo$" actual &&
     +
     +	verify_submodule_gitdir_path clone_parallel hippo/hooks modules/hippo%2fhooks &&
    -+	git -C clone_nested config submodule.hippo/hooks.gitdir > actual &&
    ++	git -C clone_nested config submodule.hippo/hooks.gitdir >actual &&
     +	test_grep "\.git/modules/hippo%2fhooks$" actual
     +'
     +
 9:  044d7de8a0 =  9:  142a85a1af submodule: fix case-folding gitdir filesystem collisions
10:  90d78b23cd = 10:  bafde20354 submodule: hash the submodule name for the gitdir path
11:  4e596a2a90 ! 11:  e3fe1f7529 submodule: detect conflicts with existing gitdir configs
    @@ submodule.c: static int check_casefolding_conflict(const char *git_dir,
     +
     +	return cb->conflict_found;
     +}
    ++
     +static bool submodule_conflicts_with_existing(const char *gitdir, const char *submodule_name)
     +{
     +	struct submodule_from_gitdir_cb cb = { 0 };
    @@ t/t7425-submodule-gitdir-path-extension.sh: test_expect_success CASE_INSENSITIVE
     +	(
     +		cd super_with_encoded &&
     +
    ++		git config core.repositoryformatversion 1 &&
     +		git config extensions.submodulePathConfig true &&
     +
     +		# Add a submodule with a nested path

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
 builtin/submodule--helper.c                | 204 +++++++-
 repository.c                               |   1 +
 repository.h                               |   1 +
 setup.c                                    |  17 +
 setup.h                                    |   1 +
 submodule.c                                | 223 +++++++--
 t/lib-verify-submodule-gitdir-path.sh      |  24 +
 t/meson.build                              |   1 +
 t/t7425-submodule-gitdir-path-extension.sh | 532 +++++++++++++++++++++
 t/t9902-completion.sh                      |   1 +
 url.c                                      |  13 +
 url.h                                      |  14 +
 16 files changed, 1030 insertions(+), 51 deletions(-)
 create mode 100644 t/lib-verify-submodule-gitdir-path.sh
 create mode 100755 t/t7425-submodule-gitdir-path-extension.sh

-- 
2.51.2

