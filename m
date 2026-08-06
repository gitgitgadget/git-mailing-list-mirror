Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156EB43F4A6
	for <git@vger.kernel.org>; Thu,  6 Aug 2026 10:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786011920; cv=none; b=nnJmrAnik4rHVuCtc/+hTGZaH2xqPHZ/ztPVwebEdMnjdLYVGfJipd4YJtL9dNDZCm1zOeRKpFgMumZ3CHOv604f/fXROwAZ7D2xRvGHzUT7r+URTS06nLwogeJmO3T2EnklIhb6TqETdcYuJ3RsMPm+FQsmZ62ssJQiK67zZeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786011920; c=relaxed/simple;
	bh=9Z8elEmtt5EBQDZe4IA77t0WYmsm6fm3kHZhVMC1EX4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jEUls/1p9/mq7tXJ2Y6pKnyP3K5j4BbPTdXKbrWSMl4+VG8qR2kXHsNrZrzELLFBcIXS6dHMy4Xi8rzDEHi/d5gctBb/LHEeiqsJmmQtwuZj4dxedcEbuAgVOo7AuT9+dtb9YT9/aeq4Y/cZDzeWSlu9TA0A3XWIXfQn7C1fvao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DPJiNu9d; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DPJiNu9d"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-cbe6295f05bso597386a12.1
        for <git@vger.kernel.org>; Thu, 06 Aug 2026 03:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786011918; x=1786616718; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zh3K0IvSMfY/YmIWtCencjbqRfBSdCcYyOG1+VSSBHA=;
        b=DPJiNu9dCRqR7RjudY2FkDoF2c14w5ARjDy/z7IKRPim4R4AfDJlYglbYRVQVzX5bs
         G5jDgY6mOlwg0j21H5XTSusmmqK0m/QANWOBDwjZf0H5awh+cGBeTcXWZcvz7sfTb/LL
         yYEXRe9Hk5SdBrw876lQI51niNoJUyV2AqXEQt1DhJQ/01OvxagWqg5jZ0WPyhPJmRy+
         PLCY/bqItSKYy/Hkg88FgpUuYHZDG6vCKjm7EFmdGDPo+uoIx5M/lDaU/45xQeBCj9SA
         tllKeHOHSVDUB5fjpuwBZltVg3yQaJvFD2rgCZjTqSLFREF1d/PSYM0SEfLJUNCTg9kX
         LsNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786011918; x=1786616718;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zh3K0IvSMfY/YmIWtCencjbqRfBSdCcYyOG1+VSSBHA=;
        b=fSZyXP8bx+DtnGwOESQjRRbqBw4fjPWLxcA0Ktg+QfAyV4jcoxcxkpfouvbnTB1xvK
         EzIJF5wQB2yeBNeKFwlNpqS62clbM608ewoPsqDZpqYqCtZr3xNcCPRsZ0V15jeJCrBt
         gVMht4hbd44MU7tZUA5TBL7HnRUMZIXjsu6puTwIZ4hRgLCZS5jYsgXVhPG6PZkoZW4b
         muVy4bLG98NLwxnLtr+cqWNyeZ/BIq/eZeYCz24OLNIqBjMI8lNVx3w4VFY3wkaDAF75
         kyx6B0gIqYoywhW1NO8Uiyp84yzq8BKddxVMBNnlCIpcSmn+FBo8JLfhWa8Od7YC9Ipj
         tZMw==
X-Gm-Message-State: AOJu0YxCpQLDj1CG2nXlSvrABRME6wQD+87d4GglF6F5DbpL8MtN3UOT
	mYJBKW4K7Je0OMmOHXdOY0tTRSL5wW2UhySLrISg/eiD5qOja+lnkbhJ
X-Gm-Gg: AR+sD12nbWkrFWkm+ieFuRrO1pmtrWpNnwuCjks0ZEgmrbFhz3IRMC9bugo3xy5VV8F
	A+7n7roAEOcYeI4qJygs1cATql1FBWEe/z6F7wlwC01luqHy85xEMz1ZF1LaR6KvTC0kvafZHqb
	uym9TRdqfUHhRA1LSVrnO3ABYo+y48rc66/7Y4CWIPL1cN40tdJuqQhl8uilmofhxws51wf34AZ
	D0f0NuE0rMSxsKMSdrt9nOCBrTP60LC2r/gtQNZXTQqeegChrVf/sric9bt3lianyG+f9pzCjM/
	8G+Bgia7+C/rg1lU8bS7trCgJFQABd8BAtdYn958KJaPeU1M2H/FsE2FaqxIxGFqJzuu2YmcXtn
	JnpG9s29zbB1UiE8wMoTah01iTpVwNmxYW7MyRZYIPuUh9ocwTQrMppL+ySaOO+0aNHKeMCCRrW
	dwCUc7JR8dRhwphw2ONQ0TD//mgEynK434bXi8ta2Lv6FMNOGNYANH/r145xTg1Abk0KVuWCTPq
	vA8qz7jNMEl/OiTPp3DSeTJK42SBNYjC8vnG3CCKpgB6R9Uk4DFdTSeAq0ylijkVRBbLWE=
X-Received: by 2002:a05:6a20:72a6:b0:3bf:9bd9:cf54 with SMTP id adf61e73a8af0-3cb9c0c8579mr6135088637.8.1786011918182;
        Thu, 06 Aug 2026 03:25:18 -0700 (PDT)
Received: from jayatheerth ([2405:201:c005:b959:7d42:d207:de10:1218])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315863b76cfsm25525901eec.4.2026.08.06.03.25.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 03:25:17 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: jayatheerthkulkarni2005@gmail.com
Cc: git@vger.kernel.org,
	jltobler@gmail.com,
	lucasseikioshiro@gmail.com
Subject: [GSoC PATCH v4 5/7] repo: add path.grafts with absolute and relative suffixes
Date: Thu,  6 Aug 2026 15:45:54 +0530
Message-ID: <20260806101556.162940-6-jayatheerthkulkarni2005@gmail.com>
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

The repository grafts file specifies alternate parent relationships for
commits and may be used by repository tooling that needs to inspect or
manage grafts. Scripts currently retrieve its location by invoking
`git rev-parse --git-path info/grafts`.

Introduce `path.grafts.absolute` and `path.grafts.relative` keys to
`git repo info`. This exposes the grafts file location as a scriptable
config-like key using standard format rules, allowing scripts to
retrieve it through the same interface as other repository path
information.

Mentored-by: Justin Tobler <jltobler@gmail.com>
Mentored-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
---
 Documentation/git-repo.adoc | 11 +++++++++++
 builtin/repo.c              | 24 ++++++++++++++++++++++++
 t/t1900-repo-info.sh        |  6 ++++++
 3 files changed, 41 insertions(+)

diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
index 08ef47750c..868ab0ed9f 100644
--- a/Documentation/git-repo.adoc
+++ b/Documentation/git-repo.adoc
@@ -119,6 +119,17 @@ values that they return:
 `path.gitdir.relative`::
 	The path to the Git repository directory relative to the current working directory.
 
+`path.grafts.absolute`::
+	The canonical absolute path to the repository's graft file.
+	Respects the `GIT_GRAFT_FILE` environment override. The path is
+	returned regardless of whether the file currently exists on disk.
+
+`path.grafts.relative`::
+	The path to the repository's graft file relative to the current
+	working directory. Respects the `GIT_GRAFT_FILE` environment
+	override. The path is returned regardless of whether the file
+	currently exists on disk.
+
 `path.hooks.absolute`::
 	The canonical absolute path to the repository's hooks directory.
 	Respects the `core.hooksPath` configuration. If `core.hooksPath` is
diff --git a/builtin/repo.c b/builtin/repo.c
index 2a15327094..779240109d 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -122,6 +122,28 @@ static int get_path_gitdir_relative(struct repository *repo, struct strbuf *buf)
 	return 0;
 }
 
+static int get_path_grafts_absolute(struct repository *repo, struct strbuf *buf)
+{
+	const char *graft_file = repo_get_graft_file(repo);
+
+	if (!graft_file)
+		return error(_("unable to get graft file"));
+
+	format_path(buf, graft_file, "", PATH_FORMAT_CANONICAL);
+	return 0;
+}
+
+static int get_path_grafts_relative(struct repository *repo, struct strbuf *buf)
+{
+	const char *graft_file = repo_get_graft_file(repo);
+
+	if (!graft_file)
+		return error(_("unable to get graft file"));
+
+	format_path(buf, graft_file, repo->prefix, PATH_FORMAT_RELATIVE);
+	return 0;
+}
+
 static int get_path_hooks_absolute(struct repository *repo, struct strbuf *buf)
 {
 	struct strbuf hooks_path = STRBUF_INIT;
@@ -230,6 +252,8 @@ static const struct repo_info_field repo_info_field[] = {
 	{ "path.commondir.relative", get_path_commondir_relative },
 	{ "path.gitdir.absolute", get_path_gitdir_absolute },
 	{ "path.gitdir.relative", get_path_gitdir_relative },
+	{ "path.grafts.absolute", get_path_grafts_absolute },
+	{ "path.grafts.relative", get_path_grafts_relative },
 	{ "path.hooks.absolute", get_path_hooks_absolute },
 	{ "path.hooks.relative", get_path_hooks_relative },
 	{ "path.index.absolute", get_path_index_absolute },
diff --git a/t/t1900-repo-info.sh b/t/t1900-repo-info.sh
index 431a4842d4..adc4a92487 100755
--- a/t/t1900-repo-info.sh
+++ b/t/t1900-repo-info.sh
@@ -221,6 +221,12 @@ test_repo_info_path 'gitdir with explicit GIT_DIR' 'gitdir' \
 	'.git' \
 	'GIT_DIR="../.git" && export GIT_DIR'
 
+test_repo_info_path 'grafts standard' 'grafts' '.git/info/grafts'
+
+test_repo_info_path 'grafts with GIT_GRAFT_FILE override' 'grafts' \
+	'custom-graft-file' \
+	'GIT_GRAFT_FILE="$ROOT/custom-graft-file" && export GIT_GRAFT_FILE'
+
 test_repo_info_path 'hooks standard' 'hooks' '.git/hooks'
 
 test_repo_info_path 'hooks with core.hooksPath override' 'hooks' \
-- 
2.55.GIT

