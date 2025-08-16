Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79BF7308F3B
	for <git@vger.kernel.org>; Sat, 16 Aug 2025 21:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755380262; cv=pass; b=DHS6samfa0M3wLeVnZLy8fXDXvhIp4tLCdEs2/A7NzR1DAlyw4EWLfnrO6ieasaqAQhT/6sKkOkMthVr33uc9uGZtd+y0d/aB8bFfGWSOTDQjQO2X4Ic3arv8Fy6CQGwjw/ivIboCEj2GrH17i+ukZR9FlUatF6e7zIXwyzmSHE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755380262; c=relaxed/simple;
	bh=mvp0044tgI2OBJQdu2R+9f1arzGZLWrjL+NVkdS//TE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vc/p8KmAwSWYblJw21acya27RDfdXm7qzv9VtvRo8ynUXIpdu7XcPpUAj+jEMcaNRoXO5Orc6HJpBqeR+xo7MsiBwFrkKZti1x4aedjrMKUDK041AKKTgsQkG+wlN0Rmvxx1nEdXRWdk2XJmU3OU20MFa4t1FSiXWeRnk5vqp8U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=c3VeN4Zp; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="c3VeN4Zp"
ARC-Seal: i=1; a=rsa-sha256; t=1755380243; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ZzVoVCLfnIXlIrc6qkO/bV6lDKq3jZ1oy9wwwyHq22GA6QboF9CLf/PsQ9tBWekWrlueh3KjmnnKWQDdzoTr0ghaN+xTcKpZCd/kzEw4796EbYfV1rUGqCjkQfvZhr20hLwie8HuD5IHaX9vm1I/mfq4pwda+qas4sFYhMVmuYs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1755380243; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=vBjsY5jC7snwQUvs4bxzyIygmUWfFdvS3Qut9+QJsMg=; 
	b=KhqN04l/wsNLGb3SzqkB8qSvA4qmIt9ysagDbEgJ2WEb1iArDRoQMZxrT/WPPrFaNRAcR951Qiam+TocYZZXEAsKdZTjwITL0DSeN0HI4uBZ7s+SeC5+TUh/kM+UqCXJAIEzTn8y+87hyQ/PS/DH7YVi31k2advFNJIoLUbF+sg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1755380243;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=vBjsY5jC7snwQUvs4bxzyIygmUWfFdvS3Qut9+QJsMg=;
	b=c3VeN4Zp39u3U6V5xQy7T30NsygfcHJpTxinOeJ9q0DuZaGM1N70dqXZ9IdQ4RB1
	Ox8ixqz5CQ2AVfRbu+fsz4Txf4wYwR4JVZVV/AZrZiTSF76uW1hus+gpo9lHdWokBOr
	7JFQTGlesPC7wZ1e/Rzk8uOtJUTufs1WgmDiLJaM=
Received: by mx.zohomail.com with SMTPS id 1755380241056600.9112670162938;
	Sat, 16 Aug 2025 14:37:21 -0700 (PDT)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: git@vger.kernel.org
Cc: Emily Shaffer <emilyshaffer@google.com>,
	Rodrigo Damazio Bovendorp <rdamazio@google.com>,
	Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Aaron Schrab <aaron@schrab.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Patrick Steinhardt <ps@pks.im>,
	Adrian Ratiu <adrian.ratiu@collabora.com>,
	Brandon Williams <bmwill@google.com>
Subject: [PATCH 3/9] submodule: add gitdir path config override
Date: Sun, 17 Aug 2025 00:36:36 +0300
Message-ID: <20250816213642.3517822-4-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.50.1.679.gbf363a8fbb.dirty
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

This adds an ability to override gitdir paths via config files
(not .gitmodules), such that any encoding scheme can be changed
and JGit & co don't need to exactly match the default encoding.

A new test and a helper are added. The helper will be used by
further tests exercising gitdir paths & encodings.

Based-on-patch-by: Brandon Williams <bmwill@google.com>
Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
 builtin/submodule--helper.c           | 17 +++++++++++++++++
 submodule.c                           | 11 +++++++++++
 t/lib-verify-submodule-gitdir-path.sh | 15 +++++++++++++++
 t/t7400-submodule-basic.sh            | 15 +++++++++++++++
 4 files changed, 58 insertions(+)
 create mode 100644 t/lib-verify-submodule-gitdir-path.sh

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 7243429c6f..30e40d6c79 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1214,6 +1214,22 @@ static int module_summary(int argc, const char **argv, const char *prefix,
 	return ret;
 }
 
+static int module_gitdir(int argc, const char **argv, const char *prefix UNUSED,
+			 struct repository *repo UNUSED)
+{
+	struct strbuf gitdir = STRBUF_INIT;
+
+	if (argc != 2)
+		usage(_("git submodule--helper gitdir <name>"));
+
+	submodule_name_to_gitdir(&gitdir, the_repository, argv[1]);
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
@@ -3597,6 +3613,7 @@ int cmd_submodule__helper(int argc,
 		NULL
 	};
 	struct option options[] = {
+		OPT_SUBCOMMAND("gitdir", &fn, module_gitdir),
 		OPT_SUBCOMMAND("clone", &fn, module_clone),
 		OPT_SUBCOMMAND("add", &fn, module_add),
 		OPT_SUBCOMMAND("update", &fn, module_update),
diff --git a/submodule.c b/submodule.c
index dbf2244e60..bf78636195 100644
--- a/submodule.c
+++ b/submodule.c
@@ -2611,6 +2611,17 @@ void submodule_name_to_gitdir(struct strbuf *buf, struct repository *r,
 	 * administrators can explicitly set. Nothing has been decided,
 	 * so for now, just append the name at the end of the path.
 	 */
+	char *gitdir_path, *key;
+
+	/* Allow config override. */
+	key = xstrfmt("submodule.%s.gitdirpath", submodule_name);
+	if (!repo_config_get_string(r, key, &gitdir_path)) {
+		strbuf_addstr(buf, gitdir_path);
+		free(key);
+		free(gitdir_path);
+		return;
+	}
+	free(key);
 
 	/* Legacy behavior: allow existing paths under modules/<name>. */
 	repo_git_path_append(r, buf, "modules/");
diff --git a/t/lib-verify-submodule-gitdir-path.sh b/t/lib-verify-submodule-gitdir-path.sh
new file mode 100644
index 0000000000..fb5cb8eea4
--- /dev/null
+++ b/t/lib-verify-submodule-gitdir-path.sh
@@ -0,0 +1,15 @@
+# Helper to verify if repo $1 contains a submodule named $2 with gitdir in path $3
+
+verify_submodule_gitdir_path() {
+	repo="$1" &&
+	name="$2" &&
+	path="$3" &&
+	(
+		cd "$repo" &&
+		cat >expect <<-EOF &&
+			$(git rev-parse --git-common-dir)/$path
+		EOF
+		git submodule--helper gitdir "$name" >actual &&
+		test_cmp expect actual
+	)
+}
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index 178c386212..f4d4fb8397 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -13,6 +13,7 @@ GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-verify-submodule-gitdir-path.sh
 
 test_expect_success 'setup - enable local submodules' '
 	git config --global protocol.file.allow always
@@ -1505,4 +1506,18 @@ test_expect_success 'submodule add fails when name is reused' '
 	)
 '
 
+test_expect_success 'submodule helper gitdir config overrides' '
+	verify_submodule_gitdir_path test-submodule child submodules/child &&
+	(
+		cd test-submodule &&
+		git config submodule.child.gitdirpath ".git/submodules/custom-child"
+	) &&
+	verify_submodule_gitdir_path test-submodule child submodules/custom-child &&
+	(
+		cd test-submodule &&
+		git config --unset submodule.child.gitdirpath
+	) &&
+	verify_submodule_gitdir_path test-submodule child submodules/child
+'
+
 test_done
-- 
2.50.1.679.gbf363a8fbb.dirty

