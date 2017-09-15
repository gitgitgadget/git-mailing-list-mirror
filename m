Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E9C3020A21
	for <e@80x24.org>; Fri, 15 Sep 2017 00:46:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751703AbdIOAqk (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Sep 2017 20:46:40 -0400
Received: from cloud.peff.net ([104.130.231.41]:39416 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751645AbdIOAqj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Sep 2017 20:46:39 -0400
Received: (qmail 17148 invoked by uid 109); 15 Sep 2017 00:46:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 15 Sep 2017 00:46:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1520 invoked by uid 111); 15 Sep 2017 00:47:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 14 Sep 2017 20:47:14 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 Sep 2017 20:46:37 -0400
Date:   Thu, 14 Sep 2017 20:46:37 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     demerphq <demerphq@gmail.com>, Git <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 7/7] config: flip return value of store_write_*()
Message-ID: <20170915004637.jueyykocyktrwfk7@sigill.intra.peff.net>
References: <20170913170807.cyx7rrpoyhaauvol@sigill.intra.peff.net>
 <20170913171756.v7vzu3a77g2khq7x@sigill.intra.peff.net>
 <20170913212528.GO27425@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170913212528.GO27425@aiede.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 13, 2017 at 02:25:28PM -0700, Jonathan Nieder wrote:

> > Let's flip them to follow the usual write() conventions and
> > update all callers. As these are local to config.c, it's
> > unlikely that we'd have new callers in any topics in flight
> > (which would be silently broken by our change). But just to
> > be on the safe side, let's rename them to just
> > write_section() and write_pairs().  That also accentuates
> > their relationship with write().
> >
> > Signed-off-by: Jeff King <peff@peff.net>
> 
> The caller only cares if it succeeded, right?  Could this return
> the customary 0 vs -1 instead of the number of bytes written?

Yes, it could. I went with "follow the conventions of write()" because
these are used in a big chain of write() calls (well, really
write_in_full). But given the current callers, it does not matter either
way.

Thanks for reviewing the series, and sorry if my comments have been a
bit terse. I'm trying to clear my pile before going out of town for a
few days (which I admit may have contributed to my desire for you to
prepare patches on top).

But either way, don't expect a re-roll until next week at the earliest.

-Peff
