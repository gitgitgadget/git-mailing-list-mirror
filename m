Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C0418C2C
	for <git@vger.kernel.org>; Sun, 26 Jul 2026 10:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785062910; cv=none; b=ulhEsR2VBzQtv8uBQIb7hKcXiORPi+41lXjfaDuVOE42sun6M5HAdr7v3P3Nv5VKyEbzhw4Whl8Q3Pl809TCZN2noL3LqkPQ1VHfuGYxujuRfZy9vL4LArMkpMEghA+3qrcjdgqOmbjz7VD0AOJOQBNC9TclfTkI0mU/XWbxh6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785062910; c=relaxed/simple;
	bh=N1J8fhnnobw2zYWE2ERZKiZOHvtzzjtmXcS7sNKj5dU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oDAnwdoH3Atr2k4yW/z9h+ac+HYHHsrrQRkvynW3M344FbOzveAZX/kwgv09LZISu40JFuqFJ4X9B8nX2c1xjQSkTBTHvdRBSqbYVJjKJzNekmB/WGdUmk5JwL519Klai9iLig/jUDTicO4RCCaIM+GWTVJf9cz/lErru6w9XIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AS6peIg8; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AS6peIg8"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-38101f85591so2533585a91.1
        for <git@vger.kernel.org>; Sun, 26 Jul 2026 03:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785062908; x=1785667708; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EqaWQI7SjFPllIahUhiqNZuMRihHLMpMt5LsOHOxUxs=;
        b=AS6peIg8d9G9mPBImbVP9HLiIDpMFiPgrjRXyAvFGavSF3mUIXG4j6Y2jzk6mft/7V
         jml/Ma/AagkYYT3sF+ZubzRVqR9Di3CjEP/EB4HkHOwrhboIgJuenoEySHwkWXwNBtcc
         Qz1jdU3SwMu4kMQpb7iQQZEvlqqQEBO4HG1cNpPk7MJE3m4Kpqh7e+qX6pDL1N0jTgbq
         l8OoOoFwf7dhfvUC1sVsRpiAGarQ3PU9KSMol8/Rah/VRC9Kcg42B/DNLISV+Q3wEFqv
         JFK+yLwxWx+3YKDcStdYRfGmyhZgJ1Vpv6111WQEgcHmq1yJfofflb1abGB6RQ62e44a
         03HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785062908; x=1785667708;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EqaWQI7SjFPllIahUhiqNZuMRihHLMpMt5LsOHOxUxs=;
        b=kAyZX9wRDhkBjfF6on4xl67mn9Jemy/HRIy0I8VprK8JjMBuz7Zd6nI93FdBLvdeAi
         VjDySg8R5V2wEKrR3iXNyf82tMow/qWb+8sdQndsxBaGdEaT66J0J6BDykMLUJCEdYan
         axECAZmcTlvq5fIvbvTf8FyjOAUn6D2mt/lg4z5AGSDiFypc8Hv0BVHzV7GwLL/8sCyw
         nLXs1yymWPBO6VqbDIaf308do/iEpDElrdPZPBvSEziga09gdRGCSpR68xJTdO9vTi3x
         9AId/XlCvCLD3LKxG2UcKebeSiyxIDXqQWo238sDN3DeXgdM5WsaLVZ3uDAlR4U3iDOs
         aU8A==
X-Gm-Message-State: AOJu0YweKT3o0iqnJD1A1QDLnA36qAjCPYQ71exNKbOlrDivMdg/wRUT
	cNK6Olz1MdIFHmjU/J899hlGQZYgIVHJzj0jGJaRbsWoFhf1wiTZCQUSXYduzQ==
X-Gm-Gg: AR+sD10QlACMFzWXdLRGBPwzK3VlK3fM+bxTZFHRLP/FKQ7YjlE1yt1RCIvM+OWt7fe
	VwIf/ZMfr5VK1OtO+eysyOFmyPf3DkMP1flPiXzcsPEM3CnBgHxreFJCvUepV1c0CFkvXW4vgfh
	iKGuhiG7dqzaPZmOysMCZBjtkoorjNQa0Iycx514aUQ/B/SfFfnkv3QRfv+3Wn4WBSG/UesU7dc
	zWllZQM8mwQ6YCz2uR34ZZbBrxzMzSXL33HNRrh0sYmv1kBRvX5vDFLZV4LLvr4LfAW9Mb0Dmzm
	FCLQrjaufZBDLqhomO0SgpsVP14nNhMzHKxQu7g0feFG+5jYci3vmrYyu8y3/qB4BAswM1/tUPt
	tr3lLKz+fEz8iCVT9O4NTGcAxd3Egv1YRxofw1MRL2otG0fbc9FfS40j1aYv6nD4W/uGVzezIeP
	/bPrCNl0W0bdMTWsdJWdJrHG9HemPSd2tO5PvIjw3ogR9jMzadAOimSxbel0Tp6JRagU0jmexqI
	3lvtAJJaZ/W
X-Received: by 2002:a17:90b:3850:b0:380:8bb9:aba9 with SMTP id 98e67ed59e1d1-38f1ea62f76mr7270378a91.3.1785062908100;
        Sun, 26 Jul 2026 03:48:28 -0700 (PDT)
Received: from jayatheerth ([2405:201:c005:b959:7d42:d207:de10:1218])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc3e1255sm30371438eec.4.2026.07.26.03.48.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 03:48:27 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: jayatheerthkulkarni2005@gmail.com
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	jltobler@gmail.com,
	lucasseikioshiro@gmail.com
Subject: [PATCH v3 6/7] repo: add path.grafts with absolute and relative suffix formatting
Date: Sun, 26 Jul 2026 16:13:42 +0530
Message-ID: <20260726104343.16933-7-jayatheerthkulkarni2005@gmail.com>
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
 Documentation/git-repo.adoc | 10 ++++++++++
 builtin/repo.c              | 24 ++++++++++++++++++++++++
 t/t1900-repo-info.sh        |  6 ++++++
 3 files changed, 40 insertions(+)

diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
index 34c4f7d61c..def888da91 100644
--- a/Documentation/git-repo.adoc
+++ b/Documentation/git-repo.adoc
@@ -119,6 +119,16 @@ values that they return:
 `path.gitdir.relative`::
 	The path to the Git repository directory relative to the current working directory.
 
+`path.grafts.absolute`::
+	The canonical absolute path to the repository grafts file.
+	Respects the `GIT_GRAFT_FILE` environment override. The path is returned
+	regardless of whether the file currently exists on disk.
+
+`path.grafts.relative`::
+	The path to the repository grafts file relative to the current working
+	directory. Respects the `GIT_GRAFT_FILE` environment override. The path
+	is returned regardless of whether the file currently exists on disk.
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
index dee1db2a49..15a4ec9b78 100755
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

