Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 970ADC433B4
	for <git@archiver.kernel.org>; Thu, 20 May 2021 16:34:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80A366101E
	for <git@archiver.kernel.org>; Thu, 20 May 2021 16:34:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234032AbhETQgF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 May 2021 12:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232707AbhETQgD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 May 2021 12:36:03 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C465C061574
        for <git@vger.kernel.org>; Thu, 20 May 2021 09:34:41 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id t10-20020a05683022eab0290304ed8bc759so15378192otc.12
        for <git@vger.kernel.org>; Thu, 20 May 2021 09:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TKTEeE/uGG1PVAJExr3w+4FcRAfskWd5NpYPUpu5HMU=;
        b=a1lhcoq2Bgjn+DJIDWpSAq7PKCduccZth7Vubw86gZ1r5BiRMNBqi608TakJBvgyuG
         DtPyZoeemvGtkn9OM2VZuOHziY1KAlw943Rk1ZLJbBzkkcj0KWv7VyaeTQtws1tqS8Xb
         9G1bS2IUj9z+rEe59MXoRIaP+gh2a4tdKxQu3PZMhvClfoiaE1TkYeZQEbd/mKkxfG1M
         PziM/UPZ9hkQ75Kq3sfxCmRUFpiT2a7UUtKXDHL88RVzXBKVrm2stcP4czxO/l/pxGF3
         79ak/MUtprVDB56gyUfHB/f95xMO11+N9YVA7ZtbSmPBppwLEbwNtMqUxO+12eZl6jmN
         Ffuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TKTEeE/uGG1PVAJExr3w+4FcRAfskWd5NpYPUpu5HMU=;
        b=aJcAG5q19DvEQZNkq73ycgqJWIP7LL7rSY73BM9KFC30yv816O6tJGXKpUmVdcva+8
         hhM7KSnFzFD6tZZFPfxCUga0BKsjL92J6P4SKW9JYDLz//Bb9/Y6/iDTK5jmo7IJQGuf
         FAUJMUkO0eid4tsT1rvp+O0C3Ly+1uNQCMxhvupSz4njjCrIlRh7GZTCS5eA8W6N9EWw
         249ZcUOGWdlz7CSnMQ4e/qkECDk/TRRGYa3WbAK5kyk3P/0DlX7IsXcgzN9z4G1BfGGa
         TMXbhR+yw1FjId6MRYeO20+uF0PysdSebfNN2rmhFr95YXCUH2rn0wUYlxoG4NIiyZWn
         3fHQ==
X-Gm-Message-State: AOAM533UlAP/AQLaoWj3+ITZNLV2jMZ1lDq5+/RqkACOpNfX1JjQPz0a
        /7scRmnCYe9ewLbQaTcyHv5m0SLYb21lCDvZOGA=
X-Google-Smtp-Source: ABdhPJyAGZtODuMv7yIvkpk+K5Jn4nMdJBhNh1lFCf1TW143UAUm/geQi5E934oCHD7U7gab/dJKkfb905WAF1Ub7ko=
X-Received: by 2002:a9d:6b8d:: with SMTP id b13mr4530618otq.316.1621528480578;
 Thu, 20 May 2021 09:34:40 -0700 (PDT)
MIME-Version: 1.0
References: <pull.859.v2.git.1620094339.gitgitgadget@gmail.com>
 <pull.859.v3.git.1621490982.gitgitgadget@gmail.com> <4246d0193fed5ff522fb2c442bd779973701c078.1621490982.git.gitgitgadget@gmail.com>
 <ef450bbd-0cbb-a512-d88e-eca6638358aa@gmail.com>
In-Reply-To: <ef450bbd-0cbb-a512-d88e-eca6638358aa@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 20 May 2021 09:34:29 -0700
Message-ID: <CABPp-BE5WdFTuOYG1Lw8_XmTg==KqbY5UHK91FVdM3fFRM5uvQ@mail.gmail.com>
Subject: Re: [PATCH v3 02/13] Documentation/technical: describe remembering
 renames optimization
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 20, 2021 at 4:32 AM Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>
> On 20/05/21 13.09, Elijah Newren via GitGitGadget wrote:
> > +Outline:
> > +
> > +  0. Assumptions
> > +
> > +  1. How rebasing and cherry-picking work
> > +
> > +  2. Why the renames on MERGE_SIDE1 in any given pick are *always* a
> > +     superset of the renames on MERGE_SIDE1 for the next pick.
> > +
> > +  3. Why any rename on MERGE_SIDE1 in any given pick is _almost_ always also
> > +     a rename on MERGE_SIDE1 for the next pick
> > +
> > +  4. A detailed description of the the counter-examples to #3.
> > +
> > +  5. Why the special cases in #4 are still fully reasonable to use to pair
> > +     up files for three-way content merging in the merge machinery, and why
> > +     they do not affect the correctness of the merge.
> > +
> > +  6. Interaction with skipping of "irrelevant" renames
> > +
> > +  7. Additional items that need to be cached
> > +
> > +  8. How directory rename detection interacts with the above and why this
> > +     optimization is still safe even if merge.directoryRenames is set to
> > +     "true".
> > +
> > +
>
> For item 1, 2, 3, 5, 8, it seems that you form question sentences but ended
> with dot, instead of question mark (?). Are these question sentences or
> descriptive sentences?

I should probably just leave off the ending punctuation on all of
these (looks like I goofed on items 2, 4, 5, and 8), since these are
headings and not full sentences.  For example, item 1 is "Here is a
description of how rebasing and cherry-picking work".  Titles are
often just sentence fragments because they're trying to be concise
while highlighting some kind of summary of what their
section/chapter/part/whatever contains.

> > +=== 0. Assumptions ===
> > +
> > +There are two assumptions that will hold throughout this document:
> > +
> > +  * The upstream side where commits are transplanted to is treated as the
> > +    first parent side when rebase/cherry-pick call the merge machinery
> > +
> > +  * All merges are fully automatic
> > +
>
> Did you mean that "fully automatic" merges are merges that can be done
> without conflicts?

No, as stated below when I explain that assumption, I mean "there is
no interruption for a user to resolve conflicts or to just further
edit or tweak files".  The fact that a merge can be done without
conflicts isn't enough, the user also needs to not interrupt the
process (as in using 'edit' in an interactive rebase) as well.
