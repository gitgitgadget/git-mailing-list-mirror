Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 70ED11F461
	for <e@80x24.org>; Mon, 15 Jul 2019 14:49:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392291AbfGOOsD (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Jul 2019 10:48:03 -0400
Received: from mout.gmx.net ([212.227.15.19]:50359 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391968AbfGOOsD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Jul 2019 10:48:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1563202073;
        bh=/S32XT9ZzMxKNj5MzQQYnWaNe1VPtXBUFZt1XRHr6Dw=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=ENMj/5r2FdbQ5Yh/WYMRtmyaMeH1HxLe3K2gszyJmpWCKeS4db+7+aL7DrcKQSfGM
         mstEUnlFFCT0GQ6qRleZtHHk648hLVITje883Z7xoHBK/P1tssg3Ntc7orjsajmOk0
         63CEy5LjuijhBmSPxOHeyVQrX5SWTlyCbXmqjOcc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [10.49.60.142] ([95.208.59.234]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Mh9yT-1i9MVN2ITJ-00MJB6; Mon, 15
 Jul 2019 16:47:53 +0200
Date:   Mon, 15 Jul 2019 16:47:32 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Carlo Arenas <carenas@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH] range-diff: fix some 'hdr-check' and sparse warnings
In-Reply-To: <CAPUEspgD8E02FcNvBx96neGEejdqMDWoH8NgpsHyGPo_KM09FA@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1907151647110.47@tvgsbejvaqbjf.bet>
References: <e6796c60-a870-e761-3b07-b680f934c537@ramsayjones.plus.com> <41a60e60-d2c0-7d54-5456-e44d106548a4@kdbg.org> <xmqqy313p5hn.fsf@gitster-ct.c.googlers.com> <ec635d0d-00ca-2419-3c1a-9b0343b46daa@kdbg.org> <xmqq1rytpqse.fsf@gitster-ct.c.googlers.com>
 <CAPUEspgD8E02FcNvBx96neGEejdqMDWoH8NgpsHyGPo_KM09FA@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Izv8B6A9ylCh4Vpi43S+192ZVKt4U3iDF0I+qserrFskSRJaKdl
 R3TqQodcExruovS0P+/+0BqlCzx0sS1tqxLn3QuvE2WPE0GPyMabU3ptQQ03S6pdZPOBKbS
 NlBqKla70GqtBAMKcWAboYfpxca/G+iB8JimhxyqZdmviHCIZgq8FEWVmVpKAfglxW2fVP3
 LSnYDrC5sEOIRtwnQegow==
X-UI-Out-Filterresults: notjunk:1;V03:K0:OGTllIyPQ/M=:b4Y89iXKXyAVzLUHhNR3JX
 EmFasbYpROFzmOEumMcRTUFRQ4PhNuMi1Ooo+DUiw9VYxDeEFXO20SSFjUmTowzfAVHGjA+L6
 vYnwTHVeRD/qQaJXco1B8VtbdyBXytfTUejPwNtH8u5iW+rJ4XTQ8vcry2omPEaAVNXsPbwYb
 GVJ3EAFPr4ZPUqbROIWw6OTst365kpJo/Lh09G4UWtMZIEi3AehrRpgy6BlkcABA9qtl8Lgfv
 bUPXqRnK7IBTnSfrAk784scYg4FvOnJXmCD3/dM6MvngnMqi7d7Em3qGlrINB5+v4MEg8lV/0
 BoX3t24LTfFAbNyM+6oJDwM02zDAEJw7VyCw0y2Cp1ckZUoXUqr11KURvJi5QIb13KtZL6vtu
 nvPqkht7iS1gGinG5CfmCcvU5Zc2Hkmzh9gM0vrqIjtng9r29pSbEVI3M1bWzePhLTdSCl+qS
 SyLpMdpy5QkD/OToVZeATm0ZO/7WYY5+s6cyyBcUe2ffljusIP4EqPwUdk51Q21Gaxr4SjhmS
 9Im1KEHkGlTuf1m+mgjaPLbAL9nsDmLGHhMTgL8Swu5iceBROv/kK7umB/6Lxq6RPmYTYQ0wv
 fl4FXVl7x7ivF6Cd54DfyfyYPxj7KjjpoXgcCmiU36OUxZ2xofFc7WBG5PSt8rXOJiW6RVNWW
 OmvvkmnLvr8K6Hx3Vxpy3GURggUy6NnCYykwCFRTzQxl2lUcUbfJCWRxRRNzPoKHUg+1joUji
 u66K8ETdSWFZf6O7UNraxOLpfFf7j0H6h+0Jl0oEd2NukvwsDo0djZ24yECElAuyyxNmohmdx
 TL4P9qRZV0RvZ5VxoyRQUPsXVRcceyNva2YLO5JZJ7hHlw85o/Cw9k6In3neJij8uDhmt0i2C
 0DEDUvvEqT29h+gn+kbnY4cCc5sKkvW2+n5/HaF/FhgpEUrB6hLqn0Om0MaegWujS5l5yGKih
 YEHtZMIT+L//h5FCx1j80B9QSLH83kbN4oKtYgIQRY0nwbLUH8wrFTysnQKGo6q4iPbdm7JXT
 rt5TG/MoIkTjK1a3hDybQuO4F6/WbcVetnoxVvhYiMR/IohsNl+EMR4x5EG9858OUOaAiHp7u
 L5iMjqnmjyCrleQ0Z9CSiQ+I8uawL1RMKIE
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,


On Sat, 13 Jul 2019, Carlo Arenas wrote:

> On Sat, Jul 13, 2019 at 2:29 PM Junio C Hamano <gitster@pobox.com> wrote=
:
> >
> > I wish if we could say
> >
> >         struct patch patch =3D {};
>
> that is actually a GNU extension that is supported by gcc and clang (at =
least)
> and that sparse also recognizes as valid; it is also valid C++ so it mig=
ht be
> even supported by MSVC.

It seems to be supported by MSVC, at least as of VS2019.

Ciao,
Dscho
