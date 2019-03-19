Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A27220248
	for <e@80x24.org>; Tue, 19 Mar 2019 03:17:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727336AbfCSDR5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Mar 2019 23:17:57 -0400
Received: from cloud.peff.net ([104.130.231.41]:55950 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726579AbfCSDR4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Mar 2019 23:17:56 -0400
Received: (qmail 29311 invoked by uid 109); 19 Mar 2019 03:17:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 19 Mar 2019 03:17:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26169 invoked by uid 111); 19 Mar 2019 03:18:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 18 Mar 2019 23:18:17 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 18 Mar 2019 23:17:54 -0400
Date:   Mon, 18 Mar 2019 23:17:54 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Josh Steadmon <steadmon@google.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, git@jeffhostetler.com
Subject: Re: [PATCH 2/2] trace2: randomize/timestamp trace2 targets
Message-ID: <20190319031754.GD6173@sigill.intra.peff.net>
References: <cover.1552519463.git.steadmon@google.com>
 <17ec237ba7498251a3ff64eec259d6f61c8f5ccc.1552519463.git.steadmon@google.com>
 <87h8c6baif.fsf@evledraar.gmail.com>
 <20190315204327.GE47591@google.com>
 <20190315204919.GF47591@google.com>
 <xmqq1s357yfj.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqq1s357yfj.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 18, 2019 at 10:40:00AM +0900, Junio C Hamano wrote:

> After seeing that the possibilities got discussed on the list, and
> that nobody seems to be very much demanding customizability (I am
> taking Ævar's mention of strftime as a mere "if we were doing an
> optional timestamp, why not do so in an even more customizable way?"
> nice-to-have, not as a "we must allow hourly or daily log, adjusting
> for each host's needs" must-have), I actually am fine if we declare
> that we've chosen the hard-coded "if it is a directory, use the last
> portion of sid to create with O_EXCL (and if we fail, append a '.%d'
> counter to retry)" or something simple.  Which I think takes us
> closer to your earlier and unpublished draft, but this time we can
> say that we omitted customizability after making sure that there is
> not much interest---so I think it was worth it.
> 
> People who really want customizability can and are welcome to argue
> otherwise and then I may change my assessment of the level of
> interest in customizability, but the above is my current feeling.

I do not really care that much about this particular issue (and I
haven't even really use trace2 for anything yet). My main concern was
just painting ourselves into a corner, and making things explicit rather
than implicit helps with that (i.e., having the user give us a
placeholder that tells us what to do instead of selecting one of several
reasonable behaviors based on whether the path exists).

-Peff
