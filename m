Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B41D208B4
	for <e@80x24.org>; Thu, 10 Aug 2017 18:37:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752740AbdHJShQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Aug 2017 14:37:16 -0400
Received: from cloud.peff.net ([104.130.231.41]:34858 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752504AbdHJShP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2017 14:37:15 -0400
Received: (qmail 21472 invoked by uid 109); 10 Aug 2017 18:37:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 10 Aug 2017 18:37:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7481 invoked by uid 111); 10 Aug 2017 18:37:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 10 Aug 2017 14:37:38 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 10 Aug 2017 14:37:13 -0400
Date:   Thu, 10 Aug 2017 14:37:13 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH 4/5] interpret-trailers: add an option to normalize output
Message-ID: <20170810183713.z75bwk5eeavi6z22@sigill.intra.peff.net>
References: <20170810080246.njjd5zkphytzmlda@sigill.intra.peff.net>
 <20170810080325.tehbbgajm4cgn2ku@sigill.intra.peff.net>
 <CAGZ79kabhz-FWNyjB6KjF4qpGfSqONBNVBcVd=+J=5XT+emz-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kabhz-FWNyjB6KjF4qpGfSqONBNVBcVd=+J=5XT+emz-A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 10, 2017 at 11:35:00AM -0700, Stefan Beller wrote:

> On Thu, Aug 10, 2017 at 1:03 AM, Jeff King <peff@peff.net> wrote:
> > The point of "--only-trailers" is to give a caller an output
> > that's easy for them to parse. Getting rid of the
> > non-trailer material helps, but we still may see more
> > complicated syntax like whitespace continuation. Let's add
> > an option to normalize the output into one "key: value" line
> > per trailer.
> >
> > As a bonus, this could be used even without --only-trailers
> > to clean up unusual formatting in the incoming data.
> 
> This is useful for the parsing part, but for the writing part we'd
> rather want to have the opposite thing, such as
> '--line-break=rfc822'. But this doesn't have to be part of this
> series. With this in mind, I do not quite understand the latter
> use case how you would use normalized trailers without
> --only-trailers?

If you prefer the normalized form (and the input was line-broken in a
way that you don't like), then this would convert to your preferred
form. I agree that you could potentially want the opposite (folding long
lines). Perhaps something like --wrap=72.

-Peff
