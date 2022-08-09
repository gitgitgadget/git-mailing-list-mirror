Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2E9CC19F2D
	for <git@archiver.kernel.org>; Tue,  9 Aug 2022 09:45:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238261AbiHIJpd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Aug 2022 05:45:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235758AbiHIJp0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Aug 2022 05:45:26 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78C5C264E
        for <git@vger.kernel.org>; Tue,  9 Aug 2022 02:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1660038318;
        bh=KH6UcrYIw3LsCH42/V23dtUb9yzoPxi79BdYuE2qh0M=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=eHYnaAs9rKYtrBB0YSTEBs9RFunv8Q3tYsgT6bMhIgu4fkGwDn2PmN2g9SQKCWXUW
         wVUNkRvAWs/q0KK5J61hT8y80bHqxlLmQMeGnADLM4KQD5OVk4WqrWv2K3o6rHr92f
         viO1VJ5jwmEQWfRVrU78rU054o2UkN+arvTOAigo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.31.241.252] ([89.1.214.151]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M3UV8-1oKnpk1Rly-000gMF; Tue, 09
 Aug 2022 11:45:18 +0200
Date:   Tue, 9 Aug 2022 11:45:16 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Matheus Tavares <matheus.bernardino@usp.br>
cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v3 2/3] t0021: implementation the rot13-filter.pl script
 in C
In-Reply-To: <CAHd-oW6GLf=4VxAvMy6c9jrGx1zcSHbe_NKbAUg7wvNBPOmEXw@mail.gmail.com>
Message-ID: <psr5o1r8-ro70-24q1-7o01-8571n1802s18@tzk.qr>
References: <cover.1659291025.git.matheus.bernardino@usp.br> <86e6baba460f4d0fce353d1fb6a0e18b57ecadaa.1659291025.git.matheus.bernardino@usp.br> <220801.86les8i495.gmgdl@evledraar.gmail.com>
 <CAHd-oW6GLf=4VxAvMy6c9jrGx1zcSHbe_NKbAUg7wvNBPOmEXw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-1179140416-1660038090=:206"
Content-ID: <r57218or-o046-0p7s-2por-67172r8or8nn@tvgsbejvaqbjf.bet>
X-Provags-ID: V03:K1:FKbzlbcCu8HZasTgf9n64x4xpY6wLCrMMOT4oWH0WRvoLiR/FoZ
 KUhzyH81YF++P7xAz+t5ZgkW17twoLQp5reC8QzBfdbXKqFTDhP1MMknJniqM1esIdo1ZDL
 jwygdfS7+ilaxJ0Jj8X/aDzm8JVlKia0hJidEhOp86IjXQ9kwsTwISZQhk9d4lZ/lOpwcQE
 1wsjPyRaHxbmPIWVsSNdQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+ypcGbheKaM=:PHOYDze/PbvlvNxLocFb8R
 xeyVVDt+rrkrYO6hyQqC/gpD9emvQXiKqwsxb0bMfZRRDaB2S6Ogua6cVb791oqx7VLQp0zBj
 7WkmvgwAb5/5Up0haJIj5AGbHPIy3RUZzDMJMwuyJVlw0XUzsx8u3B0ERlTELIrq7cGTvrRY7
 jSG+0OGiBb2vgzksdKbFigD1QdHtzOUV7+wrBK5DcVtk91VF3th/YbqJIi79N4PGK/nRexavR
 0dTaZRB8vFoZVsAluoxDWOQ943HFdZAun5LAS7XdolfgUphKqBkWG/GWhwMsS7NrUSuxgsge2
 cP7pGHjWX5lZ99RyO2m/08174QI9cx871Zluw39oMpACXbWxZNAjzzXSZIyDVx9nBdjr8bX7I
 y3tOhW6EfUXPKs8B8H5H823GcHbEl9ksrW/4H57SjNpIg+mgRJLsF3FgJ9ZZLwG+AhR9rc5oC
 xcL0hzLnSpt6q/R26VxQPvZ9PiN53DXNvL0qkEs2QCNYlcBgt7HVDtQbsWxaBheEwX5IvGY0x
 zIuti9GelbUOnCnIGV4XKrxQYhWIzhQkYu5IORBcj+WIDplv8cIwmGEdIm0CfrdyZs/1tdfoF
 r0NyYySuIWZotdL/WqRwU380waBEru/12c/xHEBbnTihFKg99Ba67hWzopG1WC0WLGHg4JMEV
 JmIK/O53XaLpSTecCfbvRDYIWl7XsD+rJG615zbwhOMARC4N/V8XjWLz+02dZCXJqRF5uR7PP
 b4JjYILm3EEgh8xFk63vUUO/wm1zeG239TOjmzsDeN3PMgyBpfbnw83TzVZw2SjVBZ1WpnGNt
 1PSEdTcxrCv7X7+I3JA6RWaRH+k8o9WALH8k1rbuK5ajrT+B2VgI90lgDgdDm64hqtd1tYZ9T
 VLTgAFfZNyDmODqAtyFfRQnQHUpgkNBqNUPqJwQyCrwHijTFPmvgSF/53/kHCNldwZWs8QfiS
 AK62muJaSFl/+YF4PaOkRBuhGPaZ5rSUYsnq1vUMD7Wvw1o/0c0Iz+9dgslaBffzJGLoY3NFv
 FnioStbWzkUDkIeRuiRGKu+iPPDfa25gK6YO/N/OgaFulVB+j+pLKgK0vDKlC9I3baHISOQFd
 g0fjn1sd/yTZ15LbPolxpFRZg2z8+2Bk5uUONAEIDm83/UPunu0giJiqA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1179140416-1660038090=:206
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-ID: <8p6q1o2r-rr4n-4621-n486-9r42o0q1sn96@tvgsbejvaqbjf.bet>

Hi Matheus,

On Mon, 1 Aug 2022, Matheus Tavares wrote:

> On Mon, Aug 1, 2022 at 8:37 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <a=
varab@gmail.com> wrote:
> >
> > On Sun, Jul 31 2022, Matheus Tavares wrote:
> > >
> > > +
> > > +     for (i =3D 0; i < cap_count; i++) {
> > > +             if (!strcmp(caps[i], "clean"))
> > > +                     has_clean_cap =3D 1;
> > > +             else if (!strcmp(caps[i], "smudge"))
> > > +                     has_smudge_cap =3D 1;
> >
> > In any case, maybe BUG() in an "else" here with "unknown capability"?
>
> Yup, will do.

Please don't, the suggestion is unsound.

The idea here is to find out whether the command-line listed the "clean"
and/or the "smudge" capabilities, ignoring all others for the moment.

To error out here with a BUG() would most likely break the invocation
in t0021 where we also pass the `delay` capability.

Ciao,
Dscho

--8323328-1179140416-1660038090=:206--
