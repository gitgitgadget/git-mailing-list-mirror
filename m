Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34B11C43461
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 04:39:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CDAE610A5
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 04:39:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbhDAEjX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Apr 2021 00:39:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbhDAEih (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Apr 2021 00:38:37 -0400
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F689C0613E6
        for <git@vger.kernel.org>; Wed, 31 Mar 2021 21:38:37 -0700 (PDT)
Received: by mail-oo1-xc2f.google.com with SMTP id p2-20020a4aa8420000b02901bc7a7148c4so248449oom.11
        for <git@vger.kernel.org>; Wed, 31 Mar 2021 21:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QModkJTKpqY15IyuDPXad+gwg5DQZCYv/g5l3Yqcydc=;
        b=oWM0PqiAKbn0tglnK32UNaEpd1BJoa70TSJjFGNnxog+Az0KkgYCKrkcvKoSOsM4Od
         mnLWwP5T/ZiB0qb9c6VMmnAlpdTIiDG8oSUmtTeAXUG059AavsAwe2/ZOcAmDLig6VLV
         OxotgWdySY0AGeaDaFH3iWmX+OJCGv1k8NMDOPcITndGHJDVbXUtQFKaNkyUyNUfbblj
         IQcuq59PDfhaVhMNK3M3FK/b2wUxp8pdPg2efqtd7SG06vwLCT/V23tYwY5t/VVtgCzQ
         cF4YC3m8thaMTYfpV4wOzqMicl5/GnQMP+Sb+60HF2bRNm54IRz/DMd3riyueI37mGA/
         44sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QModkJTKpqY15IyuDPXad+gwg5DQZCYv/g5l3Yqcydc=;
        b=mvnglKeot0r6nUwtxqYNpfErU5npgFOObIAakDY0EM/Oc7u2mHMbQxQcDspIvstkFS
         PBxfyGNYt5FFkdHXUEXhwvilc6lMZQYvf1UY+WAl1wFmHcoZaHan65eI4cVE4bKtp6QD
         PgyztAPcioyIqB2yaA8Ip8JHhuVgAXkCGTB9en7Ppz9LpdSrHs64TYZdxXwkFbtFOcTr
         jFXMDrfJGKPylAO933XciY/AUmTNypyHTLyHnYqtk15M0njDCjXeePt3xZ2F/eNzQdao
         ecQ28zzBg1MgEZNzItZByGWujgkrtfU4NqhZLuSs7RCg5Hn3zEW44dla/jTL38WbX6lS
         AceQ==
X-Gm-Message-State: AOAM5320n6WaePZAsNDpnhQy7iEhXC5JgJ9UAaiqfFgxwsQxtLZskfNM
        fr++QObcpRLM+KNdQh3c6gxP+nEV5Bu2TFrcmvk=
X-Google-Smtp-Source: ABdhPJwl7YsZ0VZUsjoo3bDG+14WT2asBhbbZyyioSf/Xppvtw5XXPhJfUHrDrwkl3mVS9NdMLnTkV5fx0QewNQGeqE=
X-Received: by 2002:a4a:df08:: with SMTP id i8mr5537112oou.32.1617251916437;
 Wed, 31 Mar 2021 21:38:36 -0700 (PDT)
MIME-Version: 1.0
References: <pull.883.v4.git.1616507069.gitgitgadget@gmail.com> <pull.883.v5.git.1617109864.gitgitgadget@gmail.com>
In-Reply-To: <pull.883.v5.git.1617109864.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 31 Mar 2021 21:38:24 -0700
Message-ID: <CABPp-BEYdNtxMEdmaojCaQNR+DZ6eofCR0CnzkSZQp3KEERM1Q@mail.gmail.com>
Subject: Re: [PATCH v5 00/21] Sparse Index: Design, Format, Tests
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 30, 2021 at 6:11 AM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> Here is the first full patch series submission coming out of the
> sparse-index RFC [1].
>
> [1]
> https://lore.kernel.org/git/pull.847.git.1611596533.gitgitgadget@gmail.co=
m/
>
> I won't waste too much space here, because PATCH 1 includes a sizeable
> design document that describes the feature, the reasoning behind it, and =
my
> plan for getting this implemented widely throughout the codebase.
>
> There are some new things here that were not in the RFC:
>
>  * Design doc and format updates. (Patch 1)
>  * Performance test script. (Patches 2 and 20)
>
> Notably missing in this series from the RFC:
>
>  * The mega-patch inserting ensure_full_index() throughout the codebase.
>    That will be a follow-up series to this one.
>  * The integrations with git status and git add to demonstrate the improv=
ed
>    performance. Those will also appear in their own series later.
>
> I plan to keep my latest work in this area in my 'sparse-index/wip' branc=
h
> [2]. It includes all of the work from the RFC right now, updated with the
> work from this series.
>
> [2] https://github.com/derrickstolee/git/tree/sparse-index/wip
>
>
> Updates in V5
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> This version is updated to use an index extension instead of a repository
> format extension. Thanks, Szeder! This one change affects the range-diff
> quite a bit, so please review those changes carefully.
>
> In particular: git sparse-checkout init --cone --sparse-index now sets a =
new
> index.sparse config option as an indicator that we should attempt writing
> the index in sparse form.
>
>
> Updates in V4
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>  * Rebased onto the latest copy of ab/read-tree.
>  * Updated the design document as per Junio's comments.
>  * Updated the submodule handling in the performance test.
>  * Followed up on some other review from =C3=86var, mostly style or commi=
t
>    message things.
>
>
> Updates in V3
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> For this version, I took =C3=86var's latest patches and applied them to v=
2.31.0
> and rebased this series on top. It uses his new "read_tree_at()" helper a=
nd
> the associated changes to the function pointer type.
>
>  * Fixed more typos. Thanks Martin and Elijah!
>  * Updated the test_sparse_match() macro to use "$@" instead of $*
>  * Added a test that git sparse-checkout init --no-sparse-index rewrites =
the
>    index to be full.
>
>
> Updates in V2
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>  * Various typos and awkward grammar is fixed.
>  * Cleaned up unnecessary commands in p2000-sparse-operations.sh
>  * Added a comment to the sparse_index member of struct index_state.
>  * Used tree_type, commit_type, and blob_type in test-read-cache.c.
>
> Thanks, -Stolee
>
> Derrick Stolee (21):
>   sparse-index: design doc and format update
>   t/perf: add performance test for sparse operations
>   t1092: clean up script quoting
>   sparse-index: add guard to ensure full index
>   sparse-index: implement ensure_full_index()
>   t1092: compare sparse-checkout to sparse-index
>   test-read-cache: print cache entries with --table
>   test-tool: don't force full index
>   unpack-trees: ensure full index
>   sparse-checkout: hold pattern list in index
>   sparse-index: add 'sdir' index extension
>   sparse-index: convert from full to sparse
>   submodule: sparse-index should not collapse links
>   unpack-trees: allow sparse directories
>   sparse-index: check index conversion happens
>   sparse-index: add index.sparse config option
>   sparse-checkout: toggle sparse index from builtin
>   sparse-checkout: disable sparse-index
>   cache-tree: integrate with sparse directory entries
>   sparse-index: loose integration with cache_tree_verify()
>   p2000: add sparse-index repos
>
>  Documentation/config/index.txt           |   5 +
>  Documentation/git-sparse-checkout.txt    |  14 ++
>  Documentation/technical/index-format.txt |  19 ++
>  Documentation/technical/sparse-index.txt | 175 ++++++++++++++
>  Makefile                                 |   1 +
>  builtin/sparse-checkout.c                |  44 +++-
>  cache-tree.c                             |  40 ++++
>  cache.h                                  |  18 +-
>  read-cache.c                             |  44 +++-
>  repo-settings.c                          |  15 ++
>  repository.c                             |  11 +-
>  repository.h                             |   3 +
>  sparse-index.c                           | 285 +++++++++++++++++++++++
>  sparse-index.h                           |  11 +
>  t/README                                 |   3 +
>  t/helper/test-read-cache.c               |  66 +++++-
>  t/perf/p2000-sparse-operations.sh        | 101 ++++++++
>  t/t1091-sparse-checkout-builtin.sh       |  13 ++
>  t/t1092-sparse-checkout-compatibility.sh | 143 ++++++++++--
>  unpack-trees.c                           |  17 +-
>  20 files changed, 988 insertions(+), 40 deletions(-)
>  create mode 100644 Documentation/technical/sparse-index.txt
>  create mode 100644 sparse-index.c
>  create mode 100644 sparse-index.h
>  create mode 100755 t/perf/p2000-sparse-operations.sh
>
>
> base-commit: 47957485b3b731a7860e0554d2bd12c0dce1c75a
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-883%2Fd=
errickstolee%2Fsparse-index%2Fformat-v5
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-883/derric=
kstolee/sparse-index/format-v5
> Pull-Request: https://github.com/gitgitgadget/git/pull/883
>
> Range-diff vs v4:
>
>   1:  6426a5c60e53 !  1:  7b600d536c6e sparse-index: design doc and forma=
t update
>      @@ Documentation/technical/sparse-index.txt (new)
>       +The only noticeable change in behavior will be that the serialized=
 index
>       +file contains sparse-directory entries.
>       +
>      -+To start, we use a new repository extension, `extensions.sparseInd=
ex`, to
>      -+allow inserting sparse-directory entries into indexes with file fo=
rmat
>      ++To start, we use a new required index extension, `sdir`, to allow
>      ++inserting sparse-directory entries into indexes with file format
>       +versions 2, 3, and 4. This prevents Git versions that do not under=
stand
>      -+the sparse-index from operating on one, but it also prevents other
>      -+operations that do not use the index at all. A new format, index v=
5, will
>      -+be introduced that includes sparse-directory entries by default. I=
t might
>      -+also introduce other features that have been considered for improv=
ing the
>      ++the sparse-index from operating on one, while allowing tools that =
do not
>      ++understand the sparse-index to operate on repositories as long as =
they do
>      ++not interact with the index. A new format, index v5, will be intro=
duced
>      ++that includes sparse-directory entries by default. It might also
>      ++introduce other features that have been considered for improving t=
he
>       +index, as well.
>       +
>       +Next, consumers of the index will be guarded against operating on =
a
>   2:  7eabc1d0586c =3D  2:  202253ec82f3 t/perf: add performance test for=
 sparse operations
>   3:  c9e21d78ecba =3D  3:  437a0f144e57 t1092: clean up script quoting
>   4:  03cdde756563 =3D  4:  b7e1bf5c55a7 sparse-index: add guard to ensur=
e full index
>   5:  6b3b6d86385d =3D  5:  e41d55d2cca9 sparse-index: implement ensure_f=
ull_index()
>   6:  7f67adba0498 =3D  6:  7bfbfbd17321 t1092: compare sparse-checkout t=
o sparse-index
>   7:  7ebd9570b1ad =3D  7:  a1b8135c0fc8 test-read-cache: print cache ent=
ries with --table
>   8:  db7bbd06dbcc =3D  8:  dd84a2a9121b test-tool: don't force full inde=
x
>   9:  3ddd5e794b5e =3D  9:  b276d2ed5323 unpack-trees: ensure full index
>  10:  7308c87697f1 =3D 10:  c3651e26dc3a sparse-checkout: hold pattern li=
st in index
>   -:  ------------ > 11:  f926cf8b2e01 sparse-index: add 'sdir' index ext=
ension
>  11:  7c10d653ca6b =3D 12:  c870ae5e8749 sparse-index: convert from full =
to sparse
>  12:  6db36f33e960 =3D 13:  bcf0da959ef3 submodule: sparse-index should n=
ot collapse links
>  13:  d24bd3348d98 =3D 14:  7191b48237de unpack-trees: allow sparse direc=
tories
>  14:  08d9f5f3c0d1 =3D 15:  57be9b4a728b sparse-index: check index conver=
sion happens
>  15:  6f38cef196b0 ! 16:  c22b4111e49e sparse-index: create extension for=
 compatibility
>      @@ Metadata
>       Author: Derrick Stolee <dstolee@microsoft.com>
>
>        ## Commit message ##
>      -    sparse-index: create extension for compatibility
>      +    sparse-index: add index.sparse config option
>
>      -    Previously, we enabled the sparse index format only using
>      -    GIT_TEST_SPARSE_INDEX=3D1. This is not a feasible direction for=
 users to
>      -    actually select this mode. Further, sparse directory entries ar=
e not
>      -    understood by the index formats as advertised.
>      -
>      -    We _could_ add a new index version that explicitly adds these
>      -    capabilities, but there are nuances to index formats 2, 3, and =
4 that
>      -    are still valuable to select as options. Until we add index for=
mat
>      -    version 5, create a repo extension, "extensions.sparseIndex", t=
hat
>      -    specifies that the tool reading this repository must understand=
 sparse
>      -    directory entries.
>      -
>      -    This change only encodes the extension and enables it when
>      -    GIT_TEST_SPARSE_INDEX=3D1. Later, we will add a more user-frien=
dly CLI
>      -    mechanism.
>      +    When enabled, this config option signals that index writes shou=
ld
>      +    attempt to use sparse-directory entries.
>
>           Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
>
>      - ## Documentation/config/extensions.txt ##
>      -@@ Documentation/config/extensions.txt: extensions.objectFormat::
>      - Note that this setting should only be set by linkgit:git-init[1] o=
r
>      - linkgit:git-clone[1].  Trying to change it after initialization wi=
ll not
>      - work and will produce hard-to-diagnose issues.
>      + ## Documentation/config/index.txt ##
>      +@@ Documentation/config/index.txt: index.recordOffsetTable::
>      +  Defaults to 'true' if index.threads has been explicitly enabled,
>      +  'false' otherwise.
>      +
>      ++index.sparse::
>      ++ When enabled, write the index using sparse-directory entries. Thi=
s
>      ++ has no effect unless `core.sparseCheckout` and
>      ++ `core.sparseCheckoutCone` are both enabled. Defaults to 'false'.
>       +
>      -+extensions.sparseIndex::
>      -+ When combined with `core.sparseCheckout=3Dtrue` and
>      -+ `core.sparseCheckoutCone=3Dtrue`, the index may contain entries
>      -+ corresponding to directories outside of the sparse-checkout
>      -+ definition in lieu of containing each path under such directories=
.
>      -+ Versions of Git that do not understand this extension do not
>      -+ expect directory entries in the index.
>      + index.threads::
>      +  Specifies the number of threads to spawn when loading the index.
>      +  This is meant to reduce index load time on multiprocessor machine=
s.
>
>        ## cache.h ##
>       @@ cache.h: struct repository_format {
>      @@ repo-settings.c: void prepare_repo_settings(struct repository *r)
>       +  * Initialize this as off.
>       +  */
>       + r->settings.sparse_index =3D 0;
>      -+ if (!repo_config_get_bool(r, "extensions.sparseindex", &value) &&=
 value)
>      ++ if (!repo_config_get_bool(r, "index.sparse", &value) && value)
>       +         r->settings.sparse_index =3D 1;
>        }
>
>      @@ repository.h: struct repo_settings {
>
>        struct repository {
>
>      - ## setup.c ##
>      -@@ setup.c: static enum extension_result handle_extension(const cha=
r *var,
>      -                  return error("invalid value for 'extensions.objec=
tformat'");
>      -          data->hash_algo =3D format;
>      -          return EXTENSION_OK;
>      -+ } else if (!strcmp(ext, "sparseindex")) {
>      -+         data->sparse_index =3D 1;
>      -+         return EXTENSION_OK;
>      -  }
>      -  return EXTENSION_UNKNOWN;
>      - }
>      -
>        ## sparse-index.c ##
>       @@ sparse-index.c: static int convert_to_sparse_rec(struct index_st=
ate *istate,
>         return num_converted - start_converted;
>      @@ sparse-index.c: static int convert_to_sparse_rec(struct index_sta=
te *istate,
>       +{
>       + const char *config_path =3D repo_git_path(repo, "config.worktree"=
);
>       +
>      -+ if (upgrade_repository_format(1) < 0) {
>      -+         warning(_("unable to upgrade repository format to enable =
sparse-index"));
>      -+         return -1;
>      -+ }
>       + git_config_set_in_file_gently(config_path,
>      -+                               "extensions.sparseIndex",
>      ++                               "index.sparse",
>       +                               "true");
>       +
>       + prepare_repo_settings(repo);
>      @@ sparse-index.c: static int convert_to_sparse_rec(struct index_sta=
te *istate,
>       +
>       + /*
>       +  * The GIT_TEST_SPARSE_INDEX environment variable triggers the
>      -+  * extensions.sparseIndex config variable to be on.
>      ++  * index.sparse config variable to be on.
>       +  */
>       + if (git_env_bool("GIT_TEST_SPARSE_INDEX", 0)) {
>       +         int err =3D enable_sparse_index(istate->repo);
>      @@ sparse-index.c: static int convert_to_sparse_rec(struct index_sta=
te *istate,
>       -  * GIT_TEST_SPARSE_INDEX environment variable. We will relax
>       -  * this once we have a proper way to opt-in (and later still,
>       -  * opt-out).
>      -+  * Only convert to sparse if extensions.sparseIndex is set.
>      ++  * Only convert to sparse if index.sparse is set.
>          */
>       - if (!git_env_bool("GIT_TEST_SPARSE_INDEX", 0))
>       + prepare_repo_settings(istate->repo);
>  16:  923081e7e079 ! 17:  75fe9b0f57da sparse-checkout: toggle sparse ind=
ex from builtin
>      @@ Documentation/git-sparse-checkout.txt: To avoid interfering with =
other worktrees
>       +that is not completely understood by external tools. If you have t=
rouble
>       +with this compatibility, then run `git sparse-checkout init --no-s=
parse-index`
>       +to rewrite your index to not be sparse. Older versions of Git will=
 not
>      -+understand the `sparseIndex` repository extension and may fail to =
interact
>      -+with your repository until it is disabled.
>      ++understand the sparse directory entries index extension and may fa=
il to
>      ++interact with your repository until it is disabled.
>
>        'set'::
>         Write a set of patterns to the sparse-checkout file, as given as
>      @@ builtin/sparse-checkout.c: static int sparse_checkout_init(int ar=
gc, const char
>
>        ## sparse-index.c ##
>       @@ sparse-index.c: static int convert_to_sparse_rec(struct index_st=
ate *istate,
>      +  return num_converted - start_converted;
>      + }
>
>      - static int enable_sparse_index(struct repository *repo)
>      +-static int enable_sparse_index(struct repository *repo)
>      ++static int set_index_sparse_config(struct repository *repo, int en=
able)
>        {
>       - const char *config_path =3D repo_git_path(repo, "config.worktree"=
);
>      -+ int res;
>      -
>      -  if (upgrade_repository_format(1) < 0) {
>      -          warning(_("unable to upgrade repository format to enable =
sparse-index"));
>      -          return -1;
>      -  }
>      +-
>       - git_config_set_in_file_gently(config_path,
>      --                               "extensions.sparseIndex",
>      +-                               "index.sparse",
>       -                               "true");
>      -+ res =3D git_config_set_gently("extensions.sparseindex", "true");
>      ++ int res;
>      ++ char *config_path =3D repo_git_path(repo, "config.worktree");
>      ++ res =3D git_config_set_in_file_gently(config_path,
>      ++                                     "index.sparse",
>      ++                                     enable ? "true" : NULL);
>      ++ free(config_path);
>
>         prepare_repo_settings(repo);
>         repo->settings.sparse_index =3D 1;
>      @@ sparse-index.c: static int convert_to_sparse_rec(struct index_sta=
te *istate,
>       +
>       +int set_sparse_index_config(struct repository *repo, int enable)
>       +{
>      -+ int res;
>      -+
>      -+ if (enable)
>      -+         return enable_sparse_index(repo);
>      -+
>      -+ /* Don't downgrade repository format, just remove the extension. =
*/
>      -+ res =3D git_config_set_gently("extensions.sparseindex", NULL);
>      ++ int res =3D set_index_sparse_config(repo, enable);
>       +
>       + prepare_repo_settings(repo);
>      -+ repo->settings.sparse_index =3D 0;
>      ++ repo->settings.sparse_index =3D enable;
>       + return res;
>        }
>
>      @@ sparse-index.c: static int convert_to_sparse_rec(struct index_sta=
te *istate,
>             !core_apply_sparse_checkout || !core_sparse_checkout_cone)
>                 return 0;
>       @@ sparse-index.c: int convert_to_sparse(struct index_state *istate=
)
>      -          istate->repo =3D the_repository;
>      -
>      -  /*
>      --  * The GIT_TEST_SPARSE_INDEX environment variable triggers the
>      --  * extensions.sparseIndex config variable to be on.
>      -+  * If GIT_TEST_SPARSE_INDEX=3D1, then trigger extensions.sparseIn=
dex
>      -+  * to be fully enabled. If GIT_TEST_SPARSE_INDEX=3D0 (set explici=
tly),
>      -+  * then purposefully disable the setting.
>      +   * The GIT_TEST_SPARSE_INDEX environment variable triggers the
>      +   * index.sparse config variable to be on.
>          */
>       - if (git_env_bool("GIT_TEST_SPARSE_INDEX", 0)) {
>       -         int err =3D enable_sparse_index(istate->repo);
>      @@ sparse-index.c: int convert_to_sparse(struct index_state *istate)
>       +         set_sparse_index_config(istate->repo, test_env);
>
>         /*
>      -   * Only convert to sparse if extensions.sparseIndex is set.
>      +   * Only convert to sparse if index.sparse is set.
>
>        ## sparse-index.h ##
>       @@ sparse-index.h: struct index_state;
>      @@ t/t1092-sparse-checkout-compatibility.sh: init_repos () {
>       - GIT_TEST_SPARSE_INDEX=3D1 git -C sparse-index sparse-checkout ini=
t --cone &&
>       - GIT_TEST_SPARSE_INDEX=3D1 git -C sparse-index sparse-checkout set=
 deep
>       + git -C sparse-index sparse-checkout init --cone --sparse-index &&
>      -+ test_cmp_config -C sparse-index true extensions.sparseindex &&
>      ++ test_cmp_config -C sparse-index true index.sparse &&
>       + git -C sparse-index sparse-checkout set deep
>        }
>
>  17:  6f1ad72c390d ! 18:  7f55a232e647 sparse-checkout: disable sparse-in=
dex
>      @@ t/t1091-sparse-checkout-builtin.sh: test_expect_success 'sparse-c=
heckout disable
>
>       +test_expect_success 'sparse-index enabled and disabled' '
>       + git -C repo sparse-checkout init --cone --sparse-index &&
>      -+ test_cmp_config -C repo true extensions.sparseIndex &&
>      ++ test_cmp_config -C repo true index.sparse &&
>       + test-tool -C repo read-cache --table >cache &&
>       + grep " tree " cache &&
>       +
>      @@ t/t1091-sparse-checkout-builtin.sh: test_expect_success 'sparse-c=
heckout disable
>       + test-tool -C repo read-cache --table >cache &&
>       + ! grep " tree " cache &&
>       + git -C repo config --list >config &&
>      -+ ! grep extensions.sparseindex config
>      ++ ! grep index.sparse config
>       +'
>       +
>        test_expect_success 'cone mode: init and set' '
>  18:  bd94e6b7d089 =3D 19:  365901809d9d cache-tree: integrate with spars=
e directory entries
>  19:  e7190376b806 =3D 20:  9b068c458898 sparse-index: loose integration =
with cache_tree_verify()
>  20:  bcf0a58eb38c =3D 21:  66602733cc95 p2000: add sparse-index repos

I've read through the range-diff and individually read through the new
patch 11.  Perhaps unsurprisingly since you addressed all my feedback
by about round 3, I didn't find any problems with this new version.
Looks good to me.
