Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 157B41F597
	for <e@80x24.org>; Tue, 31 Jul 2018 17:23:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728607AbeGaTEY (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jul 2018 15:04:24 -0400
Received: from cloud.peff.net ([104.130.231.41]:37266 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727482AbeGaTEX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jul 2018 15:04:23 -0400
Received: (qmail 29700 invoked by uid 109); 31 Jul 2018 17:23:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 31 Jul 2018 17:23:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2508 invoked by uid 111); 31 Jul 2018 17:23:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 31 Jul 2018 13:23:08 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 31 Jul 2018 13:23:04 -0400
Date:   Tue, 31 Jul 2018 13:23:04 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        George Shammas <georgyo@gmail.com>, git@vger.kernel.org
Subject: Re: git merge -s subtree seems to be broken.
Message-ID: <20180731172304.GA16977@sigill.intra.peff.net>
References: <CAF1Ko+FBP5UmETmh071dvn9iv8-N-3YgaP61q-4jQvxFdN0GTA@mail.gmail.com>
 <CAF1Ko+FNfjWMteccfKDBjPEW76rGBLQkGb1icUHmzEZ0fKQJBA@mail.gmail.com>
 <xmqqtvofcsgc.fsf@gitster-ct.c.googlers.com>
 <20180731161559.GB16910@sigill.intra.peff.net>
 <xmqqh8kfcokk.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqh8kfcokk.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 31, 2018 at 10:17:15AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > +...
> > +		} else if (cmp > 0) {
> >  			/* path2 does not appear in one */
> > +			score += score_missing(two.entry.mode, two.entry.path);
> > +			update_tree_entry(&two);
> > +			continue;
> > +		} if (oidcmp(one.entry.oid, two.entry.oid)) {
> 
> As the earlier ones do the "continue at the end of the block", this
> does not affect the correctness, but I think you either meant "else if"
> or a fresh "if/else" that is disconnected from the previous if/else if/...
> chain.

Yes, thanks. I actually started to write it without the "continue" at
all, and a big "else" that checked the "we have both" case. But I backed
that out (in favor of a smaller diff), and forgot to add back in the
"else if".

-Peff
