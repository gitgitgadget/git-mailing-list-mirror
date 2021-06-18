Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B686C48BDF
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 13:24:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3251E613ED
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 13:24:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232279AbhFRN0m (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Jun 2021 09:26:42 -0400
Received: from mout.gmx.net ([212.227.15.18]:43411 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231809AbhFRN0l (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jun 2021 09:26:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1624022668;
        bh=Vs/+tdB2WY3imsOcePSZ07JOQvI5EWGfFYnDPCiuFUE=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=BfPvPQZJstSSaPZNuo9hyQyCGi7Ir/GXHUX8oIODgcX4TLZ9DqBAJr6PpcE+AHRTO
         DRJ2o0bnddFlJ8lJFPKx7jHeCMGFIHZMXV4RZcGHRXyLZPVNcjcd1sRU6AameIrmlt
         kW4uSUVVRsZ3qJG9x7R6yXXWB3iiBEBwXD9a9EsM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.24.14.142] ([89.1.214.113]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MDhhN-1m2mo03Vqh-00AjBc; Fri, 18
 Jun 2021 15:24:27 +0200
Date:   Fri, 18 Jun 2021 15:24:26 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Simon Hausmann <simon@lst.de>
cc:     dorgon chang via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, dorgon chang <dorgonman@hotmail.com>
Subject: Re: [PATCH] git-p4: fix failed submit by skip non-text data files
In-Reply-To: <YMsveynHB8MNiz+S@bagger.lan>
Message-ID: <nycvar.QRO.7.76.6.2106181523090.57@tvgsbejvaqbjf.bet>
References: <pull.977.git.git.1615535270135.gitgitgadget@gmail.com> <YMsveynHB8MNiz+S@bagger.lan>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:gE8FRj7N8YB8l+Ny39sFTfqYQpkdvvQ5/1gBT3A6ps0NkD+zv+A
 PS23Jp1CtUJ0dK/vimqfQoUROB0M5PC91kE3vPmEclpK7FxWGrclqY+ctr0s/C1hGQOHy/x
 GsX6WW4jnkX4bgOwpLysVBuSL7sqTPoPZ3MII8AYa1tzEgRjoc3GMsGWXQ3kq26VinyoPkS
 MC9uLkDUNPGeXEPA9PUrg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:BR5uLkIOvn8=:baFdgQ++EoJ6k6H4D9ymOO
 kcoroIr6Ej01RagSO3j7hjwt9vIq2dF6sM1q3h41MhQXo2XXOGaD2sowTl/CBtltqwefRojWZ
 +35t+G6wYn/wB0nIUAQU509yKBFOQmrMMByCe1hLtaWHe/VriCE5nktJn0MOr9BmF90mAhUzb
 ZLuXCuTUEE9voixX7C+IfqP7RH19NYFD9yo/Z/onpClT0pjNJiRi6aHFDdRJvs8qtDDcwOSsU
 MLtXED0XL08C4KvkHWIcQXhk7CCXhAFTTxB8wQYiJnQjrytjigE+HixqWKo0JRiRlHNlbjsN0
 uQYRMt3ZnGYTwp2raPqcGPjJtuqoM6WFiTqK9WsQxL3a3xjw/OmfYNLSxv2k8q8sm4sTgDUYr
 S9cn6ImA/LicascB3E0JkLlpiH+OLznlk74QzJWnIzThstxolCK3OJL139c/P82G7MJpFGqcd
 ETzp6Zhl1CWHTYbNKxpJS88BKfysgfr87sNt1YtjR2SZcR0UIoH5fr0xLusg08Vn4i3C4WjSi
 kvz3kgC9hKWxSc0mZ6Yh1qaOeHSKroM7kmbFa0iRIRlQIlCts06ewWyi3ay4aL+wGdyh639q2
 +8hxHELHY/m2Y886v7oB/6vMJwYEB9GbS/W2uIV3eWnRSi1F62eZlVesJra8FEDyUGzVkZrxN
 BIjUeKxi8CyykodH6Jrp4STyYH3FvQIGQ206+bAdF11UGeOJWMdEGt2rcMOUqMF51wh9VQCgG
 +JRE9PDQFQclqp0kdB0GRoZ5R4fYwf6M3Ee8ut8m69JnssPdZTE1KrwWg+JB2InnSnZvQVSt5
 DKYQz5Cqx3UoWSykdMOZAPkQB24lxJJgT4bdN+kT/DNwVSDmUFqzhNbPLfzJR0ACmqf39gNTf
 X/je6Y1Zrgl9Z96yjhZyL6vPIEQFDJENH5cENiISGkbhCurLSrXduCE8QDKLE9FC3o7znLDo+
 kdQUutAjxi6OQI5J0P+p/UbB+dQ8QF44cyRvofVfaF9fewW+HH1gs3pgyd75boenqQGjhbRne
 C0oHLcRDETicMZJDWjCb25N2uh4beEGi1ky8fxIJ+PpGM0m/piflntDfsHPKSVfbUrkdylfvm
 HNNrwxxc8WW7YSXxjQCiOdXpjmmzv11Lbfjuvq3mJvVdB2jHUkpmSqqlQ==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Simon,

On Thu, 17 Jun 2021, Simon Hausmann wrote:

> On Fri, Mar 12, 2021 at 07:47:49AM +0000, dorgon chang via GitGitGadget =
wrote:
> > From: "dorgon.chang" <dorgonman@hotmail.com>
> >
> > If the submit contain binary files, it will throw exception and stop s=
ubmit when try to append diff line description.
> >
> > This commit will skip non-text data files when exception UnicodeDecode=
Error thrown.
> >
> > Signed-off-by: dorgon.chang <dorgonman@hotmail.com>
>
> As suggested on
> https://github.com/git/git/pull/977#issuecomment-862197824, I'm happy to
> state that the patch looks good to me. IIRC the diff there is solely for
> the submit template, so it should only include text. That your patch
> ensures in what seems an idiomatic way.

Thank you for reviewing and chiming in.

> Signed-off-by: Simon Hausmann <simon@lst.de>

The typical way to record your review is to say `Reviewed-by:`. The
`Signed-off-by:` footer is usually used to indicate that you wrote the
patch, or that you shepherd it onto the Git mailing list.

Sorry to be so nit-picky...

Thanks,
Dscho
