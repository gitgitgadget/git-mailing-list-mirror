Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 377F6203E2
	for <e@80x24.org>; Fri, 19 Aug 2016 01:02:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754673AbcHSBCl (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Aug 2016 21:02:41 -0400
Received: from cloud.peff.net ([104.130.231.41]:57788 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1754233AbcHSBCk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Aug 2016 21:02:40 -0400
Received: (qmail 11650 invoked by uid 109); 18 Aug 2016 15:05:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 18 Aug 2016 15:05:25 +0000
Received: (qmail 14691 invoked by uid 111); 18 Aug 2016 15:05:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 18 Aug 2016 11:05:27 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 18 Aug 2016 11:05:22 -0400
Date:   Thu, 18 Aug 2016 11:05:22 -0400
From:   Jeff King <peff@peff.net>
To:     Olaf Hering <olaf@aepfle.de>
Cc:     Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
Subject: Re: git format-patch --break-rewrites broken in 2.9.3
Message-ID: <20160818150522.56gdx2mhgo7qwvru@sigill.intra.peff.net>
References: <20160818144421.GA9062@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160818144421.GA9062@aepfle.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 18, 2016 at 04:44:21PM +0200, Olaf Hering wrote:

> This command used to create a diff which can be consumed by patch. But
> at least with 2.9.3 it just gives a rename output:
> 
>  git format-patch \
>         --no-signature \
>         --stdout \
>         --break-rewrites \
>         --keep-subject \
>  95fa0405c5991726e06c08ffcd8ff872f7fb4f2d^..95fa0405c5991726e06c08ffcd8ff872f7fb4f2d
> 
> 
> What must be done now to get a usable patch?

Probably --no-renames.

Renames were enabled by default by 5404c11 (diff: activate diff.renames
by default, 2016-02-25), which is in v2.9.0.

I wonder if we should consider undoing that for format-patch, whose
output may be consumed by non-git endpoints.

-Peff
