Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14F35C433E9
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 18:46:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF20564F65
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 18:46:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232763AbhCQSph (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Mar 2021 14:45:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbhCQSpD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Mar 2021 14:45:03 -0400
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5551AC06174A
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 11:45:03 -0700 (PDT)
Received: by mail-oo1-xc35.google.com with SMTP id r17-20020a4acb110000b02901b657f28cdcso796795ooq.6
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 11:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ndWWVd24wA0+0/r91UPWz6moAKCzUXgjc5AwQf/j4zc=;
        b=IIjjTSvnaMVzwvmIvCMCzM18LyljPxV1YkE2XFd23vHY9lT+j7W1FHI93hgdbIOHWe
         CRGvqeALv1wyY7+GUOxAI1c9ZLITNPmvxEByIA4AhQ+nIG9VXztHUSlsCMiRdsQJQs8s
         S8s4fhURkdY3sPWJqBFiXZyi0HaoEG+2ZB0iJvZ1HMvAchvjsWLov4Q0JqeP5ynvILDw
         tZGaIdvt4OBcicQ/FJhLrLTXyEKgYLRqfyMcnO41LQVR1sncTp/46j8GzIEe9Ym2U+RM
         jL5WIQ4xLTzbvjbyYKjTozt/fbeN8XV2FV1ZSJJrhJsWxcSYYQVfqsyPMnEgatMSehsP
         QUfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ndWWVd24wA0+0/r91UPWz6moAKCzUXgjc5AwQf/j4zc=;
        b=FzI9Y/d+r9QlbocszDT5TV9RuoZwkhIUYTxvNyvrgpI04o8ddgYO9g7XkcLJhEjKmG
         ZSWNZcLTKDUfO7cIO/3kYp1VrdbX8rh7UtYYPDy7UGSVGbJnSw6rJt5/UOp3ZmXv0xpu
         KCmuuxKs7WV3yeOiawRiO4pqA0n3Zqg+lBT4gpQg+axg7UnG4OHHca86vcnk2C18JpZh
         2O/JKXpwCZvSK0W/FR2WZakK8yEJk/9NbrMIca2blRtsrAQNd/px7GiSOu2Jx0s8o2cX
         TKmDo4rS4qLc1x3j7QAkE0oggPqEIgznWhfgKjxX0PuD1s07ZY3Jigu7cqLeSJ4xsb/r
         mEXg==
X-Gm-Message-State: AOAM530mOTETfIVyqqVYAwhcGLeXbtDSHCtTescPHxa7FwwasIWcX+CH
        pg828flDcYFiyCO+X+7dP4y5pt9Nkq4cylWgjY114xDbmXfIyg==
X-Google-Smtp-Source: ABdhPJyNQFpS0yLToorXN+Q2XZUxGlAob0+sXU63barHNh8KDiZThtlbJR/7tk5Gr+8GFwpiLPD/kcuhFVeUuGP5nBM=
X-Received: by 2002:a4a:9101:: with SMTP id k1mr4317835oog.7.1616006702648;
 Wed, 17 Mar 2021 11:45:02 -0700 (PDT)
MIME-Version: 1.0
References: <dffe8821fde290a1e19b2968098b007b9ac213e6.1615912983.git.gitgitgadget@gmail.com>
 <20210317132814.30175-4-avarab@gmail.com> <CABPp-BEvKTw6tXmFe-BnOsA6g2vsk7vwE1mkpxXmkO__5tFchg@mail.gmail.com>
 <87lfalzldu.fsf@evledraar.gmail.com>
In-Reply-To: <87lfalzldu.fsf@evledraar.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 17 Mar 2021 11:44:51 -0700
Message-ID: <CABPp-BGeQmkwX5_W2jXBnfYWd21B7VRNOwXvo1L=7U7j718yyg@mail.gmail.com>
Subject: Re: [RFC/PATCH 3/5] ls-files: add and use a new --sparse option
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 17, 2021 at 11:27 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> On Wed, Mar 17 2021, Elijah Newren wrote:
>
> > On Wed, Mar 17, 2021 at 6:28 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> > <avarab@gmail.com> wrote:
> >>
> >> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.co=
m>
> >> ---
> >>  Documentation/git-ls-files.txt           |  4 ++
> >>  builtin/ls-files.c                       | 10 ++++-
> >>  t/t1091-sparse-checkout-builtin.sh       |  9 ++--
> >>  t/t1092-sparse-checkout-compatibility.sh | 57 ++++++++++++++++-------=
-
> >>  4 files changed, 56 insertions(+), 24 deletions(-)
> >>
> >> diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-fil=
es.txt
> >> index 6d11ab506b..1145e960a4 100644
> >> --- a/Documentation/git-ls-files.txt
> >> +++ b/Documentation/git-ls-files.txt
> >> @@ -71,6 +71,10 @@ OPTIONS
> >>  --unmerged::
> >>         Show unmerged files in the output (forces --stage)
> >>
> >> +--sparse::
> >> +       Show sparse directories in the output instead of expanding
> >> +       them (forces --stage)
> >> +
> >>  -k::
> >>  --killed::
> >>         Show files on the filesystem that need to be removed due
> >> diff --git a/builtin/ls-files.c b/builtin/ls-files.c
> >> index 4db75351f2..1ebbb63c10 100644
> >> --- a/builtin/ls-files.c
> >> +++ b/builtin/ls-files.c
> >> @@ -26,6 +26,7 @@ static int show_deleted;
> >>  static int show_cached;
> >>  static int show_others;
> >>  static int show_stage;
> >> +static int show_sparse;
> >>  static int show_unmerged;
> >>  static int show_resolve_undo;
> >>  static int show_modified;
> >> @@ -639,6 +640,8 @@ int cmd_ls_files(int argc, const char **argv, cons=
t char *cmd_prefix)
> >>                         DIR_SHOW_IGNORED),
> >>                 OPT_BOOL('s', "stage", &show_stage,
> >>                         N_("show staged contents' object name in the o=
utput")),
> >> +               OPT_BOOL(0, "sparse", &show_sparse,
> >> +                       N_("show unexpanded sparse directories in the =
output")),
> >>                 OPT_BOOL('k', "killed", &show_killed,
> >>                         N_("show files on the filesystem that need to =
be removed")),
> >>                 OPT_BIT(0, "directory", &dir.flags,
> >> @@ -705,12 +708,17 @@ int cmd_ls_files(int argc, const char **argv, co=
nst char *cmd_prefix)
> >>                 tag_skip_worktree =3D "S ";
> >>                 tag_resolve_undo =3D "U ";
> >>         }
> >> +       if (show_sparse) {
> >> +               prepare_repo_settings(the_repository);
> >> +               the_repository->settings.command_requires_full_index =
=3D 0;
> >> +       }
> >>         if (show_modified || show_others || show_deleted || (dir.flags=
 & DIR_SHOW_IGNORED) || show_killed)
> >>                 require_work_tree =3D 1;
> >> -       if (show_unmerged)
> >> +       if (show_unmerged || show_sparse)
> >>                 /*
> >>                  * There's no point in showing unmerged unless
> >>                  * you also show the stage information.
> >> +                * The same goes for the --sparse option.
> >
> > Yuck, haven't you just made --sparse an alias for --stage?  Why does
> > it need an alias?
>
> It doesn't, but --unmerged, the one other option which purely modifies
> --stage output implies --stage.

--unmerged modifies --stage output.  --sparse won't.  (Maybe it does
_now_ because the command doesn't yet support sparse-indexes, but
that's a temporary artifact.  Long term, there should be no difference
in the output.)

> So it's in line with existing UI convention in the command, it's
> probably better to keep following that than have new options behave
> differently.
>
> But yeah, we could spell out --stage --sparse in the tests.

There should not be a --sparse option.  The index is _already_ sparse
and users had to take multiple steps to make it so; users shouldn't
have to repeat themselves with each and every command they ever type
when they've created a sparse index that they want sparse behavior.

You should just spell it "--stage".

> > Was the goal just to get a quick way to make the command run under
> > repo->settings.command_requires_full_index =3D 0 without auditing the
> > codepaths?  It seems to rely on them having been audited anyway, since
> > it just falls back to the code used for --stage, so I don't see how it
> > helps.  It also suggests the command might do unexpected or weird
> > things if run without the --sparse option?  If people manually
> > configure a sparse-checkout and cone mode AND a sparse-index (it's
> > annoying how they have to specify all three instead of having to just
> > pass one flag somewhere), then now we also need to force them to
> > remember to pass extra flags to random various commands for them to
> > operate in a sane manner in their environment??
> >
> > I think this is a bad path to go down.
>
> Those are probably good points, I don't have enough overview of the
> whole sparse thing yet to say.
>
> I just thought it didn't make sense to have a series changing the nature
> of the index without corresponding tooling changes to interrogate the
> state of the index.

That makes sense to me; I agree with you on that point.

> > However, if you want to write the necessary tests to make it so that
> > ls-files can operate with command_requires_full_index =3D 0, then I
> > think that's useful.  If you want to add a special flag so that folks
> > in a sparse-checkout-with-cone-mode-with-sparse-index setup want to
> > operate densely (i.e. to show what files would be in the index if it
> > were fully populated), then I think that's useful.  But having
> > sparse-yes-with-cone-yes-very-sparse folks need to specify an extra
> > flag to commands to get sparse behavior just seems wrong to me.
>
> Maybe, but what else do you suggest for getting this information out of
> the index?

Use git ls-files without new options...as I stated here:

...
> > I do like the tests and your idea that we can use ls-files to list
> > whatever entries are in the index, I just think the tests should use
> > --stage to do that.

In other words, I think making "git ls-files" the first, or at least
one of the first, commands to be modified to behave properly in a
sparse-index world is what you should be aiming for, not some
new-option-shortcut that'll make no sense long term and persist
indefinitely.

List the entries in the index: `git ls-files`
List the entries in the index with their hash, mode, and stage: `git
ls-files --stage`

List all the entries that would be in the index if it weren't sparse:
`git ls-files --$SOME_NEW_OPTION_NAME`

You don't need to implement the --$SOME_NEW_OPTION_NAME yet, of
course.  We can just note that it's the plan to add it later.
