Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 15E1C1F405
	for <e@80x24.org>; Thu,  9 Aug 2018 19:50:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbeHIWQs (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Aug 2018 18:16:48 -0400
Received: from cloud.peff.net ([104.130.231.41]:48974 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726931AbeHIWQs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Aug 2018 18:16:48 -0400
Received: (qmail 1574 invoked by uid 109); 9 Aug 2018 19:50:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 09 Aug 2018 19:50:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12985 invoked by uid 111); 9 Aug 2018 19:50:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 09 Aug 2018 15:50:30 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 09 Aug 2018 15:50:26 -0400
Date:   Thu, 9 Aug 2018 15:50:26 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Karel =?utf-8?B?S2/EjcOt?= <karel.koci@nic.cz>,
        Santiago Torres <santiago@nyu.edu>,
        Vojtech Myslivec <vojtech.myslivec@nic.cz>, git@vger.kernel.org
Subject: Re: [PATCH 1/1] verify-tag/verify-commit should exit unsuccessfully
 when signature is not trusted
Message-ID: <20180809195026.GD32376@sigill.intra.peff.net>
References: <20180803160634.GA19944@sigill.intra.peff.net>
 <20180804084346.fhte5wusbfb5baem@cynerd-laptop>
 <20180808230456.GA21882@sigill.intra.peff.net>
 <20180808231226.GA34639@genre.crustytoothpaste.net>
 <xmqqzhxwcq2o.fsf@gitster-ct.c.googlers.com>
 <20180809014302.GB34639@genre.crustytoothpaste.net>
 <20180809143010.GD1439@sigill.intra.peff.net>
 <xmqqtvo3d0by.fsf@gitster-ct.c.googlers.com>
 <20180809171219.GF1439@sigill.intra.peff.net>
 <xmqqy3dfbcys.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqy3dfbcys.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 09, 2018 at 11:40:27AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I guess leaving it serves as a sort of cross-check if gpg would return a
> > zero exit code but indicate in the status result that the signature was
> > not good. Sort of a belt-and-suspenders, I guess (which might not be
> > that implausible if we think about somebody wrapping gpg with a sloppy
> > bit of shell code that loses the exit code -- it's their fault, but it
> > might be nice for us to err on the conservative side).
> 
> OK, this time a real log message.
> 
> -- >8 --
> Subject: [PATCH] gpg-interface: propagate exit status from gpg back to the callers
> [...]

Thanks, the explanation and the patch look good to me.

I'm on the fence over whether a follow-up patch to take away the "U" is
worth it. In practice the code should never trigger either way, since
gpg would already have exited non-zero in such a case.

-Peff
