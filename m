Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A3A11F453
	for <e@80x24.org>; Mon,  4 Feb 2019 23:34:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbfBDXeu (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Feb 2019 18:34:50 -0500
Received: from cloud.peff.net ([104.130.231.41]:32856 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726436AbfBDXet (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Feb 2019 18:34:49 -0500
Received: (qmail 10194 invoked by uid 109); 4 Feb 2019 23:34:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 04 Feb 2019 23:34:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24138 invoked by uid 111); 4 Feb 2019 23:34:57 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 04 Feb 2019 18:34:57 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 05 Feb 2019 00:34:45 +0100
Date:   Tue, 5 Feb 2019 00:34:45 +0100
From:   Jeff King <peff@peff.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3] doc-diff: don't `cd_to_toplevel`
Message-ID: <20190204233444.GC2366@sigill.intra.peff.net>
References: <20190203230152.GA25608@sigill.intra.peff.net>
 <20190204205037.32143-1-martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190204205037.32143-1-martin.agren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 04, 2019 at 09:50:37PM +0100, Martin Ågren wrote:

> `usage` tries to call $0, which might very well be "./doc-diff", so if
> we `cd_to_toplevel` before calling `usage`, we'll end with an error to
> the effect of "./doc-diff: not found" rather than a friendly `doc-diff
> -h` output. This regressed in ad51743007 ("doc-diff: add --clean mode to
> remove temporary working gunk", 2018-08-31) where we moved the call to
> `cd_to_toplevel` to much earlier.
> 
> A general fix might be to teach git-sh-setup to save away the absolute
> path for $0 and then use that, instead. I'm not aware of any portable
> way of doing that, see, e.g., d2addc3b96 ("t7800: readlink may not be
> available", 2016-05-31).
> 
> An early version of this patch moved `cd_to_toplevel` back to where it
> was before ad51743007 and taught the "--clean" code to cd on its own.
> But let's try instead to get rid of the cd-ing entirely. We don't really
> need it and we can work with absolute paths instead. There's just one
> use of $PWD that we need to adjust by simply dropping it.

Thanks, this version looks great to me!

-Peff
