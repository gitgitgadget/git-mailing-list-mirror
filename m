Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE0A6C433B4
	for <git@archiver.kernel.org>; Wed,  7 Apr 2021 20:00:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D3876105A
	for <git@archiver.kernel.org>; Wed,  7 Apr 2021 20:00:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355841AbhDGUBB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Apr 2021 16:01:01 -0400
Received: from cloud.peff.net ([104.130.231.41]:43676 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348996AbhDGUBA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Apr 2021 16:01:00 -0400
Received: (qmail 17596 invoked by uid 109); 7 Apr 2021 20:00:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 07 Apr 2021 20:00:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22435 invoked by uid 111); 7 Apr 2021 20:00:50 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 07 Apr 2021 16:00:50 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 7 Apr 2021 16:00:49 -0400
From:   Jeff King <peff@peff.net>
To:     jost.schulte@tutanota.com
Cc:     Git <git@vger.kernel.org>
Subject: Re: Shell completion for branch names
Message-ID: <YG4PccicS0eH9gKG@coredump.intra.peff.net>
References: <MXghkzC----2@tutanota.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <MXghkzC----2@tutanota.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 07, 2021 at 04:23:16PM +0200, jost.schulte@tutanota.com wrote:

> I have a question regarding git-completion. I'm using zsh and have
> added the function .git-completion.bash. That gives me some
> auto-completion for branch names.
> 
> What I'm looking for: I have a branch named
> "feature/issue-123-add-feature" for example. I'd like to type "git
> switch 123[tab]". Is there some function out there that provides this?

Generally completion is done left-to-right for a partial string. The
thing you are asking about is usually called "fuzzy" completion. You can
use that term to find some discussion and tools that may help (e.g.,
[1]). I don't use any myself, so I can't comment on the quality.

I'm also not sure if they can be used with custom completions like the
one Git provides. One of the things Git's completion code does is
turning those partial strings into a full set of options. In theory a
fuzzy completion system could just feed Git's completion code an empty
string to get all possibilities, and then do its own fuzzy match against
it. But again, I don't know if anybody has written the glue code to do
that kind of thing.

-Peff

[1] https://github.com/junegunn/fzf#fuzzy-completion-for-bash-and-zsh
