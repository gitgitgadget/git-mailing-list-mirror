Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 10E78201CF
	for <e@80x24.org>; Thu, 18 May 2017 20:14:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752218AbdERUOG (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 May 2017 16:14:06 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:36547 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751200AbdERUOF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2017 16:14:05 -0400
Received: by mail-qt0-f193.google.com with SMTP id j13so7169367qta.3
        for <git@vger.kernel.org>; Thu, 18 May 2017 13:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wqGF4dDTd5D+n02k6xzt407YByagw7GWcxXlL3sKjes=;
        b=bsZ6JWXhQnmSd7NUoj+Wnoz1yiVNgBJPPrcwS56MuNJr4/aOiZzB6aR0iTy56QRMtn
         +w55GrYc7CZ0RYXQR73aICGnK1qAxuswQHgRNYTos48VqsqAhBVzsiKX1QkT78/9bcEG
         90e0PhUPUaX7odwUaD4HCeVrARy0CG5ceDA/L7OBhHlcjHFzbiCngdbV4GgETJUCSVu/
         4yH5+ccBh0AYXX+Seqo7yxA12tLWcxbLlg8GyQw/WD/ssKmluGSD3s5s669U7wnvAKDs
         pNIIsP7/KxRVpHJz2r1kSPE2YRvnisSPU6jbm+AgztSm2RquON1Qz/KUSAfkpo6T6Bzb
         sgCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wqGF4dDTd5D+n02k6xzt407YByagw7GWcxXlL3sKjes=;
        b=s5lF3xZEAqVo1DoyjS6RYYIdnOvx1BNDWzRzjLW/+W5cdvxjkx7r1P1lXmDLfTdWVv
         22zphHsNbcMSHLaAhyGh4VElaUfAU1Ls8ZIRMPvPlmZGxv7DdvuQG/WLR0/9VH52Ohe+
         WmGEHMoxNGPHU4esgeUHc7OPuGr3u01GAnMmUhCk3e6zrNDzTjajh8uI02txD+9VdyET
         kgl6+31eJaPXRiEHEhEsGW0jmC5DFy4/YKDLUUP3Mhj6hxf7YdkXsace5EHXyzLd/ZgQ
         LavIrkzPrldkpZPzVI4vV4wvq/JVMCBG4fUO4dyd911DdYzJQ7hh50HEreewCtfoFbyq
         h5lQ==
X-Gm-Message-State: AODbwcBQIDwfLXh5n2znzHq1iV0Gvsk/Dq59mH/EcoIdnFurkXPRwbrd
        7c0uaSY+ice+cA==
X-Received: by 10.200.46.10 with SMTP id r10mr5573128qta.290.1495138444382;
        Thu, 18 May 2017 13:14:04 -0700 (PDT)
Received: from localhost.localdomain ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id y17sm4369133qtc.29.2017.05.18.13.14.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 18 May 2017 13:14:04 -0700 (PDT)
From:   Ben Peart <peartben@gmail.com>
X-Google-Original-From: Ben Peart <benpeart@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, benpeart@microsoft.com, pclouds@gmail.com,
        johannes.schindelin@gmx.de, David.Turner@twosigma.com,
        peff@peff.net
Subject: [PATCH v2 1/6] bswap: add 64 bit endianness helper get_be64
Date:   Thu, 18 May 2017 16:13:28 -0400
Message-Id: <20170518201333.13088-2-benpeart@microsoft.com>
X-Mailer: git-send-email 2.13.0.windows.1.6.g4597375fc3
In-Reply-To: <20170518201333.13088-1-benpeart@microsoft.com>
References: <20170518201333.13088-1-benpeart@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a new get_be64 macro to enable 64 bit endian conversions on memory
that may or may not be aligned.

Signed-off-by: Ben Peart <benpeart@microsoft.com>
---
 compat/bswap.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/compat/bswap.h b/compat/bswap.h
index d47c003544..f89fe7f4b5 100644
--- a/compat/bswap.h
+++ b/compat/bswap.h
@@ -158,6 +158,7 @@ static inline uint64_t git_bswap64(uint64_t x)
 
 #define get_be16(p)	ntohs(*(unsigned short *)(p))
 #define get_be32(p)	ntohl(*(unsigned int *)(p))
+#define get_be64(p)	ntohll(*(uint64_t *)(p))
 #define put_be32(p, v)	do { *(unsigned int *)(p) = htonl(v); } while (0)
 
 #else
@@ -170,6 +171,9 @@ static inline uint64_t git_bswap64(uint64_t x)
 	(*((unsigned char *)(p) + 1) << 16) | \
 	(*((unsigned char *)(p) + 2) <<  8) | \
 	(*((unsigned char *)(p) + 3) <<  0) )
+#define get_be64(p)	( \
+	((uint64_t)get_be32((unsigned char *)(p) + 0) << 32) | \
+	((uint64_t)get_be32((unsigned char *)(p) + 4) <<  0)
 #define put_be32(p, v)	do { \
 	unsigned int __v = (v); \
 	*((unsigned char *)(p) + 0) = __v >> 24; \
-- 
2.13.0.windows.1.6.g4597375fc3

