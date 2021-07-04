Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81186C07E95
	for <git@archiver.kernel.org>; Sun,  4 Jul 2021 22:37:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57F5561396
	for <git@archiver.kernel.org>; Sun,  4 Jul 2021 22:37:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbhGDWkI (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 4 Jul 2021 18:40:08 -0400
Received: from mout.gmx.net ([212.227.15.18]:36727 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229549AbhGDWkH (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Jul 2021 18:40:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1625438250;
        bh=+9pMIxiSYXeynWmrPkhVoMsPGpRE8cP/SAQbtsGxpII=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=f4QlSSWqNz/5Kq+nbrVjiEArdyG9kBU2ep5nzzqaublzCxpmzVGhT9HC7ZME0z48d
         Mz+H+TwnhIC8mWd/THvXPCL7pJ4AaAzWkF1P/jKIskSeqrTQ1RqVaWm5GGK72Mnrsz
         Nx+O1CnS+Ho0gI2v0o+EARzFsFkwuy/S39zpeyxk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.249.152] ([89.1.213.17]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N4QsO-1l1Iyt3k9O-011QaS; Mon, 05
 Jul 2021 00:37:30 +0200
Date:   Mon, 5 Jul 2021 00:37:28 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2 7/7] ci: accelerate the checkout
In-Reply-To: <8735su8nkk.fsf@evledraar.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2107050036220.8230@tvgsbejvaqbjf.bet>
References: <pull.878.git.1624461857.gitgitgadget@gmail.com> <pull.878.v2.git.1625347592.gitgitgadget@gmail.com> <88a44863cd013fc9c152ff91cf109fd7b1073257.1625347592.git.gitgitgadget@gmail.com> <8735su8nkk.fsf@evledraar.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-602958541-1625438250=:8230"
X-Provags-ID: V03:K1:Gq+42/ilrIxgxtQzqBt7x8X5lNqxOpgWMC2uCB2dNeZIC0MdJ8D
 LMUvXEQGK06m4uk2365LwZgIQiaIAcef01BI8QMLThRTOmtNiTi1V/XTug/RZk/iqA9UsPp
 /mHvionC2e5RV5c8t1aGSmF/DrGJvX5pb5Q/oGJHTWFiFxqjbV8D+zAOKo/9BsmRsyyYLMW
 hxRGCj/vwiuvDJVMJdHyA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:V77Y4yvmGvc=:clckMnqHNm6Na6WvMvDdvg
 sHFXNFhT+gQI9+nJqia/+E27eWJJ0Ot+r8o6xW4jcN9ze4SbRlqy93c0T1WEBg9pzGUQpEgip
 b+tuC6iFYxu3y2GK+EBCXI0QstAaSGR1woZVjBhyDw7vq4pGEo/Lby36XsL0SAqiYcAfXkMHN
 AR39/hHcfIAfrUKRBWvdf+fq5MoLQUOBPmGFNLwk1bs+T5rr2mPfG53SurSCIkA8wxgMCzLRM
 rR5k0RM9CGu1tD2UDciJZ3hCkgIV0K5zItjSc0kpFVtVzJN9CvMv2XXs4Q+6UxHJHbGRYEtrs
 a4wwFtJ8/+tmEG5vDhJ7xPYZ2xyykBmJUlN6CdRLfSdFKC+T/L8OGfWF9TbOiGvwL6p/3nSzE
 F1q1QGCVBnpnLlXJjXh3t/rT8fzjVb6tzeXe3uMxRssqyWETUCqiCYzRkZAMjaJHkSzJfgWB2
 3vDoWDnpfXa0WcQmXzP2rnbdEyocwkI1cQfxtrTGkZjkpvSXgKqzF6aGCokzgWMkDJGPsj5jR
 iNh3Ie6oVEV/ZctjgvTnSyRyp1BkrTjbGIZAA+2/h2EPD3P+iLdkEeT7dquqSACfDaf0JVGwq
 jUAj51yYiDQjqdhBArTlMbCyUYBfiVGNg9cd0kEYevkgNVK0abDiPaZ6Ty922Xk2s/LXYZE5h
 qVQ7wsriMNsK7suiNzt8/kg12q86Q/UOo81duW3/jYRJ/m8rhEYog8DAJAUwWTcnjYzM82m63
 s4/nuI5QcK/gfcD90EdxDEyiGX9e5F40FbZkAfgQeWsCygFxL+yXYV2rSZwAnRkVybIg3Ydmm
 jxArtNDVIgb8FNrvvuH6xwtg6SrhhwPJtGfvXUQyPq+XWmbvgcuUcA04r51TJRbO8HyOYrudM
 jCpbwWf50YMME/c53Z6NjSZTyXXhms+ZYgog3gcVlrz1eIu7BUmfxSucEw15QgOwexBllL+xk
 GVmxtDgCz4aqX5/M0AaRmE9YX9/Jsf6TjBPvkL6cH9d7Ut5xhW3vtIL9JzNDH8Qu8TaWiIb2f
 XE+RuNJD3WCj1qNiTiT9sl3cdvjqjnwJAKeZ4gdFefhO+i4Jv1/af9xx6jgakNixF5qwyD8ee
 fSr8mCv9wbEzTJe+uKIWOzOQKBGlH2w1UEQn2l6xQto0dvBaihaQB4AxQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-602958541-1625438250=:8230
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi =C3=86var,

On Sun, 4 Jul 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

>
> On Sat, Jul 03 2021, Johannes Schindelin via GitGitGadget wrote:
>
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > By upgrading from v1 to v2 of `actions/checkout`, we avoid fetching al=
l
> > the tags and the complete history: v2 only fetches one revision by
> > default. This should make things a lot faster.
> >
> > Note that `actions/checkout@v2` seems to be incompatible with running =
in
> > containers: https://github.com/actions/checkout/issues/151. Therefore,
> > we stick with v1 there.
>
> I'd suggest that we shouldn't link to a "closed" issue here and instead
> to what seems to be the successor issue:
> https://github.com/actions/checkout/issues/334

I'd suggest that we can still link to this issue, even if it was closed
without the bug actually having been fixed. The ticket describes the
problem well.

> But looking at #151 most of the issue is a bazillion commit references
> to this commit being rebased again and again, seems like github isn't
> especially well set up for the "spam" our perpetual rebasing of the same
> commits causes :)

Sure, blame me.

Ciao,
Dscho

--8323328-602958541-1625438250=:8230--
