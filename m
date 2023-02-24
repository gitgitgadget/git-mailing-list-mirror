Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F019C678D5
	for <git@archiver.kernel.org>; Fri, 24 Feb 2023 06:40:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbjBXGkK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Feb 2023 01:40:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbjBXGju (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2023 01:39:50 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37EA563568
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 22:39:38 -0800 (PST)
Received: (qmail 3702 invoked by uid 109); 24 Feb 2023 06:39:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 24 Feb 2023 06:39:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31128 invoked by uid 111); 24 Feb 2023 06:39:38 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 24 Feb 2023 01:39:38 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 24 Feb 2023 01:39:37 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 17/21] rewrite_parents(): mark unused callback parameter
Message-ID: <Y/hbqRGwWa0NPTI1@coredump.intra.peff.net>
References: <Y/habYJxDRJQg/kJ@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y/habYJxDRJQg/kJ@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The rewrite_parents() function takes a callback, but not every callback
needs the "rev" parameter. Mark the unused one so -Wunused-parameter
will be happy.

Signed-off-by: Jeff King <peff@peff.net>
---
 line-log.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/line-log.c b/line-log.c
index a7f3e7f6ce..1ab2d75f29 100644
--- a/line-log.c
+++ b/line-log.c
@@ -1281,7 +1281,8 @@ int line_log_process_ranges_arbitrary_commit(struct rev_info *rev, struct commit
 	return changed;
 }
 
-static enum rewrite_result line_log_rewrite_one(struct rev_info *rev, struct commit **pp)
+static enum rewrite_result line_log_rewrite_one(struct rev_info *rev UNUSED,
+						struct commit **pp)
 {
 	for (;;) {
 		struct commit *p = *pp;
-- 
2.39.2.981.g6157336f25

