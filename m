Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED863FADFC
	for <git@vger.kernel.org>; Fri, 17 Jul 2026 13:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784295277; cv=none; b=R+dVRD1OWHjZFR9DOz7f5x3g2V/LoXu6qp2jXUCZB9jbxGov6GIim+TMup1NK93dlphUglh3RgSsGAhsxe1t4zyBvyB3wTNjdrd0PkhLtZERi04mJx9y3NqteXD0etbyAuVjUiMnFziag1sb4JTkVeAq9un6ilKEMXdYcqvjAb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784295277; c=relaxed/simple;
	bh=sCYW9ZmP5PAulWSBG7bjtfpJsETw9n6OMMsa9nkbAgw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PkoI/z5+icp7D7TvUQLp2iN/wsnWhBVRVq4g7nX1pFMr1bUKpzrdN5grA/b7ofN9uEnXf3+YLrux5ViVYiwDFkrVW8s3Err/Wm6naI80D9WLDSe+NrEoI4/tbAHf8IHoa3OTjHvMGX+6XhnDB2qLhSXX86W1nXc+BLB0cOoTAUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ae8MvShC; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ae8MvShC"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2cedda2ce6fso41790055ad.1
        for <git@vger.kernel.org>; Fri, 17 Jul 2026 06:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784295275; x=1784900075; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lKyi11uC/DavArOSXVLBtomjGo/OrrBcsKpDj+gII5k=;
        b=ae8MvShCzJdR6BbMPkiGsZ4SqqsMmItJTYL1Pazl/skziF8HLrTj7ri5Pjv1NmA6aD
         g0tolVZfnqpO5byKyWmc8MbrhBJQC9bDjRKOOqq4YePUOGb570CMgQ8fDYy2MUcsd4WS
         Pfw3Vl8WxTwSMC03M8tVOFRJcGAjlBsLq/bb0E7Ewrj40kswyEU7NJ9lbzQ9OwEUgxG/
         JxPpo6sCkX6FBoWdK2aRCDll+GP9WkV+9C2FlQX57jVktuEimnjLeZRwyXwZfyZMjg5y
         0wSIMDNOIyn7PHls5+KiyU5Og6DjYxkjhZsuiql4fTXwiPMZNWvE8SSfQHOWPzbRUK3K
         Ry+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784295275; x=1784900075;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lKyi11uC/DavArOSXVLBtomjGo/OrrBcsKpDj+gII5k=;
        b=n+qYjdrJXrknclvss+nq4cTK+uoN1gN1Lnf7Il1DBD6DKwWEdlR6V0n9ba+rTv6VEz
         E4klC4ReWpggp4pGTA1tDMNXSBqJ8yh5FCkj89/xPdsbOKUM5I7u+v2NozUZTmV5Q48T
         VmFuH5HB1uFldvUrHj/C47xJHZP2gJDPUnrhO/Fx59F5DPlSmXRnCnZJYsnxEXbd9npy
         tKzUp6Z9N7h+zqE+epCftWMULiu7jN3qRr5zNSPOY1k/2BLFUwnmiGp51FmE/xZVXyrF
         mags3YABhOgxd88WUvFkH0RlJiI2J73VTDI1+3N6+Gc89wwauIkG5NiKclSpAMVXhevW
         z/yg==
X-Gm-Message-State: AOJu0YzRbrrf13KsbnzD4DZLC+ok86dEb22W5etQnVI+k4gVIS0irLAE
	iPJFJXdZJ6QDQ1n74QDv9e16Xy9DqDHdG8KdWzWpMp7nE/HRlO79kWN1
X-Gm-Gg: AfdE7clTOVkdAtIYVjowkTgQGe4G44aPpBMJoX4V2en1cQVlKhNfP8YqE61BisLlsKn
	BaJFuZzQnTWV6GOzMO1Fm652tKGvZmP+8E1H1sOV4Is0L+hgC3PvrQP+scCVJUV6AVGS579BWqE
	HkTfcOBLZGNovo6hSe5Pm+cCWNKsxX+BknTcmWXPEdGCKfKZzR6Ck1jozQILPwSN4gJlw/PmLgx
	y753cyBE6OfOQYytCipcmSJX8L1TCqTvl+WjVT4bl72a/gRb7C793b/1THthzrCIzHzM9tS/cXy
	DmUmiU/hvbdijCacMNlic4pUOiirw+HoB3GMA9tt67QE2yrBhP7KFiovQgKEpAPp+mCSDh+QKU6
	3aGhELDH/cmsmCWW4s2YMXQYdIyUjj63dqFS1lt6Q+O3Dvju/mPKA1LDRZkp9M42CejR/8aSSnW
	Qz4qDbxld/LoY7jv7HRI7sNsJqxBbdQ+cri9M2KkH7FhgD87NqBTDAIy4neZQ+3sSknvHklknsz
	z2Zj5dxqhfb
X-Received: by 2002:a17:90b:180b:b0:387:e0bb:57fa with SMTP id 98e67ed59e1d1-38e4b5a825amr2334930a91.43.1784295275125;
        Fri, 17 Jul 2026 06:34:35 -0700 (PDT)
Received: from jayatheerth ([2405:201:c005:b959:7d42:d207:de10:1218])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3142a20cfe3sm7867411eec.30.2026.07.17.06.34.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 06:34:34 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: jayatheerthkulkarni2005@gmail.com
Cc: git@vger.kernel.org,
	jltobler@gmail.com,
	lucasseikioshiro@gmail.com
Subject: [GSoC Patch v2 4/7] repo: add path.hooks with absolute and relative suffix formatting
Date: Fri, 17 Jul 2026 19:00:12 +0530
Message-ID: <20260717133015.32040-5-jayatheerthkulkarni2005@gmail.com>
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

