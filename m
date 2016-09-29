Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A7F420987
	for <e@80x24.org>; Thu, 29 Sep 2016 08:33:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755338AbcI2Idr (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Sep 2016 04:33:47 -0400
Received: from cloud.peff.net ([104.130.231.41]:49780 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755033AbcI2Idp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Sep 2016 04:33:45 -0400
Received: (qmail 10142 invoked by uid 109); 29 Sep 2016 08:33:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 29 Sep 2016 08:33:44 +0000
Received: (qmail 32084 invoked by uid 111); 29 Sep 2016 08:33:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 29 Sep 2016 04:33:59 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 29 Sep 2016 04:33:42 -0400
Date:   Thu, 29 Sep 2016 04:33:42 -0400
From:   Jeff King <peff@peff.net>
To:     "Kyle J. McKay" <mackyle@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/5] pretty: allow formatting DATE_SHORT
Message-ID: <20160929083342.ozo2tef45hu4ox7g@sigill.intra.peff.net>
References: <20160929083315.vwb3aurwbyjwlkjn@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160929083315.vwb3aurwbyjwlkjn@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There's no way to do this short of "%ad" and --date=short,
but that limits you to having a single date format in the
output.

This would possibly be better done with something more like
"%ad(short)".

Signed-off-by: Jeff King <peff@peff.net>
---
 pretty.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/pretty.c b/pretty.c
index 493edb0..c532c17 100644
--- a/pretty.c
+++ b/pretty.c
@@ -727,6 +727,9 @@ static size_t format_person_part(struct strbuf *sb, char part,
 	case 'I':	/* date, ISO 8601 strict */
 		strbuf_addstr(sb, show_ident_date(&s, DATE_MODE(ISO8601_STRICT)));
 		return placeholder_len;
+	case 's':
+		strbuf_addstr(sb, show_ident_date(&s, DATE_MODE(SHORT)));
+		return placeholder_len;
 	}
 
 skip:
-- 
2.10.0.566.g5365f87

