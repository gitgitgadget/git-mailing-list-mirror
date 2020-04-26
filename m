Return-Path: <SRS0=OyOp=6K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 997CBC54FCB
	for <git@archiver.kernel.org>; Sun, 26 Apr 2020 16:59:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BA9A2071C
	for <git@archiver.kernel.org>; Sun, 26 Apr 2020 16:59:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="kJywYK3I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726163AbgDZQ7J (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Apr 2020 12:59:09 -0400
Received: from mout.gmx.net ([212.227.15.18]:55629 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726151AbgDZQ7I (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Apr 2020 12:59:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1587920345;
        bh=Cb9xMjGE2cKFk3mm7xOKYm0GKTQdOHHuABFSaP/VRDQ=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=kJywYK3IEywAvan1oVnwEf7Ayz8nIKlPKdpxIyyvI7gg9odelg7llXklB2ndag8Tf
         o2nds7b5tgZgxtk/cDCVuGa0iMSYwjIm1yDwy/nRVvJLgesILrjx1RH3/qqekqiLEk
         OhgiH1bJUxxRj0P+cnjNIMZ1om5IBYHwokcMd7z4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from MININT-QA14EDB.fritz.box ([213.196.212.120]) by mail.gmx.com
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MRCK6-1jnhFN0Lzw-00N9iK; Sun, 26 Apr 2020 18:59:05 +0200
Date:   Sun, 26 Apr 2020 18:59:04 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Carlo Arenas <carenas@gmail.com>
cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH] macos: do let the build find the gettext
 headers/libraries/msgfmt
In-Reply-To: <CAPUEspiici3-tTTe=AWcNWgS4CN8OiqtaE46dQGcNW5weFC8Aw@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2004261856500.18039@tvgsbejvaqbjf.bet>
References: <pull.616.git.1587628367528.gitgitgadget@gmail.com> <CAPig+cSDQe7YDke=fyfdeSZOimcR5jj3FFk=Q4iOk6uiHsT-Zw@mail.gmail.com> <CAPig+cSkr+2dExzETScru0N5_=JhjVR=QZKuY5CbhstwrUUk5w@mail.gmail.com> <nycvar.QRO.7.76.6.2004251452200.18039@tvgsbejvaqbjf.bet>
 <CAPUEspiici3-tTTe=AWcNWgS4CN8OiqtaE46dQGcNW5weFC8Aw@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Jl1MTDed/Bfi/LCVyaI/W7+t6qjmxABHSCWuke5wcaotdYBt61Z
 1vI2i8JarL595UDAvTlygBbcLmzsVsmFOkleGMDAvZ1ODhvz7Tev3hSTnxA0Chm60m+dNfc
 ZL3wrkrIvx7U066+1zs6xJNUMMTdXYRjluIGvPEtzHHzTcIOzrW4/e6sQ3kmDCCddPl+YAr
 XdAPlNhUk0B45vvBu1ecQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:poF1KdM7Yqs=:HSRxbCa+JB+Y01n96lqzeU
 B5TrDZPoWwBMvQ8eUPAyNpp84JTtedcbFab5XM2qM4dvYCm4JJB5f3c9MHPRBniLQI3EKD/+l
 5JZ9dLx0VtVbrftaOb6+00VXVFmxK3fzox0TTxwzLzZJbPevLaSQefm4AicR2BqADdMFkwlmb
 0j81lv2QlYd9iHN2V4gpdYfOmBr85RRl6uDBEFojV58B6W7/ZQkK88Zg9B1oUD4l+EXmB+mb/
 TZfuYW/+3IakvXIKaKhP1FxCD/IFrwc+djYvBGuyfQxZiI/42uNFlPSwqmla4mkE+4hVcyT/z
 S5TIAFO4SExJo22EF0XYtyrYyt3E2MX6Wo5KtX8ov/KlMA7S9A9SDSepMFUigFuwzQvgFrJxg
 6FSMhXo80qUeDxYPhJ8tsa7dk+Wjx/ZvM8G6fljQQGj5dpYXaufjsIoEJDx494X7cHuUluF3E
 YwDut587BUDCqgU4DwS+sOR51AxA2/CERrgZfqAUEBxw9KxQz9AJjzVQIdguKAv5GiyTz1Zey
 7ViKmUK5UAJC7HSbYsLewQW/RWrW+5BAVs3S1sFz75CatQ2E9AanteosVZPC220zcLoRgGoFW
 2WfQHLi+fhSc2FBke3juEBRO5yF6SaXfuKs8XrTFStdiMfJO4DCqv60RnfdX39I8EX3JnNylh
 dLVit6n8xUP0MT0wMtuQ5HkgsxLewxh62b4i8UWtwJhagvzDmxEm56R4kQfxJz8HQw63Z1BXm
 l69YRxy+chHhfEEdzbPW5jzv0YZgXopUTaILgKUsUkL008+YgUNRMuqMeONpFHvE+MAMsg7d5
 6rUR5FR8w+0+4T9/9b7Lyo2XFGZQywF0SyRftXIOruG269fjdaL58ANLlfjggA+CX5veff5zE
 0EUBucItZMcdG/jRVXUEvB9Mceb9L3QkirLpzcYwmUUTr2n0hMYJBn3IpX+V1weYRQqQVybHE
 orscuE8hKhFe8fO1zc3zPPeh0byFgkjOblBEW6jymKCQ+osQ8KUhw+FR3Sz7uBsSf5kVh7S63
 GKFnwi6DTKduD7ZZI/uyJvFxuCNfq9H4t06cn6FPIWVEMxxFJcuRSg3mqpBQfiNnp59qt/5Zp
 1HDcicFBuXNE40mofKlR76XYC6tuGJhnpZ9BxKLZhML8dkpcW+8QTrgiGCCOPxG7tXzfXH6j0
 yiVGA3xPU/+Do02actGy0fFGCsUQ8ghA3h9zm470/Z44VAXbHghDgmpc/4XkZaYZJJYlOJUuV
 Q09Z1jZseB159//Io
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Carlo,

On Sun, 26 Apr 2020, Carlo Arenas wrote:

> On Sat, Apr 25, 2020 at 5:59 AM Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> > On Thu, 23 Apr 2020, Eric Sunshine wrote:
> >
> > > On Thu, Apr 23, 2020 at 12:17 PM Eric Sunshine <sunshine@sunshineco.=
com> wrote:
> > > > I'm slightly leery of seeing these applied globally on Mac OS in
> > > > config.mak.uname since various package managers on Mac OS install
> > > > packages in wildly different locations, and these settings might
> > > > cause the wrong version of a package to be picked up if a user has
> > > > a preferred version installed elsewhere.
> > >
> > > As a follow up, although slightly leery of applying this change
> > > globally to config.mak.uname, I don't necessarily oppose it either.
> > > Considering how widely adopted Homebrew is on Mac OS, baking in a
> > > bit of Homebrew-specific knowledge would make it easier for a Git
> > > developer to get up and running by eliminating some of the manual
> > > fiddling and configuration currently necessary.
> >
> > I share your concern. But in contrast to Fink and DarwinPorts, we have
> > no Homebrew-specific knob in the Makefile (does this mean that we
> > expect users to use Homebrew by default?).
>
> IMHO the reason why there is no NO_BREW flag is because brew decided to

That is not an opinion, but an assumption.

> use the "default" directory instead of one of their own (which is why it
> has so many issues with unlinked files that might or not conflict with
> the system, like gettext), this is also why a NO_BREW flag (similar to
> the other two introduced since 8eb38cad44 (Disable linking with Fink or
> DarwinPorts., 2006-07-24)) wouldn't make sense.
>
> my assumption is also that most people in macOS use brew nowadays

Yes, that is an assumption. One I share, but I would say that it is more a
suspicion because I do not really want to act on it.

> instead of fink, darwinports or any of the other alternatives, but there
> is also people that use none and it is that complication why my proposed
> patch was in what would seem like the wrong place to begin with.  for
> more context in that last point see: 59f8674006 (Move Fink and Ports
> check to after config file, 2006-12-12).
>
> on that last point, I am afraid there is still at least a problem that
> needs addressing, but will comment in patch instead for easy of
> reference.

I would have preferred a straight answer right here than a reference to
something I have not received (yet?).

Ciao,
Dscho
