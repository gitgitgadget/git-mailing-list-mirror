Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D187EC43334
	for <git@archiver.kernel.org>; Fri, 22 Jul 2022 06:44:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231913AbiGVGoz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Jul 2022 02:44:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbiGVGoy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jul 2022 02:44:54 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 419A287C2C
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 23:44:54 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id p81so3042301iod.2
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 23:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wK2VAgBcJdJW6d/3nITh7pp46Fl4JA5buqy5ySIdh3E=;
        b=b/BN093jj0dg1xTkvtl/A7hVaAFcLE2bcPykMvsYiD/CpSgWUs+L0GFxquNhwwV/oK
         1eRLMbVaGXBCSh+2UIMc+Fx/t5/m6zTqRbq16hgMnD1byL/tIW+REdRtpAv1y4k+Ld4O
         LG3ubAdfJmeDBPSVGGeZ2VuX5FT/O7SU7xLp08CIXnI4BxK8IL3yS/dVz9BGOtUcMe+t
         gH5pEMj6t9EWWj7r8IWtqUf/Uw/qQcikM2scdx65NowUlPdOMI2sAjg9erk6MFEIWpi8
         03k0Uju/vuH7WG/PqtUWccc9BzJVJ1vOeigiM5oFYNJcHaravA3AF4d2nX2+1qii6ZOm
         To9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wK2VAgBcJdJW6d/3nITh7pp46Fl4JA5buqy5ySIdh3E=;
        b=Y6lt2A3fN4gHZ929cEN9M2lAivxYp+oMnyORdUPvkPhWtiMfI8aF4B/3dRSXqK+5GB
         bBRU4/JcLPdrxh/K9mWIhfrjRGd4gySfbK7vcGNsUDrnaFT3/M7IJ+U6bogpaJsSjuA4
         X8i0AU+0rJPy1HfwcAZycOX+mUHohOMS9bW9KhWKVjqkxlO4m85QsL7p163aw12Wlcri
         4Im3QJ1MSlj2fRObYAlrL71uS1u961JTYC5kKoFmN7xF0mXyMqgXZ/ani+Id7u2yu/VR
         5BV108/Zl+xO4V2/zS9RPkE1pnwMFD9M0Rbx3eOObKmgaXyGv3yB+eQuYoAXMRaBMncL
         +fEg==
X-Gm-Message-State: AJIora/nmhDol5BgtFEZG1kBcAfwtvfDlp3omu/qQdUv6WA90D9psedq
        ZYGlClOD4bA3WJcXyAvYOZwTjfkAg+dQIEw0BK0=
X-Google-Smtp-Source: AGRyM1u4aG1YSQNdu0mhp+ivV70Fk0i9fe1Ik85Csxua1Mj+tEe5PSgBODE3X7Frc08B48H8YwuN4XY24aH+Jxf7IPM=
X-Received: by 2002:a6b:b883:0:b0:67b:a3a5:7c6 with SMTP id
 i125-20020a6bb883000000b0067ba3a507c6mr855401iof.135.1658472293690; Thu, 21
 Jul 2022 23:44:53 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1262.v7.git.1657692472994.gitgitgadget@gmail.com>
 <pull.1262.v8.git.1658334983053.gitgitgadget@gmail.com> <xmqqbktj3ct7.fsf@gitster.g>
In-Reply-To: <xmqqbktj3ct7.fsf@gitster.g>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Fri, 22 Jul 2022 14:44:42 +0800
Message-ID: <CAOLTT8RjLoooT7t+ucFqa9P=8TiVL3M+ZgcEY7qVhRbjB=9OhA@mail.gmail.com>
Subject: Re: [PATCH v8] ls-files: introduce "--format" option
To:     Junio C Hamano <gitster@pobox.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2022=E5=B9=B47=E6=9C=8821=E6=97=
=A5=E5=91=A8=E5=9B=9B 01:37=E5=86=99=E9=81=93=EF=BC=9A
>
> >       +       git commit -m base
> >       +'
> >       +
> >       +test_expect_success 'git ls-files --format objectmode v.s. -s' '
> >      -+       git ls-files -s | awk "{print \$1}" >expect &&
> >      ++       git ls-files -s >files &&
> >      ++       cut -d" " -f1 files >expect &&
>
> Either "awk" or "cut" is fine and flipping between them is a bit
> distracting.  Cutting the pipe into two is a good move.
>
> But is this testing the right thing?
>

Yes, I am sure about that cut can do the same thing as awk, and it can
specify its delimiter.

> > +test_expect_success 'git ls-files --format objectmode v.s. -s' '
> > +     git ls-files -s >files &&
> > +     cut -d" " -f1 files >expect &&
> > +     git ls-files --format=3D"%(objectmode)" >actual &&
> > +     test_cmp expect actual
> > +'
>
> It only looks at the first column of the "-s" output, and we are
> implicitly assuming that the order of output does not change between
> the "-s" output and "--format=3D<format>" output.  I wonder if it is
> more useful and less error prone to come up with a format string
> that 100% reproduces the "ls-files -s" output and compare the two,
> e.g.
>
>         format=3D"%(objectmode) %(objectname) %(stage)    %(path)" &&
>         git ls-files -s >expect &&
>         git ls-files --format=3D"$format" >actual &&
>         test_cmp expect actual
>

See test case: 'git ls-files --format imitate --stage' which just do such t=
hing,
maybe I should change its name to 'git ls-files --format v.s. -s'?

> I do not know if the $format I wrote without looking at the doc is
> correct, but you get the idea.
>
> Thanks.
>
>

Thanks
