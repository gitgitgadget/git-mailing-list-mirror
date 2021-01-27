Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 670FDC433E0
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 18:04:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 228BF64DAB
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 18:04:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344068AbhA0SE0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Jan 2021 13:04:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344298AbhA0SEA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jan 2021 13:04:00 -0500
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89D62C061573
        for <git@vger.kernel.org>; Wed, 27 Jan 2021 10:03:19 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id 63so2592719oty.0
        for <git@vger.kernel.org>; Wed, 27 Jan 2021 10:03:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=STw5dP2ydurXErVmAy6WqhNiiN9mCb8g7FUx29EpDEA=;
        b=icyeZN9eJqt40gIRFQg5umZyf+gBlihcCbIinLf35uHkfLcTES9idYxGeXnloBYVgy
         tP//qrZISm7Tfk5HI2Nik7uITCFQp/0o6zwvoempYFDen9lXLrnwCtGaosLHoRmSUpnP
         9mJ5I6WTSKgPK7/Fpz3jNiHhrigYlEDclusGLmKrQo694eB29VvvqpRajVX/PWAYD3Fk
         A2Pd40UqMUml0P9URO7ywoRzH6hute+/UtHf92VjIq/czwM+lbHJtoiy/Xjks5G9d5D/
         uxM24DFPWtpxX0UXrJqIZ2W5DXlqkIHRYhfjQ1wQl9DQ/14QKHGmKPWSDEf50VYM5x0p
         94mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=STw5dP2ydurXErVmAy6WqhNiiN9mCb8g7FUx29EpDEA=;
        b=sjuebc88/aBzBx0b2erIZYZ2G4ujDyyfVqTJioG2xaXVmAlqJ6pDvbKzVLxiTRyWZl
         iqXx5cK3YXCL13LExcG4wZLvx0EaXXa+vWRZe1ZVeaB+luGSg4nyrImb5T6dRrHPzTVP
         8jxY2QljNjSBXZ82SGuu4sytbjuZrLvShJui+dVie88in7mynobg6xJnH+IFsnS6Q1IW
         wd+wC86mqHZZnsTNQKeUbBbO+9IhqpfYWkLcurTMHCvYzvReWQkjbyZ55iq5Z6fjCn63
         L0j+4egaRPGKBVB/mu5z7LcYrsX6EWuT4NZwkuAq+91b6yc7IQg8khSZ6izEWCCFb9FF
         8YQA==
X-Gm-Message-State: AOAM533nLvQvOxrtOXg2dLUuPsT6kWV9ZvOV6+7nAx8v7IpeP94PBRRm
        a0C84JtFf4My7N1IOG/hITjd+3bBkmp1jyPVBNo=
X-Google-Smtp-Source: ABdhPJx/PC3QwaxeB1ghhQL+OPFEcPB3HoQj6iXxz1ikJtbyBKraRg5OBPNvkOio6+Y1w3ZkbBYM90N3LGM/SHG9sSA=
X-Received: by 2002:a05:6830:402f:: with SMTP id i15mr8527248ots.345.1611770598165;
 Wed, 27 Jan 2021 10:03:18 -0800 (PST)
MIME-Version: 1.0
References: <pull.847.git.1611596533.gitgitgadget@gmail.com> <d15f67c40ea10eff8d83df72a86b8677607f4ee3.1611596534.git.gitgitgadget@gmail.com>
In-Reply-To: <d15f67c40ea10eff8d83df72a86b8677607f4ee3.1611596534.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 27 Jan 2021 10:03:07 -0800
Message-ID: <CABPp-BFEJE82k4VgkR=Jf7V7sZxZzo2pHMfAGshhi9_vV6iK0w@mail.gmail.com>
Subject: Re: [PATCH 13/27] sparse-index: create extension for compatibility
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 25, 2021 at 9:42 AM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Derrick Stolee <dstolee@microsoft.com>
>
> Previously, we enabled the sparse index format only using
> GIT_TEST_SPARSE_INDEX=1. This is not a feasible direction for users to
> actually select this mode. Further, sparse directory entries are not
> understood by the index formats as advertised.
>
> We _could_ add a new index version that explicitly adds these
> capabilities, but there are nuances to index formats 2, 3, and 4 that
> are still valuable to select as options. For now, create a repo
> extension, "extensions.sparseIndex", that specifies that the tool
> reading this repository must understand sparse directory entries.
>
> This change only encodes the extension and enables it when
> GIT_TEST_SPARSE_INDEX=1. Later, we will add a more user-friendly CLI
> mechanism.

One other interesting thing to note is that last I checked, jgit
doesn't support index format v4, which makes us unable to use it.
Making a v5 would force jgit to support all previous index formats in
order to support your new feature.

However, the jgit thing is going to make it hard for me to find other
users willing to test out this feature at $DAYJOB.  But I don't think
there's anyway around that; you need to change the index format.  And
you at least have jrnieder cc'ed.  :-)

>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  Documentation/config/extensions.txt |  7 ++++++
>  cache.h                             |  1 +
>  repo-settings.c                     |  7 ++++++
>  repository.h                        |  3 ++-
>  setup.c                             |  3 +++
>  sparse-index.c                      | 38 +++++++++++++++++++++++++----
>  6 files changed, 53 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/config/extensions.txt b/Documentation/config/extensions.txt
> index 4e23d73cdca..5c86b364873 100644
> --- a/Documentation/config/extensions.txt
> +++ b/Documentation/config/extensions.txt
> @@ -6,3 +6,10 @@ extensions.objectFormat::
>  Note that this setting should only be set by linkgit:git-init[1] or
>  linkgit:git-clone[1].  Trying to change it after initialization will not
>  work and will produce hard-to-diagnose issues.
> +
> +extensions.sparseIndex::
> +       When combined with `core.sparseCheckout=true` and
> +       `core.sparseCheckoutCone=true`, the index may contain entries
> +       corresponding to directories outside of the sparse-checkout
> +       definition. Versions of Git that do not understand this extension
> +       do not expect directory entries in the index.

Perhaps to make this slightly more explicit ("corresponding to" can be
fuzzy and be read to assume you are talking about file entries
underneath a directory rather than directory entries, so add an extra
phrase to rule that out):

...the index may contain entries corresponding to directories outside
of the sparse-checkout definition in lieu of containing each path
under such directories...

> diff --git a/cache.h b/cache.h
> index b05341cc687..dcf089b7006 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -1054,6 +1054,7 @@ struct repository_format {
>         int worktree_config;
>         int is_bare;
>         int hash_algo;
> +       int sparse_index;
>         char *work_tree;
>         struct string_list unknown_extensions;
>         struct string_list v1_only_extensions;
> diff --git a/repo-settings.c b/repo-settings.c
> index d63569e4041..9677d50f923 100644
> --- a/repo-settings.c
> +++ b/repo-settings.c
> @@ -85,4 +85,11 @@ void prepare_repo_settings(struct repository *r)
>          * removed.
>          */
>         r->settings.command_requires_full_index = 1;
> +
> +       /*
> +        * Initialize this as off.
> +        */
> +       r->settings.sparse_index = 0;
> +       if (!repo_config_get_bool(r, "extensions.sparseindex", &value) && value)
> +               r->settings.sparse_index = 1;
>  }
> diff --git a/repository.h b/repository.h
> index e06a2301569..a45f7520fd9 100644
> --- a/repository.h
> +++ b/repository.h
> @@ -42,7 +42,8 @@ struct repo_settings {
>
>         int core_multi_pack_index;
>
> -       unsigned command_requires_full_index:1;
> +       unsigned command_requires_full_index:1,
> +                sparse_index:1;
>  };
>
>  struct repository {
> diff --git a/setup.c b/setup.c
> index c04cd25a30d..cd839456461 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -500,6 +500,9 @@ static enum extension_result handle_extension(const char *var,
>                         return error("invalid value for 'extensions.objectformat'");
>                 data->hash_algo = format;
>                 return EXTENSION_OK;
> +       } else if (!strcmp(ext, "sparseindex")) {
> +               data->sparse_index = 1;
> +               return EXTENSION_OK;
>         }
>         return EXTENSION_UNKNOWN;
>  }
> diff --git a/sparse-index.c b/sparse-index.c
> index 5dd0b835b9d..71544095267 100644
> --- a/sparse-index.c
> +++ b/sparse-index.c
> @@ -102,19 +102,47 @@ static int convert_to_sparse_rec(struct index_state *istate,
>         return num_converted - start_converted;
>  }
>
> +static int enable_sparse_index(struct repository *repo)
> +{
> +       const char *config_path = repo_git_path(repo, "config.worktree");
> +
> +       if (upgrade_repository_format(1) < 0) {
> +               warning(_("unable to upgrade repository format to enable sparse-index"));
> +               return -1;
> +       }
> +       git_config_set_in_file_gently(config_path,
> +                                     "extensions.sparseIndex",
> +                                     "true");
> +
> +       prepare_repo_settings(repo);
> +       repo->settings.sparse_index = 1;
> +       return 0;
> +}
> +
>  int convert_to_sparse(struct index_state *istate)
>  {
>         if (istate->split_index || istate->sparse_index ||
>             !core_apply_sparse_checkout || !core_sparse_checkout_cone)
>                 return 0;
>
> +       if (!istate->repo)
> +               istate->repo = the_repository;
> +
> +       /*
> +        * The GIT_TEST_SPARSE_INDEX environment variable triggers the
> +        * extensions.sparseIndex config variable to be on.
> +        */
> +       if (git_env_bool("GIT_TEST_SPARSE_INDEX", 0)) {
> +               int err = enable_sparse_index(istate->repo);
> +               if (err < 0)
> +                       return err;
> +       }
> +
>         /*
> -        * For now, only create a sparse index with the
> -        * GIT_TEST_SPARSE_INDEX environment variable. We will relax
> -        * this once we have a proper way to opt-in (and later still,
> -        * opt-out).
> +        * Only convert to sparse if extensions.sparseIndex is set.
>          */
> -       if (!git_env_bool("GIT_TEST_SPARSE_INDEX", 0))
> +       prepare_repo_settings(istate->repo);
> +       if (!istate->repo->settings.sparse_index)
>                 return 0;
>
>         if (!istate->sparse_checkout_patterns) {
> --
> gitgitgadget
