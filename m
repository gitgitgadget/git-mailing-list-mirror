Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C93A32FA36
	for <git@vger.kernel.org>; Sat, 21 Feb 2026 08:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771662609; cv=none; b=bPTcP7R/UgDK3aIMB8BuyqEbVNT0yWeGgSSu15Kur9tEUoucFXmq61WUH1Skai7c9XqToUkOZvMMM989tBaffSQ/Y10x7UmIUPSVEfMGIzbsWIG8dlyvg7JSSmqaCNvXBSC6Yn631N2JxxQKA6eP/2I5yXNc7Yxpj++AUd0dphQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771662609; c=relaxed/simple;
	bh=zyk2mm8LcJojaTr/3YWWsK6QCM2rvNfXsiSiu0kmOCg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dmjw9mt3QJI2BSQHl6Ek36sBw/AWXtLpDCoyCy1EHaI0ArTuTam+nuwnFmwVd53bUIfl13A7qXPnKTKyjFcuCTEYc9vhP53bVPn2kr6I38cpkH8XYpGgWsK62ZlBwbmk5kWZvY022DlIV9hgm0L+ZilE+47TYcM6JgiPJ4GAI7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V++hggyf; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V++hggyf"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c2a00109fd8so342372a12.3
        for <git@vger.kernel.org>; Sat, 21 Feb 2026 00:30:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771662607; x=1772267407; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fZz9FLm5nIzlauEsuIeWmxJ2DOLYYYPdY0+7GdlG+1s=;
        b=V++hggyfVZENsZjvBnIxq0J90o7BtVeq55x8OQzAMBHlbP2T7DniZg6iWzLi3mjgSP
         iQOPGd+Ag/t951BxtWEvhXI1jGPrpeO0DrMFK39purHMWGV71/EFwP6D94wiH+l/oJfE
         dQ2s2zQsZwu20agTFKBq+1ERh4GAzJkqqHK28k9vBE/Pd8a9+NI0RujRc+REY9nIxY0K
         OdjJUWU/Lr91WstyX0mUv9IEhHHnZCkpIta4pFZVudWfiJA3LmPM3cwSitu83cAPS8xV
         wRCSSaw+jGJkfXt3Wb+oPXLcC8AZ2vrEAghBZVILMznPv31Dm5jyCLLKmhAa8fKF3fMM
         YHFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771662607; x=1772267407;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fZz9FLm5nIzlauEsuIeWmxJ2DOLYYYPdY0+7GdlG+1s=;
        b=R53HqexGhciKhe82TMUuJ88jbnI9sW+BMzeTsM2okeG/fh6+oAFPLUhrsrnTYOYqYL
         GKxdl7czcjYWJj0RGwlpCQVuTEeZoOGx9/JN4B+2ZQ7Ua9/Sw1/vDEAKU3acdnJ0kb47
         INrpOYmgLVM8zQKcI0fyF+qe8oso4JcNlAoVkQNsgwR1+NuXcdjHheBy+smrlkhcp5eJ
         r1FMu4QNNhZ9fMpcH29w2I3VJXEC7KrXl3CRYnNNs3WjeMr+pHzrEQ7YgXt9cxw3ceh7
         x8ZHEKjiDBS+jbOMgIFLEuP52ZB9nvQmN2yFqBYSmr2dMtszW55Abs9wN1eUmD49Z+rg
         aPQQ==
X-Gm-Message-State: AOJu0Yz1W/LLMFhUcOaIlsxqTKPBelF4DI4G0v/RrpRC/kDM0gfNZAUh
	ZEStYm6xH8cvwa8l0wqqMKT3XKccshwgLPZt6X4ixN7QPL7IP5tSnhtXWrw8Kg==
X-Gm-Gg: AZuq6aL5HbrJwBpYG+XSYRG/xe6LmBIrfPVClAtWgNtW50vondO305Oye2LckiJL045
	lG9RXlBeTn8uXa2y4WMp2cphjBARu/eBm8J2z7zup2wnzHdtjLaQNZHwjS/Dd413GtJXDYKiL4n
	RHGPj526G1kJ5pu3rXpf7FfIOSmk6itY64F4+I0wSm2SeTwt4M8zcYYkwI1pOPkz14gpFIGhDS6
	X3QcDQwZu16gSkS+urTmOLnGJIVWIZnXo9N5CYBFGXImHKOR8qvu3Tr+d/KkiJapMDY3uRHO1UC
	VI8E1+tR6mQ2Zxkybu2XWa4B0w+m+CUnjXjHVgYjLLpTPAu8qjbwTIoqEC1qfGwZx30t9iY8/mk
	GsDD0ocHq8Mu3RmynMGb7aj8CgHXMRMEvtpPABcrSy6JMfQnj7iaqSSyY9dcBSpqHqOxaBwL3mi
	kT+54NTlAaehdo3KpPVICeDdV5+vCGAQrQnkJdbGOG3c72xWHScg7a
X-Received: by 2002:a17:902:f64e:b0:2a9:63f4:120 with SMTP id d9443c01a7336-2ad744e4fb2mr16537715ad.3.1771662607122;
        Sat, 21 Feb 2026 00:30:07 -0800 (PST)
Received: from malon-Yoga-14sARE-2020.. ([111.223.90.163])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad74f5db00sm22146655ad.23.2026.02.21.00.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Feb 2026 00:30:06 -0800 (PST)
From: Tian Yuchen <a3205153416@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	karthik.188@gmail.com
Subject: [PATCH v9] setup: improve error diagnosis for invalid .git files
Date: Sat, 21 Feb 2026 16:30:01 +0800
Message-ID: <20260221083001.220061-1-a3205153416@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260220164512.216901-1-a3205153416@gmail.com>
References: <20260220164512.216901-1-a3205153416@gmail.com>
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

