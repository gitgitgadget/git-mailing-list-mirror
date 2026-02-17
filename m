Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F74E2D8387
	for <git@vger.kernel.org>; Tue, 17 Feb 2026 08:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771317695; cv=none; b=UZsXsPgRiBGMYG+qQOsxJ/R7q4NoIqBAxQXFZa/sKWce59Dzv6q2h5zZSP+xQjZpnjTfF1kI2wB4cKa7b16UStVPjyPCGtgS7MxOM0Sx+APAh71Q2S1jEuoQ6rnUHJ/C0MC5G0fYckgEZWFLBo9aeUB/PXrgi+7YgtV55V6UNHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771317695; c=relaxed/simple;
	bh=ya3eUDo1QGvalY9DXAPJ2qBU99BjF1fDZKMZBhEnZk8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XNfqAYxkmgRLQWbWC5EFAfNmO2obZ0TgAEJjjtlayHwxlpB+5a+h7D02QclptOh7toynbFyO94m4m6Ytd6c3YFjca3s/yK/bI7ctdphSx2x/RV1nMnLHzXAOfGhgaLYPv+EsXgw7GZyWTRY0cPUfdGuMHzn2V4c87+/dbeVy2lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dcOHsAyI; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dcOHsAyI"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c6e49b67239so159194a12.2
        for <git@vger.kernel.org>; Tue, 17 Feb 2026 00:41:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771317693; x=1771922493; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IbAOpyZFe1XCWEAzEh0y6BJUGTdeiW1CRkTXW5W8RmU=;
        b=dcOHsAyI/sNGLXpHDB7JimHbfMp9Gjt9yqQbS5EJmiEbuyBUGhwgCrzhw+51Ex7CRZ
         wiFrlPBGD9hV/FfWeRzApFI9LrgOHOGCP5op5uQ0a9zamPybA4KOfApO+9VB6ZyIXHga
         FUxiJHX4nkH1RrCS2ZBLkHN5kIfKVHn+EVvAX/vruoZSC4Hln4FpZQSZRJQ4yFnUUOsw
         4BsTShG+a8qctp6E1vxo1/IdBh/ICChyEe9LnvNpRkCAwGqJMeFr2rQLuKTh3Lk09Wcn
         7WZRWWEAhVKaS4iuhgXYaklcYReULkTtdt93n4Q1QZNkWredSpp+t+s/KvuaBWC43GVn
         RmkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771317693; x=1771922493;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IbAOpyZFe1XCWEAzEh0y6BJUGTdeiW1CRkTXW5W8RmU=;
        b=Ai0ZXYvv0CE+Nkh1m0V/gah8fJJ7gC7TNWyJ1WjAFpMwFddE5vACri2phx9dliC18N
         kylAgjq58c8+PfqT7OY4hyldWTaHyRXUOWe7MgcdosWfVYdcdUnoouXgVzYSWwlaH/o5
         1nBrZxLg44VcOoynCLONG5HYzZq32DAKp/5C7GLnrYOi0FgAAOxa/eVQOEdWlu8o+qqy
         /lkopfaV3j0UKx2VnEPFlIgCH3vjQ3j+d65/uKUD2zLVysiAqjE04RvTQI/MvfxzMuML
         2AzyHv8xwiOTddCJcBUVTdvUhFJ8dxp1hgJXeUE8pXgPfdL9C95UwYq0WUFJ4gmpeRjg
         NE8g==
X-Gm-Message-State: AOJu0Yw4y5sG5X30lgHKZ2HtKDXh7ROqFne6+gX48VFjqJ3A1/mZDJwB
	nJ8xwQiRJqfxZ64EbDvffRPpQyRag8a4+5OLfx5ENDs2env5yhLAhqPD8kPsShQc
X-Gm-Gg: AZuq6aLZwoYvLZmxBiYXheZVX9MMm7tzK3vEyV6R030wZBZBYFgoFpGWMqm5m9GLnVw
	y3xHwIzFp0z64tfKI9tNt9lwqMn/yKO8WSWtX90jwy0mORfKtIux9s++tl7r9c4nxfXeSPg31iv
	fUIdyGN6+wO1JzdlwhNqPpZ5QtR9MSO/4EmY94QNqQSj/a9CoHRiSlpIHKnuWE98l2yy5691i+g
	C/NJds19L4Tybab1MxMbGAZQhJz1w0A6c/QZtTlhQ60qi0jSc9B+WyggBrZwOtOcMHG+0yhiIP4
	np3j2OwN3Ppx8BkoIfo60fVwRUX8DowPnThi5TKUpZNv36KL1tIWs49D3mXvn9MwBZc71M20YAL
	djpIuWLeg83vEELkCVlxU749z8bGHcB6sZklyyHXlnuAe/QDS2V0kRa4Si2nmGxQbiYp3vPPYN6
	C4CbLuoKiES0Em3uUYx2viPxpylga1JQSGlZGFCNo=
X-Received: by 2002:a05:6a20:2452:b0:394:5d36:1a0a with SMTP id adf61e73a8af0-3946733e30fmr9209380637.8.1771317693021;
        Tue, 17 Feb 2026 00:41:33 -0800 (PST)
Received: from malon-Yoga-14sARE-2020.. ([155.69.180.3])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c6e5300d135sm9852194a12.11.2026.02.17.00.41.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 00:41:32 -0800 (PST)
From: Tian Yuchen <a3205153416@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com
Subject: [PATCH v4] setup: allow cwd/.git to be a symlink to a directory
Date: Tue, 17 Feb 2026 16:41:24 +0800
Message-ID: <20260217084124.150366-1-a3205153416@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <5b29218a-8d18-41f0-8a03-eac707151945@gmail.com>
References: <5b29218a-8d18-41f0-8a03-eac707151945@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Strictly enforcing 'lstat()' and 'S_ISREG()' on '.git' prevents valid
workflows where '.git' is a symbolic link pointing to a real git
directory (e.g. created via 'ln -s').

Refactor 'setup_git_directory_gently_1()' to use 'stat()' instead of
'lstat()'. This allows the filesystem to automatically resolve symbolic
links.

To ensure safety and correctness, the logic flow is updated to:

1. Ignore 'ENOENT' (file missing).
2. Check 'IS_A_DIR' cases via 'is_git_directory()'.
3. Explicitly reject 'NOT_A_FILE' cases (FIFOs or sockets).

Add a new test script t/t0009-setup-security.sh which verifies:

- Valid .git symlinks to real directories are accepted.
- .git as a named pipe (FIFO) is rejected.
- .git as a symlink to a named pipe is rejected.
- .git with garbage content is rejected.
- Empty .git directories are ignored.

Signed-off-by: Tian Yuchen <a3205153416@gmail.com>
---
 setup.c                   | 39 ++++++++++++++-------
 setup.h                   |  2 ++
 t/t0009-setup-security.sh | 72 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 101 insertions(+), 12 deletions(-)
 create mode 100755 t/t0009-setup-security.sh

diff --git a/setup.c b/setup.c
index 3a6a048620..269aa9faaa 100644
--- a/setup.c
+++ b/setup.c
@@ -939,8 +939,14 @@ const char *read_gitfile_gently(const char *path, int *return_error_code)
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
@@ -994,7 +1000,9 @@ const char *read_gitfile_gently(const char *path, int *return_error_code)
 cleanup_return:
 	if (return_error_code)
 		*return_error_code = error_code;
-	else if (error_code)
+	else if (error_code &&
+		error_code != READ_GITFILE_ERR_STAT_ENOENT &&
+		error_code != READ_GITFILE_ERR_IS_A_DIR)
 		read_gitfile_error_die(error_code, path, dir);
 
 	free(buf);
@@ -1576,20 +1584,27 @@ static enum discovery_result setup_git_directory_gently_1(struct strbuf *dir,
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
+			if (error_code == READ_GITFILE_ERR_STAT_ENOENT) {
+				;
+			} else if (error_code == READ_GITFILE_ERR_IS_A_DIR) {
 				if (is_git_directory(dir->buf)) {
 					gitdirenv = DEFAULT_GIT_DIR_ENVIRONMENT;
 					gitdir_path = xstrdup(dir->buf);
 				}
-			} else if (error_code != READ_GITFILE_ERR_STAT_FAILED)
-				return GIT_DIR_INVALID_GITFILE;
-		} else
-			gitfile = xstrdup(dir->buf);
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
+		}
 		/*
 		 * Earlier, we tentatively added DEFAULT_GIT_DIR_ENVIRONMENT
 		 * to check that directory for a repository.
diff --git a/setup.h b/setup.h
index d55dcc6608..c23629cb4f 100644
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
diff --git a/t/t0009-setup-security.sh b/t/t0009-setup-security.sh
new file mode 100755
index 0000000000..72c5232147
--- /dev/null
+++ b/t/t0009-setup-security.sh
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
+	mkdir -p parent/fifo &&
+	(
+		cd parent/fifo &&
+		mkfifo .git &&
+		test_must_fail git rev-parse --git-dir 2>stderr &&
+		grep "not a regular file" stderr
+	)
+'
+
+test_expect_success SYMLINKS,PIPE 'setup: .git as a symlink to a FIFO is rejected' '
+	mkdir -p parent/symlink-fifo &&
+	(
+		cd parent/symlink-fifo &&
+		mkfifo target-fifo &&
+		ln -s target-fifo .git &&
+		test_must_fail git rev-parse --git-dir 2>stderr &&
+		grep "not a regular file" stderr
+	)
+'
+
+test_expect_success 'setup: .git with garbage content is rejected' '
+	mkdir -p parent/garbage &&
+	(
+		cd parent/garbage &&
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

