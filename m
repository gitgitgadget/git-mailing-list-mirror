Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571FB29A31C
	for <git@vger.kernel.org>; Fri, 12 Jun 2026 18:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781289076; cv=none; b=YBTMXvqdte/aOi5Tmt4hM4dkvnZAdwTiBaaAT2nUfJ/VoHUkt8B2CYx3RqxmU0M1oX1poLGhUAjyjizscl+MFaA5Ph4aXZbEoYnmlXNMVIApgl5rxW+sTM8MMUw8Rj62b3jFuoU+reeh0JzyivsFZ5HXMJxBBZvemSngF4G/974=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781289076; c=relaxed/simple;
	bh=s3PxW2evY3mWySVOwoK37lEyhlg/OrlrlEbEc9a56F4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AXGOAp+dtAU8f0RLTKIKRBwimsZpuptgRW9jQOZ2rgUl4PIfL8luz7GXDy57AXxojFgjYSOcpMVrXHv6SpahdjDZDR81TmWKcJg8UY5WHUbc96kj9XGdfPGCw3h9KVgDsCWi117GYxu5WcZy2gWwQlc6v2qy6iyRuQ58Z1hyRW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kgs1FCRk; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kgs1FCRk"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8422524cb38so625663b3a.0
        for <git@vger.kernel.org>; Fri, 12 Jun 2026 11:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781289074; x=1781893874; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8vR2ftFSudIW2vyy9XGZI5T1+OUqpg+mBGp7ogXI9tw=;
        b=kgs1FCRkq0IWXnw4QUS/2IfJ9FziDBpwfuKqoaHJgycqljNlfxf+Lldc9+Ka7GUILG
         tSQzSe0uhqJsdyujGHi+Is8SilL5BzUs/2E5DjR48uuybzbhIx8HwHfhtownWMFz7+Ne
         Ad6vgOkR0MsDJbVoR9Y3dvnFR7Kv2jrEEL9I9m237exCxmm5njdYuuKrNCF+a6fsrR6u
         BcyjJribC44S6l/ezKUA+tCohTEdnY9g9vl5QcXUMIA8CCojCzmcQAGR/o8fc6ucfkTv
         SCJCsOWFVuqvoHRbY3vyBWfVCGscu05aIhaaGPI/cBlJV+5x7R0VqE5/XJKVij2vLEmA
         spHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781289074; x=1781893874;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8vR2ftFSudIW2vyy9XGZI5T1+OUqpg+mBGp7ogXI9tw=;
        b=hzxRDB4R1w50Ot7IpuB5RUyohs4r80Lc/JffER80kNLscm0xJ3D59WltA3fxmxUkJl
         aMjASDcFw8xzOu/69gkaLbral3S6K2uwLn9ugamWrmb7aENyXflu6na3lps4fC3N0/ER
         TgQfXLP3OAzO/fM7Gvp4adPwCruYnWeQKd7sH4vpGWzsi5yyzGgn062j/G8UsFMqH38z
         5lY6EENnR/auK28PAB46blINXB9qawHAhCxSK6HxHW7AkjK7q9noqpmE/ZHKtqHH6hNH
         RMcdXuVjl1YKbpxFEOrgk4Vhxwnuvyx6sN4HCzZXnJw0Mee2o+gEtHmp2aW9OLeG61RB
         zBDw==
X-Forwarded-Encrypted: i=1; AFNElJ8PgGU6b6ff5esDczAPho+ffq8yJ2lGtbcQl4craLCc0KJeHOhNmNazqvmlG7f/irhbu9Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6+h6eyZh3jSsyu893/P1pN6AcRzM665PY85Ve5zulX0XBaWTw
	jraHe2ESCEavFqZSXNNBDkYLn83Cy0Q+2GDUwV4k+CeYBrM6E97rUorR
X-Gm-Gg: Acq92OF9SA0oUIS/F0SBZAtt0OpM7WNGIygoLFlBKkMO2MMGew6xXdvo6PXUshGL6aq
	zHA1P4RyxXCgapFt+JO9lMRK5EnvlPWRRdieMCUvAHpAWfC2thcopR+2p5mjUNDyBcsogRYSX6d
	fpo99EQyQgI8qbMWzm+1AcdIF884xxTg7UL++E6N/xUtMFE5nCqhj1U+V5iKgACMsLGcO5inG/X
	/IKvbfO/NT4ELFw2W+mfJ8rtELX5mzq8iSbi9HX3Hzuz1YxMWH15aRIUJye7atT5TthdkGXi+4/
	7L7E8yAPxiuZ/b+JtJ6a2neRWJmn94zeIosdYvfXPqoU0NaR1AOcmmh4r9EFK3hrZN8fOwgKlXC
	wa3WDFRAA8KQ3NkqrCm5t0AlIAEsYEFgG3vwEwzvOjpYmrrCqqfRdo0F0y8Rqwhtr6eY8VsUT6F
	P16DSoOwmDkJOuvb7c5+ffJ7unctlbbPaIa7qEt/NyEMip2nmhEPvqO3B3QE49K2hfcDSM0Sr2u
	BTHlSoQADZin5NiT/Po6cjnz1iGPmhJCA==
X-Received: by 2002:a05:6a00:3cd1:b0:842:5a18:9af8 with SMTP id d2e1a72fcca58-844e1967789mr842488b3a.12.1781289074444;
        Fri, 12 Jun 2026 11:31:14 -0700 (PDT)
Received: from jayatheerth ([2405:201:c005:b959:7d42:d207:de10:1218])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434afc9fa8sm3341488b3a.32.2026.06.12.11.31.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 11:31:13 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: jayatheerthkulkarni2005@gmail.com
Cc: a3205153416@gmail.com,
	git@vger.kernel.org,
	gitster@pobox.com,
	jltobler@gmail.com,
	kristofferhaugsbakk@fastmail.com,
	kumarayushjha123@gmail.com,
	lucasseikioshiro@gmail.com,
	phillip.wood@dunelm.org.uk,
	sandals@crustytoothpaste.net
Subject: [GSoC Patch v3 4/4] repo: add path.gitdir with absolute and relative suffix formatting
Date: Fri, 12 Jun 2026 23:58:47 +0530
Message-ID: <20260612182847.562816-5-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260612182847.562816-1-jayatheerthkulkarni2005@gmail.com>
References: <20260601151950.30686-1-jayatheerthkulkarni2005@gmail.com>
 <20260612182847.562816-1-jayatheerthkulkarni2005@gmail.com>
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
 t/t1900-repo-info.sh        |  7 +++++++
 3 files changed, 37 insertions(+)

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
index 28fe76e25b..26acb5fe82 100755
--- a/t/t1900-repo-info.sh
+++ b/t/t1900-repo-info.sh
@@ -216,4 +216,11 @@ test_repo_info_path 'commondir with only GIT_DIR' 'commondir' \
 	'commondir-only-gitdir' '.git' '../.git' \
 	'GIT_DIR="../.git" && export GIT_DIR'
 
+test_repo_info_path 'gitdir standard' 'gitdir' 'gitdir-std' \
+	'.git' '../.git'
+
+test_repo_info_path 'gitdir with explicit GIT_DIR' 'gitdir' \
+	'gitdir-env' '.git' '../.git' \
+	'GIT_DIR="../.git" && export GIT_DIR'
+
 test_done
-- 
2.54.0

