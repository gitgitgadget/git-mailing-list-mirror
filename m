Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9DFC439F90
	for <git@vger.kernel.org>; Thu,  6 Aug 2026 10:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786011858; cv=none; b=VIYI02ftj25Rk87lGQO9yCynNWrOCj6Cwi0SWqJgDMY+dLloBd/DRZ5Q9Wyh483M/wwJlcfOIkElv7y59saHKaO/l9uHYQxr3A3hngQw4biq6bYNe2OeeNWSzPXydKtJbFmVodFKy2czt2vzUoU6OZZRdMrwBVP0bSjg59+yfb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786011858; c=relaxed/simple;
	bh=e8VO4FKYU1ffqjf7yRr5WINedwz1qjvhQ9OVASL8Z7U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Na6j0aaGBJFaaPyoC0JhiOv+OJCMKunNeGLcw0cwZZlOct5dPMPnUDuTZQuHAf3a6QbQvfGgtO02n7yiVpogNeOsDoe6CkdLEct40hEaNoMTkLf7a522OoNH9p9qA/l7ISoEhElYJD8TfMgiD84Naw7GBfL7PXf967C61To518A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qneg3lAk; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qneg3lAk"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-ca97d139d5fso1616433a12.0
        for <git@vger.kernel.org>; Thu, 06 Aug 2026 03:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786011856; x=1786616656; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=i2Ez41QNhk4c+QFUXhHvgiWx1YTlYoX7KxY0lHQB01I=;
        b=qneg3lAk6y8+Y3L26kfLHFd2wIZZixTM1esAGzSkf553bcrz1VNu3ZjhTfc8WHlVma
         zrB/Ehy1RgHHCoOnDd4ykC/751ZKu/4i84NbNXZ7GadtRrCb4eA7BcLaIoqGZ55tIyf/
         ieOoaaFBQST9l9T+//FFoQbsvBB0c/Dz9abYeTDbo4Ywh8qrREg+NvRSzYHkldSfBbU4
         p7cLbth2PEi++8Lb0CXFYYxM92Nsa9jAPUYuMkvX7lRG6xnPfkuXgpt2ZSRqmM4zxUUI
         HwGeEuiytAHIRnKw7bUEAIAreORAb37CcpcO6J0Quy7bckNeDBG4XzdVMKQL0huPejY9
         Rghw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786011856; x=1786616656;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=i2Ez41QNhk4c+QFUXhHvgiWx1YTlYoX7KxY0lHQB01I=;
        b=HJbYZ5CxtalDwRhf2s7LkIT6oMkA7So4j8j4vQ2AQL411S2J+empS54uxBXUdDndbc
         ZsCqdsKzKoIxbjY+kMK7yAR0uPpoMP6vNotNULbx0B6WBWec0/5iqzCqtmChdGa0Xgdo
         xmif+b03V/mxxr2qiRGrzLRB7LhYhL+UoqpMWneHgGoaPKPi2PoLQir+Wj53FI17CGSh
         mcfX5KEceCO70AXSzAUsEMf0xFGZeILqpPJ812QWk6YJWPq/A3pXES4E/7YKANIBV1tb
         8VRe7mwUsd9Z546a8cJlqWB6GspQGsTEEnXbTgHeLavNXacEC2XOncG1yzjDqQx74ird
         lvjA==
X-Gm-Message-State: AOJu0YykiPjNwy2dR0U1IGKacgWvgTh+7+bpWmX89yZaqFaJMpJLxtYx
	jNNJqqIU0FQzcKx8t3FX5s/G1k6JhYBcrkKi5mYc3bfab3sSCjTKc24z
X-Gm-Gg: AR+sD1291PV2ucoZPNPowgjUdqRPDatG/u9GD1y9hP/CswuAJhtv8b5IZGS2tdxtmIg
	+w70AZfsfruPdJdREThgGvQPR2UTxZF1RPtn1hSVFJr6stRGbrKVI4WdHlGNxB1mw5/5+cmb0IM
	DWjRMpdun7Ix3tCTsCQepYy1XVo75k0AYaUU9vrMCQl5k0OKi5+gLb0dm7JbR+GSwHcTeMe78iF
	K7rbu7g41npsAmwpWhC6uGyYr0UraHP9RRpNDbIPsHT3dZ68nUfSLbycaDxUJiniXNIht5A8hN+
	XM2KaZjk1x6hLmAUh15ZCIkIvJQmCionm3JKUU7EhGv1bO26GFyXLQW9wslDoRaBmuWkYLax29j
	qifF3XqqyOLNo6/uC+jkgjfUQFNIYfhiobfzriAitxndCCoEnAVeXgv5xnxWM6EiklfXGK2KC6E
	rOzas2CxAZAN11GqY/OC6wszWnyPiqMfuvBJN/LJonjib4qf3ooWstEwns9jyoGFkrSl9Rfk9nF
	i00qR2woA852rXMihIU52AZONxgv9CIyn8tYfJKC7qYbEWZtKdI0CHBTBBlFstz/Zaf9Ag=
X-Received: by 2002:a05:6a21:685:b0:3c3:7f50:fc3a with SMTP id adf61e73a8af0-3cb86027c01mr16418440637.33.1786011856254;
        Thu, 06 Aug 2026 03:24:16 -0700 (PDT)
Received: from jayatheerth ([2405:201:c005:b959:7d42:d207:de10:1218])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315863b76cfsm25525901eec.4.2026.08.06.03.24.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 03:24:15 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: jayatheerthkulkarni2005@gmail.com
Cc: git@vger.kernel.org,
	jltobler@gmail.com,
	lucasseikioshiro@gmail.com
Subject: [GSoC PATCH v4 3/7] repo: add path.hooks with absolute and relative suffixes
Date: Thu,  6 Aug 2026 15:45:52 +0530
Message-ID: <20260806101556.162940-4-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.55.GIT
In-Reply-To: <20260806101556.162940-1-jayatheerthkulkarni2005@gmail.com>
References: <20260716012138.6714-1-jayatheerthkulkarni2005@gmail.com>
 <20260806101556.162940-1-jayatheerthkulkarni2005@gmail.com>
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

