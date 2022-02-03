Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67D59C433EF
	for <git@archiver.kernel.org>; Thu,  3 Feb 2022 09:04:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236857AbiBCJER (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Feb 2022 04:04:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231674AbiBCJEP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Feb 2022 04:04:15 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11D89C061714
        for <git@vger.kernel.org>; Thu,  3 Feb 2022 01:04:15 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id ah7so6439371ejc.4
        for <git@vger.kernel.org>; Thu, 03 Feb 2022 01:04:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MXtjNq/nSlWWGG/S72+9o/cEyFAJjo/pbjuW5qmkzQg=;
        b=ODNaeHcmPKW/fw4Q6Ts9lh8sFdx2+QVHDeQUFQz53EAUxfXy1/4uOIE73MTb+KcTM9
         Ye6f0Op6mjQfgfiqadWDw8dI0Ww5kbca8CLuNdl3F7LidHFBD44clUcj6v5W1XJW8qVz
         VWZfv9XvoKEExsg6dxHHdqERFx7WK+Fdv0fvo3jN7J/UkvxyW7xsMZzjbjBaC9+iz6VL
         KaPhsGFNm2ZamqHmS4ewxKpvNNYWrvg0tV6ZzDnb5AbIWJx4pa+WZqqmFKfOcYYf+sNu
         /t0fiz3n8SsEHlRzQ5HUFjA28Vn2JsReWUUE/ajQdlEbtqNkEiMzQJQDKaUE5Zb+EeTA
         JNyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MXtjNq/nSlWWGG/S72+9o/cEyFAJjo/pbjuW5qmkzQg=;
        b=Cl4oJzJ5WJbGvndR0BlNIDRNg3wBkd8naC3A56jUk0GnSi3uIuTdrVisRIswPwekcZ
         qV65aQ/0pYQI2NlVEcOHAgrr9Aoa6pH+4xnu+5qROgYGD0Y02bEkEY8HfWC8mievLHa+
         vIUwzqSSJBuc3NAp5TpFnBuDy/vEOTX11gB3qmZMvyPGYazowdR/xu9+DCwol1HRSmJe
         QtdlMjfuaF+t881GHOQTLaEfzqA5qk6Uwj7YDWwWXTtsadfKCG2vGQctzjjrnEIwEwm7
         ghsrYi2oB3IhrBh2LKELToolyNQsQNfCs1yndh5g4pyQjWgfbdgBq8e09zBzNaMxJWry
         LAtA==
X-Gm-Message-State: AOAM530Jh/Yb9P2LuzoIshpHOAG9wXbPznkDFBceYchEG+E61xdxihJA
        FAB3DM1njezs+Sxv58TaX7FaH3nOG30DVqwTi38=
X-Google-Smtp-Source: ABdhPJygisPTjMaaieh/ZDKWgsuReGIqd1GJJvBdEZY429rRAAnIVEy10idJ9Ke4MgyWBHR24NBzrgy39Y3/dfSDyr8=
X-Received: by 2002:a17:907:7da8:: with SMTP id oz40mr22875133ejc.328.1643879053528;
 Thu, 03 Feb 2022 01:04:13 -0800 (PST)
MIME-Version: 1.0
References: <pull.1122.v2.git.1643479633.gitgitgadget@gmail.com>
 <pull.1122.v3.git.1643787281.gitgitgadget@gmail.com> <63f42df21aec5bda50e4414493eb59dcb64e5558.1643787281.git.gitgitgadget@gmail.com>
 <220203.86a6f87lbl.gmgdl@evledraar.gmail.com>
In-Reply-To: <220203.86a6f87lbl.gmgdl@evledraar.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 3 Feb 2022 01:04:01 -0800
Message-ID: <CABPp-BHKZnmaq3NM5_D6pwkw2+91EsdJ-uqjfFPBYiUSE28k1g@mail.gmail.com>
Subject: Re: [PATCH v3 03/15] merge-tree: add option parsing and initial shell
 for real merge function
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Johannes Sixt <j6t@kdbg.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 2, 2022 at 6:09 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar=
ab@gmail.com> wrote:
>
> On Wed, Feb 02 2022, Elijah Newren via GitGitGadget wrote:
>
> > From: Elijah Newren <newren@gmail.com>
> >
> > Let merge-tree accept a `--write-tree` parameter for choosing real
> > merges instead of trivial merges, and accept an optional
> > `--trivial-merge` option to get the traditional behavior.  Note that
> > these accept different numbers of arguments, though, so these names
> > need not actually be used.
>
> Maybe that ship has sailed, but just my 0.02: I thought this whole thing
> was much less confusing with your initial merge-tree-ort proposal at
> https://lore.kernel.org/git/CABPp-BEeBpJoU4yXdfA6vRAYVAUbd2gRhEV6j4VEqoqc=
u=3DFGSw@mail.gmail.com/;
> I.e. the end-state of merge-tree.c is that you end up reading largely
> unrelated code (various static functions only used by one side or
> another).

Christian's merge-tree-ort proposal?

> But maybe that's all water under the bridge etc, however...
>
> >  int cmd_merge_tree(int argc, const char **argv, const char *prefix)
> >  {
> > -     if (argc !=3D 4)
> > -             usage(merge_tree_usage);
> > -     return trivial_merge(argc, argv);
> > +     struct merge_tree_options o =3D { 0 };
> > +     int expected_remaining_argc;
> > +
> > +     const char * const merge_tree_usage[] =3D {
> > +             N_("git merge-tree [--write-tree] <branch1> <branch2>"),
> > +             N_("git merge-tree [--trivial-merge] <base-tree> <branch1=
> <branch2>"),
> > +             NULL
> > +     };
> > +     struct option mt_options[] =3D {
> > +             OPT_CMDMODE(0, "write-tree", &o.mode,
> > +                         N_("do a real merge instead of a trivial merg=
e"),
> > +                         'w'),
> > +             OPT_CMDMODE(0, "trivial-merge", &o.mode,
> > +                         N_("do a trivial merge only"), 't'),
> > +             OPT_END()
> > +     };
> > +
> > +     /* Parse arguments */
> > +     argc =3D parse_options(argc, argv, prefix, mt_options,
> > +                          merge_tree_usage, PARSE_OPT_STOP_AT_NON_OPTI=
ON);
> > +     if (o.mode) {
> > +             expected_remaining_argc =3D (o.mode =3D=3D 'w' ? 2 : 3);
> > +             if (argc !=3D expected_remaining_argc)
> > +                     usage_with_options(merge_tree_usage, mt_options);
> > +     } else {
> > +             if (argc < 2 || argc > 3)
> > +                     usage_with_options(merge_tree_usage, mt_options);
> > +             o.mode =3D (argc =3D=3D 2 ? 'w' : 't');
> > +     }
>
> Do we really need to make this interface more special-casey by
> auto-guessing based on argc what argument you want? I.e. instead of
> usage like:
>
>         N_("git merge-tree [--write-tree] <branch1> <branch2>"),
>         N_("git merge-tree [--trivial-merge] <base-tree> <branch1> <branc=
h2>"),
>
> Wouldn't it be simpler to just have the equivalent of:
>
>         # old
>         git merge-tree ...
>         # new
>         git merge-tree --new-thing ...
>
> And not have to look at ... to figure out if we're dispatching to the
> new or old thing.

You seem to be focusing on code simplicity?  Sure, that'd be simpler
code, it'd just be a less useful feature.

I think passing --write-tree all the time would be an annoyance.  I
don't see why anyone would ever use the other mode.  However, for as
long as both exist in the manual, it makes the manual easier to
explain to users, and example testcases more self-documenting by
having the flag there.  That's the sole purpose of the flag.

I'm never going to actually use it when I invoke it from the command
line.  And I suspect most would leave it off.
