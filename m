Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4505EC6377D
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 08:19:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28B5661279
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 08:19:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230405AbhGVHjU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Jul 2021 03:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbhGVHjU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jul 2021 03:39:20 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A0EAC061575
        for <git@vger.kernel.org>; Thu, 22 Jul 2021 01:19:55 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id o8so4630183ilf.4
        for <git@vger.kernel.org>; Thu, 22 Jul 2021 01:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=uTCpA9PtOiLdZt3suUvpS2jdO0Nor76CNo8nRk6OYGw=;
        b=oFhNyuo1TJtG9uFIxAUhEk7WLQ87Ij9HmAWG+PC/WDVThhPgmjfuMKHO58pYlCtjis
         4p2fC/xRGOHYSmDiL8g91CFx4Y4tUpS1B/tnxwrGPPSYFJKnRm4R0/CnTq3rCjwiN2IP
         jJNDc2mhxbjYSLS18JmUH7pJXt0s4hCRZJ5mlod4CLNHQSqnyLRywRRrH/+5cl9iBzJN
         Iu9V8oVBX1aSg2xGJGTl0dFuPpnaw4qdg5QLKGX8J2yNdmBOx57b13/q7y9IB9XT48jY
         iD6543LO4e7Khcfx1e4Kvykng2vN1+WFHsGtGQpVH4VtARFHYvm5SSXSkY9IQDeKF/2N
         j05A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=uTCpA9PtOiLdZt3suUvpS2jdO0Nor76CNo8nRk6OYGw=;
        b=oaBlmMZo2OCjv4OyI8jr/qXFCacS4+f5u8gqwOpotLFumFLEoRqEeYppW++dBe8/fU
         Zrc9NQnXIuxeqxfCwdES508h/FIsqvpZfoVtzb3fTNZxdaMv5j7ZfprjFJMx/A7tApAz
         ifVA+2SPGkciJ8Ey4WtHBUPLZt6nZGHWrbUQOMZKkbi82/bHyUdqsBnEHo/FCReJIt+e
         naZ2rgXqPTi38jJLEn2asmITl+wLfpejNgL8+oYD8E4k4cPycOy9rB98KuQJPfBRjp4m
         hoziva8aqxyST8AHhZxoQ36tIB18DbXxhvePcQe2gCEE4HuqTt9r5i/VvLm51WM0MDZ4
         Qi+g==
X-Gm-Message-State: AOAM5322DOZuGvlQC8aLhx2jrVKsVFvdFuhPQOEs2CW0vrCq9Cmhuimt
        xhV++v+7NCNChvE5Ayh15Jx2sLo0FvIFsfpPWAM=
X-Google-Smtp-Source: ABdhPJy7uWZkFUgt0HCO1ni7807LwQA9gZj9vhrfpGGa5P8t9rxHEqohjdFJTP9201PFGXoTvSvjewPlnxXcmGcWGqI=
X-Received: by 2002:a05:6e02:114e:: with SMTP id o14mr26825186ill.301.1626941994933;
 Thu, 22 Jul 2021 01:19:54 -0700 (PDT)
MIME-Version: 1.0
References: <CAOLTT8QLrG+R3sOHpMsAiveOT1wTKR-_Nw8Ro6iXL1_MTMZ6eA@mail.gmail.com>
 <CAP8UFD1Y-sL9UbU_U-adUhzMgR-UFFSNg6tdM=45c878WHhURQ@mail.gmail.com>
In-Reply-To: <CAP8UFD1Y-sL9UbU_U-adUhzMgR-UFFSNg6tdM=45c878WHhURQ@mail.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Thu, 22 Jul 2021 16:20:19 +0800
Message-ID: <CAOLTT8Qc3r+Bfzaorq-oc5Jebh=9TRCgCHYWarS2xb9UQ5v9rw@mail.gmail.com>
Subject: Re: [GSoC] Git Blog 9
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Hariom verma <hariom18599@gmail.com>,
        Atharva Raykar <raykar.ath@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> =E4=BA=8E2021=E5=B9=B47=E6=9C=
=8822=E6=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=883:50=E5=86=99=E9=81=93=
=EF=BC=9A
>
> On Mon, Jul 19, 2021 at 8:55 AM ZheNing Hu <adlternative@gmail.com> wrote=
:
> >
> > My ninth week blog finished:
> > The web version is here:
> > https://adlternative.github.io/GSOC-Git-Blog-9/
>
> Thanks!
>
> > ## Week9 BUG REPORT
> >
> > ### BUG REPORT 1
>
> First, it would be better if these bugs were submitted to the mailing
> list separately, one in each own email with a relevant subject, so
> that people can more easily find and discuss them separately. It's ok
> then if you link to these bug reports from, or copy parts of them to,
> a blog post.
>

You're right. Maybe the content of the blog did not attract everyone's
attention.

> > * What did you do before the bug happened? (Steps to reproduce your iss=
ue)
> >
> > Because someone told me that `git cherry-pick` can't gave useful
> > prompt information like `git rebase -i` does:
> >
> > ```
> > You can amend the commit now, with
> >
> > git commit --amend
> >
> > Once you are satisfied with your changes, run
> >
> > git rebase --continue
> > ```
> >
> > I found that I can take use of "GIT_CHERRY_PICK_HELP" environment varia=
ble,
> >
> > ```
> > $ GIT_CHERRY_PICK_HELP=3D"git cherry-pick --continue" ggg cherry-pick v=
1
>
> Not sure what `ggg` is. Is it GitGitGadget, `git`, an alias with some
> features turned on, or something else?
>

Oh, it's just git/bin-wrappers/git.

> Not sure what is `v1` also. Is it a tag to a random commit?

Yeah.

>
> > ```
> >
> > which will output prompt information "git cherry-pick --continue", good=
!
> >
> > * What did you expect to happen? (Expected behavior)
> >
> > I could use `git cherry-pick --abort` to exit cherry-pick normally.
> >
> > * What happened instead? (Actual behavior)
> >
> > Then I couldn't use `git cherry-pick --abort` to exit cherry-pick norma=
lly.
>
> What happened when you tried to use it? Or what prevented you from using =
it?
>
> > * Anything else you want to add:
> >
> > See the print_advice() in sequencer.c, `CHERRY_PICK_HEAD` will be remov=
ed
> > if we use the env "GIT_CHERRY_PICK_HELP". It is used by `git rebase
> > -i` and somewhere else.
>
> So you got an error because `CHERRY_PICK_HEAD` had been removed?
>

Yeah, this is the situation I encountered.

> > Here may have two solutions:
> > 1. Prevent users from using the environment variable "GIT_CHERRY_PICK_H=
ELP".
>
> This means that we should remove it, right? Otherwise what's the
> purpose of keeping it if users are prevented from using it? Or maybe
> there is something I don't understand?
>

Yeah, this may require rebase -i to use some new methods to achieve
the original functions.

> > 2. check if we are truly cherry-pick.
> >
> > ```c
> > diff --git a/sequencer.c b/sequencer.c
> > index 0bec01cf38..c01b0b9e9c 100644
> > --- a/sequencer.c
> > +++ b/sequencer.c
> > @@ -409,8 +409,9 @@ static void print_advice(struct repository *r, int
> > show_hint,
> > * (typically rebase --interactive) wants to take care
> > * of the commit itself so remove CHERRY_PICK_HEAD
> > */
> > - refs_delete_ref(get_main_ref_store(r), "", "CHERRY_PICK_HEAD",
> > - NULL, 0);
> > + if (opts->action !=3D REPLAY_PICK)
> > + refs_delete_ref(get_main_ref_store(r), "", "CHERRY_PICK_HEAD",
> > + NULL, 0);
> > return;
> > }
> > ```
>
> So this solution means not removing CHERRY_PICK_HEAD if we are indeed
> cherry-picking instead of rebasing. Yeah, this looks like a logical
> solution to the issue to me. Could you send this in a separate patch
> with a proper commit message?
>

I haven't carefully verified its correctness. but okay, I will send it
separately.

> > ### BUG REPORT 2
>
> Thanks Atharva for replying to this bug report!
>
> > ### project progress
> >
> > I am still thinking about how to improve the performance of `git
> > cat-file --batch`.
> > This cannot be solved quickly, keep patient.
>
> Yeah, sure! In cases like this when the issue is not easy to
> understand, it could be a good idea to keep some kind of research
> journal where you describe the issue, the possible ways to solve it
> and how your research to solve it goes. It could be a text or markdown
> file in a branch, or a shared Google doc, for example.
>

Great, I happen to have the same idea as you. Some private attempts do
not seem to really improve the performance of ref-filters, maybe I should s=
how
them to you.


> > My mentors told me to split my main patch series into a few smaller
> > patch series, but how?
> > In other words, there is a certain correlation between these patches,
> > If they are really split into
> > multiple patches, how can I send them to the mailing list without repea=
ting?
>
> Yeah, I am not sure if it's possible and easy to send a patch series
> based upon another one when using GitGitGadget. But you could perhaps
> still send the first patch series, and then focus on getting it merged
> and on performance issues. Discussing performance issues can probably
> be done by only sending diffs in regular emails or RFC patches that
> cannot be applied to the mailing list until a proper solution is
> found.

Now I have an idea:
The latter patch will not be sent to the mailing list first, and we
can wait for the
previous patch merge to master first.
In the meantime, let us discuss performance solutions.

> > I just received half of the GSoC bonus, and felt a burden of responsibi=
lity...
>
> No need to feel too much responsibility, we all share responsibility
> in this. Also feel free to privately email me or Hariom and me (maybe
> Kaartic too) if you want to discuss this further privately.

I just think it seems that the "performance" problem seems to have not been
solved well by Olga at the time, so I feel a certain amount of pressure.

Thanks!!!
--
ZheNing Hu
