Return-Path: <SRS0=RPsp=7C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33417C433DF
	for <git@archiver.kernel.org>; Wed, 20 May 2020 17:52:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0849E206B6
	for <git@archiver.kernel.org>; Wed, 20 May 2020 17:52:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H1MkifCr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726806AbgETRwy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 May 2020 13:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbgETRwx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 May 2020 13:52:53 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDFF9C061A0E
        for <git@vger.kernel.org>; Wed, 20 May 2020 10:52:53 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id b18so3224519oti.1
        for <git@vger.kernel.org>; Wed, 20 May 2020 10:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k1V5Zzf0k2sP+jw6Y6B0tv7LB07T4uEkwCIiTXIl70w=;
        b=H1MkifCrJIxYGD/WCxeDhlFKUJLKo6CoJLh0qi6gewxmaXH6hjv0cz0o6KiC/3D3SF
         d3nAvQM9QLqBz0q8csduCfiAG/dhd6cLPzStEPj6U+/Cyf9pXkpYBokE6p3jthZq6usa
         IREUCqK7dnq+aoR9gd20hdFshBMKEbQzI+aX5LL6i/klq4j90CuWG8QN2ABoO4hRLLAm
         IFALeuzkreS5WbZi79FcYsYUVIpMs0u9tbKpyHgzvR2BB29f9gCh391ZXdO0mzOMBDsr
         3JXmtrVE7QBNWNbEfkyCSPuWKaHxdnwt4fD2ng1QzdD/As5WuGAvOzJRKiPWW8DR2D2Y
         SZwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k1V5Zzf0k2sP+jw6Y6B0tv7LB07T4uEkwCIiTXIl70w=;
        b=j4Uklb+yspufoAkip22707tyT2A4Ul/xli5alPV+egAEcD5WlSxC9aySzjr3ZSU9Hw
         x93DbhrJHP2LKMrmvRyNXKWuINrHQR04/uIGwaxrXmSU22JDvtwG/xjzeiO4kpNXNxQm
         XCyZt/75RxD57fXyrw0/dyJJoJ+Jy95hbgaZwGXkmE/La08RGY+34GChUbsWTZj7Kgm9
         AtYDTP5lGsOhRIWwoXG9fCLtDF6fWy+46k2IR19C1kabiLYnH7TS9pKpeOlDZdt8+dB2
         Rk7hN19vqSbkRTpflYVArD1TnF6ULPk3bB4P8QN46+SKO+UdC/DOwfmRI0VDT6HP+7/y
         0mww==
X-Gm-Message-State: AOAM531KdbRy/SyZLU21PsqL/BqzVaKXMa+aTJMHa57eQKFe4zDblKkB
        4iDhxtf7pqi8aMGtJXmPJRXh9q9XcdJbLEcTEm8=
X-Google-Smtp-Source: ABdhPJykmfB0VYws8kEQThgsJncMsY/gxhoI4RjtZ6fXQ9g96x7nYA2bjpxvcG35RRLq5bwHHtTxgKlVM/XtefqhwbE=
X-Received: by 2002:a9d:24e5:: with SMTP id z92mr4170353ota.345.1589997172924;
 Wed, 20 May 2020 10:52:52 -0700 (PDT)
MIME-Version: 1.0
References: <pull.627.git.1588857462.gitgitgadget@gmail.com>
 <2188577cd848d7cee77f06f1ad2b181864e5e36d.1588857462.git.gitgitgadget@gmail.com>
 <xmqqeerv2w01.fsf@gitster.c.googlers.com> <6d354901-9361-d8d1-539d-3b6c3edb2d9f@gmail.com>
In-Reply-To: <6d354901-9361-d8d1-539d-3b6c3edb2d9f@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 20 May 2020 10:52:41 -0700
Message-ID: <CABPp-BH5p1VPXfMOyN_0SLnsFKkRU9R-ZpiAe4k5r=ZUbHeibQ@mail.gmail.com>
Subject: Re: [PATCH 04/10] sparse-checkout: allow in-tree definitions
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>, newren@gmaill.com,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 8, 2020 at 8:42 AM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 5/7/2020 6:58 PM, Junio C Hamano wrote:
> > "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> >
> >> One of the difficulties of using the sparse-checkout feature is not
> >> knowing which directories are absolutely needed for working in a portion
> >> of the repository. Some of this can be documented in README files or
> >> included in a bootstrapping tool along with the repository. This is done
> >> in an ad-hoc way by every project that wants to use it.
> >>
> >> Let's make this process easier for users by creating a way to define a
> >> useful sparse-checkout definition inside the Git tree data. This has
> >> several benefits. In particular, the data is available to anyone who has
> >> a copy of the repository without needing a different data source.
> >> Second, the needs of the repository can change over time and Git can
> >> present a way to automatically update the working directory as these
> >> sparse-checkout definitions change over time.
> >
> > And two lines of development can merge them together?
> >
> > Any time a new "feature" pops up that would eventually affect how
> > "git clone" and "git checkout" work based on untrusted user data, we
> > need to make sure there is no negative security implications.
> >
> > If it only boils down to "we have files that can record list of
> > leading directory names and without offering extra 'flexibility'", I
> > guess there aren't all that much that a malicious sparse definition
> > can do and we would be safe, though.
>
> Yes. I hope that we can be extremely careful with this feature.
> The RFC status of this series implicitly includes the question
> "Should we do this at all?" I think the benefits outweigh the
> risks, but we can minimize those risks with very careful design
> and implementation.
>
> >> To use this feature, add the "--in-tree" option when setting or adding
> >> directories to the sparse-checkout definition. For example:
> >>
> >>   $ git sparse-checkout set --in-tree .sparse/base
> >>   $ git sparse-checkout add --in-tree .sparse/extra
> >>
> >> These commands add values to the multi-valued config setting
> >> "sparse.inTree". When updating the sparse-checkout definition, these
> >> values describe paths in the repository to find the sparse-checkout
> >> data. After the commands listed earlier, we expect to see the following
> >> in .git/config.worktree:
> >>
> >>      [sparse]
> >>              intree = .sparse/base
> >>              intree = .sparse/extra
> >
> > What does this say in human words?  "These two tracked files specify
> > which paths should be in the working tree"?  Spelling it out here
> > would help readers of this commit.
>
> You got it. Sounds good.
>
> >> When applying the sparse-checkout definitions from this config, the
> >> blobs at HEAD:.sparse/base and HEAD:.sparse/extra are loaded.
> >
> > OK, so end-user edit to the working tree copy or what is added to
> > the index does not count and only the committed version gets used.
> >
> > That makes it simple---I was wondering how we would operate when
> > merging a branch with different contents in the .sparse/* files
> > until the conflicts are resolved.
>
> It's worth testing this case so we can be sure what happens.

During a merge or rebase or checkout -m, what happens if .sparse/extra
has the following working tree content:

[sparse]
    dir = D
    dir = X
<<<<<< HEAD
    dir = Y
|||||| MERGE_BASE
======
    inherit = .sparse/tools
>>>>>>  MERGE_HEAD
    inherit = .sparse/base

and, of course, three different entries in the index?

Also, do we use the version of the --in-tree file from the latest
commit, from the index, or from the working tree?  (This is a question
not only for merge and rebase, but also checkout with dirty changes
and even checkout -m.)  Which one "wins"?

And what if the user updates and commits an ill-formed version of the
file -- is it equivalent to getting an empty cone with just the
toplevel directory, equivalent to getting a complete checkout of
everything, or something else?
