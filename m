Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7760EB64D9
	for <git@archiver.kernel.org>; Thu, 29 Jun 2023 19:12:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232566AbjF2TMt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Jun 2023 15:12:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232680AbjF2TMJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Jun 2023 15:12:09 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1295A3AB3
        for <git@vger.kernel.org>; Thu, 29 Jun 2023 12:04:22 -0700 (PDT)
Received: (qmail 11402 invoked by uid 109); 29 Jun 2023 19:04:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 29 Jun 2023 19:04:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11419 invoked by uid 111); 29 Jun 2023 19:04:23 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 29 Jun 2023 15:04:23 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 29 Jun 2023 15:04:21 -0400
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine <ericsunshine@charter.net>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] fsck: avoid misleading variable name
Message-ID: <20230629190421.GA592842@coredump.intra.peff.net>
References: <20230629181333.87465-1-ericsunshine@charter.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230629181333.87465-1-ericsunshine@charter.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 29, 2023 at 02:13:33PM -0400, Eric Sunshine wrote:

> From: Eric Sunshine <sunshine@sunshineco.com>
> 
> When reporting a problem, `git fsck` emits a message such as:
> 
>     missing blob 1234abcd (:file)
> 
> However, this can be ambiguous when the problem is detected in the index
> of a worktree other than the one in which `git fsck` was invoked. To
> address this shortcoming, 592ec63b38 (fsck: mention file path for index
> errors, 2023-02-24) enhanced the output to mention the path of the index
> when the problem is detected in some other worktree:
> 
>     missing blob 1234abcd (.git/worktrees/wt/index:file)
> 
> Unfortunately, the variable in fsck_index() which controls whether the
> index path should be shown is misleadingly named "is_main_index" which
> can be misunderstood as referring to the main worktree (i.e. the one
> housing the .git/ repository) rather than to the current worktree (i.e.
> the one in which `git fsck` was invoked). Avoid such potential confusion
> by choosing a name more reflective of its actual purpose.

This looks good to me. Thanks for following up!

-Peff
