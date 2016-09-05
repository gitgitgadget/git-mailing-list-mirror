Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE3A820705
	for <e@80x24.org>; Mon,  5 Sep 2016 21:54:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933431AbcIEVyO (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Sep 2016 17:54:14 -0400
Received: from cloud.peff.net ([104.130.231.41]:38491 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S932217AbcIEVyO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Sep 2016 17:54:14 -0400
Received: (qmail 8108 invoked by uid 109); 5 Sep 2016 21:54:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 05 Sep 2016 21:54:14 +0000
Received: (qmail 22417 invoked by uid 111); 5 Sep 2016 21:54:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 05 Sep 2016 17:54:21 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 05 Sep 2016 17:54:11 -0400
Date:   Mon, 5 Sep 2016 17:54:11 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: Re: [PATCH 0/5] handle tag recursion in pack-objects --include-tag
Message-ID: <20160905215411.zu5urzi26gpbsj6j@sigill.intra.peff.net>
References: <20160905215141.b6unqtjqko7775is@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160905215141.b6unqtjqko7775is@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 05, 2016 at 05:51:41PM -0400, Jeff King wrote:

> If you have a tag of a tag of a commit, and the middle tag isn't
> otherwise reachable, then "pack-objects --include-tag" will not include
> the middle tag, and certain invocations of "clone" will fail. See the
> final patch below for the gory details.
> 
> The first five patches are just test cleanup and modernization in
> preparation (though note that the 3rd one actually fixes a minor bug in
> the test script).
> 
>   [1/5]: t5305: move cleanup into test block
>   [2/5]: t5305: drop "dry-run" of unpack-objects
>   [3/5]: t5305: use "git -C"
>   [4/5]: t5305: simplify packname handling
>   [5/5]: pack-objects: walk tag chains for --include-tag

BTW, this is not a new regression; the problem dates back to the origin
of the "include-tag" feature. So there is no urgency to the fix, as it
has been with us for almost a decade. I built it on master, but it
should apply cleanly to maint.

-Peff
