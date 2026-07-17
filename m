Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC0C23ABA7
	for <git@vger.kernel.org>; Fri, 17 Jul 2026 13:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784295305; cv=none; b=TOe1KM8JZ1E5KgnRo7pMzWBKZCFGXcWA2C2mpnGdWFkMQMbLd/+XWTzkomdT/FW0ZE2bTo9sF2vctZbtKkPXIUQvzqANFL4Sf9bmZrKwFpDhldWxtlahcFCiqbAQUTWvWdFQSwfkxVz9kYb3LHGfuUgej8ztDAO5Zyz0v4I0yjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784295305; c=relaxed/simple;
	bh=0b4sSj+RDbfO1TopRBhwn/HyArUdULKj3ZAxRaQQF+k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h/p7ZaXs9mK76DrGXylpUPcAw+DVl5lHBdBLmJMZtq4QMBmAyELc3GKW0cJaua3OLjT13mi5CxagfatZke+cMQEnj4T7hldTk9fjtpsrgAqJma6yIq1BDoPlwR/dSYamCYJBtalVbWcI/C36/sxVlEjeBs8Hc8lAJfsQ6HkA/+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pr812ONs; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pr812ONs"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c998fd549a8so5252580a12.2
        for <git@vger.kernel.org>; Fri, 17 Jul 2026 06:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784295303; x=1784900103; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xJEjYbMXDUzqcxkFh7+937BPx8Ylo5WVf/EqF/1OXCw=;
        b=pr812ONsJgg9LtOxYHLhHvGbQu8OG+bfyeTa2XE6udtIEHn3cVgyycr2iYfA+h49Ap
         UqjrYMT92Jg/J/ltrA8bxYOT6ClSzGwghtKlF0uTESBvYKlgCSrvWnw/v73xD5VtRkiU
         9xAntmeJg7uD4DSBH/dCThQBTlFTYmUgzlmYFXrxgK3D5X4YocQWqBfluzK61QJYS6uU
         OBGfk4Pboh14Bh3sSjUXijMRWyiy5cVddMhVKViY33mu1F4RoSQj6+ikVqfo+rS/+2ZN
         YMJVoWR7RVAEHkSs7IDQ6zmhCTHmVeNAw5toBv3RVdCIfVFj8BeDqkUoCwzGXibiOTHs
         HhGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784295303; x=1784900103;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xJEjYbMXDUzqcxkFh7+937BPx8Ylo5WVf/EqF/1OXCw=;
        b=gQAAi5664WuBV8Q7VZF1cvRHYb7dZ8b6dWgIzk6bd8DBKO5VjozblmCv0Z/YSH7naS
         zX89QpGrVFe/IWnBXApCb8xczFb3TMhABFBdyrPuxrpPv8kQfu78DG+RLbRGiWkzrhZ+
         OYnV919LCOFTVLLGjFEPDcvrXVkcKmr84IZ1rwpvMVPp6rdydnvRcHLRMD5FWdEJ2uxa
         Tx3YJj7rNysFwkMMkM9gz8Dyfi9osbkWAYx3ZOnWw+sBn7CUl1zGEW0V7rNdFLCJAVrk
         dUBbgKCVRAGL+EmfaTknoL/8vncnnOCGAmZVGMgfq92FeUt7CtESZBbQwD/mTMubK7yR
         iYBw==
X-Gm-Message-State: AOJu0YxbXe/bghOGskAmWhTNp1Kf9HrlfbUXzRqNz4j6N93p2WaPBFpT
	/+AKUK4ImNU1qiwngN0h4nVj/37V5gu8hu9W3SKIhkFYG6GstT2LIbf4
X-Gm-Gg: AfdE7ckyTwtRj2c/JvjmxkMLlWkXwLmHT5QjZeUW+o5VpBCR1fUI5byOCFP1D602Avb
	R/Zfn4oE8eL9Sm6MrzGRLK5ULZnHbTAlCsbTmmcbN4nFd6MZej6knKWLT3qQY20EWwb1H1fC4M9
	parFYBPVj9GLDRt4Z+nBQ2Mqx1DBAMoYgQcqiM6qwqtgHfrNXeQGwCW9mVgfquSTNWAve2xUmrD
	pFJuXj/Ar8cY5zBEoxldm4vJOrz05CijBojo16F5mJhja67mTLOjscuRUU35sJRNAyzuTDxKpka
	9RHHAPpq8owlTUJvNyVeCh/8DInOahTfImpTFVd35Qb1p7MQlKaBKsdC4hxgN2EWMETtjmv+TSV
	1LxtYy/9okVxRU+VfkJmIHTOld/i42tOpZ6ldL4ad8FMGeuMkU4Efbotaf7/vN2s1pjOfVpidwL
	hCGugf+C5YydBZWPBi5DUbyOV28Xf33a/uvpCIoBBMSCMVL1tgF8cbBM9rnClb8kjX3MxwK75in
	M6eDX5oaz/d
X-Received: by 2002:a17:90a:d40f:b0:37f:eda5:5169 with SMTP id 98e67ed59e1d1-38e4b4474f6mr2760020a91.13.1784295303231;
        Fri, 17 Jul 2026 06:35:03 -0700 (PDT)
Received: from jayatheerth ([2405:201:c005:b959:7d42:d207:de10:1218])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3142a20cfe3sm7867411eec.30.2026.07.17.06.35.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 06:35:02 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: jayatheerthkulkarni2005@gmail.com
Cc: git@vger.kernel.org,
	jltobler@gmail.com,
	lucasseikioshiro@gmail.com
Subject: [GSoC Patch v2 5/7] repo: add path.index with absolute and relative suffix formatting
Date: Fri, 17 Jul 2026 19:00:13 +0530
Message-ID: <20260717133015.32040-6-jayatheerthkulkarni2005@gmail.com>
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

