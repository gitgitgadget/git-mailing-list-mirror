Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C7212018E
	for <e@80x24.org>; Sat, 13 Aug 2016 12:10:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752421AbcHMMKC (ORCPT <rfc822;e@80x24.org>);
	Sat, 13 Aug 2016 08:10:02 -0400
Received: from mout.web.de ([212.227.17.11]:60972 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752186AbcHMMKB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Aug 2016 08:10:01 -0400
Received: from [192.168.178.36] ([79.213.114.86]) by smtp.web.de (mrweb101)
 with ESMTPSA (Nemesis) id 0MLgZ5-1bXiXs20Gp-000rNv; Sat, 13 Aug 2016 14:09:51
 +0200
Subject: [PATCH v2 1/4] commit: use xstrdup() in get_merge_parent()
To:	Jeff King <peff@peff.net>
References: <57AEE4F7.7090804@web.de>
 <20160813092330.vmy2hip4papyuula@sigill.intra.peff.net>
 <57AF0D8E.6040309@web.de>
Cc:	Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
From:	=?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <57AF0E0D.9030205@web.de>
Date:	Sat, 13 Aug 2016 14:09:49 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.2
MIME-Version: 1.0
In-Reply-To: <57AF0D8E.6040309@web.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:Dnj2l6s9zPHf+L3fc4jqKbN+eL2Bv9zjYqcNlrD0c6gr2iHInee
 hmZlLG+zFvkVZLc9RM/ANSLChx/l8lgGO0cchuXrMyd14BS9TSxl3Oml0yuZnXF5uLi3qOj
 l2pUkc4tguULChSyZYwKnuDe3NPSjUVRdo4fQBp6HCLhTTaGZdXkNyNa/oRLF8q27uLoFDb
 bUC6RO09JqKHUfYb3x+7Q==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:VOswYssqyl4=:2eSPojOs63EtTQVf8nmbG2
 nHYL68o/5feb6AU88OEKqatF2xuescvqLOUkh6npn+yp7AF7cdX6iyqvmDqvubeyNPQl+K7iN
 5NxM96YzMTJ+ib6jgJj0HEdQ6US21l4CXPRMo+FXIx/Okn3T+Na1iHSQYFItPs1UiU3Qlyxhr
 5Q+52DyS3s1Wa2PIm/dLHKj4x0u28Pf6z/z8vnxy9sYFOoj6CMzfKJAWwckFftazJDtb42mEj
 Clwj71iFx9vvBCc86Yq/md7blWPk0RuGtjZSAg9jQvtAA1Shl8Q8kIJM11W1DRtvaiRABCkty
 UdmXoRArDjgLE38Vfw6Pr9E+eIqyfJ6Irj0tUukJOXH0ChvU4B+M8UUcudq2QQp5G17mkgrLJ
 1LVeC2a/WGemMPKSpH1zU3JNQoNRw3ySld0fcuoGwfGFrqwbwZQcsOtmwn3DSVL7DZnt//8lp
 KR3nDJhM9367fwWboPH6hW1O7PdCY1joKckZB0kq2NuI+r9wNv2Bz/OdjXG2iJ8qdkuzgxFR2
 zaEtITqgbhWOOq/mw7HQFSt8BEKpOZKp1iyb44E1RnW8jSf3OXNkPYBb7oWAmkXoYrlR4I9w8
 kXrtd48HzOKwxsO1GtXc96yjaXg+sUzzccv2nUy2MO56DJBWJuuNPvs3WBTYbiw3tpjufqKN+
 0979ZGCE08l23+s0d/Foq7zhNnBs1K3boJDfx9JAF5AWbSkTh6KGnknpJO5z9KMFAr+XDWKgz
 7Nf9yPcK/bvVLjf5ZvWP5BHntA19i5iarHTEW2NQydgJB3qaI/rgxthT5wF3LEtys2LLxdGwl
 UOT1i+G
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Handle allocation errors for the name member just like we already do
for the struct merge_remote_desc itself.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 commit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/commit.c b/commit.c
index 71a360d..ccd232a 100644
--- a/commit.c
+++ b/commit.c
@@ -1589,7 +1589,7 @@ struct commit *get_merge_parent(const char *name)
 		struct merge_remote_desc *desc;
 		desc = xmalloc(sizeof(*desc));
 		desc->obj = obj;
-		desc->name = strdup(name);
+		desc->name = xstrdup(name);
 		commit->util = desc;
 	}
 	return commit;
-- 
2.9.3

