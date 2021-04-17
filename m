Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5986BC433B4
	for <git@archiver.kernel.org>; Sat, 17 Apr 2021 21:37:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2280E61352
	for <git@archiver.kernel.org>; Sat, 17 Apr 2021 21:37:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237111AbhDQVhk (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Apr 2021 17:37:40 -0400
Received: from avasout04.plus.net ([212.159.14.19]:48428 "EHLO
        avasout04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237101AbhDQVhj (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Apr 2021 17:37:39 -0400
Received: from [10.0.2.15] ([195.213.6.1])
        by smtp with ESMTPA
        id Xscnl6jlHOQhvXscolVIkm; Sat, 17 Apr 2021 22:37:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1618695431; bh=10V3OpOjEPu4vccah8jIAd+L0f1sb6Wg0qvVr9MfKEE=;
        h=To:Cc:From:Subject:Date;
        b=tbEr+W9ivCnNYlxPcf07/P22n3II1linCeC1MrNsGqMwHUJWhX9amgXio/OLCGW0c
         LOocJ+0OEIxkubKcRZ4GFrBsDIBxR61rpi5nkIk1Q/5aI4H/rQAOIV0PEWQcjNNf5K
         jDzdMG5IRTB1M//9BEYyl0J8uZEIn3M8sqaBMAIJw51S/RCF4tEkcOZOqRWERcTTNb
         TKvjR/VLbpYF5If6IMB/NRU1qyoHzU/kAM3Oy7TmbRORqwRTaE+8TrQIEOqAF6Ebzc
         RtDr3Fx/C6DrBllAQvdlLenVqu0HFD3HJPdk6ZjYQ5IqA7VSjsHXpT7RHDA+P7thFv
         O2VCh4eVYRpmw==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=IvmFjI3g c=1 sm=1 tr=0
 a=v1fZ9eGmBRQ2oAddCs0ezw==:117 a=v1fZ9eGmBRQ2oAddCs0ezw==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=07XiNrEHPrbwGcTunUkA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22 a=pHzHmUro8NiASowvMSCR:22 a=nt3jZW36AmriUCFCBwmW:22
X-AUTH: ramsayjones@:2500
To:     Patrick Steinhardt <ps@pks.im>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] list-objects-filter-options.h: fix an 'hdr-check' warning
Message-ID: <fc73f7e7-44ca-773a-7f49-e3bf29dd25bb@ramsayjones.plus.com>
Date:   Sat, 17 Apr 2021 22:37:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfHe0V03eTymt+3tVcCtd2ZWOYGOS+dmhbhxJFre0aIqxJhHbw+DjzXmd0mKK1WQdFzG4ravmv+WKi7UiKy8gNbs978OSft6SxoBfEpCaIBLq9Z2/yI6M
 8HKs4VuB92gP+ky5Qud9EzRnMXA90A4iGnffCk80IcMuD46tYWTJBUAZ
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Hi Patrick,

If you need to re-roll your 'ps/rev-list-object-type-filter' branch,
could you please squash this into the relevant patch (commit 890c534cea
("list-objects: implement object type filter", 2021-04-12)).

Sorry for being a bit tardy with this email - normally I would have sent
it soon after your branch hit 'seen', but I got distracted. ;-)

Thanks!

ATB,
Ramsay Jones

 list-objects-filter-options.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/list-objects-filter-options.h b/list-objects-filter-options.h
index 4d0d0588cc..da5b6737e2 100644
--- a/list-objects-filter-options.h
+++ b/list-objects-filter-options.h
@@ -1,6 +1,7 @@
 #ifndef LIST_OBJECTS_FILTER_OPTIONS_H
 #define LIST_OBJECTS_FILTER_OPTIONS_H
 
+#include "cache.h"
 #include "parse-options.h"
 #include "string-list.h"
 
-- 
2.31.0
