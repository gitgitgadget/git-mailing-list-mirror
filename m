Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E1F15A86B
	for <git@vger.kernel.org>; Sun, 15 Jun 2025 14:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749998818; cv=none; b=YtiqaLISLfZ96FHR94CnCQxbEiRYnPVGPcpl50q7E3R2wyQGYJvBdIetUh+oDvFwXtCv7pfyHrtopmnrKBc40mQ4pbmGHTGsRLGQ741GZIPeds62tDmpojKqPZBcGAGeLmPncROYMOpx5Dx4VriINirLPp5CdV+INXxAyGSatcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749998818; c=relaxed/simple;
	bh=y8D36BGAJya0Ad+TIODFPfSUFsesy3doShM6h7vWHvA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WjzSGdpq0vNa3l/RMa0ll93LhH0paR+ddNBNH/qDrW5RpNwefi8upczvsE8MxCo6FBEz8nGMXr+FplPprfqxMGYPGTCQNq11JunyEHduu8rNmC33AUHpUdBxQ3WZ/xSYZk9lCd6nQX1I/cEDuUMvbHnALnGQ7jciVynyPVYw35Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UIIIhrfw; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UIIIhrfw"
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-747fc7506d4so3124367b3a.0
        for <git@vger.kernel.org>; Sun, 15 Jun 2025 07:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749998816; x=1750603616; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WtHlFMNlGsnNwKiTn+Ke55XIt5o/wanHUX2+eVcON4o=;
        b=UIIIhrfwJjLKdMqRoEbBsHMqUBM3ukzm68BCtXMM4ymYLBPfUUv0v/DT6SNbrmvu2D
         ndZuOyjGN5QhFq2UG3tGkBIYSoKOfnpg3kSR/m/mQCVUaees55I666XIusS2DAj8XhlH
         v7zB404ZAGLmdt+wzXk6YGw8mmY6TuMp9KMxH5lyqwTQTfHMTeYlI8MocNo6VbT/fXst
         Jdq57k7EtPYW8TKvA01bp+rkEYStqk9waq9Wz6mcohRRmKJSOmto9S5c6gJebBZu/X6r
         3bbjQKr4eDm8DeQMujbGRt8OYtG+SozppoVO4wUQqb0pc9sQKjiS8Mbba4K3u0xeWPuE
         vUrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749998816; x=1750603616;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WtHlFMNlGsnNwKiTn+Ke55XIt5o/wanHUX2+eVcON4o=;
        b=CaAUQngNvS6qZyMAqiHvSU+gLMi4LJx5ZFP9ik2tm+J3qtxBBZ8L9sCQwK+mFYuGMj
         yTf2+3saPLyQtrkiziXlyN3xvITqNJMfVi8+VbHTHGFYkNI1LatV00GoAOeOvJ5J/cgu
         ZZWjAJ4uYS2dJ+K49pCfqgRv45nG54oHRPG5wj/H36Y0AO/X3a+615I+uQ/tfn2ruGJp
         kIddCYBYefFqNiHiTcmrgUdPvJcM9VXrSiaUm/99hKHXVSbtJn+mmoiGrgxWbnSZrSyp
         CPhXkNKAUerW2UT+jJ/8CSiyUlgVaiaaZg8djJwbRZqKrQb/nAICGYUW+jvHZczLv4jk
         Z1yg==
X-Gm-Message-State: AOJu0Yy5cAKu4PlStcDZpLpllR9NzMYwxaBZ8QrPKwQ8JyqyRuwAunjN
	J0BmXD8bkQRN6PHM4WGru71gIP1kY+e3+gE6QoYNijVdjaYHV+vu8W8qn/LVAN6T8n8JAEbu
X-Gm-Gg: ASbGncsbAz64F5WLd/dhh3SqXrMq32YhGhSsk1AzNA1u3XAJ6aTiBzAz/KPGOozJtis
	0PxDeiAwddYJm14A4Uk9KUAZvai1QpDUCUke4gyZi67PRyRjIloQjci8U9ck84lCjOpC+9MuZK8
	zKD2Ao+GvduTVm1PNYdymYbXVXeTjvGpmPoIf8YMVsiz0Lt3E5f3ACyK0XaibuxJbsXsV/7wRG5
	U9TCr0ebi59oQi9yxNr/qFK2nlGP5JzgwASmXxJoxemDfSRkaT5XRQ/p2u3zWM4U+gChtO5/+u5
	fQ7fuVEkKMCXMDqhC2RoyYH+jZ3CVlrWNaheWAT0HpMbbi+yxVfJatKjT6NeP/ldtIwI
X-Google-Smtp-Source: AGHT+IHZvA6WbEsIp9AHlL68w35cAuPZKIhGC0oycO5nNYBKP4r73zdBxNBOUi3HLrC8+BGgpftYpQ==
X-Received: by 2002:a05:6a00:3cc9:b0:740:596b:4a7f with SMTP id d2e1a72fcca58-7489d038c17mr9030246b3a.16.1749998815576;
        Sun, 15 Jun 2025 07:46:55 -0700 (PDT)
Received: from r760 ([188.253.126.211])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7488ffeca93sm4950180b3a.20.2025.06.15.07.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Jun 2025 07:46:55 -0700 (PDT)
From: Lidong Yan <yldhome2d2@gmail.com>
X-Google-Original-From: Lidong Yan <502024330056@smail.nju.edu.cn>
To: git@vger.kernel.org
Cc: Lidong Yan <502024330056@smail.nju.edu.cn>
Subject: [PATCH v3 2/2] setup: fix NEEDSWORK in setup_git_directory_gently()
Date: Sun, 15 Jun 2025 22:46:04 +0800
Message-ID: <20250615144604.1447302-3-502024330056@smail.nju.edu.cn>
X-Mailer: git-send-email 2.50.0-rc1
In-Reply-To: <20250615144604.1447302-1-502024330056@smail.nju.edu.cn>
References: <20250614050331.304405-1-502024330056@smail.nju.edu.cn>
 <20250615144604.1447302-1-502024330056@smail.nju.edu.cn>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In setup.c:setup_git_directory_gently(), the case that fail when dir->buf
is neither a file nor a directory is currently marked as NEEDSWORK. Add
two new READ_GITFILE_ERR types to handle this case more explicitly:

  * READ_GITFILE_ERR_NOT_A_FILE_OR_DIR:
    path exist, but path is neither a file nor directory
  * READ_GITFILE_ERR_IS_DIR:
    path exist, and it is a directory.

If dir->buf is neither a file nor a directory, then depending on
die_or_error, either read_gitfile_gently() will die, or this
function will return GIT_DIR_INVALID_GIT_FILE.

To make old use of READ_GITFILE_ERR_NOT_A_FILE still works,
Add READ_GITFILE_ERR_NOT_A_FILE(err) macro, which has the same
effect as `err == READ_GITFILE_ERR_NOT_A_FILE` in the origin code.

Also add die message for READ_GITFILE_ERR_NOT_A_FILE_OR_DIR in
read_gitfile_error_die().

Signed-off-by: Lidong Yan <502024330056@smail.nju.edu.cn>
---
 setup.c    | 11 +++++++----
 setup.h    | 18 +++++++++++-------
 worktree.c |  4 ++--
 3 files changed, 20 insertions(+), 13 deletions(-)

diff --git a/setup.c b/setup.c
index f93bd6a24a..b18c43d93b 100644
--- a/setup.c
+++ b/setup.c
@@ -893,9 +893,11 @@ void read_gitfile_error_die(int error_code, const char *path, const char *dir)
 {
 	switch (error_code) {
 	case READ_GITFILE_ERR_STAT_FAILED:
-	case READ_GITFILE_ERR_NOT_A_FILE:
+	case READ_GITFILE_ERR_IS_DIR:
 		/* non-fatal; follow return path */
 		break;
+	case READ_GITFILE_ERR_NOT_A_FILE_OR_DIR:
+		die(_("'%s' is not a file or directory"), path);
 	case READ_GITFILE_ERR_OPEN_FAILED:
 		die_errno(_("error opening '%s'"), path);
 	case READ_GITFILE_ERR_TOO_LARGE:
@@ -941,7 +943,9 @@ const char *read_gitfile_gently(const char *path, int *return_error_code)
 		goto cleanup_return;
 	}
 	if (!S_ISREG(st.st_mode)) {
-		error_code = READ_GITFILE_ERR_NOT_A_FILE;
+		error_code = S_ISDIR(st.st_mode) ?
+				     READ_GITFILE_ERR_IS_DIR :
+				     READ_GITFILE_ERR_NOT_A_FILE_OR_DIR;
 		goto cleanup_return;
 	}
 	if (st.st_size > max_file_size) {
@@ -1499,8 +1503,7 @@ static enum discovery_result setup_git_directory_gently_1(struct strbuf *dir,
 						NULL : &error_code);
 		if (!gitdirenv) {
 			if (die_on_error ||
-			    error_code == READ_GITFILE_ERR_NOT_A_FILE) {
-				/* NEEDSWORK: fail if .git is not file nor dir */
+			    error_code == READ_GITFILE_ERR_IS_DIR) {
 				if (is_git_directory(dir->buf)) {
 					gitdirenv = DEFAULT_GIT_DIR_ENVIRONMENT;
 					gitdir_path = xstrdup(dir->buf);
diff --git a/setup.h b/setup.h
index 18dc3b7368..7f246ad248 100644
--- a/setup.h
+++ b/setup.h
@@ -29,13 +29,17 @@ int is_git_directory(const char *path);
 int is_nonbare_repository_dir(struct strbuf *path);
 
 #define READ_GITFILE_ERR_STAT_FAILED 1
-#define READ_GITFILE_ERR_NOT_A_FILE 2
-#define READ_GITFILE_ERR_OPEN_FAILED 3
-#define READ_GITFILE_ERR_READ_FAILED 4
-#define READ_GITFILE_ERR_INVALID_FORMAT 5
-#define READ_GITFILE_ERR_NO_PATH 6
-#define READ_GITFILE_ERR_NOT_A_REPO 7
-#define READ_GITFILE_ERR_TOO_LARGE 8
+#define READ_GITFILE_ERR_IS_DIR		   2
+#define READ_GITFILE_ERR_NOT_A_FILE_OR_DIR 3
+#define READ_GITFILE_ERR_OPEN_FAILED	   4
+#define READ_GITFILE_ERR_READ_FAILED	   5
+#define READ_GITFILE_ERR_INVALID_FORMAT	   6
+#define READ_GITFILE_ERR_NO_PATH	   7
+#define READ_GITFILE_ERR_NOT_A_REPO	   8
+#define READ_GITFILE_ERR_TOO_LARGE	   9
+#define READ_GITFILE_ERR_NOT_A_FILE(x)                \
+	((x) == READ_GITFILE_ERR_NOT_A_FILE_OR_DIR || \
+	 (x) == READ_GITFILE_ERR_IS_DIR)
 void read_gitfile_error_die(int error_code, const char *path, const char *dir);
 const char *read_gitfile_gently(const char *path, int *return_error_code);
 #define read_gitfile(path) read_gitfile_gently((path), NULL)
diff --git a/worktree.c b/worktree.c
index c34b9eb74e..3f0e9748ec 100644
--- a/worktree.c
+++ b/worktree.c
@@ -646,7 +646,7 @@ static void repair_gitfile(struct worktree *wt,
 		}
 	}
 
-	if (err == READ_GITFILE_ERR_NOT_A_FILE)
+	if (READ_GITFILE_ERR_NOT_A_FILE(err))
 		fn(1, wt->path, _(".git is not a file"), cb_data);
 	else if (err)
 		repair = _(".git file broken");
@@ -826,7 +826,7 @@ void repair_worktree_at_path(const char *path,
 			strbuf_addstr(&backlink, dotgit_contents);
 			strbuf_realpath_forgiving(&backlink, backlink.buf, 0);
 		}
-	} else if (err == READ_GITFILE_ERR_NOT_A_FILE) {
+	} else if (READ_GITFILE_ERR_NOT_A_FILE(err)) {
 		fn(1, dotgit.buf, _("unable to locate repository; .git is not a file"), cb_data);
 		goto done;
 	} else if (err == READ_GITFILE_ERR_NOT_A_REPO) {
-- 
2.50.0-rc1

