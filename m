Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67546C54EBE
	for <git@archiver.kernel.org>; Mon, 16 Jan 2023 17:43:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235105AbjAPRnX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Jan 2023 12:43:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235123AbjAPRmj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jan 2023 12:42:39 -0500
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 785C02FCE2
        for <git@vger.kernel.org>; Mon, 16 Jan 2023 09:21:15 -0800 (PST)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-4d59d518505so220421937b3.1
        for <git@vger.kernel.org>; Mon, 16 Jan 2023 09:21:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eyAn/DY5qpX1jAKNxLFwN5FDsHtMEHAaDkGwLc3s1wg=;
        b=dKxSm4oxTrdtGq8Bnu/wrfyCikRZLuzbrHDBp7Er9BsYo6b1xtAwN7XkhsjfF6HkDp
         0l2ih/HMTBzKLGfJsFng1o49gdPQbz5Qk+7U9lIoe0Rg298BWa+KKgYCzELewR/Rb5bI
         LQvpUnDlvM2eruT/UQkKjFlp+Jx3JxaAEkZEob/mWENLlGWsAyuZOMGQSbAIIN793Cef
         kCKWXGhWUghM/m3zUiOG4FSJhGzRR8Zch+aceM2vLIUJ4KJgMZLKT2Vzu1+gIeZf89Uc
         RU/jFHq/q/Uipiu5qolYwMV2v8LGt/+SNxbt93bgo9tRJCWDVhXr7rIs15IqD8bqxhvJ
         dKxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eyAn/DY5qpX1jAKNxLFwN5FDsHtMEHAaDkGwLc3s1wg=;
        b=1G4q7mmHzhlliH3NecOSxQjSjClbh2zZp3+CWovR4/lC0aOlCycxuOwv7X7dZy2NgI
         oOpGGNOGrh30gIHfLFBRjKltowMJGZPIGcgMs8Sv2gn+E4V9F5h5vq3MUV1BNpNUsuaQ
         8H3ReUk4Hl1qShgj6qBLdVw7gThvD4nN1X6Sg+pMEdLf/EuPSDbW/6T7HoPrjXxOOK8I
         8fzqFv32rnJT+bX5aXEOqpvBwFi0dvAKJ7oGayHS/b6ugu4Sqb5ftgJcfFC6l66wISyP
         eNZpXr+cVMLhwyRNZle7sChbhHE+hedisLr9d/93rB++lc+3ru/PZ2IFmO5DVkdYyRxM
         RzAw==
X-Gm-Message-State: AFqh2kpfm5lQKKPUkGjZtiuHKQ0UcIJp2ZdpzTY4xLGsjP3z4KnE+nxh
        4IDvU0O1FyQXN8ms+3B85lykHFtl2/TGGvJxhjc=
X-Google-Smtp-Source: AMrXdXswBd6DmSUeDdDD71Q/yBhHdvF8Ye/AmYwJqGDJLfsUduGoCWTRW1YQ8Z9J1xnAt2nlzg6UjS4HKCxSb66DXAY=
X-Received: by 2002:a81:7b86:0:b0:46a:ca45:4844 with SMTP id
 w128-20020a817b86000000b0046aca454844mr14790ywc.43.1673889674484; Mon, 16 Jan
 2023 09:21:14 -0800 (PST)
MIME-Version: 1.0
References: <pull.1463.git.1673584914.gitgitgadget@gmail.com>
 <26406a4d8797e68f0ba4fe097cf0973f60d67114.1673584914.git.gitgitgadget@gmail.com>
 <CAOLTT8RXgw0CC7TBUunCPnnk1=5gKkyYZcFQyWu29QM9bn9s9w@mail.gmail.com> <CABPp-BFFfDPT1x9E4bucuQnyVrWacego2agzyqjT7h+wQ=xpUg@mail.gmail.com>
In-Reply-To: <CABPp-BFFfDPT1x9E4bucuQnyVrWacego2agzyqjT7h+wQ=xpUg@mail.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Tue, 17 Jan 2023 01:21:03 +0800
Message-ID: <CAOLTT8Tvkz39sigiQgdRzTfFAcQO6kf3t8Pei9Mb1R2-UNje1g@mail.gmail.com>
Subject: Re: [PATCH 3/4] ls-files: clarify descriptions of status tags for -t
To:     Elijah Newren <newren@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> =E4=BA=8E2023=E5=B9=B41=E6=9C=8815=E6=97=
=A5=E5=91=A8=E6=97=A5 04:27=E5=86=99=E9=81=93=EF=BC=9A
>
> On Sat, Jan 14, 2023 at 12:27 AM ZheNing Hu <adlternative@gmail.com> wrot=
e:
> >
> > Elijah Newren via GitGitGadget <gitgitgadget@gmail.com> =E4=BA=8E2023=
=E5=B9=B41=E6=9C=8813=E6=97=A5=E5=91=A8=E4=BA=94 12:41=E5=86=99=E9=81=93=EF=
=BC=9A
> > >
> > > From: Elijah Newren <newren@gmail.com>
> > >
> > > Much like the file selection options we tweaked in the last commit, t=
he
> > > status tags printed with -t had descriptions that were easy to
> > > misunderstand, and for many of the same reasons.  Clarify them.
> > >
> > > Also, while at it, remove the "semi-deprecated" comment for "git
> > > ls-files -t".  The -t option was marked as semi-deprecated in 5bc0e24=
7c4
> > > ("Document ls-files -t as semi-obsolete.", 2010-07-28) because:
> > >
> > >     "git ls-files -t" is [...] badly documented, hence we point the
> > >     users to superior alternatives.
> > >     The feature is marked as "semi-obsolete" but not "scheduled for r=
emoval"
> > >     since it's a plumbing command, scripts might use it, and Git test=
suite
> > >     already uses it to test the state of the index.
> > >
> > > Marking it as obsolete because it was easily misunderstood, which I
> > > think was primarily due to documentation problems, is one strategy, b=
ut
> > > I think fixing the documentation is a better option.  Especially sinc=
e
> > > in the intervening time, "git ls-files -t" has become heavily used by
> > > sparse-checkout users where the same confusion just doesn't apply.
> > >
> > > Signed-off-by: Elijah Newren <newren@gmail.com>
> > > ---
> > >  Documentation/git-ls-files.txt | 28 +++++++++++++++-------------
> > >  1 file changed, 15 insertions(+), 13 deletions(-)
> > >
> > > diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-fi=
les.txt
> > > index f89ab1bfc98..3886d58d178 100644
> > > --- a/Documentation/git-ls-files.txt
> > > +++ b/Documentation/git-ls-files.txt
> > > @@ -137,25 +137,27 @@ OPTIONS
> > >         with `-s` or `-u` options does not make any sense.
> > >
> > >  -t::
> > > -       This feature is semi-deprecated. For scripting purpose,
> > > -       linkgit:git-status[1] `--porcelain` and
> > > +       Show status tags together with filenames.  Note that for
> > > +       scripting purposes, linkgit:git-status[1] `--porcelain` and
> > >         linkgit:git-diff-files[1] `--name-status` are almost always
> > >         superior alternatives, and users should look at
> > >         linkgit:git-status[1] `--short` or linkgit:git-diff[1]
> > >         `--name-status` for more user-friendly alternatives.
> > >  +
> > >  --
> > > -This option identifies the file status with the following tags (foll=
owed by
> > > -a space) at the start of each line:
> > > -
> > > -       H::     cached
> > > -       S::     skip-worktree
> > > -       M::     unmerged
> > > -       R::     removed/deleted
> > > -       C::     modified/changed
> > > -       K::     to be killed
> > > -       ?::     other
> > > -       U::     resolve-undo
> > > +This option provides a reason for showing each filename, in the form
> > > +of a status tag (which is followed by a space and then the filename)=
.
> > > +The status tags are all single characters from the following list:
> > > +
> > > +       H::     tracked file that is not either unmerged or skip-work=
tree
> > > +       S::     tracked file that is skip-worktree
> > > +       M::     tracked file that is unmerged
> > > +       R::     tracked file with unstaged removal/deletion
> > > +       C::     tracked file with unstaged modification/change
> > > +       K::     untracked paths which are part of file/directory conf=
licts
> > > +               which prevent checking out tracked files
> > > +       ?::     untracked file
> > > +       U::     file with resolve-undo information
> > >  --
> > >
> >
> > Good to see these tags describe are changed, especially "K" (reader
> > don't know what is "to be killed")
> >
> > Maybe we should mention which option will output these tags?
> > e.g. default -> "H"/"S" ,`--other` -> "?", `--modified` -> "C",
> > `--killed` -> "K"...
>
> We could, but...
>
>   * It's H/S/M, not just H/S that is shown by default.
>   * It gets weird because other options aren't added to the default,
> so if someone specifies "-m" then suddenly H/S/M go away...unless they
> also specify "-c".
>
> Trying to explain all that feels like we're getting close to repeating
> the documentation of the individual options.  But maybe we could just
> ignore everything around default behavior and find a way to be brief
> such as with:
>
>     Note that H, S, and M entries are shown with --cached; R entries
>     are shown with --deleted, C entries are shown with --modified, K
>     entries are shown with --killed, ? entries are shown with
>     --others, and U entries are shown with --resolve-undo.
>

What you mean is that each tag will appear in which commands, rather than
each command will have which tags. I think this segment is pretty good.

> I'm not sure if I like the documentation better with or without this
> added paragraph.  What do others think?
