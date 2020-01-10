Return-Path: <SRS0=BdMw=27=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F6C8C33CA2
	for <git@archiver.kernel.org>; Fri, 10 Jan 2020 10:37:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FD062072E
	for <git@archiver.kernel.org>; Fri, 10 Jan 2020 10:37:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727452AbgAJKhb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Jan 2020 05:37:31 -0500
Received: from cloud.peff.net ([104.130.231.41]:33462 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727366AbgAJKhb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Jan 2020 05:37:31 -0500
Received: (qmail 4197 invoked by uid 109); 10 Jan 2020 10:37:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 10 Jan 2020 10:37:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24027 invoked by uid 111); 10 Jan 2020 10:43:20 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 10 Jan 2020 05:43:20 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 10 Jan 2020 05:37:29 -0500
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, johannes.schindelin@gmx.net,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH] unpack-trees: correctly compute result count
Message-ID: <20200110103729.GA470836@coredump.intra.peff.net>
References: <pull.520.git.1578621570180.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.520.git.1578621570180.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 10, 2020 at 01:59:30AM +0000, Derrick Stolee via GitGitGadget wrote:

>     Here is a very small fix to the cone-mode pattern-matching in
>     unpack-trees.c. Johannes found this while running a Coverity scan for
>     other issues. He alerted me to the problem and I could immediately see 
>     my error here. In creating this patch, most of my time was spent asking
>     "how did this work before?" and "why didn't this hurt performance?"
>     Hopefully my commit message explains this thoroughly enough.

Yes, it makes perfect sense (and as soon as I saw the explanation of the
problem, my immediate response was also "wait, how did this even work").

And the patch itself looks good.

>     As for making it into the release, I don't know. The change is small, it
>     has a very limited scope, but this flaw is also not really hurting
>     anything in a major way.

I could go either way.

This counts as something small and obvious enough that I'd consider
slipping it in at the last minute if it were fixing a bad bug. But given
how minor the bug is, being conservative makes sense to me, if only
because it's good to exercise our release discipline muscles. :)

-Peff
