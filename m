Return-Path: <SRS0=nPiP=6T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 846E8C3A5A9
	for <git@archiver.kernel.org>; Tue,  5 May 2020 00:11:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EFC0206EB
	for <git@archiver.kernel.org>; Tue,  5 May 2020 00:11:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728353AbgEEALG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 May 2020 20:11:06 -0400
Received: from cloud.peff.net ([104.130.231.41]:36960 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727028AbgEEALF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 May 2020 20:11:05 -0400
Received: (qmail 3939 invoked by uid 109); 5 May 2020 00:11:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 05 May 2020 00:11:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23850 invoked by uid 111); 5 May 2020 00:11:06 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 04 May 2020 20:11:06 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 4 May 2020 20:11:04 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     clime <clime7@gmail.com>, Git List <git@vger.kernel.org>
Subject: Re: [PATCH 1/2] ref-filter: apply --ignore-case to all sorting keys
Message-ID: <20200505001104.GA40276@coredump.intra.peff.net>
References: <20200503090952.GA170768@coredump.intra.peff.net>
 <20200503091157.GA170902@coredump.intra.peff.net>
 <xmqqh7wvfmar.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqh7wvfmar.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 04, 2020 at 02:00:12PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > would sort the primary key (taggername) case-insensitively, but sort the
> > refname case-sensitively. We have two options here:
> >
> >   - teach callers to set ignore_case on the whole list
> >
> >   - replace the ref_sorting list with a struct that contains both the
> >     list of sorting keys, as well as options that apply to _all_
> >     keys
> >
> > I went with the first one here, as it gives more flexibility if we later
> > want to let the users set the flag per-key (presumably through some
> > special syntax when defining the key; for now it's all or nothing
> > through --ignore-case).
> 
> A good design decision I would fully support.

I admit I had second thoughts when dealing with the "oops, we have to
choose ignore_case from the first one" part of the second patch. But I
think it works OK in practice, and I did like having a less invasive
diff. :)

-Peff
