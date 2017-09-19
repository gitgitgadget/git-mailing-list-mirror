Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F27F20281
	for <e@80x24.org>; Tue, 19 Sep 2017 04:57:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751000AbdISE5K (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Sep 2017 00:57:10 -0400
Received: from cloud.peff.net ([104.130.231.41]:42934 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750758AbdISE5J (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Sep 2017 00:57:09 -0400
Received: (qmail 2389 invoked by uid 109); 19 Sep 2017 04:57:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 19 Sep 2017 04:57:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31897 invoked by uid 111); 19 Sep 2017 04:57:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Tue, 19 Sep 2017 00:57:45 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 19 Sep 2017 00:57:07 -0400
Date:   Tue, 19 Sep 2017 00:57:07 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 0/2] fix read past end of array in alternates files
Message-ID: <20170919045706.evw2l37hd4r2czra@sigill.intra.peff.net>
References: <20170918155059.54f7z6cnrl47f5el@sigill.intra.peff.net>
 <20170919023603.GB175206@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170919023603.GB175206@aiede.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 18, 2017 at 07:36:03PM -0700, Jonathan Nieder wrote:

> Jeff King wrote:
> 
> > This series fixes a regression in v2.11.1 where we might read past the
> > end of an mmap'd buffer. It was introduced in cf3c635210,
> 
> The above information is super helpful.  Can it go in one of the commit
> messages?

Er, didn't I?

> > base the patch on there, for a few reasons:
> >
> >   1. There's a trivial conflict when merging up (because of
> >      git_open_noatime() becoming just git_open() in the inerim).
> >
> >   2. The reproduction advice relies on our SANITIZE Makefile knob, which
> >      didn't exist back then.
> >
> >   3. The second patch does not apply there because we don't have
> >      warn_on_fopen_errors(). Though admittedly it could be applied
> >      separately after merging up; it's just a clean-up on top.
> 
> Even this part could go in a commit message, but it's fine for it not
> to.

IMHO this kind of meta information doesn't belong in the commit message.
It's useful to the maintainer to know where to apply the patch, but I
don't think it helps somebody who is reading "git log" output.

-Peff
