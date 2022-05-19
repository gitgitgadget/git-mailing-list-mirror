Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF3FFC433F5
	for <git@archiver.kernel.org>; Thu, 19 May 2022 12:49:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237965AbiESMs4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 May 2022 08:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237337AbiESMsy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 May 2022 08:48:54 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57C26B41CD
        for <git@vger.kernel.org>; Thu, 19 May 2022 05:48:53 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id m1so4599920qkn.10
        for <git@vger.kernel.org>; Thu, 19 May 2022 05:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GMyVD0gabRpdLcJ9ktWl6tn+p99bE5Vh1ivItf3pYBo=;
        b=pCeRCbs2mfcWtpkRAKWHvKREhsBPemO9g4khVmI0kwPd3tap7mEhGJ7Wn0PuvEL4wU
         gk65MAZ/1KodefrHGUw3ELP55ZjAou8y2A6YnzzpP297Be+5FXtg6Hu0iqhfe29YPgrQ
         oCgbF4f4LmAv97FWbmsa1cNN2vI3+M/yRIga9S4MwZwnEDvdLLAPoRHy4tnk5aqu2dHL
         DaWFQuds6C66Z35tlz3L6cL4LBCjPU/X8oo6AR2053wK0kEcxMUy6cnrrOi9Fmfdx+tm
         eV4jnKzK/jjVArVWEQimiGXA33jSTJ60ln5AuRwOjhOM38f5cUHcGB77ogRX+mL58dpn
         OgMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GMyVD0gabRpdLcJ9ktWl6tn+p99bE5Vh1ivItf3pYBo=;
        b=2EXm4pim1muDjtBb4niG5hHxBSfHGumpw/unSgTA8w4Gb9hcN+bcZP4rZ3XAgU7Tdj
         eGcmrfCL12GPqd6cSrk0RuQLAyOWGaPi9DgAefPlDiyybC5Oa+5FRUXTgmmIe4qkSNWi
         p1kbRdFgkEmpcbSqdU4chE/lod14z50N3ez8E3bMEvD+IvsnAhZEyKde5kyUPePuq1TJ
         Ow4bV+/RDtDK5uRbOtYKcPNruyQkEXAvkIHnexImWJU2VD4fAJnxU0iibs0i2jmsAQqo
         Bowf/Y7m+09eqjwa+YPX09OUIqfECW7/y/xnX5qMIPN0l0bht2Td0i6+LgyxpadwItiS
         0xjA==
X-Gm-Message-State: AOAM532VBuRc5Str6nBRvOYawU/UouPPzzTcA8pCCTJjfrSykPRoqlhD
        5Cc9uqrLuTi1aFTZWssRxqVzIl9hkU38DSnNV8g=
X-Google-Smtp-Source: ABdhPJz1VWL2xfgeFXkrzSFFIX1bO4pUtNjniztVbXeUeCf17YU/Iqb4q3LdvJ48Zmcf3B41441zkCV0T1IiaaX/6Sk=
X-Received: by 2002:a05:620a:573:b0:69f:cf74:720 with SMTP id
 p19-20020a05620a057300b0069fcf740720mr2772857qkp.683.1652964532531; Thu, 19
 May 2022 05:48:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220503132354.9567-1-worldhello.net@gmail.com>
 <20220519081548.3380-3-worldhello.net@gmail.com> <220519.86pmk96fhv.gmgdl@evledraar.gmail.com>
In-Reply-To: <220519.86pmk96fhv.gmgdl@evledraar.gmail.com>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Thu, 19 May 2022 20:48:41 +0800
Message-ID: <CANYiYbGCwOCviu0x+2OJWR=AFWt1LwnZsN5DfB=C0ywdzz6HzQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/9] Makefile: generate "po/git.pot" from stable LOCALIZED_C
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Alexander Shopov <ash@kambanaria.org>,
        Jordi Mas <jmas@softcatala.org>,
        =?UTF-8?Q?Matthias_R=C3=BCster?= <matthias.ruester@gmail.com>,
        Jimmy Angelakos <vyruss@hellug.gr>,
        =?UTF-8?Q?Christopher_D=C3=ADaz?= <christopher.diaz.riv@gmail.com>,
        =?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Alessandro Menti <alessandro.menti@alessandromenti.it>,
        Gwan-gyeong Mun <elongbug@gmail.com>, Arusekk <arek_koz@o2.pl>,
        Daniel Santos <dacs.git@brilhante.top>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Peter Krefting <peter@softwolves.pp.se>,
        Emir SARI <bitigchi@me.com>,
        =?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
        Fangyi Zhou <me@fangyi.io>, Yi-Jyun Pan <pan93412@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 19, 2022 at 5:25 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> > diff --git a/Makefile b/Makefile
> > index 83e968e2a4..60ca42c268 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -2714,7 +2714,8 @@ XGETTEXT_FLAGS_SH =3D $(XGETTEXT_FLAGS) --languag=
e=3DShell \
> >       --keyword=3Dgettextln --keyword=3Deval_gettextln
> >  XGETTEXT_FLAGS_PERL =3D $(XGETTEXT_FLAGS) --language=3DPerl \
> >       --keyword=3D__ --keyword=3DN__ --keyword=3D"__n:1,2"
> > -LOCALIZED_C =3D $(C_OBJ:o=3Dc) $(LIB_H) $(GENERATED_H)
> > +LOCALIZED_C =3D $(FOUND_C_SOURCES) $(SCALAR_SOURCES) \
> > +           $(FOUND_H_SOURCES) $(GENERATED_H)
>
> The SCALAR_SOURCES seems snuck in here, but it's worth noting in the
> commit message that we effectively had it here before as part of C_OBJ.

Agree.
