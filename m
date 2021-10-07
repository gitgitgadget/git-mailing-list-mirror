Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E4FEC433F5
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 20:25:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DC0F6103B
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 20:25:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242277AbhJGU1h (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Oct 2021 16:27:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242051AbhJGU1T (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Oct 2021 16:27:19 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C7CEC061767
        for <git@vger.kernel.org>; Thu,  7 Oct 2021 13:25:24 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id r18so22795669wrg.6
        for <git@vger.kernel.org>; Thu, 07 Oct 2021 13:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=JOqUYR1gNN5dC4l619qnJyUVRtWrOcX2QPtEtyfe8Fs=;
        b=pKmeKJdWDMAqFBPXZNB4KaIZicudIe15QqlOBABWpqyBUvRh6mTKm5+agcD9+7WAL/
         aOvOHdnldaEhhp94Q90Ts13Cy4xpem0LX6iCm9qobn4QIMfaFKXL8Et8DX8FccLpUORh
         XAIOMKngpSDSDFst/KtPYbBsiyaWG5pGd7Mx4lp75RZNaBcKUmINVEqH9TY6TY2qWk++
         f/B/VlqwIIRVWXyToJgPH8fVM2sZ6PFpf69ufKV1i+OjOwwBYBTG2/NqWxINLQbGE4wc
         vLmLbSrO1bcHS/N19TnST91mJS2zbLO+yLKgh4qrBDiphHwclmkF1zSzSHnwavpDpNkh
         Dzcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=JOqUYR1gNN5dC4l619qnJyUVRtWrOcX2QPtEtyfe8Fs=;
        b=AcW/3uR8aPf9nksuW2dzl7VMdGW9nBwrC/zVQ9ymzfL/nsgukqRXQtxOWExmIYM0Sr
         yGCJI58L1B//amQXBozDSLZ+kK4M40qfIeoor6DoUOXTVGhboejUqWimFt7uK/ai9NLz
         mLdeZunjMmvFNLWp70eHf96lmjnWL725ZHU+GyB4r2n12mkMGREoZ2QnmQiUwP9h3epE
         Mu9hjHnJJjVfOc1w374w9GvhH4A9SaT2Ox2zhRr/wUAgjXhIis/Eu/qD1zKrSiY5+m7r
         Hhij3+R4BYF/O7O9eM/tQReyk0lAqvLkSFq3oeytq2W1WLy0cTixUN3j4FypTjI/0655
         pCIg==
X-Gm-Message-State: AOAM531RoYdEuZP6woIOF12P3lXKRB1ICOhks3lHqh91Y8zf8kIu4IAV
        ckIEZRcRDlvsmKhguh0q5nqw3jIVgvk=
X-Google-Smtp-Source: ABdhPJzddBZyCamb249JhDbucpnCTi6BGnkz2D5Wzswg+sZxBj2DRkMk6jAWb7iYJZk1ESSPlibSXg==
X-Received: by 2002:a05:600c:240a:: with SMTP id 10mr18514271wmp.170.1633638322946;
        Thu, 07 Oct 2021 13:25:22 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c17sm9049677wmr.15.2021.10.07.13.25.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 13:25:22 -0700 (PDT)
Message-Id: <6cbc2f758dfbfba4363fbdbf1a7a8102c52842ad.1633638316.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1081.v4.git.git.1633638315.gitgitgadget@gmail.com>
References: <pull.1081.v3.git.git.1632841817.gitgitgadget@gmail.com>
        <pull.1081.v4.git.git.1633638315.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 07 Oct 2021 20:25:03 +0000
Subject: [PATCH v4 07/19] Provide zlib's uncompress2 from compat/zlib-compat.c
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwen@google.com>,
        Carlo Marcelo Arenas =?UTF-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

This will be needed for reading reflog blocks in reftable.

Helped-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 Makefile                  |  7 +++
 ci/lib.sh                 |  1 +
 compat/.gitattributes     |  1 +
 compat/zlib-uncompress2.c | 95 +++++++++++++++++++++++++++++++++++++++
 config.mak.uname          |  5 +++
 configure.ac              | 13 ++++++
 6 files changed, 122 insertions(+)
 create mode 100644 compat/.gitattributes
 create mode 100644 compat/zlib-uncompress2.c

diff --git a/Makefile b/Makefile
index b57b2b0e78e..9dfab70f79b 100644
--- a/Makefile
+++ b/Makefile
@@ -256,6 +256,8 @@ all::
 #
 # Define NO_DEFLATE_BOUND if your zlib does not have deflateBound.
 #
+# Define NO_UNCOMPRESS2 if your zlib does not have uncompress2.
+#
 # Define NO_NORETURN if using buggy versions of gcc 4.6+ and profile feedback,
 # as the compiler can crash (http://gcc.gnu.org/bugzilla/show_bug.cgi?id=49299)
 #
@@ -1718,6 +1720,11 @@ ifdef NO_DEFLATE_BOUND
 	BASIC_CFLAGS += -DNO_DEFLATE_BOUND
 endif
 
+ifdef NO_UNCOMPRESS2
+	BASIC_CFLAGS += -DNO_UNCOMPRESS2
+	REFTABLE_OBJS += compat/zlib-uncompress2.o
+endif
+
 ifdef NO_POSIX_GOODIES
 	BASIC_CFLAGS += -DNO_POSIX_GOODIES
 endif
diff --git a/ci/lib.sh b/ci/lib.sh
index 476c3f369f5..5711c63979d 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -224,6 +224,7 @@ linux-gcc-default)
 	;;
 Linux32)
 	CC=gcc
+	MAKEFLAGS="$MAKEFLAGS NO_UNCOMPRESS2=1"
 	;;
 linux-musl)
 	CC=gcc
diff --git a/compat/.gitattributes b/compat/.gitattributes
new file mode 100644
index 00000000000..40dbfb170da
--- /dev/null
+++ b/compat/.gitattributes
@@ -0,0 +1 @@
+/zlib-uncompress2.c	whitespace=-indent-with-non-tab,-trailing-space
diff --git a/compat/zlib-uncompress2.c b/compat/zlib-uncompress2.c
new file mode 100644
index 00000000000..3dcb90b2839
--- /dev/null
+++ b/compat/zlib-uncompress2.c
@@ -0,0 +1,95 @@
+/* taken from zlib's uncompr.c
+
+   commit cacf7f1d4e3d44d871b605da3b647f07d718623f
+   Author: Mark Adler <madler@alumni.caltech.edu>
+   Date:   Sun Jan 15 09:18:46 2017 -0800
+
+       zlib 1.2.11
+
+*/
+
+#include "../reftable/system.h"
+#define z_const
+
+/*
+ * Copyright (C) 1995-2003, 2010, 2014, 2016 Jean-loup Gailly, Mark Adler
+ * For conditions of distribution and use, see copyright notice in zlib.h
+ */
+
+#include <zlib.h>
+
+/* clang-format off */
+
+/* ===========================================================================
+     Decompresses the source buffer into the destination buffer.  *sourceLen is
+   the byte length of the source buffer. Upon entry, *destLen is the total size
+   of the destination buffer, which must be large enough to hold the entire
+   uncompressed data. (The size of the uncompressed data must have been saved
+   previously by the compressor and transmitted to the decompressor by some
+   mechanism outside the scope of this compression library.) Upon exit,
+   *destLen is the size of the decompressed data and *sourceLen is the number
+   of source bytes consumed. Upon return, source + *sourceLen points to the
+   first unused input byte.
+
+     uncompress returns Z_OK if success, Z_MEM_ERROR if there was not enough
+   memory, Z_BUF_ERROR if there was not enough room in the output buffer, or
+   Z_DATA_ERROR if the input data was corrupted, including if the input data is
+   an incomplete zlib stream.
+*/
+int ZEXPORT uncompress2 (
+    Bytef *dest,
+    uLongf *destLen,
+    const Bytef *source,
+    uLong *sourceLen) {
+    z_stream stream;
+    int err;
+    const uInt max = (uInt)-1;
+    uLong len, left;
+    Byte buf[1];    /* for detection of incomplete stream when *destLen == 0 */
+
+    len = *sourceLen;
+    if (*destLen) {
+        left = *destLen;
+        *destLen = 0;
+    }
+    else {
+        left = 1;
+        dest = buf;
+    }
+
+    stream.next_in = (z_const Bytef *)source;
+    stream.avail_in = 0;
+    stream.zalloc = (alloc_func)0;
+    stream.zfree = (free_func)0;
+    stream.opaque = (voidpf)0;
+
+    err = inflateInit(&stream);
+    if (err != Z_OK) return err;
+
+    stream.next_out = dest;
+    stream.avail_out = 0;
+
+    do {
+        if (stream.avail_out == 0) {
+            stream.avail_out = left > (uLong)max ? max : (uInt)left;
+            left -= stream.avail_out;
+        }
+        if (stream.avail_in == 0) {
+            stream.avail_in = len > (uLong)max ? max : (uInt)len;
+            len -= stream.avail_in;
+        }
+        err = inflate(&stream, Z_NO_FLUSH);
+    } while (err == Z_OK);
+
+    *sourceLen -= len + stream.avail_in;
+    if (dest != buf)
+        *destLen = stream.total_out;
+    else if (stream.total_out && err == Z_BUF_ERROR)
+        left = 1;
+
+    inflateEnd(&stream);
+    return err == Z_STREAM_END ? Z_OK :
+           err == Z_NEED_DICT ? Z_DATA_ERROR  :
+           err == Z_BUF_ERROR && left + stream.avail_out ? Z_DATA_ERROR :
+           err;
+}
diff --git a/config.mak.uname b/config.mak.uname
index 76516aaa9a5..9399247cbb3 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -258,6 +258,10 @@ ifeq ($(uname_S),FreeBSD)
 	FILENO_IS_A_MACRO = UnfortunatelyYes
 endif
 ifeq ($(uname_S),OpenBSD)
+	# Versions < 7.0 need compatibility layer
+	ifeq ($(shell expr "$(uname_R)" : "[1-6]\."),2)
+		NO_UNCOMPRESS2 = UnfortunatelyYes
+	endif
 	NO_STRCASESTR = YesPlease
 	NO_MEMMEM = YesPlease
 	USE_ST_TIMESPEC = YesPlease
@@ -513,6 +517,7 @@ ifeq ($(uname_S),Interix)
 	endif
 endif
 ifeq ($(uname_S),Minix)
+	NO_UNCOMPRESS2 = YesPlease
 	NO_IPV6 = YesPlease
 	NO_ST_BLOCKS_IN_STRUCT_STAT = YesPlease
 	NO_NSEC = YesPlease
diff --git a/configure.ac b/configure.ac
index 031e8d3fee8..c3a913103d0 100644
--- a/configure.ac
+++ b/configure.ac
@@ -672,9 +672,22 @@ AC_LINK_IFELSE([ZLIBTEST_SRC],
 	NO_DEFLATE_BOUND=yes])
 LIBS="$old_LIBS"
 
+AC_DEFUN([ZLIBTEST_UNCOMPRESS2_SRC], [
+AC_LANG_PROGRAM([#include <zlib.h>],
+ [uncompress2(NULL,NULL,NULL,NULL);])])
+AC_MSG_CHECKING([for uncompress2 in -lz])
+old_LIBS="$LIBS"
+LIBS="$LIBS -lz"
+AC_LINK_IFELSE([ZLIBTEST_UNCOMPRESS2_SRC],
+	[AC_MSG_RESULT([yes])],
+	[AC_MSG_RESULT([no])
+	NO_UNCOMPRESS2=yes])
+LIBS="$old_LIBS"
+
 GIT_UNSTASH_FLAGS($ZLIB_PATH)
 
 GIT_CONF_SUBST([NO_DEFLATE_BOUND])
+GIT_CONF_SUBST([NO_UNCOMPRESS2])
 
 #
 # Define NEEDS_SOCKET if linking with libc is not enough (SunOS,
-- 
gitgitgadget

