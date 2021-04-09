Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12439C433ED
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 18:10:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D96FF6115B
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 18:10:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234538AbhDISLG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 14:11:06 -0400
Received: from cloud.peff.net ([104.130.231.41]:46604 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234499AbhDISLF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Apr 2021 14:11:05 -0400
Received: (qmail 705 invoked by uid 109); 9 Apr 2021 18:10:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 09 Apr 2021 18:10:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14728 invoked by uid 111); 9 Apr 2021 18:10:51 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 09 Apr 2021 14:10:51 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 9 Apr 2021 14:10:50 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Taylor Blau <me@ttaylorr.com>, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 2/6] object.c: remove "gently" argument to
 type_from_string_gently()
Message-ID: <YHCYqpYi6TxWh/KC@coredump.intra.peff.net>
References: <cover-0.3-0000000000-20210409T080534Z-avarab@gmail.com>
 <cover-0.6-0000000000-20210409T082935Z-avarab@gmail.com>
 <patch-2.6-daed40c479-20210409T082935Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-2.6-daed40c479-20210409T082935Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 09, 2021 at 10:32:50AM +0200, Ævar Arnfjörð Bjarmason wrote:

> Get rid of the "gently" argument to type_from_string_gently() to make
> it consistent with most other *_gently() functions. It's already a
> "gentle" function, it shouldn't need a boolean argument telling it to
> be gentle.
> 
> The reason it had a "gentle" parameter was because until the preceding
> commit "type_from_string()" was a macro resolving to
> "type_from_string_gently()", it's now a function.
> 
> This refactoring of adding a third parameter was done in
> fe8e3b71805 (Refactor type_from_string() to allow continuing after
> detecting an error, 2014-09-10) in preparation for its use in
> fsck.c.
> 
> Simplifying this means we can move the die() into the simpler
> type_from_string() function.

Yeah, this makes sense (and the change of signature will catch any
callers in topics-in-flight).

-Peff
