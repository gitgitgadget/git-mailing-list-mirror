Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D382D1F89C
	for <e@80x24.org>; Wed, 18 Jan 2017 22:34:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751204AbdARWd4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jan 2017 17:33:56 -0500
Received: from avasout05.plus.net ([84.93.230.250]:44228 "EHLO
        avasout05.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750717AbdARWd3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2017 17:33:29 -0500
Received: from [10.0.2.15] ([143.159.212.40])
        by avasout05 with smtp
        id ZyTx1u0040srQBz01yTyAR; Wed, 18 Jan 2017 22:27:59 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=Hr8GIwbS c=1 sm=1 tr=0
 a=8Z0saNXTz8GoXi/9Q5ysMA==:117 a=8Z0saNXTz8GoXi/9Q5ysMA==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=C4-tQ9VixIzhjvGp-UAA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] attr: mark a file-local symbol as static
To:     Brandon Williams <bmwill@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
Message-ID: <89290015-7c5f-1a5d-e683-59077ae55bf5@ramsayjones.plus.com>
Date:   Wed, 18 Jan 2017 22:27:57 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Hi Brandon,

If you need to re-roll your 'bw/attr' branch, could you please
squash this into the relevant patch (commit 8908457159,
"attr: use hashmap for attribute dictionary", 12-01-2017).

Also, I note that, although they are declared as part of the
public attr api, attr_check_clear() and attr_check_reset() are
also not called outside of attr.c. Are these functions part of
the public api?

Also, a minor point, but attr_check_reset() is called (line 1050)
before it's definition (line 1114). This is not a problem, given
the declaration in attr.h, but I prefer definitions to come before
use, where possible.

Thanks!

ATB,
Ramsay Jones


 attr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/attr.c b/attr.c
index f5cc68b67..e68c4688f 100644
--- a/attr.c
+++ b/attr.c
@@ -83,7 +83,7 @@ static int attr_hash_entry_cmp(const struct attr_hash_entry *a,
 }
 
 /* Initialize an 'attr_hashmap' object */
-void attr_hashmap_init(struct attr_hashmap *map)
+static void attr_hashmap_init(struct attr_hashmap *map)
 {
 	hashmap_init(&map->map, (hashmap_cmp_fn) attr_hash_entry_cmp, 0);
 }
-- 
2.11.0
