Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589EA18E1F
	for <git@vger.kernel.org>; Sun, 10 Nov 2024 21:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731274880; cv=none; b=OtYDOxfFfm1VIYP/vuVc2VOFk5UaAhls0zFG3rebOI3A2dWxLDY2C0glR9VNllKgfH2vof7Em8pcNlQX70xCu2a4hr8NbUuvN2fpByKBOUzu8tH5VdJvFElv5mqEkTejJh70K6XLgUS1uFoEbgitWoZMMF1NLmC8JWv2tlLTlTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731274880; c=relaxed/simple;
	bh=PAMEkRAxQQ4rZc/I9YghzaUFm+WRbHPPPXN0whzDFYA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Q7WvGDUqXB8B3PP+OAyhOLBcA9sY3gAY07FCIkXXQhFuJyvdhXvBm23pspqkSeAnYGXLBsCDsWdzb1oa65JN0ngldyoPtkDkCaQqNp/U4+VcJ5b3nGtY+ZykvbWZfkAfJkjnCIT/rDAySjbWqFpBBszeIq6ou/yzL8M/fJb7+Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R36RvvSj; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R36RvvSj"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43158625112so33733785e9.3
        for <git@vger.kernel.org>; Sun, 10 Nov 2024 13:41:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731274877; x=1731879677; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vadaFxs3iUt/KZWJwVrRUYBZetpTwOEtpBM0H59fUTM=;
        b=R36RvvSj+cc8VsnUI6df+tigFdUzDJrzA/H8SHYJz8HzcWUA+/FOqC8VYEMvIxiycu
         4JzeY8Vd7RM2KZ7lfJzmFRmGHrypiQ1+RxNmVsGTQB2B/651xZbK7yPYiWaFu7Y1EwEu
         QYV8bkdXfVTtU7AZx/lOQqjQFv2d8nnusR6IeK/j7OIkmGNdh4Ua7J143x21hnYOwkY7
         W4oFgKl8kDG9zLGDgs7UFmBeuMDmigB3/jVZ6OOEvdaODV4p/MMv7s4Xudz5hYXOvkdu
         lWMqGNuntY7O/g5rjjXWznmoD3bwmlxOcDEMNffIkHkRNu1qSmHDpFa401bRdjreMHU0
         VLYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731274877; x=1731879677;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vadaFxs3iUt/KZWJwVrRUYBZetpTwOEtpBM0H59fUTM=;
        b=ljl2orhPtF1SI6XS2pXu/HDYohSgb0eACHxthN+ci4VJJS1Y7ImlrRHQCpXledIQli
         4wxzYHPNCzcIuYXXyMzyb/euayRc6tO73TKNLkuN7uCcgc/A+n31OZs5mCNWk/MO7Ff9
         +InHA3u3lscci+nEzW74yJtHalOaJTH+GBTUQsTJwERsIuqUcVufBlyYOLBNhspApLop
         +0wlBiMO7SPym689r1NzE/Hlm/QParwugYNO9TGuBPTMaTZv/ZHBxs5737R77VXfzEMy
         hE8m8yuXZ1btymIpLBgjHXHVHWu8Nt8pizZVHYzX5hjWb+7aoH+Rc1lXV+CdPqjBXQp1
         tTBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWEqpR8cFKyoAooVVcYCQZuOG7/RGzLV5T+r+Qu/pm7FRvyv6yxwdjkU2gZn3dgW+CJLs4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDG/bXHinsr+1CSz08WOIaOuIcnUWo9HsGekW0G7GX3PrEgZdQ
	Y0qS2btcK0SbNuB0uKajGZEtttphJmXDdfy4ntM2PRVDrlrtJoAHxzctiQ==
X-Google-Smtp-Source: AGHT+IGqs5rkgWK68I6udneNnsgSMfE++YDiuDy6U64nswsuJ1x7ssV7c4oOZCSnOg6vGrFn+WLbmA==
X-Received: by 2002:a05:600c:510a:b0:430:5846:7582 with SMTP id 5b1f17b1804b1-432b74fda3dmr86384395e9.7.1731274876602;
        Sun, 10 Nov 2024 13:41:16 -0800 (PST)
Received: from gmail.com ([178.237.229.35])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432aa70a1e9sm194271065e9.29.2024.11.10.13.41.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Nov 2024 13:41:16 -0800 (PST)
Message-ID: <8b9c998b-9098-47d7-af49-ecea51d5278f@gmail.com>
Date: Sun, 10 Nov 2024 22:41:14 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/26] git: refactor alias handling to use a `struct
 strvec`
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
References: <cover.1730901926.git.ps@pks.im>
 <93aed59eaf67739e25dee4bd6cc0a3f2a527f345.1730901926.git.ps@pks.im>
Content-Language: en-US
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
In-Reply-To: <93aed59eaf67739e25dee4bd6cc0a3f2a527f345.1730901926.git.ps@pks.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Wed, Nov 06, 2024 at 04:10:47PM +0100, Patrick Steinhardt wrote:
> In `handle_alias()` we use both `argcp` and `argv` as in-out parameters.
> Callers mostly pass through the static array from `main()`, but once we
> handle an alias we replace it with an allocated array that may contain
> some allocated strings. Callers do not handle this scenario at all and
> thus leak memory.
> 
> We could in theory handle the lifetime of `argv` in a hacky fashion by
> letting callers free it in case they see that an alias was handled. But
> while that would likely work, we still wouldn't be able to easily handle
> the lifetime of strings referenced by `argv`.
> 
> Refactor the code to instead use a `struct strvec`, which effectively
> removes the need for us to manually track lifetimes.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  git.c            | 58 ++++++++++++++++++++++++++----------------------
>  t/t0014-alias.sh |  1 +
>  2 files changed, 33 insertions(+), 26 deletions(-)
> 
> diff --git a/git.c b/git.c
> index c2c1b8e22c2..88356afe5fb 100644
> --- a/git.c
> +++ b/git.c
> @@ -362,7 +362,7 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
>  	return (*argv) - orig_argv;
>  }
>  
> -static int handle_alias(int *argcp, const char ***argv)
> +static int handle_alias(struct strvec *args)
>  {
>  	int envchanged = 0, ret = 0, saved_errno = errno;
>  	int count, option_count;
> @@ -370,10 +370,10 @@ static int handle_alias(int *argcp, const char ***argv)
>  	const char *alias_command;
>  	char *alias_string;
>  
> -	alias_command = (*argv)[0];
> +	alias_command = args->v[0];
>  	alias_string = alias_lookup(alias_command);
>  	if (alias_string) {
> -		if (*argcp > 1 && !strcmp((*argv)[1], "-h"))
> +		if (args->nr > 1 && !strcmp(args->v[1], "-h"))
>  			fprintf_ln(stderr, _("'%s' is aliased to '%s'"),
>  				   alias_command, alias_string);
>  		if (alias_string[0] == '!') {
> @@ -390,7 +390,7 @@ static int handle_alias(int *argcp, const char ***argv)
>  			child.wait_after_clean = 1;
>  			child.trace2_child_class = "shell_alias";
>  			strvec_push(&child.args, alias_string + 1);
> -			strvec_pushv(&child.args, (*argv) + 1);
> +			strvec_pushv(&child.args, args->v + 1);
>  
>  			trace2_cmd_alias(alias_command, child.args.v);
>  			trace2_cmd_name("_run_shell_alias_");
> @@ -423,15 +423,13 @@ static int handle_alias(int *argcp, const char ***argv)
>  		trace_argv_printf(new_argv,
>  				  "trace: alias expansion: %s =>",
>  				  alias_command);
> -
> -		REALLOC_ARRAY(new_argv, count + *argcp);
> -		/* insert after command name */
> -		COPY_ARRAY(new_argv + count, *argv + 1, *argcp);
> -
>  		trace2_cmd_alias(alias_command, new_argv);
>  
> -		*argv = new_argv;
> -		*argcp += count - 1;
> +		/* Replace the alias with the new arguments. */
> +		strvec_splice(args, 0, 1, new_argv, count);

So, we take advantage here of the `replacement_len` argument for
`strvec_splice()`.  OK. 

> +
> +		free(alias_string);
> +		free(new_argv);
>  
>  		ret = 1;
>  	}
> @@ -800,10 +798,10 @@ static void execv_dashed_external(const char **argv)
>  		exit(128);
>  }
>  
> -static int run_argv(int *argcp, const char ***argv)
> +static int run_argv(struct strvec *args)
>  {
>  	int done_alias = 0;
> -	struct string_list cmd_list = STRING_LIST_INIT_NODUP;
> +	struct string_list cmd_list = STRING_LIST_INIT_DUP;
>  	struct string_list_item *seen;
>  
>  	while (1) {
> @@ -817,8 +815,8 @@ static int run_argv(int *argcp, const char ***argv)
>  		 * process.
>  		 */
>  		if (!done_alias)
> -			handle_builtin(*argcp, *argv);
> -		else if (get_builtin(**argv)) {
> +			handle_builtin(args->nr, args->v);
> +		else if (get_builtin(args->v[0])) {
>  			struct child_process cmd = CHILD_PROCESS_INIT;
>  			int i;
>  
> @@ -834,8 +832,8 @@ static int run_argv(int *argcp, const char ***argv)
>  			commit_pager_choice();
>  
>  			strvec_push(&cmd.args, "git");
> -			for (i = 0; i < *argcp; i++)
> -				strvec_push(&cmd.args, (*argv)[i]);
> +			for (i = 0; i < args->nr; i++)
> +				strvec_push(&cmd.args, args->v[i]);
>  
>  			trace_argv_printf(cmd.args.v, "trace: exec:");
>  
> @@ -850,13 +848,13 @@ static int run_argv(int *argcp, const char ***argv)
>  			i = run_command(&cmd);
>  			if (i >= 0 || errno != ENOENT)
>  				exit(i);
> -			die("could not execute builtin %s", **argv);
> +			die("could not execute builtin %s", args->v[0]);
>  		}
>  
>  		/* .. then try the external ones */
> -		execv_dashed_external(*argv);
> +		execv_dashed_external(args->v);
>  
> -		seen = unsorted_string_list_lookup(&cmd_list, *argv[0]);
> +		seen = unsorted_string_list_lookup(&cmd_list, args->v[0]);
>  		if (seen) {
>  			int i;
>  			struct strbuf sb = STRBUF_INIT;
> @@ -873,14 +871,14 @@ static int run_argv(int *argcp, const char ***argv)
>  			      " not terminate:%s"), cmd_list.items[0].string, sb.buf);
>  		}
>  
> -		string_list_append(&cmd_list, *argv[0]);
> +		string_list_append(&cmd_list, args->v[0]);
>  
>  		/*
>  		 * It could be an alias -- this works around the insanity
>  		 * of overriding "git log" with "git show" by having
>  		 * alias.log = show
>  		 */
> -		if (!handle_alias(argcp, argv))
> +		if (!handle_alias(args))
>  			break;
>  		done_alias = 1;
>  	}
> @@ -892,6 +890,7 @@ static int run_argv(int *argcp, const char ***argv)
>  
>  int cmd_main(int argc, const char **argv)
>  {
> +	struct strvec args = STRVEC_INIT;
>  	const char *cmd;
>  	int done_help = 0;
>  
> @@ -951,25 +950,32 @@ int cmd_main(int argc, const char **argv)
>  	 */
>  	setup_path();
>  
> +	for (size_t i = 0; i < argc; i++)
> +		strvec_push(&args, argv[i]);
> +
>  	while (1) {
> -		int was_alias = run_argv(&argc, &argv);
> +		int was_alias = run_argv(&args);
>  		if (errno != ENOENT)
>  			break;
>  		if (was_alias) {
>  			fprintf(stderr, _("expansion of alias '%s' failed; "
>  					  "'%s' is not a git command\n"),
> -				cmd, argv[0]);
> +				cmd, args.v[0]);
> +			strvec_clear(&args);
>  			exit(1);
>  		}
>  		if (!done_help) {
> -			cmd = argv[0] = help_unknown_cmd(cmd);
> +			strvec_replace(&args, 0, help_unknown_cmd(cmd));
> +			cmd = args.v[0];
>  			done_help = 1;
> -		} else
> +		} else {
>  			break;
> +		}
>  	}
>  
>  	fprintf(stderr, _("failed to run command '%s': %s\n"),
>  		cmd, strerror(errno));
> +	strvec_clear(&args);
>  
>  	return 1;
>  }
> diff --git a/t/t0014-alias.sh b/t/t0014-alias.sh
> index 854d59ec58c..2a6f39ad9c8 100755
> --- a/t/t0014-alias.sh
> +++ b/t/t0014-alias.sh
> @@ -2,6 +2,7 @@
>  
>  test_description='git command aliasing'
>  
> +TEST_PASSES_SANITIZE_LEAK=true
>  . ./test-lib.sh
>  
>  test_expect_success 'nested aliases - internal execution' '
> -- 
> 2.47.0.229.g8f8d6eee53.dirty
> 
