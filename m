Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5F8321F5E
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 07:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771832658; cv=none; b=lhDOpjARxaNt0rg2iaI5atX0qGtE+OI8TLqV+OeDlR4Bo2dgG+xWdN/bhgIpSJj0XOfFfHwJ4nh3bffoGqG5teC+/dqRtYJ3PDz6sON1tz/FvFzEIlvUjYIsmNczmOp0yTUSIQHDILFTeivr47mvqtw0wSVBF+g1QXPUZ++Cd+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771832658; c=relaxed/simple;
	bh=Sy3eKW0XDzzt8Mww6cPc1929zqzMdlM6ZeOs+BUr9Yo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cFCbwRFMvWV53lXd8oR0ncYhlPkRj9/PfVgvsl6KRr8MLfay9EijKjnErkLENJL1JdmaP/KIflwYGTP2R3PvWzNNdvO08XVMq6iMy3zodIJSYutyDyyAjCknmrojfizN+8CzqrP8FO0H0mIV07vhL0h2k2yQImBV5t98aP/wy6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GqdlS4/z; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GqdlS4/z"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c70b758c463so362806a12.3
        for <git@vger.kernel.org>; Sun, 22 Feb 2026 23:44:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771832656; x=1772437456; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9QRfiCrnVVCK/PvJuFlnm0zOKy1XYdpwE1qyEqXvD48=;
        b=GqdlS4/zTlfybk60m7mA70a0fLsuuxc7GYW5ZpaXjC4CMwVm4d7Wbukan47l1qwOM6
         k6chPWX/5Y73i3+2vIhBdh/h05XIptMFLke7fmnPwDHdLuWVQ+bRwunO2JqykHbBiVZ4
         PP3hGEs9xrcb2XAzqwErtqa0iA8xkSEMMGrm6mIcEdu6Q0JQ3AxlwIHG319nUE7rKb/k
         BxP0ByWxIF7kOqapMRNbIrRhAjDPJjjmxmH4qpRZEvPUwTvs1DqoqWG8cqENxcCkQGwl
         AmFan7avz1t9GkilP8Zabquuoj5VY7qE6hDasYT4tEoY3olP75VCJBN6LaZVBS7290o+
         kkvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771832656; x=1772437456;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9QRfiCrnVVCK/PvJuFlnm0zOKy1XYdpwE1qyEqXvD48=;
        b=SFfHhZugLDT6toNHfPJJLiTIoBs4yRnsqgyMIonMw7fiWkvTGu8I+JxkkqdpqB6B3B
         /dGzoDObbr3cKuwhBa7tmmNK6nvsY6wjZ92FTjOGzk8eq5PD6Sx16QZi8Lm8d78Ht19X
         2NJoeA88MnxVlIbGrtWcvsD1l2Dql8COZvN6E3MsSiMkiduK0AygiD6mam/ltTPjK2MY
         FbqUH0yFFjQGcAlxwrr9jO2WS2qoGtwbT/AHkD9QSaBroomLxftqtAAMMGHOsG+FO1qb
         k0U7+a8wvk9O+AkaGs3xVTL1reX5ZIZaWgeRMAX6MakqshEXne7jYJAe8eRwCE+Yq+zb
         FJdw==
X-Gm-Message-State: AOJu0YzIujEefB2xu39VxlT4ch6IXcY2ofHMl6hoYyXLdI/vub89EqYO
	vVaPbC7oPANK56Oxl9oa/k1TE+uvWp/gjhSP8n63A78/K9UXkuWD1PLVNg1KtQ==
X-Gm-Gg: ATEYQzzXNTc7ek/+4vPhfjvzXT669LLXVKb3jtwzkqXBt3LcfSOwzgTlubA7zpKSwZ4
	3b+2FpRXrdzqmiCrNY0DuQk47u1ucv9KBlMuYdfiYLXtVj0afimha479NH1i+PwCVPacszMkyxq
	rY7FEWrBzqXSX4pUvwSscBOCaMZJwVjOZLStYW2Kbq9Frc/Vatfl1TokrSL4sBTWCDuI29bcP7m
	YaiuRgbAHRfQLmf831BwA/gyh80mysqj//y+e7JRTuHmZwQp0aLVJ9JhcSI36x/325W8aOQT9EE
	C77rP070ZwaOajXz8NW+Fq1vo0zE5R1WfFgzqdBoNZMoYyoYRarINt/TH7cO5mmJpnwVVbdMEyT
	VxDe9Z151zepVYyDbXm1TvzjHj17rxL4fWfM7hEUQ66YyDzK8lZjUX/AOV367A63UbFhuwUnNwI
	TZH/eIKw1yAKOxcqGVB3awB5Lfhsp55v/4yWx+ZWcVc8o+RxX+KA==
X-Received: by 2002:a17:902:dac9:b0:2a0:ccee:b356 with SMTP id d9443c01a7336-2ad7445409amr56151835ad.1.1771832656295;
        Sun, 22 Feb 2026 23:44:16 -0800 (PST)
Received: from malon-Yoga-14sARE-2020.. ([155.69.180.3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad75035487sm64422115ad.74.2026.02.22.23.44.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 23:44:15 -0800 (PST)
From: Tian Yuchen <a3205153416@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	karthik.188@gmail.com
Subject: [PATCH v11] setup: improve error diagnosis for invalid .git files
Date: Mon, 23 Feb 2026 15:44:10 +0800
Message-ID: <20260223074410.917523-1-a3205153416@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260222102928.377519-1-a3205153416@gmail.com>
References: <20260222102928.377519-1-a3205153416@gmail.com>
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
together) and 'READ_GITFILE_ERR_IS_A_DIR'.

To preserve the original intent of the setup process:
1. Update 'read_gitfile_error_die()' to treat both 'IS_A_DIR' and
   'MISSING' as no-ops, while continuing to call 'die()' on true
   'NOT_A_FILE' errors to prevent security hazards (like FIFOs).
2. Unconditionally pass '&error_code' to 'read_gitfile_gently()'.
3. Only invoke 'is_git_directory()' when we explicitly receive
   'READ_GITFILE_ERR_IS_A_DIR', avoiding redundant filesystem checks.
4. Correctly return 'GIT_DIR_INVALID_GITFILE' on unrecognized errors
   when 'die_on_error' is false.

Additionally, audit external callers of 'read_gitfile_gently()' in
'submodule.c' and 'worktree.c' to accommodate the refined error codes.

Signed-off-by: Tian Yuchen <a3205153416@gmail.com>
---
 setup.c                       | 45 ++++++++++++++------
 setup.h                       |  2 +
 submodule.c                   |  2 +-
 t/meson.build                 |  1 +
 t/t0009-git-dir-validation.sh | 77 +++++++++++++++++++++++++++++++++++
 worktree.c                    |  6 ++-
 6 files changed, 118 insertions(+), 15 deletions(-)
 create mode 100755 t/t0009-git-dir-validation.sh

diff --git a/setup.c b/setup.c
index c8336eb20e..015088119c 100644
--- a/setup.c
+++ b/setup.c
@@ -897,10 +897,14 @@ int verify_repository_format(const struct repository_format *format,
 void read_gitfile_error_die(int error_code, const char *path, const char *dir)
 {
 	switch (error_code) {
-	case READ_GITFILE_ERR_STAT_FAILED:
-	case READ_GITFILE_ERR_NOT_A_FILE:
+	case READ_GITFILE_ERR_MISSING:
+	case READ_GITFILE_ERR_IS_A_DIR:
 		/* non-fatal; follow return path */
 		break;
+	case READ_GITFILE_ERR_STAT_FAILED:
+		die(_("error reading '%s'"), path);
+	case READ_GITFILE_ERR_NOT_A_FILE:
+		die(_("not a regular file: '%s'"), path);
 	case READ_GITFILE_ERR_OPEN_FAILED:
 		die_errno(_("error opening '%s'"), path);
 	case READ_GITFILE_ERR_TOO_LARGE:
@@ -941,8 +945,14 @@ const char *read_gitfile_gently(const char *path, int *return_error_code)
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
@@ -1578,20 +1588,31 @@ static enum discovery_result setup_git_directory_gently_1(struct strbuf *dir,
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
+				/* 
+				 * NEEDSWORK: should we catch a directory .git 
+				 * that is not a git directory here? 
+				 */
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
index 0000000000..7e2c711a63
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

