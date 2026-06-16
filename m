Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84C53CE088
	for <git@vger.kernel.org>; Tue, 16 Jun 2026 04:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781585567; cv=none; b=l9ULno5wyODwlJ6qWHxGmxZ7+QjyQ08Xze6oY5HudGPGJLqUNIt/JzZtw0PmsxrcUWlAyRfjAac4xAv5MsqtRlEX/6q06tB1NbNAU7s76EcemD55FtLBtylQ0eI4ocqiT9MuTmTQgMWUiAxgO0/VB06rdcWL8x/ZlEb4uVcZxO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781585567; c=relaxed/simple;
	bh=DU9Cprwmd2+xSbtmXpWEYm53nUuTm9NjCfbmh8HLy40=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BIUSOnLbx7THSqVsy2b4EaLi5+TqnI8+sSerA48S/V+6x1yoklu0xt7I8bi1kStviwfzbPjC6OOc6r7aISM944OvvmiJZj2gRbYU7p2arZ2qIG+N9zrdQpQsB9FIXyucVqv2IUJTkHtSHYCxK3wxPImVDQdC1fG+SKJiOC+nKhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UDQgDBvz; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UDQgDBvz"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c8584bbbf2cso2408020a12.3
        for <git@vger.kernel.org>; Mon, 15 Jun 2026 21:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781585565; x=1782190365; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SobQWarWo/c7K+PsEC486yIhVGr3/v/fBon73Us0Hy0=;
        b=UDQgDBvzcNCeobPaNNV4DEBMXa0qvjxndrB7wnf1LXVKJprIvcrm2Kh2yiH3W4xOq/
         XVhqKzl03quxWaIJtd2DC18uokTlP4U2zJVbSxxhNIfs6/ni3zKlzxaCf0XVSr0LGv5k
         DYL2PNJ5eD+qeF34d4059HtwX272jf5LfOLifgg/yHZ3VlA/OLcARm1BNQmk8UhyvC5R
         tweM95BcviovMNuNxKgiiuPnzOoJ1mSwflNhtLu+IECX58TDYUM9cx8Cu2DF6fqWhS79
         NGTwv61XysEtCS5G4z+TWR1wEbBd0wyHGt77kNjSwy4dBlqUM8qSE49uVchbRDbgfn8A
         e/Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781585565; x=1782190365;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SobQWarWo/c7K+PsEC486yIhVGr3/v/fBon73Us0Hy0=;
        b=lboovE+n4fIWKD+On+RgXz7EK0T16Sp8OpwwDGXwOqYg/SalUgXDRUDpuL+YrCxYxt
         keecVw1KONCPWDA0PWghaKTzbwAHhY3UalhHKlfaXXouFBmzJ8Y/12H7Rnz0M9ZyU0sZ
         KXt9XTac49oPRH6VHtVesJobtPE5lDgyuS72osrA4nSmSGgKitt6Dln7HQsQVl0+nAFU
         CDRsp9PrYOM1yole5+KXZqDWjxYIbc8mBcJWbNbbrAQFHNOsQcdqkaspV39pyPkGBGnk
         HxqHZ0LM/OtxpjGH7aLxQNS1zCDz7gV7i37fl8YPQ5cMp0dXNNHADz5y1C37dPfmIieq
         X+qg==
X-Gm-Message-State: AOJu0YzemzL2SeAbo8To3rUQCoWfdEAWiHvkHxRUWY+i1YuW8yrzMFzv
	iHvPsPpGI3oKde4XZBIwvn0pKwN1yhYPvTovSt4SEs6BQ0H80QH6BEu0xkOY+A==
X-Gm-Gg: Acq92OGn+IDXaDL+x20cLvECHXvMMCUjkeM2/lnrolcfv4EbWcL4mF4Fb5uIgUfvpVK
	5TeDcJmlRsy1gogjc9d5j+L+HWPJkww9lbZG0UBxe+/41vImIEjybp3N/aXXq0lLweEGdz9dsVf
	6YjQQHbtjDaLSX1q0D0f8sTiO/Kch18DEv7AIpRqXmtc/5Kj+0MrRudMACF2cZ7eShHagQiL3q8
	9vasV36hW/EkLcFxsoZSJTFVvpTgamQK1PpTOEihMn1JILB+oqpmZpf6FV3iafqjTU9NyFG/3hH
	UDNuGxu81wwYRkUqO7Zg2iTXldoCUY8pA/KOZ9X16DxfGSvvvCCaVhgzwrXmWTYkt8n5gq4vJ4K
	+W9NonDnsv1BWA3BxIx+ZyfJQWX4iAm+M/bJo4f+JC9MpYXlnmzmvPWLdQjLLNJ7o+srMOC+kgy
	QTNpy/GxnXzKvGjT9pQgbR/2yFGizbgppadpBqPO60P+p6J74piPrTIa5WduZbfZflY6L6+ftMF
	knGrK3FjrkvTsVtJjgjQXAEHr718r6maQ==
X-Received: by 2002:a05:6a00:4207:b0:842:5d9b:d590 with SMTP id d2e1a72fcca58-844e1a5ef8cmr14536658b3a.30.1781585565071;
        Mon, 15 Jun 2026 21:52:45 -0700 (PDT)
Received: from jayatheerth ([2405:201:c005:b959:7d42:d207:de10:1218])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434b040718sm12122614b3a.51.2026.06.15.21.52.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 21:52:44 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: git@vger.kernel.org
Cc: jltobler@gmail.com,
	lucasseikioshiro@gmail.com,
	gitster@pobox.com,
	phillip.wood@dunelm.org.uk,
	sandals@crustytoothpaste.net,
	kumarayushjha123@gmail.com,
	a3205153416@gmail.com,
	K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Subject: [GSoC Patch v5 4/4] repo: add path.gitdir with absolute and relative suffix formatting
Date: Tue, 16 Jun 2026 10:19:53 +0530
Message-ID: <20260616044953.184806-5-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616044953.184806-1-jayatheerthkulkarni2005@gmail.com>
References: <20260601151950.30686-1-jayatheerthkulkarni2005@gmail.com>
 <20260616044953.184806-1-jayatheerthkulkarni2005@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Scripts need a stable way to locate the git directory without
parsing rev-parse output or relying on its flag-driven path format
selection. There is no way to retrieve this path from git repo info
today.

Introduce path.gitdir.absolute and path.gitdir.relative keys,
consistent with the path.commondir keys added in the previous patch.
Reuse the test_repo_info_path helper introduced there to validate
both variants.

Mentored-by: Justin Tobler <jltobler@gmail.com>
Mentored-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
---
 Documentation/git-repo.adoc |  6 ++++++
 builtin/repo.c              | 24 ++++++++++++++++++++++++
 t/t1900-repo-info.sh        |  6 ++++++
 3 files changed, 36 insertions(+)

diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
index 890c34051d..ed7d80c690 100644
--- a/Documentation/git-repo.adoc
+++ b/Documentation/git-repo.adoc
@@ -113,6 +113,12 @@ values that they return:
 	The path to the Git repository's common directory relative to
 	the current working directory.
 
+`path.gitdir.absolute`::
+	The canonical absolute path to the Git repository directory (the `.git` directory).
+
+`path.gitdir.relative`::
+	The path to the Git repository directory relative to the current working directory.
+
 `references.format`::
 	The reference storage format. The valid values are:
 +
diff --git a/builtin/repo.c b/builtin/repo.c
index c4cc3bf3fc..9a312d127a 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -99,6 +99,28 @@ static int get_path_commondir_relative(struct repository *repo, struct strbuf *b
 	return 0;
 }
 
+static int get_path_gitdir_absolute(struct repository *repo, struct strbuf *buf)
+{
+	const char *git_dir = repo_get_git_dir(repo);
+
+	if (!git_dir)
+		return error(_("unable to get git directory"));
+
+	append_formatted_path(buf, git_dir, startup_info->prefix, PATH_FORMAT_CANONICAL);
+	return 0;
+}
+
+static int get_path_gitdir_relative(struct repository *repo, struct strbuf *buf)
+{
+	const char *git_dir = repo_get_git_dir(repo);
+
+	if (!git_dir)
+		return error(_("unable to get git directory"));
+
+	append_formatted_path(buf, git_dir, startup_info->prefix, PATH_FORMAT_RELATIVE);
+	return 0;
+}
+
 static int get_references_format(struct repository *repo, struct strbuf *buf)
 {
 	strbuf_addstr(buf,
@@ -113,6 +135,8 @@ static const struct repo_info_field repo_info_field[] = {
 	{ "object.format", get_object_format },
 	{ "path.commondir.absolute", get_path_commondir_absolute },
 	{ "path.commondir.relative", get_path_commondir_relative },
+	{ "path.gitdir.absolute", get_path_gitdir_absolute },
+	{ "path.gitdir.relative", get_path_gitdir_relative },
 	{ "references.format", get_references_format },
 };
 
diff --git a/t/t1900-repo-info.sh b/t/t1900-repo-info.sh
index 09158d29f9..ae8c22c817 100755
--- a/t/t1900-repo-info.sh
+++ b/t/t1900-repo-info.sh
@@ -207,4 +207,10 @@ test_repo_info_path 'commondir with only GIT_DIR' 'commondir' \
 	'.git' \
 	'GIT_DIR="../.git" && export GIT_DIR'
 
+test_repo_info_path 'gitdir standard' 'gitdir' '.git'
+
+test_repo_info_path 'gitdir with explicit GIT_DIR' 'gitdir' \
+	'.git' \
+	'GIT_DIR="../.git" && export GIT_DIR'
+
 test_done
-- 
2.54.0

