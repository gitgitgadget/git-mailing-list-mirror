Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3AB392021E
	for <e@80x24.org>; Wed,  9 Nov 2016 23:17:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754646AbcKIXRY (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Nov 2016 18:17:24 -0500
Received: from cloud.peff.net ([104.130.231.41]:40935 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752576AbcKIXRX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Nov 2016 18:17:23 -0500
Received: (qmail 27447 invoked by uid 109); 9 Nov 2016 23:17:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 09 Nov 2016 23:17:23 +0000
Received: (qmail 447 invoked by uid 111); 9 Nov 2016 23:17:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 09 Nov 2016 18:17:52 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 09 Nov 2016 18:17:21 -0500
Date:   Wed, 9 Nov 2016 18:17:21 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 4/5] attr: do not respect symlinks for in-tree
 .gitattributes
Message-ID: <20161109231720.luuhezzziuhx4r75@sigill.intra.peff.net>
References: <20161102130432.d3zprdul4sqgcfwu@sigill.intra.peff.net>
 <20161102130848.qpigt4hxpoyfjf7x@sigill.intra.peff.net>
 <CACsJy8AO2KtpxFu=wRjW1DoCA9bfpF1VoJUn__2ib-ML0XT66w@mail.gmail.com>
 <20161107211010.xo3243egggdgscou@sigill.intra.peff.net>
 <20161107211522.vzl4zpsu5cpembgc@sigill.intra.peff.net>
 <CACsJy8BoEXDjwe=ZX5ZOC_mvaMjYrB3i7wcMmiOP3mm5-rwC5Q@mail.gmail.com>
 <xmqqmvh88dlu.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqmvh88dlu.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 09, 2016 at 02:58:37PM -0800, Junio C Hamano wrote:

> Duy Nguyen <pclouds@gmail.com> writes:
> 
> > Let's err on the safe side and disable symlinks to outside repo by
> > default (or even all symlinks on .gitattributes and .gitignore as the
> > first step)
> >
> > What I learned from my changes in .gitignore is, if we have not
> > forbidden something, people likely find some creative use for it.
> 
> Yup.  Supporting any symlink in-tree is like requiring Git to be
> used only on symlink-capable filesystems.  Not allowing it sounds
> like a very sensible option and unlike true contents, there is no
> downside to give that limitation to things like .git<anything>.

I'm slightly confused. Did you mean "supporting any in-tree symlink to
an out-of-tree destination" in your first sentence?

> Shouldn't we do the same for .gitmodules while we are at it?

Good catch. Though I am inclined to have a flag that just covers all
out-of-tree symlinks, regardless of names.

-Peff
