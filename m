Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 644C5C54EBE
	for <git@archiver.kernel.org>; Mon,  9 Jan 2023 09:15:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237073AbjAIJPS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Jan 2023 04:15:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237135AbjAIJNa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jan 2023 04:13:30 -0500
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87220D2DA
        for <git@vger.kernel.org>; Mon,  9 Jan 2023 01:11:04 -0800 (PST)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-150debe2b7cso8076051fac.0
        for <git@vger.kernel.org>; Mon, 09 Jan 2023 01:11:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=69sVJwsSGj8xJxe+J9JH646sQY5nmm4fcr+dbx/DccE=;
        b=kjI1oqlYcZz58ImeEMFC80OQBNi0Hf3469PdMyGlzARW8E6ZuNXIltMk3cKnKUVgqZ
         BKFW7n71WylscHyLFgNNSsdoRU9AJl1uEUmjpI7NYWCN7M4NRxzzzSNEhxiH+US6XDXE
         Elo9ZlVoGwhVF6XVNhy93udYdlRF/tR6Sg8PBdXcebsQG4TOVLTkFSBK3hIQCaPx6LQ5
         WwjJksmV9mUpe0utkbet7gYebjHx6Y0/H0hZcWirpvMeZzRaLh3nWAI6amnGihjR6/J5
         8T06GBxk1HTSD915WlKHkyhMIMEV+PC0RCNd4vg6j5B8zDivgmZxleDTq2g09N1D5IZb
         RH8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=69sVJwsSGj8xJxe+J9JH646sQY5nmm4fcr+dbx/DccE=;
        b=3Wt3BMmA+K9gSM8YLY3o9URoS46hmpFKoggqi9iKZmgCQvpwAsIV7MNGlyUBcusXbc
         Qj2AdIMSD8TUdsTsh50EdlD++Pw86mC+mYNUgJ0hEdDOX9H6i+hly19usMSNY2S+1A3p
         t7FOVdu9G7Wd2IvAOChflC9Mz3gAEViwbzWnp6O5EWe/bMRyGUBWakbCYLkvKXtuQUYQ
         7ULxKGUhLTVEjOEKxlYAUQS8wVlfrfg57TisJDARPAf9sDviKz4uSyg8J5zJdOzvYpvK
         Voi69eLAnuk/BbiyqnZ1ZyeInaFCaw/UINkNCQH9UntgbKFiK8MRzpJLGZ5FHmb3Fz5z
         4SaA==
X-Gm-Message-State: AFqh2kopgbxZ1PQnzrGBGktdjONP6aU1IHqaZkTTieOFsCj2m4T2a2x/
        OmE/d40sfEeeeXPmMp9KYH47nWRzVugiAB4XXmICMk3xWDE=
X-Google-Smtp-Source: AMrXdXvMxSVd0RtEdJEne7DVwoRhD+DAvKbFOCjP0vNgf8KwotXZGpkHtB1ppeBsfej7FI271qfEry8JKV7F6FFc7IM=
X-Received: by 2002:a05:6870:ad0a:b0:15b:5577:8428 with SMTP id
 nt10-20020a056870ad0a00b0015b55778428mr243784oab.232.1673255463100; Mon, 09
 Jan 2023 01:11:03 -0800 (PST)
MIME-Version: 1.0
References: <cover.1671793109.git.karthik.188@gmail.com>
In-Reply-To: <cover.1671793109.git.karthik.188@gmail.com>
From:   Karthik Nayak <karthik.188@gmail.com>
Date:   Mon, 9 Jan 2023 10:10:37 +0100
Message-ID: <CAOLa=ZQxx4J8B4wOeuz3C19WD4wF7N4bcDwsNUUJWhd+vQvQgw@mail.gmail.com>
Subject: Re: [PATCH v5 0/2] check-attr: add support to work with tree-ish
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>, phillip.wood@dunelm.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bumping for reviews, before I re-roll with the fix for `make hdr-check`


- Karthik

On Mon, Jan 2, 2023 at 12:04 PM Karthik Nayak <karthik.188@gmail.com> wrote:
>
> v1: https://lore.kernel.org/git/20221206103736.53909-1-karthik.188@gmail.com/
> v2: https://lore.kernel.org/git/CAOLa=ZSsFGBw3ta1jWN8cmUch2ca=zTEjp1xMA6Linafx9W53g@mail.gmail.com/T/#t
> v3: https://lore.kernel.org/git/20221216093552.3171319-1-karthik.188@gmail.com/
> v4: https://lore.kernel.org/git/cover.1671630304.git.karthik.188@gmail.com
>
> Given a pathname, git-check-attr(1) will list the attributes which apply to that
> pathname by reading all relevant gitattributes files. Currently there is no way
> to specify a tree-ish to read the gitattributes from.
>
> This is specifically useful in bare repositories wherein the gitattributes are
> only present in the git working tree but not available directly on the
> filesystem.
>
> This series aims to add a new flag `--source` to git-check-attr(1) which
> allows us to read gitattributes from the specified tree-ish.
>
> Changes since version 4:
> - Changed the flag from `--revision` to `--source`
> - Removed uneeded header imports
> - Using a pre-initialized variable instead of malloc for the tree_oid
> - Using `die()` instead of `error()` for bad tree-ish provided
>
> Range-diff against v4:
>
> 1:  6224754179 = 1:  6224754179 t0003: move setup for `--all` into new block
> 2:  a161dbdf8b ! 2:  d835d989ad attr: add flag `--revision` to work with revisions
>     @@ Metadata
>      Author: Karthik Nayak <karthik.188@gmail.com>
>
>       ## Commit message ##
>     -    attr: add flag `--revision` to work with revisions
>     +    attr: add flag `--source` to work with tree-ish
>
>          The contents of the .gitattributes files may evolve over time, but "git
>          check-attr" always checks attributes against them in the working tree
>          and/or in the index. It may be beneficial to optionally allow the users
>          to check attributes taken from a commit other than HEAD against paths.
>
>     -    Add a new flag `--revision` which will allow users to check the
>     +    Add a new flag `--source` which will allow users to check the
>          attributes against a commit (actually any tree-ish would do). When the
>          user uses this flag, we go through the stack of .gitattributes files but
>          instead of checking the current working tree and/or in the index, we
>          check the blobs from the provided tree-ish object. This allows the
>          command to also be used in bare repositories.
>
>     -    Since we use a tree-ish object, the user can pass "--revision
>     +    Since we use a tree-ish object, the user can pass "--source
>          HEAD:subdirectory" and all the attributes will be looked up as if
>          subdirectory was the root directory of the repository.
>
>     -    We cannot simply use the `<rev>:<path>` syntax without the `--revision`
>     +    We cannot simply use the `<rev>:<path>` syntax without the `--source`
>          flag, similar to how it is used in `git show` because any non-flag
>          parameter before `--` is treated as an attribute and any parameter after
>          `--` is treated as a pathname.
>
>          The change involves creating a new function `read_attr_from_blob`, which
>     -    given the path reads the blob for the path against the provided revision and
>     +    given the path reads the blob for the path against the provided source and
>          parses the attributes line by line. This function is plugged into
>          `read_attr()` function wherein we go through the stack of attributes
>          files.
>     @@ Documentation/git-check-attr.txt: git-check-attr - Display gitattributes informa
>       [verse]
>      -'git check-attr' [-a | --all | <attr>...] [--] <pathname>...
>      -'git check-attr' --stdin [-z] [-a | --all | <attr>...]
>     -+'git check-attr' [--revision <revision>] [-a | --all | <attr>...] [--] <pathname>...
>     -+'git check-attr' --stdin [-z] [--revision <revision>] [-a | --all | <attr>...]
>     ++'git check-attr' [--source <tree>] [-a | --all | <attr>...] [--] <pathname>...
>     ++'git check-attr' --stdin [-z] [--source <tree>] [-a | --all | <attr>...]
>
>       DESCRIPTION
>       -----------
>     @@ Documentation/git-check-attr.txt: OPTIONS
>         If `--stdin` is also given, input paths are separated
>         with a NUL character instead of a linefeed character.
>
>     -+--revision=<revision>::
>     -+  Check attributes against the specified commit. All the attributes will
>     -+  be checked against the provided revision. Paths provided as part of the
>     -+  revision will be treated as the root directory.
>     ++--source=<tree>::
>     ++  Check attributes against the specified tree-ish. Paths provided as part
>     ++  of the revision will be treated as the root directory. It is common to
>     ++  specify the source tree by naming a commit, branch or tag associated
>     ++  with it.
>      +
>       \--::
>         Interpret all preceding arguments as attributes and all following
>     @@ archive.c: static const struct attr_check *get_archive_attrs(struct index_state
>
>       ## attr.c ##
>      @@
>     - #include "exec-cmd.h"
>     - #include "attr.h"
>       #include "dir.h"
>     -+#include "strbuf.h"
>     -+#include "tree-walk.h"
>       #include "utf8.h"
>       #include "quote.h"
>      +#include "revision.h"
>     @@ attr.c: void git_check_attr(struct index_state *istate,
>                 const char *name = check->all_attrs[i].attr->name;
>
>       ## attr.h ##
>     -@@
>     - #ifndef ATTR_H
>     - #define ATTR_H
>     -
>     -+#include "hash.h"
>     -+
>     - /**
>     -  * gitattributes mechanism gives a uniform way to associate various attributes
>     -  * to set of paths.
>      @@ attr.h: void attr_check_free(struct attr_check *check);
>       const char *git_attr_name(const struct git_attr *);
>
>     @@ attr.h: void attr_check_free(struct attr_check *check);
>       enum git_attr_direction {
>
>       ## builtin/check-attr.c ##
>     -@@
>     -+#include "repository.h"
>     - #define USE_THE_INDEX_VARIABLE
>     - #include "builtin.h"
>     - #include "cache.h"
>      @@
>       static int all_attrs;
>       static int cached_attrs;
>       static int stdin_paths;
>     -+static char *revision;
>     ++static char *source;
>       static const char * const check_attr_usage[] = {
>      -N_("git check-attr [-a | --all | <attr>...] [--] <pathname>..."),
>      -N_("git check-attr --stdin [-z] [-a | --all | <attr>...]"),
>     -+N_("git check-attr [--revision <revision>] [-a | --all | <attr>...] [--] <pathname>..."),
>     -+N_("git check-attr --stdin [-z] [--revision <revision>] [-a | --all | <attr>...]"),
>     ++N_("git check-attr [--source <tree>] [-a | --all | <attr>...] [--] <pathname>..."),
>     ++N_("git check-attr --stdin [-z] [--source <tree>] [-a | --all | <attr>...]"),
>       NULL
>       };
>
>     @@ builtin/check-attr.c: static const struct option check_attr_options[] = {
>         OPT_BOOL(0 , "stdin", &stdin_paths, N_("read file names from stdin")),
>         OPT_BOOL('z', NULL, &nul_term_line,
>                  N_("terminate input and output records by a NUL character")),
>     -+  OPT_STRING(0, "revision", &revision, N_("revision"), N_("check attributes at this revision")),
>     ++  OPT_STRING(0, "source", &source, N_("<tree-ish>"), N_("which tree-ish to check attributes at")),
>         OPT_END()
>       };
>
>     @@ builtin/check-attr.c: static NORETURN void error_with_usage(const char *msg)
>       {
>         struct attr_check *check;
>      +  struct object_id *tree_oid = NULL;
>     ++  struct object_id initialized_oid;
>         int cnt, i, doubledash, filei;
>
>         if (!is_bare_repository())
>     @@ builtin/check-attr.c: int cmd_check_attr(int argc, const char **argv, const char
>                 }
>         }
>
>     -+  if (revision) {
>     -+          tree_oid = xmalloc(sizeof(struct object_id));
>     -+
>     -+          if (repo_get_oid_tree(the_repository, revision, tree_oid))
>     -+                  error("%s: not a valid revision", revision);
>     ++  if (source) {
>     ++          if (repo_get_oid_tree(the_repository, source, &initialized_oid))
>     ++                  die("%s: not a valid tree-ish source", source);
>     ++          tree_oid = &initialized_oid;
>      +  }
>      +
>         if (stdin_paths)
>     @@ t/t0003-attributes.sh: attr_check_quote () {
>         test_cmp expect actual
>      +}
>      +
>     -+attr_check_revision () {
>     -+  path="$1" expect="$2" revision="$3" git_opts="$4" &&
>     ++attr_check_source () {
>     ++  path="$1" expect="$2" source="$3" git_opts="$4" &&
>
>     -+  git $git_opts check-attr --revision $revision test -- "$path" >actual 2>err &&
>     ++  git $git_opts check-attr --source $source test -- "$path" >actual 2>err &&
>      +  echo "$path: test: $expect" >expect &&
>      +  test_cmp expect actual
>     ++  test_must_be_empty err
>       }
>
>       test_expect_success 'open-quoted pathname' '
>     @@ t/t0003-attributes.sh: test_expect_success 'setup' '
>       '
>
>      +test_expect_success 'setup branches' '
>     -+  (
>     -+          echo "f test=f" &&
>     -+          echo "a/i test=n"
>     -+  ) | git hash-object -w --stdin >id &&
>     -+  git update-index --add --cacheinfo 100644,$(cat id),foo/bar/.gitattributes &&
>     -+  git write-tree >id &&
>     -+  tree_id=$(cat id) &&
>     -+  git commit-tree $tree_id -m "random commit message" >id &&
>     -+  commit_id=$(cat id) &&
>     -+  git update-ref refs/heads/branch1 $commit_id &&
>     ++  mkdir -p foo/bar &&
>     ++  test_commit --printf "add .gitattributes" foo/bar/.gitattribute \
>     ++          "f test=f\na/i test=n\n" tag-1 &&
>      +
>     -+  (
>     -+          echo "g test=g" &&
>     -+          echo "a/i test=m"
>     -+  ) | git hash-object -w --stdin >id &&
>     -+  git update-index --add --cacheinfo 100644,$(cat id),foo/bar/.gitattributes &&
>     -+  git write-tree >id &&
>     -+  tree_id=$(cat id) &&
>     -+  git commit-tree $tree_id -m "random commit message" >id &&
>     -+  commit_id=$(cat id) &&
>     -+  git update-ref refs/heads/branch2 $commit_id
>     ++  mkdir -p foo/bar &&
>     ++  test_commit --printf "add .gitattributes" foo/bar/.gitattribute \
>     ++          "g test=g\na/i test=m\n" tag-2
>      +'
>      +
>       test_expect_success 'command line checks' '
>     @@ t/t0003-attributes.sh: test_expect_success 'setup' '
>         test_must_fail git check-attr test &&
>         test_must_fail git check-attr test -- &&
>         test_must_fail git check-attr -- f &&
>     -+  test_must_fail git check-attr --revision &&
>     -+  test_must_fail git check-attr --revision not-a-valid-ref &&
>     ++  test_must_fail git check-attr --source &&
>     ++  test_must_fail git check-attr --source not-a-valid-ref &&
>         echo "f" | test_must_fail git check-attr --stdin &&
>         echo "f" | test_must_fail git check-attr --stdin -- f &&
>         echo "f" | test_must_fail git check-attr --stdin test -- f &&
>     @@ t/t0003-attributes.sh: test_expect_success 'using --git-dir and --work-tree' '
>         )
>       '
>
>     -+test_expect_success 'using --revision' '
>     -+  attr_check_revision foo/bar/f f branch1 &&
>     -+  attr_check_revision foo/bar/a/i n branch1 &&
>     -+  attr_check_revision foo/bar/f unspecified branch2 &&
>     -+  attr_check_revision foo/bar/a/i m branch2 &&
>     -+  attr_check_revision foo/bar/g g branch2 &&
>     -+  attr_check_revision foo/bar/g unspecified branch1
>     ++test_expect_success 'using --source' '
>     ++  attr_check_source foo/bar/f f tag-1 &&
>     ++  attr_check_source foo/bar/a/i n tag-1 &&
>     ++  attr_check_source foo/bar/f unspecified tag-2 &&
>     ++  attr_check_source foo/bar/a/i m tag-2 &&
>     ++  attr_check_source foo/bar/g g tag-2 &&
>     ++  attr_check_source foo/bar/g unspecified tag-1
>      +'
>      +
>       test_expect_success 'setup bare' '
>     @@ t/t0003-attributes.sh: test_expect_success 'bare repository: check that .gitattr
>         )
>       '
>
>     -+test_expect_success 'bare repository: with --revision' '
>     ++test_expect_success 'bare repository: with --source' '
>      +  (
>      +          cd bare.git &&
>     -+          (
>     -+                  echo "f test=f" &&
>     -+                  echo "a/i test=a/i"
>     -+          ) | git hash-object -w --stdin >id &&
>     -+          git update-index --add --cacheinfo 100644 $(cat id) .gitattributes &&
>     -+          git write-tree >id &&
>     -+          tree_id=$(cat id) &&
>     -+          git commit-tree $tree_id -m "random commit message" >id &&
>     -+          commit_id=$(cat id) &&
>     -+          git update-ref refs/heads/master $commit_id &&
>     -+          attr_check_revision f f HEAD &&
>     -+          attr_check_revision a/f f HEAD &&
>     -+          attr_check_revision a/c/f f HEAD &&
>     -+          attr_check_revision a/i a/i HEAD &&
>     -+          attr_check_revision subdir/a/i unspecified HEAD
>     ++          attr_check_source foo/bar/f f tag-1 &&
>     ++          attr_check_source foo/bar/a/i n tag-1 &&
>     ++          attr_check_source foo/bar/f unspecified tag-2 &&
>     ++          attr_check_source foo/bar/a/i m tag-2 &&
>     ++          attr_check_source foo/bar/g g tag-2 &&
>     ++          attr_check_source foo/bar/g unspecified tag-1
>      +  )
>      +'
>      +
>
>
> Karthik Nayak (2):
>   t0003: move setup for `--all` into new block
>   attr: add flag `--source` to work with tree-ish
>
>  Documentation/git-check-attr.txt | 10 +++-
>  archive.c                        |  2 +-
>  attr.c                           | 97 +++++++++++++++++++++++---------
>  attr.h                           |  5 +-
>  builtin/check-attr.c             | 35 +++++++-----
>  builtin/pack-objects.c           |  2 +-
>  convert.c                        |  2 +-
>  ll-merge.c                       |  4 +-
>  pathspec.c                       |  2 +-
>  t/t0003-attributes.sh            | 49 +++++++++++++++-
>  userdiff.c                       |  2 +-
>  ws.c                             |  2 +-
>  12 files changed, 157 insertions(+), 55 deletions(-)
>
> --
> 2.39.0
>
