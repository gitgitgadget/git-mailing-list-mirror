Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B99AC4338F
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 21:33:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 105FC610FF
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 21:33:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240757AbhHTVdp (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Aug 2021 17:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240615AbhHTVdp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Aug 2021 17:33:45 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDBD2C061575
        for <git@vger.kernel.org>; Fri, 20 Aug 2021 14:33:06 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id h63-20020a9d14450000b02904ce97efee36so17084890oth.7
        for <git@vger.kernel.org>; Fri, 20 Aug 2021 14:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lagvhVZfx+4jXQfy6x89T7se64v/LUdeFmp6OZfiO9A=;
        b=UCb7zYkUZ/IjrsvRkSB9pF74BjYXKJCBSbz9NRxG1Fz7/L+XIZyO9BF5pZocJ8uL0e
         iYU6b4lwN5Blr5ZWrJ+DZ3sJXlqGgC0fvzCzNxniJHcL2mhnyvey+Juabq07mt6HKSZX
         PykAIgZ6YpkhI4R9Glb0HkBeNqKGOgBmFA6WU9m3h9DizVpbh/3z9C/icSUMF6XVu3gX
         hChXFnhXFCWxQ3C7qwxSook2HaMIVN2SpLL7ucOBPCih5pn9fdAW9pcokCJU3DV12Z+f
         I1kCAvOfm2fXO7BStqJLwUwnz/LclS1a251W7ZiYhEb//5L457YmBu0MzgN0B+ULrO1Y
         5MGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lagvhVZfx+4jXQfy6x89T7se64v/LUdeFmp6OZfiO9A=;
        b=Wy2tGhuP3aOOwdyUG1bqisB862ep7kTO83kmg9LiflpFVp2u/UW5yq6HUqmQRNJg5A
         RgU5il4N8ZEIfx/K7QHz/I6q2FSGKYN/4wR86ayOtCbLA548sD/KJ1KguFRhzlEa84bm
         PFMXs4KjhO3oLtlpIZ6LyQcZCCUDvY1qcotYbBowWBlNQO8o6M2tqSVRgu5DSJbZ6a3d
         eKRVrH668v6z2V3fMII0Rh5DqmmhRt0UXhmRASC+UlRP0lNR2OEWDwqReLA25jhWpNXt
         EwbS2b61UIyTPcDQKEgW6ssJQBRJjHsSJmdw5CEJe3UWeTfZnUrNT3L55qjolyPGKXi4
         EI9A==
X-Gm-Message-State: AOAM533gnbxoY1nP9fih8+otz3Pysp5TTe/y1yzS/PG8cNUsEATQjnVA
        95rZnaA+dq7tKnaX77nAvNls7fsl0OK8vrPHxtw=
X-Google-Smtp-Source: ABdhPJxDxKrYcIapCJAvv6GQxnXbNfEpw2GF1OJ5fxKXkakGOHpy/+9zffHds9HFUCz3a2nTV5/4K+6PI+6rZlzaTOQ=
X-Received: by 2002:a05:6808:1787:: with SMTP id bg7mr4503971oib.39.1629495186144;
 Fri, 20 Aug 2021 14:33:06 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1019.git.1629220124.gitgitgadget@gmail.com> <9f50f11d394e46ffbe348a579792c2b683096452.1629220124.git.gitgitgadget@gmail.com>
In-Reply-To: <9f50f11d394e46ffbe348a579792c2b683096452.1629220124.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 20 Aug 2021 14:32:55 -0700
Message-ID: <CABPp-BFu29JHkoBERcVnV_NooSaVDrFEiR-NQRu-ehTC4iRHiQ@mail.gmail.com>
Subject: Re: [PATCH 2/6] diff: ignore sparse paths in diffstat
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 17, 2021 at 10:08 AM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Derrick Stolee <dstolee@microsoft.com>
>
> The diff_populate_filespec() method is used to describe the diff after a
> merge operation is complete, especially when a conflict appears. In
> order to avoid expanding a sparse index, the reuse_worktree_file() needs
> to be adapted to ignore files that are outside of the sparse-checkout
> cone. The file names and OIDs used for this check come from the merged
> tree in the case of the ORT strategy, not the index, hence the ability
> to look into these paths without having already expanded the index.

I'm confused; I thought the diffstat was only shown if the merge was
successful, in which case there would be no conflicts appearing.

Also, I'm not that familiar with the general diff machinery (just the
rename detection parts), but...if the diffstat only shows when the
merge is successful, wouldn't we be comparing two REVS (ORIG_HEAD to
HEAD)?  Why would we make use of the working tree at all in such a
case?  And, wouldn't using the working tree be dangerous...what if
there was a merge performed with a dirty working tree?

On a bit of a tangent, I know diffcore-rename.c calls into
diff_populate_filespec() as well, and I have some code doing merges in
a bare repository (where there obviously is no index).  It seemed to
be working, but given this commit message, now I'm wondering if I've
missed something fundamental either in that implementation or there's
something amiss in this patch.  Or both.  Maybe I need to dig into
diff_populate_filespec() more, but it seems you already have.  Any
pointers to orient me on why your changes are right here (and, if you
know, why diffcore-rename.c should or shouldn't be using
diff_populate_filespec() in a bare repo)?


> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  diff.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/diff.c b/diff.c
> index a8113f17070..c457cfa0e59 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -26,6 +26,7 @@
>  #include "parse-options.h"
>  #include "help.h"
>  #include "promisor-remote.h"
> +#include "dir.h"
>
>  #ifdef NO_FAST_WORKING_DIRECTORY
>  #define FAST_WORKING_DIRECTORY 0
> @@ -3900,6 +3901,13 @@ static int reuse_worktree_file(struct index_state *istate,
>         if (!FAST_WORKING_DIRECTORY && !want_file && has_object_pack(oid))
>                 return 0;
>
> +       /*
> +        * If this path does not match our sparse-checkout definition,
> +        * then the file will not be in the working directory.
> +        */
> +       if (!path_in_sparse_checkout(name, istate))
> +               return 0;
> +
>         /*
>          * Similarly, if we'd have to convert the file contents anyway, that
>          * makes the optimization not worthwhile.
> --
> gitgitgadget
>
