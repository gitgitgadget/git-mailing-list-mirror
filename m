Return-Path: <SRS0=iF2w=72=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 278DBC433DF
	for <git@archiver.kernel.org>; Sat, 13 Jun 2020 17:32:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECFE82074D
	for <git@archiver.kernel.org>; Sat, 13 Jun 2020 17:32:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Ai+QzmRt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbgFMRcS (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 13 Jun 2020 13:32:18 -0400
Received: from mout.gmx.net ([212.227.17.22]:36055 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726404AbgFMRcS (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Jun 2020 13:32:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1592069521;
        bh=b8piw8iSteVvGIYeuY9otkPG9vCmxx3HhfJtNjlifHc=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Ai+QzmRtq/xnS3gZosS9hqfmYfvFwvHOpOCsuzHtwQ/4gw6s8halogFI8Iq4uiQFd
         VHYdRo7MfiHw7PrIZh1M7FZLc2nMC0Ll0SiIRvRVtDLBoJnyypnlNh3VJH6AZomEpP
         srsjQVwyIdLQamy94mqMQQmmIlgsNI+hjAseOc0M=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.173.52] ([89.1.215.108]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mwfac-1j0jKF2FVi-00y6Az; Sat, 13
 Jun 2020 19:32:01 +0200
Date:   Sat, 13 Jun 2020 16:44:24 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Matt Rogers <mattr94@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        don@goodman-wilson.com, stolee@gmail.com, Jeff King <peff@peff.net>
Subject: Re: Re* [PATCH 8/9] fast-export: respect the possibly-overridden
 default branch name
In-Reply-To: <xmqqy2os2u55.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2006130703340.56@tvgsbejvaqbjf.bet>
References: <pull.656.git.1591823971.gitgitgadget@gmail.com> <1efe848f2b029e572cea61cadcfe36b9d3797836.1591823971.git.gitgitgadget@gmail.com> <CAOjrSZvm9QNUttUNVBEUMPJ8zgYEoAnSPN5_6N5uwpiM1sVrcQ@mail.gmail.com> <20200610233912.GU6569@camp.crustytoothpaste.net>
 <CAOjrSZvV6+ApfmOBa7rdXDPQJbExRsOfodO16i_1N5QjjhCB1w@mail.gmail.com> <xmqq3672cgw8.fsf@gitster.c.googlers.com> <nycvar.QRO.7.76.6.2006111559300.56@tvgsbejvaqbjf.bet> <xmqqpna5bq2l.fsf_-_@gitster.c.googlers.com> <nycvar.QRO.7.76.6.2006121451100.56@tvgsbejvaqbjf.bet>
 <xmqqy2os2u55.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:BOM9pstrIt9aa5gPSNEoGUuRH2o6J6Y43YHyRGxnyNWaMaubJxw
 QHjQf9RChOK58jr8xCAU5OWcBXLT4PcUTqVuAMR8Y/q5Fz2SM/b5A+OhXSvqssfExY6t7UM
 ji4rlWXBv4J0tsns8Ij6mCqv7B2tBnacEiSZG8s7si0OQuSsLlLVRvh4XkBiO6qSJLufmuv
 +ZIDxI6Vh6zMM1mgqZN6w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Jh6Kib65e+o=:pZQQuC1eOUki+T/RPblLor
 3Svz2YgVx97LdaLUSCLdPlGUL4ctE/8SfMVFBhdkFGNexHsvn7klCVUBt/kaC63GzGAPzDuFa
 0u397RzOTM6U/UPRrdGOdUfGo9oshoeGCBvn0N2Wfab6mS0vO5stAQZkcRyt8+28pqiPWLfK6
 LQMf7PAdKgf9J7j9McxkZS052yiII9W5dG5VMBeaa1vTA0d0RjFFoZgNI6Z2PvVDvM10SLEQG
 w9K16sT5ibzrJ2QWz7DAHZ09WGjwxSt+t3TxEtQzB6duIdFIyGqcRWl183bVsBqtRse3OdhxI
 aEkPAu6554i6HCIZF441VMNPPz1CCI1d4T1c24metTyoiCP4rE0yxtA81sdxH0PXMXax4LN/y
 tXDrXlsrZXr18+VXZ1/KLEIp62PDufxpa58pgc8vR+ePyOw3GS2ddT2DbXpy3ReP3TKmyHLiV
 SeUPdXX6gHfuawlRaeu6xfOFH87rx2QOV4Og4nTpVmmb7nekSOx7/16G96Pg4XgazZ4WcN7KT
 M8PP0D/cbZcngVM3yMrbFepNX/wBfTHjJRsqU4F2OU6NBbU4d9fndkqIesNLDjqPcj5w1Zlnp
 F96AYdl3a9j9UBrSOMExTrhMrMbc+B3LMYTlXcvgoE2Jb49+PiZ5CG7YGrYTwmw2iTdB/3YlH
 t5MMXU05I/jgxo49WX+wBPFdshy0uG8jBglFOzqqvrRdIff2h/+0O+8Gpgd6NcbOo6r2DDuin
 ZDN4RXXFSlj41SbYSUYxhipY+mtqRULEKuqXamRhTtyJgjpl6kG0LVnuU9BNkMu/TchBfSZWf
 wD87fDUpVpJJTgQsPvl2xc13r8HticDd9CujrOwyAIl5jQuIot5cNYJ1+7QTz+5TzJWr390aY
 DVpYBQu8RGkSMdruqkEIaRSE4SqK4GFibUdhLM894Nzkkj+6nL6hkmqusF+s6QE/kcM4WRSmA
 mPRAovcvKY7Jw43vyO9wv2y9XP72oVsKWZt/wtT9CJr9YoLHaurx7nRA7IWiKq2+zRvyivrlr
 4iiSAkTyzaajba2Niw6McMaVQI1a/yhayopbNOuw4WsuVoCckWSi2fwbGfEwlnfanJrus70aj
 IcmhQpCAXFOVnC+p9VOBSAdOhlG5ah8XmO6ocPO0B9MwWFL9FyjPa8mAk5EJ6GO9CthLjzjAm
 Xw33I6XALOaVFerSRTCzaDwYSfNSaJVJ0ye831Iuw7WIbkenVcpXnjzI2JIcmH4vSA9HU8kh3
 wC4lpEfr0N6ZYFiRZ
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 12 Jun 2020, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > I just realized that the comment above reads:
> >
> >         /*
> >          * We also leave "master" as a special case, since it does not=
 reveal
> >          * anything interesting.
> >          */
> >
> >
> > Obviously, we need to change that comment here because we do not leave=
 the
> > name unchanged. How about this?
> >
> >         /*
> >          * We special-case the main branch, anonymizing it to `ref0`.
> >          */
>
> If you are going to update it, why not make it useful?
>
> I complained number of times during the discussion that the original
> comment explains why leaving 'master' as-is does not reveal anything
> useful to adversaries but does not justify what the code attempts to
> achieve by special casing 'master' in the first place.

True. Sorry about forgetting that when adjusting the code comment.

In my defense, I am/was much more worried about transmogrifying the patch
series to reflect the separation between `init.defaultBranch` and
`core.mainBranch` and the associated fall-out (I highly doubt that the
range-diff between v1 and v2 will be useful...).

> It is not an improvement to literally adjust that inadequate comment
> to the new world order to just parrot what the code already says
> without explaining why it does so.
>
> 	/*
> 	 * Anonymize the name used for the primary branch in this
> 	 * repository, but reserve `ref0` for it, so that it can
> 	 * be identified among other refs in the output.
> 	 */

That is indeed an improvement, thank you so much.

> is the minimum I would expect before calling it an improvement.  We
> could add
>
> 	It is often `main` for new repositories (and `master` for
> 	aged ones) and such well-known names may not need
> 	anonymizing, but it could be configured to use a secret word
> 	that the user may not want to reveal.
>
> at the end to explain the motivation behind anonymizing even more,
> if we wanted to.

Maybe we add that to the comment in the patch that teaches `fast-export`
about `core.mainBranch`? Yeah, I think I like that idea best.

> Now, "so that ..." part is totally a fabrication based on my best
> guess.  I do not know what the original author was thinking when the
> decision to leave the master as-is was made.

This comment comes from a8722750985 (teach fast-export an --anonymize
option, 2014-08-27), and I agree that there is no explicit explanation why
the main branch is special-cased.

However, I think that your guess is a good one: it might be an interesting
aspect to identify the commits from the main branch, without necessarily
needing to know the actual name of said branch, e.g. to reproduce a
reported issue.

Ciao,
Dscho
