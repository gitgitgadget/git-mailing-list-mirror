Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3CB941FC44
	for <e@80x24.org>; Thu, 16 Feb 2017 17:03:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932338AbdBPRDa (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Feb 2017 12:03:30 -0500
Received: from cloud.peff.net ([104.130.231.41]:56493 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754704AbdBPRD3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Feb 2017 12:03:29 -0500
Received: (qmail 6567 invoked by uid 109); 16 Feb 2017 17:03:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 16 Feb 2017 17:03:29 +0000
Received: (qmail 24810 invoked by uid 111); 16 Feb 2017 17:03:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 16 Feb 2017 12:03:30 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 16 Feb 2017 12:03:27 -0500
Date:   Thu, 16 Feb 2017 12:03:27 -0500
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Maxim Moseychuk <franchesko.salias.hudro.pedros@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/3] add git_psprintf helper function
Message-ID: <20170216170326.sphzwycj3vlgpymm@sigill.intra.peff.net>
References: <20170216112829.18079-1-franchesko.salias.hudro.pedros@gmail.com>
 <20170216112829.18079-2-franchesko.salias.hudro.pedros@gmail.com>
 <616a2b08-71f9-d594-d46c-2687bf20ae2b@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <616a2b08-71f9-d594-d46c-2687bf20ae2b@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 16, 2017 at 07:51:14AM -0800, Jonathan Tan wrote:

> On 02/16/2017 03:28 AM, Maxim Moseychuk wrote:
> > There are a number of places in the code where we call
> > xsnprintf(), with the assumption that the output will fit into
> > the buffer. If the buffer is small, then git die.
> > In many places buffers have compile-time size, but generated string
> > depends from current system locale (gettext)and can have size
> > greater the buffer.
> > Just run "LANG=ru_RU.UTF8 git bisect start v4.9 v4.8"
> > on linux sources - it impossible.
> > 
> > git_psprintf is similar to the standard C sprintf() function
> > but safer, since it calculates the maximum space required
> > and allocates memory to hold the result.
> > The returned string should be freed with free() when no longer needed.
> 
> If I understand this correctly, xstrfmt (in strbuf.h) should already do what
> you need, so you do not need a new function.

Yes, this is exactly what xstrfmt is for.

-Peff
