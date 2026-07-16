Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7AB91A6824
	for <git@vger.kernel.org>; Thu, 16 Jul 2026 01:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784165150; cv=none; b=gP+P58/uMmWzxT9P+qvmW0el+jtN9lLeniPxtijtAqpkTp5bAqHwWWwJKRg3cNMCuXVS0ANp7q+MEDthqthFov8nhvGrSwCUyEMEEMdhd0oOiIE1P8fREjypNydd/8P57jF3rZ19tVXn4PvTxieqde6ZxNcAQS1L4JWAyxVF87c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784165150; c=relaxed/simple;
	bh=g1touH7pr+Nytc2Bjf2N5BakiFK79JoZs4PzRtlZgmI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SYi1wNW75oQsi17XsA6a9BwAegtpy8oWb+TE4BanIw/nZF81c1TXYPWxSFLGQjJN3e7wg+1pobIzIL9RUgPelnQios4JhQkKK9qhCVQOw9NEazH4aJz0tnO8y+/6pi5W37z4J4aHOho1NCblJF5xxZrgAGNZlf3a8ysdBsWDMQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n2q6m1Qm; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n2q6m1Qm"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-381b831d535so3156218a91.0
        for <git@vger.kernel.org>; Wed, 15 Jul 2026 18:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784165148; x=1784769948; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=O9vgetOkdCTp5BrK5JdaOW3/QZo8zlfdTsb99bRwe6I=;
        b=n2q6m1QmsQtbqldRL0b/4Ghmj/Q4L9chlhS3l4qZjaotqqdcvV609YTDKldh6lJ/SW
         /obYG1m0tjrtRDIbct+8L74PFL62Bt+Vu5ZkzDXLURgDfJgxAAjUL0BKyo44fRWs1LCU
         efSiypVxSMa7bDaXNB9R+u4AnXSjnhDl99AZ5j/1/5x1erpSC+B5C/qw/szECN0ni4du
         s9k5nMqJpC5gUb36XGLcuqdEBppeLOBpkbTHrqDrBkI/HsZZ7zUlgNjjoVDbffzHBJ72
         FysPPvKl+SQizwv9trOX128d8IA+6Y5QSUANm8xHkL904JRttIatRmrBqUfBteCmJv01
         tG7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784165148; x=1784769948;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=O9vgetOkdCTp5BrK5JdaOW3/QZo8zlfdTsb99bRwe6I=;
        b=KG9RqVL+B0si/4zrmRT6159+8e7rTds7Cgk1MvnD8zD/O3fdSvoU2EUvODY1IlPrnD
         a/NKJS1n0OtSa/jF3bV5XIfeBhi9oyZ0CqBf6ngK15f+9n1QTdOV7QNkqUHGRiWCsoO6
         wY1TxpQwYBDT1J8JwfBnAFWOIqNCz31Ek8IujiZosurkGx3Tuq39o29dVdU0YfkWWXUJ
         GhoBfIcPoUCTsU2ztlu1l2inLrS2hsiKv9PXz4jJn1sln6kI+jF8EUk/QN1+L9WznmGw
         utBkkZdcpiZ87qT2g8giPE4L1/3EkLZA4SIC4LLpr+iyqQOPkXbHT6xgoZoTzRbEE+b5
         Mnfw==
X-Gm-Message-State: AOJu0YzUuH91ZcC5HEml/Jb30ZYldN3pbSSbP/VMzOuaKCehfFmORxg2
	AJzg7TUUxvL1ByjryUgJEEDbekU7sULCUvJgUEmSAXZxfz9Il2jZL487luvgBw==
X-Gm-Gg: AfdE7ckvaTZOVAN0TaqOqLYmFScWETz/N8ZJCM9vJ+XVqkdw8q8uF2G2MzeP0GEgUqL
	XdfzWRmukyQ9SAXH1vxjYg/3KSq1QCJsdd9uDUC5AkD3tDg134aGyoS7yj3Vc8zUMAxm2gU4kjA
	YHh3jk/aU6JslfcpxX6nR76U76su8Eb5vFoonSI8vNduA2DdJMUadGu6cRfSTvAM/hr+ssXgSAI
	d51VuIvfw3+iQPEvqsO3ooQrC5iqJGwo4XSAzuh9AbdNAE1+0i8Vz1y/U/lL0Q4X0L44NyGrVF3
	/1nP3Qr/1X4aPtWu5iaSOP25fkHA4+5jn+HZSOO4vrCruh1xX/soti7Pe1cOkkrozWXXwbSc0dD
	CyBtsLO/A5v4O+hiWxIal6t3ARdvU7BAsIWcq6pschnKQEKKo3ENiLfPrNNQdX7i1C3fOBYaEyC
	bKotj+FGvialfBAVpgfoe0mC3QRYEYt+3FFlOK+baBil9R80FPelzjZ6y+d/f3R/gg2rPGHpj7v
	v/e0mkcA4Tb6tX2YZv75lGI8CK4gEXXHQ==
X-Received: by 2002:a17:90b:3b50:b0:38d:f096:a1dc with SMTP id 98e67ed59e1d1-38df096a242mr12515963a91.11.1784165148051;
        Wed, 15 Jul 2026 18:25:48 -0700 (PDT)
Received: from jayatheerth ([2405:201:c005:b959:7d42:d207:de10:1218])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3140e6e9edfsm5377490eec.28.2026.07.15.18.25.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 18:25:46 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: git@vger.kernel.org
Cc: jltobler@gmail.com,
	lucasseikioshiro@gmail.com,
	K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Subject: [GSoC Patch 6/7] repo: add path.grafts with absolute and relative suffix formatting
Date: Thu, 16 Jul 2026 06:51:37 +0530
Message-ID: <20260716012138.6714-7-jayatheerthkulkarni2005@gmail.com>
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

External toolchains managing specialized history rewrites or legacy
history splices require access to the location of the repository grafts
file. Currently, this requires a legacy call to `git rev-parse --git-path info/grafts`.

Introduce `path.grafts.absolute` and `path.grafts.relative` keys to
`git repo info`. This allows scripting layers to query the active grafts
context cleanly while scaling transparently with active `GIT_GRAFT_FILE`
environment variable overrides.

Mentored-by: Justin Tobler <jltobler@gmail.com>
Mentored-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
---
 Documentation/git-repo.adoc |  8 ++++++++
 builtin/repo.c              | 24 ++++++++++++++++++++++++
 t/t1900-repo-info.sh        |  6 ++++++
 3 files changed, 38 insertions(+)

diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
index 3a837c573e..6c962620ec 100644
--- a/Documentation/git-repo.adoc
+++ b/Documentation/git-repo.adoc
@@ -119,6 +119,14 @@ values that they return:
 `path.gitdir.relative`::
 	The path to the Git repository directory relative to the current working directory.
 
+`path.grafts.absolute`::
+	The canonical absolute path to the repository grafts file.
+	Respects the `GIT_GRAFT_FILE` environment override.
+
+`path.grafts.relative`::
+	The path to the repository grafts file relative to the current working
+	directory. Respects the `GIT_GRAFT_FILE` environment override.
+
 `path.hooks.absolute`::
 	The canonical absolute path to the repository's hooks directory.
 	Respects `core.hooksPath` configuration adjustments.
diff --git a/builtin/repo.c b/builtin/repo.c
index 66bf4c67cc..a97ad71649 100644
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
+	format_path(buf, graft_file, startup_info->prefix, PATH_FORMAT_CANONICAL);
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
+	format_path(buf, graft_file, startup_info->prefix, PATH_FORMAT_RELATIVE);
+	return 0;
+}
+
 static int get_path_hooks_absolute(struct repository *repo, struct strbuf *buf)
 {
 	struct strbuf hooks_path = STRBUF_INIT;
@@ -258,6 +280,8 @@ static const struct repo_info_field repo_info_field[] = {
 	{ "path.commondir.relative", get_path_commondir_relative },
 	{ "path.gitdir.absolute", get_path_gitdir_absolute },
 	{ "path.gitdir.relative", get_path_gitdir_relative },
+	{ "path.grafts.absolute", get_path_grafts_absolute },
+	{ "path.grafts.relative", get_path_grafts_relative },
 	{ "path.hooks.absolute", get_path_hooks_absolute },
 	{ "path.hooks.relative", get_path_hooks_relative },
 	{ "path.index.absolute", get_path_index_absolute },
diff --git a/t/t1900-repo-info.sh b/t/t1900-repo-info.sh
index 04e6b8553c..6c47989df7 100755
--- a/t/t1900-repo-info.sh
+++ b/t/t1900-repo-info.sh
@@ -213,6 +213,12 @@ test_repo_info_path 'gitdir with explicit GIT_DIR' 'gitdir' \
 	'.git' \
 	'GIT_DIR="../.git" && export GIT_DIR'
 
+test_repo_info_path 'grafts standard' 'grafts' '.git/info/grafts'
+
+test_repo_info_path 'grafts with GIT_GRAFT_FILE override' 'grafts' \
+	'custom-graft-file' \
+	'GIT_GRAFT_FILE="$ROOT/custom-graft-file" && export GIT_GRAFT_FILE'
+
 test_repo_info_path 'hooks standard fallback' 'hooks' '.git/hooks'
 
 test_repo_info_path 'hooks with core.hooksPath override' 'hooks' \
-- 
2.55.GIT

