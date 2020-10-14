Return-Path: <SRS0=g1uB=DW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B6F5C433E7
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 01:40:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2665C22254
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 01:40:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aQKc9684"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389156AbgJOBji (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Oct 2020 21:39:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389029AbgJOBjh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Oct 2020 21:39:37 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E90CC0613B9
        for <git@vger.kernel.org>; Wed, 14 Oct 2020 15:02:54 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id f10so1116380otb.6
        for <git@vger.kernel.org>; Wed, 14 Oct 2020 15:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Lxm2c/8LGiwqhRdyVnu+M1FvWrnbwDutVqR6Tvxsnw8=;
        b=aQKc9684w1SyEvyGzeC6jCdTX98c2HYVqFH4StBbcqNtpjiHwAroPSc8+VaiC9zWZB
         8LPSOIXqZSJHUsbGqHPTkaizryWtuDpqYOYU6vMrXGAFrsIS1beHJRIf83sbSy8i3hYP
         7dvtXNJ+mhd6k8eWd/25Wlr2MgVIe4okXvDMkT0UwKZDa9f1HHNW13kK/xO/1ueXXope
         G+hzSlJupFyIP0j7mjx3qjP9Ml8Xwloe3jvyW4OthyM8NTFymD6RTugV+1LYryE3fW62
         Bvy4BRk+YICGy0p00eH/aRb52R6cz+Izaj3quFZzavy1qLYtjfDnNKVFTT29L7ppuWCa
         d9xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Lxm2c/8LGiwqhRdyVnu+M1FvWrnbwDutVqR6Tvxsnw8=;
        b=tJLtYA5apEGIGLySA3PZp6Lnd33JEoEUU+BsJPBEexeZlUfDLu/f2nsKNwV2udEmtz
         IBSfwUzKDi0rWRI/5VVmA9IGeS48SVVYlwY9HG+uAX3xkszbI6hlTKThqBtCWoXuy0e1
         cUCxpOYB1r8CgRXCTZl+Gg8laxh6Quji4Yn5vBcVchHTstacd8wmx4Tmp64WQ53HMoAs
         +3qjymKd4s4BGsXH0RlxlrTz3UhTCof3HKQqBk9QBCHLoONBH1OcW4ybGt/luG0y8Wdb
         pLL3tc4pMfxaWLSx5FvojeInXQ5+arFrUJAMirK9zT8cOkQdSucL4MSwF75GjN9vFpKZ
         fbDA==
X-Gm-Message-State: AOAM531VkQhzMru7Ca7EBYWk+wC/4cWxL/YnQK8P1qN6ynu8dvzsecJa
        tbzynklqhvtJF3JMfDlEIbHisgauTQlkvjN7pL4=
X-Google-Smtp-Source: ABdhPJxSu810kAjamNtlhHtxCQcyhmayqTeWL0s2q+UgMpW8tKleW1t/ztLCN1zmTRImRCmWZTBC2OSK5+wKnSoMwJU=
X-Received: by 2002:a9d:6e96:: with SMTP id a22mr571788otr.345.1602712973243;
 Wed, 14 Oct 2020 15:02:53 -0700 (PDT)
MIME-Version: 1.0
References: <020EB674-6A95-4E53-B2E7-F4EEBD6324C3@gmail.com>
In-Reply-To: <020EB674-6A95-4E53-B2E7-F4EEBD6324C3@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 14 Oct 2020 15:02:42 -0700
Message-ID: <CABPp-BF2Stb_UfNEqYOBPjvm09oO8=ST685kZ0+U2PtPRz5_mg@mail.gmail.com>
Subject: Re: [BUG?] Weird interaction between `git -C`, aliases and worktrees
To:     Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 14, 2020 at 8:27 AM Philippe Blain
<levraiphilippeblain@gmail.com> wrote:
>
> Hello all,
>
> Up to recently I had an alias 'st' for `git status`, i.e. `git config alias.st status`.
> This works well in the main working tree as well as secondary worktrees (`git worktree add ...`),
> and also shows paths relative to the current directory if I'm not at the root of the repo,
> just like `git status`.
>
> Now I wanted to change my alias so that it ran `git status` and then an additional command, i.e.
> `git config alias.st '!git status && date'` (for demonstration purposes).
> This works correctly in the main worktree and secondary worktrees, but since aliases
> run from the root of the repo, the paths in the output of 'git st' are not relative
> to the current directory.
>
> So my next attempt was `git config alias.st '!git -C "${GIT_PREFIX}" status && date'`,
> so that paths would be relative in the output. However, this works in the main worktree
> but fails badly in the secondary worktree:
>
> ```
> rm -rf test &&
> rm -rf test2 &&
> git init test &&
> cd test &&
> mkdir folder &&
> date>>folder/file &&
> git add folder/file &&
> git ci -m "commit" &&
> git config alias.st '!git -C "${GIT_PREFIX}" status && date' &&
> date >>folder/file &&
> echo '=== `git st` in main worktree at root ===' &&
> git st &&
> cd folder &&
> echo '=== `git st` in main worktree in folder ===' &&
> git st &&
> git worktree add ../test2 &&
> cd ../test2 &&
> date >>folder/file &&
> echo '=== `git st` in secondary worktree at root ===' &&
> git st &&
> cd folder &&
> echo '=== `git st` in secondary worktree in folder ===' &&
> git st
> ```
>
> The last commands ouputs:
>
> ```
> === `git st` in secondary worktree in folder ===
> On branch test2
> Changes not staged for commit:
>   (use "git add/rm <file>..." to update what will be committed)
>   (use "git restore <file>..." to discard changes in working directory)
>         deleted:    folder/file
>
> Untracked files:
>   (use "git add <file>..." to include in what will be committed)
>         file
>
> no changes added to commit (use "git add" and/or "git commit -a")
> ```
>
> So something is wrong in the automatic worktree path detection...
> If I replace the alias with
>
>     git config alias.st '!git -C "${GIT_PREFIX}" --work-tree=$PWD status && date'
>
> then it works correctly, but I have a feeling this should not be necessary...
>
> I've CC-ed Eric (because of his work on `git worktree`) and Elijah (because
> I remember he worked on `dir.c` so maybe this is related to that code, but I'm
> not sure).
>
> Cheers,
> Philippe

I don't think there's anything dir.c-specific here (thank
goodness...).  I extended your aliases slightly to echo the command
they would run (so I could see the value of $GIT_PREFIX) as well as to
print all the GIT_* environment variables, and found that GIT_DIR was
set as well as GIT_PREFIX, so you can duplicate the funny results with

GIT_DIR=$WHEREVER git -C folder status

or even

git --git-dir=$WHEREVER -C folder status

In fact, you don't need any special worktrees setup; using these
commands will trigger the funny status output.  Looking at the
documentation for core.worktree, I see

"If --git-dir or GIT_DIR is specified but none of --work-tree,
GIT_WORK_TREE and core.worktree is specified, the current working
directory is regarded as the top level of your working tree."

and indeed, I find that if I run from the toplevel:

git --work-tree=folder/ status

then I see the same output that you are complaining about.  So, it
seems that "the current working directory is regarded as the top level
of your working tree" is implemented to take effect AFTER the "-C
folder" first changes the current working directory.

I haven't tracked down where in the code this happens, but I suspect
that this is what is happening and is the culprit behind the behavior
you are seeing.  If I am right, it doesn't answer whether this is a
bug, of course -- it could be that this ordering is intentional and
desired, or it could be that this ordering is not wanted.  Anyway,
does this help you track it down?
