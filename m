Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 619F51F600
	for <e@80x24.org>; Sat, 22 Jul 2017 09:47:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752199AbdGVJrn (ORCPT <rfc822;e@80x24.org>);
        Sat, 22 Jul 2017 05:47:43 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:35594 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752127AbdGVJrm (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Jul 2017 05:47:42 -0400
Received: by mail-lf0-f65.google.com with SMTP id b127so2377487lfb.2
        for <git@vger.kernel.org>; Sat, 22 Jul 2017 02:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XorjDS5gOnmX/cIFP6PT/5WP55ewOcJ+T8Pq8yVjROo=;
        b=YbjK62XRBi7A8zw//3IO6TjipmZlP6NeFrX7PPM/cFkQ/jzmqs0b4b178eVhSngJ/+
         OM7+NLO0oyaQyM3LC6Wv79lbBzJAkKFfeKKbpDNNYujI+aeCdo+oL/j8XT3wjbNSQB0K
         Wvy2iaoP2j2K6FGXAE4SD4jWDMr6Gz28UfWOa7VLWn0193CpqQW1xdmNIOiCpbVdnejA
         FcdM9xiQmgBs8+B15UBmFcRdZ0ccp9YcnTj6bmhI10eywI5oJuAdShjDUg6Kbmr0h6Cz
         JUFA5AES1NYAOQmX2oLzjBEJjr1DcRKtj6aXFW38RJLKsLiR7oF0O1whSYRLQpA9tThL
         n7TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XorjDS5gOnmX/cIFP6PT/5WP55ewOcJ+T8Pq8yVjROo=;
        b=k5vOydTSY9pZmueDykY77+mbvD4+6Orro6zO0i0KYY/N3RXqNyYE/2/7DwMi+u4zTm
         qrJIdcIoDT0ibCRaz034OSlxoYMEMHS+SOgLfxeF+/e490YaIrEAuaGd8xUnvSwgEHee
         RknVOEugwAzl6nqfQp7adzoh129//yUvEv/NKVwK3knPX/yAsfyWR2P9FZW9MQ2U/wqD
         knDVNeQv5p1/0bjcn9AbNsh2PU9fBC3ra2A/H1o/oQMiz8CiZQozHadAPZ6jhz3BssHV
         ZKiVQZMTtpEiErRcZeYWZj3tnmCqO/qcK04iz+FFi01t2wwbC2KxzM2ehTo25rLRrNyW
         yrTA==
X-Gm-Message-State: AIVw111R3dvPZgWOi/rGbmPmFQDnShqO7AHXuZ/A0/IuwJ3lI/wlQUi7
        sBCsFZrO+nmTLonc
X-Received: by 10.25.156.67 with SMTP id f64mr3262652lfe.78.1500716860787;
        Sat, 22 Jul 2017 02:47:40 -0700 (PDT)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id 1sm1352663ljo.36.2017.07.22.02.47.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 22 Jul 2017 02:47:39 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] make get_be64() compile on pu with NO_UNALIGNED_LOADS
Date:   Sat, 22 Jul 2017 11:47:17 +0200
Message-Id: <20170722094717.16305-1-martin.agren@gmail.com>
X-Mailer: git-send-email 2.14.0.rc0.14.g12cc05b53
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

1. s/unit64_t/uint64_t/

2. add const-qualifier to *p

3. add missing closing ')'

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
Applies to pu and passes the tests. I think this should be squashed in
somewhere. Perhaps a mismerge in commit d553324d ("Merge branch
'bp/fsmonitor' into pu", 2017-07-21).

 compat/bswap.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/compat/bswap.h b/compat/bswap.h
index 133da1d2b..f86110a72 100644
--- a/compat/bswap.h
+++ b/compat/bswap.h
@@ -188,11 +188,11 @@ static inline void put_be32(void *ptr, uint32_t value)
 	p[3] = value >>  0;
 }
 
-static inline unit64_t get_be64(const void *ptr)
+static inline uint64_t get_be64(const void *ptr)
 {
-	unsigned char *p = ptr;
+	const unsigned char *p = ptr;
 	return  ((uint64_t)get_be32(p) << 32) |
-		((uint64_t)get_be32(p + 4);
+		((uint64_t)get_be32(p + 4));
 }
 
 #endif
-- 
2.14.0.rc0.14.g12cc05b53

