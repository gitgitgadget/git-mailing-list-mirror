Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7091AC433EF
	for <git@archiver.kernel.org>; Tue, 30 Nov 2021 04:00:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238030AbhK3EDS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Nov 2021 23:03:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbhK3EDR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Nov 2021 23:03:17 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 795F3C061574
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 19:59:58 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id e3so81058456edu.4
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 19:59:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OgOfDzPAgLkXJGmlCc9Mv8W8SnpYLL3JTyvbNpSvELQ=;
        b=RuVeEC3jNq894gEgYKnxyS+6JHHLF4Xzj91U36xma/nJi9Se897D1xvBu5y1eN86zo
         XJvHRYl8vPRkrwfRMpvqFGrhxWc6/YSdt2eZmmpRok9eDbby/x1y7xVQILTMpXh+9RLl
         yATuekAgVbOj9WP+dSeGmW3KngNSiod6K0522bpsc4anNF1BsqjHrnb3vka/o50N2dXu
         T3FOpd98O20xGGEtOO2HYn4BK1Txvi+roh+8F9XoWcO1W0ALHcr7PB9qs8WvtnuqvSxC
         lKArdli9fI61RVrblo4azgn9K8nkewuhAWedmx+tJy3szTNtSUCkcTMktvoqWbhcELpO
         K+aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OgOfDzPAgLkXJGmlCc9Mv8W8SnpYLL3JTyvbNpSvELQ=;
        b=fCI7T3EnxBDBPMNAp1jiyMnv74AtGI1xlP31bOX+0d/hqjGsA4NgqoaEGNIWq5tzFm
         MQkaa3YVHdOB0zVlIDXgHuXyLAFzzSVz1bygvh7+4QNJW1CLuJ1RiZH4bv7R7M1HyPKs
         0zqfUF13W6CAMMibN19fGLEWXTDiVsS/jA+NTBshdWbc2SeXzP769yY+0hQIJedP2uZK
         GoPJDukO8NhGA5iyCKcDPhPpOeieXNtOM6x8rOmEynoCtSXbS4lzY0oSXV2azlMe3nqO
         8+QrKSf+3PkGnL63F4PVNU/Nm9KEmBKP3FRVwRGb5ilQjWK9F/O6jDTShdERZYZHOzQk
         t9cg==
X-Gm-Message-State: AOAM53248/gibh2cjw2+KXv31DhuW7GDHoCwYGZDTjqjrkJX/jeKI2HP
        0g022Tv8Ot+Ij9eyGr9xBS48kvlqXwJ5aeKtOhFr1ULq
X-Google-Smtp-Source: ABdhPJzy3dxTP5jw5TrkXyQpf535UAlKPAevZ7BQYBfzWxXjtMk6wyWVFA7G0aDG6Dh8DlDeM2sljaM8nuRERJb4UM4=
X-Received: by 2002:aa7:c902:: with SMTP id b2mr78437792edt.320.1638244797033;
 Mon, 29 Nov 2021 19:59:57 -0800 (PST)
MIME-Version: 1.0
References: <pull.1048.v5.git.1635345563.gitgitgadget@gmail.com>
 <pull.1048.v6.git.1638201164.gitgitgadget@gmail.com> <CABPp-BG0iDHf268UAnRyA=0y0T69YTc+bLMdxCmSbrL8s=9ziA@mail.gmail.com>
 <9c5b7067-b0e3-0153-5cd3-042bae92f91e@github.com>
In-Reply-To: <9c5b7067-b0e3-0153-5cd3-042bae92f91e@github.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 29 Nov 2021 19:59:45 -0800
Message-ID: <CABPp-BGtc9Q5hD_e3xh5VXQeCpD-_ADx9OTnPv4VoVsfaQvUiA@mail.gmail.com>
Subject: Re: [PATCH v6 0/8] Sparse Index: integrate with reset
To:     Victoria Dye <vdye@github.com>
Cc:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 29, 2021 at 11:44 AM Victoria Dye <vdye@github.com> wrote:
>
> Elijah Newren wrote:
> > Hi,
> >
> > On Mon, Nov 29, 2021 at 7:52 AM Victoria Dye via GitGitGadget
> > <gitgitgadget@gmail.com> wrote:
> >>
> >> Changes since V5
> >> ================
> >>
> >>  * Update t1092 test 'reset with wildcard pathspec' with more cases and
> >>    better checks
> >>  * Add "special case" wildcard pathspec check when determining whether to
> >>    expand the index (avoids double-loop over pathspecs & index entries)
> >
> > Looks pretty good.  However, I'm worried this special case you added
> > at my prodding might be problematic, and that I may have been wrong to
> > prod you into it...
> >
> >> Thanks! -Victoria
> >>
> >> Range-diff vs v5:
> >>
> >>  7:  a9135a5ed64 ! 7:  822d7344587 reset: make --mixed sparse-aware
> >>      @@ Commit message
> >>
> >>           Remove the `ensure_full_index` guard on `read_from_tree` and update `git
> >>           reset --mixed` to ensure it can use sparse directory index entries wherever
> >>      -    possible. Sparse directory entries are reset use `diff_tree_oid`, which
> >>      +    possible. Sparse directory entries are reset using `diff_tree_oid`, which
> >>           requires `change` and `add_remove` functions to process the internal
> >>           contents of the sparse directory. The `recursive` diff option handles cases
> >>           in which `reset --mixed` must diff/merge files that are nested multiple
> >>      @@ builtin/reset.c: static void update_index_from_diff(struct diff_queue_struct *q,
> >>       +          * (since we can reset whole sparse directories without expanding them).
> >>       +          */
> >>       +         if (item.nowildcard_len < item.len) {
> >>      ++                 /*
> >>      ++                  * Special case: if the pattern is a path inside the cone
> >>      ++                  * followed by only wildcards, the pattern cannot match
> >>      ++                  * partial sparse directories, so we don't expand the index.
> >>      ++                  */
> >>      ++                 if (path_in_cone_mode_sparse_checkout(item.original, &the_index) &&
> >>      ++                     strspn(item.original + item.nowildcard_len, "*") == item.len - item.nowildcard_len)
> >
> > I usually expect in an &&-chain to see the cheaper function call first
> > (because that ordering often avoids the need to call the second
> > function), and I would presume that strspn() would be the cheaper of
> > the two.  Did you switch the order because you expect the strspn call
> > to nearly always return true, though?
> >
>
> This is a miss on my part, the `strspn()` check is probably less expensive
> and should be first.
>
> > Could the strspn() call be replaced by a `item.len ==
> > item.nowildcard_len + 1`?  I mean, sure, folks could list multiple
> > asterisks in a row in their pathspec, but that seems super unlikely
> > and even if it does happen the code will just fall back to the slower
> > codepath and still give them the right answer.  And the simpler check
> > feels a lot easier to parse for human readers.
> >
>
> Agreed on wanting better readability - if the multiple-wildcard case is
> unlikely, the `PATHSPEC_ONESTAR` flag would indicate whether the pathspec
> ends in a single wildcard character. If that flag is still too obscure,
> though, I can stick with the length comparison.
>
> > But I'm worried there's a deeper issue here:
> >
> >
> > Is the wildcard character (or characters) in path treated as a literal
> > by path_in_cone_mode_sparse_checkout()?  I think it is...and I'm
> > worried that may be incorrect.  For example, if the path is
> >
> >    foo/*
> >
> > and the user has done a
> >
> >   git sparse-checkout set foo/bar/
> >
> > Then 'foo/baz/file' is not in the sparse checkout.  However, 'foo/*'
> > should match 'foo/baz/file' and yet 'foo/*' when treated as a literal
> > path would be considered in the sparse checkout by
> > path_in_cone_mode_sparse_checkout.  Does this result in the code
> > returning an incorrect answer?  (Or did I misunderstand something so
> > far?)
> >
>
> Correct: `path_in_cone_mode_sparse_checkout` interprets the wildcard
> literally, and the checks here take that into account. The goal of
> `pathspec_needs_expanded_index` is to determine if the pathspec *may* match
> only partial contents of a sparse directory (like '*.c', or 'f*le'). For a
> `git reset --mixed`, only this scenario requires expansion; if an entire
> sparse directory is matched by a pathspec, the entire sparse directory is
> reset.
>
> Using your example, 'foo/*' does match 'foo/baz/file', but it also matches
> 'foo/' itself; as a result, the `foo/` sparse directory index entry is reset
> (rather than some individual files contained within it). The same goes for a
> patchspec like 'fo*' ("in-cone" and ending in a wildcard). Conversely, a
> pathspec like 'foo/ba*' would _not_ work (it wouldn't match something like
> 'foo/test-file'), and neither would 'f*o' (it would match all of 'foo', but
> would only match files ending in "o" in a directory 'f/').
>
> Hope that helps!

Ah, yes, thanks for the explanation.  :-)

> > I'm wondering if I misled you earlier in my musings about whether we
> > could avoid the slow codepath for pathspecs with wildcard characters.
> > Maybe there's no safe optimization here and wildcard characters should
> > always go through the slower codepath.
> >
> >>      ++                         continue;
> >>      ++
> >>       +                 for (pos = 0; pos < active_nr; pos++) {
> >>       +                         struct cache_entry *ce = active_cache[pos];
> >>       +
> >>  8:  f91d1dcf024 = 8:  ddd97fb2837 unpack-trees: improve performance of next_cache_entry
> >>
> >> --
> >> gitgitgadget
>
