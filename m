Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA056C4332F
	for <git@archiver.kernel.org>; Mon, 17 Jan 2022 17:20:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239135AbiAQRUg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Jan 2022 12:20:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242803AbiAQRTR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Jan 2022 12:19:17 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7053C03327C
        for <git@vger.kernel.org>; Mon, 17 Jan 2022 09:13:55 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id w26so21922292wmi.0
        for <git@vger.kernel.org>; Mon, 17 Jan 2022 09:13:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JHFWYWZGznUOxQN8K7ynGvD6b5lYksk46qgvBlyz6O8=;
        b=e4qzctt5PuZhIx8QGKcjFr1ZcozXwqevCP50JyoZSpBHSR6mx7cxtYA74w8HRlPBmS
         SzJ79dwhNbymx/H8O8MtWNmG5krsG7afq629P6lCi4Y3zotN7zuuWEfFdIX2QJTEiCRq
         +TEfhh9SxH5jTy27fR/XQ2zTWk7xdpTE4RByaZZwbDKAe9WWSffDw0vZmh3wpEqJTbuh
         a8YR6S0vCM/pYSGsKrlhdCX2gPygZ1ZWfvA0itdr3PLR/cl+lSSaRVAkbOM+WmXu/DoB
         fZ6UKaaIm8DCmjwZnMwv62OFOsdywFcD16wf/gxM7q3Qpo8E11r3SdWVSrJNvDlSmhip
         e5lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JHFWYWZGznUOxQN8K7ynGvD6b5lYksk46qgvBlyz6O8=;
        b=cg24F/J04C9ifk2xaL2kFFDiUeK/NIkxFqnghcrtlT+0WGcIO2WUwKdxZxRAJ4ZU5Q
         wCJQXbcajM/GshuADzwBFySzmOTX3x4VF5iapplXisQsH/UKRdo1FRlkYp01N9vR+4wq
         RoV2DrBSpG0BggUEaHqaW50G+NevYN7owkPC8JmajV3xUGI8x35hlwzkZikyUSZN49uF
         8owbSJkRW3jZmF2sqLjxhLTvRIhW4vxodmuBvpj+LTu8VkhLJfZwAt/yZcFOr6q9QLl+
         +R76qTw9PU3sc5xf1OozI7sDWPwZIgk0TGgVZlvJ5dffnHmegGV+c/0gp6O2CUTFouM/
         V0Rw==
X-Gm-Message-State: AOAM5316kiDPhPH5oRm7Apq+umToV7Qwl9l4EcjpGT6u0wbwQ+Vas9EP
        Valstt4pWrP7y2Axi5/xfs6fDd9yD0g=
X-Google-Smtp-Source: ABdhPJyDRityaX3gU+5ecWzoofXoZNqNgLfXIDSImwh5DWxb8cbfgzQUk7xMwbDOynrVEpw8W5uhQg==
X-Received: by 2002:adf:f390:: with SMTP id m16mr20782053wro.651.1642439633921;
        Mon, 17 Jan 2022 09:13:53 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id d3sm4096273wmq.14.2022.01.17.09.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jan 2022 09:13:53 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        David Aguilar <davvid@gmail.com>,
        "Randall S . Becker" <randall.becker@nexbridge.ca>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] cache.h: auto-detect if zlib has uncompress2()
Date:   Mon, 17 Jan 2022 18:13:42 +0100
Message-Id: <patch-1.1-9cea01a1395-20220117T170457Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.0.rc1.855.gbd520c8f475
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the NO_UNCOMPRESS2=Y setting to auto-detect those older zlib
versions that don't have uncompress2().

This makes the compilation of git less annoying on older systems,
since the inclusion of a322920d0bb (Provide zlib's uncompress2 from
compat/zlib-compat.c, 2021-10-07) in v2.35.0-rc0 our default
dependency on a zlib 1.2.9 or newer unless NO_UNCOMPRESS2=Y is
specified has resulted in errors when git is compiled.

To get around those errors we've needed to bundle config.mak.uname
changes such as such as 68d1da41c4e (build: NonStop ships with an
older zlib, 2022-01-10) and the in-flight
https://lore.kernel.org/git/20220116020520.26895-1-davvid@gmail.com/.

Let's instead rely on ZLIB_VERNUM. Now only those systems where zlib
is so broken that it can't be rely on (such a system probably doesn't
exist) need to provide a NO_UNCOMPRESS2=Y.

See 9da3acfb194 ([PATCH] compat: support pre-1.2 zlib, 2005-04-30) and
609a2289d76 (Improve accuracy of check for presence of deflateBound.,
2007-11-07) for in-tree prior art using ZLIB_VERNUM.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

I think this should be strongly considered for inclusion before the
final v2.35.0 release.

Aside from the ones already (and in-flight) in config.mak.uname, I've
run into numerous other cases where NO_UNCOMPRESS2=y is needed (so far
gcc{10,14,45,111,119,135,210} on the GCC farm). Adding
config.mak.uname detections to those would be tedious, we'd need to
start detecting various other OS versions.

Or, we can just ask zlib.h abuot its ZLIB_VERSION instead, and include
compat/zlib-uncompress2.c in our own zlib.c wrapper.

This has an interaction with da/rhel7-lacks-uncompress2-and-c99 (the
merge should preferably delete the NO_UNCOMPRESS2=Y it adds), it's in
"next", but I didn't base this on that topic as "nex" clearly won't be
merged down before v2.35.0.

 Makefile                  |  6 ++++--
 cache.h                   |  5 +++++
 compat/zlib-uncompress2.c |  5 +----
 config.mak.uname          |  6 ------
 reftable/block.c          |  2 +-
 reftable/system.h         | 12 +-----------
 zlib.c                    |  3 +++
 7 files changed, 15 insertions(+), 24 deletions(-)

diff --git a/Makefile b/Makefile
index 5580859afdb..3e90820bbfd 100644
--- a/Makefile
+++ b/Makefile
@@ -256,7 +256,10 @@ all::
 #
 # Define NO_DEFLATE_BOUND if your zlib does not have deflateBound.
 #
-# Define NO_UNCOMPRESS2 if your zlib does not have uncompress2.
+# Define NO_UNCOMPRESS2 if your zlib is older than v1.2.9 and does not
+# have uncompress2. You should not need to define this unless your
+# zlib's ZLIB_VERNUM is broken. We'll auto-detect this on the basis of
+# that macro.
 #
 # Define NO_NORETURN if using buggy versions of gcc 4.6+ and profile feedback,
 # as the compiler can crash (http://gcc.gnu.org/bugzilla/show_bug.cgi?id=49299)
@@ -1728,7 +1731,6 @@ endif
 
 ifdef NO_UNCOMPRESS2
 	BASIC_CFLAGS += -DNO_UNCOMPRESS2
-	REFTABLE_OBJS += compat/zlib-uncompress2.o
 endif
 
 ifdef NO_POSIX_GOODIES
diff --git a/cache.h b/cache.h
index 281f00ab1b1..02b355fcf08 100644
--- a/cache.h
+++ b/cache.h
@@ -29,6 +29,11 @@ typedef struct git_zstream {
 	unsigned char *next_out;
 } git_zstream;
 
+#if defined(NO_UNCOMPRESS2) || ZLIB_VERNUM < 0x1290
+#define GIT_NO_UNCOMPRESS2 1
+int uncompress2(Bytef *dest, uLongf *destLen, const Bytef *source,
+		uLong *sourceLen);
+#endif
 void git_inflate_init(git_zstream *);
 void git_inflate_init_gzip_only(git_zstream *);
 void git_inflate_end(git_zstream *);
diff --git a/compat/zlib-uncompress2.c b/compat/zlib-uncompress2.c
index 722610b9718..915796e85ac 100644
--- a/compat/zlib-uncompress2.c
+++ b/compat/zlib-uncompress2.c
@@ -8,15 +8,12 @@
 
 */
 
-#include "../reftable/system.h"
-#define z_const
-
 /*
  * Copyright (C) 1995-2003, 2010, 2014, 2016 Jean-loup Gailly, Mark Adler
  * For conditions of distribution and use, see copyright notice in zlib.h
  */
 
-#include <zlib.h>
+/* No "#include <zlib.h>", done in cache.h */
 
 /* clang-format off */
 
diff --git a/config.mak.uname b/config.mak.uname
index 9b3e9bff5f5..d0701f9beb0 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -261,10 +261,6 @@ ifeq ($(uname_S),FreeBSD)
 	FILENO_IS_A_MACRO = UnfortunatelyYes
 endif
 ifeq ($(uname_S),OpenBSD)
-	# Versions < 7.0 need compatibility layer
-	ifeq ($(shell expr "$(uname_R)" : "[1-6]\."),2)
-		NO_UNCOMPRESS2 = UnfortunatelyYes
-	endif
 	NO_STRCASESTR = YesPlease
 	NO_MEMMEM = YesPlease
 	USE_ST_TIMESPEC = YesPlease
@@ -520,7 +516,6 @@ ifeq ($(uname_S),Interix)
 	endif
 endif
 ifeq ($(uname_S),Minix)
-	NO_UNCOMPRESS2 = YesPlease
 	NO_IPV6 = YesPlease
 	NO_ST_BLOCKS_IN_STRUCT_STAT = YesPlease
 	NO_NSEC = YesPlease
@@ -576,7 +571,6 @@ ifeq ($(uname_S),NONSTOP_KERNEL)
 	NO_SETENV = YesPlease
 	NO_UNSETENV = YesPlease
 	NO_MKDTEMP = YesPlease
-	NO_UNCOMPRESS2 = YesPlease
 	# Currently libiconv-1.9.1.
 	OLD_ICONV = UnfortunatelyYes
 	NO_REGEX = NeedsStartEnd
diff --git a/reftable/block.c b/reftable/block.c
index 855e3f5c947..946edd0f34e 100644
--- a/reftable/block.c
+++ b/reftable/block.c
@@ -13,7 +13,7 @@ license that can be found in the LICENSE file or at
 #include "record.h"
 #include "reftable-error.h"
 #include "system.h"
-#include <zlib.h>
+#include "zlib.h"
 
 int header_size(int version)
 {
diff --git a/reftable/system.h b/reftable/system.h
index 4907306c0c5..2cebbc94d4d 100644
--- a/reftable/system.h
+++ b/reftable/system.h
@@ -15,17 +15,7 @@ license that can be found in the LICENSE file or at
 #include "strbuf.h"
 #include "hash.h" /* hash ID, sizes.*/
 #include "dir.h" /* remove_dir_recursively, for tests.*/
-
-#include <zlib.h>
-
-#ifdef NO_UNCOMPRESS2
-/*
- * This is uncompress2, which is only available in zlib >= 1.2.9
- * (released as of early 2017)
- */
-int uncompress2(Bytef *dest, uLongf *destLen, const Bytef *source,
-		uLong *sourceLen);
-#endif
+#include "zlib.h"
 
 int hash_size(uint32_t id);
 
diff --git a/zlib.c b/zlib.c
index d594cba3fc9..d9440dfb784 100644
--- a/zlib.c
+++ b/zlib.c
@@ -3,6 +3,9 @@
  * at init time.
  */
 #include "cache.h"
+#ifdef GIT_NO_UNCOMPRESS2
+#include "compat/zlib-uncompress2.c"
+#endif
 
 static const char *zerr_to_string(int status)
 {
-- 
2.35.0.rc1.855.gbd520c8f475

