Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C810E1F404
	for <e@80x24.org>; Fri, 30 Mar 2018 21:27:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752846AbeC3V07 (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Mar 2018 17:26:59 -0400
Received: from cloud.peff.net ([104.130.231.41]:49508 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752571AbeC3V06 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Mar 2018 17:26:58 -0400
Received: (qmail 918 invoked by uid 109); 30 Mar 2018 21:26:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 30 Mar 2018 21:26:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 633 invoked by uid 111); 30 Mar 2018 21:27:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 30 Mar 2018 17:27:57 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 30 Mar 2018 17:26:56 -0400
Date:   Fri, 30 Mar 2018 17:26:56 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     avarab@gmail.com, e@80x24.org, git@vger.kernel.org,
        gitster@pobox.com
Subject: Re: [PATCH v7 13/13] pack-objects: reorder members to shrink struct
 object_entry
Message-ID: <20180330212656.GK14782@sigill.intra.peff.net>
References: <20180318142526.9378-1-pclouds@gmail.com>
 <20180324063353.24722-1-pclouds@gmail.com>
 <20180324063353.24722-14-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180324063353.24722-14-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 24, 2018 at 07:33:53AM +0100, Nguyễn Thái Ngọc Duy wrote:

> Previous patches leave lots of holes and padding in this struct. This
> patch reorders the members and shrinks the struct down to 80 bytes
> (from 136 bytes, before any field shrinking is done) with 16 bits to
> spare (and a couple more in in_pack_header_size when we really run out
> of bits).

Out of curiosity, did you count this yourself, or did you double-check
with a few compilers to make sure they all produce the same result?

So having read the whole thing now, I think most of my original concerns
have been addressed. I do think readability takes a hit, but it's not
_too_ bad. There are a few things that have become more brittle, but I
can't think of anything on the horizon that would bite us.

-Peff
