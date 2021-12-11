Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 696D8C433EF
	for <git@archiver.kernel.org>; Sat, 11 Dec 2021 06:35:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229474AbhLKGfA (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Dec 2021 01:35:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbhLKGe7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Dec 2021 01:34:59 -0500
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAB8DC061714
        for <git@vger.kernel.org>; Fri, 10 Dec 2021 22:34:58 -0800 (PST)
Received: by mail-ua1-x934.google.com with SMTP id r15so20539015uao.3
        for <git@vger.kernel.org>; Fri, 10 Dec 2021 22:34:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FbE5w+h2BSEXkPPIBskJCIIdNlKwd9UCXI4hG/L3cN4=;
        b=ET/DarEC5i/08UB/hIawllTFBPqfecJWsOuFD+2sYRlXYF4wowXdL9sysFvMpKz1Vt
         Wwo4XKfevSHqK7k5csOSUJDuEgCXyJEdhmz1x0pQA6ikLaaLh+Una4KypUjo34/G3Api
         ZNL6uSDpqSl68RyCr0Y74fI2O9jkGJcqbUFVVK7e8Yk955GIF4eXjEKQTL50wMNe3fVN
         fqPYtzLKWQbD1EOWr/Y5b8apd8WAKsyfONBHclDADV0xcD/LlWfjoH1+SxUdAjerTuh2
         McQZaqXkRI6d6LhhCUUpn97r1mjNtaY7L25BDLnXmH754Ut+f6SCzbeZj4rMVoqNb/0P
         dZAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FbE5w+h2BSEXkPPIBskJCIIdNlKwd9UCXI4hG/L3cN4=;
        b=TAM3qolNlCPQ37Rm+6qQz6qgnW8rZzd8qcQyyPnKj21WnkLQSH73GnOIfRAohQLJX8
         tcpqRnoDmXZC9ExjDWNGlAPce9mBP2GcngkrSq33RkT7zO5Y9CNMrLCHkx/comQZtogt
         ckRLtLwlZhb13YzRW4UtbfMLG/dG8aRbd3olwIxM7hYrpTikJfpYwU/gmipeqxbH/9Mi
         YX9j+UD2xcD2hUfHlVd6yOak83tb3YpW1XPPpN12gqKf78a7NTm4pEC6vL0VQjo0JQzn
         dWUp2r9+Mx6QaVieLzS8fjLgjnF58uKvItgOUsXc39Ad4mmVZKj0awdVefkXZEXhieXr
         fNaw==
X-Gm-Message-State: AOAM530F+4DuWz5iImhzLsg/qORDYgM013mc6iBspY/sObks54J0v2pz
        REoXqtBYK8BowOciHRd8WunHdO2cqi7tAUKn+vI=
X-Google-Smtp-Source: ABdhPJw49ROXV7tLzyyROQPWtNQrJ+w2AF1z7VFICghGA8/nN1WWsCHL3FHdbbrO/LfHflu5XZF5Vg8iqS2K5WdWgSk=
X-Received: by 2002:a05:6102:a4a:: with SMTP id i10mr20549769vss.47.1639204497954;
 Fri, 10 Dec 2021 22:34:57 -0800 (PST)
MIME-Version: 1.0
References: <pull.1095.git.1639117329.gitgitgadget@gmail.com>
 <254b352e31029d8151eb6a974fdf8c127340cf79.1639117329.git.gitgitgadget@gmail.com>
 <CAP8UFD0MK++3QdMAvJ6Az0LZyXUWXRJcRQPG1THKw4CFW0yRLg@mail.gmail.com>
In-Reply-To: <CAP8UFD0MK++3QdMAvJ6Az0LZyXUWXRJcRQPG1THKw4CFW0yRLg@mail.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Sat, 11 Dec 2021 14:34:46 +0800
Message-ID: <CAOLTT8SLQXbH_GGF1sArVSsZ1b=poqMPhdSWOkWPS0f_SGoONw@mail.gmail.com>
Subject: Re: [PATCH 2/2] checkout: introduce "--to-branch" option
To:     Christian Couder <christian.couder@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Hariom Verma <hariom18599@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> =E4=BA=8E2021=E5=B9=B412=E6=
=9C=8810=E6=97=A5=E5=91=A8=E4=BA=94 16:34=E5=86=99=E9=81=93=EF=BC=9A

> >  [verse]
> >  'git checkout' [-q] [-f] [-m] [<branch>]
> >  'git checkout' [-q] [-f] [-m] --detach [<branch>]
> > -'git checkout' [-q] [-f] [-m] [--detach] <commit>
> > +'git checkout' [-q] [-f] [-m] [--detach] [-w|--to-branch] <commit>
>
> It's a bit strange that --detach can be used along with the new
> option, as the purpose of the new option is to not detach. It makes
> one wonder what happens when both --detach and --to-branch are used.
>

When both --detach and --to-branch are used, --detach will work...
Of course, it should be reasonable to prevent them from being used at the
same time.

> I wonder if all the following lines:
>
>       git checkout [-q] [-f] [-m] [<branch>]
>       git checkout [-q] [-f] [-m] --detach [<branch>]
>       git checkout [-q] [-f] [-m] [--detach] <commit>
>
> could be replaced with just:
>
>       git checkout [-q] [-f] [-m] [--detach|--to-branch] <commitish>
>

Well, it will be much more concise.

> >  'git checkout' [-q] [-f] [-m] [[-b|-B|--orphan] <new_branch>] [<start_=
point>]
> >  'git checkout' [-f|--ours|--theirs|-m|--conflict=3D<style>] [<tree-ish=
>] [--] <pathspec>...
> >  'git checkout' [-f|--ours|--theirs|-m|--conflict=3D<style>] [<tree-ish=
>] --pathspec-from-file=3D<file> [--pathspec-file-nul]
> > @@ -210,6 +210,12 @@ variable.
> >         `<commit>` is not a branch name.  See the "DETACHED HEAD" secti=
on
> >         below for details.
> >
> > +-w::
> > +--to-branch::
>
> Using a short option name like "-w" might not be a good idea at this
> point. Maybe if many people use the long option a lot, they will want
> a short option name, but we can add it then instead of using one of
> the few left right now.
>

Makes sense.

> > +       Rather than checking out a commit to work on it, checkout out
>
> "checking out a commit to work on it" might not describe well that it
> works when we pass a tag too and that we checkout the underlying
> commit in the detached HEAD mode by default.
>
> > +       to the unique branch on it. If there are multiple branches on
> > +       the commit, the checkout will fail.
>
> It might be a bit better to say that a branch "points to" a commit,
> rather than that it is "on" a commit.
>

OK.

> >  static const char * const checkout_usage[] =3D {
> >         N_("git checkout [<options>] <branch>"),
> > @@ -70,6 +71,7 @@ struct checkout_opts {
> >         int empty_pathspec_ok;
> >         int checkout_index;
> >         int checkout_worktree;
> > +       int to_branch;
> >         const char *ignore_unmerged_opt;
> >         int ignore_unmerged;
> >         int pathspec_file_nul;
> > @@ -1512,6 +1514,35 @@ static int checkout_branch(struct checkout_opts =
*opts,
> >                     (flag & REF_ISSYMREF) && is_null_oid(&rev))
> >                         return switch_unborn_to_new_branch(opts);
> >         }
> > +       if (opts->to_branch) {
> > +               struct ref_filter filter;
> > +               struct ref_array array;
> > +               int i;
> > +               int count =3D 0;
> > +               const char *unused_pattern =3D NULL;
> > +
> > +               memset(&array, 0, sizeof(array));
> > +               memset(&filter, 0, sizeof(filter));
> > +               filter.kind =3D FILTER_REFS_BRANCHES;
> > +               filter.name_patterns =3D &unused_pattern;
> > +               filter_refs(&array, &filter, filter.kind);
> > +               for (i =3D 0; i < array.nr; i++) {
> > +                       if (oideq(&array.items[i]->objectname, &new_bra=
nch_info->oid)) {
> > +                               if (count)
> > +                                       die(_("here are more than one b=
ranch on commit %s"), oid_to_hex(&new_branch_info->oid));
> > +                               count++;
> > +                               if (new_branch_info->refname)
> > +                                       free((char *)new_branch_info->r=
efname);
> > +                               new_branch_info->refname =3D xstrdup(ar=
ray.items[i]->refname);
> > +                               if (new_branch_info->path)
> > +                                       free((char *)new_branch_info->p=
ath);
> > +                               new_branch_info->path =3D xstrdup(array=
.items[i]->refname);
> > +                               new_branch_info->name =3D new_branch_in=
fo->path;
> > +                       }
> > +               }
> > +               ref_array_clear(&array);
>
> It might be my personal taste, but I would find it cleaner and easier
> to understand if a separate function to find the branch we are looking
> for was called, instead of adding all the code here.
>

You are right.

> > +       }
> > +
> >         return switch_branches(opts, new_branch_info);
> >  }
> >
> > @@ -1797,6 +1828,8 @@ int cmd_checkout(int argc, const char **argv, con=
st char *prefix)
> >                 OPT_BOOL('l', NULL, &opts.new_branch_log, N_("create re=
flog for new branch")),
> >                 OPT_BOOL(0, "guess", &opts.dwim_new_local_branch,
> >                          N_("second guess 'git checkout <no-such-branch=
>' (default)")),
> > +               OPT_BOOL('w', "to-branch", &opts.to_branch,
> > +                        N_("checkout to a branch from a commit or a ta=
g")),
> >                 OPT_BOOL(0, "overlay", &opts.overlay_mode, N_("use over=
lay mode (default)")),
> >                 OPT_END()
> >         };
> > diff --git a/t/t2018-checkout-branch.sh b/t/t2018-checkout-branch.sh
> > index 93be1c0eae5..53e45cfe7fd 100755
> > --- a/t/t2018-checkout-branch.sh
> > +++ b/t/t2018-checkout-branch.sh
>
> I plan to look at the tests after we decide how the new option relates
> to --detach.
>
> Thanks!

Thanks.
--
ZheNing Hu
