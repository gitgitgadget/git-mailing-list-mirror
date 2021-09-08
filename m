Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06DE1C433F5
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 19:01:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C97DC6113C
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 19:01:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240231AbhIHTCe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 15:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbhIHTCd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 15:02:33 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE8C0C061575
        for <git@vger.kernel.org>; Wed,  8 Sep 2021 12:01:23 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id k13so6884413lfv.2
        for <git@vger.kernel.org>; Wed, 08 Sep 2021 12:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rplVcR4pBnjGlH7SC2gSRnQzvBJP0GebXowk4eJ5Lak=;
        b=ma06RI0aQ5HSQKOXKpXOMOg0h0eN3Qk3S/zIcO2tdl1416G/h5IjL+KwVkszImuY6u
         W2pTh+Kj7X6qx1aiIV2ff/nsHRSHicgJtODZsVC0d2V2uebQoesvOCX4cSEBidhDc9r0
         Aw3q8brovVih/R4iwEEbiZr6+FTvc+313Bom4LLl50VJZ+QFbSz6bHTjoqPw1EIC58K9
         eDBKPQz0TlWlQposz+DyTIIfTrdKsZ+PbUdbWAVwN4oVJtR+wuVKZEHja80Ns8TFVBqD
         cd1r1TfI5QkpLa3XdCP36lgpV9aVL6eqpmaUCO8hsILYl/8695q+p/9sB2hXfTiFIK6Q
         p7qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rplVcR4pBnjGlH7SC2gSRnQzvBJP0GebXowk4eJ5Lak=;
        b=8AxWRGwUfuD+27r+eT6VlyQjFfSYuGtr6w9PgtdgMne/ab+0N3jSSKZzNTqVyEYCpy
         25rt9l0ClDmjn4e4D2Qnf98qxEHXek1SkPXM/2pVAlEywEUx4YCq6JOEaptG7On7Z5Q8
         JHa/4bKCY8xRUlRbSlrug91aetnZqlzsMFgl5F4f+5hP5KtueFSzwS8RkAjxusGysw1z
         nTH3MuAFRFiXScZ0+oGK0u1LQGxg34kIgn6VPqIGjL7BQxqEN+CkEk6qiNzhXCzZKtrJ
         EkryOhVshx3uZvZJtWX7EMHoswK7Bd9Dbn4k4TVOibAstNPMWOcsZGj4Kr3NNfjMP0b+
         4LrA==
X-Gm-Message-State: AOAM532R+V0yoadf5IgsNJurrg7cmbDg+R4Q/44IYrz5OyNL8wraepQe
        A3diW/CU5WRI/RhRnIw0qmVvJh78lHeJ5YjuzHUM3gdtYiA=
X-Google-Smtp-Source: ABdhPJyOrLQIZCiUTRiKhPb/O/6CyluVatTEaIlUzQJh9WprizHAsJyER8cKkvf+ApAmVkDht2PIZZ6rqZ1muhrMIvY=
X-Received: by 2002:a05:6512:10d6:: with SMTP id k22mr3759611lfg.575.1631127681192;
 Wed, 08 Sep 2021 12:01:21 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1076.git.git.1629856292.gitgitgadget@gmail.com>
 <pull.1076.v2.git.git.1630108177.gitgitgadget@gmail.com> <CANQDOdeEic1ktyGU=dLEPi=FkU84Oqv9hDUEkfAXcS0WTwRJtQ@mail.gmail.com>
 <003701d7a422$21c32740$654975c0$@nexbridge.com> <CANQDOdcKsUqrQ6K6MEBoXS1BW8_tO8mx4tcq6nvqyiuM4e2CmA@mail.gmail.com>
 <87h7evkghf.fsf@evledraar.gmail.com>
In-Reply-To: <87h7evkghf.fsf@evledraar.gmail.com>
From:   Neeraj Singh <nksingh85@gmail.com>
Date:   Wed, 8 Sep 2021 12:01:10 -0700
Message-ID: <CANQDOddSa4KguS0phCcZwK6FneSyLQQkWdrTbNM0+7dGVKVQpw@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] Implement a batched fsync option for core.fsyncObjectFiles
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     "Randall S. Becker" <rsbecker@nexbridge.com>,
        "Neeraj K. Singh via GitGitGadget" <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Christoph Hellwig <hch@lst.de>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 7, 2021 at 6:23 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar=
ab@gmail.com> wrote:
>
>
> On Tue, Sep 07 2021, Neeraj Singh wrote:
>
> > On Tue, Sep 7, 2021 at 12:54 PM Randall S. Becker
> > <rsbecker@nexbridge.com> wrote:
> >>
> >> On September 7, 2021 3:44 PM, Neeraj Singh wrote:
> >> >On Fri, Aug 27, 2021 at 4:49 PM Neeraj K. Singh via GitGitGadget <git=
gitgadget@gmail.com> wrote:
> >> >>
> >> >> Thanks to everyone for review so far! I've responded to the previou=
s
> >> >> feedback and changed the patch series a bit.
> >> >>
> >> >> Changes since v1:
> >> >>
> >> >>  * Switch from futimes(2) to futimens(2), which is in POSIX.1-2008.=
 Contrary
> >> >>    to dscho's suggestion, I'm still implementing the Windows versio=
n in the
> >> >>    same patch and I'm not doing autoconf detection since this is a =
POSIX
> >> >>    function.
> >>
> >> While POSIX.1-2008, this function is not available on every single
> >> POSIX-compliant platform. Please make sure that the code will not
> >> cause a breakage on some platforms - the ones I maintain, in
> >> particular. Neither futimes nor futimens is available on either
> >> NonStop ia64 or x86. The platform only has utime, so this needs to
> >> be wrapped with an option in config.mak.uname.
> >>
> >> Thanks,
> >> Randall
> >
> > Ugh. Fair enough.  How do other contributors feel about me moving back
> > to utime, but instead just doing the utime over in
> > builtins/pack-objects.c?  The idea would be to eliminate the mtime
> > logic entirely from write_loose_object and just do it at the top-level
> > in loosen_unused_packed_objects.
>
> Aside from where it lives, can't we just have a wrapper that takes both
> the filename & fd, and then on some platforms will need to dispatch to a
> slower filename-only version, but can hopefully use the new fd-accepting
> function?

I had some concerns around using utime() while a file descriptor is open.
There's some risk of sharing violation on Windows (doesn't matter since we'=
d
be using futimens), but I was also concerned that there might be some OSes =
that
update the mtime on close(fd), thus overwriting the effects of utime.
Maybe that's an unwarranted concern, but it's part of why I didn't want to =
have
different call sequences on different OSes.

I'd be happy to implement your suggestion though and see what happens. But =
I
also feel that this time update thing is pretty ancillary to the real
goal of my change.
I'm only doing it because it's in the same area. The effects of
getting mtime wrong
would be pretty subtle -- I think we'd just not be deleting some
unpacked unreachable
objects as soon as expected.  Do you have a strong objection to
lifting the time update
logic out?
