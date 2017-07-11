Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 35F9120357
	for <e@80x24.org>; Tue, 11 Jul 2017 07:12:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932190AbdGKHMh (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Jul 2017 03:12:37 -0400
Received: from cloud.peff.net ([104.130.231.41]:36602 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S932162AbdGKHMh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jul 2017 03:12:37 -0400
Received: (qmail 27250 invoked by uid 109); 11 Jul 2017 07:12:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 11 Jul 2017 07:12:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13485 invoked by uid 111); 11 Jul 2017 07:12:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Tue, 11 Jul 2017 03:12:48 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 11 Jul 2017 03:12:34 -0400
Date:   Tue, 11 Jul 2017 03:12:34 -0400
From:   Jeff King <peff@peff.net>
To:     Kenneth Hsu <kennethhsu@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: bug: HEAD vs. head on case-insensitive filesystems
Message-ID: <20170711071234.bj3kzfn5xii4e33w@sigill.intra.peff.net>
References: <20170711033236.GA11492@lenny.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170711033236.GA11492@lenny.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 10, 2017 at 08:32:36PM -0700, Kenneth Hsu wrote:

> I'm not sure what the general consensus is regarding the use of "head"
> vs. "HEAD" on case insensitive filesystems, but it appears that some
> confusing behavior (bug?) may have arisen.

Generally, the advice on "head" is "don't". It's an accident that
it works at all, and as you noticed, there are odd corner cases. There
are similar oddities when mixing and matching case for other refnames on
case-insensitive filesystems, too.

I was going to point you to the recent thread in

  http://public-inbox.org/git/87ziclb2pa.fsf@gmail.com/

but I see you already participated there. So if your mail here is
"here's a summary of how HEAD/head don't quite work", then OK, that
might be handy. But I think the ultimate resolution is not "let's make
them work", but "let's consistently enforce case-sensitivity in ref
names, regardless of the underlying filesystem".

-Peff
