Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5DA274B4A
	for <git@vger.kernel.org>; Wed, 18 Feb 2026 05:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771391970; cv=none; b=uwQpfrvtWoFvEvZX5pVUIO6qdFjU7zHnzCwDm271mrVgg6I9TvH+E86+/WEJxnI+3GHBFrgaXQdUGx8Pr+ehWiwGC1je2XhsJdMVDSMwt6CTVcwhTgylAqXJRekwZWaDinZwe+P1yaAYgRzMNX+5zpWHu/ZbKIH6BKtxvGdOcAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771391970; c=relaxed/simple;
	bh=c3lYBjAilnNPHPA6CbpO318sPIsVhprqQPj+dxgITFc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E0XZN6GSqraXKyAgXNbwIQueZHFss5pPxs43HFdzzpJCSeDQhxIVHiM575bLLjU/PZrjfNAhCCXseUnDKP/NGfdn3BWaYwD/AVXgbAae+n10R68O9uXplhTq2XI27cAkC4jMA6XVyFnQcmNVIQALGPFPjQOmDzTO3SgLTA34AME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ztufql2G; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ztufql2G"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8218237420eso635488b3a.1
        for <git@vger.kernel.org>; Tue, 17 Feb 2026 21:19:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771391968; x=1771996768; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kTDWn8FKrbmOpFBYOgI2JUAbdAKzLJUgwPFRoTFIFEs=;
        b=Ztufql2G1SBHu+UplECEGFJhgSP3XrhakL2Ec/2/3hWedD+jZIgJrb+GL7FY8qLFH4
         pMrnoIglgcgd183MfFMwUMHT+SfEI7HLrp9X6BoCkVoqGbV2hxTVCQQk7QDv7FByDEOl
         OxKznjlWNhqgceBHYJN45OQ7DkkCsS5h9/G5cgFCHfJq8sKAXGlVRCQhYP+ZhoHLiLCs
         R5eer+hfYnEHKlLd9vMSNYQOACG5jlagOt8/KMQPb3ABburmHHsuIsvvzcEKRZoicCxg
         7zuJr0bQlisHnKaTvVR6t7/J3CkQ4wqiCqW9NUGwCGLomVh0lBu2CQkpBtbi0HO2oxM2
         NacA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771391968; x=1771996768;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kTDWn8FKrbmOpFBYOgI2JUAbdAKzLJUgwPFRoTFIFEs=;
        b=p9Pq177gxrqYKn08Ax9fFALFLU9P/C7sAwD6V3LZBq1Wl1Wag2PY+m4h70PEIDtl4Z
         NjA5EpUmcT2FWfqsoukV/+gdpnKJjhi0NnE6EEcgHJ4N5XC7E2ILXT4pJ0h34EApQ5Af
         aBtSHj9gKGuFORz3z78MgaCvX2A0TkI0p0uuppk7Ab7WsgYYoWlLBXK+nJId4/21r2Up
         79aGsRw+B5gQI52gF2sKq570yyoldA8wMLKJcctBNiCOxPDWPKl65ftxvhBTheC+ZGpC
         NG1rehopxFyUfLOjv9ohRpE6UgC9Wqi7d951gRYUvgju3jg5af29Kt6eaQE8pZ8utbFC
         X+cQ==
X-Gm-Message-State: AOJu0YxdKrq0VC0YgaZCmv2lOvFpCbYq+IEidv4MJJHwy126Z1w0VGg2
	tW0YNumjAppYx+daW3UJC19JAbRckhGxb9CfiH7dXF0DiC9A84gxHpLx9JdRvw==
X-Gm-Gg: AZuq6aJ9PFpkDn52f3m52FvFbfLB0+r4kOsOUbZJrxsHNlJaL3HbzJYM5vHMMPV6jjk
	BWKX2GdxbQ45U/o+rT47W7us0TUWnjsdBVDpvUKkFDOiPacfGJknqIQSXHgWhjziE4daHWAYBOA
	lF13Qp+M4/UVRT/xmwvZgTxwd9rGHEsIbyZIaP4s+heu6Bd+xR+i4/0TH/g0WMR9UB9DtqqZzqE
	K/muJ6+ICxVtI7IO+yzT8X6KpSLU9WJvRc0dPrHi8l4TYNV+K/+lmsotbSGI6kQWJo+f3m51Ewe
	aiGq0wM68ixk1nAxtSbKdm33zDGqZsCV2SDtAVkTUdSjSzPcBQ5Ipoe8xcGmaGtolG1n89/2voV
	kaJi7DMgBzDupOe1r1bwkXZ9bfdtqzbTaNmZckkIwZjRm1cO5/7UUKqDuf8O42QSmoXYKjeTm5T
	dFIjzqnNOM9O2fNNLdsT1nPgjVFEg6Kt6Icz1q+no=
X-Received: by 2002:a05:6a00:3207:b0:81f:4546:cdff with SMTP id d2e1a72fcca58-824c5ec678emr9093964b3a.3.1771391967760;
        Tue, 17 Feb 2026 21:19:27 -0800 (PST)
Received: from malon-Yoga-14sARE-2020.. ([155.69.180.3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-824c6b9a661sm15047688b3a.50.2026.02.17.21.19.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 21:19:27 -0800 (PST)
From: Tian Yuchen <a3205153416@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	karthik.188@gmail.com
Subject: [PATCH v5 2/2] setup: allow cwd/.git to be a symlink to a directory
Date: Wed, 18 Feb 2026 13:18:50 +0800
Message-ID: <20260218051850.164972-3-a3205153416@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260218051850.164972-1-a3205153416@gmail.com>
References: <20260217084124.150366-1-a3205153416@gmail.com>
 <20260218051850.164972-1-a3205153416@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Strictly enforcing 'lstat()' prevents valid '.git' symlinks.

Switch 'setup_git_directory_gently_1()' to use 'stat()' to allow
filesystem resolution.

Calling the refactored 'read_gitfile_error_die()' to ensure safety:

1. Happy cases ('ENOENT', 'IS_A_DIR') are ignored automatically;
2. Invalid types (like FIFOs and sockets) trigger 'die()' via
   'NOT_A_FILE'.

Add 't/t0009-git-dir-validation.sh' to verify symlink support and FIFO
rejection, and register it in 't/meson.build'.

Signed-off-by: Tian Yuchen <a3205153416@gmail.com>
---
 setup.c                       | 18 ++++-----
 t/meson.build                 |  1 +
 t/t0009-git-dir-validation.sh | 72 +++++++++++++++++++++++++++++++++++
 3 files changed, 81 insertions(+), 10 deletions(-)
 create mode 100755 t/t0009-git-dir-validation.sh

diff --git a/setup.c b/setup.c
index 0ca129623e..6e6068e5eb 100644
--- a/setup.c
+++ b/setup.c
@@ -1590,17 +1590,15 @@ static enum discovery_result setup_git_directory_gently_1(struct strbuf *dir,
 		gitdirenv = read_gitfile_gently(dir->buf, die_on_error ?
 						NULL : &error_code);
 		if (!gitdirenv) {
-			if (die_on_error ||
-			    error_code == READ_GITFILE_ERR_NOT_A_FILE) {
-				/* NEEDSWORK: fail if .git is not file nor dir */
-				if (is_git_directory(dir->buf)) {
-					gitdirenv = DEFAULT_GIT_DIR_ENVIRONMENT;
-					gitdir_path = xstrdup(dir->buf);
-				}
-			} else if (error_code != READ_GITFILE_ERR_STAT_FAILED)
-				return GIT_DIR_INVALID_GITFILE;
-		} else
+			if (error_code)
+				read_gitfile_error_die(error_code, dir->buf, NULL);
+			if (is_git_directory(dir->buf)) {
+				gitdirenv = DEFAULT_GIT_DIR_ENVIRONMENT;
+				gitdir_path = xstrdup(dir->buf);
+			}
+		} else {
 			gitfile = xstrdup(dir->buf);
+		}
 		/*
 		 * Earlier, we tentatively added DEFAULT_GIT_DIR_ENVIRONMENT
 		 * to check that directory for a repository.
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

