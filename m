Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8460B20D0A
	for <e@80x24.org>; Thu,  1 Jun 2017 15:51:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752274AbdFAPvj (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Jun 2017 11:51:39 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:33848 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751138AbdFAPvf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2017 11:51:35 -0400
Received: by mail-qt0-f196.google.com with SMTP id l39so6174657qtb.1
        for <git@vger.kernel.org>; Thu, 01 Jun 2017 08:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wUbWgi9OwEnIhShVXMcpBvy0wTnr62zJwvg9v0x8Jls=;
        b=Z2zPHR/CWpkjpyew6sPgXL5s1eED7HzFqETEjhXe68GLIL8ydryHNa6URzPMsiy5m3
         3ghfWJ/7nrltHnyXrcr74fLU1cSK0qaVQTSk8l5U5PPuGY+L9JQvV667hwGa9muHeAJf
         cKNlwEQpz3KO6O5ogrJgy15kWyRRceUpxhPnchzy3k90VcYSwsY0m/Lgf2Q6IN9MpA+X
         UulNrHh1jEPLRs6WITveZ4khrFzAOKJ2mlDNEteRGFz+FnuvRpbjYIUYGegtgjFA+CLP
         Vn2B9P8qMqDsvWIF+PJS34ktUu90VX3d+XJqL+tfOC/YjYnDB0fFtyhpzFHHN1PyJ4Xp
         bxVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wUbWgi9OwEnIhShVXMcpBvy0wTnr62zJwvg9v0x8Jls=;
        b=A8ZbN/jUBYD2rOjy7rH3bgguOWsVoQquNypCPnzx4VWzr6+FnfrxzoeDbXoUM313Gl
         mlwWMs9iVX01rMUq2+EmDYkZggff6cfKgrXRjrVM9gOAyFjyoknaZmQCwQ1D6q1oRO/6
         QSNtdfnkTJV5R7Rn21dROD2eLNNpDnvrXilFppvnHDGZQcbkd9pe+rJiHTy5n7ooIoVe
         if6S/p4o6XTgnX4PY2BKLlLjlyz1TmQlv/wz0re58qBOt/8TYEQgTC5iVQJgJBYN4OKQ
         sSxBOnyweNH1dKnSAL3rjH+lfVzTb87AXX3Wqg6trxhW9kierzXLey0nIkRiH/QlJ3WD
         Mn8g==
X-Gm-Message-State: AODbwcCyrDMzOeV37fz4ml2qY5wD0hhqgsjtM336Ym8Tt1lnnHJLxizX
        bB65Qop6oO31DUjROv8=
X-Received: by 10.237.58.33 with SMTP id n30mr2973370qte.101.1496332279333;
        Thu, 01 Jun 2017 08:51:19 -0700 (PDT)
Received: from localhost.localdomain ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id w41sm12715524qtg.34.2017.06.01.08.51.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 01 Jun 2017 08:51:18 -0700 (PDT)
From:   Ben Peart <peartben@gmail.com>
X-Google-Original-From: Ben Peart <benpeart@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, benpeart@microsoft.com, pclouds@gmail.com,
        johannes.schindelin@gmx.de, David.Turner@twosigma.com,
        peff@peff.net, christian.couder@gmail.com, avarab@gmail.com
Subject: [PATCH v4 1/6] bswap: add 64 bit endianness helper get_be64
Date:   Thu,  1 Jun 2017 11:51:00 -0400
Message-Id: <20170601155105.28356-2-benpeart@microsoft.com>
X-Mailer: git-send-email 2.13.0.windows.1.9.gc201c67b71
In-Reply-To: <20170601155105.28356-1-benpeart@microsoft.com>
References: <20170601155105.28356-1-benpeart@microsoft.com>
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

