Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E82CB207D6
	for <e@80x24.org>; Tue, 25 Apr 2017 06:07:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S980520AbdDYGHc (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Apr 2017 02:07:32 -0400
Received: from cloud.peff.net ([104.130.231.41]:39582 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S980495AbdDYGHb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2017 02:07:31 -0400
Received: (qmail 26693 invoked by uid 109); 25 Apr 2017 06:07:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 25 Apr 2017 06:07:31 +0000
Received: (qmail 19152 invoked by uid 111); 25 Apr 2017 06:07:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 25 Apr 2017 02:07:55 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 25 Apr 2017 02:07:28 -0400
Date:   Tue, 25 Apr 2017 02:07:28 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Sixt <j6t@kdbg.org>,
        David Turner <dturner@twosigma.com>, git@vger.kernel.org
Subject: Re: [PATCH] test-lib: abort when can't remove trash directory
Message-ID: <20170425060728.bprvsmiazho6ceyt@sigill.intra.peff.net>
References: <CAM0VKjm1m4v9vTpwFEejBuD3NuGm+kAdEV-_rzCXCz2G4m5NGw@mail.gmail.com>
 <20170420165230.5951-1-szeder.dev@gmail.com>
 <20170421201527.wdtxhox3p4g35gex@sigill.intra.peff.net>
 <xmqqk26a4q69.fsf@gitster.mtv.corp.google.com>
 <20170424014339.nuh7ixlqudfnftzp@sigill.intra.peff.net>
 <xmqqwpaa1pgb.fsf@gitster.mtv.corp.google.com>
 <xmqq60hu1mhq.fsf@gitster.mtv.corp.google.com>
 <20170424075241.ybbq2cpvbmwtdwz7@sigill.intra.peff.net>
 <xmqqmvb5uin8.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqmvb5uin8.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 24, 2017 at 11:05:15PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Good point. There's only one caller, but it does care about being in
> > that directory.
> >
> >> Second try that hopefully is much less damaging
> 
> I've been carrying it as a SQUASH??? patch, but I think it is better
> to split it as a separate pach, as removal of $remove_trash is an
> optional thing.  The main thing, i.e. SZEDER's "abort when trash is
> already gone or when we cannot remove" _can_ be (and is) correctly
> done with his pach alone.

Sort of. It still has the bug that it dies with error() when "--debug"
is used. But that is relatively minor, and as long as yours gets applied
on top I do not mind the momentary breakage.

> So here is what I queued on top.
> 
> -- >8 --
> Subject: [PATCH] test-lib: retire $remove_trash variable

Yeah, this looks fine (though it could mention that it is fixing the
"test -d" bug).

-Peff
