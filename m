Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0282D1F667
	for <e@80x24.org>; Wed, 16 Aug 2017 20:22:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752608AbdHPUW1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Aug 2017 16:22:27 -0400
Received: from vie01a-dmta-pe08-1.mx.upcmail.net ([84.116.36.20]:23130 "EHLO
        vie01a-dmta-pe05-1.mx.upcmail.net" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751678AbdHPUWR (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 16 Aug 2017 16:22:17 -0400
Received: from [172.31.216.44] (helo=vie01a-pemc-psmtp-pe02)
        by vie01a-dmta-pe08.mx.upcmail.net with esmtp (Exim 4.88)
        (envelope-from <martin.koegler@chello.at>)
        id 1di4pU-0006R8-0K
        for git@vger.kernel.org; Wed, 16 Aug 2017 22:22:16 +0200
Received: from master.zuhause ([80.108.242.240])
        by vie01a-pemc-psmtp-pe02 with SMTP @ mailcloud.upcmail.net
        id xwGf1v01k5BuuEg01wGhLA; Wed, 16 Aug 2017 22:16:41 +0200
X-SourceIP: 80.108.242.240
Received: by master.zuhause (Postfix, from userid 1006)
        id 600C845D4512; Wed, 16 Aug 2017 22:16:41 +0200 (CEST)
From:   Martin Koegler <martin.koegler@chello.at>
To:     git@vger.kernel.org, gitster@pobox.com, Johannes.Schindelin@gmx.de
Cc:     Martin Koegler <martin.koegler@chello.at>
Subject: [Patch size_t V3 06/19] Use size_t for sha1
Date:   Wed, 16 Aug 2017 22:16:18 +0200
Message-Id: <1502914591-26215-7-git-send-email-martin@mail.zuhause>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1502914591-26215-1-git-send-email-martin@mail.zuhause>
References: <1502914591-26215-1-git-send-email-martin@mail.zuhause>
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
 6 files changed, 6 insertions(+), 6 deletions(-)

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
-- 
2.1.4

