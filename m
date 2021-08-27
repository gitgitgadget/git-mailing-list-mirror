Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F910C432BE
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 21:56:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E30C760F91
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 21:56:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231998AbhH0V5V (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Aug 2021 17:57:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231906AbhH0V5U (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Aug 2021 17:57:20 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4156C0613D9
        for <git@vger.kernel.org>; Fri, 27 Aug 2021 14:56:30 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id i3-20020a056830210300b0051af5666070so9736522otc.4
        for <git@vger.kernel.org>; Fri, 27 Aug 2021 14:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1rBErrsIjmikmBY5a9uX3uFyjE/NoT7EmcUF/xZKRhI=;
        b=lNFdU2uiBDqLkV3TDBHYbjaWKWygJ30UNIDN/baalpejJOBeVXlG3aoeogygexRGz8
         /oGaupIfdjlpahhF1RlArv2xh90z1AIXdoB9ZRPaWSswpXE+OfCtVkI30o/vbbz+Hkfj
         4qZE9SKyvQ63LlTmg5TiEa9SNVaG0DmqnemQCwRMsx7klbiphMcdzaIF6z5wbYTfSZig
         40Qk1tRKPKVt/hExUwMKhUeIqh0/OjIJJ97S5oBdn5SbTsctNu2V7JuJ5Jt6v/7yRdy6
         h+y/KmpJxmRuxy1x9/NPUM6CmzVdAv6dUWL/QGyw5gpahEXjTcapYVcqx3bB4z171KTi
         GPjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1rBErrsIjmikmBY5a9uX3uFyjE/NoT7EmcUF/xZKRhI=;
        b=VCNWMZfduYz8w7GPm6YGGRop0VwjTJ1NoAGkTCCp3/v3ZYnLn/jgTo5YikhX+4oUwG
         zLceE4quqsB+u4htzlq7Qf2MvRdYg1i/7cKs69F+Hsk2gKO/8mgG2p6RIcfhYhr2ecZB
         4xNxU3y60SYnQYibVo4U8sA2KVUaUP8g/69zsE5e431DwMOQHrdcCgblC+Cmy/9vYJgI
         6t6KLKI1F7D3GaRGOviN7gjhyAl3eSmA+XqcbbAzM3eXGwEIgZElDWLSckCQXBR9VdGD
         nIVAqZ3AKCHlYqKKYiVVWK5qPyCrClBdnrvu97K3Wm8cd2pRKo5AP+OI++WQ89d3eLGQ
         /AKQ==
X-Gm-Message-State: AOAM531B/GK7TCLjocmZF8vhawmod7VfErYs09Ub/mFyBzISnEfroNp2
        eOYjJTv1MavVshUCNEjf5GCpL9Wwc9Gkc0c0Uh7iedLIVTY=
X-Google-Smtp-Source: ABdhPJzHNKpC3LDhElaL0KNCi9HkTO6liX6gFmKQ6kaKBzb287uhpCdABjN7JcSTTAILSCV0T31lOrWaLltV0vOPQXw=
X-Received: by 2002:a9d:630e:: with SMTP id q14mr9702046otk.316.1630101389937;
 Fri, 27 Aug 2021 14:56:29 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1009.v3.git.1629206602.gitgitgadget@gmail.com> <pull.1009.v4.git.1629841904.gitgitgadget@gmail.com>
In-Reply-To: <pull.1009.v4.git.1629841904.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 27 Aug 2021 14:56:18 -0700
Message-ID: <CABPp-BG01tXnd_UhYJDX4Tm_EcXGju9CkB8BXU0XS-YAWEuaeQ@mail.gmail.com>
Subject: Re: [PATCH v4 00/10] Sparse index: delete ignored files outside
 sparse cone
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee <stolee@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 24, 2021 at 2:51 PM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> UPDATE: I had to base this version on a merge of ds/add-with-sparse-index
> and v2.33.0-rc1 because of some changes to dir.h that became important!

Isn't this stale (i.e. just copied from v2/v3)?

...
> Updates in V4
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>  * Fixed an issue with the split index.
>
>  * The helper methods are used more consistently.
>
>  * The helper method path_in_cone_mode_sparse_checkout() is introduced.
>
>  * Commit messages are edited for clarity.
>
>  * A new config option is added to disable the behavior being added in th=
is
>    series.
>
>  * I split the commit that involves cache_tree_update(). I have not yet
>    succeeded in creating tests to demonstrate why this is required outsid=
e
>    of needing it in the Scalar functional tests, which includes a version=
 of
>    partial clone. I will continue to investigate recreating this scenario=
 in
>    the Git test suite, but I wanted to send this version out to get feedb=
ack
>    on the things that have changed.

Are you talking about patch 3 or patch 4?

For patch 4, as I commented on that patch, my guess would be that you
start with a full tree, pick some directory that you will sparsify
away, and before sparsifying it away, change some file under that
directory and stage the change.  Then when you sparsify the directory
away with cone mode, I think the cache_tree_update() will need to
write the tree.  At least, some quick greps of cache_tree_update
suggest there aren't that many codepaths that attempt to update it, so
I don't think anything else would have written it yet at that point.

For patch 3, since it comes before patch 5, it would be triggerable
with the same case.  Is it possible you originally found both patches
based off similar initial conditions that just resulted in slightly
different behavioral reports, and thus that patch 4 is good enough
without patch 3?  Trying to ignore that possibility and looking at the
cache_tree_update() code, the only other reasons for failure of
cache_tree_update() that I can see are (a) someone having invalid
hashes recorded in the index (e.g. someone using `git update-index
--index-info` with some invalid hashes, or someone manually deleting
some loose blobs from under their .git/ directory), or (b) disk being
full or read-only so that writing new tree objects to the object store
fail.

> base-commit: 80b8d6c56b8a5f5db1d5c2a0159fd808e8a7fc4f
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1009%2F=
derrickstolee%2Fsparse-index%2Fignored-files-v4
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1009/derri=
ckstolee/sparse-index/ignored-files-v4
> Pull-Request: https://github.com/gitgitgadget/git/pull/1009

A super micro nit:

It appears this is based on your other branches that have since been
incorporated into master.  Not a big deal, but rebasing on master
might make it easier for others to take a look at the series (I was
confused at first why this series depended on other unmerged series,
before realizing those other series had since merged down).  I know we
normally don't like rebasing series, but I suspect it wouldn't change
the range-diff (as I don't think others are touching these areas of
the code), and thus be transparent to Junio.



I commented on some individual patches, but have some small comments
that are easier to post in response to the range-diff:

> Range-diff vs v3:
>
>   1:  e66106f7a99 !  1:  c407b2cb346 t7519: rewrite sparse index test
>      @@ t/t7519-status-fsmonitor.sh: test_expect_success 'status succeeds=
 after staging/
>        test_expect_success 'status succeeds with sparse index' '
>       - git reset --hard &&
>       + git clone . full &&
>      -+ git clone . sparse &&
>      ++ git clone --sparse . sparse &&
>       + git -C sparse sparse-checkout init --cone --sparse-index &&
>       + git -C sparse sparse-checkout set dir1 dir2 &&
>
>   2:  fb3ff9108bf !  2:  8660877ba7a sparse-index: silently return when n=
ot using cone-mode patterns
>      @@ sparse-index.c: static int index_has_unmerged_entries(struct inde=
x_state *istate
>        {
>         int test_env;
>       - if (istate->split_index || istate->sparse_index ||
>      -+
>       + if (istate->split_index || istate->sparse_index || !istate->cache=
_nr ||
>             !core_apply_sparse_checkout || !core_sparse_checkout_cone)
>                 return 0;
>   3:  37198535268 !  3:  a669740af9a sparse-index: silently return when c=
ache tree fails
>      @@ Commit message
>           convert_to_sparse(), then we could still recover from this scen=
ario and
>           have a sparse index.
>
>      -    When constructing the cache-tree extension in convert_to_sparse=
(), it is
>      -    possible that we construct a tree object that is new to the obj=
ect
>      -    database. Without the WRITE_TREE_MISSING_OK flag, this results =
in an
>      -    error that halts our conversion to a sparse index. Add this fla=
g to
>      -    remove this limitation.
>      -
>           Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
>
>        ## sparse-index.c ##
>      @@ sparse-index.c: int convert_to_sparse(struct index_state *istate)
>       + /*
>       +  * Silently return if there is a problem with the cache tree upda=
te,
>       +  * which might just be due to a conflict state in some entry.
>      -+  *
>      -+  * This might create new tree objects, so be sure to use
>      -+  * WRITE_TREE_MISSING_OK.
>       +  */
>      -+ if (cache_tree_update(istate, WRITE_TREE_MISSING_OK))
>      ++ if (cache_tree_update(istate, 0))
>       +         return 0;
>
>         remove_fsmonitor(istate);
>   -:  ----------- >  4:  b379b8fc61a sparse-index: use WRITE_TREE_MISSING=
_OK

Thanks for splitting patch 3 & 4.  I left some comments on patch 5.
For patch 4, my comments above about testcases might be of interest.

>   4:  10bcadb284e !  5:  acdded0f762 unpack-trees: fix nested sparse-dir =
search
>      @@ Commit message
>           diff that modified files within the sparse directory entry, but=
 we could
>           not correctly find the entry.
>
>      +    Helped-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
>      +    Helped-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
>           Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
>
>        ## unpack-trees.c ##
>      @@ unpack-trees.c: static int sparse_dir_matches_path(const struct c=
ache_entry *ce,
>                                             const struct name_entry *p)
>        {
>       - struct cache_entry *ce;
>      ++ const char *path;
>       + struct cache_entry *ce =3D NULL;
>         int pos =3D find_cache_pos(info, p->path, p->pathlen);
>         struct unpack_trees_options *o =3D info->data;
>      -+ struct strbuf full_path =3D STRBUF_INIT;
>
>      -  if (0 <=3D pos)
>      -          return o->src_index->cache[pos];
>      -@@ unpack-trees.c: static struct cache_entry *find_cache_entry(stru=
ct traverse_info *info,
>      -  if (pos < 0 || pos >=3D o->src_index->cache_nr)
>      -          return NULL;
>      -
>      -+ strbuf_addstr(&full_path, info->traverse_path);
>      -+ strbuf_add(&full_path, p->path, p->pathlen);
>      -+ strbuf_addch(&full_path, '/');
>      -+
>      -  /*
>      -   * Due to lexicographic sorting and sparse directory
>      -   * entries ending with a trailing slash, our path as a
>       @@ unpack-trees.c: static struct cache_entry *find_cache_entry(stru=
ct traverse_info *info,
>         while (pos >=3D 0) {
>                 ce =3D o->src_index->cache[pos];
>
>       -         if (strncmp(ce->name, p->path, p->pathlen))
>      --                 return NULL;
>      -+         if (strncmp(ce->name, full_path.buf, full_path.len)) {
>      -+                 ce =3D NULL;
>      -+                 break;
>      -+         }
>      ++         if (!skip_prefix(ce->name, info->traverse_path, &path) ||
>      ++             strncmp(path, p->path, p->pathlen) ||
>      ++             path[p->pathlen] !=3D '/')
>      +                  return NULL;
>
>                 if (S_ISSPARSEDIR(ce->ce_mode) &&
>      -              sparse_dir_matches_path(ce, info, p))
>      --                 return ce;
>      -+                 break;
>      -
>      -          pos--;
>      -  }
>      -
>      -- return NULL;
>      -+ strbuf_release(&full_path);
>      -+ return ce;
>      - }
>      -
>      - static void debug_path(struct traverse_info *info)

Ren=C3=A9's suggestion definitely made this patch simpler (which sticks out
more when you look at the patch rather than the range-diff).

>   5:  5d28570c82a !  6:  1958751aa0e sparse-checkout: create helper metho=
ds
>      @@ Commit message
>           adopt these helpers. There are just two in builtin/add.c and
>           sparse-index.c that can use path_in_sparse_checkout().
>
>      +    We add a path_in_cone_mode_sparse_checkout() as well that will =
only
>      +    return false if the path is outside of the sparse-checkout defi=
nition
>      +    _and_ the sparse-checkout patterns are in cone mode.
>      +
>           Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
>
>        ## builtin/add.c ##
>      @@ builtin/add.c: static int refresh(int verbose, const struct paths=
pec *pathspec)
>       -                     (sparse_checkout_enabled &&
>       -                      !path_matches_pattern_list(path, strlen(path=
), NULL,
>       -                                                 &dtype, &pl, &the=
_index))) {
>      -+                     (core_apply_sparse_checkout &&
>      -+                      path_in_sparse_checkout(path, &the_index) =
=3D=3D NOT_MATCHED)) {
>      ++                     !path_in_sparse_checkout(path, &the_index)) {
>                                 string_list_append(&only_match_skip_workt=
ree,
>                                                    pathspec->items[i].ori=
ginal);
>                         } else {
>      @@ dir.c: done:
>
>       +int init_sparse_checkout_patterns(struct index_state *istate)
>       +{
>      -+ if (!core_apply_sparse_checkout ||
>      -+     istate->sparse_checkout_patterns)
>      ++ if (!core_apply_sparse_checkout)
>      ++         return 1;
>      ++ if (istate->sparse_checkout_patterns)
>       +         return 0;
>       +
>       + CALLOC_ARRAY(istate->sparse_checkout_patterns, 1);
>      @@ dir.c: done:
>       + return 0;
>       +}
>       +
>      -+int path_in_sparse_checkout(const char *path,
>      -+                     struct index_state *istate)
>      ++static int path_in_sparse_checkout_1(const char *path,
>      ++                              struct index_state *istate,
>      ++                              int require_cone_mode)
>       +{
>       + const char *base;
>       + int dtype =3D DT_REG;
>      -+ init_sparse_checkout_patterns(istate);
>       +
>      -+ if (!istate->sparse_checkout_patterns)
>      -+         return MATCHED;
>      ++ /*
>      ++  * We default to accepting a path if there are no patterns or
>      ++  * they are of the wrong type.
>      ++  */
>      ++ if (init_sparse_checkout_patterns(istate) ||
>      ++     (require_cone_mode &&
>      ++      !istate->sparse_checkout_patterns->use_cone_patterns))
>      ++         return 1;
>       +
>       + base =3D strrchr(path, '/');
>       + return path_matches_pattern_list(path, strlen(path), base ? base =
+ 1 : path,
>      @@ dir.c: done:
>       +                                  istate->sparse_checkout_patterns=
,
>       +                                  istate) > 0;
>       +}
>      ++
>      ++int path_in_sparse_checkout(const char *path,
>      ++                     struct index_state *istate)
>      ++{
>      ++ return path_in_sparse_checkout_1(path, istate, 0);
>      ++}
>      ++
>      ++int path_in_cone_mode_sparse_checkout(const char *path,
>      ++                              struct index_state *istate)
>      ++{
>      ++ return path_in_sparse_checkout_1(path, istate, 1);
>      ++}
>       +
>        static struct path_pattern *last_matching_pattern_from_lists(
>                 struct dir_struct *dir, struct index_state *istate,
>      @@ dir.h: enum pattern_match_result path_matches_pattern_list(const =
char *pathname,
>       +
>       +int path_in_sparse_checkout(const char *path,
>       +                     struct index_state *istate);
>      ++int path_in_cone_mode_sparse_checkout(const char *path,
>      ++                               struct index_state *istate);
>       +
>        struct dir_entry *dir_add_ignored(struct dir_struct *dir,
>                                   struct index_state *istate,
>      @@ dir.h: enum pattern_match_result path_matches_pattern_list(const =
char *pathname,
>
>        ## sparse-index.c ##
>       @@ sparse-index.c: static int convert_to_sparse_rec(struct index_st=
ate *istate,
>      + {
>         int i, can_convert =3D 1;
>         int start_converted =3D num_converted;
>      -  enum pattern_match_result match;
>      +- enum pattern_match_result match;
>       - int dtype =3D DT_UNKNOWN;
>         struct strbuf child_path =3D STRBUF_INIT;
>       - struct pattern_list *pl =3D istate->sparse_checkout_patterns;
>      @@ sparse-index.c: static int convert_to_sparse_rec(struct index_sta=
te *istate,
>          */
>       - match =3D path_matches_pattern_list(ct_path, ct_pathlen,
>       -                                   NULL, &dtype, pl, istate);
>      -+ match =3D path_in_sparse_checkout(ct_path, istate);
>      -  if (match !=3D NOT_MATCHED)
>      +- if (match !=3D NOT_MATCHED)
>      ++ if (path_in_sparse_checkout(ct_path, istate))
>                 can_convert =3D 0;
>
>      +  for (i =3D start; can_convert && i < end; i++) {
>       @@ sparse-index.c: int convert_to_sparse(struct index_state *istate=
)
>         if (!istate->repo->settings.sparse_index)
>                 return 0;
>      @@ sparse-index.c: int convert_to_sparse(struct index_state *istate)
>       -         if (get_sparse_checkout_patterns(istate->sparse_checkout_=
patterns) < 0)
>       -                 return 0;
>       - }
>      -+ if (init_sparse_checkout_patterns(istate) < 0)
>      ++ if (init_sparse_checkout_patterns(istate))
>       +         return 0;
>
>         /*
>   6:  c9e100e68f8 !  7:  e496f3cee66 attr: be careful about sparse direct=
ories
>      @@ attr.c: static struct attr_stack *read_attr_from_index(struct ind=
ex_state *istat
>                 return NULL;
>
>       + /*
>      -+  * In the case of cone-mode sparse-checkout, getting the
>      -+  * .gitattributes file from a directory is meaningless: all
>      -+  * contained paths will be sparse if the .gitattributes is also
>      -+  * sparse. In the case of a sparse index, it is critical that we
>      -+  * don't go looking for one as it will expand the index.
>      ++  * The .gitattributes file only applies to files within its
>      ++  * parent directory. In the case of cone-mode sparse-checkout,
>      ++  * the .gitattributes file is sparse if and only if all paths
>      ++  * within that directory are also sparse. Thus, don't load the
>      ++  * .gitattributes file since it will not matter.
>      ++  *
>      ++  * In the case of a sparse index, it is critical that we don't go
>      ++  * looking for a .gitattributes file, as the index will expand.

This comment is better, and I appreciate the thought behind adding the
second paragraph, but the wording seems fuzzy and potentially
confusing to future readers.  Perhaps changing the wording to:

...looking for a .gitattributes file, as doing so would cause the
index to expand.

>       +  */
>      -+ init_sparse_checkout_patterns(istate);
>      -+ if (istate->sparse_checkout_patterns &&
>      -+     istate->sparse_checkout_patterns->use_cone_patterns &&
>      -+     path_in_sparse_checkout(path, istate) =3D=3D NOT_MATCHED)
>      ++ if (!path_in_cone_mode_sparse_checkout(path, istate))
>       +         return NULL;
>       +
>         buf =3D read_blob_data_from_index(istate, path, NULL);
>   7:  b0ece4b7dcc !  8:  cab9360b1e9 sparse-index: add SPARSE_INDEX_IGNOR=
E_CONFIG flag
>      @@ Metadata
>       Author: Derrick Stolee <dstolee@microsoft.com>
>
>        ## Commit message ##
>      -    sparse-index: add SPARSE_INDEX_IGNORE_CONFIG flag
>      +    sparse-index: add SPARSE_INDEX_MEMORY_ONLY flag
>
>           The convert_to_sparse() method checks for the GIT_TEST_SPARSE_I=
NDEX
>           environment variable or the "index.sparse" config setting befor=
e
>      @@ Commit message
>           index as an in-memory data structure, regardless of whether the=
 on-disk
>           format should be sparse.
>
>      -    To that end, create the SPARSE_INDEX_IGNORE_CONFIG flag that wi=
ll skip
>      +    To that end, create the SPARSE_INDEX_MEMORY_ONLY flag that will=
 skip
>           these config checks when enabled. All current consumers are mod=
ified to
>           pass '0' in the new 'flags' parameter.
>
>      @@ sparse-index.c: static int index_has_unmerged_entries(struct inde=
x_state *istate
>       +int convert_to_sparse(struct index_state *istate, int flags)
>        {
>         int test_env;
>      +- if (istate->split_index || istate->sparse_index || !istate->cache=
_nr ||
>      ++ if (istate->sparse_index || !istate->cache_nr ||
>      +      !core_apply_sparse_checkout || !core_sparse_checkout_cone)
>      +          return 0;
>
>      -@@ sparse-index.c: int convert_to_sparse(struct index_state *istate=
)
>         if (!istate->repo)
>                 istate->repo =3D the_repository;
>
>      @@ sparse-index.c: int convert_to_sparse(struct index_state *istate)
>       - test_env =3D git_env_bool("GIT_TEST_SPARSE_INDEX", -1);
>       - if (test_env >=3D 0)
>       -         set_sparse_index_config(istate->repo, test_env);
>      -+ if (!(flags & SPARSE_INDEX_IGNORE_CONFIG)) {
>      ++ if (!(flags & SPARSE_INDEX_MEMORY_ONLY)) {
>      ++         /*
>      ++          * The sparse index is not (yet) integrated with a split =
index.
>      ++          */
>      ++         if (istate->split_index)
>      ++                 return 0;
>       +         /*
>       +          * The GIT_TEST_SPARSE_INDEX environment variable trigger=
s the
>       +          * index.sparse config variable to be on.
>      @@ sparse-index.c: int convert_to_sparse(struct index_state *istate)
>       +                 return 0;
>       + }
>
>      -  if (init_sparse_checkout_patterns(istate) < 0)
>      +  if (init_sparse_checkout_patterns(istate))
>                 return 0;
>
>        ## sparse-index.h ##
>      @@ sparse-index.h
>
>        struct index_state;
>       -int convert_to_sparse(struct index_state *istate);
>      -+#define SPARSE_INDEX_IGNORE_CONFIG (1 << 0)
>      ++#define SPARSE_INDEX_MEMORY_ONLY (1 << 0)
>       +int convert_to_sparse(struct index_state *istate, int flags);
>
>        /*
>   8:  febef675f05 !  9:  c19d93ec5d7 sparse-checkout: clear tracked spars=
e dirs
>      @@ Commit message
>           the sparse directory. This depends on the indexed version of th=
e file,
>           so the sparse directory must be expanded.
>
>      +    We must take special care to look for untracked, non-ignored fi=
les in
>      +    these directories before deleting them. We do not want to delet=
e any
>      +    meaningful work that the users were doing in those directories =
and
>      +    perhaps forgot to add and commit before switching sparse-checko=
ut
>      +    definitions. Since those untracked files might be code files th=
at
>      +    generated ignored build output, also do not delete any ignored =
files
>      +    from these directories in that case. The users can recover thei=
r state
>      +    by resetting their sparse-checkout definition to include that d=
irectory
>      +    and continue. Alternatively, they can see the warning that is p=
resented
>      +    and delete the directory themselves to regain the performance t=
hey
>      +    expect.
>      +
>           By deleting the sparse directories when changing scope (or runn=
ing 'git
>           sparse-checkout reapply') we regain these performance benefits =
as if the
>           repository was in a clean state.
>      @@ Documentation/git-sparse-checkout.txt: case-insensitive check. Th=
is corrects for
>        'git sparse-checkout set' command to reflect the expected cone in =
the working
>        directory.
>
>      -+The cone mode sparse-checkout patterns will also remove ignored fi=
les that
>      -+are not within the sparse-checkout definition. This is important b=
ehavior
>      -+to preserve the performance of the sparse index, but also matches =
that
>      -+cone mode patterns care about directories, not files. If there exi=
st files
>      -+that are untracked and not ignored, then Git will not delete files=
 within
>      -+that directory other than the tracked files that are now out of sc=
ope.
>      -+These files should be removed manually to ensure Git can behave op=
timally.
>      ++When changing the sparse-checkout patterns in cone mode, Git will =
inspect each
>      ++tracked directory that is not within the sparse-checkout cone to s=
ee if it
>      ++contains any untracked files. If all of those files are ignored du=
e to the
>      ++`.gitignore` patterns, then the directory will be deleted. If any =
of the
>      ++untracked files within that directory is not ignored, then no dele=
tions will
>      ++occur within that directory and a warning message will appear. If =
these files
>      ++are important, then reset your sparse-checkout definition so they =
are included,
>      ++use `git add` and `git commit` to store them, then remove any rema=
ining files
>      ++manually to ensure Git can behave optimally.
>       +
>
>        SUBMODULES
>      @@ builtin/sparse-checkout.c: static int sparse_checkout_list(int ar=
gc, const char
>       +  */
>       + if (!r || !r->index || !r->worktree)
>       +         return;
>      -+ init_sparse_checkout_patterns(r->index);
>      -+ if (!r->index->sparse_checkout_patterns ||
>      ++ if (init_sparse_checkout_patterns(r->index) ||
>       +     !r->index->sparse_checkout_patterns->use_cone_patterns)
>       +         return;
>       +
>      @@ builtin/sparse-checkout.c: static int sparse_checkout_list(int ar=
gc, const char
>       +          * prevents us from converting to a sparse index, then do
>       +          * not try deleting files.
>       +          */
>      -+         if (convert_to_sparse(r->index, SPARSE_INDEX_IGNORE_CONFI=
G))
>      ++         if (convert_to_sparse(r->index, SPARSE_INDEX_MEMORY_ONLY)=
)
>       +                 return;
>       +         was_full =3D 1;
>       + }

Thanks for the extra explanations; those help.

You haven't yet addressed how this choice will interact with
.gitignore files, though (as I commented on v3).  You alluded in patch
7 to how it was critical to avoid looking for .gitattributes files
because doing so would require the index to expand, possibly
recursively all the way down.  Don't .gitignore files have the same
problem?  Nuking all the ignored files so that you can delete extra
directories and thus not need to walk into them during operations
helps, but does the fact that we sometimes avoid removing directories
mean we have to walk into them anyway?  Do we only need to walk into
such directories when they are (still? again?) present in the working
copy?  Does there need to be some code added somewhere that checks for
the presence of a directory in the working copy and unsparsifies
sparse directory entries in the index when such directories are found?

Also, does non-cone mode sparsity paths have weird bugs around letting
users specify patterns that would happen to also exclude .gitignore
files from the working copy, but keep other sibling files within the
same directory?  In particular, if the .gitignore files aren't
present, does git add -A add a bunch of supposed-to-be-ignored files?
(If so, that's an issue that's probably tangential to this series
since it's not about cone mode or the sparse index, but it's certainly
an interesting thought.)

Maybe the whole .gitignore situation with cone mode has a simple
answer, but since this whole series is about gaining performance by
avoiding recursing into directories corresponding to sparse directory
entries, it feels the answers to how .gitignore will be handled should
at least be addressed.

>   -:  ----------- > 10:  8d55a6ba2fd sparse-checkout: add config to disab=
le deleting dirs

I left some comments.


Thanks, as always, for all your hard work on this!
