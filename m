Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38AD5C43461
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 17:59:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 060EC613B2
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 17:59:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237456AbhDZSAW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Apr 2021 14:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235847AbhDZSAU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Apr 2021 14:00:20 -0400
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED15C061574
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 10:59:38 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id k19so15617947vsg.0
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 10:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8IU7V4qoCLoKSzSpuuSISA6DbdvUmy/7C8oXz1UCQZM=;
        b=u5kOk2O6KctS4IhFa+cdmbkwb+E4kLrCvHmB3WGdwK7dbSg2PxNiylgDDxjJoWrDKV
         FqYekZS4Tn87/Jbz9byfeykjQbvhuihOcCAB8eYGSkk7nDXQ4nI/RsSH2p/tqt+TMEBX
         6h7TchgPxbHlhZsIDeU651UaSoJZY7e9AqCTGbAfr5Sfy7SjOjKKDizZr64bss9Qobar
         Jh/lGpJagvRLghZ0EZK8YVL7yMUIdYccuSR00YnHtAtf3aCtAASqO064AecmvhvJ3Obp
         oNEfc45BSUfTqibdvwCJ4+SXaYn2JFhBUmHwEQZ913wDzDqsiLOneg3r8bPaOR43vjBq
         n+IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8IU7V4qoCLoKSzSpuuSISA6DbdvUmy/7C8oXz1UCQZM=;
        b=K6CV70vfFi3L8aY4ZNkdxORW5vOfK2ujp0LRw65DoD9tGcXYo2Scp8oWPvnk0V7OUr
         XRAtC8M8KG0XmTG9YXFyVhJBybeSW+iCVB+mJ5AMLPx401NS7KnO0XUbI7e6heX6O6Lo
         JT8niKdRgTX9G7L62v7vanhtjW43jPko9AjtSYTQttpkLh0sj9HYLcq8rpRKm3BY/WMc
         HhjZJHLKvwY8xghyp1elchAw0ki4M/ArN1krkz4h3xS++1HW33KozF5RHV5Wls/Akpuy
         THqmZDtOZPi6aPiGovJztLuZ8omez45H7mbfFx8lf6xhC2QVEZG1fu4yGZhFroOYI6RR
         R7Tw==
X-Gm-Message-State: AOAM532CmdTPVR+qq+Zv+w9ujg0x2Phkx+QxPTbUtzW2S4IOYBMdsInX
        q0SKfsNPYUVgIWRDgfNCXthwiLIWgLNZxmF2Rm58cQ==
X-Google-Smtp-Source: ABdhPJyFXJ3giwI+Ia6moB+Pp2PtDDL2RnCeVHtp6x/wZU2c22uaP/Suql2foKxMkAqvoKpqskl8+EH8cMHgwVSJhJ4=
X-Received: by 2002:a67:bd01:: with SMTP id y1mr13679874vsq.50.1619459977209;
 Mon, 26 Apr 2021 10:59:37 -0700 (PDT)
MIME-Version: 1.0
References: <pull.847.v6.git.git.1618255552.gitgitgadget@gmail.com>
 <pull.847.v7.git.git.1618832276.gitgitgadget@gmail.com> <878s5c3wti.fsf@evledraar.gmail.com>
 <CAFQ2z_MF3SbKf8yXBvkOcLGg03dVxJW3F=c6ZDUtstEbZUUMCQ@mail.gmail.com> <87lf9b3mth.fsf@evledraar.gmail.com>
In-Reply-To: <87lf9b3mth.fsf@evledraar.gmail.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Mon, 26 Apr 2021 19:59:25 +0200
Message-ID: <CAFQ2z_Ow38_80kA5W3vPyPnZFTSCAF7nwYavgki=GJVm44P7EQ@mail.gmail.com>
Subject: Re: [PATCH v7 00/28] reftable library
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
        Derrick Stolee <stolee@gmail.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 21, 2021 at 1:21 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:

> >> I don't see the point of having re-rolls of this topic while the test
> >> changes topic it's based on hasn't finished
> >> marking/splitting/refactoring the various tests that do and don't depe=
nd
> >> on the file backend.
> >>
> >> At least when I review it I'm just left with going in circles digging
> >> into one of those failing test, figuring out if it's really
> >> refs/files-backend.c specific or not etc., and as long as we can't tur=
n
> >> on GIT_TEST_REFTABLE=3Dtrue in CI as part of this series I don't see a
> >> path to making it advance to next->master.
> >
> > The point of posting updates is to garner feedback, especially from
> > people familiar with the Git code itself.
>
> So you agree that we should make the tests pass first, then shouldn't
> these me marked as RFC/PATCH?

I added RFC to the patch introducing reftable-backend.c

I consider the code under reftable/*.c to be of production quality,
even if it's stylistically different from the git code.

> IOW a large part of the feedback you're looking for is already part of
> the codebase. Nobody can keep all of it in their head, but we've encoded
> all the tricky edge cases we could think of in the tests.

That's disappointing. I know that I can just fix test failures until
there are none left, but it's not a terribly efficient method if there
is someone who knows how this works.  Is there no other way to solicit
feedback?

> I.e. reaching some consensus on things like whether
> GIT_TEST_REFTABLE=3Dtrue passing under CI being a hard-prereq for this
> series or not is surely one of the first things to sketch out before
> figuring out how to move this forward.

I've had conflicting feedback about this, but it's ultimately not my
call to make. Jonathan Nieder suggested that this was asking too much,
and it would be OK to have a credible starting point where the effort
to address remaining test failures could be shared across multiple
people. Jun also expressed he didn't want to put all the work on my
shoulders, but so far I've not received much help.

> In v6 I noted that t5510-fetch.sh had a segfault[4], you said you'd
> check it out, and reading your cover letter nothing stood out about
> that, so I assumed it was sorted out somehow.

I fixed a number of segfaults, so it's quite likely (I did see the
freed transaction BUG).

One of the problems of working with a large pending series like this,
is that it is a project in itself, and keeping track of which change
fixes which bug is something I really need version control for, but
the frequent rebasing/squashing erases this kind of information.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
