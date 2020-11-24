Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE9ADC2D0E4
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 00:40:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1F7120729
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 00:40:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730805AbgKXAjk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Nov 2020 19:39:40 -0500
Received: from cloud.peff.net ([104.130.231.41]:39410 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730800AbgKXAjk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Nov 2020 19:39:40 -0500
Received: (qmail 29986 invoked by uid 109); 24 Nov 2020 00:39:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 24 Nov 2020 00:39:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9540 invoked by uid 111); 24 Nov 2020 00:39:39 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 23 Nov 2020 19:39:39 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 23 Nov 2020 19:39:38 -0500
From:   Jeff King <peff@peff.net>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Alex Henrie <alexhenrie24@gmail.com>,
        =?utf-8?Q?V=C3=ADt?= Ondruch <vondruch@redhat.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: Pick the right default and stop warn on `git pull`
Message-ID: <X7xWSs3/vVqKl6sK@coredump.intra.peff.net>
References: <742df4c2-2bc5-8a4b-8de1-cd5e48718398@redhat.com>
 <CAMMLpeRLsE=zNDjCRKmEMFxJBYcnTOdDGxEL9cZuVhuDMF=sLg@mail.gmail.com>
 <20201123191355.GA132317@mit.edu>
 <CAMP44s3cKVxKa0gOPfi3XRKbGbV=DweFE5pL0HM+v0kECFyPWA@mail.gmail.com>
 <20201123202003.GB132317@mit.edu>
 <CAMP44s27oEjScrJjeDVoNcWcvRsn173L_Kx+TOPfchOwge9zUQ@mail.gmail.com>
 <X7wuMvHRURK1QS/Q@coredump.intra.peff.net>
 <CAMP44s0QOcMnYQqFFSE1jV_T6=e4=xTM0zr_06C6+aYb7oqb4A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMP44s0QOcMnYQqFFSE1jV_T6=e4=xTM0zr_06C6+aYb7oqb4A@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 23, 2020 at 04:55:31PM -0600, Felipe Contreras wrote:

> On Mon, Nov 23, 2020 at 3:48 PM Jeff King <peff@peff.net> wrote:
> > On Mon, Nov 23, 2020 at 02:34:18PM -0600, Felipe Contreras wrote:
> 
> > > There has never been a "pull.mode=ff-only" option; that's what I tried
> > > to introduce.
> >
> > There is pull.ff=only these days, which also squelches the message. But
> > you're right that it was never the default.
> 
> But that's not the same thing. The whole point of "pull.mode=ff-only"
> was to print a message like:
> 
>   The pull was not fast-forward, please either merge or rebase.

Perhaps I don't understand the distinction you are making. I have
pull.ff=ff set, and I get:

  $ git pull
  remote: Enumerating objects: 1, done.
  remote: Counting objects: 100% (1/1), done.
  remote: Total 1 (delta 0), reused 0 (delta 0), pack-reused 0
  Receiving objects: 100% (1/1), done.
  From /home/peff/tmp/.
     a4f00e2..22a4151  master     -> origin/master
  fatal: Not possible to fast-forward, aborting.

Which sounds like the same thing, modulo the error message not being
nearly as helpful (which I would be happy to see rectified).

Is there some other difference you're thinking of?

-Peff
