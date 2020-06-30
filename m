Return-Path: <SRS0=HTZL=AL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F496C433DF
	for <git@archiver.kernel.org>; Tue, 30 Jun 2020 19:35:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EE5F206C0
	for <git@archiver.kernel.org>; Tue, 30 Jun 2020 19:35:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728188AbgF3Tfu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Jun 2020 15:35:50 -0400
Received: from cloud.peff.net ([104.130.231.41]:46504 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727883AbgF3Tfu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jun 2020 15:35:50 -0400
Received: (qmail 14462 invoked by uid 109); 30 Jun 2020 19:35:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 30 Jun 2020 19:35:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26181 invoked by uid 111); 30 Jun 2020 19:35:49 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 30 Jun 2020 15:35:49 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 30 Jun 2020 15:35:48 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 03/10] fast-export: store anonymized oids as hex strings
Message-ID: <20200630193548.GB1889576@coredump.intra.peff.net>
References: <20200623152436.GA50925@coredump.intra.peff.net>
 <20200623152451.GC1435482@coredump.intra.peff.net>
 <20200624114313.GJ2898@szeder.dev>
 <20200624155420.GC2088459@coredump.intra.peff.net>
 <20200625154948.GA3968780@coredump.intra.peff.net>
 <20200625204532.GK2898@szeder.dev>
 <20200625211522.GA4030664@coredump.intra.peff.net>
 <nycvar.QRO.7.76.6.2006291513330.56@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.2006291513330.56@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 29, 2020 at 03:17:00PM +0200, Johannes Schindelin wrote:

> > TBH, that does not seem like that compelling a reason to me to keep it
> > around. If no compiler is complaining of C99 for-loop declarations, then
> > maybe we should consider loosening our style. Or are we trying to be
> > kind of some unknown set of platform-specific compilers that we can't
> > feasibly hit in our CI?
> 
> FWIW _iff_ we decide to loosen our style, I would like to propose doing it
> in one place first, and keep it that way for two or three major versions.
> 
> Traditionally, people stuck on platforms such as IRIX or HP/UX with
> proprietary C compilers (and remember: I once was one of those people)
> often lack the luxury of upgrading frequently. And if it turns out that we
> want to revert the style-loosening, it is much easier to do it in one
> place than in many.

Yeah, I definitely agree that would be the way to do it. I admit I don't
even _really_ care that much about allowing the feature. More that it
might not be worth trying to crack down on it so aggressively, and
just letting it get picked up by review (or if it slips through, letting
the poor souls stuck on HP/UX complain).

(And I say "worth" because now the use of gcc 4.8 as the checking tool
has demonstrably cost a bunch of human time, so it comes with a cost).

-Peff

