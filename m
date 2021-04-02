Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79423C433ED
	for <git@archiver.kernel.org>; Fri,  2 Apr 2021 22:18:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4746661029
	for <git@archiver.kernel.org>; Fri,  2 Apr 2021 22:18:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234207AbhDBWSY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Apr 2021 18:18:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231406AbhDBWSX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Apr 2021 18:18:23 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4DD9C0613E6
        for <git@vger.kernel.org>; Fri,  2 Apr 2021 15:18:21 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id 91-20020a9d08640000b0290237d9c40382so6027053oty.12
        for <git@vger.kernel.org>; Fri, 02 Apr 2021 15:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Jz9Q6MVa/QpjQXO6Lz5522jqUy0mYPbI1J8qjx8o10M=;
        b=V2MZGo7e0juxPXvw9UhkYpp0p/hiF2jzUZMZEbGA7lXSfhBzxhC+otd9BqGJANHALz
         54Oqzurt6YrM15sMSCfwKvSISmiGBizHW+q6XQp7tPcI2hpi+PFuvncr/A1TSC/i5gjg
         uW428wMjjGjgmxswi3Lv2q0rmaP17N3uR48BCFimUs+hkeMOVOTw1I+vuCQdmvCT5DhG
         4N3yGo20kqY0HrozM1OAr3zBHc8cn8QnqjtpDuhyBEkYez1tutmRIaHFeHxGDnW8HFBc
         vd8Tpv6KIqxe09VOP2ioryi0ZpgeFMerfiHgwuyxTZXFATr32jXy/dTelH11HAGD3JOW
         VQbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Jz9Q6MVa/QpjQXO6Lz5522jqUy0mYPbI1J8qjx8o10M=;
        b=r/X111io5JR7Go+tg7ULaZW7Yla3H1JJpQW1e6N22tfNde5C5+t0zDYvV+H7TumAyG
         sUKJyK8sxMXGT8q/bEiwQc+PQriWQ/LetTaolcqjkHcuHbWoAgKGJgmj6dG98kNTbRs/
         bH7L3mKLRrDnMqMXF0nMx/tkMp5jf/UiHM/WjgR6Em9VXix/3Tt243sF2uuJs4yGU+It
         UGSvzLjVjspM6XEHjVXuLsJI1IuwuCG8mfDZkOv83uzLhQFxz6AKh+YUMEJq3AGPf3B5
         rRUNFDHJPdEat+v0bq3pS3d0bYKJnMoRdx3XwGCNyAMnREXbARDDEMqRa7dALIObRU9I
         VyeQ==
X-Gm-Message-State: AOAM530HrOMAjJje9TFl3seEcArcvKUzYirr4QQiij2Aw1LnRSGYh40S
        p9dVu6iYkW9GCQqHprONihNkS3LeR2a7WQplDmfIfIVGiaVFuA==
X-Google-Smtp-Source: ABdhPJxhfXa/zZzyOgC36JHZkE+14ILI0NSnBmwL4cojwpwbDCFv+bMf+nKXoRV0+5MpWv0uA7mXBYqOUlkvh45oN7U=
X-Received: by 2002:a9d:4d0e:: with SMTP id n14mr12761277otf.316.1617401900985;
 Fri, 02 Apr 2021 15:18:20 -0700 (PDT)
MIME-Version: 1.0
References: <pull.988.git.git.1616742969145.gitgitgadget@gmail.com>
 <pull.988.v2.git.git.1617070174458.gitgitgadget@gmail.com>
 <nycvar.QRO.7.76.6.2103301200020.52@tvgsbejvaqbjf.bet> <CABPp-BGwAtpsQJ8U5N1q21PMkideptY2MB2PNgbPqvya+XuyHg@mail.gmail.com>
 <nycvar.QRO.7.76.6.2103311533340.52@tvgsbejvaqbjf.bet> <3b117e65-bf9f-af13-b093-28bbbd6f9bb3@gmail.com>
 <xmqqa6qg4d0i.fsf@gitster.g>
In-Reply-To: <xmqqa6qg4d0i.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 2 Apr 2021 15:18:09 -0700
Message-ID: <CABPp-BEzayZkEZ36CFNBGz9X3jv0MNUnWa2EhzKKmWcb83yRmw@mail.gmail.com>
Subject: Re: unifying sequencer's options persisting, was Re: [PATCH v2]
 sequencer: fix edit handling for cherry-pick and revert messages
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Philip Oakley <philipoakley@iee.email>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 2, 2021 at 2:01 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Phillip Wood <phillip.wood123@gmail.com> writes:
>
> > I think we would save a lot by only syncing the state to disk when we
> > stop or run an exec command (the state needs to be synced so exec
> > commands can alter the todo list). In those cases we need to write the
> > index and possibly run an external process so writing a couple of
> > files is probably insignificant.
>
> The optimization opportunity of this may be a lot smaller than you
> would think---you must cater to not just exec but hook scripts that
> are run while a new commit is made, which means every step you'd
> need to write anyway.

From Documentation/git-rebase.txt, right after discussing how the
backends disagree on which hooks are called and how they are called:

...In each case, the calling of these hooks was by accident of
implementation rather than by design (both backends were originally
implemented as shell scripts and happened to invoke other commands
like 'git checkout' or 'git commit' that would call the hooks).  Both
backends should have the same behavior, though it is not entirely
clear which, if any, is correct.  We will likely make rebase stop
calling either of these hooks in the future.


Even if others now disagree with the above, I know I can get a huge
speedup by changing sequencer to stop per-commit wasteful work (stop
forking processes like "git commit", don't write control structures if
the rebase hasn't ended or hit a conflict, don't update the working
copy or index or reflog).  It's enough of a speedup that if backward
compatibility won't allow such a method to be used by default, I'd
still make yet another backend that could be optionally used.  And I'd
have the default rebase and cherry-pick start printing annoying
deprecation notices so that users become aware of a faster option.
Should I go that route?  t/helpers/test-fast-rebase.c already has a
good start...

> > Where I think we can usefully consolidate is the one-line files which
> > store the options rather than state - these are read an written much
> > less frequently so I don't think they have much of a performance hit
> > but it would be much nicer to just serialize the options to a single
> > file.
>
> Would that break external scripts, hooks, etc.?  I am not sure if we
> even have any rough consensus for allowing other people to peek into
> the .git/rebase-*/ directories, but I am inclined to say that it
> sounds more like a solution looking for a problem than a good idea
> to solve some concrete problem.

To be honest, my bigger complaint with the non-unified backend config
is how far it bled into the code and how difficult it is to determine
how things are controlled and which sections of code are relevant for
which types of operations.  And how much of a pain I'm worried it'd
make the "allow rebasing and cherry-picking in a bare repository (or
for an unchecked-out branch)" functionality.  Perhaps the code can be
cleaned up without changing these on-disk structures, in which case my
concern for this point would lessen.
