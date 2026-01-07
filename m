Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7DF72848A4
	for <git@vger.kernel.org>; Wed,  7 Jan 2026 23:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767826994; cv=pass; b=fBwqe/5EQFTMWmwkHlqCbPua/dkgflmwy/+tcBNtymfSRj2hUncEAEjq/gX/VPBekqqVy0XuA80ePKXkn5agA4tscJs70X3DI79YlWP99iHRtLMWLb7CA/YZddEl/91vJeHaNmyiqUYolyLr7RvRdek3X7QX08nredBhpgc3XSs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767826994; c=relaxed/simple;
	bh=kn+Wvz21G648FvSXUniwzVQ7G1bZVKp+PkKWTPoggFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jqn7hVy/V6bTGkQbYPRo7uHSr1i/8zPDGy7ct1mjZ/S8+tR8wlZt0txAePOCZLD0I09a+DXq7jW+camgqbzfgKRS+GXsv2mKhwm9kxGPQ82/haYiNQmwg055BpDxLpth7BbGSiUkXkEYo3smPNYkCMOM/R3TpDfpBYUCTLDrATA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=QOwbre/O; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="QOwbre/O"
ARC-Seal: i=1; a=rsa-sha256; t=1767826978; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=fA8Wa8Vcf2Tbq3PTvS8lkY8BAHDdHRhBIOdTnStbOU8QOHnZIs9P8yZwKEYyOu8xgOrmY4brdUPYdzhT8b4Ak2h4vPhkSEbvZJz1HZ42xi3k2mC96s/OQanZYM1eSYLywcM24SFDfwz+5HfBEx7IklgAhh9lB5jX2plaM8CKATE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1767826978; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=bSqojsNGI/uXhfu9/WTdmibqvmKR7iihV0G+49xjjfM=; 
	b=YoYzREQ1Mq5m3VpdBpp8LN3CSWXVLu4uGQNFpKeHnIYGQtvL6DF6IZoyEkqDZ3eyYD8naIfitTYge8HVsEOsw1tbhCeW86jKGorqTqOILsdXHl726FYuAND4OYQzI/o9OOl5i+7I19CLfmfQd2fA2FLruKRI+F2j0s8FtCuBvmM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1767826978;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=bSqojsNGI/uXhfu9/WTdmibqvmKR7iihV0G+49xjjfM=;
	b=QOwbre/OlOz534aDJwTemYRIWR+cIdvjYv9Ts+AhsQii3udqgS0CEUif2xf5+EqR
	gZ8HCWjMToVSOjLhbWjBDmUoMyKfTbg//kXZG4vLZK1tsGYPAgzanGznHUEW9buVzSx
	+rEu5SyUnVoQyeRbsPVaCoSd36YmrA0qzknbBGFo=
Received: by mx.zohomail.com with SMTPS id 176782697637658.64190624847686;
	Wed, 7 Jan 2026 15:02:56 -0800 (PST)
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
Subject: [PATCH v8 06/11] submodule--helper: add gitdir migration command
Date: Thu,  8 Jan 2026 01:01:40 +0200
Message-ID: <20260107230145.517562-7-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260107230145.517562-1-adrian.ratiu@collabora.com>
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
 <20260107230145.517562-1-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Manually running
"git config submodule.<name>.gitdir .git/modules/<name>"
for each submodule can be impractical, so add a migration command to
submodule--helper to automatically create configs for all submodules
as required by extensions.submodulePathConfig.

The command calls create_default_gitdir_config() which validates the
gitdir paths before adding the configs.

Suggested-by: Junio C Hamano <gitster@pobox.com>
Suggested-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
 Documentation/config/extensions.adoc       |  6 +-
 builtin/submodule--helper.c                | 61 ++++++++++++++
 t/t7425-submodule-gitdir-path-extension.sh | 92 +++++++++++++++++++---
 3 files changed, 145 insertions(+), 14 deletions(-)

diff --git a/Documentation/config/extensions.adoc b/Documentation/config/extensions.adoc
index e8d9d9a19a..2aef3315b1 100644
--- a/Documentation/config/extensions.adoc
+++ b/Documentation/config/extensions.adoc
@@ -93,8 +93,10 @@ Git will error out if a module does not have a corresponding
 `submodule.<name>.gitdir` set.
 +
 Existing (pre-extension) submodules need to be migrated by adding the missing
-config entries. This is done manually for now, e.g. for each submodule:
-`git config submodule.<name>.gitdir .git/modules/<name>`.
+config entries. This can be done manually, e.g. for each submodule:
+`git config submodule.<name>.gitdir .git/modules/<name>`, or via the
+`git submodule--helper migrate-gitdir-configs` command which iterates over all
+submodules and attempts to migrate them.
 +
 The extension can be enabled automatically for new repositories by setting
 `init.defaultSubmodulePathConfig` to `true`, for example by running
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index b3d6f9ff68..271d549bac 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1266,6 +1266,66 @@ static int module_gitdir(int argc, const char **argv, const char *prefix UNUSED,
 	return 0;
 }
 
+static int module_migrate(int argc UNUSED, const char **argv UNUSED,
+			  const char *prefix UNUSED, struct repository *repo)
+{
+	struct strbuf module_dir = STRBUF_INIT;
+	DIR *dir;
+	struct dirent *de;
+	int repo_version = 0;
+
+	repo_git_path_append(repo, &module_dir, "modules/");
+
+	dir = opendir(module_dir.buf);
+	if (!dir)
+		die(_("could not open '%s'"), module_dir.buf);
+
+	while ((de = readdir(dir))) {
+		struct strbuf gitdir_path = STRBUF_INIT;
+		char *key;
+		const char *value;
+
+		if (is_dot_or_dotdot(de->d_name))
+			continue;
+
+		strbuf_addf(&gitdir_path, "%s/%s", module_dir.buf, de->d_name);
+		if (!is_git_directory(gitdir_path.buf)) {
+			strbuf_release(&gitdir_path);
+			continue;
+		}
+		strbuf_release(&gitdir_path);
+
+		key = xstrfmt("submodule.%s.gitdir", de->d_name);
+		if (!repo_config_get_string_tmp(repo, key, &value)) {
+			/* Already has a gitdir config, nothing to do. */
+			free(key);
+			continue;
+		}
+		free(key);
+
+		create_default_gitdir_config(de->d_name);
+	}
+
+	closedir(dir);
+	strbuf_release(&module_dir);
+
+	repo_config_get_int(the_repository, "core.repositoryformatversion", &repo_version);
+	if (repo_version == 0 &&
+	    repo_config_set_gently(repo, "core.repositoryformatversion", "1"))
+		die(_("could not set core.repositoryformatversion to 1. "
+		      "Please set it for migration to work, for example: "
+		      "git config core.repositoryformatversion 1"));
+
+	if (repo_config_set_gently(repo, "extensions.submodulePathConfig", "true"))
+		die(_("could not enable submodulePathConfig extension. It is required "
+		      "for migration to work. Please enable it in the root repo: "
+		      "git config extensions.submodulePathConfig true"));
+
+	repo->repository_format_submodule_path_cfg = 1;
+
+	return 0;
+}
+
 struct sync_cb {
 	const char *prefix;
 	const char *super_prefix;
@@ -3657,6 +3717,7 @@ int cmd_submodule__helper(int argc,
 		NULL
 	};
 	struct option options[] = {
+		OPT_SUBCOMMAND("migrate-gitdir-configs", &fn, module_migrate),
 		OPT_SUBCOMMAND("gitdir", &fn, module_gitdir),
 		OPT_SUBCOMMAND("clone", &fn, module_clone),
 		OPT_SUBCOMMAND("add", &fn, module_add),
diff --git a/t/t7425-submodule-gitdir-path-extension.sh b/t/t7425-submodule-gitdir-path-extension.sh
index 6cb844e809..d2a963d2f1 100755
--- a/t/t7425-submodule-gitdir-path-extension.sh
+++ b/t/t7425-submodule-gitdir-path-extension.sh
@@ -160,8 +160,8 @@ test_expect_success 'fetch mixed submodule changes and verify updates' '
 test_expect_success '`git init` respects init.defaultSubmodulePathConfig' '
 	git config --global init.defaultSubmodulePathConfig true &&
 	git init repo-init &&
-	git -C repo-init config extensions.submodulePathConfig > actual &&
-	echo true > expect &&
+	git -C repo-init config extensions.submodulePathConfig >actual &&
+	echo true >expect &&
 	test_cmp expect actual &&
 	# create a submodule and check gitdir
 	(
@@ -169,8 +169,8 @@ test_expect_success '`git init` respects init.defaultSubmodulePathConfig' '
 		git init -b main sub &&
 		test_commit -C sub sub-initial &&
 		git submodule add ./sub sub &&
-		git config submodule.sub.gitdir > actual &&
-		echo ".git/modules/sub" > expect &&
+		git config submodule.sub.gitdir >actual &&
+		echo ".git/modules/sub" >expect &&
 		test_cmp expect actual
 	) &&
 	git config --global --unset init.defaultSubmodulePathConfig
@@ -240,15 +240,15 @@ test_expect_success '`git clone` respects init.defaultSubmodulePathConfig' '
 		cd repo-clone &&
 
 		# verify new repo extension is inherited from global config
-		git config extensions.submodulePathConfig > actual &&
-		echo true > expect &&
+		git config extensions.submodulePathConfig >actual &&
+		echo true >expect &&
 		test_cmp expect actual &&
 
 		# new submodule has a gitdir config
 		git submodule add ../sub sub &&
 		test_path_is_dir .git/modules/sub &&
-		git config submodule.sub.gitdir > actual &&
-		echo ".git/modules/sub" > expect &&
+		git config submodule.sub.gitdir >actual &&
+		echo ".git/modules/sub" >expect &&
 		test_cmp expect actual
 	) &&
 	git config --global --unset init.defaultSubmodulePathConfig
@@ -262,8 +262,8 @@ test_expect_success '`git clone --recurse-submodules` respects init.defaultSubmo
 		cd repo-clone-recursive &&
 
 		# verify new repo extension is inherited from global config
-		git config extensions.submodulePathConfig > actual &&
-		echo true > expect &&
+		git config extensions.submodulePathConfig >actual &&
+		echo true >expect &&
 		test_cmp expect actual &&
 
 		# previous submodules should exist
@@ -275,11 +275,79 @@ test_expect_success '`git clone --recurse-submodules` respects init.defaultSubmo
 		# create another submodule and check that gitdir is created
 		git submodule add ../sub new-sub &&
 		test_path_is_dir .git/modules/new-sub &&
-		git config submodule.new-sub.gitdir > actual &&
-		echo ".git/modules/new-sub" > expect &&
+		git config submodule.new-sub.gitdir >actual &&
+		echo ".git/modules/new-sub" >expect &&
 		test_cmp expect actual
 	) &&
 	git config --global --unset init.defaultSubmodulePathConfig
 '
 
+test_expect_success 'submodule--helper migrates legacy modules' '
+	(
+		cd upstream &&
+
+		# previous submodules exist and were not migrated yet
+		test_must_fail git config submodule.sub1.gitdir &&
+		test_must_fail git config submodule.sub2.gitdir &&
+		test_path_is_dir .git/modules/sub1 &&
+		test_path_is_dir .git/modules/sub2 &&
+
+		# run migration
+		git submodule--helper migrate-gitdir-configs &&
+
+		# test that migration worked
+		git config submodule.sub1.gitdir >actual &&
+		echo ".git/modules/sub1" >expect &&
+		test_cmp expect actual &&
+		git config submodule.sub2.gitdir >actual &&
+		echo ".git/modules/sub2" >expect &&
+		test_cmp expect actual &&
+
+		# repository extension is enabled after migration
+		git config extensions.submodulePathConfig >actual &&
+		echo "true" >expect &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success '`git clone --recurse-submodules` works after migration' '
+	test_when_finished "rm -rf repo-clone-recursive" &&
+
+	# test with extension disabled after the upstream repo was migrated
+	git clone --recurse-submodules upstream repo-clone-recursive &&
+	(
+		cd repo-clone-recursive &&
+
+		# init.defaultSubmodulePathConfig was disabled before clone, so
+		# the repo extension config should also be off, the migration ignored
+		test_must_fail git config extensions.submodulePathConfig &&
+
+		# modules should look like there was no migration done
+		test_must_fail git config submodule.sub1.gitdir &&
+		test_must_fail git config submodule.sub2.gitdir &&
+		test_path_is_dir .git/modules/sub1 &&
+		test_path_is_dir .git/modules/sub2
+	) &&
+	rm -rf repo-clone-recursive &&
+
+	# enable the extension, then retry the clone
+	git config --global init.defaultSubmodulePathConfig true &&
+	git clone --recurse-submodules upstream repo-clone-recursive &&
+	(
+		cd repo-clone-recursive &&
+
+		# repository extension is enabled
+		git config extensions.submodulePathConfig >actual &&
+		echo "true" >expect &&
+		test_cmp expect actual &&
+
+		# gitdir configs exist for submodules
+		git config submodule.sub1.gitdir &&
+		git config submodule.sub2.gitdir &&
+		test_path_is_dir .git/modules/sub1 &&
+		test_path_is_dir .git/modules/sub2
+	) &&
+	git config --global --unset init.defaultSubmodulePathConfig
+'
+
 test_done
-- 
2.51.2

