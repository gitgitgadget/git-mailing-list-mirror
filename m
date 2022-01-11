Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01884C433F5
	for <git@archiver.kernel.org>; Tue, 11 Jan 2022 22:33:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243642AbiAKWdx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Jan 2022 17:33:53 -0500
Received: from mout.gmx.net ([212.227.15.19]:47277 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233798AbiAKWdw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jan 2022 17:33:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1641940423;
        bh=2UZIbFfwwqkJmgLs4g0KP7nmTEzqdbkn8HK/WvCMlQc=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=EnwYqndbCTzu3Hy3zCRaIboqoj0IewR5O7SChnwgIIQ8wGlDd5tlCgpqIpjUG4azY
         I2IGV/USUZUKknpjK2AclXBq8NXa55jM6NHuQ28Ot0xs95pRlghNzIOXXWgcli3zkh
         81SwaT2rVF2+ku8cmQR4zK79VGjOjSSz/cI0zKXQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.24.82.111] ([89.1.215.56]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Msq2E-1mEdCR1JAO-00tCXS; Tue, 11
 Jan 2022 23:33:43 +0100
Date:   Tue, 11 Jan 2022 23:33:41 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org, reiter.christoph@gmail.com,
        =?UTF-8?Q?Matthias_A=C3=9Fhauer?= <mha1993@live.de>,
        =?UTF-8?Q?Matthias_A=C3=9Fhauer_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>
Subject: Re: [PATCH] lazyload: use correct calling conventions
In-Reply-To: <nycvar.QRO.7.76.6.2201111412300.1081@tvgsbejvaqbjf.bet>
Message-ID: <nycvar.QRO.7.76.6.2201112330480.1081@tvgsbejvaqbjf.bet>
References: <pull.1181.git.git.1641657750776.gitgitgadget@gmail.com> <xmqqh7abxmxs.fsf@gitster.g> <nycvar.QRO.7.76.6.2201111412300.1081@tvgsbejvaqbjf.bet>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:C9os8I04aS3EGEK6PUT39A//W/e5kyVIucMbDYlixqZ88aZr7sS
 GYiogrmlzFFHajkYm9s+1ZqpcX198XzRRlOmHLVhF/iLoUot3uZeJe+xPvLkZltw3s79JFK
 LNMT+AGVDMqyT2omb63zNFEFImnTA2MUl088P9n6H9kGcQ5R2qw7EdfVxp30DPshvtMWiXZ
 ti1BSFzVKEpL7eTHhxK5A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:uTNmqz7DdS0=:xWidoYeZBsQ+HLO6I1CBxD
 aS/8pFd8pizMOaGjtPLRsukzBALftV8Nce8HliCt8rGEFaa84ma9H0ok+qQD8GtQAMZiuTINl
 v+nccfHE0Svd8Suugt28HSkr+D9pRTkfLBTIdgcllKe34iMXhb4dJS2BKhFZ8nLqGq0Ul79Ke
 o1/2bFnbiKZI5STdLEBvIuonJrmUNdwwvXIXHFCpPGlkNTcsmAF6VM/U8DG5Fi6UXxU9GyOFs
 bOYJBDuzQ/qGrF9cuQ6AwScaL5DTBbJVnOdmt9uYJ/AWDSIgYu6V8H9RMbXecpca8C8LpYRV7
 zajYQ4wV2OxYbuiMcRz+U1ETnO/vyKtfEn3CmkXS01blqhGiKHGLZMLzjrcqYBERr2VYBBxDo
 SyUQnFCcOtlXEBX26cIoC+cb5oFK5JLYXHdc/x83f3GVQ2psBuDcTrKh0TjBz4VeKVO3C25sP
 5kRamZVSCRMqJol+z0ZyWGMoQJ4nO5SaLmDcYqovnCkqniWKEoXvV0i9382Tw02mchfTRJHCf
 MB/v85gxjlyWipj3knobDy97mvOvNHNPmkEAC+U2vYbYX++ULz9600MHhYndj3EOfkZzlSLWk
 LHnSnKmL+twQSLUNePesWQ+eeldeszeUHdaEpwJGTnqwZ7WazJ30LCLwt7+hAvdLd3is3jkz8
 gafIofC5YOKkkrEzBltK/pu9zUhKdtywwaEZPQV2P4F4QQ/qxHVvxrY4zPDIicJvG4UJ43yxk
 oBGW4j+ZEpoo6OwHusoXURD4JV1bYZMo+ClTcFubjt4InPzsOU4+Cg/c1AkNczJwgosNl+DWJ
 WyE5lkasbUNR+rwRB1OQ3yoRLh/6h4wFKHyMVugVIDzYzeFmYPJb8xtPQh3EwA15CMk45gF1X
 kv8SOunGd1E5BX3/fPUfCAWMd0ZMAPWIiy3K2ekN3TvBqQT/0A9se02djHqh69Y1FkKLLbsH1
 Asni0arFeoyGDlPIrtqgTxMtN/K1COz8siCp4u97KUlRAbcjRMcXFscFeRGPYb1/W79D+Q1Az
 3Ugis+yd3KTt5HRODU6gM5zVqSlUVwUJDaoeMjT1cQqYmy6HY5ZvbNphYDDQlKFgHiUCqUJ38
 dnqw7YuPnv6R6c=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 11 Jan 2022, Johannes Schindelin wrote:

> On Mon, 10 Jan 2022, Junio C Hamano wrote:
>
> > Dscho, how does this look?  My choices are
> >
> >  - Waiting for review.
> >  - Will merge to 'next'.
> >  - Will merge to 'next' and then to 'master'.
>
> My preference is the last option, merge it down quickly.
>
> > The last one will make it as part of Git 2.35.0 final, unless there
> > is some unexpected breakage found later.
>
> I do not expect anything to break. Just like Matthias, I actually expect
> future breakages to be fended off by this.

And that future is here already. We just got a report of a problem that is
resolved by Matthias' patch:
https://github.com/git-for-windows/git/pull/3624

> Merging it into v2.35.0 final will require a tiny fixup in
> `compat/win32/flush.c` (which we carry in Git for Windows already),
> [...]

And I did that, and opened a PR already, which I plan on merging soon:
https://github.com/git-for-windows/git/pull/3626

Ciao,
Dscho
