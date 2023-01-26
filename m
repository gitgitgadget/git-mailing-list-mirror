Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3465CC54E94
	for <git@archiver.kernel.org>; Thu, 26 Jan 2023 03:25:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235786AbjAZDZz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Jan 2023 22:25:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235766AbjAZDZx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2023 22:25:53 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 596BC9D
        for <git@vger.kernel.org>; Wed, 25 Jan 2023 19:25:52 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id o20so1155620lfk.5
        for <git@vger.kernel.org>; Wed, 25 Jan 2023 19:25:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/3W6eTzY/pC56kZDULanHunZUBQXKOTKWKPAaRZ6mDU=;
        b=kEDg//Vf0H/kxOWjOty3Y2jlMncftS4RNJIi9ekkOoZtXcWKIb3yI5flI3/QRM+MJG
         fz5on3HyBwpXD9ppLH19F5DkX9NFdTfyEY2T1bu5LBXJGdwhgSRZbva7IcINB4UTbBv+
         aepPFICzurH2IFQNQVrEEKEQJG9XXk4qIfh+UxXuskvF8GzL1FWaQ5gqanGvU6Txw5Ja
         vv7QWD0T9YDtMzPFQs/QggiLxuNLenepOWgcEVQ5KFV5jpXICe5NWoRAYLJ0iXBJCxER
         FocBW+W9FDE5bqtDgqQxTF/I1CMPmpSP56pujk4QnZG4JpNgxec2qD0jSowOB186/f4m
         sAYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/3W6eTzY/pC56kZDULanHunZUBQXKOTKWKPAaRZ6mDU=;
        b=G+GPeHIIeoZVi1lSiEnbDL6AAJN8o1sl6876DoOSrpY8ucq5LXPDnVw5fXdP6v0R5F
         jjEG5YkFDbaw4KaGGTJeOQRdWAXGQadYVUS89t2V+CVAFHiYK5TjxZBvnvigh60UVrAz
         0rEfmLVGoM4TeJsD2BwhIM3rHFHhUkJewWZS80ca8HRi/TMbjBkEOx2P4oCwutfdmgpP
         N12by8W/WoqX4EFoygUB/8IWkIwmcRqdJfAlwJ5ZKVF5Hs7+H03xtHlNq6MDr5tTeQdv
         2L5WqkprIB1DXEdQ16g5nW4tD03Wlvy0qNKHo5vDaHTHp1tuVukhcAVIoxLf0IOpoL5a
         K2PQ==
X-Gm-Message-State: AFqh2kqvG7Rft8GN+adU2VM5UaxZEunOwNMCrhBAWBGHI1zRV5iNrtQw
        9dBmoYFY814PfTil86kxlubJzvAD90tSc6nBygo=
X-Google-Smtp-Source: AMrXdXudSOe1kY5WzfyCj29wUByjvuYpBTxzxbK0PQrumIFbvsXs71BxQJ82pA0tJs0ilvEQeI8Av9T6eB/4TfTvNWo=
X-Received: by 2002:a05:6512:a82:b0:4d4:73e9:89a3 with SMTP id
 m2-20020a0565120a8200b004d473e989a3mr2270984lfu.183.1674703550297; Wed, 25
 Jan 2023 19:25:50 -0800 (PST)
MIME-Version: 1.0
References: <pull.1459.git.1673456518993.gitgitgadget@gmail.com>
 <pull.1459.v2.git.1674474371817.gitgitgadget@gmail.com> <CABPp-BExS8UGfGzT+w9R_p0sY+_=A0-nRzU5QTOKwfBSmX6c3A@mail.gmail.com>
 <18c94f70-4adf-1b4a-8777-206804c419e6@unity3d.com>
In-Reply-To: <18c94f70-4adf-1b4a-8777-206804c419e6@unity3d.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 25 Jan 2023 19:25:00 -0800
Message-ID: <CABPp-BFtLdRV2zWXn0On0b6mOJgMAatwvUumUxfXfNXo9gc=HA@mail.gmail.com>
Subject: Re: [PATCH v2] ls-tree: add --sparse-filter-oid argument
To:     William Sprent <williams@unity3d.com>
Cc:     William Sprent via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Victoria Dye <vdye@github.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 25, 2023 at 8:16 AM William Sprent <williams@unity3d.com> wrote=
:
>
> On 25/01/2023 06.11, Elijah Newren wrote:
> > It looks like =C3=86var and Victoria have both given really good review=
s
> > already, but I think I spotted some additional things to comment on.
> >
> > On Mon, Jan 23, 2023 at 3:46 AM William Sprent via GitGitGadget
> > <gitgitgadget@gmail.com> wrote:
> >>
> >> From: William Sprent <williams@unity3d.com>
> >>
> >> There is currently no way to ask git the question "which files would b=
e
> >> part of a sparse checkout of commit X with sparse checkout patterns Y"=
.
> >> One use-case would be that tooling may want know whether sparse checko=
uts
> >> of two commits contain the same content even if the full trees differ.
> >
> > Could you say more about this usecase?  Why does tooling need or want
> > to know this; won't a checkout of the new commit end up being quick
> > and simple?  (I'm not saying your usecase is bad, just curious that it
> > had never occurred to me, and I'm afraid I'm still not sure what your
> > purpose might be.)
> >
>
> I'm thinking mainly about a monorepo context where there are a number of
> distinct 'units' that can be described with sparse checkout patterns.
> And perhaps there's some tooling that only wants to perform an action if
> the content of a 'unit' changes.

So, you're basically wanting to do something like
   git ls-tree --paths-matching-sparsity-file=3D<pattern-file> $COMMIT1
>sparse-files
   git ls-tree --paths-matching-sparsity-file=3D<pattern-file> $COMMIT2
>>sparse-files
   sort sparse-files | uniq >relevant-files
   git diff --name-only $COMMIT1 $COMMIT2 >changed-files
and then checking whether relevant-files and changed-files have a
non-empty intersection?

Would that potentially be better handled by
   git diff --name-only $COMMIT1 $COMMIT2 | git check-ignore
--ignore-file=3D<pattern-file> --stdin
and seeing whether the output is non-empty?  We'd have to add an
"--ignore-file" option to check-ignore to override reading of
.gitignore files and such, and it'd be slightly confusing because the
documentation talks about "ignored" files rather than "selected"
files, but that's a confusion point that has been with us ever since
the gitignore mechanism was repurposed for sparse checkouts.  Or maybe
we could just add a check-sparsity helper, and then allow it to take
directories in-lieu of patterns.

This seems nicer than opening a can of worms about letting every git
command specify a different set of sparsity rules.

> Depending on the repo, it won't necessarily be quick to check out the
> commit with the given patterns. However, it is more about it being
> inconvenient to have to have a working directory, especially so if you
> want use the tooling in some kind of service or query rapidly about
> different revisions/patterns.
>
> >> Another interesting use-case would be for tooling to use in conjunctio=
n
> >> with 'git update-index --index-info'.
> >
> > Sorry, I'm not following.  Could you expound on this a bit?
> >
>
> I was imagining something along the lines of being able to generate new
> tree objects based on what matches the given sparse checkout patterns.
> Not that I have a specific use case for it right now.
>
> I think what I'm trying to evoke with that paragraph is that this
> enables integrations with git that seem interesting and weren't possible
> before.

I'm not sure if it's interesting, frightening, or something else.
Hard to say without better descriptions of usecases, which we can't
have if we don't even have a usecase.  I think I'd just strike this
paragraph.

[...]
> >> +       (*d)->pl.use_cone_patterns =3D core_sparse_checkout_cone;
> >
> > Hmm, so the behavior still depends upon the current sparse-checkout
> > (or lack thereof), despite the documentation and rationale of your
> > feature as being there to check how a different sparse checkout would
> > behave?
> >
> > I would hate to unconditionally turn cone_patterns off, since that
> > would come with a huge performance penalty for the biggest repos.  But
> > turning it unconditionally on wouldn't be good for the non-cone users.
> > This probably suggests we need something like another flag, or perhaps
> > separate flags for each mode.  Separate flags might provide the
> > benefit of allowing cone mode users to specify directories rather than
> > patterns, which would make it much easier for them to use.
> >
> I used 'core_sparse_checkout_cone' because I wanted to allow for the
> cone mode optimisations, but I also figured that I should respect the
> configuration. It doesn't change how the patterns are parsed in this case=
.
>
> I agree that it is a bit awkward to have to "translate" the directories
> into patterns when wanting to use cone mode. I can try adding
> '--[no]-cone' flags and see how that feels. Together with Victoria's
> suggestions that would result in having the following flags:
>
> * --scope=3D(sparse|all)
> * --sparse-patterns-file=3D<path>
> * --[no]-cone: used together with --sparse-patterns-file to tell git
>    whether to interpret the patterns given as directories (cone) or
>    patterns (no-cone).
>
> Which seems like a lot at first glance. But it allows for passing
> directories instead of patterns for cone mode, and is similar to the
> behaviour of 'sparse-checkout set'.
>
> Does that seem like something that would make sense?

--sparse-patterns-file still implies patterns; I think that would need
some rewording.

More importantly, though, based on your usecase description, I wonder
if you might be better served by either extending the check-ignore
subcommand or adding a similar helper ("check-sparsity"?), rather than
tweaking ls-tree.
