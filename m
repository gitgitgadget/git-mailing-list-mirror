Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 251A0C2D0E4
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 05:21:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC2792468E
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 05:21:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HD+RjHdC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725823AbgKQFUn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Nov 2020 00:20:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbgKQFUn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Nov 2020 00:20:43 -0500
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFE30C0613CF
        for <git@vger.kernel.org>; Mon, 16 Nov 2020 21:20:42 -0800 (PST)
Received: by mail-ot1-x341.google.com with SMTP id f16so18277863otl.11
        for <git@vger.kernel.org>; Mon, 16 Nov 2020 21:20:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pWnm7HE0hXee/9Wc/grkTdpBVwFfomF3i6FQl0hEkC8=;
        b=HD+RjHdCC9EHdZxosWOpBmXR2HBDrqbMtx4DCfOf1tRSGzycRsakaaR0GohnvyxG5G
         vVLd5UCwj0Cy3rf83KpSxIusNjCY1oYkgprgHit41lGJ+Is+NXo9Euz0wTr/HSRMfQaG
         sCNE3R2tDAzVhsdGfTqPvi+D4mjNegr5dusnSrseNpEjlfDmDds44KNwJqf4KBLJxt89
         iVethEsHqHQ7gD/9hA9yjNFDJjW3F929hNtEDwhBZgAQXOlNdqcOfoJAmCvY/WlN5wse
         G20hgbnUhfgHKHlmjZZncadxXoHHGdoPAWksncsfEE85+J1VYytrZStExi7HLGuPdybh
         m9vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pWnm7HE0hXee/9Wc/grkTdpBVwFfomF3i6FQl0hEkC8=;
        b=Kcxzxn4wuFoIjcm1rq6fGGMd6IlDU9v33mMSejGZzerq6XpScdSKtCJwRfB5SVLMqF
         PprpwewdlZdGm5IiPDh2CpxfUH9yh9+fZFbSjfKb0jRQ6odZVIdcfIiQffF6gtkO8+vh
         q/lobsduZoZwgi3xrhNp7ctqyo2jtc9kGuVHMIr06W7Etuz1fU6TABgR+uN8a+4Rsnvv
         7ucLFNPMSgrcXvtg5QUvdgpMdVlA3AEyXV0GF+/gDu0tDGPyt4vmjXJGGePZtgztYtiX
         v/mEjrO1sBjQlw+Qxs5CMcPTa+PTf6JpdGbskq5ciM7CT8yiHC5Lzy1pqMKCbZ0JNpTv
         DOQw==
X-Gm-Message-State: AOAM530CTwW3ALffdH8+ixxmgqQt+fQG87xwbnxghk3WVzBbPBXaenkQ
        I7E6U7b4bFwY/f3w1dxiYmqS6DnnrlcVy4eM/sDGmKy3t6IalQ==
X-Google-Smtp-Source: ABdhPJyQ8ZMPJJD0TW9wfdio2odaxlIwUqZEypzubBHYCYHNm/ISl3071Clh4yoHi2GqArCmOFZuuFtt7bUg6PuV/uQ=
X-Received: by 2002:a05:6830:1002:: with SMTP id a2mr2008000otp.316.1605590442144;
 Mon, 16 Nov 2020 21:20:42 -0800 (PST)
MIME-Version: 1.0
References: <9f2135f90ffea7f4ccb226f506bf554deab324cc.1605205427.git.matheus.bernardino@usp.br>
 <xmqqeekt83fl.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqeekt83fl.fsf@gitster.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 16 Nov 2020 21:20:30 -0800
Message-ID: <CABPp-BHvZyb4cF29HqDYgMHTMEr2LdvKYATWqADRyhqJzB=Liw@mail.gmail.com>
Subject: Re: [PATCH] rm: honor sparse checkout patterns
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Matheus Tavares <matheus.bernardino@usp.br>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Mon, Nov 16, 2020 at 12:14 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Matheus Tavares <matheus.bernardino@usp.br> writes:
>
> > Make git-rm honor the 'sparse.restrictCmds' setting, by restricting its
> > operation to the paths that match both the command line pathspecs and
> > the repository's sparsity patterns.
>
> > This better matches the expectations
> > of users with sparse-checkout definitions, while still allowing them
> > to optionally enable the old behavior with 'sparse.restrictCmds=false'
> > or the global '--no-restrict-to-sparse-paths' option.
>
> Hmph.  Is "rm" the only oddball that ignores the sparse setting?

This might make you much less happy, but in general none of the
commands pay attention to the setting; I think a line or two in
merge-recursive.c is the only part of the codebase outside of
unpack_trees() that pays any attention to it at all.  This was noted
as a problem in the initial review of the sparse-checkout series at
[1], and was the biggest factor behind me requesting the following
being added to the manpage for sparse-checkout[2]:

THIS COMMAND IS EXPERIMENTAL. ITS BEHAVIOR, AND THE BEHAVIOR OF OTHER
COMMANDS IN THE PRESENCE OF SPARSE-CHECKOUTS, WILL LIKELY CHANGE IN
THE FUTURE.

However, multiple groups were using sparse checkouts anyway, via
manually editing .git/info/sparse-checkout and running `git read-tree
-mu HEAD`, and adding various wrappers around it, and Derrick and I
thought there was value in getting _something_ out there to smooth it
out a little bit.  I'd still say it's pretty rough around the
edges...but useful nonetheless.

[1] https://lore.kernel.org/git/CABPp-BHJeuEHBDkf93m9sfSZ4rZB7+eFejiAXOsjLEUu5eT5FA@mail.gmail.com/
[2] https://lore.kernel.org/git/CABPp-BEryfaeYhuUsiDTaYdRKpK6GRi7hgZ5XSTVkoHVkx2qQA@mail.gmail.com/

> >  to the paths specified by the sparsity patterns, or to the intersection of
> >  those paths and any (like `*.c`) that the user might also specify on the
> >  command line. When false, the affected commands will work on full trees,
> > -ignoring the sparsity patterns. For now, only git-grep honors this setting.
> > +ignoring the sparsity patterns. For now, only git-grep and git-rm honor this
> > +setting.
>
> I am not sure if this is a good direction to go---can we make an
> inventory of all commands that affect working tree files and see
> which ones need the same treatment before going forward with just
> "grep" and "rm"?  Documenting the decision on the ones that will not
> get the same treatment may also be a good idea.  What I am aiming
> for is to prevent users from having to know in which versions of Git
> they can rely on the sparsity patterns with what commands, and doing
> things piecemeal like these two topics would be a road to confusion.

It's not just commands which affect the working tree that need to be
inventoried and adjusted.  We've made lists of commands in the past:

[3] https://lore.kernel.org/git/CABPp-BEbNCYk0pCuEDQ_ViB2=varJPBsVODxNvJs0EVRyBqjBg@mail.gmail.com/
[4] https://lore.kernel.org/git/xmqqy2y3ejwe.fsf@gitster-ct.c.googlers.com/

But the working-directory related ones are perhaps more problematic.
One additoinal example: I just got a report today that "git stash
apply" dies with a fatal error and the working directory in some
intermediate state when trying to apply a stash when the working
directory has a different set of sparsity paths than when the stash
was created.  (Granted, an error makes sense, but this was throwing
untranslated error messages, meaning they weren't in codepaths that
were meant to be triggered.)  This case may not be an apples to apples
comparison, but the testcase did involve adding new files before
stashing, so the stash apply would have been trying to remove files.
Anyway, I'll send more details on that issue in a separate thread
after I've had some time to dig into it.


Anyway, I'm not sure this helps, because I'm basically saying things
are kind of messy, and we're fixing as we go rather than having a full
implementation and all the fixes.
