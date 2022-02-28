Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D432AC433FE
	for <git@archiver.kernel.org>; Mon, 28 Feb 2022 18:24:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240632AbiB1SYv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Feb 2022 13:24:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240132AbiB1SYl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Feb 2022 13:24:41 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 518B88567C
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 10:04:44 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id m13-20020a17090aab0d00b001bbe267d4d1so325550pjq.0
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 10:04:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=dRjea/YIAF6UtSbwN8DiP92yRVY2Yhdi3FfbVtmNTBg=;
        b=VsmWqC5cdcoYj60cDkVKS8VBMnX2RoswODqTWJb0pQSmlQgmp97tgpRCG3zt8WVSda
         +UKLtI7a64xX0NkcxBNRLHYWSo6BGNvplBouQV8UfO2tva14wDtc3Y3C7oDT6LUJV+mB
         AMkc06Fq4DbWgIDzi83We4TkK7rwqwLCAtTon/MZIPxtgdb2dFdnbDsPNF5eWEAjgUsd
         AGrY41pZ1hxb2DXjuIlw9MbxPN2WOKEQhvAN9+f91SoWMN4qaL2WWNp0imi2dhMc5Rqy
         Z3t9bsXUrwptmizKhp2BuZPyBjaQ13YdlymgUjZdmANlNwDK/+JOls/eoqQNU97FxHV/
         ++MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=dRjea/YIAF6UtSbwN8DiP92yRVY2Yhdi3FfbVtmNTBg=;
        b=GeYjV8Dt+8OlerqcYKqNQ1pJFpZoTM4FxvfvlSWkncT3pjF5LYTLBEXsjhTu53j10B
         PXdguqBt6tmUnCUM9DTAn+yDQ0cSFMpd7eJWWC5F6CrAhIaOqj2zt3HMouQ19jww/4pp
         yZ6OkrrhW8+xk8vW9iMtmboneobZeKF4LRjL87T9O896Z3I9Sup3aiWjBsfWRESVMoQp
         fqBpcgOCFUvk5JcL8hJJ6c7uN0Z6ivfWAso52NXPHBPY9loY88PoF0u+D5wIGNlWrMzQ
         olcOvStY6AYujeJ/PBTtKnjO0RjC5PwrzeGJqW6cDim/ZliaNz1Z7ThIQrhbL3wJuHMV
         K3+A==
X-Gm-Message-State: AOAM530Y6OxJilga++U09sxgLrUNWEGG6Ij5mTqPNrTBlLrILdAVwUlH
        MU9Pu3xJK1yH7+t6P1+reDW1pLybZhhr
X-Google-Smtp-Source: ABdhPJwVco3rq8YVMEy1+CMjaMWD0X+i7Q8bE2Z44NVES51H6Pyh0cbA8UKPCTKtbkXLuxU9k32sog==
X-Received: by 2002:a17:902:7e08:b0:151:65dd:a2d1 with SMTP id b8-20020a1709027e0800b0015165dda2d1mr6779173plm.66.1646071483290;
        Mon, 28 Feb 2022 10:04:43 -0800 (PST)
Received: from [192.168.0.102] (cpe-172-249-73-112.socal.res.rr.com. [172.249.73.112])
        by smtp.gmail.com with ESMTPSA id w16-20020aa79a10000000b004e1bb6ea986sm13924327pfj.133.2022.02.28.10.04.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Feb 2022 10:04:43 -0800 (PST)
Message-ID: <dc47f12b-8724-22ef-ed2c-096badfafd76@github.com>
Date:   Mon, 28 Feb 2022 10:04:41 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH 6/7] read-tree: make two-way merge sparse-aware
Content-Language: en-US
To:     Elijah Newren <newren@gmail.com>,
        Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>
References: <pull.1157.git.1645640717.gitgitgadget@gmail.com>
 <9fdcab038b2962b7f954363e32d04591476cf219.1645640717.git.gitgitgadget@gmail.com>
 <CABPp-BHihsVQZWTE4ppOcFyk8-eVa+zZ1MhkssiTByxjPO4kcg@mail.gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <CABPp-BHihsVQZWTE4ppOcFyk8-eVa+zZ1MhkssiTByxjPO4kcg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren wrote:
> On Wed, Feb 23, 2022 at 4:09 PM Victoria Dye via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
>> From: Victoria Dye <vdye@github.com>
>>
>> Enable two-way merge with 'git read-tree' without expanding the sparse
>> index. When in a sparse index, a two-way merge will trivially succeed as
>> long as there are not changes to the same sparse directory in multiple trees
>> (i.e., sparse directory-level "edit-edit" conflicts). If there are such
>> conflicts, the merge will fail despite the possibility that individual files
>> could merge cleanly.
>>
>> In order to resolve these "edit-edit" conflicts, "conflicted" sparse
>> directories are - rather than rejected - merged by traversing their
>> associated trees by OID. For each child of the sparse directory:
>>
>> 1. Files are merged as normal (see Documentation/git-read-tree.txt for
>>    details).
>> 2. Subdirectories are treated as sparse directories and merged in
>>    'twoway_merge'. If there are no conflicts, they are merged according to
>>    the rules in Documentation/git-read-tree.txt; otherwise, the subdirectory
>>    is recursively traversed and merged.
>>
>> This process allows sparse directories to be individually merged at the
>> necessary depth *without* expanding a full index.
> 
> The idea of merging directory-level entries turns out to be
> problematic _if_ rename detection is involved, but read-tree-style
> merges are only trivial merges that ignore rename detection.  As such,
> this idea is perfectly reasonable, and is a good way to go.  Nicely
> done.
> 
> Mostly the patch looks good.  There's one thing I'm wondering about, though...
> 
>>
>> Signed-off-by: Victoria Dye <vdye@github.com>
>> ---
>>  builtin/read-tree.c                      |  5 --
>>  t/t1092-sparse-checkout-compatibility.sh |  3 +-
>>  unpack-trees.c                           | 75 ++++++++++++++++++++++++
>>  3 files changed, 77 insertions(+), 6 deletions(-)
>>
>> diff --git a/builtin/read-tree.c b/builtin/read-tree.c
>> index a7b7f822281..5a421de2629 100644
>> --- a/builtin/read-tree.c
>> +++ b/builtin/read-tree.c
>> @@ -225,11 +225,6 @@ int cmd_read_tree(int argc, const char **argv, const char *cmd_prefix)
>>                         opts.fn = opts.prefix ? bind_merge : oneway_merge;
>>                         break;
>>                 case 2:
>> -                       /*
>> -                        * TODO: update twoway_merge to handle edit/edit conflicts in
>> -                        * sparse directories.
>> -                        */
>> -                       ensure_full_index(&the_index);
>>                         opts.fn = twoway_merge;
>>                         opts.initial_checkout = is_cache_unborn();
>>                         break;
>> diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
>> index a404be0a10f..d6f19682d65 100755
>> --- a/t/t1092-sparse-checkout-compatibility.sh
>> +++ b/t/t1092-sparse-checkout-compatibility.sh
>> @@ -1411,7 +1411,8 @@ test_expect_success 'sparse index is not expanded: read-tree' '
>>         init_repos &&
>>
>>         ensure_not_expanded checkout -b test-branch update-folder1 &&
>> -       for MERGE_TREES in "update-folder2"
>> +       for MERGE_TREES in "update-folder2" \
>> +                          "base update-folder2"
>>         do
>>                 ensure_not_expanded read-tree -mu $MERGE_TREES &&
>>                 ensure_not_expanded reset --hard HEAD || return 1
>> diff --git a/unpack-trees.c b/unpack-trees.c
>> index dba122a02bb..a4ace53904e 100644
>> --- a/unpack-trees.c
>> +++ b/unpack-trees.c
>> @@ -1360,6 +1360,42 @@ static int is_sparse_directory_entry(struct cache_entry *ce,
>>         return sparse_dir_matches_path(ce, info, name);
>>  }
>>
>> +static int unpack_sparse_callback(int n, unsigned long mask, unsigned long dirmask, struct name_entry *names, struct traverse_info *info)
>> +{
>> +       struct cache_entry *src[MAX_UNPACK_TREES + 1] = { NULL, };
>> +       struct unpack_trees_options *o = info->data;
>> +       int ret;
>> +
>> +       assert(o->merge);
>> +
>> +       /*
>> +        * Unlike in 'unpack_callback', where src[0] is derived from the index when
>> +        * merging, src[0] is a transient cache entry derived from the first tree
>> +        * provided. Create the temporary entry as if it came from a non-sparse index.
>> +        */
>> +       if (!is_null_oid(&names[0].oid)) {
>> +               src[0] = create_ce_entry(info, &names[0], 0,
>> +                                       &o->result, 1,
>> +                                       dirmask & (1ul << 0));
>> +               src[0]->ce_flags |= (CE_SKIP_WORKTREE | CE_NEW_SKIP_WORKTREE);
>> +       }
>> +
>> +       /*
>> +        * 'unpack_single_entry' assumes that src[0] is derived directly from
>> +        * the index, rather than from an entry in 'names'. This is *not* true when
>> +        * merging a sparse directory, in which case names[0] is the "index" source
>> +        * entry. To match the expectations of 'unpack_single_entry', shift past the
>> +        * "index" tree (i.e., names[0]) and adjust 'names', 'n', 'mask', and
>> +        * 'dirmask' accordingly.
>> +        */
>> +       ret = unpack_single_entry(n - 1, mask >> 1, dirmask >> 1, src, names + 1, info);
> 
> So, you're passing one less entry to unpack_single_entry() when you've
> traversed into a sparse directory...won't the traversal at the next
> subdirectory deeper then also pass one less entry to
> unpack_single_entry(), so after recursing a directory or two, you only
> have one directory left and it won't conflict with anything so it just
> uses that remaining tree?  (Or maybe it passes the wrong number of
> arguments into twoway_merge()?)  Did I miss something in the logic
> somewhere that avoids that issue?  It'd be nice to test it out, which
> brings me to...
> 

The answer itself is pretty straightforward (`merged_sparse_dir(...)` is
called with `n = 3`, which is +1 to the `n` propagated throughout
`unpack_trees(...)` for a two-way merge), but I'd like to take a more
in-depth approach answering "why" in case it helps with review and/or anyone
reading along.

Suppose you are performing a two-way merge, e.g. with the command `git
read-tree my-base other-commit`. The repo contains the following files:

.
├── bar
│   └── f1
├── baz
│   ├── deep
│   │   └── a
│   └── f2
├── foo
└── foo1

Additionally:

1. 'other-commit' is identical to the index
2. 'baz/' is a sparse directory

With those assumptions in mind, below are excerpts of the execution path for
merging a file, a non-sparse directory, and a sparse directory (with values
for arguments indicated where appropriate):

MERGING FILE 'foo'
------------------
unpack_trees(len = 2, t = [my-base, other-commit], ...)
-> traverse_trees(..., n = 2, t = [my-base, other-commit], ...)
  -> unpack_callback(n = 2, ..., names = [my-base:foo, other-commit:foo], ...)
    -> unpack_single_entry(n = 2, ..., src = [INDEX:foo, NULL, NULL], 
			   names = [my-base:foo, other-commit:foo], ...)
      -> call_unpack_fn(src = [INDEX:foo, my-base:foo, other-commit:foo], ...)
        -> twoway_merge(src = [INDEX:foo, my-base:foo, other-commit:foo] ...)
  -> unpack_callback(n = 2, ..., names = [my-base:foo1, other-commit:foo1], ...)
    ...

MERGING NON-SPARSE DIRECTORY 'bar/'
----------------------------------
unpack_trees(len = 2, t = [my-base, other-commit], ...)
-> traverse_trees(..., n = 2, t = [my-base, other-commit], ...)
  -> unpack_callback(n = 2, ..., names = [my-base:bar/, other-commit:bar/], ...)
    -> unpack_single_entry(n = 2, ..., src = [NULL, NULL, NULL], 
			   names = [my-base:bar/, other-commit:bar/], ...)
    -> traverse_trees_recursive(n = 2, ..., names = [my-base:bar/, other-commit:bar/], ...)
      -> traverse_trees(..., n = 2, t = [my-base, other-commit], ...)
        -> unpack_callback(n = 2, ..., names = [my-base:bar/f1, other-commit:bar/f1], ...)
          ...

MERGING SPARSE DIRECTORY 'baz/'
------------------------------
unpack_trees(len = 2, t = [my-base, other-commit], ...)
-> traverse_trees(..., n = 2, t = [my-base, other-commit], ...)
  -> unpack_callback(n = 2, ..., names = [my-base:baz/, other-commit:baz/], ...)
    -> unpack_single_entry(n = 2, ..., src = [INDEX:baz/, NULL, NULL], 
			   names = [my-base:baz/, other-commit:baz/], ...)
      -> call_unpack_fn(src = [INDEX:baz/, my-base:baz/, other-commit:baz/], ...)
        -> twoway_merge(src = [INDEX:baz/, my-base:baz/, other-commit:baz/] ...)
  -> unpack_callback(n = 2, ..., names = [my-base:foo, other-commit:foo], ...)
    ...

Note that, throughout this process, `n = 2` despite the fact that
`twoway_merge` is actually called with *three* source entries, because
`src[0]` is the traversed entry *as it appears in the index*. Additionally,
because there are no differences between the index and 'other-commit',
'baz/' is merged without conflict in basically the same way as 'foo'.

Now suppose you update the the index to differ from 'other-commit':

1. 'baz/deep/a' is different between the index and 'my-base', same between
   'my-base' and 'other-commit'
2. 'baz/f2' is different between 'my-base' and 'other-commit', same between
   the index and 'my-base'

Before this patch, `twoway_merge` would reject the merge entirely because
the sparse directory 'baz/' has three different tree OIDs between the index,
'my-base' , and 'other-commit'. However, these changes *should* be mergeable
as long as you merge 'baz/deep/' separately from 'baz/f2'.

The way we do this is by traversing the 'baz/' index entry the same way we
traverse 'my-base' and 'other-commit' so we can circumvent populating
`src[0]` from the index. The execution path looks something like this (when
started at the sparse directory's `twoway_merge`):

MERGING CONFLICT IN SPARSE 'baz/'
---------------------------------
twoway_merge(src = [INDEX:baz/, my-base:baz/, other-commit:baz/] ...)
-> merged_sparse_dir(src = [INDEX:baz/, my-base:baz/, other-commit:baz/], n = 3, ...)
  -> traverse_trees(..., n = 3, t = [INDEX^{tree}, my-base, other-commit], ...)
    -> unpack_sparse_callback(n = 3, ..., 
			      names = [INDEX^{tree}:baz/deep/, my-base:baz/deep/, other-commit:baz/deep/])
      -> unpack_single_entry(n = 2, ..., src = [INDEX^{tree}:baz/deep/, NULL, NULL], 
			     names = [my-base:baz/deep/, other-commit:baz/deep/], ...)
        -> call_unpack_fn(src = [INDEX^{tree}:baz/deep/, my-base:baz/deep/, other-commit:baz/deep/], ...)
          -> twoway_merge(src = [INDEX^{tree}:baz/deep/, my-base:baz/deep/, other-commit:baz/deep/] ...)
    -> unpack_sparse_callback(n = 3, ..., 
			      names = [INDEX^{tree}:baz/f2, my-base:baz/f2, other-commit:baz/f2])
      -> unpack_single_entry(n = 2, ..., src = [INDEX^{tree}:baz/f2, NULL, NULL], 
			     names = [my-base:baz/f2, other-commit:baz/f2], ...)
        -> call_unpack_fn(src = [INDEX^{tree}:baz/f2, my-base:baz/f2, other-commit:baz/f2], ...)
          -> twoway_merge(src = [INDEX^{tree}:baz/f2, my-base:baz/f2, other-commit:baz/f2] ...)

Here, `unpack_sparse_callback` transforms its inputs (from `traverse_trees`)
into the those needed by `unpack_single_entry`. Unlike `unpack_callback`,
which extracts its `src[0]` from the index, `unpack_sparse_callback` creates
`src[0]` from the first tree in `names`. Then, because `unpack_single_entry`
expects `n = 2` with a populated `src[0]` and the two remaining trees in
`names`, it subtracts 1 from its value of `n` and shifts `names` (along with
other arguments like `mask` and `dirmask`). As you can see, this could
continue recursing without losing trees, since the first tree in the
`merged_sparse_dir` path is basically storage for the index as the traversal
continues.

Please let me know if I can clarify anything - this explanation more-or-less
corresponds to how I understood the problem while solving it, but it's still
pretty dense and there could be details I'm not conveying well or taking for
granted.

>> +
>> +       if (src[0])
>> +               discard_cache_entry(src[0]);
>> +
>> +       return ret >= 0 ? mask : -1;
>> +}
>> +
>>  /*
>>   * Note that traverse_by_cache_tree() duplicates some logic in this function
>>   * without actually calling it. If you change the logic here you may need to
>> @@ -2464,6 +2500,37 @@ static int merged_entry(const struct cache_entry *ce,
>>         return 1;
>>  }
>>
>> +static int merged_sparse_dir(const struct cache_entry * const *src, int n,
>> +                            struct unpack_trees_options *o)
>> +{
>> +       struct tree_desc t[MAX_UNPACK_TREES + 1];
>> +       void * tree_bufs[MAX_UNPACK_TREES + 1];
>> +       struct traverse_info info;
>> +       int i, ret;
>> +
>> +       /*
>> +        * Create the tree traversal information for traversing into *only* the
>> +        * sparse directory.
>> +        */
>> +       setup_traverse_info(&info, src[0]->name);
>> +       info.fn = unpack_sparse_callback;
>> +       info.data = o;
>> +       info.show_all_errors = o->show_all_errors;
>> +       info.pathspec = o->pathspec;
>> +
>> +       /* Get the tree descriptors of the sparse directory in each of the merging trees */
>> +       for (i = 0; i < n; i++)
>> +               tree_bufs[i] = fill_tree_descriptor(o->src_index->repo, &t[i],
>> +                                                   src[i] && !is_null_oid(&src[i]->oid) ? &src[i]->oid : NULL);
>> +
>> +       ret = traverse_trees(o->src_index, n, t, &info);
>> +
>> +       for (i = 0; i < n; i++)
>> +               free(tree_bufs[i]);
>> +
>> +       return ret;
>> +}
>> +
>>  static int deleted_entry(const struct cache_entry *ce,
>>                          const struct cache_entry *old,
>>                          struct unpack_trees_options *o)
>> @@ -2734,6 +2801,14 @@ int twoway_merge(const struct cache_entry * const *src,
>>                          * reject the merge instead.
>>                          */
>>                         return merged_entry(newtree, current, o);
>> +               } else if (S_ISSPARSEDIR(current->ce_mode)) {
>> +                       /*
>> +                        * The sparse directories differ, but we don't know whether that's
>> +                        * because of two different files in the directory being modified
>> +                        * (can be trivially merged) or if there is a real file conflict.
>> +                        * Merge the sparse directory by OID to compare file-by-file.
>> +                        */
>> +                       return merged_sparse_dir(src, 3, o);
>>                 } else
>>                         return reject_merge(current, o);
>>         }
>> --
>> gitgitgadget
> 
> It would be nice to have a couple of tests.  In particular, one
> designed to see what happens when we need to traverse into
> subdirectories of sparse directory entries and paths different between
> the two trees being merged.

There were supposed to be "ensure_not_expanded" tests added in this patch,
but they ended up in [7/7] - I'll move them back in my next version.
Additionally, the 't1092' test 'read-tree --merge with edit/edit conflicts
in sparse directories' contains examples of merges that require recursing
into sparse directories (added back in [3/7] to establish expected behavior
before changing `read-tree`).
