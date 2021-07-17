Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 880CEC12002
	for <git@archiver.kernel.org>; Sat, 17 Jul 2021 02:33:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D173613ED
	for <git@archiver.kernel.org>; Sat, 17 Jul 2021 02:33:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232648AbhGQCgE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Jul 2021 22:36:04 -0400
Received: from cloud.peff.net ([104.130.231.41]:52648 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232322AbhGQCgE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jul 2021 22:36:04 -0400
Received: (qmail 22680 invoked by uid 109); 17 Jul 2021 02:33:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 17 Jul 2021 02:33:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16539 invoked by uid 111); 17 Jul 2021 02:33:09 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 16 Jul 2021 22:33:09 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 16 Jul 2021 22:33:07 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH] refs file backend: remove dead "errno == EISDIR" code
Message-ID: <YPJBY8LjiwYRyDOu@coredump.intra.peff.net>
References: <patch-1.1-de0838fe99-20210714T111351Z-avarab@gmail.com>
 <YO8PBBJZ2Q+5ZqFs@coredump.intra.peff.net>
 <871r801yp6.fsf@evledraar.gmail.com>
 <YO9wCqetxHii+TvK@coredump.intra.peff.net>
 <875yxczbd6.fsf@evledraar.gmail.com>
 <YO/EpxU0NG+HVSlx@coredump.intra.peff.net>
 <xmqqk0lppw49.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqk0lppw49.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 16, 2021 at 06:28:06PM -0700, Junio C Hamano wrote:

> >> I then just never got to picking it up again, I'll probably re-roll it &
> >> make it a part of this series, then we can remove this whole OID != NULL
> >> case and will be sure nothing fishy's going on.
> >
> > Yeah, that sounds like a good path forward. I do think the patch under
> > discussion here is probably the right thing to do. But it becomes all
> > the more obvious if lock_ref_oid_basic() ends up dropping that parameter
> > entirely.
> 
> OK, so what's the final verdict on this step?  It is unfortunate
> that when Ævar took over a topic from Han-Wen, this patch has been
> inserted as the very first step before the patches in the series, so
> until we know we are happy with it, it takes several other patches
> hostage.

I just read through v2. Modulo a few small nits (mostly typos, but a few
commit message suggestions), it looks good to me. I agree it's a lot to
stick in front of another set of patches, but I think in this case we
can proceed quickly enough to make it worth doing in the order Ævar
suggests.

-Peff
