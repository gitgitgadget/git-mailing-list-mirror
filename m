Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8109C1F461
	for <e@80x24.org>; Wed, 28 Aug 2019 14:56:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbfH1O4m (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Aug 2019 10:56:42 -0400
Received: from cloud.peff.net ([104.130.231.41]:59598 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726454AbfH1O4m (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Aug 2019 10:56:42 -0400
Received: (qmail 13520 invoked by uid 109); 28 Aug 2019 14:56:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 28 Aug 2019 14:56:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11496 invoked by uid 111); 28 Aug 2019 14:58:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 28 Aug 2019 10:58:08 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 28 Aug 2019 10:56:41 -0400
From:   Jeff King <peff@peff.net>
To:     Giuseppe Crino' <giuscri@gmail.com>
Cc:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Pratyush Yadav <me@yadavpratyush.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Bryan Turner <bturner@atlassian.com>,
        Git Users <git@vger.kernel.org>
Subject: Re: [BUG] You can't have single quote in your username
Message-ID: <20190828145640.GC14432@sigill.intra.peff.net>
References: <CAGV3M55WAQOAOiZPPgR+6p2EVzakrbz1gYAMh-BqxCVDeLCq9w@mail.gmail.com>
 <CAGyf7-EdxDn_BwguXNUNg76K9z30X0=C1btMR0dfiHR9bLjhwQ@mail.gmail.com>
 <20190822170817.GB35435@google.com>
 <20190822184312.xhrf2ij3bh3vovrq@localhost.localdomain>
 <20190823082900.GG20404@szeder.dev>
 <20190826191455.GA25695@sigill.intra.peff.net>
 <20190828143315.GA4477@instance-template-2.europe-west6-a.c.vaulted-journal-250706.internal>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190828143315.GA4477@instance-template-2.europe-west6-a.c.vaulted-journal-250706.internal>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 28, 2019 at 02:33:15PM +0000, Giuseppe Crino' wrote:

> On Mon, Aug 26, 2019 at 03:14:55PM -0400, Jeff King wrote:
> > But we'd still need something at least for
> > GECOS, where "Your Name,,,," is common.
> 
> As I understand this, those commas are *not* removed by
> strbuf_addstr_without_crud(). Instead they're skipped from /etc/pass
> -- see `ident.c/copy_gecos()`.

Yeah, you're right. This is a good example of how we are completely
unclear on how often the crud-removal is helping. :)

But I think that does put us one step closer to possibly dropping the
crud-removal, if gecos is already handled (and hopefully "mailinfo" is
already cleaning up the names it parsers).

-Peff
