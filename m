Return-Path: <SRS0=3i0n=DJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34218C4363D
	for <git@archiver.kernel.org>; Fri,  2 Oct 2020 11:43:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6622206E3
	for <git@archiver.kernel.org>; Fri,  2 Oct 2020 11:43:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Ibd5uqxg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726223AbgJBLnP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Oct 2020 07:43:15 -0400
Received: from mout.gmx.net ([212.227.15.15]:53963 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725964AbgJBLnO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Oct 2020 07:43:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1601638986;
        bh=NTaclkF3KuxwJ7CYyq3zZC6X+W2NyqBieiP4NTTUIDo=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Ibd5uqxggjRft6Mvbmiyg2+dPEDWZLVcOt9fYfS3zNYpF/L2yOYQi9TQAKqXqEkPD
         1CAiy9LaEw+1haMKFnGjjh9MZXgagaXVNieXiH4Rt4TJKNl+UPcmYPCCiaVYR+KE8f
         KWYwFkdifGA8FaObCvZuGNKnPyGwiNn/xNwh7ci0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.20.73.169] ([89.1.212.8]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MG9kM-1kCFBm2l2K-00GXqQ; Fri, 02
 Oct 2020 13:43:06 +0200
Date:   Fri, 2 Oct 2020 13:43:05 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jonathan Nieder <jrnieder@gmail.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>,
        Jeff King <peff@peff.net>, Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v2 03/13] vcxproj: adjust for the reftable changes
In-Reply-To: <20201002040200.GC3252492@google.com>
Message-ID: <nycvar.QRO.7.76.6.2010021342200.50@tvgsbejvaqbjf.bet>
References: <pull.847.git.git.1600283416.gitgitgadget@gmail.com> <pull.847.v2.git.git.1601568663.gitgitgadget@gmail.com> <01a669a731dfce02c714a40af999b100c75815e4.1601568663.git.gitgitgadget@gmail.com> <20201002040200.GC3252492@google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:tF7Njjt4nkRLLZnm87APYeyllMtj++mvlrLBmChon6WeP+6j3vn
 HON60JsAkdh6+bVZVlvk8zmaa2dw2i1hfa2Tihg7R2xT+6ElpgB7ZhFVZomuWhNYiwN6aj5
 6nUDE320KlXPxzqbzlsmXpgM/CEIyE5LahMhs/w6MAHrzvK81tZqsfghS9RTeO2ZOyX2Zgv
 n++kYxmnGibM/5LxC4GTA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:fYfOdVko820=:BLS2HJIla9ooDod2MFTzVr
 +divqN9EHFuAdWJHUhLtorRD4i/JCw+mNT4mDU4NMZ31deH0pSl6Y2YlKhUuJet8JwMPiJfVw
 ddbmR/aCi/PoAEKWATI5AL7ZbnXr4Y1jeR7xotj5U3PY5wNNfawUXQJrExA5QcgbXCH4Rw0Ec
 /2Z2ePgpHz0dzZmZnhyp4+ybb5HGlEFIH5tlMFpOUDX/5L+GeOp0S0QoPlcQXHiq1nRItnmht
 v/qApiYcSNx1lfEhy6gbXEbaTohIX5U6JKjUiJMPVmv6Rl89rgGH7qkLYSoDEiUG56A8lg195
 ZipKGzUI6pssO8EvGpxYTVDexmv+KNYtbVS7BI1moMczcJTXJTWiEi4AkMEetl+nJrsc4s7EP
 eu/QvwatMgTFgrMDnSmEEMKxsK1z5iT7gPCJ0SwtAT2NGyJ4TSnDBsheyHZaje7u/vAteZTBa
 qAnezsG7e6oO92Kvj2+sILMf7bx8aV6+EytwTtAoL3hUYTSDOhf8zUFmOkxc0dZwNTSzJJJZR
 E20mze2jqp3nfBFa6SbsL3QoYpPcZTgZmCThiCD6hATwgRgPLWKwTv250rIkmMci5Uec7LcjO
 hDPAuGrIvKSjQAS9jU5Jcfi46i/AkzfG2SdjZ8PR4HOPE6PXU3lCphKIBb8AmGH/NG4l0Ga8K
 b36cnJ+KQ9YdaPBa6OJnnVhKyKJDdkeD2bYArVXIKF/y23Z+hat2jYMX36LutIehhKJ8iL9lR
 M1+4G9ihv18C8ED7Vy/5OuHqK36TP8NHloj/RqnRBZ3xtEXhjEEEzphcic+flkgXG8gVwUBK7
 ACBl/9kS9khk3TAiXkdxjpIDm0iNW+VDmjQVtx+ax+gVgcVc7JP2SMoO8ZVAL/IF7pF49lYJw
 6m+Z7OV4QWKw5UnTRgoUEnRJTnjquYYiBGmtaXnHNXuxL6nSuGyPr0onRVvNRXbLxZykJ6i6Q
 Q1i5WiPbxdIGE7GDAUimivovVF+U+AbNLEqQl+5iaD0xMkZbdAPI/auMLYn9Od4bJQYPCCvvO
 RKJOr1O2Vy5fg9I2nizmy9z/LFZE2Sgnx/wh0/ZAW7VWkrRvqjOmNEMAo8DcGEiUZM00Aomtm
 mPT73zPuOuV6ldixaFyenOBAS2Hi5NJfQv7KYPExcdmY7dBYgjuuGqVdAIUCMh7KwCJaQccHY
 bKCCwyNE7Z9NI66cHlvwrsrkimsSLLcokMrJvaGZHparv5euiM/LFC8fJkshQTFNZH/r1c+cD
 LUPO7wz9UlSxUre314s/VkPgIJpNrDLYkngIptg==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jonathan,

On Thu, 1 Oct 2020, Jonathan Nieder wrote:

> Han-Wen Nienhuys wrote:
>
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > This allows Git to be compiled via Visual Studio again after integrati=
ng
> > the `hn/reftable` branch.
>
> nit: This branch name is no longer meaningful to the primary audience
> for the commit message (people discovering this commit in git history
> later).
>
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  config.mak.uname                           |  2 +-
> >  contrib/buildsystems/Generators/Vcxproj.pm | 11 ++++++++++-
> >  2 files changed, 11 insertions(+), 2 deletions(-)
>
> Can this be squashed into or put immediately after patch 5 which
> introduces the Makefile?

I never intended this to be a stand-alone patch. So yes, I would be very
much in favor of squashing these changes into the appropriate commit.

Ciao,
Dscho
