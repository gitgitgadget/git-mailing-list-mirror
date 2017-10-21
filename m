Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C20B6202DD
	for <e@80x24.org>; Sat, 21 Oct 2017 07:16:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751442AbdJUHQV (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Oct 2017 03:16:21 -0400
Received: from cloud.peff.net ([104.130.231.41]:59822 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751277AbdJUHQV (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Oct 2017 03:16:21 -0400
Received: (qmail 12019 invoked by uid 109); 21 Oct 2017 07:16:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 21 Oct 2017 07:16:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22992 invoked by uid 111); 21 Oct 2017 07:16:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Sat, 21 Oct 2017 03:16:21 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 21 Oct 2017 03:16:14 -0400
Date:   Sat, 21 Oct 2017 03:16:14 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Git Mailing List <git@vger.kernel.org>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Thomas Rikl <trikl@online.de>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [Alt. PATCH] ls-remote: deprecate -h as short for --heads
Message-ID: <20171021071613.yynmigxiixnqggik@sigill.intra.peff.net>
References: <63fe2a84-d991-9165-32c0-8087d8513ce6@online.de>
 <CAN0heSpPWWdWY4d1wCdRH8TjcmD3kAiSffL0-_9kJWkm5P2EkA@mail.gmail.com>
 <4d110305-0826-6fd1-91a5-c1ebd0b1e80b@web.de>
 <774f08bd-3172-0083-1544-e5f68f6798fa@web.de>
 <xmqqk1ztmkbn.fsf@gitster.mtv.corp.google.com>
 <26112a15-f02c-a910-c8bb-794ca84dc1e5@web.de>
 <20171019203249.76uu3b6ferquitcr@sigill.intra.peff.net>
 <xmqqlgk6iq94.fsf@gitster.mtv.corp.google.com>
 <20171020030524.4xlwrdag7e4gzg7s@sigill.intra.peff.net>
 <xmqq7evqidp3.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq7evqidp3.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 20, 2017 at 02:35:36PM +0900, Junio C Hamano wrote:

> I may be biased as every time I think about this one, the first one
> that comes to my mind is how "grep -h" (not "git grep", but GNU
> grep) behaves.  Yes, "-h" means something else, but by itself, the
> command does not make sense, and "ls-remote -h" is an exception to
> the rule: most sane commands do not have a sensible semantics when
> they take only "-h" and nothing else.  And even for ls-remote it is
> true only when you try to be extra lazy and do not say which remote
> you are asking.

Yeah, I have to admit "grep -h" is a lot more compelling, since it
matches normal grep. And I've used "grep -h" many times without thinking
about it, simply because the rule just falls out naturally there
(there's nothing possible to do without a regex argument, so we'd show
the usage either way).

> And that is why I think "'cmd -h" and nothing else consistently
> gives help" may overall be positive in usability, than a rule that
> says "'cmd -h' is for short-help unless -h means something else for
> the command".

Yeah, I was shooting more for "let's avoid assigning -h to things". But
that's not really possible if we want to be consistent with upstream
grep, which is probably more important.

I think you've convinced me.

-Peff
