Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A33AE1F97E
	for <e@80x24.org>; Thu, 11 Oct 2018 14:06:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728524AbeJKVdd (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Oct 2018 17:33:33 -0400
Received: from cloud.peff.net ([104.130.231.41]:37214 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728517AbeJKVdc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Oct 2018 17:33:32 -0400
Received: (qmail 19444 invoked by uid 109); 11 Oct 2018 14:06:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 11 Oct 2018 14:06:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29919 invoked by uid 111); 11 Oct 2018 14:05:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 11 Oct 2018 10:05:21 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 11 Oct 2018 10:06:10 -0400
Date:   Thu, 11 Oct 2018 10:06:10 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v3 4/7] revision.c: begin refactoring --topo-order logic
Message-ID: <20181011140610.GD27312@sigill.intra.peff.net>
References: <pull.25.v2.git.gitgitgadget@gmail.com>
 <pull.25.v3.git.gitgitgadget@gmail.com>
 <fd1a0ab7cdaa06fd99f86fec51b483238f588296.1537551564.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fd1a0ab7cdaa06fd99f86fec51b483238f588296.1537551564.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 21, 2018 at 10:39:32AM -0700, Derrick Stolee via GitGitGadget wrote:

> [..]
> When setting revs->limited only because revs->topo_order is true,
> only do so if generation numbers are not available. There is no
> reason to use the new logic as it will behave similarly when all
> generation numbers are INFINITY or ZERO.
> 
> In prepare_revision_walk(), if we have revs->topo_order but not
> revs->limited, then we trigger the new logic. It breaks the logic
> into three pieces, to fit with the existing framework:

Nicely explained. Your abstracted init/next/expand API seems sane, but
of course the real test will be reading the later patches that make use
of it. :)

The patch matches my understanding of your explanation.

-Peff
