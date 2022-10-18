Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A299C43217
	for <git@archiver.kernel.org>; Tue, 18 Oct 2022 01:09:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbiJRBJW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Oct 2022 21:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231235AbiJRBI7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Oct 2022 21:08:59 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A756686809
        for <git@vger.kernel.org>; Mon, 17 Oct 2022 18:08:52 -0700 (PDT)
Received: (qmail 28803 invoked by uid 109); 18 Oct 2022 01:08:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 18 Oct 2022 01:08:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13474 invoked by uid 111); 18 Oct 2022 01:08:53 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 17 Oct 2022 21:08:53 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 17 Oct 2022 21:08:51 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 09/12] apply: mark unused parameters in noop error/warning
 routine
Message-ID: <Y038o3i6gt4retMQ@coredump.intra.peff.net>
References: <Y036whEorZV0rOgB@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y036whEorZV0rOgB@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We squelch error/warning output by passing a noop handler to
set_error_routine(). We need to tell the compiler that this is intended
so that it doesn't trigger -Wunused-parameter.

Signed-off-by: Jeff King <peff@peff.net>
---
 apply.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/apply.c b/apply.c
index fa9a02771c..6b4dbe0c88 100644
--- a/apply.c
+++ b/apply.c
@@ -125,7 +125,7 @@ void clear_apply_state(struct apply_state *state)
 	/* &state->fn_table is cleared at the end of apply_patch() */
 }
 
-static void mute_routine(const char *msg, va_list params)
+static void mute_routine(const char *msg UNUSED, va_list params UNUSED)
 {
 	/* do nothing */
 }
-- 
2.38.0.371.g300879f34e

