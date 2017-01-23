Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0AAB020A17
	for <e@80x24.org>; Mon, 23 Jan 2017 18:01:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751283AbdAWSBK (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jan 2017 13:01:10 -0500
Received: from 89-28-117-31.starnet.md ([89.28.117.31]:50704 "EHLO
        home.thecybershadow.net" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1750738AbdAWSBJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jan 2017 13:01:09 -0500
Received: by home.thecybershadow.net (Postfix, from userid 1000)
        id 4B42655FC5A; Mon, 23 Jan 2017 18:01:05 +0000 (UTC)
From:   Vladimir Panteleev <git@thecybershadow.net>
To:     git@vger.kernel.org
Cc:     Vladimir Panteleev <git@thecybershadow.net>
Subject: [PATCH v3 5/5] show-ref: Remove dead `if (verify)' check
Date:   Mon, 23 Jan 2017 18:00:59 +0000
Message-Id: <20170123180059.4288-6-git@thecybershadow.net>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170123180059.4288-1-git@thecybershadow.net>
References: <20170123180059.4288-1-git@thecybershadow.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As show_ref is only ever called on the path where --verify is not
specified, `verify' can never possibly be true here.

Signed-off-by: Vladimir Panteleev <git@thecybershadow.net>
---
 builtin/show-ref.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/builtin/show-ref.c b/builtin/show-ref.c
index 107d05fe0..2dfcb5634 100644
--- a/builtin/show-ref.c
+++ b/builtin/show-ref.c
@@ -73,9 +73,6 @@ static int show_ref(const char *refname, const struct object_id *oid,
 				continue;
 			if (len == reflen)
 				goto match;
-			/* "--verify" requires an exact match */
-			if (verify)
-				continue;
 			if (refname[reflen - len - 1] == '/')
 				goto match;
 		}
-- 
2.11.0

