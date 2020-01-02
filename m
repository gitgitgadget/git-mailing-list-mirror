Return-Path: <SRS0=b7P8=2X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CE1FC2D0C2
	for <git@archiver.kernel.org>; Thu,  2 Jan 2020 19:53:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA8D621655
	for <git@archiver.kernel.org>; Thu,  2 Jan 2020 19:53:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="b11/qjaI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728463AbgABTxk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Jan 2020 14:53:40 -0500
Received: from mout.gmx.net ([212.227.17.21]:42983 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728397AbgABTxj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Jan 2020 14:53:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1577994813;
        bh=ERXkGY79hkTPh3BnrUNEQXAsEqI4prImIAYY2tbJ/SA=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=b11/qjaIzLjiDDlUHkYqoacWzAOIDpQk1ebRs0q+DkZ3tadZO0YHw7wRwzCvF7pip
         O0Fn5j92qdHEM3PFDNqzuGC1K2Ts5YaxwHSKNTr9jpctcUDBC99eY6kbSN5y9wnckG
         z92ZKlZ0mI1qUzLLF/4YUUsrRrtad/0Y54T24CIQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.152]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MpDNf-1jW6ug35W3-00qhdS; Thu, 02
 Jan 2020 20:53:33 +0100
Date:   Thu, 2 Jan 2020 20:53:16 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/1] mingw: only test index entries for backslashes, not
 tree entries
In-Reply-To: <xmqqk16dfpcy.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2001022051410.46@tvgsbejvaqbjf.bet>
References: <pull.682.git.git.1577382151.gitgitgadget@gmail.com>        <4a120fd0b32d2d6492eac6b0494ad6b1bc2ba500.1577382151.git.gitgitgadget@gmail.com>        <xmqqr20qlxtz.fsf@gitster-ct.c.googlers.com>        <nycvar.QRO.7.76.6.1912262209190.46@tvgsbejvaqbjf.bet>
 <xmqqk16dfpcy.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:+nNb2nNYUwlhIuxadw20a4wOlbT8OPJGP17+InXuUbjO3LRygjN
 gIBp4UCBvdXrjxzBxwc3dihEEnDyKpRF6DdecOAhEitVQg/WzRFDOSJygOJHR3aXxBiDPbd
 AvRElL4h1VkeoXveV0y9WLRj60os6kq09eaQBT2KPCtVjH0hE+22KPGciRw2HSwGguk9brx
 lGsuA47ONWhI2w/RRzYdQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:2H6GpaTC3r4=:HAdmx4TXB4HhK5ZhmLM8ts
 IhhSPMlBPstJABZ2nXAj202SBr01U1aI9Zw1mF/tLNzzLPR3EuzWLoB8ioBDrbWYY4QYFzBtL
 k1jjF0FYOPOZVtBd/qdbdApYaveIBY+P9FPJrqpOJunk6pL4uWqQ0jeVeLmgvGJqeQbwJI0dA
 gmBOLeqHQ4JUB62+LUL90rDiQbVQ/b3v4WvB92GzpeW8p+gTnEPUSSpHYrhLYQG1iPNJmJIx/
 iSxESlI3KxulTSobqLLArabcCcCRj87TLk22DWTQNLzLb7Tc3VBPOnlGwBJnmxD7PmSfJQMI9
 ydE2asFCwOg23GjHfYza6uhLblRPMh1NmyjPKM8wAftBpdlLM6Tlo8o2dfC6VPnmdBkLISFGL
 CK9z4tesYBqJ4lZ/U0EFWfslneAL/N/TzYpIJnkAwkiWO6hWAtwPzauEEpuvrVJrKu2oHaOI4
 BakmJbISLtG9/M8ZMew2LI0zAnIVWvj9Qd5zWNmx5kADiyGDR87VYfbETkxuIpgDslEe128sL
 Vwev80fL9oSVu4KVlwSWN9OLMIAUuhvd9kcBfgl987emrNWZNkd5qyUme73Qei/kKMNSud5ec
 13HOXEHclL0Jw0X7vjC0uzFtGNDlvfQ1aVwpDRZ9F5euXIImjLRsWliYd2kO9qvgmxk+2nktj
 7Y/YXpJQ2dN8tFrCkwIT9w5J1TGFC7nhMCj6ds0Ewrunbvnss0LYIhPRK13jU3+W4r/KMqem5
 1hLNcJZyJd5K7R6SVTanSnucjgcCaCtdMhdxmpkndg2wQ/AdlG4PD8EI7LYqEHzKf6iSNMSoD
 zHSDG5AHhaC7PP46OQNYbkOwa07cWbh8+lRLQw+fUzu/NcgU3cbYdMcJME+BQ3teYW43jg1O3
 xQ3qckkrdx/dafcyYOqBF8Je4WxWwxGBT1aTtRjiEyeo6sXcvYcq/c4kumM7cYMuUSgF5FKhS
 E+InL9oPlHzlBtCpWkhJ/Lz7t0Cm68inf6Av76YRAx4j4PM4BCrhI+yiVD5n++87Gr9lhcQBx
 uaGMsyQ4WcLN18VJgV8dbj4CYq5LW4Kh3hZvj0pt4Zq0g3vR184mDRmjuWC0kOIuDhNsllPOs
 1+u2o7K129TgYiCoqXYHVNjsZW6H1gZxdwIBR2qaLCEAWFVFRKwbCoxTrPUzZ7pSYLHW2FgtS
 wStZBNVcLZeBAzKp2BCuEWEYr9ATvY878r1ZNiBtMVvyMTF+5xttOA4fCkpe7bHECC93Gasu6
 utFTqzrCKBKz3mddu30R/yhsSyjj78OzLCaokaTNwMquWZldK35e55Mz2D20=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 30 Dec 2019, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > Turns out that this inconsistency is only in Git for Windows v2.24.1(2=
)
> > but not in current `master` of Git, so I simply struck that part from =
the
> > commit message.
> > ...
> > I rephrased it to:
> >
> >     So let's loosen the requirements: we now leave tree entries with
> >     backslashes in their file names alone, but we do require any entri=
es
> >     that are added to the Git index to contain no backslashes on Windo=
ws.
> > ...
>
> We are in -rc so there is no real rush,

My intention was actually to integrate this patch into Git for Windows
v2.25.0-rc1 already, that's why I sent it out for review even this late in
the -rc phase.

> but I take these to mean that I should just leave this loose end hanging
> untied, and wait for an updated version to replace it sometime early
> next year.

I sent out a new iteration of the patch *just* before the new year arrived
over here ;-)

> Thanks and happy new year.

The same to you!
Dscho
