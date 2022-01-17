Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9964C433F5
	for <git@archiver.kernel.org>; Mon, 17 Jan 2022 18:15:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242385AbiAQSPM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Jan 2022 13:15:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238188AbiAQSPL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Jan 2022 13:15:11 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C33BC061574
        for <git@vger.kernel.org>; Mon, 17 Jan 2022 10:15:11 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id q25so69112177edb.2
        for <git@vger.kernel.org>; Mon, 17 Jan 2022 10:15:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Cb//9/0qPVrIOfjaGNoYrZmRW7fUkXBxkf8gZZEBMkI=;
        b=q46Qexxj1aS8iz9GyEFRSjvuA3ic3QN3o406lqf7ElzH9aa63Idr0Lt7ijU7kbHxPv
         XGl6U7TzHd4F4vLOEQK4+ZbLfJRl7iVNoBCaN0fuICzp8IMcmHnOKUZoQt9OISwiQM9q
         C5pvgugBQ/WhuJswxHfiyXM+AhBKCflFKLgV4mCrQ4Ee2whJPFPFxWks2GmZ3n3mcBh8
         +MthBxW964Z5OjW1R88ICvqn451f10ouBSGQmw3S97rjXYk8h/l60AlYs8sFygIw5g91
         iXm5XR2chc+lqOLZ+OKdVKl3J7RwngYhSFE8I5eRCI4EXnQ4hlYeyru6BQPT+StU087n
         5DmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Cb//9/0qPVrIOfjaGNoYrZmRW7fUkXBxkf8gZZEBMkI=;
        b=PVdrdFxjhJrJxNKFux2wsb3GEQc0nx10/UfSo2xR3lDPHQoW+DXsXXP3CmaBrTozDp
         wcQgrl7uN9+aXZOZkwJZAmqT3ck2Xq2CmfT75WYuXG2xS+H5FZ8ei5EHnnY39ZtnjXLH
         t1F7s0inq9MxWxeG0ytTFLA4phh8a6I7mDRXJDVTTlTx9odjQwhFBwkzcbH5ehxWXNY5
         rhGmnRnfEquFLZjB0loOHJK7fmETNZT/aFAOnPAAL3Uepm++J4ZWrvJ2RMB7dbOFMktN
         ti9/jlhatbLszQmJsJnaFCsR9zyv+uOlCGMbWXgaQrCvmLDueCQN9U22pQESvj3T/r6+
         Txpw==
X-Gm-Message-State: AOAM530EFARdOx2pmS9C5ARHjUSuaH69TmngYSPJARci4Y4KC9D7xDu4
        MXfc80zaaR3vZVZpTqY+On3Cl7zevt8pjvqqPT4=
X-Google-Smtp-Source: ABdhPJyQUo7YADs0lOEco1kMpCGhIfcDTJ4NZFtUQxLRn6hiqdHGk11pIrNeYg4YCDhtZEVc569LyGbeiDt6MoE6Uk8=
X-Received: by 2002:a17:907:3f1b:: with SMTP id hq27mr17345805ejc.613.1642443309888;
 Mon, 17 Jan 2022 10:15:09 -0800 (PST)
MIME-Version: 1.0
References: <pull.1108.v2.git.1640892413.gitgitgadget@gmail.com>
 <pull.1108.v3.git.1641841193.gitgitgadget@gmail.com> <256e5f034c6072b6e3621adfa96c5c6319752fae.1641841193.git.gitgitgadget@gmail.com>
 <20220115095725.GA1738@szeder.dev> <CABPp-BGR+UrW5ej-8+XXHPkjMfFgURycd9rWC+2awUvYcr_PXA@mail.gmail.com>
 <xmqqv8yjz5us.fsf@gitster.g>
In-Reply-To: <xmqqv8yjz5us.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 17 Jan 2022 10:14:58 -0800
Message-ID: <CABPp-BErg-RtyycXaRXYfQHEQXA4q-FU9Q6nYkSHJsqL-04oXw@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] sparse-checkout: custom tab completion
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Lessley Dennington via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        johannes.schindelin@gmail.com,
        Lessley Dennington <lessleydennington@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jan 16, 2022 at 2:13 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> > ...  If our
> > guide is merely what the command swallows, then we should forgo
> > completion for these subcommands, because it's not possible to
> > enumerate all possible completions.
>
> I am not sure if I follow.  I do not think it makes sense to aim for
> enumerating EVERYTHING the command would accept.  But I do not know
> that is the same as "merely what the command swallows".

I don't understand your distinction; I think your second sentence is
the same thing I said.

> > I don't think that's a useful guide or starting point, so we
> > instead need to discuss what are reasonable completions.
>
> I do not think it is a good idea to refrain from suggesting anything
> that has a possibility of being wring, either, though.  If a path
> that is not a directory (either because it is a file in the current
> checkout, or because it is a directory only in a different branch)
> is given, it might not make sense in the cone-mode for the current
> checkout, but it may well make sense when a different branch is
> checked out.

Completing on files and directories would be a reasonable first cut,
but that's what we already had before this series was proposed.  It
has the downsides of
  * [cone-mode] making the majority of suggested completions wrong
  * [non-cone mode] subtly recommending individually adding all wanted
files, increasing the number of patterns and exacerbating the
quadratic behavior that non-cone mode experiences with every
unpack_trees() call that touches the working tree.
  * [both modes] potentially making it hard to find or select the
valid choices you do want (there are many more files than directories)

But, despite all that, completing on files and directories is a
somewhat reasonable first cut.

Lessley was trying to aim higher with her submission, though, and I
don't see why she should be dissuaded.  Something better would be
nice.

>  Or you may not even in the cone-mode, and in which
> case, as SZEDER suggested, a single filename may perfectly make
> sense.  A user who said READM<TAB> and does not see it completed to
> README.md would be quite confused.

I'm not sure I follow.  READM<TAB> already doesn't complete to
README.md in the following example command lines:
   'cd READM<TAB>'
   'ssh READM<TAB>'
That doesn't seem to cause user confusion, so I don't think
disallowing it in cone-mode would cause confusion.  Suggesting it, on
the other hand, may well cause confusion given that cone-mode is
explicitly about directories and is documented as such.

If you're only talking about non-cone mode, then this may be a
reasonable objection, though I'm not sure I agree with it even then.
In addition to the fact that individual file completion can be
detrimental to the user in non-cone mode for performance reasons, the
documentation never explicitly states files are acceptable to
sparse-checkout {set,add}.  It always mentions "directories" and
"patterns".  We can't complete all patterns, so we have to pick a
subset.  I don't see why "directories and files" is a better subset to
pick than "just directories".

> Are we limiting ourselves to directories only when we know we are in
> the cone-mode and showing both directories and files otherwise?

That is one possibility, though not the one Lessley proposed.

> I think the guiding principle ought to be that we show completion
> that
>
>  - is cheap enough to compute in interactive use (e.g. we should
>    refrain from looking for directories in all possible branches,
>    but instead just look at the working tree and possibly in the
>    index),

I agree, except with the suggestion to use the working tree or index
in the case of sparse-checkouts.  The working tree shouldn't be used
because it doesn't have the needed information:
  * `git clone --sparse` starts with zero subdirectories present
  * `set` and `add` are likely being used to change sparsity to
include something not already present

The index shouldn't be used because it is not cheap for interactive use:
  * it contains recursive entries below directories of interest that
have to be filtered out
  * with the sparse-index, it may have sparse-directories hiding what
we want, forcing us to fully inflate the index to find the pieces we
do want

I agree with Lessley's choice of using ls-tree and HEAD to achieve
cheap interactive use.

>  - is simple enough to explain to the users to understand what the
>    rules are, and
>
>  - gives useful enough candidates.

I agree with these 3 criteria.

> "We only look for directories (without going recursive) in the
> working tree" does satisfy the first two, but I am not sure it is
> more useful than "We show files and directories (without going
> recursive) in the working tree", which also satisfies the first
> two.

Well, Lessley certainly thought directories-only was more useful, and
in fact labelled "files and directories" as a bug/issue in her cover
letter.  Stolee commented on the series and also didn't see anything
wrong with that claim.

> Of course, if the completion limits to directories only in a
> repository in the cone-mode, I would not worry about the exclusion
> of non-directories will confuse users.

I'd prefer directories-only for both modes, but could accept
directories-only for cone mode and both-files-and-directories for
non-cone mode.

Especially since I think we're going to deprecate non-cone mode regardless.
