Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4031C433F5
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 15:27:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D078461104
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 15:27:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234825AbhIIP23 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Sep 2021 11:28:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232557AbhIIP2U (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Sep 2021 11:28:20 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF864C061574
        for <git@vger.kernel.org>; Thu,  9 Sep 2021 08:27:10 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id i8-20020a056830402800b0051afc3e373aso2956843ots.5
        for <git@vger.kernel.org>; Thu, 09 Sep 2021 08:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3zHA2NRMyM8sjUZcbw1192xxOA065S+xQuVaBdImHgw=;
        b=qmk4dj6avNpRAXAPU2caCQrNuMlQXttXRulmjWZhk569/UsBk5lA9MEeLrBM5kH99b
         nPSs/0ai5j59NlH7zJD9UdJoY2jo11zJnchRb/9Cyz+EZG/zm1XJdVuReB5G2bubISYm
         S6Ntny2IPghOO2gglXrQR9aDJ4qFXF27EQFHGTqVXPd71iaZ7fxX1VU8asanOeQQds1/
         +ogz8i/D/ys8Vn3EmIjHzZ8uMWurIDyzIgFaGpHuFjGnNp7O9nzG1m6uxQSPRSrTd9bn
         9GVtHRr3kzXY0+6c3ghOMB256htZxNCFn7cyZ1w9JWaIGn4V1LVp8UMp8YV/C2O8uIaN
         cRXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3zHA2NRMyM8sjUZcbw1192xxOA065S+xQuVaBdImHgw=;
        b=DcBAMkR4vCMI25etZ4xnF03xPFqweDA3e8zJJe9CDmshxfqdTIPaEvls9z9w9EWZ5l
         BCTDsXGX5p35bdo3kRmVXRSM6FqZ/NT+fHx61iXwqnhZL/KHtFaarsvPioIv46cTkDIr
         5k3lc4/1tPDV6Vd/XB3UvtCu1YroTdtXymz+dDDv8oE2LU2YxA6W+6Qqshj61M2IAwuF
         H3AGz0wTuAZeIGaviEhik/rCYOomPC0lpnFgRhmGPebNTD9z8tZ8f4V/Srfykvj864yG
         8vBf/JVw7Ve7I7yraoXt9/T+5uBs0AVvGhXp1Py8jMqHaDDtlmNSpKY87Sld6BqSpFgd
         KeMg==
X-Gm-Message-State: AOAM5321RPbDHdksD1MaD169nmfrvoPNq+pkqursYaH1cpSIG/F7Uguk
        C0Rki4s0RoJDXJ3DSD5qlTLwORnGtPnqmWPEEY5Dimbw+8I=
X-Google-Smtp-Source: ABdhPJy7mdphRohG0iKHxX9bcgzU92g/NNJ4mItalkVx2nCuARi3b6NVplyD+SsJtWdR/z6/H1OvOoKl6RO65wGT4yo=
X-Received: by 2002:a05:6830:2b24:: with SMTP id l36mr376696otv.25.1631201230205;
 Thu, 09 Sep 2021 08:27:10 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1631123754.git.jonathantanmy@google.com>
In-Reply-To: <cover.1631123754.git.jonathantanmy@google.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 9 Sep 2021 08:26:58 -0700
Message-ID: <CABPp-BGKBMtue-T1ah-+RQHJ+ceYBVsqs54Vx0p-Hs+UkLXPtw@mail.gmail.com>
Subject: Re: [PATCH 0/3] More add_submodule_odb() cleanup in merge code
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 8, 2021 at 11:18 AM Jonathan Tan <jonathantanmy@google.com> wrote:
>
> (CC-ing Elijah in case he has insight into the merge-ort part.)

All the submodule merging related functions were lifted from
merge-recursive.c and minimally modified to fit the new structure.
The only substantive change I made was to fix the merge result for
virtual merge bases, but that's like one or two lines of code.  In
particular, everything relating to submodule objects was totally
untouched...and I think that's reflected in the fact that your PATCH 2
basically is the same patch twice, once for merge-recursive and once
for merge-ort.

I read over PATCH 2 and I didn't find anything that looked
problematic, but I'm not up-to-speed on the add_submodule_odb and repo
handling bits of the codebase so I'm not sure I would catch anything.
But I am encouraged by the fact that it looks like you did the same
stuff to merge-recursive and merge-ort; I'd be worried you missed
something if that weren't the case.


As a sidenote, though...

This does remind me that I noticed that the following functions from
object-store.h do not take an explicit repository:

write_object_file()
hash_object_file()
hash_object_file_literally()
force_object_loose()

I have a patch sitting around somewhere (possibly only still
referenced in my 'temp' branch) to make repo_*() variants of the above
functions, and turn the above into simple wrappers of the repo_*()
variants which just pass the_repository (much like someone else did
with read_object_file() and repo_read_object_file()).  It also updates
merge-ort to use the new repo_*() functions.  However, I ended up
excluding it from my merge-ort submissions since it wasn't necessary.
Would this be of interest in your submodule work, though?  I guess
it'd only matter if we started doing real merges of submodules as part
of a parent repo merge.  (As opposed to the fast-forward-only merges
that merge-recursive/merge-ort do right now for submodules.)

> While continuing the effort into removing add_submodule_odb() (as part
> of the submodule partial clone effort) I came across this part of the
> merge code that specifies the repository being operated on in two ways:
> one as a struct repository pointer and the other as a path. This patch
> set unifies the two.
>
> I normally would not send refactoring patches unless I also have a
> feature patch that uses the results of said refactoring, but in this
> case, I think that these patches are worth having since they clarify a
> potentially unclear part of the API.
>
> Note that these patches mean that the merging code no longer supports
> submodules that have their .git dirs in the worktree, but from what I
> can tell, this seems to be the direction we're going in
> (repo_submodule_init() does not support such submodules).
>
> Patch 3 is included to show how I'm verifying some things. Including
> something like that in the master branch would probably require
> conditional compilation (to exclude the additional field in struct
> object used for checking, among other things), so I'm just including it
> here for informational purposes.
>
> All these patches work under GIT_TEST_MERGE_ALGORITHM=recursive and
> GIT_TEST_MERGE_ALGORITHM=ort (and when that envvar is unset, for good
> measure).
>
> Jonathan Tan (3):
>   t6437: run absorbgitdirs on repos
>   revision: remove "submodule" from opt struct
>   DO NOT SUBMIT commit-reach,revision: verify non-mixing
>
>  alloc.c                    |  2 +
>  commit-reach.c             | 60 +++++++++++++++++-------
>  merge-ort.c                | 55 +++++++++++++++-------
>  merge-recursive.c          | 51 +++++++++++++-------
>  object.h                   |  1 +
>  revision.c                 | 96 ++++++++++++++++++++++----------------
>  revision.h                 |  1 -
>  t/t6437-submodule-merge.sh |  9 ++--
>  8 files changed, 179 insertions(+), 96 deletions(-)
>
> --
> 2.33.0.309.g3052b89438-goog
>
