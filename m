Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4831BC433C1
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 01:00:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15E01619D3
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 01:00:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233897AbhCXBAj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Mar 2021 21:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230492AbhCXA75 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Mar 2021 20:59:57 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD8BCC061763
        for <git@vger.kernel.org>; Tue, 23 Mar 2021 17:59:57 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id k25so19069697oic.4
        for <git@vger.kernel.org>; Tue, 23 Mar 2021 17:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fJc8rh7bLpPEms45FFwaJalloNsPQ4jx+InrL/8Z5vk=;
        b=c7qpQPT5GrAK+/InPCDoUYGWWMa4VadFSqw5RcoFW6NdJp6Qz6QqTqU1pJ4RXMRbJP
         7ittuyld6ryvyrsAEl9q9tQXHP91tZK2RlNG6dhOZHQQWqvJxy/63pGirC0o3uNo7Qn+
         zBsKf+/+B4d6ovPsz2N61bsqSQdu39xMn4Y/cF1JXa3GhLafCLksd3EwpbqSIjQ6gfl4
         6J8PdZRIBbqisKYsZb2ITSfsI+ih8T3UirvHS4FmFEdESBIw2DvEJTaBHVj75bT8GXx6
         90VIuLrEOTUPd8N51qVZnP77DRq2cahUc1/4fZi2PNm+xw2DIaArftyxz62yhU5vpG33
         MPdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fJc8rh7bLpPEms45FFwaJalloNsPQ4jx+InrL/8Z5vk=;
        b=ZNYrctqM9DXC7+J7xUuVO8vo9fPU8UIYkCCdj00SaLJaVkxvC1dFTqIEfP+sVClcdG
         YBJVdMWs80f4Hci2n7tV84ykblrM2mJ2rscQxXqanUB0cbvieAVuFDYxb0nluXHqbFYv
         QoH0L3eIgfWpkco0bXcBtzKXkt5XvvZT9dXTXus0W/Vm8K0hjJIp4KIhAz0Re2fRHpjT
         gimJto7xbHVlnxRP55ZTZnqcMtlfGHRJFkKZDhsnX4PHF5xIrXTIEN8haKguSp7VHaix
         ek8PKV1TEMf2Fl0FC0xIuB8xb9OG3BaczA/c++fb10fCOi8kM2PJfUJijRaMuK2Cwr0l
         9tYQ==
X-Gm-Message-State: AOAM532ib1R2nVJAhF2dSUyGgnpLGc92jE6e3RVRPx7pQXXXKyaemrct
        TU69DHYgs5PYQmRBYnPshn8GnSnpzU7LiDdX/+FkwflTf+w=
X-Google-Smtp-Source: ABdhPJxQiGk79JCrB2s3Z/HiG/88PnHP/gwsuFbMc6iGjWUeH3BLpsmrd+S+39QF8LJgayYqd7TVRk0zmhNYCTF3Mjw=
X-Received: by 2002:aca:6545:: with SMTP id j5mr573403oiw.31.1616547597030;
 Tue, 23 Mar 2021 17:59:57 -0700 (PDT)
MIME-Version: 1.0
References: <4442fd0a-3306-a22b-3614-e3272f8f0be5@FreeBSD.org>
 <YFUX+Rqdj3gteyql@camp.crustytoothpaste.net> <78c7bd2c-c487-756e-c85d-dcfe2866f5f4@FreeBSD.org>
 <CABPp-BGZebutsk5c4kf9gAuu0zgSEptxRmbEBFFwNPE03D4R1g@mail.gmail.com>
In-Reply-To: <CABPp-BGZebutsk5c4kf9gAuu0zgSEptxRmbEBFFwNPE03D4R1g@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 23 Mar 2021 17:59:46 -0700
Message-ID: <CABPp-BEGEcws69sg6Z2=B1nihFG227mAsSx=boU3uSx2xDUEjg@mail.gmail.com>
Subject: Re: --no-edit not respected after conflict
To:     Renato Botelho <garga@freebsd.org>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 22, 2021 at 10:14 AM Elijah Newren <newren@gmail.com> wrote:
>
> On Mon, Mar 22, 2021 at 6:09 AM Renato Botelho <garga@freebsd.org> wrote:
> >
> > On 19/03/21 18:30, brian m. carlson wrote:
> > > On 2021-03-19 at 14:44:30, Renato Botelho wrote:
> > >> I was reverting multiple commits using --no-edit parameter and after one of
> > >> those commits conflicted and I resolved using mergetool, no-edit option was
> > >> not respected anymore and next commits opened editor for me to review commit
> > >> message.
> > >
> > > I'm not sure I understand what you're seeing here, and I think maybe if
> > > I knew that I could provide more useful information.  Could you maybe
> > > provide the set of commands that you're running up to and when you see
> > > this problem, or even better, a reproduction testcase?
> > >
> >
> > I ran `git revert --no-edit commit1 commit2 ... commitN` and one of
> > those reverts had a conflict and the process stopped waiting for a
> > resolution.
> >
> > I ran `git mergetool` and resolved the conflict, then ran `git revert
> > --continue` and then it ignored --no-edit parameter for all other
> > commits and opened $EDITOR for me to edit commit message.
> >
> > I managed to reproduce it on a testing repository doing following steps:
> >
> > % echo a > file
> > % git init
> > % git add file
> > % git commit -m a
> > % echo b > file; git commit -a -m b
> > % echo c > file; git commit -a -m c
> > % echo d > file; git commit -a -m d
> > % echo e > file; git commit -a -m e
> > % git log --oneline
> >
> > d3ec7fc e
> > 23ad2b7 d
> > 2265c82 c
> > 5e0c98a b
> > b34f81a a
> >
> > % git revert --no-edit d3ec7fc 2265c82 5e0c98a
> >
> > It will revert d3ec7fc without any interaction, as expected, then will
> > stop the process on 2265c82 due to conflict and after resolve conflict
> > when I do:
> >
> > % git revert --continue
> >
> > --no-edit parameter will be ignored when reverting 5e0c98a.
>
> Thanks for the testcase.  I can reproduce.
>
> sequencer.c:save_opts() will only save non-zero values (and since
> options.edit defaults to 1, it'll only save the default value).
>
> sequencer.c:continue_single_pick() was written assuming struct
> replay_opts was not necessary, so even if opts->edit is 0, it just
> runs a plain "git commit" anyway.  It should include --no-edit
> --cleanup=strip.
>
> I've got a patch that fixes both issues, but need to make a proper
> testcase and whatnot.  Maybe I'll have time to do that tonight.

This turns out to be messier than I expected, and I still don't know
what correct behavior is for two related cases.  As best I've figured,
current behavior and expected behavior is as follows (note the
question marks for two entries in the expected behavior table):

=== Current behavior ===
                   Non-conflict commits    Right after Conflict
revert             Edit iff isatty(0)      Edit (ignore isatty(0))
cherry-pick        No edit                 See above
Specify --edit     Edit (ignore isatty(0)) See above
Specify --no-edit  (*)                     See above

(*) Before stopping for conflicts, No edit is the behavior.  After
    stopping for conflicts, the --no-edit flag is not saved so see the
    first two rows.

=== Expected behavior ===

                   Non-conflict commits    Right after Conflict
revert             Edit iff isatty(0)      Edit (regardless of isatty(0)?)
cherry-pick        No edit                 Edit (regardless of isatty(0)?)
Specify --edit     Edit (ignore isatty(0)) Edit (ignore isatty(0))
Specify --no-edit  No edit                 No edit


The thing I'm unsure on is the !isatty(0) handling for revert &
cherry-pick right after a conflict when neither --edit nor --no-edit
are specified.  Should that attempt to launch an editor, which is
likely to fail?  It does currently, but given that it ignored
--no-edit previously it may have just been an oversight rather than
intentional behavior.

Thoughts?
