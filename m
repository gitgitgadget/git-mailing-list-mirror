Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54BEC23D283
	for <git@vger.kernel.org>; Thu, 16 Jul 2026 01:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784165103; cv=none; b=MuPO2ZpQxZ8Cb8KwkQ+HwdKitP/GAD9FNl0ZdIPeeDCcyy5/p78asZVMn2imusl1shDt8SiXMpAPx8OhHrhMcC4ta94RCyaT/LYSzLY//tHuLu93aFVRPpnqd4miJ29NXnp/gpBDVz3ltcTYgEc0WLJXX+d6UcYZtbMbUCZbJIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784165103; c=relaxed/simple;
	bh=sCYW9ZmP5PAulWSBG7bjtfpJsETw9n6OMMsa9nkbAgw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qMHDLPGra1FlVD8PyLgEy9/6L1mCykbGgLPeDW+YuGKbPzYdpXc7NpRsjStPC248D9pZ3bQAue/TpaYiVmGIMmWuCPuvKi/UJeyFPzG2zHgR1GTBVE0fiLa5fxmmpOf57PUuWdaFpplaV9txq55FYedJ3JM2HxVfTfUTe5YtH2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eA1mZaCJ; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eA1mZaCJ"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c9b373d5af0so4457107a12.2
        for <git@vger.kernel.org>; Wed, 15 Jul 2026 18:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784165100; x=1784769900; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lKyi11uC/DavArOSXVLBtomjGo/OrrBcsKpDj+gII5k=;
        b=eA1mZaCJ8pR6SLLBJbWhy1dWadPfV95sQtkaQhgs1Xgfw7ntem8PJTF/MhsWF9f2AP
         04RntAEbjHlxnY8mfXmTy708OrEz+mJ7SZU/NvKEvEFl7oGn6sGRh8FIvg/tLI1qe8uK
         Xf6byforvS0S7JrtG/zadA+bvU/SS50iJznVqjezgvXMWv4FHC/AynnzuGKLF7TeLW8z
         0WJN28xXbGb8D/utM9muaf16nWMSPuXVMjFJINr9RcdaXFL/NyczVoUdOYWDaDiriQ+L
         jttoa6wsP+ilXDXzK+n9FpIoU1B4RWrUKcQQBYHEkpGbAK+xAblgyQUQ0++6QAAIaeOm
         DwkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784165100; x=1784769900;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lKyi11uC/DavArOSXVLBtomjGo/OrrBcsKpDj+gII5k=;
        b=CuNAEWQAWFkmVK6oNQYd8+11sEW483NcUg2jSAYtHmeasbIDmfeUUr3iP0PbRKP4uE
         wWItLxMFT0BHLEOGZUF88zyx8C64w0RWxjaC3bScvXHNACqEfhEB73w70IpBe+JSdU0e
         PTf0m+rY3Cl+27lbF2kIcXlalPchAjkIkhskfOhW3UWbjLzv215R2nN2snUHKL9kGSNw
         Fi2ovKHUGYlKUlb8XKEdMC+3+gTXzC/hXxUXPYKDCt3rvYSe8KvibSyPMdIRWCKF1oVW
         xA3CB9e52ZPat42B3loZdkXbOo4aGHcoUWurp+PCSM2pq04jnADUFgcXJM8midBqQtsC
         XJ6g==
X-Gm-Message-State: AOJu0YyBb2SxUYoTMnpxgerTr2ea0dg0zndTrrtpgpHuLW4Xp0vBjOwb
	Mu2mi/r6ntoBvxcgId9XTe+4vsXmeVX2G7Hiy2TVCD1s3YuzRuZ/N2LBou3DWQ==
X-Gm-Gg: AfdE7clNZizQp0yaC+mp2FKOfaGkF7TyrBe+RThT4GgzUub2Jo6DCqVYoHIxJhtBrky
	53PjV5ntI9VMid9svNz1BFJr+xY0o6M784yuchOZmmaqv9uHMuWh2nybDxERg7k7NVM7P6hciVU
	bQfOa7FKmglKdBM/A7z8ryseM1SuAod/gPWXDRAecSsrwvc0qIZRrWaNvwDKf5xwOe4xeE0KoV+
	tVPPUZRW6bM5FWDDqgJku3UDW25UZK7YKvM6BSM1T9gAcUC+cWxa9VAi6rh87WR0vnVcc8f8zzf
	96nHKnyghTMB6/rvU4P0RcQaJi2mtpgrq1Jxua2uQWi/FnG2vAvMymM7JLeYCMa/LLSXo9WX/kK
	n4JGXaUqZlhx7WZI4LTWMsCapg/jAf3f1eswVgDLyMOxNQC6BE7nFqbX/veYv+Fw+D+tqLBXu+g
	dGbSno6yigUfnpi3RaS/YNVuJfvoKkMeKqzIEOjZu29/E4+W2sp49g5oSS7UMhazQmN8bxdjEu7
	LZOAs6jeGQo
X-Received: by 2002:a05:6a20:c989:b0:3c0:9c19:65be with SMTP id adf61e73a8af0-3c36c49a084mr5872557637.70.1784165099607;
        Wed, 15 Jul 2026 18:24:59 -0700 (PDT)
Received: from jayatheerth ([2405:201:c005:b959:7d42:d207:de10:1218])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3140e6e9edfsm5377490eec.28.2026.07.15.18.24.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 18:24:58 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: git@vger.kernel.org
Cc: jltobler@gmail.com,
	lucasseikioshiro@gmail.com,
	K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Subject: [GSoC Patch 4/7] repo: add path.hooks with absolute and relative suffix formatting
Date: Thu, 16 Jul 2026 06:51:35 +0530
Message-ID: <20260716012138.6714-5-jayatheerthkulkarni2005@gmail.com>
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

