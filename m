Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A3FCD1F453
	for <e@80x24.org>; Tue, 29 Jan 2019 16:49:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbfA2Qtu (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Jan 2019 11:49:50 -0500
Received: from cloud.peff.net ([104.130.231.41]:53426 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725794AbfA2Qtu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jan 2019 11:49:50 -0500
Received: (qmail 3390 invoked by uid 109); 29 Jan 2019 16:49:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 29 Jan 2019 16:49:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8484 invoked by uid 111); 29 Jan 2019 16:49:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 29 Jan 2019 11:49:56 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Jan 2019 11:49:48 -0500
Date:   Tue, 29 Jan 2019 11:49:48 -0500
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 1/1] Makefile: add prove and coverage-prove targets
Message-ID: <20190129164947.GB6991@sigill.intra.peff.net>
References: <pull.114.git.gitgitgadget@gmail.com>
 <294187c6968eff952e78bcea808c66fbedbf1f90.1548773766.git.gitgitgadget@gmail.com>
 <20190129155827.GC13764@szeder.dev>
 <a5ca8985-f877-b250-d186-32bef40092f5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a5ca8985-f877-b250-d186-32bef40092f5@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 29, 2019 at 11:37:34AM -0500, Derrick Stolee wrote:

> > I'm afraid that this issue would badly affect 'coverage-prove' as well
> > (I didn't try).  Or if doesn't (anymore?), then that should be
> > mentioned in the commit message, and then perhaps it's time to remove
> > that '-j1' from the 'coverage-test' target as well.
> 
> I'll fix this by forcing an update to GIT_PROVE_OPTS. It does limit our
> ability to use GIT_PROVE_OPTS as a pass-through, but at least this new
> target will have that assumption built in.

I think doing:

  make GIT_PROVE_OPTS="$(GIT_PROVE_OPTS) -j1"

should be sufficient to pass through most of the options but override
-j, since prove does the usual left-to-right "last one wins" behavior
for its options.

-Peff
