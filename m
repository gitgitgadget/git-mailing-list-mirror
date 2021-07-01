Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EEE1C11F64
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 17:30:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3228161356
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 17:30:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232397AbhGARcv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jul 2021 13:32:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbhGARcu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jul 2021 13:32:50 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DD15C061762
        for <git@vger.kernel.org>; Thu,  1 Jul 2021 10:30:18 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id i24so9529425edx.4
        for <git@vger.kernel.org>; Thu, 01 Jul 2021 10:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=YCST9Bnc4NNcSVaVL/74TL0Jcx3MtcwNOfgUP8/uxGM=;
        b=FlT5rAIf6vB7PLBI7cxsNu7vl4lr4PrEqRr77Cz0GucSEJJa72e7yhYBniP0ZM0jTW
         WvgP/v+F26e14QfCoQEI9DlnDJ5geLuAuki/2nPi/wx9vjtPMsaM+Co2rDYATehJS9Yf
         tt8rzxVNuk9q33i+uqDa40YsQbGucU37r3hklfUIP5VKA3/yg46DXo5zWT3XizmMSOMU
         bggCVttLO5pN1+iN69w6Nvz0pziUm2mAmPItunXeQ7lj9K5eO2l0P9oaVcXvcFDntKgW
         jiGcKbPzY2rThaz6YrP58UjQSIiGX5WECMrhv/qiA1mhQ6SvNfndH0pT9dKxrQhaeB8F
         VM/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=YCST9Bnc4NNcSVaVL/74TL0Jcx3MtcwNOfgUP8/uxGM=;
        b=tSiblwKhJaOTilHODA0iH16m4nDyToebxLvoe7NUsL5MVIKnOy/FGsU3Ozl2Dh2oG+
         rSpF36Ls80JD2qdrWVuOaS158qtcb3jEZmBzc3MNqkV/ukRKSVztxP5OatZlpph90Mu3
         mtaBuyGvYNgVUZY8ZojL7VmaE+E0/c4YrbTBze4w1xwG1SgpS7lHix1V3ng9vLEEZhmi
         Umjqlzz8afaKCHXz/faPmvPAyp4WTiUWCxs138mLGOkrLlXKZCsQNHiMQ/AwoQKIPPB1
         Rl505kqC/e1BcxODciSxot6HotXYcRR0NTYuGtXqOz9NEGHzebdOcnOwqxAvuN8s3WPM
         y6DQ==
X-Gm-Message-State: AOAM530SCNJbJ4qpieerUnW1/XrsJrt9wyU39AS6TEal9hQ/tKk/bbVO
        PEVPh0GQ3xd6jsXznWrXi2jgBzhk9uEZAw==
X-Google-Smtp-Source: ABdhPJz5K+/2+yINhEAc+UW8UO7FOuw6tfePpJRWR7GzIHnvzI1HzveIWtBp5eGaXdWlGpt1fN8CtQ==
X-Received: by 2002:a05:6402:348d:: with SMTP id v13mr1248659edc.119.1625160616735;
        Thu, 01 Jul 2021 10:30:16 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id c14sm221155edr.27.2021.07.01.10.30.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 10:30:16 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v3 06/34] fsmonitor: config settings are
 repository-specific
Date:   Thu, 01 Jul 2021 18:46:01 +0200
References: <pull.923.v2.git.1621691828.gitgitgadget@gmail.com>
 <pull.923.v3.git.1625150864.gitgitgadget@gmail.com>
 <8b64b7cd3674163adb0588d42eccf4873b30974b.1625150864.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <8b64b7cd3674163adb0588d42eccf4873b30974b.1625150864.git.gitgitgadget@gmail.com>
Message-ID: <87im1uc57c.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jul 01 2021, Jeff Hostetler via GitGitGadget wrote:

In a reference to a discussion[1] about an earlier version of this patch
you said:

    I'm going to ignore all of the thread responses to this patch
    dealing with how we acquire config settings and macros and etc.
    Those issues are completely independent of FSMonitor (which is
    already way too big).

Since then the changes to repo-settings.c have become a lot larger, so
let's take a look...

1. https://lore.kernel.org/git/87mttkyrqq.fsf@evledraar.gmail.com/
2. https://lore.kernel.org/git/4552971c-0a23-c19a-6a23-cb5737e43b2a@jeffhostetler.com/


> diff --git a/repo-settings.c b/repo-settings.c
> index 0cfe8b787db..faf197ff60a 100644
> --- a/repo-settings.c
> +++ b/repo-settings.c
> @@ -5,10 +5,42 @@
>  
>  #define UPDATE_DEFAULT_BOOL(s,v) do { if (s == -1) { s = v; } } while(0)
>  
> +/*
> + * Return 1 if the repo/workdir is incompatible with FSMonitor.
> + */
> +static int is_repo_incompatible_with_fsmonitor(struct repository *r)
> +{
> +	const char *const_strval;
> +
> +	/*
> +	 * Bare repositories don't have a working directory and
> +	 * therefore, nothing to watch.
> +	 */
> +	if (!r->worktree)
> +		return 1;

Looking ahead in this series you end up using
FSMONITOR_MODE_INCOMPATIBLE in two places in the codebase. In
builtin/update-index.c to throw a "repository is incompatible with
fsmonitor" error.

Can't that case just be replaced with setup_work_tree()? Other sub-modes
of update-index already die implicitly on that, e.g.:

	$ git update-index test
	fatal: this operation must be run in a work tree

The other case is:
	
	+       prepare_repo_settings(the_repository);
	+       if (!the_repository->worktree)
	+               return error(_("fsmonitor-daemon does not support bare repos '%s'"),
	+                            xgetcwd());
	+       if (the_repository->settings.fsmonitor_mode == FSMONITOR_MODE_INCOMPATIBLE)
	+               return error(_("fsmonitor-daemon is incompatible with this repo '%s'"),
	+                            the_repository->worktree);

I.e. we just checked the_repository->worktree, but it's not that, but....

> +
> +	/*
> +	 * GVFS (aka VFS for Git) is incompatible with FSMonitor.
> +	 *
> +	 * Granted, core Git does not know anything about GVFS and
> +	 * we shouldn't make assumptions about a downstream feature,
> +	 * but users can install both versions.  And this can lead
> +	 * to incorrect results from core Git commands.  So, without
> +	 * bringing in any of the GVFS code, do a simple config test
> +	 * for a published config setting.  (We do not look at the
> +	 * various *_TEST_* environment variables.)
> +	 */
> +	if (!repo_config_get_value(r, "core.virtualfilesystem", &const_strval))
> +		return 1;

I'm skeptical of us hardcoding a third-party software config
variable. Can't GitVFS handle this somehow on its end?

But just in terms of implementation it seems the end result of that is
to emit a very confusing error to the user. Sinc we already checked for
bare repos we run into this and instead of sayingwhen we should really
say "hey, maybe disable your core.virtualFileSystem setting", we say
"your repo is incompatible".

> +
> +	return 0;
> +}
> +
>  void prepare_repo_settings(struct repository *r)
>  {
>  	int value;
>  	char *strval;
> +	const char *const_strval;

Can be declared in the "else" below.

>  
>  	if (r->settings.initialized)
>  		return;
> @@ -26,6 +58,22 @@ void prepare_repo_settings(struct repository *r)
>  	UPDATE_DEFAULT_BOOL(r->settings.commit_graph_read_changed_paths, 1);
>  	UPDATE_DEFAULT_BOOL(r->settings.gc_write_commit_graph, 1);
>  
> +	r->settings.fsmonitor_hook_path = NULL;
> +	r->settings.fsmonitor_mode = FSMONITOR_MODE_DISABLED;

With the memset earlier (b.t.w. I've got a patch to fix all this bizarre
behavior in repo-settings.c, but have been waiting on this series we
implicitly set it to FSMONITOR_MODE_UNSET (-1) with the memset, but then
never use that ever.

Your code in update-index.c then for a check against
"FSMONITOR_MODE_DISABLED" says "core.useBuiltinFSMonitor is unset;".

> +	if (is_repo_incompatible_with_fsmonitor(r))
> +		r->settings.fsmonitor_mode = FSMONITOR_MODE_INCOMPATIBLE;

Style: should have {} braces on all arms.

> +	else if (!repo_config_get_bool(r, "core.usebuiltinfsmonitor", &value)
> +		   && value)
> +		r->settings.fsmonitor_mode = FSMONITOR_MODE_IPC;

Here you're conflating false with whether the variable is set at all. I
guess that works out here since if it's false we want to fall through
to...

> +	else {

...ignoring it and looing at core.fsmonitor instead.

> +		if (repo_config_get_pathname(r, "core.fsmonitor", &const_strval))
> +			const_strval = getenv("GIT_TEST_FSMONITOR");

If it's not set we pay attention to GIT_TEST_FSMONITOR, so the behavior
from the old git_config_get_fsmonitor(). So even if the env variable is
set we want to take the config variable over it, correct?

> +		if (const_strval && *const_strval) {
> +			r->settings.fsmonitor_hook_path = strdup(const_strval);

We had a strbuf_detach()'d string in the case of
repo_config_get_pathname(), but here we strdup() it again in case we
were in the getenv() codepath. This code probably leaks memory now
anyway, but perhaps it's better to split up the two so we make it easier
to deal with who owns/frees what in the future.
