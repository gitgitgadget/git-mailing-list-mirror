Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B4631F404
	for <e@80x24.org>; Tue, 13 Feb 2018 18:40:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965455AbeBMSjx (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Feb 2018 13:39:53 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:42128 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965415AbeBMSju (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Feb 2018 13:39:50 -0500
Received: by mail-pg0-f68.google.com with SMTP id y8so451914pgr.9
        for <git@vger.kernel.org>; Tue, 13 Feb 2018 10:39:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=NvuToHcT4h1AZ9Dk62vydznTtS1PAc0gw3L65atLRxo=;
        b=B2deZ4nX23QQ4QCrgMtt6ES82TKU7gkg1FNGywjicr3kzxShxfSBPCPdEjEE622HRf
         TcI7fgmEhjfoNVkh6H8eTCXgizMBQw+kREhrLq3j9Y5fnu2pk+9jEZBkKLOupUcmgonV
         06zW476C/lpVeZdR8V7+epYZKvb0MChRa+lyG5lId1vLS/RKDDRlEkeeGU70/u09OW9r
         y6Iz0NoVKOVxIUCYv3PBQsG98X1NqAhrdK0Lwa55qCRC+O1HEI7C1+8B+V78S7OW58EO
         3RFm7CkSrCx3fGoZEZRMwA1CHm7tdE/1VY92HYP7SxnHp8cSXL5Sn2PXVVYCkoz8PV7y
         KY5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=NvuToHcT4h1AZ9Dk62vydznTtS1PAc0gw3L65atLRxo=;
        b=ixZ9xWB/m4EoAzk/GNGfWLPPXjJjOlm1hJ4Mrap4Z2Rh0Iz2A9+2wK3CMwJ2J29b/z
         QQVrUMb4yhi7d9JOVyRGOQsmBr5qmXQj1UWL2VIw7SUysd46oRtFdX6dRUZlmH9KLdPS
         Z2mjWH1wCGyXeAv4CFWWs1L9OYwAG9n2l9eKX/PNLapYwi28pGGltUzOS64iACAqYIJM
         PUByo4NQ1U4zcH3GOzRQl7gFP6P4n5zZzoylGOKmfNkqY21OzxGwXFBlKbb+3Dh6AQ2u
         e9QKNUb3FQ2kNv4uKBdCvpqwuEhOi+sX+ISMWxFaFJyU1oUm90i+rd3PrPZd+O93b9rv
         S4cQ==
X-Gm-Message-State: APf1xPDgBtcozeqZGjbsntezzGBe1Ou6k4hWMIo4JMlL8kusV1AsUWz7
        43dSn1yoa+j+JXTp9ubwP+9AXQ2Le48=
X-Google-Smtp-Source: AH8x2268bqTZoma/28RgHhiYfkxF7R1Y/Hl8lQJDgI9l2vHjgQkWr0K4sCBSox9UUsvHYArMx3yDgQ==
X-Received: by 10.101.74.134 with SMTP id b6mr1726088pgu.137.1518547189984;
        Tue, 13 Feb 2018 10:39:49 -0800 (PST)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:422:ffac:c1d4:4bf7:bb93])
        by smtp.gmail.com with ESMTPSA id i69sm29944102pfk.24.2018.02.13.10.39.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Feb 2018 10:39:49 -0800 (PST)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     l.s.r@web.de, stolee@gmail.com,
        Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH v2 1/2] packfile: remove GIT_DEBUG_LOOKUP log statements
Date:   Tue, 13 Feb 2018 10:39:38 -0800
Message-Id: <a85c57bc80487e765baa8bcaf30ca5774402f84f.1518546891.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.16.0.rc1.238.g530d649a79-goog
In-Reply-To: <cover.1518546891.git.jonathantanmy@google.com>
References: <cover.1517609773.git.jonathantanmy@google.com>
 <cover.1518546891.git.jonathantanmy@google.com>
In-Reply-To: <cover.1518546891.git.jonathantanmy@google.com>
References: <cover.1518546891.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In commit 628522ec1439 ("sha1-lookup: more memory efficient search in
sorted list of SHA-1", 2008-04-09), a different algorithm for searching
a sorted list was introduced, together with a set of log statements
guarded by GIT_DEBUG_LOOKUP that are invoked both when using that
algorithm and when using the existing binary search. Those log
statements was meant for experiments and debugging, but with the removal
of the aforementioned different algorithm in commit f1068efefe6d
("sha1_file: drop experimental GIT_USE_LOOKUP search", 2017-08-09),
those log statements are probably no longer necessary.

Remove those statements.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 packfile.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/packfile.c b/packfile.c
index 4a5fe7ab1..58bdced3b 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1713,10 +1713,6 @@ off_t find_pack_entry_one(const unsigned char *sha1,
 	const uint32_t *level1_ofs = p->index_data;
 	const unsigned char *index = p->index_data;
 	unsigned hi, lo, stride;
-	static int debug_lookup = -1;
-
-	if (debug_lookup < 0)
-		debug_lookup = !!getenv("GIT_DEBUG_LOOKUP");
 
 	if (!index) {
 		if (open_pack_index(p))
@@ -1738,17 +1734,10 @@ off_t find_pack_entry_one(const unsigned char *sha1,
 		index += 4;
 	}
 
-	if (debug_lookup)
-		printf("%02x%02x%02x... lo %u hi %u nr %"PRIu32"\n",
-		       sha1[0], sha1[1], sha1[2], lo, hi, p->num_objects);
-
 	while (lo < hi) {
 		unsigned mi = lo + (hi - lo) / 2;
 		int cmp = hashcmp(index + mi * stride, sha1);
 
-		if (debug_lookup)
-			printf("lo %u hi %u rg %u mi %u\n",
-			       lo, hi, hi - lo, mi);
 		if (!cmp)
 			return nth_packed_object_offset(p, mi);
 		if (cmp > 0)
-- 
2.16.0.rc1.238.g530d649a79-goog

