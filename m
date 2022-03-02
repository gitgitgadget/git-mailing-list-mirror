Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9E44C433EF
	for <git@archiver.kernel.org>; Wed,  2 Mar 2022 07:22:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239767AbiCBHXF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 02:23:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232279AbiCBHXE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 02:23:04 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22F493C714
        for <git@vger.kernel.org>; Tue,  1 Mar 2022 23:22:20 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id kt27so1839795ejb.0
        for <git@vger.kernel.org>; Tue, 01 Mar 2022 23:22:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rk6xhXKDxJLWZhBg5ZTEUPb7AP1PiqLafEKii6Djl44=;
        b=Zo5EpyT46qlpXz9RpXVSBl0t9uKPYzfxvNEfYiDm5ALUA/KU++hlSr9B7gPaJ0Xk1S
         pCEkcmK+wseQIAODUCXK6mRdXoBvcrFtX9+XF/Takolh3SZKGI329WAheXcVOMlfkUEE
         MUmwsawRxlaaaK2u+TYAVeLyfZ9UNMpg+K3iJx9Ri9gmwU8wjlXg1FBZRjxTooYlKD1L
         tQ/UaGBByT9TITMAI5rHIaylW0iPdm9dQn3eC8AeM0OCYvY0Ef3T2Rxwi++bFkYHDOZ2
         /HWvyFCisCDd/2tJpHFUDjyd/RC+XeOa8mZy722S+b9EgluBB/JzM0HxW0z7Q18PkjMn
         FzvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rk6xhXKDxJLWZhBg5ZTEUPb7AP1PiqLafEKii6Djl44=;
        b=wss7WOM9mvvxMyUCc9sERT9lnRl7tiqrZOH7Sjf6PH/fb+sD1nGGe51XC03K5Cw+R0
         bKlbNQj/xmuO1GVqEWFVO68GKl6/N6cNF0ZVgHvT40tUMZ73Dun9czjLqVt9aCcnFvLl
         hSmEbEyalSSGQpY6OL0F8UrXOCTR1cvYJqBdPDYmj1jtv4uP41fBa4fGmTq6TtGjetI/
         pwccCg0ppesLkeyWH15UymWOdN39BOs4yfbjBP2tbBlUZTkNNH8xPtHx9LM7FzAGtFew
         OSSXIbxxOWkBG9bbVdlxRJUCyq/ueNUOR+txr4iYuXA2lealPg+8jCsMmmoOB9lCrrFu
         FfFw==
X-Gm-Message-State: AOAM532uRNsQrBYNf8c3U1/rPEn+Si2Q+e/n3WqdCVke+r7ih6iZXFFG
        bsRqwFPYnpB/APirLjDeP04k53i0XP92/I+9Zywkhr3CVZg=
X-Google-Smtp-Source: ABdhPJzIJX5ElanFfEmwJqhdr49opHX9we5gmmzRrWE84FPjEB5jLgBHG0NVrJuHWRhYuGWukTjeeqJ+35R1xyGlqUs=
X-Received: by 2002:a17:906:a855:b0:6cd:ba20:39c5 with SMTP id
 dx21-20020a170906a85500b006cdba2039c5mr21573861ejb.100.1646205738298; Tue, 01
 Mar 2022 23:22:18 -0800 (PST)
MIME-Version: 1.0
References: <pull.1157.v2.git.1645742073.gitgitgadget@gmail.com> <pull.1157.v3.git.1646166271.gitgitgadget@gmail.com>
In-Reply-To: <pull.1157.v3.git.1646166271.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 1 Mar 2022 23:22:06 -0800
Message-ID: <CABPp-BHxt2cM0E47eYTn=+H-FYJEQ54O7x2TAbqawwFMWAGYgA@mail.gmail.com>
Subject: Re: [PATCH v3 0/8] Sparse index: integrate with 'read-tree'
To:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Victoria Dye <vdye@github.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 1, 2022 at 12:24 PM Victoria Dye via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> Like previous integrations [1] [2], this series allows 'git read-tree' to
> operate using a sparse index.
>
> The first three patches are bugfixes for issues found while implementing =
the
> 'read-tree' integration:
>
>  * The first (patch [1/8]) fixes an edge case in which a repo with no
>    in-cone files or directories would have its root collapsed into a spar=
se
>    directory; the fix ensures the root directory is never collapsed into =
a
>    sparse directory.
>  * The second (patch [2/8]) corrects the 'git status' reporting of change=
s
>    nested inside the subdirectory of a sparse directory, ensuring that th=
e
>    modified file (not the subdirectory) is correctly reported as having
>    changes.
>  * The third (patch [3/8]) explicitly disallows the somewhat ambiguous ca=
se
>    of using 'git read-tree --prefix=3D/' to represent the repo root (it c=
ould
>    be interpreted as a leading slash - even though it's actually trailing
>    slash - which is not allowed for prefixes). Now, an error specifying t=
hat
>    prefixes cannot begin with '/' guides users more directly to the corre=
ct
>    syntax. If a user does want to specify the repo root as their prefix,
>    that can still be done with 'git read-tree --prefix=3D'
>
> The remainder of the series focuses on utilizing the sparse index in 'git
> read-tree'. After some baseline behavior-establishing tests (patch [4/8])=
,
> sparse index usage is trivially enabled (patch [5/8]) for 'read-tree'
> except:
>
>  * usage with '--prefix'
>  * two- and three-way merge
>
> These cases require additional changes in order to work as expected (i.e.=
,
> outwardly matching non-sparse index sparse-checkout). For the former, the
> sparse index can be enabled as long as the index is expanded when the pre=
fix
> is a directory outside the sparse cone (patch [6/8]). For the latter, spa=
rse
> directories that cannot be trivially merged must have their contents merg=
ed
> file-by-file, done by recursively traversing the trees represented by the
> sparse directories (patches [7/8] & [8/8]).
>
>
> Changes since V2
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>  * revised/clarified explanation for why the 'recursive' flag is necessar=
y
>    in 'git status' internal diff in both the commit message for [2/8] and
>    the code comments
>  * added patch [3/8] to disallow '/' as a prefix
>  * moved the loop over different 'read-tree' scenarios outside the test i=
n
>    t1092 test 'read-tree --merge with files outside sparse definition',
>    separating the tests into individually-runnable and traceable cases
>  * improved test case clarity and variety in 'read-tree --prefix' tests
>  * removed redundant arg to 'git reset' in 'sparse index is not expanded:
>    read-tree'
>  * pointed out pre-existing testing that covers '--prefix' in [6/8] commi=
t
>    message
>  * moved prefix-dependent index expansion logic into function
>    'update_sparsity_for_prefix', improved explanation for function behavi=
or
>    in comments
>  * pointed out pre-existing testing that covers two- and three-way merge =
in
>    [7/8] & [8/8] commit messages, respectively
>  * added test cases for "ensure not expanded" tests of read-tree for both
>    two- and three-way merge
>  * fixed issue with three-way merge implementation (if the "no merge" cas=
es
>    described in 't/t1000-read-tree-m-3way.sh' are reached, sparse
>    directories should be recursively merged), testing added in the "ensur=
e
>    not expanded" cases

I've read through all of these.  This round is:

Reviewed-by: Elijah Newren <newren@gmail.com>

>
>
> Changes since V1
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>  * switched an empty string check from '!strlen(path)' to the
>    slightly-less-expensive '!*path'
>
> Thanks!
>
>  * Victoria
>
> [1]
> https://lore.kernel.org/git/pull.1109.v2.git.1641924306.gitgitgadget@gmai=
l.com/
> [2]
> https://lore.kernel.org/git/pull.1048.v6.git.1638201164.gitgitgadget@gmai=
l.com/
>
> Victoria Dye (8):
>   sparse-index: prevent repo root from becoming sparse
>   status: fix nested sparse directory diff in sparse index
>   read-tree: explicitly disallow prefixes with a leading '/'
>   read-tree: expand sparse checkout test coverage
>   read-tree: integrate with sparse index
>   read-tree: narrow scope of index expansion for '--prefix'
>   read-tree: make two-way merge sparse-aware
>   read-tree: make three-way merge sparse-aware
>
>  builtin/read-tree.c                      |  14 ++-
>  dir.c                                    |   7 +-
>  t/perf/p2000-sparse-operations.sh        |   1 +
>  t/t1003-read-tree-prefix.sh              |  10 ++
>  t/t1092-sparse-checkout-compatibility.sh | 133 ++++++++++++++++++++
>  unpack-trees.c                           | 147 +++++++++++++++++++++--
>  wt-status.c                              |   9 ++
>  7 files changed, 308 insertions(+), 13 deletions(-)
>
>
> base-commit: e6ebfd0e8cbbd10878070c8a356b5ad1b3ca464e
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1157%2F=
vdye%2Fsparse%2Fread-tree-v3
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1157/vdye/=
sparse/read-tree-v3
> Pull-Request: https://github.com/gitgitgadget/git/pull/1157
>
> Range-diff vs v2:
>
>  1:  744668eeece =3D 1:  744668eeece sparse-index: prevent repo root from=
 becoming sparse
>  2:  f0cff03b95d ! 2:  26f4d30bd95 status: fix nested sparse directory di=
ff in sparse index
>      @@ Metadata
>        ## Commit message ##
>           status: fix nested sparse directory diff in sparse index
>
>      -    Add the 'recursive' flag to 'wt_status_collect_changes_index(..=
.)'. Without
>      -    the 'recursive' flag, 'git status' could report index changes i=
ncorrectly
>      -    when the following conditions were met:
>      +    Enable the 'recursive' diff option for the diff executed as par=
t of 'git
>      +    status'. Without the 'recursive' enabled, 'git status' reports =
index
>      +    changes incorrectly when the following conditions were met:
>
>           * sparse index is enabled
>           * there is a difference between the index and HEAD in a file in=
side a
>             *subdirectory* of a sparse directory
>           * the sparse directory index entry is *not* expanded in-core
>
>      -    In this scenario, 'git status' would not recurse into the spars=
e directory's
>      -    subdirectories to identify which file contained the difference =
between the
>      -    index and HEAD. Instead, it would report the immediate subdirec=
tory itself
>      -    as "modified".
>      +    Because it is not recursive by default, the diff in 'git status=
' reports
>      +    changes only at the level of files and directories that are imm=
ediate
>      +    children of a sparse directory, rather than recursing into dire=
ctories with
>      +    changes to identify the modified file(s). As a result, 'git sta=
tus' reports
>      +    the immediate subdirectory itself as "modified".
>
>           Example:
>
>      @@ Commit message
>             (use "git restore --staged <file>..." to unstage)
>                   modified:   sparse/sub
>
>      -    The 'recursive' diff option in 'wt_status_collect_changes_index=
' corrects
>      -    this by indicating that 'git status' should recurse into sparse=
 directories
>      -    to find modified files. Given the same repository setup as the =
example
>      -    above, the corrected result of `git status` is:
>      +    Enabling the 'recursive' diff option in 'wt_status_collect_chan=
ges_index'
>      +    corrects this issue by allowing the diff to recurse into subdir=
ectories of
>      +    sparse directories to find modified files. Given the same repos=
itory setup
>      +    as the example above, the corrected result of `git status` is:
>
>           $ git status
>           On branch master
>      @@ wt-status.c: static void wt_status_collect_changes_index(struct w=
t_status *s)
>         rev.diffopt.rename_score =3D s->rename_score >=3D 0 ? s->rename_s=
core : rev.diffopt.rename_score;
>       +
>       + /*
>      -+  * The `recursive` option must be enabled to show differences in =
files
>      -+  * *more than* one level deep in a sparse directory index entry (=
e.g., given
>      -+  * sparse directory 'sparse-dir/', reporting a difference in the =
file
>      -+  * 'sparse-dir/another-dir/my-file').
>      ++  * The `recursive` option must be enabled to allow the diff to re=
curse
>      ++  * into subdirectories of sparse directory index entries. If it i=
s not
>      ++  * enabled, a subdirectory containing file(s) with changes is rep=
orted
>      ++  * as "modified", rather than the modified files themselves.
>       +  */
>       + rev.diffopt.flags.recursive =3D 1;
>       +
>  -:  ----------- > 3:  e48a281a4d3 read-tree: explicitly disallow prefixe=
s with a leading '/'
>  3:  ffe0b6aff2b ! 4:  90ebcb7b8ff read-tree: expand sparse checkout test=
 coverage
>      @@ Commit message
>           emphasis is placed on interactions with files outside the spars=
e cone, e.g.
>           merges with out-of-cone conflicts.
>
>      +    Helped-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail=
.com>
>           Signed-off-by: Victoria Dye <vdye@github.com>
>
>        ## t/perf/p2000-sparse-operations.sh ##
>      @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'up=
date-index --ca
>         test_cmp expect sparse-checkout-out
>        '
>
>      -+test_expect_success 'read-tree --merge with files outside sparse d=
efinition' '
>      -+ init_repos &&
>      -+
>      -+ test_all_match git checkout -b test-branch update-folder1 &&
>      -+ for MERGE_TREES in "base HEAD update-folder2" \
>      -+                    "update-folder1 update-folder2" \
>      -+                    "update-folder2"
>      -+ do
>      -+         # Clean up and remove on-disk files
>      -+         test_all_match git reset --hard HEAD &&
>      -+         test_sparse_match git sparse-checkout reapply &&
>      ++for MERGE_TREES in "base HEAD update-folder2" \
>      ++            "update-folder1 update-folder2" \
>      ++            "update-folder2"
>      ++do
>      ++ test_expect_success "'read-tree -mu $MERGE_TREES' with files outs=
ide sparse definition" '
>      ++         init_repos &&
>       +
>       +         # Although the index matches, without --no-sparse-checkou=
t, outside-of-
>       +         # definition files will not exist on disk for sparse chec=
kouts
>      @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'up=
date-index --ca
>       +         test_all_match git read-tree -mu --no-sparse-checkout $ME=
RGE_TREES &&
>       +         test_all_match git status --porcelain=3Dv2 &&
>       +         test_cmp sparse-checkout/folder2/a sparse-index/folder2/a=
 &&
>      -+         test_cmp sparse-checkout/folder2/a full-checkout/folder2/=
a || return 1
>      -+ done
>      -+'
>      ++         test_cmp sparse-checkout/folder2/a full-checkout/folder2/=
a
>      ++
>      ++ '
>      ++done
>       +
>       +test_expect_success 'read-tree --merge with edit/edit conflicts in=
 sparse directories' '
>       + init_repos &&
>      @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'up=
date-index --ca
>       + test_all_match test_must_fail git read-tree -mu rename-out-to-in =
update-folder1
>       +'
>       +
>      -+test_expect_success 'read-tree --prefix outside sparse definition'=
 '
>      ++test_expect_success 'read-tree --prefix' '
>       + init_repos &&
>       +
>      -+ # Cannot read-tree --prefix with a single argument when files exi=
st within
>      -+ # prefix
>      -+ test_all_match test_must_fail git read-tree --prefix=3Dfolder1/ -=
u update-folder1 &&
>      ++ # If files differing between the index and target <commit-ish> ex=
ist
>      ++ # inside the prefix, `read-tree --prefix` should fail
>      ++ test_all_match test_must_fail git read-tree --prefix=3Ddeep/ deep=
est &&
>      ++ test_all_match test_must_fail git read-tree --prefix=3Dfolder1/ u=
pdate-folder1 &&
>       +
>      -+ test_all_match git read-tree --prefix=3Dfolder2/0 -u rename-base =
&&
>      -+ test_path_is_missing sparse-checkout/folder2 &&
>      -+ test_path_is_missing sparse-index/folder2 &&
>      ++ # If no differing index entries exist matching the prefix,
>      ++ # `read-tree --prefix` updates the index successfully
>      ++ test_all_match git rm -rf deep/deeper1/deepest/ &&
>      ++ test_all_match git read-tree --prefix=3Ddeep/deeper1/deepest -u d=
eepest &&
>      ++ test_all_match git status --porcelain=3Dv2 &&
>      ++
>      ++ test_all_match git rm -rf --sparse folder1/ &&
>      ++ test_all_match git read-tree --prefix=3Dfolder1/ -u update-folder=
1 &&
>      ++ test_all_match git status --porcelain=3Dv2 &&
>       +
>      -+ test_all_match git read-tree --reset -u HEAD &&
>      -+ test_all_match git read-tree --prefix=3Dfolder2/0 -u --no-sparse-=
checkout rename-base &&
>      -+ test_cmp sparse-checkout/folder2/0/a sparse-index/folder2/0/a &&
>      -+ test_cmp sparse-checkout/folder2/0/a full-checkout/folder2/0/a
>      ++ test_all_match git rm -rf --sparse folder2/0 &&
>      ++ test_all_match git read-tree --prefix=3Dfolder2/0/ -u rename-out-=
to-out &&
>      ++ test_all_match git status --porcelain=3Dv2
>       +'
>       +
>       +test_expect_success 'read-tree --merge with directory-file conflic=
ts' '
>  4:  cb7e0cf419c ! 5:  015618a9f29 read-tree: integrate with sparse index
>      @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'sp=
arse index is n
>       + for MERGE_TREES in "update-folder2"
>       + do
>       +         ensure_not_expanded read-tree -mu $MERGE_TREES &&
>      -+         ensure_not_expanded reset --hard HEAD || return 1
>      ++         ensure_not_expanded reset --hard || return 1
>       + done
>       +'
>       +
>  5:  4f05fa70209 ! 6:  1a9365c3bc5 read-tree: narrow scope of index expan=
sion for '--prefix'
>      @@ Commit message
>           If the prefix is in-cone, its sparse subdirectories (if any) wi=
ll be
>           traversed correctly without index expansion.
>
>      +    The behavior of 'git read-tree' with prefixes 1) inside of cone=
, 2) equal to
>      +    a sparse directory, and 3) inside a sparse directory are all te=
sted as part
>      +    of the 't/t1092-sparse-checkout-compatibility.sh' test 'read-tr=
ee --prefix',
>      +    ensuring that the sparse index case works the way it did prior =
to this
>      +    change as well as matching non-sparse index sparse-checkout.
>      +
>      +    Helped-by: Elijah Newren <newren@gmail.com>
>           Signed-off-by: Victoria Dye <vdye@github.com>
>
>        ## builtin/read-tree.c ##
>      @@ t/t1092-sparse-checkout-compatibility.sh
>       @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 's=
parse index is not expanded: read-tree' '
>         do
>                 ensure_not_expanded read-tree -mu $MERGE_TREES &&
>      -          ensure_not_expanded reset --hard HEAD || return 1
>      +          ensure_not_expanded reset --hard || return 1
>       - done
>       + done &&
>       +
>      @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'sp=
arse index is n
>        test_expect_success 'ls-files' '
>
>        ## unpack-trees.c ##
>      -@@ unpack-trees.c: int unpack_trees(unsigned len, struct tree_desc =
*t, struct unpack_trees_options
>      -          setup_standard_excludes(o->dir);
>      -  }
>      +@@ unpack-trees.c: static void populate_from_existing_patterns(stru=
ct unpack_trees_options *o,
>      +          o->pl =3D pl;
>      + }
>
>      -+ /*
>      -+  * If the prefix is equal to or contained within a sparse directo=
ry, the
>      -+  * index needs to be expanded to traverse with the specified pref=
ix.
>      -+  */
>      -+ if (o->prefix && o->src_index->sparse_index) {
>      -+         int prefix_len =3D strlen(o->prefix);
>      ++static void update_sparsity_for_prefix(const char *prefix,
>      ++                                struct index_state *istate)
>      ++{
>      ++ int prefix_len =3D strlen(prefix);
>      ++ struct strbuf ce_prefix =3D STRBUF_INIT;
>       +
>      -+         while (prefix_len > 0 && o->prefix[prefix_len - 1] =3D=3D=
 '/')
>      -+                 prefix_len--;
>      ++ if (!istate->sparse_index)
>      ++         return;
>       +
>      -+         if (prefix_len > 0) {
>      -+                 struct strbuf ce_prefix =3D STRBUF_INIT;
>      -+                 strbuf_grow(&ce_prefix, prefix_len + 1);
>      -+                 strbuf_add(&ce_prefix, o->prefix, prefix_len);
>      -+                 strbuf_addch(&ce_prefix, '/');
>      ++ while (prefix_len > 0 && prefix[prefix_len - 1] =3D=3D '/')
>      ++         prefix_len--;
>       +
>      -+                 /*
>      -+                  * If the prefix is not inside the sparse cone, t=
hen the
>      -+                  * index is explicitly expanded if it is found as=
 a sparse
>      -+                  * directory, or implicitly expanded (by 'index_n=
ame_pos')
>      -+                  * if the path is inside a sparse directory.
>      -+                  */
>      -+                 if (!path_in_cone_mode_sparse_checkout(ce_prefix.=
buf, o->src_index) &&
>      -+                     index_name_pos(o->src_index, ce_prefix.buf, c=
e_prefix.len) >=3D 0)
>      -+                         ensure_full_index(o->src_index);
>      ++ if (prefix_len <=3D 0)
>      ++         BUG("Invalid prefix passed to update_sparsity_for_prefix"=
);
>       +
>      -+                 strbuf_release(&ce_prefix);
>      -+         }
>      -+ }
>      ++ strbuf_grow(&ce_prefix, prefix_len + 1);
>      ++ strbuf_add(&ce_prefix, prefix, prefix_len);
>      ++ strbuf_addch(&ce_prefix, '/');
>      ++
>      ++ /*
>      ++  * If the prefix points to a sparse directory or a path inside a =
sparse
>      ++  * directory, the index should be expanded. This is accomplished =
in one
>      ++  * of two ways:
>      ++  * - if the prefix is inside a sparse directory, it will be expan=
ded by
>      ++  *   the 'ensure_full_index(...)' call in 'index_name_pos(...)'.
>      ++  * - if the prefix matches an existing sparse directory entry,
>      ++  *   'index_name_pos(...)' will return its index position, trigge=
ring
>      ++  *   the 'ensure_full_index(...)' below.
>      ++  */
>      ++ if (!path_in_cone_mode_sparse_checkout(ce_prefix.buf, istate) &&
>      ++     index_name_pos(istate, ce_prefix.buf, ce_prefix.len) >=3D 0)
>      ++         ensure_full_index(istate);
>      ++
>      ++ strbuf_release(&ce_prefix);
>      ++}
>      +
>      + static int verify_absent(const struct cache_entry *,
>      +                   enum unpack_trees_error_types,
>      +@@ unpack-trees.c: int unpack_trees(unsigned len, struct tree_desc =
*t, struct unpack_trees_options
>      +          setup_standard_excludes(o->dir);
>      +  }
>      +
>      ++ if (o->prefix)
>      ++         update_sparsity_for_prefix(o->prefix, o->src_index);
>       +
>         if (!core_apply_sparse_checkout || !o->update)
>                 o->skip_sparse_checkout =3D 1;
>  6:  94c2aad2f93 ! 7:  71bec3ddad1 read-tree: make two-way merge sparse-a=
ware
>      @@ Commit message
>           This process allows sparse directories to be individually merge=
d at the
>           necessary depth *without* expanding a full index.
>
>      +    The 't/t1092-sparse-checkout-compatibility.sh' test 'read-tree =
--merge with
>      +    edit/edit conflicts in sparse directories' tests two-way merges=
 with 1)
>      +    changes inside sparse directories that do not conflict and 2) c=
hanges that
>      +    do conflict (with the correct file(s) reported in the error mes=
sage).
>      +    Additionally, add two-way merge cases to 'sparse index is not e=
xpanded:
>      +    read-tree' to confirm that the index is not expanded regardless=
 of whether
>      +    edit/edit conflicts are present in a sparse directory.
>      +
>           Signed-off-by: Victoria Dye <vdye@github.com>
>
>        ## builtin/read-tree.c ##
>      @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'sp=
arse index is n
>
>         ensure_not_expanded checkout -b test-branch update-folder1 &&
>       - for MERGE_TREES in "update-folder2"
>      -+ for MERGE_TREES in "update-folder2" \
>      -+                    "base update-folder2"
>      ++ for MERGE_TREES in "base update-folder2" \
>      ++                    "base rename-base" \
>      ++                    "update-folder2"
>         do
>                 ensure_not_expanded read-tree -mu $MERGE_TREES &&
>      -          ensure_not_expanded reset --hard HEAD || return 1
>      +          ensure_not_expanded reset --hard || return 1
>
>        ## unpack-trees.c ##
>       @@ unpack-trees.c: static int is_sparse_directory_entry(struct cach=
e_entry *ce,
>  7:  c4080e99d6e ! 8:  6bc11325dd1 read-tree: make three-way merge sparse=
-aware
>      @@ Commit message
>           merge, the contents of each conflicted sparse directory are mer=
ged without
>           referencing the index, avoiding sparse index expansion.
>
>      +    As with two-way merge, the 't/t1092-sparse-checkout-compatibili=
ty.sh' test
>      +    'read-tree --merge with edit/edit conflicts in sparse directori=
es' confirms
>      +    that three-way merges with edit/edit changes (both with and wit=
hout
>      +    conflicts) inside a sparse directory result in the correct inde=
x state or
>      +    error message. To ensure the index is not unnecessarily expande=
d, add
>      +    three-way merge cases to 'sparse index is not expanded: read-tr=
ee'.
>      +
>           Signed-off-by: Victoria Dye <vdye@github.com>
>
>        ## builtin/read-tree.c ##
>      @@ builtin/read-tree.c: int cmd_read_tree(int argc, const char **arg=
v, const char *
>
>        ## t/t1092-sparse-checkout-compatibility.sh ##
>       @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 's=
parse index is not expanded: read-tree' '
>      +  init_repos &&
>
>         ensure_not_expanded checkout -b test-branch update-folder1 &&
>      -  for MERGE_TREES in "update-folder2" \
>      --                    "base update-folder2"
>      +- for MERGE_TREES in "base update-folder2" \
>      ++ for MERGE_TREES in "base HEAD update-folder2" \
>      ++                    "base HEAD rename-base" \
>       +                    "base update-folder2" \
>      -+                    "base HEAD update-folder2"
>      +                     "base rename-base" \
>      +                     "update-folder2"
>         do
>      -          ensure_not_expanded read-tree -mu $MERGE_TREES &&
>      -          ensure_not_expanded reset --hard HEAD || return 1
>
>        ## unpack-trees.c ##
>       @@ unpack-trees.c: int threeway_merge(const struct cache_entry * co=
nst *stages,
>      @@ unpack-trees.c: int threeway_merge(const struct cache_entry * con=
st *stages,
>
>         if (head) {
>                 /* #5ALT, #15 */
>      +@@ unpack-trees.c: int threeway_merge(const struct cache_entry * co=
nst *stages,
>      +
>      +  }
>      +
>      +- /* Below are "no merge" cases, which require that the index be
>      +-  * up-to-date to avoid the files getting overwritten with
>      +-  * conflict resolution files.
>      +-  */
>      ++ /* Handle "no merge" cases (see t/t1000-read-tree-m-3way.sh) */
>      +  if (index) {
>      ++         /*
>      ++          * If we've reached the "no merge" cases and we're mergin=
g
>      ++          * a sparse directory, we may have an "edit/edit" conflic=
t that
>      ++          * can be resolved by individually merging directory cont=
ents.
>      ++          */
>      ++         if (S_ISSPARSEDIR(index->ce_mode))
>      ++                 return merged_sparse_dir(stages, 4, o);
>      ++
>      ++         /*
>      ++          * If we're not merging a sparse directory, ensure the in=
dex is
>      ++          * up-to-date to avoid files getting overwritten with con=
flict
>      ++          * resolution files
>      ++          */
>      +          if (verify_uptodate(index, o))
>      +                  return -1;
>      +  }
>
> --
> gitgitgadget
