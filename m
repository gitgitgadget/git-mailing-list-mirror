Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B41B19D8AC
	for <git@vger.kernel.org>; Fri,  5 Jun 2026 16:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780677123; cv=none; b=fREkDOIiBX3xxum3FjpwcF0V9KSAC0B2zbRXciBHBxIhxmZL/jMZeiAhMdu1nAqMEAf7A5CPkaZwtUNm/hTwp+ccIt2ql6NF9LxJ9Yqy5TyL45e/aeilGTnjVoCcJabkRLSn5w2+6UHSYD0MBOcm+s+NV2/KkkUFkYfIJh8AMhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780677123; c=relaxed/simple;
	bh=BKlvIiOLRnxv9hiCTCQJBq4CaKanEIxfbIEWBsYz1a8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CRxG2k9jRn+bpJlQN0vk2BOod/bmsv+BaEWBsY7ZFiMw6LD3nZOYvRxwaqo3G/RTwKmQP2qNyd+wvX6Ww1H29Nv7LKtyrpnGDN+NAoGXkh3SX/2pMuYYwDbWH23uEfslzgAwZgQG4f9BJf7wqEhTlJg0IzamXAOmW5Zs5vhAm8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FHBEjtbE; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FHBEjtbE"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2c0c379e8ffso15128545ad.3
        for <git@vger.kernel.org>; Fri, 05 Jun 2026 09:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780677117; x=1781281917; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YNA56HGMlhqRIPUmbXn1SGiNPG1cAvPLBknNqSt5i8E=;
        b=FHBEjtbEUJXSqUfg8xA2aO5/ETjjbH6IEJAQdsq2uD15//1nj7TFnLAaUz9PcbJ1BM
         Vs3hr55ytMgQ2KLQZfnqS+9DLQoOttgr/Wp0+ucAg2O7Ltm0XHN8tS1l66+rW28tXand
         +w6R0iIUri8VhaDgpT3qh3mqVTD3FU92W3+XhtcWDInKV/8jF1CRlpivqk4/eodDD7J1
         MjUsLFvKZZsnoyhrxnJyKI8r637WMECG24tCrJ/ivnos0qMFH7kxoscm9HCJUCVCpeeG
         TsQHx1vvBWRFONSywe3dzKPor7LqYNITS1sClHHu2qPezaniPwuk8fh9To6GRNvDx30h
         r0+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780677117; x=1781281917;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YNA56HGMlhqRIPUmbXn1SGiNPG1cAvPLBknNqSt5i8E=;
        b=mQBuDvAAjZ3PF2iE5YGZUFh9U0KjkDAl2e9IBLxeFLrzOW0K2aiwr2ksyH8eGzGU0D
         n2kdRBWuGwc7G7l/wr6GDxcNndNN32pSrSwNLtRM1t3lDuv0td17WGpqS0akZZBhWChX
         hPqAo2h2GiDF7s+hoGRiTL+bORwuwmdbK4iOTRgDNBeHRqQrP2TIG/CEQYNL1YItC4Kl
         1ia7jvth5eg0PoRKhoM4SFRUduiTLUklh0jrpGHTpqhPDqBiARwYB9OJdMvTW+zsDCpy
         uxxPesNrJIAahJkDtSIiuMhSWc8AcsVEpRaICoqXO3AowvUOeHbWmEX1TqHiMs7pyaYS
         S8tw==
X-Gm-Message-State: AOJu0YzUwXBsWW6VIOXgq8lb7jrpwpv6AmSKscNnF+ikJzgMhlj5sN9C
	PX3FUSdcNJEf6HOyrJfQqUbJjVlPU6RGep1bX88N2uNDZLix7JJVW9FtGSogyg==
X-Gm-Gg: Acq92OG6TLcPVMLvnhSsyLu7jpNRM7vpJClN8nZsz+yMtbTMNVStV7J1oAkE1TTb6ji
	pUjgcI2JIDeOew4ZCkRKmx+7UAcy6H0Zj9IjCy75CP+TQEBaKvCnzzdb8VdNzSoX9U+eaohFTfX
	WIniwMSmkl3f5Beo/otKcr+5ldH/kk3jMu/1w+58yQS2NfzdnHutRLSnFYiTqRCbo33JFXHVXhK
	pD5vjvrWrLdq3FlZkzWo1OgiAp01rTHb+rcSfEVAJ3cCrvobdd+XAwp2CWALlcfaBhVCW7uxEpo
	wOVHnfcydvNewyRwT302Rn4bCYi8aaw21wVl+u3KiUS2P/NF8faBrZjj1bjOPvogjc9ozQts2Vi
	nPDjPuOOk9grJDLAeD9qsQOAT+Yf4N4V+bHOswsfxfbrFjMY1AeGPwDVMv6YDdQbmP0+P4BboeW
	CQ42P+EBtaGvjx7jZEvSu4ccYBowpYa/I69n86efF/ay+xrYYadvem6RPtglOlguPINXtxnNPM0
	nptnSHZKoaawQltB3ZAiEopMISF2NW/w7YKIL7kNYF9ygHyly5Ls9U=
X-Received: by 2002:a17:903:f8b:b0:2b2:5503:1b8c with SMTP id d9443c01a7336-2c1e7b048f5mr52495895ad.11.1780677117370;
        Fri, 05 Jun 2026 09:31:57 -0700 (PDT)
Received: from jayatheerth ([2405:201:c005:b959:7d42:d207:de10:1218])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f85de1sm95883955ad.20.2026.06.05.09.31.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 09:31:56 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: git@vger.kernel.org
Cc: jayatheerthkulkarni2005@gmail.com,
	a3205153416@gmail.com,
	gitster@pobox.com,
	jltobler@gmail.com,
	kumarayushjha123@gmail.com,
	lucasseikioshiro@gmail.com,
	phillip.wood@dunelm.org.uk,
	sandals@crustytoothpaste.net
Subject: [GSoC PATCH v2 4/4] repo: add path.commondir with absolute and relative suffix formatting
Date: Fri,  5 Jun 2026 22:00:12 +0530
Message-ID: <20260605163012.181089-5-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260605163012.181089-1-jayatheerthkulkarni2005@gmail.com>
References: <20260601151950.30686-1-jayatheerthkulkarni2005@gmail.com>
 <20260605163012.181089-1-jayatheerthkulkarni2005@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In standard Git repositories, the Git directory and the common directory
are identical. However, in environments utilizing multiple worktrees, the
local working state ($GIT_DIR) is separated from the shared central data
($GIT_COMMON_DIR). Scripts require a reliable way to discover this shared
path.

Introduce `path.commondir.absolute` and `path.commondir.relative` keys
to `git repo info`. Similar to the `path.gitdir` keys, exposing explicit
format variants removes the ambiguity of default fallbacks. Both keys are
evaluated via the `format_path()` engine.

Insert the new keys into the `repo_info_field` array in lexicographical
order to maintain the integrity of binary search lookups.

Utilize the parameterized `test_repo_info_path` helper to validate the
worktree edge cases. This ensures that path resolution correctly respects
$GIT_COMMON_DIR when defined and safely falls back to $GIT_DIR otherwise.

Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Mentored-by: Justin Tobler <jltobler@gmail.com>
Mentored-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
---
 Documentation/git-repo.adoc |  9 +++++++++
 builtin/repo.c              | 24 ++++++++++++++++++++++++
 t/t1900-repo-info.sh        |  7 +++++++
 3 files changed, 40 insertions(+)

diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
index a0dca7ce88..ed7d80c690 100644
--- a/Documentation/git-repo.adoc
+++ b/Documentation/git-repo.adoc
@@ -104,6 +104,15 @@ values that they return:
 `object.format`::
 	The object format (hash algorithm) used in the repository.
 
+`path.commondir.absolute`::
+	The canonical absolute path to the Git repository's common
+	directory (the shared `.git` directory containing objects,
+	refs, and global configuration).
+
+`path.commondir.relative`::
+	The path to the Git repository's common directory relative to
+	the current working directory.
+
 `path.gitdir.absolute`::
 	The canonical absolute path to the Git repository directory (the `.git` directory).
 
diff --git a/builtin/repo.c b/builtin/repo.c
index 6e97f6a0e4..27c8caff38 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -77,6 +77,28 @@ static int get_object_format(struct repository *repo, struct strbuf *buf)
 	return 0;
 }
 
+static int get_path_commondir_absolute(struct repository *repo, struct strbuf *buf)
+{
+	const char *common_dir = repo_get_common_dir(repo);
+
+	if (!common_dir)
+		return error(_("unable to get common directory"));
+
+	format_path(buf, common_dir, startup_info->prefix, PATH_FORMAT_CANONICAL);
+	return 0;
+}
+
+static int get_path_commondir_relative(struct repository *repo, struct strbuf *buf)
+{
+	const char *common_dir = repo_get_common_dir(repo);
+
+	if (!common_dir)
+		return error(_("unable to get common directory"));
+
+	format_path(buf, common_dir, startup_info->prefix, PATH_FORMAT_RELATIVE);
+	return 0;
+}
+
 static int get_path_gitdir_absolute(struct repository *repo, struct strbuf *buf)
 {
 	const char *git_dir = repo_get_git_dir(repo);
@@ -111,6 +133,8 @@ static const struct repo_info_field repo_info_field[] = {
 	{ "layout.bare", get_layout_bare },
 	{ "layout.shallow", get_layout_shallow },
 	{ "object.format", get_object_format },
+	{ "path.commondir.absolute", get_path_commondir_absolute },
+	{ "path.commondir.relative", get_path_commondir_relative },
 	{ "path.gitdir.absolute", get_path_gitdir_absolute },
 	{ "path.gitdir.relative", get_path_gitdir_relative },
 	{ "references.format", get_references_format },
diff --git a/t/t1900-repo-info.sh b/t/t1900-repo-info.sh
index 0660b00bbc..21755d9d14 100755
--- a/t/t1900-repo-info.sh
+++ b/t/t1900-repo-info.sh
@@ -186,6 +186,13 @@ test_expect_success 'setup test repository layout for path fields' '
 	mkdir -p test-repo/sub
 '
 
+test_expect_success 'setup custom-common for commondir tests' '
+	git init --bare test-repo/custom-common
+'
+
+test_repo_info_path 'commondir' 'echo "$(cd .. && pwd)/.git"' '../.git'
+test_repo_info_path 'commondir' 'echo "$(cd .. && pwd)/custom-common"' '../custom-common' 'GIT_COMMON_DIR="$(cd .. && pwd)/custom-common" GIT_DIR=../.git'
+test_repo_info_path 'commondir' 'echo "$(cd .. && pwd)/.git"' '../.git' 'GIT_DIR=../.git'
 test_repo_info_path 'gitdir' 'echo "$(cd .. && pwd)/.git"' '../.git'
 
 test_done
-- 
2.54.0

