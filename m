Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D74420357
	for <e@80x24.org>; Mon, 10 Jul 2017 13:27:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754165AbdGJN1r (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Jul 2017 09:27:47 -0400
Received: from cloud.peff.net ([104.130.231.41]:35416 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753864AbdGJN1q (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jul 2017 09:27:46 -0400
Received: (qmail 17966 invoked by uid 109); 10 Jul 2017 13:27:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 10 Jul 2017 13:27:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5403 invoked by uid 111); 10 Jul 2017 13:27:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Mon, 10 Jul 2017 09:27:58 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 10 Jul 2017 09:27:44 -0400
Date:   Mon, 10 Jul 2017 09:27:44 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Kyle Meyer <kyle@kyleam.com>, git@vger.kernel.org,
        Sahil Dua <sahildua2305@gmail.com>, Eric Wong <e@80x24.org>
Subject: Re: [PATCH v2 3/7] log: do not free parents when walking reflog
Message-ID: <20170710132744.scjkpaqzunrx7gnf@sigill.intra.peff.net>
References: <20170707090507.ko2ygry7j4zv7t3s@sigill.intra.peff.net>
 <20170707090734.x2ki7lluawf66g4a@sigill.intra.peff.net>
 <xmqqwp7kb2ap.fsf@gitster.mtv.corp.google.com>
 <20170709101351.qcwgtzly72wwvwmq@sigill.intra.peff.net>
 <xmqqtw2l8s22.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqtw2l8s22.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jul 09, 2017 at 09:59:33AM -0700, Junio C Hamano wrote:

> >> After step 6/7, we no longer "allow cycles in reflog ancestry", as
> >> there will be no reflog ancestry to speak of ;-), so it would be
> >> nice to remove the comment above in that step.  But alternatively,
> >> we can rephrase the comment here, to say something like "the same
> >> commit can be shown multiple times while showing entries from the
> >> reflog" instead.
> >
> > I actually think the comment is a bit obtuse in the first place. The
> > real issue is that we show commits multiple times. That's caused by
> > cycles, yes, but also by us clearing the SEEN flag. ;)
> >
> > Maybe this on top?
> 
> Yup, that is a much better version of what I had in mind that can go
> either before this step as a preparatory cleanup, squashed into this
> as "while at it", or after the series as a finishing touches.  The
> last one will let the codebase lie for a short while, though, so I am
> likely to squash it in or wiggle it under.

Where you put it on jk/reflog-walk in your tree is fine, though note the
commit message is slightly inaccurate there (it says "commit buffer and
parents" but at that point it is really just "commit buffer").

-Peff
