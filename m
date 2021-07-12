Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D0E8C07E99
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 20:13:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6422A61245
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 20:13:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236729AbhGLUPv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jul 2021 16:15:51 -0400
Received: from cloud.peff.net ([104.130.231.41]:46982 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235270AbhGLUPu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jul 2021 16:15:50 -0400
Received: (qmail 21709 invoked by uid 109); 12 Jul 2021 20:13:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 12 Jul 2021 20:13:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1990 invoked by uid 111); 12 Jul 2021 20:13:02 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 12 Jul 2021 16:13:02 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 12 Jul 2021 16:13:01 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/6] git-compat-util.h: add __attribute__((printf)) to
 git_*printf*
Message-ID: <YOyiTTbFJmWjwXlq@coredump.intra.peff.net>
References: <cover-0.6-00000000000-20210710T084445Z-avarab@gmail.com>
 <patch-6.6-365c5cf50b6-20210710T084445Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-6.6-365c5cf50b6-20210710T084445Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jul 10, 2021 at 10:47:32AM +0200, Ævar Arnfjörð Bjarmason wrote:

> Add __attribute__((printf)) to the compatibility functions we use
> under SNPRINTF_RETURNS_BOGUS=Y.
> 
> In practice this is redundant to the compiler's default printf format
> checking, since we mostly (entirely?)  develop and test on platforms
> where SNPRINTF_RETURNS_BOGUS is not set. I'm doing this mainly for
> consistency with other code, now we don't need to think about why this
> particular case is different.
> 
> See c4582f93a26 (Add compat/snprintf.c for systems that return bogus,
> 2008-03-05) for the commit that added these functions.

I'm slightly lukewarm on general on adding this to a compat function.
Those are meant to be a lowest-common-denominator fallback, and we
usually avoid fancy features or our usual styles there in favor of
simplicity.

I guess this probably isn't _hurting_ anything, but it makes me wonder
how many systems have a broken snprintf _and_ support the attribute.

-Peff
