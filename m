Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F3633D6D6
	for <git@vger.kernel.org>; Fri, 11 Sep 2026 14:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789137977; cv=none; b=gvb3PeWoDvpo0vsBUZ7ZzEYWSj+cPNyZhfQT1qdYVMGBITAI9QiANP1Cio9Xa/5aiMNC/p0HeSsUhsuJcpikTjKHJJm9ODPmJoqRhQvcigetQeCgwsV9v8hF1G3A+hEuPx6MfM3+sbrk3vw17xHjzDAo4lS8E1DrULQSFQg3G1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789137977; c=relaxed/simple;
	bh=fe7+oKPtpBQ/vCfnOroilLNTMOY+si7QCnmfJ0W5FQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cwqxRiT6u2kGl7B07j38+qqtQrtMmGhXfuX5LYBlAPVPUs86zH9nhbITHk6z6spUMysAnKEwcaoOowHEj62xgDO0iraRcQaH9QTpy5NeaZTdBKOnCSZCNWckQ3FuSpZQLlItMzqWRHtjH1pdHWrYJInGHDBFAnKrosFfBrYuKwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VtzHKkSk; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VtzHKkSk"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-39647aa9d52so1098370a91.0
        for <git@vger.kernel.org>; Fri, 11 Sep 2026 07:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789137975; x=1789742775; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ku4QfXZxvsi5Mw/JwJW1bggO/MqZJQzRT8QMxmkn9i4=;
        b=VtzHKkSk01dGITHaqJBYoc8hFD0fRSHzjbA0IvZCGD0qx29vuF6CJTBsISXR/r3VWR
         PzuQC2/bV8THU1w5nkXzXMm4GSv/h6HwkH0Hoze6EYtslGTqo2dd9yU5y+vOKDZzWi4l
         1b3f35Lg5jS8Y2IzMkmD1AzNb/txo48+0nS/NJTxAihnSFmjeco51Tf+r7H/I6BDNZxH
         jxa+f5tGXODkaqIuJCz/8Gj2hpE64DuU3N3gOyVQifoawER1emiO61EVv0S3AzT1Vg8n
         sVIi5GQVtUZ3EsXKBwefYFciWm2I72GCN3hHWNH64+vLWiO2HaeKWvsnpmPpm9o1vAfB
         y3wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789137975; x=1789742775;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ku4QfXZxvsi5Mw/JwJW1bggO/MqZJQzRT8QMxmkn9i4=;
        b=fwruEWoXSTJxNoD7D4OKcPlLfk6CP9aoLXV5rqc+he4IJZDdM7uPbwQ0twutTUt4hS
         l35Lr5+4Ke6oqpfhqsUEHwRGXE9Y1B+qj29ABc40rCQaS3HhK0adHmkApTVtgV5NG7rk
         2Mk6qsn1tUh/bDNuKghiWV7+bon5QOuf+UFRJQ/FwRLQvbsGCVzIzXymtdRWtWRkQJnT
         nxpfzFT+O7gy2f559kY9iDPUYR2aNZDivTj37nkb+5UpUjTjiXCnJqVRvO7MYRBj2c1Y
         iTkaea1V+JZ+WEpA9izi0fRrqT38cklyGcLVKh8/vgo2ndWAeXfv2LdIqs7/BHUvwcTw
         cHDw==
X-Gm-Message-State: AFuF++l1brRtn+rZHZGwOvzEtVaWoXA9CwuA0P+facYkELADIbceAT6p
	Nhn+tNr8xjhyKwVt4ScHKW55qHRMnUw/ZmniaLjDAP7pjvJG8C/1xXL5
X-Gm-Gg: AYBFou1cC9fu7MX4Rxe+mpQ4Gy9SKf59qC0P+lgI9UlJzB01RB77C+8SWV0X/HiCK8t
	ikyNJPzknxGldBtA6Fot9OdXky1m+h/o5aPnzEethadQIBebvAH8MX+mLzdbhrJSUJf5hJMT0Bd
	7KvJKycrEl8WMUUMmdPPkZQc6cmgxIEVW5M0/3431Y9SCOM6/D0j4J+O/mwC+L7XzbT7AnbaSvC
	3zsOFUDXeeSxd2DyTUdxViMOYJufwgfjtvwFS5t01mvWnwuPSu0ak24/f92NiONMBrA0JQzf307
	BjnlBQADE1m+hIBfI7P3uEqUPrzanJ4VD1aFvBk7LJVjuanLU/zxr4tf7vauIU9rBUaKCluW6N0
	3A26oNI860MI11aRhaMTGtIZyiTMb8FYjoUACTh+NIpnDm7PoMFdQLUF6vOLoK+r8N4lTMEw5Pm
	HG31ywVYBqZs8TXCkU5exxJLGhvyBrNYA+FRCPBuMAAVVsoRFKVmtf/QbS5S7aEY51FwhCK8Kx2
	8TNaGuB4SJ+btFheFofOXDkmXdW7vW3Sz7dN2CxCAz9zxl1ne4ZSyLx5+Xw41xPNhr+waJWBEQk
	eHpqnA==
X-Received: by 2002:a17:90b:2685:b0:395:c3f7:2895 with SMTP id 98e67ed59e1d1-39d7791458cmr12414237a91.7.1789137974172;
        Fri, 11 Sep 2026 07:46:14 -0700 (PDT)
Received: from jayatheerth ([2405:201:c005:b959:7d42:d207:de10:1218])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14365b759d0sm7843335c88.7.2026.09.11.07.46.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 07:46:13 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: jayatheerthkulkarni2005@gmail.com
Cc: git@vger.kernel.org,
	jltobler@gmail.com,
	lucasseikioshiro@gmail.com,
	gitster@pobox.com
Subject: [GSoC Patch v6 1/7] repo: add path.toplevel with absolute and relative suffix formatting
Date: Fri, 11 Sep 2026 20:15:13 +0530
Message-ID: <20260911144519.1011780-2-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.55.GIT
In-Reply-To: <20260911144519.1011780-1-jayatheerthkulkarni2005@gmail.com>
References: <20260716012138.6714-1-jayatheerthkulkarni2005@gmail.com>
 <20260911144519.1011780-1-jayatheerthkulkarni2005@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Scripts frequently need to find the root directory of a repository's
working tree. Currently, this requires using `git rev-parse --show-toplevel`
or inferring it from other repository information.

Introduce `path.toplevel.absolute` and `path.toplevel.relative` keys
to `git repo info`. This allows scripts to retrieve the top-level
working tree path in a predictable, strictly formatted manner without
relying on `rev-parse`.

If requested in a bare repository where no working tree exists, the
command returns an empty string.

Mentored-by: Justin Tobler <jltobler@gmail.com>
Mentored-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
---
 Documentation/git-repo.adoc | 10 ++++++++++
 builtin/repo.c              | 24 ++++++++++++++++++++++++
 t/t1900-repo-info.sh        | 35 +++++++++++++++++++++++++++++++++++
 3 files changed, 69 insertions(+)

diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
index ed7d80c690..e34abe5fea 100644
--- a/Documentation/git-repo.adoc
+++ b/Documentation/git-repo.adoc
@@ -119,6 +119,16 @@ values that they return:
 `path.gitdir.relative`::
 	The path to the Git repository directory relative to the current working directory.
 
+`path.toplevel.absolute`::
+	The canonical absolute path to the top-level directory of the
+	repository's working tree. Outputs an empty string if the repository
+	is bare.
+
+`path.toplevel.relative`::
+	The path to the top-level directory of the repository's working
+	tree relative to the current working directory. Outputs an empty
+	string if the repository is bare.
+
 `references.format`::
 	The reference storage format. The valid values are:
 +
diff --git a/builtin/repo.c b/builtin/repo.c
index 84e012f83f..c31e9cfa70 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -121,6 +121,28 @@ static int get_path_gitdir_relative(struct repository *repo, struct strbuf *buf)
 	return 0;
 }
 
+static int get_path_toplevel_absolute(struct repository *repo, struct strbuf *buf)
+{
+	const char *work_tree = repo_get_work_tree(repo);
+
+	if (!work_tree)
+		return 0;
+
+	format_path(buf, work_tree, "", PATH_FORMAT_CANONICAL);
+	return 0;
+}
+
+static int get_path_toplevel_relative(struct repository *repo, struct strbuf *buf)
+{
+	const char *work_tree = repo_get_work_tree(repo);
+
+	if (!work_tree)
+		return 0;
+
+	format_path(buf, work_tree, repo->prefix, PATH_FORMAT_RELATIVE);
+	return 0;
+}
+
 static int get_references_format(struct repository *repo, struct strbuf *buf)
 {
 	strbuf_addstr(buf,
@@ -137,6 +159,8 @@ static const struct repo_info_field repo_info_field[] = {
 	{ "path.commondir.relative", get_path_commondir_relative },
 	{ "path.gitdir.absolute", get_path_gitdir_absolute },
 	{ "path.gitdir.relative", get_path_gitdir_relative },
+	{ "path.toplevel.absolute", get_path_toplevel_absolute },
+	{ "path.toplevel.relative", get_path_toplevel_relative },
 	{ "references.format", get_references_format },
 };
 
diff --git a/t/t1900-repo-info.sh b/t/t1900-repo-info.sh
index c85d390f43..9417d1ab65 100755
--- a/t/t1900-repo-info.sh
+++ b/t/t1900-repo-info.sh
@@ -213,4 +213,39 @@ test_repo_info_path 'gitdir with explicit GIT_DIR' 'gitdir' \
 	'.git' \
 	'GIT_DIR="../.git" && export GIT_DIR'
 
+test_expect_success 'path.toplevel absolute and relative' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		mkdir -p repo/sub &&
+		cd repo/sub &&
+
+		ROOT="$(test-tool path-utils real_path ..)" &&
+
+		echo "path.toplevel.absolute=$ROOT" >expect.abs &&
+		git repo info path.toplevel.absolute >actual.abs &&
+		test_cmp expect.abs actual.abs &&
+
+		echo "path.toplevel.relative=../" >expect.rel &&
+		git repo info path.toplevel.relative >actual.rel &&
+		test_cmp expect.rel actual.rel
+	)
+'
+
+test_expect_success 'path.toplevel absolute and relative in a bare repository' '
+	test_when_finished "rm -rf bare.git" &&
+	git init --bare bare.git &&
+	(
+		cd bare.git &&
+
+		echo "path.toplevel.absolute=" >expect.abs &&
+		git repo info path.toplevel.absolute >actual.abs &&
+		test_cmp expect.abs actual.abs &&
+
+		echo "path.toplevel.relative=" >expect.rel &&
+		git repo info path.toplevel.relative >actual.rel &&
+		test_cmp expect.rel actual.rel
+	)
+'
+
 test_done
-- 
2.55.GIT

