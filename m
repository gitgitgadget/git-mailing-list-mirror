Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFF29C71153
	for <git@archiver.kernel.org>; Tue, 29 Aug 2023 23:46:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241296AbjH2Xq2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Aug 2023 19:46:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241327AbjH2Xpw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Aug 2023 19:45:52 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C356CF4
        for <git@vger.kernel.org>; Tue, 29 Aug 2023 16:45:31 -0700 (PDT)
Received: (qmail 14914 invoked by uid 109); 29 Aug 2023 23:45:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 29 Aug 2023 23:45:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19899 invoked by uid 111); 29 Aug 2023 23:45:31 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 29 Aug 2023 19:45:31 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 29 Aug 2023 19:45:30 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v2 14/22] negotiator/noop: mark unused callback parameters
Message-ID: <20230829234530.GL227214@coredump.intra.peff.net>
References: <20230829234305.GA226944@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230829234305.GA226944@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The noop negotiator unsurprisingly does not bother looking at any of its
parameters. Mark them unused to silence -Wunused-parameter.

Signed-off-by: Jeff King <peff@peff.net>
---
 negotiator/noop.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/negotiator/noop.c b/negotiator/noop.c
index 7b72937686..de39028ab7 100644
--- a/negotiator/noop.c
+++ b/negotiator/noop.c
@@ -3,22 +3,24 @@
 #include "../commit.h"
 #include "../fetch-negotiator.h"
 
-static void known_common(struct fetch_negotiator *n, struct commit *c)
+static void known_common(struct fetch_negotiator *n UNUSED,
+			 struct commit *c UNUSED)
 {
 	/* do nothing */
 }
 
-static void add_tip(struct fetch_negotiator *n, struct commit *c)
+static void add_tip(struct fetch_negotiator *n UNUSED,
+		    struct commit *c UNUSED)
 {
 	/* do nothing */
 }
 
-static const struct object_id *next(struct fetch_negotiator *n)
+static const struct object_id *next(struct fetch_negotiator *n UNUSED)
 {
 	return NULL;
 }
 
-static int ack(struct fetch_negotiator *n, struct commit *c)
+static int ack(struct fetch_negotiator *n UNUSED, struct commit *c UNUSED)
 {
 	/*
 	 * This negotiator does not emit any commits, so there is no commit to
@@ -28,7 +30,7 @@ static int ack(struct fetch_negotiator *n, struct commit *c)
 	return 0;
 }
 
-static void release(struct fetch_negotiator *n)
+static void release(struct fetch_negotiator *n UNUSED)
 {
 	/* nothing to release */
 }
-- 
2.42.0.528.g7950723a09

