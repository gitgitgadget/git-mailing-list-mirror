Return-Path: <SRS0=R55k=B3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C06AC433E3
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 17:27:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB2A12072E
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 17:27:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kLmfDGqJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729682AbgHQR1g (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Aug 2020 13:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389719AbgHQRTP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Aug 2020 13:19:15 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60CEEC061389
        for <git@vger.kernel.org>; Mon, 17 Aug 2020 10:19:15 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id k4so15454332oik.2
        for <git@vger.kernel.org>; Mon, 17 Aug 2020 10:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GfU5egJWFvRMe1FYaQzgZHv+90LWp6L6WkAapDQ4Mi0=;
        b=kLmfDGqJuaW38nf76Xwrq83PVT01Y6yk60ubG298y4Dg3EqXmr7TLivPPnKKhT2Vh6
         UUImrGyzq9qZB1yjwql4/y5UkW5qN5M1Fgr0DjAnrNYKdW6+2e4o09tJlmyq/fhVlzJO
         e9N2eSWk2Q9RLOpOzA47xa7TbBP1FIgxNlMPDLqGUvpp/CZOtI2OFsasPWe/C+7YIJ/t
         eegpOMFm1PkiXdtbV1HBzt8QXV9Ss8U3Ad0w7TZAn+Y16Xu0taDYjVrf3K1WJyOK/j0g
         m7QyMmLEL0FKTLIa16yq+1IEzctDbEEEnCxsUK4dgtOh4M2W4a5O/EhssOAIP4OL1+zM
         aeww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GfU5egJWFvRMe1FYaQzgZHv+90LWp6L6WkAapDQ4Mi0=;
        b=cgacFr/wwtnGwIOt3CKxLMd1uB/mLMbaoKfj4HitiAasWYb+j8vjSUu0B+6PkO7J8w
         KfFkR6xdlGP9Uu2yHhLz5Xy3IVcyBOW3wrxbTz/CetvBOJEXHCBmEZ/gZW1IoQMnQGpI
         lDmcSjcH33dlsMC+zVGsUKIgV1S1GWbIhv3gN4KAEPs3gbQl6b9GnaQc5iOGz6EzsEXp
         CiesEWOWIIr1P+232H2fHQX6LIXPlG7nHscz1/pb45+aWJsGiI6M/S1s16dmza4Ai/UO
         ZgbohQVMI7etkgIw6/fLeFQwd6ovGk0WrQU6HGg0UAV5LmG2yXvUGI1Pyx+VRKhps9C0
         ov+A==
X-Gm-Message-State: AOAM530nBX7j5kb/8qbniIbXbCYH656TsLwKzNT3PBkoxIoMKojlfXMI
        FHj7YRyDgx35yXA16ZT+tB6d+qm5+hiaRaQkUbs=
X-Google-Smtp-Source: ABdhPJx8NqXX4OezF/UYMJ95dnQMM/+2Iiy0pJdyGX54cbKt101YzW5X/77Zv/LJpZt80Bftz25U6OEnz2+CV1jbquA=
X-Received: by 2002:aca:b705:: with SMTP id h5mr9725801oif.31.1597684754657;
 Mon, 17 Aug 2020 10:19:14 -0700 (PDT)
MIME-Version: 1.0
References: <pull.831.git.git.1597561152.gitgitgadget@gmail.com>
 <b9310e9941e91336258edd97a913e5908180720e.1597561152.git.gitgitgadget@gmail.com>
 <20200816091154.GC1221900@coredump.intra.peff.net>
In-Reply-To: <20200816091154.GC1221900@coredump.intra.peff.net>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 17 Aug 2020 10:19:03 -0700
Message-ID: <CABPp-BHyCVdb5AueF+tTwTsgAA5LkPEj-mPLoX_F+WYgPqFcNw@mail.gmail.com>
Subject: Re: [PATCH 3/3] dir: fix problematic API to avoid memory leaks
To:     Jeff King <peff@peff.net>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Aug 16, 2020 at 2:11 AM Jeff King <peff@peff.net> wrote:
>
> On Sun, Aug 16, 2020 at 06:59:11AM +0000, Elijah Newren via GitGitGadget wrote:
>
> > Digging further, I found that despite the pretty clear documentation
> > near the top of dir.h that folks were supposed to call clear_directory()
> > when the user no longer needed the dir_struct, there were four callers
> > that didn't bother doing that at all.  However, two of them clearly
> > thought about leaks since they had an UNLEAK(dir) directive, which to me
> > suggests that the method to free the data was too unclear.  I suspect
> > the non-obviousness of the API and its holes led folks to avoid it,
> > which then snowballed into further problems with the entries[],
> > ignored[], parent_hashmap, and recursive_hashmap problems.
>
> The UNLEAK() ones are sort-of my fault, and are a combination of:
>
>   - The commit adding them says "in some cases (e.g., dir_struct) we
>     don't even have a function which knows how to free all of the struct
>     members". I'm not sure if why I didn't fix clear_directory() as you
>     did. I may not have known about it, or I may have been lazy. Or more
>     likely I was simply holding the UNLEAK() hammer, so it looked like a
>     nail. ;)
>
>   - My focus was on making leak-checker output cleaner. And it wasn't
>     clear for cases where we're about to exit the program whether we
>     should be actually freeing (which has small but non-zero cost) or
>     just annotating (which is zero-cost, but clearly has confused some
>     people about how UNLEAK() was meant to be used). I think I'm leaning
>     these days towards "free if it is easy to do so".
>
> So this definitely seems like a good direction to me.
>
> > Rename clear_directory() to dir_free() to be more in line with other
> > data structures in git, and introduce a dir_init() to handle the
> > suggested memsetting of dir_struct to all zeroes.  I hope that a name
> > like "dir_free()" is more clear, and that the presence of dir_init()
> > will provide a hint to those looking at the code that there may be a
> > corresponding dir_free() that they need to call.
>
> I think having a pair of matched calls is good. I _thought_ we had
> established a pattern that we should prefer "clear" to "free" for cases
> where the struct itself its not freed. But grepping around, I see there
> are a few exceptions (hashmap_free() is the big one, and then
> oidmap_free() which is built around it seems to have inherited it).
>
> The rest seem to follow that pattern, though: attr_check_free,
> cache_tree_free, and submodule_cache_free all actually free the pointer
> passed in. And "git grep '_clear(' *.h" shows lots of
> clear-but-don't-free examples.
>
> Would dir_clear() make the pairing more obvious, but keep the clear
> name?

Sure, that works for me.  The case where having an actual _free()
makes sense to me -- possibly in addition to a _clear() -- is when
some memory has to be allocated before first use, and thus a
foo_clear() would leave that memory allocated.  Then you really do
need a foo_free() for use when the data structure won't be used again.

> (I also wouldn't be opposed to changing hashmap and oidmap to use the
> name "clear", but that's obviously a separate patch).

hashmap is one of the cases that needs to have a free construct,
because the table in which to stuff the entries has to be allocated
and thus a hashmap_clear() would have to leave the table allocated if
it wants to be ready for re-use.  If someone really is done with a
hashmap, then to avoid leaking, both the entries and the table need to
be deallocated.

I keep getting confused by the hashmap API, and what pieces it frees
-- it looks like my earlier comments today were wrong and
hashmap_free_entries() does free the table.  So...perhaps I should
create a patch to make that clearer, and also submit the patch I've
had for a while to introduce a hashmap_clear() function (which is
similar to hashmap_free_entries, in that it frees the entries and
zeros out most of the map, but it leaves the table allocated and ready
for use).

I really wish hashmap_free() did what hashmap_free_entries() did.  So
annoying and counter-intuitive...

> >  builtin/add.c          |  4 ++--
> >  builtin/check-ignore.c |  4 ++--
> >  builtin/clean.c        |  8 ++++----
> >  builtin/grep.c         |  3 ++-
> >  builtin/ls-files.c     |  4 ++--
> >  builtin/stash.c        |  4 ++--
> >  dir.c                  |  7 ++++++-
> >  dir.h                  | 19 ++++++++++---------
> >  merge.c                |  3 ++-
> >  wt-status.c            |  4 ++--
> >  10 files changed, 34 insertions(+), 26 deletions(-)
>
> That patch itself looks good except for two minor points:
>
> >  /* Frees memory within dir which was allocated.  Does not free dir itself. */
> > -void clear_directory(struct dir_struct *dir)
> > +void dir_free(struct dir_struct *dir)
> >  {
> >       int i, j;
> >       struct exclude_list_group *group;
>
> As I mentioned in my previous email, I think it would be nice if this
> called dir_init() at the end, so that the struct is always in a
> consistent state.
>
> > diff --git a/dir.h b/dir.h
> > index 7d76d0644f..7c55c1a460 100644
> > --- a/dir.h
> > +++ b/dir.h
> > [...]
> > - * - Use `dir.entries[]`.
> > + * - Use `dir.entries[]` and `dir.ignored[]`.
> >   *
> >   * - Call `clear_directory()` when the contained elements are no longer in use.
> >   *
>
> This last line should become dir_free() / dir_clear().

I'll fix these up.

Elijah
