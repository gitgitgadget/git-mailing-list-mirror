Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 92C211F463
	for <e@80x24.org>; Thu, 12 Sep 2019 14:01:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732393AbfILOBq (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Sep 2019 10:01:46 -0400
Received: from cloud.peff.net ([104.130.231.41]:47852 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1732389AbfILOBq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Sep 2019 10:01:46 -0400
Received: (qmail 13543 invoked by uid 109); 12 Sep 2019 14:01:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 12 Sep 2019 14:01:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7978 invoked by uid 111); 12 Sep 2019 14:03:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 12 Sep 2019 10:03:45 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 12 Sep 2019 10:01:45 -0400
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        Derrick Stolee <dstolee@microsoft.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH] upload-pack: disable commit graph more gently for
 shallow traversal
Message-ID: <20190912140144.GC23031@sigill.intra.peff.net>
References: <20190912000414.GA31334@sigill.intra.peff.net>
 <20190912020748.GA76228@syl.lan>
 <20190912110620.GA3729@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190912110620.GA3729@szeder.dev>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 12, 2019 at 01:06:20PM +0200, SZEDER Gábor wrote:

> > > +#  - we must use protocol v2, because it handles the "have" negotiation before
> > > +#    processing the shallow direectives
> 
> s/ee/e/

Thanks, fixed.

> We can't simply replace that 'git config' command with 'test_config',
> because it is implemented using 'test_when_finished', which doesn't
> work in a subshell [1].  What we could do is:
> 
>   test_create_repo shallow-since-graph &&
>   test_config -C shallow-since-graph core.commitGraph true &&
>   (
>      cd shallow-since-graph &&
>      ....
> 
> Or we could entirely avoid the subshell by passing '-C
> shallow-since-graph' to every single command... [2]
> 
> However, since this repo was specifically created for this test, it
> doesn't really matter in what state it's left behind, so I don't think
> it's worth it.

Yep, agreed on all of this. :)

-Peff
