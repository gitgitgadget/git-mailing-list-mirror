Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C926C4338F
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 08:08:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 439F260F00
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 08:08:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239746AbhHMIIq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Aug 2021 04:08:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239668AbhHMIIq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Aug 2021 04:08:46 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89BC2C061756
        for <git@vger.kernel.org>; Fri, 13 Aug 2021 01:08:19 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id q16so9782173ioj.0
        for <git@vger.kernel.org>; Fri, 13 Aug 2021 01:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NArSPMQBczuOdrm1lP0kx9c0myrXfty9pZU6Nc9hBc4=;
        b=GuOrzpRvh5o7fNHLFvNO3baRGeyZPC5+27y9bS014wzm1PVL0KvJniFSU6dvAkZIRP
         hciuXQpcdbcPsdB3grJYEqOuqQq7idLLo/eFZ7e0sAhoKEKpQNzhZOCynIHH923sfmvu
         OoLWxA6ByG28C5hZ/km7bmR4RHgxjhUc6vcE5rHPOIHl96MWen/H2wqcnrYfMgQSfZ1g
         VememBcyWCQYRXpGFcQhXyRGd/Z83f180R1eWIR6YjIjanLRVSN3L9GYMXX3POfGhN/0
         KAmCRXkeM+2iBtx7gbbWHgH1EP6SCDqFJMQbE9G5+LuUAQW9PIVIuNHuRdr0odC+jUtI
         oTZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NArSPMQBczuOdrm1lP0kx9c0myrXfty9pZU6Nc9hBc4=;
        b=nm/ZaW3qiLcCEzCKM5rgQzcy89JxEIkzI/HX/B1QIqIJ9tczq3bgffHaORdDuEr9cf
         pgXroK9hy+VDUYslK5xW1EREiHqmSAMBNwAGTlSwfupP2rXYz21PvB+NQjAkQ2xIpwL1
         VVzJWd+sXIG8gT9u9eRbjg9lZkYJJnM8Z9WDK5saqKWXioWxm87bFK1ercmPExX/oWuv
         BdsIkWMTC2BToN0DiXONlWFB4jNoWdsTUKvWW/S7tZOZic62DyKrVN8IAd7OsKsB68iL
         +6cQQi2fe4VazGv7Hhz0lPFCEaHJtNAA5Jynuf6L0/BTnSvnI5FpvVlshw0Xv3GYWyRV
         d2Ng==
X-Gm-Message-State: AOAM531TDZcem1I5TozYEwIdBs88JVZZUG8nVj1fwWi3MYsWzHQ0n/hL
        GPz0lhwvd7zOU18riVsR9DmnC2zjx+gAz17x+Nk=
X-Google-Smtp-Source: ABdhPJw1dSACU5KTkBe+kFdKmgyaoxehYG53Q/h68b2MpcQWqxLu8DLRV7O/snI00Libl5+6s47P6C/i0Tw5wtjlRso=
X-Received: by 2002:a02:a488:: with SMTP id d8mr1132234jam.50.1628842099065;
 Fri, 13 Aug 2021 01:08:19 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1010.v2.git.1627953383.gitgitgadget@gmail.com>
 <pull.1010.v3.git.1628142482640.gitgitgadget@gmail.com> <a510722c-d5a2-f00c-dd20-dd7f76da2408@gmail.com>
In-Reply-To: <a510722c-d5a2-f00c-dd20-dd7f76da2408@gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Fri, 13 Aug 2021 16:08:08 +0800
Message-ID: <CAOLTT8QGD08BRuJ5Z8kLdS8gFx+HBeZfsgqotTz0Xch3BNHGPg@mail.gmail.com>
Subject: Re: [PATCH v3] [GSOC] cherry-pick: use better advice message
To:     phillip.wood@dunelm.org.uk
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Ramkumar Ramachandra <artagnon@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,
sorry for the late reply, I am busy processing the patches on the
ref-filter side.

Phillip Wood <phillip.wood123@gmail.com> =E4=BA=8E2021=E5=B9=B48=E6=9C=8811=
=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=886:00=E5=86=99=E9=81=93=EF=BC=
=9A
>
> On 05/08/2021 06:48, ZheNing Hu via GitGitGadget wrote:
> > From: ZheNing Hu <adlternative@gmail.com>
> > [...]
> >   sequencer.c                     | 11 +++++++++--
> >   t/t3507-cherry-pick-conflict.sh | 17 ++++++++++++-----
> >   2 files changed, 21 insertions(+), 7 deletions(-)
> >
> > diff --git a/sequencer.c b/sequencer.c
> > index 0bec01cf38e..7fa91b99870 100644
> > --- a/sequencer.c
> > +++ b/sequencer.c
> > @@ -403,7 +403,7 @@ static void print_advice(struct repository *r, int =
show_hint,
> >       char *msg =3D getenv("GIT_CHERRY_PICK_HELP");
> >
> >       if (msg) {
> > -             fprintf(stderr, "%s\n", msg);
> > +             advise("%s\n", msg);
> >               /*
> >                * A conflict has occurred but the porcelain
> >                * (typically rebase --interactive) wants to take care
> > @@ -415,7 +415,14 @@ static void print_advice(struct repository *r, int=
 show_hint,
> >       }
> >
> >       if (show_hint) {
> > -             if (opts->no_commit)
> > +             if (opts->action =3D=3D REPLAY_PICK) {
>
> This changes means we give the wrong advice for 'git cherry-pick
> --no-commit'. I think you want to keep the existing clause as the first
> one and insert this before the else. The advice itself looks good. It
> would be nice to improve the advice for 'git revert' in the same way.
>

Make sense.

> > +                     advise(_("Resolve all conflicts manually, mark th=
em as resolved with\n"
> > +                              "\"git add/rm <conflicted_files>\", then=
 run\n"
> > +                              "\"git cherry-pick --continue\".\n"
> > +                              "You can instead skip this commit: run \=
"git cherry-pick --skip\".\n"
> > +                              "To abort and get back to the state befo=
re \"git cherry-pick\",\n"
> > +                              "run \"git cherry-pick --abort\"."));
> > +             } else if (opts->no_commit)
> >                       advise(_("after resolving the conflicts, mark the=
 corrected paths\n"
> >                                "with 'git add <paths>' or 'git rm <path=
s>'"));
> >               else
> > diff --git a/t/t3507-cherry-pick-conflict.sh b/t/t3507-cherry-pick-conf=
lict.sh
> > index 014001b8f32..d3ed9d7ce0d 100755
> > --- a/t/t3507-cherry-pick-conflict.sh
> > +++ b/t/t3507-cherry-pick-conflict.sh
> > @@ -53,9 +53,12 @@ test_expect_success 'advice from failed cherry-pick'=
 "
> >       picked=3D\$(git rev-parse --short picked) &&
> >       cat <<-EOF >expected &&
>
> If you quote the here doc end marker then there is no substitution in
> the here doc so writing
>
>         cat <<-\EOF >expected &&
>
> >       error: could not apply \$picked... picked
> > -     hint: after resolving the conflicts, mark the corrected paths
> > -     hint: with 'git add <paths>' or 'git rm <paths>'
> > -     hint: and commit the result with 'git commit'
> > +     hint: Resolve all conflicts manually, mark them as resolved with
> > +     hint: \"git add/rm <conflicted_files>\", then run
>
> means you can replace \" with " here
>

Thanks, I haven't paid attention to this detail before.

> Best Wishes
>
> Phillip
>

Thanks,
--
ZheNing Hu
