Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0CC4C6EF6
	for <git@vger.kernel.org>; Fri, 21 Aug 2026 14:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787322213; cv=none; b=C5OfaWkU+DH+7uDB6YCN5Z0BrtxhxL/XhA456twLs1H09bZ38qaDPias51red4f81eJfg4w3/vpl7b7isTt1bb9m+491xNfiR3ihaRqcWK5lWdiEDFgjlqewvCNg/XL+XPEJd7xN3yjnm9NDs+UPBE1QejiRbj0AD615+Ysh+tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787322213; c=relaxed/simple;
	bh=g9o+TTVFeiVKb4cJLa4FWnTWFidSsuOc5be5Bdj6XM4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=dq/Ma5UpWfzSvAFKE4gyhveyRtS5gg4i2fIZAy8zsdCjiYeBem1yYmTkm0b8wsuOaFrAaadGdE4djTYMBSvaNqxRGg7qIUe1lMhboUIbC/Pms5HA8tlQRvqzwvYC+AsNXcTGQPg4G0FgvlJeFAjEjq7AFR5EsC667UanMgiYd9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q+hRHPLS; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q+hRHPLS"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-84f38f3b36eso679587b3a.1
        for <git@vger.kernel.org>; Fri, 21 Aug 2026 07:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787322208; x=1787927008; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=y4XCY9NSj45V/REZJLyq/UNASKcmXubSD1izy4LVCbI=;
        b=Q+hRHPLS37afqv/KbMQioyZR3/YkvzqYA2anVmtLuvqOXvWilWY2a5t3L9hQp2qcoW
         Can2bvuHOPKMqcoo0+Ubuqo9SpVaBnqGNf8s72rkwKC42NP7IJzFUzw82f7+zSrKkLXU
         tF9fguKBR8cZ6t61XWf8SlQ3BT/okWvAFalwo1mqZtL1zs9+ezz/gCqccLivniqkAT43
         Y14vr55240wFurn5Vck4iZ28R4r1ajEGrGSoH75wnhCUTdVlW3RHZPRt4/ymAamcb1nY
         RStFlHtBjXJEf9Nx+dPPyA0LPYjqcFta/P8pAwtcjnTMxs/Mh6ocmyEvULhLGccPY8hT
         8JPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787322208; x=1787927008;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=y4XCY9NSj45V/REZJLyq/UNASKcmXubSD1izy4LVCbI=;
        b=OH9vTfVWRRn0qcEbScV1qywhPYbB43fdn07K+MM0/1Oktx77iUiJrB984/jlkyvEdr
         ta6M6hGkoFkIyjqIbC1f4J+j9RnK88cCnE0wEuGycW87dHSpTcxuzC+nGW5ACfzleUme
         R62+aJ/vdfAVJ+ma7bOIaC2aQoxp7xxPOeUV7mER9CQcBv5gGviuYGKWOfmrY2K3UMbu
         pT3DntEbGJa2xiHFje3c8aJWqXNeR6sH0x4btS8NI9kpnHcFjmaRLeT/oSNU2p4ial+3
         gXvwEYZZi6E9n7b/g5H42d0Y8b5v1PWHzC3VoJw1W5BQtG0hD1wxod3/Y2gJeEYIkd3P
         H61g==
X-Gm-Message-State: AFuF++mnj/YEpR99B273dFiR9LiECjdDISysGpfNazePSJPqYhcDjKka
	7Z5goW7OqaNbkNXQE9VFgTyrInKWgE4chJtJgGpgN06HB05YGxWfSPOXRf3kbjqf
X-Gm-Gg: AR+sD11O6LKv1N//ZrTv6wgdpxJMCN/XOecJasoHPWCp4xw1efSrLlWsYRxJncp6sSc
	/K85xBz9WIwzQfM6hLfahXCj0ZfXMBfX9BGF0rk1/2lSpf/LJqSo5M7Gb9gRBzeholPbjp0PVgr
	SBLgJkhcXDsfoO6prUu9fqrqdzvhDtj/BuxkI855SnAp+euT6puC/lLObtdUvkEyZiiCFJNs0gw
	uPBqhJdtc7Yyixc6RvwesPrERTH4hty+2eQaH0bXr/oAZaYiAB+DgN4qmKm51P1+UMOuBi5aail
	+lF35e5qiTq50C9pKXA3KEYmZN4DJ+AGIiX3+904D5Z12Vf4Tbia8hoBPffTFezz0qWvNtSzrA1
	8HUiy3+oG7IDxBFil93qKYNMN5tq8Adha553t9oF6KtxjkaSJVg1OC73JUarK73TdEvTQ6PeEb8
	Uaeh6yG4kzvDhn4Wk3b/AD6DhwSK04IiHS+OD07Tu1HUkmK+6opQ6LU2NmNzXQqA==
X-Received: by 2002:a05:6a00:8c2:b0:84e:24df:3870 with SMTP id d2e1a72fcca58-851f95a0290mr10294324b3a.0.1787322208273;
        Fri, 21 Aug 2026 07:23:28 -0700 (PDT)
Received: from [127.0.0.1] ([128.85.45.85])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc155238b85sm3154527a12.6.2026.08.21.07.23.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 07:23:27 -0700 (PDT)
Message-Id: <9c737bd600bac6b6645a10f6b36951985a99262d.1787322203.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2209.git.1787322203.gitgitgadget@gmail.com>
References: <pull.2209.git.1787322203.gitgitgadget@gmail.com>
From: "Alexey Samsonov via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 21 Aug 2026 14:23:23 +0000
Subject: [PATCH 3/3] compat/posix: drop legacy <utime.h> header and shims
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
Cc: Alexey Samsonov <vonosmas@gmail.com>,
    Alexey Samsonov <vonosmas@gmail.com>

From: Alexey Samsonov <vonosmas@gmail.com>

With all callers across the codebase now converted to utimensat(2), we no
longer need to include the legacy <utime.h> header in `compat/posix.h`.

Remove `#include <utime.h>` from `compat/posix.h` and test fixtures,
remove `mingw_utime()` from `compat/mingw.c`, and delete the legacy
header shims in `compat/vcbuild/include/`.

Signed-off-by: Alexey Samsonov <vonosmas@gmail.com>
---
 compat/mingw-posix.h               |  2 --
 compat/mingw.c                     | 16 --------------
 compat/posix.h                     |  1 -
 compat/vcbuild/include/sys/utime.h | 34 ------------------------------
 compat/vcbuild/include/utime.h     |  1 -
 t/helper/test-chmtime.c            |  1 -
 t/t4051/includes.c                 |  1 -
 7 files changed, 56 deletions(-)
 delete mode 100644 compat/vcbuild/include/sys/utime.h
 delete mode 100644 compat/vcbuild/include/utime.h

diff --git a/compat/mingw-posix.h b/compat/mingw-posix.h
index aab91d76db..286ca24002 100644
--- a/compat/mingw-posix.h
+++ b/compat/mingw-posix.h
@@ -384,8 +384,6 @@ int mingw_fstat(int fd, struct stat *buf);
 #define lstat mingw_lstat
 
 
-int mingw_utime(const char *file_name, const struct utimbuf *times);
-#define utime mingw_utime
 int mingw_utimensat(int fd, const char *path, const struct timespec times[2], int flag);
 #define utimensat mingw_utimensat
 size_t mingw_strftime(char *s, size_t max,
diff --git a/compat/mingw.c b/compat/mingw.c
index d09a976191..e2ec44fdd2 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -1480,22 +1480,6 @@ revert_attrs:
 	return rc;
 }
 
-int mingw_utime(const char *file_name, const struct utimbuf *times)
-{
-	struct timespec ts[2];
-	struct timespec *tsp = NULL;
-
-	if (times) {
-		ts[0].tv_sec = times->actime;
-		ts[0].tv_nsec = 0;
-		ts[1].tv_sec = times->modtime;
-		ts[1].tv_nsec = 0;
-		tsp = ts;
-	}
-
-	return mingw_utimensat(AT_FDCWD, file_name, tsp, 0);
-}
-
 #undef strftime
 size_t mingw_strftime(char *s, size_t max,
 		      const char *format, const struct tm *tm)
diff --git a/compat/posix.h b/compat/posix.h
index 3cac1751aa..435ed90f56 100644
--- a/compat/posix.h
+++ b/compat/posix.h
@@ -123,7 +123,6 @@
 #include <signal.h>
 #include <assert.h>
 #include <regex.h>
-#include <utime.h>
 #include <syslog.h>
 #if !defined(NO_POLL_H)
 #include <poll.h>
diff --git a/compat/vcbuild/include/sys/utime.h b/compat/vcbuild/include/sys/utime.h
deleted file mode 100644
index 582589c70a..0000000000
--- a/compat/vcbuild/include/sys/utime.h
+++ /dev/null
@@ -1,34 +0,0 @@
-#ifndef	_UTIME_H_
-#define	_UTIME_H_
-/*
- * UTIME.H
- * This file has no copyright assigned and is placed in the Public Domain.
- * This file is a part of the mingw-runtime package.
- *
- * The mingw-runtime package and its code is distributed in the hope that it
- * will be useful but WITHOUT ANY WARRANTY.  ALL WARRANTIES, EXPRESSED OR
- * IMPLIED ARE HEREBY DISCLAIMED.  This includes but is not limited to
- * warranties of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
- *
- * You are free to use this package and its code without limitation.
- */
-
-/*
- * Structure used by _utime function.
- */
-struct _utimbuf
-{
-	time_t	actime;		/* Access time */
-	time_t	modtime;	/* Modification time */
-};
-
-#ifndef	_NO_OLDNAMES
-/* NOTE: Must be the same as _utimbuf above. */
-struct utimbuf
-{
-	time_t	actime;
-	time_t	modtime;
-};
-#endif	/* Not _NO_OLDNAMES */
-
-#endif
diff --git a/compat/vcbuild/include/utime.h b/compat/vcbuild/include/utime.h
deleted file mode 100644
index 8285f38fde..0000000000
--- a/compat/vcbuild/include/utime.h
+++ /dev/null
@@ -1 +0,0 @@
-#include <sys/utime.h>
diff --git a/t/helper/test-chmtime.c b/t/helper/test-chmtime.c
index a9e6eb78b8..295f55cf47 100644
--- a/t/helper/test-chmtime.c
+++ b/t/helper/test-chmtime.c
@@ -38,7 +38,6 @@
  */
 #include "test-tool.h"
 #include "git-compat-util.h"
-#include <utime.h>
 
 static const char usage_str[] =
 	"(-v|--verbose|-g|--get) (+|=|=+|=-|-)<seconds> <file>...";
diff --git a/t/t4051/includes.c b/t/t4051/includes.c
index efc68f8bf6..4861f6657b 100644
--- a/t/t4051/includes.c
+++ b/t/t4051/includes.c
@@ -15,6 +15,5 @@
 #include <signal.h>
 #include <assert.h>
 #include <regex.h>
-#include <utime.h>
 #include <syslog.h>
 #include <End.h>
-- 
gitgitgadget
