Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 49C1320285
	for <e@80x24.org>; Thu, 24 Aug 2017 13:38:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753178AbdHXNiv (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Aug 2017 09:38:51 -0400
Received: from cloud.peff.net ([104.130.231.41]:47878 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753117AbdHXNir (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Aug 2017 09:38:47 -0400
Received: (qmail 16585 invoked by uid 109); 24 Aug 2017 13:38:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 24 Aug 2017 13:38:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9542 invoked by uid 111); 24 Aug 2017 13:39:14 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 24 Aug 2017 09:39:14 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Aug 2017 06:38:43 -0700
Date:   Thu, 24 Aug 2017 06:38:43 -0700
From:   Jeff King <peff@peff.net>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH] Doc: clarify that pack-objects makes packs, plural
Message-ID: <20170824133842.vqzydienll6ka4vw@sigill.intra.peff.net>
References: <20170822182242.20862-1-jonathantanmy@google.com>
 <xmqqbmn72x7a.fsf@gitster.mtv.corp.google.com>
 <20170823212251.li5fs4kypeveydbm@sigill.intra.peff.net>
 <CA+P7+xoPscnzCGLHSK-gk80GcZLZ5T4e7E29ztVX7qbjMcGbnw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+P7+xoPscnzCGLHSK-gk80GcZLZ5T4e7E29ztVX7qbjMcGbnw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 24, 2017 at 12:27:52AM -0700, Jacob Keller wrote:

> > For the sneaker-net case, you are much better off generating a single
> > pack and then using "split" and "cat" to reconstruct it on the other end
> > Not that I think we should go into such detail in the manpage, but I
> > have to wonder if --max-pack-size has outlived its usefulness. The only
> > use case I can think of is a filesystem that cannot hold files larger
> > than N bytes.
> 
> Is it possible to detect on the file system that we can't store files
> that large, and remove the option, while enabling it only when we
> detect the filesystem is unable to store large files?

I'm not sure how easy it would be to do such a check. But even if it
was, I'm not sure that buys us much. We'd still carry the code. We could
in theory remove the option, simplifying the interface. But that removes
the possibility of somebody wanting to stage the smaller packfiles on a
more capable filesystem in preparation for moving them to the
more-limited one.

-Peff
