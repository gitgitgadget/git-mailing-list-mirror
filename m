Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB385C6379D
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 02:44:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CA3420720
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 02:44:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728699AbgKXCnh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Nov 2020 21:43:37 -0500
Received: from cloud.peff.net ([104.130.231.41]:39666 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728491AbgKXCnh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Nov 2020 21:43:37 -0500
Received: (qmail 30842 invoked by uid 109); 24 Nov 2020 02:43:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 24 Nov 2020 02:43:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10606 invoked by uid 111); 24 Nov 2020 02:43:36 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 23 Nov 2020 21:43:36 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 23 Nov 2020 21:43:36 -0500
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v2 00/24] pack-bitmap: bitmap generation improvements
Message-ID: <X7xzWClGr3bM3wcg@coredump.intra.peff.net>
References: <cover.1605123652.git.me@ttaylorr.com>
 <cover.1605649533.git.me@ttaylorr.com>
 <CAN0heSq59uX=4pqkhc904oLfeiwF5ctiEb_9cQXYY7T1t=Mt1g@mail.gmail.com>
 <xmqqy2iusdpy.fsf@gitster.c.googlers.com>
 <CAN0heSpVnzyE5S5ReKQ0Q_UU48jQ77NVF1x1NTGx29+5KZsyRA@mail.gmail.com>
 <X7nNlu8wBZw3xFjX@xnor.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <X7nNlu8wBZw3xFjX@xnor.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 21, 2020 at 09:31:50PM -0500, Taylor Blau wrote:

> > There was SZEDER's comment on that last patch in v2, where future
> > readers of that patch will have to wonder why it does s/256/270/ in a
> > test. I agree with SZEDER that the change should be mentioned in the
> > commit message, even if it's just "unfortunately, we have some magicness
> > here, plus we want to pass both with SHA-1 and SHA-256; turns out 270
> > hits the problem we want to test for".
> 
> Thanks for reviewing it, and noticing a couple of problems in the
> earlier patches, too. If folks are happy with the replacement that I
> sent [1], then I am too :-).
> 
> I don't think that the "big" patch generated a ton of review on the
> list, but maybe that's OK. Peff, Stolee, and I all reviewed that patch
> extensively when deploying it at GitHub (where it has been running since
> late Summer).

Hrm. I thought you were going to integrate the extra checks I suggested
for load_bitmap_entries_v1(). Which is looks like you did in patch 17.
After that, the s/256/270/ hack should not be necessary anymore (if it
is, then we should keep fixing more spots).

-Peff
