Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23CB0C2D0E4
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 01:45:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A106A206FA
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 01:45:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726186AbgKXBpx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Nov 2020 20:45:53 -0500
Received: from cloud.peff.net ([104.130.231.41]:39560 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725861AbgKXBpx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Nov 2020 20:45:53 -0500
Received: (qmail 30445 invoked by uid 109); 24 Nov 2020 01:45:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 24 Nov 2020 01:45:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10180 invoked by uid 111); 24 Nov 2020 01:45:52 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 23 Nov 2020 20:45:52 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 23 Nov 2020 20:45:51 -0500
From:   Jeff King <peff@peff.net>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Git <git@vger.kernel.org>,
        =?utf-8?Q?V=C3=ADt?= Ondruch <vondruch@redhat.com>,
        "Theodore Y . Ts'o" <tytso@mit.edu>, Andreas Krey <a.krey@gmx.de>,
        John Keeping <john@keeping.me.uk>,
        Richard Hansen <rhansen@rhansen.org>,
        Philip Oakley <philipoakley@iee.email>,
        "Brian M. Carlson" <sandals@crustytoothpaste.net>,
        "W. Trevor King" <wking@tremily.us>
Subject: Re: [PATCH v7 1/1] pull: add ff-only option
Message-ID: <X7xlz8NAnsh4SE9l@coredump.intra.peff.net>
References: <20201123224621.2573159-1-felipe.contreras@gmail.com>
 <20201123224621.2573159-2-felipe.contreras@gmail.com>
 <CAMP44s2FRZUvUy+F3banxd9MEdL=RMqEdJL3JLYEGDQkOz3vNA@mail.gmail.com>
 <CAMMLpeR8_fshsaqSF6idOY-KyFw2+AK_5683a-7wDXhsO=iFVQ@mail.gmail.com>
 <xmqqim9vlkdn.fsf@gitster.c.googlers.com>
 <CAMP44s3Y3BEbPM_69uxmQWiBq2CqwBo4w13M43WvU4nUQZha8g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMP44s3Y3BEbPM_69uxmQWiBq2CqwBo4w13M43WvU4nUQZha8g@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 23, 2020 at 05:51:42PM -0600, Felipe Contreras wrote:

> > On the other hand, it looks quite funny for that single variable
> > that controls the way how pull works, whether rebase or merge is
> > used, is pull.REBASE.
> 
> Which is precisely why I wanted to rename it to pull.mode.
> 
> In my option git pull should have three main modes:
> 
> 1. fast-forward only
> 2. merge
> 3. rebase
> 
> The fast-forward only mode can be considered a merge, or a rebase,
> doesn't matter.

I agree that is much nicer. I'd worry a bit though that it may be
confusing to users to have this new mode option _and_ the existing
pull.rebase and pull.ff options, which overlap (but not completely). It
might be something we could solve with good documentation, though.

-Peff
