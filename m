Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D8E7B201B0
	for <e@80x24.org>; Tue, 28 Feb 2017 12:37:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752326AbdB1Mh5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Feb 2017 07:37:57 -0500
Received: from cloud.peff.net ([104.130.231.41]:35587 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751737AbdB1Mh5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Feb 2017 07:37:57 -0500
Received: (qmail 24091 invoked by uid 109); 28 Feb 2017 12:37:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Feb 2017 12:37:56 +0000
Received: (qmail 25619 invoked by uid 111); 28 Feb 2017 12:38:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Feb 2017 07:38:02 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 28 Feb 2017 07:37:54 -0500
Date:   Tue, 28 Feb 2017 07:37:54 -0500
From:   Jeff King <peff@peff.net>
To:     Patrick Steinhardt <patrick.steinhardt@elego.de>
Cc:     git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 2/2] docs/diffcore: unquote "Complete Rewrites" in headers
Message-ID: <20170228123753.6k646m7jnyc5uoav@sigill.intra.peff.net>
References: <2882e77a58e4219d60a39827c3ea8d4537d5178a.1488272203.git.patrick.steinhardt@elego.de>
 <576fa5be072ebd503aa553ef24290c77ed34eeb1.1488272203.git.patrick.steinhardt@elego.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <576fa5be072ebd503aa553ef24290c77ed34eeb1.1488272203.git.patrick.steinhardt@elego.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 28, 2017 at 09:59:05AM +0100, Patrick Steinhardt wrote:

> The gitdiffcore documentation quotes the term "Complete Rewrites" in
> headers for no real gain. This would make sense if the term could be
> easily confused if not properly grouped together. But actually, the term
> is quite obvious and thus does not really need any quoting, especially
> regarding that it is not used anywhere else.
> 
> But more importanly, this brings up a bug when rendering man pages: when
> trying to render quotes inside of a section header, we end up with
> quotes which have been misaligned to the end of line. E.g.
> 
>     diffcore-break: For Splitting Up Complete Rewrites
>     --------------------------------------------------
> 
> renders as
> 
>     DIFFCORE-BREAK: FOR SPLITTING UP  COMPLETE REWRITES""
> 
> , which is obviously wrong. While this is fixable for the man pages by
> using double-quotes (e.g. ""COMPLETE REWRITES""), this again breaks it
> for our generated HTML pages.
> 
> So fix the issue by simply dropping quotes inside of section headers,
> which is currently only done for the term "Complete Rewrites".

Thanks for a nice explanation of the issue. I was curious whether
asciidoctor gets this right. It does, though I suppose that's because we
only look at the HTML output. It sounds like the issue is in the
docbook->roff path.

At any rate, I agree with your analysis. It's not worth futzing with the
formatting when it reads just as well without the quotes.

-Peff
