Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6878EC4338F
	for <git@archiver.kernel.org>; Sat, 24 Jul 2021 01:19:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D19860BD3
	for <git@archiver.kernel.org>; Sat, 24 Jul 2021 01:19:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233413AbhGXAir (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Jul 2021 20:38:47 -0400
Received: from cloud.peff.net ([104.130.231.41]:56434 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233296AbhGXAir (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jul 2021 20:38:47 -0400
Received: (qmail 13957 invoked by uid 109); 24 Jul 2021 01:19:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 24 Jul 2021 01:19:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30319 invoked by uid 111); 24 Jul 2021 01:19:20 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 23 Jul 2021 21:19:20 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 23 Jul 2021 21:19:18 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org,
        Nicolas Morey-Chaisemartin <NMoreyChaisemartin@suse.de>,
        "Tom G . Christensen" <tgc@jupiterrise.com>,
        Mischa POSLAWSKY <git@shiar.nl>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 0/5] drop support for ancient curl
Message-ID: <YPtqlsnn/xYoS+7L@coredump.intra.peff.net>
References: <20170809120024.7phdjzjv54uv5dpz@sigill.intra.peff.net>
 <cover-0.5-00000000000-20210721T220402Z-avarab@gmail.com>
 <YPqW8lAcwno3j7Fq@coredump.intra.peff.net>
 <xmqqo8atovbc.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqo8atovbc.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 23, 2021 at 09:21:11AM -0700, Junio C Hamano wrote:

> > So modulo the commit message tweaks that Junio suggested, this all looks
> > fine. I actually think my original "#error on too-old curl" is still
> > reasonable. Yes, people whose distro has backported all of these
> > features could possibly still use it. But in that case they likely know
> > what's going on and can rip out the #error. It seems much more likely
> > to me that it _won't_ work, and they'll get confused by obscure errors
> > when they try to use an old curl.
> >
> > But I don't feel too stronlgy about it either way.
> 
> Me neither.  Those who are vanilla would not be helped by having it,
> as their build would fail if their cURL is too old anyway even
> without it.  Those who backported would have a build that may or may
> not work, but diagnosing it is part of the job of backporting their
> cURL anyway.  So in practice, I think "#error if you are older than
> X" primarily would serve documentation purposes (which may be worth
> doing, but requirements listed in INSTALL would probably be a better
> alternative anyway).

Yeah, it is purely for documentation to help people who are confused by
a broken build. But I agree that INSTALL is probably reasonable there
(not to mention that the whole point is that these versions are so old
hardly anybody should be using them anyway). So let's forget about the
#error thing, then.

-Peff
