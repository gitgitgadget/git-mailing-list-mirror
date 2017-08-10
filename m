Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D8039208B4
	for <e@80x24.org>; Thu, 10 Aug 2017 19:25:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753293AbdHJTZW (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Aug 2017 15:25:22 -0400
Received: from vie01a-dmta-pe04-3.mx.upcmail.net ([62.179.121.165]:32101 "EHLO
        vie01a-dmta-pe04-3.mx.upcmail.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753279AbdHJTZT (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 10 Aug 2017 15:25:19 -0400
Received: from [172.31.216.44] (helo=vie01a-pemc-psmtp-pe02)
        by vie01a-dmta-pe04.mx.upcmail.net with esmtp (Exim 4.88)
        (envelope-from <martin.koegler@chello.at>)
        id 1dft54-0004ln-17
        for git@vger.kernel.org; Thu, 10 Aug 2017 21:25:18 +0200
Received: from master.zuhause ([80.108.242.240])
        by vie01a-pemc-psmtp-pe02 with SMTP @ mailcloud.upcmail.net
        id vXRB1v01u5BuuEg01XRCkm; Thu, 10 Aug 2017 21:25:13 +0200
X-SourceIP: 80.108.242.240
Received: by master.zuhause (Postfix, from userid 1006)
        id D001245D4513; Thu, 10 Aug 2017 21:25:11 +0200 (CEST)
From:   Martin Koegler <martin.koegler@chello.at>
To:     git@vger.kernel.org, gitster@pobox.com, Johannes.Schindelin@gmx.de
Cc:     Martin Koegler <martin.koegler@chello.at>
Subject: [PATCH 6/9] Use size_t for sha1
Date:   Thu, 10 Aug 2017 21:25:07 +0200
Message-Id: <1502393110-31996-2-git-send-email-martin@mail.zuhause>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1502393110-31996-1-git-send-email-martin@mail.zuhause>
References: <1502393110-31996-1-git-send-email-martin@mail.zuhause>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Martin Koegler <martin.koegler@chello.at>

Signed-off-by: Martin Koegler <martin.koegler@chello.at>
---
 block-sha1/sha1.c | 2 +-
 block-sha1/sha1.h | 2 +-
 ppc/sha1.c        | 2 +-
 ppc/sha1.h        | 2 +-
 sha1dc_git.c      | 2 +-
 sha1dc_git.h      | 2 +-
 sha1dc_git_ext.h  | 2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/block-sha1/sha1.c b/block-sha1/sha1.c
index 22b125c..8681031 100644
--- a/block-sha1/sha1.c
+++ b/block-sha1/sha1.c
@@ -203,7 +203,7 @@ void blk_SHA1_Init(blk_SHA_CTX *ctx)
 	ctx->H[4] = 0xc3d2e1f0;
 }
 
-void blk_SHA1_Update(blk_SHA_CTX *ctx, const void *data, unsigned long len)
+void blk_SHA1_Update(blk_SHA_CTX *ctx, const void *data, size_t len)
 {
 	unsigned int lenW = ctx->size & 63;
 
diff --git a/block-sha1/sha1.h b/block-sha1/sha1.h
index 4df6747..9fb0441 100644
--- a/block-sha1/sha1.h
+++ b/block-sha1/sha1.h
@@ -13,7 +13,7 @@ typedef struct {
 } blk_SHA_CTX;
 
 void blk_SHA1_Init(blk_SHA_CTX *ctx);
-void blk_SHA1_Update(blk_SHA_CTX *ctx, const void *dataIn, unsigned long len);
+void blk_SHA1_Update(blk_SHA_CTX *ctx, const void *dataIn, size_t len);
 void blk_SHA1_Final(unsigned char hashout[20], blk_SHA_CTX *ctx);
 
 #define platform_SHA_CTX	blk_SHA_CTX
diff --git a/ppc/sha1.c b/ppc/sha1.c
index ec6a192..f0dfcfb 100644
--- a/ppc/sha1.c
+++ b/ppc/sha1.c
@@ -25,7 +25,7 @@ int ppc_SHA1_Init(ppc_SHA_CTX *c)
 	return 0;
 }
 
-int ppc_SHA1_Update(ppc_SHA_CTX *c, const void *ptr, unsigned long n)
+int ppc_SHA1_Update(ppc_SHA_CTX *c, const void *ptr, size_t n)
 {
 	unsigned long nb;
 	const unsigned char *p = ptr;
diff --git a/ppc/sha1.h b/ppc/sha1.h
index 9b24b32..52cac23 100644
--- a/ppc/sha1.h
+++ b/ppc/sha1.h
@@ -16,7 +16,7 @@ typedef struct {
 } ppc_SHA_CTX;
 
 int ppc_SHA1_Init(ppc_SHA_CTX *c);
-int ppc_SHA1_Update(ppc_SHA_CTX *c, const void *p, unsigned long n);
+int ppc_SHA1_Update(ppc_SHA_CTX *c, const void *p, size_t n);
 int ppc_SHA1_Final(unsigned char *hash, ppc_SHA_CTX *c);
 
 #define platform_SHA_CTX	ppc_SHA_CTX
diff --git a/sha1dc_git.c b/sha1dc_git.c
index 4d32b4f..a9076bc 100644
--- a/sha1dc_git.c
+++ b/sha1dc_git.c
@@ -11,7 +11,7 @@ void git_SHA1DCFinal(unsigned char hash[20], SHA1_CTX *ctx)
 	    sha1_to_hex(hash));
 }
 
-void git_SHA1DCUpdate(SHA1_CTX *ctx, const void *vdata, unsigned long len)
+void git_SHA1DCUpdate(SHA1_CTX *ctx, const void *vdata, size_t len)
 {
 	const char *data = vdata;
 	/* We expect an unsigned long, but sha1dc only takes an int */
diff --git a/sha1dc_git.h b/sha1dc_git.h
index a8a5c1d..f6051aa 100644
--- a/sha1dc_git.h
+++ b/sha1dc_git.h
@@ -11,7 +11,7 @@ void git_SHA1DCFinal(unsigned char [20], SHA1_CTX *);
 /*
  * Same as SHA1DCUpdate, but adjust types to match git's usual interface.
  */
-void git_SHA1DCUpdate(SHA1_CTX *ctx, const void *data, unsigned long len);
+void git_SHA1DCUpdate(SHA1_CTX *ctx, const void *data, size_t len);
 
 #define platform_SHA_CTX SHA1_CTX
 #define platform_SHA1_Init SHA1DCInit
diff --git a/sha1dc_git_ext.h b/sha1dc_git_ext.h
index d0ea8ce..aede828 100644
--- a/sha1dc_git_ext.h
+++ b/sha1dc_git_ext.h
@@ -17,7 +17,7 @@ void git_SHA1DCFinal(unsigned char [20], SHA1_CTX *);
 /*
  * Same as SHA1DCUpdate, but adjust types to match git's usual interface.
  */
-void git_SHA1DCUpdate(SHA1_CTX *ctx, const void *data, unsigned long len);
+void git_SHA1DCUpdate(SHA1_CTX *ctx, const void *data, size_t len);
 
 #define platform_SHA_CTX SHA1_CTX
 #define platform_SHA1_Init git_SHA1DCInit
-- 
2.1.4

