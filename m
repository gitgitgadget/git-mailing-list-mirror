Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A460C433EF
	for <git@archiver.kernel.org>; Tue, 18 Jan 2022 12:32:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233436AbiARMcn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Jan 2022 07:32:43 -0500
Received: from mout.gmx.net ([212.227.17.20]:37109 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229604AbiARMcm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jan 2022 07:32:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1642509125;
        bh=/JvNdrbvUCFJbZmEKayW2E/PGCNrnhcpYUDJHQ8Nawk=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=DKK+b1WaEoTSoSBahgG9AOtc1+Y09kXy5KSnpYpFI0DxMGglGoFX8b5u5mGiaBTVe
         noy1+xWnMJYK2STFnvvQD/PGVuiO/RUO2ZUXO80QItpiP08h2o2CONCPvACg7OIlp4
         eaYrmNBJSjQvpeNSndQkPvbA7ghmRN1/St+vHAQQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.28.174.184] ([89.1.213.181]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M5fMY-1nFq4V2GnC-0079tp; Tue, 18
 Jan 2022 13:32:05 +0100
Date:   Tue, 18 Jan 2022 13:32:03 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>
Subject: Re: v2.35.0 DEVELOPER=1 regression
In-Reply-To: <xmqqzgny7xo7.fsf@gitster.g>
Message-ID: <nycvar.QRO.7.76.6.2201181308540.2121@tvgsbejvaqbjf.bet>
References: <pull.1152.git.git.1638899124.gitgitgadget@gmail.com>        <8deccc3a1dff7e4f7d613fa63d2781fd1f11f841.1638899124.git.gitgitgadget@gmail.com>        <xmqqlf0w5bbc.fsf@gitster.g>        <YbAVOtYXA1Hf9EtJ@coredump.intra.peff.net>       
 <xmqq4k7j68eg.fsf@gitster.g>        <YbEMnksMEuAz3Nt0@coredump.intra.peff.net>        <211209.867dcekm9h.gmgdl@evledraar.gmail.com>        <YbMWNZCpy578Qu+l@coredump.intra.peff.net>        <220113.86tue7vr6d.gmgdl@evledraar.gmail.com>       
 <YeDUA6NhHuCUkqXf@camp.crustytoothpaste.net>        <xmqqilumayfh.fsf@gitster.g> <xmqqzgny7xo7.fsf@gitster.g>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:IM1ps8nTdb4dUaGf7iGMoVAHUTlsS8RF6mIuCPbnr6CeTCG26we
 TrSaXIIXlR9SxnBpeCciEwDAjmJfLQ4ZPsYWjojdj4Gh7x7Ysj61sNjHrcIQDxz/6GDA4FI
 FumoPtGqsjPaP5JpZl/Df7cys5aA/dois8AtvxsUga9ttEfcfwbJ435iwl+cPJFsQ6es/Ae
 59na5bJGCbJP0LGrtYTHg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:klcTNd0rAgk=:VUvTY5v0Ng8DfsVIrzdPy1
 5EE+mNIsOUNGqilPnporboUWeDQZQhOuFtIH4CdLTq1UFByy36/gJD+wG4egcmLZF1DIKu0K7
 wuRbnrgwo6JS+JbGBuPs97xCQYmo/4tO9nazMJtEADlYBzsvFe1Ksb3drrfKGxp9PIsUe9FDn
 qx9ciV4/yZKzjpk05pbEJripXv4sBlJ9cwv8nNpRDTtLv9vPcMSMLo7FCrFKUVwTMQTA4r1Za
 LW/GtGkkdEOUH3f+slrc0uXdqzBjwrVu3LQ1ZsvDDFK8SMERBcR3581cYKp38ZIpOEBkOqD8c
 aqw6fcdNPYuiHG84Bh2qtb4nmMrCitslBMrDIOV7b1XDj7V+opUwyBDzI/MiyXPBtQCwZjHDk
 6CLSci0MeuTXkJsJYdToGt1qurPP4WkQdv34dQXeRYnPZ8+T0Bdw7rqDJjlnP/FsbtX0dOPb2
 doEFrLdyNGKGhpMJ2U696ZMuD+Flkwbt+MoMdLgp4eiTGVwwqRYo18zsd3FTZHZJt+4Yt2PVE
 Gj2SOCDaN2DTL68rxsijw2Lsyh+ZpZFP1X0yHAF6F9Lvx8mHHqHY7tMeb33yFj/WOvQK+0Y9g
 Oe3/l0FE7osHr7JMj2OzSofmpqCMvXOKgGYaId1BHK7/QlLTbRJ/HP1emshCj8lXlipIz8M1e
 3AUbR2j9u2B78Lj/NwlLpkY6roW2W7JQLyVpAufTLOF9wtwuHhZzlcAYD/M7myguDUpyt4Bxd
 UFclgusnME0WV3GmuAW4dgVJSD9+Azfse0TDIMzECaLr3mUEIa3WQMevkPDzXMlnLB5q3Bjot
 8c4BDg1kkfIeND8o1cHoG85StNLcNZ4SGOnHF1RhmasZy+rcNImyjBxVsRUm3VN/yemvoKh/N
 WU596hRCk09eS7K5yT0dPNPrw2NQC14OV4MEVmuAHNkcZh+oY4uyS/GjrIXp0nAcguLijGXPh
 0P40Abfu7Q163IV93sQL84fp0tSG+lBwaEachHbZZlKMOfka1VOgLLnFqzzd95sbE4vXKwNMm
 9ZHLH/CAg72uc4j+YIVIjfzW89z0o6VCqzeK5MivZzNlC3QKnga/uW5D8SziuFBp120ww+Eak
 1fPLLC5/aC2QQY=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 14 Jan 2022, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
>
> >> I think we had this discussion about FreeBSD before and that's why I
> >> specifically dropped that option from the main makefile.  We can eith=
er
> >> drop that patch, or we can set it to -std=3Dgnu11 and tell folks sett=
ing
> >> DEVELOPER to use a system released in the last five years.  I think w=
e
> >> can be a little stricter with what we require in the case of DEVELOPE=
R
> >> than we might be otherwise.
> >
> > But that is not being stricter, but looser, no?  I thought that the
> > point of -std=3Dgnu99 was to allow us to use C99 features while catchi=
ng
> > use of language features newer than that, and use of -std=3Dgnu11 will
> > defeat half the point, wouldn't it?
>
> If FreeBSD (or any other platform) cannot do "reject features beyond
> C99", I am perfectly OK to drop -std=3Dgnu99 on such a place.
>
> DEVELOPER=3DYesPlease ought to be a collection of settings that helps
> the developers the most.  So on platforms that *can* do "reject
> features beyond C99", I prefer to have it enabled when
> DEVELOPER=3DYesPlease is given.
>
> It seems that -std=3Dgnu99 is only added conditionally even in today's
> config.mak.dev, so it is fine if we dropped -std=3Dgnu99 from there.
> Which means that developers on FreeBSD cannot participate in vetting
> use of features beyond C99, but there are developers on other
> platforms who will, so it's not too bad, I would say.

Plus, we have CI runs that do help us, thanks to setting `DEVELOPER=3D1`
(see https://github.com/git/git/blob/v2.35.0-rc1/ci/lib.sh#L154).

> As config.mak.dev is included after config.mak.uname, something like
> this may be sufficient, perhaps?
>
>  config.mak.dev | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git i/config.mak.dev w/config.mak.dev
> index d4afac6b51..3deb076d5e 100644
> --- i/config.mak.dev
> +++ w/config.mak.dev
> @@ -20,9 +20,14 @@ endif
>  endif
>  endif
>
> +ifneq ($(uname_S),FreeBSD)
>  ifneq ($(or $(filter gcc6,$(COMPILER_FEATURES)),$(filter clang7,$(COMPI=
LER_FEATURES))),)
>  DEVELOPER_CFLAGS +=3D -std=3Dgnu99
>  endif
> +else
> +# FreeBSD cannot limit to C99 because its system headers unconditionall=
y
> +# rely on C11 features.
> +endif
>
>  DEVELOPER_CFLAGS +=3D -Wdeclaration-after-statement
>  DEVELOPER_CFLAGS +=3D -Wformat-security
>

I applied this patch on top of the current tip of `seen`, opened a PR at
https://github.com/gitgitgadget/git/pull/1116. The corresponding FreeBSD
run is here: https://cirrus-ci.com/task/5867558132776960, and it
succeeded.

In addition, I concur that this is the best we can do, and I really would
like to have that patch as soon as possible because it confuses new
contributors when their PR builds fail out of no mistake of their own.

Please count this as a vote for including this patch in -rc2.

Thank you,
Dscho
