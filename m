Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20DA737882A
	for <git@vger.kernel.org>; Mon, 18 May 2026 15:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779118037; cv=none; b=tLZgI/Rh2wXdpITsSdlMvZ9oCaZlGintJAfZtzhqLSeferndP+VyjOoIUCbbvB9AGCe6JrAmeRUsYF8r8dRRqTWks9NkJsJJ4hltfMqcQ3bfTu4aYCag9RiXBYkDwUvxLYedHE8/3wrAjoThOqS+KxqlBtorZqdg2TsBaV9oztg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779118037; c=relaxed/simple;
	bh=an4gvCK3/4bOucgxVCslwr1aCBuEHEwzPpEpXPtWvF4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fXmHK2N5+YBzqh+BL3lqAhSj+DUo//dRph7k3HaZL4lG7pCZJRScupg8PPH7H4U/eHA+QzxbfvivA/J6PGz51VTxDs0LpTjBTjPgB9cx1BbtRb9wD6rZcJdW2mdZj9X3TM+pQRvxU5HkDGypLC4VAhX7IwVwpt4ND1QRlGhsTcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jj1fKHQ9; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jj1fKHQ9"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-4526a8170ceso1051657f8f.2
        for <git@vger.kernel.org>; Mon, 18 May 2026 08:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779118032; x=1779722832; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=YiPi2jGsWTGVa2tnDuDvrD9odCod+UsJsZt1KV/Q598=;
        b=jj1fKHQ9CM21YydMxKGDDpKCj07HSYu7R9EzW6bA1YXIVv5XCxFRX2VR+Ow0lSqcpj
         foAlSdUG72hwustTQMNZ4rHgWnZ1qLMzD1qYEk36k7VdmiT1KsBpcPu0Ebd8/sHzoFWz
         O0mI0RPAy540vMPvnRLg7+aaUisiPZ1GE2tCiB6uHzfnW2x4rjyD7rwnFgS+bVEWSsJ2
         7PR6qCqBgocXLgn+U0jhQEKkUnidH1uT5u54PTNM5PUxEJDHGH/7FQysz1vYLfO4Xz4/
         v8701iWdi3cLhLHLtvkkRhuHnms1s66LUec8dZUQ7t8GzBCQztPma6d7QF7M8fdi6RWV
         S4jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779118032; x=1779722832;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YiPi2jGsWTGVa2tnDuDvrD9odCod+UsJsZt1KV/Q598=;
        b=gHHTAjrDdPrxfMj+c/UMOL4v3YQgFPr5sZlT9mrrd949/09LC0ysUVeKGYwD/W/9aR
         lCmKkenKvef7bmmwPEdbQo2gfbAyBniNgaVj9PJuwpcJxhKlaFFFtJVDX2aqkT/Vt3oL
         j5WCIqoBzPV008qDMrByYKk1VE1c172eGJYpOCCtFCdmsI850CqyP25lbD9/hJlEo9fU
         svxNbXJ7sjwj3KJWvD7TnSVEnq/4D1aYbYhGvnMY1Uj6DeTcW8ns9JM8379/ASSijeBa
         10Wtb/ql/RKkb8iqGgLvfkCWnPnU/5AVCAC+weJtjZgqC8GOqU2AbIdiAQiUbhaQuDOS
         q4tA==
X-Forwarded-Encrypted: i=1; AFNElJ8Zg4b+u9uwiNxV/JkyeZ9yaVbl5YFOnMd3WjIUVXZFRoBs6JkfRg6YO7EfDNPZbBWnyRU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzH/+ICJ9vgAaH/IBxSPC75pQgwmFISjiKO4yQfMHLL+tWMa6rQ
	Ag8ZHO4/5Ug4VYRXHU4cIEth2ChGu3C8aHLyDutT2W4uDJB8+ZUetna/rqkaZw==
X-Gm-Gg: Acq92OHbGmre6cQjzFYkP+anpPyJyJ8i5Yk8RyPatDAyA9wU44DEyw7onDOm008FZOr
	4h7dZ4C3pOzEhEYmrb8c18VPkqk9MwuyHObGz+F1MdSg2mEmiUo6gvQU2qG7ArCJ0z5rHc5Mx1u
	rWGVBBl41BmvLlzAZ0OdcLvBhtj8KbmFSbATj35HpSt4irNzCeqOMz8llioh2wsDbwEzPVWcDJn
	wu+Od34xwk8apiChJh68V2NF7juPOdF5em3ss2Q0stFyrBI886zGn7RQxUNkQ3njcp+plpXLE9M
	jtkvoBi10B2GMxFvQ9Gjp/GVTV2h2LwaG8daIJD14ZTok7MSOswm928h9LeB5t7DDNix5/p175r
	uQQEN0Iwd2IdfemJy5JDvvh627IYYmKywTi+icsVC7lDb6ECYL52xY7Ly3pOTY9Di0+ZaEU2x7A
	MF9tR4enjCfcspCWHdYOTghrD04j4DWSWVzZvrY/fjShxIG/UrLb+XrTqWod0RFSAOC+991TUPd
	0m4hQ==
X-Received: by 2002:a05:600c:c10b:b0:489:1c2d:211e with SMTP id 5b1f17b1804b1-48fe5fcdedemr185391975e9.5.1779118032054;
        Mon, 18 May 2026 08:27:12 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:662:5a01:509f:d84a:9a5e:1263? ([2a0a:ef40:662:5a01:509f:d84a:9a5e:1263])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48febe7e442sm81547925e9.33.2026.05.18.08.27.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2026 08:27:11 -0700 (PDT)
Message-ID: <4b7d3370-6d7a-4cbf-a02e-53db8ca58b6e@gmail.com>
Date: Mon, 18 May 2026 16:27:10 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v9 5/5] branch: add --all-remotes flag
To: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 Johannes Sixt <j6t@kdbg.org>, Harald Nordgren <haraldnordgren@gmail.com>
References: <pull.2285.v8.git.git.1778605658.gitgitgadget@gmail.com>
 <pull.2285.v9.git.git.1778700883.gitgitgadget@gmail.com>
 <6ae95d3f98212ca449cb81d3cfe332e78b8011ea.1778700883.git.gitgitgadget@gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <6ae95d3f98212ca449cb81d3cfe332e78b8011ea.1778700883.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Harald

On 13/05/2026 20:34, Harald Nordgren via GitGitGadget wrote:
> From: Harald Nordgren <haraldnordgren@gmail.com>
> 
> +`--all-remotes`::
> +	With `--forked` or `--prune-merged`, act on every
> +	configured remote in addition to any explicit _<remote>_
> +	arguments.

Why do we except additional arguments if this option includes all the 
remotes?

Thanks

Phillip

>   `-v`::
>   `-vv`::
>   `--verbose`::
> diff --git a/builtin/branch.c b/builtin/branch.c
> index bc4f4a4a18..7d45bada45 100644
> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -687,6 +687,13 @@ static void copy_or_rename_branch(const char *oldname, const char *newname, int
>   	free_worktrees(worktrees);
>   }
>   
> +static int collect_remote_name(struct remote *remote, void *cb_data)
> +{
> +	struct string_list *remote_names = cb_data;
> +	string_list_insert(remote_names, remote->name);
> +	return 0;
> +}
> +
>   static void parse_forked_args(int argc, const char **argv,
>   			      struct string_list *remote_names,
>   			      struct string_list *tracking_refs)
> @@ -776,7 +783,7 @@ static void collect_default_branch_refs(const struct string_list *remote_names,
>   	}
>   }
>   
> -static void collect_forked_set(int argc, const char **argv,
> +static void collect_forked_set(int argc, const char **argv, int all_remotes,
>   			       struct string_list *protected_default_refs,
>   			       struct string_list *out)
>   {
> @@ -789,6 +796,8 @@ static void collect_forked_set(int argc, const char **argv,
>   	};
>   
>   	parse_forked_args(argc, argv, &remote_names, &tracking_refs);
> +	if (all_remotes)
> +		for_each_remote(collect_remote_name, &remote_names);
>   
>   	refs_for_each_branch_ref(get_main_ref_store(the_repository),
>   				 collect_forked_branch, &cb);
> @@ -802,15 +811,15 @@ static void collect_forked_set(int argc, const char **argv,
>   	string_list_clear(&tracking_refs, 0);
>   }
>   
> -static int list_forked_branches(int argc, const char **argv)
> +static int list_forked_branches(int argc, const char **argv, int all_remotes)
>   {
>   	struct string_list out = STRING_LIST_INIT_DUP;
>   	struct string_list_item *item;
>   
> -	if (!argc)
> -		die(_("--forked requires at least one <remote>"));
> +	if (!argc && !all_remotes)
> +		die(_("--forked requires at least one <remote> or --all-remotes"));
>   
> -	collect_forked_set(argc, argv, NULL, &out);
> +	collect_forked_set(argc, argv, all_remotes, NULL, &out);
>   	for_each_string_list_item(item, &out)
>   		puts(item->string);
>   
> @@ -818,7 +827,8 @@ static int list_forked_branches(int argc, const char **argv)
>   	return 0;
>   }
>   
> -static int prune_merged_branches(int argc, const char **argv, int quiet)
> +static int prune_merged_branches(int argc, const char **argv,
> +				 int all_remotes, int quiet)
>   {
>   	struct string_list candidates = STRING_LIST_INIT_DUP;
>   	struct string_list protected_default_refs = STRING_LIST_INIT_DUP;
> @@ -827,10 +837,11 @@ static int prune_merged_branches(int argc, const char **argv, int quiet)
>   	int n_not_merged = 0;
>   	int ret = 0;
>   
> -	if (!argc)
> -		die(_("--prune-merged requires at least one <remote>"));
> +	if (!argc && !all_remotes)
> +		die(_("--prune-merged requires at least one <remote> or --all-remotes"));
>   
> -	collect_forked_set(argc, argv, &protected_default_refs, &candidates);
> +	collect_forked_set(argc, argv, all_remotes, &protected_default_refs,
> +			   &candidates);
>   
>   	for_each_string_list_item(item, &candidates) {
>   		const char *short_name = item->string;
> @@ -943,6 +954,7 @@ int cmd_branch(int argc,
>   	    unset_upstream = 0, show_current = 0, edit_description = 0;
>   	int forked = 0;
>   	int prune_merged = 0;
> +	int all_remotes = 0;
>   	const char *new_upstream = NULL;
>   	int noncreate_actions = 0;
>   	/* possible options */
> @@ -1000,6 +1012,9 @@ int cmd_branch(int argc,
>   			N_("list local branches forked from the given <remote>s")),
>   		OPT_BOOL(0, "prune-merged", &prune_merged,
>   			N_("delete local branches forked from the given <remote>s that are merged into their upstream")),
> +		OPT_BOOL_F(0, "all-remotes", &all_remotes,
> +			N_("with --forked or --prune-merged, act on every configured remote"),
> +			PARSE_OPT_NONEG),
>   		OPT__FORCE(&force, N_("force creation, move/rename, deletion"), PARSE_OPT_NOCOMPLETE),
>   		OPT_MERGED(&filter, N_("print only branches that are merged")),
>   		OPT_NO_MERGED(&filter, N_("print only branches that are not merged")),
> @@ -1043,6 +1058,10 @@ int cmd_branch(int argc,
>   	argc = parse_options(argc, argv, prefix, options, builtin_branch_usage,
>   			     0);
>   
> +	if (all_remotes && !forked && !prune_merged)
> +		die(_("--all-remotes requires --forked or --prune-merged"));
> +
> +
>   	if (!delete && !rename && !copy && !edit_description && !new_upstream &&
>   	    !show_current && !unset_upstream && !forked && !prune_merged &&
>   	    argc == 0)
> @@ -1096,10 +1115,10 @@ int cmd_branch(int argc,
>   				      quiet, 0, NULL);
>   		goto out;
>   	} else if (forked) {
> -		ret = list_forked_branches(argc, argv);
> +		ret = list_forked_branches(argc, argv, all_remotes);
>   		goto out;
>   	} else if (prune_merged) {
> -		ret = prune_merged_branches(argc, argv, quiet);
> +		ret = prune_merged_branches(argc, argv, all_remotes, quiet);
>   		goto out;
>   	} else if (show_current) {
>   		print_current_branch_name();
> diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
> index 885a275e36..a36e5ee80a 100755
> --- a/t/t3200-branch.sh
> +++ b/t/t3200-branch.sh
> @@ -1771,6 +1771,27 @@ test_expect_success '--forked requires at least one <remote>' '
>   	test_grep "at least one <remote>" err
>   '
>   
> +test_expect_success '--forked --all-remotes covers every configured remote' '
> +	git -C forked branch --forked --all-remotes >actual &&
> +	cat >expect <<-\EOF &&
> +	local-foreign
> +	local-one
> +	local-two
> +	main
> +	EOF
> +	test_cmp expect actual
> +'
> +
> +test_expect_success '--forked --all-remotes still validates explicit <remote>' '
> +	test_must_fail git -C forked branch --forked nope --all-remotes 2>err &&
> +	test_grep "neither a configured remote nor a remote-tracking branch" err
> +'
> +
> +test_expect_success '--all-remotes alone is rejected' '
> +	test_must_fail git -C forked branch --all-remotes 2>err &&
> +	test_grep "requires --forked or --prune-merged" err
> +'
> +
>   test_expect_success '--prune-merged: setup' '
>   	test_create_repo pm-upstream &&
>   	test_commit -C pm-upstream base &&
> @@ -1881,4 +1902,27 @@ test_expect_success 'branch -d still deletes a pruneMerged=false branch' '
>   	test_must_fail git -C pm-optout-d rev-parse --verify refs/heads/one
>   '
>   
> +test_expect_success '--prune-merged --all-remotes covers every configured remote' '
> +	test_when_finished "rm -rf pm-allremotes pm-other" &&
> +	git clone pm-upstream pm-allremotes &&
> +	test_create_repo pm-other &&
> +	test_commit -C pm-other other-base &&
> +	git -C pm-other checkout -b stable &&
> +	test_commit -C pm-other foreign-commit &&
> +	git -C pm-other branch foreign HEAD &&
> +	git -C pm-other checkout main &&
> +
> +	git -C pm-allremotes remote add other ../pm-other &&
> +	git -C pm-allremotes fetch other &&
> +	git -C pm-allremotes branch one one-commit &&
> +	git -C pm-allremotes branch --set-upstream-to=origin/next one &&
> +	git -C pm-allremotes branch foreign other/foreign &&
> +	git -C pm-allremotes branch --set-upstream-to=other/stable foreign &&
> +
> +	git -C pm-allremotes branch --prune-merged --all-remotes &&
> +
> +	test_must_fail git -C pm-allremotes rev-parse --verify refs/heads/one &&
> +	test_must_fail git -C pm-allremotes rev-parse --verify refs/heads/foreign
> +'
> +
>   test_done

