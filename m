Return-Path: <SRS0=dkLL=BK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC24DC433E0
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 19:14:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7CB121744
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 19:14:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbgGaTOu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jul 2020 15:14:50 -0400
Received: from cloud.peff.net ([104.130.231.41]:44094 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726726AbgGaTOt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jul 2020 15:14:49 -0400
Received: (qmail 24052 invoked by uid 109); 31 Jul 2020 19:14:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 31 Jul 2020 19:14:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29921 invoked by uid 111); 31 Jul 2020 19:14:48 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 31 Jul 2020 15:14:48 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 31 Jul 2020 15:14:48 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Son Luong Ngoc via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Son Luong Ngoc <sluongng@gmail.com>
Subject: Re: [PATCH] commit-graph: add verify changed paths option
Message-ID: <20200731191448.GA848793@coredump.intra.peff.net>
References: <pull.687.git.1596181765336.gitgitgadget@gmail.com>
 <20200731180235.GA846620@coredump.intra.peff.net>
 <20200731180956.GA60133@syl.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200731180956.GA60133@syl.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 31, 2020 at 02:09:56PM -0400, Taylor Blau wrote:

> > Is a single boolean flag sufficient? If you have incrementals, you might
> > have some slices with this chunk and some without. What should the
> > boolean be in that case?
> 
> I think you'd really want to know which layers do and don't have
> filters. It might be even more interesting to have a tool like what 'git
> show-index' is to '*.idx' files, maybe something like 'git show-graph'
> or 'git show-commit-graph'. Its output would be one line per commit that
> shows:
> 
>   - what layer in the chain it's located at
>   - its graph_pos
>   - its generation number
>   - whether or not it has a Bloom filter
>   - ???
> 
> That would be a useful tool for debugging anyway, even outside of the
> test suite. It would be even better if we could replace the test-tool
> with it.

Yeah, that was exactly what I had in mind, except that I'd make it a
sub-command of "git commit-graph" ("show" or perhaps "dump").

-Peff
