Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD4E35E1BF
	for <git@vger.kernel.org>; Tue, 25 Aug 2026 17:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787680778; cv=none; b=RJfER7c+Oqbx8IZaIgJK/CdoUB1G//Vo0D32jev7BqNvx2iwHDLjObD/bo7j7NYPPN37/46sE+YYNsV8jGwI6/cMZ3zkTQkM3CzQi03PwGLgMmkYIArn1ToszotvL/JdWE0v2JiYTESMY4W9V93a2jJ2PEE8hOciTPqLmwIKuKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787680778; c=relaxed/simple;
	bh=e8VO4FKYU1ffqjf7yRr5WINedwz1qjvhQ9OVASL8Z7U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jm0+hYlpkKOJnbbI7MIYbehsdwDmQ5Tf3fCbeHlZ3EyQc+b6RQN6b/WnMOVWO8Ff2WqNAjtnCjMBLHA8fVN3CIi2H87D1c6e4QJ84HZyzCE2MNkevCRn7hqGgBbg/C1Pog8U81gmbNA9Ol5jWqVUVrqIaY/Oi1zx08xFjc0P+II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JbXUwBea; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JbXUwBea"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2cace91f112so2047995ad.0
        for <git@vger.kernel.org>; Tue, 25 Aug 2026 10:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787680776; x=1788285576; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=i2Ez41QNhk4c+QFUXhHvgiWx1YTlYoX7KxY0lHQB01I=;
        b=JbXUwBeacIZDkXCA19b7FOJkzqhFd3P9GSPdunTGEy95z7zNo8DjfmYhbBr5OiexEk
         jbKzvzMFJesdCJl6Mp3tmSEOHa1CfW5x5eDLQpwsw/WsmXAg9fWvxQNgpl33YrcpjK7o
         TkVtrh8fEtw/0iFBpdH6T5aD3hmGdZeQd58dOvm9bGj5GbzJ/6AmdExHvvONw6TCnR88
         UfCcJuhPhY7p8yR6mFM8mv5dWPCBISdKmHXBOzJjl/YcDODIuBmGqqPmbUN/SmqW9ToG
         bQL+zxrnBdp0nS/s/ouVXhVkE37sosN/5+XjopsjCd9sWoPJuUfe1Svp7lyhAk+f2H2I
         qLYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787680776; x=1788285576;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=i2Ez41QNhk4c+QFUXhHvgiWx1YTlYoX7KxY0lHQB01I=;
        b=OM88xFUxo2RH0EbWlBlZ/QVNCi5dWjjlrqZHhV5Vnt4TVrjFKY0OeBU569ZKrxAIwa
         9CknivdxTGwK0QdkSeeg256IHuRWCPuVm+SHVvIVC/8lYTCbY5I8BZ5PrE0NWHf/5bwV
         DicU21S0DiwEY2H5Hj5Knda/pIq2cwqbW37/NFl8qnd3TfP6qHTU7I1YNA8h3CPLEu5W
         QK5UUSX8W5iPXHpxh/tgxNZi2ghkam2nPNkNQVsScgjrUvy9AyxpG8lyVQU3JIigCR+Y
         yF9WLx8neoaROZkmiYlZfA+F6LMYuj9l/cYZwurO1I6XszQyOyiK/6iY+794rh5wegnJ
         Wc9w==
X-Gm-Message-State: AFuF++laLZ59dHXT8PHUa4RqnB1RBYaJS691SLRWVmALxBi3F32E48qC
	VRrS63CRiZ+u72CS/BdkakWjkjm80wH+ciMAsRC1KUnTTPB5iq1lr5xj
X-Gm-Gg: AR+sD10iWOqMYtlQwIii/b2n5o8h1/N0DCyYYftIxwwiGsvF529HCEB5jf/WOXi6QD+
	+J6duFi5a+4LSzZO8l3Gsrhrn3/odXn2Ys/p95n+N4nAyMelaaoxP8ypJCoTwdhJgZ7+JPokVz/
	dpWjPdbjYdhw/EMrtaSj4AqqqmNqpvclqdjSe9QhozRAfMR4chgNoxHOkmFUU5nqh4GZqO25+Q1
	0icxfkFWFZ7BlH7nnqeUvp9tLqE75la1SxQu+Mw94aakFXo7UruG0DfhxgqqNNRF33ZnL6GSu0K
	uVaaquYk6U04chhBc9sVMitN1l7ysZaDlJ3OeZoGb0Bg8KhYvecDE/t//JJRKceS2iXhMTG5+GB
	EsvpCOoOOwFNKdvR3Bvp9tV23kja5ptAVXLOOHpC04Xj0EC/nxmRYdt/6tX+sdUKhjJu2IfNvlx
	BYkmudUyUiCLHxbTFzlXQP71aW4mZbbG9r4r4WdCUotV+J1MZ/Hxq1WCHgO1v1vmDzSEgeQCHR+
	qdVieiCEiv2U3BPYQkmY5lZRarNOUAUSupkZ0Jas4HdaQVWmchkzyVmFMX8o3OM/lzCN4g=
X-Received: by 2002:a17:90b:4b04:b0:396:4c63:7193 with SMTP id 98e67ed59e1d1-3966d3e1e87mr1895891a91.11.1787680776151;
        Tue, 25 Aug 2026 10:59:36 -0700 (PDT)
Received: from jayatheerth ([2405:201:c005:b959:7d42:d207:de10:1218])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141a8e118fasm954417c88.0.2026.08.25.10.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 10:59:35 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: jayatheerthkulkarni2005@gmail.com
Cc: git@vger.kernel.org,
	jltobler@gmail.com,
	lucasseikioshiro@gmail.com,
	gitster@pobox.com
Subject: [GSoC Patch v5 3/7] repo: add path.hooks with absolute and relative suffixes
Date: Tue, 25 Aug 2026 23:28:14 +0530
Message-ID: <20260825175818.645579-4-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.55.GIT
In-Reply-To: <20260825175818.645579-1-jayatheerthkulkarni2005@gmail.com>
References: <20260716012138.6714-1-jayatheerthkulkarni2005@gmail.com>
 <20260825175818.645579-1-jayatheerthkulkarni2005@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hooks are an integral part of a repository's configuration and are
commonly used by tooling to automate repository-specific workflows.
Currently, scripts typically retrieve the hooks directory by invoking
`git rev-parse --git-path hooks`.

Introduce `path.hooks.absolute` and `path.hooks.relative` keys to
`git repo info`. This exposes the hooks directory as a scriptable
config-like key using standard format rules, allowing scripts to
retrieve it through the same interface as other repository path
information.

Mentored-by: Justin Tobler <jltobler@gmail.com>
Mentored-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
---
 Documentation/git-repo.adoc |  9 +++++++++
 builtin/repo.c              | 22 ++++++++++++++++++++++
 t/t1900-repo-info.sh        | 28 ++++++++++++++++++++++++++--
 3 files changed, 57 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
index e524a07f53..20836cf8f6 100644
--- a/Documentation/git-repo.adoc
+++ b/Documentation/git-repo.adoc
@@ -119,6 +119,15 @@ values that they return:
 `path.gitdir.relative`::
 	The path to the Git repository directory relative to the current working directory.
 
+`path.hooks.absolute`::
+	The canonical absolute path to the repository's hooks directory.
+	Respects the `core.hooksPath` configuration. If `core.hooksPath` is
+	set to `/dev/null`, that value is returned unchanged.
+
+`path.hooks.relative`::
+	The path to the repository's hooks directory relative to the current
+	working directory. Respects the `core.hooksPath` configuration.
+
 `path.superproject-root.absolute`::
 	The canonical absolute path to the working tree root of the superproject
 	if the current repository is an initialized submodule. Outputs an empty
diff --git a/builtin/repo.c b/builtin/repo.c
index 47c4fce293..d7c451a771 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -122,6 +122,26 @@ static int get_path_gitdir_relative(struct repository *repo, struct strbuf *buf)
 	return 0;
 }
 
+static int get_path_hooks_absolute(struct repository *repo, struct strbuf *buf)
+{
+	struct strbuf hooks_path = STRBUF_INIT;
+
+	repo_git_path_replace(repo, &hooks_path, "hooks");
+	format_path(buf, hooks_path.buf, "", PATH_FORMAT_CANONICAL);
+	strbuf_release(&hooks_path);
+	return 0;
+}
+
+static int get_path_hooks_relative(struct repository *repo, struct strbuf *buf)
+{
+	struct strbuf hooks_path = STRBUF_INIT;
+
+	repo_git_path_replace(repo, &hooks_path, "hooks");
+	format_path(buf, hooks_path.buf, repo->prefix, PATH_FORMAT_RELATIVE);
+	strbuf_release(&hooks_path);
+	return 0;
+}
+
 static int get_path_superproject_absolute(struct repository *repo UNUSED, struct strbuf *buf)
 {
 	struct strbuf superproject = STRBUF_INIT;
@@ -188,6 +208,8 @@ static const struct repo_info_field repo_info_field[] = {
 	{ "path.commondir.relative", get_path_commondir_relative },
 	{ "path.gitdir.absolute", get_path_gitdir_absolute },
 	{ "path.gitdir.relative", get_path_gitdir_relative },
+	{ "path.hooks.absolute", get_path_hooks_absolute },
+	{ "path.hooks.relative", get_path_hooks_relative },
 	{ "path.superproject-root.absolute", get_path_superproject_absolute },
 	{ "path.superproject-root.relative", get_path_superproject_relative },
 	{ "path.toplevel.absolute", get_path_toplevel_absolute },
diff --git a/t/t1900-repo-info.sh b/t/t1900-repo-info.sh
index eec576a1d9..1da5db4942 100755
--- a/t/t1900-repo-info.sh
+++ b/t/t1900-repo-info.sh
@@ -174,7 +174,11 @@ test_repo_info_path () {
 			cd repo/sub &&
 			ROOT="$(test-tool path-utils real_path ..)" && export ROOT &&
 			eval "$init_command" &&
-			echo "path.$field_name.absolute=$ROOT/$expected_dir" >expect &&
+			case "$expected_dir" in
+			/*) EXPECT_ABS="$expected_dir" ;;
+			*) EXPECT_ABS="$ROOT/$expected_dir" ;;
+			esac &&
+			echo "path.$field_name.absolute=$EXPECT_ABS" >expect &&
 			git repo info "path.$field_name.absolute" >actual &&
 			test_cmp expect actual
 		)
@@ -188,7 +192,11 @@ test_repo_info_path () {
 			cd repo/sub &&
 			ROOT="$(test-tool path-utils real_path ..)" && export ROOT &&
 			eval "$init_command" &&
-			echo "path.$field_name.relative=../$expected_dir" >expect &&
+			case "$expected_dir" in
+			/*) EXPECT_REL="$(test-tool path-utils relative_path "$expected_dir" "$PWD")" ;;
+			*) EXPECT_REL="../$expected_dir" ;;
+			esac &&
+			echo "path.$field_name.relative=$EXPECT_REL" >expect &&
 			git repo info "path.$field_name.relative" >actual &&
 			test_cmp expect actual
 		)
@@ -213,6 +221,22 @@ test_repo_info_path 'gitdir with explicit GIT_DIR' 'gitdir' \
 	'.git' \
 	'GIT_DIR="../.git" && export GIT_DIR'
 
+test_repo_info_path 'hooks standard' 'hooks' '.git/hooks'
+
+test_repo_info_path 'hooks with core.hooksPath override' 'hooks' \
+	'custom-hooks' \
+	'git config core.hooksPath "$ROOT/custom-hooks" && mkdir -p "$ROOT/custom-hooks"'
+
+# /dev/null is not a real, canonicalizable filesystem path on Windows,
+# so path resolution for core.hooksPath=/dev/null cannot be expected to
+# produce a literal "/dev/null" the way it does on POSIX systems.
+if ! test_have_prereq MINGW
+then
+	test_repo_info_path 'hooks with core.hooksPath=/dev/null' 'hooks' \
+		'/dev/null' \
+		'git config core.hooksPath /dev/null'
+fi
+
 test_expect_success 'path.superproject-root absolute and relative' '
 	test_when_finished "rm -rf sub super" &&
 	git init sub &&
-- 
2.55.GIT

