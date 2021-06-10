Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	GAPPY_SUBJECT,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F35E0C48BDF
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 20:47:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB7A061374
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 20:47:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbhFJUtQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Jun 2021 16:49:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbhFJUtO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jun 2021 16:49:14 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D4B1C061574
        for <git@vger.kernel.org>; Thu, 10 Jun 2021 13:47:17 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id r16so3197000oiw.3
        for <git@vger.kernel.org>; Thu, 10 Jun 2021 13:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hnPjuexJWezz6wH+SyUTUSaj173KtTokN7xOraOgOmE=;
        b=kOOG9z8Okt7SrrR+/ykVob6LDtDQZHiB7zL0AzUYwjRoCpMdfIhg6AJzcRDZdzHjF7
         9Dlw37C2zGXNA7/TLDGvR2gngPPD+RbLoge9toknkwAtEqqbYHAKKQleDwI1GcnXt59d
         91Q0qVLB+OYpocyJ6diwTKoJLCd8bBK1eGvFXDBqpvqcwHXHz0idEeMu/DbcEzSKpSEF
         OmvMOssHTqSaECV+XHlVmLNUDbvu8SWs160Spdo2dtiNpTRovCqzwDmOH+oLGKc+jsMg
         PL3g4b6QRRPdJnzfFfh4XuuZkfGDtirj/KWKhAuieaiADoy0xV0Zv+WSFEyBdb0kQ0aI
         /XSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hnPjuexJWezz6wH+SyUTUSaj173KtTokN7xOraOgOmE=;
        b=F5/bOTfz+Z42BJ/+q/tMqkVIaAHjRD2HuxLUTbeANCT+3dfaVDFDk+9d0n83USVfL8
         2qe2VoPh02GwPaGT8u0h2zez/1nCjNODWCBNguEf+YM2+ZVgwgmxyMfsQ5yfBNspVMd/
         9SFKkYo6MPO6KH7nn0WPuAxb7whZIWLT8q0KCOPZihpwxf9N881WtGJw4oE11SdCIlUM
         Fp4oeQPUHxDi282eL//PU8ZXkfTgecjeMeq6Gbdo6vXiMYfsmIpmRlARh5ILuUh9WAGt
         uBC3839esVJrxmToZOc/WxrBK2mx0+1JZSiXq5UAZkYC/a235qKlGVTX9OMoiz9uv+zb
         yVVg==
X-Gm-Message-State: AOAM531IhEf2chpWdiJPTAFHuxgS6WkdqcAlZ4L38/UOWETlJAdqXaSd
        oD9iqeMruC0dcATdIsWlQA7zs7i7Y9mZKATV4gE=
X-Google-Smtp-Source: ABdhPJxSfGaS92U5vtMe4k6nY4JxUju6JvNHjIx9Om8pWMBGKMauY3/PrsrO9FKRZ/Wrpx9ik6y9Iq8ePRzSe9Gp35I=
X-Received: by 2002:a05:6808:13d5:: with SMTP id d21mr231065oiw.31.1623358035737;
 Thu, 10 Jun 2021 13:47:15 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1622580781.git.jonathantanmy@google.com>
 <cover.1623345496.git.jonathantanmy@google.com> <255d1122569dabc4654f7521698744bcc0f13a42.1623345496.git.jonathantanmy@google.com>
In-Reply-To: <255d1122569dabc4654f7521698744bcc0f13a42.1623345496.git.jonathantanmy@google.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 10 Jun 2021 13:47:04 -0700
Message-ID: <CABPp-BGaet8LAJMj_nGDUShPrAw0tq0U=J-Cw1nxRn5v53pgjg@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] repository: move global r_f_p_c to repo struct
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 10, 2021 at 10:35 AM Jonathan Tan <jonathantanmy@google.com> wrote:
>
> Move repository_format_partial_clone, which is currently a global
> variable, into struct repository. (Full support for per-repository
> partial clone config will be done in a subsequent commit - this is split
> into its own commit because of the extent of the changes needed.)
>
> The new repo-specific variable cannot be set in
> check_repository_format_gently() (as is currently), because that
> function does not know which repo it is operating on (or even whether
> the value is important); therefore this responsibility is delegated to
> the outermost caller that knows. Of all the outermost callers that know
> (found by looking at all functions that call clear_repository_format()),
> I looked at those that either read from the main Git directory or write
> into a struct repository. These callers have been modified accordingly
> (write to the_repository in the former case and write to the given
> struct repository in the latter case).
>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
>  promisor-remote.c | 13 +++----------
>  promisor-remote.h |  6 ------
>  repository.c      |  3 +++
>  repository.h      |  3 +++
>  setup.c           | 16 +++++++++++-----
>  5 files changed, 20 insertions(+), 21 deletions(-)
>
> diff --git a/promisor-remote.c b/promisor-remote.c
> index da3f2ca261..d24081dc21 100644
> --- a/promisor-remote.c
> +++ b/promisor-remote.c
> @@ -5,13 +5,6 @@
>  #include "transport.h"
>  #include "strvec.h"
>
> -static char *repository_format_partial_clone;
> -
> -void set_repository_format_partial_clone(char *partial_clone)
> -{
> -       repository_format_partial_clone = xstrdup_or_null(partial_clone);
> -}
> -
>  static int fetch_objects(const char *remote_name,
>                          const struct object_id *oids,
>                          int oid_nr)
> @@ -145,15 +138,15 @@ static void promisor_remote_init(void)
>
>         git_config(promisor_remote_config, NULL);
>
> -       if (repository_format_partial_clone) {
> +       if (the_repository->repository_format_partial_clone) {
>                 struct promisor_remote *o, *previous;
>
> -               o = promisor_remote_lookup(repository_format_partial_clone,
> +               o = promisor_remote_lookup(the_repository->repository_format_partial_clone,
>                                            &previous);
>                 if (o)
>                         promisor_remote_move_to_tail(o, previous);
>                 else
> -                       promisor_remote_new(repository_format_partial_clone);
> +                       promisor_remote_new(the_repository->repository_format_partial_clone);
>         }
>  }
>
> diff --git a/promisor-remote.h b/promisor-remote.h
> index c7a14063c5..687210ab87 100644
> --- a/promisor-remote.h
> +++ b/promisor-remote.h
> @@ -32,10 +32,4 @@ int promisor_remote_get_direct(struct repository *repo,
>                                const struct object_id *oids,
>                                int oid_nr);
>
> -/*
> - * This should be used only once from setup.c to set the value we got
> - * from the extensions.partialclone config option.
> - */
> -void set_repository_format_partial_clone(char *partial_clone);
> -
>  #endif /* PROMISOR_REMOTE_H */
> diff --git a/repository.c b/repository.c
> index 448cd557d4..4878c297d9 100644
> --- a/repository.c
> +++ b/repository.c
> @@ -172,6 +172,9 @@ int repo_init(struct repository *repo,
>
>         repo_set_hash_algo(repo, format.hash_algo);
>
> +       repo->repository_format_partial_clone = format.partial_clone;
> +       format.partial_clone = NULL;

This was surprising to me, and I tried to dig around to find out why
you set it to NULL.  AFAICT, you're trying to avoid the need to do a
xstrdup(), so you take over ownership in the first line and set to
NULL in the second to avoid a double-free.  So, it makes sense, but
given how surprising it was and it took me a while to figure it out,
perhaps it's worth adding a comment that this is what you're doing
here?  The same comment would also apply in a few other places in this
patch...

> +
>         if (worktree)
>                 repo_set_worktree(repo, worktree);
>
> diff --git a/repository.h b/repository.h
> index a45f7520fd..6fb16ed336 100644
> --- a/repository.h
> +++ b/repository.h
> @@ -139,6 +139,9 @@ struct repository {
>         /* True if commit-graph has been disabled within this process. */
>         int commit_graph_disabled;
>
> +       /* Configurations related to promisor remotes. */
> +       char *repository_format_partial_clone;
> +
>         /* Configurations */
>
>         /* Indicate if a repository has a different 'commondir' from 'gitdir' */
> diff --git a/setup.c b/setup.c
> index 59e2facd9d..fbedfe8e03 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -468,8 +468,6 @@ static enum extension_result handle_extension_v0(const char *var,
>                         data->precious_objects = git_config_bool(var, value);
>                         return EXTENSION_OK;
>                 } else if (!strcmp(ext, "partialclone")) {
> -                       if (!value)
> -                               return config_error_nonbool(var);
>                         data->partial_clone = xstrdup(value);
>                         return EXTENSION_OK;
>                 } else if (!strcmp(ext, "worktreeconfig")) {
> @@ -566,7 +564,6 @@ static int check_repository_format_gently(const char *gitdir, struct repository_
>         }
>
>         repository_format_precious_objects = candidate->precious_objects;
> -       set_repository_format_partial_clone(candidate->partial_clone);
>         repository_format_worktree_config = candidate->worktree_config;
>         string_list_clear(&candidate->unknown_extensions, 0);
>         string_list_clear(&candidate->v1_only_extensions, 0);
> @@ -1193,6 +1190,10 @@ int discover_git_directory(struct strbuf *commondir,
>                 return -1;
>         }
>
> +       the_repository->repository_format_partial_clone =
> +               candidate.partial_clone;
> +       candidate.partial_clone = NULL;
> +

comment would also be nice here

>         clear_repository_format(&candidate);
>         return 0;
>  }
> @@ -1300,8 +1301,12 @@ const char *setup_git_directory_gently(int *nongit_ok)
>                                 gitdir = DEFAULT_GIT_DIR_ENVIRONMENT;
>                         setup_git_env(gitdir);
>                 }
> -               if (startup_info->have_repository)
> +               if (startup_info->have_repository) {
>                         repo_set_hash_algo(the_repository, repo_fmt.hash_algo);
> +                       the_repository->repository_format_partial_clone =
> +                               repo_fmt.partial_clone;
> +                       repo_fmt.partial_clone = NULL;

and here

> +               }
>         }
>         /*
>          * Since precompose_string_if_needed() needs to look at
> @@ -1319,7 +1324,6 @@ const char *setup_git_directory_gently(int *nongit_ok)
>                 setenv(GIT_PREFIX_ENVIRONMENT, "", 1);
>         }
>
> -

why the stray whitespace change?

>         strbuf_release(&dir);
>         strbuf_release(&gitdir);
>         clear_repository_format(&repo_fmt);
> @@ -1386,6 +1390,8 @@ void check_repository_format(struct repository_format *fmt)
>         check_repository_format_gently(get_git_dir(), fmt, NULL);
>         startup_info->have_repository = 1;
>         repo_set_hash_algo(the_repository, fmt->hash_algo);
> +       the_repository->repository_format_partial_clone =
> +               xstrdup_or_null(fmt->partial_clone);
>         clear_repository_format(&repo_fmt);
>  }
>
> --
> 2.32.0.rc1.229.g3e70b5a671-goog

Other than the minor nits above, this looks good.
