Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D19B1F829
	for <e@80x24.org>; Mon,  1 May 2017 05:43:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S642641AbdEAF3I (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 May 2017 01:29:08 -0400
Received: from cloud.peff.net ([104.130.231.41]:42938 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1165234AbdEAF3H (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2017 01:29:07 -0400
Received: (qmail 26120 invoked by uid 109); 1 May 2017 05:29:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 01 May 2017 05:29:06 +0000
Received: (qmail 8264 invoked by uid 111); 1 May 2017 05:29:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 01 May 2017 01:29:32 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 01 May 2017 01:29:03 -0400
Date:   Mon, 1 May 2017 01:29:03 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Marc Branchaud <marcnarc@xiplink.com>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 2/2] Have the diff-* builtins configure diff before
 initializing revisions.
Message-ID: <20170501052903.nkcg3ndcgbfj7t2p@sigill.intra.peff.net>
References: <20170427205037.1787-1-marcnarc@xiplink.com>
 <20170427205037.1787-3-marcnarc@xiplink.com>
 <20170428080620.cbnreh5invwpasxr@sigill.intra.peff.net>
 <xmqqpoftjspa.fsf@gitster.mtv.corp.google.com>
 <20170501051758.bei3odg3gehtbxbv@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170501051758.bei3odg3gehtbxbv@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 01, 2017 at 01:17:58AM -0400, Jeff King wrote:

> Yeah, I agree it is an existing bug. The only other case I found is
> dirstat. Doing:
> 
>   mkdir a b
>   for i in 1 2; do echo content >a/$i; done
>   for i in 1 2 3; do echo content >b/$i; done
>   git -c diff.dirstat=50 diff-tree --dirstat --root HEAD
> 
> should respect the config and show only "b", but it doesn't currently
> (and does with Marc's patch).

Er, there's a "git add a b; git commit -m foo" missing before running
the diff, of course.

-Peff
