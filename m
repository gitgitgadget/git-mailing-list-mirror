Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7141C2957B6
	for <git@vger.kernel.org>; Sat, 13 Dec 2025 08:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765613369; cv=pass; b=JpKd2dhb4cm6rLEY97RAdSHgWArUx1cYoOvYw5tL6aIsOxJPXuXatq9xat4wNh8sSXYCJVQ+WVecVQDHOba0DLhv71Q8ZFO7ahdAhQfQShhLFD5y86K4SWe+3Oux8Ak3sgaStjwprEpjjTxJBxnSQ1UC33Jx/KYrr0h6Rx3Nbr8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765613369; c=relaxed/simple;
	bh=QJgV2UyL958Of8apcX4wsdEMpKRAJHL033E4n59c6RM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bxPul8iMiJKhxD41ihE2sJX/c/Z6Q01MVZlNLG9WDBUP8vcbE+NjQiedW+bGSTI+qQyK66bqyv2LXdT+RCXZ+OZjAtyhKEIu/8o0LoUd8X0V3yBTnYf2JXVkqauPLh64/WZjNAlevJL7XcrxlcyyAxkOywJqMD1wPHjTUXyjIlw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=cDMwmq+j; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="cDMwmq+j"
ARC-Seal: i=1; a=rsa-sha256; t=1765613353; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=HeHhyjqPBKrwIFGUDIfX4gMVYRKs41YyJdw/HfktmZQFi/8rh9WqBrOIb6/mrf4BzBIvuI1HuXekzREmOWaAv+WcNyarYTcBfFX/Nn1oK36q4m/1HPmuqH7xci0ZxJMDJKO016F51Dd9Cmp4VUJAcpsygCU0baJN7WqTrdXRUFA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1765613353; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=qnt1kuVB1VrFj8o2KLoqQKzDaBFzoEufyIe5WcQlJfI=; 
	b=lmNYQ0PID595CwyPrSvu+4iVH2eTjeWMn9UVASAQymCbvZ27iQsnpI93GuoE65zM2lLZNx8uQjI+eqVncae5YazklwSLRhYeArBvSSo+LmnTrbrH/QkNpfO7IZwSPAZHTE7EplXjcAwy9IQM8Ta9wYT02Bcb6Iv8LMTj3Sr8EYw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1765613353;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=qnt1kuVB1VrFj8o2KLoqQKzDaBFzoEufyIe5WcQlJfI=;
	b=cDMwmq+jlChbpkbQFqAENkCdfIo4oPnls2NLKTDNjAO5mLVAgLzKNl7FZHhrIscG
	Fjsj3VQEkFgswTHITWDH5TdleYYApzkEsLbypfKKt5xdSgQY5lvP3ypM/qQJs5IWz/S
	hZR3/L2bEO4R2O7F7TDAeMqFYvvA9DsxQgy3OMC0=
Received: by mx.zohomail.com with SMTPS id 176561335085318.805980958704026;
	Sat, 13 Dec 2025 00:09:10 -0800 (PST)
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
Subject: [PATCH v6 06/10] submodule--helper: add gitdir migration command
Date: Sat, 13 Dec 2025 10:08:12 +0200
Message-ID: <20251213080817.347922-7-adrian.ratiu@collabora.com>
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
 Documentation/config/extensions.adoc       |  6 ++-
 builtin/submodule--helper.c                | 58 ++++++++++++++++++++++
 t/t7425-submodule-gitdir-path-extension.sh | 34 +++++++++++++
 3 files changed, 96 insertions(+), 2 deletions(-)

diff --git a/Documentation/config/extensions.adoc b/Documentation/config/extensions.adoc
index 929e4e1bf1..63c8727c3b 100644
--- a/Documentation/config/extensions.adoc
+++ b/Documentation/config/extensions.adoc
@@ -80,8 +80,10 @@ submodulePathConfig:::
 	This extension can also be enabled as a global runtime config, with
 	the local repository config having precedence (overwrites it).
 	Existing pre-extension submodules need to be migrated by adding the
-	missing config entries. This is done manually for now, e.g. for each
-	submodule: "git config submodule.<name>.gitdir .git/modules/<name>".
+	missing config entries. This can be done manually, e.g. for each
+	submodule: "git config submodule.<name>.gitdir .git/modules/<name>",
+	or via the "git submodule--helper migrate-gitdir-configs" command
+	which iterates over all submodules and attempts to migrate them.
 
 worktreeConfig:::
 	If enabled, then worktrees will load config settings from the
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 2b5b4f575b..458dc863df 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1270,6 +1270,63 @@ static int module_gitdir(int argc, const char **argv, const char *prefix UNUSED,
 	return 0;
 }
 
+static int module_migrate(int argc UNUSED, const char **argv UNUSED,
+			  const char *prefix UNUSED, struct repository *repo)
+{
+	struct strbuf module_dir = STRBUF_INIT;
+	DIR *dir;
+	struct dirent *de;
+
+	if (repo_config_set_gently(repo, "core.repositoryformatversion", "1"))
+		die(_("could not set core.repositoryformatversion to 1. "
+		      "Please enable it for migration to work, for example: "
+		      "git config core.repositoryformatversion 1"));
+
+	if (repo_config_set_gently(repo, "extensions.submodulePathConfig", "true"))
+		die(_("could not enable submodulePathConfig extension. It is required "
+		      "for migration to work. Please enable it in the root repo: "
+		      "git config extensions.submodulePathConfig true"));
+
+	repo->repository_format_submodule_path_cfg = 1;
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
+	return 0;
+}
+
 struct sync_cb {
 	const char *prefix;
 	const char *super_prefix;
@@ -3654,6 +3711,7 @@ int cmd_submodule__helper(int argc,
 		NULL
 	};
 	struct option options[] = {
+		OPT_SUBCOMMAND("migrate-gitdir-configs", &fn, module_migrate),
 		OPT_SUBCOMMAND("gitdir", &fn, module_gitdir),
 		OPT_SUBCOMMAND("clone", &fn, module_clone),
 		OPT_SUBCOMMAND("add", &fn, module_add),
diff --git a/t/t7425-submodule-gitdir-path-extension.sh b/t/t7425-submodule-gitdir-path-extension.sh
index 2f198bff82..b7f0e8cdf4 100755
--- a/t/t7425-submodule-gitdir-path-extension.sh
+++ b/t/t7425-submodule-gitdir-path-extension.sh
@@ -181,4 +181,38 @@ test_expect_success 'runtime config extensions.submodulePathConfig on existing r
 	)
 '
 
+test_expect_success 'submodule--helper migrates legacy modules' '
+	git init sm-repo-1 &&
+	test_commit -C sm-repo-1 initial-1 &&
+	git init sm-repo-2 &&
+	test_commit -C sm-repo-2 initial-2 &&
+
+	# ensure the global config is disabled so we can actually test migration
+	git config --global extensions.submodulePathConfig false &&
+
+	git init -b main migrate-test &&
+	(
+		cd migrate-test &&
+
+		git submodule add ../sm-repo-1 sub1 &&
+		git submodule add ../sm-repo-2 sub2 &&
+		test_commit add-submodules &&
+
+		# gitdir configs should not exist
+		test_must_fail git config submodule.sub1.gitdir &&
+		test_must_fail git config submodule.sub2.gitdir &&
+
+		git submodule--helper migrate-gitdir-configs &&
+
+		# gitdir configs must exist after migration
+		git config submodule.sub1.gitdir >actual &&
+		echo ".git/modules/sub1" >expect &&
+		test_cmp expect actual &&
+
+		git config submodule.sub2.gitdir >actual &&
+		echo ".git/modules/sub2" >expect &&
+		test_cmp expect actual
+	)
+'
+
 test_done
-- 
2.51.2

