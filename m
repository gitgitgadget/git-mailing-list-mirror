Return-Path: <SRS0=1eW7=DV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAF44C433DF
	for <git@archiver.kernel.org>; Wed, 14 Oct 2020 16:53:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69723221EB
	for <git@archiver.kernel.org>; Wed, 14 Oct 2020 16:53:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389171AbgJNQxa (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Oct 2020 12:53:30 -0400
Received: from cloud.peff.net ([104.130.231.41]:59890 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731323AbgJNQxa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Oct 2020 12:53:30 -0400
Received: (qmail 17963 invoked by uid 109); 14 Oct 2020 16:53:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 14 Oct 2020 16:53:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18644 invoked by uid 111); 14 Oct 2020 16:53:29 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 14 Oct 2020 12:53:29 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 14 Oct 2020 12:53:29 -0400
From:   Jeff King <peff@peff.net>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 3/3] test-lib: reduce verbosity of skipped tests
Message-ID: <20201014165329.GA21687@coredump.intra.peff.net>
References: <pull.878.git.git.1602545164.gitgitgadget@gmail.com>
 <pull.878.v2.git.git.1602616786.gitgitgadget@gmail.com>
 <85a4ca164a9f665016d4aad0f29cbef6f62f36b0.1602616786.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <85a4ca164a9f665016d4aad0f29cbef6f62f36b0.1602616786.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 13, 2020 at 07:19:46PM +0000, Elijah Newren via GitGitGadget wrote:

> From: Elijah Newren <newren@gmail.com>
> 
> When using the --run flag to run just two or three tests from a test
> file which contains several dozen tests, having every skipped test print
> out dozens of lines of output for the test code for that skipped test
> adds up to hundreds or thousands of lines of irrelevant output that make
> it very hard to fish out the relevant results you were looking for.
> Simplify the output for skipped tests down to just showing the one-line
> descriptions.

This last sentence is inaccurate in this version, isn't it?

Other than that, I think this is a good change (I admit I never noticed
the irrelevant output because it is only shown with "-v", and that is
already full of irrelevant bits. But I have trouble imagining how it
would be useful).

Earlier discussion mentioned shortening the "ok 2 # skip" line, but I
think removing this fd-3 version is the only sane direction. The other
one gets parsed by TAP tools like prove, and may be shown. E.g., "prove
--directive t0003-attributes.sh" shows the description of the skipped
tests (likewise, "-v" shows all tests but highlights the skipped ones).

-Peff
