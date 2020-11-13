Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B57EC4742C
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 22:40:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF4BB22255
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 22:40:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="J3LA/JXt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbgKMWkP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Nov 2020 17:40:15 -0500
Received: from mout.gmx.net ([212.227.15.19]:40809 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725986AbgKMWkG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Nov 2020 17:40:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1605307198;
        bh=7al6844YrrUAxCAuKB/h2igGLBTw+y4xwTRxvz4c9I4=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=J3LA/JXt3dJeDiDWnbmYfANaanvMNYSCVlPBlWQRpKM6j+mLPTz/kJowq2CcWsqQ5
         lzacL9uro7RYAxhHGIur20GiR3XkcrNpGSJLBRQ2pxSK0sXspXULuUhCCVpTvFyF4N
         al7kMKJhXHkleinGBuDNlE3ElkDVsCtjrAFwdDnY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.26.25.62] ([213.196.212.205]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MBDjA-1kR5Ci1Sus-00Cjl6; Fri, 13
 Nov 2020 23:39:58 +0100
Date:   Fri, 13 Nov 2020 23:39:00 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] tests: support testing with an arbitrary default
 branch (sort of)
In-Reply-To: <nycvar.QRO.7.76.6.2011132229480.18437@tvgsbejvaqbjf.bet>
Message-ID: <nycvar.QRO.7.76.6.2011132324070.18437@tvgsbejvaqbjf.bet>
References: <nycvar.QRO.7.76.6.2011131519170.18437@tvgsbejvaqbjf.bet> <20201113161320.16458-1-avarab@gmail.com> <20201113191418.GA764688@coredump.intra.peff.net> <nycvar.QRO.7.76.6.2011132229480.18437@tvgsbejvaqbjf.bet>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:MnGHrxAxtaunQr0RFCedUKPYFjQ4s48tNl7iPz8531O6JwzEYvZ
 W/rdpLGyq6Zu5f63EXVhXetjhfRa4BK8vWXCcri6hJe26vNlOHUEFWnAq203ge2cZ63h5pz
 Zbu+Z5538r/IAjCvOPmfZyvDZu/vdTYKH+fA5mTqPNk8lI2ScT6KB0VNJJgy2sXLq7bkj6f
 FITsy3pr0CVqSGWwHwPjw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:FFS2vYv78g0=:zXOzjdLNNHtu+RjvfpoyTh
 qkXX8rG1yBVqo2M98nhlASXY3zpYwvq8uPpWLSfXALFOi8N8kGasyvU5VHvFzVh9ePhYlwIdn
 2LnQuqBwY4riULLpNhmVC1ipXEdfazpvQST6uupt+PK5yD3aM6cjnFggSZ15W2opI6cLbQq6O
 tiWta+xPbUqzTSI4cCVd4c07NgRJA5DaY8yuemNuXQRkiU93okU/ECP5lftG8IlgiFIGvDYKE
 lp0jc+9JKco37XyKtD56tCNrVXSYBtBisqw3KVYo6LtS6nQ822KQy5IGNfIbiEPc5ZerGbQ/Z
 jrCM2oOCyJH6XVztQcrhhMA7lMCH0bJ1Pj4qz0HkkE+78B6NZPma7VLsHmqZmV9kF4zR1tFuo
 km6ChS9xhme7DBPE4i3MHmyMKb881i9UsyU71orKTEt6AZfnd9t1nViJzCKsg/ksfAAgB4kB8
 OPlfTcAMB71iedQhAGwlDjYJMkoQtkiKf11AfauhBhCqoeemkodIFh69nUKTE/bolyDg4nYBx
 xLdyaov755Bkvw8z33nFqTCXAQhPxGRUBaseADWwrQu6XyXfRgaCFSO7EvoXnrmlLcsFct3c0
 7HYEDDgtshhKffqjor8lOlmmxvgxMBHYKdqd+PPnN2QxbaLXq88dA40ME0RIZ4Jr8ZuVux0cY
 8KRS+5je3zpjJUylCYsT4TDuS1yhbOtre8TeNzSjTjwbm1wykX/TUNvczNI3CvdEbpOxnAvGt
 7eX7BFid4XtOfZM4/zYb7nCPNfBbhYHIYvhUBRAVDwkwrPBXm4p8NOPZjh/vvufkHRk2NTAjd
 oKT/UC16/0mtlSO5V5ggGL36qm6vzKg1Hnfxd131rA1THwz4TjUuVVQsixzVtnqPgoI7QFjYS
 kJK292Vr2IsNaLvvB16CG3JEq97s0n4TIMR4kjCSU=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Fri, 13 Nov 2020, Johannes Schindelin wrote:

> On Fri, 13 Nov 2020, Jeff King wrote:
>
> > I'm on the fence whether there should be a deprecation period or major
> > version bump for the final patch, but making the tests flexible enough
> > to handle the before and after state seems like it can be done uncoupl=
ed
> > from the actual default-flip.
>
> [...] It's not like the median developer is creating new repositories on
> a regular basis, and if they do, chances are that they go with whatever
> branch name happens to be the initial one.
>
> What is much more common is that developers clone existing projects. And
> guess what, many of those projects already use a different default branc=
h
> name. And developers seem to accept that and just go on with their lives=
.

After sending off this mail, I felt a bit bad about not backing this up
with data.

Whatever telemetry I would be able to pull would not be representative,
and I would not be at liberty to share it anyway. So I asked Alex Mullans
of GitHub (who is in charge of the default branch name switch to `main`
there) whether he has any data I could share publicly and he said: "Across
GitHub, 1/4 of daily pushes (and growing) go to `main`."

Seeing as the branch name to be used in newly-created repositories on
GitHub changed only very recently (October 1st, i.e. some 6 weeks ago), I
highly suspect that this number means that _a lot_ of existing projects
have changed their primary branch name to `main`, and seem to be quite
happy with it.

All this is to say that I consider it unnecessary to have a long
deprecation period or major version bump for this patch series, based on
available public data. The name `main` is already in wide-spread use (and
growing) as primary branch name of Git projects.

Ciao,
Dscho
