Return-Path: <SRS0=B37d=3G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3DF4C33C9E
	for <git@archiver.kernel.org>; Fri, 17 Jan 2020 17:49:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C486024679
	for <git@archiver.kernel.org>; Fri, 17 Jan 2020 17:49:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbgAQRtc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Jan 2020 12:49:32 -0500
Received: from cloud.peff.net ([104.130.231.41]:38984 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726603AbgAQRtc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Jan 2020 12:49:32 -0500
Received: (qmail 12375 invoked by uid 109); 17 Jan 2020 17:49:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 17 Jan 2020 17:49:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15962 invoked by uid 111); 17 Jan 2020 17:56:02 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 17 Jan 2020 12:56:02 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 17 Jan 2020 12:49:31 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] Makefile: use compat regex with SANITIZE=address
Message-ID: <20200117174931.GA8958@coredump.intra.peff.net>
References: <20200116175138.GA691238@coredump.intra.peff.net>
 <xmqqr1zydlwt.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqr1zydlwt.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 17, 2020 at 09:37:22AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Recent versions of the gcc and clang Address Sanitizer produce test
> > failures related to regexec(). This triggers with gcc-10 and clang-8
> > (but not gcc-9 nor clang-7). Running:
> >
> >   make CC=gcc-10 SANITIZE=address test
> >
> > results in failures in t4018, t3206, and t4062.
> [...]
> I guess we should treat this the same way as the recent vcproj "fix"
> by Dscho, i.e. fast-track to 'maint' to ensure that all public
> integration branches has it soonish?

I don't think there's a huge rush. It only triggers ASan and recent
compilers, so AFAIK nobody has been hitting this in CI. I occasionally
test with whatever is the most recent compiler in Debian unstable to see
if it turns up any interesting new warnings or errors (but gcc-9 is
still the default there).

-Peff
