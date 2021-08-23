Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6115AC4338F
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 20:27:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4321C60E97
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 20:27:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232563AbhHWU2g (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Aug 2021 16:28:36 -0400
Received: from mout.gmx.net ([212.227.15.18]:53245 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231569AbhHWU2f (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Aug 2021 16:28:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1629750467;
        bh=hPXSS8Qvi+NbpX0TYmeb/Z0i2MNIbF7k53HiseksmiY=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=WEbVMbrRgLvZy5WT+h1Lu2siDqXspWATwAblPTOYByfV/pmSNVfwLkm0GeMn//Djb
         WJcT1dOuU4S+7RdcR81bs+EG+t0PIXMosovswpy0LQPAZRi0gLUKLlOu0NuZ4Fbwdr
         4fRe1bUoxWjcCmDRiEb9UDM8bOHSAFvXm+QwRfSw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.30.86.215] ([89.1.214.7]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MwwZd-1nGinQ187H-00yQpu; Mon, 23
 Aug 2021 22:27:47 +0200
Date:   Mon, 23 Aug 2021 22:27:45 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] compat: let git_mmap use malloc(3) directly
In-Reply-To: <9c2fe5de-be23-3e66-6edf-3c2edfb804f3@web.de>
Message-ID: <nycvar.QRO.7.76.6.2108232227140.55@tvgsbejvaqbjf.bet>
References: <9c2fe5de-be23-3e66-6edf-3c2edfb804f3@web.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-2027710095-1629750467=:55"
X-Provags-ID: V03:K1:tRPIXpDE1hjtfdxaXDlmcynKmp5BR6BvyvgonsaXuFP4GtfCkDq
 1bLfQyaig4iBhbAKjl52ZOjgw2VkMV06XN4yXiRbkJDNuV90mBArciwHWe6qUaPLpJ1IA1g
 CiqigSmee/JtUAoMjIKD9YrBRfRHFxmmmCf70SnMz7v3gSC4ncPf55DeNuijmE9o2dEzLtE
 aHRnp7WsHQ999G5TYU0oA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:dei9FGgCq90=:LI32MWWbTo5NL4fvahPOpo
 hIeeN4vvRwNecPvzCUasE/915eaX/DmdW0H4KujwSL0+jRX7kteD4yZY11DXIHPJL/wjPrz26
 Zx3wkGp/MnLiiJf/mGiDdrZ8qZHDXGYdHy5BNHHS6yKiBhE9sLaynomade1vdza34+1Uegnhb
 HHxEMf0M7kwPOJdZLvINlNj22CNbCzFIMmoD1NV4fCQSt3fVtc5tjmFtVdUMmy0P2imANchpg
 +z+djHLPgHXgdzoisqk5QW0VNJO7uFIocrJJUk7auERyMmFuL7Rty/Qaqs+9nmKI4Nf3dZrqz
 eInMXFkZSOif0b1jIb57ROUBwM2Agr7T/n9imP79FkQZiR1sVqmFRCALr442cmmaWJZLccGOM
 a/9gfex7xPX2xa0T826o2DcCtcdnWwy/4u1AWmzue14jLhPnfU9ZX4cwswoJ1jveGxHq0ZK+l
 LrE5+sd4v386BGO+97ZOECIMpf8sAbTjE8Mm6d8Xl9OYo4fK5S8OSovaj3KQMhHnOjPvlkc6E
 fFxP17kwyBPPiT3lsOLZ7VSe5Z+285H6QjLiXUvjK4Ph42+Wzi12E2vHsUODZfx5Lx3Xs7Gsb
 LOPGr118txO1RO28rB07TiFkC3KKo/0UjC3RtZBhifqwL8C2C08Io37pj79EInTrdUXv3PtHV
 gEYfHx9XgbUUdkCTyTy+ugx7NPTW/4cy2w0DkMsWdVeF+7iZsTw/+r8vKP2Fi5H+FIm/nLVC8
 bq6sYZ4h1PqCB8AGYiKD4PHNkkYO6nhDO5lOk3ecQjVUPrCcRN5FBX5JbljBLqcU4rjkSoLEa
 JBzpaLfSVdroF+q3C+CyVaC6w2oGc/dpRjIURV5Z8jVOH9BYviK6Bg8YcIoXE5TiEM5lvwBGQ
 Cvb/CBMyRmh92Yze3Zh+weeRvFFwAjamjXE5NzJ5l/IU9MMH9DPcjnKEjmvGOHAnptsy0nlqZ
 /D8VFWjzoO12y9sbY+r1YXPOBedhL5XSEik77iTaSS30LEhUAfeCJdJdEiUjs6RrO7Vbd5cci
 jgIAv6rqgiu5UoYx9osvgbXPxuDqNzEapbYO61t2iDF8rl8IohO9dartYVDTU1gbM1Ffa4pxU
 90pCuCiyZS15u/laD43qyZCMlsRJ9pxS0SR33owNFU+Raw0a3NV2tCyrA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2027710095-1629750467=:55
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Ren=C3=A9,

On Sat, 21 Aug 2021, Ren=C3=A9 Scharfe wrote:

> xmalloc() dies on error, allows zero-sized allocations and enforces
> GIT_ALLOC_LIMIT for testing.  Our mmap replacement doesn't need any of
> that.  Let's cut out the wrapper, reject zero-sized requests as required
> by POSIX and use malloc(3) directly.  Allocation errors were needlessly
> handled by git_mmap() before; this code becomes reachable now.

Acked-by: Johannes Schindelin <johannes.schindelin@gmx.de>

Thanks!
Dscho

>
> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
> ---
>  compat/mmap.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/compat/mmap.c b/compat/mmap.c
> index 14d31010df..8d6c02d4bc 100644
> --- a/compat/mmap.c
> +++ b/compat/mmap.c
> @@ -7,7 +7,12 @@ void *git_mmap(void *start, size_t length, int prot, in=
t flags, int fd, off_t of
>  	if (start !=3D NULL || flags !=3D MAP_PRIVATE || prot !=3D PROT_READ)
>  		die("Invalid usage of mmap when built with NO_MMAP");
>
> -	start =3D xmalloc(length);
> +	if (length =3D=3D 0) {
> +		errno =3D EINVAL;
> +		return MAP_FAILED;
> +	}
> +
> +	start =3D malloc(length);
>  	if (start =3D=3D NULL) {
>  		errno =3D ENOMEM;
>  		return MAP_FAILED;
> --
> 2.33.0
>

--8323328-2027710095-1629750467=:55--
