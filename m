Return-Path: <SRS0=HTZL=AL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 274C3C433E0
	for <git@archiver.kernel.org>; Tue, 30 Jun 2020 13:06:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F16F620672
	for <git@archiver.kernel.org>; Tue, 30 Jun 2020 13:06:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="MEXhAh9R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387863AbgF3NGS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Jun 2020 09:06:18 -0400
Received: from mout.gmx.net ([212.227.15.19]:48569 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727850AbgF3NGR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jun 2020 09:06:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1593522361;
        bh=XfBG2ioX7QEHSZdBtYFhCIEhLd/5CDcyujUWg2MDsC0=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=MEXhAh9RMtF6sCuUYVXwvPdssaSzwYwiNnef+mZCZnBkSNtFwcabiB12ellrqAd6B
         5BGSVry3JqR4Y6FSrCAZojRBjQDTmVra7h6w/TZF/r6EHTRhQlfXC/CKquDh1KLotZ
         9azkE+JLCMIfxSwYXXYMenCEQXj9SluJuCabeDYg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.30.116.87] ([213.196.212.146]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mqs4Z-1j3feS3A2b-00msYM; Tue, 30
 Jun 2020 15:06:01 +0200
Date:   Mon, 29 Jun 2020 15:17:00 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 03/10] fast-export: store anonymized oids as hex
 strings
In-Reply-To: <20200625211522.GA4030664@coredump.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.2006291513330.56@tvgsbejvaqbjf.bet>
References: <20200623152436.GA50925@coredump.intra.peff.net> <20200623152451.GC1435482@coredump.intra.peff.net> <20200624114313.GJ2898@szeder.dev> <20200624155420.GC2088459@coredump.intra.peff.net> <20200625154948.GA3968780@coredump.intra.peff.net>
 <20200625204532.GK2898@szeder.dev> <20200625211522.GA4030664@coredump.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1296894414-1593436622=:56"
X-Provags-ID: V03:K1:VyLTOvVMcljJmsxL4WINOmhZtArGljhURSBxHOVtp2L4+Uxueck
 CiWXrx0PGhDTRfieim0HFBi0X9gQ+ZujH+hgx91zloHldYODoxbRH23MEwAfNACffamYcId
 uUdqrsM9bxoSPJFRlfuo3Oy7mtEB22LAb7xlEemHXSomp5M+P9QXAOpI5rAfiQO+FfbYzgd
 e1s4YinsDAqsaKGgsxFAQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:2Cw7YZUwGbo=:r9aPhqeYDPH6nIBs/W2d8u
 OObf8yJaqvzpQ4g13B31BnX9IzTFWHmnB5ffScFHHnCCJXhtPnd9it8UVunD4vns1pIh3yz0E
 tT9WzO2PF8A+NiWbZf6yGkyYuRbClSeJd9QOzuvkA4jExBQcphkyBMekvR3S9ROeYRS/GipWd
 zu+gvWy248kTQ4WL4A5tMYdDET4mYv+74ObXpMaM/G+ehltJWqvDI4rikBACSqIjhmcBy4iVd
 56PWUJxcXp3L9el0+6acD7qgu1VDjnkwHRwGvMmaOkwdmfDruUdJo9SNbZGdGsfCeMsmbRD2E
 VYCbdc5WI0HBm4Wbe2D00ZPcIA7akNSuDqs+ETwEuhNEo6Q7vG9x166csr82qxfbic6o2I88/
 mdxcbWDqdC8o0QTpGX2BaDWqJPZ2pFZfzI6up3ufim2H7z/mr17eF4KiYTeHIHN2cppDTVqh0
 bsIvSraVq2SfSMTaMYjSleqUvqN/+bg8nJXMQ7h7hxddsdFtMvOKm+tA3MGnBJkLUtOV+tM+a
 GyDqnN1eBcB35gV1g/dx0DV3G1j/k3B7lziVCKPz3UY75k8QO94QXuStstl8jrWPYDOM9cK9j
 mh2Dz4LLyzLytIGyKwBWHHmK0Wcge0lPziZ8kr0fb6O2bjzg3b/HFgs5VRn+a+u2tA+nlUbhd
 YmEkotvVPlHJnyAG+gBwEUbOahuWChQGG+ql+XELK7SUlytFFSZxkmzOm/67lgPFx+DVI9ejf
 lv9Syog62i9TbJzQ0gK4KJRWScYTEeM2tgO2QWTad05tEWqoIuvjnqMGyTOhF1vijncSlD59T
 BOarUqWo6Yh90xFtbwL8YUJzytqHLcWzc5wdD2mJUuQZzmG6ESzalQNmJ9b95BbYVi5D2BZKG
 a51D7Omh7e4aF7Cyy3CgnNt/rShItNFWxjG8RDnajdEdgnrFGYo9+0fUzWkBgq0VylkTJwgOX
 2GhMyNBU2UjFVZKfH2cZ56AiWLUfmm2kbftNjrCfJrxQGVcg4jxZYDqYPy7PshoteNtxoSWC0
 sj1cuFXLPrMJDN01qfKeUAmYja5CICqnjR7FhmzQtZ15OUx5f8SyUC8wMwNz+Dz3NLM5VzEcc
 PD9U3csGVg1ZkWVjnf/H070t6U2+cOaTRpOiGAqJtv5YtC54WzEGebHqi93MuLWCrJ3ku2wMb
 R7Khm+1bJvW6VzKePDTA9pa+JU3PlYxxGysWMCBnIjMDvbGPPTDfyA6dehQdJVlkU9XcgnKES
 OCMT5bx/SHT6z30LhYXWuJqbVqrOpxhnP+p/gWA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1296894414-1593436622=:56
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Peff & G=C3=A1bor,

On Thu, 25 Jun 2020, Jeff King wrote:

> On Thu, Jun 25, 2020 at 10:45:32PM +0200, SZEDER G=C3=A1bor wrote:
>
> > > So this really seems like a pointless false positive from the compil=
er,
> > > and it's a rather old compiler (the warning no longer triggers in gc=
c 6
> > > and up). Is it worth caring about? Ubuntu Trusty is out of standard
> > > support but not fully EOL'd until 2022. Debian jessie has gcc 4.9
> > > which triggers the warning, but will hit EOL in 5 days. If it were a=
n
> > > actual breakage I'd be more concerned, but keeping such an old compi=
ler
> > > -Werror clean doesn't seem that important.
> > >
> > > I'd note also that none of the Actions CI jobs run with this compile=
r
> > > version. If we _do_ want to care about it, it might be worth coverin=
g it
> > > there.
> >
> > C99 style 'for' loop initial declarations are still frowned upon in
> > Git's codebase, and as far as we know it GCC 4.8 is the the most
> > recent compiler that can reasonably detect it; see fb9d7431cf
> > (travis-ci: build with GCC 4.8 as well, 2019-07-18).
>
> TBH, that does not seem like that compelling a reason to me to keep it
> around. If no compiler is complaining of C99 for-loop declarations, then
> maybe we should consider loosening our style. Or are we trying to be
> kind of some unknown set of platform-specific compilers that we can't
> feasibly hit in our CI?

FWIW _iff_ we decide to loosen our style, I would like to propose doing it
in one place first, and keep it that way for two or three major versions.

Traditionally, people stuck on platforms such as IRIX or HP/UX with
proprietary C compilers (and remember: I once was one of those people)
often lack the luxury of upgrading frequently. And if it turns out that we
want to revert the style-loosening, it is much easier to do it in one
place than in many.

Ciao,
Dscho

--8323328-1296894414-1593436622=:56--
