Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62991C433F5
	for <git@archiver.kernel.org>; Mon, 23 May 2022 08:50:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232250AbiEWIuV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 May 2022 04:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232222AbiEWIuR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 May 2022 04:50:17 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAB6112ACB
        for <git@vger.kernel.org>; Mon, 23 May 2022 01:50:15 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id u3so12081612qta.8
        for <git@vger.kernel.org>; Mon, 23 May 2022 01:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AeWL6zajhZ1KAL08XblULHpxBoOFol0U3IxoiKhL7b4=;
        b=ib7JbPe6ySsjrKu1Py3xRLZVgbCi586aaPQwtQgCNxF+e2b3d6zj9UmbEV0+6egljj
         jNGdSdVaDvtV5BUmqbN7KGYLFCuFxo8iWdsc6tVfoEG0PFj8r3QMMvHqh/kC2WzECn8G
         e8HrSKZg96jk0/+zfIGUDRbluJQd/42yDXbEMQyFOMjzLVda0XY5HDfyFN0MDcAWhgX2
         REaeWJ0xLvWThf2AY5WZ86OTkr8nN7xJkT+r307sAObqchJRxszTH5o/+fyXNzF2f+WU
         mhnTxLHGipSka0pBub+XxOig/FKf669gVHdSjFAGnTmdbS/QdQRuhdVfxQjo9E5YsHLe
         jafA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AeWL6zajhZ1KAL08XblULHpxBoOFol0U3IxoiKhL7b4=;
        b=NIkp4St359xQaoifdy6wzwauZlmC/SIDUu0Hka0ISz5o1Q1FMzb6s30dOpBU4HxxVh
         DgQbC3XLd5xO0NGuTsVFsiuzLH3DObBfmNSantq0BIsQGcEcAclaNGjemxfgIatR4ZYJ
         Yxu/rx3OF380uypjZ8jx3DccFCLrop4m04EwxwGb1P7HhNt75GPHmlvjLmlwKxbQ/b3u
         lxkHn2BIFOwRQ6E2I2+04g2O75uRRMUMAnqqi3/l+BleuB2vhUCIY9DS3mAWUj8BcqEO
         nG3qUZyDJQDx6RzB62+ULBjJ1wYuMFnzduO0wZsJo8TeGKJWvNX0Jzw2SRdjE9uNc2Ee
         qSCQ==
X-Gm-Message-State: AOAM532cycrl2qAgGPYALk8LlqBWIlYFa9mdmtIJeHXijqDWIvN1eqqx
        Sf7lezbsZYqOxU9zzEb5UaYQxNktEmV/sXJluvA=
X-Google-Smtp-Source: ABdhPJw4x44n6R8hy96KiBYR0d1m0owNmhEjK/8FT43QOy/1/WezbDabsV0JREHE+qxSGpHD7urp7dEVF9Ljl++qKpg=
X-Received: by 2002:a05:622a:1010:b0:2f3:d8f4:6cb4 with SMTP id
 d16-20020a05622a101000b002f3d8f46cb4mr15347437qte.180.1653295815091; Mon, 23
 May 2022 01:50:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220519081548.3380-1-worldhello.net@gmail.com>
 <20220523012531.4505-2-worldhello.net@gmail.com> <xmqqk0acu11q.fsf@gitster.g>
In-Reply-To: <xmqqk0acu11q.fsf@gitster.g>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Mon, 23 May 2022 16:50:03 +0800
Message-ID: <CANYiYbEmG+r-e2srvfZ5w-MBQ78RytYmJfMdrdWc7gHFq_AyuA@mail.gmail.com>
Subject: Re: [PATCH v3 1/9] Makefile: sort "po/git.pot" by file location
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git List <git@vger.kernel.org>,
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
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 23, 2022 at 4:05 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Jiang Xin <worldhello.net@gmail.com> writes:
>
> > From: Jiang Xin <zhiyou.jx@alibaba-inc.com>
> >
> > We will feed xgettext with more C souce files and in different order in
>
> "source"
>
> > subsequent commit. To generate a stable "po/git.pot" regardless of the
> > number and order of input source files, we add a new option
> > "--sort-by-file" to xgettext program.
>
> Probably: ... we pass the option "--sort-by-file"
>
> > With this update, the newly generated "po/git.pot" will has the same
>
> "will have"
>
> > entries while in a different order.
> >
> > With the help of a custom diff driver as shown below,
> >
> >     git config --global diff.gettext-fmt.textconv \
> >         "msgcat --no-location --sort-by-file"
> >
> > and appending a new entry "*.po diff=gettext-fmt" to git attributes,
> > we can see that there are no substantial changes in "po/git.pot".
> >
> > We won't checkin the newly generated "po/git.pot", because we will
> > remove it from tree in a later commit.
> >
> > Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
> > Signed-off-by: Junio C Hamano <gitster@pobox.com>
>
> This has no input from me (yet), so technically it is a bit
> premature to add my sign-off here.  It wouldn't make a difference to
> the end result, though ;-)

I started reroll v3 on your branch, forgot to remove your signature.
