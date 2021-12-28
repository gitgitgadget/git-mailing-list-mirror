Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66055C433EF
	for <git@archiver.kernel.org>; Tue, 28 Dec 2021 18:16:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236947AbhL1SQu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Dec 2021 13:16:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233411AbhL1SQu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Dec 2021 13:16:50 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 079B2C061574
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 10:16:50 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id m21so78093891edc.0
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 10:16:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SInADg8J7e69PXuE5F5+5CB1P9AH0qVMp+vee4/4FLo=;
        b=CnqJA7HSq4OSFBHDDAdrlwqRDcF5xNqIdfY0wXzws3gCycvnlS8SCzpvQeQ9P6VyCT
         3JWYUQXuY9jBq1M12idUia01fTobg87yvocITpbbVQXZmkEMbR7cHXVjKnTgfwWntUI5
         KhGMCNYwhjXgLoVhT1Nyj33Jj11X1W9U3i5as7bP7Y703jJ3ejQQB0s5uES0UtgEY4/l
         U01dUxC4AhBK73ylzIdNgwzjn+jx/BOGnnALhEW+dEoaWlwjNRKL+FbRaIb7QIq69l4t
         icvSPX+OSeJrYBo3oE14JVHtr7MqbDBwMijKlA2Aq0XWtQ4dqZQrKrs9m5c28IwWzDEl
         m+MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SInADg8J7e69PXuE5F5+5CB1P9AH0qVMp+vee4/4FLo=;
        b=xD1EFg0MAh5qGIOJO+oMSu0XPSNCIrPxdGi1b2vc8azJUkfFUAaHIIuQAAaNj3cjc0
         PMf/IkXJiWXbaL07OgUtaY+ICGHoXM5aDYX6eXJZo9gqn5MHN23M+CyprcLqM/zoXYFK
         CYzBO1NdSaLg9CUDl3PNnxFtrZf6jD+kdrZrNw1hAR8leN3m87VTfMhySLvBbfda9gb8
         FsHvx3aIJ6l18AUy4TLbfUrxI/s9LO3dKZjc7rxVsGQvZwNsjWYvNijlUFcwuCOUqA1d
         5lewqwB7FgxxAig8j94X7MUxyOFlqQtgkM2QXVCLpSY4H1Eh0sKntAD069uy2QIdad43
         I26w==
X-Gm-Message-State: AOAM533YeSavzQLU9Eu/6qekMzlAHAvJxp6d+Wb2yt4gm46SVSrogHcZ
        XgCaNI3eXVW/1IEf2U70eqerV7DUVOgdGLq7zWI=
X-Google-Smtp-Source: ABdhPJzRcTeDzufqzNr+CZBG8goVglealJr5hFuEnolfkW+B60fN2MLgBHhAwvOQFq5a86qG81sm88OyHFA2QwEJgCk=
X-Received: by 2002:a17:907:968a:: with SMTP id hd10mr17810204ejc.269.1640715408494;
 Tue, 28 Dec 2021 10:16:48 -0800 (PST)
MIME-Version: 1.0
References: <pull.1101.git.1640015844.gitgitgadget@gmail.com>
 <pull.1101.v2.git.1640114048.gitgitgadget@gmail.com> <CABPp-BG7nwsdEYrnfqhAbWU4ndJHcqGf6RS_6DzJittuNVLvoA@mail.gmail.com>
 <CAPig+cRDDGU=9BB6kd1tMJR8DmWKSSJwpTD8JeszrY685Fc3-Q@mail.gmail.com>
 <CABPp-BFxz5B_wUubzaYeGEaztALqDMxxVTrcT4d1kKjpX8pRDQ@mail.gmail.com> <CAPig+cRYKKGA1af4hV0fz_nZWNG=zMgAziuAimDxWTz6L8u3Tg@mail.gmail.com>
In-Reply-To: <CAPig+cRYKKGA1af4hV0fz_nZWNG=zMgAziuAimDxWTz6L8u3Tg@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 28 Dec 2021 10:16:37 -0800
Message-ID: <CABPp-BGKyDJV9DP+igmCC_Ad0jgvb4aOAYpXWCbx9hW8ShhDQg@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] Sparse checkout: fix bug with worktree of bare repo
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Sean Allred <allred.sean@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 27, 2021 at 11:33 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> On Mon, Dec 27, 2021 at 2:35 PM Elijah Newren <newren@gmail.com> wrote:
> > On Sun, Dec 26, 2021 at 11:15 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
> > > Your example indeed leads to a broken state because it doesn't follow
> > > the instructions given by git-worktree.txt for enabling
> > > `extensions.worktreeConfig`, which involves additional bookkeeping
> > > operations beyond merely setting that config variable.
> >
> > These are instructions which neither Stolee nor I was aware of prior
> > to your pointing it out.  [...]
> > I'd suspect that Stolee and I are actually _more_ likely to be aware
> > of relevant documentation than the average Git user, so if we missed
> > it, I suspect many of them will. [...]
>
> I wasn't originally aware of the bookkeeping instructions either. In
> fact, for a good while, I wasn't even aware that Duy had implemented
> per-worktree configuration or that there was such a thing. I either
> must have been entirely off-list during the implementation or was not
> in a position to follow changes to the project at the time. I only
> became aware of per-worktree configuration at some point in the last
> two or three years when someone asked some question on the list
> related to the feature and I ended up diving into the documentation,
> the source code, and the patches themselves in order to understand it
> fully -- because I think I didn't understand it merely from reading
> the documentation which is rather sparse (no pun intended). And I had
> forgotten enough about it since then that I had to re-research it when
> Sean raised the issue on the list a few days back in relation to
> sparse-checkout.
>
> > So, I don't think relying on folks to read this particular piece of
> > documentation is a reliable course of action...at least not without
> > some changes to make it much more likely to be noticed.
>
> The sparsity of documentation about per-worktree configuration
> certainly doesn't help, nor the fact that it's fairly near the end of
> git-worktree.txt, at which point people may have given up reading. We
> could make it a bit more prominent by mentioning it early in the
> command description, but it still involves enough fiddly bookkeeping
> that it likely will continue to be problematic.

Further, it's not clear people even looked at git-worktree.txt at the
time they learned about extensions.worktreeConfig.  I believe I
discovered and started using extensions.worktreeConfig from `git
config --help`, which makes no mention of or even reference to the
need for any extra steps.  (I didn't see the original mailing list
discussions around that setting either.)  It never occurred to me in
the ~3 years since to even look in `git worktree --help` for
additional guidance around that config setting until this particular
mailing list thread.

> Making per-worktree configuration the default does seem like the best
> long-term solution. Doing so should make all these problems go away. I
> don't know what Duy's plans were, nor whether he had some migration
> strategy planned.
>
> > > I vaguely recall some mention of this not long ago on the list but
> > > didn't follow the discussion at all. Do you have pointers or a
> > > summary?
> >
> > For the microsoft repositories, sparse-checkouts are needed because a
> > full checkout is unmanageable (millions of files to check out
> > otherwise).  For other repositories, full checkouts might technically
> > be manageable, but are annoyingly slow and users may only want to work
> > with sparse checkouts (and for some of these, due to various
> > mono-repoization efforts, the repository is growing towards a size
> > where manageability of full checkouts is decreasing).
> >
> > The fact that `git worktree add` does a full checkout is quite
> > painful...possibility to the point of making worktrees useless for
> > some users.  I think `git worktree add` should copy the sparsity of
> > the worktree from which it was invoked.
>
> Okay, I do recall reading a message in which you proposed this, though
> I didn't understand the reasoning for the suggestion since I wasn't
> following the discussion. The explanation you provide here makes the
> proposal understandable.
>
> >   * using --no-checkout as a proxy: This means no files checked out
> > and no index file.  The lack of an index file makes it appear that
> > everything was manually deleted (with the deletion staged).  Also, if
> > the project is using some kind of <sparsity-wrapper-script> (e.g. for
> > determining dependencies between directories so that appropriate
> > 'modules' can be specified and transformed into a list of directories
> > passed to sparse-checkout), then the sparsity-wrapper-script isn't
> > available to them to invoke.  If users try to check out just the
> > wrapper file, then an index will be created and have just one entry
> > and we kind of cement the fact that all other files look like they
> > were intended to be deleted.  Also, even if the user runs `git
> > sparse-checkout init --cone`, you don't actually don't transform this
> > no-checkout into a sparse checkout because sparse-checkout doesn't
> > want to undo your staged deletions.  Despite the fact that I'm very
> > familiar with all the implementation internals, it was not obvious to
> > me all the necessary additional commands needed for users to get a
> > sparse checkout while making use of --no-checkout.  Users stand little
> > chance of figuring the necessary command invocations out without a
> > huge amount of effort (and they've given up and come to me before
> > asking for help, and my first response turned out to be incomplete in
> > various cases...).
>
> You've clearly put much more thought into this than I have (since I
> only just read this), so I'm not likely to have any meaningful input,
> but I'll write down a few thoughts/questions which popped into my head
> while reading what you wrote. Perhaps they've already been discussed
> elsewhere, so feel free to ignore (and they may not be worth
> responding to anyhow).
>
> When you say "copy the sparsity of the worktree from which it was
> invoked", do you mean that literally, such that it special-cases it
> and only copies sparse-checkout information? An alternative would be
> to allow the user to specify -- via the shared configuration
> (.git/config) -- exactly which config keys get inherited/copied over
> by `git worktree add`. Such a solution would avoid special-casing
> sparse-checkout and could be useful in the future for other commands
> which might need such functionality, though this approach may be
> overengineered.
>
> A more general approach might be for the new worktree to copy all the
> per-worktree configuration from the worktree in which the command was
> invoked, thus sparsity would be inherited "for free" along with other
> settings. This has the benefits of not requiring sparse-checkout
> special-cases in the code and it's easy to document ("the new worktree
> inherits/copies configuration settings from the worktree in which `git
> worktree add` was invoked") and easy to understand.

Ooh, this is a good point and I *really* like this simple solution.
Thanks for pointing it out.

Do note, though, that it's more than just config.worktree -- I also
want the ${GITDIR}/info/sparse-checkout file copied.

> I also wondered if adding some sort of `--sparse-checkout=...` option
> to `git worktree add` would solve this particular dilemma, thus
> allowing the user to configure custom sparse-checkout for the worktree
> as it is being created. I also very briefly wondered if this should
> instead be a feature of the `git sparse-checkout` command itself, such
> as `git sparse-checkout add-worktree`, but I think that's probably a
> dead-end in terms of user discoverability, whereas `git worktree add
> --sparse-checkout=...` is more easily discoverable for people wanting
> to work with worktrees.

This might be a useful extra capability (we'd probably want to keep
this flag in sync with git-clone's --sparse flag and whatever
capabilities grow there), but I don't see it as a solution to this
problem.  I think the default needs to be copying the existing
sparsity.  Making users specify cone/non-cone mode and
sparse-index/non-sparse-index and and several dozen directories by
hand just doesn't sound reasonable to me.  (We have a case with
several hundred directories/modules, with various dependencies between
them.  Users can use a wrapper, `./sparsify --modules $MODULE_A
$MODULE_B` which figures out the several dozen relevant directories
and calls sparse-checkout set with those, but of course that wrapper
won't yet be available in the new worktree until after the new
worktree has been added.)

An alternative that would be workable, though annoying, is giving the
user a super-sparse checkout with only files in the toplevel directory
present (i.e. what you'd get after `git sparse-checkout init --cone`
or `git clone --sparse ...`), and then making them use the normal
tools to manually specify the wanted sparsity (which probably requires
switching back to the previous worktree to run some info commands to
determine exactly what the sparsity was).

An increasingly unworkable alternative is the current behavior of
defaulting to a full checkout in all cases (and forcing users to
sparsify afterwards).  A full checkout is fine if the user came from
one (and probably preferable in such a case), but it's increasingly
problematic for us even with our repo being nowhere near the size of
the microsoft repos.
