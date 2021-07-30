Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9D63C4338F
	for <git@archiver.kernel.org>; Fri, 30 Jul 2021 13:52:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A755B60EFF
	for <git@archiver.kernel.org>; Fri, 30 Jul 2021 13:52:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238992AbhG3Nwg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Jul 2021 09:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231137AbhG3Nwg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jul 2021 09:52:36 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73BBBC06175F
        for <git@vger.kernel.org>; Fri, 30 Jul 2021 06:52:31 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id 68-20020a9d0f4a0000b02904b1f1d7c5f4so9551294ott.9
        for <git@vger.kernel.org>; Fri, 30 Jul 2021 06:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Hw8p99Wbp6WolXtOQsBChfm4Uu+SAHyCuuwQHWRrnsA=;
        b=HW3YRehLh1YKUmxR0P6W1DOEmQZIPo+4Q5wX/iH8ehaCqbP1bPm8tk48JK8vxhRV0z
         XH+pPDMgBu6Z9nfFkg2CWDu/K3v5yMQA20Pb/0vVZ988h9R52CoNzhVBu0dTO7BXAAh5
         3xNOlVEeCVls73c0UArTuVh3jf7ft/0sIb5YMaJ7rcXXyCYFy+WaFYLS6WfdrzgEndxn
         fpbjezrTWqtj3PfCXjz/qJvvhN11cmrWYs/wMB37y/n3+3WnCpCL3mm0HzsiQqiKVW7+
         EdyJOJlkEiYWRdDpji36LQ5mOvSM+DR17/WWmBybJK/J1fF4WtTeDMVXsUObanMFmbyB
         pleA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hw8p99Wbp6WolXtOQsBChfm4Uu+SAHyCuuwQHWRrnsA=;
        b=IC32MJxqvPGrIe5hFa0nXvkdqqqNIg0U7UBuB0+bxHhYNp91jghWZHPfaGtdCfnsYh
         iiJEDNkG59x81tAD/5QVWRfKCUGnDHU7OcJVs9HA99j4GbJ533movwawox9fr/fKvKDv
         uQ7rXwWE4+lf22SVSCbcNusDR8ZC5dvX2J7QGWsWMS7KWJ/gMUgr46rJStEDVjjxF98o
         IYBUIudmOrZbOUnWXlcrN3ykYZ3Jb3PIiZwQEYoJPT6hwLZ6E8RdXj/UOy/RI77TrX3x
         jW59uosj6PSN6FU0sIvxeq8jjZQHVMQdUz0eQFY6oirASqWjnM/ccJ2daqKpEXD8/kgV
         yOjw==
X-Gm-Message-State: AOAM532r2dDgTPYIwaxl/saAdvixrY4s2K2cx/q+hWVUlD+9co6LVAfD
        TznpVvgMv0/1aIn4owwy34fojdwwEolVl4AFIio=
X-Google-Smtp-Source: ABdhPJxV4Xg6kVI7oMHCC9/bLPiM1bCYZNRyA7ocjUGXA1N2Ds61N6AcQ01Y7mtkh4z4jE1xkZrt14Kk+bFQGGckn5A=
X-Received: by 2002:a05:6830:78c:: with SMTP id w12mr2039970ots.162.1627653150825;
 Fri, 30 Jul 2021 06:52:30 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1009.git.1627579637.gitgitgadget@gmail.com> <9212bbf4e3cab20fe49ab8e6dd4ac0277c4f2805.1627579637.git.gitgitgadget@gmail.com>
In-Reply-To: <9212bbf4e3cab20fe49ab8e6dd4ac0277c4f2805.1627579637.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 30 Jul 2021 07:52:19 -0600
Message-ID: <CABPp-BGbRbyCYYS+NcYrC-T4hJf7BCoLE2HsXFM4K51A0wSgcg@mail.gmail.com>
Subject: Re: [PATCH 2/2] sparse-checkout: clear tracked sparse dirs
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 29, 2021 at 11:27 AM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Derrick Stolee <dstolee@microsoft.com>
>
> When changing the scope of a sparse-checkout using cone mode, we might
> have some tracked directories go out of scope. The current logic removes
> the tracked files from within those directories, but leaves the ignored
> files within those directories. This is a bit unexpected to users who
> have given input to Git saying they don't need those directories
> anymore.
>
> This is something that is new to the cone mode pattern type: the user
> has explicitly said "I want these directories and _not_ those
> directories." The typical sparse-checkout patterns more generally apply
> to "I want files with with these patterns" so it is natural to leave
> ignored files as they are. This focus on directories in cone mode
> provides us an opportunity to change the behavior.
>
> Leaving these ignored files in the sparse directories makes it
> impossible to gain performance benefits in the sparse index. When we
> track into these directories, we need to know if the files are ignored
> or not, which might depend on the _tracked_ .gitignore file(s) within
> the sparse directory. This depends on the indexed version of the file,
> so the sparse directory must be expanded.

Is this the issue I highlighted at
https://lore.kernel.org/git/CABPp-BHsiLTtv6AuycRrQ5K6q0=ZTJe0kd7uTUL+UT=nxj66zA@mail.gmail.com/,
the paragraph "...I thought the point of add_patterns()..." or is
there more or other things involved here?

> By deleting the sparse directories when changing scope (or running 'git
> sparse-checkout reapply') we regain these performance benefits as if the
> repository was in a clean state.

:-)

However, note that our repository is probably ~25x smaller than yours
in terms of number of files, and 'git status' performance really isn't
that big of an issue for us.  Users complained to us about these
directories sticking around simply because they were confused by the
directories remaining.  (Did sparsify not work?  What's all that
leftover stuff?  Why do they have to deal with it?  etc.)

> Since these ignored files are frequently build output or helper files
> from IDEs, the users should not need the files now that the tracked
> files are removed. If the tracked files reappear, then they will have
> newer timestamps than the build artifacts, so the artifacts will need to
> be regenerated anyway.

This is such a good explanation of why automatically removing these
directories was perfectly fine for us to do.

> If users depend on ignored files within the sparse directories, then
> they have created a bad shape in their repository. Regardless, such
> shapes would create risk that changing the behavior for all cone mode
> users might be too risky to take on at the moment. Since this data shape
> makes it impossible to get performance benefits using the sparse index,
> we limit the change to only be enabled when the sparse index is enabled.
> Users can opt out of this behavior by disabline the sparse index.

s/disabline/disabling/, otherwise, I fully agree with this paragraph.

> Depending on user feedback or real-world use, we might want to consider
> expanding the behavior change to all of cone mode. Since we are
> currently restricting to the sparse index case, we can use the existence
> of sparse directory entries in the index as indicators of which
> directories should be removed.

Let's just expand it to all of cone mode.

> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  Documentation/git-sparse-checkout.txt |  6 +++
>  builtin/sparse-checkout.c             | 73 +++++++++++++++++++++++++++
>  t/t1091-sparse-checkout-builtin.sh    | 42 +++++++++++++++
>  3 files changed, 121 insertions(+)
>
> diff --git a/Documentation/git-sparse-checkout.txt b/Documentation/git-sparse-checkout.txt
> index fdcf43f87cb..c443189f418 100644
> --- a/Documentation/git-sparse-checkout.txt
> +++ b/Documentation/git-sparse-checkout.txt
> @@ -210,6 +210,12 @@ case-insensitive check. This corrects for case mismatched filenames in the
>  'git sparse-checkout set' command to reflect the expected cone in the working
>  directory.
>
> +When the sparse index is enabled through the `index.sparse` config option,
> +the cone mode sparse-checkout patterns will also remove ignored files that
> +are not within the sparse-checkout definition. This is important behavior
> +to preserve the performance of the sparse index, but also matches that
> +cone mode patterns care about directories, not files.
> +
>
>  SUBMODULES
>  ----------
> diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
> index a4bdd7c4940..5c03636b6ec 100644
> --- a/builtin/sparse-checkout.c
> +++ b/builtin/sparse-checkout.c
> @@ -15,6 +15,7 @@
>  #include "wt-status.h"
>  #include "quote.h"
>  #include "sparse-index.h"
> +#include "run-command.h"
>
>  static const char *empty_base = "";
>
> @@ -100,6 +101,71 @@ static int sparse_checkout_list(int argc, const char **argv)
>         return 0;
>  }
>
> +static void clean_tracked_sparse_directories(struct repository *r)
> +{
> +       int i;
> +       struct strbuf path = STRBUF_INIT;
> +       size_t pathlen;
> +
> +       /*
> +        * If we are not using cone mode patterns, then we cannot
> +        * delete directories outside of the sparse cone.
> +        */
> +       if (!r || !r->index || !r->index->sparse_checkout_patterns ||
> +           !r->index->sparse_checkout_patterns->use_cone_patterns)
> +               return;
> +       /*
> +        * NEEDSWORK: For now, only use this behavior when index.sparse
> +        * is enabled. We may want this behavior enabled whenever using
> +        * cone mode patterns.
> +        */
> +       prepare_repo_settings(r);
> +       if (!r->worktree || !r->settings.sparse_index)
> +               return;

s/may/do/  :-)

> +
> +       /*
> +        * Since we now depend on the sparse index to enable this
> +        * behavior, use it to our advantage. This process is more
> +        * complicated without it.
> +        */

Ah, the real reason why you limited this change to sparse-index comes out.  :-)

> +       convert_to_sparse(r->index);
> +
> +       strbuf_addstr(&path, r->worktree);
> +       strbuf_complete(&path, '/');
> +       pathlen = path.len;
> +
> +       for (i = 0; i < r->index->cache_nr; i++) {
> +               struct cache_entry *ce = r->index->cache[i];
> +
> +               /*
> +                * Is this a sparse directory? If so, then definitely
> +                * include it. All contained content is outside of the
> +                * patterns.

"include"?  I would have used the word "remove", but it gets confusing
because the question is if we want to include it in our list of things
to remove or remove it from the working directory.

> +                */
> +               if (S_ISSPARSEDIR(ce->ce_mode) &&
> +                   repo_file_exists(r, ce->name)) {
> +                       strbuf_setlen(&path, pathlen);
> +                       strbuf_addstr(&path, ce->name);
> +
> +                       /*
> +                        * Removal is "best effort". If something blocks
> +                        * the deletion, then continue with a warning.
> +                        */
> +                       if (remove_dir_recursively(&path, 0))
> +                               warning(_("failed to remove directory '%s'"), path.buf);

Um, doesn't this delete untracked files that are not ignored as well
as the ignored files?  If so, was that intentional?  I'm fully on
board with removing the gitignore'd files, but I'm worried removing
other untracked files is dangerous.

My implementation of this concept (in an external tool) was more along
the lines of

  * Get $LIST_OF_NON_SPARSE_DIRECTORIES by walking `git ls-files -t`
output and finding common fully-sparse directories
  * git clean -fX $LIST_OF_NON_SPARSE_DIRECTORIES


> +               }
> +       }
> +
> +       strbuf_release(&path);
> +
> +       /*
> +        * This is temporary: the sparse-checkout builtin is not
> +        * integrated with the sparse-index yet, so we need to keep
> +        * it full during the process.
> +        */
> +       ensure_full_index(r->index);
> +}
> +
>  static int update_working_directory(struct pattern_list *pl)
>  {
>         enum update_sparsity_result result;
> @@ -141,6 +207,8 @@ static int update_working_directory(struct pattern_list *pl)
>         else
>                 rollback_lock_file(&lock_file);
>
> +       clean_tracked_sparse_directories(r);
> +
>         r->index->sparse_checkout_patterns = NULL;
>         return result;
>  }

(Adding a comment here just to separate the two blocks below.)

> @@ -540,8 +608,11 @@ static int modify_pattern_list(int argc, const char **argv, enum modify_type m)
>  {
>         int result;
>         int changed_config = 0;
> +       struct pattern_list *old_pl = xcalloc(1, sizeof(*old_pl));
>         struct pattern_list *pl = xcalloc(1, sizeof(*pl));
>
> +       get_sparse_checkout_patterns(old_pl);
> +
>         switch (m) {
>         case ADD:
>                 if (core_sparse_checkout_cone)
> @@ -567,7 +638,9 @@ static int modify_pattern_list(int argc, const char **argv, enum modify_type m)
>                 set_config(MODE_NO_PATTERNS);
>
>         clear_pattern_list(pl);
> +       clear_pattern_list(old_pl);
>         free(pl);
> +       free(old_pl);
>         return result;
>  }

You create an old_pl, populate it with get_sparse_checkout_patterns(),
do nothing with it, then clear and free it?  I'm confused by the above
two blocks.

>
> diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
> index 38fc8340f5c..43eb314c94a 100755
> --- a/t/t1091-sparse-checkout-builtin.sh
> +++ b/t/t1091-sparse-checkout-builtin.sh
> @@ -642,4 +642,46 @@ test_expect_success MINGW 'cone mode replaces backslashes with slashes' '
>         check_files repo/deep a deeper1
>  '
>
> +test_expect_success 'cone mode clears ignored subdirectories' '
> +       rm repo/.git/info/sparse-checkout &&
> +
> +       # NEEDSWORK: --sparse-index is required for now
> +       git -C repo sparse-checkout init --cone --sparse-index &&
> +       git -C repo sparse-checkout set deep/deeper1 &&
> +
> +       cat >repo/.gitignore <<-\EOF &&
> +       obj/
> +       *.o
> +       EOF
> +
> +       git -C repo add .gitignore &&
> +       git -C repo commit -m ".gitignore" &&
> +
> +       mkdir -p repo/obj repo/folder1/obj repo/deep/deeper2/obj &&
> +       for file in folder1/obj/a obj/a folder1/file.o folder1.o \
> +                   deep/deeper2/obj/a deep/deeper2/file.o file.o
> +       do
> +               echo ignored >repo/$file || return 1
> +       done &&
> +
> +       git -C repo status --porcelain=v2 >out &&
> +       test_must_be_empty out &&
> +
> +       git -C repo sparse-checkout reapply &&
> +       test_path_is_missing repo/folder1 &&
> +       test_path_is_missing repo/deep/deeper2 &&
> +       test_path_is_dir repo/obj &&
> +       test_path_is_file repo/file.o &&
> +
> +       git -C repo status --porcelain=v2 >out &&
> +       test_must_be_empty out &&
> +
> +       git -C repo sparse-checkout set deep/deeper2 &&
> +       test_path_is_missing repo/deep/deeper1 &&
> +       test_path_is_dir repo/deep/deeper2 &&

What's the expectation for repo/obj?

> +
> +       git -C repo status --porcelain=v2 >out &&
> +       test_must_be_empty out
> +'
> +
>  test_done
> --
