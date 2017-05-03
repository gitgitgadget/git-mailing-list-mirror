Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 42E661F829
	for <e@80x24.org>; Wed,  3 May 2017 16:30:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753704AbdECQaV (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 May 2017 12:30:21 -0400
Received: from smtp2-g21.free.fr ([212.27.42.2]:43048 "EHLO smtp2-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753434AbdECQaS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2017 12:30:18 -0400
Received: from localhost.localdomain (unknown [IPv6:2a01:e35:2ef1:f910:5006:1621:c385:7777])
        by smtp2-g21.free.fr (Postfix) with ESMTP id 656892003FF;
        Wed,  3 May 2017 18:30:14 +0200 (CEST)
From:   Jean-Noel Avila <jn.avila@free.fr>
To:     git@vger.kernel.org
Cc:     Jean-Noel Avila <jn.avila@free.fr>
Subject: [PATCH 3/4] read-tree.c: rework UI when merging no trees
Date:   Wed,  3 May 2017 18:29:30 +0200
Message-Id: <20170503162931.30721-3-jn.avila@free.fr>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20170503162931.30721-1-jn.avila@free.fr>
References: <20170503162931.30721-1-jn.avila@free.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The initial test was inherited from a previous commit, but it is no
longer needed, given the following switch case. Moreover, the question
sentence ending the program has been replace by an assertative one.

Signed-off-by: Jean-Noel Avila <jn.avila@free.fr>
---
 builtin/read-tree.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/builtin/read-tree.c b/builtin/read-tree.c
index 23e212ee8..05296997c 100644
--- a/builtin/read-tree.c
+++ b/builtin/read-tree.c
@@ -226,9 +226,10 @@ int cmd_read_tree(int argc, const char **argv, const char *unused_prefix)
 		setup_work_tree();
 
 	if (opts.merge) {
-		if (stage < 2)
-			die("just how do you expect me to merge %d trees?", stage-1);
 		switch (stage - 1) {
+		case 0:
+			die("there are no trees to merge!");
+			break;
 		case 1:
 			opts.fn = opts.prefix ? bind_merge : oneway_merge;
 			break;
-- 
2.12.0

