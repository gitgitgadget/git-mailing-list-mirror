Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 468F9C64ED8
	for <git@archiver.kernel.org>; Fri, 24 Feb 2023 07:06:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbjBXHG6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Feb 2023 02:06:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjBXHGv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2023 02:06:51 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 444844DE1A
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 23:06:44 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id e9so13177858ljn.9
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 23:06:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=k7k1KzQcT6OoJYwGTIa/WKEk2NlB40UCbgQOSTy54cI=;
        b=g3May2dXN4aGrBUu7fSVjByWviQ7WLucJ9TFnVbse7evf3TseKK6q6odGG9DoC8LM5
         us1Ka495IQnMQw2EJO5OzCycmfS1sdi5zB4ot9LzwvckhlGFtHyu1hFl7D6lXexZBqMU
         XmkrFuqW+KfcyS3g44C1vuW9gGmZDcLebUbIiQbTf3lBzf6b+jAhoGuowfU3zzZ5ajIz
         Xve79dK6gN2Nhzyv5PVdeF4pF24WugePtx2q4gWcq7vEczJ1BfAgXSAf8N2yC7TQk7TN
         JF83krkqAkg9sKgBQO6OTvzH3RgkQuco7Qh9NEjRXoIjfeEz+hWjjewSKx1nR6PtPk3r
         PcuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k7k1KzQcT6OoJYwGTIa/WKEk2NlB40UCbgQOSTy54cI=;
        b=URkElv9MsxUzovMQYQYAdN516icwrIsuR/lrxCaNQDAnyEF3CsNeiMvqTJ9etO9QnO
         1FVqx9D4jqgBbGcuTVNUoAFCV7wpdwfGtzz6dTmul2x9EtX35RC0XYbJ+cFuZI9+OVHZ
         3wY0gaTPS4cmGkbCewpyEU3vGs6yQZJBmBdcF/qsvatbnmDteb+NOs30QSF/FqtkOG0h
         ru9/Qd58jQ1NtdmwPevaQ/moeTt4CbFOk2jDctam4F10peSmRv+WWBYPOsq7T1bsnN9l
         RYCUMfn4LWJya+hDPoNrLIgVKKKhpc3fDHC6Pw65+3uPOYvJ2r9P0qdl8+O7zmHOhJkm
         Q4Kg==
X-Gm-Message-State: AO0yUKX+L8MTTOOpp5XqOjnD8e3o4RWirk77inRHdMTqSNnedXh61fd/
        CoVxyI4dzOuEhmObKJLEyUBTEiI4R4ohU27OkQBkdDbNDUwmGA==
X-Google-Smtp-Source: AK7set9i0Ld9uEpGTB1KV+2pYx7mpi3fCdOujWAsoENVODcW+0Sgx6XKofEq0FfroVv9eAuOcC4H3Wv2lZMFfV4T0mk=
X-Received: by 2002:a2e:b5dc:0:b0:293:34ef:355b with SMTP id
 g28-20020a2eb5dc000000b0029334ef355bmr4554809ljn.6.1677222402320; Thu, 23 Feb
 2023 23:06:42 -0800 (PST)
MIME-Version: 1.0
References: <pull.1474.git.1675614276549.gitgitgadget@gmail.com>
 <CAMMLpeTPEoKVTbfc17w+Y9qn7jOGmQi_Ux0Y3sFW5QTgGWJ=SA@mail.gmail.com>
 <CAPMMpogFAR6cvcR8T5fx+AoytAJ7TsPpSeOjHNzW4Gmkuq7FLQ@mail.gmail.com>
 <CAMMLpeTQ1RpsvwRdZ0G3wdvH1+LXE5tw=7Cs6Q+HxMcRU0qj5Q@mail.gmail.com>
 <CABPp-BFxGYQ_JTC5c4_S_gOK3GxWKuZ=KfvycpkBjPGyKzCJ+g@mail.gmail.com>
 <c3ef69e0-c37a-01fe-a40a-c2940e329793@dunelm.org.uk> <CAPMMpogi_QoGKD824JW+85v_Sgaf5d3TAd_P55YyT5NF6AUJ=w@mail.gmail.com>
 <87a615vkqk.fsf@osv.gnss.ru>
In-Reply-To: <87a615vkqk.fsf@osv.gnss.ru>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 23 Feb 2023 23:06:29 -0800
Message-ID: <CABPp-BH2XPB4BN5Oo=VnLav_wvAGGUAyZC4HRHRRmES5k75P1Q@mail.gmail.com>
Subject: Re: [PATCH] pull: conflict hint pull.rebase suggestion should offer
 "merges" vs "true"
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Tao Klerks <tao@klerks.biz>, phillip.wood@dunelm.org.uk,
        Alex Henrie <alexhenrie24@gmail.com>,
        Tao Klerks via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 22, 2023 at 6:27 AM Sergey Organov <sorganov@gmail.com> wrote:
>
> Tao Klerks <tao@klerks.biz> writes:
>
> > On Sat, Feb 18, 2023 at 5:39 PM Phillip Wood <phillip.wood123@gmail.com> wrote:
> >>
> >> On 18/02/2023 03:17, Elijah Newren wrote:

[...]

> I also agree (in particular with Buga) that from the POV of user
> experience the method suggested by Phillip should be superior, as it
> emphasizes the natural dominance of the "current branch", as opposed to
> originally described symmetric method that is more suitable for formal
> analysis than for actual convenient implementation. Yet creating U1' and
> U2' from the original method could be useful for the purpose of checking
> for possible problems with automatic rebase that the user may need to be
> aware of.
>
> The biggest problem here, as I see it, is designing UI that'd make sense
> in the case of conflicts in multiple stages of the suggested algorithms,
> but I think we can simplify it for now by stopping and suggesting blind
> re-merge in case of any conflict but that on rebasing of changes to the
> first parent. Even this would be a huge step forward compared to silent
> drop of merge commits and blindly re-merging of updated parents.

I'm not so sure it's a huge step forward.  Or even a step forward.

Dscho actually implemented the old proposals and tried them out, as
mentioned in the threads I linked to.  The results on balance were
significantly worse to him than just throwing away the previous merge
resolution information and redoing the merge from scratch.  He really
wanted a better solution, but the previous proposals didn't provide
it.

This newer approximation, while more careful about only attempting to
run in specific cases and having some good ideas to improve the user
experience, still builds on the problematic foundations in those old
suggestions (namely, cherry-picking merges relative to either of their
parents).  I think it isn't careful enough about the subset of cases
where those problematic foundations can work right.

> > Are there *any* circumstances where the new cherry-picking behavior
> > introduced here wouldn't be the right thing to have happen?

Yes, I can think of one fairly readily: Do an interactive rebase and
drop one or more commits on the side-branch being merged.  This
cherry-picking of merges would reinstate those dropped changes via
silently squashing them into the merge commit itself, making for a
rather evil merge.

> None that I'm aware off, but I admit I'm not familiar with later Elijah
> work on the subject, so I could be mistaken. I only got a sketchy look
> at what Elijah did, and it looks like advanced material to me. I'd
> incline to rather get solid implementation of basics first, probably
> using Phillip method, then consider advanced methods if practice reveals
> demands for further improvements.

That'd be fine if there's another solution that can provide a "solid
implementation of the basics"; I've not seen another proposal that can
yet.

> I'm afraid that there is no ideal general solution for the problem of
> rebasing merge commits.

Sometimes problems aren't generically solvable.  However, sometimes
the problem is solvable, but folks so far have only provided solutions
built on a faulty basis, or that were only designed for special cases,
or that only look at a subset of the problem space.

I think rebasing merges falls into the latter category, and that the
prior proposals were just off the mark.  Granted, I haven't
implemented my proposal yet and I might discover more issues when I
do, but I'm optimistic.  It just really needs some good uninterrupted
time, and my Git time comes in highly interrupted occasional spurts
these days (and with new short-term priorities being inserted based on
other things that come up on the mailing list and from elsewhere to
boot).  But I'll get to it one way or another.
