Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2625C432BE
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 17:57:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A228610E6
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 17:57:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235342AbhHTR6T (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Aug 2021 13:58:19 -0400
Received: from cloud.peff.net ([104.130.231.41]:53440 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229940AbhHTR6Q (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Aug 2021 13:58:16 -0400
Received: (qmail 23390 invoked by uid 109); 20 Aug 2021 17:57:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 20 Aug 2021 17:57:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6957 invoked by uid 111); 20 Aug 2021 17:57:37 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 20 Aug 2021 13:57:37 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 20 Aug 2021 13:57:37 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Mike Hommey <mh@glandium.org>, Junio C Hamano <gitster@pobox.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] Fix leak in credential_apply_config
Message-ID: <YR/tETCiv3TqqEPH@coredump.intra.peff.net>
References: <20210820084413.1503711-1-mh@glandium.org>
 <ffa1786e-f69f-3d76-98dc-7fa5cdbd31c0@gmail.com>
 <YR/sxISzR0RebVMZ@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YR/sxISzR0RebVMZ@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 20, 2021 at 01:56:20PM -0400, Jeff King wrote:

> > It would help unify the handling of code that is somewhat
> > duplicated (but slightly different each time) across
> > credential_apply_config(), http_init(), get_urlmatch(),
> > and cmd__urlmatch_normalization().
> 
> Agreed. It looks like http_init() has the same leak that is fixed here.

Oh, nevermind. That call is indeed correct. Apparently if you re-order
two lines I'm unable to see them. ;)

-Peff
