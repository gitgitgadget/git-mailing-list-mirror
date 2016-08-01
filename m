Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B3871F955
	for <e@80x24.org>; Mon,  1 Aug 2016 11:46:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753408AbcHALpt (ORCPT <rfc822;e@80x24.org>);
	Mon, 1 Aug 2016 07:45:49 -0400
Received: from mout.gmx.net ([212.227.15.19]:49487 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753302AbcHALpK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2016 07:45:10 -0400
Received: from virtualbox ([37.24.142.100]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0Ld1CS-1b3tNK2e8W-00iBrF; Mon, 01 Aug 2016 13:44:58
 +0200
Date:	Mon, 1 Aug 2016 13:44:57 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Duy Nguyen <pclouds@gmail.com>,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Subject: [PATCH v6 16/16] merge-recursive: flush output buffer even when
 erroring out
In-Reply-To: <cover.1470051326.git.johannes.schindelin@gmx.de>
Message-ID: <3b4494c586574b59d80d0f1b88bd4c3d56b678cf.1470051326.git.johannes.schindelin@gmx.de>
References: <cover.1469547160.git.johannes.schindelin@gmx.de> <cover.1470051326.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:p8Sc8xoBywk2qVdXV2znzQv2zx260UKE41MzkJXbl7ItTFrkwlw
 mlfq330OtmQg1KgWXAnFVBw01/xqeOyi8CraAYxLSWM/K2dZoAbJfwyYu3Q5JjF78ZHKFVj
 cEvtnjY/+szESU/v3ikv6xRunSLs0t1LBf2q7/z9JLExkyzWYR5+kTsuj1TkvLvD5e4MCQc
 o7jOZVWkPXXqvPCCp1vag==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:pdHYOxw3BSo=:kRGo5w8vkzrloNafJaQh66
 c+tMj8vBwwDWjVI7E0LxLj+Gm69WH6Ywrc6SyAKCmGbyQiu26+MLAAT9sMGgPI172Qu8h+bU/
 BMAQM/FCxQWFUazmFtAh/t0FwQjVQRZSwylvIq38GqHJgkRcVHMHy7NaNKbKzfEKt6bej9vLt
 Yxe0CgSnBdTtqtCHXFt2EPlCXupoeB2qPSN7T7juZD6Gk5vX8U6JksoLcp3p39Ipw5RyGECsB
 RMiIENAmrnpnAh8dI4uS6ggMGA6abMBS29ZmM73kNkHY9nyCM2ARRWwKV+Hf2kDkrKZ9dwDZL
 wqZ8tBVCQdflzI1WfCXA13JGERihX47W9CO38m5SH9oHfRM88AKy0ONj4SHwMqIvnPgVPY2qy
 BwhGj0RUFu7rIHRBt6/KUUQwjypgM5aYFzpTtOnhCdfheVSbIW5+cy4Rn0iTpfb/32IZQbAIx
 Xx81G7q2gOMQJMoZay3sHuGmSBa6GOPA47Sz+GwGp2nE/PAMdZsCwjhVmGjE2qe2gBUvl6Xzj
 B89ZDvQMdBhLMtIpz27JDUZ6Xs/RO3oxw5hIkV1LAsMFBpA2GwYR3A9+i0Uh3FNbIrJQK9KBV
 Yj4BCObh6WRXYGPT3RcHHx7OPHRjdWa0mKuc+3XNv3hB2mI31Iift/9YIVBA2Ud+/tXbYn2eF
 PewcZIeUZuDckED0EK5pSJrXRI18/xYnxDPaIjyAgb/qenOeofc/4eZxtPow72dsfDq1K4cIj
 FjMwqsc/wf2Np8CfYAy4jGYGjMzfPD2D/FaJ0a6QLxpY00ExnZ+eA/1qjMSZ7KwwGg+dA/vlB
 VGKY+nQ
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Ever since 66a155b (Enable output buffering in merge-recursive.,
2007-01-14), we had a problem: When the merge failed in a fatal way, all
regular output was swallowed because we called die() and did not get a
chance to drain the output buffers.

To fix this, several modifications were necessary:

- we needed to stop die()ing, to give callers a chance to do something
  when an error occurred (in this case, flush the output buffers),

- we needed to delay printing the error message so that the caller can
  print the buffered output before that, and

- we needed to make sure that the output buffers are flushed even when
  the return value indicates an error.

The first two changes were introduced through earlier commits in this
patch series, and this commit addresses the third one.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 merge-recursive.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 9e527de..c9e4dbc 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -2069,8 +2069,10 @@ int merge_recursive(struct merge_options *o,
 	o->ancestor = "merged common ancestors";
 	clean = merge_trees(o, h1->tree, h2->tree, merged_common_ancestors->tree,
 			    &mrtree);
-	if (clean < 0)
+	if (clean < 0) {
+		flush_output(o);
 		return clean;
+	}
 
 	if (o->call_depth) {
 		*result = make_virtual_commit(mrtree, "merged tree");
-- 
2.9.0.281.g286a8d9
