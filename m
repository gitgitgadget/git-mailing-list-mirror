Return-Path: <SRS0=XLsf=DH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ADE7C4363D
	for <git@archiver.kernel.org>; Wed, 30 Sep 2020 22:39:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEAC92075F
	for <git@archiver.kernel.org>; Wed, 30 Sep 2020 22:39:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731656AbgI3WjP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Sep 2020 18:39:15 -0400
Received: from cloud.peff.net ([104.130.231.41]:46058 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731626AbgI3WjO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Sep 2020 18:39:14 -0400
Received: (qmail 26802 invoked by uid 109); 30 Sep 2020 22:39:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 30 Sep 2020 22:39:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1171 invoked by uid 111); 30 Sep 2020 22:39:13 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 30 Sep 2020 18:39:13 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 30 Sep 2020 18:39:13 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Carlo Arenas <carenas@gmail.com>,
        Nikita Leonov via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Nikita Leonov <nykyta.leonov@gmail.com>
Subject: Re: [PATCH v2 2/3] credentials: make line reading Windows compatible
Message-ID: <20200930223913.GB1908000@coredump.intra.peff.net>
References: <pull.710.git.git.1581688196706.gitgitgadget@gmail.com>
 <pull.710.v2.git.git.1601293224.gitgitgadget@gmail.com>
 <f69076036fe4dfe8b57fc1d4329c7be3f7346850.1601293224.git.gitgitgadget@gmail.com>
 <CAPUEspgW9CFO3WtbiuTUsmXp05fPqr2Cs81piDJFJ0g3KcTy3A@mail.gmail.com>
 <20200929003000.GA898702@coredump.intra.peff.net>
 <xmqqwo0difdh.fsf@gitster.c.googlers.com>
 <20200929004448.GD898702@coredump.intra.peff.net>
 <xmqqsgb1ier6.fsf@gitster.c.googlers.com>
 <20200929030043.GA905754@coredump.intra.peff.net>
 <xmqqeemigawq.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqeemigawq.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 30, 2020 at 03:25:09PM -0700, Junio C Hamano wrote:

> OK, so what's the final verdict from us?  This is good enough to
> move forward as-is?

I'd prefer to see the credential-cache--daemon changes either dropped,
or split out into a separate patch with the justification of: this
probably doesn't matter in practice, but it makes the whole protocol
between client and server treat CRLF consistently.

I had also raised a question in:

  https://lore.kernel.org/git/20200929004220.GC898702@coredump.intra.peff.net/

about whether they just care about the empty line, or about CRLF on data
lines. If the former (which is what the commit message claims), then I
think we can do something much simpler. But I suspect it is the latter,
and it is simply the commit message that is a bit misleading.

Other than those nits, I think the series is OK.

-Peff
