Return-Path: <SRS0=eX0j=BR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C41EC433DF
	for <git@archiver.kernel.org>; Fri,  7 Aug 2020 08:26:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2D51221E5
	for <git@archiver.kernel.org>; Fri,  7 Aug 2020 08:26:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726644AbgHGI0o (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Aug 2020 04:26:44 -0400
Received: from cloud.peff.net ([104.130.231.41]:51502 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726382AbgHGI0o (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Aug 2020 04:26:44 -0400
Received: (qmail 30068 invoked by uid 109); 7 Aug 2020 08:26:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 07 Aug 2020 08:26:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12074 invoked by uid 111); 7 Aug 2020 08:26:43 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 07 Aug 2020 04:26:43 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 7 Aug 2020 04:26:43 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Sergey Organov <sorganov@gmail.com>, git@vger.kernel.org,
        Chris Torek <chris.torek@gmail.com>
Subject: Re: [PATCH v2 0/7] making log --first-parent imply -m
Message-ID: <20200807082643.GA34012@coredump.intra.peff.net>
References: <20200803180824.GA2711830@coredump.intra.peff.net>
 <874kpi47xj.fsf@osv.gnss.ru>
 <xmqqbljqrydm.fsf@gitster.c.googlers.com>
 <20200804200018.GB2014743@coredump.intra.peff.net>
 <877due1688.fsf@osv.gnss.ru>
 <20200804212201.GA2020725@coredump.intra.peff.net>
 <xmqq3652rs84.fsf@gitster.c.googlers.com>
 <878seuxdz8.fsf@osv.gnss.ru>
 <20200804221440.GC2022650@coredump.intra.peff.net>
 <xmqqpn86qb6a.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqpn86qb6a.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 04, 2020 at 03:49:17PM -0700, Junio C Hamano wrote:

> > I'm just
> > raising the issue now because we'll be locked into the semantics of this
> > option, which may not be able to express the full set of what's possible
> > (so we'd be stuck adding another option later).
> 
> Yeah, but a good thing is that we won't have to worry about this
> until much later, as long as we would just be introducing "diff
> against no parents" and nothing else (or together with "diff against
> all parents", which would make it easier to explain "-m").

Agreed. My only question is whether the possibility of later having
those other options might influence how we name the two options we add
now. I think it's clear to all of us in this thread how those two easy
options should behave, but if the intent is to eventually allow these to
be mutually exclusive:

  - no diff
  - combined
  - dense combined
  - individual diff against each parent

but orthogonal to the selection of the parent-set (none, all, or
selected ones) then e.g. "all" makes less sense for "individual diff
against each parent". I don't have a good succinct name suggestion,
though.

TBH, I would be happy enough with any of the suggestions in the thread,
so I am really just finishing the thought here, and not trying to derail
progress. :)

-Peff
