Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8CC271F461
	for <e@80x24.org>; Mon, 22 Jul 2019 18:29:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728808AbfGVS32 (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Jul 2019 14:29:28 -0400
Received: from s019.cyon.net ([149.126.4.28]:58592 "EHLO s019.cyon.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726291AbfGVS32 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Jul 2019 14:29:28 -0400
X-Greylist: delayed 595 seconds by postgrey-1.27 at vger.kernel.org; Mon, 22 Jul 2019 14:29:27 EDT
Received: from [10.20.10.231] (port=63074 helo=mail.cyon.ch)
        by s019.cyon.net with esmtpa (Exim 4.92)
        (envelope-from <bb@drbeat.li>)
        id 1hpcuH-0002Ug-BV; Mon, 22 Jul 2019 20:19:31 +0200
Received: by drbeat.li (Postfix, from userid 1000)
        id 27A21180402; Mon, 22 Jul 2019 20:19:29 +0200 (CEST)
From:   Beat Bolli <dev+git@drbeat.li>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Beat Bolli <dev+git@drbeat.li>
Subject: [PATCH] grep: print the pcre2_jit_on value
Date:   Mon, 22 Jul 2019 20:19:23 +0200
Message-Id: <20190722181923.21572-1-dev+git@drbeat.li>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - s019.cyon.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - drbeat.li
X-Get-Message-Sender-Via: s019.cyon.net: authenticated_id: ig@drbeat.li
X-Authenticated-Sender: s019.cyon.net: ig@drbeat.li
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When pcre2_jit_on is neither 1 nor 0, the BUG() call printed the value
of pcre1_jit_on.

Print the value of pcre2_jit_on instead.

Signed-off-by: Beat Bolli <dev+git@drbeat.li>
---
 grep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/grep.c b/grep.c
index f7c3a5803e..cd952ef5d3 100644
--- a/grep.c
+++ b/grep.c
@@ -559,7 +559,7 @@ static void compile_pcre2_pattern(struct grep_pat *p, const struct grep_opt *opt
 		pcre2_jit_stack_assign(p->pcre2_match_context, NULL, p->pcre2_jit_stack);
 	} else if (p->pcre2_jit_on != 0) {
 		BUG("The pcre2_jit_on variable should be 0 or 1, not %d",
-		    p->pcre1_jit_on);
+		    p->pcre2_jit_on);
 	}
 }
 
-- 
2.21.0.1020.gf2820cf01a

