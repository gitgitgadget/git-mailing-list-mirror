Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1FDEC433ED
	for <git@archiver.kernel.org>; Sun, 25 Apr 2021 09:31:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 954F16023C
	for <git@archiver.kernel.org>; Sun, 25 Apr 2021 09:31:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbhDYJbs (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 25 Apr 2021 05:31:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbhDYJbr (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Apr 2021 05:31:47 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CCE9C061574
        for <git@vger.kernel.org>; Sun, 25 Apr 2021 02:31:08 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id b17so44222605ilh.6
        for <git@vger.kernel.org>; Sun, 25 Apr 2021 02:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xVDFkK+3tKRCRR2mVyGhgEFytb1jeWFOerX6W8aHYgs=;
        b=R1fwmdVkBT8vHy8N1Ii/vFwWCU+dzcJ7HKzDz6mEA/Y2aZ7RVW5hGOlxAnhSj8dFvu
         svQG6IhI3khqjBBMNQb4WatRco97YiyXZ0503ltopX9NTw50+KFI/gC2AFVrXkUdJ9+F
         U9liTJyNK0w1RNZpRl/v2BXNAfhP2kkTIEU+co8lhfq3A4SOjhXuVwhSt4VNwFu7XD7r
         2PtVzj5UeF9iZynCfV9//D4VpHiVh17bbMj8Hlw6v4xemkJGyuC2TvxTac+WOB/lvwIn
         JzenBPlx3mFVpQT7IQVrj0jj5DWvVqZfMts35kTGv59YerGu81xEnT7XbT5BlBprAT/u
         Qd2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xVDFkK+3tKRCRR2mVyGhgEFytb1jeWFOerX6W8aHYgs=;
        b=qYwWiZzYN9HEYT3dLHkgfDrwyRPtcQQ1EE+cVIfyF/8gSYSXDwY5ZQFnNuqZDLTN9c
         9M6SrL8dFrkcR9xJH2kRrXo5BoUs9TWGtzHlUQfu6Oy5K/wBOyDA2uBkp1Zxur8Or8ku
         dleAunaoMHzSzMi/hKjgTkbo+FYP7u3lqOJ9COa9U66utf/sqy3ipOfiIb9r1poVIVEQ
         IS/UwhVI78Syxe+ccqGsWXJdFnfjD5YPvRtW4jep4V8yfUe6iCW5K4/GYhLnv+1HWXD3
         tMMF56s2YsQA17buR/Stkg8UvuBiSY+1uc0/Gnb3ejVxFibjQcNJ0/QdTUPp1p7Aow/2
         8gsw==
X-Gm-Message-State: AOAM5310G1m7GHMqSsOkD8qxEs7fph/cCJBFIUQdpvfRfd+O9N7vPfqo
        ZKWxV25IU7R+niCHPrQzi/iIX9TXl0f9GBzYaAc=
X-Google-Smtp-Source: ABdhPJxHxRKxEcB0psmA8WaDoSc5KMUOzG/23QxEzo7g6qlWtDuoG/9nMoW/iORibHhKpiY8RVKrZPCrloxI3yauhZk=
X-Received: by 2002:a92:cf45:: with SMTP id c5mr8933651ilr.259.1619343067640;
 Sun, 25 Apr 2021 02:31:07 -0700 (PDT)
MIME-Version: 1.0
References: <pull.939.v2.git.1619275340051.gitgitgadget@gmail.com>
 <cover-0.2-00000000000-20210425T090506Z-avarab@gmail.com> <patch-2.2-6a17343b23b-20210425T090506Z-avarab@gmail.com>
In-Reply-To: <patch-2.2-6a17343b23b-20210425T090506Z-avarab@gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Sun, 25 Apr 2021 17:30:56 +0800
Message-ID: <CAOLTT8TPn6wF44ARPzq9p7Cnik2rz8DtA-oK1Zk33t49EquTJQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] pretty tests: give --date/format tests a better description
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Taylor Blau <me@ttaylorr.com>, Beat Bolli <bbolli@ewanet.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason,

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> =E4=BA=8E2021=E5=
=B9=B44=E6=9C=8825=E6=97=A5=E5=91=A8=E6=97=A5 =E4=B8=8B=E5=8D=885:11=E5=86=
=99=E9=81=93=EF=BC=9A
>
> Change the description for the --date/format equivalency tests added
> in 466fb6742d7 (pretty: provide a strict ISO 8601 date format,
> 2014-08-29) and 0df621172d8 (pretty: provide short date format,
> 2019-11-19) to be more meaningful.
>
> This allows us to reword the comment added in the former commit to
> refer to both tests, and any other future test, such as the in-flight
> --date=3Dhuman format being proposed in [1].
>
> 1. http://lore.kernel.org/git/pull.939.v2.git.1619275340051.gitgitgadget@=
gmail.com
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  t/t4205-log-pretty-formats.sh | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.s=
h
> index 0462115ac5c..bcb558ef4d7 100755
> --- a/t/t4205-log-pretty-formats.sh
> +++ b/t/t4205-log-pretty-formats.sh
> @@ -525,14 +525,14 @@ test_expect_success 'strbuf_utf8_replace() not prod=
ucing NUL' '
>         ! grep Q actual
>  '
>
> -# ISO strict date format
> -test_expect_success 'ISO and ISO-strict date formats display the same va=
lues' '
> +# --date=3D[XXX] and corresponding %a[X] %c[X] format equivalency
> +test_expect_success '--date=3Diso-strict %ad%cd is the same as %aI%cI' '
>         git log --format=3D%ad%n%cd --date=3Diso-strict >expected &&
>         git log --format=3D%aI%n%cI >actual &&
>         test_cmp expected actual
>  '
>
> -test_expect_success 'short date' '
> +test_expect_success '--date=3Dshort %ad%cd is the same as %as%cs' '
>         git log --format=3D%ad%n%cd --date=3Dshort >expected &&
>         git log --format=3D%as%n%cs >actual &&
>         test_cmp expected actual
> --
> 2.31.1.734.g8d26f61af32
>

Notice that you modified the title of the test
`short date`--->  `--date=3Dshort %ad%cd is the same as %as%cs`,
then the `human date` patch I am working should also do the similar
things as you do here?

--
ZheNing Hu
