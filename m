Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 634B8C433F5
	for <git@archiver.kernel.org>; Mon, 29 Nov 2021 18:47:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379855AbhK2SuU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Nov 2021 13:50:20 -0500
Received: from cloud.peff.net ([104.130.231.41]:39416 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1380624AbhK2SsT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Nov 2021 13:48:19 -0500
Received: (qmail 5217 invoked by uid 109); 29 Nov 2021 18:45:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 29 Nov 2021 18:45:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4544 invoked by uid 111); 29 Nov 2021 18:45:00 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 29 Nov 2021 13:45:00 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 29 Nov 2021 13:44:59 -0500
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, avarab@gmail.com, gitster@pobox.com,
        me@ttaylorr.com, Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 0/2] Set GIT_TRACE2_EVENT_NESTING in test-lib.sh
Message-ID: <YaUfq88UwWVcb7KG@coredump.intra.peff.net>
References: <pull.1085.git.1638193666.gitgitgadget@gmail.com>
 <YaUegEGxfAf72O9Z@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YaUegEGxfAf72O9Z@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 29, 2021 at 01:40:00PM -0500, Jeff King wrote:

> On Mon, Nov 29, 2021 at 01:47:44PM +0000, Derrick Stolee via GitGitGadget wrote:
> 
> > As reported by Ævar [1] and diagnosed by Peff in a reply, the default
> > GIT_TRACE2_EVENT_NESTING is set so low that tests that look for trace2
> > events can start failing due to an added trace2 region. This can even be
> > subtle, including the fact that the progress API adds trace2 regions when in
> > use (which can depend on the verbose output of a test script).
> 
> I think this is a good change for fixing the immediate problem of the
> test suite failing.
> 
> But I have to wonder if this is masking a problem that real users will
> see. Aren't we silently discarding trace2 output that could be useful to
> somebody debugging or trying to get performance metrics?
> 
> I.e., should we be bumping the internal nesting max of 2 to something
> higher? If that would that cause problems with existing metrics, should
> we be designing new metrics to avoid nesting?

One thing I should have added to the first paragraph: the patches
themselves look fine and I'm OK with this as a band-aid in the short
term.

-Peff
