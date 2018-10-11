Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC9611F97E
	for <e@80x24.org>; Thu, 11 Oct 2018 20:53:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbeJLEWX (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Oct 2018 00:22:23 -0400
Received: from cloud.peff.net ([104.130.231.41]:37790 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725819AbeJLEWX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Oct 2018 00:22:23 -0400
Received: (qmail 4715 invoked by uid 109); 11 Oct 2018 20:53:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 11 Oct 2018 20:53:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2090 invoked by uid 111); 11 Oct 2018 20:52:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 11 Oct 2018 16:52:34 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 11 Oct 2018 16:53:23 -0400
Date:   Thu, 11 Oct 2018 16:53:23 -0400
From:   Jeff King <peff@peff.net>
To:     Rafael =?utf-8?B?QXNjZW5zw6Nv?= <rafa.almas@gmail.com>
Cc:     Daniels Umanovskis <daniels@umanovskis.se>, git@vger.kernel.org
Subject: Re: [PATCH v2 1/1] branch: introduce --show-current display option
Message-ID: <20181011205323.GB11618@sigill.intra.peff.net>
References: <20181010205432.11990-1-daniels@umanovskis.se>
 <20181010205432.11990-2-daniels@umanovskis.se>
 <20181011003440.GD13853@sigill.intra.peff.net>
 <20181011154319.GA6386@rigel>
 <1409ebd2-d72c-fbd6-bf5c-777342723ca2@umanovskis.se>
 <20181011175136.GA8825@sigill.intra.peff.net>
 <20181011203518.GA2385@rigel>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181011203518.GA2385@rigel>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 11, 2018 at 09:35:28PM +0100, Rafael Ascensão wrote:

> On Thu, Oct 11, 2018 at 01:51:36PM -0400, Jeff King wrote:
> > Yeah, I agree.
> 
> Not sure which parts you meant, so I'll assume you didn't agree
> with me.

Correct. ;)

I like your general idea, but I agree with Daniel that it introduces an
inconsistency in the interface.

> I doesn't seem far fetched to ask for an overview of my current branch,
> feature1, feature2 and all hotfixes with something like:
> 
>   $ git branch --verbose --list HEAD feature1 feature2 hotfix-*;
> 
> The 'what's my current branch' could be just a particular case of this
> form.

Right, I like that part. It's just that putting "HEAD" there already has
a meaning: it would find refs/heads/HEAD.

Now I'll grant that's a bad name for a branch (and the source of other
confusions, and I think perhaps even something a few commands actively
discourage these days).

> My defense to treat HEAD specially comes in the form that from the user
> perspective, HEAD is already being resolved to a commit when HEAD is
> detached (Showing the detached at <hash> message.)
> 
> Is there a strong reason to *not* "resolve" HEAD when it is attached?
> Would it be that bad to have some DWIM behaviour here? After all, as
> HEAD is an invalid name for a branch, nothing would ever match it
> anyways.

I don't think this is about resolving HEAD, or showing it. It's about
the fact that arguments to "branch" are currently always branch-names,
not full refs.

-Peff
