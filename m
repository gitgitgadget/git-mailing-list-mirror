Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F3E2FCBE5
	for <git@vger.kernel.org>; Sat, 14 Feb 2026 04:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771044786; cv=none; b=DHa1qLgFHBYJj4zUOgpi1YiWDpg0NvLIa7m25879SaYBuK7IMb3j4OjH7JAJaihsJqPRwCro7A3WG80Jq5087IXEIAUHTLn0wS4LlSQiDjTkUM09gYTDJlzqG+fDI0bSQKcg9+9o62YchwIAeYboO0477AI3URgrrfWt3O7Mtcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771044786; c=relaxed/simple;
	bh=77EVQddo69Nju9cb0znVF936tqm8xhbI/ezYQbG/tOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iWMUy5UCRwQoJ6rVWOxZCLQfoKdKtoSyonYWndCSM4daxolPOjTw5ptSxJsz6n2llb/CAjmfu7kLFiu9PukETBL1vbjPmVhzgdtX3LQplocbjngt418emJNZ8HGBwI+degY5GijGQNxmVH1lza0a0FgIrSStmJ0Ua2jXWCR4sSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JPyqdrae; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JPyqdrae"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c1b5b65f832so157895a12.3
        for <git@vger.kernel.org>; Fri, 13 Feb 2026 20:53:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771044782; x=1771649582; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1LhQdu3AhsfsEYvzvrlnnzsvMb6x3wUVBisAuCCMtdw=;
        b=JPyqdraeH4jelSiJxRYLHbobaRK92QEnF2cHVIPqgC83U1RM9h+xOFy4Bibr7GaZPB
         HqCy7wBD04CtWBaxGPn6wftCWD0n2grOQ98S7NrwvtsO9oTmkXL+TH3D4cGxblfOUq4+
         u3beQzrzTDpn85dOiukWBpWckTAJyydFEq+sS+XeWVnegOVdydb8mppJo6SByds0lufm
         8pbCvqyC+8KTluswT4z+YiiBDr31vhuVnor+Iy6IcAMPLp1BOB9WnM/IUSaqwgffBcMr
         2sUw54TzKTlRiXPWS8g0wdJHx8XaVlNEO2P6glURTBoO/BkfDuUPm/wt5iNQNZusWplz
         63Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771044782; x=1771649582;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1LhQdu3AhsfsEYvzvrlnnzsvMb6x3wUVBisAuCCMtdw=;
        b=qdJUkPzGtqwXsBt0TkvL2sPgLd+mPdTN4hkWZeQThVjGV79Nn2FxuwlxWahGAVxeKq
         P+mlVl4QsK3AnfCj23W7EoRJ3zTNdJ9lWPZM/1ZAIQLWCY4z/ieGmDvz4urQzWrLAClj
         8rOL1mVJmuWbqkbPqJYB3dqF79tio0WmpuWYXxftWoPJTfTAFfQTtPaFM68btpNkYCKM
         1uyMvSk4CPFMYX1LpF614pN8Tb2/UchjoQXor+aKnx/FIeTSMij5NVPrPO5ngxlVF1vs
         WyRkI/a5099vpAyqao8QkiIPVj5k3s1exY5sPXjSjnRj5gEnWZ21Jfdc/TbvQS0zw/tF
         hqcw==
X-Gm-Message-State: AOJu0YwN/4ipf/BkGnMY93Wo70B9kFEkSHZOk12UjSM0aCqeN/CXwd/g
	nXyYeVshsaJIciEq21cVajxf5O0jAU6CXpWDQbIdAXDIQLr6gRfQol/RhXWE3hsS
X-Gm-Gg: AZuq6aIiD3WvyVQbLlMzSx+FNAgoK+nwv2WA6yCm8WpOj0MXbENDuVZQY+rcGusacEK
	Jw80xLB11916v0frdMaAiGzipSUPEsTGB/cXANDAayz9qcLdhc+Yd8ZJ2Wzuk/Smcn9TBxWq6/P
	4z5xbYnAXF3CJK027sDtuY7VU47yCJpmpzjfkHajAwTR6fDIUj7nh+i/or0OWd6phfuB1XkP2r2
	Hkcp+AjqFoAgzOUme2pjUKhKbL+IbriFN/lpMSPA7tD/gaLPX4WDniW2jYNlG/ZtlRWK5CeXkm0
	NXc8XkxoyQDjdgF5zz7LEq5OSZWicUs6twwq4f1SiCZQqRz3WyiCIDlXUqU1AqsLGiLMOCPXaJ6
	Ad23pMaXUSMRQlV58TmSJ/IybO2QJnObujdQvF1ulPug7WV6qkd4BcQXZVvTBIIxDwbZqav77/1
	MU/pBLp2MXdhCKFj7E6dOdgXp4q10qskRiRUZb0rw=
X-Received: by 2002:a17:90b:4cc8:b0:34f:4416:33b5 with SMTP id 98e67ed59e1d1-356a7b0d470mr3316829a91.8.1771044782426;
        Fri, 13 Feb 2026 20:53:02 -0800 (PST)
Received: from malon-Yoga-14sARE-2020.. ([155.69.180.3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3567e9fb4bfsm9712463a91.8.2026.02.13.20.53.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 20:53:01 -0800 (PST)
From: Tian Yuchen <a3205153416@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	sandals@crustytoothpaste.net
Subject: [PATCH v3] setup: fail if .git is not a file or directory
Date: Sat, 14 Feb 2026 12:52:47 +0800
Message-ID: <20260214045247.118013-1-a3205153416@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260212172405.48614-1-a3205153416@gmail.com>
References: <20260212172405.48614-1-a3205153416@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, `setup_git_directory_gently_1()` checks if `.git` is a
regular file (handling submodules/worktrees) or a directory. If it is
neither (e.g., a FIFO), the code hits a NEEDSWORK comment and simply
ignores the entity, continuing the discovery process in the parent
directory.

Failing instead of ignoring here makes it easier for the users to notice
anomalies and take action, particularly if this non-file non-directory
entity was created by mistake or by file system corruption.

However, strictly enforcing 'lstat()' and 'S_ISREG()' breaks valid
workflows where '.git' is a symlink pointing to a real git directory
(e.g. created via 'ln -s'). To ensure safety and correctness:

1. Differentiate between "missing file" and "is a directory". This
   removes the long standing NEEDSWORK comment in 'read_gitfile_gently()'.

2. Explicitly check 'st_mode' after 'stat()'. If the path resolves to a
   directory, return 'READ_GITFILE_ERR_IS_A_DIR' so the caller can try
   to handle it as a directory.

3. If the path exists but is neither a regular file nor a directory,
   return 'READ_GITFILE_ERR_NOT_A_FILE'.

Update 'setup_git_directory_gently_1()' to aborts setup immeditaely upon
encountering a malicous '.git' file.

Signed-off-by: Tian Yuchen <a3205153416@gmail.com>
---

I have verified this with a test script covering:
1. Normal .git file
2. .git as a symlink to a directory
3. .git as a FIFO
4. .git as a symlink to a FIFO
5. .git with garbage content

 setup.c | 39 +++++++++++++++++++++++++++++----------
 setup.h |  3 +++
 2 files changed, 32 insertions(+), 10 deletions(-)

diff --git a/setup.c b/setup.c
index 3a6a048620..8681a8a9d1 100644
--- a/setup.c
+++ b/setup.c
@@ -911,6 +911,10 @@ void read_gitfile_error_die(int error_code, const char *path, const char *dir)
 		die(_("no path in gitfile: %s"), path);
 	case READ_GITFILE_ERR_NOT_A_REPO:
 		die(_("not a git repository: %s"), dir);
+	case READ_GITFILE_ERR_STAT_ENOENT:
+		die(_("Not a git repository: %s"), path);
+	case READ_GITFILE_ERR_IS_A_DIR:
+		die(_("Not a git file (is a directory): %s"), path);
 	default:
 		BUG("unknown error code");
 	}
@@ -939,8 +943,14 @@ const char *read_gitfile_gently(const char *path, int *return_error_code)
 	static struct strbuf realpath = STRBUF_INIT;
 
 	if (stat(path, &st)) {
-		/* NEEDSWORK: discern between ENOENT vs other errors */
-		error_code = READ_GITFILE_ERR_STAT_FAILED;
+		if (errno == ENOENT)
+			error_code = READ_GITFILE_ERR_STAT_ENOENT;
+		else
+			error_code = READ_GITFILE_ERR_STAT_FAILED;
+		goto cleanup_return;
+	}
+	if (S_ISDIR(st.st_mode)) {
+		error_code = READ_GITFILE_ERR_IS_A_DIR;
 		goto cleanup_return;
 	}
 	if (!S_ISREG(st.st_mode)) {
@@ -994,7 +1004,9 @@ const char *read_gitfile_gently(const char *path, int *return_error_code)
 cleanup_return:
 	if (return_error_code)
 		*return_error_code = error_code;
-	else if (error_code)
+	else if (error_code &&
+		error_code != READ_GITFILE_ERR_STAT_ENOENT &&
+		error_code != READ_GITFILE_ERR_IS_A_DIR)
 		read_gitfile_error_die(error_code, path, dir);
 
 	free(buf);
@@ -1576,18 +1588,25 @@ static enum discovery_result setup_git_directory_gently_1(struct strbuf *dir,
 		if (offset > min_offset)
 			strbuf_addch(dir, '/');
 		strbuf_addstr(dir, DEFAULT_GIT_DIR_ENVIRONMENT);
-		gitdirenv = read_gitfile_gently(dir->buf, die_on_error ?
-						NULL : &error_code);
+		gitdirenv = read_gitfile_gently(dir->buf, &error_code);
 		if (!gitdirenv) {
-			if (die_on_error ||
-			    error_code == READ_GITFILE_ERR_NOT_A_FILE) {
-				/* NEEDSWORK: fail if .git is not file nor dir */
+			if (error_code == READ_GITFILE_ERR_STAT_ENOENT ||
+				error_code == READ_GITFILE_ERR_IS_A_DIR) {
 				if (is_git_directory(dir->buf)) {
 					gitdirenv = DEFAULT_GIT_DIR_ENVIRONMENT;
 					gitdir_path = xstrdup(dir->buf);
 				}
-			} else if (error_code != READ_GITFILE_ERR_STAT_FAILED)
-				return GIT_DIR_INVALID_GITFILE;
+			} else if (error_code == READ_GITFILE_ERR_NOT_A_FILE) {
+				if (die_on_error)
+					die(_("Invalid %s: not a regular file or directory"), dir->buf);
+				else
+					return GIT_DIR_INVALID_GITFILE;
+			} else if (error_code != READ_GITFILE_ERR_STAT_FAILED) {
+				if (die_on_error)
+					read_gitfile_error_die(error_code, dir->buf, NULL);
+				else
+					return GIT_DIR_INVALID_GITFILE;
+			}
 		} else
 			gitfile = xstrdup(dir->buf);
 		/*
diff --git a/setup.h b/setup.h
index d55dcc6608..0271cc8f93 100644
--- a/setup.h
+++ b/setup.h
@@ -36,6 +36,9 @@ int is_nonbare_repository_dir(struct strbuf *path);
 #define READ_GITFILE_ERR_NO_PATH 6
 #define READ_GITFILE_ERR_NOT_A_REPO 7
 #define READ_GITFILE_ERR_TOO_LARGE 8
+#define READ_GITFILE_ERR_STAT_ENOENT 9
+#define READ_GITFILE_ERR_IS_A_DIR 10
+
 void read_gitfile_error_die(int error_code, const char *path, const char *dir);
 const char *read_gitfile_gently(const char *path, int *return_error_code);
 #define read_gitfile(path) read_gitfile_gently((path), NULL)
-- 
2.43.0

