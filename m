Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF537C61DA3
	for <git@archiver.kernel.org>; Fri, 24 Feb 2023 06:40:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbjBXGkJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Feb 2023 01:40:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbjBXGjr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2023 01:39:47 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88E9D61F1C
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 22:39:36 -0800 (PST)
Received: (qmail 3699 invoked by uid 109); 24 Feb 2023 06:39:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 24 Feb 2023 06:39:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31125 invoked by uid 111); 24 Feb 2023 06:39:35 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 24 Feb 2023 01:39:35 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 24 Feb 2023 01:39:35 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 16/21] fetch-pack: mark unused parameter in callback function
Message-ID: <Y/hbp4onkIEqELNN@coredump.intra.peff.net>
References: <Y/habYJxDRJQg/kJ@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y/habYJxDRJQg/kJ@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The for_each_cached_alternate() interface requires a callback that takes
a negotiator parameter, but not all implementations need it. Mark the
unused one as such to appease -Wunused-parameter.

Signed-off-by: Jeff King <peff@peff.net>
---
 fetch-pack.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index 04016d1e32..67a7786865 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -722,7 +722,7 @@ static void filter_refs(struct fetch_pack_args *args,
 	*refs = newlist;
 }
 
-static void mark_alternate_complete(struct fetch_negotiator *unused,
+static void mark_alternate_complete(struct fetch_negotiator *negotiator UNUSED,
 				    struct object *obj)
 {
 	mark_complete(&obj->oid);
-- 
2.39.2.981.g6157336f25

