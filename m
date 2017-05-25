Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3640A209FD
	for <e@80x24.org>; Thu, 25 May 2017 18:36:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1036421AbdEYSgm (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 May 2017 14:36:42 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:35083 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936821AbdEYSgj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 May 2017 14:36:39 -0400
Received: by mail-qt0-f196.google.com with SMTP id r58so31233652qtb.2
        for <git@vger.kernel.org>; Thu, 25 May 2017 11:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wUbWgi9OwEnIhShVXMcpBvy0wTnr62zJwvg9v0x8Jls=;
        b=HSI/NJFcA2+tbYXDOUZw5gxDy8RFfqGex4PA5rTCrzgwyoSaRihgNeyUbVx++EViKN
         3aNNWjoc4dROTprHibg13iEI2I6T/BectD5pKaFUh5csbPeeMu4d4ezR6UTxnYEaKoJr
         JgOG7llGmvJtJtr6Oe72Ps2kkvi29hX5LqzyJPfLkYDg+xIGaftcPTHDIvtgizhhW5xJ
         poPLltZeyqKhcI0H2hmIHpD+BeBwmx4zjjoYc3ZRKL0yNVTc+ZzApv9Ewkz57zZdQ38O
         vtvkKWy3KV4R5vPeXV4uVKZBa8gHmUNvvZ6AW18gX1VKkvwr+EJqzqjvmvVYqaT97gVU
         Om8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wUbWgi9OwEnIhShVXMcpBvy0wTnr62zJwvg9v0x8Jls=;
        b=sy3ZjteB7cVH7LH937t37Idx22T+n+WeBOlpRjMl+bvSasuuvsadO3QYxNvjqvUzjs
         i19M32FWpfImmrLY86IoJyOx4jLAXxMMQ0TDutLZgqrh5ZuuKA7GEVhWtjgu/lcvpOe3
         b0v0E9shKyehDndkhcTw3WieycxdKrIDXIwaWz7L8b4Efph1LwAfRqrQqvRSA4o4t2Yp
         L7d2ii37ohMg6hFbXC9oyiwL4a6njmg58sWCzzLlMk1gheAYGykP72yfFhk7qoJl6iY6
         vNShtx0AR6fI4npfPkf43zVMxuwKCakT2o00jU1Ts6vbyhbKRSC6Ji1LNmjj73xwxYCd
         968A==
X-Gm-Message-State: AODbwcBVrXt8bWytfMRilfvIf9d3bOOuhEPSzPYdv4YyT6rj/We3bR0h
        W1fUHeGD2nKCzA==
X-Received: by 10.200.51.27 with SMTP id t27mr42767602qta.10.1495737398783;
        Thu, 25 May 2017 11:36:38 -0700 (PDT)
Received: from localhost.localdomain ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id j66sm5089231qte.26.2017.05.25.11.36.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 25 May 2017 11:36:38 -0700 (PDT)
From:   Ben Peart <peartben@gmail.com>
X-Google-Original-From: Ben Peart <benpeart@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, benpeart@microsoft.com, pclouds@gmail.com,
        johannes.schindelin@gmx.de, David.Turner@twosigma.com,
        peff@peff.net
Subject: [PATCH v3 1/6] bswap: add 64 bit endianness helper get_be64
Date:   Thu, 25 May 2017 14:36:07 -0400
Message-Id: <20170525183612.3128-2-benpeart@microsoft.com>
X-Mailer: git-send-email 2.13.0.windows.1.9.gc201c67b71
In-Reply-To: <20170525183612.3128-1-benpeart@microsoft.com>
References: <20170525183612.3128-1-benpeart@microsoft.com>
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
2.13.0.windows.1.9.gc201c67b71

