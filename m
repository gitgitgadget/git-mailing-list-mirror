Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54D40C433B4
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 08:25:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E5496128E
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 08:25:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbhDMI0R (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Apr 2021 04:26:17 -0400
Received: from cloud.peff.net ([104.130.231.41]:50946 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229379AbhDMI0R (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Apr 2021 04:26:17 -0400
Received: (qmail 29328 invoked by uid 109); 13 Apr 2021 08:25:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 13 Apr 2021 08:25:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23814 invoked by uid 111); 13 Apr 2021 08:25:58 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 13 Apr 2021 04:25:58 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 13 Apr 2021 04:25:56 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Taylor Blau <me@ttaylorr.com>, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 1/2] blob.c: remove buffer & size arguments to
 parse_blob_buffer()
Message-ID: <YHVVlCg2EAb4ZddJ@coredump.intra.peff.net>
References: <cover-00.11-00000000000-20210328T021238Z-avarab@gmail.com>
 <cover-0.3-0000000000-20210409T080534Z-avarab@gmail.com>
 <patch-1.3-68a7709fe5-20210409T080534Z-avarab@gmail.com>
 <YHCUFwZMitOXELpq@coredump.intra.peff.net>
 <87y2dqfgbb.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87y2dqfgbb.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 10, 2021 at 02:57:12PM +0200, Ævar Arnfjörð Bjarmason wrote:

> > Not new in your patch, but I wondered if this could cause a segfault
> > when lookup_blob() returns NULL. I _think_ the answer is "no". We'd hit
> > this code path when either:
> [...]
> I was trying to keep the changes smaller, but what about just doing this?:
> [...]

Yeah, that seems pretty reasonable to me. It cleans up the extra lookups
in parse_object() and gets rid of the funny-named "parse_blob_buffer()"
that takes no buffer.

-Peff
