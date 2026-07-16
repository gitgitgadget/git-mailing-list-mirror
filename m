Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B7E317715
	for <git@vger.kernel.org>; Thu, 16 Jul 2026 01:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784164995; cv=none; b=FGDFF1/gQbae+AXlGwIjsW2XXFl7N5ej/fOCOsJLzV573SVjjsbvAjBr1I0IElKyBVV5e+GQ01Sl0v4eHf6iAN4LLIG0mrFh888zB5JAIuRpD/KqDj6v3i2FZaiV0jm1trzaHQaJfOgLqPz9z/o5AIa7xLqpO8aBcrYfo+OQm24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784164995; c=relaxed/simple;
	bh=HW7s/iKJcFiYpIJ/oBWNUp5EVNoxeA8WOGBGzw+yC1E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pw4Ea9GUasMBu4qj6gxVaUWwGF/9nDcXujbgbx313cS7zw9qDrUjebWqIayNdn23E1hHA13lKs761Hp53N1tTCl9jfrvBFMsP6KomYgz+76Y+flL8gy8YneG74L3TJPKyMihoE4AMBSasfKbgw9ZECN/Caq6QSNJ/y2v8FwuIJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bnE/vo8L; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bnE/vo8L"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-38dc4553f62so4703057a91.0
        for <git@vger.kernel.org>; Wed, 15 Jul 2026 18:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784164987; x=1784769787; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SqLtY1pIMDFxHEBpyrjnsIsRQiasQFf0PmrhcaXPWv8=;
        b=bnE/vo8LTGMcfBBC1Z3wgo3PzOxDlk9ZdrZ1IkvFNgoXBLcq+/qeI5DULSgbp6AR4q
         WWmNuSXeqfI6LWFV2Fne3tiC+Yx2vB3yCIGtmNsXfqT07kWnLvwuqYgkxJ+Qe/+E1VLk
         jVzl89UFUYETgL3lMMhsURECBZFThm0c63mZGvNPFmWYCmxNa6HgTCu4WFyfuuzUj5OP
         YC3P6z+Ebz9VHPBJs4aNUQMqvoAFbSBORmVEPBOUlzV6CXSpUe/G37wN5OpYMk0hKFaY
         L9BNjc9opHrrkAtCjWnYaD2LJrvpSo37psxDNOGK6+798/vI/HoOIpLx/NWqtsweiKL2
         tvMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784164987; x=1784769787;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SqLtY1pIMDFxHEBpyrjnsIsRQiasQFf0PmrhcaXPWv8=;
        b=pL9NE86sKyum57SSVsGSnGoIaeZUj2DiC0IsR0xqI0biNVDIVN+6/CfTj52qI0Celx
         vT5jO1I6ukNb/CRePV/4T604DZoafHmM3o6EPSHLhPZOjxQHcoZHnDCZOJDztkQicdrj
         v1rD/Wpwm8FnG1lsXPW/5CUw+dzM4ZsUeCP7O7wP63vj9wI4fGyoqt629ZGLhkBpeEhJ
         LKY3gksk8i4/6Ef3quDXaZWu2Kh2jN/CklV48prGglQJcNNfE5fyUW5a+/n9L2O7/o9s
         At2iYWBDAamuV++pLKmadKlmwjwUlqU2EPAqWqXPIPYPYSBPIKTXRF0HKKxPafvtq/mZ
         /KxA==
X-Gm-Message-State: AOJu0YxQtEwaAHgMzQonC6F/l8DquOTC2KHLqKizv3q20a35apDyJfW+
	l2GaFSg4RWx+vg7ShiASqq+FN0xHzXF4aeYrVt1ZI6zYPRoYlnY5YAW/iNOyWw==
X-Gm-Gg: AfdE7cmE0YQASVaDVTFj4Chvs0eLZ7MLNV4IIZXNljVj4zirQwbKDVmwJFm7WMRcQ12
	whJhmn3PIbqvhZDUzKyWYHHegRsz5U0pcpeO1+ddttht3HtF8+SqsRlT3hdCMal/iTX3aXoUrqe
	TXTVH7U8/0v5oPkxuHf1fLiHFZvXcmXa7cH+tOMPOuqrEiMrN8ADvkp6jTAN4A/1fVb9Cba+iLR
	72mSHI1+uf9vwBi/os59cT21hO8xwPMZG2c1vJlpaBQE4N8eIT6PcY1TFCzFXE7VXCgyeLr6gvs
	9gTAN65q1WGKsyEo2xOGtp5iJScib6MygiYiVhlWZN+WBY7kb6+j1IRPZS4YC+kjsNAYzYtqpa1
	BezMIc4xSza2sTD5a6bbJ4TjfJpjbjV48WjsbkgBIRb4vwzWt9qO+sZuun8RHPoXyRCY6M7xzd9
	aRqURXMEzZpBGQyXbSz/UuR9SiTMQ8L6y6sOJjWhovughBRgJvb/L3kHYstnlbOHsDLd8AVCjvU
	q4fSWlTnWHL8SheH7tftOY=
X-Received: by 2002:a17:90b:4f84:b0:38d:eaec:4383 with SMTP id 98e67ed59e1d1-38e1afbf3d3mr8162068a91.22.1784164987301;
        Wed, 15 Jul 2026 18:23:07 -0700 (PDT)
Received: from jayatheerth ([2405:201:c005:b959:7d42:d207:de10:1218])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3140e6e9edfsm5377490eec.28.2026.07.15.18.23.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 18:23:06 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: git@vger.kernel.org
Cc: jltobler@gmail.com,
	lucasseikioshiro@gmail.com,
	K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Subject: [GSoC Patch 1/7] repo: add path.toplevel with absolute and relative suffix formatting
Date: Thu, 16 Jul 2026 06:51:32 +0530
Message-ID: <20260716012138.6714-2-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.55.GIT
In-Reply-To: <20260716012138.6714-1-jayatheerthkulkarni2005@gmail.com>
References: <20260716012138.6714-1-jayatheerthkulkarni2005@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Scripts frequently need to find the root directory of a repository's
working tree. Currently, this requires using `git rev-parse --show-toplevel`
or inferring it from other path components.

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
 builtin/repo.c              | 28 ++++++++++++++++++++++++++++
 t/t1900-repo-info.sh        | 30 ++++++++++++++++++++++++++++++
 3 files changed, 68 insertions(+)

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
index 042d6de558..194757eb18 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -121,6 +121,32 @@ static int get_path_gitdir_relative(struct repository *repo, struct strbuf *buf)
 	return 0;
 }
 
+static int get_path_toplevel_absolute(struct repository *repo, struct strbuf *buf)
+{
+	const char *work_tree = repo_get_work_tree(repo);
+
+	if (!work_tree) {
+		strbuf_addstr(buf, "");
+		return 0;
+	}
+
+	format_path(buf, work_tree, startup_info->prefix, PATH_FORMAT_CANONICAL);
+	return 0;
+}
+
+static int get_path_toplevel_relative(struct repository *repo, struct strbuf *buf)
+{
+	const char *work_tree = repo_get_work_tree(repo);
+
+	if (!work_tree) {
+		strbuf_addstr(buf, "");
+		return 0;
+	}
+
+	format_path(buf, work_tree, startup_info->prefix, PATH_FORMAT_RELATIVE);
+	return 0;
+}
+
 static int get_references_format(struct repository *repo, struct strbuf *buf)
 {
 	strbuf_addstr(buf,
@@ -137,6 +163,8 @@ static const struct repo_info_field repo_info_field[] = {
 	{ "path.commondir.relative", get_path_commondir_relative },
 	{ "path.gitdir.absolute", get_path_gitdir_absolute },
 	{ "path.gitdir.relative", get_path_gitdir_relative },
+	{ "path.toplevel.absolute", get_path_toplevel_absolute },
+	{ "path.toplevel.relative", get_path_toplevel_relative },
 	{ "references.format", get_references_format },
 };
 
diff --git a/t/t1900-repo-info.sh b/t/t1900-repo-info.sh
index ae8c22c817..fbb9063ee5 100755
--- a/t/t1900-repo-info.sh
+++ b/t/t1900-repo-info.sh
@@ -213,4 +213,34 @@ test_repo_info_path 'gitdir with explicit GIT_DIR' 'gitdir' \
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
+test_expect_success 'path.toplevel returns empty in a bare repository' '
+	test_when_finished "rm -rf bare.git" &&
+	git init --bare bare.git &&
+	(
+		cd bare.git &&
+		echo "path.toplevel.absolute=" >expect &&
+		git repo info path.toplevel.absolute >actual &&
+		test_cmp expect actual
+	)
+'
+
 test_done
-- 
2.55.GIT

