Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D1FCC433ED
	for <git@archiver.kernel.org>; Thu, 20 May 2021 14:34:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1908A61355
	for <git@archiver.kernel.org>; Thu, 20 May 2021 14:34:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237911AbhETOfr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 May 2021 10:35:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232781AbhETOfq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 May 2021 10:35:46 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CECB6C061574
        for <git@vger.kernel.org>; Thu, 20 May 2021 07:34:23 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id t11so16763883iol.9
        for <git@vger.kernel.org>; Thu, 20 May 2021 07:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=25TJeJX40dYcV+s+YSfBAdsnzHC6mXLbw+I7jwx2wI4=;
        b=CpzYvdkFjTiuqjBrTL3bxudN/hGn6U5JSBm85GZsCyRFlGhtxj3vpb1vutmA7i7dVY
         +48Yj2CRhiqFmr79puPLb0bFuarkJ9WDvL9iFmikOv8dDJG0RQDl2yARgM33b1nRX+aE
         8263GpoehD49j2fTilOogyd5rEHQ0M7Im0QkjsDFFqeteP1LVAOmBANeKYBuvVyZoM8u
         TeT+LBpd9jR7Uk+AcoL9tbGtEHy4FWh5Sy7tL+y/JvxFR88zhfCyB9sSY57I29dS9NZm
         yI8HnMMVDKdBT6loOssKxknPhnQVDqrDD93TxMp0MCMm9ctYB5DEJnXC9DGr02UZdsJ4
         cO+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=25TJeJX40dYcV+s+YSfBAdsnzHC6mXLbw+I7jwx2wI4=;
        b=LdUifOa1VPCDJsKcd5JA+kbQO1uwnko+SLRpDK98jdpp9namSUsXH3YaI7ZH/THpNz
         g5IyzfcC6GobfZf85b/XNBRUQCQWI2h6dhfXF32KgZYmqIbPOyEVPtZXHVJeBClA0eoD
         XQFaFpEcTkRWyftsf4dKRQ++QW2AUpzzjJ0E0h1rk9jC7LQg7DEbrIt75Xk5j/aZbMTz
         xdWMHh07xtscn1vJDDwl5LoiqEvRK8MjVjlLHv3Hqy+plupVOAnn5z8wsjpKOJVhjIhX
         kCLkRMMP1uSmxnWzykgzJeIX3eYf+VU2IipCT/kgBJEeY0vvt92vdrCvFIswjqX/qtbW
         t6Rg==
X-Gm-Message-State: AOAM531TsVuK66au6yBV0aKtVCOS2fjmTQA9CW0sQ05EqXTQx982w8OJ
        Fm3bOAtdbPY3j8b1y496edhF9ZOskKX4u9xIy6I=
X-Google-Smtp-Source: ABdhPJyYkmZZ9OtLhVIK5GbyItYkGPf1qz/tynPv1ZCtUDTF6njwymNCMSgitnOxit6hGdAVpbEVox6PlADOvyu01DA=
X-Received: by 2002:a5d:814d:: with SMTP id f13mr5495667ioo.203.1621521263136;
 Thu, 20 May 2021 07:34:23 -0700 (PDT)
MIME-Version: 1.0
References: <pull.958.git.1621500593126.gitgitgadget@gmail.com> <CA+CkUQ8kiCk7X2kFMqPDK2VMbhgRh-HaHynV2GjE7k=LAJhiUA@mail.gmail.com>
In-Reply-To: <CA+CkUQ8kiCk7X2kFMqPDK2VMbhgRh-HaHynV2GjE7k=LAJhiUA@mail.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Thu, 20 May 2021 22:34:07 +0800
Message-ID: <CAOLTT8SVnK6HiUYhEkbt10q0ZUprSLy-01c8+TfD6BK2dRmZiA@mail.gmail.com>
Subject: Re: [PATCH] [GSOC] ref-filter: add contents:raw atom
To:     Hariom verma <hariom18599@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hariom verma <hariom18599@gmail.com> =E4=BA=8E2021=E5=B9=B45=E6=9C=8820=E6=
=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=887:29=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi ZheNing,
>
> On Thu, May 20, 2021 at 2:19 PM ZheNing Hu via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> >
> > From: ZheNing Hu <adlternative@gmail.com>
> >
> > diff --git a/ref-filter.c b/ref-filter.c
> > index e2eac50d9508..fc384a194c0c 100644
> > --- a/ref-filter.c
> > +++ b/ref-filter.c
> > @@ -133,7 +133,7 @@ static struct used_atom {
> >                         unsigned int nobracket : 1, push : 1, push_remo=
te : 1;
> >                 } remote_ref;
> >                 struct {
> > -                       enum { C_BARE, C_BODY, C_BODY_DEP, C_LENGTH, C_=
LINES,
> > +                       enum { C_RAW, C_BARE, C_BODY, C_BODY_DEP, C_LEN=
GTH, C_LINES,
>
> Maybe it's better if you can preserve the alphabetical order?
>
> Thanks.

Thanks, this is indeed my negligence.
--
ZheNing Hu
