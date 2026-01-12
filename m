Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BDC33876DE
	for <git@vger.kernel.org>; Mon, 12 Jan 2026 18:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768244084; cv=pass; b=VQi+DMolFPz5NdkRzOuYN/Svl2HmZ17GU41zUZWeFDx0pZjkDqtYBmSOAR+gFTFUQtVST8GlV0OZ0eZcMbqsuVKI45MRtsnZo1p/n8WWmyyAwbMQVVlC5HwIyp2KESYHtpyrNk0nNhUehzTLxWgmzbRHxUg+0RKB887PIB9iQFU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768244084; c=relaxed/simple;
	bh=CIzuzo1EfBaEe2ysQ2m2t1aM//jYkzGgfzX7yIyrWME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TewG5p6GD9NZT9gCpawHPs88AjH7qNoO1oPGOlvBUNQDec6xet7WxzGAfKmTIaZYL+AkjGmlZ4a9tYPZQuB18lIPc1kQs7mUz1PcrxiweKyflz1NP+PZqMP0Jhmdfg45SoGbq+R936TeMA7Cf4JY3H+nqOJwGTkfpxwxGHPWy9Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=GKJIARC8; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="GKJIARC8"
ARC-Seal: i=1; a=rsa-sha256; t=1768244064; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=kn3K4VLuGJQi63FxQsOOSbZBtGB7dYBq9R0Y6vr0AWUQ1tngASUpbgvfAq+qocTNXkB7mSFTuf9pxFH+0k9k8YmRyxqZXfXylHmTnKU8gxynsaKgnMdrz0G9TGsnlFNeZlL2cCmQTXX7NAsHNu9JV5gEfSeQS67rVQIYlOPo654=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1768244064; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=hc0tTc4Dx8cz36oS8sI6LRhxcEB5ydDoeHjwzB4Mm8U=; 
	b=Ki58bH8rP7oB39y/x94gYqoH7pih89yE6pXt9FjrcF5vBtc3eXjo5HHT/auHUJtd7pO8uWwrI1RayYblF4/wWxXTD012Er67ZN2Gs68m4BmrY+NPbYvjr4m2QUKYAqvuffj6W7rQlS/SePRQXASPFJNCrK4ljmCq58uRoOelOdI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1768244064;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=hc0tTc4Dx8cz36oS8sI6LRhxcEB5ydDoeHjwzB4Mm8U=;
	b=GKJIARC8VM5dOiYnW6+6VBy3GHRY0TDl1n7yEY+S072jNtDJq8VQT27HaDGG45x3
	1Pd70TuddxEcFyHu9U+eVTkGU/mIfbUFOf4z38rooplsHLLTwRCB6yzFiwm1So7+VEx
	QuXjIlfHP2xqyFrFkQJwV7+UvIe6n4UVR4ujwjmc=
Received: by mx.zohomail.com with SMTPS id 1768244062799193.6016062827823;
	Mon, 12 Jan 2026 10:54:22 -0800 (PST)
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
Subject: [PATCH v9 05/11] submodule: allow runtime enabling extensions.submodulePathConfig
Date: Mon, 12 Jan 2026 20:46:26 +0200
Message-ID: <20260112184632.1334495-6-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260112184632.1334495-1-adrian.ratiu@collabora.com>
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
 <20260112184632.1334495-1-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Add a new config `init.defaultSubmodulePathConfig` which allows
enabling `extensions.submodulePathConfig` for new submodules by
default (those created via git init or clone).

Important: setting init.defaultSubmodulePathConfig = true does
not globally enable `extensions.submodulePathConfig`. Existing
repositories will still have the extension disabled and will
require migration (for example via git submodule--helper command
added in the next commit).

Suggested-by: Patrick Steinhardt <ps@pks.im>
Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
 Documentation/config/extensions.adoc       |   4 +
 Documentation/config/init.adoc             |   6 +
 setup.c                                    |  10 ++
 t/t7425-submodule-gitdir-path-extension.sh | 122 +++++++++++++++++++++
 4 files changed, 142 insertions(+)

diff --git a/Documentation/config/extensions.adoc b/Documentation/config/extensions.adoc
index f4f57c9114..e8d9d9a19a 100644
--- a/Documentation/config/extensions.adoc
+++ b/Documentation/config/extensions.adoc
@@ -95,6 +95,10 @@ Git will error out if a module does not have a corresponding
 Existing (pre-extension) submodules need to be migrated by adding the missing
 config entries. This is done manually for now, e.g. for each submodule:
 `git config submodule.<name>.gitdir .git/modules/<name>`.
++
+The extension can be enabled automatically for new repositories by setting
+`init.defaultSubmodulePathConfig` to `true`, for example by running
+`git config --global init.defaultSubmodulePathConfig true`.
 
 worktreeConfig:::
 	If enabled, then worktrees will load config settings from the
diff --git a/Documentation/config/init.adoc b/Documentation/config/init.adoc
index e45b2a8121..7b4abdaf8b 100644
--- a/Documentation/config/init.adoc
+++ b/Documentation/config/init.adoc
@@ -18,3 +18,9 @@ endif::[]
 	See `--ref-format=` in linkgit:git-init[1]. Both the command line
 	option and the `GIT_DEFAULT_REF_FORMAT` environment variable take
 	precedence over this config.
+
+init.defaultSubmodulePathConfig::
+	A boolean that specifies if `git init` and `git clone` should
+	automatically set `extensions.submodulePathConfig` to `true`. This
+	allows all new repositories to automatically use the submodule path
+	extension. Defaults to `false` when unset.
diff --git a/setup.c b/setup.c
index 428427d689..0378483b69 100644
--- a/setup.c
+++ b/setup.c
@@ -2310,6 +2310,7 @@ void initialize_repository_version(int hash_algo,
 {
 	struct strbuf repo_version = STRBUF_INIT;
 	int target_version = GIT_REPO_VERSION;
+	int default_submodule_path_config = 0;
 
 	/*
 	 * Note that we initialize the repository version to 1 when the ref
@@ -2348,6 +2349,15 @@ void initialize_repository_version(int hash_algo,
 		clear_repository_format(&repo_fmt);
 	}
 
+	repo_config_get_bool(the_repository, "init.defaultSubmodulePathConfig",
+			     &default_submodule_path_config);
+	if (default_submodule_path_config) {
+		/* extensions.submodulepathconfig requires at least version 1 */
+		if (target_version == 0)
+			target_version = 1;
+		repo_config_set(the_repository, "extensions.submodulepathconfig", "true");
+	}
+
 	strbuf_addf(&repo_version, "%d", target_version);
 	repo_config_set(the_repository, "core.repositoryformatversion", repo_version.buf);
 
diff --git a/t/t7425-submodule-gitdir-path-extension.sh b/t/t7425-submodule-gitdir-path-extension.sh
index 453183e27c..03ac165de9 100755
--- a/t/t7425-submodule-gitdir-path-extension.sh
+++ b/t/t7425-submodule-gitdir-path-extension.sh
@@ -157,4 +157,126 @@ test_expect_success 'fetch mixed submodule changes and verify updates' '
 	)
 '
 
+test_expect_success '`git init` respects init.defaultSubmodulePathConfig' '
+	test_config_global init.defaultSubmodulePathConfig true &&
+	git init repo-init &&
+	git -C repo-init config extensions.submodulePathConfig >actual &&
+	echo true >expect &&
+	test_cmp expect actual &&
+	# create a submodule and check gitdir
+	(
+		cd repo-init &&
+		git init -b main sub &&
+		test_commit -C sub sub-initial &&
+		git submodule add ./sub sub &&
+		git config submodule.sub.gitdir >actual &&
+		echo ".git/modules/sub" >expect &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success '`git init` does not set extension by default' '
+	git init upstream &&
+	test_commit -C upstream initial &&
+	test_must_fail git -C upstream config extensions.submodulePathConfig &&
+	# create a pair of submodules and check gitdir is not created
+	git init -b main sub &&
+	test_commit -C sub sub-initial &&
+	(
+		cd upstream &&
+		git submodule add ../sub sub1 &&
+		test_path_is_dir .git/modules/sub1 &&
+		test_must_fail git config submodule.sub1.gitdir &&
+		git submodule add ../sub sub2 &&
+		test_path_is_dir .git/modules/sub2 &&
+		test_must_fail git config submodule.sub2.gitdir &&
+		git commit -m "Add submodules"
+	)
+'
+
+test_expect_success '`git clone` does not set extension by default' '
+	test_when_finished "rm -rf repo-clone-no-ext" &&
+	git clone upstream repo-clone-no-ext &&
+	(
+		cd repo-clone-no-ext &&
+
+		test_must_fail git config extensions.submodulePathConfig &&
+		test_path_is_missing .git/modules/sub1 &&
+		test_path_is_missing .git/modules/sub2 &&
+
+		# create a submodule and check gitdir is not created
+		git submodule add ../sub sub3 &&
+		test_must_fail git config submodule.sub3.gitdir
+	)
+'
+
+test_expect_success '`git clone --recurse-submodules` does not set extension by default' '
+	test_when_finished "rm -rf repo-clone-no-ext" &&
+	git clone --recurse-submodules upstream repo-clone-no-ext &&
+	(
+		cd repo-clone-no-ext &&
+
+		# verify that that submodules do not have gitdir set
+		test_must_fail git config extensions.submodulePathConfig &&
+		test_path_is_dir .git/modules/sub1 &&
+		test_must_fail git config submodule.sub1.gitdir &&
+		test_path_is_dir .git/modules/sub2 &&
+		test_must_fail git config submodule.sub2.gitdir &&
+
+		# create another submodule and check that gitdir is not created
+		git submodule add ../sub sub3 &&
+		test_path_is_dir .git/modules/sub3 &&
+		test_must_fail git config submodule.sub3.gitdir
+	)
+
+'
+
+test_expect_success '`git clone` respects init.defaultSubmodulePathConfig' '
+	test_when_finished "rm -rf repo-clone" &&
+	test_config_global init.defaultSubmodulePathConfig true &&
+	git clone upstream repo-clone &&
+	(
+		cd repo-clone &&
+
+		# verify new repo extension is inherited from global config
+		git config extensions.submodulePathConfig >actual &&
+		echo true >expect &&
+		test_cmp expect actual &&
+
+		# new submodule has a gitdir config
+		git submodule add ../sub sub &&
+		test_path_is_dir .git/modules/sub &&
+		git config submodule.sub.gitdir >actual &&
+		echo ".git/modules/sub" >expect &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success '`git clone --recurse-submodules` respects init.defaultSubmodulePathConfig' '
+	test_when_finished "rm -rf repo-clone-recursive" &&
+	test_config_global init.defaultSubmodulePathConfig true &&
+	git clone  --recurse-submodules upstream repo-clone-recursive &&
+	(
+		cd repo-clone-recursive &&
+
+		# verify new repo extension is inherited from global config
+		git config extensions.submodulePathConfig >actual &&
+		echo true >expect &&
+		test_cmp expect actual &&
+
+		# previous submodules should exist
+		git config submodule.sub1.gitdir &&
+		git config submodule.sub2.gitdir &&
+		test_path_is_dir .git/modules/sub1 &&
+		test_path_is_dir .git/modules/sub2 &&
+
+		# create another submodule and check that gitdir is created
+		git submodule add ../sub new-sub &&
+		test_path_is_dir .git/modules/new-sub &&
+		git config submodule.new-sub.gitdir >actual &&
+		echo ".git/modules/new-sub" >expect &&
+		test_cmp expect actual
+	)
+'
+
 test_done
-- 
2.52.0

