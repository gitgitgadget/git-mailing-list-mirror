Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FED53EBF22
	for <git@vger.kernel.org>; Fri, 20 Feb 2026 16:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771605941; cv=none; b=jgtZWrM3lFpiRGpqUntUzMzhzAG59V2YtU8wFHVaFK9ajCUugVf8lRvhyfS3dU0cN8AX8t6hqvVCd/oVTpqGxZ+atkR9iSqdA5fqJBGCKHskwpi1iYa2fwpOUHpdCwPL3NlA4nXazScM3t+b1fI5U3GzoOAvmfziXd0M3aWMDVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771605941; c=relaxed/simple;
	bh=EJK/lPtvZHJZjTtcX2jlvke76Gk2TMh/daQ2fD6guvI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b8n2zHA7vCXFprIsP6ojFU6+FwoY3ijfNnaQ92EYj/5OHF1SYHK1HuWkaIgQ4dpgKbgqeukqLid9KBSHR0Dx11kCyYw2h1wV4gH6vPmP4Nyc+nSS4/Xy+uANQvTKMehTtYKm7CMRyVR12om4WjpRzEm74QdBt7PFth6+UpOCXqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zcn6PZ8z; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zcn6PZ8z"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2a871c767f5so965815ad.0
        for <git@vger.kernel.org>; Fri, 20 Feb 2026 08:45:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771605939; x=1772210739; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uTAJCWoGeq7uK0Rl3BuyUiS2l6XLWWcvnP+RapHW+Dg=;
        b=Zcn6PZ8zWKb1RY+2fyZCY5xdYWGxBUjEJ89V3oo6lHTQWA5T/gWNuuo9m4vZcAQhUL
         wrHmbUSv6BdrVnidwpuTJE8tUol9iGDA94Widdr3G3aunfhi3yakMFcg3Q5w3+OVY28y
         pdx6OxwSCtVxagvY6SeNfFgrNoMKOPjJTp1f2DnvxGrzK5pLsb05zOm7LYDJMVv66baO
         DJ0/RcQyYAzTvq1yqk3kF839OdecnvunfxJ8efoWUSeS/gqbf8gr75OU/rsBjzA+MvB7
         2wX6ZC9seqyCz9puyrKpC7EyyZdw8vXrIV2CL0MRECQEtunWe4hCOfUf65fShB48sVTR
         7d0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771605939; x=1772210739;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uTAJCWoGeq7uK0Rl3BuyUiS2l6XLWWcvnP+RapHW+Dg=;
        b=VdJ3htcwrU3lQ8loc7IqabSpXO+Fcdl+z2jkPepejdVdoqVa73lUSmUPImwW3v2Xe7
         k3vKj1u5C7VJ9ORdrWDLOmp+Rnytmj3YNeK/CC4nD/FiuhvKor9Q6fpax6OfF9qkea5X
         58ySHk3Hlwi02kOeMaUrRPnRd8b9dTfCKcA9nfNdOIRVZqEIcVThg0GpsSEkOFnaVz5u
         Lt0qRqK8e92u+qoedNEXCLh6zunsugJZbAs+fDeCQ87ksMqFuBZg5tY966RC41cQJ0im
         GCpTjvE4+O8oKKF6FU2Y9li5Y1ERglvcHUeItqZ9Ebx76Rr+l8mOsP7AWS3eLdgh/mhw
         WAMA==
X-Gm-Message-State: AOJu0Yz/qad/b0iGgG+rf8bfAbm003L6KuBzJ6rg/KgvO0Sv2TIwH64/
	0i/mEqmu0csvbOWWmBEWxGzodMMDcv0EVxZ6iYcuFjH4wAJkM8XV1JtQAjexgg==
X-Gm-Gg: AZuq6aIAyHaFyt3mRIQOWpXtqI5YsguRVi493FWCLj7oAf0A1tZTu5Z0tFhGKV7rjdy
	sRHrgui+2Sf2qaG1QXAkqJFPWo/fYnpgHz/00Uf4H0RGLByaRYAcXo8JMibxrO8UpF6fLerxNPF
	qpp2bn61cVXcFougpUdk+G+SXHulp244EYmUyKwwX0DKV9agohTbCvkmp3gn8fdqk1GlvtmgSnu
	Bz8LsrnNW9ahLHr5ExWo/AVSMd4/iNEyzPJblJWL4LXO/JOqqVGIPB5YjxrCpZ43EL/Tt0T5DDJ
	53kfLSKnamdYITPf+Sj/atgQ0/nIBdqm7K89QbCagkQfdMYYia3UXZrMSN/X/W1NjNyBNHu7H9w
	eM0GiRKXvyX+QZaqX3LvYXYVnQVINOOa2zJJF0I2ghDq8bTj2bOfv9x/3y4LuwNrF3iY39H2pY6
	LQkCeIOe1C1FjbOJac6a54IjGm+qv5ASGDPWqJt9o=
X-Received: by 2002:a17:902:ce8b:b0:2aa:d1e1:29d8 with SMTP id d9443c01a7336-2ad745690d1mr1026795ad.6.1771605939107;
        Fri, 20 Feb 2026 08:45:39 -0800 (PST)
Received: from malon-Yoga-14sARE-2020.. ([155.69.180.3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad1a72c151sm207990565ad.33.2026.02.20.08.45.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Feb 2026 08:45:38 -0800 (PST)
From: Tian Yuchen <a3205153416@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	karthik.188@gmail.com
Subject: [PATCH v8] setup: allow cwd/.git to be a symlink to a directory
Date: Sat, 21 Feb 2026 00:45:12 +0800
Message-ID: <20260220164512.216901-1-a3205153416@gmail.com>
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
 setup.c                       | 42 ++++++++++++++------
 setup.h                       |  2 +
 t/meson.build                 |  1 +
 t/t0009-git-dir-validation.sh | 72 +++++++++++++++++++++++++++++++++++
 4 files changed, 105 insertions(+), 12 deletions(-)
 create mode 100755 t/t0009-git-dir-validation.sh

diff --git a/setup.c b/setup.c
index c8336eb20e..2869d10669 100644
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
+				/* otherwise, it is an empty/unrelated directory, move on */
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

