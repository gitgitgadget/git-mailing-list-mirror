Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8EC291F453
	for <e@80x24.org>; Tue, 29 Jan 2019 22:35:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727570AbfA2Wfe (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Jan 2019 17:35:34 -0500
Received: from cloud.peff.net ([104.130.231.41]:54048 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727332AbfA2Wfe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jan 2019 17:35:34 -0500
Received: (qmail 20352 invoked by uid 109); 29 Jan 2019 22:35:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 29 Jan 2019 22:35:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11649 invoked by uid 111); 29 Jan 2019 22:35:39 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 29 Jan 2019 17:35:39 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Jan 2019 17:35:30 -0500
Date:   Tue, 29 Jan 2019 17:35:30 -0500
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Sebastian Staudt <koraktor@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v3 2/3] Setup working tree in describe
Message-ID: <20190129223529.GB1895@sigill.intra.peff.net>
References: <20190129051859.12830-1-koraktor@gmail.com>
 <20190129051859.12830-2-koraktor@gmail.com>
 <20190129131151.GB22211@sigill.intra.peff.net>
 <CAPig+cRUCmaiYqKG6ON==g1sFph-hz6nK5fTYc-9w2JaNFmdLA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cRUCmaiYqKG6ON==g1sFph-hz6nK5fTYc-9w2JaNFmdLA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 29, 2019 at 03:53:40PM -0500, Eric Sunshine wrote:

> > > The implementation of --broken uses diff-index which calls
> > > setup_work_tree() itself.
> >
> > If I hadn't just read the rest of the thread, I'd probably wonder why we
> > are talking about --broken at all. Maybe:
> >
> >   The --broken option similarly needs a working tree. But because the
> >   current implementation calls an external diff-index to do the work,
> >   we don't have to bother setting up the working tree in the
> >   git-describe process.
> 
> This rewrite left me slightly in the dark since I had to infer that
> git-diff-index calls setup_work_tree() itself. Perhaps:
> 
>     ...an external diff-index to do the work, which itself calls
>     setup_work_tree(), we don't have to bother...
> 
> But that's minor.

Yeah, my reasoning was that we handed off to diff-index, so if it
doesn't work, then it has its own bug. ;) But I agree it is probably
better to just be explicit.

-Peff
