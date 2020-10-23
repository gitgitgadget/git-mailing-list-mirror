Return-Path: <SRS0=cWhr=D6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E4AEC388F9
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 15:48:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FF7F21D47
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 15:48:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="GkcacWtD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S463693AbgJWPsl (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Oct 2020 11:48:41 -0400
Received: from mout.gmx.net ([212.227.17.20]:33607 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S463638AbgJWPsk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Oct 2020 11:48:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1603468113;
        bh=lgJ9TYWEOjULnWmqTnAB+0AzaL7ISua+Ec7ovNYcUEw=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=GkcacWtD5erxugVT/Vm2cejs5LjPrUqEhu85VGb8A0v2EBCErPuusDCn1ovCuzOoZ
         7y3+xyVv2KlMWicuChlnx0ftHT4ZxD7wbmwxtKUmUZZB+PFGQBx4zmvsqywFU23pg4
         RpYW2mIoQfZgft0ZpIXVlicqSEgPoitrWMbAeyM0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.26.25.62] ([89.1.213.182]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1McYCb-1k0DrJ3h89-00cxe2; Fri, 23
 Oct 2020 17:48:32 +0200
Date:   Fri, 23 Oct 2020 10:37:24 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Phillip Wood <phillip.wood123@gmail.com>,
        phillip.wood@dunelm.org.uk,
        Sangeeta via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Sangeeta <sangunb09@gmail.com>
Subject: Re: [PATCH][OUTREACHY] bisect: allow `git bisect` to run from
 subdirectory
In-Reply-To: <xmqqzh4embt5.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2010231036180.56@tvgsbejvaqbjf.bet>
References: <pull.765.git.1603271344522.gitgitgadget@gmail.com> <2f71d0c4-a5de-c22b-9cbe-a9efcb3cd21d@gmail.com> <nycvar.QRO.7.76.6.2010221042260.56@tvgsbejvaqbjf.bet> <46b208d8-3741-d528-c833-aea5770a502c@gmail.com>
 <xmqqzh4embt5.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:9iA6DqKehuYbHKzDXumiHQmpu4jfiK5DgZKKL5lNZUV/kQrM3x9
 DS6ONgG9qBwJPEFZvbzn5rPKx34Ckw0m/KynJs5lcKTTvS3aU3Mjj1FoEPSC4x3X7ukqo7j
 w4pcYvijE+wvIeM1rMgKplwSjgj500xFokXhtLdHMBMMouFyvttu0YT9YlHCiRARWGH10KK
 OXb8VMOW2CquutO9Ae+MQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:tX/IgvTJyP0=:MV0FHFBivbCbbpPLX048NA
 KvyykehXvxVsHhnJIyAQMjQ+N4YZRc1BYPlMiBDzE+85CoOqZR59/JFaVFiQ9xMmvtQ2In9CC
 pMV83YqekM3yPHPB+xunD+7FQRCE3l7Px4eREiEtKYEAenJCAGkYTjiC+pg2bSbeSgRVRslxC
 oU36xRFhZLyzkEUbT7PxHKIOJ8DSFC5U1XJZsu2G5GlPe3t+/siugAsHRivaRLx+RBlF+5+/g
 iGObBNA/XukAoPeD+q/CJiuDAXtQU5p1aPpksgx+qSb5ms92rLpt9zSLojZaTYTASMgN+bqsP
 nUm8IT2SEkRuAqc29RaJdThTqMvR7AKJXxMhde65e8Dn9GRTcNxlp7BC3WqW1B/wBv1PCXIF3
 Gy4n83Q6xo+D6j+FF6Rbu8AKFlzSAJXHM+bRTJSqEUOeTrLX5XuL3izczvSiwQg98L0UTggRT
 g5yKwB6fXb2mJhavZzWkoB3Fk3u6wFxRzKy1KRgXTnl73sA87Z6NjnXeaKRfC4Q2vrObWGn9J
 /XYdFvGENyMcTN2/HMrXlhNanrgJPGCMnBV1kX5Dy62GuzS2VaNamKRkaB03AKuEQiYJnNUTO
 otTF63qqN8teXKeLaqIOc3fc+9ilKda0t/oBO2E/8ng7UsrD9U0Mpx5rz/2eGj9bj2k8yK0+6
 tINpCHh3LkAl/lc/7zipDDvnM/Y9M+0APd/+62r0qOH8Qkc8yegFPz9R2VI/HeLNFhovb9z3v
 9MObaPg1FqDQrzyH8ai+w6P/H8pEJPtw1XR4V/OR8oU06jTJTEX0WC+ZBuHlHH1lgUeEyeM2M
 I4HpSxyMo0K15emd/F4rgHNJEOp9wQ8QfhVONvJwtPxNWNdwz3W6tJye97LNrnEvz23t0hzhZ
 +jnmxMcbPA9pjdPplYkoF00rGjDKRGyaOdinCsDDw=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 22 Oct 2020, Junio C Hamano wrote:

> Phillip Wood <phillip.wood123@gmail.com> writes:
>
> >> The relevance is this: _iff_ we want to prevent `git bisect` from
> >> running
> >> in a subdirectory under the premise that that subdirectory might need=
 to
> >> be removed, then why don't we prevent `git rebase` from running in a
> >> subdirectory when that command is equally likely to remove that
> >> subdirectory?
> >
> > That's a good point, I'd completely missed the analogy with `rebase --=
exec`
>
> I concur.  Perhaps we should make rebase a bit more careful.

That might be a rabbit hole that's a little too deep. If we want to make
rebase a bit more careful, we then also must make `git -C ..` more
careful. And `git -C ../..`...

I am fairly certain that I don't want to go there.

Ciao,
Dscho
