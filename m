Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD730202A5
	for <e@80x24.org>; Thu, 21 Sep 2017 16:48:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751648AbdIUQsl (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Sep 2017 12:48:41 -0400
Received: from avasout07.plus.net ([84.93.230.235]:34251 "EHLO
        avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750790AbdIUQsl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Sep 2017 12:48:41 -0400
Received: from [10.0.2.15] ([147.147.86.16])
        by avasout07 with smtp
        id CGoe1w00K0M91Ur01Gog8k; Thu, 21 Sep 2017 17:48:40 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=CrLPSjwD c=1 sm=1 tr=0
 a=dubYQqM3tRRTmV8xSh8cXQ==:117 a=dubYQqM3tRRTmV8xSh8cXQ==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=MVwuzgcZ76DhQnH9eGsA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH 3/4] cache.h: hex2chr() - avoid -Wsign-compare warnings
Message-ID: <ae537e7e-2c3d-f7f3-28f4-451c37c01bbb@ramsayjones.plus.com>
Date:   Thu, 21 Sep 2017 17:48:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---
 cache.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/cache.h b/cache.h
index a916bc79e..a0e3e362c 100644
--- a/cache.h
+++ b/cache.h
@@ -1243,8 +1243,8 @@ static inline unsigned int hexval(unsigned char c)
  */
 static inline int hex2chr(const char *s)
 {
-	int val = hexval(s[0]);
-	return (val < 0) ? val : (val << 4) | hexval(s[1]);
+	unsigned int val = hexval(s[0]);
+	return (val & ~0xf) ? val : (val << 4) | hexval(s[1]);
 }
 
 /* Convert to/from hex/sha1 representation */
-- 
2.14.0
