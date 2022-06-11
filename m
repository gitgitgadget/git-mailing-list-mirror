Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B59EEC43334
	for <git@archiver.kernel.org>; Sat, 11 Jun 2022 04:54:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347980AbiFKEyE (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Jun 2022 00:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236616AbiFKEx6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Jun 2022 00:53:58 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A81BB74
        for <git@vger.kernel.org>; Fri, 10 Jun 2022 21:53:55 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id fu3so1517849ejc.7
        for <git@vger.kernel.org>; Fri, 10 Jun 2022 21:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7yBcKurY0GWzVwunMdmX1zPT7lLF1XX5LPfUGq3B9js=;
        b=KMWFkh/d36LofwEJ2ZceCT+y3LTFdLCe8oi8Glcf+wzBkA4+BTpV7uyf7OnGlqLZI8
         bCVFcCnX0O1uxYwrKedmWbpXdIDEiXJO+RMZ0vBk1JLRSwcc+RiR9t90Xzj4I8dEBmqz
         GrNUgKCSw0C7awbwvzp1sTZRCCDdgfR3iMTM3qxN/orMnQ4ZdkCwDsOOTJkas5zTko5d
         wID3j1qbsapiw9XrH+oTdBSjNJ18IuxuCxPfneyPlRzb06fSXgpMJO9+f+VId46A9pU7
         MhL2JDYS9HbH+gaUWedU6vdlO9Y1KugGP4zRfREwpDNEMmARCnjGpxrlI6ctMXYR10Y2
         J88g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7yBcKurY0GWzVwunMdmX1zPT7lLF1XX5LPfUGq3B9js=;
        b=uS2OBJ2FCUf+drbUfYqn7zHcyehBnGL7e+IODj2S/1UCWjrvNt5rVsIgtQnezEcTF7
         yjCDL4xJ7+n0q3uXj/WHuJxk4JAppeoPJ8/gCThWpErVELYwHcAZig5tBFNdj6xcvW5h
         BAC5xbm82yRxNXcBR5/2ZiDrkYrYfWq/9U2cvcsdoohuIHHmaWVasloateAoNGpkg6K6
         za6ep2YDjjONU0uPChbf5frMguc+btshuOTQyeK5nI1kOQs/67tHzPMS+vKKW6U+YNDo
         PTHbgoZxFpNPIVGF4ngrUbs1DpN5LLb9jCcKJZ+6xaiGwE5FPcJUHAqtxOo9BdGMQCbK
         x/6w==
X-Gm-Message-State: AOAM532248xsIqylEm68T8w7Oy2xgPYuRjPuPi1bjfQ+9Jgw9UlI2XWl
        G4uOdUNz0Q6jrGunnsyRU235rH674bxu/BExjOk=
X-Google-Smtp-Source: ABdhPJyT88MXJxEfKndgIUgEkZLLCCTwZ9l7Q6GtPX5lsf/28193TR9PEsfew/w6ODiOwGzrokC+zpp5WfDPHSpD+Mg=
X-Received: by 2002:a17:907:7ea9:b0:6fe:d412:ec2c with SMTP id
 qb41-20020a1709077ea900b006fed412ec2cmr43238040ejc.613.1654923233432; Fri, 10
 Jun 2022 21:53:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220606235449.2890858-1-calvinwan@google.com> <20220610231152.2594428-1-calvinwan@google.com>
In-Reply-To: <20220610231152.2594428-1-calvinwan@google.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 10 Jun 2022 21:53:42 -0700
Message-ID: <CABPp-BHe7wdd3LMYtZ83ZgapvUxzQYcK-3=sdMAD5Ozs4YmKyw@mail.gmail.com>
Subject: Re: [PATCH v2] submodule merge: update conflict error message
To:     Calvin Wan <calvinwan@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Glen Choo <chooglen@google.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 10, 2022 at 4:29 PM Calvin Wan <calvinwan@google.com> wrote:
>
> When attempting to do a non-fast-forward merge in a project with
> conflicts in the submodules, the merge fails and git prints the
> following error:
>
> Failed to merge submodule <submodules>
> CONFLICT (submodule):Merge conflict in <submodule>
> Automatic merge failed; fix conflicts and then commit the result.
>
> Git is left in a conflicted state, which requires the user to:
>  1. merge submodules
>  2. add submodules changes to the superproject
>  3. merge superproject

I think we may need to tweak these steps a bit:

   1. merge submodules OR update submodules to an already existing
commit that reflects the merge (i.e. as submodules they may well be
independently actively developed.  Someone may have already merged the
appropriate branch/commit and the already extant merges should be used
in preference to creating new ones.)
   2. <just as you said>
   3. FINISH merging the superproject (i.e. don't redo the merge)

I might be off on step 1; I have only used submodules extremely
lightly and usually only for a limited time, so I'm not really sure
what the expected workflow is.  I could also imagine it potentially
being repository-dependent whether you would want to merge or select
an appropriate commit to update to.

> These steps are non-obvious for newer submodule users to figure out
> based on the error message and neither `git submodule status` nor `git
> status` provide any useful pointers.
>
> Update error message to the following when attempting to do a
> non-fast-forward merge in a project with conflicts in the submodules.

Make sense.

> The error message is based off of what would happen when `merge
> --recurse-submodules` is eventually supported
>
> Failed to merge submodule <submodule>
> CONFLICT (submodule): Merge conflict in <submodule>
> Automatic merge failed; recursive merging with submodules is currently
> not supported. To manually complete the merge:
>  - go to submodule (<submodule>), and merge commit <commit>
>  - come back to superproject, and `git add <submodule>` to record the above merge
>  - resolve any other conflicts in the superproject
>  - commit the resulting index in the superproject

Ah, I see you've fixed step 3 here; that's good.

However, these steps miss out on the merge-or-update submodule
possibility...and since you mention these steps are potentially the
basis for some future work, I think it's worth calling that out again.
I'm slightly worried that the 'update' part of merge-or-update may
throw a wrench in the plans for `merge --recurse-submodules`.

(Also, continuing on the `merge --recurse-submodules` talent but
discussing a different aspect of it, I'm curious if you need to add
extra dirty-worktree/dirty-index checks for each submodule at the
start of a merge, whether you need to try to lock N indexes before
starting, and what other extra details are necessary.  But those are
probably questions to address whenever work on the future series to
implement this option is underway.)

> Changes since v1:
>  - Removed advice to abort merge
>  - Error message updated to contain more commit/submodule information
>
> Signed-off-by: Calvin Wan <calvinwan@google.com>
>
> ---
>  builtin/merge.c            | 23 ++++++++++++++++++++++-
>  merge-ort.c                |  7 ++++++-
>  merge-recursive.c          |  7 ++++++-
>  merge-recursive.h          |  4 ++++
>  t/t6437-submodule-merge.sh |  5 ++++-
>  5 files changed, 42 insertions(+), 4 deletions(-)

So you're modifying the "git merge" porcelain level (builtin/merge.c),
the two merges strategies, their common header, and adding some tests.
No other porcelains are modified...

> diff --git a/builtin/merge.c b/builtin/merge.c
> index f178f5a3ee..7e2deea7fb 100644
> --- a/builtin/merge.c
> +++ b/builtin/merge.c
> @@ -88,6 +88,8 @@ static const char *sign_commit;
>  static int autostash;
>  static int no_verify;
>  static char *into_name;
> +static struct oid_array conflicted_submodule_oids = OID_ARRAY_INIT;
> +static struct string_list conflicted_submodule_paths = STRING_LIST_INIT_DUP;
>
>  static struct strategy all_strategy[] = {
>         { "recursive",  NO_TRIVIAL },
> @@ -734,6 +736,8 @@ static int try_merge_strategy(const char *strategy, struct commit_list *common,
>                 }
>
>                 init_merge_options(&o, the_repository);
> +               o.conflicted_submodule_oids = &conflicted_submodule_oids;
> +               o.conflicted_submodule_paths = &conflicted_submodule_paths;
>                 if (!strcmp(strategy, "subtree"))
>                         o.subtree_shift = "";
>
> @@ -973,8 +977,25 @@ static int suggest_conflicts(void)
>         strbuf_release(&msgbuf);
>         fclose(fp);
>         repo_rerere(the_repository, allow_rerere_auto);
> -       printf(_("Automatic merge failed; "
> +       if (conflicted_submodule_oids.nr > 0) {
> +               int i;
> +               printf(_("Automatic merge failed; recursive merging with submodules is currently\n"
> +                       "not supported. To manually complete the merge:\n"));
> +               for (i = 0; i < conflicted_submodule_oids.nr; i++) {
> +                       printf(_(" - go to submodule (%s), and merge commit %s\n"),
> +                               conflicted_submodule_paths.items[i].string,
> +                               oid_to_hex(&conflicted_submodule_oids.oid[i]));
> +               }
> +               printf(_(" - come back to superproject, and `git add"));
> +               for (i = 0; i < conflicted_submodule_paths.nr; i++)
> +                       printf(_(" %s"), conflicted_submodule_paths.items[i].string);
> +               printf(_("` to record the above merge \n"
> +               " - resolve any other conflicts in the superproject\n"
> +               " - commit the resulting index in the superproject\n"));
> +       } else {
> +               printf(_("Automatic merge failed; "
>                         "fix conflicts and then commit the result.\n"));
> +       }
>         return 1;
>  }

This is kind of nice.  I was worried you were going to embed these
messages in the merge strategies, which could cause problems for other
users of the merge strategies such as the --remerge-diff options to
git log and git show (your new messages would be unwanted noise or
even cause confusion there), and to the merge-tree work.  In fact, a
current submodule-merging message (search for "--cacheinfo") that is
potentially similar to what you are adding here but which was added at
the merge strategy level already feels highly problematic to me.  I've
been considering nuking it from the codebase for some time because of
those issues, though I guess just moving it out elsewhere may also
work.

However, this implementation does have a drawback: these messages
won't appear for rebases, cherry-picks, reverts, attempted unstashing
(git stash apply/pop), or other actions unless you update the relevant
porcelains for those as well.

A possible alternative here would be to move it to the level of
merge-recursive and merge-ort that is only called when the working
tree and index are updated.  For example, placing it in
merge_finalize() in merge-recursive.c and merge_switch_to_result() in
merge-ort.c -- next to the diff_warn_rename_limit() call in each case.
However, I'm also fine with keeping it at the porcelain level, it just
may need to be in a function that is called from several porcelains
that way.

> diff --git a/merge-ort.c b/merge-ort.c
> index 0d3f42592f..c86ee11614 100644
> --- a/merge-ort.c
> +++ b/merge-ort.c
> @@ -3866,8 +3866,13 @@ static void process_entry(struct merge_options *opt,
>                         const char *reason = _("content");
>                         if (ci->filemask == 6)
>                                 reason = _("add/add");
> -                       if (S_ISGITLINK(merged_file.mode))
> +                       if (S_ISGITLINK(merged_file.mode)) {
>                                 reason = _("submodule");
> +                               if (opt->conflicted_submodule_oids && opt->conflicted_submodule_paths) {
> +                                       oid_array_append(opt->conflicted_submodule_oids, &merged_file.oid);
> +                                       string_list_append(opt->conflicted_submodule_paths, path);
> +                               }
> +                       }
>                         path_msg(opt, path, 0,
>                                  _("CONFLICT (%s): Merge conflict in %s"),
>                                  reason, path);
> diff --git a/merge-recursive.c b/merge-recursive.c
> index fd1bbde061..ff7cdbefe9 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -3149,8 +3149,13 @@ static int handle_content_merge(struct merge_file_info *mfi,
>         }
>
>         if (!mfi->clean) {
> -               if (S_ISGITLINK(mfi->blob.mode))
> +               if (S_ISGITLINK(mfi->blob.mode)) {
>                         reason = _("submodule");
> +                       if (opt->conflicted_submodule_oids && opt->conflicted_submodule_paths) {
> +                               oid_array_append(opt->conflicted_submodule_oids, &mfi->blob.oid);
> +                               string_list_append(opt->conflicted_submodule_paths, path);
> +                       }
> +               }
>                 output(opt, 1, _("CONFLICT (%s): Merge conflict in %s"),
>                                 reason, path);
>                 if (ci && !df_conflict_remains)

Nice that the changes needed to both the ort and recursive strategies
are so localized.  :-)

> diff --git a/merge-recursive.h b/merge-recursive.h
> index b88000e3c2..5d267e7a43 100644
> --- a/merge-recursive.h
> +++ b/merge-recursive.h
> @@ -51,6 +51,10 @@ struct merge_options {
>
>         /* internal fields used by the implementation */
>         struct merge_options_internal *priv;
> +
> +       /* fields that hold submodule conflict information */
> +       struct oid_array *conflicted_submodule_oids;
> +       struct string_list *conflicted_submodule_paths;
>  };

Make sense.

>  void init_merge_options(struct merge_options *opt, struct repository *repo);
> diff --git a/t/t6437-submodule-merge.sh b/t/t6437-submodule-merge.sh
> index 178413c22f..5b384dedc1 100755
> --- a/t/t6437-submodule-merge.sh
> +++ b/t/t6437-submodule-merge.sh
> @@ -141,6 +141,7 @@ test_expect_success 'merging should conflict for non fast-forward' '
>                 test_must_fail git merge c 2> actual
>           fi &&
>          grep $(cat expect) actual > /dev/null &&
> +        test_i18ngrep "go to submodule (sub), and merge commit $(git -C sub rev-parse sub-b)" actual &&
>          git reset --hard)
>  '
>
> @@ -167,6 +168,7 @@ test_expect_success 'merging should fail for ambiguous common parent' '
>          fi &&
>         grep $(cat expect1) actual > /dev/null &&
>         grep $(cat expect2) actual > /dev/null &&
> +       test_i18ngrep "go to submodule (sub), and merge commit $(git -C sub rev-parse sub-b)" actual &&
>         git reset --hard)
>  '
>
> @@ -205,7 +207,8 @@ test_expect_success 'merging should fail for changes that are backwards' '
>         git commit -a -m "f" &&
>
>         git checkout -b test-backward e &&
> -       test_must_fail git merge f)
> +       test_must_fail git merge f >actual &&
> +       test_i18ngrep "go to submodule (sub), and merge commit $(git -C sub rev-parse sub-a)" actual)

test_i18ngrep is apparently on the way out:

    $ grep -B 3 ^test_i18ngrep t/test-lib-functions.sh
    # Wrapper for grep which used to be used for
    # GIT_TEST_GETTEXT_POISON=false. Only here as a shim for other
    # in-flight changes. Should not be used and will be removed soon.
    test_i18ngrep () {

I think you just want to use grep instead here for each of these hunks.
