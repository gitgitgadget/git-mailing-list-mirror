Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EBE7F1FAFB
	for <e@80x24.org>; Wed,  5 Apr 2017 09:30:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932291AbdDEJa4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Apr 2017 05:30:56 -0400
Received: from cloud.peff.net ([104.130.231.41]:56879 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754573AbdDEJ3f (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Apr 2017 05:29:35 -0400
Received: (qmail 9665 invoked by uid 109); 5 Apr 2017 09:29:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 05 Apr 2017 09:29:33 +0000
Received: (qmail 14649 invoked by uid 111); 5 Apr 2017 09:29:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 05 Apr 2017 05:29:52 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 05 Apr 2017 05:29:31 -0400
Date:   Wed, 5 Apr 2017 05:29:31 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Stefan Beller <sbeller@google.com>,
        Brandon Williams <bmwill@google.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>, frank@gevaerts.be
Subject: Re: [RFC] dropping support for ancient versions of curl
Message-ID: <20170405092931.3n7m5lawxiyy4qae@sigill.intra.peff.net>
References: <20170404025438.bgxz5sfmrawqswcj@sigill.intra.peff.net>
 <CACBZZX78oKU5HuBEqb9qLy7--wcwhC_mW6x7Q+tB4suxohSCsQ@mail.gmail.com>
 <20170404083341.uajswm3qdzyvzxsp@sigill.intra.peff.net>
 <CACBZZX5D2cYf0-ob_Da0EsxRtZHfegezPtCGA10-sjfi0A+AoQ@mail.gmail.com>
 <alpine.DEB.2.20.1704041351350.4268@virtualbox>
 <CACBZZX6W+fbCg7xXKuM=iqnSYFENBYxYT1WJmoOvYYCBEkX=hQ@mail.gmail.com>
 <20170404165321.GC189807@google.com>
 <alpine.DEB.2.20.1704050043370.4268@virtualbox>
 <CAGZ79kb5VeKCzzafw+nEcRda2apuit-K=qZxxZ3Li96MiMdOXA@mail.gmail.com>
 <alpine.DEB.2.20.1704051031200.4268@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1704051031200.4268@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 05, 2017 at 10:49:47AM +0200, Johannes Schindelin wrote:

> Let's reiterate that we are talking about some #ifdef's here that are a
> tiny maintenance burden. That may have a bug here and there, easily fixed.

Forget the maintenance cost for a moment. My concern is that we are
doing users a disservice by shipping broken and untested code without
them (or us) realizing it. The compile failure is the _best_ case,
because they know there's a bug to be fixed. A build that quietly fails
to enforce security properties is actively dangerous, and the user would
potentially be better off with an #error.

> Also, maybe, just maybe, there are more pressing issues than removing a
> couple lines here and there? This discussion vaguely reminds me of the
> opening statement of https://en.wikipedia.org/wiki/Law_of_triviality...
> Just saying'...

It's not just removing a couple of lines. It's remembering to check and
#ifdef new lines that get added, too (this conversation started because
of review on another patch which failed to do so). Is our attitude "add
it and when somebody with an ancient curl complains and provides a
patch, we'll #ifdef it"?

-Peff
