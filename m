Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCF24C433B4
	for <git@archiver.kernel.org>; Thu,  6 May 2021 20:30:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3588613C8
	for <git@archiver.kernel.org>; Thu,  6 May 2021 20:30:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234338AbhEFUbJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 May 2021 16:31:09 -0400
Received: from mout.gmx.net ([212.227.17.20]:40905 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232831AbhEFUbJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 May 2021 16:31:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1620333000;
        bh=WhXR8qLjAXF188AS/K+FQwKaY6gyt4gTo8jSlQHXPI8=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=SyDDOtuBObGn+I28DQl1woW48j2ZjNlritEVwofOJ8cA3PURqRg+fbQS/E2AxZWDn
         +f43txas6izJG2Xx7hXyh+xPMzLHEKFI1bJdzrCT7ZZHDjBJa+Khe42Lb/dV0GIBVR
         qDxpx5HBsFpPJL5GF8Oo59lMOFATJJk4izG61P2M=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.28.146.104] ([89.1.212.20]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M7sHy-1lat1G0Hqs-004zeB; Thu, 06
 May 2021 22:30:00 +0200
Date:   Thu, 6 May 2021 22:29:57 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, git@vger.kernel.org, Jeff King <peff@peff.net>,
        Denton Liu <liu.denton@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH] trace2: refactor to avoid gcc warning under -O3
In-Reply-To: <xmqqv97w1wl1.fsf@gitster.g>
Message-ID: <nycvar.QRO.7.76.6.2105062229270.50@tvgsbejvaqbjf.bet>
References: <20200404142131.GA679473@coredump.intra.peff.net> <patch-1.1-87d9bcf1095-20210505T083951Z-avarab@gmail.com> <nycvar.QRO.7.76.6.2105051623230.50@tvgsbejvaqbjf.bet> <xmqqv97w1wl1.fsf@gitster.g>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1934349159-1620333000=:50"
X-Provags-ID: V03:K1:oQEWalE2VyCq0Ex5GZyCVWQM2euUywpLNkoU1fpnSPVjnLnXrrH
 eCYzLoeI1LFsmP/gXEz1QmxH8NdVg+yCqtPezmNJtlEVL+1fG0xPxq6uqSabuXqGTbhpGt9
 C5pP+74GHSiSet0fRyrmmIBzL+AWO5keqKrwDxYg9qUPMreIHyvSN/vuxXnhVlvuSf6wbOl
 iYdk86nMIHCkyvIyvqWuA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:rmPoLJrb5bs=:EAgBq3o2mdmKmpOaUHeIZf
 wW51OryCT3UZrO5nMnYcTBBa1owhept+0XmD9N7ZP2/HWrBfps4dNPC03hXQL9OC0h1wUnicB
 HJNT8vWSbC/s6Vr0PE/rtC5anIt6+rHjEpaOZjpk080uSaFisBMZfXkLQFwCaHfwNgWVPbqqj
 EQEEnxGfx0I6Zf4scp0WYI2u1TZmpchuJfKeoWbdDRsYGgcd16SpbETGC7V4rmIKsZ1Bd5him
 XD942EojfS1NkkdIb1yfca1iTFSI7tgCSGFbQ+BsX3ULtBIj9wF7u2804jVJZwEmMqev+RcLz
 t0ex7Md0emFFZRnD8g/Xl+hgc6iLhrYltzRM2vDHnxEFVNJQOHPHUE7IcGG76LtWi/IjlBEzQ
 asGPMUBCGFTerwb/EX2UPTdmPS27184vyOP6Hd5DTNl5gF3VpIQ0WZCc582Cq+Mr695T09nKZ
 VTKmbqQmR1wDCarkJJvnGD4ov9Oj4tVxhNzwHr0laD10AcZHm3nzlFdVWeiwLRprMi7gKURqr
 +OPf3TzEKTgbPU7dAjJJsfFSzyx9msOe+Efl5P8L4kQlGYa0VWFSyYuG7WzqZLHWVdOOAZE+K
 IJ+2ZUl4QHOzYmuZTzIZKO71ZZE7GakqOzctsfcDlWWhVtLrnzfj39C3DXgXhZaikN8RiMO0m
 Q/sIXTQRDkYgr4sNoTL+V6CrGwK0AvntQy0QSFMQPhmMMnNErXbctLsCkQjOyWCBnOoTRmgD+
 vkrIK6HmipdfTCygn4oS1AQxsacHm3tn7zAeG4aCt6kY8uLikKHKCBPrPlv/eLeeFvqhBV4hq
 wStzz05fBreAAf6wRtBbGgAlHi8BXdi4Hpees1Eh8BCWH/uDi4VNA1X24Ttd3Kq0SD6Ydo/lB
 fbSGYlYotntIvlgwlKTDttzYFpiqJjKfdPTTrLF8V2G2bDI0lwLUnZ64EBqMahP7nbSrulPAO
 P05TqnI52RxtUyNLyYnmZoxPjzogfdBOXl45MUEkufbZb8plGa9SEA5x/EX76yhv4+ZrqOAsv
 96nrWMk8cFPp2O/Ew4HlINwu4foUuGXErOc6yEriuJa7fvHY8fP18e9zwl/9AoN90t/EDhWlt
 oX8xZ+fLZEpAFSuT3OE4r76eQQNH2gV+6frrxqLSMMNN7RBYiSvSmUpNBuKZFRl9ND1peHbaX
 Obw86W27Bv9QbnH462InWLhdBIQeSgoNEyP6kfgrOuFR6QAvE3Oah+/AK3I55jBlWg4wPTVL2
 iD3i6e8p7PkpfLzyY
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1934349159-1620333000=:50
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Junio,

On Thu, 6 May 2021, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > Hi =C3=86var,
> >
> > On Wed, 5 May 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> >
> >> Refactor tr2_dst_try_uds_connect() to avoid a gcc warning[1] that
> >> appears under -O3 (but not -O2). This makes the build pass under
> >> DEVELOPER=3D1 without needing a DEVOPTS=3Dno-error.
> >>
> >> This can be reproduced with GCC Debian 8.3.0-6, but not e.g. with
> >> clang 7.0.1-8+deb10u2. We've had this warning since
> >> ee4512ed481 (trace2: create new combined trace facility, 2019-02-22).
> >>
> >> As noted in [2] this warning happens because the compiler doesn't
> >> assume that errno must be non-zero after a failed syscall. Let's work
> >> around it as suggested in that analysis. We now return -1 ourselves o=
n
> >> error, and save away the value of errno in a variable the caller
> >> passes in.
> >
> > It would probably be a lot nicer if you lead with this insight. I coul=
d
> > imagine, for example, that a oneline like this would be much more help=
ful
> > to any reader:
> >
> > 	trace2: do not assume errno !=3D 0 after a failed syscall
>
> But that is misleading.
>
> My understanding is that this patch is about working around
> compilers that do not know that a failed syscall means errno would
> be set to non-zero.  Am I mistaken?
>
> Otherwise I'd strongly prefer to see a word that hints that this is
> an otherwise unneeded workaround for comiplers.  Your suggested
> title instead hints that it is wrong to assume that errno will be
> set to non-zero after a syscall.  I do not think that is the message
> we want to send to our readers.

Right, the oneline I suggested was only for the original patch, with which
I disagreed.

Ciao,
Dscho

--8323328-1934349159-1620333000=:50--
