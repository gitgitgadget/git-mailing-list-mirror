Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AE98C433EF
	for <git@archiver.kernel.org>; Fri, 14 Jan 2022 21:49:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbiANVtZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Jan 2022 16:49:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbiANVtZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jan 2022 16:49:25 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98930C061574
        for <git@vger.kernel.org>; Fri, 14 Jan 2022 13:49:24 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id o6so38818058edc.4
        for <git@vger.kernel.org>; Fri, 14 Jan 2022 13:49:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4XNEBM5Dvq+0QczK4hd/PUXh5ad2+vLWpw4cbAI/YLc=;
        b=V4EJxaUQLeRfI0SnIQtB/PGs4mjkXqXKQgZ0hcsiwndriFHL1uetZGKSLyroNm7U/X
         IfFOCRr65oL0voclZ9kjoNQ2kDCh9WFMzJM0s2RFPlGpRYDC1zKHjs34W04htvBrUaxW
         IcaJvzVSfehBZTSrDPpgLdT3yvCW0Y7q4AySy7MccmGE8AAal03BKGl1pcTavs8eE1aN
         E1dnfdFwqaM4FNG08HZCAqM8FjpLlNqbHclnFmn+QuMJOWs81s5jxHJd1tMwgMoWO8nZ
         LSe3Dh9G/JYtJU/r4Vd0qOB/DgdQ+dSzHZeBnwGfp1jjjvc1NGDJ2kOA3NOL1d/z+6ER
         bNNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4XNEBM5Dvq+0QczK4hd/PUXh5ad2+vLWpw4cbAI/YLc=;
        b=NkAvNqhcMQ//kJTFLDUAFoO6mWeipVrsUKFHAO+ovF+OA/icmEci7LsylxYRhfvIF8
         urP5hRP+3ljUFp6z1KOw4SQZQP9Ylk8hNddvlUvuSqF8cUD+wAFSIiBB7dY/E1xQQ/BN
         Bb6jJkgTzrfQRrlPKixlb0PdSDEPvAN0XUKfwMUvxn7yMzQHb5uD8jXfIMoJG/FWE+Tm
         eDi4QPxICtfAvkPt4H3DWW/iIdkZY5RmSn6PSZAZG9S+o3+Vpiwgol7yIgKYAqOmpAeJ
         V6W2Clh4tsZvCUrplliL/zvZnpm12WplGuNUipAIiuhAzP1BreT4l0/FPhCSZViu9t2N
         Vznw==
X-Gm-Message-State: AOAM530NxObrOBwzup2glsy6asxornLFUZtVzB8Oyb9pJLfIR8oMqU6R
        /sYFQ1hnjLkrTYhpTG7osza0Hpc0h+OCLBNqpX0=
X-Google-Smtp-Source: ABdhPJzoqQsuhB2TLmerWbmIg0qnZ7XXhUjJw2BSNVK3aBu81J+jbhkzq5UZb9o0c3SfMxD/4bFn2rKBPBWg83AZSsE=
X-Received: by 2002:a50:da48:: with SMTP id a8mr10406892edk.146.1642196963149;
 Fri, 14 Jan 2022 13:49:23 -0800 (PST)
MIME-Version: 1.0
References: <xmqq35lrf8g4.fsf@gitster.g> <xmqqk0f3dk5o.fsf@gitster.g>
 <CABPp-BFGxKBzi5RYDuiJv6Vz7yyGYTOdJC9cL_EkPGNJ5BksYQ@mail.gmail.com> <xmqqmtjyaylt.fsf@gitster.g>
In-Reply-To: <xmqqmtjyaylt.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 14 Jan 2022 13:49:11 -0800
Message-ID: <CABPp-BGOqK0YJXna3PqnFmTcW_KxzAGbqjpUvRjgAxAwYzG4bw@mail.gmail.com>
Subject: Re: What's cooking in git.git (Jan 2022, #03; Thu, 13)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 14, 2022 at 11:47 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> > It's apparently the latter, because there have been no test script
> > changes in the relevant tests.
> >
> >> Somebody with too much time on their hand should go in and check to
> >> help, before CI testing on 'seen' becomes useful again.
> >
> > This "fixes" seen:
> > https://lore.kernel.org/git/pull.1192.git.git.1642176433017.gitgitgadget@gmail.com/
> >
> > I briefly looked at a couple leak traces and thought they looked ref
> > related, but I don't have time to go hunt down memory leaks right now.
> > I figure this thread has reported them, so let's just get "seen" back
> > to green.
>
> If it were "we added a use of known-to-leak command in an otherwise
> clean test, without adding a new leak", I would wholeheartedly
> support such a change, but if it is the other way around, it may
> make sense to leave it broken as an incentive for people who care
> about leaks to go in and fix them up.

Perhaps.  Waiting can make sense up to a point.

> If we toggle it off any time leak-checker CI job starts complaining
> on a test script, the leak-checker CI job serves no useful purpose,
> no?

Folks who use PRs for the purpose of getting the cross-platform CI
testing before submitting to the list can still get early notification
of potential leaks in their own series, due to the remaining tests
being marked as leak-free.  They can then fix up their series before
submitting them to the list.  That seems like a useful purpose to me.

Further, these CI jobs did notify us of an issue in someone else's
patches (we don't yet know whose), and we were able to report it much
like any other bug report.  That gives people a heads up and allows
them to take action on it.  (And if they do so, they can remark the
test as leak-free.)  That also seems like a useful purpose to me.

In contrast, if we leave the leak-checker failing and the failing job
spreads to next and master, then we'll just end up training everyone
to ignore it -- both for their own PRs and in general.  To me, that's
what making the leak-checker serve no useful purpose would look like.
