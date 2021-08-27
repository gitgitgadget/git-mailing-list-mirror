Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 457B8C432BE
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 22:56:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1278F60FC4
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 22:56:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232340AbhH0W5q (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Aug 2021 18:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232289AbhH0W5o (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Aug 2021 18:57:44 -0400
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2EAEC0613D9
        for <git@vger.kernel.org>; Fri, 27 Aug 2021 15:56:54 -0700 (PDT)
Received: by mail-oo1-xc35.google.com with SMTP id m11-20020a056820034b00b0028bb60b551fso2474756ooe.5
        for <git@vger.kernel.org>; Fri, 27 Aug 2021 15:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sZFakbNTwk6ssmcgRfjGg5Rhjb/Qk+QPyPvq4c3f6Tg=;
        b=K5akhsdJsyAZtNdUwhnUeT69cQ9mfjSC2u3i+3gz/gqVDPVb1QhEq055lR2RRHBnpe
         1XUvyL3/AhLyCEfCht86iBXke2AL7/VR7SUrgy0iHYLRcRumMLP2LRKWOm2UYF67t7m7
         AwkJccl34EjzW+kyjY5JbKEVFmug2TYeC8v0XpKdZ5VJv2zba2mPe+TZnOvu0ExsDqyE
         kdH0JOkPbhZUQ1uHmeBdMQDnv67Fm8oQVF+8gDXXbUITVRWIfMiArJa1QBntFXtVZZwd
         JkLE+cT3ISyMpH+SDf+rWDyye7fuHC7tBvxk24T8YjhhXWQ4mE5sF0IhNVf1feSQVg69
         LKjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sZFakbNTwk6ssmcgRfjGg5Rhjb/Qk+QPyPvq4c3f6Tg=;
        b=tGeklL0iWSWKZPYyQQdUyhw6UQNkuKBfe4UMLlMO+b6Rf+4meDQxyG2ubArg7qPtQH
         CZxuTuPvJuLXyT2TzFbqg7l2qNeyjnnKFvE/i2SxoPSMN8iECQkzfe+pH6olWxjBJy1/
         rZTeg8SKOWqLtgCZjuzk8cVsfA5kn6r/02gT01lGmPgrcYcW7dlF8+LE4C4Vk/eCn6iE
         oETYvzEZ4ngwNn0hJgRfEf7lQlTP/e4RpIyzzKLotEMbAD5j3P4Z2ryDASYAQiabwgGk
         McxfomkYauT4yUEJ+39egGRRbh3Asp1ZK/cAxD2SYNVr5vGlyi66ITYn61MY4gJ5yaU7
         wD9A==
X-Gm-Message-State: AOAM5321yHVdHNBUWkVi/1OWAdNKVdq8wZGuZ3WVXTrWjQC+uiAtX6Cd
        pXC0WSvx6Y+K+xdKEfnQl7S4zLl7gvmgplZyIJM=
X-Google-Smtp-Source: ABdhPJzH1oy0htCBhkW4R35yJsOV7tv4IjwvYoP9FklCedcFFr2RKSjF3pih1E01xNagMeJjR+SdP1vMSXs1G7s1UHU=
X-Received: by 2002:a4a:11c6:: with SMTP id 189mr928295ooc.32.1630105013428;
 Fri, 27 Aug 2021 15:56:53 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1019.git.1629220124.gitgitgadget@gmail.com> <pull.1019.v2.git.1629841965.gitgitgadget@gmail.com>
In-Reply-To: <pull.1019.v2.git.1629841965.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 27 Aug 2021 15:56:42 -0700
Message-ID: <CABPp-BFXk++dktLnaTTuCe+keqkNuPzGyVi4uFsOpE4VxqAUdw@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] Sparse Index: Integrate with merge, cherry-pick,
 rebase, and revert
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 24, 2021 at 2:52 PM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> This series integrates the sparse index with commands that perform merges
> such as 'git merge', 'git cherry-pick', 'git revert' (free with
> cherry-pick), and 'git rebase'.
>
> When the ORT merge strategy is enabled, this allows most merges to succeed
> without expanding the sparse index, leading to significant performance
> gains. I tested these changes against an internal monorepo with over 2
> million paths at HEAD but with a sparse-checkout that only has ~60,000 files
> within the sparse-checkout cone. 'git merge' commands went from 5-6 seconds
> to 0.750-1.250s.
>
> In the case of the recursive merge strategy, the sparse index is expanded
> before the recursive algorithm proceeds. We expect that this is as good as
> we can get with that strategy. When the strategy shifts to ORT as the
> default, then this will not be a problem except for users who decide to
> change the behavior.
>
> Most of the hard work was done by previous series, such as
> ds/sparse-index-ignored-files (which this series is based on).
>
>
> Updates in V2
> =============
>
>  * The tests no longer specify GIT_TEST_MERGE_ALGORITHM or directly
>    reference "-s ort". By relaxing this condition, I found an issue with
>    'git cherry-pick' and 'git rebase' when using the 'recursive' algorithm
>    which is fixed in a new patch.
>
>  * Use the pul.twohead config to specify the ORT merge algorithm to avoid
>    expanding the sparse index when that is what we are testing.

pull.twohead, not pul.twohead.

I'm curious, though, why use it instead of just setting
GIT_TEST_MERGE_ALGORITHM=ort?  That'd seem to avoid the need for the
explicit subshells and the sane_unset calls.

>
>  * Corrected some misstatements in my commit messages.

I read over v2.  Other than some minor questions about whether using
GIT_TEST_MERGE_ALGORITHM=ort would be easier, and a typo still present
from v1, the series looks good to me.
