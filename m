Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C47220357
	for <e@80x24.org>; Mon, 10 Jul 2017 13:25:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754127AbdGJNYz (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Jul 2017 09:24:55 -0400
Received: from cloud.peff.net ([104.130.231.41]:35394 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753864AbdGJNYy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jul 2017 09:24:54 -0400
Received: (qmail 17822 invoked by uid 109); 10 Jul 2017 13:24:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 10 Jul 2017 13:24:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5064 invoked by uid 111); 10 Jul 2017 13:25:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Mon, 10 Jul 2017 09:25:00 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 10 Jul 2017 09:24:47 -0400
Date:   Mon, 10 Jul 2017 09:24:47 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 4/5] Makefile: turn off -fomit-frame-pointer with sanitizers
Message-ID: <20170710132447.atwjp2pj6xk6md4i@sigill.intra.peff.net>
References: <20170710132418.d6bvzxwvbejretb4@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170710132418.d6bvzxwvbejretb4@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The ASan manual recommends disabling this optimization, as
it can make the backtraces produced by the tool harder to
follow (and since this is a test-debug build, we don't care
about squeezing out every last drop of performance).

Signed-off-by: Jeff King <peff@peff.net>
---
 Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Makefile b/Makefile
index 59f6bdcd7..cc03b3c95 100644
--- a/Makefile
+++ b/Makefile
@@ -1014,6 +1014,7 @@ endif
 
 ifdef SANITIZE
 BASIC_CFLAGS += -fsanitize=$(SANITIZE) -fno-sanitize-recover=$(SANITIZE)
+BASIC_CFLAGS += -fno-omit-frame-pointer
 endif
 
 ifndef sysconfdir
-- 
2.13.2.1071.gcd8104b61

