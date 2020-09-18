Return-Path: <SRS0=7xvA=C3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E7DEC43464
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 17:20:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D68B206D9
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 17:20:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbgIRRUq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Sep 2020 13:20:46 -0400
Received: from cloud.peff.net ([104.130.231.41]:33426 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726126AbgIRRUq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Sep 2020 13:20:46 -0400
Received: (qmail 11057 invoked by uid 109); 18 Sep 2020 17:20:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 18 Sep 2020 17:20:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23019 invoked by uid 111); 18 Sep 2020 17:20:45 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 18 Sep 2020 13:20:45 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 18 Sep 2020 13:20:44 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Thomas Guyot-Sionnest <tguyot@gmail.com>, git@vger.kernel.org,
        dermoth@aei.ca
Subject: Re: [PATCH 2/2] Allow passing pipes for input pipes to diff
 --no-index
Message-ID: <20200918172044.GB183026@coredump.intra.peff.net>
References: <20200918113256.8699-1-tguyot@gmail.com>
 <20200918113256.8699-3-tguyot@gmail.com>
 <20200918143647.GB1606445@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200918143647.GB1606445@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 18, 2020 at 10:36:47AM -0400, Taylor Blau wrote:

>   - The cat pipe is unnecessary, and is also violating a rule that we
>     don't place 'git' on the right-hand side of a pipe (can you redirect
>     the file at the end instead?).

What's wrong with git on the right-hand side of a pipe?

On the left-hand side we lose its exit code, which is bad. But on the
right hand side, we are only losing the exit code of "cat", which we
don't care about.

(Though I agree that "cat" is pointless here; we could just be
redirecting from a file).

-Peff
