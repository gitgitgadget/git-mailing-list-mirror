Return-Path: <SRS0=IlH6=24=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DA9AC282DD
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 19:31:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4B9C2077B
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 19:31:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728834AbgAGTbp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jan 2020 14:31:45 -0500
Received: from cloud.peff.net ([104.130.231.41]:59626 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728836AbgAGTbo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jan 2020 14:31:44 -0500
Received: (qmail 15367 invoked by uid 109); 7 Jan 2020 19:31:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 07 Jan 2020 19:31:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4648 invoked by uid 111); 7 Jan 2020 19:37:19 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 07 Jan 2020 14:37:19 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 7 Jan 2020 14:31:43 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, brad@brad-smith.co.uk,
        sunshine@sunshineco.com, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 1/3] graph: fix case that hit assert()
Message-ID: <20200107193143.GA56858@coredump.intra.peff.net>
References: <pull.517.git.1578408947.gitgitgadget@gmail.com>
 <65186f3ded251e0bcf1fcb18160163a3efd97c37.1578408947.git.gitgitgadget@gmail.com>
 <20200107153006.GA20591@coredump.intra.peff.net>
 <xmqqblrf5azn.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqblrf5azn.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 07, 2020 at 11:21:00AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> >> Second, the horizontal lines in that first line drop their coloring.
> >> This is due to a use of graph_line_addch() instead of
> >> graph_line_write_column(). Using a ternary operator to pick the
> >> character is nice for compact code, but we actually need a column
> >> to provide the color.
> >
> > It seems like this is a totally separate bug, and could be its own
> > commit?
> 
> I think so.
> 
> And with that removed, all that remains would be a removal of the
> assert() plus an additional test?

Yes, though note that the color thing is a v2.25 regression as well. So
we'd probably want both of them.

-Peff
