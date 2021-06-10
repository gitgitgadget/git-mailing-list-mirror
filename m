Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C982C48BD1
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 21:22:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E15D661362
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 21:22:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbhFJVY0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Jun 2021 17:24:26 -0400
Received: from mail-oo1-f46.google.com ([209.85.161.46]:43537 "EHLO
        mail-oo1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbhFJVY0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jun 2021 17:24:26 -0400
Received: by mail-oo1-f46.google.com with SMTP id e27-20020a056820061bb029020da48eed5cso217999oow.10
        for <git@vger.kernel.org>; Thu, 10 Jun 2021 14:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D+iLBYOg6OXbiADBR+AnUcmr06/QUzFmIKjSX1vw6Lc=;
        b=LryVxXHQ4ehQiQZNwC6ShE/7dxSGZeKH3ocgIXfVjdOMl63PC4H490rRJRvJbMz8QY
         6dPavbwovfZtdc+XK4JyaIiHpm2WD4SR1UXA4rMb+91YF7GdXTjgA041LzG+3GyEkgY0
         Ew4KqAN0SqbceEWQBxTYtFKnNWYVnqC/jiv5jFMsKzKMciQSdvxpQDxiXkXCiTZ+aBkZ
         SKUwB+/NR6XCMHyqBQvTezHaV08BjazTv5fvU6gjfM01oLlFUZsc039PgKRdcsnz3kzH
         QOqnp1VVelamM0rGYexVU3Zfakp9BOi6/icv7xUyQ4F0Bg16/Sjojxt8T6MxoS6ronOB
         5v6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D+iLBYOg6OXbiADBR+AnUcmr06/QUzFmIKjSX1vw6Lc=;
        b=J5UH8U8LI6LuUVcamyigEsXRv/BB522XeZ9RVBkJF0fjkbSv06IhneDXrqVvcLW31+
         pLJiLjEOiXOam/qPAOkz7cHzNkOuZKgyUPKv9tXN0ecI5EelmUjc79kPp+qA7ADL6EKn
         4Z7rsfqns5mMvlqBGPDAqJYPmg0Ta7Le2ctnqynp0k413RTsnBksckkIFzt8XBrfJP82
         kQvr/o6l5RqFkgH+6iBQ7giwyVoZRauD07nk2kHk6XSjzF3bOis6ca725MNX0Cpo00C6
         aTxEPZ+g5rVEEqzyyRiX92VFtj92eLpQcPXJAS1sY6ZGGGlxOvROl4HArUgipdZh9tKS
         p3yw==
X-Gm-Message-State: AOAM533sovuA9bCWjk69UYixZ90lLmfAs+szDqiZuOtoG+1lLuzUJVVD
        DmNs8ml2IvQijgycsgAHANt/X5sbSRPPtnjNuE4=
X-Google-Smtp-Source: ABdhPJzetAfUS0Py382pG/3YOnbcqm4T+kGjG4IBGbiqOIVX/USi7HGnBIYVLWxAASvVe/NVWNU4JUSLz4jdmzyslCQ=
X-Received: by 2002:a4a:b789:: with SMTP id a9mr430051oop.45.1623360089599;
 Thu, 10 Jun 2021 14:21:29 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1622580781.git.jonathantanmy@google.com>
 <cover.1623345496.git.jonathantanmy@google.com> <fd6907822cf4cb12023999a61682676de193bff9.1623345496.git.jonathantanmy@google.com>
In-Reply-To: <fd6907822cf4cb12023999a61682676de193bff9.1623345496.git.jonathantanmy@google.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 10 Jun 2021 14:21:18 -0700
Message-ID: <CABPp-BGgdQ02-gUwK1vPSBw8Fw_OCKZskd+5P7_4Bj0sYX++Gg@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] run-command: refactor subprocess env preparation
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
> submodule.c has functionality that prepares the environment for running
> a subprocess in a new repo. The lazy-fetching code (used in partial
> clones) will need this in a subsequent commit, so move it to a more
> central location.
>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
>  run-command.c | 12 ++++++++++++
>  run-command.h | 10 ++++++++++
>  submodule.c   | 18 ++----------------
>  3 files changed, 24 insertions(+), 16 deletions(-)
>
> diff --git a/run-command.c b/run-command.c
> index be6bc128cd..549a94a6a4 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -1892,3 +1892,15 @@ int run_auto_maintenance(int quiet)
>
>         return run_command(&maint);
>  }
> +
> +void prepare_other_repo_env(struct strvec *env_array, const char *new_git_dir)
> +{
> +       const char * const *var;
> +
> +       for (var = local_repo_env; *var; var++) {
> +               if (strcmp(*var, CONFIG_DATA_ENVIRONMENT) &&
> +                   strcmp(*var, CONFIG_COUNT_ENVIRONMENT))
> +                       strvec_push(env_array, *var);
> +       }
> +       strvec_pushf(env_array, "%s=%s", GIT_DIR_ENVIRONMENT, new_git_dir);
> +}
> diff --git a/run-command.h b/run-command.h
> index d08414a92e..92f1c00b11 100644
> --- a/run-command.h
> +++ b/run-command.h
> @@ -483,4 +483,14 @@ int run_processes_parallel_tr2(int n, get_next_task_fn, start_failure_fn,
>                                task_finished_fn, void *pp_cb,
>                                const char *tr2_category, const char *tr2_label);
>
> +/**
> + * Convenience function which prepares env_array for a command to be run in a
> + * new repo. This adds all GIT_* environment variables to env_array with the
> + * exception of GIT_CONFIG_PARAMETERS (which cause the corresponding
> + * environment variables to be unset in the subprocess) and adds an environment
> + * variable pointing to new_git_dir. See local_repo_env in cache.h for more
> + * information.

This comment is out-of-date as of your previous patch.  There's (at
least) one more variable that is also excluded.

> + */
> +void prepare_other_repo_env(struct strvec *env_array, const char *new_git_dir);
> +
>  #endif
> diff --git a/submodule.c b/submodule.c
> index f09031e397..8e611fe1db 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -484,28 +484,14 @@ static void print_submodule_diff_summary(struct repository *r, struct rev_info *
>         strbuf_release(&sb);
>  }
>
> -static void prepare_submodule_repo_env_no_git_dir(struct strvec *out)
> -{
> -       const char * const *var;
> -
> -       for (var = local_repo_env; *var; var++) {
> -               if (strcmp(*var, CONFIG_DATA_ENVIRONMENT) &&
> -                   strcmp(*var, CONFIG_COUNT_ENVIRONMENT))
> -                       strvec_push(out, *var);
> -       }
> -}
> -
>  void prepare_submodule_repo_env(struct strvec *out)
>  {
> -       prepare_submodule_repo_env_no_git_dir(out);
> -       strvec_pushf(out, "%s=%s", GIT_DIR_ENVIRONMENT,
> -                    DEFAULT_GIT_DIR_ENVIRONMENT);
> +       prepare_other_repo_env(out, DEFAULT_GIT_DIR_ENVIRONMENT);
>  }
>
>  static void prepare_submodule_repo_env_in_gitdir(struct strvec *out)
>  {
> -       prepare_submodule_repo_env_no_git_dir(out);
> -       strvec_pushf(out, "%s=.", GIT_DIR_ENVIRONMENT);
> +       prepare_other_repo_env(out, ".");
>  }
>
>  /*
> --
> 2.32.0.rc1.229.g3e70b5a671-goog
