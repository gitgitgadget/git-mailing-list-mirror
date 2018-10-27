Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 811971F453
	for <e@80x24.org>; Sat, 27 Oct 2018 01:52:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbeJ0Kb1 (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Oct 2018 06:31:27 -0400
Received: from avasout03.plus.net ([84.93.230.244]:56544 "EHLO
        avasout03.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726048AbeJ0Kb0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Oct 2018 06:31:26 -0400
Received: from [10.0.2.15] ([80.189.70.193])
        by smtp with ESMTPA
        id GDlmgYeiefmQQGDlngjERz; Sat, 27 Oct 2018 02:52:07 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=Acuf4UfG c=1 sm=1 tr=0
 a=wSR+GDtF+fsrIzE5OYgxVg==:117 a=wSR+GDtF+fsrIzE5OYgxVg==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=8X0J4UNF0WQiq7mHffEA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=c3=b3n?= <carenas@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH 2/3] ewok_rlw.h: add missing 'inline' to function definition
Message-ID: <1a465da6-d139-5880-72ff-c612b42c3b8f@ramsayjones.plus.com>
Date:   Sat, 27 Oct 2018 02:52:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfJjMpVt929It/juvNyOcBnRQeUfN46mCk4OZE+A7VufKlLn0EtB1tBT/Kh6iFPWsz3S3MngiFgj7CmM9NnFifbfQuVrxIzpwz+L7JvMMuM1AKwWAQr+z
 +RvSuv7LiE5Hzyz2wXpiInd1tVzBgSrs2uVcT5LgxnJDQJ67f1+f9yoSD0Ntv1bbV+YLAVqrIzWgXg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


The 'ewok_rlw.h' header file contains the rlw_get_run_bit() function
definition, which is marked as 'static' but not 'inline'. At least when
compiled by gcc, with the default -O2 optimization level, the function
is actually inlined and leaves no static version in the ewah_bitmap.o
and ewah_rlw.o object files. Despite this, add the missing 'inline'
keyword to better describe the intended behaviour.

Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---
 ewah/ewok_rlw.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ewah/ewok_rlw.h b/ewah/ewok_rlw.h
index d487966935..bafa24f4c3 100644
--- a/ewah/ewok_rlw.h
+++ b/ewah/ewok_rlw.h
@@ -31,7 +31,7 @@
 
 #define RLW_RUNNING_LEN_PLUS_BIT (((eword_t)1 << (RLW_RUNNING_BITS + 1)) - 1)
 
-static int rlw_get_run_bit(const eword_t *word)
+static inline int rlw_get_run_bit(const eword_t *word)
 {
 	return *word & (eword_t)1;
 }
-- 
2.19.0
