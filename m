Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 461FEC433F5
	for <git@archiver.kernel.org>; Mon, 20 Dec 2021 13:50:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232237AbhLTNu6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Dec 2021 08:50:58 -0500
Received: from cloud.peff.net ([104.130.231.41]:55040 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230044AbhLTNu6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Dec 2021 08:50:58 -0500
Received: (qmail 10269 invoked by uid 109); 20 Dec 2021 13:50:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 20 Dec 2021 13:50:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2535 invoked by uid 111); 20 Dec 2021 13:50:57 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 20 Dec 2021 08:50:57 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 20 Dec 2021 08:50:56 -0500
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com, gitster@pobox.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 1/2] repack: respect kept objects with '--write-midx -b'
Message-ID: <YcCKQEpBbdgbAKrk@coredump.intra.peff.net>
References: <pull.1098.git.1639758526.gitgitgadget@gmail.com>
 <1ed91f6d255b76bdbdcccea7e1effcebbb263ced.1639758526.git.gitgitgadget@gmail.com>
 <YbzHtsl045XZbJGN@coredump.intra.peff.net>
 <d10662af-4ce9-6944-aa73-ef344f6bdf67@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d10662af-4ce9-6944-aa73-ef344f6bdf67@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 20, 2021 at 08:40:09AM -0500, Derrick Stolee wrote:

> > One could perhaps argue that the combined grep is less readable. If
> > that's a concern, I'd suggest wrapping it in a function like:
> > 
> >   # usage: check_trace2_arg <trace_file> <cmd> <arg>
> >   check_trace2_arg () {
> > 	grep "\"event\":\"start\".*\"$2\".*\"$3\"" "$1"
> >   }
> > 
> > All just suggestions, of course. I'd be happy enough to see the patch go
> > in as-is.
> 
> Thanks for the suggestions. I decided to adapt the 'test_subcommand'
> helper into a 'test_subcommand_inexact' helper. The existing helper
> requires the full argument list in exact order, but the new one only
> cares about the given arguments (in that relative order).

Heh, I should have looked to see if we had faced this problem before.
Extending that family of helpers is better still than my suggestion.

-Peff
