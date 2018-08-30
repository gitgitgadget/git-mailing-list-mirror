Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 65D191F404
	for <e@80x24.org>; Thu, 30 Aug 2018 19:55:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727360AbeH3X7h (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Aug 2018 19:59:37 -0400
Received: from cloud.peff.net ([104.130.231.41]:34522 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727088AbeH3X7h (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Aug 2018 19:59:37 -0400
Received: (qmail 8475 invoked by uid 109); 30 Aug 2018 19:55:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 30 Aug 2018 19:55:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30895 invoked by uid 111); 30 Aug 2018 19:55:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 30 Aug 2018 15:55:57 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 30 Aug 2018 15:55:46 -0400
Date:   Thu, 30 Aug 2018 15:55:46 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] doc/Makefile: remove tmp-doc-diff on "make clean"
Message-ID: <20180830195546.GA22407@sigill.intra.peff.net>
References: <20180830081202.GA10224@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180830081202.GA10224@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The tmp-doc-diff directory isn't strictly a build product of
the Makefile, since it's only present if you manually run
the doc-diff script.  But anybody running "make clean" would
probably want it to go away.

Suggested-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Jeff King <peff@peff.net>
---
> Another fixup for jk/diff-rendered-docs,[...]

And here's one more. I don't have a strong opinion on this myself, but
it seems sensible. I doubt anybody cares overly much about the cost of
an extra $(RM) during "make clean" (and if they do, we really ought to
consider joining the existing ones into a single invocation).

 Documentation/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index a42dcfc745..99a349ce9a 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -332,6 +332,7 @@ clean:
 	$(RM) SubmittingPatches.txt
 	$(RM) $(cmds_txt) $(mergetools_txt) *.made
 	$(RM) manpage-base-url.xsl
+	$(RM) -r tmp-doc-diff
 
 $(MAN_HTML): %.html : %.txt asciidoc.conf
 	$(QUIET_ASCIIDOC)$(RM) $@+ $@ && \
-- 
2.19.0.rc1.546.g3fcb3c0d7c


