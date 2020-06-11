Return-Path: <SRS0=QgeI=7Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D927C433E0
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 07:01:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE14D2072F
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 07:01:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Znugccdc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbgFKHBE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Jun 2020 03:01:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726547AbgFKHBD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jun 2020 03:01:03 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC472C08C5C1
        for <git@vger.kernel.org>; Thu, 11 Jun 2020 00:01:02 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id t25so4521773oij.7
        for <git@vger.kernel.org>; Thu, 11 Jun 2020 00:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5/2LzODUXfjUgti3upNwi1KzM6GuRk8DoG7B7tGUers=;
        b=ZnugccdcX0q7dm2aUHMbv6A3gcmMCt8cjr2l+mRVle86z5x4FhEOtgv6UAIzUViVVX
         HoO33o88RNzbLVRkl/WNUGHjr14cBCzmHqm2jSw5tP4+xqmy2D7ZeIHDhfRqFMyuXKDp
         Eogipe+F7wQgwv3Y0XeEAqHtOKKRA8p2Dtu2Nb8lLt8UtPz5nrr89h9qraSBmwzqzDZv
         w3h9kDvZqDMPJrPrv7hqihs/YCdsEoU1BSf+CLEBK1klEW/SvzMQjqQTmWvNnCaCEU2X
         sM0XWl4yEpE0hRNI7JXOQrW2TDXLMyZa8MjuSa413q526mBLYLsiejIpshs20rk9P/6h
         cOZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5/2LzODUXfjUgti3upNwi1KzM6GuRk8DoG7B7tGUers=;
        b=Jx8o7pHYWd75k/QuoYuVtr5VXzvquAhgVssLWEgyaoArYjGbjUTiheias0T1Ii1TZj
         krTo/yPUxz4ukoOJDqHG6qOsJ712UxmU0nfRD2UDKhZnoNADYtB+rdZtnqYDS8jAopcx
         /1iqjpgNiEPowxZOUwT51/qqChOg4Xu7aeu7KtixUuUP8GRLc6ONriY1WGr21g16iW2X
         2ztUd4Te8t5MNir1pU5OvwXTMQdLU9gdSBCXAzSWU7jlb9BOs2iC3BTD0MwI0uLF8rPu
         IdGHIXexCxm54rbEkjctVKUDc76fm2WS+dEENhvswB1FihJsK35SBoVSrlGvgD939wMt
         J7Jw==
X-Gm-Message-State: AOAM531O8TsSex3q759EBZtu4QdHbeV+5OrElqysxwUmZU3+m2mk6D3R
        LUPtuXcyJpNWKCKtW2jKCGkSyCL8KkQEHCJU2tA=
X-Google-Smtp-Source: ABdhPJzureX9nPMQNCMaQScFHw8jm+IulrSegn+S/Gdy3tecqlae61LB1RuMuw4V82/cu7HJsK+R50+cYhlg+FGk7Lw=
X-Received: by 2002:a05:6808:4b:: with SMTP id v11mr5103956oic.31.1591858861331;
 Thu, 11 Jun 2020 00:01:01 -0700 (PDT)
MIME-Version: 1.0
References: <pull.805.git.git.1591831009762.gitgitgadget@gmail.com>
In-Reply-To: <pull.805.git.git.1591831009762.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 11 Jun 2020 00:00:50 -0700
Message-ID: <CABPp-BGVB3XNT=yrfnwX63V9ZbH-UxetDJ0ND3Or6TxBiMfHNw@mail.gmail.com>
Subject: Re: [PATCH] git-sparse-checkout: clarify interactions with submodules
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 10, 2020 at 4:16 PM Elijah Newren via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Elijah Newren <newren@gmail.com>
>
> Ignoring the sparse-checkout feature momentarily, if one has a submodule and
> creates local branches within it with unpushed changes and maybe adds some
> untracked files to it, then we would want to avoid accidentally removing such
> a submodule.  So, for example with git.git, if you run
>    git checkout v2.13.0
> then the sha1collisiondetection/ submodule is NOT removed even though it
> did not exist as a submodule until v2.14.0.  Similarly, if you only had
> v2.13.0 checked out previously and ran
>    git checkout v2.14.0
> the sha1collisiondetection/ submodule would NOT be automatically
> initialized despite being part of v2.14.0.  In both cases, git requires
> submodules to be initialized or deinitialized separately.  Further, we
> also have special handling for submodules in other commands such as
> clean, which requires two --force flags to delete untracked submodules,
> and some commands have a --recurse-submodules flag.
>
> sparse-checkout is very similar to checkout, as evidenced by the similar
> name -- it adds and removes files from the working copy.  However, for
> the same avoid-data-loss reasons we do not want to remove a submodule
> from the working copy with checkout, we do not want to do it with
> sparse-checkout either.  So submodules need to be separately initialized
> or deinitialized; changing sparse-checkout rules should not
> automatically trigger the removal or vivification of submodules.
>
> I believe the previous wording in git-sparse-checkout.txt about
> submodules was only about this particular issue.  Unfortunately, the
> previous wording could be interpreted to imply that submodules should be
> considered active regardless of sparsity patterns.  Update the wording
> to avoid making such an implication.  It may be helpful to consider two
> example situations where the differences in wording become important:
>
> In the future, we want users to be able to run commands like
>    git clone --sparse=moduleA --recurse-submodules $REPO_URL
> and have sparsity paths automatically set up and have submodules *within
> the sparsity paths* be automatically initialized.  We do not want all
> submodules in any path to be automatically initialized with that
> command.
>
> Similarly, we want to be able to do things like
>    git -c sparse.restrictCmds grep --recurse-submodules $REV $PATTERN
> and search through $REV for $PATTERN within the recorded sparsity
> patterns.  We want it to recurse into submodules within those sparsity
> patterns, but do not want to recurse into directories that do not match
> the sparsity patterns in search of a possible submodule.
>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>     git-sparse-checkout: clarify interactions with submodules
>
>     gitgitgadget is going to treat this like V1, but it's really V2. V1 was
>     an inline scissors patch.
>
>     Changes since V1:

To make the record easier for those looking over the archives, V1 is
over here: https://lore.kernel.org/git/20200522142611.1217757-1-newren@gmail.com/


>      * More wording clarifications in areas pointed out by Stolee, and using
>        some of his suggested wording.
>      * In particular, given that the final sentence from V1 was causing lots
>        of problems, I just stepped back and painted a very broad stroke for
>        end users that I think will make sense to them: we have two reasons
>        tracked files might be missing from the working copy, so there are
>        two things that might limit commands that search through tracked
>        files in the working copy. Greater detail about if or how they are
>        limited can be left to the manpages of individual subcommands.
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-805%2Fnewren%2Fsparse-submodule-interactions-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-805/newren/sparse-submodule-interactions-v1
> Pull-Request: https://github.com/git/git/pull/805
>
>  Documentation/git-sparse-checkout.txt | 30 +++++++++++++++++++++++----
>  1 file changed, 26 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/git-sparse-checkout.txt b/Documentation/git-sparse-checkout.txt
> index 1a3ace60820..c7feaeca110 100644
> --- a/Documentation/git-sparse-checkout.txt
> +++ b/Documentation/git-sparse-checkout.txt
> @@ -200,10 +200,32 @@ directory.
>  SUBMODULES
>  ----------
>
> -If your repository contains one or more submodules, then those submodules will
> -appear based on which you initialized with the `git submodule` command. If
> -your sparse-checkout patterns exclude an initialized submodule, then that
> -submodule will still appear in your working directory.
> +If your repository contains one or more submodules, then submodules
> +are populated based on interactions with the `git submodule` command.
> +Specifically, `git submodule init -- <path>` will ensure the submodule
> +at `<path>` is present, while `git submodule deinit [-f] -- <path>`
> +will remove the files for the submodule at `<path>` (including any
> +untracked files, uncommitted changes, and unpushed history).  Similar
> +to how sparse-checkout removes files from the working tree but still
> +leaves entries in the index, deinitialized submodules are removed from
> +the working directory but still have an entry in the index.
> +
> +Since submodules may have unpushed changes or untracked files,
> +removing them could result in data loss.  Thus, changing sparse
> +inclusion/exclusion rules will not cause an already checked out
> +submodule to be removed from the working copy.  Said another way, just
> +as `checkout` will not cause submodules to be automatically removed or
> +initialized even when switching between branches that remove or add
> +submodules, using `sparse-checkout` to reduce or expand the scope of
> +"interesting" files will not cause submodules to be automatically
> +deinitialized or initialized either.
> +
> +Further, the above facts mean that there are multiple reasons that
> +"tracked" files might not be present in the working copy: sparsity
> +pattern application from sparse-checkout, and submodule initialization
> +state.  Thus, commands like `git grep` that work on tracked files in
> +the working copy may return results that are limited by either or both
> +of these restrictions.
>
>
>  SEE ALSO
>
> base-commit: 87680d32efb6d14f162e54ad3bda4e3d6c908559
> --
> gitgitgadget
