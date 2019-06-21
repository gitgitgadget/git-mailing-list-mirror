Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7FEDB1F461
	for <e@80x24.org>; Fri, 21 Jun 2019 20:51:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726018AbfFUUvw (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Jun 2019 16:51:52 -0400
Received: from cloud.peff.net ([104.130.231.41]:47278 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725985AbfFUUvw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jun 2019 16:51:52 -0400
Received: (qmail 18270 invoked by uid 109); 21 Jun 2019 20:51:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 21 Jun 2019 20:51:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26276 invoked by uid 111); 21 Jun 2019 20:52:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 21 Jun 2019 16:52:41 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 21 Jun 2019 16:51:50 -0400
Date:   Fri, 21 Jun 2019 16:51:50 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/8] Add 'ls-files --json' to dump the index in json
Message-ID: <20190621205150.GC25874@sigill.intra.peff.net>
References: <20190619095858.30124-1-pclouds@gmail.com>
 <20190619191709.GF28145@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1906211515160.44@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1906211515160.44@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 21, 2019 at 03:16:52PM +0200, Johannes Schindelin wrote:

> > I think your warning in the manpage that this is for debugging is fine,
> > as it does not put us on the hook for maintaining the feature nor its
> > format forever. We might want to call it "--debug=json" or something,
> > though, in case we do want real stable json support later (though of
> > course we would be free to steal the option then, since we're making no
> > promises).
> 
> Traditionally, we have not catered well to 3rd-party applications in Git,
> and this JSON format would provide a way out of that problem.
> 
> So I would like *not* to lock the door on letting this feature stabilize
> organically.

I'd like it to stabilize organically, too, but my thinking was that we'd
wait a while and then promote it to a stable name eventually.

> I'd be much more in favor of `--json[=<version>]`, with an initial version
> of 0 to indicate that it really is unstable for now.

That's OK with me, too, if you think "0" indicates that sufficiently
(we've used "v0" in a lot of other places to refer to stable protocols,
like the git:// one). Maybe it's OK with some documentation making it
clear.

I'm not sure whether we want to be locked into supporting this v0
forever or not (though maybe it would not be such a burden).

I think JSON-based output also has the potential to need fewer bumps.
It's syntactically stable, so it's really just about our schema. And
it's easy to say "newer versions of Git may produce new keys; you can
ignore them", as long as we do not change the meaning of existing keys.
That might be an easier promise to make.

-Peff
