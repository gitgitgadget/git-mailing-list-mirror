Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9D8AC11F65
	for <git@archiver.kernel.org>; Wed, 30 Jun 2021 14:32:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B567361477
	for <git@archiver.kernel.org>; Wed, 30 Jun 2021 14:32:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235180AbhF3OfA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Jun 2021 10:35:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234913AbhF3Oe7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Jun 2021 10:34:59 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1A24C061756
        for <git@vger.kernel.org>; Wed, 30 Jun 2021 07:32:29 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id o13-20020a9d404d0000b0290466630039caso2890567oti.6
        for <git@vger.kernel.org>; Wed, 30 Jun 2021 07:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xhKbLVd/FBb0QaNn2i8dksAKEpDJCPS/7b268gGGJQE=;
        b=PL+pp2s3lDbLyNobh/pVAnD4RMxA+V9iCWkwo/1dsjzdX/D8w7ivAgl++uX8YNE2g7
         W8298BVR9ce+JDvh+fzjNC56axxdZzBCRd4PBz2J4zPdUtREUMkVQXSw9q1rvwJlT8KL
         AZAmkAubc7/vG9/JgKjPZtfQeqtAk7lkNOzy/o1KAsmbOZsez45MZBMXwCW9u7wA2ikE
         u9UQ8G6v99Ofa+jABlraWdloikQRTe/qBsYEtTVo3SGIdNGEv6wpenRAgWXVYja70v8M
         nbJk5RyWBxfnkeqbGf5FdNTm/BBheecmLsHCu0GvOHKbtNhteWl5PSvGIBhOYZrz2v2m
         Cr1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xhKbLVd/FBb0QaNn2i8dksAKEpDJCPS/7b268gGGJQE=;
        b=e2H5DejzXC49d/iyo6bCA+rmEiFL9K3UHWTvlWWo/4FF6z9mN3yfhsyjnjK7zLtGf5
         IDMy2c5ESs0FaN8fkCc8HT9/Lg4Dh5jVud4neBrzhbhv2GiktSgjpNX1JQPJhxIrgqsg
         hm2YGw2tjjrrqrFdXOy2apd/v3AXmi5CESWLFIpbSoctka77rKhwVJufYRg5IBQ1Ay0y
         i3wXxn/GgjybteCrnIZObU2hRQuZFaQPHDxW70dKHq2/GZHBLzu22/0EIrljoH8ki6xu
         j2lblejPAqOnTt0iJff8AEG6y7RKw43JT+osbkqUz/WMFFQPg1Hu9qE3UIdAlLTo6LIy
         fL0Q==
X-Gm-Message-State: AOAM530O6mkxknttMILlEyQfLoVTTBXg8Ybqdjkxo4OgLJxwg02u0+Ew
        MwYLwwZ5YbY6VIin3CM9YQw83FTUrbX23vUKT7w=
X-Google-Smtp-Source: ABdhPJwgrzMrtYKpdcM7FhG73SigbxKJuivfiAdkfZhNR/CFgiFk83PnTWsxm5ETCAayIa4h5pO6zHXVdBnGa94JZKY=
X-Received: by 2002:a9d:7c92:: with SMTP id q18mr9404151otn.345.1625063548763;
 Wed, 30 Jun 2021 07:32:28 -0700 (PDT)
MIME-Version: 1.0
References: <pull.932.v6.git.1624931502.gitgitgadget@gmail.com> <pull.932.v7.git.1624932293.gitgitgadget@gmail.com>
In-Reply-To: <pull.932.v7.git.1624932293.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 30 Jun 2021 07:32:17 -0700
Message-ID: <CABPp-BHqoJjF9f6NKZ8jjQdj1bgUNgrwek5jcnGTRk2m-m8dBg@mail.gmail.com>
Subject: Re: [PATCH v7 00/16] Sparse-index: integrate with status
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 28, 2021 at 7:04 PM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> This is the first "payoff" series in the sparse-index work. It makes 'git
> status' very fast when a sparse-index is enabled on a repository with
> cone-mode sparse-checkout (and a small populated set).
>
> This is based on ds/sparse-index-protections AND mt/add-rm-sparse-checkout.
> The latter branch is needed because it changes the behavior of 'git add'
> around sparse entries, which changes the expectations of a test added in
> patch 1.
>
> The approach here is to audit the places where ensure_full_index() pops up
> while doing normal commands with pathspecs within the sparse-checkout
> definition. Each of these are checked and tested. In the end, the
> sparse-index is integrated with these features:
>
>  * git status
>  * FS Monitor index extension.
>
> The performance tests in p2000-sparse-operations.sh improve by 95% or more,
> even when compared with the full-index cases, not just the sparse-index
> cases that previously had extra overhead.
>
> Hopefully this is the first example of how ds/sparse-index-protections has
> done the basic work to do these conversions safely, making them look easier
> than they seemed when starting this adventure.
>
> Thanks, -Stolee
>
>
> Update in V7 (relative to v5)
> =============================
>
> APOLOGIES: As I was working on this cover letter, I was still organizing my
> big list of patches, including reordering some into this series. I forgot to
> actually include them in my v6 submission, so here is a re-submission.
> Please ignore v6.
>
> I'm sorry that this revision took so long. Initially I was blocked on
> getting the directory/file conflict figured out (I did), but also my team
> was very busy with some things. Eventually, we reached an internal deadline
> to make an experimental release available [1] with initial sparse-index
> performance boosts. Creating that included some additional review by Jeff
> Hostetler and Johannes Schindelin which led to more changes in this version.
>
> The good news is that this series has now created the basis for many Git
> commands to integrate with the sparse-index without much additional work.
> This effort was unfortunately overloaded on this series because the changes
> needed for things like 'git checkout' or 'git add' all intersect with the
> changes needed for 'git status'. Might as well get it right the first time.
>
> Because the range-diff is a big difficult to read this time, I'll break the
> changes down on a patch-by-patch basis.
>
>  1. sparse-index: skip indexes with unmerged entries
>
>     (no change)
>
>  2. sparse-index: include EXTENDED flag when expanding
>
>  * Commit message better describes the purpose of the change.
>
>  3. t1092: replace incorrect 'echo' with 'cat'
>
>  * Typo fix
>
>  4. t1092: expand repository data shape
>
>  * some files are added that surround "folder1/" immediately before and
>    after, based on the sorting with the trailing slash. This provides extra
>    coverage.
>
>  5. t1092: add tests for status/add and sparse files
>
>     (no change)
>
>  6. unpack-trees: preserve cache_bottom
>
>     (no change)
>
>  7. unpack-trees: compare sparse directories correctly
>
>  * We were previosly not comparing the path lengths, which causes a problem
>    (with later updates) when a sparse directory such as "folder1/0/" gets
>    compared to a tree name "folder1".
>
>  8. unpack-trees: rename unpack_nondirectories()
>
>  * This new commit changes the name to make more sense with its new behavior
>    that could modify a sparse directory entry. The point of the method is in
>    contrast to recursing into trees.
>
>  9. unpack-trees: unpack sparse directory entries
>
>  * THIS is the biggest change from previous versions. There were a few
>    things going on that were tricky to get right, especially with the
>    directory/file conflict (handled in an update in the following, new
>    patch).
>
>  * The changes to create_ce_entry() regarding alloc_len missed a spot that
>    was critical to getting the length right in the allocated entry.
>
>  * Use '\0' over 0 to represent the terminating character.
>
>  * We don't need a "sparse_directory" parameter to unpack_nondirectories()
>    (which was renamed to unpack_single_entry() by the previous new patch)
>    because we can use dirmask to discover if src[0] (or any other value)
>    should be a sparse directory entry.
>
>  * Similarly, we don't need to call the method twice from unpack_callback().
>
>  * The 'conflicts' variable is set to match the dirmask in the beginning,
>    but it should depend on whether or not we have a sparse directory entry
>    instead, and if all trees that have the path have a directory.
>
>  * The implementation of find_cache_entry() uses find_cache_pos() to find an
>    insertion position for a path if it doesn't find an exact match. Before,
>    we subtracted one to find the sparse directory entry, but there could be
>    multiple paths between the sparse directory entry and the insertion
>    point, so we need to walk backwards until we find it. This requires many
>    paths having the same prefix, so hopefully is a rare case. Some of the
>    test data changes were added to cover the need for this logic. This uses
>    a helper method, sparse_dir_matches_path, which is also used by
>    is_sparse_directory_entry.
>
>  10. unpack-trees: handle dir/file conflict of sparse entries
>
>  * This new logic inside twoway_merge handles the special case for dealing
>    with a directory/file conflict during a 'git checkout'. The necessarily
>    data and tests are also added here, though the logic will only take
>    serious effect when we integrate with 'git checkout' later.
>
>  11. dir.c: accept a directory as part of cone-mode patterns
>
>  * The value slash_pos was previously a pointer within a strbuf, but in some
>    cases we add to that strbuf and that could reallocate the pointer, making
>    slash_pos be invalid. The replacement is to have slash_pos be an integer
>    position within the string, so it is consistent even if the string is
>    reallocated for an append.
>
>  12. diff-lib: handle index diffs with sparse dirs
>
>  * As recommended in the previous review, a simple diff_tree_oid() replaces
>    the complicated use of read_tree_at() and traverse_trees() in the
>    previous version.
>
>  13. status: skip sparse-checkout percentage with sparse-index
>
>      (no change)
>
>  14. status: use sparse-index throughout
>
>      (no change)
>
>  15. wt-status: expand added sparse directory entries
>
>  * Duplicate 'git status --porcelain=v2' lines are removed from tests.
>
>  * The pathspec is initialized using "= { 0 }" instead of memset().
>
>  16. fsmonitor: integrate with sparse index
>
>  * An extra test_region is added to ensure that the filesystem monitor hook
>    is still being called, and we are not simply disabling the feature
>    entirely.

This is SUPER exciting.  I've only read the cover letter, but it
strongly suggests you've not only handled all my feedback in previous
rounds, but got things pretty solidly nailed away.  I'll try to make
some time to go over it all soon.
