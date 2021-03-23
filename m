Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E16BC433C1
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 20:53:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3721E60C3D
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 20:53:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233354AbhCWUxM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Mar 2021 16:53:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233355AbhCWUwt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Mar 2021 16:52:49 -0400
Received: from mail-vk1-xa33.google.com (mail-vk1-xa33.google.com [IPv6:2607:f8b0:4864:20::a33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F45CC061574
        for <git@vger.kernel.org>; Tue, 23 Mar 2021 13:52:45 -0700 (PDT)
Received: by mail-vk1-xa33.google.com with SMTP id 11so4962566vkx.6
        for <git@vger.kernel.org>; Tue, 23 Mar 2021 13:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gTM5WXXmd6ZTnkdbRmmsJ8LXCjhiXSVX7UQGsOx521k=;
        b=LNrnxaaNFghyATOYP//Bunqgp7iS5mwXDqYFr4DZzmiOjakORG1DwmykPqCRAZ+jmQ
         VViGwktIlOMO/bVxYjc34VlG2SflsYWj8w9EaLh0ROcidhByO0vOpVEUdm/5kaEB6HXS
         /AKjC2LKN8Hq9fzmrmt6RZZd+348o++iY6gtqGFnopXiCaaxXbzExsbljFORLrni3LEi
         GlpCpKIf7rm/BWxAWm4Qupwal9S7lH9S9PQgx86gQTFUN0WGvqGJigv2Jzr0dKfB0abz
         XLGLaEaJdS5bKXwxI9nWtvJEVVMh3P6q44WzlXjQWxTPhyKjRI3lWYXVTEUZVkiNuV/z
         Hogg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gTM5WXXmd6ZTnkdbRmmsJ8LXCjhiXSVX7UQGsOx521k=;
        b=nlC/kiEGl91fAubNPI0nqrjghmEYLOhLe1JRce2JbdALLsiuf8iTS2AaI9kK81NyHB
         t2T+6o5LV6Wn32wainmRkPoaJqD3CfLE0gP6Uzq46LTW+Ze7uvoQuVfy8NyFx9/zN/Db
         T39w7veRlENxb/68giFe3mKqZaGJvYGFxS5YVjp1iC3/eWtGbblIJ7gvfFqLgzkGlO9A
         kaqd4KpbEtKunFfpKozBCLrvOKwFfEdPbgb1ycA8+PeLGyRko7jQHoE/23lBw1zJAhFw
         EB5IdaW08MD5XNkgnvbdxFG88CGn0sGsX/sILy2AhDJAjJ7WFcRBTEPx6WdHvz0UabX8
         Os9g==
X-Gm-Message-State: AOAM530llKE7jBY75yS0qHtBZv4UfI+fCxBFTjVQBiH/nG/fRn792Rpv
        jDV5RMJqKYBZIleqbasNZU4bOZB4UKCGULdA7mo=
X-Google-Smtp-Source: ABdhPJyRUIUNT1tosNr3KCmf6ihDxPALaok+5eAoNE+CJprKiMpkFl1R+uycU1INB4eKD/ZyV8NCmBmUTEk3iv78Zlw=
X-Received: by 2002:a1f:aa43:: with SMTP id t64mr5511213vke.22.1616532762395;
 Tue, 23 Mar 2021 13:52:42 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqk0px3dfu.fsf@gitster.g>
In-Reply-To: <xmqqk0px3dfu.fsf@gitster.g>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Tue, 23 Mar 2021 13:52:31 -0700
Message-ID: <CA+P7+xokjz-2nC5+F9HG0tBqS948uZcuq-1eY9uGuNyzbFGbZQ@mail.gmail.com>
Subject: Re: Pass or not to pass config environment down...
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Patrick Steinhardt <ps@pks.im>, Jeff King <peff@peff.net>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 23, 2021 at 11:58 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> I was grepping around and found this piece of code today:
>
>         static void prepare_submodule_repo_env_no_git_dir(struct strvec *out)
>         {
>                 const char * const *var;
>
>                 for (var = local_repo_env; *var; var++) {
>                         if (strcmp(*var, CONFIG_DATA_ENVIRONMENT))
>                                 strvec_push(out, *var);
>                 }
>         }
>
> which tries to "unsetenv" the environment variables that pertain to
> the current repository listed in loocal_repo_env[], but makes
> exception for GIT_CONFIG_PARAMETERS.

Right. We need to unset some parameters, but not everything...

>
> It originally came from 14111fc4 (git: submodule honor -c
> credential.* from command line, 2016-02-29) and later simplified by
> 89044baa (submodule: stop sanitizing config options, 2016-05-04).
>
> Now after d8d77153 (config: allow specifying config entries via
> envvar pairs, 2021-01-12), we have yet another way to pass a set of
> custom one-shot configuration via the environment variable, using
> GIT_CONFIG_COUNT (which is in local_repo_env[] and will be removed
> from the environment by this helper function), GIT_CONFIG_KEY_$n and
> GIT_CONFIG_VALUE_$n (which are unbound set and naturally not in
> local_repo_env[]).  Leaving the latter two exported will not hurt if
> we do intend to hide the custom configuration from the subprocess by
> unsetting GIT_CONFIG_COUNT, but should we be doing so?
>

I think it's a difficult question because if I recall, there was some
question/concern about what values need to stay for the submodule vs
which ones do not..?

> There are many run_command() users that just pass local_repo_env[]
> to the child.env when running a subprocess.  Given that the code
> that works in a submodule, which presumably is THE primary target
> of the "we do not want to pass environment variables that pertain to
> the current repository but not to the repository the child process
> works in" consideration that the local_repo_env[] is about, does *not*
> want the GIT_CONFIG_PARAMETERS cleansed, I have to wonder if the
> environment variables (the original GIT_CONFIG_PARAMETERS as well as
> Patrick's GIT_CONFIG_{COUNT,KEY_$n,VALUE_$n}) should be in that
> local_repo_env[] array in the first place.  If we remove them, the
> above helper function can just go away and be replaced with the
> usual child.env = local_repo_env assignment like everybody else.
>

I think that makes a reasonable amount of sense. So if I understand
right, this change makes it so that CONFIG_DATA_ENVIRONMENT and
CONFIG_COUNT_ENVIRONMENT will no longer be forwarded? I guess I am a
bit confused about the current status vs what we want here.

> Comments?
>
>  environment.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git c/environment.c w/environment.c
> index 2f27008424..6dcee6a9c5 100644
> --- c/environment.c
> +++ w/environment.c
> @@ -116,8 +116,6 @@ static char *super_prefix;
>  const char * const local_repo_env[] = {
>         ALTERNATE_DB_ENVIRONMENT,
>         CONFIG_ENVIRONMENT,
> -       CONFIG_DATA_ENVIRONMENT,
> -       CONFIG_COUNT_ENVIRONMENT,
>         DB_ENVIRONMENT,
>         GIT_DIR_ENVIRONMENT,
>         GIT_WORK_TREE_ENVIRONMENT,
