Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CDC081F461
	for <e@80x24.org>; Tue, 14 May 2019 09:30:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726259AbfENJaZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 May 2019 05:30:25 -0400
Received: from cloud.peff.net ([104.130.231.41]:56586 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726075AbfENJaZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 May 2019 05:30:25 -0400
Received: (qmail 2910 invoked by uid 109); 14 May 2019 09:30:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 14 May 2019 09:30:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10962 invoked by uid 111); 14 May 2019 09:31:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 14 May 2019 05:31:03 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 14 May 2019 05:30:23 -0400
Date:   Tue, 14 May 2019 05:30:23 -0400
From:   Jeff King <peff@peff.net>
To:     Alyssa Ross <hi@alyssa.is>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] doc: explain why file: URLs and bundles don't mix
Message-ID: <20190514093023.GB11679@sigill.intra.peff.net>
References: <20190513002355.25031-1-hi@alyssa.is>
 <xmqqv9yebwzp.fsf@gitster-ct.c.googlers.com>
 <20190513165140.vq225fscfvemol7k@x220.qyliss.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190513165140.vq225fscfvemol7k@x220.qyliss.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 13, 2019 at 04:54:55PM +0000, Alyssa Ross wrote:

> > I think what is closer to the reaility is that we check if the
> > source is a bundle when the local filesystem path is used and try to
> > clone from the bundle, before using the local filesystem path as a
> > directory we can "clone --local" from.  On the other hand, when the
> > <scheme>://<path> syntax is used, we do not even bother seeing if
> > the named resource is a bundle, or if --local optimization is
> > possible (because we do not bother seeing if the named resource is a
> > local filesystem entity, either).
> 
> Would the following work better for you?
> 
> When cloning, the former will check to see if the source is a bundle.
> If it is, it will clone from the bundle, otherwise it will behave as if
> given --local. The latter performs neither of these checks, and
> therefore does not support bundles.

FWIW, I like that much better than the original proposal. I think it
would also be OK to say something like: ...does not support bundles (but
may in the future).

-Peff
