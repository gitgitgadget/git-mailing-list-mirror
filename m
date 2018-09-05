Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7252E1F404
	for <e@80x24.org>; Wed,  5 Sep 2018 16:56:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727364AbeIEV1a (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Sep 2018 17:27:30 -0400
Received: from cloud.peff.net ([104.130.231.41]:40112 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726335AbeIEV1a (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Sep 2018 17:27:30 -0400
Received: (qmail 17641 invoked by uid 109); 5 Sep 2018 16:56:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 05 Sep 2018 16:56:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20529 invoked by uid 111); 5 Sep 2018 16:56:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 05 Sep 2018 12:56:39 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 05 Sep 2018 12:56:26 -0400
Date:   Wed, 5 Sep 2018 12:56:26 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Van Oostenryck Luc <luc.vanoostenryck@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Kevin Willford <kewillf@microsoft.com>
Subject: Re: [PATCH] reopen_tempfile(): truncate opened file
Message-ID: <20180905165625.GA31930@sigill.intra.peff.net>
References: <20180902072408.GA18787@sigill.intra.peff.net>
 <xmqq36upcl1s.fsf@gitster-ct.c.googlers.com>
 <CACsJy8AuWKxAdETaqYmcSY2VeLeWFyjnSYrK4GJeyG5ecv3OcA@mail.gmail.com>
 <20180904163807.GA23572@sigill.intra.peff.net>
 <20180904233643.GA9156@sigill.intra.peff.net>
 <CACsJy8Ax4S9Sms6TY1dMV8M9-=hakEW8TCqn8yxb73Vbrpy_MQ@mail.gmail.com>
 <20180905153551.GB24660@sigill.intra.peff.net>
 <CACsJy8BGxqzjXUprnhSU7jQDjzgDnY4x+SMsnOVb4Uho4dJt0g@mail.gmail.com>
 <20180905154827.GC24660@sigill.intra.peff.net>
 <xmqqva7j51gt.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqva7j51gt.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 05, 2018 at 09:54:42AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> >> > So AFAIK this fsck catches everything and yields a non-zero exit in the
> >> > error case. And it should work for even a single byte of rubbish.
> >> 
> >> Yes you're right. I forgot about the trailing hash.
> >
> > Thanks, I was worried that I was missing something. ;)
> >
> > Maybe it is worth making that final comment:
> >
> >   # and that the trailing hash in the index was not corrupted,
> >   # which should catch even a single byte of cruft
> >   git fsck
> 
> Perhaps.  I do not mind seeing an additional comment to explain why
> this requires PERL (it wasn't immediately obvious as I never use
> 'commit -p' myself), either.

I thought the PERL prereq in the existing "-p" test of the commit header
would explain it. ;)

Do you prefer an in-code comment, or one in the commit message?

-Peff
