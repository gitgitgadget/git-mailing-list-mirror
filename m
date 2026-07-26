Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB613603E0
	for <git@vger.kernel.org>; Sun, 26 Jul 2026 10:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785062860; cv=none; b=hIjzvZRMplQn2Bi7Hu2Oup2nSJQzZbov11DwfkhdVYejEU/X2QmnwD3g7mVrnQl3S86fKYNZRi75v/k2gylJskiNH3YAb7jlCot4gAzJy7+GMNkO9kjzdMA2u8yJ3ox5ASMUOTacjparmJnCatduK+GKgx384O9QDx4fDBr9KxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785062860; c=relaxed/simple;
	bh=sCYW9ZmP5PAulWSBG7bjtfpJsETw9n6OMMsa9nkbAgw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wq/AFs268K38ztkDZBt3FWHpXvKPC+HraxWb9M1es6X1FUJlxyzjAf7FEvjpw8U2fDam7uGP/9suw6JUabuCcUmib9eDrt+XOdSlxQ++uCI1cWI0k7bVFPIm08I2n7e3UU+u46mKNbsxMR2D/b07b8Vyw/6csHJ2HO2e0tPihVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JOxNA+4a; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JOxNA+4a"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c99eaa1f020so1665384a12.2
        for <git@vger.kernel.org>; Sun, 26 Jul 2026 03:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785062858; x=1785667658; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lKyi11uC/DavArOSXVLBtomjGo/OrrBcsKpDj+gII5k=;
        b=JOxNA+4a2WBV5jd5Ll1n7eHxxtAhNhejZP+PtyPr4eWfMnh6E5Vk8ddN7bXGXx0tOo
         R18TY8AHx5qMVeYDCUe8jsRILLWzKuJEZj00teiOwyThoHpUTw052DZhkvWQfL8xryUy
         qL2Mbg5zTpuc9bzfXaTrwq3mpyhbVSZgzLuRTfccwz1rPVDaCZfoOfkP57WlnNEC7bct
         633I38eTJs0z38X/lP8f2FagKNj9WU3oe+ct5jmAOP+iJbkXBQqM4P5S2eAXmJjy3cEk
         Edc+aqQ7KCYe5tIkCmZjKx3VGf2m1P6zWLf3G9S9Zu/ASmxChfnRh5SQsftrbdEWLHoe
         KA8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785062858; x=1785667658;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lKyi11uC/DavArOSXVLBtomjGo/OrrBcsKpDj+gII5k=;
        b=bq9iIMfBHPHNkTEuw03KeQDDsyU2UQ8pv7iCFjzK7cIwYHKldqfiDjtMMuZJTV0UKp
         LvBcFxQOiKT0U9VPwuTJ2iKH0yzfyBMgPBoloYgI5jILuIXLhpcwR1DFCfv72bBD9Lmp
         etk7Uvsm7ijeImLSh7J72OoNFPvuvzkbDUjQfEhXSw7Q+XM3BSDxuYxtwN+Fn0ZBnVDH
         2LSTZNOxBPtFTRHxOF1cOVbx3j9SoeqwOYYgIfUCoJVAJPmjjEPx7ilkCZgG/4T0m8aD
         H3Dyv+7pSLe6WCb2+nxm+eE6fga3WBcQ1kOSDA16ZIMQsomRp39PODNXOi95jdlLd6H1
         bXlw==
X-Gm-Message-State: AOJu0YxgdTiXgEfptI67/ki4A6Cu5pjvXm9umMwJdyYkcaeu+DNDELRD
	+Tep8u0x91OyReQwRu2u0flYikkCA2lkueONc6KnMbBlwG3ufFK6/vI7
X-Gm-Gg: AR+sD109ffxH3135g9f6qhlNE1Z5LcEhRDaHDwFh7LLw0iytMZXBGzjLk7yx46kItpt
	XT5yVXs9xUM/5rk0V6kCcyKwvuO4IWSwmrsnQcQMFXXAeOIjYrgApR91jJAWAytO/Xj7Zqpa6P7
	/vQtmtYeUi7u7ICuNjGBiQr6zRu51PjJTVEXNxqymrfR+w1IVRAf1fWImRYFcdhQpOfQJy4Qkmu
	2hQf0w3nDoMmQIixtCnBPh7oFqhN+8NKaqI8OxPMjji8lKIiI077s/M8XDzxsd9tJYezoGK7CQj
	FSOFVYNS0fMQSvttOyvJqS2AV1/xmefMWtXIt4vZITbx3nNRWDQTtzhaudlMbZFotQvBdjaTOi+
	+ZyNUMubUx7fF4Qv5irQOhuH6/FpQYN+KARYoKB0rtY8udgyFaqZHwiIoYRPbzfIsYSZo1wd+yo
	DtUp2oKfb5XpbG2SSa6dvlebmcZ8w4qDRl4gn/aQgu0+X6QFgWtqtIYng5+muhYIzOqL7nCdETa
	ffTO/7aZNFP8Uhhuiev6wU=
X-Received: by 2002:a05:6a21:6005:b0:3c3:b57b:6285 with SMTP id adf61e73a8af0-3c67d9b3d76mr4738331637.13.1785062858239;
        Sun, 26 Jul 2026 03:47:38 -0700 (PDT)
Received: from jayatheerth ([2405:201:c005:b959:7d42:d207:de10:1218])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc3e1255sm30371438eec.4.2026.07.26.03.47.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 03:47:37 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: jayatheerthkulkarni2005@gmail.com
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	jltobler@gmail.com,
	lucasseikioshiro@gmail.com
Subject: [PATCH v3 4/7] repo: add path.hooks with absolute and relative suffix formatting
Date: Sun, 26 Jul 2026 16:13:40 +0530
Message-ID: <20260726104343.16933-5-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.55.GIT
In-Reply-To: <20260726104343.16933-1-jayatheerthkulkarni2005@gmail.com>
References: <20260716012138.6714-1-jayatheerthkulkarni2005@gmail.com>
 <20260726104343.16933-1-jayatheerthkulkarni2005@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

External tool integrations and validation systems need a stable way to
identify where the repository hooks are stored. Currently, this involves
relying on `git rev-parse --git-path hooks` or querying `core.hooksPath`
manually.

Introduce `path.hooks.absolute` and `path.hooks.relative` keys to
`git repo info`. This allows tools to discover the active hooks location
natively, ensuring proper resolution regardless of whether Git is using
the standard `.git/hooks` structure or a custom `core.hooksPath` setup.

Mentored-by: Justin Tobler <jltobler@gmail.com>
Mentored-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
---
 Documentation/git-repo.adoc |  8 ++++++++
 builtin/repo.c              | 22 ++++++++++++++++++++++
 t/t1900-repo-info.sh        |  6 ++++++
 3 files changed, 36 insertions(+)

diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
index 8429a44b43..7bc1c51310 100644
--- a/Documentation/git-repo.adoc
+++ b/Documentation/git-repo.adoc
@@ -119,6 +119,14 @@ values that they return:
 `path.gitdir.relative`::
 	The path to the Git repository directory relative to the current working directory.
 
+`path.hooks.absolute`::
+	The canonical absolute path to the repository's hooks directory.
+	Respects `core.hooksPath` configuration adjustments.
+
+`path.hooks.relative`::
+	The path to the repository's hooks directory relative to the current
+	working directory. Respects `core.hooksPath` configuration adjustments.
+
 `path.objects.absolute`::
 	The canonical absolute path to the repository's object database directory.
 	Respects the `GIT_OBJECT_DIRECTORY` environment override.
diff --git a/builtin/repo.c b/builtin/repo.c
index d6bdd5bcfa..c921de222d 100644
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
+	format_path(buf, hooks_path.buf, startup_info->prefix, PATH_FORMAT_CANONICAL);
+	strbuf_release(&hooks_path);
+	return 0;
+}
+
+static int get_path_hooks_relative(struct repository *repo, struct strbuf *buf)
+{
+	struct strbuf hooks_path = STRBUF_INIT;
+
+	repo_git_path_replace(repo, &hooks_path, "hooks");
+	format_path(buf, hooks_path.buf, startup_info->prefix, PATH_FORMAT_RELATIVE);
+	strbuf_release(&hooks_path);
+	return 0;
+}
+
 static int get_path_objects_absolute(struct repository *repo, struct strbuf *buf)
 {
 	const char *obj_dir = repo_get_object_directory(repo);
@@ -216,6 +236,8 @@ static const struct repo_info_field repo_info_field[] = {
 	{ "path.commondir.relative", get_path_commondir_relative },
 	{ "path.gitdir.absolute", get_path_gitdir_absolute },
 	{ "path.gitdir.relative", get_path_gitdir_relative },
+	{ "path.hooks.absolute", get_path_hooks_absolute },
+	{ "path.hooks.relative", get_path_hooks_relative },
 	{ "path.objects.absolute", get_path_objects_absolute },
 	{ "path.objects.relative", get_path_objects_relative },
 	{ "path.superproject-working-tree.absolute", get_path_superproject_absolute },
diff --git a/t/t1900-repo-info.sh b/t/t1900-repo-info.sh
index 260f4fde43..cd3f856d04 100755
--- a/t/t1900-repo-info.sh
+++ b/t/t1900-repo-info.sh
@@ -213,6 +213,12 @@ test_repo_info_path 'gitdir with explicit GIT_DIR' 'gitdir' \
 	'.git' \
 	'GIT_DIR="../.git" && export GIT_DIR'
 
+test_repo_info_path 'hooks standard fallback' 'hooks' '.git/hooks'
+
+test_repo_info_path 'hooks with core.hooksPath override' 'hooks' \
+	'custom-hooks' \
+	'git config core.hooksPath "$ROOT/custom-hooks" && mkdir -p "$ROOT/custom-hooks"'
+
 test_repo_info_path 'objects standard' 'objects' '.git/objects'
 
 test_repo_info_path 'objects with GIT_OBJECT_DIRECTORY override' 'objects' \
-- 
2.55.GIT

