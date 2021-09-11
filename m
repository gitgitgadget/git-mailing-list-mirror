Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E603C433F5
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 21:22:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2695161050
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 21:22:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233331AbhIKVX1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Sep 2021 17:23:27 -0400
Received: from cloud.peff.net ([104.130.231.41]:45240 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229977AbhIKVX0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Sep 2021 17:23:26 -0400
Received: (qmail 13432 invoked by uid 109); 11 Sep 2021 21:22:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 11 Sep 2021 21:22:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24899 invoked by uid 111); 11 Sep 2021 21:22:12 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 11 Sep 2021 17:22:12 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 11 Sep 2021 17:22:12 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/5] packfile: use oidset for bad objects
Message-ID: <YT0eBC16DLkd80Ak@coredump.intra.peff.net>
References: <4a702bfe-afd0-669a-c893-0262289c24b8@web.de>
 <e50c1465-59de-7fe1-de01-800404c7640e@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e50c1465-59de-7fe1-de01-800404c7640e@web.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 11, 2021 at 10:31:52PM +0200, René Scharfe wrote:

> Replace the custom hash array for remembering corrupt pack entries with
> an oidset.  This shortens and simplifies the code.
> 
> Changes since v1:
> - inline oidset_size()
> - inline nth_midxed_pack_entry() early
> - use oidset_size() to avoid a function call if no bad objects exist

Thanks, these all look fine to me. I raised a question elsewhere in the
thread about inlining oidset_contains(), but I think that can be
considered separately (and is less clear-cut; we might win by saving a
function call, but we might lose due to larger code size).

-Peff
