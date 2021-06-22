Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C34C3C2B9F4
	for <git@archiver.kernel.org>; Tue, 22 Jun 2021 19:28:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BE4460FE9
	for <git@archiver.kernel.org>; Tue, 22 Jun 2021 19:28:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232415AbhFVTaZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Jun 2021 15:30:25 -0400
Received: from cloud.peff.net ([104.130.231.41]:36328 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229786AbhFVTaZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jun 2021 15:30:25 -0400
Received: (qmail 6659 invoked by uid 109); 22 Jun 2021 19:28:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 22 Jun 2021 19:28:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29706 invoked by uid 111); 22 Jun 2021 19:28:07 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 22 Jun 2021 15:28:07 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 22 Jun 2021 15:28:06 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Denton Liu <liu.denton@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Kristof Provost <Kristof@provost-engineering.be>
Subject: Re: [PATCH 3/3] Makefile: don't use "FORCE" for tags targets
Message-ID: <YNI5xsHWqOd3kv1y@coredump.intra.peff.net>
References: <cover-0.3-00000000000-20210622T141844Z-avarab@gmail.com>
 <patch-3.3-67fc87665d6-20210622T141844Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-3.3-67fc87665d6-20210622T141844Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 22, 2021 at 04:21:27PM +0200, Ævar Arnfjörð Bjarmason wrote:

> Remove the "FORCE" dependency from the "tags", "TAGS" and "cscope.out"
> targets, instead make them depend on whether or not the relevant
> source files have changed.
> 
> I'm also removing the "-o" option from them, that seems to have been
> cargo-culted when they were initially added in f81e7c626f3 (Makefile:
> Add TAGS and tags targets, 2006-03-18). It would make sense to use
> that option if we had been appending to tag files, it doesn't make any
> sense that it was used after we'd just removed the files file being
> appended to.

You mean "-a" in this second paragraph, right?

I think it would help if xargs splits the source file list across
multiple invocations of the command.

-Peff
