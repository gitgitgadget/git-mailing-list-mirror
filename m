Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 687EB2037F
	for <e@80x24.org>; Mon, 22 Apr 2019 21:02:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729104AbfDVVCR (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Apr 2019 17:02:17 -0400
Received: from cloud.peff.net ([104.130.231.41]:37280 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729095AbfDVVCR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Apr 2019 17:02:17 -0400
Received: (qmail 5954 invoked by uid 109); 22 Apr 2019 21:02:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 22 Apr 2019 21:02:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2909 invoked by uid 111); 22 Apr 2019 21:02:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 22 Apr 2019 17:02:48 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 22 Apr 2019 17:02:15 -0400
Date:   Mon, 22 Apr 2019 17:02:15 -0400
From:   Jeff King <peff@peff.net>
To:     Martin Fick <mfick@codeaurora.org>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: Resolving deltas dominates clone time
Message-ID: <20190422210214.GA31079@sigill.intra.peff.net>
References: <259296914.jpyqiltySj@mfick-lnx>
 <20190420035825.GB3559@sigill.intra.peff.net>
 <16052712.dFCfNLlQnN@mfick-lnx>
 <20190422205653.GA30286@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190422205653.GA30286@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 22, 2019 at 04:56:54PM -0400, Jeff King wrote:

> > I suspect at 3 threads, seems like the default?
> 
> Ah, right, I forgot we cap it at 3 (which was determined experimentally,
> and which we more or less attributed to lock contention as the
> bottleneck). I think you need to use $GIT_FORCE_THREADS to override it.

Ah, nevermind this. Using --threads will do what you expect. The cap at
3 only applies when we've just picked the number of available CPUs as a
default.

-Peff
