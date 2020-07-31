Return-Path: <SRS0=dkLL=BK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBB16C433DF
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 18:02:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D89CF2177B
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 18:02:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733194AbgGaSCh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jul 2020 14:02:37 -0400
Received: from cloud.peff.net ([104.130.231.41]:43948 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729753AbgGaSCg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jul 2020 14:02:36 -0400
Received: (qmail 23449 invoked by uid 109); 31 Jul 2020 18:02:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 31 Jul 2020 18:02:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28968 invoked by uid 111); 31 Jul 2020 18:02:35 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 31 Jul 2020 14:02:35 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 31 Jul 2020 14:02:35 -0400
From:   Jeff King <peff@peff.net>
To:     "Son Luong Ngoc via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Son Luong Ngoc <sluongng@gmail.com>
Subject: Re: [PATCH] commit-graph: add verify changed paths option
Message-ID: <20200731180235.GA846620@coredump.intra.peff.net>
References: <pull.687.git.1596181765336.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.687.git.1596181765336.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 31, 2020 at 07:49:25AM +0000, Son Luong Ngoc via GitGitGadget wrote:

> From: Son Luong Ngoc <sluongng@gmail.com>
> 
> Add '--has-changed-paths' option to 'git commit-graph verify' subcommand
> to validate whether the commit-graph was written with '--changed-paths'
> option.

Is a single boolean flag sufficient? If you have incrementals, you might
have some slices with this chunk and some without. What should the
boolean be in that case?

I thought we had some way of reporting the number of commits covered by
filters, but I can't seem to find it.

Our "test-tool read-graph" can report on whether there's a bloom filter
chunk, but I think it also doesn't distinguish between different slices
(and anyway, it wouldn't be suitable for tools that don't rely on an
actual built git.git directory).

-Peff
