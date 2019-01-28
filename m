Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A39781F453
	for <e@80x24.org>; Mon, 28 Jan 2019 18:31:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727677AbfA1SbU (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Jan 2019 13:31:20 -0500
Received: from cloud.peff.net ([104.130.231.41]:51762 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727672AbfA1SbT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jan 2019 13:31:19 -0500
Received: (qmail 8730 invoked by uid 109); 28 Jan 2019 18:31:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 28 Jan 2019 18:31:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27868 invoked by uid 111); 28 Jan 2019 18:31:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 28 Jan 2019 13:31:25 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 28 Jan 2019 13:31:17 -0500
Date:   Mon, 28 Jan 2019 13:31:17 -0500
From:   Jeff King <peff@peff.net>
To:     Sergey Lukashev <lukashev.s@ya.ru>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: unclear docs
Message-ID: <20190128183117.GA13165@sigill.intra.peff.net>
References: <57362151548583138@iva8-37fc2ad204cd.qloud-c.yandex.net>
 <13169311548590123@iva1-16f33c6a446b.qloud-c.yandex.net>
 <20190128160944.GB23588@sigill.intra.peff.net>
 <1593541548699120@myt6-27270b78ac4f.qloud-c.yandex.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1593541548699120@myt6-27270b78ac4f.qloud-c.yandex.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 28, 2019 at 09:12:00PM +0300, Sergey Lukashev wrote:

> Thank you. Does the paragraph about core.eol refers to the text
> attribute? It's written 'property' there. I was thinking it means
> whether git thinks file is text, using .gitattributes OR otherwise.
> Maybe changing this word will make it clearer?

Yeah, I think the word "property" is unnecessarily confusing. Here's
another patch (meant to go on top of the other).

-- >8 --
Subject: [PATCH] docs/config: clarify "text property" in core.eol

The word "property" is less clear than "attribute", which is used
elsewhere in the (surprise!) gitattributes documentation. So let's use
that.

While we're here, let's make the paragraph a little easier to read by
de-emphasizing the "when core.autocrlf is false" bit. Putting it in the
first sentence obscures the main content, and many readers won't care
about autocrlf (i.e., anyone who is just following the gitattributes(7)
advice, which mainly discusses "text" and "core.eol").

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/config/core.txt | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/config/core.txt b/Documentation/config/core.txt
index d0e6635fe0..69c73ffe30 100644
--- a/Documentation/config/core.txt
+++ b/Documentation/config/core.txt
@@ -121,11 +121,12 @@ core.quotePath::
 
 core.eol::
 	Sets the line ending type to use in the working directory for
-	files that have the `text` property set when core.autocrlf is false.
+	files that have the `text` attribute.
 	Alternatives are 'lf', 'crlf' and 'native', which uses the platform's
 	native line ending.  The default value is `native`.  See
 	linkgit:gitattributes[5] for more information on end-of-line
-	conversion.
+	conversion. Note that this value is ignored if `core.autocrlf`
+	is set to `true`.
 
 core.safecrlf::
 	If true, makes Git check if converting `CRLF` is reversible when
-- 
2.20.1.845.g57b86ca485

