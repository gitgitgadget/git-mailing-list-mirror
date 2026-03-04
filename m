Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A933B8BB0
	for <git@vger.kernel.org>; Wed,  4 Mar 2026 14:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772633740; cv=none; b=myAoGnRF2pNfrJBYbPY4mqHtJo59DsVZlpa9Wu0K2Ns68asqOKjTW4QxuTLjqWHOTXggjNGGLwgdByh44dvWw6r+oBDnlbFsEdEk6XUPCmDZ6OeOZyedlQUs/FymuIQQMxE8A5lOdg7tN8rQbK/XmF/rqHNiIru4M7ljNyABcZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772633740; c=relaxed/simple;
	bh=AspFL618yJzerLQvEGm2rVVuKoHGkrrU+DNJXz9h6Fk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D4us1PerxwQG3Zj+HHu+vA/s3U+RGsko8I8kLt3EIRVVodh1XGS8Zp2kHTyafB0K1eHcPaTMmcNLKRkdyf7QUkQAIlQDy40sGEH95YHnG9DkepnwIoH+FwkicARjpGO/1AsRtqUHHFpR0Mek9IhsmPiLLQfw1L7iVSZZKYMWOq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jMYjCAFp; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jMYjCAFp"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c70e3eb3af1so260749a12.2
        for <git@vger.kernel.org>; Wed, 04 Mar 2026 06:15:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772633738; x=1773238538; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r2uY08d8v1J49TqzItmkHTQ9Zhg/dK780TPDu3HFzRo=;
        b=jMYjCAFpWm+a8voucj1hX3QrXcBypgtVZ3X2FLIozsDhOcppsyFna5MXjRdw911crX
         WvWdCeFw3SyZWGJuC+GMGb7hLTv1cTuF4aHxtVRQeA20DAW0n7vTClCbrNbsnGLyJf7w
         qReiU1SxJ+wz5Q26dgZYWLh597dO/2tEgvOmCLUUCeyMcZOI+urBFTrQnX6ZOlPVnD/R
         95Sc/Enn/dPSYMVKzXKOfP1iLALENsGu3uWpXyr4AIPr7/uwnWu8uviUMn58iD3VvS1G
         oLHH1817NIhFej1OpQVK0ntLTYRUtdeN3OdqiYWNCpgHUv/nxcIj+1dzXd47LfFTRs9x
         9X7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772633738; x=1773238538;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=r2uY08d8v1J49TqzItmkHTQ9Zhg/dK780TPDu3HFzRo=;
        b=Yj94UPWf6IMTKuQO78xvsKp+uOJL0rXTg3E/13uU+5zv1ubWRYQpvcsff57cDHP4sX
         gdFP/1Tb+mE1JwQuAd43Jbr418d+aFIf6XZOj/AP/rOULJKMMFw1t+ZzGrigRPVq+Q7c
         g1mcO+aVOIOMtRgqc8e5gTw3eqqCppFVhJyC3SZYXOx7GYuf/sHkhs66yq2ccLT4/B1i
         Khms/gRrHoZVyGQbD8u3MyMLMkC+yA+iGYIUoRvCggqfiDXCPmVyagj0nIuUIcrnX4uK
         y6H5UiD5L2i3Mz9uCruWNCMCFKGrC/Fiapdt7UIhnPzVGzjtLi00t3xv8zu1JvRCpdT+
         9/1A==
X-Gm-Message-State: AOJu0YyPN7984J50dgjNIKGtwcClJjJtsnCAIuyemx2/GvvD/2vuf0A3
	Sa+eKcE/06vij0dbBrCKo7IFoYS+G52xVbyLd+5+PaBlBnRZwfnm33ms3iXG0tZx
X-Gm-Gg: ATEYQzznk5kVt36b0BP00G1Ng1mvosmYOvEc945EinI+H6h/Sil2LGPlFXmuvgmK7km
	KKPHjHE6DUtSyO3nIyzCo8tqzWNg+4u6FnDgX6ntx6AV57G5jxcD4pfA9fH3lmedkjbMbnr7Dxg
	N5umcNoX+9J/sMBfLerAdpeBRi0goOxAT20x15ojWRgW1MbDdCGLYGgn0vQUYmGPOfYu0DWbCHH
	n2NwmvXG+Rl9XrjF8bey7sjhJEk1IBZXsfQYDOTI2mrKFoNJvK4YMBzJQwoOvkcxZmJOStUIfou
	bm4nEMmeNOkw2fUJJfsbuZ/LGlL3rcLVQuSJszHCJBF5Ea5plzeYiPUFfQ5V/NcZoHczFTDUlU1
	URZJe6rsUuBvKYyGmrdtZSv/LjMeKjfG1KK2b7tDoqAHktGqP4uLYKkXiP4Ml5vgCjyQfof2W46
	uNuDqeaxBzZ5gL8/p7L1Xj+a27Q1ei8yhmSxt3FHXNA3wlOgQ1QKMHpB1wNRzhEpdQvSGHcVoTV
	NoSepmBJywGE7bzI9IlEI52
X-Received: by 2002:a17:903:1508:b0:2ae:6092:8d87 with SMTP id d9443c01a7336-2ae6ab3fa63mr14657285ad.6.1772633738103;
        Wed, 04 Mar 2026 06:15:38 -0800 (PST)
Received: from malon-Yoga-14sARE-2020.. ([155.69.180.3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae3d19559csm127216855ad.5.2026.03.04.06.15.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 06:15:37 -0800 (PST)
From: Tian Yuchen <a3205153416@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	karthik.188@gmail.com,
	phillip.wood@dunelm.org.uk
Subject: [PATCH v12] setup: improve error diagnosis for invalid .git files
Date: Wed,  4 Mar 2026 22:15:26 +0800
Message-ID: <20260304141526.37764-1-a3205153416@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260223074410.917523-1-a3205153416@gmail.com>
References: <20260223074410.917523-1-a3205153416@gmail.com>
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
'READ_GITFILE_ERR_MISSING'(which groups the "file missing" scenarios
together) and 'READ_GITFILE_ERR_IS_A_DIR':

1. Update 'read_gitfile_error_die()' to treat 'IS_A_DIR', 'MISSING',
'NOT_A_FILE' and 'STAT_FAILED' as non-fatal no-ops. This accommodates
intentional non-repo scenarios (e.g., GIT_DIR=/dev/null).

2. Explicitly catch 'NOT_A_FILE' and 'STAT_FAILED' during
discovery and call 'die()' if 'die_on_error' is set.

3. Unconditionally pass '&error_code' to 'read_gitfile_gently()'.

4. Only invoke 'is_git_directory()' when we explicitly receive
   'READ_GITFILE_ERR_IS_A_DIR', avoiding redundant checks.

Additionally, audit external callers of 'read_gitfile_gently()' in
'submodule.c' and 'worktree.c' to accommodate the refined error codes.

Signed-off-by: Tian Yuchen <a3205153416@gmail.com>
---
To be honest, I've really gotten myself all tangled up.
Skill issue :(
Feel free to point out all the stupid mistakes I made.

I'm very uncertain about whether my changes in 
setup_git_directory_gently_1() are appropriate.
But least all CI tests passed.

By the way, the replies in my email inbox look particularly messy.
When sending a new patch, which email should I reply to? Should I
reply to the previous patch, or, start a new thread?

 setup.c                       | 47 ++++++++++++++++-----
 setup.h                       |  2 +
 submodule.c                   |  2 +-
 t/meson.build                 |  1 +
 t/t0009-git-dir-validation.sh | 77 +++++++++++++++++++++++++++++++++++
 worktree.c                    |  6 ++-
 6 files changed, 121 insertions(+), 14 deletions(-)
 create mode 100755 t/t0009-git-dir-validation.sh

diff --git a/setup.c b/setup.c
index c8336eb20e..3bf96516ba 100644
--- a/setup.c
+++ b/setup.c
@@ -897,8 +897,10 @@ int verify_repository_format(const struct repository_format *format,
 void read_gitfile_error_die(int error_code, const char *path, const char *dir)
 {
 	switch (error_code) {
-	case READ_GITFILE_ERR_STAT_FAILED:
 	case READ_GITFILE_ERR_NOT_A_FILE:
+	case READ_GITFILE_ERR_STAT_FAILED:
+	case READ_GITFILE_ERR_MISSING:
+	case READ_GITFILE_ERR_IS_A_DIR:
 		/* non-fatal; follow return path */
 		break;
 	case READ_GITFILE_ERR_OPEN_FAILED:
@@ -941,8 +943,14 @@ const char *read_gitfile_gently(const char *path, int *return_error_code)
 	static struct strbuf realpath = STRBUF_INIT;
 
 	if (stat(path, &st)) {
-		/* NEEDSWORK: discern between ENOENT vs other errors */
-		error_code = READ_GITFILE_ERR_STAT_FAILED;
+		if (errno == ENOENT || errno == ENOTDIR)
+			error_code = READ_GITFILE_ERR_MISSING;
+		else
+			error_code = READ_GITFILE_ERR_STAT_FAILED;
+		goto cleanup_return;
+	}
+	if (S_ISDIR(st.st_mode)) {
+		error_code = READ_GITFILE_ERR_IS_A_DIR;
 		goto cleanup_return;
 	}
 	if (!S_ISREG(st.st_mode)) {
@@ -1578,20 +1586,37 @@ static enum discovery_result setup_git_directory_gently_1(struct strbuf *dir,
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
+			case READ_GITFILE_ERR_MISSING:
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
+				break;
+			case READ_GITFILE_ERR_STAT_FAILED:
+				if (die_on_error)
+					die(_("error reading '%s'"), dir->buf);
+				else
+					return GIT_DIR_INVALID_GITFILE;
+			case READ_GITFILE_ERR_NOT_A_FILE:
+				if (die_on_error)
+					die(_("not a regular file: '%s'"), dir->buf);
+				else
+					return GIT_DIR_INVALID_GITFILE;
+			default:
+				if (die_on_error)
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
index 0738dec244..76fb260c20 100644
--- a/setup.h
+++ b/setup.h
@@ -36,6 +36,8 @@ int is_nonbare_repository_dir(struct strbuf *path);
 #define READ_GITFILE_ERR_NO_PATH 6
 #define READ_GITFILE_ERR_NOT_A_REPO 7
 #define READ_GITFILE_ERR_TOO_LARGE 8
+#define READ_GITFILE_ERR_MISSING 9
+#define READ_GITFILE_ERR_IS_A_DIR 10
 void read_gitfile_error_die(int error_code, const char *path, const char *dir);
 const char *read_gitfile_gently(const char *path, int *return_error_code);
 #define read_gitfile(path) read_gitfile_gently((path), NULL)
diff --git a/submodule.c b/submodule.c
index 508938e4da..767d4c3c35 100644
--- a/submodule.c
+++ b/submodule.c
@@ -2559,7 +2559,7 @@ void absorb_git_dir_into_superproject(const char *path,
 		const struct submodule *sub;
 		struct strbuf sub_gitdir = STRBUF_INIT;
 
-		if (err_code == READ_GITFILE_ERR_STAT_FAILED) {
+		if (err_code == READ_GITFILE_ERR_MISSING) {
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
index 0000000000..33d21ed9ea
--- /dev/null
+++ b/t/t0009-git-dir-validation.sh
@@ -0,0 +1,77 @@
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
+	test_when_finished "rm -rf parent/link-to-dir" &&
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
+	test_when_finished "rm -rf parent/fifo-trap" &&
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
+	test_when_finished "rm -rf parent/symlink-fifo-trap" &&
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
+	test_when_finished "rm -rf parent/garbage-trap" &&
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
+	test_when_finished "rm -rf parent/empty-dir" &&
+	mkdir -p parent/empty-dir &&
+	(
+		cd parent/empty-dir &&
+		git rev-parse --git-dir >expect &&
+		mkdir .git &&
+		git rev-parse --git-dir >actual &&
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

