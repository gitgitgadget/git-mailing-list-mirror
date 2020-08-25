Return-Path: <SRS0=G1/z=CD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 694D6C433DF
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 07:57:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F1D42071E
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 07:57:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MM9Kq+aY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726066AbgHYH5W (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Aug 2020 03:57:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbgHYH5V (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Aug 2020 03:57:21 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37646C061574
        for <git@vger.kernel.org>; Tue, 25 Aug 2020 00:57:21 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id k4so9626613ilr.12
        for <git@vger.kernel.org>; Tue, 25 Aug 2020 00:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=n1BoHo1/mLw1HuKkyMZA1O7QFtZxswHQs0c0ooTbI9Q=;
        b=MM9Kq+aY4cxD177btBnxUlgPdCJjrMiBqrT6eSOZFwgL920u2mR7cbecODn8LZ1JMp
         OJwscR9tIbjokb4xpJvx3mSPU9u9swbUT2N1OdbvPiXKCQ5xn2nHKenGePiPrDCuoHrm
         MD9qA5HxPbpHRrgykd3KFk4/Uw+slCZYqWApN2mu05SPjpELLWdKa1gQn2FgAzZZoxCY
         dMTElEjliWIQ4ywU1xcQweZIR0fBQeV3+SmxzbmZrwTqSB9NUbZJvjoKx4fLttpU+x7w
         HSru+T0itU+BLPnGGsFcMW+73h/i+aLMEiKIYeQj3ecOSTx7NjJCUntnuBZJt4EYh8WW
         3m9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=n1BoHo1/mLw1HuKkyMZA1O7QFtZxswHQs0c0ooTbI9Q=;
        b=Bgk9WXglZgfPhQODyIx4sTDXOxoXsnrgtWE2rI0w3ZRa9+nCV5zAEfEHxa79+owQlx
         76cWf9vnVn4fS0lBmkTkoYC1FaKnwtoyP2TtNH1/BzdgbRzB4oDSD4JFmxxOVo7yPT51
         BW1nGpwwLbo3b7/cK6/VbQNMRCgWfKuom84sRrgo5QwUc+tQd5qCspRgE6VrDrpK7Vne
         V5n2crtELO/vI1secapbpLFqxo2XZK/xn801BMzPD0QFE/0azzIx1mTyOvlXlIWS/YSR
         lnJ2cgeGjSZQTY782+YLfbAN6DyjxUfJGireUjcVSg7o+1xGvWrTcQTItHCCh+I4VppM
         URIg==
X-Gm-Message-State: AOAM531NqwTeJ3PEaxaTqR9dd/FtZqUtXYVQ+lLYhVRSN1vTyVNFdJqe
        6j3kqp4X/x1Z8Bdmmdek9wBYZ7Dbgf8CwKinfN2nzNOTVEb3hw==
X-Google-Smtp-Source: ABdhPJwlpUcnkVwEY+6qeRGZgATqXGE6hEu30RbDpkbpYOvTQGjck4IbNjpQj0A3TYBxQfBslJJbybw7p64uYHDYiw4=
X-Received: by 2002:a05:6e02:f92:: with SMTP id v18mr8004856ilo.125.1598342240494;
 Tue, 25 Aug 2020 00:57:20 -0700 (PDT)
MIME-Version: 1.0
References: <pull.676.v2.git.1596941624.gitgitgadget@gmail.com>
 <pull.676.v3.git.1597509583.gitgitgadget@gmail.com> <b347dbb01b9254ab8d79fbbd0f7c2b637efde62e.1597509583.git.gitgitgadget@gmail.com>
 <85d03jlu05.fsf@gmail.com> <20200825061418.GA629699@Abhishek-Arch> <855z97dvsp.fsf@gmail.com>
In-Reply-To: <855z97dvsp.fsf@gmail.com>
From:   =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Date:   Tue, 25 Aug 2020 09:56:44 +0200
Message-ID: <CANQwDwdsV0mSos7M_d7UP1CjT1rCyA_GfaYarMKUZaFdDZ0WRg@mail.gmail.com>
Subject: Re: [PATCH v3 06/11] commit-graph: add a slab to store topological levels
To:     Abhishek Kumar <abhishekkumar8222@gmail.com>
Cc:     git <git@vger.kernel.org>,
        Abhishek Kumar via GitGitGadget <gitgitgadget@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 25 Aug 2020 at 09:33, Jakub Nar=C4=99bski <jnareb@gmail.com> wrote:
> Abhishek Kumar <abhishekkumar8222@gmail.com> writes:
> > On Fri, Aug 21, 2020 at 08:43:38PM +0200, Jakub Nar=C4=99bski wrote:
> >> "Abhishek Kumar via GitGitGadget" <gitgitgadget@gmail.com> writes:
> >>
> >>> From: Abhishek Kumar <abhishekkumar8222@gmail.com>
> [...]
> >>> @@ -1335,11 +1341,11 @@ static void compute_generation_numbers(struct=
 write_commit_graph_context *ctx)
> >>>                                     _("Computing commit graph generat=
ion numbers"),
> >>>                                     ctx->commits.nr);
> >>>     for (i =3D 0; i < ctx->commits.nr; i++) {
> >>> -           uint32_t generation =3D commit_graph_data_at(ctx->commits=
.list[i])->generation;
> >>> +           uint32_t level =3D *topo_level_slab_at(ctx->topo_levels, =
ctx->commits.list[i]);
> >>
> >> All right, so that is why this 'generation' variable was not converted
> >> to timestamp_t type.
> >>
> >>>
> >>>             display_progress(ctx->progress, i + 1);
> >>> -           if (generation !=3D GENERATION_NUMBER_V1_INFINITY &&
> >>> -               generation !=3D GENERATION_NUMBER_ZERO)
> >>> +           if (level !=3D GENERATION_NUMBER_V1_INFINITY &&
> >>> +               level !=3D GENERATION_NUMBER_ZERO)
> >>>                     continue;
> >>
> >> Here we use GENERATION_NUMBER*_INFINITY to check if the commit is
> >> outside commit-graph files, and therefore we would need its topologica=
l
> >> level computed.
> >>
> >> However, I don't understand how it works.  We have had created the
> >> commit_graph_data_at() and use it instead of commit_graph_data_slab_at=
()
> >> to provide default values for `struct commit_graph`... but only for
> >> `graph_pos` member.  It is commit_graph_generation() that returns
> >> GENERATION_NUMBER_INFINITY for commits not in graph.
> >>
> >> But neither commit_graph_data_at()->generation nor topo_level_slab_at(=
)
> >> handles this special case, so I don't see how 'generation' variable ca=
n
> >> *ever* be GENERATION_NUMBER_INFINITY, and 'level' variable can ever be
> >> GENERATION_NUMBER_V1_INFINITY for commits not in graph.
> >>
> >> Does it work *accidentally*, because the default value for uninitializ=
ed
> >> data on commit-slab is 0, which matches GENERATION_NUMBER_ZERO?  It
> >> certainly looks like it does.  And GENERATION_NUMBER_ZERO is an artifa=
ct
> >> of commit-graph feature development history, namely the short time whe=
re
> >> Git didn't use any generation numbers and stored 0 in the place set fo=
r
> >> it in the commit-graph format...  On the other hand this is not the ca=
se
> >> for corrected commit date (generation number v2), as it could
> >> "legitimately" be 0 if some root commit (without any parents) had
> >> committerdate of epoch 0, i.e. 1 January 1970 00:00:00 UTC, perhaps
> >> caused by malformed but valid commit object.
> >>
> >> Ugh...
> >
> > It works accidentally.
> >
> > Our decision to avoid the cost of initializing both
> > commit_graph_data->generation and commit_graph_data->graph_pos has
> > led to some unwieldy choices - the complexity of helper functions,
> > bypassing helper functions when writing a commit-graph file [1].
> >
> > I want to re-visit how commit_graph_data slab is defined in a future se=
ries.
> >
> > [1]: https://lore.kernel.org/git/be28ab7b-0ae4-2cc5-7f2b-92075de3723a@g=
mail.com/
>
> All right, we might want to make use of the fact that the value of 0 for
> topological level here always mean that its value for a commit needs to
> be computed, that 0 is not a valid value for topological levels.
> - if the value 0 came from commit-graph file, it means that it came
>   from Git version that used commit-graph but didn't compute generation
>   numbers; the value is GENERATION_NUMBER_ZERO
> - the value 0 might came from the fact that commit is not in graph,
>   and that commit-slab zero-initializes the values stored; let's
>   call this value GENERATION_NUMBER_UNINITIALIZED
>
> If we ensure that corrected commit date can never be zero (which is
> extremely unlikely, as one of root commits would have to be malformed or
> written on badly misconfigured computer, with value of 0 for committer
> timestamp), then this "happy accident" can keep working.
>
>   As a special case, commit date with timestamp of zero (01.01.1970 00:00=
:00Z)
>   has corrected commit date of one, to be able to distinguish
>   uninitialized values.
>
> Or something like that.
>
> Actually, it is not even necessary, as corrected commit date of 0 just
> means that this single value (well, for every root commit with commit
> date of 0) would be unnecessary recomputed in compute_generation_numbers(=
).
>
> Anyway, we would want to document this fact in the commit message.

Alternatively, instead of comparing 'level' (and later in series also
'corrected_commit_date') against GENERATION_NUMBER_INFINITY,
we could load at no extra cost `graph_pos` value and compare it
against COMMIT_NOT_FROM_GRAPH.

But with this solution we could never get rid of graph_pos, if we
think it is unnecessary. If we split commit_graph_data into separate
slabs (as it was in early versions of respective patch series), we
would have to pay additional cost.

But it is an alternative.

Best,
--=20
Jakub Nar=C4=99bski
