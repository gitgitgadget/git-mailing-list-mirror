Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0861CC433E0
	for <git@archiver.kernel.org>; Fri, 15 Jan 2021 20:47:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C752223AA9
	for <git@archiver.kernel.org>; Fri, 15 Jan 2021 20:47:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbhAOUrZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Jan 2021 15:47:25 -0500
Received: from cloud.peff.net ([104.130.231.41]:57696 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726286AbhAOUrW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jan 2021 15:47:22 -0500
Received: (qmail 4303 invoked by uid 109); 15 Jan 2021 20:46:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 15 Jan 2021 20:46:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 883 invoked by uid 111); 15 Jan 2021 20:46:41 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 15 Jan 2021 15:46:41 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 15 Jan 2021 15:46:40 -0500
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Subject: Re: [PATCH] ci/install-depends: attempt to fix "brew cask" stuff
Message-ID: <YAH/ME/YvesZBxfr@coredump.intra.peff.net>
References: <xmqqk0sevqlh.fsf@gitster.c.googlers.com>
 <YAH0G+Y4fIxoTeZa@coredump.intra.peff.net>
 <CAPig+cSWa_jgUjPXVMeOUwxQV_9Qhv0f-Wyb3odJnb1UpcOcPg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cSWa_jgUjPXVMeOUwxQV_9Qhv0f-Wyb3odJnb1UpcOcPg@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 15, 2021 at 03:07:38PM -0500, Eric Sunshine wrote:

> On Fri, Jan 15, 2021 at 3:00 PM Jeff King <peff@peff.net> wrote:
> > > -     brew cask install --no-quarantine perforce || {
> > > +     brew install --cask --no-quarantine perforce || {
> >
> > On a related note, it feels like perforce is a frequent offender for
> > triggering spurious failures (both for homebrew setup, but I have
> > definitely seen racy/flaky failures from it as well). I am tempted to
> > say it is not worth the trouble, but then I do not care at all about
> > git-p4 myself in the first place, so I may be biased.
> 
> To be fair to 'perforce', though, the fault of this particular problem
> is Homebrew, which doesn't seem to be all that concerned about
> backward compatibility, at least in my experience. The single
> Homebrew-related automation script I wrote for personal use has been
> broken by arbitrary Homebrew changes frustratingly often over the last
> three years.

Yeah, sorry, I should have been more precise in my language. None of
this is perforce's fault at all. It is homebrew in this case, and in the
racy cases it is probably our tests. But I do not feel like trying to
debug those races for a tool I don't care much about.

I tried to dig up some failing logs as an example, but it's actually a
bit hard to search for, and it looks like logs get expired after a few
months anyway.

-Peff
