Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33D92C433ED
	for <git@archiver.kernel.org>; Wed, 19 May 2021 09:17:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12A2560FE4
	for <git@archiver.kernel.org>; Wed, 19 May 2021 09:17:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344364AbhESJSb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 May 2021 05:18:31 -0400
Received: from cloud.peff.net ([104.130.231.41]:58738 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343716AbhESJSa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 May 2021 05:18:30 -0400
Received: (qmail 22460 invoked by uid 109); 19 May 2021 09:17:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 19 May 2021 09:17:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17684 invoked by uid 111); 19 May 2021 09:17:11 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 19 May 2021 05:17:11 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 19 May 2021 05:17:09 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: [PATCH] doc: explain the use of color.pager
Message-ID: <YKTXlTjwOUi4W+R8@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The current documentation for color.pager is technically correct, but
slightly misleading and doesn't really clarify the purpose of the
variable. As explained in the original thread which added it:

  https://lore.kernel.org/git/E1G6zPH-00062L-Je@moooo.ath.cx/

the point is deal with pagers that don't understand colors. And hence it
being set to "true" is necessary for colorizing output to the pager, but
not sufficient by itself (you must also have enabled one of the other
color options, though note that these are set to "auto" by default these
days).

Signed-off-by: Jeff King <peff@peff.net>
---
Just a loose end from:

  https://lore.kernel.org/git/xmqqlf8c2k2y.fsf@gitster.g/

that I think is worth tying up before we forget.

 Documentation/config/color.txt | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/config/color.txt b/Documentation/config/color.txt
index d5daacb13a..e05d520a86 100644
--- a/Documentation/config/color.txt
+++ b/Documentation/config/color.txt
@@ -127,8 +127,9 @@ color.interactive.<slot>::
 	interactive commands.
 
 color.pager::
-	A boolean to enable/disable colored output when the pager is in
-	use (default is true).
+	A boolean to specify whether `auto` color modes should colorize
+	output going to the pager. Defaults to true; set this to false
+	if your pager does not understand ANSI color codes.
 
 color.push::
 	A boolean to enable/disable color in push errors. May be set to
-- 
2.32.0.rc0.424.g95d3bde94f
