Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D497DC48BDF
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 11:27:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B114A61455
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 11:27:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbhFOL3c (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Jun 2021 07:29:32 -0400
Received: from mout.gmx.net ([212.227.15.18]:51823 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229951AbhFOL3b (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jun 2021 07:29:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1623756426;
        bh=lmMHJ7uARDTHE9QU0nVOpJMTfZ7+VFpwJjtyT8PBWt4=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=EcYVn7uoy8CAljvgoVFE3GH2jbE20c9FGlKpg8uUzs3Lr8U4pNOBiLTqwIAYqPEw+
         uvTl5iceC9UP5GZdoxZrTH2guGlvG0LBuwiIssYZRkQjhKdBqER/MMpX3K6+PYunki
         FA7dccdSwz4XXhbkrOBzS/9NoJm/ak0CI4S9hnbw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.24.14.142] ([89.1.214.113]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N5mGH-1lE7GL2ONP-017FfQ; Tue, 15
 Jun 2021 13:27:06 +0200
Date:   Tue, 15 Jun 2021 13:27:04 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Luke Shumaker <lukeshu@lukeshu.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Luke Shumaker <lukeshu@datawire.io>
Subject: Re: [PATCH 1/2] subtree: fix the GIT_EXEC_PATH sanity check to work
 on Windows
In-Reply-To: <YMiMaG2nYHYZKofJ@coredump.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.2106151324570.57@tvgsbejvaqbjf.bet>
References: <pull.978.git.1623316412.gitgitgadget@gmail.com> <a91ac6c18938116c4a74e19466da456b67376fa5.1623316412.git.gitgitgadget@gmail.com> <87bl8d6xoq.wl-lukeshu@lukeshu.com> <nycvar.QRO.7.76.6.2106111213050.57@tvgsbejvaqbjf.bet> <875yyk7c3j.wl-lukeshu@lukeshu.com>
 <nycvar.QRO.7.76.6.2106141330410.57@tvgsbejvaqbjf.bet> <xmqqtulzyhyh.fsf@gitster.g> <YMiHX6H/k1Z8C6Ws@coredump.intra.peff.net> <0c409e32-423b-a4bb-22b9-a43cd1c802f2@gmail.com> <YMiMaG2nYHYZKofJ@coredump.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:duKPSOtq2mcndURWthC8bUr1grgPWKVcaQqnRb1CbnRI2KilNwY
 BB62ucC4XjvnFRyWhMFeSDpeSh3GuKGTefV5VatnpGm12tGEWx3WdkEdgtRE0y7n8dLUDza
 G2yckTk3JW+mi4l/09WMMKaAzdi7jO/PivexvvMEju9WfEvWi0m7ywaMP9bzUhQVjXGwZ1X
 yaxrARF7aTZVFrZfrKW+g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:CU624D0vEqQ=:H5B3yF9jNiDBzj1v03i2b+
 Zy4Jd5fGx97sSLw+ews73DTIWiTKeKXEYcCaJhDFIQNuqbWICnmh9Ha8LW1OrMS7gwfTFzgR8
 /nwnAOnVozIFcRt8heEX9s2QlFm8wB+fW04owsPrv9WETSrFjjxFOrRNAKxSO0KaZcyaK/Qbj
 2MHXUZc3AL8AbaOwVyzuvlGX/3Q20RFjKC3aXVU2MMac7KjhRP2d0DRnOe0zVR8CH4mkYUGiR
 Sx3FcE7wGyy3rOGR8gSHdZZQY7/lGnVi8228GiCJR6kFxRhTZYHKmAwAIlsrqz4nVQ+64kVR6
 ZNVo6Uko3fp1A5vG3h9iFA0WN70tkvxwg7amwi4XxTcZujmYunsTeSHbTCWq1OB1Aw8SfMcNF
 6/j3X2FcdPNGjxmosnLcUTBL8WEXj0sbBErONjronpnihtKDx9cXQlIu7UiGenzw+ycdNTYh9
 KAcr+GvOFiQMJbiH4M18pDZgQ+jtkgjBQQl7LxLPfWsx/Kf2Qge+TYzm4nn2ENsKWDqhO3ba6
 yQQZP56imC09EbqAclX2BnYxC/cNG+TWd3Vq814G8FGWZk1HIeUIYqEQZCl5u7Z1ov5hQvpkQ
 GpGhXY1uRJoidVHFIHVw5Y7C9F03bkp0upXS7UE6qAOgZ7eqOH1rmZrl8hxXk9xKiGdmDULzE
 5v9MoKf+PFAPal94eFgGYZjpjpMP5w6uBxZNRr3i8gjnwrLsJdhsMU2o5ez/c0mmTKiYm8IBJ
 r9+LcgehjeQt9zK7mXA6/tZG00CPRjcph9Rx44bXTdl1HYQzdAo3GK4UXUxmZEk/PFnfTs412
 r6pdUcrO4OEyEZpjmERokRODHfVgK8JT1CoU4lILbTmm52ZJaJMEJfry3sqL9QteaR3sSj12P
 k6MkNeVSvsi+x3j+SCgM6EGt7730JDgGZOFGhCQus1qDse0N4rNb3QfLdeB38hzXKgF045QY5
 tApoYKYOG17SEt+IjEWoC6xQ8dFkUx8Bz/WoxVujsN3MxpLa5TFZmTkQRrzVAqHu0Z/a5uY4k
 LvW2jTDetgYkt0r7tQ5G7wtBjFo6FD1S8C5AuUHaHoieiF/vBN55cwzeh0H12pAYdIucjUt8Z
 GW3cY4NsL8zMsn6L2H6tLXp0PvLSIAwlRCNYLJKiv/b2kkwqqXUHnyTiw==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Tue, 15 Jun 2021, Jeff King wrote:

> On Tue, Jun 15, 2021 at 06:05:08PM +0700, Bagas Sanjaya wrote:
>
> > > But having seen the earlier part of the thread, it looks like "are w=
e on
> > > Windows" is predicated on "! type -p cygpath", which seems a bit loo=
se.
> > > I also think "-p" is a bash-ism, so we'd want to avoid it before
> > > determining whether we're on Windows to avoid a chicken-and-egg on o=
ther
> > > platforms.
> > >
> > > -Peff
> > >
> >
> > What is the POSIX equivalent then of?
>
> I don't think there is an equivalent for "-p". But regular "type" is
> probably sufficient for this use (the "-p" is just suppressing aliases
> and functions).
>
> It would be nice if there was a more robust test in general, though
> (after all, I could have something called "cygpath" on a non-Windows
> system). I don't know what options there are to get info from bash,
> though.
>
> (I'd also clarify that I haven't been carefully following this thread,
> so take any suggestion or comments from me with a grain of salt. I
> mostly jumped in because it looked like there was a communication
> confusion).

Please don't worry about `type` vs `type -p` here, as that is no longer
used in v2.

Please also don't worry about perceived brittleness of relying on `-ef`:
The only thing my patch now does is to _fall back_ after the
previously-already-existing test verifying that `$PATH` starts with
`$GIT_EXEC_PREFIX:`.

In the worst case, this will simply behave the same. In the best case
(which is the case on Windows), it will rely on Git for Windows' Bash to
_have_ support for `-ef` and no longer do the wrong thing.

Ciao,
Dscho
