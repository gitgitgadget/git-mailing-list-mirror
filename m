Return-Path: <SRS0=QBG1=2L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93AADC2D0C3
	for <git@archiver.kernel.org>; Sat, 21 Dec 2019 19:23:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F9B2206CB
	for <git@archiver.kernel.org>; Sat, 21 Dec 2019 19:23:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbfLUTXu (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Dec 2019 14:23:50 -0500
Received: from cloud.peff.net ([104.130.231.41]:51830 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726107AbfLUTXu (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Dec 2019 14:23:50 -0500
Received: (qmail 8807 invoked by uid 109); 21 Dec 2019 19:23:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 21 Dec 2019 19:23:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21436 invoked by uid 111); 21 Dec 2019 19:28:36 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 21 Dec 2019 14:28:36 -0500
Authentication-Results: peff.net; auth=none
Date:   Sat, 21 Dec 2019 14:23:48 -0500
From:   Jeff King <peff@peff.net>
To:     Beat Bolli <dev+git@drbeat.li>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] contrib/git-jump: add mode commit
Message-ID: <20191221192348.GA3339249@coredump.intra.peff.net>
References: <20191221113846.169538-1-dev+git@drbeat.li>
 <20191221113846.169538-2-dev+git@drbeat.li>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191221113846.169538-2-dev+git@drbeat.li>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Dec 21, 2019 at 12:38:46PM +0100, Beat Bolli wrote:

> After committing, I often want to return to the place of the latest
> change to continue my work. Add the new mode "commit" which does exactly
> this.

That's one of my primary uses for git-jump, too. But you can already do
that by jumping to the diff of HEAD^. Which has the additional advantage
that it's a diff against the working tree. So if you did a partial
commit, the diff will include any leftover changes.

So I'm not opposed to this patch per se, given that it's not very many
lines. But I'm not sure I see much advantage over "git jump diff HEAD^".
It's slightly less typing, but I already alias "git jump diff" since
it's so long.

> Optional arguments are given to the "git show" call. So it's possible to
> jump to changes of other commits than HEAD.

This can also be done with "git jump diff $commit^ $commit". However,
I've found that jumping based on older diffs is mostly useless, because
the line numbers at $commit and those in the working tree don't always
match up (and inherently you're always jumping in the working tree
copy).

-Peff
