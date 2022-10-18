Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E5A5C4167E
	for <git@archiver.kernel.org>; Tue, 18 Oct 2022 01:09:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbiJRBJ1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Oct 2022 21:09:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231271AbiJRBJC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Oct 2022 21:09:02 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C8139411D
        for <git@vger.kernel.org>; Mon, 17 Oct 2022 18:08:56 -0700 (PDT)
Received: (qmail 28806 invoked by uid 109); 18 Oct 2022 01:08:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 18 Oct 2022 01:08:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13477 invoked by uid 111); 18 Oct 2022 01:08:56 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 17 Oct 2022 21:08:56 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 17 Oct 2022 21:08:54 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 10/12] convert: mark unused parameter in null stream filter
Message-ID: <Y038poWdaLOZdp+J@coredump.intra.peff.net>
References: <Y036whEorZV0rOgB@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y036whEorZV0rOgB@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The null stream filter unsurprisingly does not look at its "filter"
argument, since it just eats bytes. But we can't drop it, since it has
to conform to the same virtual interface that real filters do. Mark the
unused parameter to appease -Wunused-parameter.

Signed-off-by: Jeff King <peff@peff.net>
---
 convert.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/convert.c b/convert.c
index 95e6a5244f..9b67649032 100644
--- a/convert.c
+++ b/convert.c
@@ -1549,7 +1549,7 @@ struct stream_filter {
 	struct stream_filter_vtbl *vtbl;
 };
 
-static int null_filter_fn(struct stream_filter *filter,
+static int null_filter_fn(struct stream_filter *filter UNUSED,
 			  const char *input, size_t *isize_p,
 			  char *output, size_t *osize_p)
 {
@@ -1568,7 +1568,7 @@ static int null_filter_fn(struct stream_filter *filter,
 	return 0;
 }
 
-static void null_free_fn(struct stream_filter *filter)
+static void null_free_fn(struct stream_filter *filter UNUSED)
 {
 	; /* nothing -- null instances are shared */
 }
-- 
2.38.0.371.g300879f34e

