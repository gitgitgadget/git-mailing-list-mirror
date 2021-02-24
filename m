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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 391ECC433DB
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 07:00:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7C7364E6F
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 07:00:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234305AbhBXHAi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Feb 2021 02:00:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234275AbhBXHAh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Feb 2021 02:00:37 -0500
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4EDEC061574
        for <git@vger.kernel.org>; Tue, 23 Feb 2021 22:59:56 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id r19so1271986otk.2
        for <git@vger.kernel.org>; Tue, 23 Feb 2021 22:59:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vzmUwp8LyI9MkCUZPZiNK1TK0zEgm+/3uq1JGc+I/kQ=;
        b=Hy8sYqd6XuSz0qQ07Rk54mMkxRgnuEe+V9LIB1+dyBILQVuf+2ZOLAiiDu9QP4Ts2i
         kCAcYrvCB7RPeoaf+ZtBXaHsqb15OXP7fRpXBmkyX27ApF859oAEx3V3lhAFCO78VP3F
         rA8rA6nX9vKPc+9uP6SdbfhCOddyoqYur+yM5tp8zJItxNsavGQYx3kojAHZTfCANr+y
         +izpr2dk48xBjwUYHTB7wgCTK7O9FxHALS4zzQklgoVvdTO/dwHmb7ps1A5C9D3QMe0N
         DG4QpuF0SI+fXoYzp6h0u94EcSBTPZjKzlBkfdkEYs0maNV4W+8/p55zEg28E6q3TbkP
         G6Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vzmUwp8LyI9MkCUZPZiNK1TK0zEgm+/3uq1JGc+I/kQ=;
        b=VL8GPe4El/cQb565WWGnAFcdzK2EyGtfYrGKShfLqf8geDZgIC+w/2wq6B8OcuTRgD
         zXHbH5iAy2FZ1wsZBNmmBJi4aj8v83xvfQAWgCPJ4Rjj1flZWeYOWBi98wVVb96bpl+i
         0ieLbU9hiRUfLgvMJsZNS5RE/GLqZxqikgLF8XyRS2Mjf+PE1qRKNEO4Jy/bj99ZDweb
         t9z9WNYG4TVOBGKw55yuQsPnyy2aJ0cQ3pCZDnnaQDxHsB3v7fBZ6XcjteB1zCKpW+nJ
         bkSY+9rWa5r/1AgpD5MGqan1UDXYOWMjhw8WipwGOpSHIiuW3h3fFxsbcJRHAjnKhBt2
         QZjw==
X-Gm-Message-State: AOAM530k+OXwnL087JLD8/bJKurJF1uB2RFq3l1PSGjbla8zN8kFB874
        o1XO8pGxe2DVssnzbU2s5TUohqBP0MpV+3Nv+MY=
X-Google-Smtp-Source: ABdhPJyQOt8rojfEvdOeVYW9uSh5HroBw/IRsK3i8rFQs4++HePuzKiaUmruLnrY6dTgAnNhmlC9jTrOGprHFLX5UBo=
X-Received: by 2002:a05:6830:100c:: with SMTP id a12mr8225922otp.345.1614149995778;
 Tue, 23 Feb 2021 22:59:55 -0800 (PST)
MIME-Version: 1.0
References: <cover.1614138107.git.matheus.bernardino@usp.br> <08f0c32bfcbd04891afd3ca7133484b0ed6c7257.1614138107.git.matheus.bernardino@usp.br>
In-Reply-To: <08f0c32bfcbd04891afd3ca7133484b0ed6c7257.1614138107.git.matheus.bernardino@usp.br>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 23 Feb 2021 22:59:44 -0800
Message-ID: <CABPp-BFHsT02opYhoQSun+SYE1sDVdAqYipaMQonFAtw9ZkW-A@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] rm: honor sparse checkout patterns
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
> `git add` refrains from adding or updating paths outside the sparsity
> rules, but `git rm` doesn't follow the same restrictions. This is
> somewhat counter-intuitive and inconsistent. So make `rm` honor the
> sparse checkout and advise on how to remove SKIP_WORKTREE entries, just
> like `add` does. Also add some tests for the new behavior.
>
> Suggested-by: Elijah Newren <newren@gmail.com>
> Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
> ---
>  Documentation/config/advice.txt  |  5 ++-
>  Documentation/git-rm.txt         |  4 +-
>  builtin/rm.c                     | 35 ++++++++++-----
>  t/t3602-rm-sparse-checkout.sh    | 76 ++++++++++++++++++++++++++++++++
>  t/t7011-skip-worktree-reading.sh |  5 ---
>  5 files changed, 106 insertions(+), 19 deletions(-)
>  create mode 100755 t/t3602-rm-sparse-checkout.sh
>
> diff --git a/Documentation/config/advice.txt b/Documentation/config/advice.txt
> index d53eafa00b..bdd423ade4 100644
> --- a/Documentation/config/advice.txt
> +++ b/Documentation/config/advice.txt
> @@ -120,6 +120,7 @@ advice.*::
>                 Advice shown if a user runs the add command without providing
>                 the pathspec parameter.
>         updateSparsePath::
> -               Advice shown if the pathspec given to linkgit:git-add[1] only
> -               matches index entries outside the current sparse-checkout.
> +               Advice shown if the pathspec given to linkgit:git-add[1] or
> +               linkgit:git-rm[1] only matches index entries outside the
> +               current sparse-checkout.
>  --
> diff --git a/Documentation/git-rm.txt b/Documentation/git-rm.txt
> index ab750367fd..26e9b28470 100644
> --- a/Documentation/git-rm.txt
> +++ b/Documentation/git-rm.txt
> @@ -23,7 +23,9 @@ branch, and no updates to their contents can be staged in the index,
>  though that default behavior can be overridden with the `-f` option.
>  When `--cached` is given, the staged content has to
>  match either the tip of the branch or the file on disk,
> -allowing the file to be removed from just the index.
> +allowing the file to be removed from just the index. When
> +sparse-checkouts are in use (see linkgit:git-sparse-checkout[1]),
> +`git rm` will only remove paths within the sparse-checkout patterns.
>
>
>  OPTIONS
> diff --git a/builtin/rm.c b/builtin/rm.c
> index 4858631e0f..d23a3b2164 100644
> --- a/builtin/rm.c
> +++ b/builtin/rm.c
> @@ -5,6 +5,7 @@
>   */
>  #define USE_THE_INDEX_COMPATIBILITY_MACROS
>  #include "builtin.h"
> +#include "advice.h"
>  #include "config.h"
>  #include "lockfile.h"
>  #include "dir.h"
> @@ -254,7 +255,7 @@ static struct option builtin_rm_options[] = {
>  int cmd_rm(int argc, const char **argv, const char *prefix)
>  {
>         struct lock_file lock_file = LOCK_INIT;
> -       int i;
> +       int i, ret = 0;
>         struct pathspec pathspec;
>         char *seen;
>
> @@ -295,6 +296,8 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
>
>         for (i = 0; i < active_nr; i++) {
>                 const struct cache_entry *ce = active_cache[i];
> +               if (ce_skip_worktree(ce))
> +                       continue;
>                 if (!ce_path_match(&the_index, ce, &pathspec, seen))
>                         continue;
>                 ALLOC_GROW(list.entry, list.nr + 1, list.alloc);
> @@ -308,24 +311,34 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
>         if (pathspec.nr) {
>                 const char *original;
>                 int seen_any = 0;
> +               char *skip_worktree_seen = NULL;
> +               struct string_list only_match_skip_worktree = STRING_LIST_INIT_NODUP;
> +
>                 for (i = 0; i < pathspec.nr; i++) {
>                         original = pathspec.items[i].original;
> -                       if (!seen[i]) {
> -                               if (!ignore_unmatch) {
> -                                       die(_("pathspec '%s' did not match any files"),
> -                                           original);
> -                               }
> -                       }
> -                       else {
> +                       if (seen[i])
>                                 seen_any = 1;
> -                       }
> +                       else if (ignore_unmatch)
> +                               continue;
> +                       else if (matches_skip_worktree(&pathspec, i, &skip_worktree_seen))
> +                               string_list_append(&only_match_skip_worktree, original);
> +                       else
> +                               die(_("pathspec '%s' did not match any files"), original);
> +
>                         if (!recursive && seen[i] == MATCHED_RECURSIVELY)
>                                 die(_("not removing '%s' recursively without -r"),
>                                     *original ? original : ".");
>                 }
>
> +               if (only_match_skip_worktree.nr) {
> +                       advise_on_updating_sparse_paths(&only_match_skip_worktree);
> +                       ret = 1;
> +               }
> +               free(skip_worktree_seen);
> +               string_list_clear(&only_match_skip_worktree, 0);
> +
>                 if (!seen_any)
> -                       exit(0);
> +                       exit(ret);
>         }
>
>         if (!index_only)
> @@ -405,5 +418,5 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
>                                COMMIT_LOCK | SKIP_IF_UNCHANGED))
>                 die(_("Unable to write new index file"));
>
> -       return 0;
> +       return ret;
>  }
> diff --git a/t/t3602-rm-sparse-checkout.sh b/t/t3602-rm-sparse-checkout.sh
> new file mode 100755
> index 0000000000..34f4debacf
> --- /dev/null
> +++ b/t/t3602-rm-sparse-checkout.sh
> @@ -0,0 +1,76 @@
> +#!/bin/sh
> +
> +test_description='git rm in sparse checked out working trees'
> +
> +. ./test-lib.sh
> +
> +test_expect_success 'setup' '
> +       mkdir -p sub/dir &&
> +       touch a b c sub/d sub/dir/e &&
> +       git add -A &&
> +       git commit -m files &&
> +
> +       cat >sparse_entry_b_error <<-EOF &&
> +       The following pathspecs only matched index entries outside the current
> +       sparse checkout:
> +       b
> +       EOF
> +
> +       cat >b_error_and_hint sparse_entry_b_error - <<-EOF
> +       hint: Disable or modify the sparsity rules if you intend to update such entries.
> +       hint: Disable this message with "git config advice.updateSparsePath false"
> +       EOF
> +'
> +
> +for opt in "" -f --dry-run
> +do
> +       test_expect_success "rm${opt:+ $opt} does not remove sparse entries" '
> +               git sparse-checkout set a &&
> +               test_must_fail git rm $opt b 2>stderr &&
> +               test_i18ncmp b_error_and_hint stderr &&
> +               git ls-files --error-unmatch b
> +       '
> +done
> +
> +test_expect_success 'recursive rm does not remove sparse entries' '
> +       git reset --hard &&
> +       git sparse-checkout set sub/dir &&
> +       git rm -r sub &&
> +       git status --porcelain -uno >actual &&
> +       echo "D  sub/dir/e" >expected &&
> +       test_cmp expected actual
> +'
> +
> +test_expect_success 'rm obeys advice.updateSparsePath' '
> +       git reset --hard &&
> +       git sparse-checkout set a &&
> +       test_must_fail git -c advice.updateSparsePath=false rm b 2>stderr &&
> +       test_i18ncmp sparse_entry_b_error stderr
> +'
> +
> +test_expect_success 'do not advice about sparse entries when they do not match the pathspec' '
> +       git reset --hard &&
> +       git sparse-checkout set a &&
> +       test_must_fail git rm nonexistent 2>stderr &&
> +       test_i18ngrep "fatal: pathspec .nonexistent. did not match any files" stderr &&
> +       test_i18ngrep ! "The following pathspecs only matched index entries" stderr
> +'
> +
> +test_expect_success 'do not warn about sparse entries when pathspec matches dense entries' '
> +       git reset --hard &&
> +       git sparse-checkout set a &&
> +       git rm "[ba]" 2>stderr &&
> +       test_must_be_empty stderr &&
> +       git ls-files --error-unmatch b &&
> +       test_must_fail git ls-files --error-unmatch a
> +'
> +
> +test_expect_success 'do not warn about sparse entries with --ignore-unmatch' '
> +       git reset --hard &&
> +       git sparse-checkout set a &&
> +       git rm --ignore-unmatch b 2>stderr &&
> +       test_must_be_empty stderr &&
> +       git ls-files --error-unmatch b
> +'
> +
> +test_done
> diff --git a/t/t7011-skip-worktree-reading.sh b/t/t7011-skip-worktree-reading.sh
> index 37525cae3a..f87749951f 100755
> --- a/t/t7011-skip-worktree-reading.sh
> +++ b/t/t7011-skip-worktree-reading.sh
> @@ -141,11 +141,6 @@ test_expect_success 'diff-files does not examine skip-worktree dirty entries' '
>         test -z "$(git diff-files -- one)"
>  '
>
> -test_expect_success 'git-rm succeeds on skip-worktree absent entries' '
> -       setup_absent &&
> -       git rm 1
> -'
> -
>  test_expect_success 'commit on skip-worktree absent entries' '
>         git reset &&
>         setup_absent &&
> --
> 2.30.1

I already reviewed the source code previously a few times now; it
still looks good to me, and you didn't change it from the last
version.  You've added new tests and tweaked them a bit, but all those
changes look good to me.
