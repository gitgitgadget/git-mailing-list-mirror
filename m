Return-Path: <SRS0=Te6D=5Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FBADC2BA2B
	for <git@archiver.kernel.org>; Thu,  9 Apr 2020 13:47:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F4262083E
	for <git@archiver.kernel.org>; Thu,  9 Apr 2020 13:47:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbgDINrZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Apr 2020 09:47:25 -0400
Received: from cloud.peff.net ([104.130.231.41]:37980 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726621AbgDINrY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Apr 2020 09:47:24 -0400
Received: (qmail 19009 invoked by uid 109); 9 Apr 2020 13:47:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 09 Apr 2020 13:47:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18243 invoked by uid 111); 9 Apr 2020 13:57:54 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 09 Apr 2020 09:57:54 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 9 Apr 2020 09:47:24 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>,
        Philip Oakley <philipoakley@iee.email>
Subject: Re: [PATCH] bloom: ignore renames when computing changed paths
Message-ID: <20200409134724.GA3494212@coredump.intra.peff.net>
References: <pull.601.git.1586363907252.gitgitgadget@gmail.com>
 <20200408223111.GC3468797@coredump.intra.peff.net>
 <72fa2e30-b841-9600-ae2c-21a269817f1c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <72fa2e30-b841-9600-ae2c-21a269817f1c@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 09, 2020 at 07:56:43AM -0400, Derrick Stolee wrote:

> > So we really aren't detecting renames in the first place! And indeed,
> > checking diffopt.detect_rename shows that it is unset. So I'm curious if
> > there is a case where that would not be true. I _think_ it would only be
> > true in a program which ran init_diff_ui_defaults(), but never in
> > git-commit-graph.
> 
> So our issue was really that the partial clone prefetch logic was just
> overly aggressive.

Right, but I'm not sure how this patch could ever have helped, since
it's just setting a variable to the value it _should_ have already had.

Or do you just mean that the issue would have gone away with Jonathan's
patch to make the prefetching less aggressive?

-Peff
