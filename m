Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF292C433DB
	for <git@archiver.kernel.org>; Thu, 18 Mar 2021 21:37:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C64AB64F33
	for <git@archiver.kernel.org>; Thu, 18 Mar 2021 21:37:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233213AbhCRVhH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Mar 2021 17:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231688AbhCRVgz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Mar 2021 17:36:55 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75D16C06174A
        for <git@vger.kernel.org>; Thu, 18 Mar 2021 14:36:55 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id y19-20020a0568301d93b02901b9f88a238eso6578377oti.11
        for <git@vger.kernel.org>; Thu, 18 Mar 2021 14:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TOs4PMNXw8On74QmnOHO38i3mNBicJ6BKKmK+VK+IEM=;
        b=nIhNZh64g/jPmuzq/e8Rk9eT/FjOzg4O/Vy6b7on7t6DPAndCvy/o19ZrF//9256tE
         4Wm6mlSgMLT1G3mSMv4PGe1Cw6j2ZpKSN5Uz09HuQ6peqbnItRe+5I9p35AtVwh5/Dm+
         K5FKp6+PcqXpQjvklNjC+R5tKa++fWLBF+e0TAz7ctsh+iwT9vtwjQpdwVM+Fnzd2aDg
         DW+n2mvJqRcOZWJUcERCrs+6WzrZoUY7mxCtalml82aJl6TQG8m0CwX+nAgflA79TQ5D
         D3Hyh9yPIZeY65MQtUiMKA/U8TeGY0wu5ztMgH57vyl/Lg68X2G7Ju3IgsXX/CoZUiS7
         Ewrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TOs4PMNXw8On74QmnOHO38i3mNBicJ6BKKmK+VK+IEM=;
        b=k6m2ePIAdD3Q745XU1dI4Lp1DMM8xm8PziEb1xqYUTk0DjZWIZS+gDiE7qFwsmrKc3
         ZlZnRkt/YtYkXqq++1p74X6saRMrd0MO+FYmuIJJBaCsPDTbFgJMKYr21CvaK3JjXyfr
         sTWiiouekwKBI0zkgUN35UOkL10CtLPD+5UsI/ixRIPm9HrE8H3mVtbJIsq4vuZJWplx
         nPvvTS0YwjnUGHDcuRsS/+J79Y+Q1cFuCOBiNhia14Emsvgqa9oTCAeuz9N2ThJF8bc9
         3TBfuZUvw6p4pK1ycWKYfzCt7WbIVElagjUbvB+bPXy76SINbGj1skrTk+XgnhTloO+q
         xabQ==
X-Gm-Message-State: AOAM530gwOPsUcDf1s5ZT2PBYCQ4Q6JlJiaP8o9x0XXaBOO3YceX83gv
        IpvpbNqxlkUG5PGXcdfskY2a9M7TF1w1BCgE0YYfuI0dfMAuAQ==
X-Google-Smtp-Source: ABdhPJwfPx0ZRxDU6DdGPy+zan9mEReQrNNhPcEJVRwpdNlCyO7d2kJgObMaCAveYh65xskMhBIWPBm2vK6XnUw7UPU=
X-Received: by 2002:a9d:73d0:: with SMTP id m16mr8941416otk.172.1616103414532;
 Thu, 18 Mar 2021 14:36:54 -0700 (PDT)
MIME-Version: 1.0
References: <pull.903.git.1615760258.gitgitgadget@gmail.com>
 <pull.903.v2.git.1616016143.gitgitgadget@gmail.com> <75a3c46c405549d1f5127097729c556a7e297587.1616016143.git.gitgitgadget@gmail.com>
 <xmqqo8fgry3g.fsf@gitster.g>
In-Reply-To: <xmqqo8fgry3g.fsf@gitster.g>
From:   Nipunn Koorapati <nipunn1313@gmail.com>
Date:   Thu, 18 Mar 2021 14:36:43 -0700
Message-ID: <CAN8Z4-VQHJVx6+-Lc4jF7NRwLxS6+9wW03FiZ2Ydqn0Mi30dKg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] fsmonitor: skip lstat deletion check during git diff-index
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Nipunn Koorapati via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Nipunn Koorapati <nipunn@dropbox.com>, dscho@github.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 18, 2021 at 1:44 PM Junio C Hamano <gitster@pobox.com> wrote:
> >
> > +     refresh_fsmonitor(istate);
>
> And the VALID bit is set only for the ones that are untouched?  When
> core_fsmonitor is not set, or istate->fsmonitor_has_run_once is set,
> refresh_fsmonitor() becomes no-op and does not even drop the VALID
> bit from the cache entries.  As run_diff_index() is rather
> library-ish part of the system, are we sure no earlier attempts to
> invoke fsmonitor have touched ce to set the VALID bit on at this
> point?
>
> Assuming that we won't see stray VALID bit to confuse us, the patch
> looks good to me, but I am not sure what to base confidence on that
> assumption.
>
> Thanks.

My understanding is that git's invariants around
fsmonitor bit would ensure that the bit is set simultaneously w/ the
rest of the index entry
after a stat (at the cursor/timestamp of the most recent refresh_fsmonitor).

Regardless of whether earlier access to the VALID bit happened within
the command, the
state should be internally consistent at this point, meaning that if
valid is set, the rest of the
entry is sensible.

I did just manually confirm this here
$ bin-wrappers/git diff HEAD
$ rm zlib.c
$ GIT_TRACE_FSMONITOR=1 bin-wrappers/git diff HEAD
21:21:22.911316 fsmonitor.c:97          read fsmonitor extension
successful 'c:1615751750:32210:5:60'
21:21:22.911417 fsmonitor.c:249         refresh fsmonitor
21:21:22.937726 fsmonitor.c:301         fsmonitor process
'.git/hooks/query-watchman' returned success
21:21:22.937749 fsmonitor.c:228         fsmonitor_refresh_callback 'zlib.c'
21:21:22.937755 fsmonitor.c:228         fsmonitor_refresh_callback '.git'
diff --git a/zlib.c b/zlib.c
deleted file mode 100644
[rest of output omitted]

This should be confirmable in the testsuite via
ls t*.sh | grep diff | GIT_TEST_FSMONITOR=$PWD/t7519/fsmonitor-all xargs prove

Perhaps dscho might be amenable to adding this variant to
https://github.com/gitgitgadget/git/blob/master/.github/workflows/main.yml
in the future - so fsmonitor tests run automatically on diffs there.

--Nipunn
