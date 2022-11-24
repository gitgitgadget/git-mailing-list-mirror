Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17230C433FE
	for <git@archiver.kernel.org>; Thu, 24 Nov 2022 00:57:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbiKXA5D (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Nov 2022 19:57:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbiKXA4y (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Nov 2022 19:56:54 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E9FA12D19
        for <git@vger.kernel.org>; Wed, 23 Nov 2022 16:56:53 -0800 (PST)
Received: (qmail 24280 invoked by uid 109); 24 Nov 2022 00:56:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 24 Nov 2022 00:56:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21404 invoked by uid 111); 24 Nov 2022 00:56:53 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 23 Nov 2022 19:56:53 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 23 Nov 2022 19:56:51 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2] config: introduce an Operating System-specific
 `includeIf` condition
Message-ID: <Y37BU6UA4plxNJCf@coredump.intra.peff.net>
References: <pull.1429.git.1669037992587.gitgitgadget@gmail.com>
 <pull.1429.v2.git.1669058388327.gitgitgadget@gmail.com>
 <Y3wKe7aO7I7bpmLm@coredump.intra.peff.net>
 <Y34KBTx+gQB13GRv@danh.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y34KBTx+gQB13GRv@danh.dev>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 23, 2022 at 06:54:45PM +0700, Đoàn Trần Công Danh wrote:

> > This seems like a reasonable thing to have in general, but I wonder if
> > you have an example of how people use this. Mostly I am wondering:
> > 
> >   - is it sometimes a misuse, where users _think_ that the OS is
> >     correlated with some feature of Git.  And they would be better off
> >     with some flag like "does the current platform support fsmonitor".
> 
> A possible use-case is setting credential.helper based on OS, let's say
> libsecret on Linux, and osxkeychain on macOS. Of course, users can
> have their own helper on specific OS.

Thanks, that's a very nice concrete example. I agree that's a pretty
reasonable use of this feature, given the lack of other selection
mechanisms. I do wonder if folks might run into annoyances when they
want to use libsecret on Linux _and_ FreeBSD or similar. But this
feature is definitely better than the status quo, and is not very much
code to implement or support.

-Peff
