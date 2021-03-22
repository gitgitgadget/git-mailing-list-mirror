Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA640C433DB
	for <git@archiver.kernel.org>; Mon, 22 Mar 2021 17:15:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F33D6198E
	for <git@archiver.kernel.org>; Mon, 22 Mar 2021 17:15:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232118AbhCVROs (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Mar 2021 13:14:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232137AbhCVROg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Mar 2021 13:14:36 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21122C061574
        for <git@vger.kernel.org>; Mon, 22 Mar 2021 10:14:36 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id k25so13798208oic.4
        for <git@vger.kernel.org>; Mon, 22 Mar 2021 10:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bX2dR0vzRTAGlNi0nGnScxBSmwNy+EEWbgTlx86J7AI=;
        b=MWXd0f2ErYB0cv1S51iosZDspmJFCRlNviYbS/jBJC37+vTXsnIAqTsQbWxQfiqXz0
         xEq+Pb5L0vT7bTWXRNZPQQGwcJrvq0CfVXrEPKeAftVOwgiaB6J8b8r6Li3iHYyqsIqs
         D8S7UIUEotCe/bJ7s4ve56BgYKFldtJjnTnQOpXER4z8EchtJ9NKnofK2i6nNhP1Y7x4
         jnjcaBFso9RV32emAfOVxSY7FoXaPBNCwKr54ZbsHZ8rgqMEkouG2Bcw7Vr+Dl+m7adg
         H76gt3o/aLvMD0WphKWjeLfVBTptujtxT+PcoQ6QnpkbfapgrCr+zboKEAyehNsIIxM5
         Ve7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bX2dR0vzRTAGlNi0nGnScxBSmwNy+EEWbgTlx86J7AI=;
        b=MjdvvrK7b2D+DOPJFfdEqwhRoUlDwpyBpq7CTz9CdOWVVkv9k4nwv9lvtd6ZEe+7dL
         uDYnyK7IjyxsUw+w0VzoiTgGb4hNv0w4+xoLJyhb8x96DF2eJGk82zRPBNP99SheAgOq
         USKmKRnHVTfK5m5TfaWUsJ6bwB5MoIiYNnEnLHf4YD1fBNh+OLs6SslAj13To1V21rJF
         37s2Ug2jM98WTsJh0ZFRhcLMpvp7uyLfXg4n2+i8EDIPXYDhCtPnMJBpt/kXETuYv7Oo
         YxCYIkOd690N9OaqVD2U/kgqOe4fLS8+S5a9BZ8abdaEr/3lT4/k7iADpEeOfb7CUuuH
         W9KA==
X-Gm-Message-State: AOAM530kdtKY5uF4C0tWqvO7KmRL8klXcRschZlxmCx6joEUxWtVzfpE
        +o8i20SaUJOKwP3mQ3vuJdJXH0W6li6uERFuJuMJcJ8NRKc=
X-Google-Smtp-Source: ABdhPJwUBDQjnHVAkCX2szm/tH04BrsDRcdsU/mkX1onuSse52dCOy+qd6vkrr4TIHVmCowwQ86ylRpWhZFhHI2iEAg=
X-Received: by 2002:aca:6545:: with SMTP id j5mr61527oiw.31.1616433275530;
 Mon, 22 Mar 2021 10:14:35 -0700 (PDT)
MIME-Version: 1.0
References: <4442fd0a-3306-a22b-3614-e3272f8f0be5@FreeBSD.org>
 <YFUX+Rqdj3gteyql@camp.crustytoothpaste.net> <78c7bd2c-c487-756e-c85d-dcfe2866f5f4@FreeBSD.org>
In-Reply-To: <78c7bd2c-c487-756e-c85d-dcfe2866f5f4@FreeBSD.org>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 22 Mar 2021 10:14:24 -0700
Message-ID: <CABPp-BGZebutsk5c4kf9gAuu0zgSEptxRmbEBFFwNPE03D4R1g@mail.gmail.com>
Subject: Re: --no-edit not respected after conflict
To:     Renato Botelho <garga@freebsd.org>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 22, 2021 at 6:09 AM Renato Botelho <garga@freebsd.org> wrote:
>
> On 19/03/21 18:30, brian m. carlson wrote:
> > On 2021-03-19 at 14:44:30, Renato Botelho wrote:
> >> I was reverting multiple commits using --no-edit parameter and after one of
> >> those commits conflicted and I resolved using mergetool, no-edit option was
> >> not respected anymore and next commits opened editor for me to review commit
> >> message.
> >
> > I'm not sure I understand what you're seeing here, and I think maybe if
> > I knew that I could provide more useful information.  Could you maybe
> > provide the set of commands that you're running up to and when you see
> > this problem, or even better, a reproduction testcase?
> >
>
> I ran `git revert --no-edit commit1 commit2 ... commitN` and one of
> those reverts had a conflict and the process stopped waiting for a
> resolution.
>
> I ran `git mergetool` and resolved the conflict, then ran `git revert
> --continue` and then it ignored --no-edit parameter for all other
> commits and opened $EDITOR for me to edit commit message.
>
> I managed to reproduce it on a testing repository doing following steps:
>
> % echo a > file
> % git init
> % git add file
> % git commit -m a
> % echo b > file; git commit -a -m b
> % echo c > file; git commit -a -m c
> % echo d > file; git commit -a -m d
> % echo e > file; git commit -a -m e
> % git log --oneline
>
> d3ec7fc e
> 23ad2b7 d
> 2265c82 c
> 5e0c98a b
> b34f81a a
>
> % git revert --no-edit d3ec7fc 2265c82 5e0c98a
>
> It will revert d3ec7fc without any interaction, as expected, then will
> stop the process on 2265c82 due to conflict and after resolve conflict
> when I do:
>
> % git revert --continue
>
> --no-edit parameter will be ignored when reverting 5e0c98a.

Thanks for the testcase.  I can reproduce.

sequencer.c:save_opts() will only save non-zero values (and since
options.edit defaults to 1, it'll only save the default value).

sequencer.c:continue_single_pick() was written assuming struct
replay_opts was not necessary, so even if opts->edit is 0, it just
runs a plain "git commit" anyway.  It should include --no-edit
--cleanup=strip.

I've got a patch that fixes both issues, but need to make a proper
testcase and whatnot.  Maybe I'll have time to do that tonight.
