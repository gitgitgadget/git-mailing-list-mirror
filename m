Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04143C677F1
	for <git@archiver.kernel.org>; Fri, 24 Feb 2023 06:40:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbjBXGkQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Feb 2023 01:40:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbjBXGj6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2023 01:39:58 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4513961ED1
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 22:39:42 -0800 (PST)
Received: (qmail 3707 invoked by uid 109); 24 Feb 2023 06:39:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 24 Feb 2023 06:39:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31131 invoked by uid 111); 24 Feb 2023 06:39:41 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 24 Feb 2023 01:39:41 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 24 Feb 2023 01:39:40 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 18/21] for_each_commit_graft(): mark unused callback parameter
Message-ID: <Y/hbrHxK2npFU5lR@coredump.intra.peff.net>
References: <Y/habYJxDRJQg/kJ@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y/habYJxDRJQg/kJ@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The for_each_commit_graft() functions takes a callback, but not every
callback uses the void data parameter. Mark the unused one to appease
the -Wunused-parameter warning.

Signed-off-by: Jeff King <peff@peff.net>
---
 log-tree.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/log-tree.c b/log-tree.c
index 1dd5fcbf7b..0f08864ae8 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -196,7 +196,8 @@ static int add_ref_decoration(const char *refname, const struct object_id *oid,
 	return 0;
 }
 
-static int add_graft_decoration(const struct commit_graft *graft, void *cb_data)
+static int add_graft_decoration(const struct commit_graft *graft,
+				void *cb_data UNUSED)
 {
 	struct commit *commit = lookup_commit(the_repository, &graft->oid);
 	if (!commit)
-- 
2.39.2.981.g6157336f25

