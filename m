Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6433B27E8
	for <git@vger.kernel.org>; Tue,  6 Oct 2026 09:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791278609; cv=none; b=L/ix7ulvoL+DS23L0vJNUSmLp1Le3KoZK8Uail7OE+kepAXlaqnKvVj04UjccnARBbb544fkmDmMMf+Umenn4iYkz/9vaOwYRCO7pPzi54jpGv6HEjLC7sTdVKMS5CCz6j67q0iwfmOyfpKxGdM7Iyj83xgXWYtDjsSxooX8E0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791278609; c=relaxed/simple;
	bh=Wl8nW04kgbrHlmxNv0pNmBhn2LGEbMyRm/1IqFI4f8Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZDMcjrsBvO7UO1ZS/1Xl38HfiCL+Bm9BaxqoiDmEoVZkGa6tMiyWq9khdJIv0yBuOGX3pi+ZSwmDoB84DZeBedAni22AlOtfEJAOzP4U3l8aIk1DPzrunfIa7frI86ojQY+epM8ta4UP0ZbnaslDXk0ZwqGGYa4YlLmUDYQSh2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AM67kaU7; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AM67kaU7"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a1682bff3cso13967775e9.1
        for <git@vger.kernel.org>; Tue, 06 Oct 2026 02:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791278604; x=1791883404; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=WqMehEmmnKvHZ7j8br2ULbMo0uJCxfx9SLrkMQr9YaU=;
        b=AM67kaU7feVN9ldRtveoHwaOT4h6ZO5jxozYIo5J2HLlWTFgAv4hCWNr2UX5ndXH41
         Nmxdm4BiNzxNOHiABS+KhIgd/rd+6AcvueCYd3J3ccvUsqGUqLPrTcyx6623bIXiAxwA
         DwyyJR+Ld97O7d/R7oUPuvWoNBQ/1yD0l70WcNwhCLt68+Zs9cqtrTGJDIxjsvcZqDiz
         5xvN2FbrB9fh9efdS6mbQQuXx+FUhvQyaNO+v2Br6FTy6E/1FBU/LuSZRBvdhkGjJ3S4
         d+Fnw9lv44JlBqypO/wAI6N3RNE0Xgc8OWWEmmk/1cAaK2PDY644Z1rCVq1wD7+Xp+MN
         AlBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791278604; x=1791883404;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=WqMehEmmnKvHZ7j8br2ULbMo0uJCxfx9SLrkMQr9YaU=;
        b=icYMeJteKelXf/4FE5inehUsZqL+YcdL26QN5BUfn32R+sVcTX/wLKeTHfr94/Pyia
         C6d5vCs2Iu9WVJKEiAVertPg0Xe4keweJoaXt9ck06ocbeV8SXzKsxUSkUHpl04589y8
         xvEVXzzkQfCSQFZU8PIJND44PTbqM0ArTllzrF10uIVAOEyqw8c7psFalcSYyj/MdZdw
         2nvzpSj82t9qS3BlQq1Ic59HL38FYRR63unT9Kdy7w2kNQUePcbNGXzbYucV+xyGDJR+
         6dUVD/CJZY3DbzDfAXGVHFLVAyHHap68SP/8wfcdC+z+MbUOG6hv4PNHYAupRiocVLrt
         rcFg==
X-Forwarded-Encrypted: i=1; AKwUvByEpNQkEBrNQSqRN3M8p7VGONtVZcAer0Pitm8Y7RYRGx1+toTiXBRUJwORkzjlF2dQS6w=@vger.kernel.org
X-Gm-Message-State: AFuF++lxJy4UYEW7QgpV+MeUIBB37r/nTpO1fnqR4jLCT9rPvoA5Qp2l
	iZQrFUuXfVyTMMCgVuQuYp+4l+89SH380KC1O2CgyHWCWzYZaWd240u5
X-Gm-Gg: AYBFou1lpjOX+YuVjy1EBzeiscKWa9M6TcH77n8zO6e//62A1L7b++F6vvGCsq7Ee9W
	liSBM5FPmv8TzSb8eq4VLXpayHlUph/wieaPcSbkkLuMrAs/RfUR7yTP2YdYofZB7c038H/iHiH
	WKsOJmRiqKpoSIKvEfnzDOtzCPh7FczxY+SH1oXW7eNh94jAyzYrmyW0Py1O5nxnEWx4xwfvUQw
	3d+p9dWofKLTwqXBYAgrn/DazuIgYJO0GzL0QhkzA6nsrladqkYaQ/eTnJQC2HQ28isZ90hp5O+
	QEc2a3wtLkdFuHeyGBm4hcKseHa8Ykwoi6039L/101de0kSIRb4g3POdxsq3Js5nPtUTKSrQbLd
	4JwHOixaZm7TZ9atolYjOIOSAQ/AOhSC5LFeR29C0N/SPC6P+ORacaoHksQc03uQV9Zk5byLVaU
	bsCCOyOijsXEZodmNuu1PYWEkUOmLuLpTmA7zJypmQC+CNfVjq+j167uKtbe3ZVJZpOPYtMV6If
	ZcSR80NpZ4PeWHXxKGONryDzXN20Sg28nls/hc01SqrQpctwFCX
X-Received: by 2002:a05:600c:3b1a:b0:4a0:251f:dabd with SMTP id 5b1f17b1804b1-4a1680f17f8mr155734725e9.16.1791278604077;
        Tue, 06 Oct 2026 02:23:24 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a03ff56136sm159463375e9.3.2026.10.06.02.23.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Oct 2026 02:23:23 -0700 (PDT)
Message-ID: <71131749-b624-4c81-bae2-c32a7d3f1a15@gmail.com>
Date: Tue, 6 Oct 2026 10:23:19 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 1/2] worktree: add post-worktree lifecycle hook
To: domen@cachix.org, git@vger.kernel.org
Cc: gitster@pobox.com, cdwhite3@pm.me, sunshine@sunshineco.com, ps@pks.im,
 avarab@gmail.com, test35965@gmail.com, kristofferhaugsbakk@fastmail.com,
 maciej.ciemborowicz@gmail.com, Claude Fable 5 <noreply@anthropic.com>
References: <371a01cf-2765-4cf5-b1fd-414d1b55a325@mtasv.net>
 <cover.1791152172.git.domen@cachix.org>
 <2c1c1f06-05e7-4d8c-bd29-c2a9708b443d@mtasv.net>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <2c1c1f06-05e7-4d8c-bd29-c2a9708b443d@mtasv.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Domen

On 05/10/2026 00:09, Domen Kožar wrote:
> Tools that manage per-worktree development environments need to observe
> worktrees created, moved, or removed by other programs. Wrapping the
> worktree command only helps when every caller uses the wrapper, and
> post-checkout does not run for add --no-checkout or --orphan.

There is quite a lot of implicit context in that sentance - it assumes 
the reader has read the previous discussions about this hook. It would 
be clearer if it was explicit that it was talking about (a) using a 
wrapper script to perform additional operations around "git worktree" 
and (b) using the post-checkout hook as a proxy for detecting when a new 
worktree is added.

> There is no notification for moving or removing a worktree.

A wrapper can do that though?

> Add one post-worktree hook for these operations. Pass the event name,
> worktree identifier, old absolute path, and new absolute path as four
> arguments, using an empty string for a path that does not apply.

As I've said before, I don't think the worktree id is very useful 
because git commands do not take it as an argument. Someone mentioned 
wanting to use it as a key to look up other information about the 
worktree, but different repositories can have worktrees with the same id 
so I think we'd be better passing the worktree's absolute git-dir.

There was also a comment from someone pointing out that notifying 
callers after the worktree is removed maybe too late for them to clean 
up the resources associated with that worktree. If we had a 
"worktree-event" hook we could run it before the worktree is removed, 
but after a worktree is added or moved.

Having four arguments for add and remove seems to me to be unecessarily 
complicated - why not just pass the paths that are relavent, rather than 
padding the arguments with empty strings?

I see the hook is run serially, is that really necessary?

> An
> explicit event name lets one handler manage the whole lifecycle without
> using argument count to distinguish operations, as the earlier series
> with three separate hooks did.
> 
> Run the hook in the invoking repository with its normal environment,
> rather than changing to the affected worktree. Passing both paths lets
> handlers target the new worktree when needed and keeps the execution
> context consistent when a worktree has been removed.

It also means that GIT_DIR and GIT_WORK_TREE are consistent with the 
directory that the hook is run in. The downside for adding a worktree is 
that the hook needs to clear those variables if it is going to run git 
in the new worktree.

> Run the add event after post-checkout even when that hook fails, because
> the worktree remains present. A failing lifecycle hook affects the
> command's exit status without undoing the completed operation.

Ok, that matches what we do with a failing post-checkout hook
> Preserve post-checkout's failure status if both hooks fail.

Ok

> Document the interface and cover ordinary, bare, and linked callers,
> no-checkout and orphan worktrees, relative paths, paths with spaces,
> configured hooks, and hook failures.

I'm not sure why we need separate tests for paths with spaces or orphan 
worktrees

I think adding a hook for worktree lifecycle events is a useful 
addition. Using a wrapper script is a pain because it is easy to forget 
to use it and it is hard to make it work if you have several different 
entities that want to be notified about worktrees being added or removed.

Thanks

Phillip

> Co-authored-by: Claude Fable 5 <noreply@anthropic.com>
> Signed-off-by: Domen Kožar <domen@cachix.org>
> ---
>   Documentation/config/hook.adoc |   1 +
>   Documentation/githooks.adoc    |  43 +++++++++++
>   builtin/worktree.c             |  56 ++++++++++----
>   t/t2400-worktree-add.sh        | 132 +++++++++++++++++++++++++++++++++
>   t/t2403-worktree-move.sh       | 113 ++++++++++++++++++++++++++++
>   5 files changed, 329 insertions(+), 16 deletions(-)
> 
> diff --git a/Documentation/config/hook.adoc b/Documentation/config/hook.adoc
> index 083dc60a13..501bb006f5 100644
> --- a/Documentation/config/hook.adoc
> +++ b/Documentation/config/hook.adoc
> @@ -94,6 +94,7 @@ hook.jobs::
>   	Receive a commit message file and may rewrite it in place.
>   `pre-commit`;;
>   `post-checkout`;;
> +`post-worktree`;;
>   `push-to-checkout`;;
>   `post-commit`;;
>   	Access the working tree, index, or repository state.
> diff --git a/Documentation/githooks.adoc b/Documentation/githooks.adoc
> index 145642bf05..3e25f769c5 100644
> --- a/Documentation/githooks.adoc
> +++ b/Documentation/githooks.adoc
> @@ -215,6 +215,49 @@ This hook can be used to perform repository validity checks, auto-display
>   differences from the previous HEAD if different, or set working dir metadata
>   properties.
>   
> +post-worktree
> +~~~~~~~~~~~~~
> +
> +This hook is invoked by linkgit:git-worktree[1] after a working tree is
> +added, moved, or removed. It takes four parameters: the event (`add`, `move`,
> +or `remove`), the worktree identifier (the name of its administrative
> +directory in `$GIT_COMMON_DIR/worktrees/`), the old absolute path, and the
> +new absolute path.
> +
> +The parameters for each event are:
> +
> +    post-worktree add    <id> ""         <new-path>
> +    post-worktree move   <id> <old-path> <new-path>
> +    post-worktree remove <id> <old-path> ""
> +
> +The empty strings are passed as arguments, so all events have exactly
> +four parameters.
> +
> +The hook runs in the repository where the command was invoked, following
> +the working directory and environment rules described above. It does not
> +change to the added or moved working tree. To run Git commands there,
> +clear the repository environment variables and use the new path, for
> +example:
> +
> +------------
> +(unset $(git rev-parse --local-env-vars); git -C "$4" status)
> +------------
> +
> +The `add` event runs after the new working tree has been set up, including
> +with `--no-checkout` and `--orphan`. It runs after `post-checkout`, even
> +if that hook fails. The `move` event runs after the working tree and its
> +administrative files have been moved. The `remove` event runs after the
> +working tree has been deleted or its administrative entry removed.
> +
> +The hook cannot undo the worktree operation. A non-zero exit status is
> +reflected in the command's exit status, but leaves the completed operation
> +in place. If `post-checkout` fails during `git worktree add`, its exit
> +status takes precedence over that of `post-worktree`.
> +
> +This hook can be used to set up, relocate, or tear down per-worktree
> +development environments, or to maintain registrations with external
> +tools. Hook scripts should ignore events they do not handle.
> +
>   post-merge
>   ~~~~~~~~~~
>   
> diff --git a/builtin/worktree.c b/builtin/worktree.c
> index 77ecd0f71f..0f2748080c 100644
> --- a/builtin/worktree.c
> +++ b/builtin/worktree.c
> @@ -168,6 +168,15 @@ static void delete_worktrees_dir_if_empty(void)
>   	free(path);
>   }
>   
> +static int run_post_worktree_hook(const char *event, const char *id,
> +				  const char *old_path, const char *new_path)
> +{
> +	struct run_hooks_opt hook_opt = RUN_HOOKS_OPT_INIT_FORCE_SERIAL;
> +
> +	strvec_pushl(&hook_opt.args, event, id, old_path, new_path, NULL);
> +	return run_hooks_opt(the_repository, "post-worktree", &hook_opt);
> +}
> +
>   static void prune_worktree(const char *id, const char *reason)
>   {
>   	if (show_only || verbose)
> @@ -604,21 +613,30 @@ static int add_worktree(const char *path, const char *refname,
>   	}
>   
>   	/*
> -	 * Hook failure does not warrant worktree deletion, so run hook after
> -	 * is_junk is cleared, but do return appropriate code when hook fails.
> +	 * Hook failures do not warrant worktree deletion, so run hooks after
> +	 * is_junk is cleared, but do return appropriate code when a hook
> +	 * fails.
>   	 */
> -	if (!ret && opts->checkout && !opts->orphan) {
> -		struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT_FORCE_SERIAL;
> -
> -		strvec_pushl(&opt.env, "GIT_DIR", "GIT_WORK_TREE", NULL);
> -		strvec_pushl(&opt.args,
> -			     oid_to_hex(null_oid(the_hash_algo)),
> -			     oid_to_hex(&commit->object.oid),
> -			     "1",
> -			     NULL);
> -		opt.dir = path;
> -
> -		ret = run_hooks_opt(the_repository, "post-checkout", &opt);
> +	if (!ret) {
> +		int hook_ret;
> +
> +		if (opts->checkout && !opts->orphan) {
> +			struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT_FORCE_SERIAL;
> +
> +			strvec_pushl(&opt.env, "GIT_DIR", "GIT_WORK_TREE", NULL);
> +			strvec_pushl(&opt.args,
> +				     oid_to_hex(null_oid(the_hash_algo)),
> +				     oid_to_hex(&commit->object.oid),
> +				     "1",
> +				     NULL);
> +			opt.dir = path;
> +
> +			ret = run_hooks_opt(the_repository, "post-checkout", &opt);
> +		}
> +
> +		hook_ret = run_post_worktree_hook("add", wt->id, "", wt->path);
> +		if (!ret)
> +			ret = hook_ret;
>   	}
>   
>   	strvec_clear(&child_env);
> @@ -1305,7 +1323,8 @@ static int move_worktree(int ac, const char **av, const char *prefix,
>   	struct strbuf dst = STRBUF_INIT;
>   	struct strbuf errmsg = STRBUF_INIT;
>   	const char *reason = NULL;
> -	char *path;
> +	char *old_path, *path;
> +	int ret;
>   
>   	ac = parse_options(ac, av, prefix, options, git_worktree_move_usage,
>   			   0);
> @@ -1348,14 +1367,17 @@ static int move_worktree(int ac, const char **av, const char *prefix,
>   		    errmsg.buf);
>   	strbuf_release(&errmsg);
>   
> +	old_path = xstrdup(wt->path);
>   	if (rename(wt->path, dst.buf) == -1)
>   		die_errno(_("failed to move '%s' to '%s'"), wt->path, dst.buf);
>   
>   	update_worktree_location(wt, dst.buf, use_relative_paths);
> +	ret = run_post_worktree_hook("move", wt->id, old_path, wt->path);
>   
> +	free(old_path);
>   	strbuf_release(&dst);
>   	free_worktrees(worktrees);
> -	return 0;
> +	return ret;
>   }
>   
>   /*
> @@ -1473,6 +1495,8 @@ static int remove_worktree(int ac, const char **av, const char *prefix,
>   	ret |= delete_git_dir(wt->id);
>   	delete_worktrees_dir_if_empty();
>   
> +	ret |= run_post_worktree_hook("remove", wt->id, wt->path, "");
> +
>   	free_worktrees(worktrees);
>   	return ret;
>   }
> diff --git a/t/t2400-worktree-add.sh b/t/t2400-worktree-add.sh
> index bdcca97633..65fec976b5 100755
> --- a/t/t2400-worktree-add.sh
> +++ b/t/t2400-worktree-add.sh
> @@ -1172,6 +1172,138 @@ test_expect_success '"add" in bare repo invokes post-checkout hook' '
>   	test_cmp hook.expect goozy/hook.actual
>   '
>   
> +# Install a post-worktree hook and write the output expected for adding
> +# worktree $1. Repo $2 defaults to "."; the caller worktree is $3.
> +post_worktree_add_hook () {
> +	test_when_finished "rm -rf .git/hooks" &&
> +	mkdir .git/hooks &&
> +	test_hook -C "$2" post-worktree <<-\EOF &&
> +	test "$#" = 4 &&
> +	{
> +		printf "%s\n" "$@" &&
> +		test-tool path-utils real_path . &&
> +		git rev-parse --absolute-git-dir
> +	} >hook.actual
> +	EOF
> +	{
> +		test_write_lines add "$1" "" "$(pwd)/$1" &&
> +		(cd "${3:-${2:-.}}" && test-tool path-utils real_path .) &&
> +		git -C "${3:-${2:-.}}" rev-parse --absolute-git-dir
> +	} >hook.expect
> +}
> +
> +test_expect_success '"add" invokes post-worktree hook' '
> +	post_worktree_add_hook wanda &&
> +	git worktree add wanda &&
> +	test_cmp hook.expect hook.actual
> +'
> +
> +test_expect_success '"add" in other worktree invokes post-worktree hook there' '
> +	post_worktree_add_hook wilbur "" wanda &&
> +	git -C wanda worktree add ../wilbur &&
> +	test_cmp hook.expect wanda/hook.actual
> +'
> +
> +test_expect_success '"add --no-checkout" still invokes post-worktree hook' '
> +	post_worktree_add_hook wendy &&
> +	git worktree add --no-checkout wendy &&
> +	test_cmp hook.expect hook.actual
> +'
> +
> +test_expect_success '"add --orphan" invokes post-worktree hook' '
> +	post_worktree_add_hook winnie &&
> +	git worktree add --orphan winnie &&
> +	test_cmp hook.expect hook.actual
> +'
> +
> +test_expect_success '"add" in bare repo invokes post-worktree hook there' '
> +	rm -rf bare2 &&
> +	git clone --bare . bare2 &&
> +	post_worktree_add_hook willow bare2 &&
> +	git -C bare2 worktree add --detach ../willow &&
> +	test_cmp hook.expect bare2/hook.actual
> +'
> +
> +test_expect_success '"add" runs post-worktree after post-checkout' '
> +	test_when_finished "rm -rf .git/hooks" &&
> +	mkdir .git/hooks &&
> +	test_hook post-checkout <<-\EOF &&
> +	echo post-checkout >>"$(git rev-parse --git-common-dir)/hooks.actual"
> +	EOF
> +	test_hook post-worktree <<-\EOF &&
> +	echo post-worktree >>"$(git rev-parse --git-common-dir)/hooks.actual"
> +	EOF
> +	test_write_lines post-checkout post-worktree >hooks.expect &&
> +	git worktree add wobble &&
> +	test_cmp hooks.expect .git/hooks.actual
> +'
> +
> +test_expect_success 'failing post-checkout hook does not suppress post-worktree hook' '
> +	test_when_finished "rm -rf .git/hooks" &&
> +	mkdir .git/hooks &&
> +	test_hook post-checkout <<-\EOF &&
> +	exit 2
> +	EOF
> +	test_hook post-worktree <<-\EOF &&
> +	>post-worktree.ran &&
> +	exit 3
> +	EOF
> +	test_expect_code 2 git worktree add wozzle &&
> +	test_path_is_file post-worktree.ran
> +'
> +
> +test_expect_success 'failing post-worktree hook leaves worktree in place' '
> +	test_when_finished "rm -rf .git/hooks" &&
> +	mkdir .git/hooks &&
> +	test_hook post-worktree <<-\EOF &&
> +	exit 1
> +	EOF
> +	test_expect_code 1 git worktree add wilma &&
> +	git worktree list --porcelain >out &&
> +	test_grep -F "worktree $(pwd)/wilma" out
> +'
> +
> +test_expect_success 'failed "add" does not invoke post-worktree hook' '
> +	test_when_finished "rm -rf .git/hooks occupied" &&
> +	mkdir .git/hooks &&
> +	test_hook post-worktree <<-\EOF &&
> +	>hook.ran
> +	EOF
> +	mkdir occupied &&
> +	: >occupied/blocker &&
> +	test_must_fail git worktree add occupied &&
> +	test_path_is_missing hook.ran
> +'
> +
> +test_expect_success 'post-worktree add gets absolute path with relative worktrees' '
> +	test_when_finished "rm -rf relhook" &&
> +	git init relhook &&
> +	test_commit -C relhook base &&
> +	test_hook -C relhook post-worktree <<-\EOF &&
> +	test "$#" = 4 &&
> +	printf "%s\n" "$@" >hook.actual
> +	EOF
> +	git -C relhook worktree add --relative-paths --detach wt &&
> +	test_write_lines add wt "" "$(pwd)/relhook/wt" >hook.expect &&
> +	test_cmp hook.expect relhook/hook.actual
> +'
> +
> +test_expect_success 'configured post-worktree hook preserves paths with spaces' '
> +	test_when_finished "rm -rf confighook" &&
> +	git init confighook &&
> +	test_commit -C confighook base &&
> +	write_script confighook/record-hook <<-\EOF &&
> +	test "$#" = 4 &&
> +	printf "%s\n" "$@" >hook.actual
> +	EOF
> +	git -C confighook config hook.lifecycle.command ./record-hook &&
> +	git -C confighook config hook.lifecycle.event post-worktree &&
> +	git -C confighook worktree add --detach "wt with spaces" &&
> +	id=$(basename "$(git -C "confighook/wt with spaces" rev-parse --absolute-git-dir)") &&
> +	test_write_lines add "$id" "" "$(pwd)/confighook/wt with spaces" >hook.expect &&
> +	test_cmp hook.expect confighook/hook.actual
> +'
> +
>   test_expect_success '"add" an existing but missing worktree' '
>   	git worktree add --detach pneu &&
>   	test_must_fail git worktree add --detach pneu &&
> diff --git a/t/t2403-worktree-move.sh b/t/t2403-worktree-move.sh
> index 69768c1207..11ef81dce8 100755
> --- a/t/t2403-worktree-move.sh
> +++ b/t/t2403-worktree-move.sh
> @@ -82,6 +82,59 @@ test_expect_success 'move worktree' '
>   	test_cmp expected2 actual2
>   '
>   
> +test_expect_success '"move" invokes post-worktree hook in the calling repository' '
> +	test_hook post-worktree <<-\EOF &&
> +	test "$#" = 4 || exit 1
> +	test "$1" = move || exit 0
> +	{
> +		printf "%s\n" "$@" &&
> +		test-tool path-utils real_path . &&
> +		git rev-parse --absolute-git-dir
> +	} >hook.actual
> +	EOF
> +	git worktree add --detach hook-source &&
> +	git worktree move hook-source hook-destination &&
> +	{
> +		test_write_lines move hook-source "$(pwd)/hook-source" "$(pwd)/hook-destination" &&
> +		test-tool path-utils real_path . &&
> +		git rev-parse --absolute-git-dir
> +	} >hook.expect &&
> +	test_cmp hook.expect hook.actual
> +'
> +
> +test_expect_success 'failing post-worktree move event leaves worktree moved' '
> +	test_hook post-worktree <<-\EOF &&
> +	test "$1" = move || exit 0
> +	exit 1
> +	EOF
> +	git worktree add --detach hook-failing-source &&
> +	test_must_fail git worktree move hook-failing-source hook-failing-destination &&
> +	test_path_is_missing hook-failing-source &&
> +	git -C hook-failing-destination status --porcelain >actual &&
> +	test_must_be_empty actual
> +'
> +
> +test_expect_success 'post-worktree move keeps the ID and passes absolute paths with spaces' '
> +	test_when_finished "rm -rf movehook" &&
> +	git init movehook &&
> +	test_commit -C movehook base &&
> +	git -C movehook worktree add --relative-paths --detach "source tree" &&
> +	git -C movehook worktree add --detach caller &&
> +	id=$(basename "$(git -C "movehook/source tree" rev-parse --absolute-git-dir)") &&
> +	test_hook -C movehook post-worktree <<-\EOF &&
> +	test "$#" = 4 &&
> +	{
> +		printf "%s\n" "$@" &&
> +		git rev-parse --show-toplevel
> +	} >hook.actual
> +	EOF
> +	git -C movehook/caller worktree move --relative-paths "../source tree" "../destination tree" &&
> +	test_write_lines move "$id" "$(pwd)/movehook/source tree" \
> +		"$(pwd)/movehook/destination tree" "$(pwd)/movehook/caller" >hook.expect &&
> +	test_cmp hook.expect movehook/caller/hook.actual &&
> +	test_path_is_dir "movehook/destination tree"
> +'
> +
>   test_expect_success 'move main worktree' '
>   	test_must_fail git worktree move . def
>   '
> @@ -246,6 +299,66 @@ test_expect_success 'not remove a repo with initialized submodule' '
>   	)
>   '
>   
> +test_expect_success '"remove" invokes post-worktree remove event' '
> +	test_hook post-worktree <<-\EOF &&
> +	test "$#" = 4 || exit 1
> +	test "$1" = remove || exit 0
> +	printf "%s\n" "$@" >hook.actual
> +	EOF
> +	git worktree add --detach wt-hooked &&
> +	git worktree remove wt-hooked &&
> +	test_write_lines remove wt-hooked "$(pwd)/wt-hooked" "" >hook.expect &&
> +	test_cmp hook.expect hook.actual
> +'
> +
> +test_expect_success '"remove" of missing worktree invokes post-worktree hook' '
> +	test_when_finished "rm -rf wt-moved-away" &&
> +	test_hook post-worktree <<-\EOF &&
> +	test "$1" = remove || exit 0
> +	printf "%s\n" "$@" >hook.actual
> +	EOF
> +	rm -f hook.actual &&
> +	git worktree add --detach wt-elsewhere &&
> +	mv wt-elsewhere wt-moved-away &&
> +	git worktree remove wt-elsewhere &&
> +	test_write_lines remove wt-elsewhere "$(pwd)/wt-elsewhere" "" >hook.expect &&
> +	test_cmp hook.expect hook.actual
> +'
> +
> +test_expect_success 'refused "remove" does not invoke post-worktree hook' '
> +	git worktree add --detach wt-kept &&
> +	test_when_finished "git worktree remove --force --force wt-kept || :" &&
> +	test_hook post-worktree <<-\EOF &&
> +	>hook.ran
> +	EOF
> +	git worktree lock wt-kept &&
> +	test_must_fail git worktree remove wt-kept &&
> +	test_path_is_missing hook.ran
> +'
> +
> +test_expect_success 'failing post-worktree remove event fails "remove", worktree is gone' '
> +	test_hook post-worktree <<-\EOF &&
> +	test "$1" = remove || exit 0
> +	exit 1
> +	EOF
> +	git worktree add --detach wt-doomed &&
> +	test_must_fail git worktree remove wt-doomed &&
> +	test_path_is_missing wt-doomed &&
> +	test_path_is_missing .git/worktrees/wt-doomed
> +'
> +
> +test_expect_success 'post-worktree remove preserves paths with spaces' '
> +	git worktree add --detach "remove tree" &&
> +	id=$(basename "$(git -C "remove tree" rev-parse --absolute-git-dir)") &&
> +	test_hook post-worktree <<-\EOF &&
> +	test "$#" = 4 &&
> +	printf "%s\n" "$@" >hook.actual
> +	EOF
> +	git worktree remove "remove tree" &&
> +	test_write_lines remove "$id" "$(pwd)/remove tree" "" >hook.expect &&
> +	test_cmp hook.expect hook.actual
> +'
> +
>   test_expect_success 'move worktree with absolute path to relative path' '
>   	test_config worktree.useRelativePaths false &&
>   	git worktree add ./absolute &&

