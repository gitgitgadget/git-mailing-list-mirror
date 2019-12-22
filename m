Return-Path: <SRS0=9sC2=2M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BC65C2D0C0
	for <git@archiver.kernel.org>; Sun, 22 Dec 2019 06:48:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8F7D206CB
	for <git@archiver.kernel.org>; Sun, 22 Dec 2019 06:48:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mac.com header.i=@mac.com header.b="Knq9y2iP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725848AbfLVGs1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Dec 2019 01:48:27 -0500
Received: from mr85p00im-hyfv06011401.me.com ([17.58.23.191]:36233 "EHLO
        mr85p00im-hyfv06011401.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725775AbfLVGs1 (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 22 Dec 2019 01:48:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mac.com; s=1a1hai;
        t=1576997305; bh=rjph3GTyTVgKRyONS6vEc+/nKX1tpkB+qAXLfvJPT7E=;
        h=From:To:Subject:Date:Message-Id;
        b=Knq9y2iPqfjyHQ8Xw6dFdxerPPIOJUXbPL4QkMo9KwsWOKU4mouqF4LNsEAKJdoeE
         SwiA8rNPwEjXmTZKvZIEWf5gilctmcd5MU6kHekUJaMozIdCaar1jwtzhUGoAKyzcq
         lqSi9I5ztPxc374jWz9ERuPFA0dqT8aVJQ2/U3xkAg2rmsJ9pIQAPhGgzfHM+9Wdda
         X2boG9niisSqEYkwCusIerqb/HZ/VXDd7gqKNxJBGR4xksN9Pj2M7J5dl6JBM9MVDV
         VJHAqkIeNqxBCRllqVsTrEUL8Y36ef7+s9ata9c8pcNp+WG2gbeZ7z/Oib7qiOM1WX
         CsYcy1xuJqbCg==
Received: from localhost.localdomain (125-237-36-9-fibre.sparkbb.co.nz [125.237.36.9])
        by mr85p00im-hyfv06011401.me.com (Postfix) with ESMTPSA id ED92FD20971;
        Sun, 22 Dec 2019 06:48:24 +0000 (UTC)
From:   Michael Clark <michaeljclark@mac.com>
To:     git@vger.kernel.org
Cc:     Michael Clark <michaeljclark@mac.com>
Subject: [PATCH 1/6] Move all SHA algorithm variants into sha/ directory
Date:   Sun, 22 Dec 2019 19:48:04 +1300
Message-Id: <20191222064809.35667-2-michaeljclark@mac.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191222064809.35667-1-michaeljclark@mac.com>
References: <20191222064809.35667-1-michaeljclark@mac.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-12-22_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=965 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1912220061
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a tidy up before we add additional hash agorithms.
This patch does not change code. It only contains renames.

After this patch, all hash algorithm implementations are in sha/.
---
 Makefile                              | 16 ++++++++--------
 hash.h                                |  6 +++---
 {block-sha1 => sha/sha1}/sha1.c       |  2 +-
 {block-sha1 => sha/sha1}/sha1.h       |  0
 {sha1dc => sha/sha1dc}/.gitattributes |  0
 {sha1dc => sha/sha1dc}/LICENSE.txt    |  0
 {sha1dc => sha/sha1dc}/sha1.c         |  0
 {sha1dc => sha/sha1dc}/sha1.h         |  0
 {sha1dc => sha/sha1dc}/ubc_check.c    |  0
 {sha1dc => sha/sha1dc}/ubc_check.h    |  0
 sha1dc_git.c => sha/sha1dc_git.c      |  0
 sha1dc_git.h => sha/sha1dc_git.h      |  2 +-
 {ppc => sha/sha1ppc}/sha1.c           |  0
 {ppc => sha/sha1ppc}/sha1.h           |  0
 {ppc => sha/sha1ppc}/sha1ppc.S        |  0
 {sha256 => sha/sha256}/gcrypt.h       |  0
 {sha256/block => sha/sha256}/sha256.c |  0
 {sha256/block => sha/sha256}/sha256.h |  0
 18 files changed, 13 insertions(+), 13 deletions(-)
 rename {block-sha1 => sha/sha1}/sha1.c (99%)
 rename {block-sha1 => sha/sha1}/sha1.h (100%)
 rename {sha1dc => sha/sha1dc}/.gitattributes (100%)
 rename {sha1dc => sha/sha1dc}/LICENSE.txt (100%)
 rename {sha1dc => sha/sha1dc}/sha1.c (100%)
 rename {sha1dc => sha/sha1dc}/sha1.h (100%)
 rename {sha1dc => sha/sha1dc}/ubc_check.c (100%)
 rename {sha1dc => sha/sha1dc}/ubc_check.h (100%)
 rename sha1dc_git.c => sha/sha1dc_git.c (100%)
 rename sha1dc_git.h => sha/sha1dc_git.h (95%)
 rename {ppc => sha/sha1ppc}/sha1.c (100%)
 rename {ppc => sha/sha1ppc}/sha1.h (100%)
 rename {ppc => sha/sha1ppc}/sha1ppc.S (100%)
 rename {sha256 => sha/sha256}/gcrypt.h (100%)
 rename {sha256/block => sha/sha256}/sha256.c (100%)
 rename {sha256/block => sha/sha256}/sha256.h (100%)

diff --git a/Makefile b/Makefile
index 42a061d3fb75..bac1b30b2f1f 100644
--- a/Makefile
+++ b/Makefile
@@ -1158,7 +1158,7 @@ THIRD_PARTY_SOURCES += compat/obstack.%
 THIRD_PARTY_SOURCES += compat/poll/%
 THIRD_PARTY_SOURCES += compat/regex/%
 THIRD_PARTY_SOURCES += sha1collisiondetection/%
-THIRD_PARTY_SOURCES += sha1dc/%
+THIRD_PARTY_SOURCES += sha/sha1dc/%
 
 GITLIBS = common-main.o $(LIB_FILE) $(XDIFF_LIB)
 EXTLIBS =
@@ -1657,11 +1657,11 @@ ifdef OPENSSL_SHA1
 	BASIC_CFLAGS += -DSHA1_OPENSSL
 else
 ifdef BLK_SHA1
-	LIB_OBJS += block-sha1/sha1.o
+	LIB_OBJS += sha/sha1/sha1.o
 	BASIC_CFLAGS += -DSHA1_BLK
 else
 ifdef PPC_SHA1
-	LIB_OBJS += ppc/sha1.o ppc/sha1ppc.o
+	LIB_OBJS += sha/sha1ppc/sha1.o sha/sha1ppc/sha1ppc.o
 	BASIC_CFLAGS += -DSHA1_PPC
 else
 ifdef APPLE_COMMON_CRYPTO
@@ -1670,7 +1670,7 @@ ifdef APPLE_COMMON_CRYPTO
 else
 	DC_SHA1 := YesPlease
 	BASIC_CFLAGS += -DSHA1_DC
-	LIB_OBJS += sha1dc_git.o
+	LIB_OBJS += sha/sha1dc_git.o
 ifdef DC_SHA1_EXTERNAL
 	ifdef DC_SHA1_SUBMODULE
 		ifneq ($(DC_SHA1_SUBMODULE),auto)
@@ -1685,8 +1685,8 @@ ifdef DC_SHA1_SUBMODULE
 	LIB_OBJS += sha1collisiondetection/lib/ubc_check.o
 	BASIC_CFLAGS += -DDC_SHA1_SUBMODULE
 else
-	LIB_OBJS += sha1dc/sha1.o
-	LIB_OBJS += sha1dc/ubc_check.o
+	LIB_OBJS += sha/sha1dc/sha1.o
+	LIB_OBJS += sha/sha1dc/ubc_check.o
 endif
 	BASIC_CFLAGS += \
 		-DSHA1DC_NO_STANDARD_INCLUDES \
@@ -1707,7 +1707,7 @@ ifdef GCRYPT_SHA256
 	BASIC_CFLAGS += -DSHA256_GCRYPT
 	EXTLIBS += -lgcrypt
 else
-	LIB_OBJS += sha256/block/sha256.o
+	LIB_OBJS += sha/sha256/sha256.o
 	BASIC_CFLAGS += -DSHA256_BLK
 endif
 endif
@@ -2782,7 +2782,7 @@ sparse: $(SP_OBJ)
 GEN_HDRS := command-list.h unicode-width.h
 EXCEPT_HDRS := $(GEN_HDRS) compat/% xdiff/%
 ifndef GCRYPT_SHA256
-	EXCEPT_HDRS += sha256/gcrypt.h
+	EXCEPT_HDRS += sha/sha256/gcrypt.h
 endif
 CHK_HDRS = $(filter-out $(EXCEPT_HDRS),$(LIB_H))
 HCO = $(patsubst %.h,%.hco,$(CHK_HDRS))
diff --git a/hash.h b/hash.h
index 52a4f1a3f430..f1b941218dc8 100644
--- a/hash.h
+++ b/hash.h
@@ -10,9 +10,9 @@
 #elif defined(SHA1_OPENSSL)
 #include <openssl/sha.h>
 #elif defined(SHA1_DC)
-#include "sha1dc_git.h"
+#include "sha/sha1dc_git.h"
 #else /* SHA1_BLK */
-#include "block-sha1/sha1.h"
+#include "sha/sha1/sha1.h"
 #endif
 
 #if defined(SHA256_GCRYPT)
@@ -20,7 +20,7 @@
 #elif defined(SHA256_OPENSSL)
 #include <openssl/sha.h>
 #else
-#include "sha256/block/sha256.h"
+#include "sha/sha256/sha256.h"
 #endif
 
 #ifndef platform_SHA_CTX
diff --git a/block-sha1/sha1.c b/sha/sha1/sha1.c
similarity index 99%
rename from block-sha1/sha1.c
rename to sha/sha1/sha1.c
index 22b125cf8c12..ad9f7e50a395 100644
--- a/block-sha1/sha1.c
+++ b/sha/sha1/sha1.c
@@ -7,7 +7,7 @@
  */
 
 /* this is only to get definitions for memcpy(), ntohl() and htonl() */
-#include "../git-compat-util.h"
+#include "git-compat-util.h"
 
 #include "sha1.h"
 
diff --git a/block-sha1/sha1.h b/sha/sha1/sha1.h
similarity index 100%
rename from block-sha1/sha1.h
rename to sha/sha1/sha1.h
diff --git a/sha1dc/.gitattributes b/sha/sha1dc/.gitattributes
similarity index 100%
rename from sha1dc/.gitattributes
rename to sha/sha1dc/.gitattributes
diff --git a/sha1dc/LICENSE.txt b/sha/sha1dc/LICENSE.txt
similarity index 100%
rename from sha1dc/LICENSE.txt
rename to sha/sha1dc/LICENSE.txt
diff --git a/sha1dc/sha1.c b/sha/sha1dc/sha1.c
similarity index 100%
rename from sha1dc/sha1.c
rename to sha/sha1dc/sha1.c
diff --git a/sha1dc/sha1.h b/sha/sha1dc/sha1.h
similarity index 100%
rename from sha1dc/sha1.h
rename to sha/sha1dc/sha1.h
diff --git a/sha1dc/ubc_check.c b/sha/sha1dc/ubc_check.c
similarity index 100%
rename from sha1dc/ubc_check.c
rename to sha/sha1dc/ubc_check.c
diff --git a/sha1dc/ubc_check.h b/sha/sha1dc/ubc_check.h
similarity index 100%
rename from sha1dc/ubc_check.h
rename to sha/sha1dc/ubc_check.h
diff --git a/sha1dc_git.c b/sha/sha1dc_git.c
similarity index 100%
rename from sha1dc_git.c
rename to sha/sha1dc_git.c
diff --git a/sha1dc_git.h b/sha/sha1dc_git.h
similarity index 95%
rename from sha1dc_git.h
rename to sha/sha1dc_git.h
index 41e1c3fd3f78..100a7cc9d641 100644
--- a/sha1dc_git.h
+++ b/sha/sha1dc_git.h
@@ -5,7 +5,7 @@
 #elif defined(DC_SHA1_SUBMODULE)
 #include "sha1collisiondetection/lib/sha1.h"
 #else
-#include "sha1dc/sha1.h"
+#include "sha/sha1dc/sha1.h"
 #endif
 
 #ifdef DC_SHA1_EXTERNAL
diff --git a/ppc/sha1.c b/sha/sha1ppc/sha1.c
similarity index 100%
rename from ppc/sha1.c
rename to sha/sha1ppc/sha1.c
diff --git a/ppc/sha1.h b/sha/sha1ppc/sha1.h
similarity index 100%
rename from ppc/sha1.h
rename to sha/sha1ppc/sha1.h
diff --git a/ppc/sha1ppc.S b/sha/sha1ppc/sha1ppc.S
similarity index 100%
rename from ppc/sha1ppc.S
rename to sha/sha1ppc/sha1ppc.S
diff --git a/sha256/gcrypt.h b/sha/sha256/gcrypt.h
similarity index 100%
rename from sha256/gcrypt.h
rename to sha/sha256/gcrypt.h
diff --git a/sha256/block/sha256.c b/sha/sha256/sha256.c
similarity index 100%
rename from sha256/block/sha256.c
rename to sha/sha256/sha256.c
diff --git a/sha256/block/sha256.h b/sha/sha256/sha256.h
similarity index 100%
rename from sha256/block/sha256.h
rename to sha/sha256/sha256.h
-- 
2.20.1

