Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 925B6C433F5
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 02:57:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231436AbiCAC5y (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Feb 2022 21:57:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230498AbiCAC5x (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Feb 2022 21:57:53 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B30C506D2
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 18:57:12 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id p15so28698820ejc.7
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 18:57:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Ah9+QbwvM0C2k5yZ4lUuWqHfV/M3Xfv64Yr7b8fth2k=;
        b=bxzyqv4pagqFLOn5nKt5j5E3Eib9uKsnTN+/NAIzTnKjU//Kr7nLp6aQAUUkIGoXF5
         druPYOgDgDd+yg2Ym4wy98IWR0XW/igsQzrascpggu57ODsCL/l3iLXqqMzIf/ggI1oa
         kLZVmZMJS/C7GgvqDHGTaTKIXYU36Wl0QflLC1zfPQEAViI3k9+zMV3HON1UH8AEzyOg
         toiEfGiK/hnmDLtK1UsY8RuDVDmSLGfy5KI30+sPjgrQejZYeoc15WFqKpOueyKi6sQu
         Tcd6CSagFOV0BH/cAXojbBhOkN2cMjqC4+2NzgxRKNqN5DyqAfzs218nlL2qWDJYpBZF
         5ZtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Ah9+QbwvM0C2k5yZ4lUuWqHfV/M3Xfv64Yr7b8fth2k=;
        b=4siv2lalyLXKkKyRXHeR0hnIGu/0gTwMuyfXJIrMcsqBDCfxWLm1uzEAWOQ/g+RHqh
         KfS6RjErLWyGOv2+9HHHSAAXY6W9fdFz0ktD2pjdP4bgGsk0X/c9mZ1+ePGt9lTRfzWX
         mDomsLHJcyRfZWz86QMURJId1vkCJKw6buzpskROESO/odCNXgt5r/CEsgV/RiyDguAU
         YGm1yDVPmvwKszkrXyDBiBjKLcRIWgpmN2pZ5Puq6VHZvqTtmLwy0UV4eKaJ6kMhDhP7
         vseVacit8tRPnzfqrAQtsPNuunTv7mampJFDBa5DMq9EDKTM4DJW5JrDhrYS6FwEwhbK
         LhGA==
X-Gm-Message-State: AOAM531/HD1IkrfmYH02zWmBuyGh2OlA31wbpl5hh/aGtrwLn7CyScfA
        b3lADCP0fsE8/ChbXQZCbFAwT6gg9x/0I1AHJKVXo6jOY0I6mw==
X-Google-Smtp-Source: ABdhPJy38MEan9qLgNyJahY3Md+siYb/CaCdyokJCQWlFCwpGv8Mb4Ym1ZLlzhZf7nb1pbXNlBR5yLS6JrkXrhgdSfs=
X-Received: by 2002:a17:906:7e09:b0:6d6:80f5:e00f with SMTP id
 e9-20020a1709067e0900b006d680f5e00fmr9171255ejr.192.1646103430337; Mon, 28
 Feb 2022 18:57:10 -0800 (PST)
MIME-Version: 1.0
References: <pull.1157.git.1645640717.gitgitgadget@gmail.com>
 <9fdcab038b2962b7f954363e32d04591476cf219.1645640717.git.gitgitgadget@gmail.com>
 <CABPp-BHihsVQZWTE4ppOcFyk8-eVa+zZ1MhkssiTByxjPO4kcg@mail.gmail.com> <dc47f12b-8724-22ef-ed2c-096badfafd76@github.com>
In-Reply-To: <dc47f12b-8724-22ef-ed2c-096badfafd76@github.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 28 Feb 2022 18:56:58 -0800
Message-ID: <CABPp-BH4jf6z5umYpWB_A+gokUtDkjkiLOahB3FKed_Pe4sZ2g@mail.gmail.com>
Subject: Re: [PATCH 6/7] read-tree: make two-way merge sparse-aware
To:     Victoria Dye <vdye@github.com>
Cc:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 28, 2022 at 10:04 AM Victoria Dye <vdye@github.com> wrote:
>
> Elijah Newren wrote:
> > On Wed, Feb 23, 2022 at 4:09 PM Victoria Dye via GitGitGadget
> > <gitgitgadget@gmail.com> wrote:
> >>
> >> From: Victoria Dye <vdye@github.com>
> >>
> >> Enable two-way merge with 'git read-tree' without expanding the sparse
> >> index. When in a sparse index, a two-way merge will trivially succeed =
as
> >> long as there are not changes to the same sparse directory in multiple=
 trees
> >> (i.e., sparse directory-level "edit-edit" conflicts). If there are suc=
h
> >> conflicts, the merge will fail despite the possibility that individual=
 files
> >> could merge cleanly.
> >>
> >> In order to resolve these "edit-edit" conflicts, "conflicted" sparse
> >> directories are - rather than rejected - merged by traversing their
> >> associated trees by OID. For each child of the sparse directory:
> >>
> >> 1. Files are merged as normal (see Documentation/git-read-tree.txt for
> >>    details).
> >> 2. Subdirectories are treated as sparse directories and merged in
> >>    'twoway_merge'. If there are no conflicts, they are merged accordin=
g to
> >>    the rules in Documentation/git-read-tree.txt; otherwise, the subdir=
ectory
> >>    is recursively traversed and merged.
> >>
> >> This process allows sparse directories to be individually merged at th=
e
> >> necessary depth *without* expanding a full index.
> >
> > The idea of merging directory-level entries turns out to be
> > problematic _if_ rename detection is involved, but read-tree-style
> > merges are only trivial merges that ignore rename detection.  As such,
> > this idea is perfectly reasonable, and is a good way to go.  Nicely
> > done.
> >
> > Mostly the patch looks good.  There's one thing I'm wondering about, th=
ough...
> >
> >>
> >> Signed-off-by: Victoria Dye <vdye@github.com>
> >> ---
> >>  builtin/read-tree.c                      |  5 --
> >>  t/t1092-sparse-checkout-compatibility.sh |  3 +-
> >>  unpack-trees.c                           | 75 +++++++++++++++++++++++=
+
> >>  3 files changed, 77 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/builtin/read-tree.c b/builtin/read-tree.c
> >> index a7b7f822281..5a421de2629 100644
> >> --- a/builtin/read-tree.c
> >> +++ b/builtin/read-tree.c
> >> @@ -225,11 +225,6 @@ int cmd_read_tree(int argc, const char **argv, co=
nst char *cmd_prefix)
> >>                         opts.fn =3D opts.prefix ? bind_merge : oneway_=
merge;
> >>                         break;
> >>                 case 2:
> >> -                       /*
> >> -                        * TODO: update twoway_merge to handle edit/ed=
it conflicts in
> >> -                        * sparse directories.
> >> -                        */
> >> -                       ensure_full_index(&the_index);
> >>                         opts.fn =3D twoway_merge;
> >>                         opts.initial_checkout =3D is_cache_unborn();
> >>                         break;
> >> diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse=
-checkout-compatibility.sh
> >> index a404be0a10f..d6f19682d65 100755
> >> --- a/t/t1092-sparse-checkout-compatibility.sh
> >> +++ b/t/t1092-sparse-checkout-compatibility.sh
> >> @@ -1411,7 +1411,8 @@ test_expect_success 'sparse index is not expande=
d: read-tree' '
> >>         init_repos &&
> >>
> >>         ensure_not_expanded checkout -b test-branch update-folder1 &&
> >> -       for MERGE_TREES in "update-folder2"
> >> +       for MERGE_TREES in "update-folder2" \
> >> +                          "base update-folder2"
> >>         do
> >>                 ensure_not_expanded read-tree -mu $MERGE_TREES &&
> >>                 ensure_not_expanded reset --hard HEAD || return 1
> >> diff --git a/unpack-trees.c b/unpack-trees.c
> >> index dba122a02bb..a4ace53904e 100644
> >> --- a/unpack-trees.c
> >> +++ b/unpack-trees.c
> >> @@ -1360,6 +1360,42 @@ static int is_sparse_directory_entry(struct cac=
he_entry *ce,
> >>         return sparse_dir_matches_path(ce, info, name);
> >>  }
> >>
> >> +static int unpack_sparse_callback(int n, unsigned long mask, unsigned=
 long dirmask, struct name_entry *names, struct traverse_info *info)
> >> +{
> >> +       struct cache_entry *src[MAX_UNPACK_TREES + 1] =3D { NULL, };
> >> +       struct unpack_trees_options *o =3D info->data;
> >> +       int ret;
> >> +
> >> +       assert(o->merge);
> >> +
> >> +       /*
> >> +        * Unlike in 'unpack_callback', where src[0] is derived from t=
he index when
> >> +        * merging, src[0] is a transient cache entry derived from the=
 first tree
> >> +        * provided. Create the temporary entry as if it came from a n=
on-sparse index.
> >> +        */
> >> +       if (!is_null_oid(&names[0].oid)) {
> >> +               src[0] =3D create_ce_entry(info, &names[0], 0,
> >> +                                       &o->result, 1,
> >> +                                       dirmask & (1ul << 0));
> >> +               src[0]->ce_flags |=3D (CE_SKIP_WORKTREE | CE_NEW_SKIP_=
WORKTREE);
> >> +       }
> >> +
> >> +       /*
> >> +        * 'unpack_single_entry' assumes that src[0] is derived direct=
ly from
> >> +        * the index, rather than from an entry in 'names'. This is *n=
ot* true when
> >> +        * merging a sparse directory, in which case names[0] is the "=
index" source
> >> +        * entry. To match the expectations of 'unpack_single_entry', =
shift past the
> >> +        * "index" tree (i.e., names[0]) and adjust 'names', 'n', 'mas=
k', and
> >> +        * 'dirmask' accordingly.
> >> +        */
> >> +       ret =3D unpack_single_entry(n - 1, mask >> 1, dirmask >> 1, sr=
c, names + 1, info);
> >
> > So, you're passing one less entry to unpack_single_entry() when you've
> > traversed into a sparse directory...won't the traversal at the next
> > subdirectory deeper then also pass one less entry to
> > unpack_single_entry(), so after recursing a directory or two, you only
> > have one directory left and it won't conflict with anything so it just
> > uses that remaining tree?  (Or maybe it passes the wrong number of
> > arguments into twoway_merge()?)  Did I miss something in the logic
> > somewhere that avoids that issue?  It'd be nice to test it out, which
> > brings me to...
> >
>
> The answer itself is pretty straightforward (`merged_sparse_dir(...)` is
> called with `n =3D 3`, which is +1 to the `n` propagated throughout
> `unpack_trees(...)` for a two-way merge), but I'd like to take a more
> in-depth approach answering "why" in case it helps with review and/or any=
one
> reading along.
>
> Suppose you are performing a two-way merge, e.g. with the command `git
> read-tree my-base other-commit`. The repo contains the following files:
>
> .
> =E2=94=9C=E2=94=80=E2=94=80 bar
> =E2=94=82   =E2=94=94=E2=94=80=E2=94=80 f1
> =E2=94=9C=E2=94=80=E2=94=80 baz
> =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 deep
> =E2=94=82   =E2=94=82   =E2=94=94=E2=94=80=E2=94=80 a
> =E2=94=82   =E2=94=94=E2=94=80=E2=94=80 f2
> =E2=94=9C=E2=94=80=E2=94=80 foo
> =E2=94=94=E2=94=80=E2=94=80 foo1
>
> Additionally:
>
> 1. 'other-commit' is identical to the index
> 2. 'baz/' is a sparse directory
>
> With those assumptions in mind, below are excerpts of the execution path =
for
> merging a file, a non-sparse directory, and a sparse directory (with valu=
es
> for arguments indicated where appropriate):
>
> MERGING FILE 'foo'
> ------------------
> unpack_trees(len =3D 2, t =3D [my-base, other-commit], ...)
> -> traverse_trees(..., n =3D 2, t =3D [my-base, other-commit], ...)
>   -> unpack_callback(n =3D 2, ..., names =3D [my-base:foo, other-commit:f=
oo], ...)
>     -> unpack_single_entry(n =3D 2, ..., src =3D [INDEX:foo, NULL, NULL],
>                            names =3D [my-base:foo, other-commit:foo], ...=
)
>       -> call_unpack_fn(src =3D [INDEX:foo, my-base:foo, other-commit:foo=
], ...)
>         -> twoway_merge(src =3D [INDEX:foo, my-base:foo, other-commit:foo=
] ...)
>   -> unpack_callback(n =3D 2, ..., names =3D [my-base:foo1, other-commit:=
foo1], ...)
>     ...
>
> MERGING NON-SPARSE DIRECTORY 'bar/'
> ----------------------------------
> unpack_trees(len =3D 2, t =3D [my-base, other-commit], ...)
> -> traverse_trees(..., n =3D 2, t =3D [my-base, other-commit], ...)
>   -> unpack_callback(n =3D 2, ..., names =3D [my-base:bar/, other-commit:=
bar/], ...)
>     -> unpack_single_entry(n =3D 2, ..., src =3D [NULL, NULL, NULL],
>                            names =3D [my-base:bar/, other-commit:bar/], .=
..)
>     -> traverse_trees_recursive(n =3D 2, ..., names =3D [my-base:bar/, ot=
her-commit:bar/], ...)
>       -> traverse_trees(..., n =3D 2, t =3D [my-base, other-commit], ...)
>         -> unpack_callback(n =3D 2, ..., names =3D [my-base:bar/f1, other=
-commit:bar/f1], ...)
>           ...
>
> MERGING SPARSE DIRECTORY 'baz/'
> ------------------------------
> unpack_trees(len =3D 2, t =3D [my-base, other-commit], ...)
> -> traverse_trees(..., n =3D 2, t =3D [my-base, other-commit], ...)
>   -> unpack_callback(n =3D 2, ..., names =3D [my-base:baz/, other-commit:=
baz/], ...)
>     -> unpack_single_entry(n =3D 2, ..., src =3D [INDEX:baz/, NULL, NULL]=
,
>                            names =3D [my-base:baz/, other-commit:baz/], .=
..)
>       -> call_unpack_fn(src =3D [INDEX:baz/, my-base:baz/, other-commit:b=
az/], ...)
>         -> twoway_merge(src =3D [INDEX:baz/, my-base:baz/, other-commit:b=
az/] ...)
>   -> unpack_callback(n =3D 2, ..., names =3D [my-base:foo, other-commit:f=
oo], ...)
>     ...
>
> Note that, throughout this process, `n =3D 2` despite the fact that
> `twoway_merge` is actually called with *three* source entries, because
> `src[0]` is the traversed entry *as it appears in the index*. Additionall=
y,
> because there are no differences between the index and 'other-commit',
> 'baz/' is merged without conflict in basically the same way as 'foo'.
>
> Now suppose you update the the index to differ from 'other-commit':
>
> 1. 'baz/deep/a' is different between the index and 'my-base', same betwee=
n
>    'my-base' and 'other-commit'
> 2. 'baz/f2' is different between 'my-base' and 'other-commit', same betwe=
en
>    the index and 'my-base'
>
> Before this patch, `twoway_merge` would reject the merge entirely because
> the sparse directory 'baz/' has three different tree OIDs between the ind=
ex,
> 'my-base' , and 'other-commit'. However, these changes *should* be mergea=
ble
> as long as you merge 'baz/deep/' separately from 'baz/f2'.
>
> The way we do this is by traversing the 'baz/' index entry the same way w=
e
> traverse 'my-base' and 'other-commit' so we can circumvent populating
> `src[0]` from the index. The execution path looks something like this (wh=
en
> started at the sparse directory's `twoway_merge`):
>
> MERGING CONFLICT IN SPARSE 'baz/'
> ---------------------------------
> twoway_merge(src =3D [INDEX:baz/, my-base:baz/, other-commit:baz/] ...)
> -> merged_sparse_dir(src =3D [INDEX:baz/, my-base:baz/, other-commit:baz/=
], n =3D 3, ...)
>   -> traverse_trees(..., n =3D 3, t =3D [INDEX^{tree}, my-base, other-com=
mit], ...)
>     -> unpack_sparse_callback(n =3D 3, ...,
>                               names =3D [INDEX^{tree}:baz/deep/, my-base:=
baz/deep/, other-commit:baz/deep/])
>       -> unpack_single_entry(n =3D 2, ..., src =3D [INDEX^{tree}:baz/deep=
/, NULL, NULL],
>                              names =3D [my-base:baz/deep/, other-commit:b=
az/deep/], ...)
>         -> call_unpack_fn(src =3D [INDEX^{tree}:baz/deep/, my-base:baz/de=
ep/, other-commit:baz/deep/], ...)
>           -> twoway_merge(src =3D [INDEX^{tree}:baz/deep/, my-base:baz/de=
ep/, other-commit:baz/deep/] ...)
>     -> unpack_sparse_callback(n =3D 3, ...,
>                               names =3D [INDEX^{tree}:baz/f2, my-base:baz=
/f2, other-commit:baz/f2])
>       -> unpack_single_entry(n =3D 2, ..., src =3D [INDEX^{tree}:baz/f2, =
NULL, NULL],
>                              names =3D [my-base:baz/f2, other-commit:baz/=
f2], ...)
>         -> call_unpack_fn(src =3D [INDEX^{tree}:baz/f2, my-base:baz/f2, o=
ther-commit:baz/f2], ...)
>           -> twoway_merge(src =3D [INDEX^{tree}:baz/f2, my-base:baz/f2, o=
ther-commit:baz/f2] ...)
>
> Here, `unpack_sparse_callback` transforms its inputs (from `traverse_tree=
s`)
> into the those needed by `unpack_single_entry`. Unlike `unpack_callback`,
> which extracts its `src[0]` from the index, `unpack_sparse_callback` crea=
tes
> `src[0]` from the first tree in `names`. Then, because `unpack_single_ent=
ry`
> expects `n =3D 2` with a populated `src[0]` and the two remaining trees i=
n
> `names`, it subtracts 1 from its value of `n` and shifts `names` (along w=
ith
> other arguments like `mask` and `dirmask`). As you can see, this could
> continue recursing without losing trees, since the first tree in the
> `merged_sparse_dir` path is basically storage for the index as the traver=
sal
> continues.
>
> Please let me know if I can clarify anything - this explanation more-or-l=
ess
> corresponds to how I understood the problem while solving it, but it's st=
ill
> pretty dense and there could be details I'm not conveying well or taking =
for
> granted.

Thanks for taking the time to explain this.  For some reason, I tend
to get confused by the extra index entry.  I blame the fact that I
mostly only ever looked at threeway_merge() (since it was the one used
by merge-recursive.c), and there we get to assume that the HEAD tree
is equal to the index always, so there really isn't a separate fourth
argument from the index to worry about.  So the combination of having
to look at twoway_merge() as well as the special index entry for some
reason was throwing me a bit.  This clears it up nicely.

(Once upon a time we only claimed but didn't enforce that index was
equal to the HEAD tree for the three way merging, but that was an
abject failure; if you're curious about it, see the fun commit message
at 9822175d2b ("Ensure index matches head before invoking merge
machinery, round N", 2019-08-17) explaining it.)

> >> +
> >> +       if (src[0])
> >> +               discard_cache_entry(src[0]);
> >> +
> >> +       return ret >=3D 0 ? mask : -1;
> >> +}
> >> +
> >>  /*
> >>   * Note that traverse_by_cache_tree() duplicates some logic in this f=
unction
> >>   * without actually calling it. If you change the logic here you may =
need to
> >> @@ -2464,6 +2500,37 @@ static int merged_entry(const struct cache_entr=
y *ce,
> >>         return 1;
> >>  }
> >>
> >> +static int merged_sparse_dir(const struct cache_entry * const *src, i=
nt n,
> >> +                            struct unpack_trees_options *o)
> >> +{
> >> +       struct tree_desc t[MAX_UNPACK_TREES + 1];
> >> +       void * tree_bufs[MAX_UNPACK_TREES + 1];
> >> +       struct traverse_info info;
> >> +       int i, ret;
> >> +
> >> +       /*
> >> +        * Create the tree traversal information for traversing into *=
only* the
> >> +        * sparse directory.
> >> +        */
> >> +       setup_traverse_info(&info, src[0]->name);
> >> +       info.fn =3D unpack_sparse_callback;
> >> +       info.data =3D o;
> >> +       info.show_all_errors =3D o->show_all_errors;
> >> +       info.pathspec =3D o->pathspec;
> >> +
> >> +       /* Get the tree descriptors of the sparse directory in each of=
 the merging trees */
> >> +       for (i =3D 0; i < n; i++)
> >> +               tree_bufs[i] =3D fill_tree_descriptor(o->src_index->re=
po, &t[i],
> >> +                                                   src[i] && !is_null=
_oid(&src[i]->oid) ? &src[i]->oid : NULL);
> >> +
> >> +       ret =3D traverse_trees(o->src_index, n, t, &info);
> >> +
> >> +       for (i =3D 0; i < n; i++)
> >> +               free(tree_bufs[i]);
> >> +
> >> +       return ret;
> >> +}
> >> +
> >>  static int deleted_entry(const struct cache_entry *ce,
> >>                          const struct cache_entry *old,
> >>                          struct unpack_trees_options *o)
> >> @@ -2734,6 +2801,14 @@ int twoway_merge(const struct cache_entry * con=
st *src,
> >>                          * reject the merge instead.
> >>                          */
> >>                         return merged_entry(newtree, current, o);
> >> +               } else if (S_ISSPARSEDIR(current->ce_mode)) {
> >> +                       /*
> >> +                        * The sparse directories differ, but we don't=
 know whether that's
> >> +                        * because of two different files in the direc=
tory being modified
> >> +                        * (can be trivially merged) or if there is a =
real file conflict.
> >> +                        * Merge the sparse directory by OID to compar=
e file-by-file.
> >> +                        */
> >> +                       return merged_sparse_dir(src, 3, o);
> >>                 } else
> >>                         return reject_merge(current, o);
> >>         }
> >> --
> >> gitgitgadget
> >
> > It would be nice to have a couple of tests.  In particular, one
> > designed to see what happens when we need to traverse into
> > subdirectories of sparse directory entries and paths different between
> > the two trees being merged.
>
> There were supposed to be "ensure_not_expanded" tests added in this patch=
,
> but they ended up in [7/7] - I'll move them back in my next version.

Awesome.

> Additionally, the 't1092' test 'read-tree --merge with edit/edit conflict=
s
> in sparse directories' contains examples of merges that require recursing
> into sparse directories (added back in [3/7] to establish expected behavi=
or
> before changing `read-tree`).

Any chance you could reference the testcase from 3/7 in your commit
message just so other reviewers or our future selves can find it more
easily?
