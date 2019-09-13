Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 13D6E1F463
	for <e@80x24.org>; Fri, 13 Sep 2019 04:48:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727136AbfIMEsa (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Sep 2019 00:48:30 -0400
Received: from cloud.peff.net ([104.130.231.41]:48896 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726781AbfIMEs3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Sep 2019 00:48:29 -0400
Received: (qmail 23810 invoked by uid 109); 13 Sep 2019 04:48:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 13 Sep 2019 04:48:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14455 invoked by uid 111); 13 Sep 2019 04:50:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 13 Sep 2019 00:50:30 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 13 Sep 2019 00:48:28 -0400
From:   Jeff King <peff@peff.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/7] Fix more AsciiDoc/tor differences
Message-ID: <20190913044828.GA21172@sigill.intra.peff.net>
References: <cover.1567707999.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1567707999.git.martin.agren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 07, 2019 at 04:12:46PM +0200, Martin Ågren wrote:

> This series roughly halves the line count of `./doc-diff --from-asciidoc
> --to-asciidoctor --cut-header-footer HEAD HEAD`. Together with my recent
> (independent) mini-series [1], I claim that Asciidoctor 1.5.5 now
> processes the manpages better than AsciiDoc 8.6.10 does.

I looked these over, both source and rendered output (both with asciidoc
and with asciidoctor 2.0.10), and they all look good to me.

I think the delimited literal blocks are _slightly_ less pretty than the
indented ones, but this is the solution we've been using for cross-tool
compatibility (and I think it's intentional in asciidoctor to deprecate
the indented blocks, because there are just too many corner cases). The
delimited ones are also easier to write correctly.

> Patch 6/7 actually changes the rendering with both engines, so that they
> look nice and the same. The other patches are all no-ops with one engine
> while fixing things with the other -- they all improve the situation
> with Asciidoctor (which is what I care most about) except patch 1/7
> which goes the other way (it reduces the doc-diff, which helps).

Yeah, I agree that the change in 6/7 is an improvement (and 1/7 is an
obvious bugfix looking at the doc-diff using just asciidoc).

> Patch 7/7 has an element of black magic to it. I wouldn't be too
> surprised if I've managed to appease my particular versions of these
> tools while not fixing -- or maybe even breaking? -- some other versions
> [that people actually use]. That's where I think a quick test would be
> the most valuable.

I can confirm that asciidoctor 2.0.10 has the same bogus output there
before your patches, and that 7/7 fixes it.

-Peff
