Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 085E71FBEC
	for <e@80x24.org>; Fri, 10 Mar 2017 18:03:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755449AbdCJSDq (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Mar 2017 13:03:46 -0500
Received: from cloud.peff.net ([104.130.231.41]:42095 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755276AbdCJSDp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Mar 2017 13:03:45 -0500
Received: (qmail 22607 invoked by uid 109); 10 Mar 2017 18:03:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 10 Mar 2017 18:03:44 +0000
Received: (qmail 27288 invoked by uid 111); 10 Mar 2017 18:03:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 10 Mar 2017 13:03:53 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 10 Mar 2017 13:03:41 -0500
Date:   Fri, 10 Mar 2017 13:03:41 -0500
From:   Jeff King <peff@peff.net>
To:     Brandon Williams <bmwill@google.com>
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>, git@vger.kernel.org,
        markbt@efaref.net, benpeart@microsoft.com, jonathantanmy@google.com
Subject: Re: [PATCH 02/10] pack-objects: add --partial-by-size=n
 --partial-special
Message-ID: <20170310180341.bbzukqrj2zlkje2b@sigill.intra.peff.net>
References: <1488994685-37403-1-git-send-email-jeffhost@microsoft.com>
 <1488994685-37403-3-git-send-email-jeffhost@microsoft.com>
 <xmqqh93338s2.fsf@gitster.mtv.corp.google.com>
 <1c38ffbc-e4a2-32e5-d324-506c2111043e@jeffhostetler.com>
 <20170309070438.r5g2h5vlmgzds4kp@sigill.intra.peff.net>
 <20170310175823.GA53198@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170310175823.GA53198@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 10, 2017 at 09:58:23AM -0800, Brandon Williams wrote:

> > A while back when we discussed whether to allow symlinks for
> > .gitattributes, etc, I think the consensus was to treat the whole
> > ".git*" namespace consistently. I haven't followed up with patches yet,
> > but my plan was to go that route.
> 
> Well if I remember correctly you sent out some patches for
> .gitattributes but I got in the way with the refactoring work! :)

True. :) But those were the old method that tries to treat
.gitattributes specially, by using O_NOFOLLOW in the attribute code (but
only for in-tree files, naturally).

I think we ended up deciding that it would be better to just disallow
symlink .gitattributes (and .git*) from entering the index, the way we
disallow ".git".

-Peff
