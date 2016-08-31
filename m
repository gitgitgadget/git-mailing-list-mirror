Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E4571F6BF
	for <e@80x24.org>; Wed, 31 Aug 2016 08:57:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759421AbcHaI4x (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Aug 2016 04:56:53 -0400
Received: from mout.gmx.net ([212.227.17.21]:63886 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933890AbcHaI4s (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2016 04:56:48 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0LeBPM-1bJzrR1ebk-00psCN; Wed, 31 Aug 2016 10:56:33
 +0200
Date:   Wed, 31 Aug 2016 10:56:32 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 30/34] sequencer (rebase -i): show only failed cherry-picks'
 output
In-Reply-To: <cover.1472633606.git.johannes.schindelin@gmx.de>
Message-ID: <660acea3122b6379c7545b04fbecd94243c9fd02.1472633606.git.johannes.schindelin@gmx.de>
References: <cover.1472633606.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:VzIxQgbQf6IUgGeS89Bbqg8zLwXgC40smsEnDTTCDvfS5cG9n9z
 RpFMwNw1fkFxw+uhWrTzIlA7JBNzBpOfGIEg8Aa20CV69NQKGLDC1H6xwq6V+yT8SlRKpZJ
 ezCsrMsg75yv57O6amczt6/TzPYaeh1N9H29h9mDhgn5nIfMZahAd6u4QN+klxFEYbd2eEd
 qgXAtEHH1qrr+/ATricMg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:S7Km2jOXVts=:rCqj0HzPSwRjEnLatiKWTj
 2duKfLtOaF1vsLJU/RsAzOeyOwhGHy4uEVOqWSBrQHbozJee6mPpP/EJ0EWMNezFgE2XcOH2n
 2hIv5JAb6YKAgiKFpPHdB1hJewK5AU2BM7F/c4NODQHMw1OdoYTPm24yYFYD4pxC06QhKtI5R
 LHhZO2U6aRMQpQR/TRWgC7HJ0FTqR9eqBH/GPIdHRN30VpXetH+aVzO8v37m0Mj59+B6i2CEX
 tXdYyXkGZB/B2BGe4+5YL3/gvPNVaJzA5ZjCac9XwIcUMF1G6gvknnG1prKFd3OjMlgE8g16m
 rgNh8Vv+/A0OUJODV5MT+tdpuGrda2x226szQfpLUC5Ev3b2Vt2DMyb8mDBrSay+yt8ATur/j
 pU3+GXpedGGlV7iq3Db6GYV9rCw7LOPNrJ4T81QNVUw4EchxX0kj5h8IObkr+LFo/TSjqyvkX
 /rUa//nyvA+HWivaKji+p9W+S3ibR+C0Bxi7b5n1OFllBU3xvq/pTcx2SZniB/3oe+PxHQTfA
 8PFuQ3IKNzqeQJuW+tO67uqm0nkmULaCZ2lGIai51vtBitWfO7JYVsWUE2IkGiRSWtxJ1WCyG
 6yczHz9ClkSfKOzrc/cf1yYMMzIF5rIzxR3iOKb/PrZ82dLLk0sx4jm7kdugjKlrlxGC/lAsB
 B7jBmmaFIVP5XGQ26niAlslhP13/WgAAVD4QI4aBpi/m3MSAPmydlU5Iz230+3J1yFKTsvb9k
 5MCqJqNryM/Y+KtHbD+cS6ZOeq8PAAy2GpZh7G3YcevrNeKD2aC0nf14H7q4fArjmu8jg4jfv
 K3hHaF3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is the behavior of the shell script version of the interactive
rebase, by using the `output` function defined in `git-rebase.sh`.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sequencer.c b/sequencer.c
index 22568d2..b34c381 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -477,6 +477,8 @@ static int do_recursive_merge(struct commit *base, struct commit *next,
 	o.ancestor = base ? base_label : "(empty tree)";
 	o.branch1 = "HEAD";
 	o.branch2 = next ? next_label : "(empty tree)";
+	if (is_rebase_i(opts))
+		o.buffer_output = 2;
 
 	head_tree = parse_tree_indirect(head);
 	next_tree = next ? next->tree : empty_tree();
@@ -488,6 +490,8 @@ static int do_recursive_merge(struct commit *base, struct commit *next,
 	clean = merge_trees(&o,
 			    head_tree,
 			    next_tree, base_tree, &result);
+	if (is_rebase_i(opts) && clean <= 0)
+		fputs(o.obuf.buf, stdout);
 	strbuf_release(&o.obuf);
 	if (clean < 0)
 		return clean;
-- 
2.10.0.rc2.102.g5c102ec


