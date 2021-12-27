Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 753BAC433F5
	for <git@archiver.kernel.org>; Mon, 27 Dec 2021 19:35:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232406AbhL0TfR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Dec 2021 14:35:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232178AbhL0TfR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Dec 2021 14:35:17 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B39F8C06173E
        for <git@vger.kernel.org>; Mon, 27 Dec 2021 11:35:16 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id z29so65292712edl.7
        for <git@vger.kernel.org>; Mon, 27 Dec 2021 11:35:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=59iMiAd8zGCNbSGiR7hctrt7gNHyZmAdY+DkRdhihMI=;
        b=XiovSUnUs4omjJPz1OftsPDO3VFhKBKF2LwYAAt4xwc0UhNCCp5Le8LGp04tlWa/2e
         y6hDBulS3zSqHN7xfvGxe2JkqeORUnmYikk89MgzQzpuS2c5Jhb7tXoWdTGAiP9IH8g3
         8cwzx/9hUts6xnvJyQbSxcgL+w9TTXY7YGavjmcGQAiuFacfSjHpQ0PjLMMwGi4/ZasW
         Ds88niWIDpxtCEhIIG6uJPC88Hez7F0sixn2cw8YxrA2SgGyVg0lN8Tx4t6NLuXUGZkr
         PmZZeV49UOUTEcXw4Xt3KblLIy3bezqnPcvtF5ZJAnKnE3H7axE4lJXv6BueudNuwBEc
         Usjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=59iMiAd8zGCNbSGiR7hctrt7gNHyZmAdY+DkRdhihMI=;
        b=bPKAPgNqzv8h8QqayCjUoraFKXx0ohlO4wC2rBUMEUKgY3snK0/q42SqyMa+a1t5/r
         SeQWu35IgLzZ10MXm+HqoNrdOFtEdpp6o0w+BQmgVhyZE49pCOQtzZA78jeM9dr2ISPH
         Mi4WCEsAyQEX7Re7IVnGyHxnV7M74i9awhrFxL6Fvxz+PftWYkFL4pMFOQa9ryoMUdBX
         bGvPGXOtAnolbBgqsJzYtQUAAgWwbLg9cPzCKK7yND5XaAFgJCZBpuq1JF92zEG04lzP
         HA//gjA7FkYAxTrwCrbU/L4AdPiamfMD/NwRo8Xf8PuyaVmBbhhWc9BLQ7g8cXgvhhpW
         8wpg==
X-Gm-Message-State: AOAM533UBp9/Yp7QmuL8+f0XbntBOzMuV7aozpBEXDoRwLw+mqcQGuFg
        NN39BEc46CLrHT4IcGUURB6jBkaZHRlz3vQT2EI=
X-Google-Smtp-Source: ABdhPJwYxqY1mLFmcAaD/Vq7E5+ds59X8Gxe+4Jd3U6ZQ8xccf0OpF38AMnuhu9qAdZZ2g2ofiHSO9uIO2AKJaHlDIQ=
X-Received: by 2002:a17:907:968a:: with SMTP id hd10mr14509460ejc.269.1640633714983;
 Mon, 27 Dec 2021 11:35:14 -0800 (PST)
MIME-Version: 1.0
References: <pull.1101.git.1640015844.gitgitgadget@gmail.com>
 <pull.1101.v2.git.1640114048.gitgitgadget@gmail.com> <CABPp-BG7nwsdEYrnfqhAbWU4ndJHcqGf6RS_6DzJittuNVLvoA@mail.gmail.com>
 <CAPig+cRDDGU=9BB6kd1tMJR8DmWKSSJwpTD8JeszrY685Fc3-Q@mail.gmail.com>
In-Reply-To: <CAPig+cRDDGU=9BB6kd1tMJR8DmWKSSJwpTD8JeszrY685Fc3-Q@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 27 Dec 2021 11:35:03 -0800
Message-ID: <CABPp-BFxz5B_wUubzaYeGEaztALqDMxxVTrcT4d1kKjpX8pRDQ@mail.gmail.com>
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

On Sun, Dec 26, 2021 at 11:15 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> On Wed, Dec 22, 2021 at 5:54 PM Elijah Newren <newren@gmail.com> wrote:
> > On Wed, Dec 22, 2021 at 8:00 AM Derrick Stolee via GitGitGadget
> > <gitgitgadget@gmail.com> wrote:
> > > This patch series includes a fix to the bug reported by Sean Allred [1] and
> > > diagnosed by Eric Sunshine [2].
> >
> > This feels like a bandaid to me.  In addition to fixating on core.bare
> > (thus overlooking core.worktree), it also overlooks that people can
> > use worktrees without using sparse-checkout.  What if they do
> > something like:
> >
> >   git clone --bare $URL myrepo
> >   cd myrepo
> >   git worktree add foo
> >   git worktree add bar
> >   git worktree add baz
> >   ... days/weeks later ...
> >   cd foo
> >   git config extensions.worktreeConfig true
> >   git config status.showUntrackedFiles no  # Or other config options
> >   ... hours/days later ..
> >   cd ../bar
> >   git status
> >
> > At this point the user gets "fatal: this operation must be run in a
> > work tree".
>
> Your example indeed leads to a broken state because it doesn't follow
> the instructions given by git-worktree.txt for enabling
> `extensions.worktreeConfig`, which involves additional bookkeeping
> operations beyond merely setting that config variable.

These are instructions which neither Stolee nor I was aware of prior
to your pointing it out.  Not only had we often flipped that variable,
we did so for many of our users (I know I did for some time prior to
Stolee introducing sparse-checkout).  With `git sparse-checkout` we
propagated that to many more users, and now have many repositories out
in the wild that have been set up for _years_ in violation of these
instructions.  So, even if Stolee and I are independently particularly
bad about noticing the relevant documentation, we now have a situation
where people can discover this misconfiguration just by looking around
in their config.  Once they notice it, they may well copy it
elsewhere.

I'd suspect that Stolee and I are actually _more_ likely to be aware
of relevant documentation than the average Git user, so if we missed
it, I suspect many of them will.  Especially now that we've amplified
their opportunities for discovering repositories set up in
contravention to that documentation.

So, I don't think relying on folks to read this particular piece of
documentation is a reliable course of action...at least not without
some changes to make it much more likely to be noticed.

> It is exactly
> this sort of situation which prompted me to suggest several
> times[1,2,3] in the conversation following my diagnosis of the
> problem, as well as in my reviews of this series, that we may want to
> add a git-worktree subcommand which does all the necessary bookkeeping
> to enable `extensions.worktreeConfig` rather than expecting users to
> handle it all manually. In [1], I called this hypothetical command
> `git worktree manage --enable-worktree-config ` and in [4], I called
> it `git worktree config --enable-per-worktree` (not because I like
> either name, but because I couldn't think of anything better).

How would users discover this new command and use it?  Is it any more
reliably discoverable than the above documentation?

Your suggestion sounds to me like "We know this command will break
things, so we'll provide another command they can use to avoid the
breakage, and hope they notice this new command and use it."  I'm sure
that's not your intent, and perhaps there's a way of making this
suggestion robust, but to me it just sounds like it leads to
inevitable breakage.  I'd rather just fix the command that can break
things.

> > I think that "git
> > worktree add" should check if either core.bare is false or
> > core.worktree is set, and if so then set extensions.worktreeConfig and
> > migrate the relevant config.
>
> (I think you meant "...if either core.bare is _true_ or...".)

Yes, indeed.

> Similar to my response to Sean in [1] and to Stolee in [2], while this
> may help the situation for worktrees created _after_
> `extensions.worktreeConfig` is enabled, it does _not_ help existing
> worktrees at all. For this reason, in my opinion, `git worktree add`
> is simply not the correct place to be addressing this problem, and
> it's why I suggested a separate command for enabling the feature and
> doing all the necessary bookkeeping. It's also why I suggested[2] that
> in the long run, we may want per-worktree config to be the default
> (and only) behavior rather than the current (legacy) behavior of all
> config being shared between worktrees.
>
> Aside from that, I'm uncomfortable with the suggestion that `git
> worktree add` should be responsible for making these sort of dramatic
> changes (upgrading to version=1 and enabling
> `extensions.worktreeConfig`) to the repository automatically. That
> seems very much out of scope for what this command should be doing. On
> the other hand, I would have no problem with `git worktree add`
> protecting users by detecting whether `core.bare=true` or
> `core.worktree` is set in the shared .git/config file and aborting
> with an error if so, and giving a "HINT" telling the user to enable
> per-worktree config via the (hypothetical) `git worktree config
> --enable-per-worktree` command.
>
> Regarding your feeling that this patch series is a "band-aid", while I
> agree with you that we ultimately need a better approach, such as the
> hypothetical `git worktree config --enable-per-worktree` (or
> eventually making per-worktree config be the default), that better
> solution does not need to be implemented today, and certainly
> shouldn't derail _this_ patch series which is aimed at fixing a very
> real bug which exists presently in `git sparse-checkout init`. This
> patch series does need a good number of improvements and fixes before
> it is ready -- as indicated by my v2 review comments[4,5,6], the most
> obvious of which is its missing handling of `core.worktree` -- but I
> do think this series is headed in the correct direction by focusing on
> fixing the immediate problem with `git sparse-checkout init` (and
> paving the way for an eventual more complete solution, such as `git
> worktree config --enable-per-worktree `).

Looks like you've changed your opinion a bit and it'd be better for me
to respond to these parts in your follow-up email.

> [1]: https://lore.kernel.org/git/CAPig+cQ6U_yFw-X2OWrizB1rbCvc4bNxuSzKFzmoLNnm0GH8Eg@mail.gmail.com/
> [2]: https://lore.kernel.org/git/CAPig+cQPUe9REf+wgVNjyak_nk3V361h-48rTFgk6TGC7vJgOA@mail.gmail.com/
> [3]: https://lore.kernel.org/git/CAPig+cRombN-8g0t7Hs9qQypJoY41gK3+kvypH4D0G6EB4JgbQ@mail.gmail.com/
> [4]: https://lore.kernel.org/git/CAPig+cQrJ9yWjkc8VMu=uyx_qtrXdL3cNnxLVafoxOo6e-r9kw@mail.gmail.com/
> [5]: https://lore.kernel.org/git/CAPig+cRi2SA6+poaemY8XR5ZoMweuztfiENpcRVOCnukg3Qa7w@mail.gmail.com/
> [6]: https://lore.kernel.org/git/CAPig+cRuY40RNi4bC3CBfghLLqz74VUPRbaYJYEhmF78b0GfPQ@mail.gmail.com/#t
>
> > I also think `git worktree add` should handle additional configuration
> > items related to sparse checkouts (as we've discussed elsewhere in the
> > past), but that's going a bit outside the scope of this series; I only
> > mention it so that we're aware the functionality added to `git
> > worktree add` will be getting some additions in the future.
>
> I vaguely recall some mention of this not long ago on the list but
> didn't follow the discussion at all. Do you have pointers or a
> summary?

For the microsoft repositories, sparse-checkouts are needed because a
full checkout is unmanageable (millions of files to check out
otherwise).  For other repositories, full checkouts might technically
be manageable, but are annoyingly slow and users may only want to work
with sparse checkouts (and for some of these, due to various
mono-repoization efforts, the repository is growing towards a size
where manageability of full checkouts is decreasing).

The fact that `git worktree add` does a full checkout is quite
painful...possibility to the point of making worktrees useless for
some users.  I think `git worktree add` should copy the sparsity of
the worktree from which it was invoked.

Addressing potential questions/objections to this proposal:
  * just requiring users to do a full checkout first is very
unfriendly: the checkout might not even fit in available disk space,
and even if it does fit, this has the performance penalty of inflating
and writing all files to disk only to delete a (vast?) majority of
them immediately after.  Users have shown a willingness to swallow a
lot of pain trying to figure out how to avoid that performance
penalty.
  * full-checkout: If users do want a full checkout of the new
worktree despite running from a sparse-checkout, it's a single command
away (`git sparse-checkout disable` or `<sparsity-wrapper-script>
--undo`).  And in that case, the invoked commands don't do huge
amounts of unnecessary work.
  * using --no-checkout as a proxy: This means no files checked out
and no index file.  The lack of an index file makes it appear that
everything was manually deleted (with the deletion staged).  Also, if
the project is using some kind of <sparsity-wrapper-script> (e.g. for
determining dependencies between directories so that appropriate
'modules' can be specified and transformed into a list of directories
passed to sparse-checkout), then the sparsity-wrapper-script isn't
available to them to invoke.  If users try to check out just the
wrapper file, then an index will be created and have just one entry
and we kind of cement the fact that all other files look like they
were intended to be deleted.  Also, even if the user runs `git
sparse-checkout init --cone`, you don't actually don't transform this
no-checkout into a sparse checkout because sparse-checkout doesn't
want to undo your staged deletions.  Despite the fact that I'm very
familiar with all the implementation internals, it was not obvious to
me all the necessary additional commands needed for users to get a
sparse checkout while making use of --no-checkout.  Users stand little
chance of figuring the necessary command invocations out without a
huge amount of effort (and they've given up and come to me before
asking for help, and my first response turned out to be incomplete in
various cases...).
