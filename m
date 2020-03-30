Return-Path: <SRS0=sJPh=5P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02756C43331
	for <git@archiver.kernel.org>; Mon, 30 Mar 2020 09:45:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C37E020714
	for <git@archiver.kernel.org>; Mon, 30 Mar 2020 09:45:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728259AbgC3JpO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Mar 2020 05:45:14 -0400
Received: from cloud.peff.net ([104.130.231.41]:55362 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727376AbgC3JpO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Mar 2020 05:45:14 -0400
Received: (qmail 13531 invoked by uid 109); 30 Mar 2020 09:45:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 30 Mar 2020 09:45:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16631 invoked by uid 111); 30 Mar 2020 09:55:17 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 30 Mar 2020 05:55:17 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 30 Mar 2020 05:45:13 -0400
From:   Jeff King <peff@peff.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/6] Doc: drop support for docbook-xsl before 1.74
Message-ID: <20200330094513.GB1735224@coredump.intra.peff.net>
References: <cover.1585486103.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1585486103.git.martin.agren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 29, 2020 at 03:18:04PM +0200, Martin Ågren wrote:

> In the documentation Makefile and a few helper conf and xsl files, we
> carry various workarounds to make the docs build at all or to look
> better with older docbook-xsl versions. Let's see if we can't just drop
> that support. All of this seems to have been useful at one point, but I
> doubt that anyone needs this nowadays. This was also suggested in [1].

Yay, I'm very happy to see this series. I'd be happy to go even further
if there's some benefit, but I think this removes the last of the
Makefile knobs.

Thanks for splitting each version bump into its own patch. That made it
a lot easier to see what we we're gaining from each one.

I double-checked that there's no difference with doc-diff when using a
modern asciidoc/docbook combo, though I'm sure you did as well.

> After this series, user-manual.conf still refers to older docbook-xsl
> versions. The proper fix there might be to actually be a bit more
> aggressive and drop that hunk, making the rendered docs prettier.
> There's some history there, including mentions of texinfo, which is
> outside my comfort zone. I've got work in progress there, but I'd rather
> submit that separately from these "expected no-op" patches.

Yeah, dropping that bit from user-manual.conf seems reasonable. That
shouldn't show anything in doc-diff because it's not installed with the
manpages. And the HTML build wouldn't use docbook. I installed the
zillion packages needed to build user-manual.pdf. The behavior without
that block looks significantly nicer (the example blocks are actually
shaded).

The very first example block in section 1.1 has some funny indentation,
but that's true before or after.

Anyway, that was just for my own curiosity. If you've got further work
in that area and prefer to do it as a separate series, that's fine by
me.

-Peff
