Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 081ACC48BE6
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 10:24:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D893D60D07
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 10:24:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232303AbhFPK0q (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Jun 2021 06:26:46 -0400
Received: from cloud.peff.net ([104.130.231.41]:57356 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231769AbhFPK0l (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jun 2021 06:26:41 -0400
Received: (qmail 12425 invoked by uid 109); 16 Jun 2021 10:24:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 16 Jun 2021 10:24:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25243 invoked by uid 111); 16 Jun 2021 10:24:35 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 16 Jun 2021 06:24:35 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 16 Jun 2021 06:24:32 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Andrei Rybak <rybak.a.v@gmail.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Subject: Re: [PATCH] test-lib: fix "$remove_trash" regression and
 match_pattern_list() bugs
Message-ID: <YMnRYJnMAe5/TIlF@coredump.intra.peff.net>
References: <xmqqa6nqsd2i.fsf@gitster.g>
 <patch-1.1-436c723f4f8-20210616T082030Z-avarab@gmail.com>
 <YMm4F2uKZ4Dv3C4p@coredump.intra.peff.net>
 <xmqqeed2p3jx.fsf@gitster.g>
 <YMnRC8v4RLDk2+K9@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YMnRC8v4RLDk2+K9@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 16, 2021 at 06:23:07AM -0400, Jeff King wrote:

> But this also means the shell will do the usual globbing for each
> argument, which can result in us seeing an expansion based on what's in
> the filesystem, rather than the real pattern. For example, if I have the
> path "t5000" in the filesystem, and you feed the pattern "t?0000", that
> _should_ match the string "t0000", but it won't after the shell has
> expanded it to "t5000".

Whoops, that pattern should be "t?000", of course.

It's correct in the runnable example later on.

-Peff
