Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80E30C77B71
	for <git@archiver.kernel.org>; Tue, 18 Apr 2023 10:43:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbjDRKnh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Apr 2023 06:43:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbjDRKnf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2023 06:43:35 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECA662728
        for <git@vger.kernel.org>; Tue, 18 Apr 2023 03:43:32 -0700 (PDT)
Received: (qmail 5019 invoked by uid 109); 18 Apr 2023 10:43:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 18 Apr 2023 10:43:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 965 invoked by uid 111); 18 Apr 2023 10:43:31 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 18 Apr 2023 06:43:31 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 18 Apr 2023 06:43:31 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 05/10] t/t9300-fast-import.sh: prepare for `gc --cruft`
 by default
Message-ID: <20230418104331.GE508219@coredump.intra.peff.net>
References: <cover.1681764848.git.me@ttaylorr.com>
 <1b07eb83fe6ab9fcb65d5a4746dec50c0f2cbd9e.1681764848.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1b07eb83fe6ab9fcb65d5a4746dec50c0f2cbd9e.1681764848.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 17, 2023 at 04:54:27PM -0400, Taylor Blau wrote:

> In a similar fashion as the previous commit, adjust the fast-import
> tests to prepare for "git gc" generating a cruft pack by default.
> 
> This adjustment is slightly different, however. Instead of relying on us
> writing out the objects loose, and then calling `git prune` to remove
> them, t9300 needs to be prepared to drop objects that would be moved
> into cruft packs.
> 
> To do this, we can combine the `git gc` invocation with `git prune` into
> one `git gc --prune`, which handles pruning both loose objects, and
> objects that would otherwise be written to a cruft pack.

Good. This is more efficient anyway. It probably does not matter for our
tiny test repository, but it is always good for our tests to model the
best option when possible. :)

>  t/t9300-fast-import.sh | 13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)

The patch itself looks good to me.

-Peff
