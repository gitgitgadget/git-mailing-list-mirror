Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 04815201A8
	for <e@80x24.org>; Sat, 18 Feb 2017 06:33:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750825AbdBRGds (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Feb 2017 01:33:48 -0500
Received: from cloud.peff.net ([104.130.231.41]:57965 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750805AbdBRGdr (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Feb 2017 01:33:47 -0500
Received: (qmail 26930 invoked by uid 109); 18 Feb 2017 06:33:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 18 Feb 2017 06:33:46 +0000
Received: (qmail 12483 invoked by uid 111); 18 Feb 2017 06:33:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 18 Feb 2017 01:33:49 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 18 Feb 2017 01:33:45 -0500
Date:   Sat, 18 Feb 2017 01:33:45 -0500
From:   Jeff King <peff@peff.net>
To:     hIpPy <hippy2981@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: git alias for options
Message-ID: <20170218063345.3owwc2pwptdv2zu6@sigill.intra.peff.net>
References: <CAM_JFCz+9mxp37BTT7XPJ0fMd41DdbAxnvQF7id9msH+SDe6_Q@mail.gmail.com>
 <CACBZZX4Zmwb8ZHGBXCpm6=yH_uxc-K1X1vv1jQ+wwnUPneqM4A@mail.gmail.com>
 <20170217204227.kreormjoo5lr6zu4@sigill.intra.peff.net>
 <CACBZZX7nJkRmSxTdvhgXz5Zuk0KeovSZM1D_eGqbBn7i20+ePQ@mail.gmail.com>
 <20170217221317.e5kby2jwutdznnlk@sigill.intra.peff.net>
 <xmqq4lzsqwjy.fsf@gitster.mtv.corp.google.com>
 <CAM_JFCzoouREM5-6aq9wb0ouT34GKCoJ_pcsww5TYKAdztR9sA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAM_JFCzoouREM5-6aq9wb0ouT34GKCoJ_pcsww5TYKAdztR9sA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 17, 2017 at 02:34:15PM -0800, hIpPy wrote:

> I think the conversation has drifted away from what I am asking / hoping for.

Yeah, the usual answer to "can we have custom options" is "use a custom
alias". But I agree they are not quite the same thing.

> Say I want an alias for option --name-status as -s, so I can type:
> $ git log -s
> 
> But there is already a -s option and that wins so the built-in option
> alias wins.
> 
> However, I think I should be able alias it as --ns.
> $ git log --ns

To be honest, I am not that enthused about the idea, but I don't have an
real objection beyond "meh, that looks like an unnecessary
complication".

If anybody wants to pursue it, the simplest way would probably be to
teach parse-options to take a callback for an unknown option, which
could then do a config lookup to transmute the argument into another
option-name.

Though many of the options (notably the revision-walker and diff ones)
are not handled by parse-options. So that might present a challenge.

-Peff
