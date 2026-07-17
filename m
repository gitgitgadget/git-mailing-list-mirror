Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E482C3757
	for <git@vger.kernel.org>; Fri, 17 Jul 2026 13:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784295340; cv=none; b=e108QHdC104dyrYiX9YJzoGIxGH6Oz/UD0JdsIYHZ2GNjceWbguUvIDW1Na1wTmTrXdmuMpngq5ILKBtLYh4vRne674cEKCTpn7dtvworhG07R4MaKFdSFNreThelb8SY+ZYvHd9gEijaTMJgT7K4Fm5JeL/Mmyj9uLR7Qv4NN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784295340; c=relaxed/simple;
	bh=dSMppWfanvz1+zwfxiKMrt982ASFjQ8XUEqjznzHWoA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bosfxDlCD75ZkM4xaLCjePk9/cQKmeZ+2Daj+ISQZnKkpBrtMSUJMfjOXaHnVeHr7MLCKFtG89bmbZSkQdfOxzf9oNJLJ1yWj16q155cB6oRlz4sg+5U9sD//zhRiQADTHK4wdr1LMYA11cPghTv2tniRUNHmWYesK2eXhCp3ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TnFgxfQF; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TnFgxfQF"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-38de840f2f0so4440395a91.0
        for <git@vger.kernel.org>; Fri, 17 Jul 2026 06:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784295339; x=1784900139; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=x+n1XNlYQmhBCVtj7SLWqGvmbXicQdXgFygkmnGbuYg=;
        b=TnFgxfQF0idFm9x6DJI/ZLehNyNtzLk6GPnkvcmMM/uoMvULKBtlwu0IDymUW9KQc3
         895S78QukxCh45Vy8ZzoWN6fzYcXErf7wy8F09kL6/YZjd6Zf2z1pmeh50icLv6yVWFC
         LjKe80jAI8B6aG9jhNfKBP7Js1ISQb4cIXTZcwsTEu6uUNDi6GTVSYHGsoXN1mGa/fF0
         MCCg8TxHltjBs7IHl7m2xtTbgoiZDIusB8eB92w2f6+2k1HaN+lL1XIzL7QgNM6FTCfV
         vm/diiw7gGN0+dfS2oXu1hE6whoSA/eAZBEsbQCP72vvtsInV0zyJcDpFitsflx4Sthw
         9c0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784295339; x=1784900139;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=x+n1XNlYQmhBCVtj7SLWqGvmbXicQdXgFygkmnGbuYg=;
        b=DV4RqVd4AYSfNbM7BTDzx5e87YIc1+vbz+S0WQFv1dp/kKBZ0tXuJhpCGcsS+qWOf0
         MpSy22vOOk8IK1wZQ3JG/4PRfCLDHrQ+2a51GDziSWMgolzJY1r7ZnxMprWUIBnTSn7+
         RgYhCzaebWrNs3AV5GlaSCw5aPh1HADOyskhEeXq9CsSJ3jLEIqfMyhldhwXMxFTpRni
         FnJw+oRMKhzk1q/tEVg9OrtUhlQ+tF9VYg9gC4mEFbJODSqS49546gDXnxTenH80RFZ8
         xuUwKCwrH/t/OoelDIoUL0SzR1wYlTyOC9W13DVKOKQP2Pl1yYc0uR+Jr8lD248jeW5D
         v8QA==
X-Gm-Message-State: AOJu0Yxk+3Rxt8VzOGRlTfCA/iHqySjidTEOXDwiZMewb6yCazMi+eEi
	buebAN5uUwbLq5v9vRhUu7T2tMBRxSElOCgW4bM0SsJ8XdQIkexWAxG1
X-Gm-Gg: AfdE7cmbM1RBoS1tGuoqpptFhVoozD8L8c9x4Fuf8tA4IV9kCcn1452VOFh4gNrcGdm
	venycALmFstlWlxApijSgVnJuM1LsLivdDsJNIszo3cLy7WH16tEEu4iYPc+Nn8h9Iv3OEwus2S
	hRF2ZhzpZdzUW7gKxhGc/Xek+SD6JWJvCfYPFfnEoAm3ueNm5cuGhUrBMUrbE8ZS9y/31kKyslG
	i+LOU3bJ5n+uCqVe6qwmgK7vww49n7xB5Dck+SgqPATyxLZh0nla+NOH1FlQlE0v8XmBpB0K5OG
	qOsRsmgkzSiiG4+mUCUeWHsL4ij6ZvYkgPIy1Fz6gRLaEPWXVT+GGwaoSR9Kmzptfh3QQtCOLQY
	JKeM7LkfaZR9iSf+6lMHQ4NsMmP5t2m25D5x/j2tJukgHZWq+1mCq4I/fE71U2iHTAvLesJGl0w
	UmQv0ufe//zsfLh8+g8/XAb9HVLXjJf8hhUjwx4h5u+CqwvK/HV03FFi0TPPfl+bQbPA8qBgy1y
	JdtVkq0pTai
X-Received: by 2002:a17:90a:e7d1:b0:38d:e442:901e with SMTP id 98e67ed59e1d1-38e4b516836mr2792464a91.27.1784295338945;
        Fri, 17 Jul 2026 06:35:38 -0700 (PDT)
Received: from jayatheerth ([2405:201:c005:b959:7d42:d207:de10:1218])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3142a20cfe3sm7867411eec.30.2026.07.17.06.35.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 06:35:38 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: jayatheerthkulkarni2005@gmail.com
Cc: git@vger.kernel.org,
	jltobler@gmail.com,
	lucasseikioshiro@gmail.com
Subject: [GSoC Patch v2 7/7] repo: add path.git-prefix path key
Date: Fri, 17 Jul 2026 19:00:15 +0530
Message-ID: <20260717133015.32040-8-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.55.GIT
In-Reply-To: <20260717133015.32040-1-jayatheerthkulkarni2005@gmail.com>
References: <20260716012138.6714-1-jayatheerthkulkarni2005@gmail.com>
 <20260717133015.32040-1-jayatheerthkulkarni2005@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Scripts and command-line prompt integrations frequently need to know their
relative depth inside a repository working tree layout. Currently, this
is retrieved using `git rev-parse --show-prefix`.

Introduce the `path.git-prefix` key to `git repo info`. This mirrors the
prefix location tracking framework as a standalone key, returning the
exact relative path offset complete with a trailing slash, or an empty
string if run directly at the repository working tree root.

Mentored-by: Justin Tobler <jltobler@gmail.com>
Mentored-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
---
 Documentation/git-repo.adoc |  5 +++++
 builtin/repo.c              | 11 +++++++++++
 t/t1900-repo-info.sh        | 19 +++++++++++++++++++
 3 files changed, 35 insertions(+)

diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
index 6c962620ec..5ba2ab1612 100644
--- a/Documentation/git-repo.adoc
+++ b/Documentation/git-repo.adoc
@@ -113,6 +113,11 @@ values that they return:
 	The path to the Git repository's common directory relative to
 	the current working directory.
 
+`path.git-prefix`::
+	The relative path from the top-level directory of the working tree to
+	the current working directory (including a trailing slash). Outputs an
+	empty string if executed at the root of the working tree.
+
 `path.gitdir.absolute`::
 	The canonical absolute path to the Git repository directory (the `.git` directory).
 
diff --git a/builtin/repo.c b/builtin/repo.c
index a97ad71649..b93c140c74 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -100,6 +100,16 @@ static int get_path_commondir_relative(struct repository *repo, struct strbuf *b
 	return 0;
 }
 
+static int get_path_git_prefix(struct repository *repo UNUSED, struct strbuf *buf)
+{
+	/*
+	 * startup_info->prefix is NULL if we are at the working tree root.
+	 * We add an empty string to ensure the buffer is cleanly initialized.
+	 */
+	strbuf_addstr(buf, startup_info->prefix ? startup_info->prefix : "");
+	return 0;
+}
+
 static int get_path_gitdir_absolute(struct repository *repo, struct strbuf *buf)
 {
 	const char *git_dir = repo_get_git_dir(repo);
@@ -278,6 +288,7 @@ static const struct repo_info_field repo_info_field[] = {
 	{ "object.format", get_object_format },
 	{ "path.commondir.absolute", get_path_commondir_absolute },
 	{ "path.commondir.relative", get_path_commondir_relative },
+	{ "path.git-prefix", get_path_git_prefix },
 	{ "path.gitdir.absolute", get_path_gitdir_absolute },
 	{ "path.gitdir.relative", get_path_gitdir_relative },
 	{ "path.grafts.absolute", get_path_grafts_absolute },
diff --git a/t/t1900-repo-info.sh b/t/t1900-repo-info.sh
index 6c47989df7..3e5e42f6d3 100755
--- a/t/t1900-repo-info.sh
+++ b/t/t1900-repo-info.sh
@@ -207,6 +207,25 @@ test_repo_info_path 'commondir with only GIT_DIR' 'commondir' \
 	'.git' \
 	'GIT_DIR="../.git" && export GIT_DIR'
 
+test_expect_success 'path.git-prefix at root and in a subdirectory' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+
+		echo "path.git-prefix=" >expect.root &&
+		git repo info path.git-prefix >actual.root &&
+		test_cmp expect.root actual.root &&
+
+		mkdir -p sub/dir &&
+		cd sub/dir &&
+
+		echo "path.git-prefix=sub/dir/" >expect.sub &&
+		git repo info path.git-prefix >actual.sub &&
+		test_cmp expect.sub actual.sub
+	)
+'
+
 test_repo_info_path 'gitdir standard' 'gitdir' '.git'
 
 test_repo_info_path 'gitdir with explicit GIT_DIR' 'gitdir' \
-- 
2.55.GIT

