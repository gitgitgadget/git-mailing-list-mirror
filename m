Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50469C433F5
	for <git@archiver.kernel.org>; Fri,  6 May 2022 07:47:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389676AbiEFHup (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 May 2022 03:50:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236048AbiEFHuo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 May 2022 03:50:44 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3672E674E2
        for <git@vger.kernel.org>; Fri,  6 May 2022 00:47:02 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id i19so12862722eja.11
        for <git@vger.kernel.org>; Fri, 06 May 2022 00:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LsZCbG6khWev3ppxaNrKHfOEA2TcYw+sQiLxv84si5E=;
        b=gKK4AQEo6Rb/UFwgMryMmuugc8Oe6JorLOnnkjj23uYhLneVfmdNmaxGxCrhHW25Md
         MmgehPvZt8ozg2MOQ8/f0NkI3NHnTOSBFfY1TDZH32fIWYrVQtH74OaHGYNx/crLHRwH
         /BbculhLorLsfvVdb5Gx6AbvChyBJ2QcM/Kf8/N6H69E8R9gikW+WgemkshxYwV5Xpnl
         QRu7kBzmdLaBvduVZ/pYWIXY19MFcpGFWEPgRdOLcPEvmdwOzEcUz7kKaJSbUOKE6n+C
         l1N7SKJxFXs2jkHQgqq599PzoLq2uyQd2JR9ttXElq3T5fRavmEKUs4kt0SpiubvrIJF
         1xOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LsZCbG6khWev3ppxaNrKHfOEA2TcYw+sQiLxv84si5E=;
        b=QX2cSXlateS56LQbrrGYkQvFK2K3ejD6oYJxVPM7MFt7o44t8VIoS0KeAFlD91kviL
         obWTNzb5eW0Ebey5K46jNbqdcaOAf0RKh5mg6VYNl4S+L5K/UPbePpH3f468XU17ga8a
         9UJLYsGKg4Tly0sdHmaHsAYkNEFg7SRjXq64VzF/9KcfRoGeIKJ8A9NWOu+Jjx8NFol4
         t2BVvqUy8vQSdn3SGE6nHjYMZd43V38dZYh/1CNVSnjYQnuolu3sIevL+vOMXMHAJ4a1
         IMZfYbOHToFEbBfWbpF3Fn5n7TJbWI6HWswAovX2Yrv2ttrSbvU6RQMO89bKGY3gS5jK
         OU2w==
X-Gm-Message-State: AOAM533hlbkzj5BluWAtTLihU6sXYXKr5lmlknnZY3saOR/EiWzqlZ+O
        KoVVFfhrl6bx+fymujCu7bJvqaaVwkWNzOVFZmM=
X-Google-Smtp-Source: ABdhPJzaCK36BZE/400owgc7J2k7XYfAyWJYZFJ9GZTxQSXtoQQVjGOl7UC/sJlk1A4iSWnmNOThfqyC77i+LSK5rpk=
X-Received: by 2002:a17:907:7f26:b0:6f4:69c:196f with SMTP id
 qf38-20020a1709077f2600b006f4069c196fmr1738486ejc.613.1651823220662; Fri, 06
 May 2022 00:47:00 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1171.git.1650908957.gitgitgadget@gmail.com> <pull.1171.v2.git.1651083378.gitgitgadget@gmail.com>
In-Reply-To: <pull.1171.v2.git.1651083378.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 6 May 2022 00:46:49 -0700
Message-ID: <CABPp-BFANwZn73w8zrVySB7mh0bQQBdGJjBuSJy50UOeyYT6aA@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] Sparse index: integrate with 'git stash'
To:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>,
        Victoria Dye <vdye@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 27, 2022 at 11:16 AM Victoria Dye via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> This series, in combination with the sparse index integrations of reset [1],
> update-index [2], checkout-index [2], clean [2], and read-tree [3], allows
> most subcommands of 'git stash' to use the sparse index end-to-end without
> index expansion.

I've read through the series.  Like Stolee, I'm pleased with how
simple some of the code changes are (much due to prior hard work in
the area) and how nicely you describe the changes.

At first when I was reading through, I was again a bit disappointed
that we're just converting the subcommands stash uses instead of
fixing stash to stop forking subprocesses, but...then I realized this
served as a forcing function of sorts to make more of Git sparse-index
compatible, so I think it's actually the better route.  We can always
make the orthogonal fixes to stash's implementation design later.  :-)

However, there is one small issue around the way merging is handled...

> Like the earlier series, this series starts with new tests ensuring
> compatibility of the sparse index with non-sparse index full and sparse
> checkouts [1/7]. Next, sparse index is trivially enabled [2/7].
> Functionally, sparse index-enabled sparse-checkouts remain compatible with
> non-sparse index sparse-checkouts, but there are still some cases where the
> index (or a temporary index) is expanded unnecessarily. These cases are
> fixed in three parts:
>
>  * First, 'git stash -u' is made sparse index-compatible by ensuring the
>    "temporary" index holding the stashed, untracked files is created as a
>    sparse index whenever possible (per repo settings &
>    'is_sparse_index_allowed()'). Patch [3/7] exposes
>    'is_sparse_index_allowed()' to files outside of 'sparse-index.c', then
>    patch [4/7] uses that function to mark the temporary index sparse when
>    appropriate.
>  * Next, 'git stash (apply|pop)' are made sparse index-compatible by
>    changing their internal "merge" function (executed via
>    'merge_recursive_generic()') from 'merge_recursive()' to
>    'merge_ort_recursive()'. This requires first allowing
>    'merge_recursive_generic()' to accept a merge function as an input
>    (rather than hardcoding use of 'merge_recursive()') in patch [5/7], then
>    changing the call in 'stash.c' to specify 'merge_ort_recursive()' in
>    patch [6/7]. See note [4] for possible alternate implementations.
>  * Finally, while patches 5 & 6 avoid index expansion for most cases of 'git
>    stash (apply|pop)', applying a stash that includes untracked files still
>    expands the index. This is a result of an internal 'read-tree' execution
>    (specifically in its 'unpack_trees' call) creating a result index that is
>    never sparse in-core, thus forcing the index to be unnecessarily
>    collapsed and re-expanded in 'do_write_locked_index()'. In patch [7/7],
>    'unpack_trees' is updated to set the default sparsity of the resultant
>    index to "sparse" if allowed by repo settings and
>    'is_sparse_index_allowed()' (similar to the change in patch 4).
>
> Performance results (from the 'p2000' tests):
>
> (git stash &&
>  git stash pop)              master            this series
> ---------------------------------------------------------------------
> full-v3                      4.07(2.42+1.34)   3.98(2.42+1.32) -2.2%
> full-v4                      4.05(2.46+1.31)   4.00(2.49+1.29) -1.2%
> sparse-v3                    7.48(4.81+2.57)   1.53(0.26+1.61) -79.5%
> sparse-v4                    7.35(4.74+2.54)   1.59(0.27+1.63) -78.4%
>
> (echo >>new &&
>  git stash -u &&
>  git stash pop)              master            this series
> ---------------------------------------------------------------------
> full-v3                      4.21(2.62+1.45)   4.11(2.55+1.44) -2.4%
> full-v4                      4.11(2.51+1.41)   4.02(2.49+1.41) -2.2%
> sparse-v3                    7.35(4.64+2.66)   1.70(0.32+1.64) -76.9%
> sparse-v4                    7.74(4.87+2.83)   1.70(0.32+1.66) -78.0%
>
>
>
> Changes since V1
> ================
>
>  * Added quotes to the "$WITHOUT_UNTRACKED_TXT" when testing for it in
>    'ensure_not_expanded' (in 't/t1092-sparse-checkout-compatibility.sh')
>  * Moved the 'stash' test in 't1092' elsewhere in the file, so that it
>    doesn't conflict (even trivially) with the also-in-flight 'git show'
>    integration
>  * Moved the 'ensure_not_expended' tests for 'checkout-index' back to
>    original location
>
> [1]
> https://lore.kernel.org/git/pull.1048.v6.git.1638201164.gitgitgadget@gmail.com/
> [2]
> https://lore.kernel.org/git/pull.1109.v2.git.1641924306.gitgitgadget@gmail.com/
> [3]
> https://lore.kernel.org/git/pull.1157.v3.git.1646166271.gitgitgadget@gmail.com/
> [4] I went with changing 'stash' to always use 'merge-ort' in
> 'merge_recursive_generic()' as a sort of "middle ground" between "replace
> 'merge_recursive()' with 'merge_ort_recursive()' in all of its hardcoded
> internal usage" and "only use 'merge-ort' if using a sparse index in 'git
> stash', otherwise 'merge-recursive'". The former would extend the use of
> 'merge-ort' to 'git am' and 'git merge-recursive', whereas the latter is a
> more cautious/narrowly-focused option. If anyone has any other thoughts, I'm
> interested in hearing them.

I understand that you'd want to modify and use
merge_recursive_generic() in order to make the smallest code change
possible, but merge_recursive_generic() has no equivalent in ort
because during the review of ort, we discovered that porting over
merge_recursive_generic() meant porting bugs.  We need to fix those
bugs.  However, in the case of stash, I think we can just sidestep
those bugs. stash probably only uses merge_recursive_generic() because
it was the easiest transliteration of shell (which originally invoked
git-merge-recursive), as opposed to the best conversion.  The best
conversion at the time would have been to call merge_trees() instead
(stash doesn't need recursiveness, and tends to have commits available
rather than just trees).  I'd like to see us modify stash to call
merge_incore_nonrecursive() directly (and/or merge_trees() if we're
supporting using both merge-ort and merge-recursive backends).

No need to worry about git-am or git-merge-recursive for now; we can
replace/fix/update their calls to merge_recursive_generic() later.
