Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD271422AC
	for <git@vger.kernel.org>; Fri, 17 May 2024 23:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715987770; cv=none; b=C4RM/4GMO8SLx+P+NeeSCM3816bRSMbd206/2H3/ZJl7r1okvGEJv6RwGtZt8ghT2nndYIqNk4xv482dmFaiP03GplYS+IGAT0McwpyXV4L+BstYUNXzkkyXSKnDeUwdeu+2W8jKsaQb5XZIR8q5rOiFM/ZQ+d9GB4lOEbLxero=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715987770; c=relaxed/simple;
	bh=ldVou3LjvRyszwlkSq0AhyfPkMxbgdNiKzyu2EBNRqU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=rW7Ue42zUbxBItL/uKzcmcSszRw5iE82cUj254PkHIYsLUxFVx1TBRSWZvVuQ3fR2d2jhcBPwV37BIvaITdOD4HI5N3FU+jfnNDK4DkayT+2x3fXiYl2au5kshlOk0HnOmwHegg7RHD2YrWSBY/EEl0c3dF/81jO7WRrdQ30TmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aBzA1/XM; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aBzA1/XM"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-351d79b56cdso504616f8f.1
        for <git@vger.kernel.org>; Fri, 17 May 2024 16:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715987767; x=1716592567; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zrr1+lMEsbdxBYmZl3ymH80XsSKj7Aucdz/ecD0EJAM=;
        b=aBzA1/XMtsHsC33i3bUuPH3h1tJNSebMrLPlch5jcT0l6OeEJ+ZpKGXOVvxO3oSei1
         DAMoCeckmO6byxv2iAfu8+qAcEvNUq5jJ7M5FYeBeA/xQxcw6pGDNmQB43oxwxOAIBoe
         AjxCq9Qc2g2SA2gDGJSh/vD1xpRKWXYeUuER/EBnsUaARaHrhy7wkKsR3DnTkj8YmA4z
         AwUmk+rnDMS0ZtROfxRbndamDCGeCsyXKpM9xXFst5SELNevJaSJRoT0odJxmuHokJnh
         6wW2QkOO5swC10a5ReZQP7tyR0X7Nv4bz3ut5MDod9pFd9hPVMod+HPyKW1+ewYtkin4
         Robg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715987767; x=1716592567;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zrr1+lMEsbdxBYmZl3ymH80XsSKj7Aucdz/ecD0EJAM=;
        b=o7D+DRSwn8xZ0ZDt8SltF7F4gl1X2pVHzcvzAJ4tSO3nAZbrZyfJOv+IHDWyh7Gibb
         oeRn7TVS3mxXTVzwEzleA0Nb8zhf1ypIFYr/INn07AltZN4MUAwQHoE0xwex/hN8xOqF
         nAZtgndps9uCQz2mgnJi+Rhx8nHZMJ9Pxxog4lbhEs3NtBinfv7/QwW7SxwkjsxivWw8
         OZz0m5YKi3YIlLLMykiAbN4FElY/D6fdzsmS+C8fekvUkio/dP9ZncHiVTpWWICnmmle
         6G/pQp8w6iwIdpE5QVxn8OdH2z9gahpeupJGfP2DkSlTHkFjyIzu7CQ1k5ymQs3BCF2W
         06hA==
X-Gm-Message-State: AOJu0Yyv+IFfxzfIvOXNrOefZ8nOLc7f6K4hEpmmtJ47aD6CqNtvtkFv
	fstEDwzMzqANcD2os9kTMbJjB7WrE9UoYW/PYl5BQQFXquPlvLnuG9hZ5g==
X-Google-Smtp-Source: AGHT+IFKRq93BVVoAz7GQ2hWZCDWA2qMzW531e0GT5jVVvjpcJluBi4LUeicFFGx1GLThUEOo9hCZg==
X-Received: by 2002:a5d:4fd0:0:b0:34c:9e0b:f24c with SMTP id ffacd0b85a97d-3504a7376acmr15174756f8f.37.1715987766741;
        Fri, 17 May 2024 16:16:06 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-351d2df8449sm6205395f8f.12.2024.05.17.16.16.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 May 2024 16:16:06 -0700 (PDT)
Message-Id: <c45c33d8e3f658c7cb4bd33000bb507333727468.1715987756.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1732.git.1715987756.gitgitgadget@gmail.com>
References: <pull.1732.git.1715987756.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 17 May 2024 23:15:56 +0000
Subject: [PATCH 8/8] Revert "Add a helper function to compare file contents"
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
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
