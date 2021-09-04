Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37423C433EF
	for <git@archiver.kernel.org>; Sat,  4 Sep 2021 10:25:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10470608FB
	for <git@archiver.kernel.org>; Sat,  4 Sep 2021 10:25:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235090AbhIDK0A (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Sep 2021 06:26:00 -0400
Received: from cloud.peff.net ([104.130.231.41]:39288 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234482AbhIDK0A (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Sep 2021 06:26:00 -0400
Received: (qmail 32172 invoked by uid 109); 4 Sep 2021 10:24:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 04 Sep 2021 10:24:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10161 invoked by uid 111); 4 Sep 2021 10:25:00 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 04 Sep 2021 06:25:00 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 4 Sep 2021 06:24:57 -0400
From:   Jeff King <peff@peff.net>
To:     Fedor Biryukov <fedor.birjukov@gmail.com>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>, git@vger.kernel.org
Subject: Re: Aborting 'rebase main feat' removes unversioned files
Message-ID: <YTNJeY2U6tcOQiCh@coredump.intra.peff.net>
References: <CAG2t84Uaw-Kdp+EXU8CY1QYfykFQj-hGLJnTSH8MYO8Vi_yqgA@mail.gmail.com>
 <C357A648-8B13-45C3-9388-C0C7F7D40DAE@gmail.com>
 <dbe7d88d-4174-e080-03df-e35d0ac6004f@gmail.com>
 <YTNA6Qo6Yj5o9NmQ@coredump.intra.peff.net>
 <CAG2t84Xe2XwdwdAK42bRrwAeNaB3-A+WhgSsJGOoW9-rG1S9Xg@mail.gmail.com>
 <CAG2t84WY35RvieOc5mhRJExwHdXuaiBafB4S4APkrnGiBM_t_g@mail.gmail.com>
 <CAG2t84Ud9AFfHhCxyKWvcqVUKTrkRufdMsQL93cdUUvVAyNpzA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAG2t84Ud9AFfHhCxyKWvcqVUKTrkRufdMsQL93cdUUvVAyNpzA@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 04, 2021 at 12:03:49PM +0200, Fedor Biryukov wrote:

> Here's the output from Windows, where everything works as expected.
> [...]
> PS> git rebase main feat
> error: The following untracked working tree files would be overwritten
> by checkout:
>         readme.txt
> Please move or remove them before you switch branches.
> Aborting
> error: could not detach HEAD

Interesting that it behaves differently than the mac and linux versions.
There are some changes between Git for Windows and regular upstream Git,
but looking over the diff between the v2.33.0 releases, I don't see
anything that might cause this discrepancy.

If the problem used to occur on v2.31 and now doesn't, it might be
interesting to bisect it.

-Peff
