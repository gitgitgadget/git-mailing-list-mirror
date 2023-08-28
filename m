Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF672C83F17
	for <git@archiver.kernel.org>; Mon, 28 Aug 2023 21:48:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233818AbjH1Vs1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Aug 2023 17:48:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233784AbjH1VsC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Aug 2023 17:48:02 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBDF6F9
        for <git@vger.kernel.org>; Mon, 28 Aug 2023 14:48:00 -0700 (PDT)
Received: (qmail 569 invoked by uid 109); 28 Aug 2023 21:48:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 28 Aug 2023 21:48:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4550 invoked by uid 111); 28 Aug 2023 21:48:01 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 28 Aug 2023 17:48:01 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 28 Aug 2023 17:47:59 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 12/22] grep: mark unused parameter in output function
Message-ID: <20230828214759.GL3831137@coredump.intra.peff.net>
References: <20230828214604.GA3830831@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230828214604.GA3830831@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a callback used with grep_options.output, but we don't look at
the grep_opt parameter, as we're just writing the output to stdout.

Signed-off-by: Jeff King <peff@peff.net>
---
 grep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/grep.c b/grep.c
index 0904d55b24..0124eb1960 100644
--- a/grep.c
+++ b/grep.c
@@ -17,7 +17,7 @@ static int grep_source_load(struct grep_source *gs);
 static int grep_source_is_binary(struct grep_source *gs,
 				 struct index_state *istate);
 
-static void std_output(struct grep_opt *opt, const void *buf, size_t size)
+static void std_output(struct grep_opt *opt UNUSED, const void *buf, size_t size)
 {
 	fwrite(buf, size, 1, stdout);
 }
-- 
2.42.0.505.g4c6fb48dec

