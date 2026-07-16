Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B925420010A
	for <git@vger.kernel.org>; Thu, 16 Jul 2026 01:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784165127; cv=none; b=Q+t7ICI66kxDBf7vgfnlR9C0YoQGPubcbZxWIAp+xD+gdAwkHxFntceArvbHVA/c5onE2RjGIYK38TPmTI1lQAwTYTJf1fS74gl5UvVn4GAEdWe8umavxrHbUOpKX9KdOVrcN9NSXsxoYgVicq4AKUht5xLLJvJ3iN9i7R7A4R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784165127; c=relaxed/simple;
	bh=0b4sSj+RDbfO1TopRBhwn/HyArUdULKj3ZAxRaQQF+k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hOvaRLXLjpPq/ApXKH4r8ER6sG3Lz+qw4GQVmbbONPx7pFcj292g7ws4rbuE1vjjhQqG4a4BswSvuznc7EhdiZalCFTcFBSOQrhhqIyPbILNY/1PI5p12aZ/CxGsyilHFxAnzPwileMAX6FIr7Cpf0VJ4Lemr2pbtVkiGnOQDX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ILMhF4QC; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ILMhF4QC"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-38e1a9d9105so2182334a91.1
        for <git@vger.kernel.org>; Wed, 15 Jul 2026 18:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784165124; x=1784769924; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xJEjYbMXDUzqcxkFh7+937BPx8Ylo5WVf/EqF/1OXCw=;
        b=ILMhF4QC6cox0RdS0mTuB4HlzqoZXUdYdDKLdSr5uRyf1Ai2Zv//eqdNMHDgA3i9xS
         qznaDX/aF7lQLBeXBiDl5HI3ZdJ8bujnUdj2aBZzWiHaFVRLJoQwAlM4tq1fsISow/2C
         fVpjJ0NO7BzkKDZpstkYJnrW2VUBPIrtqe8E1I96LsgMs1+ih2GHVk7Aitlkbq5Imw4R
         brECMeeA8XNHVXUUjfbAL+JyDb6uB76LWYJx1joVF8SJq3l4higYGe3CJ00FhXEnOTlW
         1eKcw4+joFm1BeChbwgd94hIxoZPL9zfdbdvFtWr9A+3uMltIVCvYKQ8FOyvpCf59PZB
         alyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784165124; x=1784769924;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xJEjYbMXDUzqcxkFh7+937BPx8Ylo5WVf/EqF/1OXCw=;
        b=hg7ko6wx9YtLUBovZgR3vxJVytScvsVOZJZv3ouxZkn7z7CioEV+9tShiR5Nv0jkKD
         kQolvUDeSpL6enIW0UqSAvBp7LAYN3tudVCZYbUKwl8DSIL1y47bJckdvJdcwOCq65Y7
         ed0ZP3MPFJZ9ExN7kF7ClyVOKaBpsIch6R/kJnxRNTkx5olUbEAU0HEhVL4RtkUyF02t
         huvBwPoZ74n8HlG6TrP5HG3pYIf8F5upODQ9S4Zk47fxVWBurtFemzyie2oTPnudLy5T
         AeiNZ9yJesV4c+hCJ41hmt9sKrARWp6ZKnKevBDpEiZQir2XjyGhKd8WX1qCSyQsDAPG
         XU/g==
X-Gm-Message-State: AOJu0Yxp5a6ja6VskHd3BAt7shYhQc8xe4zyOqabOtpM5tGCFU0nGjyo
	gal6ts8UajaiSIbnEPF/rSY2DKgVBnNX/YQrotApI4gG9SaQieQOk+c1N2tubA==
X-Gm-Gg: AfdE7cl3U+WHNkrEWTNbs1q9rI0z+yzsStFF0ECPbR9RtV5UYHomsIKJKY2l6M8Cvti
	JBWlll7PI2PdTJPyEtVUfAzJR4Jqd2jtSVz2kgWoUbeYhWcoPV1000yyKRkCvuTQ7o0xVHfP/6J
	uIJrFYfeOUj9cOq9nvtoKrNdstHWfXMFS+IdFsmRlwcQvh2T/tKTD4vNQ9gPhme1h9rSvgmLOpY
	JZjJ27ceJfr5MkZqmMoZgw37evIVDXMcmx0CZL1fvsAeihWjUllR44P7u7Fs9j/xjkAVsYeFQV2
	/gOT0oHIWj2UdjB0svuB3ARj/cNwmRgxEgz2XQbv1bdmcoOCnhtU75g+UbubAVuiyhN4xVOsg7K
	+9vE02V4/0kZvXHHQIFGL/kREDqBIkTHD46vSA7+qbCZt0fyTfRvnvFQ8gYJF/qxrlG+nziX/dJ
	Hn47IU8rngvkLKH7ImAMDKpobZLUt071jDie6DClvDOvPpBf6Yem7LUu+ajajlX+C9AoVB9TbhN
	MAW0Pyrdugt
X-Received: by 2002:a17:90b:1807:b0:372:b4a1:21d8 with SMTP id 98e67ed59e1d1-38e2a0174famr3579027a91.13.1784165124591;
        Wed, 15 Jul 2026 18:25:24 -0700 (PDT)
Received: from jayatheerth ([2405:201:c005:b959:7d42:d207:de10:1218])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3140e6e9edfsm5377490eec.28.2026.07.15.18.25.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 18:25:23 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: git@vger.kernel.org
Cc: jltobler@gmail.com,
	lucasseikioshiro@gmail.com,
	K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Subject: [GSoC Patch 5/7] repo: add path.index with absolute and relative suffix formatting
Date: Thu, 16 Jul 2026 06:51:36 +0530
Message-ID: <20260716012138.6714-6-jayatheerthkulkarni2005@gmail.com>
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
 Documentation/git-repo.adoc |  8 ++++++++
 builtin/repo.c              | 24 ++++++++++++++++++++++++
 t/t1900-repo-info.sh        |  6 ++++++
 3 files changed, 38 insertions(+)

diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
index 7bc1c51310..3a837c573e 100644
--- a/Documentation/git-repo.adoc
+++ b/Documentation/git-repo.adoc
@@ -127,6 +127,14 @@ values that they return:
 	The path to the repository's hooks directory relative to the current
 	working directory. Respects `core.hooksPath` configuration adjustments.
 
+`path.index.absolute`::
+	The canonical absolute path to the repository's current index file.
+	Respects the `GIT_INDEX_FILE` environment override.
+
+`path.index.relative`::
+	The path to the repository's current index file relative to the current
+	working directory. Respects the `GIT_INDEX_FILE` environment override.
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
index cd3f856d04..04e6b8553c 100755
--- a/t/t1900-repo-info.sh
+++ b/t/t1900-repo-info.sh
@@ -219,6 +219,12 @@ test_repo_info_path 'hooks with core.hooksPath override' 'hooks' \
 	'custom-hooks' \
 	'git config core.hooksPath "$ROOT/custom-hooks" && mkdir -p "$ROOT/custom-hooks"'
 
+test_repo_info_path 'index standard' 'index' '.git/index'
+
+test_repo_info_path 'index with GIT_INDEX_FILE override' 'index' \
+	'custom-index-file' \
+	'GIT_INDEX_FILE="$ROOT/custom-index-file" && export GIT_INDEX_FILE'
+
 test_repo_info_path 'objects standard' 'objects' '.git/objects'
 
 test_repo_info_path 'objects with GIT_OBJECT_DIRECTORY override' 'objects' \
-- 
2.55.GIT

