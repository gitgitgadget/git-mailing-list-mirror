Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F288C47089
	for <git@archiver.kernel.org>; Tue,  6 Dec 2022 01:47:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232374AbiLFBrO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Dec 2022 20:47:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbiLFBrM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Dec 2022 20:47:12 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3A9D13D0E
        for <git@vger.kernel.org>; Mon,  5 Dec 2022 17:47:11 -0800 (PST)
Received: (qmail 11341 invoked by uid 109); 6 Dec 2022 01:47:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 06 Dec 2022 01:47:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16115 invoked by uid 111); 6 Dec 2022 01:47:12 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 05 Dec 2022 20:47:12 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 5 Dec 2022 20:47:10 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-compat-util.h: introduce CALLOC(x)
Message-ID: <Y46fHhD3xionHgPE@coredump.intra.peff.net>
References: <6694c52b38674859eb0390c7f62da1209a8d8ec3.1670266373.git.me@ttaylorr.com>
 <a8e33b1e-1056-5f75-55b5-65c0bceef3ca@web.de>
 <Y45yaYV3xFB/xR2G@nand.local>
 <221206.868rjle7za.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <221206.868rjle7za.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 06, 2022 at 12:12:32AM +0100, Ævar Arnfjörð Bjarmason wrote:

> But if we *are* doing that then surely we should provide the full set of
> functions. I.e. ALLOC() and ALLOC_ARRAY(), CALLOC() and CALLOC_ARRAY(),
> and REALLOC() and REALLOC_ARRAY()?

FWIW, I would be happy to see all of those (minus REALLOC(), as there is
not really any point in growing or shrinking something with a fixed
size).

The biggest argument against them that I can see is that:

  struct foo *x = malloc(sizeof(*x));

is idiomatic C that newcomers to the project will easily understand,
and:

  struct foo *x;
  ALLOC(x);

is not. But it feels like we already crossed that bridge with
ALLOC_ARRAY(), etc.

-Peff
