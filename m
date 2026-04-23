Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A4B35CBCB
	for <git@vger.kernel.org>; Thu, 23 Apr 2026 16:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776960569; cv=none; b=HhYK0Qhy+JQww5lv7zOisrhwy7Rk9C7FKyLxkCMWG/BNTgV8s/t83Ue4hvzplfxvDQ9qi7yUyFuVZg7jDlYlz+D4XljLFIFBh73LzvABz+rs4lCbuyOEcknJLa/8ru8eX0ynmXdmb9DS6gj3X5evTrnmOLRZlrksYBPOLtc7qMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776960569; c=relaxed/simple;
	bh=4KrB8V2soIkMFQ3yKsXtw1yFg6IejgY1Q+7z1KlC9bE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O3DZh/M3b8UoihbvMJtsZgolqOk45OQ2oSjfhBapsB6sqv6y5HU3usZ/qvQ3sM8CCJhTEcx0wy24MqSlSZAeErzcOrA1sSFD5D39LkWOiNNES/GFmOVxQzPso5CWA3RhaO9eoOHo4V/itB96TpB+0SZoFkSRsGYYIENvJDpCH7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eiVxYQ7f; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eiVxYQ7f"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-79a7109f568so83348037b3.1
        for <git@vger.kernel.org>; Thu, 23 Apr 2026 09:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776960567; x=1777565367; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cGKL+EnVICh/jyc+yvMql0ikOORR6KDKj/RgXtx/O3U=;
        b=eiVxYQ7fbgUaV2D0Hvc0TLSFEhZYMnVJzLSG/QgLl2W4AuRctx73UKeSObSTofjc2G
         QXf85gqr2jKR5EsgjGx4WgstTMCEOwlqT32qvJIlM+5hk+Em/aA+C1uI/5dlkRF5q/db
         oI1mUM/jbbapfNvZiYUP2GQbDQCpzC+E1WHvRIadYG9tnD0xjsN+OojI//FU4E6HHaEU
         mI2JjRZZ7Xp7rUn8quYaqFwA9lbrY0t12uhQDACJWW9j05ZflRLnc5IrLtBn9YOq9c5/
         logUoenRU7MsdSiIsaCq5PFlKkqfP72ZK04uRyPBq2C3ARZfNhDWSWvYORcjOjY/m3hE
         SF2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776960567; x=1777565367;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cGKL+EnVICh/jyc+yvMql0ikOORR6KDKj/RgXtx/O3U=;
        b=JWGGBchrFq9C/v+AyYofA7TbLCcdt79W5G3T6khl2cUEZASQbKfL/LlKYqYPF85BHq
         hCv2JgLXjfRqLpdo7ncBzwOD50ttJzsXXM7OqVDYOzl/OFguLLfAG3v/vO9uc/kgnzjM
         Hi+kYwEx0avpcmeD09oRYhX55DawiLzn2Db2gakQY+51+eSbvX4DQqyMgUEwOOYPyRKi
         vR+J5kkxajN/yTUXgJNT2sjIrhyrIrwrodyL/m3mnoTfrwN4rxTW4Ckt+d1QRnGk1cRw
         M3yLLqA/irTaCqVL5Pi92rgqK0JY2VeSFbbb28xzLIc6hkG775ARqv+DkKWBgbbHTueO
         8hvA==
X-Gm-Message-State: AOJu0YwvLhh528w/fV91F6PPw0XgrRzSod86jXnLyqbcuEzwks+ghXIi
	h1Kh8TjMxAA1S9J5GdvmkNC8Jnw1MfcaT0AwzWgyO59Dh5klIOfGn2X9qhW6Shng
X-Gm-Gg: AeBDieuym7eyJ1KBy9vfizswJCcT6aBpBSxCVInNv3IfXWaQcrm88D94irriJWFbFWs
	++59vEj8QfnJJ/kB1HdLNOv67deiD610jgpe7qghHt0fazSiPde4cdtaQGB74i5V2m8IijlQHOR
	iOAM0TVAa2GS7DY1fisjqoqd2T36OG0faEstquLdduPu7o3P7NQPc4fK1CsolW+gF1RSmCrznnV
	NbZwpWon7IhTgKnUjSzqBHzm4aUeNeFHDdr7Ar+G4nfLZbC781C7+4ZQAXGJ2YW4nNZaoHjXwu4
	d+TRFPWo/n7ORQsyEZVV79QWISs7Ra4FAfB6r766vGGdvL2ltSRSBMfV1cYUB3bD2RTkfqblDMd
	5csBMS9NZhCsaX6zF1LMtD3q6Z0bKwaCfUk/8uKjkYYllzYlzShtFBe6WXJsf3FUV/i0UoI8z4j
	8DJ6hnJkpl1LVvCIP2ETss/p49PzzQ+GNUw4ulR6B3aP2UFezalGXDhpCNJ5kJRslAEMf8oA==
X-Received: by 2002:a05:690c:6c0d:b0:7b4:378c:f732 with SMTP id 00721157ae682-7b9ed0477e1mr285135767b3.46.1776960567263;
        Thu, 23 Apr 2026 09:09:27 -0700 (PDT)
Received: from pop-os.lan ([2605:59c0:e5f:a910:737e:f405:338f:9bbf])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7baeeaa2cb5sm51083997b3.21.2026.04.23.09.09.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 09:09:26 -0700 (PDT)
From: Olamide Caleb Bello <belkid98@gmail.com>
To: git@vger.kernel.org
Cc: phillip.wood123@gmail.com,
	gitster@pobox.com,
	christian.couder@gmail.com,
	usmanakinyemi202@gmail.com,
	kaartic.sivaraam@gmail.com,
	me@ttaylorr.com
Subject: [PATCH v3 1/8] Revert "compat/posix: introduce writev(3p) wrapper"
Date: Thu, 23 Apr 2026 17:08:25 +0100
Message-ID: <20260423160832.114816-2-belkid98@gmail.com>
X-Mailer: git-send-email 2.53.0.155.g9f36b15afa
In-Reply-To: <20260423160832.114816-1-belkid98@gmail.com>
References: <CAOLa=ZQDXn7181VfHpcWtNOSjTh9nzM3YnDTG_X1Vqh_v64bwg@mail.gmail.com>
 <20260423160832.114816-1-belkid98@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Junio C Hamano <gitster@pobox.com>

This reverts commit 3b9b2c2a29a1d529ca9884fa0a6529f6e2496abe; let's
not use writev() for now.
---
 Makefile         |  4 ----
 compat/posix.h   | 14 --------------
 compat/writev.c  | 44 --------------------------------------------
 config.mak.uname |  2 --
 meson.build      |  1 -
 5 files changed, 65 deletions(-)
 delete mode 100644 compat/writev.c

diff --git a/Makefile b/Makefile
index 5d22394c2e..cedc234173 100644
--- a/Makefile
+++ b/Makefile
@@ -2029,10 +2029,6 @@ ifdef NO_PREAD
 	COMPAT_CFLAGS += -DNO_PREAD
 	COMPAT_OBJS += compat/pread.o
 endif
-ifdef NO_WRITEV
-	COMPAT_CFLAGS += -DNO_WRITEV
-	COMPAT_OBJS += compat/writev.o
-endif
 ifdef NO_FAST_WORKING_DIRECTORY
 	BASIC_CFLAGS += -DNO_FAST_WORKING_DIRECTORY
 endif
diff --git a/compat/posix.h b/compat/posix.h
index 94699a03fa..faaae1b655 100644
--- a/compat/posix.h
+++ b/compat/posix.h
@@ -137,9 +137,6 @@
 #include <sys/socket.h>
 #include <sys/ioctl.h>
 #include <sys/statvfs.h>
-#ifndef NO_WRITEV
-#include <sys/uio.h>
-#endif
 #include <termios.h>
 #ifndef NO_SYS_SELECT_H
 #include <sys/select.h>
@@ -326,17 +323,6 @@ int git_lstat(const char *, struct stat *);
 ssize_t git_pread(int fd, void *buf, size_t count, off_t offset);
 #endif
 
-#ifdef NO_WRITEV
-#define writev git_writev
-#define iovec git_iovec
-struct git_iovec {
-	void *iov_base;
-	size_t iov_len;
-};
-
-ssize_t git_writev(int fd, const struct iovec *iov, int iovcnt);
-#endif
-
 #ifdef NO_SETENV
 #define setenv gitsetenv
 int gitsetenv(const char *, const char *, int);
diff --git a/compat/writev.c b/compat/writev.c
deleted file mode 100644
index 3a94870a2f..0000000000
--- a/compat/writev.c
+++ /dev/null
@@ -1,44 +0,0 @@
-#include "../git-compat-util.h"
-#include "../wrapper.h"
-
-ssize_t git_writev(int fd, const struct iovec *iov, int iovcnt)
-{
-	size_t total_written = 0;
-	size_t sum = 0;
-
-	/*
-	 * According to writev(3p), the syscall shall error with EINVAL in case
-	 * the sum of `iov_len` overflows `ssize_t`.
-	 */
-	 for (int i = 0; i < iovcnt; i++) {
-		if (iov[i].iov_len > maximum_signed_value_of_type(ssize_t) ||
-		    iov[i].iov_len + sum > maximum_signed_value_of_type(ssize_t)) {
-			errno = EINVAL;
-			return -1;
-		}
-
-		sum += iov[i].iov_len;
-	}
-
-	for (int i = 0; i < iovcnt; i++) {
-		const char *bytes = iov[i].iov_base;
-		size_t iovec_written = 0;
-
-		while (iovec_written < iov[i].iov_len) {
-			ssize_t bytes_written = xwrite(fd, bytes + iovec_written,
-						       iov[i].iov_len - iovec_written);
-			if (bytes_written < 0) {
-				if (total_written)
-					goto out;
-				return bytes_written;
-			}
-			if (!bytes_written)
-				goto out;
-			iovec_written += bytes_written;
-			total_written += bytes_written;
-		}
-	}
-
-out:
-	return (ssize_t) total_written;
-}
diff --git a/config.mak.uname b/config.mak.uname
index ccb3f71881..5feb582558 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -459,7 +459,6 @@ ifeq ($(uname_S),Windows)
 	SANE_TOOL_PATH ?= $(msvc_bin_dir_msys)
 	HAVE_ALLOCA_H = YesPlease
 	NO_PREAD = YesPlease
-	NO_WRITEV = YesPlease
 	NEEDS_CRYPTO_WITH_SSL = YesPlease
 	NO_LIBGEN_H = YesPlease
 	NO_POLL = YesPlease
@@ -675,7 +674,6 @@ ifeq ($(uname_S),MINGW)
 	pathsep = ;
 	HAVE_ALLOCA_H = YesPlease
 	NO_PREAD = YesPlease
-	NO_WRITEV = YesPlease
 	NEEDS_CRYPTO_WITH_SSL = YesPlease
 	NO_LIBGEN_H = YesPlease
 	NO_POLL = YesPlease
diff --git a/meson.build b/meson.build
index 8309942d18..11488623bf 100644
--- a/meson.build
+++ b/meson.build
@@ -1429,7 +1429,6 @@ checkfuncs = {
   'initgroups' : [],
   'strtoumax' : ['strtoumax.c', 'strtoimax.c'],
   'pread' : ['pread.c'],
-  'writev' : ['writev.c'],
 }
 
 if host_machine.system() == 'windows'
-- 
2.53.0.155.g9f36b15afa

