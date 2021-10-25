Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83CFAC433F5
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 20:16:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6784C60230
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 20:16:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232764AbhJYUSc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Oct 2021 16:18:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237657AbhJYUSO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Oct 2021 16:18:14 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5E9BC098004
        for <git@vger.kernel.org>; Mon, 25 Oct 2021 12:47:56 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id v193so5116227pfc.4
        for <git@vger.kernel.org>; Mon, 25 Oct 2021 12:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QdUV8k1CTQnQe6tUhsyYlED9QURYNq/cwXJq1DrFacA=;
        b=ltauQXSskIfVY+WMx+UnDs2H/E3MB75RF9I7CPHbL36iOdQYWJ0rhQ2pZqz/H7uSb5
         2bIw09oR0N6VqxHiugEl6omOWwJKjfoIUKmNp1eKoKT2WopLTwAISEDpKt5oeIvnYqa1
         vgdHuDteXGUKIr/cv5LKH2ukxs+iyW8yk5LU24f/H3e7od9PZobcXuZ1uHj3AQxfdhVN
         NcmRsGdtPJwNOnJfuRAhL1ZkAYZL2HUbVisddLfZi7ZM3a7WCRxF7OUUQQSzAuhwNCJW
         6+dXtXLgI5zLCwlE5S1vKaeMbeP7+mHAeCJkYIniEWnzb6deLEvLuLscDexviu0hyloV
         n4CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QdUV8k1CTQnQe6tUhsyYlED9QURYNq/cwXJq1DrFacA=;
        b=IpwB13VH1oMr+ftWdRnlXfopmP6D0YBj8B+NvPneu2IeHYIfdV19nshwZfRf6H/2CJ
         Y+B/KeDhktmGTeInuR3aPuOoJPnTd7gSU0EC/QcW+nhTi9uSY+NlaInEDDGPrYUu9nsf
         Q8HsTT2egUmDO0jiR0frjrOGkO3qEj0aO/ASshhlAq4gzEYYF9iAlOULEtZWZHcipmOn
         23OqFVdB18e4nz8PvnZQ+dF4UJbSyFh+l7m3v12c+6CzpHP8m4dV8VO02BdtIdgCEfMR
         AYkPMus7CAm2/6dGMvLgNB9FTMgtap7LffdREOMpjCTAn7CFSE5M4KWg0r93hm5iizlm
         4DEA==
X-Gm-Message-State: AOAM532IPljGqMe4s5cZgHZiuUaeQtbwHhiQxUM5PNQWoFyyoLqe22Am
        Q/8ax1Q2nHg/UDec5BmGDIGKtXuW8mFSJrk889IlZJsM9cY=
X-Google-Smtp-Source: ABdhPJxO0S0EQ/zJAReiM7+ZyhdgC1ifpRKxHGYpMKBkn5cttgVRty/RkKqWkRn1rIpRgTeCDdQi8NZGL6b9NoIVdIY=
X-Received: by 2002:a63:7881:: with SMTP id t123mr14962624pgc.150.1635191276199;
 Mon, 25 Oct 2021 12:47:56 -0700 (PDT)
MIME-Version: 1.0
References: <CACYzLDcFjwaJkgVUemD_KqkoGhV_5OYrECddDuxa-o5FpZ6XMA@mail.gmail.com>
 <CACYzLDcO4OATYYZ6AtJnJTKS9EKUKNRJY5_Rb=y62gWFFwoDhg@mail.gmail.com> <47c45a9e-649d-89cc-3d7e-3dcea54bccb5@gmail.com>
In-Reply-To: <47c45a9e-649d-89cc-3d7e-3dcea54bccb5@gmail.com>
From:   Timothy Eccleston <timothy.perisho.eccleston@gmail.com>
Date:   Mon, 25 Oct 2021 12:47:45 -0700
Message-ID: <CACYzLDdx5Nd6PotGp7oNOzkD2qVriu=U1mXMG80yxO9x2+rz2w@mail.gmail.com>
Subject: Re: Unified workflow for `git add/checkout --patch`?
To:     phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,
Thanks for taking an interest!

In the workflow I'm describing, I don't add any arguments - i.e. the
defaults work for me. But, I see your point about the mismatch between
INDEX and HEAD. However, it looks like `git checkout -p` already uses
INDEX as its default when you add the `--patch` argument:
https://git-scm.com/docs/git-checkout#Documentation/git-checkout.txt--p.*

Essentially, I'm sifting through the diffs between workspace and INDEX
and deciding for each whether to:
- leave it for later (just lying around in the workspace, or perhaps
even `git stash`ed away)
- add it to the INDEX,
- undo it entirely,
- edit it (add part and then leave or undo the rest).

I was going to suggest that we just add a second layer of "directing"
hotkeys for "add", "checkout", "leave", and "stash" to pair with the
ones (below) that already exist in the `git add -p` command:
```
Stage this hunk [y,n,q,a,d,j,J,g,/,e,?]? ?
y - stage this hunk
n - do not stage this hunk
q - quit; do not stage this hunk or any of the remaining ones
a - stage this hunk and all later hunks in the file
d - do not stage this hunk or any of the later hunks in the file
g - select a hunk to go to
/ - search for a hunk matching the given regex
j - leave this hunk undecided, see next undecided hunk
J - leave this hunk undecided, see next hunk
e - manually edit the current hunk
? - print help
```

So, you'd chain 2 single letter commands, like "sa" to stash ("s") all
"a" the hunks in this file, but my new "directing" hotkeys aren't
quite orthogonal to the existing hotkeys. For example, "n" and "j" are
both sort of like "leave". I'm guessing we'd have to create a whole
new set of commands.

Best,
Tim

P.S. *Concerning the git checkout defaults. I also assumed that the
plain git checkout command targets HEAD, but in the docs, all I can
find are side effects for the HEAD pointer when the command is run. It
looks like with no arguments it targets the current branch, but that's
a noop, since you're already on that branch. I feel like I'm missing
something still, but it also doesn't appear relevant to this "patch"
workflow anyway.

On Mon, Oct 25, 2021 at 3:08 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
>
> Hi Tim
>
> On 21/10/2021 23:19, Timothy Eccleston wrote:
> > Hi,
> > I really like both these features:
> > - git add -p
> > - git checkout -p
> >
> > My typical workflow
> > I like to use them after a long and complex coding sessions where I
> > want to double-check my work, making edits and adding sets of patches
> > into sequential commits to keep related changes together topically.
> >
> > In the process of using git add -p to grab some patches, I may notice
> > other patches I don't want (especially after I've used the "e" command
> > in `git add -p` to edit a patch - I usually want to drop the
> > remaining, unstaged version of the patch right then). But, instead, I
> > have to go through git add -p and then git checkout -p and likely back
> > and forth several times, each time skipping through all the same
> > undecided or postponed patches I am waiting on for later.
> >
> > Note: I recently discovered the "j" and "J" subcommands which are
> > useful to postpone decisions on certain patches, but only if I
> > restrict myself to just git add or git checkout. If I want to do both,
> > I still have to cycle back through from the top each time. I suppose I
> > could use stash -p to really hide patches I'm saving for later, but I
> > still have to exit my workflow and start another command, requiring
> > multiple passes. OTOH, a unified git add/checkout/stash --patch would
> > be amazing!
> >
> > My request
> > It would be really nice if there were a unified command workflow where
> > I could add or checkout patches or even partial patches (after editing
> > a patch in git add), on a case by case basis in a single pass.
>
> I think I kind of see what you want but I'm a bit confused as how it
> could be implemented. To clarify do you want to checkout the index to
> discard the changes in the worktree or checkout HEAD (the later would be
> difficult as 'add -p' shows the differences between the index and the
> worktree)? Have you any thoughts on how the user would select whether to
> add a change to the index or discard it from the worktree? It gets a bit
> tricky if you want to stage an edited version of a hunk and discard the
> unstaged portion from the worktree but I guess we could apply the
> reverse of the original hunk to discard all the changes and then apply
> the staged version of the hunk to get just the changes the user wants. I
> think the main challenge would be with the user interface.
>
> Best Wishes
>
> Phillip
>
> > Does anyone know a way to do this or do you think it's worth making a
> > new feature in git to handle it?
> >
> > Thanks!
> > Tim
> >
>
