Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A15CAC433EF
	for <git@archiver.kernel.org>; Sun, 24 Jul 2022 11:08:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232369AbiGXLIO (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Jul 2022 07:08:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbiGXLIN (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Jul 2022 07:08:13 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F9FA167FC
        for <git@vger.kernel.org>; Sun, 24 Jul 2022 04:08:12 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id v2so961822ilm.4
        for <git@vger.kernel.org>; Sun, 24 Jul 2022 04:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pnvIdH8XKpxwoePagkzWAypVRWrXEst5mOyixgP2Zdg=;
        b=DMclxnu/a8jRZIeWg8B5U91QbL8IgPW2jygXHPUuplZ83p81w9/JO8ABWeoaLroIXc
         8Sx+jEGC9ty6aNH0zIdbIms/P/BndT/FIyv9r0HuG058kt6Wudi5h0HbC4tTmXUYATpI
         XLd5TWtecVhY9TelXoZZKZlkD9Uun5dM9zO07lIqftdi+c+GMCxTYU0+8LjKN+ndbyWO
         /AGxVmkEwq8xSf0IrrZpGwunFgKmBnojzowFUtCPWhbkX8uj27ZG3YEUSLa+R0lMtrdy
         p8KuGdzBUC/0uEBY0n4JENOBEihYiO3nvW4SyGtnQgO4MNWNpRXBJi1A0EevCMNfJiFX
         XLAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pnvIdH8XKpxwoePagkzWAypVRWrXEst5mOyixgP2Zdg=;
        b=fn/0tE1P3cCIn51w8lw/Kv2GynpRhhhS9JeJCwYQhHVYCbK0LFBv2f0DlJuu9iW/Ub
         e34Tma7vrMbIgoACq5Mnzoqb5ZHxEr4iN4118Rv73v/0cjK1qEVdWNl/YpTMhzyNtxkl
         It1rSz6fISVYIXpCdXCbYhu79LmqMzJaYMM5/6ftJbZXx++F5vi/xL+J20GBkNqUp5PG
         l/WQ5gFE3yMwZk5nS/u+L4wx4bqE3PHsCP8HQZDRAIKSj3us8agpc2pVZc2Cq8zQXjL0
         jlTLF529RU8J3BP4un8kHZiLkSovmdGq9J50/Kq/UEr7e7bGnRQ4DQy0+q3+lcCyGzNR
         8hog==
X-Gm-Message-State: AJIora8vbEUNvbJAB+m6nnaIKdGd26H5TFwcmX7ehBCWVV40yRhYM2XP
        d9nxDrfqfW7zvllDjEXSCiU4FF1t/PgEQmWFuoY=
X-Google-Smtp-Source: AGRyM1tb1n3hZlIB9IBCZClzpO+czVcxYoQudPi8DmrCCH0KjDwZpIxUJW3aHIelNme6449POvdm0HHm4137L25tBDo=
X-Received: by 2002:a05:6e02:1bcc:b0:2dd:1bb1:d2df with SMTP id
 x12-20020a056e021bcc00b002dd1bb1d2dfmr2909781ilv.213.1658660891627; Sun, 24
 Jul 2022 04:08:11 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1262.v7.git.1657692472994.gitgitgadget@gmail.com>
 <pull.1262.v8.git.1658334983053.gitgitgadget@gmail.com> <xmqqbktj3ct7.fsf@gitster.g>
 <CAOLTT8RjLoooT7t+ucFqa9P=8TiVL3M+ZgcEY7qVhRbjB=9OhA@mail.gmail.com> <xmqqsfmr8ygp.fsf@gitster.g>
In-Reply-To: <xmqqsfmr8ygp.fsf@gitster.g>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Sun, 24 Jul 2022 19:08:00 +0800
Message-ID: <CAOLTT8RqMU-k85LmcpY0wATHSDoWDEQLnPtfuZ2OC2nWN9305A@mail.gmail.com>
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

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2022=E5=B9=B47=E6=9C=8824=E6=97=
=A5=E5=91=A8=E6=97=A5 02:40=E5=86=99=E9=81=93=EF=BC=9A
>
> ZheNing Hu <adlternative@gmail.com> writes:
>
> >> But is this testing the right thing?
> >
> > Yes, I am sure about that cut can do the same thing as awk, and it can
> > specify its delimiter.
>
> That is not an answer to "is this testing the right thing?"
> question, though ;-)
>
> >> > +test_expect_success 'git ls-files --format objectmode v.s. -s' '
> >> > +     git ls-files -s >files &&
> >> > +     cut -d" " -f1 files >expect &&
> >> > +     git ls-files --format=3D"%(objectmode)" >actual &&
> >> > +     test_cmp expect actual
> >> > +'
> >>
> >> It only looks at the first column of the "-s" output, and we are
> >> implicitly assuming that the order of output does not change between
> >> the "-s" output and "--format=3D<format>" output.  I wonder if it is
> >> more useful and less error prone to come up with a format string
> >> that 100% reproduces the "ls-files -s" output and compare the two,
> >> e.g.
> >>
> >>         format=3D"%(objectmode) %(objectname) %(stage)    %(path)" &&
> >>         git ls-files -s >expect &&
> >>         git ls-files --format=3D"$format" >actual &&
> >>         test_cmp expect actual
> >>
> >
> > See test case: 'git ls-files --format imitate --stage' which just do su=
ch thing,
>
>
> That was not the point.  By extracting only "%(objectmode)" without
> having any other clues (like "%(path)") on the same line, the test
> is assuming that ls-files will always sort its output in the same
> order regardless of the output format, whether it is "--stage" or
> "--format=3D<spec>", and that was what the "is this testing the right
> thing?" question was about.
>

Ah, so that we should sort the ls-files output first, and then compare them=
.

> The other test that makes sure --format=3D<spec> can recreate --stage
> output is fine.  If some future developer breaks the output order by
> mistake for --format=3D<spec>, we will catch such a mistake with it.
>
>
> > maybe I should change its name to 'git ls-files --format v.s. -s'?
>
> I do not think you should.  "A v.s. B" does not imply "A and B
> should create identical result".  The original title describes what
> it does much more clearly.

Ok, here I don't need another rerolling to revert it, right?

Thanks for all the reviews!

ZheNing Hu
