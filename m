Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D94AC4320A
	for <git@archiver.kernel.org>; Wed, 28 Jul 2021 07:34:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 657A560F9C
	for <git@archiver.kernel.org>; Wed, 28 Jul 2021 07:34:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234970AbhG1He7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Jul 2021 03:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234745AbhG1Hey (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jul 2021 03:34:54 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AF8EC061765
        for <git@vger.kernel.org>; Wed, 28 Jul 2021 00:34:52 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id gn26so3066439ejc.3
        for <git@vger.kernel.org>; Wed, 28 Jul 2021 00:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Z6GnWVdLm5Bl8586tcB+dGXgmaSb4QWvKvZi/c7c304=;
        b=ePQlnmd1ESvRS7+e/BuEsDHHoEuEhgIDM5X23D/BqywNyIkoWNSBtdb50AvrWEjd97
         WUf1RhvUn6s6DoK0GLWf+HW2ACzCXuUyy7DJzvpUJfF+97UUfxD3EY09YHCGqsuNt5Ii
         ifXMfz8/vghmmqhlVERMhPZjpGSBO79OG1jC6wtE98du7jBwsgOdCCnh7zgH8vemQB9s
         1pJvyMSY4nfXQbSo+dUvq0WG+CLkFKs42H8/zIhcskwD7uIe1VQo8R2XdHuPMPdazPA/
         lmM3FX38NjBX617I5222BDAmZ14Gj/HaQI2BbWhM/BvZ1f1gO7o8K4ClJ1tTbsHOcFK8
         wdeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Z6GnWVdLm5Bl8586tcB+dGXgmaSb4QWvKvZi/c7c304=;
        b=mUZ/f4D6Lg6LDmphROM69aN+yh7CoClrMnZbvua0eVJFaSRHeXHXktD3cn8qX2GXl/
         F32QicELmeI3iM8fgHyRxgZ2Du1CwJtRu8IsyCGV2Gp5idqUsmv9YR/MNNbvMG4zb7Cz
         fxl2iLdUmo+MWoka4JJjPVzHzN+vLgFVAlF2kxQS8voY8h+eZUPYb9hlo1Plz8x1UUYs
         G6Snv3btIkqDnsMV8CXt+KrIL2sdhzMBSkKBRC0tfjCCDywN2ADBalxHn6opnI4i+gEo
         MyeMRnuKVu8m/60ujJ6agWxK1ScoIo9GvjyxpZ7Aq5Oi0mup1SJ+oV+Q6ISZtriM8uI0
         TN1Q==
X-Gm-Message-State: AOAM532sgMnzFRgXUS9RHGkFCLuK8ORVImE1AYWGC+4Zjh/yp+8gzqnF
        ZANHSm+u/CKYWPVvkaB+Phmt8NyLWSs/xc4KFfc=
X-Google-Smtp-Source: ABdhPJzNunet11q5G25OO0X3MZ92NhwihckcSMpHF0aH2BgP/2TyEkNl3eaJyHOwT/fyAj2asdzyAVgy9yVyu3SrtLs=
X-Received: by 2002:a17:906:58c7:: with SMTP id e7mr25244825ejs.197.1627457690699;
 Wed, 28 Jul 2021 00:34:50 -0700 (PDT)
MIME-Version: 1.0
References: <CAOLTT8RR3nvtXotqhSO8xPCzGQpGUA8dnNgraAjREZ6uLf4n4w@mail.gmail.com>
 <87im0zs8wn.fsf@evledraar.gmail.com> <CAOLTT8Sbusr8=iJbG1qXcSerivZqP5xm-GS8R7TqDMh7QXSZaA@mail.gmail.com>
 <CAP8UFD1szPO-qmusSqiLRWxynV0gcy8UsnZORNn0USYAmRUGVw@mail.gmail.com> <CAOLTT8TdL7UhfVSOzbpmo-WFNrcKwmy=E720tNt4KM9o_p=keg@mail.gmail.com>
In-Reply-To: <CAOLTT8TdL7UhfVSOzbpmo-WFNrcKwmy=E720tNt4KM9o_p=keg@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 28 Jul 2021 09:34:39 +0200
Message-ID: <CAP8UFD1WtSX59AqfG=d0Ge2BcK+8LdyZk0mQuftpu=FKX-877Q@mail.gmail.com>
Subject: Re: [GSOC] How to improve the performance of git cat-file --batch
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Hariom verma <hariom18599@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 27, 2021 at 3:37 AM ZheNing Hu <adlternative@gmail.com> wrote:
>
> Christian Couder <christian.couder@gmail.com> =E4=BA=8E2021=E5=B9=B47=E6=
=9C=8826=E6=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=885:38=E5=86=99=E9=81=
=93=EF=BC=9A
> >
> > On Sun, Jul 25, 2021 at 2:04 PM ZheNing Hu <adlternative@gmail.com> wro=
te:
> > > =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> =E4=BA=8E20=
21=E5=B9=B47=E6=9C=8825=E6=97=A5=E5=91=A8=E6=97=A5 =E4=B8=8A=E5=8D=885:23=
=E5=86=99=E9=81=93=EF=BC=9A
> >
> > > > Having skimmed it I'm a bit confused about this in reference to
> > > > performance generally. I haven't looked into the case you're discus=
sing,
> > > > but as I noted in
> > > > https://lore.kernel.org/git/87im1p6x34.fsf@evledraar.gmail.com/ the
> > > > profiling clearly shows that the main problem is that you've added
> > > > object lookups we skipped before.
> > >
> > > Yeah, you showed me last time that lookup_object() took up a lot of t=
ime.
> >
> > Could the document explain with some details why there are more calls
> > to lookup_object()?

Please note that here we are looking for the number of times the
lookup_object() function is called. This means that to measure that
properly, it might actually be better to have some way to count this
number of times the lookup_object() function is called, rather than
count the time spent in the function.

For example you could add a trace_printf(...) call in the
lookup_object() function, set GIT_TRACE=3D/tmp/git_trace.log, and then
just run `git cat-file --batch ...` and count the number of times the
new trace from lookup_object() appears in the log file.

> > For example it could take an example `git cat-file
> > --batch ...` command (if possible a simple one), and say which
> > functions like lookup_object() it was using (and how many times) to
> > get the data it needs before using the ref-filter logic, and then the
> > same information after using the ref-filter logic.
>
> Sorry but this time I use gprof but can=E2=80=99t observe the same effect=
 as before.
> lookup_object() is indeed a part of the time overhead, but its proportion=
 is
> not very large this time.

I am not sure gprof is a good tool for this. It looks like it tries to
attribute spent times to functions by splitting time between many low
level functions, and it doesn't seem like the right approach to me.
For example if lookup_object() is called 5% more often, it could be
that the excess time is attributed to some low level functions and not
to lookup_object() itself.

That's why we might get a more accurate view of what happens by just
counting the number of time the function is called.

> > It could be nice if there were also some data about how much time used
> > to be spent in lookup_object() and how much time is now spent there,
> > and how this compares with the whole slowdown we are seeing. If =C3=86v=
ar
> > already showed that, you can of course reuse what he already did.

Now I regret having wrote the above, sorry, as it might not be the
best way to look at this.

> This is my test for git cat-file --batch --batch-all-objects >/dev/null:

[...]

> Because we called parse_object_buffer() in get_object(), lookup_object()
> is called indirectly...

It would be nice if you could add a bit more details about how
lookup_object() is called (both before and after the changes that
degrade performance).

> We can see that some functions are called the same times:

When you say "the same times" I guess you mean that the same amount of
time is spent in these functions.

> patch_delta(),
> unpack_entry(), hashmap_remove()... But after using my patch,
> format_ref_array_item(), grab_sub_body_contents(), get_object(), lookup_o=
bject()
> begin to occupy a certain proportion.

Thanks!
