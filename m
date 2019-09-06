Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A23B51F461
	for <e@80x24.org>; Fri,  6 Sep 2019 19:16:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389416AbfIFTQX (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Sep 2019 15:16:23 -0400
Received: from cloud.peff.net ([104.130.231.41]:42420 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727768AbfIFTQX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Sep 2019 15:16:23 -0400
Received: (qmail 22573 invoked by uid 109); 6 Sep 2019 19:16:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 06 Sep 2019 19:16:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6649 invoked by uid 111); 6 Sep 2019 19:18:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 06 Sep 2019 15:18:09 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 6 Sep 2019 15:16:22 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, avarab@gmail.com, garimasigit@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 1/1] fetch: add fetch.writeCommitGraph config setting
Message-ID: <20190906191622.GA7096@sigill.intra.peff.net>
References: <pull.328.git.gitgitgadget@gmail.com>
 <49f877c85ca2be5bb76d9082ee4aa26e26111a14.1567477320.git.gitgitgadget@gmail.com>
 <20190904030829.GB28836@sigill.intra.peff.net>
 <xmqqa7bipjil.fsf@gitster-ct.c.googlers.com>
 <a697c4de-e269-c330-ece2-8ac7007e6c55@gmail.com>
 <20190906175628.GH23181@sigill.intra.peff.net>
 <xmqq1rwtnv03.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq1rwtnv03.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 06, 2019 at 11:24:12AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Sure, but wouldn't that similarly apply to fetching? What is it that
> > makes bursts of pushes more likely than bursts of fetches?
> 
> Because people tend to use a repository as a gathering point?  You
> may periodically fetch from and push to a repository, and you may
> even do so at the same interval, but simply because there are more
> "other" people than you alone as a single developer in the project,
> your fetch tends to grab work from more people than yoru push that
> publish your work alone?

I suppose so. But I think the "stock git without any other job
infrastructure" case would still benefit. How do we know when the burst
is done? We'd effectively be relying on auto-gc to do that, but "enough
packs to merit gc" and "burst is done, now is a good time to update the
commit graph" are two different metrics.

-Peff
