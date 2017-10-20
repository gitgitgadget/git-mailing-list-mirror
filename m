Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2066D202DD
	for <e@80x24.org>; Fri, 20 Oct 2017 03:05:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751292AbdJTDFd (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Oct 2017 23:05:33 -0400
Received: from cloud.peff.net ([104.130.231.41]:58630 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751217AbdJTDFc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Oct 2017 23:05:32 -0400
Received: (qmail 17418 invoked by uid 109); 20 Oct 2017 03:05:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 20 Oct 2017 03:05:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14376 invoked by uid 111); 20 Oct 2017 03:05:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 19 Oct 2017 23:05:31 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 19 Oct 2017 23:05:25 -0400
Date:   Thu, 19 Oct 2017 23:05:25 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Git Mailing List <git@vger.kernel.org>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Thomas Rikl <trikl@online.de>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [Alt. PATCH] ls-remote: deprecate -h as short for --heads
Message-ID: <20171020030524.4xlwrdag7e4gzg7s@sigill.intra.peff.net>
References: <63fe2a84-d991-9165-32c0-8087d8513ce6@online.de>
 <CAN0heSpPWWdWY4d1wCdRH8TjcmD3kAiSffL0-_9kJWkm5P2EkA@mail.gmail.com>
 <4d110305-0826-6fd1-91a5-c1ebd0b1e80b@web.de>
 <774f08bd-3172-0083-1544-e5f68f6798fa@web.de>
 <xmqqk1ztmkbn.fsf@gitster.mtv.corp.google.com>
 <26112a15-f02c-a910-c8bb-794ca84dc1e5@web.de>
 <20171019203249.76uu3b6ferquitcr@sigill.intra.peff.net>
 <xmqqlgk6iq94.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqlgk6iq94.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 20, 2017 at 10:04:23AM +0900, Junio C Hamano wrote:

> > Yuck. This "we only treat -h as special in certain cases" rule is
> > sufficiently magical that I don't think we want to advertise and lock
> > ourselves into it.
> 
> Hmph.  I think it is way too late to be worried about "locked into"
> the convention---hasn't the "git cmd -h" been with us forever?

I guess. I still find it pretty nasty (not that "-h" works for help, but
that it can override the normal usage).

> Besides, I personally feel that there is nothing magical in the rule
> that is "we always treat 'git $cmd -h' as asking for short help, but
> individual subcommand may choose to use -h for, perhaps to be
> compatible with other tools and conventions, in other situations".

<shrug> It seems weird and inconsistent to me that the meaning of "-h"
depends on the position and presence of other unrelated options. Maybe
it's just me. I know _why_ it's that way, but this seems like one of
those weird corners of the interface that end up confusing people and
giving Git's interface the reputation of being full of mysterious
inconsistencies. I suspect one of the reasons nobody has complained
about it is that "ls-remote" is not commonly used, and "ls-remote -h"
less so (I didn't even know it was there until this conversation).

-Peff
