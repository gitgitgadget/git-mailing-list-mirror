Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B837EC432BE
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 20:15:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92E9361053
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 20:15:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240578AbhHaUQE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Aug 2021 16:16:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbhHaUQD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Aug 2021 16:16:03 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07885C061575
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 13:15:07 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id u25so763138oiv.5
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 13:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SUM6e/i4v2PFuGpwooxzMMNBox9VTyAQzQhc4fsvi20=;
        b=oSA9jUj+SfSKZwjPwNpnIT4qwWcDpsXMuUbYI2I1aBivQkjppLTcwqotxPEVssK0w4
         H/OC4yiMvX9YFu4HGwAJvuPSKw4N3EwyQHgdxqT4Vu0wPwmrYV9vymHtRmn4iZ8vvI+3
         9UHXfpuBc9vlHKBLZCTDVoGfJSyNdjCs63PDZ7bMh+Xj4d/e8K2rQrLwHYEuAHPHXXVJ
         YqpsLVV829Uyd+rRCBmf5usCB+VNjHKPNZemzM7Ugj4dIzeZVxO95Y7DKqZ5jfaBeE+/
         1PazEw/r1xqgFWYXHzz4/aRJOVLFG8MCRe07hYA09dWUvNKZg8klqC7sgJwqZqGId+ab
         Kzyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SUM6e/i4v2PFuGpwooxzMMNBox9VTyAQzQhc4fsvi20=;
        b=AHpVZt2c7HYnRG/QN9nLAA1uArKRheDQPvF3bvoOB27shz7NtB1lcOvba+I+9ADuv8
         nhQ4xODHtCaKDOOq+3M7E40XsQGivoRJdpkO5RV1och7TTKmMZshqHhb8vch/dwliZ+T
         6wQFRQLBtNpr5npEo0fVUG6dG+JRF0s7xhbE4Q9h6m8lFIzseQQcw1cdpwkXNLvj8yi7
         oamkn3bPpfG1iXsLAynu6fOk5rwZbxjog8pjJM6WdgEu4HsocG0VwykGPpbdopm7+gN3
         ZVMMry4iShgxufbrpNJvlUkesuIyOBmwaPulReTUFIdzPeXo1D6s9X9e00sEvCSCwXpP
         TPDw==
X-Gm-Message-State: AOAM531HhZUFnYv+tOSFNO7iIhkas+iT6A+n61NumxkmdVN6ax2rJxsD
        Y/Qt8lKG9F9TeCbMxzlcHqidwkbKxxDZuR+JJUs=
X-Google-Smtp-Source: ABdhPJz7lBHVHTBD70s0DfYyRJJRiAbC9t/r2Tsqaiy7MM4OD3sZRIPstVUsn7x5YGD8G/f6uvrOHIihMWHmBtgtmx0=
X-Received: by 2002:aca:bfc6:: with SMTP id p189mr4494847oif.167.1630440906364;
 Tue, 31 Aug 2021 13:15:06 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1083.git.git.1630379030665.gitgitgadget@gmail.com> <YS3Tv7UfNkF+adry@coredump.intra.peff.net>
In-Reply-To: <YS3Tv7UfNkF+adry@coredump.intra.peff.net>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 31 Aug 2021 13:14:55 -0700
Message-ID: <CABPp-BFmU+RaAjq4_0-PSfRgH1Jc63nN0fMuDWk2+iDbdz7CCA@mail.gmail.com>
Subject: Re: [PATCH] rebase, cherry-pick, revert: only run from toplevel
To:     Jeff King <peff@peff.net>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 31, 2021 at 12:01 AM Jeff King <peff@peff.net> wrote:
>
> On Tue, Aug 31, 2021 at 03:03:50AM +0000, Elijah Newren via GitGitGadget wrote:
>
> > From: Elijah Newren <newren@gmail.com>
> >
> > Allowing rebase, cherry-pick and revert to run from subdirectories
> > inevitably leads to eventual user confusion.  For example, if they
> > are within a directory that was created by one of the patches being
> > rebased, then the rebase operation could hit a conflict before the
> > directory is restored leading the user to be running from a directory
> > that no longer exists.  Similarly with cherry-pick and revert, those
> > operations could result in the directory being removed.
> >
> > Similar to bisect, simply require that these commands be run from the
> > toplevel to avoid such problems.
>
> IMHO this is too draconian. You are occasionally helping people who are
> in a directory which goes away over the course of the operation. But you
> are hurting everyone who _isn't_ in that situation, and who needlessly
> has to re-issue their command after doing a "cd".
>
> I think we'd be much better served to do even a rudimentary analysis of
> whether the operation will be a problem. E.g., if we taught the checkout
> code to error out when the cwd is going to disappear, then:
>
>   - we'd protect the user from confusion during regular sight-seeing via
>     "git checkout v0.99" and so forth
>
>   - we'd protect the most common cases for git-rebase (your patches
>     introduce "subdir/", but it is not yet in the parent directory). We
>     wouldn't preemptively avoid a rebase where subdir/ disappears and
>     then reappears in the middle of the series. We could find such a
>     case by iterating over the patches, but IMHO it's not worth the
>     computation.
>
>   - we could likewise protect git-bisect, making it more reasonable to
>     loosen its current restriction
>
>   - we might want to teach similar logic to sequencer operations, so
>     that applying a patch would likewise error-out. That would protect
>     cherry-pick and revert, but also make the "subdir/ disappears
>     mid-patch-series" case pretty nice: the specific patch that deletes
>     it would fail to apply, and then you could "cd .. && git rebase
>     --continue".
>
>     I suspect that the "oops, we're going to delete cwd" code would end
>     up in unpack-trees anyway, which means that both checkout and all of
>     this sequencer operations would use the same code.

Well, sequencer uses the merge machinery, and merge-ort creates a
toplevel merge tree that includes conflict markers in files and
whatnot, and then only updates the working tree via checkout().  So,
yeah, it really should be the same codepath.

> Now I have spent zero time looking into actually coding this, so it may
> turn out to be much trickier than I am suggesting. But this seems like a
> much more fruitful direction, where we can protect users in cases where
> they benefit (and give them sensible and actionable error messages),
> without bothering people in the majority of cases where their cwd
> doesn't go away.

Ooh, this sounds intriguing to me...but what if we changed that rule
slightly and just decided to never make the cwd go away?  Currently,
the checkout code removes directories if they have no tracked or
untracked or ignored files left, i.e. if they're empty.  What if we
decide to only have remove_scheduled_dirs() remove directories that
are empty AND they are not the current working directory?

Granted, that could leave a directory in the way of files from other
revisions, but the same was already true in the analogous situation
where there were leftover untracked files in some directory.  Since
all our code paths already have to handle directories leftover due to
untracked files, perhaps avoiding removing the current working
directory would just automatically work for us?  (I think it'd handle
all of checkout, bisect, rebase, cherry-pick, revert, and merge.)
