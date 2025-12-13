Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F0D2673AA
	for <git@vger.kernel.org>; Sat, 13 Dec 2025 08:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765613362; cv=pass; b=ZUAnRwal62lu+P5O17Us72hhXn8LoDOHniiXT/QWe+rj0GBxeHrPumUax5MuxY4EbpAF8jEWqo9X4gIb56gv7QeT71RPP5Mw57QeDtWivBM/DKC3frQhEpDiCUZRnKW7FP4Ys5TIGZEfbjwJEwiolyQqwTjCIU2y9LeBe7+ozXA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765613362; c=relaxed/simple;
	bh=INiDNR/v8vGHvDgFiS3Xjihe3OCTIIPvOScUw5BpIos=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bucl94PjcQqHizRzsi+UY73c94HTj8AdzbOXAsSpaqUmsdEGbtJTq/F35Utnrd4TXUnKO2PLzp/1UpGzT/FJAf4bRBCfsBgm+qrUR7GcwXmL5IYVfQ3jXdYOO7ijEwunmqhHoVjns45HblP9/mGVl3OpE6mUQ3nQzNEqgEChCgM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=Q+Mo01Yq; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="Q+Mo01Yq"
ARC-Seal: i=1; a=rsa-sha256; t=1765613345; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=fpw4F8texMXYd8wR9AO/xHm9ybROXbN//6BAImpEjab6H54AAfcdvgeKmQSy7b+sxRcq7bb/hRqxyiQjehEH18PBdK8GVsjKemg7SuMMYuDfvStUo6Ha0H6cyg77FGO81dR3s654Oxnd7CPT29k8Y+e2gyef/xNOPgF7PSEfEzk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1765613345; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ReaitiEvudL5y5KzvxTHjWVYKaSB5eNRugy0vXkb++0=; 
	b=BlTk5n478+SG/j+s9CcSLNTAO7l6Thlharhq3wSQD1mTjse/DZp4dahJ1FKd8VDA5eFbR9u+Nzrxh0yIAkPuK09cdU2HLn6wS0rDkyGlEMvB7eigpIQnecCeCosnk8xoJeepNhO8z3wRvUgR6WW/kyxgadNNrPsxGdnC2eDgiEA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1765613345;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=ReaitiEvudL5y5KzvxTHjWVYKaSB5eNRugy0vXkb++0=;
	b=Q+Mo01YqHDZKu11Q8BngOR+Exm5r7bLKl582CE0ewsRpIst4lNzB/rsnQCD5aaKx
	cHi0tYHk2cQYqjM5C5izHhnLnNmr/HeKFsuP+gS0japzNTIpZObzouS/hExrM2riW4J
	5tzqoMlMcOJcUdGVscvDc77WuGqABEAO/aaibGPU=
Received: by mx.zohomail.com with SMTPS id 1765613343566782.331828096177;
	Sat, 13 Dec 2025 00:09:03 -0800 (PST)
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
Subject: [PATCH v6 04/10] submodule: introduce extensions.submodulePathConfig
Date: Sat, 13 Dec 2025 10:08:10 +0200
Message-ID: <20251213080817.347922-5-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251213080817.347922-1-adrian.ratiu@collabora.com>
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
 <20251213080817.347922-1-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

The idea of this extension is to abstract away the submodule gitdir
path implementation: everyone is expected to use the config and not
worry about how the path is computed internally, either in git or
other implementations.

With this extension enabled, the submodule.<name>.gitdir repo config
becomes the single source of truth for all submodule gitdir paths.

The submodule.<name>.gitdir config is added automatically for all new
submodules when this extension is enabled.

Git will throw an error if the extension is enabled and a config is
missing, advising users how to migrate. Migration is manual for now.

E.g. to add a missing config entry for an existing "foo" module:
git config submodule.foo.gitdir .git/modules/foo

Suggested-by: Junio C Hamano <gitster@pobox.com>
Suggested-by: Phillip Wood <phillip.wood123@gmail.com>
Suggested-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
 Documentation/config/extensions.adoc       |   8 ++
 Documentation/config/submodule.adoc        |   7 ++
 builtin/submodule--helper.c                |  51 ++++++++
 repository.c                               |   1 +
 repository.h                               |   1 +
 setup.c                                    |   7 ++
 setup.h                                    |   1 +
 submodule.c                                |  59 +++++----
 t/lib-verify-submodule-gitdir-path.sh      |  24 ++++
 t/meson.build                              |   1 +
 t/t7425-submodule-gitdir-path-extension.sh | 138 +++++++++++++++++++++
 t/t9902-completion.sh                      |   1 +
 12 files changed, 274 insertions(+), 25 deletions(-)
 create mode 100644 t/lib-verify-submodule-gitdir-path.sh
 create mode 100755 t/t7425-submodule-gitdir-path-extension.sh

diff --git a/Documentation/config/extensions.adoc b/Documentation/config/extensions.adoc
index 532456644b..6ce1dcc98b 100644
--- a/Documentation/config/extensions.adoc
+++ b/Documentation/config/extensions.adoc
@@ -73,6 +73,14 @@ relativeWorktrees:::
 	repaired with either the `--relative-paths` option or with the
 	`worktree.useRelativePaths` config set to `true`.
 
+submodulePathConfig:::
+	If enabled, the submodule.<name>.gitdir config is the single source of
+	truth for submodule gitdir paths and is always set for new submodules.
+	Git will error if a module does not have submodule.<name>.gitdir set.
+	Existing pre-extension submodules need to be migrated by adding the
+	missing config entries. This is done manually for now, e.g. for each
+	submodule: "git config submodule.<name>.gitdir .git/modules/<name>".
+
 worktreeConfig:::
 	If enabled, then worktrees will load config settings from the
 	`$GIT_DIR/config.worktree` file in addition to the
diff --git a/Documentation/config/submodule.adoc b/Documentation/config/submodule.adoc
index 0672d99117..4cf7424cda 100644
--- a/Documentation/config/submodule.adoc
+++ b/Documentation/config/submodule.adoc
@@ -52,6 +52,13 @@ submodule.<name>.active::
 	submodule.active config option. See linkgit:gitsubmodules[7] for
 	details.
 
+submodule.<name>.gitdir::
+	This sets the gitdir path for submodule <name>. It only works when
+	`extensions.submodulePathConfig` is enabled, otherwise it does nothing.
+	When the extension is enabled, this config is the single source of truth
+	for submodule gitdir paths and git will throw an error if it is missing.
+	See linkgit:git-config[1] for details.
+
 submodule.active::
 	A repeated field which contains a pathspec used to match against a
 	submodule's path to determine if the submodule is of interest to git
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 3bc139ff9c..699ac32004 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -435,6 +435,52 @@ struct init_cb {
 };
 #define INIT_CB_INIT { 0 }
 
+static int validate_and_set_submodule_gitdir(struct strbuf *gitdir_path,
+					     const char *submodule_name)
+{
+	const char *value;
+	char *key;
+
+	if (validate_submodule_git_dir(gitdir_path->buf, submodule_name))
+		return -1;
+
+	 key = xstrfmt("submodule.%s.gitdir", submodule_name);
+
+	 /* Nothing to do if the config already exists. */
+	if (!repo_config_get_string_tmp(the_repository, key, &value)) {
+		free(key);
+		return 0;
+	}
+
+	if (repo_config_set_gently(the_repository, key, gitdir_path->buf)) {
+		free(key);
+		return -1;
+	}
+
+	free(key);
+	return 0;
+}
+
+static void create_default_gitdir_config(const char *submodule_name)
+{
+	struct strbuf gitdir_path = STRBUF_INIT;
+
+	/* The config is set only when extensions.submodulePathConfig is enabled */
+	if (!the_repository->repository_format_submodule_path_cfg)
+		return;
+
+	repo_git_path_append(the_repository, &gitdir_path, "modules/%s", submodule_name);
+	if (!validate_and_set_submodule_gitdir(&gitdir_path, submodule_name)) {
+		strbuf_release(&gitdir_path);
+		return;
+	}
+
+	die(_("failed to set a valid default config for 'submodule.%s.gitdir'. "
+	      "Please ensure it is set, for example by running something like: "
+	      "'git config submodule.%s.gitdir .git/modules/%s'"),
+	    submodule_name, submodule_name, submodule_name);
+}
+
 static void init_submodule(const char *path, const char *prefix,
 			   const char *super_prefix,
 			   unsigned int flags)
@@ -511,6 +557,9 @@ static void init_submodule(const char *path, const char *prefix,
 		if (repo_config_set_gently(the_repository, sb.buf, upd))
 			die(_("Failed to register update mode for submodule path '%s'"), displaypath);
 	}
+
+	create_default_gitdir_config(sub->name);
+
 	strbuf_release(&sb);
 	free(displaypath);
 	free(url);
@@ -3574,6 +3623,8 @@ static int module_add(int argc, const char **argv, const char *prefix,
 	add_data.progress = !!progress;
 	add_data.dissociate = !!dissociate;
 
+	create_default_gitdir_config(add_data.sm_name);
+
 	if (add_submodule(&add_data))
 		goto cleanup;
 	configure_added_submodule(&add_data);
diff --git a/repository.c b/repository.c
index 863f24411b..6cb1247f4b 100644
--- a/repository.c
+++ b/repository.c
@@ -281,6 +281,7 @@ int repo_init(struct repository *repo,
 	repo->repository_format_worktree_config = format.worktree_config;
 	repo->repository_format_relative_worktrees = format.relative_worktrees;
 	repo->repository_format_precious_objects = format.precious_objects;
+	repo->repository_format_submodule_path_cfg = format.submodule_path_cfg;
 
 	/* take ownership of format.partial_clone */
 	repo->repository_format_partial_clone = format.partial_clone;
diff --git a/repository.h b/repository.h
index 6063c4b846..7141237f97 100644
--- a/repository.h
+++ b/repository.h
@@ -165,6 +165,7 @@ struct repository {
 	int repository_format_worktree_config;
 	int repository_format_relative_worktrees;
 	int repository_format_precious_objects;
+	int repository_format_submodule_path_cfg;
 
 	/* Indicate if a repository has a different 'commondir' from 'gitdir' */
 	unsigned different_commondir:1;
diff --git a/setup.c b/setup.c
index 3a6a048620..428427d689 100644
--- a/setup.c
+++ b/setup.c
@@ -686,6 +686,9 @@ static enum extension_result handle_extension(const char *var,
 	} else if (!strcmp(ext, "relativeworktrees")) {
 		data->relative_worktrees = git_config_bool(var, value);
 		return EXTENSION_OK;
+	} else if (!strcmp(ext, "submodulepathconfig")) {
+		data->submodule_path_cfg = git_config_bool(var, value);
+		return EXTENSION_OK;
 	}
 	return EXTENSION_UNKNOWN;
 }
@@ -1947,6 +1950,8 @@ const char *setup_git_directory_gently(int *nongit_ok)
 				repo_fmt.worktree_config;
 			the_repository->repository_format_relative_worktrees =
 				repo_fmt.relative_worktrees;
+			the_repository->repository_format_submodule_path_cfg =
+				repo_fmt.submodule_path_cfg;
 			/* take ownership of repo_fmt.partial_clone */
 			the_repository->repository_format_partial_clone =
 				repo_fmt.partial_clone;
@@ -2045,6 +2050,8 @@ void check_repository_format(struct repository_format *fmt)
 				    fmt->ref_storage_format);
 	the_repository->repository_format_worktree_config =
 		fmt->worktree_config;
+	the_repository->repository_format_submodule_path_cfg =
+		fmt->submodule_path_cfg;
 	the_repository->repository_format_relative_worktrees =
 		fmt->relative_worktrees;
 	the_repository->repository_format_partial_clone =
diff --git a/setup.h b/setup.h
index d55dcc6608..0738dec244 100644
--- a/setup.h
+++ b/setup.h
@@ -167,6 +167,7 @@ struct repository_format {
 	char *partial_clone; /* value of extensions.partialclone */
 	int worktree_config;
 	int relative_worktrees;
+	int submodule_path_cfg;
 	int is_bare;
 	int hash_algo;
 	int compat_hash_algo;
diff --git a/submodule.c b/submodule.c
index f645372a18..85ca7ea0fb 100644
--- a/submodule.c
+++ b/submodule.c
@@ -2570,30 +2570,39 @@ int submodule_to_gitdir(struct repository *repo,
 void submodule_name_to_gitdir(struct strbuf *buf, struct repository *r,
 			      const char *submodule_name)
 {
-	/*
-	 * NEEDSWORK: The current way of mapping a submodule's name to
-	 * its location in .git/modules/ has problems with some naming
-	 * schemes. For example, if a submodule is named "foo" and
-	 * another is named "foo/bar" (whether present in the same
-	 * superproject commit or not - the problem will arise if both
-	 * superproject commits have been checked out at any point in
-	 * time), or if two submodule names only have different cases in
-	 * a case-insensitive filesystem.
-	 *
-	 * There are several solutions, including encoding the path in
-	 * some way, introducing a submodule.<name>.gitdir config in
-	 * .git/config (not .gitmodules) that allows overriding what the
-	 * gitdir of a submodule would be (and teach Git, upon noticing
-	 * a clash, to automatically determine a non-clashing name and
-	 * to write such a config), or introducing a
-	 * submodule.<name>.gitdir config in .gitmodules that repo
-	 * administrators can explicitly set. Nothing has been decided,
-	 * so for now, just append the name at the end of the path.
-	 */
-	repo_git_path_append(r, buf, "modules/");
-	strbuf_addstr(buf, submodule_name);
+	const char *gitdir;
+	char *key;
+	int ret;
+
+	/* If extensions.submodulePathConfig is disabled, continue to use the plain path */
+	if (!r->repository_format_submodule_path_cfg) {
+		repo_git_path_append(r, buf, "modules/%s", submodule_name);
+		if (validate_submodule_git_dir(buf->buf, submodule_name) < 0)
+			die(_("refusing to create/use '%s' in another submodule's "
+			      "git dir"), buf->buf);
+
+		return; /* plain gitdir is valid for use */
+	}
+
+	/* Extension is enabled: use the gitdir config if it exists */
+	key = xstrfmt("submodule.%s.gitdir", submodule_name);
+	ret = repo_config_get_string_tmp(r, key, &gitdir);
+	FREE_AND_NULL(key);
+
+	if (!ret) {
+		strbuf_addstr(buf, gitdir);
+
+		/* validate because users might have modified the config */
+		if (validate_submodule_git_dir(buf->buf, submodule_name))
+			die(_("invalid 'submodule.%s.gitdir' config: '%s' please check "
+			      "if it is unique or conflicts with another module"),
+			    submodule_name, gitdir);
+
+		return; /* gitdir from config is valid for use */
+	}
 
-	if (validate_submodule_git_dir(buf->buf, submodule_name) < 0)
-		die(_("refusing to create/use '%s' in another submodule's "
-		      "git dir"), buf->buf);
+	die(_("the 'submodule.%s.gitdir' config does not exist for module '%s'. "
+	      "Please ensure it is set, for example by running something like: "
+	      "'git config submodule.%s.gitdir .git/modules/%s'"),
+	    submodule_name, submodule_name, submodule_name, submodule_name);
 }
diff --git a/t/lib-verify-submodule-gitdir-path.sh b/t/lib-verify-submodule-gitdir-path.sh
new file mode 100644
index 0000000000..62794df976
--- /dev/null
+++ b/t/lib-verify-submodule-gitdir-path.sh
@@ -0,0 +1,24 @@
+# Helper to verify if repo $1 contains a submodule named $2 with gitdir path $3
+
+# This does not check filesystem existence. That is done in submodule.c via the
+# submodule_name_to_gitdir() API which this helper ends up calling. The gitdirs
+# might or might not exist (e.g. when adding a new submodule), so this only
+# checks the expected configuration path, which might be overridden by the user.
+
+verify_submodule_gitdir_path() {
+	repo="$1" &&
+	name="$2" &&
+	path="$3" &&
+	(
+		cd "$repo" &&
+		# Compute expected absolute path
+		expected="$(git rev-parse --git-common-dir)/$path" &&
+		expected="$(test-tool path-utils real_path "$expected")" &&
+		# Compute actual absolute path
+		actual="$(git submodule--helper gitdir "$name")" &&
+		actual="$(test-tool path-utils real_path "$actual")" &&
+		echo "$expected" >expect &&
+		echo "$actual" >actual &&
+		test_cmp expect actual
+	)
+}
diff --git a/t/meson.build b/t/meson.build
index d3d0be2822..c101faca31 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -886,6 +886,7 @@ integration_tests = [
   't7422-submodule-output.sh',
   't7423-submodule-symlinks.sh',
   't7424-submodule-mixed-ref-formats.sh',
+  't7425-submodule-gitdir-path-extension.sh',
   't7450-bad-git-dotfiles.sh',
   't7500-commit-template-squash-signoff.sh',
   't7501-commit-basic-functionality.sh',
diff --git a/t/t7425-submodule-gitdir-path-extension.sh b/t/t7425-submodule-gitdir-path-extension.sh
new file mode 100755
index 0000000000..5d52a289f8
--- /dev/null
+++ b/t/t7425-submodule-gitdir-path-extension.sh
@@ -0,0 +1,138 @@
+#!/bin/sh
+
+test_description='submodulePathConfig extension works as expected'
+
+. ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-verify-submodule-gitdir-path.sh
+
+test_expect_success 'setup: allow file protocol' '
+       git config --global protocol.file.allow always
+'
+
+test_expect_success 'create repo with mixed extension submodules' '
+	git init -b main legacy-sub &&
+	test_commit -C legacy-sub legacy-initial &&
+	legacy_rev=$(git -C legacy-sub rev-parse HEAD) &&
+
+	git init -b main new-sub &&
+	test_commit -C new-sub new-initial &&
+	new_rev=$(git -C new-sub rev-parse HEAD) &&
+
+	git init -b main main &&
+	(
+		cd main &&
+		git submodule add ../legacy-sub legacy &&
+		test_commit legacy-sub &&
+
+		# trigger the "die_path_inside_submodule" check
+		test_must_fail git submodule add ../new-sub "legacy/nested" &&
+
+		git config core.repositoryformatversion 1 &&
+		git config extensions.submodulePathConfig true &&
+
+		git submodule add ../new-sub "New Sub" &&
+		test_commit new &&
+
+		# retrigger the "die_path_inside_submodule" check with encoding
+		test_must_fail git submodule add ../new-sub "New Sub/nested2"
+       )
+'
+
+test_expect_success 'verify new submodule gitdir config' '
+	git -C main config submodule."New Sub".gitdir > actual &&
+	echo ".git/modules/New Sub" > expect &&
+	test_cmp expect actual &&
+	verify_submodule_gitdir_path main "New Sub" "modules/New Sub"
+'
+
+test_expect_success 'manual add and verify legacy submodule gitdir config' '
+	# the legacy module should not contain a gitdir config, because it
+	# was added before the extension was enabled. Add and test it.
+	test_must_fail git -C main config submodule.legacy.gitdir &&
+	git -C main config submodule.legacy.gitdir .git/modules/legacy &&
+	git -C main config submodule.legacy.gitdir > actual &&
+	echo ".git/modules/legacy" > expect &&
+	test_cmp expect actual &&
+	verify_submodule_gitdir_path main "legacy" "modules/legacy"
+'
+
+test_expect_success 'clone from repo with both legacy and new-style submodules' '
+	git clone --recurse-submodules main cloned-non-extension &&
+	(
+		cd cloned-non-extension &&
+
+		test_path_is_dir .git/modules/legacy &&
+		test_path_is_dir .git/modules/"New Sub" &&
+
+		test_must_fail git config submodule.legacy.gitdir &&
+		test_must_fail git config submodule."New Sub".gitdir &&
+
+		git submodule status >list &&
+		test_grep "$legacy_rev legacy" list &&
+		test_grep "$new_rev New Sub" list
+	) &&
+
+	git clone -c extensions.submodulePathConfig=true --recurse-submodules main cloned-extension &&
+	(
+		cd cloned-extension &&
+
+		test_path_is_dir .git/modules/legacy &&
+		test_path_is_dir ".git/modules/New Sub" &&
+
+		git config submodule.legacy.gitdir &&
+		git config submodule."New Sub".gitdir &&
+
+		git submodule status >list &&
+		test_grep "$legacy_rev legacy" list &&
+		test_grep "$new_rev New Sub" list
+	)
+'
+
+test_expect_success 'commit and push changes to encoded submodules' '
+	git -C legacy-sub config receive.denyCurrentBranch updateInstead &&
+	git -C new-sub config receive.denyCurrentBranch updateInstead &&
+	git -C main config receive.denyCurrentBranch updateInstead &&
+	(
+		cd cloned-extension &&
+
+		git -C legacy switch --track -C main origin/main  &&
+		test_commit -C legacy second-commit &&
+		git -C legacy push &&
+
+		git -C "New Sub" switch --track -C main origin/main &&
+		test_commit -C "New Sub" second-commit &&
+		git -C "New Sub" push &&
+
+		# Stage and commit submodule changes in superproject
+		git switch --track -C main origin/main  &&
+		git add legacy "New Sub" &&
+		git commit -m "update submodules" &&
+
+		# push superproject commit to main repo
+		git push
+	) &&
+
+	# update expected legacy & new submodule checksums
+	legacy_rev=$(git -C legacy-sub rev-parse HEAD) &&
+	new_rev=$(git -C new-sub rev-parse HEAD)
+'
+
+test_expect_success 'fetch mixed submodule changes and verify updates' '
+	(
+		cd main &&
+
+		# only update submodules because superproject was
+		# pushed into at the end of last test
+		git submodule update --init --recursive &&
+
+		test_path_is_dir .git/modules/legacy &&
+		test_path_is_dir ".git/modules/New Sub" &&
+
+		# Verify both submodules are at the expected commits
+		git submodule status >list &&
+		test_grep "$legacy_rev legacy" list &&
+		test_grep "$new_rev New Sub" list
+	)
+'
+
+test_done
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 964e1f1569..ffb9c8b522 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -3053,6 +3053,7 @@ test_expect_success 'git config set - variable name - __git_compute_second_level
 	submodule.sub.fetchRecurseSubmodules Z
 	submodule.sub.ignore Z
 	submodule.sub.active Z
+	submodule.sub.gitdir Z
 	EOF
 '
 
-- 
2.51.2

