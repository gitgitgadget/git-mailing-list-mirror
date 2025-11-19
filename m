Received: from sender3-pp-f112.zoho.com (sender3-pp-f112.zoho.com [136.143.184.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4DD2EDD62
	for <git@vger.kernel.org>; Wed, 19 Nov 2025 21:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763586715; cv=pass; b=AtcXnDP1L/33b6dfmQM8r1GNetWTLua7Qb3qItxhr9IOSq5iGRys8g9d9GYctSw1AuRONqv5uMe52U4tlSIUdmzVkvDWI1SLjKXxedIFGyi8LQcZpCyepNStkIfy2T6WCKNo7G140+I7WPYNLdx9b2fDnWZK0RkMvl3QriNNJWk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763586715; c=relaxed/simple;
	bh=66tqSt16hRqZHv+VrVf4QB5tH/N/cRYxLSYdtiZspTs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KxOl55X1TNP83W/lkaQ6anAGljhIvr1qNZXcJQoi85aaZzX6i/8cgq8teWCFq9030QIFH1RqR/X+MiVh7wh5UEHHGXSVYS0gwOWI3C70z2zOOZ2FpaOF1aARg2bC6Yzau+X3UnezLZPpQop2EzSlp0lAFLyAI+ixJ48HlBgv3sU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=EQw56f3X; arc=pass smtp.client-ip=136.143.184.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="EQw56f3X"
ARC-Seal: i=1; a=rsa-sha256; t=1763586686; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=aa80cTI/OSdmsROPyb4tYQrn0XP1Agl8T0mjXMT1bsM9AITfyEjQggYxPedSAFJBojnsIUwgFqbIPxskIUk6Tprai5U3AHWCLmKfYXn2N/3JrcjOQxF1KJksXkvMiTb5CRtGMDVWhKd2UCWmoDrelLLt6MmwFTes4CjZrhdHtI4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1763586686; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=0/DQegNIozCMdT6JFYWQfQuyksl4SwrDQCuEm99IHo0=; 
	b=k4KQh4n9cBfexNAJ5c+LjD6EV6gW/1RLb4hBgrNZCkGneg4f7Joux8cdMCF1zjhdQw6aFxzOyt9GA9xGaGVmfg6TuluWnrKIG8bbNiDPi5WQYnKhkk0cLm2AbrHmR8MDNaermW0UYv/GrFmEhggrO3XmDnlAh2lP3ODS1Q4RUIg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1763586686;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=0/DQegNIozCMdT6JFYWQfQuyksl4SwrDQCuEm99IHo0=;
	b=EQw56f3X3d3yQ29S/+ht2Vy3zJg1NTHM5+KjVntTIA+/UJhgqzf9QYOWhcz/oRqN
	KvP+mlCcZ8WjOYOXLzXLBVuQ+/sYlEzLjH+amAVWpMDU/v+Od6/eepjQn9vW07SUy8d
	/5Cd716cJ4MzYXVmmB9V+cW67yfLgoCVUCfDeRu4=
Received: by mx.zohomail.com with SMTPS id 1763586685057806.7065200994283;
	Wed, 19 Nov 2025 13:11:25 -0800 (PST)
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
	Adrian Ratiu <adrian.ratiu@collabora.com>,
	Brandon Williams <bwilliams.eng@gmail.com>
Subject: [PATCH v5 4/7] submodule: add extension to encode gitdir paths
Date: Wed, 19 Nov 2025 23:10:27 +0200
Message-ID: <20251119211030.2008441-5-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251119211030.2008441-1-adrian.ratiu@collabora.com>
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
 <20251119211030.2008441-1-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Add a submoduleEncoding extension which fixes filesystem collisions by
encoding gitdir paths. At a high level, this implements a mechanism to
encode -> validate -> retry until a working gitdir path is found.

Credit goes to Junio for coming up with this design: encoding is only
applied when necessary, e.g. uppercase characters are encoded only on
case-folding filesystems and only if a real conflict is detected.

To make this work, we rely on the submodule.<name>.gitdir config as the
single source of truth for gitidir paths: the config is always set when
the extension is enabled. Users who care about gitdir paths are expected
to get/set the config and not the underlying encoding implementation.

This commit adds the basic encoding logic which addresses nested gitdirs.
The next commit fixes case-folding, the next commit fixes names longer
than NAME_MAX. The idea is the encoding can be improved over time in a
way which is transparent to users.

Suggested-by: Junio C Hamano <gitster@pobox.com>
Suggested-by: Phillip Wood <phillip.wood123@gmail.com>
Suggested-by: Patrick Steinhardt <ps@pks.im>
Based-on-patch-by: Brandon Williams <bwilliams.eng@gmail.com>
Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
 Documentation/config/extensions.adoc  |   6 +
 Documentation/config/submodule.adoc   |   5 +
 builtin/submodule--helper.c           |  17 +++
 repository.c                          |   1 +
 repository.h                          |   1 +
 setup.c                               |   7 ++
 setup.h                               |   1 +
 submodule.c                           | 117 ++++++++++++++----
 t/lib-verify-submodule-gitdir-path.sh |  24 ++++
 t/meson.build                         |   1 +
 t/t7425-submodule-encoding.sh         | 164 ++++++++++++++++++++++++++
 t/t9902-completion.sh                 |   1 +
 12 files changed, 323 insertions(+), 22 deletions(-)
 create mode 100644 t/lib-verify-submodule-gitdir-path.sh
 create mode 100755 t/t7425-submodule-encoding.sh

diff --git a/Documentation/config/extensions.adoc b/Documentation/config/extensions.adoc
index 532456644b..4861d01894 100644
--- a/Documentation/config/extensions.adoc
+++ b/Documentation/config/extensions.adoc
@@ -73,6 +73,12 @@ relativeWorktrees:::
 	repaired with either the `--relative-paths` option or with the
 	`worktree.useRelativePaths` config set to `true`.
 
+submoduleEncoding:::
+	If enabled, submodule gitdir paths are encoded to avoid filesystem
+	conflicts due to nested gitdirs, case insensitivity or other issues.
+	When enabled, the submodule.<name>.gitdir config is always set for
+	all submodules and is the single point of authority for gitdir paths.
+
 worktreeConfig:::
 	If enabled, then worktrees will load config settings from the
 	`$GIT_DIR/config.worktree` file in addition to the
diff --git a/Documentation/config/submodule.adoc b/Documentation/config/submodule.adoc
index 0672d99117..ddaadc3dc5 100644
--- a/Documentation/config/submodule.adoc
+++ b/Documentation/config/submodule.adoc
@@ -52,6 +52,11 @@ submodule.<name>.active::
 	submodule.active config option. See linkgit:gitsubmodules[7] for
 	details.
 
+submodule.<name>.gitdir::
+	This option sets the gitdir path for submodule <name>, allowing users to
+	override the default path. Only works when `extensions.submoduleEncoding`
+	is enabled, otherwise does nothing. See linkgit:git-config[1] for details.
+
 submodule.active::
 	A repeated field which contains a pathspec used to match against a
 	submodule's path to determine if the submodule is of interest to git
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 9914ca0786..72440121a8 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1208,6 +1208,22 @@ static int module_summary(int argc, const char **argv, const char *prefix,
 	return ret;
 }
 
+static int module_gitdir(int argc, const char **argv, const char *prefix UNUSED,
+			 struct repository *repo)
+{
+	struct strbuf gitdir = STRBUF_INIT;
+
+	if (argc != 2)
+		usage(_("git submodule--helper gitdir <name>"));
+
+	submodule_name_to_gitdir(&gitdir, repo, argv[1]);
+
+	printf("%s\n", gitdir.buf);
+
+	strbuf_release(&gitdir);
+	return 0;
+}
+
 struct sync_cb {
 	const char *prefix;
 	const char *super_prefix;
@@ -3570,6 +3586,7 @@ int cmd_submodule__helper(int argc,
 		NULL
 	};
 	struct option options[] = {
+		OPT_SUBCOMMAND("gitdir", &fn, module_gitdir),
 		OPT_SUBCOMMAND("clone", &fn, module_clone),
 		OPT_SUBCOMMAND("add", &fn, module_add),
 		OPT_SUBCOMMAND("update", &fn, module_update),
diff --git a/repository.c b/repository.c
index 6faf5c7398..26a21c0d71 100644
--- a/repository.c
+++ b/repository.c
@@ -288,6 +288,7 @@ int repo_init(struct repository *repo,
 	repo->repository_format_worktree_config = format.worktree_config;
 	repo->repository_format_relative_worktrees = format.relative_worktrees;
 	repo->repository_format_precious_objects = format.precious_objects;
+	repo->repository_format_submodule_encoding = format.submodule_encoding;
 
 	/* take ownership of format.partial_clone */
 	repo->repository_format_partial_clone = format.partial_clone;
diff --git a/repository.h b/repository.h
index 5808a5d610..7e39b2acf7 100644
--- a/repository.h
+++ b/repository.h
@@ -158,6 +158,7 @@ struct repository {
 	int repository_format_worktree_config;
 	int repository_format_relative_worktrees;
 	int repository_format_precious_objects;
+	int repository_format_submodule_encoding;
 
 	/* Indicate if a repository has a different 'commondir' from 'gitdir' */
 	unsigned different_commondir:1;
diff --git a/setup.c b/setup.c
index 7086741e6c..bf6e815105 100644
--- a/setup.c
+++ b/setup.c
@@ -687,6 +687,9 @@ static enum extension_result handle_extension(const char *var,
 	} else if (!strcmp(ext, "relativeworktrees")) {
 		data->relative_worktrees = git_config_bool(var, value);
 		return EXTENSION_OK;
+	} else if (!strcmp(ext, "submoduleencoding")) {
+		data->submodule_encoding = git_config_bool(var, value);
+		return EXTENSION_OK;
 	}
 	return EXTENSION_UNKNOWN;
 }
@@ -1865,6 +1868,8 @@ const char *setup_git_directory_gently(int *nongit_ok)
 				repo_fmt.worktree_config;
 			the_repository->repository_format_relative_worktrees =
 				repo_fmt.relative_worktrees;
+			the_repository->repository_format_submodule_encoding =
+				repo_fmt.submodule_encoding;
 			/* take ownership of repo_fmt.partial_clone */
 			the_repository->repository_format_partial_clone =
 				repo_fmt.partial_clone;
@@ -1963,6 +1968,8 @@ void check_repository_format(struct repository_format *fmt)
 				    fmt->ref_storage_format);
 	the_repository->repository_format_worktree_config =
 		fmt->worktree_config;
+	the_repository->repository_format_submodule_encoding =
+		fmt->submodule_encoding;
 	the_repository->repository_format_relative_worktrees =
 		fmt->relative_worktrees;
 	the_repository->repository_format_partial_clone =
diff --git a/setup.h b/setup.h
index 8522fa8575..66ec1ceba5 100644
--- a/setup.h
+++ b/setup.h
@@ -130,6 +130,7 @@ struct repository_format {
 	char *partial_clone; /* value of extensions.partialclone */
 	int worktree_config;
 	int relative_worktrees;
+	int submodule_encoding;
 	int is_bare;
 	int hash_algo;
 	int compat_hash_algo;
diff --git a/submodule.c b/submodule.c
index 8ef028f26b..07cb4694cf 100644
--- a/submodule.c
+++ b/submodule.c
@@ -31,6 +31,7 @@
 #include "commit-reach.h"
 #include "read-cache-ll.h"
 #include "setup.h"
+#include "url.h"
 
 static int config_update_recurse_submodules = RECURSE_SUBMODULES_OFF;
 static int initialized_fetch_ref_tips;
@@ -2237,12 +2238,43 @@ int submodule_move_head(const char *path, const char *super_prefix,
 	return ret;
 }
 
+/*
+ * Encoded gitdir validation function used when extensions.submoduleEncoding is enabled.
+ * This does not print errors like the non-encoded version, because encoding is supposed
+ * to mitigate / fix all these.
+ */
+static int validate_submodule_encoded_git_dir(char *git_dir, const char *submodule_name UNUSED)
+{
+	const char *modules_marker = "/modules/";
+	char *p = git_dir, *last_submodule_name = NULL;
+
+	if (!the_repository->repository_format_submodule_encoding)
+		BUG("validate_submodule_encoded_git_dir() must be called with "
+		    "extensions.submoduleEncoding enabled.");
+
+	/* Find the last submodule name in the gitdir path (modules can be nested). */
+	while ((p = strstr(p, modules_marker))) {
+		last_submodule_name = p + strlen(modules_marker);
+		p++;
+	}
+
+	/* Prevent the use of '/' in encoded names */
+	if (!last_submodule_name || strchr(last_submodule_name, '/'))
+		return -1;
+
+	return 0;
+}
+
 static int validate_submodule_git_dir(char *git_dir, const char *submodule_name)
 {
 	size_t len = strlen(git_dir), suffix_len = strlen(submodule_name);
 	char *p;
 	int ret = 0;
 
+	if (the_repository->repository_format_submodule_encoding)
+		BUG("validate_submodule_git_dir() must be called with "
+		    "extensions.submoduleEncoding disabled.");
+
 	if (len <= suffix_len || (p = git_dir + len - suffix_len)[-1] != '/' ||
 	    strcmp(p, submodule_name))
 		BUG("submodule name '%s' not a suffix of git dir '%s'",
@@ -2559,33 +2591,74 @@ int submodule_to_gitdir(struct repository *repo,
 	return ret;
 }
 
+static int validate_and_set_submodule_gitdir(struct strbuf *gitdir_path,
+					     const char *submodule_name)
+{
+	char *key;
+
+	if (validate_submodule_encoded_git_dir(gitdir_path->buf, submodule_name))
+		return -1;
+
+	key = xstrfmt("submodule.%s.gitdir", submodule_name);
+	repo_config_set_gently(the_repository, key, gitdir_path->buf);
+	FREE_AND_NULL(key);
+
+	return 0;
+}
+
 void submodule_name_to_gitdir(struct strbuf *buf, struct repository *r,
 			      const char *submodule_name)
 {
+	const char *gitdir;
+	char *key;
+
+	repo_git_path_append(r, buf, "modules/");
+	strbuf_addstr(buf, submodule_name);
+
+	/* If extensions.submoduleEncoding is disabled, use the plain path set above */
+	if (!r->repository_format_submodule_encoding) {
+		if (validate_submodule_git_dir(buf->buf, submodule_name) < 0)
+			die(_("refusing to create/use '%s' in another submodule's "
+			      "git dir"), buf->buf);
+
+		return; /* plain gitdir is valid for use */
+	}
+
+	/* Extension is enabled: use the gitdir config if it exists */
+	key = xstrfmt("submodule.%s.gitdir", submodule_name);
+	if (!repo_config_get_string_tmp(r, key, &gitdir)) {
+		strbuf_reset(buf);
+		strbuf_addstr(buf, gitdir);
+		FREE_AND_NULL(key);
+
+		/* validate because users might have modified the config */
+		if (validate_submodule_encoded_git_dir(buf->buf, submodule_name))
+			die(_("Invalid 'submodule.%s.gitdir' config: '%s' please check "
+			      "if it is unique or conflicts with another module"),
+			    submodule_name, gitdir);
+
+		return;
+	}
+	FREE_AND_NULL(key);
+
 	/*
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
+	 * The gitdir config does not exist, even though the extension is enabled.
+	 * Therefore we are in one of the following cases:
 	 */
+
+	/* Case 1: legacy migration of valid plain submodule names */
+	if (!validate_and_set_submodule_gitdir(buf, submodule_name))
+		return;
+
+	/* Case 2: Try URI-safe (RFC3986) encoding first, this fixes nested gitdirs */
+	strbuf_reset(buf);
 	repo_git_path_append(r, buf, "modules/");
-	strbuf_addstr(buf, submodule_name);
+	strbuf_addstr_urlencode(buf, submodule_name, is_rfc3986_unreserved);
+	if (!validate_and_set_submodule_gitdir(buf, submodule_name))
+		return;
 
-	if (validate_submodule_git_dir(buf->buf, submodule_name) < 0)
-		die(_("refusing to create/use '%s' in another submodule's "
-		      "git dir"), buf->buf);
+	/* Case 3: Nothing worked: error out */
+	die(_("Cannot construct a valid gitdir path for submodule '%s': "
+	      "please set a unique git config for 'submodule.%s.gitdir'."),
+	    submodule_name, submodule_name);
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
index a5531df415..4187b35aee 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -884,6 +884,7 @@ integration_tests = [
   't7422-submodule-output.sh',
   't7423-submodule-symlinks.sh',
   't7424-submodule-mixed-ref-formats.sh',
+  't7425-submodule-encoding.sh',
   't7450-bad-git-dotfiles.sh',
   't7500-commit-template-squash-signoff.sh',
   't7501-commit-basic-functionality.sh',
diff --git a/t/t7425-submodule-encoding.sh b/t/t7425-submodule-encoding.sh
new file mode 100755
index 0000000000..f877887549
--- /dev/null
+++ b/t/t7425-submodule-encoding.sh
@@ -0,0 +1,164 @@
+#!/bin/sh
+
+test_description='submodules handle mixed legacy and new (encoded) style gitdir paths'
+
+. ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-verify-submodule-gitdir-path.sh
+
+test_expect_success 'setup: allow file protocol' '
+	git config --global protocol.file.allow always
+'
+
+test_expect_success 'create repo with mixed encoded and non-encoded submodules' '
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
+		git config extensions.submoduleEncoding true &&
+
+		git submodule add ../new-sub "New Sub" &&
+		test_commit new &&
+
+		# retrigger the "die_path_inside_submodule" check with encoding
+		test_must_fail git submodule add ../new-sub "New Sub/nested2"
+	)
+'
+
+test_expect_success 'verify submodule name is properly encoded' '
+	verify_submodule_gitdir_path main legacy modules/legacy &&
+	verify_submodule_gitdir_path main "New Sub" "modules/New Sub"
+'
+
+test_expect_success 'clone from repo with both legacy and new-style submodules' '
+	git clone --recurse-submodules main cloned-non-encoding &&
+	(
+		cd cloned-non-encoding &&
+
+		test_path_is_dir .git/modules/legacy &&
+		test_path_is_dir .git/modules/"New Sub" &&
+
+		git submodule status >list &&
+		test_grep "$legacy_rev legacy" list &&
+		test_grep "$new_rev New Sub" list
+	) &&
+
+	git clone -c extensions.submoduleEncoding=true --recurse-submodules main cloned-encoding &&
+	(
+		cd cloned-encoding &&
+
+		test_path_is_dir .git/modules/legacy &&
+		test_path_is_dir ".git/modules/New Sub" &&
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
+		cd cloned-encoding &&
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
+test_expect_success 'setup submodules with nested git dirs' '
+	git init nested &&
+	test_commit -C nested nested &&
+	(
+		cd nested &&
+		cat >.gitmodules <<-EOF &&
+		[submodule "hippo"]
+			url = .
+			path = thing1
+		[submodule "hippo/hooks"]
+			url = .
+			path = thing2
+		EOF
+		git clone . thing1 &&
+		git clone . thing2 &&
+		git add .gitmodules thing1 thing2 &&
+		test_tick &&
+		git commit -m nested
+	)
+'
+
+test_expect_success 'git dirs of encoded sibling submodules must not be nested' '
+	git clone -c extensions.submoduleEncoding=true --recurse-submodules nested clone_nested &&
+	verify_submodule_gitdir_path clone_nested hippo modules/hippo &&
+	verify_submodule_gitdir_path clone_nested hippo/hooks modules/hippo%2fhooks
+'
+
+test_expect_success 'submodule git dir nesting detection must work with parallel cloning' '
+	git clone -c extensions.submoduleEncoding=true --recurse-submodules --jobs=2 nested clone_parallel &&
+	verify_submodule_gitdir_path clone_parallel hippo modules/hippo &&
+	verify_submodule_gitdir_path clone_parallel hippo/hooks modules/hippo%2fhooks
+'
+
+test_expect_success 'disabling extensions.submoduleEncoding prevents nested submodules' '
+	(
+		cd clone_nested &&
+		# disable extension and verify failure
+		git config extensions.submoduleEncoding false &&
+		test_must_fail git submodule add ./thing2 hippo/foobar &&
+		# re-enable extension and verify it works
+		git config extensions.submoduleEncoding true &&
+		git submodule add ./thing2 hippo/foobar
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
2.51.0

