Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2623EC32771
	for <git@archiver.kernel.org>; Fri, 19 Aug 2022 10:09:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347911AbiHSKI7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Aug 2022 06:08:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348309AbiHSKIo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2022 06:08:44 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74D386A486
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 03:08:43 -0700 (PDT)
Received: (qmail 17672 invoked by uid 109); 19 Aug 2022 10:08:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 19 Aug 2022 10:08:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 934 invoked by uid 111); 19 Aug 2022 10:08:45 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 19 Aug 2022 06:08:45 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 19 Aug 2022 06:08:42 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 06/11] streaming: mark unused virtual method parameters
Message-ID: <Yv9hKkGZxeqE1Ep3@coredump.intra.peff.net>
References: <Yv9gxqH6nK2KYnNj@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yv9gxqH6nK2KYnNj@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Streaming "open" functions need to conform to the same virtual function
interface, but not every implementation needs every parameter. Mark the
unused ones as such to appease -Wunused-parameter.

Signed-off-by: Jeff King <peff@peff.net>
---
 streaming.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/streaming.c b/streaming.c
index fe54665d86..4b34e2a748 100644
--- a/streaming.c
+++ b/streaming.c
@@ -328,9 +328,9 @@ static int close_istream_pack_non_delta(struct git_istream *st)
 }
 
 static int open_istream_pack_non_delta(struct git_istream *st,
-				       struct repository *r,
-				       const struct object_id *oid,
-				       enum object_type *type)
+				       struct repository *UNUSED(r),
+				       const struct object_id *UNUSED(oid),
+				       enum object_type *UNUSED(type))
 {
 	struct pack_window *window;
 	enum object_type in_pack_type;
-- 
2.37.2.928.g0821088f4a

