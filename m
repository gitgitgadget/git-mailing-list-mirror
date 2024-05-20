Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A3D139CEB
	for <git@vger.kernel.org>; Mon, 20 May 2024 20:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716236538; cv=none; b=IhfH38umyoEqcsT8Asdmy+d9QJDdY96SxBYe9ENyXLV1IxLwsGle2VqjV3l+/QX0fHE8Mkt7mKq6Px5bnvBTUoTZdfg/pqVpMcgZG7J7V34Qxz3deT7PZsAs/YHEX9jSWQukq5sfGiA5fCQQM5FfPFKmXVVPgO2Tv7G8a5se810=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716236538; c=relaxed/simple;
	bh=ldVou3LjvRyszwlkSq0AhyfPkMxbgdNiKzyu2EBNRqU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=FQrhCwBMS7nvBvxfbafuDB347dUr+wqa626C4enHT0qVqdpSw9lw6VuZOpBCtnZLzd7sl0S1PuUcQfQdg85tjxEfp/tvVsF0815+eFWWCkt0a3Qk443aVSjzIb5jx5SLtSwNXgAo6ycVJbLLMY4QRK006RgVClsm7F3LZcUql0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dDq0lp8S; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dDq0lp8S"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-34dc8d3fbf1so2068215f8f.1
        for <git@vger.kernel.org>; Mon, 20 May 2024 13:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716236534; x=1716841334; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zrr1+lMEsbdxBYmZl3ymH80XsSKj7Aucdz/ecD0EJAM=;
        b=dDq0lp8SOQEVKXlRMxWog0tTddaHE15USyg9SaFO3VT/me+3uGQx33St4t8j63HsTF
         HIk/An7wjJzr1onm/JS21lcyG92BCNDtJq6f/RnUpRtfDi8AeCrVxJmWI0Y0+atVz2pu
         43X6K/jTGO2Hs+xRWeyBYtKG8KB+C2xfKoM80kSU82QcIgC3L9zw6FBrlEpOgDzm+vQn
         PgeHa9Crl/OaZm1lLqrtQuo8X5taA0gL0yg+10frRqi5CkxXSpcqBv5lAR9yefJoduY2
         5wwe4JlNBsw1lNsEL+cAjswKLEKdA3A70QjvPAHk/dLzvZvlHu8s1rwQMLqYyG/+qxIg
         KGuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716236534; x=1716841334;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zrr1+lMEsbdxBYmZl3ymH80XsSKj7Aucdz/ecD0EJAM=;
        b=c5Jj9E4nvwkOtz8AD2u72/dTiN2ef49I1jJNybA71cEt55RvtknieMd7O7A7Rp9cdS
         0gcucHqWrRx2Fh3Fb7PY5zmQLtIxyWHv3MhRi4d2c4ZH/AYK8oITAz07okW9ObMtS2gy
         Qj+9ON5Q4QDrYuA77L90XIbWGt6PepiBUZ2uF6eq/u1InJNvlv+8NqdN+R0n6jiYKupw
         NE3JyIKOCW8NRvW/X5/MW27Y9csALjp8YyghWlNNLFQN9eu6eRN+yiWLFSStY4BdpN7V
         iOIi1SPbUTg99mxzoSME4++ahyvSOCuN/K7r2i/aC/Mmljjb0WgkssN5nEojM2juW2fa
         iqMg==
X-Gm-Message-State: AOJu0YzJOWkSWwsp6/8NaUyADVzw2/P3UCyLMqpSNrBJFFS7eJN+n/um
	xF+Jw/EQwwDlQRs78AsGKGI7oLZvJETPOsw+W6Hwa02M59rYNrUYUJhc5A==
X-Google-Smtp-Source: AGHT+IEEbXw4gHO6iGGo0lSfFCs06OMZoe0swFd5V4C2ctf9+IlryZL1uEF8ji0s4F6ef3VwGGIxSQ==
X-Received: by 2002:adf:c047:0:b0:351:c731:ed0b with SMTP id ffacd0b85a97d-351c731eec5mr11646173f8f.70.1716236534624;
        Mon, 20 May 2024 13:22:14 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502b79bc83sm29950250f8f.16.2024.05.20.13.22.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 13:22:14 -0700 (PDT)
Message-Id: <5c576e889d85b34fc717b693ba526cc46836f66a.1716236527.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1732.v3.git.1716236526.gitgitgadget@gmail.com>
References: <pull.1732.v2.git.1716028366.gitgitgadget@gmail.com>
	<pull.1732.v3.git.1716236526.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 20 May 2024 20:22:05 +0000
Subject: [PATCH v3 6/6] Revert "Add a helper function to compare file
 contents"
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
    Jeff King <peff@peff.net>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Now that during a `git clone`, the hooks' contents are no longer
compared to the templates' files', the caller for which the
`do_files_match()` function was introduced is gone, and therefore this
function can be retired, too.

This reverts commit 584de0b4c23 (Add a helper function to compare file
contents, 2024-03-30).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 cache.h                    | 14 ---------
 copy.c                     | 58 --------------------------------------
 t/helper/test-path-utils.c | 10 -------
 t/t0060-path-utils.sh      | 41 ---------------------------
 4 files changed, 123 deletions(-)

diff --git a/cache.h b/cache.h
index 16b34799bfd..8c5fb1e1ba1 100644
--- a/cache.h
+++ b/cache.h
@@ -1785,20 +1785,6 @@ int copy_fd(int ifd, int ofd);
 int copy_file(const char *dst, const char *src, int mode);
 int copy_file_with_time(const char *dst, const char *src, int mode);
 
-/*
- * Compare the file mode and contents of two given files.
- *
- * If both files are actually symbolic links, the function returns 1 if the link
- * targets are identical or 0 if they are not.
- *
- * If any of the two files cannot be accessed or in case of read failures, this
- * function returns 0.
- *
- * If the file modes and contents are identical, the function returns 1,
- * otherwise it returns 0.
- */
-int do_files_match(const char *path1, const char *path2);
-
 void write_or_die(int fd, const void *buf, size_t count);
 void fsync_or_die(int fd, const char *);
 int fsync_component(enum fsync_component component, int fd);
diff --git a/copy.c b/copy.c
index 8492f6fc831..4de6a110f09 100644
--- a/copy.c
+++ b/copy.c
@@ -65,61 +65,3 @@ int copy_file_with_time(const char *dst, const char *src, int mode)
 		return copy_times(dst, src);
 	return status;
 }
-
-static int do_symlinks_match(const char *path1, const char *path2)
-{
-	struct strbuf buf1 = STRBUF_INIT, buf2 = STRBUF_INIT;
-	int ret = 0;
-
-	if (!strbuf_readlink(&buf1, path1, 0) &&
-	    !strbuf_readlink(&buf2, path2, 0))
-		ret = !strcmp(buf1.buf, buf2.buf);
-
-	strbuf_release(&buf1);
-	strbuf_release(&buf2);
-	return ret;
-}
-
-int do_files_match(const char *path1, const char *path2)
-{
-	struct stat st1, st2;
-	int fd1 = -1, fd2 = -1, ret = 1;
-	char buf1[8192], buf2[8192];
-
-	if ((fd1 = open_nofollow(path1, O_RDONLY)) < 0 ||
-	    fstat(fd1, &st1) || !S_ISREG(st1.st_mode)) {
-		if (fd1 < 0 && errno == ELOOP)
-			/* maybe this is a symbolic link? */
-			return do_symlinks_match(path1, path2);
-		ret = 0;
-	} else if ((fd2 = open_nofollow(path2, O_RDONLY)) < 0 ||
-		   fstat(fd2, &st2) || !S_ISREG(st2.st_mode)) {
-		ret = 0;
-	}
-
-	if (ret)
-		/* to match, neither must be executable, or both */
-		ret = !(st1.st_mode & 0111) == !(st2.st_mode & 0111);
-
-	if (ret)
-		ret = st1.st_size == st2.st_size;
-
-	while (ret) {
-		ssize_t len1 = read_in_full(fd1, buf1, sizeof(buf1));
-		ssize_t len2 = read_in_full(fd2, buf2, sizeof(buf2));
-
-		if (len1 < 0 || len2 < 0 || len1 != len2)
-			ret = 0; /* read error or different file size */
-		else if (!len1) /* len2 is also 0; hit EOF on both */
-			break; /* ret is still true */
-		else
-			ret = !memcmp(buf1, buf2, len1);
-	}
-
-	if (fd1 >= 0)
-		close(fd1);
-	if (fd2 >= 0)
-		close(fd2);
-
-	return ret;
-}
diff --git a/t/helper/test-path-utils.c b/t/helper/test-path-utils.c
index 0e0de218076..f69709d674f 100644
--- a/t/helper/test-path-utils.c
+++ b/t/helper/test-path-utils.c
@@ -495,16 +495,6 @@ int cmd__path_utils(int argc, const char **argv)
 		return !!res;
 	}
 
-	if (argc == 4 && !strcmp(argv[1], "do_files_match")) {
-		int ret = do_files_match(argv[2], argv[3]);
-
-		if (ret)
-			printf("equal\n");
-		else
-			printf("different\n");
-		return !ret;
-	}
-
 	fprintf(stderr, "%s: unknown function name: %s\n", argv[0],
 		argv[1] ? argv[1] : "(there was none)");
 	return 1;
diff --git a/t/t0060-path-utils.sh b/t/t0060-path-utils.sh
index 73d0e1a7f10..68e29c904a6 100755
--- a/t/t0060-path-utils.sh
+++ b/t/t0060-path-utils.sh
@@ -560,45 +560,4 @@ test_expect_success !VALGRIND,RUNTIME_PREFIX,CAN_EXEC_IN_PWD '%(prefix)/ works'
 	test_cmp expect actual
 '
 
-test_expect_success 'do_files_match()' '
-	test_seq 0 10 >0-10.txt &&
-	test_seq -1 10 >-1-10.txt &&
-	test_seq 1 10 >1-10.txt &&
-	test_seq 1 9 >1-9.txt &&
-	test_seq 0 8 >0-8.txt &&
-
-	test-tool path-utils do_files_match 0-10.txt 0-10.txt >out &&
-
-	assert_fails() {
-		test_must_fail \
-		test-tool path-utils do_files_match "$1" "$2" >out &&
-		grep different out
-	} &&
-
-	assert_fails 0-8.txt 1-9.txt &&
-	assert_fails -1-10.txt 0-10.txt &&
-	assert_fails 1-10.txt 1-9.txt &&
-	assert_fails 1-10.txt .git &&
-	assert_fails does-not-exist 1-10.txt &&
-
-	if test_have_prereq FILEMODE
-	then
-		cp 0-10.txt 0-10.x &&
-		chmod a+x 0-10.x &&
-		assert_fails 0-10.txt 0-10.x
-	fi &&
-
-	if test_have_prereq SYMLINKS
-	then
-		ln -sf 0-10.txt symlink &&
-		ln -s 0-10.txt another-symlink &&
-		ln -s over-the-ocean yet-another-symlink &&
-		ln -s "$PWD/0-10.txt" absolute-symlink &&
-		assert_fails 0-10.txt symlink &&
-		test-tool path-utils do_files_match symlink another-symlink &&
-		assert_fails symlink yet-another-symlink &&
-		assert_fails symlink absolute-symlink
-	fi
-'
-
 test_done
-- 
gitgitgadget
