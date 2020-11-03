Return-Path: <SRS0=XO6Y=EJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A895C2D0A3
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 10:47:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D505622384
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 10:47:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LQ4/eo8W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727246AbgKCKrB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Nov 2020 05:47:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726058AbgKCKrB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Nov 2020 05:47:01 -0500
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C355C0613D1
        for <git@vger.kernel.org>; Tue,  3 Nov 2020 02:47:01 -0800 (PST)
Received: by mail-oi1-x242.google.com with SMTP id 9so17913718oir.5
        for <git@vger.kernel.org>; Tue, 03 Nov 2020 02:47:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dFU0Uw63xJgtP+jcFNmhtacnTAq4KZmDCnN2UucY9B0=;
        b=LQ4/eo8WiA65717/DG3Bc0u6qC1KQQFGt0gv0LQ2EZXl7mwvTQWQMvqRkoF1hcgPKa
         lv38CXzqYHA0tN9m9Vtlt4Jy1yVfNLvI6BqEcFXqlHXyZ8pklgvfq5h6SEDGGOKNvl1+
         HHOj3WCQp8VtWoomFYGRpvvFbhTPmvhPoc3+FNFYzK/Z0YUbt7Mj0Sb9qNwoxSKf+dcg
         /HCElrpCPX/BxPl92hQhSO+B+ul82+bCp6VFdqyRhcb6zUYJFOgaiHJeFHQZ3L0eT0Y4
         1m18fk2uEO4g4g0nPqyullrCuEwm0UsW2vL4iSU6pSVuar8hEEUVx0qPtOqMgUiz9zUY
         dFvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dFU0Uw63xJgtP+jcFNmhtacnTAq4KZmDCnN2UucY9B0=;
        b=pfv9Z86ILLH7k9Liad/jVx4OXBwvjQzF5tYFupB6o519vpzO6vooYUKx8aTNxi/x5b
         /GciQgjSCFsCHgPPGBqrao536YGVEPl/mo/PDm0c2CnIW1DRh09mbfBDJ09GYzy+Mm7q
         y5K17QC7RgdDx7es97uBhvnZ73RCfUvq4if7JUG2FImy0Mq63xAD8MovbYq8vdYkqR4Q
         fxX4Se9ETofjMALaWOKGN5d2oIarB9ipI1kSak7fkCIarz1J3jZjUGLJ53EX1nXvi1hg
         Un9bBPQ+dG+12tua2pnr3f7jaaNhBZcDfIrSfJd1XFq+LkD6+cHSyxaJ2Ni4ipGBatV2
         PzZQ==
X-Gm-Message-State: AOAM5327ff4+h+IKcHmbWtWAjwyiar2K9hzgaO5RsNZ/ef6Sacng0sKj
        1SB5DbflaHD8nSMay+GKVDT3VfJpw7lvXkPJv3S+01tmNCwY8A==
X-Google-Smtp-Source: ABdhPJyw5pdKzKQNfN2EYoNRWPtLNU42eeW0PnK0mZJWhUJ0P8O1ppLvUqpGwXp5r1ubw06+3TPS41PTXH0VotlplAE=
X-Received: by 2002:a05:6808:578:: with SMTP id j24mr1623768oig.10.1604400420313;
 Tue, 03 Nov 2020 02:47:00 -0800 (PST)
MIME-Version: 1.0
References: <pull.751.git.1602781723670.gitgitgadget@gmail.com> <20201026175742.33356-1-sangunb09@gmail.com>
In-Reply-To: <20201026175742.33356-1-sangunb09@gmail.com>
From:   Sangeeta <sangunb09@gmail.com>
Date:   Tue, 3 Nov 2020 16:16:49 +0530
Message-ID: <CAHjREB7W2P9_P4LoMHVVzV_YR5-_51zdbRZ0fpEDVkgkd7sh8w@mail.gmail.com>
Subject: Re: [Outreachy][PATCH v6] diff: do not show submodule with untracked
 files as "-dirty"
To:     Git List <git@vger.kernel.org>
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey Johannes and Junio,

In continuation of the discussion from here[1]

[1] https://lore.kernel.org/git/nycvar.QRO.7.76.6.2011020251520.18437@tvgsbejvaqbjf.bet/

> >> * sj/untracked-files-in-submodule-directory-is-not-dirty (2020-10-26) 1 commit
> >>  - diff: do not show submodule with untracked files as "-dirty"
> >>
> >>  "git diff" showed a submodule working tree with untracked cruft as
> >>  "Submodule commit <objectname>-dirty", but a natural expectation is
> >>  that the "-dirty" indicator would align with "git describe --dirty",
> >>  which does not consider having untracked files in the working tree
> >>  as source of dirtiness.  The inconsistency has been fixed.
> >>
> >>  Needs doc update.

Do I need to add the doc update in the same patch?

> > I *think* the original rationale for marking submodules with untracked
> > (_un-ignored_) files was to avoid deleting a submodule that has
> > uncommitted (because untracked) files.
>
> I agree with you that that the motivation was exactly that, but I
> have a suspicion that its execution was misguided.

I am really very sorry if I ended up adding some unwanted code.

>
> When one has a subdirectory D where one might or might not have an
> untracked new file that one does not want to lose, but one otherwise
> would want to clean up (perhaps an errant process created tons of
> garbage files in the directory), one would not
>
>         git diff D
>
> to see if there are important changes in that directory before doing
>
>         rm -rf D && git checkout D
>
> to bring it back to pristine state, exactly because one would not
> want to lose newly-created but not added files.  One would instead
> use
>
>         git status D
>
> for checking.  Why would a user change the habit when D happens to
> be a submodule?
>
> So I would say that "git status [D]", if it does not let the user
> notice that there is untracked contents in the submodule working
> tree, would be a bad idea.  "git diff" that ignores untracked paths
> in the submodule working tree, on the other hand, is a good thing.
>
> Now, the patch as-is may change the behaviour of "git status D" in
> this case, and the internal invocation of diff-files made somewhere
> in wt-status.c may have to be adjusted to keep such a submodule with
> forgotten newly created files shown as modified.
>
> Further discussion on this should be done on the original review
> thread for continuity, not here, in any case.
>

So we want that `git status` should behave in the same way as it was
behaving before? Can we do this by passing --ignore-submodules=none as
the default args for status? Another approach might be to figure out
how the diff is being called(like is this being called from git status
or git diff) and then add the --ignore-submodules=untracked behavior
to it accordingly. Though I have no idea how to do that now.

Please correct me if I am completely going in the wrong direction. As
it is my first time contributing to git, so any help would be greatly
beneficial for me.

Thanks and regards,
Sangeeta
