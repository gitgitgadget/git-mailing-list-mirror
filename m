Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF465C4338F
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 10:47:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9655B60E91
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 10:47:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231688AbhGWKHS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Jul 2021 06:07:18 -0400
Received: from cloud.peff.net ([104.130.231.41]:55704 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231519AbhGWKHR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jul 2021 06:07:17 -0400
Received: (qmail 11260 invoked by uid 109); 23 Jul 2021 10:47:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 23 Jul 2021 10:47:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24274 invoked by uid 111); 23 Jul 2021 10:47:53 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 23 Jul 2021 06:47:53 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 23 Jul 2021 06:47:50 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Denton Liu <liu.denton@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Kristof Provost <Kristof@provost-engineering.be>,
        Taylor Blau <me@ttaylorr.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v3 5/5] Makefile: normalize clobbering & xargs for tags
 targets
Message-ID: <YPqeVnoC3mL1t8/a@coredump.intra.peff.net>
References: <cover-0.5-0000000000-20210629T110837Z-avarab@gmail.com>
 <cover-0.5-00000000000-20210721T231900Z-avarab@gmail.com>
 <patch-5.5-f3ff76d0e98-20210721T231900Z-avarab@gmail.com>
 <YPqdQZdfR1kh0vGT@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YPqdQZdfR1kh0vGT@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 23, 2021 at 06:43:13AM -0400, Jeff King wrote:

> On Thu, Jul 22, 2021 at 01:23:06AM +0200, Ævar Arnfjörð Bjarmason wrote:
> 
> > This is because the xargs command may decide to invoke the program
> > multiple times. We need to make sure we've got a union of its results
> > at the end.
> > 
> > For "ctags" and "etags" we used the "-a" flag for this, for cscope
> > that behavior is the default. Its "-u" flag disables its equivalent of
> > an implicit "-a" flag.
> 
> Hrm, that's not the experience I get with cscope. E.g.:

Just to make it extra clear: this is not a problem introduced by your
series, since we were already using xargs with cscope. But this seems
like a good time to fix it.

-Peff
