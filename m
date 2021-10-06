Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2721FC433F5
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 19:28:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0759F610A1
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 19:28:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239239AbhJFTa3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Oct 2021 15:30:29 -0400
Received: from cloud.peff.net ([104.130.231.41]:34406 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229992AbhJFTa3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Oct 2021 15:30:29 -0400
Received: (qmail 26825 invoked by uid 109); 6 Oct 2021 19:28:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 06 Oct 2021 19:28:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 431 invoked by uid 111); 6 Oct 2021 19:28:35 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 06 Oct 2021 15:28:35 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 6 Oct 2021 15:28:35 -0400
From:   Jeff King <peff@peff.net>
To:     Alexander Mills <alexander.d.mills@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: add/init all git submodules that are referenced in .gitmodules
Message-ID: <YV3444Bvvfzp37Di@coredump.intra.peff.net>
References: <CA+KyZp75fjj9T0LjkpEjLMVf5KNguNZ1Ycxbb26ZnCGrK5zLAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+KyZp75fjj9T0LjkpEjLMVf5KNguNZ1Ycxbb26ZnCGrK5zLAQ@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 05, 2021 at 04:52:00PM -0700, Alexander Mills wrote:

> I am looking for this feature:
> 
> https://stackoverflow.com/a/69458406/1223975
> 
> it is really confusing as to why it doesn't exist

I'm not sure I understand what is being asked for.

If you just want to initialize and populate all of the modules in
.gitmodules (which is what I thought your subject line was asking for),
then:

  git submodule update --init

will do that (though of course if you are cloning anyway, you can just
say "--recurse-submodules).

But reading the original SO question, it is about finding repositories
in the current directory that _aren't_ submodules, and then adding them.
But those ones wouldn't be referenced in .gitmodules.

For that problem, no, I don't think there's an easy command, and you
have to dig for them (though "git ls-files -o --exclude-standard" is
perhaps a good way to locate them). But it's also not something I'd
expect to be a very common operation, which is why there's not an
existing command to do it.

-Peff
