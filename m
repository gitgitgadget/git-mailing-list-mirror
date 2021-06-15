Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D6DDC48BE5
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 11:18:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2606861455
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 11:18:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbhFOLUG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Jun 2021 07:20:06 -0400
Received: from cloud.peff.net ([104.130.231.41]:55954 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229659AbhFOLUG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jun 2021 07:20:06 -0400
Received: (qmail 7570 invoked by uid 109); 15 Jun 2021 11:18:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 15 Jun 2021 11:18:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13760 invoked by uid 111); 15 Jun 2021 11:18:00 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 15 Jun 2021 07:18:00 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 15 Jun 2021 07:18:00 -0400
From:   Jeff King <peff@peff.net>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Luke Shumaker <lukeshu@lukeshu.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Luke Shumaker <lukeshu@datawire.io>
Subject: Re: [PATCH 1/2] subtree: fix the GIT_EXEC_PATH sanity check to work
 on Windows
Message-ID: <YMiMaG2nYHYZKofJ@coredump.intra.peff.net>
References: <pull.978.git.1623316412.gitgitgadget@gmail.com>
 <a91ac6c18938116c4a74e19466da456b67376fa5.1623316412.git.gitgitgadget@gmail.com>
 <87bl8d6xoq.wl-lukeshu@lukeshu.com>
 <nycvar.QRO.7.76.6.2106111213050.57@tvgsbejvaqbjf.bet>
 <875yyk7c3j.wl-lukeshu@lukeshu.com>
 <nycvar.QRO.7.76.6.2106141330410.57@tvgsbejvaqbjf.bet>
 <xmqqtulzyhyh.fsf@gitster.g>
 <YMiHX6H/k1Z8C6Ws@coredump.intra.peff.net>
 <0c409e32-423b-a4bb-22b9-a43cd1c802f2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0c409e32-423b-a4bb-22b9-a43cd1c802f2@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 15, 2021 at 06:05:08PM +0700, Bagas Sanjaya wrote:

> Hi Jeff,
> 
> > But having seen the earlier part of the thread, it looks like "are we on
> > Windows" is predicated on "! type -p cygpath", which seems a bit loose.
> > I also think "-p" is a bash-ism, so we'd want to avoid it before
> > determining whether we're on Windows to avoid a chicken-and-egg on other
> > platforms.
> > 
> > -Peff
> > 
> 
> What is the POSIX equivalent then of?

I don't think there is an equivalent for "-p". But regular "type" is
probably sufficient for this use (the "-p" is just suppressing aliases
and functions).

It would be nice if there was a more robust test in general, though
(after all, I could have something called "cygpath" on a non-Windows
system). I don't know what options there are to get info from bash,
though.

(I'd also clarify that I haven't been carefully following this thread,
so take any suggestion or comments from me with a grain of salt. I
mostly jumped in because it looked like there was a communication
confusion).

-Peff
