Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A3B26E6FB
	for <git@vger.kernel.org>; Thu, 19 Feb 2026 07:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771485423; cv=none; b=mzUQdrAWdS5ZOD9HV0dWkwiX6MF5pYm1oHyaq28Yb40G6UHniAoJIWxkrvOMAww9oXQWg2+Q/I+vtqLTHnsUwsmm6MPQgZwBeMWv0e+ee1gbMvTpNZ5IQsmvD0ee32/oAAB5OOGF1JXemH7zRDT22uvY0jvfD893DXMLNl71Q/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771485423; c=relaxed/simple;
	bh=YUnoLPCZ/WqW/sy1d6WIo4SgAFVu7dpVKwqYNFsFwZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XLHMfgsznyFrgY1istUwYdqSMdHbvm/D21Ttji2cAkpUnsBvRMBPVIYbrTl359bMAaoQtTu9RHipbrgsWOxMEjNQ0jxk9/3kymhsWE+WVrXR5d5Wzwxa62l6d8sY30bCO6GRHjcSdcV115kxnaP/gyMXzh7J+3aP6DPCQiYo2Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jeZB8QA1; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jeZB8QA1"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2aae38670daso873115ad.3
        for <git@vger.kernel.org>; Wed, 18 Feb 2026 23:17:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771485421; x=1772090221; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GgIILteiycvEH07T9+iK5G/wl1C6PLHxE+752M9Muoo=;
        b=jeZB8QA1xaBI3/a7PlSvgTS+zJGCSbElMcRoTSjT6PS2pdF9eExl1H60Ku4IzZReZ6
         07DWjile2pt0KFPq1loc9DOArSDXdhggsOniZ5T5EdMiuUMGNi0QHKRAojhfoLXfKPjq
         CD+fjLVJ/XAfqN4pNBruXa2OFvOlegumlYeLpdUi70g6E1uTdPUp8r4VFRyW4TFOw99O
         3DPzqEQVHXiWUfls81dlV217CtX+hl5wh3UElaOvlyhg4Iru7Sp+6XN7tBFrFsVjS25n
         oaw3icLbwWONOv69r2I+AWyQd5RyRDL//XpAPNuzh6LHsVKccKfOM5LrGXDuBm57TO9p
         +6+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771485421; x=1772090221;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GgIILteiycvEH07T9+iK5G/wl1C6PLHxE+752M9Muoo=;
        b=rfkfVfAg2Du5UmUVWrLG04Q0O90P3Ug/Z9c9fSzWemBT/rBwSbF79pgVLK7UTHf0iy
         p2tnDHuyyeqDS2IE/r3FYY5QvFEVTijjb3ssmwKIXflCTEODK8Iskd/KegTxjAchgh2u
         qcVcV8kK5ZbVHTae1oM9SnJ50/Mdc24hdr90FsbIvY35unoVKhnOCW6mVY+0zfMeda4a
         KUusN7lC1hG1Y5AY6U/18JZXYPevDYJJlb4gOGXdRfK4/mAehUAiSqL/UxRcIa82nkZP
         BHwatagF/CkPcGoM6u1oqjRieXM+BhVuOD5QqsWmC7jsd8O/BkKymiQj0GgDpsvqd7qe
         ViGA==
X-Gm-Message-State: AOJu0Yx8pMPouuFmULy8u2VnnKw5hM+MmoUZCq255OPxA1v7maJ/Wleq
	aFZaMP4qkD/ETDPxlFGdFuuaYnPsiaEroqEuSIXBivOHCw2nJ+D+cxpHKGMtjA==
X-Gm-Gg: AZuq6aLTXSA/3VswYBQy5hejWuolA+gObsB+tU0s9jb2v7As3kWZNaDd/xWLL9J+c+f
	jaOKCtnvbD6y3aqEADRvEzWGgGbOcEChC8BzTyb/pXHnfZnrSzEnZUtiNwIRAUBIvoDUMlsDoa2
	olLzMFNppQ6tYUANLVYCRmjGnB1SWC+tJ16i/BduQDte1xF3TpnHaj6kdjwNxYqyhP41GKU0YBs
	mxR2E/X2rRQuMiiiNl3qQyAq6NZlvlRYEhXkxII5xVaCUD4k4M80yoRucv7UecRA1XYmU05XqUh
	fAb3FGpvCFKLoh/oWMgAxdNnmXM/prNZJq5TiOc1FMHe6ITD2dC4KyDnVviQB408EugScmZCWGI
	14S9t8l2SLj8lFFjwhm3C6HLMxLbYhHO5fvHm1T+beoMCXC4IN+YiPfyedMZQyaFOtVFkfJr2Gj
	gswOADkdmbCoLS/mFTd9PSqT5lK99Q75SoAunWoTLJHAL3mfBxVA==
X-Received: by 2002:a17:903:2446:b0:2aa:de29:65c with SMTP id d9443c01a7336-2ab4cfd0a8bmr132477115ad.6.1771485420817;
        Wed, 18 Feb 2026 23:17:00 -0800 (PST)
Received: from malon-Yoga-14sARE-2020.. ([155.69.180.3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad1a73053dsm160507685ad.35.2026.02.18.23.16.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Feb 2026 23:17:00 -0800 (PST)
From: Tian Yuchen <a3205153416@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	karthik.188@gmail.com
Subject: [PATCH v7] setup: allow cwd/.git to be a symlink to a directory
Date: Thu, 19 Feb 2026 15:16:50 +0800
Message-ID: <20260219071650.208074-1-a3205153416@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260218124638.176936-1-a3205153416@gmail.com>
References: <20260218124638.176936-1-a3205153416@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, `setup_git_directory_gently_1()` fails to recognize a `.git`
symlink pointing to a directory because `read_gitfile_gently()` strictly
expects a regular file and returns `READ_GITFILE_ERR_NOT_A_FILE` for
anything else, including valid directories.

Fix this by distinguishing directories from regular files and other
non-regular file types (like FIFOs or sockets) via newly introduced
error_code.

To preserve the original intent of the setup process:
1. Update `read_gitfile_error_die()` to treat `IS_A_DIR` as a no-op
   (like `ENOENT`), while still calling `die()` on true `NOT_A_FILE`
   errors.
2. Unconditionally pass `&error_code` to `read_gitfile_gently()`. This
   eliminates an uninitialized variable hazard that occurred when
   `die_on_error` was true and `NULL` was passed.
3. Only invoke `is_git_directory()` when we explicitly receive
   `READ_GITFILE_ERR_IS_A_DIR`, avoiding redundant filesystem checks.
4. Correctly return `GIT_DIR_INVALID_GITFILE` on unrecognized errors
   when `die_on_error` is false.

Signed-off-by: Tian Yuchen <a3205153416@gmail.com>
---
Changes since v6:

 - Squashed into a single commit.
 - Fixed a hidden uninitialized variable trap. In v6:
   'setup_git_directory_gently_1()' passed 'die_on_error ? NULL : &error_code'
 to 'read_gitfile_gently()'. When 'NULL' was passed, the local 'error_code'
 remained uninitialized. The old code survived this because of short-circuit
 evaluation ('if (die_on_error || error_code == ...)'). 
   In this v7, I now unconditionally pass '&error_code'. This gives the caller
 explicit control over error routing.
   (Actually, I seem to have made the same modification back in v3 or v4, but I didn't
 realize at the time that the part I changed was originally a bug. So it was a 
 happy accident. :P
 - We now only invoke 'is_git_directory()' explicitly when 'error_code ==
 READ_GITFILE_ERR_IS_A_DIR'.

Thanks for your patience.

 setup.c                       | 44 +++++++++++++--------
 setup.h                       |  2 +
 t/meson.build                 |  1 +
 t/t0009-git-dir-validation.sh | 72 +++++++++++++++++++++++++++++++++++
 4 files changed, 104 insertions(+), 15 deletions(-)
 create mode 100755 t/t0009-git-dir-validation.sh

diff --git a/setup.c b/setup.c
index c8336eb20e..5a573e5865 100644
--- a/setup.c
+++ b/setup.c
@@ -897,10 +897,13 @@ int verify_repository_format(const struct repository_format *format,
 void read_gitfile_error_die(int error_code, const char *path, const char *dir)
 {
 	switch (error_code) {
+	case READ_GITFILE_ERR_STAT_ENOENT:
+	case READ_GITFILE_ERR_IS_A_DIR:
+		break;
 	case READ_GITFILE_ERR_STAT_FAILED:
+		die(_("error reading %s"), path);
 	case READ_GITFILE_ERR_NOT_A_FILE:
-		/* non-fatal; follow return path */
-		break;
+		die(_("not a regular file: %s"), path);
 	case READ_GITFILE_ERR_OPEN_FAILED:
 		die_errno(_("error opening '%s'"), path);
 	case READ_GITFILE_ERR_TOO_LARGE:
@@ -941,8 +944,14 @@ const char *read_gitfile_gently(const char *path, int *return_error_code)
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
@@ -1578,20 +1587,25 @@ static enum discovery_result setup_git_directory_gently_1(struct strbuf *dir,
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
-				if (is_git_directory(dir->buf)) {
-					gitdirenv = DEFAULT_GIT_DIR_ENVIRONMENT;
-					gitdir_path = xstrdup(dir->buf);
+			if (error_code == READ_GITFILE_ERR_IS_A_DIR &&
+			is_git_directory(dir->buf)) {
+				gitdirenv = DEFAULT_GIT_DIR_ENVIRONMENT;
+				gitdir_path = xstrdup(dir->buf);
+			} else {
+				if (error_code == READ_GITFILE_ERR_STAT_ENOENT ||
+				error_code == READ_GITFILE_ERR_IS_A_DIR ||
+				error_code == READ_GITFILE_ERR_NOT_A_FILE ||
+				die_on_error) {
+					read_gitfile_error_die(error_code, dir->buf, NULL);
+				} else {
+					return GIT_DIR_INVALID_GITFILE;
 				}
-			} else if (error_code != READ_GITFILE_ERR_STAT_FAILED)
-				return GIT_DIR_INVALID_GITFILE;
-		} else
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
-- 
2.43.0

