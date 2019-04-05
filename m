Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E1D5420248
	for <e@80x24.org>; Fri,  5 Apr 2019 20:53:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726468AbfDEUxr (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Apr 2019 16:53:47 -0400
Received: from cloud.peff.net ([104.130.231.41]:49090 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725973AbfDEUxr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Apr 2019 16:53:47 -0400
Received: (qmail 16716 invoked by uid 109); 5 Apr 2019 20:53:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 05 Apr 2019 20:53:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29877 invoked by uid 111); 5 Apr 2019 20:54:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 05 Apr 2019 16:54:14 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 05 Apr 2019 16:53:45 -0400
Date:   Fri, 5 Apr 2019 16:53:45 -0400
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/7] t: introduce tests for unexpected object types
Message-ID: <20190405205345.GB8166@sigill.intra.peff.net>
References: <cover.1554435033.git.me@ttaylorr.com>
 <ef6b4f380435d9743a56f47f68c18123bf0a0933.1554435033.git.me@ttaylorr.com>
 <20190405105033.GT32732@szeder.dev>
 <20190405182412.GC2284@sigill.intra.peff.net>
 <CAPig+cQ7f6C-YBE5LT3qiXSyjpqQQEknmE8eHdQJvzCAzkBNPA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPig+cQ7f6C-YBE5LT3qiXSyjpqQQEknmE8eHdQJvzCAzkBNPA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 05, 2019 at 03:25:43PM -0400, Eric Sunshine wrote:

> On Fri, Apr 5, 2019 at 2:24 PM Jeff King <peff@peff.net> wrote:
> > On Fri, Apr 05, 2019 at 12:50:33PM +0200, SZEDER Gábor wrote:
> > > > +   git cat-file commit $commit |
> > > > +           perl -lpe "/^author/ && print q(parent $blob)" \
> > > > +           >broken-commit &&
> >
> > > Wouldn't a 'sed' one-liner suffice, so we won't have yet another perl
> > > dependency?
> >
> > Heh, this was actually the subject of much discussion before the patches
> > hit the list. If you can write such a one-liner that is both readable
> > and portable, please share it. I got disgusted with sed and suggested
> > this perl.
> 
> Trivial and portable 'sed' equivalent:
> 
> git cat-file commit $commit | sed "/^author/ { h; s/.*/parent $blob/; G; }"

I always forget about the hold space. That's pretty readable (though
being sed, it's terse enough that I actually think the perl is more
readable; that may be personal taste, though).

-Peff
