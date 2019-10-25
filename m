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
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E04E1F4C0
	for <e@80x24.org>; Fri, 25 Oct 2019 21:29:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725958AbfJYV3Q (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Oct 2019 17:29:16 -0400
Received: from mout.gmx.net ([212.227.15.15]:37401 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725899AbfJYV3Q (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Oct 2019 17:29:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1572038949;
        bh=4HO/tasGuHgty3qrNktYWy9eOXw4c3Yw0H7GLOR+kFk=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=MLIOytWboQu5e/d5bl69K4UVzx1+M0lpSv/aXTpJflRnrhEp/16+Fipyne4uH5ygg
         pKecW2Dacjp9TiLXTwXagYrf+cjpmK1zEoo2hD9DLOyRwkkwFgaX/wTKOeMJgcorFS
         iT+shbYjxsWbtyGfkIlL88qsdVl5ULiBNM+Go7HE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MNKhs-1icuD91xAA-00Olrd; Fri, 25
 Oct 2019 23:29:09 +0200
Date:   Fri, 25 Oct 2019 23:28:53 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
cc:     Alexandr Miloslavskiy via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/1] vreportf: Fix interleaving issues, remove 4096
 limitation
In-Reply-To: <4bd58e13-4e6e-5122-6127-4399d34fde43@syntevo.com>
Message-ID: <nycvar.QRO.7.76.6.1910252323490.46@tvgsbejvaqbjf.bet>
References: <pull.407.git.1571755147.gitgitgadget@gmail.com> <pull.407.v2.git.1571755538.gitgitgadget@gmail.com> <54f0d6f6b53dd4fdd6e4129c942de8002459fd88.1571755538.git.gitgitgadget@gmail.com> <nycvar.QRO.7.76.6.1910251034110.46@tvgsbejvaqbjf.bet>
 <e7002f76-65d3-607f-3b5a-e242938374f7@syntevo.com> <nycvar.QRO.7.76.6.1910251548560.46@tvgsbejvaqbjf.bet> <4bd58e13-4e6e-5122-6127-4399d34fde43@syntevo.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:VEiTxqRVCe/w06Ne9rHrFSRrjwJIBiJNn4dlX+TMp3iIklSQy34
 5+w4/5n918MiUJnUPL2Hcgbl+x9jh4aD6OD6LbOEtAa8CskK4GM6hX2nTWuMTYUxRtg2Cqs
 I1+uEEehtg6T/oaOCO6u1aJ7YtDVXKLRMEua8VLzg38L1AAn1qHJysz1gjvdHax9eMxq9Pi
 4r1trqYo2kzY+FFn2PbCA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8txMSnbT71s=:sktZJCaUYkH5baT0j2PgS3
 SJJm1piD1Izkw1BC906opI+xVR+Kwtqa2iUR0BTcj0a2Z1uy5uO6Ge9hyRE8x2R1f+tAysKKp
 Rwj1ivI0ifN5P5wtZjr1+3SE1YCEKO/iuHEZODVSEtYMxYPgfb83Wu1/VaDo0QFUsISx2Tt+B
 YCc1r8M84FNHcGfaRMt3IcEPEPl0aZkk52NnjOwtyZocQyBH8Ilw6GSEB8K2W4d8W9SSwv3+U
 lDwtK1ygDoJTfYGxjpkf13u6LMmAOwVRl89e/9kw8XJTVuUXuI1jKSry2ciNcgsoJWMIoZE1h
 KH0Sii8HKXsZTdxxJH1B1fGQPwxffY8qmlQmwoAxCC9phJijmWo3AinHh5+LQU9hsxuUZu9dH
 nQRs15wvl1+bgik3em46tEI5ArrsUPogg96M7xN+/V36/h5eQUb4OTRq/oHgcy35Lr+ZShmVO
 DMmCAbPbP1bZxUrQti5QZPYvXHuB24Dnp+/jMwSMR/2buVnqrfIj/PMMqZAdYQ8ZBuzLyx2Y9
 44GwUQuYchovqrLKcVb3wS+wl51pDSoQIxjDORhdJRAq3zoy21oCGIdA4dKwEjAjafyM9hPRN
 ItgaTYNKutHyPJ+niOwE7IbjFn1ag0ZD+e7k0eOs22nKpxQ86kZf/0eYxYhPKtNoPmghdiZEj
 o06rBKAjQRqo0VBXLr+c6GARgCJDflpOqvwXqiUgRL97qj3BPIsCLQbBh0K4VAENLI8A1Btaz
 1yGvT3gW9wZMG3fxeHriCfRcKBmaIQy48zSi+UaTF3qP8XIWg3AluzlZGE3TACAKRRA8IujoV
 hgXp9dqr8ljFiT7Lxk71LbILjzHsaNzXGT6UtWC3V1pUOuAXpCueoXiVL+YbsWHo3+AlKTirJ
 0TPsQRvbVDQ8zSZR+v7MJeKqsbHu/vY73TpUTECImDqTjpIIapwm9KHHKawOxHe8S7xaEjDRV
 bYs2NruteP8tk2wf9iWwacb2JodlnEDa8pjjJ83AW6pEOlHyqOKGnf4anYvvqMaw/6j/NS9Oh
 lbKRw+hCY9Z4gSZImlk+uuN467Pz1F+aezMydHGGKqsm1alFJo8JqBMoeDVrMozU9k87jvWX3
 D7PQweFj35mA3Aepzjo0Dbc+Vnxa3e64S6PiVBHhnn4YU5suq5FaIIVsUHhBpXlIcD2orMeiH
 cM/JqxuCbT76ZteOfqZnEQgmO61LXZFqH/WOk32VPGKGuOB1a9Og85bSbPfUT0CHIXTp+RfF8
 NGkh6fxxf528wfAPKcsEWqJw3y1Ff+phopTfW12OtJlisxvBPjb5pYMuEw0M=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alex,

On Fri, 25 Oct 2019, Alexandr Miloslavskiy wrote:

> On 25.10.2019 16:02, Johannes Schindelin wrote:
> > My example is even worse (read: more convincing), though:
> >
> > fatal: git uploadfata-lp: raemcokte :error:  upload-pnot our arcef k6:=
 n4ot
> > our ea4cr1e3f 36d45ea94fca1398e86a771eda009872d63adb28598f6a9
> > 8e86a771eda009872d6ab2886
> >
> > So maybe you want to use that?
>
> OK.
>
> > Again, I don't think that it is wise to try to make this work for
> > arbitrary sizes of error messages.
>
> > My point is: I don't want to "fix" truncation. I actually think of it
> > as a feature
>
> It would be helpful to hear opinions from someone else, before the patch=
 is
> reworked significantly.

If you must wait, well, then you must.

The commits you found seem to suggest already that there is support for
clipping the message, but hey, what do I know, maybe the mood changed
over the years.

Since I have to re-run CI/PR builds regularly that failed due to t5516,
I will be very tempted _not_ to wait, though.

> > I know _which_ two processes battle for `stderr`.
>
> I think I said the same in code comment, bullet 3, near t5516?

Probably.

A code comment about a test case that is not in the very vicinity of
said comment is _prone_ to get stale.

In other words: this information does not belong into a code comment. It
belongs into the commit message.

If you needed any indication that this is true: I would not have missed
this important piece if it had been in the commit message (instead of
the code with whose added complexity I disagree).

Ciao,
Dscho
