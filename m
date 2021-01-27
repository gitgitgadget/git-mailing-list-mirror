Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79FFBC433E0
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 16:41:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3362B64D9E
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 16:41:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232655AbhA0QlU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Jan 2021 11:41:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231342AbhA0Qjr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jan 2021 11:39:47 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F33BBC061574
        for <git@vger.kernel.org>; Wed, 27 Jan 2021 08:39:06 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id a77so2796630oii.4
        for <git@vger.kernel.org>; Wed, 27 Jan 2021 08:39:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l3z7Rj49//euw5IGs/MrAjuGuqzooWPa/tnpqUFjlG0=;
        b=BuX7j7csuTP2ShD5C0Lcruy9aR238y5jTVX74HAXBpySnTauFKPx80XLIH3Se689iP
         bk44uqc0GcAqCZqNV8CXP/ERJ468uPM8/k4eUcyXKzyrEEkO21Uom9FhytRilJ1gsuNB
         xKwry+AJX06tQH3ElNrt9T1pp0/krC1J/lCsGhS+XKlogAgxCpnrVCexKbAcc0LfaPYv
         SIDV2ElHNT1co+vTQtvsid4/fG30f28k7Jm6zY7V5aJGqA6p9sbnrrvk2AjqRDktgLf9
         hHysQuq2RW5tPhh6sxGTl3mWda3ejKrJETBcu1fF7HKBhKYAYkKZsh8pk/R6N9U9+BeE
         oCkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l3z7Rj49//euw5IGs/MrAjuGuqzooWPa/tnpqUFjlG0=;
        b=MF24Ku86xESFtR/fWRq2vDoT/Bh+P5mKW6VzI0JeUugTe5DJhXQTsKokg1LnOMyHY8
         owB620R4teF9yh5E1tSm1b9tBH0qmzt/ecpzqnJRMdtdH0797REuFi5Szelphv6srCKH
         ZxuqE9T3pnRwN5N8kas0Emxf3rd9xgLv/+Cv/plLnUHp651QELUmSsJNsT3wgDxX42qK
         p2940K/pHT2jGNXrBek88PIA7hYF+lniAO4TbSWB6VUlmEmz+nlWPoqrDR2WfUic08yH
         0Xb4UHB6FT8lw9G2/PlHqxCs7bDKcrMAYxyWVNa1lM6aNu4kAHMBGnsMfJa8j5XqGKMN
         HSyQ==
X-Gm-Message-State: AOAM532tMAhKdGWueL4Y/4VSgujo6PkIaUGTgCNUaIaey2pQpNa5zIFU
        xfWgmm46oI7bwvI5VgnCRshMME1lvXUJz+tJEfXlnqd7LR4=
X-Google-Smtp-Source: ABdhPJyc+4EiMW87mF4RFe0Ycz3aTAtGZCo17/VW2EzvjhRzoQ02z63YhuW9bGa5CgQR24Ydpnl2S62qHNeE6P7YtsY=
X-Received: by 2002:aca:4e4f:: with SMTP id c76mr3744985oib.167.1611765546342;
 Wed, 27 Jan 2021 08:39:06 -0800 (PST)
MIME-Version: 1.0
References: <pull.847.git.1611596533.gitgitgadget@gmail.com>
 <ebbe8569dcc16f2ae235c4167be0e72a53982982.1611596534.git.gitgitgadget@gmail.com>
 <CABPp-BE3tLmfwyncbdTKZUgLYH_8M9zMjH=+LJG4bdGcbYDPMg@mail.gmail.com> <ef86c7fc-e811-036b-b2e3-221e3bdb624a@gmail.com>
In-Reply-To: <ef86c7fc-e811-036b-b2e3-221e3bdb624a@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 27 Jan 2021 08:38:55 -0800
Message-ID: <CABPp-BGavK8-xhVFcDk=VpzZ7h8e6v+M5tqkQO9wSkEoaqDhdg@mail.gmail.com>
Subject: Re: [PATCH 02/27] sparse-index: implement ensure_full_index()
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 27, 2021 at 5:43 AM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 1/26/2021 10:05 PM, Elijah Newren wrote:
> > On Mon, Jan 25, 2021 at 9:42 AM Derrick Stolee via GitGitGadget
> > <gitgitgadget@gmail.com> wrote:
> ...
> >> Sparse directory entries have a specific 'ce_mode' value. The macro
> >> S_ISSPARSEDIR(ce) can check if a cache_entry 'ce' has this type. This
> >> ce_mode is not possible with the existing index formats, so we don't
> >> also verify all properties of a sparse-directory entry, which are:
> >>
> >>  1. ce->ce_mode == 01000755
> >
> > This is a weird number.  What's the reason for choosing it?  It looks
> > deceptively close to 0100755, normal executable files, but has the
> > extra 0, meaning that ce->ce_mode & S_IFMT is 0, suggesting it has no
> > file type.
> >
> > Since it's a directory, why not use S_IFDIR (040000)?
> >
> > (GITLINK does use the weird 0160000 value, but it happens to be
> > S_IFLNK | S_IFDIR == 0120000 | 040000, which conveys "it's both a
> > directory and a symlink")
>
> I forget how exactly I came up with these magic constants, but then
> completely forgot to think of them critically because I haven't had
> to look at them in a while. They _are_ important, especially because
> these values affect the file format itself.
>
> I'll think harder on this before submitting a series intended for
> merging.
>
> >>  2. ce->flags & CE_SKIP_WORKTREE is true
> >
> > Makes sense.
> >
> >>  3. ce->name[ce->namelen - 1] == '/' (ends in dir separator)
> >
> > Is there a particular reason for this?  I'm used to seeing names
> > without the trailing slash, both in the index and in tree objects.  I
> > don't know enough to be for or against this idea; just curious at this
> > point.
>
> It's yet another way to distinguish directories from files, but
> there are cases where we do string searches up to a prefix, and
> having these directory separators did help, IIRC.
>
> >>  4. ce->oid references a tree object.
> >
> > Makes sense...but doesn't that suggest we'd want to use ce->ce_mode = 040000?
>
> ...
>
> >> +#define CE_MODE_SPARSE_DIRECTORY 01000755
> >> +#define SPARSE_DIR_MODE 0100
> >
> > Another magic value.  Feels like the commit message should reference
> > this one and why it was picked.  Seems odd to me, and possibly
> > problematic to re-use file permission bits that might collide with
> > files recorded by really old versions of git.  Maybe that's not a
> > concern, though.
> >
> >> +#define S_ISSPARSEDIR(m) ((m)->ce_mode == CE_MODE_SPARSE_DIRECTORY)
> >
> > Should the special sauce apply to ce_flags rather than ce_mode?  Thus,
> > instead of an S_ISSPARSEDIR, perhaps have a ce_sparse_dir macro
> > (similar to ce_skip_worktree) based on a CE_SPARSE_DIR value (similar
> > to CE_SKIP_WORKTREE)?
> >
> > Or, alternatively, do we need a single special state here?  Could we
> > check for a combination of ce_mode == 040000 && ce_skip_worktree(ce)?
>
> The intention was that ce_mode be a unique value that could only
> be assigned to a directory entry, which would then by necessity be
> sparse. Checking both ce_mode and ce_flags seemed wasteful with the
> given assumptions

040000 is a unique value that could only be assigned to a directory
entry.  Since we have no other uses of directories within the index,
you are right, we wouldn't need to check ce_skip_worktree(ce) as well;
just a check for the 040000 mode would be enough.

> ...
>
> >> +       /* Copy back into original index. */
> >> +       memcpy(&istate->name_hash, &full->name_hash, sizeof(full->name_hash));
> >> +       istate->sparse_index = 0;
> >> +       istate->cache = full->cache;
> >
> > Haven't you leaked the original istate->cache here?
>
> Yes, seems so. Will fix.
>
> Thanks,
> -Stolee
