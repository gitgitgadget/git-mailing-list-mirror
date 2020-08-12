Return-Path: <SRS0=KdtI=BW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0F2AC433DF
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 20:11:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A51BE20774
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 20:11:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbgHLULb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Aug 2020 16:11:31 -0400
Received: from cloud.peff.net ([104.130.231.41]:56986 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726547AbgHLULb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Aug 2020 16:11:31 -0400
Received: (qmail 11961 invoked by uid 109); 12 Aug 2020 20:11:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 12 Aug 2020 20:11:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3927 invoked by uid 111); 12 Aug 2020 20:11:30 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 12 Aug 2020 16:11:30 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 12 Aug 2020 16:11:30 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Sibi Siddharthan <sibisiv.siddharthan@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: What's cooking in git.git (Aug 2020, #01; Mon, 3)
Message-ID: <20200812201130.GB1340519@coredump.intra.peff.net>
References: <xmqq8sevt1lf.fsf@gitster.c.googlers.com>
 <20200804185057.GA1400256@coredump.intra.peff.net>
 <xmqqr1sms0f0.fsf@gitster.c.googlers.com>
 <20200804192053.GA1400936@coredump.intra.peff.net>
 <nycvar.QRO.7.76.6.2008121516560.50@tvgsbejvaqbjf.bet>
 <20200812141958.GA32453@coredump.intra.peff.net>
 <CAKw82xxOZFcsMw47TSrD7-pXpqO7O0_m84o96iH6+ZVeN9j1uw@mail.gmail.com>
 <20200812160653.GA42443@coredump.intra.peff.net>
 <xmqqlfij63p8.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqlfij63p8.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 12, 2020 at 12:53:39PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Yeah, I know. My main beef was that because it fails CI, the urgency of
> > doing that fix gets pushed onto people working on their individual
> > topics (in fact there is nothing for you to fix yet because I haven't
> > even sent these topics upstream). I don't know how to solve that without
> > stopping its use in the vsbuild CI job, though.
> 
> What I am not getting is in what way it blocks you (or others who do
> not deeply care about Windows) to leave vsbuild CI job broken.  Do
> you have some automation that is gated by all the CI jobs to pass,
> or do you just dislike failing CI jobs out of principle?

It's two things.

The first is "out of principle". If the vs-build job always fails, then
I'll stop looking at it. So I'd never even see if it fails for a
legitimately interesting reason. And now there's no value in running it
at all.

The second thing is annoyance. I get an email that says "hey, your CI
job failed". And then I think "oh no, I should figure out what it is".
And then I spend 10 minutes investigating only to find out that no, it's
not something I care about.

If the vs-build job always failed I could write it off in less time than
10 minutes. But it's still not nothing, because the email still grabs my
attention, and then I have to manually figure out that it was indeed
vs-build and only vs-build which failed (which is not helped by the mail
from GitHub consisting of 25 lines listing the succeeded jobs). Getting
that once a day isn't world-ending, but it is annoying (and I do get it
once a day because I do my own daily integration run, which is what I
push to CI).

So rather than deal with that, I'd probably add more bits to our
ci/config to allow myself to just disable that job. For now I'm letting
it run, though. I've fixed my two topics, and I'm curious to see if it
comes up again, and if so how long it takes.

-Peff
