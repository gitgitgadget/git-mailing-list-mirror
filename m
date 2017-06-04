Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D8021F7D2
	for <e@80x24.org>; Sun,  4 Jun 2017 08:23:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751266AbdFDIXc (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Jun 2017 04:23:32 -0400
Received: from cloud.peff.net ([104.130.231.41]:34515 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751171AbdFDIXb (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Jun 2017 04:23:31 -0400
Received: (qmail 15149 invoked by uid 109); 4 Jun 2017 08:23:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 04 Jun 2017 08:23:30 +0000
Received: (qmail 7753 invoked by uid 111); 4 Jun 2017 08:24:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 04 Jun 2017 04:24:10 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 04 Jun 2017 04:23:29 -0400
Date:   Sun, 4 Jun 2017 04:23:29 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] perf: work around the tested repo having an index.lock
Message-ID: <20170604082328.wdjb5yvx24w7biwk@sigill.intra.peff.net>
References: <20170602103330.25663-1-avarab@gmail.com>
 <20170602184506.x2inwswmcwafyvfy@sigill.intra.peff.net>
 <xmqqd1amx80f.fsf@gitster.mtv.corp.google.com>
 <CACBZZX52O9Pf=5Xtq1Lg1=ZU26tm7pupvubk1ZjNJZp7kR450g@mail.gmail.com>
 <xmqqefv0wrj7.fsf@gitster.mtv.corp.google.com>
 <CAP8UFD1u-C-T2X+H8WxxB7O+ajcGfygRBLN0t7+zJcOh_SrvFQ@mail.gmail.com>
 <CACBZZX4eCJJS6iaod+tWFF5M998Y5x88SdYR2ZekAJeeOiU8ug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACBZZX4eCJJS6iaod+tWFF5M998Y5x88SdYR2ZekAJeeOiU8ug@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 04, 2017 at 09:55:15AM +0200, Ævar Arnfjörð Bjarmason wrote:

> > Is a local clone really much slower these days? Wouldn't it is use
> > hard links too?
> > By the way the many properties that are preserved might not be worth
> > preserving as they could make results depend a lot on the current
> > state of the original repo.
> 
> AFAICT from some quick testing it'll hardlink the objects/ dir, so
> e.g. you preserve the loose objects. Making the results depend on the
> state of the original repo is a feature, but perhaps it should be opt
> in. It's very useful to be able to take a repo that's accrued e.g. a
> month's worth of refs & loose objects and test that v.s. a fresh
> clone.
> 
> But there are other things that ever a hardlink local clone doesn't
> preserve which might be worth preserving...

Yes. Reflogs are one example. They aren't copied at all as part of a
clone, but they impact pruning and repacking.

-Peff
