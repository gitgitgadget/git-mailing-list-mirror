Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9FDD32027C
	for <e@80x24.org>; Fri,  2 Jun 2017 22:30:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751157AbdFBWaH (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Jun 2017 18:30:07 -0400
Received: from cloud.peff.net ([104.130.231.41]:34154 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750971AbdFBWaG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2017 18:30:06 -0400
Received: (qmail 7587 invoked by uid 109); 2 Jun 2017 22:30:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 02 Jun 2017 22:30:06 +0000
Received: (qmail 32190 invoked by uid 111); 2 Jun 2017 22:30:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 02 Jun 2017 18:30:45 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 02 Jun 2017 18:30:04 -0400
Date:   Fri, 2 Jun 2017 18:30:04 -0400
From:   Jeff King <peff@peff.net>
To:     Ulrich Mueller <ulm@gentoo.org>
Cc:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: git-2.13.0: log --date=format:%z not working
Message-ID: <20170602223003.6etkdnnogb2jmoh3@sigill.intra.peff.net>
References: <22824.29946.305300.380299@a1i15.kph.uni-mainz.de>
 <CACBZZX6t0Q9AJ4cpnG298tf5Las-YpmvvJXgLNNYMszikLvtMQ@mail.gmail.com>
 <20170527214611.suohggo226tvmbgt@sigill.intra.peff.net>
 <0a56f99e-aaa4-17ea-245a-12897ba08dbb@web.de>
 <xmqq1sr3161p.fsf@gitster.mtv.corp.google.com>
 <20170602030825.hdpbaisn54d4fi4n@sigill.intra.peff.net>
 <72b001fc-80e7-42b9-bd9d-87621da7978a@web.de>
 <20170602183504.ii7arq2ssxgwgyxr@sigill.intra.peff.net>
 <22833.57584.108133.30274@a1i15.kph.uni-mainz.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <22833.57584.108133.30274@a1i15.kph.uni-mainz.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 03, 2017 at 12:04:32AM +0200, Ulrich Mueller wrote:

> Actually, the POSIX definition for %Z continues: "or by no bytes if no
> timezone information exists." So also returning an empty string would
> be compliant (but maybe not very helpful).
> [...]
> I agree that GMT+0200 could be misleading. But what about resolving %Z
> the same as %z in the case of the author's time zone, as was suggested
> earlier? It is supposed to be human-readable output, or do we expect
> that someone would use the %Z output and e.g. plug it back into their
> TZ?

Yeah, I think these are the only real contenders: an empty string, or
"+0200" (which _isn't_ confusing, because it doesn't have the
abbreviation in front of it, so it pretty clearly is an offset from
GMT).

I don't have a preference between the other two.

The remaining question is whether we want to care about preserving the
system %Z for the local-timezone case.

-Peff
