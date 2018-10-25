Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E8C261F453
	for <e@80x24.org>; Thu, 25 Oct 2018 01:09:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbeJYJjc (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Oct 2018 05:39:32 -0400
Received: from cloud.peff.net ([104.130.231.41]:53566 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726365AbeJYJjc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Oct 2018 05:39:32 -0400
Received: (qmail 8298 invoked by uid 109); 25 Oct 2018 01:09:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 25 Oct 2018 01:09:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12046 invoked by uid 111); 25 Oct 2018 01:08:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 24 Oct 2018 21:08:20 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 24 Oct 2018 21:09:05 -0400
Date:   Wed, 24 Oct 2018 21:09:05 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Vasco Almeida <vascomalmeida@sapo.pt>,
        Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [PATCH] i18n: make GETTEXT_POISON a runtime option
Message-ID: <20181025010905.GA4458@sigill.intra.peff.net>
References: <xmqqsh0xtwgb.fsf@gitster-ct.c.googlers.com>
 <20181023210154.32507-1-avarab@gmail.com>
 <xmqqefcfoq2a.fsf@gitster-ct.c.googlers.com>
 <20181024074400.GA31239@sigill.intra.peff.net>
 <xmqqefcen8ls.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqefcen8ls.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 25, 2018 at 10:00:31AM +0900, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > but then you lose the default handling. I think if we added a new
> > option, it would either be:
> >
> >   # interpret a value directly; use default on empty, I guess?
> >   git config --default=false --type=bool --interpret-value "$GIT_WHATEVER_ENV"
> >
> > or
> >
> >   # less flexible, but the --default semantics are more obvious
> >   git config --default=false --type=bool --get-env GIT_WHATEVER_ENV
> 
> Yeah, my thinko.  The latter would be closer to what this patch
> wants to have, but obviously the former would be more flexible and
> useful in wider context.  Both have the "Huh?" factor---what they
> are doing has little to do with "config", but I did not think of a
> better kitchen-sink (and our default kitchen-sink "rev-parse" is
> even further than "config", I would think, for this one).

Heh, I thought through the exact sequence in your paragraph when writing
my other message. That's probably a good sign that we should probably
not pursue this further unless we see the use case come up again a few
more times (and if we do, then consider "config" the least-bad place to
do it).

-Peff
