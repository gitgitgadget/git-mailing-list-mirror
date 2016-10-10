Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E76AA20989
	for <e@80x24.org>; Mon, 10 Oct 2016 20:54:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751008AbcJJUy1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Oct 2016 16:54:27 -0400
Received: from cloud.peff.net ([104.130.231.41]:55344 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751721AbcJJUy1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2016 16:54:27 -0400
Received: (qmail 16507 invoked by uid 109); 10 Oct 2016 20:54:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 10 Oct 2016 20:54:27 +0000
Received: (qmail 1938 invoked by uid 111); 10 Oct 2016 20:54:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 10 Oct 2016 16:54:45 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 10 Oct 2016 16:54:25 -0400
Date:   Mon, 10 Oct 2016 16:54:25 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Tom Hale <tom@hale.ee>, git <git@vger.kernel.org>
Subject: Re: [PATCH] pretty: respect color settings for %C placeholders
Message-ID: <20161010205424.p25nlrtwhhwu33ye@sigill.intra.peff.net>
References: <cb81631e-9623-9020-f955-ec215b493a50@hale.ee>
 <f35965e9-2901-b9b5-92e5-9bc7fe673637@web.de>
 <65d8def3-df62-6c45-7d8f-79b6a8769bf5@hale.ee>
 <25c17e16-2456-7da3-ae22-2dc812a3aa0d@web.de>
 <20161009234617.y6xfjyv6xjkf2afi@sigill.intra.peff.net>
 <CACsJy8CroyynVMctbPhuVr2VVQB7YyfcxDaMT25BikQ4R4We0Q@mail.gmail.com>
 <20161010142818.lglwrxpks6l6aqrm@sigill.intra.peff.net>
 <20161010151517.6wszhuyp57yfncaj@sigill.intra.peff.net>
 <xmqq1szof34x.fsf@gitster.mtv.corp.google.com>
 <20161010185935.r3wnfglpi7hjjpdk@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161010185935.r3wnfglpi7hjjpdk@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 10, 2016 at 02:59:35PM -0400, Jeff King wrote:

> > I must be reading the patch incorrectly, but I cannot quite tell
> > where I want astray...
> 
> No, we don't come here from %C() at all. This is for bare "%Cred", which
> cannot have "always" (or "auto"), as there is no syntactic spot for it.
> It is mostly historical (it _only_ supports red, green, and blue). We
> could actually leave this as-is to show the colors unconditionally. I
> changed it to keep the new behavior consistent, but I doubt anybody
> cares much either way.

Speaking of consistent behavior, if we do this, I think we should give
"%(color:red)" in for-each-ref and tag the same treatment. That requires
some infrastructure refactoring to get the value down to the
ref-formatting code. I'm working on it, but might not have it out today.

-Peff
