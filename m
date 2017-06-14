Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6408F20401
	for <e@80x24.org>; Wed, 14 Jun 2017 06:38:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752854AbdFNGiw (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Jun 2017 02:38:52 -0400
Received: from cloud.peff.net ([104.130.231.41]:39742 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750771AbdFNGiw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jun 2017 02:38:52 -0400
Received: (qmail 3152 invoked by uid 109); 14 Jun 2017 06:38:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 14 Jun 2017 06:38:51 +0000
Received: (qmail 8735 invoked by uid 111); 14 Jun 2017 06:38:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 14 Jun 2017 02:38:53 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 14 Jun 2017 02:38:49 -0400
Date:   Wed, 14 Jun 2017 02:38:49 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH 1/2] add: warn when adding an embedded repository
Message-ID: <20170614063849.kkdzxp54r25l2wk6@sigill.intra.peff.net>
References: <20170613091452.ew2rwx5r6axxo65p@sigill.intra.peff.net>
 <20170613092408.db22ygki6wg2t23d@sigill.intra.peff.net>
 <xmqqshj37qqo.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqshj37qqo.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 13, 2017 at 10:16:15AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I also waffled on whether we should ask the submodule code
> > whether it knows about a particular path. Technically:
> >
> >   git config submodule.foo.path foo
> >   git config submodule.foo.url git://...
> >   git add foo
> >
> > is legal, but would still warn with this patch. 
> 
> Did you mean "git config -f .gitmodules" for the first two?  If so,
> I think I agree that (1) it should be legal and (2) we should be
> able to add the check on top of this patch.
> 
> Or do you really mean the case in which these are in .git/config?

I did mean .git/config, but I think it was because I was mostly confused
about what was possible. In either case I think what we'd want is to ask
"could this be used as an active submodule". And leave it to the
submodule code to decide whatever mechanisms are legal.

-Peff
