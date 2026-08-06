Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93EF1438475
	for <git@vger.kernel.org>; Thu,  6 Aug 2026 10:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786011945; cv=none; b=djkHyBgJzi2fmBB8PSSjWKF8077m4HYsiCxYsgQRbP5Vq06ipPTaNFRxNCplDckZtgP79FzZPyt69PeMSMrSBYDv+QtcTLIxwFrC1pb33dTS5V4xIC6q+2pLypVgxKYJwb7k34SczjpNWYN+thzJgdK1wkCnjD6+VpZtOzcVxUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786011945; c=relaxed/simple;
	bh=yV7l20l9/dnYNIl1a/0RtkF4cUYJr7YIQ2AzGJJ07PM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WKbFMQ7/FpatYctltEoNWmAUVgaIiRUQKhVz9UiEl3EPNmR3EOjioMj9rSvdxzVfkgme+5JuoHClCntchqHiipe30aQ1HDZmEQh9lW7Ajkc54BAl+H10bui2RXhKWbUy86WAldOB/IlquxLgBJ8MkowRYKuI5yQrKqP8ZunMkYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qcWmJ0qE; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qcWmJ0qE"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-cbb7926836eso1505210a12.3
        for <git@vger.kernel.org>; Thu, 06 Aug 2026 03:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786011943; x=1786616743; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vvhrmKIjkQsYbygUFpk95u1jBXKNzz7+Fi8NIVbg1yQ=;
        b=qcWmJ0qE52t0IzsNefFKfTulZ1Mea0kHbc+QVOpu42E9fiy5X6c2H+DELU/R0wiaWD
         PjpjaxpU7H0h9Et2WdeAjbeSvW7jw0QI+7Iqoq3LoysU0CAQbViG6/ahiAqwmWV9Dy0F
         JBdlUzJfbpr/UxI/t49iNxvZ/EVgUJEG2XETpHiRBM8rnoUzAVr0CzdJqAif8jJMgXQX
         sH9+nlPPQJhJ11zrj53EFuaskoGfyqXjrXMspPhV+TY8OZ0XepJOMMzvunSdrMvH+Xml
         U1ipFHHNWsTAZ1RkXZBKTFa7lqlh6pxQ1rN5U1UrgPb7hh7bOhqtzSztXvUiKVTi89vH
         3RlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786011943; x=1786616743;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vvhrmKIjkQsYbygUFpk95u1jBXKNzz7+Fi8NIVbg1yQ=;
        b=AO51r1Sh6vlue2e11iksFg6wTGt5npyvMji+tVDQEJM3PRy1htC2/b2M7nn0n9Qpoe
         +uTug+vo4biLQTURzCGmuAQdH4Xv9YZwmpdhxWqS3mTeT7ZJdo5J2zM8/MZnu+AN21zq
         QHiGJ7LI8zOykEewNBy5fTO9DDLqn74srQR9Now2fG0Vn7TgrKDbb1tgdgPZ9gP4n6YN
         7rlXYv1Qy5SxsUNmaUXtXhEd3iTT1lU8xpK0AawJPcaytfumFxGJfxTH1GBR12ak4iJ/
         ThzI3bfaXVTOc5fAkOsGatci4zy2g7RyWChloo6wkMV3poumhQ5k9BfyOZPKbgnU2KWs
         8oiA==
X-Gm-Message-State: AOJu0Yz8g2CW/eUevyjX4tDku0BzstQTxp50lHFTmkZVTdfZ8XTNqb/o
	Pme0lLtn/nX+jaKVFTXV/IO8Hd84TBykJPAaMRywFuqpaK83pKbyxaS5
X-Gm-Gg: AR+sD13saN0qp2hfTlR2tA5LCGHW8YR+9FlV303E51om96PaG0Y5fDKWolKEBWbbpmR
	KpsqFJMldELFkuLMLzWLmEcPvcyqPUG+QaQ9r6QlI7qp9jlE+KnyH9BM2vny6zP71QAxlcbiBua
	56HLuD5z1WCgkHkDnXwUg7C7Tt8FLwOcNZQrzY3CsiCu7ggUpx9EGrXVpq7aEgJHVHGdALqeRvB
	IsmCMeQCJ/X45SZcLIa26iZGq0LmZ8lUhy8pfKf+vlhDvAjnU/mnKCpE24iAFzWNLnEPuAC3z48
	k168chD7KNV4H04m8HAaudSl5uc67bpCzBKBNo5llspMRpayD0La4fdQCxejXAgSH/WPrISKsS6
	BvL76CVGtEHBXPxMC0kHV31Vl+1co1UyYreK2P6JneVlt4xAGkzp3Uuf1klNMq087VK2/UApn92
	NAQ0WGvlS+LmhURpiWEO6O8YkpyhX+2VNYrO6B7miOCqd0Bg+MtDi/KzNg/s4NlPqeSy/4QOefP
	Q94/qt85GQXRZwgHPGMuNq9O3lcfb4jpLUPzPbX2W0tKyCzpr6dnFt1yQZA5MfREvDs/z4=
X-Received: by 2002:a05:6a20:7fa1:b0:3c8:e140:63c3 with SMTP id adf61e73a8af0-3cb86076804mr15023115637.37.1786011942821;
        Thu, 06 Aug 2026 03:25:42 -0700 (PDT)
Received: from jayatheerth ([2405:201:c005:b959:7d42:d207:de10:1218])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315863b76cfsm25525901eec.4.2026.08.06.03.25.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 03:25:42 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: jayatheerthkulkarni2005@gmail.com
Cc: git@vger.kernel.org,
	jltobler@gmail.com,
	lucasseikioshiro@gmail.com
Subject: [GSoC PATCH v4 6/7] repo: add path.git-prefix
Date: Thu,  6 Aug 2026 15:45:55 +0530
Message-ID: <20260806101556.162940-7-jayatheerthkulkarni2005@gmail.com>
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

Scripts sometimes need the path from the repository's working tree root
to the current working directory. While this information can be derived
through existing Git commands, `git repo info` does not currently expose
it as a scriptable key.

Introduce the `path.git-prefix` key to `git repo info`. The key returns
the path from the working tree root to the current working directory,
returning the empty string when invoked from the working tree root.

Mentored-by: Justin Tobler <jltobler@gmail.com>
Mentored-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
---
 Documentation/git-repo.adoc |  5 +++++
 builtin/repo.c              | 11 +++++++++++
 t/t1900-repo-info.sh        | 23 +++++++++++++++++++++++
 3 files changed, 39 insertions(+)

diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
index 868ab0ed9f..fb5aceae8f 100644
--- a/Documentation/git-repo.adoc
+++ b/Documentation/git-repo.adoc
@@ -113,6 +113,11 @@ values that they return:
 	The path to the Git repository's common directory relative to
 	the current working directory.
 
+`path.git-prefix`::
+	The path from the root of the working tree to the current working
+	directory. Returns the empty string when the current working directory
+	is the root of the working tree.
+
 `path.gitdir.absolute`::
 	The canonical absolute path to the Git repository directory (the `.git` directory).
 
diff --git a/builtin/repo.c b/builtin/repo.c
index 779240109d..c0f99b6869 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -100,6 +100,16 @@ static int get_path_commondir_relative(struct repository *repo, struct strbuf *b
 	return 0;
 }
 
+static int get_path_git_prefix(struct repository *repo, struct strbuf *buf)
+{
+	/*
+	 * repo->prefix is NULL when the current working directory is
+	 * the worktree root.
+	 */
+	strbuf_addstr(buf, repo->prefix ? repo->prefix : "");
+	return 0;
+}
+
 static int get_path_gitdir_absolute(struct repository *repo, struct strbuf *buf)
 {
 	const char *git_dir = repo_get_git_dir(repo);
@@ -250,6 +260,7 @@ static const struct repo_info_field repo_info_field[] = {
 	{ "object.format", get_object_format },
 	{ "path.commondir.absolute", get_path_commondir_absolute },
 	{ "path.commondir.relative", get_path_commondir_relative },
+	{ "path.git-prefix", get_path_git_prefix },
 	{ "path.gitdir.absolute", get_path_gitdir_absolute },
 	{ "path.gitdir.relative", get_path_gitdir_relative },
 	{ "path.grafts.absolute", get_path_grafts_absolute },
diff --git a/t/t1900-repo-info.sh b/t/t1900-repo-info.sh
index adc4a92487..b689445b7a 100755
--- a/t/t1900-repo-info.sh
+++ b/t/t1900-repo-info.sh
@@ -215,6 +215,29 @@ test_repo_info_path 'commondir with only GIT_DIR' 'commondir' \
 	'.git' \
 	'GIT_DIR="../.git" && export GIT_DIR'
 
+test_expect_success 'path.git-prefix at repository root' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		echo "path.git-prefix=" >expect &&
+		git repo info path.git-prefix >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'path.git-prefix in subdirectory' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	mkdir -p repo/sub/dir &&
+	(
+		cd repo/sub/dir &&
+		echo "path.git-prefix=sub/dir/" >expect &&
+		git repo info path.git-prefix >actual &&
+		test_cmp expect actual
+	)
+'
+
 test_repo_info_path 'gitdir standard' 'gitdir' '.git'
 
 test_repo_info_path 'gitdir with explicit GIT_DIR' 'gitdir' \
-- 
2.55.GIT

