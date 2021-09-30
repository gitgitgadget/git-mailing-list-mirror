Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 166C3C433EF
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 12:24:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7007617E5
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 12:24:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350038AbhI3M0U (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Sep 2021 08:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349808AbhI3M0T (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Sep 2021 08:26:19 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 423F8C06176A
        for <git@vger.kernel.org>; Thu, 30 Sep 2021 05:24:37 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id 72so5538278qkk.7
        for <git@vger.kernel.org>; Thu, 30 Sep 2021 05:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IJyM2gxfTL92Sfb9qo2xTlF8ZA24RFcDSyhwNQv6qMI=;
        b=TRNSRpXxnn5SikeudFb4W6zE9lBRx7pt+W4MgwMEuxtuD92FGpqNd1LaZ2tuUqVKAj
         Pm2TJuEQXGzoQEinIASryCa/IPn/bK+axI5ELdg7m3QNt/JKMGYXi2MdnVv+2JWWbegI
         uVIH4r9fHmKZ6qs08rTYFQeX1delSf9burKzYniM4Zm3uSYuGDQ+vi0Hl0QpFBfh3R5Q
         WGu4Hvh6JpnjLUVGTOClZ0uHnGm9YDquZx1G2zAJ+glB5FFml7Uc8MlNVMadxGltL/2x
         yU4IR8i4v/qCneM1oN7sM+rbFw307HxD/rFbCn2U4aA8i/aEte5hReHjvicOoaIWYx6k
         TxHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IJyM2gxfTL92Sfb9qo2xTlF8ZA24RFcDSyhwNQv6qMI=;
        b=yOnWZOW5tUNzoHeChIxHQf4DIJTOS91RAiCTBRI6zHK/m7eRbPkXliOQp8fPwvq+RF
         fTXtWFn5LbFddVU5hoC0Xq0zRNV6rNuKftxDzjUO5Tq1ib3N/bwSa0k8aX5hFpRYi+tM
         d3W3YDbT6qp8IitlG+kY2QfsbdiPjoXCkjl1Jf0cKbego17vv9odF/rLoZVjJT5BlHsR
         eZz6W+YFmgyR4JdgXalFYbqLFiaSMfpAGWQeeO9qW3pNOCq+yu/ps3vVhkyFdx/4oaCT
         IOSaFcqCI/CMTULp9Zpu9v/gcAnUaN/bUiiNAUFfBDJnOIk4zr2oa476b8g4f9gNuytb
         4JKA==
X-Gm-Message-State: AOAM532zk+jLptRsGn8WEaNFXJ5JLfigA913mxZU4C43rpoYRKi1z0E9
        28rRYKxtFA+GEFRV692wKjr8QRn2nRGiag==
X-Google-Smtp-Source: ABdhPJyzNOIw0TrNpaLfgcKVAPNwWtxb0HBtjgvBHus3twhDmIPOUGDv7sRHcvgpy6/nLKNf0aorhQ==
X-Received: by 2002:a37:44ca:: with SMTP id r193mr4518484qka.190.1633004676037;
        Thu, 30 Sep 2021 05:24:36 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id i15sm1512730qtq.76.2021.09.30.05.24.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Sep 2021 05:24:35 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     hanwen@google.com, avarab@gmail.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH] squash! reftable: reading/writing blocks
Date:   Thu, 30 Sep 2021 05:23:52 -0700
Message-Id: <20210930122352.26505-1-carenas@gmail.com>
X-Mailer: git-send-email 2.33.0.955.gee03ddbf0e
In-Reply-To: <04f2d74df5189f473bc7a6395b9e194a1929f623.1632841817.git.gitgitgadget@gmail.com>
References: <04f2d74df5189f473bc7a6395b9e194a1929f623.1632841817.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Avoid a possible infinite loop in platforms where size_t > long
by using instead the required type and checking for overflow
before doubling.

Increase slightly the initial buffer based on the zlib(1)
recommendation to reduce the likelihood of this code triggering,
and add some error checking to the memory allocation.

[1] https://refspecs.linuxbase.org/LSB_3.0.0/LSB-Core-generic/LSB-Core-generic/zlib-compress2-1.html

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 reftable/block.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/reftable/block.c b/reftable/block.c
index 11387b260a..4029df18ac 100644
--- a/reftable/block.c
+++ b/reftable/block.c
@@ -132,7 +132,7 @@ int block_writer_add(struct block_writer *w, struct reftable_record *rec)
 
 int block_writer_finish(struct block_writer *w)
 {
-	int i = 0;
+	int i;
 	for (i = 0; i < w->restart_len; i++) {
 		put_be24(w->buf + w->next, w->restarts[i]);
 		w->next += 3;
@@ -144,23 +144,24 @@ int block_writer_finish(struct block_writer *w)
 
 	if (block_writer_type(w) == BLOCK_TYPE_LOG) {
 		int block_header_skip = 4 + w->header_off;
-		uint8_t *compressed = NULL;
-		int zresult = 0;
+		uint8_t *compressed;
 		uLongf src_len = w->next - block_header_skip;
-		size_t dest_cap = src_len;
+		uLongf dest_cap = src_len * 1.001 + 12;
 
 		compressed = reftable_malloc(dest_cap);
 		while (1) {
+			int zresult;
 			uLongf out_dest_len = dest_cap;
 
 			zresult = compress2(compressed, &out_dest_len,
 					    w->buf + block_header_skip, src_len,
 					    9);
-			if (zresult == Z_BUF_ERROR) {
+			if (zresult == Z_BUF_ERROR && dest_cap < LONG_MAX) {
 				dest_cap *= 2;
 				compressed =
 					reftable_realloc(compressed, dest_cap);
-				continue;
+				if (compressed)
+					continue;
 			}
 
 			if (Z_OK != zresult) {
-- 
2.33.0.955.gee03ddbf0e

