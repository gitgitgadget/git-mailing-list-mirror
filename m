Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9911C433F5
	for <git@archiver.kernel.org>; Wed, 20 Oct 2021 16:13:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 866F66138F
	for <git@archiver.kernel.org>; Wed, 20 Oct 2021 16:13:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231173AbhJTQPt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Oct 2021 12:15:49 -0400
Received: from cloud.peff.net ([104.130.231.41]:42688 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230257AbhJTQPt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Oct 2021 12:15:49 -0400
Received: (qmail 9812 invoked by uid 109); 20 Oct 2021 16:13:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 20 Oct 2021 16:13:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25701 invoked by uid 111); 20 Oct 2021 16:13:32 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 20 Oct 2021 12:13:32 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 20 Oct 2021 12:13:32 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
        git@vger.kernel.org
Subject: Re: What's cooking in git.git (Oct 2021, #02; Wed, 6)
Message-ID: <YXBALFsf305U8mJs@coredump.intra.peff.net>
References: <xmqqfstdr8b5.fsf@gitster.g>
 <YV5aaD418SyZqS/1@coredump.intra.peff.net>
 <YV5dmkkuCqAY2qqG@coredump.intra.peff.net>
 <YV5yi+AejPGO9qOi@nand.local>
 <YV/BMkZrj4xQyvUL@coredump.intra.peff.net>
 <nycvar.QRO.7.76.6.2110080946060.395@tvgsbejvaqbjf.bet>
 <YWC49+xCh+zum8Ms@coredump.intra.peff.net>
 <nycvar.QRO.7.76.6.2110201416390.56@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.2110201416390.56@tvgsbejvaqbjf.bet>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 20, 2021 at 02:27:30PM +0200, Johannes Schindelin wrote:

> Hi Peff,
> 
> On Fri, 8 Oct 2021, Jeff King wrote:
> 
> > On Fri, Oct 08, 2021 at 09:51:33AM +0200, Johannes Schindelin wrote:
> >
> > > FWIW I have set up an Azure Pipeline to keep Git for Windows' `main`
> > > branch covered by Coverity:
> > >
> > > https://dev.azure.com/git-for-windows/git/_build?definitionId=35
> > >
> > > It essentially calls into this scripted code:
> > > https://github.com/git-for-windows/build-extra/blob/4676f286a1ec830a5038b32400808a353dc6c48d/please.sh#L1820-L1915
> >
> > Do you have any objection to adding something like the Action I showed
> > eariler? It would do nothing in git-for-windows/git unless you set up
> > the right environment, so there shouldn't be any downside.
> 
> No objection. I'd just ask to use `${{github.repository}}` instead of
> hard-coding `peff/git`, and to really not run the workflow unless
> configured. So something like this:

Yep, those were directions I was planning to take it.

> I am very much in favor of having this in git/git. Do you want to provide
> the commit message, or do you want me to shepher this?

I'd be just as happy if you did (I hadn't even looked at it since my
earlier email).

It sounds like Taylor is volunteering to set up the Coverity side for
git.git, and I can help him with getting those COVERITY_* variables into
the GitHub environment.

> > I admit I was not really planning to try to suppress the false positives
> > as you've done here; my plan was to just keep an eye on the "new"
> > entries (having already gone through the existing ones years ago).
> 
> I think we will _have_ to suppress the false positives at some point, as
> something like 9 out of 10 new reports I receive are about these, and it
> takes time to analyze & dismiss them. In general, I have no trouble
> finding more fun things to do with my time.

The volume is low enough that I've been OK just manually skipping past
them. But if we have mitigations to make that happen automatically, I'm
all in favor. We can do that incrementally on top, but the fact that
you've already figured out most of it means it may make sense to just do
it from the start (and is another good reason for you to submit the
patches).

Sorry, I didn't mean to make more work/patches for you. :)

-Peff
