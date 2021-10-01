Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F831C433EF
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 04:26:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22D3261439
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 04:26:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239646AbhJAE2g (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Oct 2021 00:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232679AbhJAE2f (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Oct 2021 00:28:35 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17E33C06176A
        for <git@vger.kernel.org>; Thu, 30 Sep 2021 21:26:52 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id p13so1705135edw.0
        for <git@vger.kernel.org>; Thu, 30 Sep 2021 21:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EQdIwiqK3Jvswhf/qgrx4NXDd3NsEO1FmxeTgVbBPBk=;
        b=MgwsJTPCFOfc1+dO2BNo3mwy7NFhveDNVdl0xNEtptYUxp0vzrgvTiC22TiDOyKeVQ
         tBVIGI2oPkHAnulGldwmDh0USX4Cp5o1NVAIjfzzx0QUXq3r1nHL+ROjx7Vl3xOMWbIs
         BQHnPZ/QmclcBtI5+v01udlIZUOmPCskkNeTiNrBn3eNJfzANiHdHEYzETzzQa8Xw4wb
         73oPKuQztuo1HiW+uuejyI2g4xsdHl8bLhsudM+0aABUHAf4UunXyq6VQ+U0a95RmhI2
         cAeJAnAsRyKKLQR8mVgC3KsSoEAJQ9OLayq4o72nNEm1rElw+UYYZf/ptQ0VUFBe/Sat
         Y5nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EQdIwiqK3Jvswhf/qgrx4NXDd3NsEO1FmxeTgVbBPBk=;
        b=0Sh3OnpWr7uQrUknYjRQ9vUAX1+S3iaLt3oDOdS7Zl5SUZIURYXnzWiWvcOYE6TS5U
         fRoCGXcqUVtkeCz4tTmK1WuDmpLxyvHgUQHBeACMuwONfqhFOva/p47HnKTwu/EKXA7C
         iW5Rx/bSzugKkDkk2SNsZ6Q0QwxrL/q4p+fp+gwr+dbz/MQ684za8vqOOu6f0yRJ1Qcw
         1VVECX//UM/r5X4I4wwLN537BqSCAWjml7FIu+8UCB384Go2ysuSOxadXUwueg/wxB70
         yWl+mOAUZ30InIefb4z+TGXrDrzy1vVWqx2L9U/Ads+JzpBD19BSDsuzdXzW8BznOKOq
         3LbA==
X-Gm-Message-State: AOAM531GrEQdsDYC4FEtV7EocwMdqGn55pzVQ6tKQ9FqxCLqHGq4+sF4
        YiJUhUmbkER89+/rbHWH3zAX69b+Y3uMWWIZcfk=
X-Google-Smtp-Source: ABdhPJxhB61ny2/yK5JuzL+0/9Q3qekvHReW+pOzzFWdrydkVAVyT8NOUNykWs0xYP1iBvdoO83s8GSi3813W9tx5nw=
X-Received: by 2002:aa7:df9a:: with SMTP id b26mr11901446edy.368.1633062410527;
 Thu, 30 Sep 2021 21:26:50 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1080.git.git.1630376800.gitgitgadget@gmail.com>
 <67d3b2b09f9ddda616cdd0d1b12ab7afc73670ed.1630376800.git.gitgitgadget@gmail.com>
 <YVOiggCWAdZcxAb6@coredump.intra.peff.net> <xmqqsfxof2hr.fsf@gitster.g> <YVVoXJo3DlPQd1A3@coredump.intra.peff.net>
In-Reply-To: <YVVoXJo3DlPQd1A3@coredump.intra.peff.net>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 30 Sep 2021 21:26:37 -0700
Message-ID: <CABPp-BF20vpC4m5V4JtS91fuA+PMiEN78J9OpVEPDpnKsTcP8A@mail.gmail.com>
Subject: Re: [PATCH 5/7] tmp-objdir: new API for creating and removing primary
 object dirs
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Sergey Organov <sorganov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 30, 2021 at 12:33 AM Jeff King <peff@peff.net> wrote:
>
> On Tue, Sep 28, 2021 at 09:08:00PM -0700, Junio C Hamano wrote:
>
> > Jeff King <peff@peff.net> writes:
> >
> > >   Side note: The pretend_object_file() approach is actually even better,
> > >   because we know the object is fake. So it does not confuse
> > >   write_object_file()'s "do we already have this object" freshening
> > >   check.
> > >
> > >   I suspect it could even be made faster than the tmp_objdir approach.
> > >   From our perspective, these objects really are tempfiles. So we could
> > >   write them as such, not worrying about things like fsyncing them,
> > >   naming them into place, etc. We could just write them out, then mmap
> > >   the results, and put the pointers into cached_objects (currently it
> > >   insists on malloc-ing a copy of the input buffer, but that seems like
> > >   an easy extension to add).
> > >
> > >   In fact, I think you could get away with just _one_ tempfile per
> > >   merge. Open up one tempfile. Write out all of the objects you want to
> > >   "store" into it in sequence, and record the lseek() offsets before and
> > >   after for each object. Then mmap the whole result, and stuff the
> > >   appropriate pointers (based on arithmetic with the offsets) into the
> > >   cached_objects list.
> >
> > Cute.  The remerge diff code path creates a full tree that records
> > the mechanical merge result.  By hooking into the lowest layer of
> > write_object() interface, we'd serialize all objects in such a tree
> > in the order they are computed (bottom up from the leaf level, I'd
> > presume) into a single flat file ;-)
>
> I do still like this approach, but just two possible gotchas I was
> thinking of:
>
>  - This side-steps all of our usual code for getting object data into
>    memory. In general, I'd expect this content to not be too enormous,
>    but it _could_ be if there are many / large blobs in the result. So
>    we may end up with large maps. Probably not a big deal on modern
>    64-bit systems. Maybe an issue on 32-bit systems, just because of
>    virtual address space.
>
>    Likewise, we do support systems with NO_MMAP. They'd work here, but
>    it would probably mean putting all that object data into the heap. I
>    could live with that, given how rare such systems are these days, and
>    that it only matters if you're using --remerge-diff with big blobs.

Um, I'm starting to get uncomfortable with this pretend_object stuff.
Part of the reason that merge-ort isn't truly "in memory" despite
attempting to do exactly that, was because for large enough repos with
enough files modified on both sides, I wasn't comfortable assuming
that all new files from three-way content merges and all new trees fit
into memory.  I'm sure we'd be fine with current-day linux kernel
sized repos.  No big deal.  In fact, most merges probably don't add
more than a few dozen new files.  But for microsoft-sized repos, and
with repos tending to grow over time, more so when the tools
themselves scale nicely (which we've all been working on enabling),
makes me worry there might be enough new objects within a single merge
(especially given the recursive inner merges) that we might need to
worry about this.

>  - I wonder to what degree --remerge-diff benefits from omitting writes
>    for objects we already have. I.e., if you are writing out a whole
>    tree representing the conflicted state, then you don't want to write
>    all of the trees that aren't interesting. Hopefully the code is
>    already figuring out which paths the merge even touched, and ignoring
>    the rest.

Not only do you want to avoid writing all of the trees that aren't
interesting, you also want to avoid traversing into them in the first
place and avoid doing trivial file merges for each entry underneath.
Sadly, merge-recursive did anyway.  Because renames and directory
renames can sometimes throw a big wrench in the desire to avoid
traversing into such directories.  Figuring out how to avoid it was
kind of tricky, but merge-ort definitely handles this when it can
safely do so; see the cover letter for my trivial directory resolution
series[1].

[1] https://lore.kernel.org/git/pull.988.v4.git.1626841444.gitgitgadget@gmail.com/

>    It probably benefits performance-wise from
>    write_object_file() deciding to skip some object writes, as well
>    (e.g., for resolutions which the final tree already took, as they'd
>    be in the merge commit).

Yes, it will also benefit from that, but the much bigger side is
avoiding needlessly recursing into directories unchanged on (at least)
one side.

>    The whole pretend-we-have-this-object thing
>    may want to likewise make sure we don't write out objects that we
>    already have in the real odb.

Right, so I'd have to copy the relevant logic from write_object_file()
-- I think that means instead of write_object_file()'s calls to
freshen_packed_object() and freshen_loose_object() that I instead call
find_pack_entry() and make has_loose_object() in object-file.c not be
static and then call it.  Does that sound right?

Of course, that's assuming we're okay with this pretend_object thing,
which I'm starting to worry about.
