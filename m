Return-Path: <SRS0=1oE7=AU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	PLING_QUERY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D697C433E0
	for <git@archiver.kernel.org>; Thu,  9 Jul 2020 04:07:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1171A206F6
	for <git@archiver.kernel.org>; Thu,  9 Jul 2020 04:07:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="td4RQxw+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726213AbgGIEHU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jul 2020 00:07:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726064AbgGIEHT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jul 2020 00:07:19 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70405C061A0B
        for <git@vger.kernel.org>; Wed,  8 Jul 2020 21:07:19 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id e90so786759ote.1
        for <git@vger.kernel.org>; Wed, 08 Jul 2020 21:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/nBsD849uiGdABqrN09COO56GAp6j1+GeHWcGO1SAx8=;
        b=td4RQxw+UiLa8vp9gca9ylpRlBltgvICh2osNTV0kCuT+oncti8zDq4REnn5FxVUcg
         uja1riKWGEstI6zFWku2DHYgsz9HuEccrOBwx0S0LqVha5QCtw6pAmzDBjs52LP9nqD6
         rvRVFpdJeIdFfN3zST245ojApxa08P6Jc7YEdIoJmmVyj0L+xNhf4DGjdlRn3pVz70hN
         TuvV3m4b1qb5MCXocB5P0YOYvtu0RuEhcK/5nC26Wyu9J73jA2KXb8nGHsIG1xo179Ry
         ID5bmcOakQbWvxhm+i+DRo9HO3Cjeczr1OeyE7ZUwKdIzEcAlRY2OEqCAdEAZzWUAuWi
         fO7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/nBsD849uiGdABqrN09COO56GAp6j1+GeHWcGO1SAx8=;
        b=rDnQj71DPO6MKWLwOOoeqB+wd7xl9micw+WT+Ty6pjXQm/Ttumsc8eYvR47H7izmtf
         lkP0vrNKAuNFRzW5xYCmqS2J/jKvHNdQaZcj8NDqE/niKZwwt5ADkYzEy9GX8DEmt+87
         GPUG5kZ96oNpN7zXXxaONKP+TaNETS0/+sLoNuHgp7iB0zAR5xlr9beRbARMVtzDJRNm
         cIAMQM3sfWxp4dsTE07i8aIbidtP1k5Rg1sYGN5Qk+qyMAFrSvmkGD8Itj0VGLgjp7La
         vwezKDmO6Ee9IvdEqfYg9VnjVh9mHMm0qDaTCLSgmPIqynDS2RBH1JNGQOIK6yopBN5Q
         Mb8g==
X-Gm-Message-State: AOAM530cJ1Jf7Z6CnvLmvhHk7VxPGKNYFyjEu490Gno91YTSXkFMubNJ
        ngj45U0BkdTvoPsnHbGIA/43cGg16WZej0v0Vl8=
X-Google-Smtp-Source: ABdhPJzvcrVWEsyPp5FVPrRqEQwL7pEwr8YoXisLAWMM2kY0R6o4bQ/Iv2Hp+3/K8mb3Zn+tn9pVXA/bav0/hXMLPkI=
X-Received: by 2002:a05:6830:18da:: with SMTP id v26mr36167988ote.316.1594267638645;
 Wed, 08 Jul 2020 21:07:18 -0700 (PDT)
MIME-Version: 1.0
References: <7A30EA48-72E3-47E1-9792-136D7B96DC84@gmail.com>
In-Reply-To: <7A30EA48-72E3-47E1-9792-136D7B96DC84@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 8 Jul 2020 22:07:07 -0600
Message-ID: <CABPp-BEu=7xSLk5AE8sQX+S-vvYXxgn+avQ8+9ttdSKDjikb9w@mail.gmail.com>
Subject: Re: rebase - "fixup!" conflict applied at the wrong code location,
 why ?
To:     Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 8, 2020 at 5:07 PM Philippe Blain
<levraiphilippeblain@gmail.com> wrote:
>
> Hello,
>
> I've been working on a branch for a while. I've been using `git commit --fixup`  and `git commit --squash`
> when I noticed that I had forgotten to add something to a previous commit.
> Today I did `git rebase --autosquash` to clean up my history, and the rebase failed at the
> first 'fixup!' commit with a conflict. However, the conflict is not located at the right place
> in the code (it's not in the right subroutine!). This is very surprising to me, and I would
> like to understand why it happens.
>
> Steps to reproduce:
>
> git clone -b branch-to-be-rebased https://github.com/phil-blain/CICE.git cice
> cd cice
> git rebase -i --autosquash my-first-commit
> # save the todo list without modifications
>   Auto-merging <file>
>   CONFLICT (content): Merge conflict in <file>
>   error: could not apply e8bfa55... fixup! <commit message of f4e1ae6>
> # the rebase stops at f4e1ae6
> git diff
> # tangential question : for some reason the hunk header does not appear here, I don't know why...
> git diff -2  # but it appears here
> git grep -p -e '<<<<<<< HEAD' -e '>>>>>>> e8bfa55...'  # or here
> # ok, the conflict appears in subroutine 'picard_solver'
> git show REBASE_HEAD -U5
> # but the original "fixup!" commit only modifies the subroutine 'anderson_solver' !!
>
> I would have expected that the conflict be created around lines 1118-1132
> (line numbers in f4e1ae6), in the 'anderson_solver' subroutine.
>
> I don't know if this plays a part here, but commit f4e1ae6 (where the rebase stops)
> is the commit where the 'anderson_solver' subroutine is added to the code...
>
> Thanks,
>
> Philippe.

If you take a look where the rebase stops, you see:

$ git ls-files -u
100644 ee4377f1ec6836fa05573976a473373906c37d9f 1
cicecore/cicedynB/dynamics/ice_dyn_vp.F90
100644 30c699ac371c2a751052fa98d04317e84a96ec47 2
cicecore/cicedynB/dynamics/ice_dyn_vp.F90
100644 276f224e9048fe0bbd7c25822695049547362c87 3
cicecore/cicedynB/dynamics/ice_dyn_vp.F90

The difference from the merge base to "other" (index 3) is pretty
tiny, you just moved one line in the "anderson_solver" subroutine
about 10 lines down.  The more interesting difference is from the
merge base to "ours" (index 2), seen with:

$ git diff :1:cicecore/cicedynB/dynamics/ice_dyn_vp.F90
:2:cicecore/cicedynB/dynamics/ice_dyn_vp.F90

If you search for "anderson_solver" in that diff, you see that the
reconstructed diff looks like "subroutine anderson_solver" is renamed
to "subroutine picard_solver" with similar but slightly different
arguments.  The diff routine successfully finds lots of lines common
between these two subroutines so it seems quite logical as a way of
representing the changes, especially since they occur near each other
in the order of the file.  If you keep looking further in the diff, it
says that a few hundred lines later there's another subroutine rename,
this time from "subroutine calc_zeta_Pr" to "subroutine
anderson_solver".  Looking at it this way, it's quite natural to apply
the change from the rebased commit to the picard_solver since the
other side of history "renamed" anderson_solver to picard_solver.

This might not make as much sense to you, since you tend to think in
terms of parse trees and "subroutines" are a high level unit.  But
diffs work in terms of lines and have no knowledge of any kind of file
structure or semantics.  If you have a string of functions A,B,C and
insert a new function Z on one side of history somewhere in a file
that happens to look a lot like existing functions (meaning several
identical lines between the two), then diffs won't necessarily treat
it as a contiguous block of inserted lines but instead compare
function Z on one side to function B on the other, then function B on
the first side to function C on the second, etc.

There are alternative diff algorithms that try to minimize the number
of changed lines shown by the diff, such as --histogram and
--patience, and they do shrink this particular diff, but they both
yield the same treatment of comparing "subroutine anderson_solver" to
"subroutine picard_solver" essentially treating it as a rename.  To
get a merge like you want, you'd need some kind of higher level
semantic merge, or at least need functions to not have so many lines
in common between them.

This kind of problem also causes big issues when reordering functions
in a file.  line-by-line diffs and the diff3 merge algorithm tend to
really struggle with those.  (See e.g.
https://www.cis.upenn.edu/~bcpierce/papers/diff3-short.pdf if you want
to read up more on these.)

Hope that helps,
Elijah
