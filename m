Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0FA6C4320A
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 15:56:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 944F2610A3
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 15:56:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241418AbhHTP5U (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Aug 2021 11:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241429AbhHTP5S (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Aug 2021 11:57:18 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7575BC0617A8
        for <git@vger.kernel.org>; Fri, 20 Aug 2021 08:56:38 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id k12-20020a056830150c00b0051abe7f680bso9698910otp.1
        for <git@vger.kernel.org>; Fri, 20 Aug 2021 08:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3FlCYfQp114FCgcUrAMxBKfZvQZO5JzWFqJICyQtulg=;
        b=RokAOJfiRD1Fe8vi6IeCM0Sspoyy7eFBB1Ma+hG7qfoDMv8tuPetbz2KMVvLA9DwAB
         A2zxt6JGcLs3wE+MPWQt4w9whRi8v3xmh7HiG/aBRocpzc/FaHPZqhqjxxpcGrReSvPE
         cZRgE095tfRphcRep20FyX6ia4yQB8nMAo6JwwNTXUZE9nL99eUq6BgSCC5HHEhMmAJd
         lKrP3wk5uHs/u57uippTDii/VcAFTkigUN9tGqVTs14wZN34/n/djYaV/JpHTNBXp6dd
         yuHCKEZNh3nRa3KSE6JR4eZBk5mAyIB+QwB/ZpdnvbepcCsNAGYpEPX3E/22hY8PI+4z
         kXVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3FlCYfQp114FCgcUrAMxBKfZvQZO5JzWFqJICyQtulg=;
        b=gZpBxiP/cwV0PqRz6+Fs9SFWN4J4Fi9KhOoGC+xrnZIF7Z7F0GcCuKFwGyW7WH2L0G
         Ru0ThIoQb+yY2vojnE45d6GjSBj97N6oDaTiZlIMRkEqif9ipa13vfxyZG3rjR0O0P6r
         2ZZxb6uxhG8RUGIdXsKAXsWn8VAo+AZSovZNgWKUbBLYopzzTW8DA57EF+6cqGJYr4su
         khTFVBnyL2y3p7Xun0l4gsBWhbKNYtc1e8BXdvD5u6lfakkoUe5Peh2A0guLfKFW31jw
         bzLQgwhvVUFwOsgCXJ+HSNm2r+pIL8ulEBlCV3M94agxFhm8+W8rzjq4L8FGa24/WrLM
         x/Yw==
X-Gm-Message-State: AOAM532g7e93+oObmmWu6biQBelzsNDTFLobmtFhAeGSBznPz91oemRD
        v8aGgTGyotMbxThFZ5qpQxlN1z2rVlUQoIeRA0M=
X-Google-Smtp-Source: ABdhPJzPmiOf5JyuQWV+b7LYjdPVNJQbzzL9VSMxmFtj4mF+hwcmPb/HUkYdXco8aCFePu34alSQWSgSqRXQvWQGsJc=
X-Received: by 2002:a05:6808:2084:: with SMTP id s4mr3518779oiw.31.1629474997888;
 Fri, 20 Aug 2021 08:56:37 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1009.v2.git.1628625013.gitgitgadget@gmail.com>
 <pull.1009.v3.git.1629206602.gitgitgadget@gmail.com> <febef675f051eb08896751bb5661b6deb5579ead.1629206603.git.gitgitgadget@gmail.com>
 <nycvar.QRO.7.76.6.2108191015260.55@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.2108191015260.55@tvgsbejvaqbjf.bet>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 20 Aug 2021 08:56:26 -0700
Message-ID: <CABPp-BFUoPQUQDRaRj3Rq2gShOD8WPv6Oh-Wdj4m-7sf=okY6Q@mail.gmail.com>
Subject: Re: [PATCH v3 8/8] sparse-checkout: clear tracked sparse dirs
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 19, 2021 at 1:48 AM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi Stolee,
>
> On Tue, 17 Aug 2021, Derrick Stolee via GitGitGadget wrote:
>
> > From: Derrick Stolee <dstolee@microsoft.com>
> >
> > When changing the scope of a sparse-checkout using cone mode, we might
> > have some tracked directories go out of scope. The current logic removes
> > the tracked files from within those directories, but leaves the ignored
> > files within those directories. This is a bit unexpected to users who
> > have given input to Git saying they don't need those directories
> > anymore.
> >
> > This is something that is new to the cone mode pattern type: the user
> > has explicitly said "I want these directories and _not_ those
> > directories." The typical sparse-checkout patterns more generally apply
> > to "I want files with with these patterns" so it is natural to leave
> > ignored files as they are. This focus on directories in cone mode
> > provides us an opportunity to change the behavior.
> >
> > Leaving these ignored files in the sparse directories makes it
> > impossible to gain performance benefits in the sparse index. When we
> > track into these directories, we need to know if the files are ignored
> > or not, which might depend on the _tracked_ .gitignore file(s) within
> > the sparse directory. This depends on the indexed version of the file,
> > so the sparse directory must be expanded.
> >
> > By deleting the sparse directories when changing scope (or running 'git
> > sparse-checkout reapply') we regain these performance benefits as if the
> > repository was in a clean state.
> >
> > Since these ignored files are frequently build output or helper files
> > from IDEs, the users should not need the files now that the tracked
> > files are removed. If the tracked files reappear, then they will have
> > newer timestamps than the build artifacts, so the artifacts will need to
> > be regenerated anyway.
> >
> > Use the sparse-index as a data structure in order to find the sparse
> > directories that can be safely deleted. Re-expand the index to a full
> > one if it was full before.
>
> This description makes sense, and is easy to explain.
>
> It does not cover the case where untracked files are found and the
> directory is _not_ removed as a consequence, though. I would like to ask
> to add this to the commit message, because it is kind of important.
>
> The implementation of this behavior looks fine to me.
>
> About this behavior itself: in my experience, the more tricky a feature is
> to explain, the more likely the design should have been adjusted in the
> first place. And I find myself struggling a little bit to explain what
> files `git switch` touches in cone mode in addition to tracked files.

I share this concern.

> So I wonder whether an easier-to-explain behavior would be the following:
> ignored files in directories that fell out of the sparse-checkout cone are
> deleted. (Even if there are untracked, unignored files in the same
> directory tree.)
>
> This is different than what this patch implements: we would now have to
> delete the ignored and out-of-cone files _also_ when there are untracked
> files in the same directory, i.e. we could no longer use the sweet
> `remove_dir_recursively()` call. Therefore, the implementation of what I
> suggested would be much more complicated: you would have to enumerate the
> ignored files and remove them individually.

The ignored files are already enumerated by the fill_directory call;
you just need to iterate over the dir->ignored_nr entries in
dir->ignored.

> Having said that, even after mulling over this behavior and sleeping over
> it, I am unsure what the best way forward would be. Just because it is
> easy to explain does not make it right.
>
> It is tricky to decide mostly because "ignored" files are definitely not
> always build output. Apart from VIM's temporary files, users like me
> frequently write other files and/or directories that we simply do not want
> to see tracked in Git. For example, I often test things in an `a1.c` file
> that -- for convenience -- lives in the current worktree. Obviously I
> don't want Git to track it, but I also don't want it to be deleted, so I
> often add corresponding lines to `.git/info/exclude`. Likewise, I
> sometimes download additional information related to what I am
> implementing, and that also lives in the current worktree (but then, I
> usually am too lazy to add an entry to `.git/info/exclude` in those
> cases).

I do the same thing, and I know other users that do as well...but I
don't put such files in directories that are irrelevant to me.  I
create cruft files near other files that I'm working on, or in a
special directory of its own, but not under some directory that is
irrelevant to the areas I'm working on.

For reference, we implemented something like this in our `sparsify`
wrapper we have internally, where 'git clean -fdX <all sparse
directories>` is executed whenever folks sparsify.  (We have our own
tool and don't have users use sparse-checkout directly, because our
tool computes dependencies to determine which directories are needed.)
 I was really hesitant to add that cleaning behavior by default, and
just made it an option.  My colleagues tired of all the bug reports
about left-around directories and made it the default, waiting to hear
complaints.  We never got one.  It's been over a year.

> Now, I don't want to over-index on my own habits. There are so many users
> out there, and most of them have different preferences from mine.
>
> Which leaves me to wonder whether we need at least a flag to turn this
> behavior on and off? Something like
> `core.ignoredFilesInSparseConesArePrecious = true` (obviously with a
> better, shorter name).

That seems fine, but I suspect you're projecting the same concerns I
had, and it turns out much less useful than you'd expect (perhaps even
totally useless).
