Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3785BC38142
	for <git@archiver.kernel.org>; Thu, 19 Jan 2023 17:40:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbjASRj7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Jan 2023 12:39:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjASRj5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jan 2023 12:39:57 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48CE72728
        for <git@vger.kernel.org>; Thu, 19 Jan 2023 09:39:55 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id e130so3485273yba.7
        for <git@vger.kernel.org>; Thu, 19 Jan 2023 09:39:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IcZtXNVy1OXjAhgEH4/A7eBq+ppdLW16k4WhACD9yb0=;
        b=nYbE2dQJs9YNjcwzZOGNX/mNnKfDwo9Z6iQW9j6KDw+l79e/6QJKo19zy2IvRTRX2u
         k4DCUlHFLdij2NF0D6dM0aVav9gELZaUadktd/MqOyEXeCsQAh11ADQ1Fi9TnkmKfAIA
         qmdKvL+/zjz6ezgMnO2ucxKOJDOmzoZp1HYmepMGh3bbQW/jH4k+5AXeaPN1f3iEiIE0
         ny7pEDT8LgxZTM1L6tmGz60OvHDw09HSO4BT/qbb87OSIT/ZOIY9Mr9BBPyfaq14c9aJ
         FZBx47+EZ2qRplywPWx7ZNMks4rEN3aE2RWBguzUBwWnJHpGtKd3g/8MGGXAE4o49xpz
         njFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IcZtXNVy1OXjAhgEH4/A7eBq+ppdLW16k4WhACD9yb0=;
        b=SqBTk7olldFahyLfmD4tJa7YKhWgf7r057RF5S4c5SHU5ipReUQctKGFIas65/37ey
         Qul7rnmP/qTzJ9lRwU8R2MAw+EW/HSCwnSW/92m+f3qeEqGn1UqOiZ/1oYfxIn6ZpJTF
         fxjo8bwF04eWWg43jRC2a6ayt+azR/h6faXsMLYL4r0Z+KNLyvz7wtWjb//PekkOgBTt
         nA0PXDZ2KGZTIyUkMzapqRlEukvYlpTHPrHkPbrxII+G2mRVN3o6eEQbY4zeTuE1Z9ho
         8o8eeSYF08RtkRzg+xEfKon3rko0EoEnv+L5s9Tdf/oV91fR0JwOFd0m2Y55LXnY60lN
         sy+Q==
X-Gm-Message-State: AFqh2kqwBNb2T4FxHynq9Jea242KJfCOeHjrroD+DKmTa43AvDPpsKPh
        SeyijCxLLydIWJZrKdt3w1+NqT0pXwO11Tk8wmU=
X-Google-Smtp-Source: AMrXdXvc3xJuz50WtaSJ5dIoAvKHd24qPaS1YBkEkC8CRPerNNZg6FUUEAizsqHhEdYEhkUQZfWWgcasWw4o9b+EAf4=
X-Received: by 2002:a25:bd14:0:b0:73f:fb7d:400 with SMTP id
 f20-20020a25bd14000000b0073ffb7d0400mr1760899ybk.352.1674149994522; Thu, 19
 Jan 2023 09:39:54 -0800 (PST)
MIME-Version: 1.0
References: <pull.1465.git.1673951562.gitgitgadget@gmail.com>
 <605b95bf8ab6f1fb5b1ec5b75cd4dcaefbb7f3b6.1673951562.git.gitgitgadget@gmail.com>
 <230117.861qntz4dc.gmgdl@evledraar.gmail.com>
In-Reply-To: <230117.861qntz4dc.gmgdl@evledraar.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Fri, 20 Jan 2023 01:39:43 +0800
Message-ID: <CAOLTT8TaUaq+RJsJ2cW9tH1tdPgYLut1z8kaLc0LeD=ft-14FQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] [RFC] push: allow delete one level ref
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Christian Couder <christian.couder@gmail.com>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> =E4=BA=8E2023=E5=
=B9=B41=E6=9C=8817=E6=97=A5=E5=91=A8=E4=BA=8C 21:18=E5=86=99=E9=81=93=EF=BC=
=9A
>
>
> On Tue, Jan 17 2023, ZheNing Hu via GitGitGadget wrote:
>
> > From: ZheNing Hu <adlternative@gmail.com>
> >
> > Git will reject the deletion of one level refs e,g. "refs/foo"
> > through "git push -d", however, some users want to be able to
> > clean up these branches that were created unexpectedly on the
> > remote.
> >
> > Therefore, when updating branches on the server with
> > "git receive-pack", by checking whether it is a branch deletion
> > operation, it will determine whether to allow the update of
> > one level refs. This avoids creating/updating such one level
> > branches, but allows them to be deleted.
> >
> > On the client side, "git push" also does not properly fill in
> > the old-oid of one level refs, which causes the server-side
> > "git receive-pack" to think that the ref's old-oid has changed
> > when deleting one level refs, this causes the push to be rejected.
> >
> > So the solution is to fix the client to be able to delete
> > one level refs by properly filling old-oid.
> >
> > Signed-off-by: ZheNing Hu <adlternative@gmail.com>
> > ---
> >  builtin/receive-pack.c |  5 ++++-
> >  connect.c              |  2 +-
> >  t/t5516-fetch-push.sh  | 13 +++++++++++++
> >  3 files changed, 18 insertions(+), 2 deletions(-)
> >
> > diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> > index 13ff9fae3ba..ad21877ea1b 100644
> > --- a/builtin/receive-pack.c
> > +++ b/builtin/receive-pack.c
> > @@ -1463,7 +1463,10 @@ static const char *update(struct command *cmd, s=
truct shallow_info *si)
> >               find_shared_symref(worktrees, "HEAD", name);
> >
> >       /* only refs/... are allowed */
> > -     if (!starts_with(name, "refs/") || check_refname_format(name + 5,=
 0)) {
> > +     if (!starts_with(name, "refs/") ||
> > +         check_refname_format(name + 5,
> > +                              is_null_oid(new_oid) ?
> > +                              REFNAME_ALLOW_ONELEVEL : 0)) {
>
> Style nit: We tend to wrap at 79 characters, adn with argument lists you
> "keep going" until you hit that limit.
>
> In this case strictly following that rule will lead to funny
> indentation, as we'll have to wrap at "is_null_oid(...)" etc.
>
> But even when avoiding that (which seems good in this case) this should
> be:
>
>         if (!starts_with(name, "refs/") ||
>             check_refname_format(name + 5, is_null_oid(new_oid) ?
>                                  REFNAME_ALLOW_ONELEVEL : 0)) {
>
>

Make sense, I'm going to fix the formatting here.

>
> >               rp_error("refusing to update funny ref '%s' remotely", na=
me);
> >               ret =3D "funny refname";
> >               goto out;
> > diff --git a/connect.c b/connect.c
> > index 63e59641c0d..b841ae58e03 100644
> > --- a/connect.c
> > +++ b/connect.c
> > @@ -30,7 +30,7 @@ static int check_ref(const char *name, unsigned int f=
lags)
> >               return 0;
> >
> >       /* REF_NORMAL means that we don't want the magic fake tag refs */
> > -     if ((flags & REF_NORMAL) && check_refname_format(name, 0))
> > +     if ((flags & REF_NORMAL) && check_refname_format(name, REFNAME_AL=
LOW_ONELEVEL))
>
> Here we should wrap after "name,", we end up with a too-long line.
>

To be honest, sometimes it's hard to notice if the current line is longer
than 79 characters, it's often a matter of intuition. Is there any ci scrip=
t
that can detect this kind of problem?

> >               return 0;
> >
> >       /* REF_HEADS means that we want regular branch heads */
> > diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
> > index f37861efc40..dec8950a392 100755
> > --- a/t/t5516-fetch-push.sh
> > +++ b/t/t5516-fetch-push.sh
> > @@ -903,6 +903,19 @@ test_expect_success 'push --delete refuses empty s=
tring' '
> >       test_must_fail git push testrepo --delete ""
> >  '
> >
> > +test_expect_success 'push --delete onelevel refspecs' '
> > +     mk_test testrepo heads/main &&
> > +     (
> > +             cd testrepo &&
> > +             git update-ref refs/onelevel refs/heads/main
> > +     ) &&
>
> Avoid the subshell here with:
>
>         git -C update-ref ....
>

OK.

> > +     git push testrepo --delete refs/onelevel &&
> > +     (
> > +             cd testrepo &&
> > +             test_must_fail git rev-parse --verify refs/onelevel
>
> Ditto.


Thanks,
ZheNing Hu
