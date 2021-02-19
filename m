Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B55BAC433E0
	for <git@archiver.kernel.org>; Fri, 19 Feb 2021 06:15:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6140D64EC0
	for <git@archiver.kernel.org>; Fri, 19 Feb 2021 06:15:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbhBSGPZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Feb 2021 01:15:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbhBSGPW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Feb 2021 01:15:22 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6621C061574
        for <git@vger.kernel.org>; Thu, 18 Feb 2021 22:14:41 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id 80so4203298oty.2
        for <git@vger.kernel.org>; Thu, 18 Feb 2021 22:14:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+grEbmY/8a8S3OGC55SfllLRTXMw32zJVg0/jk2VKUw=;
        b=XcCpl2tksPz1//bGeFV+s9lEFgTOewlHrJ1SOBX4SMbMyDinuQJKOVsynpsJJLUM3H
         dedvInMjLzBOtvKLqKD6UNsI3+cN8MtthixzyFePPUXPgoJFc+G/85d0hQuM9o7eQ7up
         BiKH7xcwnQ27qEbYKB0rhO7h/+ZP7wV+UyVCvkmPBih51kR0g5MByRnuIklW0wX/ToTk
         Bhv+1ZekeVlXePsf89zCB/ridkN2iiq0pxppttIUEqvW7nr9MxlL29+oODwNhq/Gt44/
         9/xO6hlR5yOm1QOFuJSwxUPFfhi1zrv0JI5HWf55Bwnr316DAUvKm+zisUGTMhFTEy8y
         QUvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+grEbmY/8a8S3OGC55SfllLRTXMw32zJVg0/jk2VKUw=;
        b=ZsFge6IGVhLSPaPocPK0k3VctQ+p3JZYYnL5WNnhtsiDq/TE6gVTU8ah3o8wCFdsZ7
         lYov/lRVrnXbV0330Ew6rfAKduBhjFgxSCweCdhDfKeH+JEs/ymmnqeBnfPjUm9jd+5Q
         WbHj9csBF1CyTohLPBwJ4tmcEhQ6h6Ze4qxCc+YSaOumFuD/ZaWbHFaJCv9XS3UYMadl
         yLYycwc1cMVtcv33r4s5gGEYPdBYseeC3kA/hsb5fqQYv/bOcCBYbx+BxHprhr5vLpsp
         FNoMJl1rf8EDEoJa4G9vNBFoGCMpFhRl1ObkuuIm+5JA5bTq1dijlB9bPBq3GMTcaOlM
         ssFg==
X-Gm-Message-State: AOAM5307by++QGA4RIh3gLuyG2lngO2UpH019hK6++DhtYs7pgfdQCCL
        MjuZ9ZGyy4e4/UkI4vrUN5zrjc7TeH6/bBdh/gw=
X-Google-Smtp-Source: ABdhPJy4rj69tIMbPry0/Z5r7g8ByLIwrhMb0wRIXMhK5TEC2m+83uuPYTGy2KLmfr9ERx/xLVMHchEYO1+IX6kcRp8=
X-Received: by 2002:a05:6830:1d43:: with SMTP id p3mr1737901oth.184.1613715281285;
 Thu, 18 Feb 2021 22:14:41 -0800 (PST)
MIME-Version: 1.0
References: <xmqqr1legm5v.fsf@gitster.g> <CAPSFM5efu6MF2RzfDkw8XJ9kF79akEesdA0WFAG3n9fo9N26vQ@mail.gmail.com>
 <xmqq8s7lf9ra.fsf@gitster.g>
In-Reply-To: <xmqq8s7lf9ra.fsf@gitster.g>
From:   Charvi Mendiratta <charvi077@gmail.com>
Date:   Fri, 19 Feb 2021 11:44:30 +0530
Message-ID: <CAPSFM5caUz-tz3AAAgXeOB26CZ87A0xdG3aHYHTgCC9d8zsbKw@mail.gmail.com>
Subject: Re: What's cooking in git.git (Feb 2021, #03; Wed, 17)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 19 Feb 2021 at 01:07, Junio C Hamano <gitster@pobox.com> wrote:
>
> Charvi Mendiratta <charvi077@gmail.com> writes:
>
> > On Thu, 18 Feb 2021 at 07:44, Junio C Hamano <gitster@pobox.com> wrote:
> >>
> >> * cm/rebase-i-fixup-amend-reword (2021-02-17) 6 commits
> >>  - doc/git-commit: add documentation for fixup[amend|reword] options
> >>  - t3437: use --fixup with options to create amend! commit
> >>  - t7500: add tests for --fixup[amend|reword] options
> >>  - commit: add a reword suboption to --fixup
> >>  - commit: add amend suboption to --fixup to create amend! commit
> >>  - sequencer: export subject_length()
> >>  (this branch uses cm/rebase-i and cm/rebase-i-updates.)
> >>
> >>  "git commit --fixup" learns to optionally create "amend!" and
> >>  "reword!"  commits, that use the log message in "fixup" commit
> >>  as the message of the resulting commit.
> >>
> >
> > I would like to put light on the description of the patches. I might have
> > misinterpreted the meaning of  _"reword!" commit_ as written above.
> > But I thought to explain that here both additional suboptions i.e
> > `amend` and `reword`
> > of `--fixup` introduced in the patch series creates "amend!" commit only.
>
> Thanks for clarifying.  I did mix up in the description.
>
> As the parameter given to the command line option is much more
> end-user facing than which insn it results in the todo list, how
> about explaining the topic like so:
>
>     "git commit --fixup=<commit>", which was to tweak the changes
>     made to the contents while keeping the original log message
>     intact, learned "--fixup=(amend|reword):<commit>", that can be
>     used to tweak both the message and the contents, and only the
>     message, respectively.
>

Yes, this explains as per the working and sounds good to me.

Thanks and Regards,
Charvi
