Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB57420B00
	for <git@vger.kernel.org>; Mon, 19 Feb 2024 08:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708329875; cv=none; b=sbCyMC46Cdu2bzztXmcqLKGCb3C26Ytqe5A7FMwhY7K5sbgU/hnkSGHmklvLiyxqTMPfsHxYbNksASaUOARQNyddSyhxmfyvJlqHydn86Nu3aEorN2hLAXBNpLrHDeX8UMmeXvLK5FxHGmIrfQ+L5YvGGgMUXMqtmNaeAV/Tm5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708329875; c=relaxed/simple;
	bh=7gvuS4hCYg3h2Mb9XYH9G+Ywvd09y86o5cNQOvY81Co=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=AUaa9DuL7lYiPktpvmeQrCogrYc7FrVUyFxBBN59SP77Y93Ht/vJTitK8jZ50Mf+b3tofVnbDhEddMG1XjaheIHlK5IFVZRzUPBsTRXuSLo1kziDj+8NbAoQ6IpLOSM/LXq69U/ADhmuiAjCeqvl6nr5vQ3faV/aIwgzAc5Us+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lfYyAbte; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lfYyAbte"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5645960cd56so1131970a12.1
        for <git@vger.kernel.org>; Mon, 19 Feb 2024 00:04:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708329871; x=1708934671; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bQubGDDlnFDYynrOP8h/V5sNqkVStCEz48/s5PIjPgU=;
        b=lfYyAbtemI3UjEmUt8kVYULFdZG3GRNGQRE5JLAd1JYPd7XQUwEuvNW4amUFPuY8wO
         uXinsoCvM5u91a0AWEJmM0X1CUVG0fdq+/QQrcs5c5uQmoGDodUOcLVapAL02qgbaXdI
         bmH7h562Qf3QWdX/Q9lz7dKNNp7opONU2tICCZFSkwOXvU4icMSVbgeZqGIjpHkjSSBR
         asXbc92p8EuPotI89TGXdaN8PinqpQvMz+AaYZ2s6v8bsP1i4usYFs2Yp2lYBQvpiHv8
         Bpsq+DAzzMZzNq4pwJ6zuEKbq3MSRPfSUXLTOPSYEKtlv5xn17aTtXER9wQLEr9YUTdc
         RY5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708329871; x=1708934671;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bQubGDDlnFDYynrOP8h/V5sNqkVStCEz48/s5PIjPgU=;
        b=XUQbtCv9HdYXZpAAs4yTEgD9FyWwUdxPbBddNtuzQtkKrNR5FLDuO7f60jrSQ3+jA/
         FSjK/HNL/AkbMmOrjIjL9OPNwYdf2wCVBPTsqAG8SymGoIyg+qP/Ipri03P0Nqmsijy7
         VhwuwICJhkbzF0KqG1+LXdhFbxXxxiqIILYRaNabvUPv7prI1wWzZOSVIHGgHUYyp8pu
         4B2uale1g+QHrD2Wdyd3vH53/JFZrqF0JUAkB8cgyE51j2RkUsnHyyCxlckBdYRkzQbx
         53qWFcHtihQu18R1CMZJQTbiv4p5L2movnHkZFlFTxsyur4/qQYG0liXAd6K0OjEFiMa
         9pbw==
X-Forwarded-Encrypted: i=1; AJvYcCUpSKeZ2c9jqJUIupML5Q6HN0INvOehfHJSa6QWy3yum2z26ePwP49YqXC31dtiMTqHX/+n/+RjbTkEZeLhNwo+2o/F
X-Gm-Message-State: AOJu0YzI9g9gUNml9nb8bxIFYd3rvIKCVL+QCTp/OYLRwAESh0TeQDi8
	QOMdDmxH/H54+YSoMtgdbtQZyRAxfKnygwOndYt9tzmdazHoAOCsdavQFzQF
X-Google-Smtp-Source: AGHT+IGEcVgBUgVNK6spZZBvd/fwIKm9rwa84s6SOULro6oGMK5bmygJZlz+zfJb8v63gv0PKerJuA==
X-Received: by 2002:a17:906:c7d6:b0:a3e:b726:20ef with SMTP id dc22-20020a170906c7d600b00a3eb72620efmr530367ejb.34.1708329870552;
        Mon, 19 Feb 2024 00:04:30 -0800 (PST)
Received: from [192.168.3.191] ([92.173.128.58])
        by smtp.googlemail.com with ESMTPSA id th8-20020a1709078e0800b00a3d3b68e504sm2640125ejc.202.2024.02.19.00.04.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Feb 2024 00:04:29 -0800 (PST)
Message-ID: <fc7a8c46-61e4-4b5d-b625-cbc845b81590@gmail.com>
Date: Mon, 19 Feb 2024 09:04:28 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] builtin/stash: configs keepIndex, includeUntracked
To: MithicSpirit <rpc01234@gmail.com>, git@vger.kernel.org
References: <20240218033146.372727-2-rpc01234@gmail.com>
From: =?UTF-8?Q?Jean-No=C3=ABl_Avila?= <avila.jn@gmail.com>
Content-Language: fr
In-Reply-To: <20240218033146.372727-2-rpc01234@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello,

Le 18/02/2024 à 04:30, MithicSpirit a écrit :
> Adds options `stash.keepIndex` and `stash.includeUntracked`, which
> enable `--keep-index` and `--include-untracked` by default (unless it
> would conflict with another option). This is done to facilitate the
> workflow where a user:
> 
> . Makes modifications;
> . Selectively adds them with `git add -p`; and
> . Stashes the unadded changes to run tests with only the current
>    modifications.
> 
> `stash.keepIndex` is especially important for this, as otherwise the
> work done in `git add -p` is lost since applying the stash does not
> restore the index. This problem could also be solved by adding
> functionality to the stash to restore the index specifically, but this
> would create much more complexity and still wouldn't be as convenient
> for that workflow.
> 
> Signed-off-by: Ricardo Prado Cunha (MithicSpirit) <rpc01234@gmail.com>
> ---
> This is my first patch to git and my first time using mailing lists for this
> kind of stuff. Please do let me know of any mistakes or gaffes I've made.
> 
>   Documentation/config/stash.txt |  13 ++++
>   builtin/stash.c                |  65 ++++++++++++------
>   t/t3903-stash.sh               | 119 +++++++++++++++++++++++++++++++++
>   3 files changed, 178 insertions(+), 19 deletions(-)
> 
> diff --git a/Documentation/config/stash.txt b/Documentation/config/stash.txt
> index ec1edaeba6..d6d9ea7daa 100644
> --- a/Documentation/config/stash.txt
> +++ b/Documentation/config/stash.txt
> @@ -1,6 +1,19 @@
> +stash.includeUntracked::
> +	Boolean option that configures whether the `git stash push` and `git
> +	stash save` commands also stash untracked files by default. This option
> +	is ignored if `--include-untracked`, `--no-include-untracked`, `--all`,
> +	`--patch`, or `--staged` are used. Defaults to `false`. See
> +	linkgit:git-stash[1].
> +
> +stash.keepIndex::
> +	Boolean option that configures whether the `git stash push` and `git
> +	stash save` commands also stash changes that have been added to the
> +	index. This option is ignored if `--keep-index`, `--no-keep-index`, or
> +	`--patch` are used. Defaults to `false`. See linkgit:git-stash[1].
> +
>   stash.showIncludeUntracked::
>   	If this is set to true, the `git stash show` command will show
>   	the untracked files of a stash entry.  Defaults to false. See
>   	the description of the 'show' command in linkgit:git-stash[1].
> 
>   stash.showPatch::
> diff --git a/builtin/stash.c b/builtin/stash.c
> index 7fb355bff0..c591a2bf4b 100644
> --- a/builtin/stash.c
> +++ b/builtin/stash.c
> @@ -836,12 +836,14 @@ static int list_stash(int argc, const char **argv, const char *prefix)
>   	return run_command(&cp);
>   }
> 
>   static int show_stat = 1;
>   static int show_patch;
>   static int show_include_untracked;
> +static int default_keep_index;
> +static int default_include_untracked;
> 
>   static int git_stash_config(const char *var, const char *value,
>   			    const struct config_context *ctx, void *cb)
>   {
>   	if (!strcmp(var, "stash.showstat")) {
>   		show_stat = git_config_bool(var, value);
> @@ -852,12 +854,20 @@ static int git_stash_config(const char *var, const char *value,
>   		return 0;
>   	}
>   	if (!strcmp(var, "stash.showincludeuntracked")) {
>   		show_include_untracked = git_config_bool(var, value);
>   		return 0;
>   	}
> +	if (!strcmp(var, "stash.keepindex")) {
> +		default_keep_index = git_config_bool(var, value);
> +		return 0;
> +	}
> +	if (!strcmp(var, "stash.includeuntracked")) {
> +		default_include_untracked = git_config_bool(var, value);
> +		return 0;
> +	}
>   	return git_diff_basic_config(var, value, ctx, cb);
>   }
> 
>   static void diff_include_untracked(const struct stash_info *info, struct diff_options *diff_opt)
>   {
>   	const struct object_id *oid[] = { &info->w_commit, &info->u_tree };
> @@ -1509,33 +1519,50 @@ static int do_push_stash(const struct pathspec *ps, const char *stash_msg, int q
>   	int ret = 0;
>   	struct stash_info info = STASH_INFO_INIT;
>   	struct strbuf patch = STRBUF_INIT;
>   	struct strbuf stash_msg_buf = STRBUF_INIT;
>   	struct strbuf untracked_files = STRBUF_INIT;
> 
> -	if (patch_mode && keep_index == -1)
> -		keep_index = 1;
> -
> -	if (patch_mode && include_untracked) {
> -		fprintf_ln(stderr, _("Can't use --patch and --include-untracked"
> -				     " or --all at the same time"));
> -		ret = -1;
> -		goto done;
> +	if (keep_index == -1) {
> +		if (patch_mode)
> +			keep_index = 1;
> +		else
> +			keep_index = default_keep_index;
>   	}
> 
> -	/* --patch overrides --staged */
> -	if (patch_mode)
> +	if (patch_mode) {
> +		if (include_untracked == -1)
> +			include_untracked = 0;
> +		else if (include_untracked) {
> +			fprintf_ln(stderr,
> +				   _("Can't use --patch and --include-untracked"
> +				     " or --all at the same time"));
> +			ret = -1;
> +			goto done;
> +		}
> +
> +		/* --patch overrides --staged */
>   		only_staged = 0;
> -
> -	if (only_staged && include_untracked) {
> -		fprintf_ln(stderr, _("Can't use --staged and --include-untracked"
> -				     " or --all at the same time"));
> -		ret = -1;
> -		goto done;
>   	}
> 
> +	if (only_staged) {
> +		if (include_untracked == -1)
> +			include_untracked = 0;
> +		else if (include_untracked) {
> +			fprintf_ln(
> +				stderr,
> +				_("Can't use --staged and --include-untracked"
> +				  " or --all at the same time"));
> +			ret = -1;
> +			goto done;
> +		}
> +	}
> +
> +	if (include_untracked == -1)
> +		include_untracked = default_include_untracked;
> +

I'm not sure this would be better, but instead of mixing option 
compatibility and actually building your logic, why not use a series of
die_for_incompatible_opt3 and the like in order to clear the option 
lists, then build your action logic without resorting to special values?


>   	repo_read_index_preload(the_repository, NULL, 0);
>   	if (!include_untracked && ps->nr) {
>   		int i;
>   		char *ps_matched = xcalloc(ps->nr, 1);
> 
>   		/* TODO: audit for interaction with sparse-index. */
> @@ -1688,13 +1715,13 @@ static int do_push_stash(const struct pathspec *ps, const char *stash_msg, int q
>   				fprintf_ln(stderr, _("Cannot remove "
>   						     "worktree changes"));
>   			ret = -1;
>   			goto done;
>   		}
> 
> -		if (keep_index < 1) {
> +		if (!keep_index) {
>   			struct child_process cp = CHILD_PROCESS_INIT;
> 
>   			cp.git_cmd = 1;
>   			strvec_pushl(&cp.args, "reset", "-q", "--refresh", "--",
>   				     NULL);
>   			add_pathspecs(&cp.args, ps);
> @@ -1718,13 +1745,13 @@ static int push_stash(int argc, const char **argv, const char *prefix,
>   		      int push_assumed)
>   {
>   	int force_assume = 0;
>   	int keep_index = -1;
>   	int only_staged = 0;
>   	int patch_mode = 0;
> -	int include_untracked = 0;
> +	int include_untracked = -1;
>   	int quiet = 0;
>   	int pathspec_file_nul = 0;
>   	const char *stash_msg = NULL;
>   	const char *pathspec_from_file = NULL;
>   	struct pathspec ps;
>   	struct option options[] = {
> @@ -1798,13 +1825,13 @@ static int push_stash_unassumed(int argc, const char **argv, const char *prefix)
> 
>   static int save_stash(int argc, const char **argv, const char *prefix)
>   {
>   	int keep_index = -1;
>   	int only_staged = 0;
>   	int patch_mode = 0;
> -	int include_untracked = 0;
> +	int include_untracked = -1;
>   	int quiet = 0;
>   	int ret = 0;
>   	const char *stash_msg = NULL;
>   	struct pathspec ps;
>   	struct strbuf stash_msg_buf = STRBUF_INIT;
>   	struct option options[] = {
> diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
> index 00db82fb24..4ffcca742c 100755
> --- a/t/t3903-stash.sh
> +++ b/t/t3903-stash.sh
> @@ -1565,7 +1565,126 @@ test_expect_success 'stash apply reports a locked index' '
>   		EOF
>   		test_must_fail git stash apply 2>err &&
>   		test_cmp expect err
>   	)
>   '
> 
> +setup_dirty() {
> +	echo a >tracked &&
> +	echo b >added-modified &&
> +	git add tracked added-modified &&
> +	git commit -m initial &&
> +	echo 1 >>tracked &&
> +	echo 2 >>added-modified &&
> +	echo c >added-new &&
> +	echo d >untracked &&
> +	git add added-modified added-new
> +}
> +
> +test_expect_success 'stash.includeuntracked equivalent to --include-untracked' '
> +	git init using_opt &&
> +	test_when_finished rm -rf using_opt &&
> +	(
> +		cd using_opt &&
> +		setup_dirty &&
> +		git stash push &&
> +		git stash show -u --patch >../using-opt
> +	) &&
> +
> +	test_config stash.includeuntracked true &&
> +	git init using_config &&
> +	test_when_finished rm -rf using_config &&
> +	(
> +		cd using_config &&
> +		setup_dirty &&
> +		git stash push &&
> +		git stash show -u --patch >../using-config
> +	) &&
> +
> +	test_cmp using-opt using-config
> +'
> +
> +test_expect_success 'stash.includeuntracked yields to --no-include-untracked' '
> +	git init no_config &&
> +	test_when_finished rm -rf no_config &&
> +	(
> +		cd no_config &&
> +		setup_dirty &&
> +		git stash push --no-include-untracked &&
> +		git stash show -u --patch >../no-config
> +	) &&
> +
> +	test_config stash.includeuntracked true &&
> +	git init using_config &&
> +	test_when_finished rm -rf using_config &&
> +	(
> +		cd using_config &&
> +		setup_dirty &&
> +		git stash push --no-include-untracked &&
> +		git stash show -u --patch >../using-config
> +	) &&
> +
> +	test_cmp no-config using-config
> +'
> +
> +test_expect_success 'stash.includeuntracked succeeds with --patch' '
> +	test_config stash.includeuntracked true &&
> +	git stash --patch
> +'
> +
> +test_expect_success 'stash.includeuntracked succeeds with --staged' '
> +	test_config stash.includeuntracked true &&
> +	git stash --staged
> +'
> +
> +test_expect_success 'stash.keepindex equivalent to --keep-index' '
> +	git init using_opt &&
> +	test_when_finished rm -rf using_opt &&
> +	(
> +		cd using_opt &&
> +		setup_dirty &&
> +		git stash push &&
> +		git stash show -u --patch >../using-opt
> +	) &&
> +
> +	test_config stash.keepindex true &&
> +	git init using_config &&
> +	test_when_finished rm -rf using_config &&
> +	(
> +		cd using_config &&
> +		setup_dirty &&
> +		git stash push &&
> +		git stash show -u --patch >../using-config
> +	) &&
> +
> +	test_cmp using-opt using-config
> +'
> +
> +test_expect_success 'stash.keepindex yields to --no-keep-index' '
> +	git init no_config &&
> +	test_when_finished rm -rf no_config &&
> +	(
> +		cd no_config &&
> +		setup_dirty &&
> +		git stash push --no-keep-index &&
> +		git stash show -u --patch >../no-config
> +	) &&
> +
> +	test_config stash.keepindex true &&
> +	git init using_config &&
> +	test_when_finished rm -rf using_config &&
> +	(
> +		cd using_config &&
> +		setup_dirty &&
> +		git stash push --no-keep-index &&
> +		git stash show -u --patch >../using-config
> +	) &&
> +
> +	test_cmp no-config using-config
> +'
> +
> +test_expect_success 'stash.keepindex succeeds with --patch' '
> +	test_config stash.keepindex true &&
> +	git stash --patch
> +'
> +
>   test_done
> --
> 2.43.2
> 

