Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF9DAC11F67
	for <git@archiver.kernel.org>; Wed, 30 Jun 2021 02:23:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B466E61D6E
	for <git@archiver.kernel.org>; Wed, 30 Jun 2021 02:23:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232373AbhF3C0E (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Jun 2021 22:26:04 -0400
Received: from cloud.peff.net ([104.130.231.41]:36984 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232299AbhF3C0E (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jun 2021 22:26:04 -0400
Received: (qmail 22246 invoked by uid 109); 30 Jun 2021 02:23:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 30 Jun 2021 02:23:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1112 invoked by uid 111); 30 Jun 2021 02:23:37 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 29 Jun 2021 22:23:37 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 29 Jun 2021 22:23:35 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] Makefile: add and use the ".DELETE_ON_ERROR" flag
Message-ID: <YNvVpxeYH4LKZZCm@coredump.intra.peff.net>
References: <8735t93h0u.fsf@evledraar.gmail.com>
 <YNI3WVu5SK7pHI7T@coredump.intra.peff.net>
 <87r1gs1hfx.fsf@evledraar.gmail.com>
 <YNOz1GD/8+CaUvRz@coredump.intra.peff.net>
 <871r8r1hwe.fsf@evledraar.gmail.com>
 <YNSbe0At6SaQu1Z4@coredump.intra.peff.net>
 <87fsx6xn0b.fsf@evledraar.gmail.com>
 <YNqE8BIRF6NeYQcd@coredump.intra.peff.net>
 <xmqqfsx1yyza.fsf@gitster.g>
 <875yxxgkav.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <875yxxgkav.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 29, 2021 at 09:39:26AM +0200, Ævar Arnfjörð Bjarmason wrote:

> > I do not see a point in complicating the build procedure to avoid
> > using it.
> 
> I'd really understand your and Jeff's concerns if I was proposing some
> really complex workaround, but it's just extending & making consistent
> the "mv" dance we already use for 1/2 our rules already.

Just to clarify my position: I'm not all that upset about adding more
uses of "mv", as I agree it's not a lot of code (and in general I like
making things atomic). Mostly I was trying to understand your use case,
and whether we could be encouraging a more robust workflow there.

And that's what I was prodding at in the last email: what's the reason
that doing it in a separate workdir doesn't work? I did find your
answers compelling that it takes more disk space, and you have to
compile everything twice (I do use ccache myself, but I agree that "oh,
just install ccache" is not helpful advice in the general case).

-Peff
