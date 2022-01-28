Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE204C433F5
	for <git@archiver.kernel.org>; Fri, 28 Jan 2022 12:36:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348520AbiA1Mgf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Jan 2022 07:36:35 -0500
Received: from mout.gmx.net ([212.227.17.20]:49505 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236322AbiA1Mgd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jan 2022 07:36:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1643373388;
        bh=z+Q1rscLwsmkiUr0Lt3HWU30YAYlHRrOsMA0LWhVG8g=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=MSFdmwZZC9TQ7kB3qYN0ToFu5wxkbP2nRWyM2Nmeij85xIM+UvybijLLO3ygtp+8G
         FbrALNgOJwVdJ/7koX+xIP/CRX2Y2/B9B/TXNPTHgG07aonh3XB2P6Qn5TJTMt1xMP
         RLmFv7IL+RSzwWu0YC6LcpmuHGE0TsgktdUaVyu8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.27.196.48] ([89.1.213.181]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N8ofO-1m9l9u1u0U-015tNg; Fri, 28
 Jan 2022 13:36:28 +0100
Date:   Fri, 28 Jan 2022 13:36:25 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Thomas Gummerer <t.gummerer@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH] fetch --prune: exit with error if pruning fails
In-Reply-To: <87pmocp1si.fsf@coati.i-did-not-set--mail-host-address--so-tickle-me>
Message-ID: <nycvar.QRO.7.76.6.2201281335050.347@tvgsbejvaqbjf.bet>
References: <20220127153714.1190894-1-t.gummerer@gmail.com> <xmqqmtjh0x5f.fsf@gitster.g> <nycvar.QRO.7.76.6.2201281110050.347@tvgsbejvaqbjf.bet> <87pmocp1si.fsf@coati.i-did-not-set--mail-host-address--so-tickle-me>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Qk463u6GwbQrTbBh8IWiPzT0ITwxjxfV5rEqG7G20E5jgAh0DtO
 ftfUQbnNpavN6qdlO31BgquQMhZNzCmQ6yk0IVcGPO1izyePFaTigxcrQ+aN2jL0WCUljpD
 x7VV+fY6jx6YZxWleskkpj5lB7/C/e1GlePamV6fWqLSCGCtlUrHmCStzFlFOwevv9tWkGU
 h54P61uRCpTWSkdP4ib7A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:cxv7DAkww4o=:ngMtx9dSiZZaKnaMVo/Pk8
 hrg8jjFdQ2t59RL9nrur3Uz5F+5ls10U8MnSKMw0Efp3t+pvvXxVyOp4Wc/RJzhbqYzZ/xxXC
 dUK3frTkE40gbjy59Of+Ux6ICp+Yi+4XB6lpv05yEOVDlsv/xE/bWDpphVJlalt4GCQKiC8g5
 zmkHAtaFT3WhJihSkSpMG8PZ9V13zQNK7WOBo5q1xF2b5yuReeJap1vTz0gu0RjD79dOO2BoD
 g6gSMz0/TbGjOShaUgh0zPB0P1nolDsMXKOqzOzfR3MYvqt+2T8Ti39BY+HE5+pQSgnNWompC
 9HfcFLGwZzzK6zWfp20CzZF3+L9Ct+EpFKQ6+9lDNMHRV3NSmcNk6NeHCzXaVFsmc1wbrSsDc
 l+Kg++cVCKnR5AiUdERXzfGdeLmc1K6pV/sSF2GWvI6a507zrhrDJV1I8bC9l/pjE/oAbbO3X
 fJSQmaBCM0bIO6GXUv0Oxz+U/MlHsK8cok/3SoA83K5sP5MEnCvVABW8Zi36+YvDq3TjLU6A9
 h+rmDQajSVee6YVWj+oWzONjwRAOUocSSnnMJhEa6LDg6J94nuJ4SNCAAlTH+F7KmzcHKF7k3
 S+FrPjbRuiBEckZzi4rkRJHEK2P0HKQYanisQA8QrhZwGrt4ELw8KPTPhfBxOX0TPq2ExLmFc
 Zats0/5jM78w+VYFtG0UZAVkPgcoKeD5oL90HbwGjcP2GQ0BsaVeSZ6njgZiUPjyC1BYySrdU
 mWCUyTpbv3DqDsv960YTTQWQuc/HRtw3gLaoxqpAtNHrGOhLQj5NVPn58lMl0styVRDCTF1xd
 fFX0IEVq8NEcbHSAyuW3MuU6H1B26sydngl/4f5lbLWrAY/Ns435Gc2lOlv2Y8ok5Ujds8zIH
 lXYIXzJjL4DJ+YKJHEa4HG+M1p7nJjPpvg+InJhULkjPh0+wHVjwyUKlA2LXOunzljfwzh2AT
 uHsiVe+A8sdE+d7X8vkVDzwKUR/gJrtCqYvBUKaxuAIOOkaAHSlz5TSR0H4PMBEmG7jUaO8ko
 261ezkX9g4dAXvPII96c1+AbVWJAHFtlB6+pKdDnbguZ+CTppxW0y1dlLCFekhBba09YNB+bt
 0ynVe7PhWdyCSA=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Thomas & Junio,

On Fri, 28 Jan 2022, Thomas Gummerer wrote:

> Johannes Schindelin writes:
>
> > On Thu, 27 Jan 2022, Junio C Hamano wrote:
> >
> >> Thomas Gummerer <t.gummerer@gmail.com> writes:
> >>
> >> > +		if (retcode) {
> >> > +			free_refs(ref_map);
> >> > +			goto cleanup;
> >> >  		}
> >>
> >> This part is iffy.  We tried to prune refs, we may have removed some
> >> of the refs missing from the other side but we may still have some
> >> other refs that are missing from the other side due to the failure
> >> we noticed.
> >>
> >> Is it sensible to abort the fetching?  I am undecided, but without
> >> further input, my gut reaction is that it is safe and may even be
> >> better to treat this as a soft error and try to go closer to where
> >> the user wanted to go as much as possible by continuing to fetch
> >> from the other side, given that we have already paid for the cost of
> >> discovering the refs from the other side.
>
> > I am not so sure. When pruning failed, there may very well be director=
ies
> > or files in the way of fetching the refs as desired. And it might be e=
ven
> > worse if pruning failed _without_ the fetch failing afterwards: the us=
er
> > specifically asked for stale refs to be cleaned up, the command succee=
ded,
> > but did not do what the user asked for.
>
> I was thinking along similar lines here.  I was going back and forth
> between letting the fetch continue, and then exiting with a non-zero
> exit code, and just erroring out directly.

Oh, I think I misunderstood Junio. As long as the failed prune will cause
a non-zero exit code, I am fine with continuing to try to fetch.

Ciao,
Dscho
