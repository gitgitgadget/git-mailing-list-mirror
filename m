Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 761641F437
	for <e@80x24.org>; Sat, 28 Jan 2017 21:43:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752247AbdA1VnA (ORCPT <rfc822;e@80x24.org>);
        Sat, 28 Jan 2017 16:43:00 -0500
Received: from mout.web.de ([212.227.15.3]:62384 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752205AbdA1Vm6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Jan 2017 16:42:58 -0500
Received: from [192.168.178.36] ([79.237.55.102]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M8oFY-1cd8gR2VRs-00C8Zf; Sat, 28
 Jan 2017 22:42:27 +0100
Subject: [PATCH 5/5] graph: use SWAP macro
To:     Git List <git@vger.kernel.org>
References: <8ef4c833-45bd-6831-0683-6d01f30aa518@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <af5a7205-7703-f5ad-4ea2-b20ab4c01c80@web.de>
Date:   Sat, 28 Jan 2017 22:42:15 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.6.0
MIME-Version: 1.0
In-Reply-To: <8ef4c833-45bd-6831-0683-6d01f30aa518@web.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:dUKtzo0kq7FhPanMgjpcCc5By4aWbHJgPk9x0C/a9xNhA5IjxkC
 xYFW7EOiw3nLKcwMBOZ/QDqgiQIE4q9Ah0VPOwHfNZ+EieqWI5xXoeqaJmN7FgzfGWhnPX4
 hP+WBSWrM4nenQZlz4gMkvAXJlb9iAxRqTPAojR2O4HMzd8ZpKIi+zxu+TdvvA8fQRXFeED
 +rrf6H4fJKRDEUn5kwp9Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:15hg880U6mo=:05tPlXCHh/ItmlSuS/GZBO
 X2Kv5RxFUIaglsLW8akqNwJgm/ZMgfm9uHIDQi9i2ETF4GJO5ifmov4P6G0D56k5w3dJqCgmL
 sRbgqbLW9QVvlpE440mn4oWxPv41TjxZ8CVK/eq6G7RxZqc/r95UX+i/s7JmFiLtyHD3OaZoK
 QpZb1K2l3ZULdCjjspYxhZINm48gYZngigkI0sVcv81Lk9yHAxIl7cuWuvAKBvVdgHTzfXXqL
 8N9E1acgAQj4vaAElZmzmWNGReR4IbeSonCZHS5lYvXezzqi0UE6ysl/idPKtDNOXmVN0BKBS
 XSut3aXphg1/m9JnrpTSPwbj+1KWY2G1XvbuJ4AXeS1dUDwgbA4tkEwiYj+GVEMrfDfnEHbl/
 2LEVlxVCAEwgnxJyt2VIj4PoCKOsYhVJfxe3x6gvZaml/TUNbrycHUhFRNIAypBqKTLAskZwA
 KC1igGqag73rJs4szXwfFsgQSMCrt5wvKW4mtY6iztu/y+m2c+4TMRL0W8voL6MKDqn5/nujP
 KUN+edKskyfYctlwF+5HzGP/3M0YW3lsL4lElxs+pdrKG/p2EAwa0VjuLegsU0vEEh68gBbOG
 NmZC6Li175NxAp1I+sfkP9DVOEFGWPRguTQI/KC63MpVLMyhpyGa7S6OXzo4t/5minuZU6SQX
 5LO4RATZbPZsuc7hLdfHR2ymYvm6eem/tkKNLrx9812VjL3iwbecPXXzPvIJRruJ+oTVO5CjG
 NGMDfK9zE92ByiHLgG5GuJdZv5OK6gfjxHzpiQ6viMge2RoE4G0yT+9BDJXa0iMi2uCYIiDfW
 giIlIOK
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Exchange the values of graph->columns and graph->new_columns using the
macro SWAP instead of hand-rolled code.  The result is shorter and
easier to read.

This transformation was not done by the semantic patch swap.cocci
because there's an unrelated statement between the second and the last
step of the exchange, so it didn't match the expected pattern.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 graph.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/graph.c b/graph.c
index 4c722303d2..29b0f51dc5 100644
--- a/graph.c
+++ b/graph.c
@@ -463,7 +463,6 @@ static void graph_update_width(struct git_graph *graph,
 static void graph_update_columns(struct git_graph *graph)
 {
 	struct commit_list *parent;
-	struct column *tmp_columns;
 	int max_new_columns;
 	int mapping_idx;
 	int i, seen_this, is_commit_in_columns;
@@ -476,11 +475,8 @@ static void graph_update_columns(struct git_graph *graph)
 	 * We'll re-use the old columns array as storage to compute the new
 	 * columns list for the commit after this one.
 	 */
-	tmp_columns = graph->columns;
-	graph->columns = graph->new_columns;
+	SWAP(graph->columns, graph->new_columns);
 	graph->num_columns = graph->num_new_columns;
-
-	graph->new_columns = tmp_columns;
 	graph->num_new_columns = 0;
 
 	/*
-- 
2.11.0

