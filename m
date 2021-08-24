Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B407C4338F
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 15:01:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 138F36113B
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 15:01:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238034AbhHXPBw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 11:01:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237749AbhHXPBv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 11:01:51 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43374C061757
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 08:01:07 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id me10so16644635ejb.11
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 08:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=d+ekJCdJhws9uxiP6DkuQSDtuBbMcJ3VIMDBrOJgAvg=;
        b=SKJ+OWfuQdIpmgI0brxGCsu72vyMvrVofTZwN9AIx+05ambP6WzoUZhAYOeRHge8EX
         G+BkmLTmuCX1h4vDsrU8bY0dcrNL4ptE/MtQgKhQcWUTBx0aZhbBOJHTk8UttZ4Qqzcu
         O/ppyulbVJ6A/S2wpKn4qbklbZebtAMLbxUHGvhzitrDXfHtv1FaeEz9sQx8sj/rCyw4
         jqCvGoenf+RTfSmBZHbDcila71HVEBaRFWN3P6TJ2feXCG1DGpgtPMUEpUfHmlLmCMLE
         nEJsayPeQw/IPCBSmN0fpByNXOJjEXKZJlAQKa5hKVOS8RZfLQ3oZDvmR8Fr3wqByt73
         lI4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=d+ekJCdJhws9uxiP6DkuQSDtuBbMcJ3VIMDBrOJgAvg=;
        b=cNS0NYmuyXIFzzGCS4E+9ZKdC1c0PznIjiva5BdKiA3gNaJZ3cHSk+bJI7yQ3DWEnI
         6CcGlaYmqfSktxr4TimhojOO2/wujVi6lP6mAlZ49s6zpMvvk7ha+no42nYT8cwTZTnx
         C1/G+gkMTtefgQ/nymVH55K8IHPLtf6OR6U2oYS6seSyG92zhnPWck/HBn7ge9IMf8ab
         GJbihvxrmo/oOxMFPupCqhVtWUhAESGBC1dcYj5EXYoT2Odu7Q9j4GK5i5BoTHHi6prc
         oKCn6+r40hem541Ytf+4QqZg47XBkO1Ow2rZYXxU5NVDirKwJbN5ZblJFd5E4YutXdS1
         8ekA==
X-Gm-Message-State: AOAM532y3quMOSnB5Cvub00izfhUsyFjt3EdyNxal+Uc6WCszxzgiigs
        q5YHKiDIxF67PifHHzXdTfg=
X-Google-Smtp-Source: ABdhPJzlwIbWTmIAo1vjgZnP8zGnU5yk0Foj/lpMiEy1p9Nm9IFHxYuCizU9xQEicpImXj3925FYgw==
X-Received: by 2002:a17:907:7817:: with SMTP id la23mr8384917ejc.43.1629817265790;
        Tue, 24 Aug 2021 08:01:05 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id bf15sm11801883edb.83.2021.08.24.08.01.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 08:01:05 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 1/6] hook: run a list of hooks instead
Date:   Tue, 24 Aug 2021 16:56:10 +0200
References: <20210819033450.3382652-1-emilyshaffer@google.com>
 <20210819033450.3382652-2-emilyshaffer@google.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <20210819033450.3382652-2-emilyshaffer@google.com>
Message-ID: <87zgt6evkf.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Aug 18 2021, Emily Shaffer wrote:

> @@ -25,7 +25,8 @@ static int run(int argc, const char **argv, const char *prefix)
>  	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
>  	int ignore_missing = 0;
>  	const char *hook_name;
> -	const char *hook_path;
> +	struct list_head *hooks;
> +
>  	struct option run_options[] = {
>  		OPT_BOOL(0, "ignore-missing", &ignore_missing,
>  			 N_("exit quietly with a zero exit code if the requested hook cannot be found")),

In general in this patch series there's a bunch of little whitespace
changes like that along with other changes. I think it's probably best
if I just absorb that in the "base" topic instead of doing them
here. E.g. in this case we could also add a line between "struct option"
and the rest.

I don't mind either way, but the whitespace churn makes for distracting
reading...

> @@ -58,15 +59,16 @@ static int run(int argc, const char **argv, const char *prefix)
>  	git_config(git_default_config, NULL);
>  
>  	hook_name = argv[0];
> -	if (ignore_missing)
> -		return run_hooks_oneshot(hook_name, &opt);
> -	hook_path = find_hook(hook_name);
> -	if (!hook_path) {
> +	hooks = list_hooks(hook_name);
> +	if (list_empty(hooks)) {
> +		/* ... act like run_hooks_oneshot() under --ignore-missing */
> +		if (ignore_missing)
> +			return 0;
>  		error("cannot find a hook named %s", hook_name);
>  		return 1;
>  	}
>  
> -	ret = run_hooks(hook_name, hook_path, &opt);
> +	ret = run_hooks(hook_name, hooks, &opt);
>  	run_hooks_opt_clear(&opt);
>  	return ret;

This memory management is a bit inconsistent. So here we list_hooks(),
pass it to run_hooks(), which clears it for us, OK...

> -int run_hooks(const char *hook_name, const char *hook_path,
> -	      struct run_hooks_opt *options)
> +int run_hooks(const char *hook_name, struct list_head *hooks,
> +		    struct run_hooks_opt *options)
>  {
> -	struct strbuf abs_path = STRBUF_INIT;
> -	struct hook my_hook = {
> -		.hook_path = hook_path,
> -	};
>  	struct hook_cb_data cb_data = {
>  		.rc = 0,
>  		.hook_name = hook_name,
> @@ -197,11 +241,9 @@ int run_hooks(const char *hook_name, const char *hook_path,
>  	if (!options)
>  		BUG("a struct run_hooks_opt must be provided to run_hooks");
>  
> -	if (options->absolute_path) {
> -		strbuf_add_absolute_path(&abs_path, hook_path);
> -		my_hook.hook_path = abs_path.buf;
> -	}
> -	cb_data.run_me = &my_hook;
> +
> +	cb_data.head = hooks;
> +	cb_data.run_me = list_first_entry(hooks, struct hook, list);
>  
>  	run_processes_parallel_tr2(jobs,
>  				   pick_next_hook,
> @@ -213,18 +255,15 @@ int run_hooks(const char *hook_name, const char *hook_path,
>  				   "hook",
>  				   hook_name);
>  
> -
> -	if (options->absolute_path)
> -		strbuf_release(&abs_path);
> -	free(my_hook.feed_pipe_cb_data);
> +	clear_hook_list(hooks);
>  
>  	return cb_data.rc;
>  }

Which we can see here will call clear_hook_list(), so far so good, but then...

>  int run_hooks_oneshot(const char *hook_name, struct run_hooks_opt *options)
>  {
> -	const char *hook_path;
> -	int ret;
> +	struct list_head *hooks;
> +	int ret = 0;
>  	struct run_hooks_opt hook_opt_scratch = RUN_HOOKS_OPT_INIT;
>  
>  	if (!options)
> @@ -233,14 +272,19 @@ int run_hooks_oneshot(const char *hook_name, struct run_hooks_opt *options)
>  	if (options->path_to_stdin && options->feed_pipe)
>  		BUG("choose only one method to populate stdin");
>  
> -	hook_path = find_hook(hook_name);
> -	if (!hook_path) {
> -		ret = 0;
> +	hooks = list_hooks(hook_name);
> +
> +	/*
> +	 * If you need to act on a missing hook, use run_found_hooks()
> +	 * instead
> +	 */
> +	if (list_empty(hooks))
>  		goto cleanup;
> -	}
>  
> -	ret = run_hooks(hook_name, hook_path, options);
> +	ret = run_hooks(hook_name, hooks, options);
> +
>  cleanup:
>  	run_hooks_opt_clear(options);
> +	clear_hook_list(hooks);

...the oneshot command also does clear_hook_list(), after calling
run_hooks() which cleared it already.  That looks like a mistake,
i.e. we should always trust run_hooks() to clear it, no?
