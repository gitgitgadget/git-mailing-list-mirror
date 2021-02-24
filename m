Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2ED8C433E0
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 06:51:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9479C64E60
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 06:51:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233660AbhBXGvT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Feb 2021 01:51:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231627AbhBXGvQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Feb 2021 01:51:16 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A719EC061574
        for <git@vger.kernel.org>; Tue, 23 Feb 2021 22:50:36 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id s107so1216838otb.8
        for <git@vger.kernel.org>; Tue, 23 Feb 2021 22:50:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5KlF/7jppHyW2UXXMX+2ETQ/9tcMS3AgNB4eArpGXm0=;
        b=Yi4JGwtR4vvbIN2vgsR/ZtYEPJSr+D7n0zCRhtXCdo0IXdoVtFpaHbeOKhkPNH4Eul
         ihzRztxRz/u0f24bd6YQnd3NfdWoqcjYvZiD5/MILATDKAUZ08jRcjOSnNBs6uDluo10
         zPVDPik3Ped1YqC0/u16lVKtRtNGLjN8XkIChrcq9DqfNgyFflf5zNHTRa1/1A/21DcS
         55blaEGtS4Q6k9R7o8FCjUnArAmnW0Vq1KDc8C5Mr7EugdJf3U46Au8rlnv2yONBm3ia
         uEYiry7VN1bzlnA5Bj/TZsv/cs10wn57KgPWAfAwhJfYpwuFOM9G9uP+iXl7Nb0F563e
         ew7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5KlF/7jppHyW2UXXMX+2ETQ/9tcMS3AgNB4eArpGXm0=;
        b=bpMBxgS6Juw3ehRx6jtNn84KI8C+a4mkF24yKkBif/L4PDat3JT9Kauc6ZzyXALRTW
         iHiIY/FHwXmd0mtwdy4J2N2/RRn6GfKcdBTJrE3uiYLkrJd/nq9nPQo+YfgLinetAyvs
         /PGXenpmU2KN0WFgpWcX3iJbgf55U69BnG/dkqgU0VR/JUrgtQHYJoJYswNaFXoHt6B+
         F9QPFwZHpmo5fra9P+v5btso0FgGI7tiHtVXfX8JE2k22uNTrE3BFcfRSUsgQ5YA2+7f
         bw6fw3QmMScu+qBrIk+jXsXq8bq5LE/mxzwCy4LGAXnm4m/0ngu7md4eCl6Btb1FyJ05
         aJJw==
X-Gm-Message-State: AOAM533LQ7LAk7qY52wk17rq7gkEnpFRns9vcXRfSE5szlGaErmmNSmz
        x4suX7fnBhop/yrEZJpz0sRHDad5WkHgpKgxM+Q=
X-Google-Smtp-Source: ABdhPJzH89othuJrD0GPHDHLNoJSDq99fUllxO+6FSJCN1zzYPxzWkLLtIkFVnCxpESw4WN4Z1kXusQpYD3U7cmX+So=
X-Received: by 2002:a9d:6251:: with SMTP id i17mr14300812otk.162.1614149435663;
 Tue, 23 Feb 2021 22:50:35 -0800 (PST)
MIME-Version: 1.0
References: <cover.1614138107.git.matheus.bernardino@usp.br> <24e889ca9b1cb0823d1663a60ce1e0ba9e55f875.1614138107.git.matheus.bernardino@usp.br>
In-Reply-To: <24e889ca9b1cb0823d1663a60ce1e0ba9e55f875.1614138107.git.matheus.bernardino@usp.br>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 23 Feb 2021 22:50:24 -0800
Message-ID: <CABPp-BEpnaR1tydJ-vcWAUYnT-TFcfCMMqwbmOz1Dx+nvsHZMQ@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] add: warn when pathspec only matches SKIP_WORKTREE entries
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 23, 2021 at 8:05 PM Matheus Tavares
<matheus.bernardino@usp.br> wrote:
>
> `git add` already refrains from updating SKIP_WORKTREE entries, but it
> silently exits with zero code when a pathspec only matches these
> entries. Instead, let's warn the user and display a hint on how to
> update these entries.
>
> Note that the warning is only shown if the pathspec matches no untracked
> paths in the working tree and only matches index entries with the
> SKIP_WORKTREE bit set. A warning message was chosen over erroring out
> right away to reproduce the same behavior `add` already exhibits with
> ignored files. This also allow users to continue their workflow without
> having to invoke `add` again with only the matching pathspecs, as the
> matched files will have already been added.
>
> Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
> ---
>  Documentation/config/advice.txt |  3 ++
>  advice.c                        | 19 +++++++++
>  advice.h                        |  4 ++
>  builtin/add.c                   | 70 ++++++++++++++++++++++++-------
>  pathspec.c                      | 15 +++++++
>  pathspec.h                      |  8 ++++
>  t/t3705-add-sparse-checkout.sh  | 73 +++++++++++++++++++++++++++++----
>  7 files changed, 171 insertions(+), 21 deletions(-)
>
> diff --git a/Documentation/config/advice.txt b/Documentation/config/advice.txt
> index acbd0c09aa..d53eafa00b 100644
> --- a/Documentation/config/advice.txt
> +++ b/Documentation/config/advice.txt
> @@ -119,4 +119,7 @@ advice.*::
>         addEmptyPathspec::
>                 Advice shown if a user runs the add command without providing
>                 the pathspec parameter.
> +       updateSparsePath::
> +               Advice shown if the pathspec given to linkgit:git-add[1] only
> +               matches index entries outside the current sparse-checkout.
>  --
> diff --git a/advice.c b/advice.c
> index 164742305f..cf22c1a6e5 100644
> --- a/advice.c
> +++ b/advice.c
> @@ -2,6 +2,7 @@
>  #include "config.h"
>  #include "color.h"
>  #include "help.h"
> +#include "string-list.h"
>
>  int advice_fetch_show_forced_updates = 1;
>  int advice_push_update_rejected = 1;
> @@ -136,6 +137,7 @@ static struct {
>         [ADVICE_STATUS_HINTS]                           = { "statusHints", 1 },
>         [ADVICE_STATUS_U_OPTION]                        = { "statusUoption", 1 },
>         [ADVICE_SUBMODULE_ALTERNATE_ERROR_STRATEGY_DIE] = { "submoduleAlternateErrorStrategyDie", 1 },
> +       [ADVICE_UPDATE_SPARSE_PATH]                     = { "updateSparsePath", 1 },
>         [ADVICE_WAITING_FOR_EDITOR]                     = { "waitingForEditor", 1 },
>  };
>
> @@ -284,6 +286,23 @@ void NORETURN die_conclude_merge(void)
>         die(_("Exiting because of unfinished merge."));
>  }
>
> +void advise_on_updating_sparse_paths(struct string_list *pathspec_list)
> +{
> +       struct string_list_item *item;
> +
> +       if (!pathspec_list->nr)
> +               return;
> +
> +       fprintf(stderr, _("The following pathspecs only matched index entries outside the current\n"
> +                         "sparse checkout:\n"));
> +       for_each_string_list_item(item, pathspec_list)
> +               fprintf(stderr, "%s\n", item->string);

Was the use of fprintf(stderr, ...) because of the fact that you want
to do multiple print statements?  I'm just curious if that was the
reason for avoiding the warning() function, or if there was another
consideration at play as well.

> +
> +       advise_if_enabled(ADVICE_UPDATE_SPARSE_PATH,
> +                         _("Disable or modify the sparsity rules if you intend to update such entries."));
> +
> +}
> +
>  void detach_advice(const char *new_name)
>  {
>         const char *fmt =
> diff --git a/advice.h b/advice.h
> index bc2432980a..bd26c385d0 100644
> --- a/advice.h
> +++ b/advice.h
> @@ -3,6 +3,8 @@
>
>  #include "git-compat-util.h"
>
> +struct string_list;
> +
>  extern int advice_fetch_show_forced_updates;
>  extern int advice_push_update_rejected;
>  extern int advice_push_non_ff_current;
> @@ -71,6 +73,7 @@ extern int advice_add_empty_pathspec;
>         ADVICE_STATUS_HINTS,
>         ADVICE_STATUS_U_OPTION,
>         ADVICE_SUBMODULE_ALTERNATE_ERROR_STRATEGY_DIE,
> +       ADVICE_UPDATE_SPARSE_PATH,
>         ADVICE_WAITING_FOR_EDITOR,
>  };
>
> @@ -92,6 +95,7 @@ void advise_if_enabled(enum advice_type type, const char *advice, ...);
>  int error_resolve_conflict(const char *me);
>  void NORETURN die_resolve_conflict(const char *me);
>  void NORETURN die_conclude_merge(void);
> +void advise_on_updating_sparse_paths(struct string_list *pathspec_list);
>  void detach_advice(const char *new_name);
>
>  #endif /* ADVICE_H */
> diff --git a/builtin/add.c b/builtin/add.c
> index e15b25a623..fde6462850 100644
> --- a/builtin/add.c
> +++ b/builtin/add.c
> @@ -177,24 +177,43 @@ static char *prune_directory(struct dir_struct *dir, struct pathspec *pathspec,
>                         *dst++ = entry;
>         }
>         dir->nr = dst - dir->entries;
> -       add_pathspec_matches_against_index(pathspec, &the_index, seen, 0);
> +       add_pathspec_matches_against_index(pathspec, &the_index, seen, 1);

_If_ you add the enum as mentioned earlier, this 1 would become
whatever the other enum value was.  I'll omit making similar comments
for other call sites like this one, though there are a few more in the
patch.

>         return seen;
>  }
>
> -static void refresh(int verbose, const struct pathspec *pathspec)
> +static int refresh(int verbose, const struct pathspec *pathspec)
>  {
>         char *seen;
> -       int i;
> +       int i, ret = 0;
> +       char *skip_worktree_seen = NULL;
> +       struct string_list only_match_skip_worktree = STRING_LIST_INIT_NODUP;
> +       int flags = REFRESH_DONT_MARK_SPARSE_MATCHES |
> +                   (verbose ? REFRESH_IN_PORCELAIN : REFRESH_QUIET);
>
>         seen = xcalloc(pathspec->nr, 1);
> -       refresh_index(&the_index, verbose ? REFRESH_IN_PORCELAIN : REFRESH_QUIET,
> -                     pathspec, seen, _("Unstaged changes after refreshing the index:"));
> +       refresh_index(&the_index, flags, pathspec, seen,
> +                     _("Unstaged changes after refreshing the index:"));
>         for (i = 0; i < pathspec->nr; i++) {
> -               if (!seen[i])
> -                       die(_("pathspec '%s' did not match any files"),
> -                           pathspec->items[i].original);
> +               if (!seen[i]) {
> +                       if (matches_skip_worktree(pathspec, i, &skip_worktree_seen)) {
> +                               string_list_append(&only_match_skip_worktree,
> +                                                  pathspec->items[i].original);
> +                       } else {
> +                               die(_("pathspec '%s' did not match any files"),
> +                                   pathspec->items[i].original);
> +                       }
> +               }
> +       }
> +
> +       if (only_match_skip_worktree.nr) {
> +               advise_on_updating_sparse_paths(&only_match_skip_worktree);
> +               ret = 1;
>         }

On first reading, I missed that the code die()s if there are any
non-SKIP_WORKTREE entries matched, and that is the reason you know
that only SKIP_WORKTREE entries could have been matched for this last
if-statement.  Perhaps a short comment for the reader like me who is
prone to miss the obvious?

> +
>         free(seen);
> +       free(skip_worktree_seen);
> +       string_list_clear(&only_match_skip_worktree, 0);
> +       return ret;
>  }
>
>  int run_add_interactive(const char *revision, const char *patch_mode,
> @@ -570,15 +589,17 @@ int cmd_add(int argc, const char **argv, const char *prefix)
>         }
>
>         if (refresh_only) {
> -               refresh(verbose, &pathspec);
> +               exit_status |= refresh(verbose, &pathspec);
>                 goto finish;
>         }
>
>         if (pathspec.nr) {
>                 int i;
> +               char *skip_worktree_seen = NULL;
> +               struct string_list only_match_skip_worktree = STRING_LIST_INIT_NODUP;
>
>                 if (!seen)
> -                       seen = find_pathspecs_matching_against_index(&pathspec, &the_index, 0);
> +                       seen = find_pathspecs_matching_against_index(&pathspec, &the_index, 1);
>
>                 /*
>                  * file_exists() assumes exact match
> @@ -592,12 +613,24 @@ int cmd_add(int argc, const char **argv, const char *prefix)
>
>                 for (i = 0; i < pathspec.nr; i++) {
>                         const char *path = pathspec.items[i].match;
> +
>                         if (pathspec.items[i].magic & PATHSPEC_EXCLUDE)
>                                 continue;
> -                       if (!seen[i] && path[0] &&
> -                           ((pathspec.items[i].magic &
> -                             (PATHSPEC_GLOB | PATHSPEC_ICASE)) ||
> -                            !file_exists(path))) {
> +                       if (seen[i])
> +                               continue;
> +
> +                       if (matches_skip_worktree(&pathspec, i, &skip_worktree_seen)) {
> +                               string_list_append(&only_match_skip_worktree,
> +                                                  pathspec.items[i].original);
> +                               continue;
> +                       }
> +
> +                       /* Don't complain at 'git add .' inside empty repo. */
> +                       if (!path[0])
> +                               continue;
> +
> +                       if ((pathspec.items[i].magic & (PATHSPEC_GLOB | PATHSPEC_ICASE)) ||
> +                           !file_exists(path)) {

Breaking up that if-statement into several with some continues seems
to make it a lot easier for me to read; thanks.  It also makes it
easier to add your new condition.

>                                 if (ignore_missing) {
>                                         int dtype = DT_UNKNOWN;
>                                         if (is_excluded(&dir, &the_index, path, &dtype))
> @@ -608,7 +641,16 @@ int cmd_add(int argc, const char **argv, const char *prefix)
>                                             pathspec.items[i].original);
>                         }
>                 }
> +
> +
> +               if (only_match_skip_worktree.nr) {
> +                       advise_on_updating_sparse_paths(&only_match_skip_worktree);
> +                       exit_status = 1;
> +               }

Hmm...here's an interesting command sequence:

git init lame
cd lame
mkdir baz
touch baz/tracked
git add baz/tracked
git update-index --skip-worktree baz/tracked
rm baz/tracked.  # But leave the empty directory!
echo baz >.gitignore
git add --ignore-missing --dry-run baz


Reports the following:
"""
The following pathspecs only matched index entries outside the current
sparse checkout:
baz
hint: Disable or modify the sparsity rules if you intend to update such entries.
hint: Disable this message with "git config advice.updateSparsePath false"
The following paths are ignored by one of your .gitignore files:
baz
hint: Use -f if you really want to add them.
hint: Turn this message off by running
hint: "git config advice.addIgnoredFile false"
"""

That's probably okay because it does match both, but the "only
matched" in the first message followed by saying it matched something
else seems a little surprising at first.  It's not wrong, just
slightly surprising.  But then again, this setup is super weird...so
maybe it's all okay?

> +
>                 free(seen);
> +               free(skip_worktree_seen);
> +               string_list_clear(&only_match_skip_worktree, 0);
>         }
>
>         plug_bulk_checkin();
> diff --git a/pathspec.c b/pathspec.c
> index e5e6b7458d..61f294fed5 100644
> --- a/pathspec.c
> +++ b/pathspec.c
> @@ -62,6 +62,21 @@ char *find_pathspecs_matching_against_index(const struct pathspec *pathspec,
>         return seen;
>  }
>
> +char *find_pathspecs_matching_skip_worktree(const struct pathspec *pathspec)
> +{
> +       struct index_state *istate = the_repository->index;
> +       char *seen = xcalloc(pathspec->nr, 1);
> +       int i;
> +
> +       for (i = 0; i < istate->cache_nr; i++) {
> +               struct cache_entry *ce = istate->cache[i];
> +               if (ce_skip_worktree(ce))
> +                   ce_path_match(istate, ce, pathspec, seen);
> +       }
> +
> +       return seen;
> +}
> +
>  /*
>   * Magic pathspec
>   *
> diff --git a/pathspec.h b/pathspec.h
> index 8202882ecd..f591ba625c 100644
> --- a/pathspec.h
> +++ b/pathspec.h
> @@ -155,6 +155,14 @@ void add_pathspec_matches_against_index(const struct pathspec *pathspec,
>  char *find_pathspecs_matching_against_index(const struct pathspec *pathspec,
>                                             const struct index_state *istate,
>                                             int ignore_skip_worktree);
> +char *find_pathspecs_matching_skip_worktree(const struct pathspec *pathspec);
> +static inline int matches_skip_worktree(const struct pathspec *pathspec,
> +                                       int item, char **seen_ptr)
> +{
> +       if (!*seen_ptr)
> +               *seen_ptr = find_pathspecs_matching_skip_worktree(pathspec);
> +       return (*seen_ptr)[item];
> +}
>  int match_pathspec_attrs(const struct index_state *istate,
>                          const char *name, int namelen,
>                          const struct pathspec_item *item);
> diff --git a/t/t3705-add-sparse-checkout.sh b/t/t3705-add-sparse-checkout.sh
> index 6781620297..fdfd8b085e 100755
> --- a/t/t3705-add-sparse-checkout.sh
> +++ b/t/t3705-add-sparse-checkout.sh
> @@ -36,10 +36,26 @@ setup_gitignore () {
>         EOF
>  }
>
> +test_expect_success 'setup' '
> +       cat >sparse_error_header <<-EOF &&
> +       The following pathspecs only matched index entries outside the current
> +       sparse checkout:
> +       EOF
> +
> +       cat >sparse_hint <<-EOF &&
> +       hint: Disable or modify the sparsity rules if you intend to update such entries.
> +       hint: Disable this message with "git config advice.updateSparsePath false"
> +       EOF
> +
> +       echo sparse_entry | cat sparse_error_header - >sparse_entry_error &&
> +       cat sparse_entry_error sparse_hint >error_and_hint
> +'
> +
>  test_expect_success 'git add does not remove sparse entries' '
>         setup_sparse_entry &&
>         rm sparse_entry &&
> -       git add sparse_entry &&
> +       test_must_fail git add sparse_entry 2>stderr &&
> +       test_i18ncmp error_and_hint stderr &&
>         test_sparse_entry_unchanged
>  '
>
> @@ -47,7 +63,8 @@ test_expect_success 'git add -A does not remove sparse entries' '
>         setup_sparse_entry &&
>         rm sparse_entry &&
>         setup_gitignore &&
> -       git add -A &&
> +       git add -A 2>stderr &&
> +       test_must_be_empty stderr &&
>         test_sparse_entry_unchanged
>  '
>
> @@ -55,7 +72,13 @@ test_expect_success 'git add . does not remove sparse entries' '
>         setup_sparse_entry &&
>         rm sparse_entry &&
>         setup_gitignore &&
> -       git add . &&
> +       test_must_fail git add . 2>stderr &&
> +
> +       cat sparse_error_header >expect &&
> +       echo . >>expect &&
> +       cat sparse_hint >>expect &&
> +
> +       test_i18ncmp expect stderr &&
>         test_sparse_entry_unchanged
>  '
>
> @@ -64,7 +87,8 @@ do
>         test_expect_success "git add${opt:+ $opt} does not update sparse entries" '
>                 setup_sparse_entry &&
>                 echo modified >sparse_entry &&
> -               git add $opt sparse_entry &&
> +               test_must_fail git add $opt sparse_entry 2>stderr &&
> +               test_i18ncmp error_and_hint stderr &&
>                 test_sparse_entry_unchanged
>         '
>  done
> @@ -73,14 +97,16 @@ test_expect_success 'git add --refresh does not update sparse entries' '
>         setup_sparse_entry &&
>         git ls-files --debug sparse_entry | grep mtime >before &&
>         test-tool chmtime -60 sparse_entry &&
> -       git add --refresh sparse_entry &&
> +       test_must_fail git add --refresh sparse_entry 2>stderr &&
> +       test_i18ncmp error_and_hint stderr &&
>         git ls-files --debug sparse_entry | grep mtime >after &&
>         test_cmp before after
>  '
>
>  test_expect_success 'git add --chmod does not update sparse entries' '
>         setup_sparse_entry &&
> -       git add --chmod=+x sparse_entry &&
> +       test_must_fail git add --chmod=+x sparse_entry 2>stderr &&
> +       test_i18ncmp error_and_hint stderr &&
>         test_sparse_entry_unchanged &&
>         ! test -x sparse_entry
>  '
> @@ -89,8 +115,41 @@ test_expect_success 'git add --renormalize does not update sparse entries' '
>         test_config core.autocrlf false &&
>         setup_sparse_entry "LINEONE\r\nLINETWO\r\n" &&
>         echo "sparse_entry text=auto" >.gitattributes &&
> -       git add --renormalize sparse_entry &&
> +       test_must_fail git add --renormalize sparse_entry 2>stderr &&
> +       test_i18ncmp error_and_hint stderr &&
>         test_sparse_entry_unchanged
>  '
>
> +test_expect_success 'git add --dry-run --ignore-missing warn on sparse path' '
> +       setup_sparse_entry &&
> +       rm sparse_entry &&
> +       test_must_fail git add --dry-run --ignore-missing sparse_entry 2>stderr &&
> +       test_i18ncmp error_and_hint stderr &&
> +       test_sparse_entry_unchanged

See also the slightly convoluted setup I responded above with.  I'm
not sure if we need to make it a test, in part because it's crazy
enough that I'm not quite convinced that the current behavior is right
-- or wrong.

> +'
> +
> +test_expect_success 'do not advice about sparse entries when they do not match the pathspec' '
> +       setup_sparse_entry &&
> +       test_must_fail git add nonexistent 2>stderr &&
> +       test_i18ngrep "fatal: pathspec .nonexistent. did not match any files" stderr &&
> +       test_i18ngrep ! "The following pathspecs only matched index entries" stderr
> +'
> +
> +test_expect_success 'do not warn when pathspec matches dense entries' '
> +       setup_sparse_entry &&
> +       echo modified >sparse_entry &&
> +       >dense_entry &&
> +       git add "*_entry" 2>stderr &&
> +       test_must_be_empty stderr &&
> +       test_sparse_entry_unchanged &&
> +       git ls-files --error-unmatch dense_entry
> +'
> +
> +test_expect_success 'add obeys advice.updateSparsePath' '
> +       setup_sparse_entry &&
> +       test_must_fail git -c advice.updateSparsePath=false add sparse_entry 2>stderr &&
> +       test_i18ncmp sparse_entry_error stderr
> +
> +'
> +
>  test_done
> --
> 2.30.1

Overall, a nice read.  Didn't spot any other issues, just the minor
points I highlighted above.  I'm curious if others have thoughts on my
really weird setup and the dual warnings, though.
