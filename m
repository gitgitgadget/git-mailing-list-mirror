Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1809C4332F
	for <git@archiver.kernel.org>; Mon, 12 Dec 2022 20:58:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233250AbiLLU6l (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Dec 2022 15:58:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231752AbiLLU6j (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Dec 2022 15:58:39 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F4DB17059
        for <git@vger.kernel.org>; Mon, 12 Dec 2022 12:58:37 -0800 (PST)
Received: (qmail 6444 invoked by uid 109); 12 Dec 2022 20:58:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 12 Dec 2022 20:58:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29622 invoked by uid 111); 12 Dec 2022 20:57:22 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 12 Dec 2022 15:57:22 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 12 Dec 2022 15:57:21 -0500
From:   Jeff King <peff@peff.net>
To:     "Joshua J. Kugler" <joshua@azariah.com>
Cc:     git@vger.kernel.org
Subject: Re: includeIf appears to not be working
Message-ID: <Y5eVsb8rIH9TFgIj@coredump.intra.peff.net>
References: <8316344.DvuYhMxLoT@hosanna>
 <Y5eVTrK2CO0h5BPl@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y5eVTrK2CO0h5BPl@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 12, 2022 at 03:55:42PM -0500, Jeff King wrote:

> > Is there a debug command which can show if the gitdir is/isn't
> > matching like I thought it should?  What other command output could
> > help debug this?
> 
> No, there's no debug/tracing code for this feature. You'd have to run it
> under gdb (break on the include_by_gitdir function).

Oh, one other command you could try:

  git rev-parse --absolute-git-dir

while in the repository in question. I think that would do the same
normalization of the path (including resolving symlinks). So that would
tell you what Git should be matching against.

-Peff
