Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D10F18C2C
	for <git@vger.kernel.org>; Sun, 26 Jul 2026 10:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785062891; cv=none; b=cSgqPn82SyoqvQ9BRg22jogWdBH27fnPRbWkHxqXesWqvlMKi8KbBsSUcL6Kles2rQxE7yOnG1IhrBj0cVUAUFQKeDP1fr2y+WTJ+d0P47ZgC1h1XroPq0SGzjKKkHRW9DP8Oh+Si13KzSwjwX1IRcEs4WfHDPRAGbp78zsls3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785062891; c=relaxed/simple;
	bh=gCnMBNGsW+w2gn3uGkEXNi8cot+bVncU6OvXFLeVjy4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dliTYiNE78NzrFUmuwpl9vGk7eZTgaw50uIMqKBXhrwLCJOdW0kvighmeRg1HuOByaTd/rdv7/k0tL3mKnQAtbFgyRvIrLUTOmDnfga5c80DyUR8L5FM/j5z3EKZl8R1b73t5ggk+z1JWe5GIBGjFU8WANvduk2nNk6QLQSrtcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aSKZlI+X; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aSKZlI+X"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2cedda2ce6fso15447765ad.1
        for <git@vger.kernel.org>; Sun, 26 Jul 2026 03:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785062889; x=1785667689; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EHecgHbkzydwSNIuuGbpx63aZTRXqMEF3WstdkdC++s=;
        b=aSKZlI+X9TlNBkekpQGIZWqaavqy/NTlwatmfuJqOayeXsczU4miQTPsDjXtKz8sYS
         X44Y2W2k0ibsmz9EsuzbHwxoSfD70ZtTXxpv24VfnjrNtdlC6UgQ1nCiuHJOJJaGuX/B
         d6f0W1gf8EUeqEKVJmh5ngl1QyPVdL83JVJurUS2nOPxGag8TEND5OyUPKtGAoGxj6Cw
         AMsHhI/wsEXUH5Az41U8kPHdUuTrenmuHdCNIutmpAbv17bG7qZP0vZdg8nmsdjdD39V
         MBGmRJgNy/ANFDb+CN6li/T567iPE+QSIfvLZevlhWiBHKQnM0nDjXUEwaY4LYlVYJiG
         n9ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785062889; x=1785667689;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EHecgHbkzydwSNIuuGbpx63aZTRXqMEF3WstdkdC++s=;
        b=XN4MW5qx3hr06LAdJp/jO6DjEEWqqgaIfpFxHxra/dLK7l5p48mLUHPCRnYiu6+2qY
         3AmmJujIXpXUCscBgxwIqk5gBXq7ZEl2IeU31Avhgzq7c/KHS/yhlwgDO8hHL3kfhdVF
         fgojoL430x6B4Xw2SFPGSLcKS5MJrW7+l4oMKWqwdy+jaK6e9nBJHl1yqpSE3SjJsLZL
         l+N5lHTTvVwfPMCQWnQMLB4j3vq7mpNdB0RwNQc22tqF1Jrs3T52zIqLqqCfEqSYuTRg
         ES8vKv9IRbxYxGTNDHPBSKB0h9L/YUn+xOteIsFdk8cZk0+nGxpBNwEskwHca6M4h1Wl
         a7GQ==
X-Gm-Message-State: AOJu0YwNIZcsWrQUD4TLBWuf9GQh3TmPRF0itjbMDpDgkt4Jp68sNULr
	u7+Y85uCEL0nlpql+HLcitP5zGe6nl30wmt3mqCou/HTt58JSs7REluH
X-Gm-Gg: AR+sD11E/nEOib/4+VrOWQbZmyZnReqR02QK5fSuK+S7ubVN2fYJyS22E9wn2tsuyv2
	drWqic0zPi8QbTSiilrB32jdIq+kYIXbLA5eLfzZxqBfjAl+RaVwVeonj5WRB+h+4Ezb5CwyzEa
	w2ktee4GYy7V9RHJkacKkNRTow6/xRGTVk/5ZPc3n384QxU2d1NbPY1sIYqHMeuulzZKMQcppdE
	MLZpLagNHTmMBYbM0IFW9L57VBMB7oODtddJlOLZp6L9a8zCz/Rp8SEe2XYlsWdXMHIZ0Q+jY/v
	8pE7mwQ8AdY3axHBi93ygSHLuIxGYLNFIliouA96xmqayeCEzwmydYIawagNcWy6H5t9Xo8O0na
	VjrwMqxd1MaX0vbx8ucHDHxImkU7c/TqPEgqDlOxVD44wOx087okSeAGt/0dIhfozMlHkP4jaew
	11CaLJA7Z3iFbyz8/uCt0CHekce2UFDUgUnTp6DB2b1UkRHrlXHSJl69Ol8x9kAqWDSZnvV6gEy
	J3mdVWqz10hCjiLYPedjY0=
X-Received: by 2002:a17:90b:3d4d:b0:387:e0bb:57f8 with SMTP id 98e67ed59e1d1-38f298a4cf1mr4882995a91.41.1785062889386;
        Sun, 26 Jul 2026 03:48:09 -0700 (PDT)
Received: from jayatheerth ([2405:201:c005:b959:7d42:d207:de10:1218])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc3e1255sm30371438eec.4.2026.07.26.03.48.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 03:48:08 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: jayatheerthkulkarni2005@gmail.com
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	jltobler@gmail.com,
	lucasseikioshiro@gmail.com
Subject: [PATCH v3 5/7] repo: add path.index with absolute and relative suffix formatting
Date: Sun, 26 Jul 2026 16:13:41 +0530
Message-ID: <20260726104343.16933-6-jayatheerthkulkarni2005@gmail.com>
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

External script workflows and formatting layers require straightforward
access to the location of the index staging file. Currently, tracking
this necessitates a legacy call to `git rev-parse --git-path index` or
`--show-toplevel` logic abstractions.

Introduce `path.index.absolute` and `path.index.relative` keys to
`git repo info`. This allows tooling utilities to discover the active
index context cleanly while scaling transparently with localized
`GIT_INDEX_FILE` environment overrides.

Mentored-by: Justin Tobler <jltobler@gmail.com>
Mentored-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
---
 Documentation/git-repo.adoc | 12 ++++++++++++
 builtin/repo.c              | 24 ++++++++++++++++++++++++
 t/t1900-repo-info.sh        | 23 +++++++++++++++++++++++
 3 files changed, 59 insertions(+)

diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
index 7bc1c51310..34c4f7d61c 100644
--- a/Documentation/git-repo.adoc
+++ b/Documentation/git-repo.adoc
@@ -127,6 +127,18 @@ values that they return:
 	The path to the repository's hooks directory relative to the current
 	working directory. Respects `core.hooksPath` configuration adjustments.
 
+`path.index.absolute`::
+	The canonical absolute path to the repository's current index file.
+	Respects the `GIT_INDEX_FILE` environment override. The returned path
+	reflects the configured/default index location regardless of whether the
+	repository is bare or whether the file currently exists.
+
+`path.index.relative`::
+	The path to the repository's current index file relative to the current
+	working directory. Respects the `GIT_INDEX_FILE` environment override.
+	The returned path reflects the configured/default index location regardless
+	of whether the repository is bare or whether the file currently exists.
+
 `path.objects.absolute`::
 	The canonical absolute path to the repository's object database directory.
 	Respects the `GIT_OBJECT_DIRECTORY` environment override.
diff --git a/builtin/repo.c b/builtin/repo.c
index c921de222d..66bf4c67cc 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -142,6 +142,28 @@ static int get_path_hooks_relative(struct repository *repo, struct strbuf *buf)
 	return 0;
 }
 
+static int get_path_index_absolute(struct repository *repo, struct strbuf *buf)
+{
+	const char *index_file = repo_get_index_file(repo);
+
+	if (!index_file)
+		return error(_("unable to get index file"));
+
+	format_path(buf, index_file, startup_info->prefix, PATH_FORMAT_CANONICAL);
+	return 0;
+}
+
+static int get_path_index_relative(struct repository *repo, struct strbuf *buf)
+{
+	const char *index_file = repo_get_index_file(repo);
+
+	if (!index_file)
+		return error(_("unable to get index file"));
+
+	format_path(buf, index_file, startup_info->prefix, PATH_FORMAT_RELATIVE);
+	return 0;
+}
+
 static int get_path_objects_absolute(struct repository *repo, struct strbuf *buf)
 {
 	const char *obj_dir = repo_get_object_directory(repo);
@@ -238,6 +260,8 @@ static const struct repo_info_field repo_info_field[] = {
 	{ "path.gitdir.relative", get_path_gitdir_relative },
 	{ "path.hooks.absolute", get_path_hooks_absolute },
 	{ "path.hooks.relative", get_path_hooks_relative },
+	{ "path.index.absolute", get_path_index_absolute },
+	{ "path.index.relative", get_path_index_relative },
 	{ "path.objects.absolute", get_path_objects_absolute },
 	{ "path.objects.relative", get_path_objects_relative },
 	{ "path.superproject-working-tree.absolute", get_path_superproject_absolute },
diff --git a/t/t1900-repo-info.sh b/t/t1900-repo-info.sh
index cd3f856d04..dee1db2a49 100755
--- a/t/t1900-repo-info.sh
+++ b/t/t1900-repo-info.sh
@@ -219,6 +219,29 @@ test_repo_info_path 'hooks with core.hooksPath override' 'hooks' \
 	'custom-hooks' \
 	'git config core.hooksPath "$ROOT/custom-hooks" && mkdir -p "$ROOT/custom-hooks"'
 
+test_repo_info_path 'index standard' 'index' '.git/index'
+
+test_repo_info_path 'index with GIT_INDEX_FILE override' 'index' \
+	'custom-index-file' \
+	'GIT_INDEX_FILE="$ROOT/custom-index-file" && export GIT_INDEX_FILE'
+
+test_expect_success 'path.index in a bare repository returns default index location' '
+	test_when_finished "rm -rf bare.git" &&
+	git init --bare bare.git &&
+	(
+		cd bare.git &&
+		ROOT="$(test-tool path-utils real_path .)" &&
+
+		echo "path.index.absolute=$ROOT/index" >expect.abs &&
+		git repo info path.index.absolute >actual.abs &&
+		test_cmp expect.abs actual.abs &&
+
+		echo "path.index.relative=index" >expect.rel &&
+		git repo info path.index.relative >actual.rel &&
+		test_cmp expect.rel actual.rel
+	)
+'
+
 test_repo_info_path 'objects standard' 'objects' '.git/objects'
 
 test_repo_info_path 'objects with GIT_OBJECT_DIRECTORY override' 'objects' \
-- 
2.55.GIT

