Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B105EE71
	for <git@vger.kernel.org>; Tue, 23 Jan 2024 14:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706019946; cv=none; b=GMbftxo5tiaKpKPvKNhlCLv7lpZKHb+UltrqKvnE8arbn/3C+IUDyYRCUHkCzRlAdSiN2+49pZ/0Z0cxP8qVxt6bbS1vXrBX4JGrxNG6T486jlIKkKVmDU4BhcrkKuelixAr8uM16++CMMadwOSICYhjz0tudcj1ThrBfDPeXu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706019946; c=relaxed/simple;
	bh=pz9Ur9sHzHpI3pQcnw1/fXyy2YZgT5FTukDtphId5eM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pm8Qh6UmtclyGyb8wBfNbbffAG3Iy/hM2c15tRdhRYNlpifMidnm1/GHQI/PIeUhWuxp1I9ez6Ildp7a3StT8rhDdZOKeH40FzrCiYOvHXPtxtkYk3Dg1QGg5lyWSm0bTpHXSExk+AyOe5RH9S76Sdm2SMT/M2NoALR0JaKtp+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gRDSLz1x; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gRDSLz1x"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40e80046246so26427065e9.1
        for <git@vger.kernel.org>; Tue, 23 Jan 2024 06:25:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706019943; x=1706624743; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8ydMECxJ9D8QlrY0i26u9VnQ7SBgTt/AoYJpk/ioaqQ=;
        b=gRDSLz1x4m+rj6ahrc6QhGXxy7/R4FkSFYmiYgMxeRnJt7yUUS02yqaRLJNiGWorLF
         4PpPV0nN9w8nKIEK/+nw/bo0UazihkWFuG25dDjTBaXGjkDhIliIzZWnpEtbjVhX0woQ
         3nUj9DHlImtNJTpCuSpmJdlVitmyuW37wGIk+ctVtQBXk6BJz+Wty125rU7Keu+fK5dA
         E/thtvmI7pLe22jCq1IQyXqgvvAKQMuu2CmMO9VUy+yParAE11EuXYw9A0GpnM4BdqLK
         NcjsW4ZMCXoStJdUgV0ovWcMuJD9YhYDWYuf5zhwNtKqYXLBjE7tBn9XMWctItn/shS4
         dhHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706019943; x=1706624743;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8ydMECxJ9D8QlrY0i26u9VnQ7SBgTt/AoYJpk/ioaqQ=;
        b=c2DHc4nZgYvDB79anh22wZNNbvPIIdD1aTJwqUPRPRm91x4LmqqzDQIVr4LDjmYro6
         lkVwJtkyJYUAfb3+chZxCRvC00QtFJvVCi9VtpV7Ox3u0M2IQJlShMbgw6akNRRjl/wZ
         htRuHko+ayy5E7oIDILWCDEHG2+XoY/gi/zYcmOKi+ZzyGyGmqYQhN90j9e5xm4MdLX6
         /J1+DhjBd9N5HaIK0xVRN5g9IXUiu2WDGZAoePngFDP9Ql4xqF1f9ZUHj0YAdz7m8rYg
         hVSBDbyudvtv8/4VdHuDRtu0rSFWUO/SVhWTawfU2rwqvXc3rtN4+zAK1hRY+v+Z9vnZ
         QnoQ==
X-Gm-Message-State: AOJu0Yx5ZvhOyrotzIOkZh13a0g8Y4REO2cD4OKksVVyIoFueGogNHY6
	7iOUtYUM72hyRu6/ksfV+4RMrzavvXfEQNWMWRRlfn5iurTEcRbpL7i6rTto
X-Google-Smtp-Source: AGHT+IH7XFDyQcVTYzGkmLY7Ugv6lP0Dpth42EiXxVpV8Otk19CjsXFFlg0+nFDItWvWumZEQJWJwQ==
X-Received: by 2002:a05:600c:4ec9:b0:40d:92b7:112f with SMTP id g9-20020a05600c4ec900b0040d92b7112fmr198260wmq.114.1706019942637;
        Tue, 23 Jan 2024 06:25:42 -0800 (PST)
Received: from [192.168.1.101] ([84.64.64.237])
        by smtp.googlemail.com with ESMTPSA id q12-20020adfab0c000000b00337d8c40ff7sm12505590wrc.3.2024.01.23.06.25.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jan 2024 06:25:42 -0800 (PST)
Message-ID: <b897771e-c60e-4e41-bfae-3bcfdd832be1@gmail.com>
Date: Tue, 23 Jan 2024 14:25:43 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 4/4] cherry-pick: Add `--empty` for more robust redundant
 commit handling
Content-Language: en-US
To: brianmlyles@gmail.com, git@vger.kernel.org
Cc: me@ttaylorr.com, newren@gmail.com
References: <20240119060721.3734775-2-brianmlyles@gmail.com>
 <20240119060721.3734775-5-brianmlyles@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20240119060721.3734775-5-brianmlyles@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Brian


On 19/01/2024 05:59, brianmlyles@gmail.com wrote:
> From: Brian Lyles <brianmlyles@gmail.com>
> 
> As with `git-rebase` and `git-am`, `git-cherry-pick` can result in a
> commit being made redundant if the content from the picked commit is
> already present in the target history. However, `git-cherry-pick` does
> not have the same options available that `git-rebase` and `git-am` have.
> 
> There are three things that can be done with these redundant commits:
> drop them, keep them, or have the cherry-pick stop and wait for the user
> to take an action. `git-rebase` has the `--empty` option added in commit
> e98c4269c8 (rebase (interactive-backend): fix handling of commits that
> become empty, 2020-02-15), which handles all three of these scenarios.
> Similarly, `git-am` got its own `--empty` in 7c096b8d61 (am: support
> --empty=<option> to handle empty patches, 2021-12-09).
> 
> `git-cherry-pick`, on the other hand, only supports two of the three
> possiblities: Keep the redundant commits via `--keep-redundant-commits`,
> or have the cherry-pick fail by not specifying that option. There is no
> way to automatically drop redundant commits.
> 
> In order to bring `git-cherry-pick` more in-line with `git-rebase` and
> `git-am`, this commit adds an `--empty` option to `git-cherry-pick`. It
> has the same three options (keep, drop, and stop), and largely behaves
> the same. The notable difference is that for `git-cherry-pick`, the
> default will be `stop`, which maintains the current behavior when the
> option is not specified.

Thanks for the well explained commit message

> The `--keep-redundant-commits` option will be documented as a deprecated
> synonym of `--empty=keep`, and will be supported for backwards
> compatibility for the time being.

I'm not sure if we need to deprecate it as in "it will be removed in the 
future" or just reduce it prominence in favor of --empty

> Signed-off-by: Brian Lyles <brianmlyles@gmail.com>
> ---
>   Documentation/git-cherry-pick.txt | 28 ++++++++++++++++++-------
>   builtin/revert.c                  | 35 ++++++++++++++++++++++++++++++-
>   sequencer.c                       |  6 ++++++
>   t/t3505-cherry-pick-empty.sh      | 26 ++++++++++++++++++++++-
>   4 files changed, 86 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cherry-pick.txt
> index 806295a730..8c20a10d4b 100644
> --- a/Documentation/git-cherry-pick.txt
> +++ b/Documentation/git-cherry-pick.txt
> @@ -132,23 +132,37 @@ effect to your index in a row.
>   	keeps commits that were initially empty (i.e. the commit recorded the
>   	same tree as its parent).  Commits which are made empty due to a
>   	previous commit will cause the cherry-pick to fail.  To force the
> -	inclusion of those commits use `--keep-redundant-commits`.
> +	inclusion of those commits use `--empty=keep`.
>   
>   --allow-empty-message::
>   	By default, cherry-picking a commit with an empty message will fail.
>   	This option overrides that behavior, allowing commits with empty
>   	messages to be cherry picked.
>   
> ---keep-redundant-commits::
> -	If a commit being cherry picked duplicates a commit already in the
> -	current history, it will become empty.  By default these
> -	redundant commits cause `cherry-pick` to stop so the user can
> -	examine the commit. This option overrides that behavior and
> -	creates an empty commit object. Note that use of this option only
> +--empty=(stop|drop|keep)::
> +	How to handle commits being cherry-picked that are redundant with
> +	changes already in the current history.
> ++
> +--
> +`stop`;;

I'm still on the fence about "stop" vs "ask". I see in your tests you've 
accidentally used "ask" which makes me wonder if that is the more 
familiar term for users who probably use "git rebase" more often than 
"git am".

> +	The cherry-pick will stop when the empty commit is applied, allowing
> +	you to examine the commit. This is the default behavior.
> +`drop`;;
> +	The empty commit will be dropped.
> +`keep`;;
> +	The empty commit will be kept. Note that use of this option only
>   	results in an empty commit when the commit was not initially empty,
>   	but rather became empty due to a previous commit. Commits that were
>   	initially empty will cause the cherry-pick to fail. To force the
>   	inclusion of those commits use `--allow-empty`.
> +--
> ++
> +Note that commits which start empty will cause the cherry-pick to fail (unless
> +`--allow-empty` is specified).
> ++
> +
> +--keep-redundant-commits::
> +	Deprecated synonym for `--empty=keep`.
>   
>   --strategy=<strategy>::
>   	Use the given merge strategy.  Should only be used once.
> diff --git a/builtin/revert.c b/builtin/revert.c
> index b2cfde7a87..1491c45e26 100644
> --- a/builtin/revert.c
> +++ b/builtin/revert.c
> @@ -45,6 +45,30 @@ static const char * const *revert_or_cherry_pick_usage(struct replay_opts *opts)
>   	return opts->action == REPLAY_REVERT ? revert_usage : cherry_pick_usage;
>   }
>   
> +enum empty_action {
> +	STOP_ON_EMPTY_COMMIT = 0,  /* output errors and stop in the middle of a cherry-pick */
> +	DROP_EMPTY_COMMIT,         /* skip with a notice message */
> +	KEEP_EMPTY_COMMIT,         /* keep recording as empty commits */
> +};
> +
> +static int parse_opt_empty(const struct option *opt, const char *arg, int unset)
> +{
> +	int *opt_value = opt->value;
> +
> +	BUG_ON_OPT_NEG(unset);
> +
> +	if (!strcmp(arg, "stop"))
> +		*opt_value = STOP_ON_EMPTY_COMMIT;
> +	else if (!strcmp(arg, "drop"))
> +		*opt_value = DROP_EMPTY_COMMIT;
> +	else if (!strcmp(arg, "keep"))
> +		*opt_value = KEEP_EMPTY_COMMIT;
> +	else
> +		return error(_("invalid value for '%s': '%s'"), "--empty", arg);
> +
> +	return 0;
> +}
> +
>   static int option_parse_m(const struct option *opt,
>   			  const char *arg, int unset)
>   {
> @@ -87,6 +111,7 @@ static int run_sequencer(int argc, const char **argv, const char *prefix,
>   	const char * const * usage_str = revert_or_cherry_pick_usage(opts);
>   	const char *me = action_name(opts);
>   	const char *cleanup_arg = NULL;
> +	enum empty_action empty_opt;
>   	int cmd = 0;
>   	struct option base_options[] = {
>   		OPT_CMDMODE(0, "quit", &cmd, N_("end revert or cherry-pick sequence"), 'q'),
> @@ -116,7 +141,10 @@ static int run_sequencer(int argc, const char **argv, const char *prefix,
>   			OPT_BOOL(0, "ff", &opts->allow_ff, N_("allow fast-forward")),
>   			OPT_BOOL(0, "allow-empty", &opts->allow_empty, N_("preserve initially empty commits")),
>   			OPT_BOOL(0, "allow-empty-message", &opts->allow_empty_message, N_("allow commits with empty messages")),
> -			OPT_BOOL(0, "keep-redundant-commits", &opts->keep_redundant_commits, N_("keep redundant, empty commits")),
> +			OPT_BOOL(0, "keep-redundant-commits", &opts->keep_redundant_commits, N_("deprecated: use --empty=keep instead")),
> +			OPT_CALLBACK_F(0, "empty", &empty_opt, "(stop|drop|keep)",
> +				       N_("how to handle commits that become empty"),
> +				       PARSE_OPT_NONEG, parse_opt_empty),
>   			OPT_END(),
>   		};
>   		options = parse_options_concat(options, cp_extra);
> @@ -136,6 +164,11 @@ static int run_sequencer(int argc, const char **argv, const char *prefix,
>   	prepare_repo_settings(the_repository);
>   	the_repository->settings.command_requires_full_index = 0;
>   
> +	if (opts->action == REPLAY_PICK) {
> +		opts->drop_redundant_commits = (empty_opt == DROP_EMPTY_COMMIT);
> +		opts->keep_redundant_commits = opts->keep_redundant_commits || (empty_opt == KEEP_EMPTY_COMMIT);
> +	}

The code changes look good but I think we want to update 
verify_opt_compatible() to check for "--empty" being combined with 
"--continue" etc. as well.

>   	if (cleanup_arg) {
>   		opts->default_msg_cleanup = get_cleanup_mode(cleanup_arg, 1);
>   		opts->explicit_cleanup = 1;
> diff --git a/sequencer.c b/sequencer.c
> index 582bde8d46..c49c27c795 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -2934,6 +2934,9 @@ static int populate_opts_cb(const char *key, const char *value,
>   	else if (!strcmp(key, "options.allow-empty-message"))
>   		opts->allow_empty_message =
>   			git_config_bool_or_int(key, value, ctx->kvi, &error_flag);
> +	else if (!strcmp(key, "options.drop-redundant-commits"))
> +		opts->drop_redundant_commits =
> +			git_config_bool_or_int(key, value, ctx->kvi, &error_flag);
>   	else if (!strcmp(key, "options.keep-redundant-commits"))
>   		opts->keep_redundant_commits =
>   			git_config_bool_or_int(key, value, ctx->kvi, &error_flag);
> @@ -3478,6 +3481,9 @@ static int save_opts(struct replay_opts *opts)
>   	if (opts->allow_empty_message)
>   		res |= git_config_set_in_file_gently(opts_file,
>   				"options.allow-empty-message", "true");
> +	if (opts->drop_redundant_commits)
> +		res |= git_config_set_in_file_gently(opts_file,
> +				"options.drop-redundant-commits", "true");

It is good that we're saving the option - it would be good to add a test 
to check that we remember --empty after stopping for a conflict resolution.

>   	if (opts->keep_redundant_commits)
>   		res |= git_config_set_in_file_gently(opts_file,
>   				"options.keep-redundant-commits", "true");
> diff --git a/t/t3505-cherry-pick-empty.sh b/t/t3505-cherry-pick-empty.sh
> index 6adfd25351..ae0cf7886a 100755
> --- a/t/t3505-cherry-pick-empty.sh
> +++ b/t/t3505-cherry-pick-empty.sh
> @@ -89,7 +89,7 @@ test_expect_success 'cherry-pick a commit that becomes no-op (prep)' '
>   	git commit -m "add file2 on the side"
>   '
>   
> -test_expect_success 'cherry-pick a no-op without --keep-redundant' '
> +test_expect_success 'cherry-pick a no-op with neither --keep-redundant nor --empty' '
>   	git reset --hard &&
>   	git checkout fork^0 &&
>   	test_must_fail git cherry-pick main
> @@ -104,4 +104,28 @@ test_expect_success 'cherry-pick a no-op with --keep-redundant' '
>   	test_cmp expect actual
>   '
>   
> +test_expect_success 'cherry-pick a no-op with --empty=ask' '
> +	git reset --hard &&
> +	git checkout fork^0 &&
> +	test_must_fail git cherry-pick --empty=ask main

This is an example of why it is a good idea to check the error message 
when using "test_must_fail" as here the test will fail due to a bad 
value passed to "--empty" rather than for the reason we want the test to 
check. It would be good to add a separate test to check that we reject 
invalid "--empty" values.

> +'
> +
> +test_expect_success 'cherry-pick a no-op with --empty=drop' '
> +	git reset --hard &&
> +	git checkout fork^0 &&
> +	git cherry-pick --empty=drop main &&
> +	git show -s --format=%s >actual &&
> +	echo "add file2 on the side" >expect &&
> +	test_cmp expect actual

I think you could simplify this by using test_commit_message

Best Wishes

Phillip

