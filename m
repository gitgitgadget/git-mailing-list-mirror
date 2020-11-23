Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3959BC63798
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 21:48:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D99CF20715
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 21:48:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731960AbgKWVsg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Nov 2020 16:48:36 -0500
Received: from cloud.peff.net ([104.130.231.41]:39094 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729381AbgKWVsg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Nov 2020 16:48:36 -0500
Received: (qmail 29028 invoked by uid 109); 23 Nov 2020 21:48:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 23 Nov 2020 21:48:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7846 invoked by uid 111); 23 Nov 2020 21:48:35 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 23 Nov 2020 16:48:35 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 23 Nov 2020 16:48:34 -0500
From:   Jeff King <peff@peff.net>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Alex Henrie <alexhenrie24@gmail.com>,
        =?utf-8?Q?V=C3=ADt?= Ondruch <vondruch@redhat.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: Pick the right default and stop warn on `git pull`
Message-ID: <X7wuMvHRURK1QS/Q@coredump.intra.peff.net>
References: <742df4c2-2bc5-8a4b-8de1-cd5e48718398@redhat.com>
 <CAMMLpeRLsE=zNDjCRKmEMFxJBYcnTOdDGxEL9cZuVhuDMF=sLg@mail.gmail.com>
 <20201123191355.GA132317@mit.edu>
 <CAMP44s3cKVxKa0gOPfi3XRKbGbV=DweFE5pL0HM+v0kECFyPWA@mail.gmail.com>
 <20201123202003.GB132317@mit.edu>
 <CAMP44s27oEjScrJjeDVoNcWcvRsn173L_Kx+TOPfchOwge9zUQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMP44s27oEjScrJjeDVoNcWcvRsn173L_Kx+TOPfchOwge9zUQ@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 23, 2020 at 02:34:18PM -0600, Felipe Contreras wrote:

> > > Which is why I suggested to make fast-forward-only the default:
> > >
> > > https://lore.kernel.org/git/1398988808-29678-1-git-send-email-felipe.contreras@gmail.com/
> > >
> > > In what case would that default not be what most people want?
> >
> > Well, it *was* the default, previously, IIRC.
> 
> There has never been a "pull.mode=ff-only" option; that's what I tried
> to introduce.

There is pull.ff=only these days, which also squelches the message. But
you're right that it was never the default.

The default has continued to be merging. If we were going to switch that
to bailing out and doing nothing with a warning, I agree that doing so
only in the non-fast-forward case would be much better (because in that
case, all three modes have the same result).

I don't recall whether there is any active plan to move away from the
merge default, though.

-Peff
