Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BABE1C47083
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 13:16:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EBC5613AA
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 13:16:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbhFBNRw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Jun 2021 09:17:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbhFBNRv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Jun 2021 09:17:51 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73B6EC061574
        for <git@vger.kernel.org>; Wed,  2 Jun 2021 06:16:08 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id o9so2093263ilh.6
        for <git@vger.kernel.org>; Wed, 02 Jun 2021 06:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wgrG9xbwRYiGLpbgTiiJOoY+94osYeF7yboPiyr7ZzY=;
        b=bcdrNLJQYMg9KzQb2PxLAxr83sJQ3U9vB4FCmWNoxxo8lisvK8zL5OGT/jf837xdit
         z6ItujbXs6ardRhdlyJgE5Zfl/1JDGNN/fVMQDN4nHhQXtC10Lh9cNQoP1fsvGGyfPrV
         3exDEzD5bJqEQs7uunTgjaYbNNIsShQ1WWO9qJKCrL9gGAiDWDzQfwOQllL7z2ifbg7J
         /3rhxpQhiqsRh+qsAQoZXNLVEEHiHL9HHTcZA1nNw2ELbmRL8gDHSkHdRUWZMpBhaUIH
         RRu4d8YOm8bIMEfH2thi0j+RmImaD5+3NQB1Um4PtA3n6TCb15PkHDOaTxzFyGw/jKfn
         CnVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wgrG9xbwRYiGLpbgTiiJOoY+94osYeF7yboPiyr7ZzY=;
        b=nO3itJdTD2Zu8/IQQTr1ULiIdeSJc9DfHHJWy8eE5b78CnnTqOGuxt5TVrIib64S1m
         f86XFxgIuJcv5GKHDz+Ep3LsD28dY5BqHwsHD7/Dp86gufi2AO1qKJnX0Egjzex42NXK
         9VoH0fnven4Q5U9HXqd9jA1ZvG8RSeBAPPN/wqYWJk37LC6wi82hfMgA9cmVmgUwiK4S
         PdiOV3xuFKsxHR5UrzaNWwWxBlizmRrsD5QZt5UOaYABEtmPDNXKoMBQom932G8ovlbd
         joqbLH5rVpFoAzNrnb98UIOtZgJ3XCRN2LYIWKc3NNMHXeuOW/UMkt+htUxfceLoO2aw
         2FWw==
X-Gm-Message-State: AOAM533tgrO5p+YKxMBff5HUNvh0yU+nQeik2gVsQ1Hv8lj0qwNwLRYU
        d9BQR28ZRwUncHwRPepMRnCsgr7sGWj6kXop6Oz8BInpstwZzA==
X-Google-Smtp-Source: ABdhPJxdtlsAYgg3vFSbe40VVdz6xCb3k2Ko37qHavjjEyQtt5nJRBKywKxHlBS5zDBewQ4F4Go3YHBhHTV+2yeMrgw=
X-Received: by 2002:a05:6e02:1063:: with SMTP id q3mr15150179ilj.259.1622639767830;
 Wed, 02 Jun 2021 06:16:07 -0700 (PDT)
MIME-Version: 1.0
References: <pull.967.git.1622558157.gitgitgadget@gmail.com>
 <495cd90dbaf43e957d03edd2fdc7449b39eee53a.1622558157.git.gitgitgadget@gmail.com>
 <YLZXyBJ5YgGfmkKv@coredump.intra.peff.net>
In-Reply-To: <YLZXyBJ5YgGfmkKv@coredump.intra.peff.net>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Wed, 2 Jun 2021 21:15:45 +0800
Message-ID: <CAOLTT8SCeKy74cVO3K5zJ5n=0s=o9zk2ipV5wM6CHQPzRoMi5Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] [GSOC] cat-file: fix --batch report changed-type bug
To:     Jeff King <peff@peff.net>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> =E4=BA=8E2021=E5=B9=B46=E6=9C=881=E6=97=A5=E5=91=
=A8=E4=BA=8C =E4=B8=8B=E5=8D=8811:52=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue, Jun 01, 2021 at 02:35:56PM +0000, ZheNing Hu via GitGitGadget wro=
te:
>
> > From: ZheNing Hu <adlternative@gmail.com>
> >
> > When `--batch` used with `--batch-all-objects`,
> > with some format atoms like %(objectname), %(rest)
> > or even no atoms may cause Git exit and report
> > "object xxx changed type!?".
> >
> > E.g. `git cat-file --batch=3D"batman" --batch-all-objects`
> >
> > This is because we did not get the object type through
> > oid_object_info_extended(), it's composed of two
> > situations:
> >
> > 1. Since object_info is empty, skip_object_info is
> > set to true, We skipped collecting the object type.
> >
> > 2. The formatting atom like %(objectname) does not require
> > oid_object_info_extended() to collect object types.
> >
> > The correct way to deal with it is to swap the order
> > of setting skip_object_info and setting typep. This
> > will ensure that we must get the type of the object
> > when using --batch.
>
> Thanks, this explanation and the patch make sense, and I'd be happy if
> we take it as-is. But in the name of GSoC, let me offer a few polishing
> tips.
>

Thanks, as a GSOC student, your reminders will be very helpful to me.

> The commit message hints at the root of the problem, but doesn't say it
> explicitly. Which is: because setting skip_object_info depends on seeing
> that the object_info is empty, we can't add items to it after setting
> that flag. And the code path for --batch does that, hence re-ordering
> them is the solution.
>

Um, let's rewrite the commit message, I don't know if this is accurate:

[GSOC] cat-file: fix --batch report changed-type bug

When `--batch` used with `--batch-all-objects`,
with some format atoms like %(objectname), %(rest)
or even no atoms may cause Git exit and report
"object xxx changed type!?".

E.g. `git cat-file --batch=3D"batman" --batch-all-objects`

The bug was present from when the skip_object_info code
was initially added in 845de33a5b (cat-file: avoid
noop calls to sha1_object_info_extended, 2016-05-18).

This is because we did not get the object type through
oid_object_info_extended(), it's composed of two
situations:

1. all_objects will be set to true when we use
`--batch-all-objects`, seeing that object_info
is empty, skip_object_info will be to true,
`oid_object_info_extended()` will not get the
type of the object.

2. The formatting atom like %(objectname) does
not require oid_object_info_extended() to collect
object types.

print_contents will be set to true when we use
`--batch`, which can make object_info non-empty,
so the solution is to swap the code order of it
and checking if object_info is empty, which will
ensure that we must get the type of the object
when using --batch.

> It might also be worth noting that the bug was present from when the
> skip_object_info code was initially added in 845de33a5b (cat-file: avoid
> noop calls to sha1_object_info_extended, 2016-05-18).
>

OK.

> > +test_expect_success 'cat-file --batch=3D"%(objectname)" with --batch-a=
ll-objects will work' '
> > +     git -C all-two cat-file --batch-all-objects --batch-check=3D"%(ob=
jectname)" >objects &&
> > +     git -C all-two cat-file --batch=3D"%(objectname)" <objects >expec=
t &&
> > +     git -C all-two cat-file --batch-all-objects --batch=3D"%(objectna=
me)" >actual &&
> > +     cmp expect actual
> > +'
>
> OK, we're checking the output of --batch-all-objects versus taking the
> object list from the input. We can depend on the ordering being
> identical between the two because --batch-all-objects sorts. Good.
>
> > +test_expect_success 'cat-file --batch=3D"%(rest)" with --batch-all-obj=
ects will work' '
> > +     git -C all-two cat-file --batch=3D"%(rest)" <objects >expect &&
> > +     git -C all-two cat-file --batch-all-objects --batch=3D"%(rest)" >=
actual &&
> > +     cmp expect actual
> > +'
>
> This one is rather curious. It definitely shows the bug, but I can't
> imagine why %(rest) would be useful with --batch-all-objects, since its
> purpose is to show the rest of the input line (and there are no input
> lines!).
>

I wanted to argue that print_object_or_die() will use data->rest originally=
.
But --batch-all-objects and --textconv and --filter are incompatible.
So your idea is reasonable: %(rest) with --batch-all-objects is useless.

> That might be a problem later if we change the behavior (e.g., to say
> "%(rest) does not make sense with --batch-all-objects"). But I'm also OK
> leaving it for now; somebody later can dig up this commit via git-blame.
>

Yes, I think this feature can be completed later.(not in this patch)

> > +test_expect_success 'cat-file --batch=3D"batman" with --batch-all-obje=
cts will work' '
> > +     git -C all-two cat-file --batch=3D"batman" <objects >expect &&
> > +     git -C all-two cat-file --batch-all-objects --batch=3D"batman" >a=
ctual &&
> > +     cmp expect actual
> > +'
>
> And this one is a more extreme version of the "%(objectname)" one. It's
> useful as a regression test because we might later change the
> optimization so that %(objectname) ends up filling in the other object
> info.
>

Yes, it does not use atoms, so it is the most special.

> There's a subtle dependency here on the "objects" file from the earlier
> test. In such a case, we'll often split that out as a separate setup
> step like:
>
>   test_expect_success 'set up object list for --batch-all-objects tests' =
'
>         git -C all-two cat-file --batch-all-objects --batch-check=3D"%(ob=
jectname)" >objects
>   '
>
> That makes it more clear that all three of the other tests are doing the
> same thing (just with different formats), and can be reordered, removed,
> etc, later if we wanted to. So not a correctness thing, but rather just
> communicating the structure of the tests to later readers.
>

Makes sense.

> -Peff

Thanks.
--
ZheNing Hu
