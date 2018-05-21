Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B0F8E1F51C
	for <e@80x24.org>; Mon, 21 May 2018 02:39:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752698AbeEUCjQ (ORCPT <rfc822;e@80x24.org>);
        Sun, 20 May 2018 22:39:16 -0400
Received: from cloud.peff.net ([104.130.231.41]:47440 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752680AbeEUCjQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 May 2018 22:39:16 -0400
Received: (qmail 14452 invoked by uid 109); 21 May 2018 02:39:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 21 May 2018 02:39:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25346 invoked by uid 111); 21 May 2018 02:39:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sun, 20 May 2018 22:39:23 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 20 May 2018 19:39:14 -0700
Date:   Sun, 20 May 2018 19:39:14 -0700
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jacob Keller <jacob.keller@gmail.com>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Elijah Newren <newren@gmail.com>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Phillip Wood <phillip.wood@talktalk.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Re*: [PATCH v4 3/4] string-list: provide `string_list_appendf()`
Message-ID: <20180521023913.GB16236@sigill.intra.peff.net>
References: <CAN0heSp7DqxOy-UeLgj8t_T_4f-fNthMpGNS8oUbcs7+NvS-zw@mail.gmail.com>
 <cover.1526810549.git.martin.agren@gmail.com>
 <77b025bb47869478e3eef1c3c34d379164f5d91c.1526810549.git.martin.agren@gmail.com>
 <CA+P7+xqPnuuQpp5e7fduLgaSd+JrTn95w=Da7q=iCXUgo0QHFA@mail.gmail.com>
 <xmqqvabh3mim.fsf_-_@gitster-ct.c.googlers.com>
 <xmqqr2m53leq.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqr2m53leq.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 21, 2018 at 09:25:01AM +0900, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > I have a feeling that argv_array might be a better fit for the
> > purpose of keeping track of to_free[] strings in the context of this
> > series.  Moving away from string_list would allow us to sidestep the
> > storage ownership issues the API has, and we do not need the .util
> > thing string_list gives us (which is one distinct advantage string_list
> > has over argv_array, if the application needs that feature).
> >
> > We would need to make _pushf() and friends return "const char *" if
> > we go that route to make the resulting API more useful, though.
> 
> ... and redoing the 4/4 patch using argv_array_pushf() makes the
> result look like this, which does not look too bad.

Agreed.

-Peff
