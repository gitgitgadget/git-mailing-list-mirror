Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3911CC61DA3
	for <git@archiver.kernel.org>; Fri, 24 Feb 2023 06:40:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbjBXGkV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Feb 2023 01:40:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjBXGj7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2023 01:39:59 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 350B161EF4
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 22:39:45 -0800 (PST)
Received: (qmail 3710 invoked by uid 109); 24 Feb 2023 06:39:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 24 Feb 2023 06:39:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31134 invoked by uid 111); 24 Feb 2023 06:39:44 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 24 Feb 2023 01:39:44 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 24 Feb 2023 01:39:43 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 19/21] userformat_want_item(): mark unused parameter
Message-ID: <Y/hbr8J0vxKYnd+/@coredump.intra.peff.net>
References: <Y/habYJxDRJQg/kJ@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y/habYJxDRJQg/kJ@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This function is used as a callback to strbuf_expand(), so it must
conform to the correct interface. But naturally it doesn't need to touch
its "sb" parameter, since it is only examining the placeholder string,
and not actually writing any output. So mark the unused parameter to
silence -Wunused-parameter.

Signed-off-by: Jeff King <peff@peff.net>
---
 pretty.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/pretty.c b/pretty.c
index 1e1e21878c..2e47292407 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1857,7 +1857,8 @@ static size_t format_commit_item(struct strbuf *sb, /* in UTF-8 */
 	return consumed + 1;
 }
 
-static size_t userformat_want_item(struct strbuf *sb, const char *placeholder,
+static size_t userformat_want_item(struct strbuf *sb UNUSED,
+				   const char *placeholder,
 				   void *context)
 {
 	struct userformat_want *w = context;
-- 
2.39.2.981.g6157336f25

