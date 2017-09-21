Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 007A920A26
	for <e@80x24.org>; Thu, 21 Sep 2017 16:47:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751804AbdIUQrk (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Sep 2017 12:47:40 -0400
Received: from avasout07.plus.net ([84.93.230.235]:33762 "EHLO
        avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751803AbdIUQrj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Sep 2017 12:47:39 -0400
Received: from [10.0.2.15] ([147.147.86.16])
        by avasout07 with smtp
        id CGnc1w0090M91Ur01Gnd6W; Thu, 21 Sep 2017 17:47:38 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=CrLPSjwD c=1 sm=1 tr=0
 a=dubYQqM3tRRTmV8xSh8cXQ==:117 a=dubYQqM3tRRTmV8xSh8cXQ==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=XlRNIa04yNmNByYNy2gA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH 2/4] commit-slab.h: avoid -Wsign-compare warnings
Message-ID: <f120046a-f0b3-6199-a2fc-65a5fd37c0a3@ramsayjones.plus.com>
Date:   Thu, 21 Sep 2017 17:47:36 +0100
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
 commit-slab.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/commit-slab.h b/commit-slab.h
index 333d81e37..dcaab8ca0 100644
--- a/commit-slab.h
+++ b/commit-slab.h
@@ -78,7 +78,7 @@ static MAYBE_UNUSED void init_ ##slabname(struct slabname *s)		\
 									\
 static MAYBE_UNUSED void clear_ ##slabname(struct slabname *s)		\
 {									\
-	int i;								\
+	unsigned int i;							\
 	for (i = 0; i < s->slab_count; i++)				\
 		free(s->slab[i]);					\
 	s->slab_count = 0;						\
@@ -89,13 +89,13 @@ static MAYBE_UNUSED elemtype *slabname## _at_peek(struct slabname *s,	\
 						  const struct commit *c, \
 						  int add_if_missing)   \
 {									\
-	int nth_slab, nth_slot;						\
+	unsigned int nth_slab, nth_slot;				\
 									\
 	nth_slab = c->index / s->slab_size;				\
 	nth_slot = c->index % s->slab_size;				\
 									\
 	if (s->slab_count <= nth_slab) {				\
-		int i;							\
+		unsigned int i;						\
 		if (!add_if_missing)					\
 			return NULL;					\
 		REALLOC_ARRAY(s->slab, nth_slab + 1);			\
-- 
2.14.0
