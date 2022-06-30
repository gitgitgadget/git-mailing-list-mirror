Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DE3CC43334
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 02:40:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbiF3Ck1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jun 2022 22:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiF3CkZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jun 2022 22:40:25 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07DB12A4
        for <git@vger.kernel.org>; Wed, 29 Jun 2022 19:40:23 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id sb34so36146972ejc.11
        for <git@vger.kernel.org>; Wed, 29 Jun 2022 19:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KC4yd0VKfLlCT6VWdjBuaRazHyFfN0m25FUAgauzaoE=;
        b=FA7pzuLZK9SsWNUG152aUjajHILAoAF4BcAPHElIF1L/IUhtHwOaKP9j9HgXc93cyf
         oeS3tZZtOXBwQbadQ9LAM9JLDRvTnX1STbrx7so0NFYIp/5r9nvFWKxH+fiVhTnIBO8i
         wX71SFImKF7OwQlc+/KshykJIAyXmFKj0IKuTTkoJQdqTSBKsD3PUrPCzymlLefnTF49
         luAXeC0iTkqcrWz0hXBPQVjA/DRr584YKs8Lcw9jaDLVX+Nt6SrtmZeEWgkGrEs9usCB
         YbJvPCHDluWcxvY1JR79aE68fQ1w9thyXxXNl1MsTAPIBPvcg+0IIovQ0ROCH07YHbjp
         8Ygw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KC4yd0VKfLlCT6VWdjBuaRazHyFfN0m25FUAgauzaoE=;
        b=alip5b49apfJo4kN1FArOb/IOzZJdEKEJf3Az53PQHnRhBkj8Xo57rv8nrRrSkXB5u
         Hggm+dxKN7p7Yaj5JUmg5wtYQjvTmyB2V689HXucYmskjO9D2p+f9M8tNXTo8HzhExar
         BmXxP7k86Io89LE5Ea4VKQSPcrPJiByBxSVmNM62uYb8srLyU6M0x2f0zTZkS4QSWVAs
         kamiR3YHltLvXEDoSmgU8sVd6fahcfAbyt1yXIuUBpSZglCyzCCBLJaUaPW4rTMjAese
         OGuFDvNHGr3GnarHNt6rYWtxT3hMLEcDykS+liPF1BAhYGKR5YfQ7sq8FfTnvf9tURZo
         fbqw==
X-Gm-Message-State: AJIora8mUflWF4msF4K4XesfaFSumkHLxdMiXcM5XB3YmJ5iMTrlCDF8
        WTJweyXft9o4w/P9jAZKg+JQYUrSdwKna4YJhq8=
X-Google-Smtp-Source: AGRyM1tGHU1ZJXr8LlEhst91FkDm+MccfTGaM891PsiCq/QALzO6uZ47JRlTZCgHwFIJT2oqgN+VPeTA0zXx32SRmvA=
X-Received: by 2002:a17:906:7049:b0:70c:a5fe:d4f8 with SMTP id
 r9-20020a170906704900b0070ca5fed4f8mr6192010ejj.493.1656556821408; Wed, 29
 Jun 2022 19:40:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220610231152.2594428-1-calvinwan@google.com> <20220629224059.1016645-1-calvinwan@google.com>
In-Reply-To: <20220629224059.1016645-1-calvinwan@google.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 29 Jun 2022 19:40:09 -0700
Message-ID: <CABPp-BEXQNWCPXr31Oo59577kzoSbfDV=7_7dN8n6KMTsVgsjg@mail.gmail.com>
Subject: Re: [PATCH v3] submodule merge: update conflict error message
To:     Calvin Wan <calvinwan@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Glen Choo <chooglen@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Wed, Jun 29, 2022 at 3:41 PM Calvin Wan <calvinwan@google.com> wrote:
>
> When attempting to merge in a superproject with conflicting submodule
> pointers that cannot be fast-forwarded, the merge fails and git prints
> the following error:
>
> Failed to merge submodule <submodule>
> CONFLICT (submodule):Merge conflict in <submodule>
> Automatic merge failed; fix conflicts and then commit the result.
>
> Git is left in a conflicted state, which requires the user to:
>  1. merge submodules or update submodules to an already existing
>         commit that reflects the merge
>  2. add submodules changes to the superproject
>  3. finish merging superproject
> These steps are non-obvious for newer submodule users to figure out
> based on the error message and neither `git submodule status` nor `git
> status` provide any useful pointers.
>
> Update error message to match the steps above. If git does not detect a
> merge resolution, the following is printed:
>
> --------
>
> Failed to merge submodule <submodule>
> CONFLICT (submodule): Merge conflict in <submodule>
> Automatic merge failed; recursive merging with submodules is currently
> not supported. To manually complete the merge:
>  - go to submodule (<submodule>), and merge commit <commit>

I'm still a little unsure on this.  The merge_submodule() logic we
have may not have detected a merge commit that merges the two branches
together, but that doesn't automatically imply a new merge must be
created in the submodule to resolve this conflict.  There might be
various reasons that other existing commits in the submodule could be
used as the "correct" update.

Perhaps that is uncommon enough to not be worth mentioning; I'm just a
little hesitant to treat the merge_submodule() logic as robust and
finding the only choices users might want to use.  If we do keep the
wording as-is, it might be nice to at least discuss in the commit
message why we chose that and ignored the or-update-submodule option
in this case.

>  - come back to superproject, and `git add <submodule>` to record the above merge
>  - resolve any other conflicts in the superproject
>  - commit the resulting index in the superproject
> Automatic merge failed; fix conflicts and then commit the result.
>
> --------
>
> If git detects a possible merge resolution, the following is printed:
>
> --------
>
> Failed to merge submodule sub, but a possible merge resolution exists:
>     <commit> Merge branch '<branch1>' into <branch2>
>
>
> If this is correct simply add it to the index for example
> by using:
>
>   git update-index --cacheinfo 160000 <commit> "<submodule>"
>
> which will accept this suggestion.

The last few lines above will no longer be part of the output once
en/merge-tree is merged; see commit a4040cfa35 (merge-ort: remove
command-line-centric submodule message from merge-ort, 2022-06-18).

> CONFLICT (submodule): Merge conflict in <submodule>
> Recursive merging with submodules is currently not supported.
> To manually complete the merge:
>  - go to submodule (<submodule>), and either update the submodule to a possible commit above or merge commit <commit>

Again, I'm hesitant to treat the suggestions from merge_submodule() as
the only possibilities.  For example, perhaps the user will want to
pick a commit that contains one of the ones found by merge_submodule()
in its history -- perhaps because the newer commit they want to select
contains an important bugfix for an issue not discovered at the time
of the merge in the submodule.

Also, I'm worried your sentence may be easy to misunderstand, due to
it being ambiguous whether "merge" is a verb or an adjective.  More
precisely, your sentence could be read as "update the submodule to a
possible commit above, or update the submodule to merge commit
<commit>" and then users say, "But <commit> isn't a merge commit; why
does this message claim it is?  Do I just update the submodule to that
commit anyway?"  Or perhaps users just update it to <commit> without
even checking to find out that it's not a merge commit, with the
deleterious consequences of missing all the important changes
currently found in the submodule.

>  - come back to superproject, and `git add <submodule>` to record the above merge

"...to record the above merge or update"?

>  - resolve any other conflicts in the superproject
>  - commit the resulting index in the superproject
> Automatic merge failed; fix conflicts and then commit the result.
>
> --------
>
> If git detects multiple possible merge resolutions, the following is printed:
>
> --------
>
> Failed to merge submodule sub, but multiple possible merges exist:
>     <commit> Merge branch '<branch1>' into <branch2>
>     <commit> Merge branch '<branch1>' into <branch3>
>
> CONFLICT (submodule): Merge conflict in <submodule>
> Recursive merging with submodules is currently not supported.
> To manually complete the merge:
>  - go to submodule (<submodule>), and either update the submodule to a possible commit above or merge commit <commit>

Same issues as I mentioned above for the single-merge-resolution-found case.

>  - come back to superproject, and `git add <submodule>` to record the above merge

"merge or update", right?

>  - resolve any other conflicts in the superproject
>  - commit the resulting index in the superproject
> Automatic merge failed; fix conflicts and then commit the result.
>
> -------
>
> Changes since v2:
> There are three major changes in this patch thanks to all the helpful
> feedback! I have moved the print function from builtin/merge.c to
> merge-ort.c and added it to merge_finalize() in merge-recursive.c and
> merge_switch_to_result() in merge-ort.c. This allows other merge
> machinery commands besides merge to print submodule conflict advice.
>
> I have moved the check for submodule conflicts from process_entry() to
> merge_submodule(). This also required removing the early returns and
> instead going to my submodule conflict check allowing us to pass back
> information on whether git detected a possible merge resolution or not.
>
> I have also updated the error message to better reflect the merge
> status. Specifically, if git detects a possible merge resolution, the
> error message now also suggest updating to one of those resolutions.
>
> Other small changes:
>  - Moved fields that hold submodule conflict information to new object
>  - Shortened printed commit id to DEFAULT_ABBREV
>  - Added a test to t6437-submodule-merge.sh for merges with no
>    resolution existence
>  - Modified a test in t7402-submodule-rebase to show error message
>    prints in other parts of the merge machinery
>
> Changes since v1:
>  - Removed advice to abort merge
>  - Error message updated to contain more commit/submodule information
>
> Signed-off-by: Calvin Wan <calvinwan@google.com>
> ---
>  merge-ort.c                 | 53 ++++++++++++++++++++++++++++++++++---
>  merge-recursive.c           | 26 +++++++++++++++---
>  merge-recursive.h           | 18 +++++++++++++
>  t/t6437-submodule-merge.sh  | 36 ++++++++++++++++++++++---
>  t/t7402-submodule-rebase.sh |  6 +++--
>  5 files changed, 125 insertions(+), 14 deletions(-)
>
> diff --git a/merge-ort.c b/merge-ort.c
> index 0d3f42592f..2d9f03ea8c 100644
> --- a/merge-ort.c
> +++ b/merge-ort.c
> @@ -1610,6 +1610,9 @@ static int merge_submodule(struct merge_options *opt,
>         struct commit *commit_o, *commit_a, *commit_b;
>         int parent_count;
>         struct object_array merges;
> +       struct conflicted_submodule_list *csub = opt->conflicted_submodules;
> +       struct conflicted_submodule_item csub_item;
> +       int resolution_exists = 0;
>
>         int i;
>         int search = !opt->priv->call_depth;
> @@ -1619,17 +1622,17 @@ static int merge_submodule(struct merge_options *opt,
>
>         /* we can not handle deletion conflicts */
>         if (is_null_oid(o))
> -               return 0;
> +               goto ret;
>         if (is_null_oid(a))
> -               return 0;
> +               goto ret;
>         if (is_null_oid(b))
> -               return 0;
> +               goto ret;
>
>         if (repo_submodule_init(&subrepo, opt->repo, path, null_oid())) {
>                 path_msg(opt, path, 0,
>                                 _("Failed to merge submodule %s (not checked out)"),
>                                 path);
> -               return 0;
> +               goto ret;
>         }
>
>         if (!(commit_o = lookup_commit_reference(&subrepo, o)) ||
> @@ -1703,6 +1706,7 @@ static int merge_submodule(struct merge_options *opt,
>                            "which will accept this suggestion.\n"),
>                          oid_to_hex(&merges.objects[0].item->oid), path);
>                 strbuf_release(&sb);
> +               resolution_exists = 1;
>                 break;
>         default:
>                 for (i = 0; i < merges.nr; i++)
> @@ -1712,11 +1716,24 @@ static int merge_submodule(struct merge_options *opt,
>                          _("Failed to merge submodule %s, but multiple "
>                            "possible merges exist:\n%s"), path, sb.buf);
>                 strbuf_release(&sb);
> +               resolution_exists = 1;
>         }
>
>         object_array_clear(&merges);
>  cleanup:
>         repo_clear(&subrepo);
> +ret:
> +       if (!ret) {
> +               if (!csub) {
> +                       CALLOC_ARRAY(csub, 1);
> +               }
> +               csub_item.oid = *result;

Shouldn't this be "*b" rather than "*result"?

Also, are we risking telling the user to "merge commit
0000000000000000000000000000000000000000" from the submodule, given
some of the early exits that you redirected to come through here?

> +               csub_item.path = xstrdup(path);
> +               csub_item.resolution_exists = resolution_exists;
> +               ALLOC_GROW(csub->items, csub->nr + 1, csub->alloc);
> +               csub->items[csub->nr++] = csub_item;
> +               opt->conflicted_submodules = csub;
> +       }
>         return ret;
>  }
>
> @@ -4256,6 +4273,32 @@ static int record_conflicted_index_entries(struct merge_options *opt)
>         return errs;
>  }
>
> +void print_submodule_conflict_suggestion(struct conflicted_submodule_list *csub) {

Maybe just make this function be static?

> +       if (csub && csub->nr > 0) {
> +               int i;
> +               printf(_("Recursive merging with submodules is currently not supported.\n"
> +                       "To manually complete the merge:\n"));
> +               for (i = 0; i < csub->nr; i++) {
> +                       const struct object_id id = csub->items[i].oid;
> +                       if (csub->items[i].resolution_exists)
> +                               printf(_(" - go to submodule (%s), and either update the submodule "
> +                                       "to a possible commit above or merge commit %s\n"),
> +                                       csub->items[i].path,
> +                                       find_unique_abbrev(&id, DEFAULT_ABBREV));

Shouldn't this be repo_find_unique_abbrev(), and in particular with
the submodule repository being passed to it?  Or perhaps using the
format_commit() function, since merge_submodule() is already using it
for the earlier submodule-related messages?

> +                       else
> +                               printf(_(" - go to submodule (%s), and merge commit %s\n"),
> +                                       csub->items[i].path,
> +                                       find_unique_abbrev(&id, DEFAULT_ABBREV));

Likewise?

> +               }
> +               printf(_(" - come back to superproject, and `git add"));
> +               for (i = 0; i < csub->nr; i++)
> +                       printf(_(" %s"), csub->items[i].path);
> +               printf(_("` to record the above merge \n"
> +                       " - resolve any other conflicts in the superproject\n"
> +                       " - commit the resulting index in the superproject\n"));
> +       }
> +}
> +
>  void merge_switch_to_result(struct merge_options *opt,
>                             struct tree *head,
>                             struct merge_result *result,
> @@ -4324,6 +4367,8 @@ void merge_switch_to_result(struct merge_options *opt,
>                 }
>                 string_list_clear(&olist, 0);
>
> +               print_submodule_conflict_suggestion(opt->conflicted_submodules);
> +
>                 /* Also include needed rename limit adjustment now */
>                 diff_warn_rename_limit("merge.renamelimit",
>                                        opti->renames.needed_limit, 0);
> diff --git a/merge-recursive.c b/merge-recursive.c
> index fd1bbde061..311cc37886 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c

Is it worth updating merge-recursive.c here?  I'd rather only give it
security fix updates until we delete it.

> @@ -1190,6 +1190,9 @@ static int merge_submodule(struct merge_options *opt,
>         struct commit *commit_base, *commit_a, *commit_b;
>         int parent_count;
>         struct object_array merges;
> +       struct conflicted_submodule_list *csub = opt->conflicted_submodules;
> +       struct conflicted_submodule_item csub_item;
> +       int resolution_exists = 0;
>
>         int i;
>         int search = !opt->priv->call_depth;
> @@ -1204,15 +1207,15 @@ static int merge_submodule(struct merge_options *opt,
>
>         /* we can not handle deletion conflicts */
>         if (is_null_oid(base))
> -               return 0;
> +               goto ret;
>         if (is_null_oid(a))
> -               return 0;
> +               goto ret;
>         if (is_null_oid(b))
> -               return 0;
> +               goto ret;
>
>         if (repo_submodule_init(&subrepo, opt->repo, path, null_oid())) {
>                 output(opt, 1, _("Failed to merge submodule %s (not checked out)"), path);
> -               return 0;
> +               goto ret;
>         }
>
>         if (!(commit_base = lookup_commit_reference(&subrepo, base)) ||
> @@ -1287,17 +1290,31 @@ static int merge_submodule(struct merge_options *opt,
>                        "  git update-index --cacheinfo 160000 %s \"%s\"\n\n"
>                        "which will accept this suggestion.\n"),
>                        oid_to_hex(&merges.objects[0].item->oid), path);
> +               resolution_exists = 1;
>                 break;
>
>         default:
>                 output(opt, 1, _("Failed to merge submodule %s (multiple merges found)"), path);
>                 for (i = 0; i < merges.nr; i++)
>                         print_commit(&subrepo, (struct commit *) merges.objects[i].item);
> +               resolution_exists = 1;
>         }
>
>         object_array_clear(&merges);
>  cleanup:
>         repo_clear(&subrepo);
> +ret:
> +       if (!ret) {
> +               if (!csub) {
> +                       CALLOC_ARRAY(csub, 1);
> +               }
> +               csub_item.oid = *result;
> +               csub_item.path = xstrdup(path);
> +               csub_item.resolution_exists = resolution_exists;
> +               ALLOC_GROW(csub->items, csub->nr + 1, csub->alloc);
> +               csub->items[csub->nr++] = csub_item;
> +               opt->conflicted_submodules = csub;
> +       }
>         return ret;
>  }
>
> @@ -3736,6 +3753,7 @@ static void merge_finalize(struct merge_options *opt)
>         flush_output(opt);
>         if (!opt->priv->call_depth && opt->buffer_output < 2)
>                 strbuf_release(&opt->obuf);
> +       print_submodule_conflict_suggestion(opt->conflicted_submodules);
>         if (show(opt, 2))
>                 diff_warn_rename_limit("merge.renamelimit",
>                                        opt->priv->needed_rename_limit, 0);
> diff --git a/merge-recursive.h b/merge-recursive.h
> index b88000e3c2..b615955fb7 100644
> --- a/merge-recursive.h
> +++ b/merge-recursive.h
> @@ -9,6 +9,7 @@ struct object_id;
>  struct repository;
>  struct tree;
>
> +struct conflicted_submodule_list;
>  struct merge_options_internal;
>  struct merge_options {
>         struct repository *repo;
> @@ -51,6 +52,21 @@ struct merge_options {
>
>         /* internal fields used by the implementation */
>         struct merge_options_internal *priv;
> +
> +       /* field that holds submodule conflict information */
> +       struct conflicted_submodule_list *conflicted_submodules;

I think this should be added to merge_options_internal rather than to
merge_options.  There's no need for an API caller to make use of
these.

Also, if a clear need arises later for API callers to make use of this
information, then it should be part of merge_result for merge-ort.c,
not part of merge_options.

> +};
> +
> +struct conflicted_submodule_item {
> +       struct object_id oid;
> +       char *path;
> +       int resolution_exists;
> +};
> +
> +struct conflicted_submodule_list {
> +       struct conflicted_submodule_item *items;
> +       size_t nr;
> +       size_t alloc;
>  };

Similarly, I think these should be defined in merge-ort.c (and maybe
also merge-recursive.c) near struct merge_options_internal.

>  void init_merge_options(struct merge_options *opt, struct repository *repo);
> @@ -122,4 +138,6 @@ int merge_recursive_generic(struct merge_options *opt,
>                             const struct object_id **merge_bases,
>                             struct commit **result);
>
> +void print_submodule_conflict_suggestion(struct conflicted_submodule_list *csub);

and I think there's no reason to put this in the header file; it
should just be a static function in merge-ort.c.  (And, if we really
want to update merge-recursive.c, then copy the function over there.
*Nothing* in merge-ort.c should call a function in merge-recursive.c
and similarly nothing in merge-recursive.c should call any function in
merge-ort.c.  Yes, that implies some duplication.  There is a fair
amount already and we've discussed it, and chosen against creating a
shared module as well.  I want merge-recursive to not be broken by
merge-ort updates; it should remain stable until the day we finally
get to nuke it.  I'm personally of the opinion that merge-recursive
should only get security fixes at this point, though I haven't pinged
to see if other folks agree with that point of view yet or not.  I'm
not wasting my time fixing/improving it, though...)

> +
>  #endif
> diff --git a/t/t6437-submodule-merge.sh b/t/t6437-submodule-merge.sh
> index 178413c22f..f0a31c3a61 100755
> --- a/t/t6437-submodule-merge.sh
> +++ b/t/t6437-submodule-merge.sh
> @@ -103,8 +103,28 @@ test_expect_success 'setup for merge search' '
>          echo "file-c" > file-c &&
>          git add file-c &&
>          git commit -m "sub-c") &&
> -       git commit -a -m "c" &&
> +       git commit -a -m "c")
> +'
> +
> +test_expect_success 'merging should conflict for non fast-forward' '
> +       (cd merge-search &&
> +        git checkout -b test-nonforward-a b &&
> +        (cd sub &&
> +         git rev-parse --short sub-b > ../expect) &&
> +         if test "$GIT_TEST_MERGE_ALGORITHM" = ort
> +         then
> +               test_must_fail git merge c >actual
> +         else
> +               test_must_fail git merge c 2> actual
> +         fi &&
> +        grep $(cat expect) actual > /dev/null &&
> +        sub_expect="go to submodule (sub), and merge commit $(git -C sub rev-parse --short sub-b)" &&
> +        grep "$sub_expect" actual &&
> +        git reset --hard)
> +'
>
> +test_expect_success 'finish setup for merge-search' '
> +       (cd merge-search &&
>         git checkout -b d a &&
>         (cd sub &&
>          git checkout -b sub-d sub-b &&
> @@ -129,9 +149,9 @@ test_expect_success 'merge with one side as a fast-forward of the other' '
>          test_cmp expect actual)
>  '
>
> -test_expect_success 'merging should conflict for non fast-forward' '
> +test_expect_success 'merging should conflict for non fast-forward (resolution exists)' '
>         (cd merge-search &&
> -        git checkout -b test-nonforward b &&
> +        git checkout -b test-nonforward-b b &&
>          (cd sub &&
>           git rev-parse sub-d > ../expect) &&
>           if test "$GIT_TEST_MERGE_ALGORITHM" = ort
> @@ -141,6 +161,9 @@ test_expect_success 'merging should conflict for non fast-forward' '
>                 test_must_fail git merge c 2> actual
>           fi &&
>          grep $(cat expect) actual > /dev/null &&
> +        sub_expect="go to submodule (sub), and either update the submodule to a \
> +possible commit above or merge commit $(git -C sub rev-parse --short sub-b)" &&
> +        grep "$sub_expect" actual &&
>          git reset --hard)
>  '
>
> @@ -167,6 +190,9 @@ test_expect_success 'merging should fail for ambiguous common parent' '
>          fi &&
>         grep $(cat expect1) actual > /dev/null &&
>         grep $(cat expect2) actual > /dev/null &&
> +       sub_expect="go to submodule (sub), and either update the submodule to a \
> +possible commit above or merge commit $(git -C sub rev-parse --short sub-b)" &&
> +       grep "$sub_expect" actual &&
>         git reset --hard)
>  '
>
> @@ -205,7 +231,9 @@ test_expect_success 'merging should fail for changes that are backwards' '
>         git commit -a -m "f" &&
>
>         git checkout -b test-backward e &&
> -       test_must_fail git merge f)
> +       test_must_fail git merge f >actual &&
> +       sub_expect="go to submodule (sub), and merge commit $(git -C sub rev-parse --short sub-a)" &&
> +       grep "$sub_expect" actual)
>  '
>
>
> diff --git a/t/t7402-submodule-rebase.sh b/t/t7402-submodule-rebase.sh
> index 8e32f19007..21c8b4e97c 100755
> --- a/t/t7402-submodule-rebase.sh
> +++ b/t/t7402-submodule-rebase.sh
> @@ -104,7 +104,7 @@ test_expect_success 'rebasing submodule that should conflict' '
>         test_tick &&
>         git commit -m fourth &&
>
> -       test_must_fail git rebase --onto HEAD^^ HEAD^ HEAD^0 &&
> +       test_must_fail git rebase --onto HEAD^^ HEAD^ HEAD^0 >actual_output &&
>         git ls-files -s submodule >actual &&
>         (
>                 cd submodule &&
> @@ -112,7 +112,9 @@ test_expect_success 'rebasing submodule that should conflict' '
>                 echo "160000 $(git rev-parse HEAD^^) 2  submodule" &&
>                 echo "160000 $(git rev-parse HEAD) 3    submodule"
>         ) >expect &&
> -       test_cmp expect actual
> +       test_cmp expect actual &&
> +       sub_expect="go to submodule (submodule), and merge commit $(git -C submodule rev-parse --short HEAD^^)" &&
> +       grep "$sub_expect" actual_output
>  '
>
>  test_done
>
> base-commit: ab336e8f1c8009c8b1aab8deb592148e69217085
> --
> 2.37.0.rc0.161.g10f37bed90-goog

Despite my many nitpicks and whatnot, it looks like your change will
make things nicer for the user, and I think your patch is coming along
nicely.  There are some things to fix up, but the overall direction
seems good.
