Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82EBD137923
	for <git@vger.kernel.org>; Sun, 22 Feb 2026 10:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771756175; cv=none; b=ipHYJHCv+BJ/QDEFmLrR0N/Ak332RxP6F8TocaccsYkust5/YiGDJzF0sNikPWlyuh6krO01hbviHuP798GTS4NUbdNAHRA88AONAVidvKEYSHPwR8vNTHuh21lq9clgMVdVfewmhIA2mqwQQo6rJtrlVto1vR/UUptNk5xZdK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771756175; c=relaxed/simple;
	bh=lS8aHvZe0IBPfjGAM4ev/qkoHpBQHQ/Jv9H+mIX3R8o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LaiT9UFIoE3k+IhPqHVTGNtHmUSDZHnnjnubbAY3pEfz1D13Oqcq9zqktWymdRGsaIQHzj04nf9CSO2c3omEwq1d99YiLDMG0ENBU/uwj4f0fub4TAWE65iE3/4ENHbrzCB6fUk+mC4B7Imaljosk76e8FL0y9KVd8o2S14890w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LaGh8ulM; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LaGh8ulM"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c46d4a02ff5so481768a12.1
        for <git@vger.kernel.org>; Sun, 22 Feb 2026 02:29:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771756174; x=1772360974; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=24uv4kyWbwO9IVpduQSK9DeSfBVU1EXP4/szV5kCW3Y=;
        b=LaGh8ulMzX9tD6cS2studwIqb0h170BUv5lneDSB1zEsVC17/NnNu1HX2krhpoMRpR
         jfSA6Z1h9++alOuDwKL61xC6lLoD4upzVXrY5YzhomhE7J8pt+MtSX91rkW+XqYc0fu9
         lQjR1nAams3ULQO49xwvmoqrsdzo4/w0/ox+YxHmBx/d0533sNsDFAE84xNUcuZ/I0cT
         wNmZOxUWgOiL1llMC96oB+m3jSQUG3SLYitweWpteSUxd7BbkryD28lO4HFsP7k0UqTe
         v5kgeUnY50hLv8nM0YguP8ExEwmyfGoGyhNIS6PRaOnuawcAQ+DDCO7PAmKiEXeBkxSq
         /CiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771756174; x=1772360974;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=24uv4kyWbwO9IVpduQSK9DeSfBVU1EXP4/szV5kCW3Y=;
        b=FGwL4hvj+DyUSsKUSWd4FLB8zlnhs77jZ5o1PwX8XlUFiOTs8Kd5a6SbQA5GIidhgz
         F6XI59cGHivJEi/OIih3T5lkCq/TUk5pzgykMMAEPG6QA8kJZuJeJtwVzBUDqElepy95
         YfXOre2x/Kg6XCOCNz+lOjkV7h9CAhNd5ETK6sBeyYNvwGQ2bNqgh1zPFBYCSNJlojzj
         FVBznxv3TVM5cdfZI2oV/z4mejvQwCEzUm8wRZ5zDAE+afVLcZD3EMXiYW+wGh3sT8d4
         CHzCkHhimXbweBzfUpucaJmD4rZaCxtj54UdO6SplhHmTZZd7y+nz9RDvSrTxGjeAzwK
         phZA==
X-Gm-Message-State: AOJu0YxI6zAJ/iNUGb079uPmQd8gqUVmOZfploLNIxDk19VzGjpC6Gs0
	G0U3hX0MhQYciDNYxLn5T3MMwhxEp8mXNs0H8nUzJqj3dOabLzUgacv2IkNmAQ==
X-Gm-Gg: AZuq6aLLuhIQUCiRV4gG9TjEZO84X3DMT3hknwA0A6PL89hIeG1lWdxZ7IgzwVtSemW
	lpUMwPFUCk9k8sTtsNu6JUYafXg47O/PZLYdBtApXbUHkuqFwQIs+b1mF59wSR356c2RE2NlVSN
	PPR34+HNsS7+qBMeXSUBEuOSCY2xQxtWrw32FqFT1H6Ow3Afkwvu5Lmk0UFl/jEDStH5B/ixGuI
	NXN4oF/xKMHQ22ZdO9SQ4qMevk2BvySaGu9OF2lBBSZP+uG+kH/bsI3C0EUiatgWfH/XAvFeIz4
	KURYEuI0kQc3i/QN5dMJNKk2ZudAIFeI+oNp9dyMPce1DkeuWj8vLKVymvsfzaK7wXOX7hsDHgK
	7gaUkap13crjxANDwHS8jzgSHDVnr9tRaz/TlmXfM/o9lIzkVRNPNHcvhU55ML3yR3Vd2QqB1O7
	e0juRcF9aZFUPYpCEI5fc2EjGY+ZArnWVw3xFzfGw=
X-Received: by 2002:a17:902:dac9:b0:2a0:ccee:b356 with SMTP id d9443c01a7336-2ad7445409amr39898095ad.1.1771756173604;
        Sun, 22 Feb 2026 02:29:33 -0800 (PST)
Received: from malon-Yoga-14sARE-2020.. ([155.69.180.3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad7503d406sm41441565ad.75.2026.02.22.02.29.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 02:29:33 -0800 (PST)
From: Tian Yuchen <a3205153416@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com
Subject: [PATCH v10] setup: improve error diagnosis for invalid .git files
Date: Sun, 22 Feb 2026 18:29:28 +0800
Message-ID: <20260222102928.377519-1-a3205153416@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260221083001.220061-1-a3205153416@gmail.com>
References: <20260221083001.220061-1-a3205153416@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'read_gitfile_gently()' treats any non-regular file as
'READ_GITFILE_ERR_NOT_A_FILE' and fails to discern between 'ENOENT'
and other stat failures. This flawed error reporting is noted by two
'NEEDSWORK' comments.

Address these comments by introducing two new error codes:
'READ_GITFILE_ERR_STAT_ENOENT' and 'READ_GITFILE_ERR_IS_A_DIR'.

To preserve the original intent of the setup process:
1. Update 'read_gitfile_error_die()' to treat 'IS_A_DIR' as a no-op
   (like 'ENOENT'), while still calling 'die()' on true 'NOT_A_FILE'
   errors.
2. Unconditionally pass '&error_code' to 'read_gitfile_gently()'. This
   eliminates an uninitialized variable hazard that occurred when
   'die_on_error' was true and 'NULL' was passed.
3. Only invoke 'is_git_directory()' when we explicitly receive
   'READ_GITFILE_ERR_IS_A_DIR', avoiding redundant filesystem checks.
4. Correctly return 'GIT_DIR_INVALID_GITFILE' on unrecognized errors
   when 'die_on_error' is false.

Additionally, audit external callers of 'read_gitfile_gently()' in
'submodule.c' and 'worktree.c' to accommodate the refined error codes.

Signed-off-by: Tian Yuchen <a3205153416@gmail.com>
---
 setup.c                       | 42 ++++++++++++++------
 setup.h                       |  2 +
 submodule.c                   |  2 +-
 t/meson.build                 |  1 +
 t/t0009-git-dir-validation.sh | 72 +++++++++++++++++++++++++++++++++++
 worktree.c                    |  6 ++-
 6 files changed, 110 insertions(+), 15 deletions(-)
 create mode 100755 t/t0009-git-dir-validation.sh

diff --git a/setup.c b/setup.c
index c8336eb20e..9d49b9ae53 100644
--- a/setup.c
+++ b/setup.c
@@ -897,10 +897,14 @@ int verify_repository_format(const struct repository_format *format,
 void read_gitfile_error_die(int error_code, const char *path, const char *dir)
 {
 	switch (error_code) {
-	case READ_GITFILE_ERR_STAT_FAILED:
-	case READ_GITFILE_ERR_NOT_A_FILE:
+	case READ_GITFILE_ERR_STAT_ENOENT:
+	case READ_GITFILE_ERR_IS_A_DIR:
 		/* non-fatal; follow return path */
 		break;
+	case READ_GITFILE_ERR_STAT_FAILED:
+		die(_("error reading %s"), path);
+	case READ_GITFILE_ERR_NOT_A_FILE:
+		die(_("not a regular file: %s"), path);
 	case READ_GITFILE_ERR_OPEN_FAILED:
 		die_errno(_("error opening '%s'"), path);
 	case READ_GITFILE_ERR_TOO_LARGE:
@@ -941,8 +945,14 @@ const char *read_gitfile_gently(const char *path, int *return_error_code)
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
@@ -1578,20 +1588,28 @@ static enum discovery_result setup_git_directory_gently_1(struct strbuf *dir,
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
+			switch (error_code) {
+			case READ_GITFILE_ERR_STAT_ENOENT:
+				/* no .git in this directory, move on */
+				break;
+			case READ_GITFILE_ERR_IS_A_DIR:
 				if (is_git_directory(dir->buf)) {
 					gitdirenv = DEFAULT_GIT_DIR_ENVIRONMENT;
 					gitdir_path = xstrdup(dir->buf);
 				}
-			} else if (error_code != READ_GITFILE_ERR_STAT_FAILED)
-				return GIT_DIR_INVALID_GITFILE;
-		} else
+				/* NEEDSWORK: should we catch a directory .git that is not a git directory here? */
+				break;
+			default:
+				if (die_on_error || error_code == READ_GITFILE_ERR_NOT_A_FILE)
+					read_gitfile_error_die(error_code, dir->buf, NULL);
+				else
+					return GIT_DIR_INVALID_GITFILE;
+			}
+		} else {
 			gitfile = xstrdup(dir->buf);
+		}
 		/*
 		 * Earlier, we tentatively added DEFAULT_GIT_DIR_ENVIRONMENT
 		 * to check that directory for a repository.
diff --git a/setup.h b/setup.h
index 0738dec244..ed4b13f061 100644
--- a/setup.h
+++ b/setup.h
@@ -36,6 +36,8 @@ int is_nonbare_repository_dir(struct strbuf *path);
 #define READ_GITFILE_ERR_NO_PATH 6
 #define READ_GITFILE_ERR_NOT_A_REPO 7
 #define READ_GITFILE_ERR_TOO_LARGE 8
+#define READ_GITFILE_ERR_STAT_ENOENT 9
+#define READ_GITFILE_ERR_IS_A_DIR 10
 void read_gitfile_error_die(int error_code, const char *path, const char *dir);
 const char *read_gitfile_gently(const char *path, int *return_error_code);
 #define read_gitfile(path) read_gitfile_gently((path), NULL)
diff --git a/submodule.c b/submodule.c
index 508938e4da..b179f952fb 100644
--- a/submodule.c
+++ b/submodule.c
@@ -2559,7 +2559,7 @@ void absorb_git_dir_into_superproject(const char *path,
 		const struct submodule *sub;
 		struct strbuf sub_gitdir = STRBUF_INIT;
 
-		if (err_code == READ_GITFILE_ERR_STAT_FAILED) {
+		if (err_code == READ_GITFILE_ERR_STAT_ENOENT) {
 			/* unpopulated as expected */
 			strbuf_release(&gitdir);
 			return;
diff --git a/t/meson.build b/t/meson.build
index f80e366cff..c4afaacee5 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -80,6 +80,7 @@ integration_tests = [
   't0006-date.sh',
   't0007-git-var.sh',
   't0008-ignores.sh',
+  't0009-git-dir-validation.sh',
   't0010-racy-git.sh',
   't0012-help.sh',
   't0013-sha1dc.sh',
diff --git a/t/t0009-git-dir-validation.sh b/t/t0009-git-dir-validation.sh
new file mode 100755
index 0000000000..9b3925c85f
--- /dev/null
+++ b/t/t0009-git-dir-validation.sh
@@ -0,0 +1,72 @@
+#!/bin/sh
+
+test_description='setup: validation of .git file/directory types
+
+Verify that setup_git_directory() correctly handles:
+1. Valid .git directories (including symlinks to them).
+2. Invalid .git files (FIFOs, sockets) by erroring out.
+3. Invalid .git files (garbage) by erroring out.
+'
+
+. ./test-lib.sh
+
+test_expect_success 'setup: create parent git repository' '
+	git init parent &&
+	test_commit -C parent "root-commit"
+'
+
+test_expect_success SYMLINKS 'setup: .git as a symlink to a directory is valid' '
+	mkdir -p parent/link-to-dir &&
+	(
+		cd parent/link-to-dir &&
+		git init real-repo &&
+		ln -s real-repo/.git .git &&
+		git rev-parse --git-dir >actual &&
+		echo .git >expect &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success PIPE 'setup: .git as a FIFO (named pipe) is rejected' '
+	mkdir -p parent/fifo-trap &&
+	(
+		cd parent/fifo-trap &&
+		mkfifo .git &&
+		test_must_fail git rev-parse --git-dir 2>stderr &&
+		grep "not a regular file" stderr
+	)
+'
+
+test_expect_success SYMLINKS,PIPE 'setup: .git as a symlink to a FIFO is rejected' '
+	mkdir -p parent/symlink-fifo-trap &&
+	(
+		cd parent/symlink-fifo-trap &&
+		mkfifo target-fifo &&
+		ln -s target-fifo .git &&
+		test_must_fail git rev-parse --git-dir 2>stderr &&
+		grep "not a regular file" stderr
+	)
+'
+
+test_expect_success 'setup: .git with garbage content is rejected' '
+	mkdir -p parent/garbage-trap &&
+	(
+		cd parent/garbage-trap &&
+		echo "garbage" >.git &&
+		test_must_fail git rev-parse --git-dir 2>stderr &&
+		grep "invalid gitfile format" stderr
+	)
+'
+
+test_expect_success 'setup: .git as an empty directory is ignored' '
+	mkdir -p parent/empty-dir &&
+	(
+		cd parent/empty-dir &&
+		mkdir .git &&
+		git rev-parse --git-dir >actual &&
+		echo "$TRASH_DIRECTORY/parent/.git" >expect &&
+		test_cmp expect actual
+	)
+'
+
+test_done
diff --git a/worktree.c b/worktree.c
index 9308389cb6..d1165e1d1c 100644
--- a/worktree.c
+++ b/worktree.c
@@ -653,7 +653,8 @@ static void repair_gitfile(struct worktree *wt,
 		}
 	}
 
-	if (err == READ_GITFILE_ERR_NOT_A_FILE)
+	if (err == READ_GITFILE_ERR_NOT_A_FILE ||
+		err == READ_GITFILE_ERR_IS_A_DIR)
 		fn(1, wt->path, _(".git is not a file"), cb_data);
 	else if (err)
 		repair = _(".git file broken");
@@ -833,7 +834,8 @@ void repair_worktree_at_path(const char *path,
 			strbuf_addstr(&backlink, dotgit_contents);
 			strbuf_realpath_forgiving(&backlink, backlink.buf, 0);
 		}
-	} else if (err == READ_GITFILE_ERR_NOT_A_FILE) {
+	} else if (err == READ_GITFILE_ERR_NOT_A_FILE ||
+			err == READ_GITFILE_ERR_IS_A_DIR) {
 		fn(1, dotgit.buf, _("unable to locate repository; .git is not a file"), cb_data);
 		goto done;
 	} else if (err == READ_GITFILE_ERR_NOT_A_REPO) {
-- 
2.43.0

