Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43A8AC433E0
	for <git@archiver.kernel.org>; Sun, 17 Jan 2021 17:09:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0142A20770
	for <git@archiver.kernel.org>; Sun, 17 Jan 2021 17:09:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729785AbhAQRJA (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 17 Jan 2021 12:09:00 -0500
Received: from cloud.peff.net ([104.130.231.41]:58546 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728181AbhAQRI7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Jan 2021 12:08:59 -0500
Received: (qmail 21502 invoked by uid 109); 17 Jan 2021 17:08:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 17 Jan 2021 17:08:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16307 invoked by uid 111); 17 Jan 2021 17:08:18 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 17 Jan 2021 12:08:18 -0500
Authentication-Results: peff.net; auth=none
Date:   Sun, 17 Jan 2021 12:08:17 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Denton Liu <liu.denton@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 09/11] archive tests: use a cheaper "zipinfo -h"
 invocation to get header
Message-ID: <YARvAf8p+0Oj9jhF@coredump.intra.peff.net>
References: <20210114233515.31298-1-avarab@gmail.com>
 <20210116153554.12604-10-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210116153554.12604-10-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 16, 2021 at 04:35:52PM +0100, Ævar Arnfjörð Bjarmason wrote:

> Change an invocation of zipinfo added in 19ee29401d (t5004: test ZIP
> archives with many entries, 2015-08-22) to simply ask zipinfo for the
> header info, rather than spewing out info about the entire archive and
> race to kill it with SIGPIPE due to the downstream "head -2".
> 
> I ran across this because I'm adding a "set -o pipefail" test
> mode. This won't be needed for the version of the mode that I'm
> introducing (which currently relies on a patch to GNU bash), but I
> think this is a good idea anyway.

Makes sense. The only risk here would be that "-h" is not portable. But
I don't have any reason to think that's the case, and since it's just a
test, I'm fine with proceeding and seeing if anybody screams.

-Peff
