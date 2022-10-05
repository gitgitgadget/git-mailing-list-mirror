Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2DECC4332F
	for <git@archiver.kernel.org>; Wed,  5 Oct 2022 12:30:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbiJEMae (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Oct 2022 08:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbiJEMac (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Oct 2022 08:30:32 -0400
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 674961A81C
        for <git@vger.kernel.org>; Wed,  5 Oct 2022 05:30:31 -0700 (PDT)
Received: by mail-oo1-xc2f.google.com with SMTP id d22-20020a4a5216000000b0047f740d5847so1431493oob.13
        for <git@vger.kernel.org>; Wed, 05 Oct 2022 05:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=aZqO054ZpQofRbETvYs4kXyb7BxiC9mke60z8AexAj4=;
        b=IDHiauW45oZyg6iyQIxk254fy3QvVf4tVy0n6n4pt9cZGJjRlD2eLZTumMu2UGvm6F
         PwXACGdlL0WlRuUafMOyYkvWQHif60ri/YhCZsJ5PfSEJi1yj2rQFZM1vy6wjvscinqM
         CuAzlIyfW5c6RpluLGP4pycXxDDpAVWv8jv0znWEe27je2WPwHwK7VwPwVKjgpoDmYyy
         Kqi+4pJKY+tLFnKm2VutYxmfSgLmONxjtanfD+3nwP+TEnh6WqywjjbvXU4vs1ssMR9k
         +yRNCgm0vcbzJJ7IwlPNctgeYI7qDtFFbJ5RTm9ZUFUa/g2EjbJHc1KV0/PT05b9piSY
         zZlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=aZqO054ZpQofRbETvYs4kXyb7BxiC9mke60z8AexAj4=;
        b=1PAGKrMh/qj4KU0mYX+41NZM+2GvwOlQ3opPkIo5SUH4jaLW1ZOBXKJWG607sfLxo5
         /LfOTh/W2lyKK/GO+s89M4XtLEqobeLGeHk5EmbBPazHgN9l8ovygU2NpBt+n6jdqXZZ
         vH8Jkvq/m/30l6F1AjGqitF47N/sHfSnY4+/TMYp8/lA7VMriFZDT574b3ryVUgT4UVY
         mYk8XDMr42eF6DIgHwW2SjsjYTcTjaBMdEC5gFqrRmfAxh4QOLkbL3qKajWp0IFc23H8
         O5S5jPXADrjSW+itU/d8+uCB5BWZXmj2eA/KbSEk7fae1cUrJsSvtilFXoy0qxbTJR2A
         xv1A==
X-Gm-Message-State: ACrzQf0GDyEfqOFlJXTCPQGyF2nStthZWrk+JtuvkQQUkt3x/JIcwKTl
        zY+h+BdzEJBt3QrkGoE2f1aj+OYWL5xsGxOHfbk=
X-Google-Smtp-Source: AMsMyM4rd3/YPaCVdDuCRWrKCjhdFfXnNXCOWWNZOqalchDfqKlR3K4nkZfiCJ1pDK3P5wTat9rwzdxZ8TzZkzY5j8c=
X-Received: by 2002:a4a:dd01:0:b0:476:64a1:923f with SMTP id
 m1-20020a4add01000000b0047664a1923fmr11071841oou.6.1664973030603; Wed, 05 Oct
 2022 05:30:30 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1356.git.1663959324.gitgitgadget@gmail.com>
 <914028341842a4d57e02ec42a7426d3aa83640f9.1663959325.git.gitgitgadget@gmail.com>
 <220926.8635ce4jox.gmgdl@evledraar.gmail.com>
In-Reply-To: <220926.8635ce4jox.gmgdl@evledraar.gmail.com>
From:   Chris P <christophe.poucet@gmail.com>
Date:   Wed, 5 Oct 2022 14:30:18 +0200
Message-ID: <CAN84kK=kTsy5stN7rR=EeLiTOq0si1UcmHfAE-UNvcofMSPKCg@mail.gmail.com>
Subject: Re: [PATCH 07/10] evolve: implement the git change command
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Stefan Xenos via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Stefan Xenos <sxenos@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 26, 2022 at 10:35 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
>
> On Fri, Sep 23 2022, Stefan Xenos via GitGitGadget wrote:
>
> > From: Stefan Xenos <sxenos@google.com>
>
> > +static const char * const builtin_change_usage[] =3D {
> > +     N_("git change update [--force] [--replace <treeish>...] [--origi=
n <treesih>...] [--content <newtreeish>]"),
> > +     NULL
> > +};
> > +
> > +static const char * const builtin_update_usage[] =3D {
> > +     N_("git change update [--force] [--replace <treeish>...] [--origi=
n <treesih>...] [--content <newtreeish>]"),
> > +     NULL
> > +};
>
> This (and the corresponding later *.txt version) should indent the
> overly long -h line, probably after "[--replace <treeish>...]".
>
> > +struct update_state {
> > +     int options;
>
> I think this should be an enum in your earlier 06/10. Makes things more
>
> > +             die(_("Failed to resolve '%s' as a valid revision."), com=
mittish);
>
> This and other error should start with a lower-case letter, see
> CodingGuidelines on errors.

Done.

>
> > [...]
> > +             die(_("Could not parse object '%s'."), committish);
>
> Ditto etc.
>
> > +     int i;
> > +     for (i =3D 0; i < commitsish_list->nr; i++) {
>
> A string_list uses a size_t for a nr, not int, so lets make that "size_t
> i".
>
> This both makes things more obvious, and helps some compilers spot
> unsigned v.s. signed issues.

Done.

>
>
> > +     int i;
>
> ditto size_t above...
>
> > +     for (i =3D 0; i < changes.nr; i++) {
>
> ...for this iteration...

Obsolete, moved to using for_each_string_list_item

>
> > +             struct string_list_item *it =3D &changes.items[i];
>
> ...but actually don't you just want for_each_string_list_item() instead?
>
> > +             if (it->util)
> > +                     fprintf(stdout, N_("Updated change %s\n"), name);
> > +             else
> > +                     fprintf(stdout, N_("Created change %s\n"), name);
>
> The use of N_() here is wrong, you should use _(), N_() just marks
> things for translation, but doesn't use it.
>

Done.

> We also tend to try to avoid adding \n in translations needlessly. And
> since you're printing to stdout this can be:
>
>
>         if (...)
>                 printf(_("Updated change %s"), name);
>         ...
>         putchar('\n')

Done

>
>
> > +     }
> > +
> > +     string_list_clear(&changes, 0);
> > +     change_table_clear(&chtable);
> > +     clear_metacommit_data(&metacommit);
> > +
> > +     return ret;
> > +}
> > +
> > +static int change_update(int argc, const char **argv, const char* pref=
ix)
> > +{
> > +     int result;
> > +     int force =3D 0;
> > +     int newchange =3D 0;
> > +     struct strbuf err =3D STRBUF_INIT;
> > +     struct update_state state;
> > +     struct option options[] =3D {
> > +             { OPTION_CALLBACK, 'r', "replace", &state, N_("commit"),
> > +                     N_("marks the given commit as being obsolete"),
> > +                     0, update_option_parse_replace },
> > +             { OPTION_CALLBACK, 'o', "origin", &state, N_("commit"),
> > +                     N_("marks the given commit as being the origin of=
 this commit"),
> > +                     0, update_option_parse_origin },
> > +             OPT_BOOL('F', "force", &force,
> > +                     N_("overwrite an existing change of the same name=
")),
> > +             OPT_STRING('c', "content", &state.content, N_("commit"),
> > +                              N_("identifies the new content commit fo=
r the change")),
> > +             OPT_STRING('g', "change", &state.change, N_("commit"),
> > +                              N_("name of the change to update")),
> > +             OPT_BOOL('n', "new", &newchange,
> > +                     N_("create a new change - do not append to any ex=
isting change")),
> > +             OPT_END()
> > +     };
> > +
> > +     init_update_state(&state);
> > +
> > +     argc =3D parse_options(argc, argv, prefix, options, builtin_updat=
e_usage, 0);
> > +
> > +     if (force) state.options |=3D UPDATE_OPTION_FORCE;
> > +     if (newchange) state.options |=3D UPDATE_OPTION_NOAPPEND;
>
> Just use OPT_SET_INT_F() and skip the indirection thorugh OPT_BOOL(),
> that macro itself is a thin wrapper for OPT_SET_INT_F().
>
> I.e. you can drop these "force" and "newchange" variables, andjust set
> your state.options directly.

Done.

>
> > +int cmd_change(int argc, const char **argv, const char *prefix)
> > +{
> > +     /* No options permitted before subcommand currently */
> > +     struct option options[] =3D {
> > +             OPT_END()
> > +     };
> > +     int result =3D 1;
> > +
> > +     argc =3D parse_options(argc, argv, prefix, options, builtin_chang=
e_usage,
> > +             PARSE_OPT_STOP_AT_NON_OPTION);
> > +
> > +     if (argc < 1)
> > +             usage_with_options(builtin_change_usage, options);
> > +     else if (!strcmp(argv[0], "update"))
> > +             result =3D change_update(argc, argv, prefix);
> > +     else {
> > +             error(_("Unknown subcommand: %s"), argv[0]);
> > +             usage_with_options(builtin_change_usage, options);
> > +     }
>
> This was presumably written before the recent OPT_SUBCOMMAND(), and
> should instead use that API.

Done, thanks!
