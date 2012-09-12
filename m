From: Yann Droneaud <ydroneaud@opteya.com>
Subject: [PATCH 3/3] sha1: use char type for temporary work buffer
Date: Wed, 12 Sep 2012 12:30:45 +0200
Message-ID: <a8c30a998cad6a7b38bd983e7689a628567a8176.1347442430.git.ydroneaud@opteya.com>
References: <cover.1347442430.git.ydroneaud@opteya.com>
Cc: Yann Droneaud <ydroneaud@opteya.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 12 13:16:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TBkw2-0003CT-KX
	for gcvg-git-2@plane.gmane.org; Wed, 12 Sep 2012 13:16:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752257Ab2ILLQ2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Sep 2012 07:16:28 -0400
Received: from smtp1-g21.free.fr ([212.27.42.1]:48727 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752009Ab2ILLQ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Sep 2012 07:16:26 -0400
Received: from test.quest-ce.net (unknown [IPv6:2a01:e35:2e9f:6ac0:21d0:2ede:8970:5205])
	by smtp1-g21.free.fr (Postfix) with ESMTP id 4C20694014E;
	Wed, 12 Sep 2012 13:16:16 +0200 (CEST)
Received: from test.quest-ce.net (localhost.localdomain [127.0.0.1])
	by test.quest-ce.net (8.14.5/8.14.5) with ESMTP id q8CBGF7B030220;
	Wed, 12 Sep 2012 13:16:15 +0200
Received: (from ydroneaud@localhost)
	by test.quest-ce.net (8.14.5/8.14.5/Submit) id q8CBCpbI030084;
	Wed, 12 Sep 2012 13:12:51 +0200
X-Mailer: git-send-email 1.7.11.4
In-Reply-To: <cover.1347442430.git.ydroneaud@opteya.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205280>

The SHA context is holding a temporary buffer for partial block.

This block must 64 bytes long. It is currently described as
an array of 16 integers.

Signed-off-by: Yann Droneaud <ydroneaud@opteya.com>
---
 block-sha1/sha1.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block-sha1/sha1.h b/block-sha1/sha1.h
index b864df6..d29ff6a 100644
--- a/block-sha1/sha1.h
+++ b/block-sha1/sha1.h
@@ -9,7 +9,7 @@
 typedef struct {
 	unsigned long long size;
 	unsigned int H[5];
-	unsigned int W[16];
+	unsigned char W[64];
 } blk_SHA_CTX;
 
 void blk_SHA1_Init(blk_SHA_CTX *ctx);
-- 
1.7.11.4
