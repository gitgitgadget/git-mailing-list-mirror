Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6C17C433ED
	for <git@archiver.kernel.org>; Thu, 20 May 2021 16:45:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FF386101B
	for <git@archiver.kernel.org>; Thu, 20 May 2021 16:45:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234866AbhETQqh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 May 2021 12:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234736AbhETQqg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 May 2021 12:46:36 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34BFCC061574
        for <git@vger.kernel.org>; Thu, 20 May 2021 09:45:14 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id d25-20020a0568300459b02902f886f7dd43so15441870otc.6
        for <git@vger.kernel.org>; Thu, 20 May 2021 09:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KzPTgzz2fxxGmU9djmyhGij4ooZvXBgxs2SbJ3xONlY=;
        b=RsiL52+oicPfvAPHL4DuRmt0q4+0Of9SzOXIO+2RTfrqEC5QXCSkdLD6m7OQDnrioN
         zIZAG0QOC57D9jwLG8bpTbZFVBt5vxBLv5HGpZuLdiQXyyk7PNU0Cl2jQn3e3byPtstT
         tnUHHzfkEYlbt/tQf36Pk6aUU835Dfy/d+qQsp4Df97V/AtuRmSp9258j0P88y70SWuy
         e9gdPLS3xTgopYFUl3/MCdZukwCDW2C7aW1smonshQlRGkoegSP+XcVf6IP6hXYplUP2
         nK3yN1U9770j8aoWx499tiUkZYgNo+ZGcQoVcZ4JFhpuYUIpYnzKF9Bwv0ZkD86Iw3eF
         bzKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KzPTgzz2fxxGmU9djmyhGij4ooZvXBgxs2SbJ3xONlY=;
        b=BlNqvxkuw1qNBsfxb2NXw3EGXkOl4+dMSJS9HZ/QBLlUkd8tUJ50EgCGfE8bFFD2hO
         UyrL5+kmmbMdjDlxJ0j5N3zifpO2YfDk2TPxb50NqhlyLoEcLL8NUzrBG/SAQCjqWKy3
         ujvYQXtEbbbnjZ1mYvr/yPVEFRbfms8Jz+uBZrm6KbZ39FhxiVSvDQkFw1nqsxfXXcHt
         ntcv1ynRlndJF7hxnbsihHo/ziJM/Mo7t6MsmLKMCQ6ivL7rm6mhlp+u0QE/2xQlxyMA
         spu+/GaROan7yK97Dd9ihGnpo711gXeBT4rGqrlm1W6VQbQKEDF8UNDdaEHxBieRDVLO
         bFlw==
X-Gm-Message-State: AOAM530pvE0kv3wpIDBGn8ZkFAGC+H14Gb+3lrt9vvwNU/ngF77J6Hho
        QlfczO6cvbZBaKWGW6Zy1iXXItdvupaPc0ju8uo=
X-Google-Smtp-Source: ABdhPJwtq3PS2eYqNZwWN0Ztt9wd8D4RO7vNQib1DO4t4eQm+OMaPtAV91tWi4MycbgvhUCwdzbCbFI5zuMvsbunu6A=
X-Received: by 2002:a9d:6b8d:: with SMTP id b13mr4563459otq.316.1621529113564;
 Thu, 20 May 2021 09:45:13 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqv97g2svd.fsf@gitster.g> <ab2d8b16-42db-9675-083a-efa7cfca6e4c@gmail.com>
 <xmqqh7iyuhlp.fsf@gitster.g> <xmqqcztmuhem.fsf@gitster.g>
In-Reply-To: <xmqqcztmuhem.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 20 May 2021 09:45:02 -0700
Message-ID: <CABPp-BEGtrb0QjhVff57=s8-8w1CCvw9N_mAm166pzyVDcL_7g@mail.gmail.com>
Subject: Re: [PATCH] revisions(7): clarify that most commands take a single
 revision range
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 19, 2021 at 10:03 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Junio C Hamano <gitster@pobox.com> writes:
>
> > Bagas Sanjaya <bagasdotme@gmail.com> writes:
> >
> >> On 18/05/21 18.17, Junio C Hamano wrote:
> >>> ...
> >>> +In other words, writing two "two-dot range notation" next to each
> >>> +other, e.g.
> >>> +
> >>> +    $ git log A..B C..D
> >>> +
> >>> +does *not* specify two revision ranges for most commands.  Instead
> >>> +it will name a single connected set of commits, i.e. those that are
> >>> +reachable from either B or D but are reachable from neither A or C.
> >>> +In a linear history like this:
> >>> +
> >>> +    ---A---B---o---o---C---D
> >>> +
> >>
> >> So "git log A..B C..D" is same as "A..D", right?
> >
> > A..B C..D is equivalent to ^A ^C B D, and in order to be part of the
> > set it represents, a commit must not be reachable from A, must not
> > be reachable from C, and must be reachable from B or D.
> >
> > In the picture, A, B and two o's are all reachable from C, therefore
> > are not part of the set A..B C..D represents.  Neither is C, as it
> > is reachable from C.  That leaves only D in the resulting range.
> >
> > A..D is a set of connected five commits, B o o C D in the above
> > picture.
> >
> > So, no.
> >
> > The confusion we often see goes more like "The set A..B contains B
> > (and nothing else), and C..D contains D (and nothing else), hence
> > 'git log A..B C..D' would show B and D".  But that is not what
> > happens because "git log" (like most other commands) takes just a
> > "range" that is "A..B C..D", which is a set of connected commits
> > each of whose member is reachable from one of the "positive"
> > endpoints (like B and D) and is not reachable from any of the
> > "negative" endpoints (like A and C).
>
> Well, apparently the proposed text may have failed to educate you
> about what a "revision range" is and how it works, so it is not good
> enough, so I'll postpone merging the change down further and see if
> somebody else can come up with a better description.
>
> Thanks.

I think it's helpful and would have answered questions for users that
I've had to manually explain to folks a few times, so while it may not
be optimal, I do think your description is an improvement to the docs.
That said, it can't hurt to see if we can find out what caused Bagas'
confusion and see if we can improve it, but I wouldn't hold it up
indefinitely if no better wording comes along.
