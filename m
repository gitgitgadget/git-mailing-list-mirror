Return-Path: <SRS0=1eW7=DV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6DBDC433E7
	for <git@archiver.kernel.org>; Wed, 14 Oct 2020 19:49:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52597214D8
	for <git@archiver.kernel.org>; Wed, 14 Oct 2020 19:49:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728185AbgJNTt2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Oct 2020 15:49:28 -0400
Received: from cloud.peff.net ([104.130.231.41]:60202 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728146AbgJNTt1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Oct 2020 15:49:27 -0400
Received: (qmail 18489 invoked by uid 109); 14 Oct 2020 19:49:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 14 Oct 2020 19:49:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20320 invoked by uid 111); 14 Oct 2020 19:49:27 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 14 Oct 2020 15:49:26 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 14 Oct 2020 15:49:26 -0400
From:   Jeff King <peff@peff.net>
To:     Elijah Newren <newren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2 1/3] test-lib: allow selecting tests by
 substring/regex with --run
Message-ID: <20201014194926.GB365553@coredump.intra.peff.net>
References: <pull.878.git.git.1602545164.gitgitgadget@gmail.com>
 <pull.878.v2.git.git.1602616786.gitgitgadget@gmail.com>
 <41e2528e83ba7087c9d21f0b15efed416f1512f8.1602616786.git.gitgitgadget@gmail.com>
 <20201014170413.GB21687@coredump.intra.peff.net>
 <CAPc5daVa4j5mDvTzCFCX2bLr1qVFLO=P=nSakT+mDG1kqeXa+g@mail.gmail.com>
 <20201014180707.GB24279@coredump.intra.peff.net>
 <CAPc5daU_aw=yWPKHG1XGt4X5A1AkEXeLfCmHqqVfZ+FzBD7nxg@mail.gmail.com>
 <CABPp-BE0_u=TAJKUGUTLrZbg8vk2MFYmfscT_+MgYwAS2rV8Aw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BE0_u=TAJKUGUTLrZbg8vk2MFYmfscT_+MgYwAS2rV8Aw@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 14, 2020 at 12:41:00PM -0700, Elijah Newren wrote:

> > I use "?" for the same purpose for globs. For things that are casual,
> > I find that
> > it tends to make the end-user (read: my) experience simpler to use globs than
> > to use regexp, largely for your ".*" vs "*" reasons.
> 
> Oh, I thought you were arguing for globs over regexes here just due to
> performance reasons.  Most of my uses of this feature so far are just
> substring matches, so either globs or regexes would be fine for what
> I've done so far.  Mostly, I was leaning towards regexes because I
> figured they were a bit more flexible and perhaps there might arise a
> usecase where that would be handy (plus Peff seemed to like them).
> But if you find the normal usecase easier with globs, maybe I should
> let you and Peff argue it out and then I'll resubmit with the
> preferred solution?

Thinking on it more, globs are probably a more natural fit here.
Especially if we do eventually allow selection of scripts by name, too
(e.g., for GIT_SKIP_TESTS), matching those filenames with a glob would
match what happens on the command-line.

-Peff
