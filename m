Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BB7DC433F5
	for <git@archiver.kernel.org>; Wed,  5 Oct 2022 04:53:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbiJEExn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Oct 2022 00:53:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiJEExk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Oct 2022 00:53:40 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BEBF58B4C
        for <git@vger.kernel.org>; Tue,  4 Oct 2022 21:53:39 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id n12so4595188wrp.10
        for <git@vger.kernel.org>; Tue, 04 Oct 2022 21:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=xlXwXkpvUVbdkMGEdmK8jbE7KpgZ6Uc+CgV4eQWp8/4=;
        b=OZ661spoZvFu+/WHLu0sOE0XZpBpaik0yftDTFX5QLlUg9naIFp7vyeEQ9mLmI0hBJ
         PRIkSofVxUD8oz8qtUkqKbUNuCK/3Nj635KsAIwnCLAzaAkgbHeYugEmTdFq9bHTzgvT
         OW4XLi8gY0SB/4noqtxeUKF5qtmGRFZnOxKM5YaMYslrWl8belW4FsZuPj9CeL45YBls
         OmlwiX/cjoUv63ZMriIIlz/XXVMcvU39oDbJPqYbYvts/QIeyNJy1CTcqcnbKzP0Kv3i
         hiZXJWa7x/zoWiyyLsQS3/ujDKjR+u290lw68Zk0dO2qWGQgHaFvyQ99SJciqUTQH65Z
         /b9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=xlXwXkpvUVbdkMGEdmK8jbE7KpgZ6Uc+CgV4eQWp8/4=;
        b=W27mEtQwZm3sclLKYVHLmkxWLXImlJxPa+5Palmd24nF8qJ/qDTOSPuoAFD9vvWjCa
         hwqJORhtg0p8GV1xZTbf4cTczQInW/FTWv5fbLAJqqpMzC2sDoClMbdXqspSQrIRaCwv
         NMTF2bXgfmaJU3N8Qi1AD38k6/ZD3AUR1lUWuL6/soMFM80yyYrGC3k3tq5DP2ZyPI+9
         +24P49dyv12EAv0GOJ9QZtwlOyo/gfaFfHonrZ5YxzzqCWU5xnmHBHtP+ClLHlTCEJlM
         KBaF6DXQbx1VBD2hQtBDmZSj30S93BPLHeGmfCB8Feb2CbI3NBQR4ihLmLjQOLOjY70O
         VWog==
X-Gm-Message-State: ACrzQf3RA7IXd68wtm1WHli0q+uvuOjnbsocd3wC1nyCqZRicVT4SQ4l
        xSz4eqeH5a3SA50oNnHNtnG5heNH8lvllS1/1lEuIw==
X-Google-Smtp-Source: AMsMyM4IIWhVYnrcl89JUv16zlntR3L0GHCC+R8Rw5UIVeG6mLisxMg10sYB+MuL6TZ1rGDW1IVMl2EAwBInAmTZFls=
X-Received: by 2002:a05:6000:2ad:b0:228:cf8f:fe85 with SMTP id
 l13-20020a05600002ad00b00228cf8ffe85mr18812999wry.94.1664945617525; Tue, 04
 Oct 2022 21:53:37 -0700 (PDT)
MIME-Version: 1.0
References: <kl6l35c4mukf.fsf@chooglen-macbookpro.roam.corp.google.com>
 <54ee4a2a-1937-8640-9297-8ad1516596cc@github.com> <CAESOdVAh68HoQoyicfZn4XbjGfiRFCu1zFQmUjMcSAg3tUzr4Q@mail.gmail.com>
 <96c4f52e-bc66-f4ee-f4f6-d22da579858e@github.com>
In-Reply-To: <96c4f52e-bc66-f4ee-f4f6-d22da579858e@github.com>
From:   Martin von Zweigbergk <martinvonz@google.com>
Date:   Tue, 4 Oct 2022 21:53:25 -0700
Message-ID: <CAESOdVByucFm=yJn2yL1mwKGqey7tHXH4A-JM-yP125Ok+_Q+g@mail.gmail.com>
Subject: Re: Bug report: `git restore --source --staged` deals poorly with sparse-checkout
To:     Victoria Dye <vdye@github.com>
Cc:     Glen Choo <chooglen@google.com>, git@vger.kernel.org,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 4, 2022 at 1:35 PM Victoria Dye <vdye@github.com> wrote:
>
> Hi Martin!
>
> Please make sure you respond in plaintext - it looks like your message didn't
> make it to the mailing list. I've reformatted it to render nicely in this
> reply.

Hi! Sorry about that, and thanks for fixing! I've switched to plain
text now, and I've
manually added newlines to keep lines short (unsure if I was supposed to).

>
> Martin von Zweigbergk wrote:
> >> On Tue, Oct 4, 2022 at 9:34 AM Victoria Dye <vdye@github.com <mailto:vdye@github.com>> wrote:
> >>
> >> Glen Choo wrote:
> >>> Filing a `git bugreport` on behalf of a user at $DAYJOB. I'm also pretty
> >>> surprised by this behavior, perhaps someone who knows more could shed
> >>> some light?
> >>>
> >>> What did you do before the bug happened? (Steps to reproduce your issue)
> >>>
> >>>   git clone git@github.com:git/git.git . &&
> >>>   git sparse-checkout set t &&
> >>>   git restore --source v2.38.0-rc1 --staged Documentation &&
> >>>   git status
> >>> ...>
> >>> What happened instead? (Actual behavior)
> >>>
> >>> I saw a staged modification (Documentation/cmd-list.perl) and the same
> >>> file reported as deleted in the working copy. Specifically,
> >>>
> >>>   $ git status
> >>>
> >>>   On branch master
> >>>   Your branch is up to date with 'origin/master'.
> >>>
> >>>   You are in a sparse checkout with 64% of tracked files present.
> >>>
> >>>   Changes to be committed:
> >>>     (use "git restore --staged <file>..." to unstage)
> >>>           modified:   Documentation/cmd-list.perl
> >>>
> >>>   Changes not staged for commit:
> >>>     (use "git add/rm <file>..." to update what will be committed)
> >>>     (use "git restore <file>..." to discard changes in working directory)
> >>>           deleted:    Documentation/cmd-list.perl
> >>>
> >>
> >> Thanks for reporting this! There are a few confusing things going on with
> >> 'restore' here.
> >>
> >> First is that the out-of-cone was even restored in the first place.
> >>
> >
> > I was actually happy that the out-of-cone paths were restored. I ran that
> > command as an experiment while reading Elijah's doc because I was curious
> > what would happen. The reason I think it should restore out-of-cone paths is
> > so you can do `git restore --staged --source <some commit> && git commit -m
> > "restore to old commit"` without caring about the sparse spec.
>
> Conversely, that's behavior a user *wouldn't* want if they want to keep
> their sparse cone intact (not to mention the performance impact of checking
> out the entire worktree). I think it does more harm to those users than it
> would benefit the ones that want to checkout out-of-cone files.
>
> The use-case you're describing should be served by the
> '--ignore-skip-worktree-bits' option (not the most intuitive name,
> unfortunately). Luckily, there's an increasing desire to improve the naming
> of sparse-related options, so the UX situation should improve in the future.

I realized after sending my previous email that I might have a
different view of what
sparse checkout is about. To me, it seems like it should be just a performance
optimization. That's why I feel like commands should behave the same way with
or without a sparse spec (unless that proposed `--restrict` flag is passed). I
understand if that's just not feasible. Sorry about the noise in that case :)

>
> >
> >> Theoretically, 'restore' (like 'checkout') should be limited to pathspecs
> >> inside the sparse-checkout patterns (per the documentation of
> >> '--ignore-skip-worktree-bits'), but 'Documentation' does not match them.
> >> Then, there's a difference between 'restore' and 'checkout' that doesn't
> >> seem intentional; both remove the 'SKIP_WORKTREE' flag from the file, but
> >> only 'checkout' creates the file on-disk (therefore avoiding the "deleted"
> >> status).
> >
> > Restoring only into the index (as I think `git restore --staged` is supposed
> > to do) is weird.
>
> 'git restore --staged' is intended to restore to both the worktree and index
> (per 183fb44fd2 (restore: add --worktree and --staged, 2019-04-25)). The bug
> you've identified is that it's not restoring to the worktree.

Ah, `--worktree` is on by default even if I pass `--staged`, I see. Hmm, the
help text actually says "Specifying --staged will only restore the index."...

>
> Assuming everything was working properly, users could still choose to
> restore only to the index (using the '--no-worktree' option).
>
> > Let's say we do a clean checkout of a commit with tree A
> > (i.e. the root tree's hash is A). If we do `git sparse-checkout set
> > non-existent`, the index and the working copy still logically contain state
> > A, right?
>
> The index will, but the working tree will be empty because all index entries
> not matching 'non-existent' will have SKIP_WORKTREE applied.
>
> > If we now do `git restore --staged --source HEAD^` and that
> > command doesn't remove the `SKIP_WORKTREE` flag on any paths, that logically
> > means that we have modified the working copy, and I think `git
> > sparse-checkout disable` would agree with me.
>
> If you aren't using '--ignore-skip-worktree-bits', the entries with
> SKIP_WORKTREE shouldn't be touched in the first place. If you *do* specify
> it, by virtue of restoring to the working tree, SKIP_WORKTREE must be
> removed.
>
> But suppose you're doing something like 'git restore --staged --no-worktree
> --ignore-skip-worktree-bits --source HEAD^'. In that case:
>
> - you are restoring to the index
> - you are *not* restoring to the worktree
> - you're restoring files with SKIP_WORKTREE applied
>
> Right now, SKIP_WORKTREE is removed from the matched entries, but suppose
> (per your comment) it wasn't. That wouldn't mean that we've "modified the
> working copy"; the working tree is defined with respect to the index, and if
> the index entry says "I don't care about the worktree", then there are no
> differences to reflect.

Yes, not technically changed. I was (and still am) thinking of the working copy
as logically containing all the files even if some of them are not written out
to disk. I understand if that seems like an odd way of thinking about
it. It might
help to think about how it might appear in a virtual file system where clean
files outside the sparse spec are presented from the index. Or it may be better
to not try to think about it in this weird way at all :)

>
> This raises an interesting question about the current behavior, though: if
> you restore a SKIP_WORKTREE entry with '--staged' and '--no-worktree',
> should we remove SKIP_WORKTREE?

FWIW, that's the case I meant.

> I'd lean towards "no", but I'm interested to
> hear other contributors' thoughts.
>
> > That's different from how `git
> > restore --staged` without sparse-checkout would have worked (it would not
> > have updated the working copy). So from that perspective, it might make
> > sense to remove the `SKIP_WORKTREE` and add the old file contents back in
> > the working (i.e. from state A in this example), and maybe that's why the
> > commands do that?
>
> It's important to avoid restoring a file to the worktree when it has
> SKIP_WORKTREE enabled. See af6a51875a (repo_read_index: clear SKIP_WORKTREE
> bit from files present in worktree, 2022-01-14) and the corresponding
> discussion in [1].

Makes sense. That's why I said "and add the old file contents back in the
working copy" (if I understood correctly what that discussion was about).

>
> [1] https://lore.kernel.org/all/pull.1114.v2.git.1642175983.gitgitgadget@gmail.com/
>
> > Actually, `git checkout HEAD^ .` would update both the
> > index and the working copy to match
> > HEAD^, so that shouldn't have to remove the `SKIP_WORKTREE`, maybe?
> >
>
>
