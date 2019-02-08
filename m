Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A15D1F453
	for <e@80x24.org>; Fri,  8 Feb 2019 02:51:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbfBHCvf (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Feb 2019 21:51:35 -0500
Received: from cloud.peff.net ([104.130.231.41]:36968 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726911AbfBHCvf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Feb 2019 21:51:35 -0500
Received: (qmail 18771 invoked by uid 109); 8 Feb 2019 02:51:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 08 Feb 2019 02:51:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21217 invoked by uid 111); 8 Feb 2019 02:51:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 07 Feb 2019 21:51:44 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 07 Feb 2019 21:51:33 -0500
Date:   Thu, 7 Feb 2019 21:51:33 -0500
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3] doc-diff: don't `cd_to_toplevel`
Message-ID: <20190208025133.GB11392@sigill.intra.peff.net>
References: <20190203230152.GA25608@sigill.intra.peff.net>
 <20190204205037.32143-1-martin.agren@gmail.com>
 <20190204233444.GC2366@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1902051050090.41@tvgsbejvaqbjf.bet>
 <20190206184903.GC10231@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1902071518340.41@tvgsbejvaqbjf.bet>
 <20190207204502.GA28893@sigill.intra.peff.net>
 <20190208005852.GT10587@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190208005852.GT10587@szeder.dev>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 08, 2019 at 01:58:52AM +0100, SZEDER Gábor wrote:

> On Thu, Feb 07, 2019 at 03:45:02PM -0500, Jeff King wrote:
> > Fair enough. As an alternative, do you know offhand if there's an easy
> > machine-readable way to get the CI results? If I could poll it with curl
> > and generate my own notifications, that would be fine for me.
> 
> Well, what do you mean by "CI results"?  Getting whether a build
> succeeded, failed, still running, etc.?  Sure.  Getting which
> particular test script (semantic patch, documentation...) caused the
> build failure?  Nope. [1]

Ideally yeah, I'd like to see the verbose (even "-x") log of the failed
test. But even an indication of a failure is enough that I know I can
start digging (and bonus if I can then dig into the log with a script
and parse it myself).

> Travis CI has a REST API (note that you have to sign in with GitHub
> account to view its docs, and then need an access token to use the
> API):

Thanks, I may poke around that.  In this particular case, though, I was
wondering about the Azure Pipelines builds that Dscho has put together.

> Depending on what you want that in itself might already be enough for
> you.  It wasn't for me, as I have a very particular idea about how I
> prefer to view my CI results, but neither the website nor the CLI
> client offer such a compact _and_ detailed view like this:
> 
>   ccccccccc 2175  pu
>   ccccccccc 2174  sg/ci-parallel-build
>   ccccccccc 2173  js/fuzz-commit-graph-update
>   ccccccccc 2172  js/mingw-host-cpu
>   PsscsPscc 2171  dl/submodule-set-branch
>   PPXsPPPPP 2170  kl/pretty-doc-markup-fix
>   PPPPPPPPP 2169  en/combined-all-paths

Mostly I just want to see the status of my own topics (ideally as soon
as they're available, but even polling to get them within a few hours
would be OK). I run the tests locally, of course, but sometimes problems
show up on other platforms.

-Peff
