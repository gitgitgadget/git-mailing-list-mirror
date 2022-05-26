Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFCBCC433EF
	for <git@archiver.kernel.org>; Thu, 26 May 2022 11:07:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245114AbiEZLHK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 May 2022 07:07:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347205AbiEZLG7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 May 2022 07:06:59 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 773DCC966A
        for <git@vger.kernel.org>; Thu, 26 May 2022 04:06:39 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id hh4so1214555qtb.10
        for <git@vger.kernel.org>; Thu, 26 May 2022 04:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NrL9hd4Wqwj91FT0S6XAmdlMViF2awh5gSoyfYWTPmg=;
        b=M9h17twNEySu7CiD0xGHqZPT8Yrb+v2TPzpppPzZcGDQrKqN5/AdpX6hVfHeEpPL8n
         EvrEaP6f6mV5+LOdDe+CPgrqX0VLYLxvp3dXld4c7GVquFsKztbyR9fS4t3622NLD829
         7CpmrTDojy9wMPMX/ajWfQVOqYeyMhAUMMlLi3E68xqkvymB1cfmkxp+7GZXHaLxMfTd
         cdnKJ6zqh6pvglmWS4PNlPIzZHvdY56xMovQO2juA93clUYvAX+lZaT3jpLhkKL33HzH
         AMfTYnon57PPf35Gl456Ol/fjKWEiMnscj3KohPkb5V6FQeIalyq6g4gbm9he/KeIi13
         S1Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NrL9hd4Wqwj91FT0S6XAmdlMViF2awh5gSoyfYWTPmg=;
        b=2wVLl85icAAIHrhwTACUH/Rc3cmprGYkwByKkZU2fYCYzly7R9rYq37Jmfgc9XBP5C
         BkBY1vB1xJuUO6VHIv0/D3J1y298pJdgdg8ldLkLfPW1SDgMWAWRwJbt4QMwSQRbSMpu
         HzZO6o6O+G5KQnUv+GNK2+lCpeEh3+3q/OE2HrJLlxqN3ZhYCk8soyoXe5PpOteoC2JC
         yGOIhz8bKkwfWIkoQuv6VNHhcUAuZM1yqH5px+WnMaiqANImudE4hwGLQo2BKHlHMpJa
         c2wSyxxokmdKXTci9KecjkI3aWbvnEXKKce05hDBZFiXFgo4P0+csoWKk0NZ0K2nZu99
         /Vuw==
X-Gm-Message-State: AOAM531JpMqh4jGxbrpzskSK4Q7NAR8nWPC7u/UbXH3XS9pT9m59lJwO
        pyc2P787TBtUeZoaVyGlOrc0Luy7JbnNo7/uMjw=
X-Google-Smtp-Source: ABdhPJzRTF2Ys5rfC0obQ5sjUXStNrWG8KkpNDQbTmL6TmH6hw+3ClVx4y/lanteUB75tm09D5CHsw1a9BcgxmNfia4=
X-Received: by 2002:ac8:7d51:0:b0:2f9:4390:6bfd with SMTP id
 h17-20020ac87d51000000b002f943906bfdmr9586533qtb.325.1653563198634; Thu, 26
 May 2022 04:06:38 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqtu9d45f7.fsf@gitster.g> <20220526021540.2812-1-worldhello.net@gmail.com>
 <xmqqo7zl2b66.fsf@gitster.g> <CANYiYbEcNJ7+7XW-8-v+p8q=aiOP9RJYvST8ethVjxVdNugR5Q@mail.gmail.com>
 <xmqq5yls3j8i.fsf@gitster.g> <CANYiYbGn08N_9bOw+ss6L4U_iTomc-08_961bk40eq1BnEstiw@mail.gmail.com>
 <220526.86tu9c625s.gmgdl@evledraar.gmail.com>
In-Reply-To: <220526.86tu9c625s.gmgdl@evledraar.gmail.com>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Thu, 26 May 2022 19:06:26 +0800
Message-ID: <CANYiYbEAdZ4g2ce9aGpRh7Hv_RHxSXHQnx4bW53f75O9j8p2Qg@mail.gmail.com>
Subject: Re: [PATCH] Makefile: dedup git-ls-files output to prevent duplicate targets
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

On Thu, May 26, 2022 at 6:04 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> > If we apply the above patch, sorting LOCALIZED_C is not necessary.
>
> Per earlier feedback in
> https://lore.kernel.org/git/220519.86tu9l6fw4.gmgdl@evledraar.gmail.com/
> this all seesm a bit too complex, especially now.
>
> I pointed out then that with --sort-by-file added we:
>
>  * Don't group the translations by C/SH/Perl anymore

I missed this point in the previous discussion. Will take this into
account in next reroll.

>  * Change the sort order within files, to be line/sorted instead of
>    line/order (i.e. first occurring translations first)
>
> I suggested then to just use $(sort) on the respective lists.
>
> So why not just:
>
>  1. Switch to the $(FOUND_C_SOURCES) (good)
>  2. Filter that by C/Perl/SH as before (just a simple $(filter)
>  3. $(sort) that (which as noted, also de-dupes it)

Will try this direction.

> Then we don't have any of the behavior change of --sort-by-file, and we
> don't have to carefully curate the ls-files/find commands to not include
> duplicates (although as seen here that seems to have been a useful
> canary in the "find" case).
