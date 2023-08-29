Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06ACCC83F1B
	for <git@archiver.kernel.org>; Tue, 29 Aug 2023 23:46:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241298AbjH2XqF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Aug 2023 19:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241295AbjH2Xpj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Aug 2023 19:45:39 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82477CD9
        for <git@vger.kernel.org>; Tue, 29 Aug 2023 16:45:28 -0700 (PDT)
Received: (qmail 14892 invoked by uid 109); 29 Aug 2023 23:45:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 29 Aug 2023 23:45:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19886 invoked by uid 111); 29 Aug 2023 23:45:28 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 29 Aug 2023 19:45:28 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 29 Aug 2023 19:45:27 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v2 12/22] grep: mark unused parameter in output function
Message-ID: <20230829234527.GJ227214@coredump.intra.peff.net>
References: <20230829234305.GA226944@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230829234305.GA226944@coredump.intra.peff.net>
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
2.42.0.528.g7950723a09

