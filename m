Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F17E8C433F5
	for <git@archiver.kernel.org>; Mon, 22 Nov 2021 16:46:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240382AbhKVQtM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 11:49:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240369AbhKVQtL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 11:49:11 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAB8EC061574
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 08:46:04 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id jo22so12836040qvb.13
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 08:46:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=/AsunvV0Jwj3TljzeW1eQl1seqqSDYZDVe/A0o8APLs=;
        b=ik5fgRqMzOxCdwLihOjPLH+gqBYjAH+Y+jTQ+Gb5p4zFBOQiIHIOhCjpJEzprev9Jc
         Qy4NIfavTGAZJ01Rsav97g6XjWUx5eB8CTaajaKO2JXVMbqm7S6hEXkH8Dc7QXAPxBfQ
         /1aGwurLRDxKMoGwsVCWFZ6Bn7X3pq7HyWWlErU1Il35LbZpeAmrAE7c+DbFNL9WInY0
         mvky3JYXQSSXehx++uvesERjVqupgW+VC1kpZFrb4jqeo+knd8uTuOtKjKawOxmdCV47
         rmGP0ISXmodkPazI2sPIX07V/r8Ns3Sd1q60TjPtTKjmlNvU1UC3H2reV7cZol5BsQIL
         qirg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/AsunvV0Jwj3TljzeW1eQl1seqqSDYZDVe/A0o8APLs=;
        b=cduv3vsgCFbPjHiHYOsR5feDEygqqW8I4qzVjGsEMRA42IH0s0nS8hBDMx7R2HMNT6
         WYBRA9GoMpjmrZF2QPwgDF8ou5MdYlzENJyFgf8+XcZVBvCnMX58w5Fx0g4eZUT1ElHQ
         49GEPmDCVpvsu+jwKzUXp62vcfKAdDBVrGY458mH7lmgrQSvolXyAMzjcLLvDTQf+H86
         Z/40ZmQxPHNHfZMZMudDye/YRBPXLeqcetLSisHz18nawV+4Dry37yc/Wxmm3tBe6/op
         HAsLKpWn71IqZC+V/msKDMTOB5HYH2weIxh8Lw4XyJZ5/DwkRLohtA5i06u/mOc6Ove4
         7wQA==
X-Gm-Message-State: AOAM532VlafMlEEjOhkrHpBcODAesJ2NithhAmUiP3wtIaCC7BtyUmNe
        XRiCjRbB6zGhSPbi4TJREu6G
X-Google-Smtp-Source: ABdhPJxX6dex4AFSIiy9OYJhpx1ci1tP+m4pUy9hiplkD4I3bMiAqfYhD8SavO1DN68ZTZRB5z8pRA==
X-Received: by 2002:ad4:5b8f:: with SMTP id 15mr102580469qvp.60.1637599563973;
        Mon, 22 Nov 2021 08:46:03 -0800 (PST)
Received: from [192.168.0.105] (70.15.20.152.res-cmts.sm.ptd.net. [70.15.20.152])
        by smtp.gmail.com with ESMTPSA id l22sm4415139qtj.68.2021.11.22.08.46.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Nov 2021 08:46:03 -0800 (PST)
Message-ID: <c97e4252-b17a-c8c1-3bde-cbfe22a6e4d5@github.com>
Date:   Mon, 22 Nov 2021 11:46:02 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.0
Subject: Re: [PATCH v3 7/8] reset: make --mixed sparse-aware
Content-Language: en-US
To:     Elijah Newren <newren@gmail.com>,
        Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <pull.1048.v2.git.1633440057.gitgitgadget@gmail.com>
 <pull.1048.v3.git.1633641339.gitgitgadget@gmail.com>
 <6ef8e4e31d39386e3a6fa1e6c24acd2c005fbd54.1633641339.git.gitgitgadget@gmail.com>
 <CABPp-BEcWutcLJWJvO-DC5B59EO4focgCJG1OWYg080j8ti44Q@mail.gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <CABPp-BEcWutcLJWJvO-DC5B59EO4focgCJG1OWYg080j8ti44Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren wrote:
> On Thu, Oct 7, 2021 at 2:15 PM Victoria Dye via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
>> From: Victoria Dye <vdye@github.com>
>>
>> Remove the `ensure_full_index` guard on `read_from_tree` and update `git
>> reset --mixed` to ensure it can use sparse directory index entries wherever
>> possible. Sparse directory entries are reset use `diff_tree_oid`, which
> 
> I am having trouble parsing this second sentence.  Was this meant to
> be 'Sparse directory entries _which_ are reset use...'?
> 

It should be "Sparse directory entries are reset _using_
`diff_tree_oid`...".

>> requires `change` and `add_remove` functions to process the internal
>> contents of the sparse directory. The `recursive` diff option handles cases
>> in which `reset --mixed` must diff/merge files that are nested multiple
>> levels deep in a sparse directory.
>>
>> The use of pathspecs with `git reset --mixed` introduces scenarios in which
>> internal contents of sparse directories may be matched by the pathspec. In
>> order to reset *all* files in the repo that may match the pathspec, the
>> following conditions on the pathspec require index expansion before
>> performing the reset:
>>
>> * "magic" pathspecs
>> * wildcard pathspecs that do not match only in-cone files or entire sparse
>>   directories
>> * literal pathspecs matching something outside the sparse checkout
>>   definition
>>
>> Helped-by: Elijah Newren <newren@gmail.com>
>> Signed-off-by: Victoria Dye <vdye@github.com>
>> ---
>>  builtin/reset.c                          | 78 +++++++++++++++++++++++-
>>  t/t1092-sparse-checkout-compatibility.sh | 17 ++++++
>>  2 files changed, 93 insertions(+), 2 deletions(-)
>>
>> diff --git a/builtin/reset.c b/builtin/reset.c
>> index 0ac0de7dc97..60517e7e1d6 100644
>> --- a/builtin/reset.c
>> +++ b/builtin/reset.c
>> @@ -148,7 +148,9 @@ static void update_index_from_diff(struct diff_queue_struct *q,
>>                  * If the file 1) corresponds to an existing index entry with
>>                  * skip-worktree set, or 2) does not exist in the index but is
>>                  * outside the sparse checkout definition, add a skip-worktree bit
>> -                * to the new index entry.
>> +                * to the new index entry. Note that a sparse index will be expanded
>> +                * if this entry is outside the sparse cone - this is necessary
>> +                * to properly construct the reset sparse directory.
>>                  */
>>                 pos = cache_name_pos(one->path, strlen(one->path));
>>                 if ((pos >= 0 && ce_skip_worktree(active_cache[pos])) ||
>> @@ -166,6 +168,73 @@ static void update_index_from_diff(struct diff_queue_struct *q,
>>         }
>>  }
>>
>> +static int pathspec_needs_expanded_index(const struct pathspec *pathspec)
>> +{
>> +       unsigned int i, pos;
>> +       int res = 0;
>> +       char *skip_worktree_seen = NULL;
>> +
>> +       /*
>> +        * When using a magic pathspec, assume for the sake of simplicity that
>> +        * the index needs to be expanded to match all matchable files.
>> +        */
>> +       if (pathspec->magic)
>> +               return 1;
>> +
>> +       for (i = 0; i < pathspec->nr; i++) {
>> +               struct pathspec_item item = pathspec->items[i];
>> +
>> +               /*
>> +                * If the pathspec item has a wildcard, the index should be expanded
>> +                * if the pathspec has the possibility of matching a subset of entries inside
>> +                * of a sparse directory (but not the entire directory).
>> +                *
>> +                * If the pathspec item is a literal path, the index only needs to be expanded
>> +                * if a) the pathspec isn't in the sparse checkout cone (to make sure we don't
>> +                * expand for in-cone files) and b) it doesn't match any sparse directories
>> +                * (since we can reset whole sparse directories without expanding them).
>> +                */
>> +               if (item.nowildcard_len < item.len) {
>> +                       for (pos = 0; pos < active_nr; pos++) {
>> +                               struct cache_entry *ce = active_cache[pos];
>> +
>> +                               if (!S_ISSPARSEDIR(ce->ce_mode))
>> +                                       continue;
> 
> This double loop over all pathspecs and over all index entries reminds
> me of the original non-cone mode sparsity patterns.  Stolee introduced
> cone mode patterns specifically to avoid the expensiveness of such
> double loops (cf.
> https://lore.kernel.org/git/19d664a5dada87a9a8dcf18d7548582275593f10.1566313865.git.gitgitgadget@gmail.com/).
> Can one of the functions he added allow us to avoid this double loop,
> or are there complications that don't allow this (e.g. the actually
> SKIP_WORKTREE paths don't quite match the requested sparsity paths in
> some cases, or here we are faced with just a leading path of multiple
> index entries)?
> 
>> +                               /*
>> +                                * If the pre-wildcard length is longer than the sparse
>> +                                * directory name and the sparse directory is the first
>> +                                * component of the pathspec, need to expand the index.
>> +                                */
>> +                               if (item.nowildcard_len > ce_namelen(ce) &&
>> +                                   !strncmp(item.original, ce->name, ce_namelen(ce))) {
>> +                                       res = 1;
>> +                                       break;
>> +                               }
>> +
>> +                               /*
>> +                                * If the pre-wildcard length is shorter than the sparse
>> +                                * directory and the pathspec does not match the whole
>> +                                * directory, need to expand the index.
>> +                                */
>> +                               if (!strncmp(item.original, ce->name, item.nowildcard_len) &&
>> +                                   wildmatch(item.original, ce->name, 0)) {
>> +                                       res = 1;
>> +                                       break;
>> +                               }
>> +                       }
>> +               } else if (!path_in_cone_mode_sparse_checkout(item.original, &the_index) &&
>> +                          !matches_skip_worktree(pathspec, i, &skip_worktree_seen))
> 
> Oh, so you can at least generally avoid the double loop.  That's good.
> So is this just a case of wildcards are special and there isn't a way,
> even in cone-mode, to avoid the double loop?
> 

The wildcard pathspecs are difficult to handle as "cleanly" as the
non-wildcard pathspecs, since the condition for expanding the index is
whether the pathspec has the potential to match some, but not all, contents
of any given sparse directory. Luckily, the double loop is constrained to
only sparse directories in the index and wildcard pathspecs, and exits as
soon as there is any indication that the index needs to be expanded.

> (Given that I'm so tardy in reviewing this, even if the answer is that
> the double loop is avoidable, or if we just don't know, I'd be totally
> fine with a 'TODO: consider whether this double loop could be avoided
> in cone mode using some kind of variant of
> path_in_cone_mode_sparse_checkout()')
> 

I had originally tried something like this, but even if a wildcard pathspec
is in-cone, it could match something outside of it. For example, '*.c' is
in-cone, but has the potential to match only some of the files in a sparse
directory containing both *.c and *.h files. 

Looking at it again, though, if you constrain
`path_in_cone_mode_sparse_checkout()` pathspecs further and require that the
only post-`nowildcard_len` characters are '*', there's no risk of matching
partial subsets of files in sparse directories. I'll add that in a re-roll.

>> +                       res = 1;
>> +
>> +               if (res > 0)
>> +                       break;
>> +       }
>> +
>> +       free(skip_worktree_seen);
>> +       return res;
>> +}
>> +
>>  static int read_from_tree(const struct pathspec *pathspec,
>>                           struct object_id *tree_oid,
>>                           int intent_to_add)
>> @@ -178,9 +247,14 @@ static int read_from_tree(const struct pathspec *pathspec,
>>         opt.format_callback = update_index_from_diff;
>>         opt.format_callback_data = &intent_to_add;
>>         opt.flags.override_submodule_config = 1;
>> +       opt.flags.recursive = 1;
>>         opt.repo = the_repository;
>> +       opt.change = diff_change;
>> +       opt.add_remove = diff_addremove;
>> +
>> +       if (pathspec->nr && the_index.sparse_index && pathspec_needs_expanded_index(pathspec))
>> +               ensure_full_index(&the_index);
>>
>> -       ensure_full_index(&the_index);
>>         if (do_diff_cache(tree_oid, &opt))
>>                 return 1;
>>         diffcore_std(&opt);
>> diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
>> index 4ac93874cb2..c9343ff5b9c 100755
>> --- a/t/t1092-sparse-checkout-compatibility.sh
>> +++ b/t/t1092-sparse-checkout-compatibility.sh
>> @@ -774,11 +774,28 @@ test_expect_success 'sparse-index is not expanded' '
>>                 ensure_not_expanded reset --hard $ref || return 1
>>         done &&
>>
>> +       ensure_not_expanded reset --mixed base &&
>>         ensure_not_expanded reset --hard update-deep &&
>>         ensure_not_expanded reset --keep base &&
>>         ensure_not_expanded reset --merge update-deep &&
>>         ensure_not_expanded reset --hard &&
>>
>> +       ensure_not_expanded reset base -- deep/a &&
>> +       ensure_not_expanded reset base -- nonexistent-file &&
>> +       ensure_not_expanded reset deepest -- deep &&
>> +
>> +       # Although folder1 is outside the sparse definition, it exists as a
>> +       # directory entry in the index, so the pathspec will not force the
>> +       # index to be expanded.
>> +       ensure_not_expanded reset deepest -- folder1 &&
>> +       ensure_not_expanded reset deepest -- folder1/ &&
>> +
>> +       # Wildcard identifies only in-cone files, no index expansion
>> +       ensure_not_expanded reset deepest -- deep/\* &&
>> +
>> +       # Wildcard identifies only full sparse directories, no index expansion
>> +       ensure_not_expanded reset deepest -- folder\* &&
>> +
>>         ensure_not_expanded checkout -f update-deep &&
>>         test_config -C sparse-index pull.twohead ort &&
>>         (
>> --
>> gitgitgadget

