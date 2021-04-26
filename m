Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07830C433B4
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 16:18:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C93C061158
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 16:18:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234435AbhDZQSp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Apr 2021 12:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233934AbhDZQSn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Apr 2021 12:18:43 -0400
Received: from mail-vk1-xa2b.google.com (mail-vk1-xa2b.google.com [IPv6:2607:f8b0:4864:20::a2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22EB3C061574
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 09:18:01 -0700 (PDT)
Received: by mail-vk1-xa2b.google.com with SMTP id q192so1292638vke.1
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 09:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UNZhuqEhNrEIP/TCyetZwhtHUtwEt0ME1p9o/yhLwd8=;
        b=EYBQdHR8UfD8i39xWUWAz7bDgHwj/vi8qmQ5tzRuYpMjVm6+nhYtgxHGtDuw6q7a/P
         vyH5fGkCZ32rRYXt1x+XIa0ZdwWwOf2NY5aERsym1spjLsfVEn7l3tvNM9MMHMO8YcBu
         zOWfYV2Dhalxb87CBEEA24bzxh1Zh3o3DDRP911zZ+xtJzKmf1I4stelRZqFx+nK9zFk
         TR3Qp53kX/GU6HrgjZZXFzlJwe1lN1lg5UrqHMN/FUZwfLPe5lYFtKbqmrR73BcJBPFb
         8/2BpxFvE1efIfm+WjgXwWMv2Y2uoyLyzDxTUvVeQRkg3kBEu0rzpRhODzy08mkhqq8F
         tTMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UNZhuqEhNrEIP/TCyetZwhtHUtwEt0ME1p9o/yhLwd8=;
        b=uVtDhZBD1lupI7JwtSVOXR2c8q1zdyqhXljfzdcT7wZ89/weKsuxZd56SIXccz0u9t
         Ptp9kP++uEykZm9KQNYyYL5NeRcGbMuM7+uQdlV+fmXeUT9FaaHbTpJmPVFZbsurZkpp
         sjm+8WGGJVAzQ8B4i0sZMatWxZK61g64Ul//4trk4b0bvvlkcuFVuBggGnz9nX0F0aCk
         zwnjfIqF3J6YGxi+ac1AJ7l4V+35/bg2vpgAA7KYj69l8L2/ybpY43z1oKUFpuzWOsqD
         EstnT2mZXdCYDUzRHw+PAhXlzf1P9to23e5IC3Hl5r06nem8EM0ip+87THusYx8uyC0a
         XyZA==
X-Gm-Message-State: AOAM533I06FrlHIDtWj/VOijx5bp0WGE6hmPXn7SUURDNKiBl44BeamB
        x3bMTYrCv/nak9S4U/WP9XAB4xr2uC5mnitki3nH15W5U/o=
X-Google-Smtp-Source: ABdhPJzRn31Hq1OaG5BV/8boTwwAQtfZTiQLTTHfIe86YJ59mYI0U9WY3SJzZ3DKXCvxH8bq3j54QbOjX/l1IUW+ju0=
X-Received: by 2002:a1f:3105:: with SMTP id x5mr13303721vkx.8.1619453879880;
 Mon, 26 Apr 2021 09:17:59 -0700 (PDT)
MIME-Version: 1.0
References: <pull.847.v3.git.git.1606419752.gitgitgadget@gmail.com>
 <pull.847.v4.git.git.1607522429.gitgitgadget@gmail.com> <d57023d9f13d178dc95d7a74751923b80d1a5939.1607522429.git.gitgitgadget@gmail.com>
 <871ree8eto.fsf@evledraar.gmail.com> <CAFQ2z_Pco4KhhE7S_8zBZ7hCwOH=DnxHoKE8zus7REdQaXCZiQ@mail.gmail.com>
 <87lf953yto.fsf@evledraar.gmail.com>
In-Reply-To: <87lf953yto.fsf@evledraar.gmail.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Mon, 26 Apr 2021 18:17:48 +0200
Message-ID: <CAFQ2z_Pb62Oe352UwdsPWLxjXd7P97pyuggTMK2URJd2p=OTnA@mail.gmail.com>
Subject: Re: [PATCH v4 13/15] Reftable support for git-core
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Patrick Steinhardt <ps@pks.im>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 26, 2021 at 4:28 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> I agree that whether or not we should have any tests at all is a matter
> of opinion and circumstance. I don't think in general that someone using
> some random internal API needs to be checking what is and isn't tested
> in that API.
>
> I do think in this case that it's worth digging a bit further. The APIs
> in question are using EINVAL and EISDIR to pass up errors that are had a
> 1:1 mapping into the FS historically.
>
> Are we really better off faking those up, or is some of that perhaps not
> used at all? Maybe we'd find that this level of abstraction isn't what
> we need, and it could actually be much simpler.

I think none of these error functions are being used at all, and I've
made a start at removing them in https://github.com/git/git/pull/1012
(see also my discussion with peff.)

> It seems to me that a good way to get there is to seek some systematic
> ways of focusing review onto various edge cases of this series. I.e. to
> begin with having GIT_TEST_REFTABLE pass as noted elsewhere, and in this
> case calling attention to some of the underlying assumptions behind this
> series.

> One of the hardest things I've found about trying to review this has
> been closing the gap between things that exist in your mind and commit
> messages / code.

thanks, that is valuable feedback.

> something like this in the commit message (and other applicable commits
> etc.) would be *very* valuable:
>
>     In functions such as git_reftable_read_raw_ref() (and ????, are
>     there more?) we're diligently emulating the documented behavior and
>     return values of the refs file backend. According to "make gcov" we
>     can see we don't have coverage for this, in particular the behavior
>     of EINVAL etc.

I haven't done this, because a lot of these considerations are
transient, and I'd rather not spend a lot of time documenting what I
don't know.

> I.e. per [1] once if and when we have GIT_TEST_REFTABLE passing surely
> one of the best way to garner feedback on the rest is to discover those
> parts (using "make gcov", after running with/without
> GIT_TEST_REFTABLE=3D[true|false]) where we still have outstanding blind
> spots between the tests and code.

Getting GIT_TEST_REFTABLE=3D1 passing is the hard part, because it means
having  to understand exactly how the current code is supposed to
work.  Once I get to that point (with knowledge being complete and
tests passing), it will be easy to document what is happening and why.

I was hoping that by posting these series with known test failures,
and questions marked "XXX" in reftable-backend.c, I would get feedback
from the other people who know exactly how this part of the code
works.  But from your mail, I get the sense that nobody understands
how the whole picture fits together?

--
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
