Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AD79C433FE
	for <git@archiver.kernel.org>; Tue, 23 Nov 2021 07:41:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234213AbhKWHo6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Nov 2021 02:44:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234063AbhKWHo6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Nov 2021 02:44:58 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F4C4C061574
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 23:41:50 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id g14so88189914edb.8
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 23:41:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bEh3GwnGtCYJZq9FYguQolBdXd/BibmrIS5gTbZgMtM=;
        b=Qj/tO2WVnGqDUIhUlKv9PC6v6YKGtBj9bCWjpSpBj6bcamk4ILGB5XBReta/FcZf2w
         x0bGTLgO/4OVgpojCdWsssTMiUKsK7saS4Xbk/E1704pqaHK8lsJ00ARuSZ+Csw6zN/x
         w6AHnh2ClPbWZNW7n3sRw87lPNmGpyrys9D+kqhHDld+65EnSsPK4ZxBPCRQpy/r16Dd
         CJ3LblSSDQm2D2SHYlDCd4B94alZ8km7NNtUP0Je20bo1OChrfR+7VAjJW3qKJ+qJ0le
         RKfMvqciqNKIHh2VMEMveE+q8mq8vexEvb8Z8SzDqB+zmwyH81u8naOuNZVO8GxJSGKu
         4EcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bEh3GwnGtCYJZq9FYguQolBdXd/BibmrIS5gTbZgMtM=;
        b=eAO9SpokKEgf9DW1HlHRKHudFbptAoyLoayC/Tbz+/sKMaeclDgAqInNhah0D4Pggb
         U/M2HbSLQyZNQCRCKbKCuEge9Uy7FyqyUGj8GPyhlV56+AHzr/vn8ip135W8UYy7waTk
         tBCQVP3gB88n1u8v2TcXLxePhGxLLu5T3+CVgR+yujDiER+S5xNIw7Gz2cU7tyga/wPE
         F/nwCZ8UxbWjBVDzmYw7UkFshptfFHwCHpxe6xEfMGjfLRZjKVrQZCzOmS0m0slXaoCQ
         NB5xH1YBQG/0v4U1oSjRsR2tA8smlxSjk9KFj3C84iEchBz6mjFH5wQpvNkEXH0xLzPx
         ObHw==
X-Gm-Message-State: AOAM532BtoePV/8LQXwVCHAlrA0/WYhAZ9U9K7jYzPiIUekVoUK5erCJ
        3dQNc+V4f/+Vu4jQh7a+kCn+svzNRMqt7dQwLvQ=
X-Google-Smtp-Source: ABdhPJxgrk71ix/2J7f80XRmJtEhdhYOrYkosAirxTATCBtYbvnGaxwpJs8Mf6gqyb0PEav0IBe7Xi5GgFTAFiRxEpg=
X-Received: by 2002:a05:6402:134a:: with SMTP id y10mr5837459edw.241.1637653308717;
 Mon, 22 Nov 2021 23:41:48 -0800 (PST)
MIME-Version: 1.0
References: <pull.1050.v3.git.1635802069.gitgitgadget@gmail.com>
 <pull.1050.v4.git.1637620958.gitgitgadget@gmail.com> <81e208cf454b61c761fa66e4f43a464ed439ba59.1637620958.git.gitgitgadget@gmail.com>
In-Reply-To: <81e208cf454b61c761fa66e4f43a464ed439ba59.1637620958.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 22 Nov 2021 23:41:37 -0800
Message-ID: <CABPp-BEM+FpdQ4yJxDcqvdz3LNmFV+5CBMAQdAnEfc0ytbZ-dA@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] sparse index: enable only for git repos
To:     Lessley Dennington via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Lessley Dennington <lessleydennington@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 22, 2021 at 2:42 PM Lessley Dennington via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Lessley Dennington <lessleydennington@gmail.com>
>
> Check whether git dir exists before adding any repo settings. If it
> does not exist, BUG with the message that one cannot add settings for an
> uninitialized repository. If it does exist, proceed with adding repo
> settings.
>
> Additionally, ensure the above BUG is not triggered when users pass the -h
> flag by adding a check for the repository to the checkout and pack-objects
> builtins.

Why only checkout and pack-objects?  Why don't the -h flags to all of
the following need it as well?:

$ git grep -l prepare_repo_settings | grep builtin/
builtin/add.c
builtin/blame.c
builtin/checkout.c
builtin/commit.c
builtin/diff.c
builtin/fetch.c
builtin/gc.c
builtin/merge.c
builtin/pack-objects.c
builtin/rebase.c
builtin/reset.c
builtin/revert.c
builtin/sparse-checkout.c
builtin/update-index.c

If none of these need it, was it because they put
prepare_repo_settings() calls after some other basic checks had been
done so more do not have to be added?  If so, is there a similar place
in checkout and pack-objects where their calls to
prepare_repo_settings() can be moved?  (Looking ahead, it appears you
moved some code in patch 2 to do something like this.  Are the similar
moves that could be done here?)

> Finally, ensure the above BUG is not triggered for commit-graph by
> returning early if the git directory does not exist.

If commit-graph needs a special case to avoid triggering the BUG,
wouldn't several of these need it too?:

$ git grep -l prepare_repo_settings | grep -v builtin/
commit-graph.c
fetch-negotiator.c
merge-recursive.c
midx.c
read-cache.c
repo-settings.c
repository.c
repository.h
sparse-index.c
t/helper/test-read-cache.c
t/helper/test-read-graph.c
unpack-trees.c

or are their calls to prepare_repo_settings() only done after gitdir
setup?  If the latter, perhaps the commit-graph function calls could
be moved after gitdir setup too to avoid the need to do extra checks
in it?

> Signed-off-by: Lessley Dennington <lessleydennington@gmail.com>
> ---
>  builtin/checkout.c     | 6 ++++--
>  builtin/pack-objects.c | 9 ++++++---
>  commit-graph.c         | 5 ++++-
>  repo-settings.c        | 3 +++
>  4 files changed, 17 insertions(+), 6 deletions(-)
>
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index 8c69dcdf72a..31632b07888 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -1588,8 +1588,10 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
>
>         git_config(git_checkout_config, opts);
>
> -       prepare_repo_settings(the_repository);
> -       the_repository->settings.command_requires_full_index = 0;
> +       if (startup_info->have_repository) {
> +               prepare_repo_settings(the_repository);
> +               the_repository->settings.command_requires_full_index = 0;
> +       }
>
>         opts->track = BRANCH_TRACK_UNSPECIFIED;
>
> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index 1a3dd445f83..45dc2258dc7 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -3976,9 +3976,12 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
>         read_replace_refs = 0;
>
>         sparse = git_env_bool("GIT_TEST_PACK_SPARSE", -1);
> -       prepare_repo_settings(the_repository);
> -       if (sparse < 0)
> -               sparse = the_repository->settings.pack_use_sparse;
> +
> +       if (startup_info->have_repository) {
> +               prepare_repo_settings(the_repository);
> +               if (sparse < 0)
> +                       sparse = the_repository->settings.pack_use_sparse;
> +       }
>
>         reset_pack_idx_option(&pack_idx_opts);
>         git_config(git_pack_config, NULL);
> diff --git a/commit-graph.c b/commit-graph.c
> index 2706683acfe..265c010122e 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -632,10 +632,13 @@ static int prepare_commit_graph(struct repository *r)
>         struct object_directory *odb;
>
>         /*
> +        * Early return if there is no git dir or if the commit graph is
> +        * disabled.
> +        *
>          * This must come before the "already attempted?" check below, because
>          * we want to disable even an already-loaded graph file.
>          */
> -       if (r->commit_graph_disabled)
> +       if (!r->gitdir || r->commit_graph_disabled)
>                 return 0;
>
>         if (r->objects->commit_graph_attempted)
> diff --git a/repo-settings.c b/repo-settings.c
> index b93e91a212e..00ca5571a1a 100644
> --- a/repo-settings.c
> +++ b/repo-settings.c
> @@ -17,6 +17,9 @@ void prepare_repo_settings(struct repository *r)
>         char *strval;
>         int manyfiles;
>
> +       if (!r->gitdir)
> +               BUG("Cannot add settings for uninitialized repository");
> +
>         if (r->settings.initialized++)
>                 return;

I'm not what the BUG() is trying to help us catch, but I'm worried
that there are many additional places that now need workarounds to
avoid triggering bugs.
