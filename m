Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92BF0C433B4
	for <git@archiver.kernel.org>; Tue, 11 May 2021 17:46:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59CCC613C3
	for <git@archiver.kernel.org>; Tue, 11 May 2021 17:46:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231517AbhEKRrP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 13:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231329AbhEKRrO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 May 2021 13:47:14 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB3B0C061574
        for <git@vger.kernel.org>; Tue, 11 May 2021 10:46:07 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id n184so19737194oia.12
        for <git@vger.kernel.org>; Tue, 11 May 2021 10:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+A2YkrbharpCwceZsvClmy3gaSLGMpOO+eoVsIg+WzA=;
        b=oKuOy2Sblgd0HUBzJBP0fygKiSq/6Lo4T0t8kaPRVN4e8JdzckdUc+HWgpTrpqsVmi
         yXntiJLRuk+wJuzT8iWNDLxjpUd8Th1/K0YLfiWMoISv/KYnp+jR3RusK9FHTMMkR/JR
         DjkilNvUgfBD6dp2dORndM1vHWsgQjbGGjaXhMH0lcQ+Rdgoe/GNsjtHHKjeAPjxLTbW
         E5rY1ekNm+RjpP77o2VeSQO3Hc8o8XFAG1mwkv8PP1pOsOHkolwm7PBuPlLS4ZbrZyKo
         T8CkhR/h8oE2HABB8RRLJ30xIDt30ARvM+nrdlhuI+J8vSs8Z3tb+in7qxpkAENRTWBA
         f5Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+A2YkrbharpCwceZsvClmy3gaSLGMpOO+eoVsIg+WzA=;
        b=SUGtP0HG/9vMNhIoID/loFNvxgrKH8+OtdmCNipOWKX/vpj/FIjLTzAFJnT3zcFZMt
         sluWIAPY1RK8Yt7JiMDmbyfV7vQTS5H7ZK5tUlDHydtDhMZG8YGLAPLeyrscEzN+vSsp
         gaayYjpJcZH3YzKdj6E9sxJqEmBjHzNKnvyYFMTSaLlu5klsZdqqQyXEsOqiTz738l/d
         wZ4vIaCKGUdmybqno/nFpe/KF+ZwIQuFqlJmBdtlpM/pIKdkX38mBgEYrhpFR2aFZaVi
         vYAUx/pc7Z3uPr0OsKIeYtBry2dcpqYqpt11MAgBBvtCOEy4s7IuSIod1UitW/M7UC1S
         xJZQ==
X-Gm-Message-State: AOAM5329Abi7Wgjx+ofvwNkhW6IuWqhIoTKbMkfx/5xmlPD06LHG8NDp
        WRQShHNqWypHcq7lgc5SUajoXmsP7+/lcECfRMg=
X-Google-Smtp-Source: ABdhPJxeLKOew/5D8fTLzQ7x9vePoOfTvqmm1TYLOddZYClgelCrjQ8VtN2LqCGc0kbdNnVkI4dDdMqhF/8yE10MI1w=
X-Received: by 2002:aca:30cd:: with SMTP id w196mr4346447oiw.167.1620755167240;
 Tue, 11 May 2021 10:46:07 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1020.v2.git.git.1620432500.gitgitgadget@gmail.com>
 <pull.1020.v3.git.git.1620503945.gitgitgadget@gmail.com> <dc3d3f2471410aa55da4dbc8e2747192888bce5f.1620503945.git.gitgitgadget@gmail.com>
 <xmqq7dk7rwcc.fsf@gitster.g>
In-Reply-To: <xmqq7dk7rwcc.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 11 May 2021 10:45:56 -0700
Message-ID: <CABPp-BFV6R9GNeZVbiKx_Tazq+6LuBNCzLcsEq63MfG5YD0hFQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/8] t7300: add testcase showing unnecessary traversal
 into ignored directory
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Josh Steadmon <steadmon@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, May 9, 2021 at 10:28 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > +test_expect_failure 'avoid traversing into ignored directories' '
> > +     test_when_finished rm -f output error trace.* &&
> > +     test_create_repo avoid-traversing-deep-hierarchy &&
> > +     (
> > +             cd avoid-traversing-deep-hierarchy &&
> > +
> > +             mkdir -p untracked/subdir/with/a &&
> > +             >untracked/subdir/with/a/random-file.txt &&
> > +
> > +             GIT_TRACE2_PERF="$TRASH_DIRECTORY/trace.output" \
> > +             git clean -ffdxn -e untracked
> > +     ) &&
> > +
> > +     grep data.*read_directo.*visited trace.output \
> > +             | cut -d "|" -f 9 >trace.relevant &&
> > +     cat >trace.expect <<-EOF &&
> > +      directories-visited:1
> > +      paths-visited:4
>
> Are the origins of '1' and '4' trivially obvious to those who are
> reading the test, or do these deserve comments?
>
> We create an empty test repository, go there and create a untracked/
> hierarchy with a junk file, and tell "clean" that 'untracked' is
> "also" in the exclude pattern (but since there is no other exclude
> pattern, that is the only one), so everything underneath untracked/
> we have no reason to inspect.
>
> So, we do not visit 'untracked' directory.  Which ones do we visit?
> Is '1' coming from the top-level of the working tree '.'?  What
> about the number of visited paths '4' (the trace is stored outside
> this new test repository, so that's not it).

Good points.  I'll make a comment that directories-visited:1 is about
ensuring we only went into the toplevel directory, and I'll removed
the paths-visited check.

But to answer your question, the paths we visit are '.', '..', '.git',
and 'untracked', the first three of which we mark as path_none and
don't recurse into because of special rules for those paths, and the
last of which we shouldn't recurse into since it is ignored.  There
weren't any non-directory files in the toplevel directory, or those
would also be included in the paths-visited count.  A later patch in
the series will fix the code to not recurse into the 'untracked'
directory, fixing this test.
