Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF94D20248
	for <e@80x24.org>; Wed, 20 Mar 2019 08:14:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbfCTIOc (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Mar 2019 04:14:32 -0400
Received: from cloud.peff.net ([104.130.231.41]:57422 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725942AbfCTIOc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Mar 2019 04:14:32 -0400
Received: (qmail 19625 invoked by uid 109); 20 Mar 2019 08:14:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 20 Mar 2019 08:14:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6315 invoked by uid 111); 20 Mar 2019 08:14:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 20 Mar 2019 04:14:53 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Mar 2019 04:14:30 -0400
Date:   Wed, 20 Mar 2019 04:14:30 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 05/13] test-date: drop unused "now" parameter from
 parse_dates()
Message-ID: <20190320081430.GE10403@sigill.intra.peff.net>
References: <20190320081258.GA5621@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190320081258.GA5621@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We only need the current time for relative dates like "5
minutes ago", and those are parsed only through approxidate,
not the strict parser used by parse_dates().

Signed-off-by: Jeff King <peff@peff.net>
---
 t/helper/test-date.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/helper/test-date.c b/t/helper/test-date.c
index b3253803ac..585347ea48 100644
--- a/t/helper/test-date.c
+++ b/t/helper/test-date.c
@@ -55,7 +55,7 @@ static void show_dates(const char **argv, const char *format)
 	}
 }
 
-static void parse_dates(const char **argv, struct timeval *now)
+static void parse_dates(const char **argv)
 {
 	struct strbuf result = STRBUF_INIT;
 
@@ -124,7 +124,7 @@ int cmd__date(int argc, const char **argv)
 	else if (skip_prefix(*argv, "show:", &x))
 		show_dates(argv+1, x);
 	else if (!strcmp(*argv, "parse"))
-		parse_dates(argv+1, &now);
+		parse_dates(argv+1);
 	else if (!strcmp(*argv, "approxidate"))
 		parse_approxidate(argv+1, &now);
 	else if (!strcmp(*argv, "timestamp"))
-- 
2.21.0.701.g4401309e11

