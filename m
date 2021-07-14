Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C8E9C12002
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 20:54:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0300F613D0
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 20:54:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbhGNU5Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 16:57:16 -0400
Received: from mout.gmx.net ([212.227.15.18]:56469 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229816AbhGNU5P (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 16:57:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1626296047;
        bh=zmfqGv59TefMozhCXAVxg9fCafnnkdA94p/jGi3EJvE=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=L/jmevjt813sL5VMcxY3bbaJ3Odek8gKCh5976vXb03nhZs37bnwUrseCpffvWt3+
         8+LLyMHEthlqO87XyEgBZ1Bz0Dr7BSRAKBZZzh4YZEwjk0baVmWy1seZ0+CgmI/Ffw
         tjwzMVskhXAawb/XPLnLCqvjbPb/us3FRTpEYROA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.111.2] ([89.1.214.95]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MhD2O-1lYZkD2DEA-00eJDj; Wed, 14
 Jul 2021 22:54:07 +0200
Date:   Wed, 14 Jul 2021 22:54:07 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Ramsay Jones <ramsay@ramsayjones.plus.com>,
        =?UTF-8?Q?=C4=90o=C3=A0n_Tr=E1=BA=A7n_C=C3=B4ng_Danh?= 
        <congdanhqx@gmail.com>
Subject: Re: [PATCH] ci: run `make sparse` as a GitHub workflow
In-Reply-To: <xmqq35sgzy0d.fsf@gitster.g>
Message-ID: <nycvar.QRO.7.76.6.2107142252060.59@tvgsbejvaqbjf.bet>
References: <pull.994.git.1626177086682.gitgitgadget@gmail.com>        <xmqqbl7525w7.fsf@gitster.g>        <nycvar.QRO.7.76.6.2107141124530.76@tvgsbejvaqbjf.bet> <xmqq35sgzy0d.fsf@gitster.g>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:aU0JKHmzUd1rPQlF0Lld2xi9BJ4bWpXcgNb9zxBAp9VkwuC+cSS
 2Wt+u5eWN0A8mC3iDCHWsfe0FWO6Tejp72+4IE4lpDTFf8XaJFVTrzgbam7MYoGJN8T3IXF
 mw3NLbULA2aABqZpn4uP5PYTJ/9CKMp1ZGMzWyKzMrRwVZt8MqieUAxLeGIVOFPFjql2tBk
 Q2+IcbCdEA2uFf3NcIabg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4umw/H2m54k=:PFYXk/gwoaLSBz9iv7iaeD
 6gqV0zKmudDUJ/06wHFKggxzWSMbcOllWCEDgNNE2ElocMaGx83RmfsTXAU3Q5mPC3P+FyuD7
 8tRXbRDkYCGMXAAaTvw81fHS2x98QQ+Bl6FFlQc4uTuPgd18qcFMwTw44h4Q4rp/SPoykx9bp
 deLMSwE/4ex5RE4MzOoBnSap1nJq0KY05akdwm9p106DVd/nLPYor1U5rJcuHPHh2qCIcZ0oa
 dJ6ElsANhmRBE4atHzLPbIK56BspNvT59MLtczS6azB6eCPie7dAizIVsNydgWM8mcj5nUnfi
 fNynx2XX+bocQXyrOEzm6NYd1j/Q2wApYBQzIXWsW07R7PHtS9p4xA/V6B5916DB+gaxQcJ8+
 UAMZudupBNLQVmC+SUHMfqqxNtjwOnJWYPvV9Kd/RS263QjkdmIXPQDvJ+b36sWZZMY75yUrW
 H2zMnhXld1pXyBCiCP9Ler2JJuQQGHv45mcHGWAjOwWTMC9XLwrxeR1J0J2vYuEtGLXbjq2qJ
 tgZgmqvc/i41fIfe1ZbLAd4MuP1JWejbaLx3kqzZ2HiRTRgSNqlh9FiXfoiBZIE2R6LYAwNSp
 l207qzbqgYG7XLaLTcgxAXmH4qw4rwlLOJzXUn8XkFyPo3cvOeXhuttIQwfxebhQUrf4dPGaj
 zbKpvZE4jPkHzY2a7l+vLre+y/3HTZUS2e/iNj5bI3bd8AnkmscBRasxnj8aG26yjwbuMkDVO
 lOEFLgCrJgdkpOJ5IUaRk62yDiJ5MTFEng2DJW9teh/J/BnAZaJsLRMKZaxrU4gW7q9Fla5v7
 HVsRIFZ3HbRjCEg85zgGSneasHMl8G946Lrh+KQ4fYQfpybXbCqmzZPfkHXGigW1tmyhByYVe
 V+G1UGTCBdlYXqjruMfSrrqCAJX3hjJQ1QStvCGtINYyhnJdEGMedxkFopav+iayz1kZEmqhN
 Qbx4W+le/og8Nrmm94o/HUmDrrt2vg5yIcfzg3gVKxhyYeza/E7Ko7Bt1o1mqrDB1djafBG59
 DhobBBt75JuiDbZkR7zBXc1ES3wnPvirKrJZSA3QEV19zrU1xbMCW/jI9YgSiIn1JVc0i+yu7
 xY0dhZj7T5Ocd14wJMtMxcjXLEk1/o/zOFe3yHkFC/Nk1a3vt5RBNzRNg==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 14 Jul 2021, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > Which means that the likelihood of a run to fail increases with the nu=
mber
> > of jobs in said run (even innocuous problems such as transient failure=
s to
> > download an Ubuntu package), and it also makes it much more painful to
> > re-run the entire thing because you may well end up wasting a grand to=
tal
> > of ~370 minutes even if only a 30-second-job would need to be re-run.
> >
> > Having said that, I think you're right and the upside of keeping thing=
s
> > together may outweigh that downside.
>
> I wasn't make a request or a demand to change or not to change
> anything, so in this particular exchange there was no point where I
> was right (or wrong, for that matter ;-).  I was asking if there was
> a solid reasoning behind the split, and if there is, I am perfectly
> happy to see it done as a separate workflow with the log message
> that explains why it is separate.  I am also perfectly fine with
> this rolled into the primary one, with clear reasoning behind the
> choice recorded in the log message.

I do not think that it would be an improvement to defend the default
choice (i.e. to add this new job to `.github/workflows/main.yml`) in the
commit message. It is the default for new CI stuff to go, after all, and
we do not need to clutter the message by stating the obvious.

Ciao,
Dscho
