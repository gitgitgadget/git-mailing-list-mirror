Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9989020899
	for <e@80x24.org>; Thu, 10 Aug 2017 07:32:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751511AbdHJHcn (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Aug 2017 03:32:43 -0400
Received: from cloud.peff.net ([104.130.231.41]:34148 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750868AbdHJHcm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2017 03:32:42 -0400
Received: (qmail 25683 invoked by uid 109); 10 Aug 2017 07:32:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 10 Aug 2017 07:32:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2224 invoked by uid 111); 10 Aug 2017 07:33:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 10 Aug 2017 03:33:05 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 10 Aug 2017 03:32:40 -0400
Date:   Thu, 10 Aug 2017 03:32:40 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH 3/5] interpret-trailers: add an option to show only
 existing trailers
Message-ID: <20170810073239.ny64rqmwb3yqbpb6@sigill.intra.peff.net>
References: <20170809122147.g44nwaitzctbadzm@sigill.intra.peff.net>
 <20170809122439.fscozhyvxcx2oq2n@sigill.intra.peff.net>
 <CAGZ79kYqq_EhRxckM4iV=99r59Y7_y94j+-65xXLUF4y2vNUUw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kYqq_EhRxckM4iV=99r59Y7_y94j+-65xXLUF4y2vNUUw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 09, 2017 at 11:18:19AM -0700, Stefan Beller wrote:

> On Wed, Aug 9, 2017 at 5:24 AM, Jeff King <peff@peff.net> wrote:
> > It can be useful to invoke interpret-trailers for the
> > primary purpose of parsing existing trailers. But in that
> > case, we don't want to apply existing ifMissing or ifExists
> > rules from the config. Let's add a special mode where we
> > avoid applying those rules. Coupled with --only-trailers,
> > this gives us a reasonable parsing tool.
> 
> I have the impression that the name is slightly misleading
> because 'only' just reduces the set. it does not enhance it.
> (Do we have a configuration that says "remove this trailer
> anytime"?)

No, I think you can only add trailers via ifExists or ifMissing.
I actually called this --no-config originally, because to me it meant
"do not apply config". But the processing applies also to --trailer
arguments no the command line, which is how I ended up with
--only-existing.

> So maybe this is rather worded as 'exact-trailers' ?

I'm not fond of that, as it's vague about which exact trailers we're
talking about. I also thought of something like --verbatim, but I'd
worry that would seem to conflict with --normalize.

I dunno. All of the names seem not quite descriptive enough to me.

-Peff
