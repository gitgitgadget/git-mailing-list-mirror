Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14D937DABE
	for <git@vger.kernel.org>; Tue, 23 Jun 2026 13:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782222574; cv=none; b=Rax03Flu7vt7T+jsIZgKezIat7NJjuKEyguRZQyueewJm8jJwkRKS1t73rz4wQ5DmH7RZRv69uJFWvWZ3xrLx3Q/KJxd0wCm4w484Smv1mvgb6vtEQvO2zTNZvlw9JhYyceMuohVb/hh8EUNulbTFdrq5CbpQH2qr7DJ8kyOO6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782222574; c=relaxed/simple;
	bh=hvAikZdTFNUQj7xq7z90hvMGVR9irSQ0nrK6tUg4F5s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GMvQuGkUStid2tj10hb1Iun93/MnSk0qAnIPBCA1eP7EC1OFZRJfA24uhny7+igYzjhGfVAvnHRdG5Rv4oC5aylyp/f7B7VgZtQjZ+bx+4okHeCPxuJaRUB7cUr49AYtMLuT5MlTiqJwuaoyMZOw46sI84cG1Y7QfnA6nGmKMYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qv7Gem8N; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qv7Gem8N"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-693c69b97e7so9460046a12.2
        for <git@vger.kernel.org>; Tue, 23 Jun 2026 06:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782222571; x=1782827371; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=YoS4epn1ZYzQlFMgTws+oQhSYQ5wsX/JxJN6Ij/yKv8=;
        b=qv7Gem8Nars1axwAh58jqO4RyLkjarFuyxsbeXEw3p9VvheoaO5GM5PWtJtpLZtG1F
         R0bM91d5j4GIOkle6vSkQks8lQ9gXiXQssp8Y3BzJTdeMP4NMVhw50MPmHYy5o7iUsQG
         8+l2x94Nb1jjmrvmKmjH58r/p5ec1wO4A5CMsGl8ybIcsXkNfoc/GEuTCK/8mKqXmUNi
         eYOFiBfj3c8Vqxwkal0episC8K7iGsVVyq8SOtDgkRrIfOydGXfYI4s29F0Q5TphqKdP
         yCSZAhPFTofE8WMtsoLKhFpd6DrZSJZzQ4OJ/pYdODqi+S5Jz/rE36XxDCV4U/ZJE1gz
         2rzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782222571; x=1782827371;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YoS4epn1ZYzQlFMgTws+oQhSYQ5wsX/JxJN6Ij/yKv8=;
        b=nGLveL0TaYsOGD1SNnaluF3Wjoil1tuxCvc/xsuUkNxKQUjeDQeFsPB/6n/gqORi2t
         i5bFLPhlJT+Uow21FjnN2+IfkIAejRW70sydkkDJPYWK+0FO3ZTqKMVHflOXudLZA/I3
         6dwPxyQhKODbwSbuEkWKZWCqmG0Ei3i9+yPfeFAwEqr+erSKhZdEIdSfSrH4SpHOa/YG
         X8ilouU4EMpKIwimTawdLWRyZHrn34/YFnhZCFkI21bGrDf/7ff8N8Qf+8mvyJrD10pe
         GMoiaXO6XABqW+cVVn8gCLIJzugkhj4cldD23qsLsCoTP3rT3ZEnVRHZbA2tnw9NKhzw
         wbwQ==
X-Forwarded-Encrypted: i=1; AFNElJ9kwAwstCIt4VWFeQG/XcRNC15JbZnhT1xffJf7l6tRQO0wKeYeXmg6XE/YjUpFDBIfIjM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMbhb0pEqF6uRDZJxj0SV0paz/SiLgZB7P/27LAXkkG7rdh2R4
	fmpwvcisRG9XWJswfBKXljWpEukUTSYsE8TUM/PB6roPnFPzAnI3WLj+
X-Gm-Gg: AfdE7ck76mFZpqsLbMJhcB0Diir746pWLsTvoElV6hK/mzk3542flve1jJsr6vCbjAB
	B7mkmDAFFguvZNP3X7MBpGkztz7VRY+a3YSejY8wChf1c5lgCqaP5BJQAc4yQiYqPRUucxCJeJU
	9jXFQuBXzlQkWpg8ilB2XPmHLjFLoQbNIQlvtdY0sLrdXxlSwHKcTZLaELnPTVO3oih8QGPP6QE
	SXH3Zfumvm2wBopMH5IRl1n8b1vPASCERSIsAco6jG6loHEAYLJa7YL6aE0KKzGNXI/rRLtFcQm
	ZwhIWm7c+ghm/wfgnQya2yT3CAnmItZhsbtQ0bmwufvGQryvLqzRMF4O9DRZzmclgvilMtV250H
	MoJy6LU3EMI+bbE7TBtvaFuoDzrYqny5ydKr2gvqYjmWHQABkX7LBUjU18uQwhj6gR5RF5tJTVY
	cEkf8PIwAdxBMBhC7LI73YRTK3AD91Y0fVaRqURfI2IIpU5YePOtRIJGTxZ8WPI6NFsMw=
X-Received: by 2002:a05:6402:2806:b0:697:df4c:13f4 with SMTP id 4fb4d7f45d1cf-697df4c149fmr1142429a12.5.1782222570604;
        Tue, 23 Jun 2026 06:49:30 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:69a:b801:201a:26ab:8d41:fb43? ([2a0a:ef40:69a:b801:201a:26ab:8d41:fb43])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6977be64ddasm4711150a12.28.2026.06.23.06.49.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jun 2026 06:49:30 -0700 (PDT)
Message-ID: <12998c3a-ff69-4a98-9ed6-18aa0224e75e@gmail.com>
Date: Tue, 23 Jun 2026 14:49:29 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v14 2/2] checkout: extend --track with a "fetch" mode to
 refresh start-point
To: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>,
 "D. Ben Knoble" <ben.knoble@gmail.com>,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 Marc Branchaud <marcnarc@gmail.com>,
 Harald Nordgren <haraldnordgren@gmail.com>
References: <pull.2281.v13.git.git.1779565714.gitgitgadget@gmail.com>
 <pull.2281.v14.git.git.1781786652.gitgitgadget@gmail.com>
 <8518f090b1069a02d40c710975528ad118776b67.1781786652.git.gitgitgadget@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <8518f090b1069a02d40c710975528ad118776b67.1781786652.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Harald

On 18/06/2026 13:44, Harald Nordgren via GitGitGadget wrote:
> From: Harald Nordgren <haraldnordgren@gmail.com>
> 
> Add a "fetch" mode to the "--track" option of "git checkout" / "git
> switch" that refreshes <start-point> before checking it out:
> 
>      git checkout -b new_branch --track=fetch origin/some-branch
> 
> is shorthand for
> 
>      git fetch origin some-branch
>      git checkout -b new_branch --track origin/some-branch
> 
> Identify the remote whose configured fetch refspec maps to
> <start-point> using find_tracking_remote_for_ref() (the same lookup
> "--track" uses to pick which remote to record in
> branch.<name>.remote), then run "git fetch <remote> <src-ref>" for
> just that ref so other remote-tracking branches are left untouched.
> When <start-point> is a bare <remote> (e.g. "origin"), follow
> refs/remotes/<remote>/HEAD to learn which branch to refresh. If
> "git fetch" fails but the remote-tracking ref already exists locally,
> warn and proceed from the existing tip; otherwise abort.

This describes the feature well, but does not really explain why it is 
convenient to have a shorthand for "git fetch ... && git checkout -b 
...". For example if the reason is that in a fast-moving project you 
want to start your new work off the latest upstream changes to minimize 
the chance of merge conflicts or duplicated work it would be useful to 
say that. As Junio has said the implementation looks pretty solid I've 
left a few comments below, but the important thing to do first is to 
convince others that this is a useful feature and why it is worth 
blurring the separation between fetch and checkout. You can do that 
without sending a new version.

> diff --git a/Documentation/git-checkout.adoc b/Documentation/git-checkout.adoc
> index a8b3b8c2e2..20b6cae60e 100644
> --- a/Documentation/git-checkout.adoc
> +++ b/Documentation/git-checkout.adoc
> @@ -158,11 +158,26 @@ of it").
>   	resets _<branch>_ to the start point instead of failing.
>   
>   `-t`::
> -`--track[=(direct|inherit)]`::
> +`--track[=(direct|inherit|fetch)[,...]]`::
>   	When creating a new branch, set up "upstream" configuration. See
>   	`--track` in linkgit:git-branch[1] for details. As a convenience,
>   	--track without -b implies branch creation.
>   +
> +The argument is a comma-separated list. `direct` (the default) and
> +`inherit` select the tracking mode and are mutually exclusive. Adding
> +`fetch` requests that the remote be fetched before _<start-point>_ is
> +resolved, so the new branch starts from a fresh tip: when
> +_<start-point>_ is in _<remote>/<branch>_ form, only that branch is
> +updated; when _<start-point>_ is a bare _<remote>_ (e.g. `origin`), the
> +branch named by _<remote>/HEAD_ is updated, and the checkout fails
> +with a hint to configure that symref if it is not set. The checkout
> +also fails if no configured remote's fetch refspec maps to
> +_<start-point>_, or if more than one does (in which case the `fetch`
> +cannot be unambiguously routed). If the fetch itself fails and the
> +corresponding remote-tracking ref already exists, a warning is printed
> +and the checkout proceeds from the existing tip; otherwise the checkout
> +is aborted.

Nicely explained

> +static void fetch_remote_for_start_point(const char *arg, int quiet)
> +{
> +	struct strbuf dst = STRBUF_INIT;
> +	struct tracking tracking;
> +	struct string_list tracking_srcs = STRING_LIST_INIT_DUP;
> +	struct string_list ambiguous_remotes = STRING_LIST_INIT_DUP;
> +	struct child_process cmd = CHILD_PROCESS_INIT;
> +	struct object_id oid;
> +	struct remote *named_remote;
> +	int bare_ns;
> +
> +	strbuf_addf(&dst, "refs/remotes/%s", arg);
> +	if (check_refname_format(dst.buf, 0))
> +		die(_("cannot fetch start-point '%s': not a valid "
> +		      "remote-tracking name"), arg);
> +
> +	named_remote = remote_get(arg);
> +	bare_ns = !strchr(arg, '/') ||
> +		(named_remote && remote_is_configured(named_remote, 1));
> +	if (bare_ns) {
> +		char *head_path = xstrfmt("refs/remotes/%s/HEAD", arg);
> +		const char *head_target =
> +			refs_resolve_ref_unsafe(get_main_ref_store(the_repository),
> +						head_path,
> +						RESOLVE_REF_READING |
> +						RESOLVE_REF_NO_RECURSE,

Why do we use RESOLVE_REF_NO_RECURSE here? This should match whatever 
"git checkout -b <remote>" does.

> +						&oid, NULL);
> +		if (head_target &&
> +		    starts_with(head_target, dst.buf) &&
> +		    head_target[dst.len] == '/' &&
> +		    !check_refname_format(head_target, 0)) {

I don't think there is any need to call check_refname_format() here - 
you're using the result of reading a ref, not some untrusted input.

> +			strbuf_reset(&dst);
> +			strbuf_addstr(&dst, head_target);
> +			bare_ns = 0;
> +		}
> +		free(head_path);
> +	}
> +
> +	memset(&tracking, 0, sizeof(tracking));

When you want to zero initialize a stack variable it is easier, clearer 
and less error-prone to initialize it by adding "= {0};" where it is 
declared.

> +	tracking.spec.dst = dst.buf;
> +	tracking.srcs = &tracking_srcs;
> +	find_tracking_remote_for_ref(&tracking, &ambiguous_remotes);
> +
> +	if (tracking.matches > 1) {
> +		int status = die_message(_("cannot fetch start-point '%s': "
> +					   "fetch refspecs of multiple remotes "
> +					   "map to '%s'"), arg, dst.buf);
> +		advise_ambiguous_fetch_refspec(dst.buf, &ambiguous_remotes);
> +		exit(status);
> +	}
> +
> +	if (!tracking.matches) {
> +		if (bare_ns && named_remote &&
> +		    remote_is_configured(named_remote, 1))
> +			die(_("cannot fetch start-point '%s': "
> +			      "'refs/remotes/%s/HEAD' is not set; run "
> +			      "'git remote set-head %s --auto' to set it")

This is quite a long message for a single line - breaking the line and 
putting the suggested command on a separate line would make it clearer. 
Something like

cannot fetch start-point 'origin' because 'refs/remotes/origin/HEAD'
does not exist. To create it run

     git remote set-head origin --auto

> +			    arg, arg, arg);
> +		die(_("cannot fetch start-point '%s': no configured remote's "
> +		      "fetch refspec matches it"), arg);
> +	}
> +
> +	strvec_push(&cmd.args, "fetch");
> +	if (quiet)
> +		strvec_push(&cmd.args, "--quiet");
> +	strvec_pushl(&cmd.args, tracking.remote,
> +		     tracking_srcs.items[0].string, NULL);
> +	cmd.git_cmd = 1;
> +	if (run_command(&cmd)) {
> +		if (!refs_read_ref(get_main_ref_store(the_repository),
> +				   dst.buf, &oid))

You can use refs_ref_exists() to check a ref exists which avoids 
declaring "oid" which we're not interested in here.

> +			warning(_("failed to fetch start-point '%s'; "
> +				  "using existing '%s'"), arg, dst.buf);
> +		else
> +			die(_("failed to fetch start-point '%s'"), arg);
> +	}
> +
> +	string_list_clear(&tracking_srcs, 0);
> +	string_list_clear(&ambiguous_remotes, 0);
> +	strbuf_release(&dst);
> +}
> +
> +static int parse_opt_checkout_track(const struct option *opt,
> +				    const char *arg, int unset)
> +{
> +	struct checkout_opts *opts = opt->value;
> +	struct string_list tokens = STRING_LIST_INIT_DUP;
> +	struct string_list_item *item;
> +	int saw_direct = 0;
> +	int ret = 0;
> +
> +	opts->fetch = 0;
> +	if (unset) {
> +		opts->track = BRANCH_TRACK_NEVER;
> +		return 0;
> +	}
> +	opts->track = BRANCH_TRACK_EXPLICIT;
> +	if (!arg)
> +		return 0;
> +
> +	string_list_split(&tokens, arg, ",", -1);
> +	for_each_string_list_item(item, &tokens) {
> +		if (!strcmp(item->string, "fetch"))
> +			opts->fetch = 1;
> +		else if (!strcmp(item->string, "direct"))
> +			saw_direct = 1;
> +		else if (!strcmp(item->string, "inherit"))
> +			opts->track = BRANCH_TRACK_INHERIT;
> +		else {
> +			ret = error(_("option `%s' expects \"%s\", \"%s\", "
> +				      "or \"%s\""),
> +				    "--track", "direct", "inherit", "fetch");
> +			goto out;
> +		}
> +	}
> +	if (saw_direct && opts->track == BRANCH_TRACK_INHERIT)
> +		ret = error(_("option `%s' cannot combine \"%s\" and \"%s\""),
> +			    "--track", "direct", "inherit");

This parsing looks good
> diff --git a/t/t7201-co.sh b/t/t7201-co.sh
> index 7613b1d2a4..1e321b1512 100755
> --- a/t/t7201-co.sh
> +++ b/t/t7201-co.sh
> @@ -870,4 +870,280 @@ test_expect_success 'tracking info copied with autoSetupMerge=inherit' '
>   	test_cmp_config "" --default "" branch.main2.merge
>   '

I've not read the tests in detail but there seem to be an awful lot of 
them. We only need to test each thing once so for example if we test

     git checkout --track=fetch -b <remote-ref>

with a fetch refspec, that maps refs/heads/*:refs/remotes/origin/xxx/* 
then we don't need to test it without that refspec. I notice you use 
"namespace" below with is confusing because it is not referring to the 
feature described in the gitnamespaces(7) man page.

Try and avoid

     test $a = $b

as it makes it hard to debug failing tests. Instead I think you can use 
test_cmp_rev in this case.

Thanks

Phillip

> +test_expect_success 'setup upstream for --track=fetch tests' '
> +	git checkout main &&
> +	git init fetch_upstream &&
> +	test_commit -C fetch_upstream u_main &&
> +	git remote add fetch_upstream fetch_upstream &&
> +	git fetch fetch_upstream &&
> +	git -C fetch_upstream checkout -b fetch_new &&
> +	test_commit -C fetch_upstream u_new
> +'
> +
> +test_expect_success 'checkout --track=fetch -b picks up branch created upstream after clone' '
> +	git checkout main &&
> +	test_must_fail git rev-parse --verify refs/remotes/fetch_upstream/fetch_new &&
> +	git checkout --track=fetch -b local_new fetch_upstream/fetch_new &&
> +	test_cmp_rev refs/remotes/fetch_upstream/fetch_new HEAD &&
> +	test_cmp_config fetch_upstream branch.local_new.remote &&
> +	test_cmp_config refs/heads/fetch_new branch.local_new.merge
> +'
> +
> +test_expect_success 'checkout --track=fetch <remote>/<branch> leaves other tracking branches untouched' '
> +	git checkout main &&
> +	git -C fetch_upstream checkout -b fetch_target &&
> +	test_commit -C fetch_upstream u_target_pre &&
> +	git -C fetch_upstream checkout -b fetch_other &&
> +	test_commit -C fetch_upstream u_other_pre &&
> +	git fetch fetch_upstream &&
> +	other_before=$(git rev-parse refs/remotes/fetch_upstream/fetch_other) &&
> +	git -C fetch_upstream checkout fetch_target &&
> +	test_commit -C fetch_upstream u_target_post &&
> +	git -C fetch_upstream checkout fetch_other &&
> +	test_commit -C fetch_upstream u_other_post &&
> +	git checkout --track=fetch -b local_target fetch_upstream/fetch_target &&
> +	test_cmp_rev refs/remotes/fetch_upstream/fetch_target HEAD &&
> +	test "$(git rev-parse refs/remotes/fetch_upstream/fetch_other)" = "$other_before"
> +'
> +
> +test_expect_success 'checkout --track=fetch with bare remote name fetches only <remote>/HEAD target' '
> +	git checkout main &&
> +	git -C fetch_upstream checkout main &&
> +	git remote set-head fetch_upstream main &&
> +	git -C fetch_upstream checkout -b fetch_unrelated &&
> +	test_commit -C fetch_upstream u_unrelated_pre &&
> +	git fetch fetch_upstream fetch_unrelated &&
> +	unrelated_before=$(git rev-parse refs/remotes/fetch_upstream/fetch_unrelated) &&
> +	git -C fetch_upstream checkout main &&
> +	test_commit -C fetch_upstream u_main_post &&
> +	git -C fetch_upstream checkout fetch_unrelated &&
> +	test_commit -C fetch_upstream u_unrelated_post &&
> +	git checkout --track=fetch -b local_from_remote fetch_upstream &&
> +	test_cmp_rev refs/remotes/fetch_upstream/main HEAD &&
> +	test "$(git rev-parse refs/remotes/fetch_upstream/fetch_unrelated)" = "$unrelated_before"
> +'
> +
> +test_expect_success 'checkout --track=fetch aborts and does not create branch when no existing ref' '
> +	git checkout main &&
> +	test_might_fail git branch -D bogus &&
> +	test_must_fail git checkout --track=fetch -b bogus fetch_upstream/does_not_exist &&
> +	test_must_fail git rev-parse --verify refs/heads/bogus
> +'
> +
> +test_expect_success 'checkout --track=fetch warns and proceeds when fetch fails but ref exists' '
> +	git checkout main &&
> +	git -C fetch_upstream checkout -b fetch_offline &&
> +	test_commit -C fetch_upstream u_offline &&
> +	git fetch fetch_upstream fetch_offline &&
> +	saved_url=$(git config remote.fetch_upstream.url) &&
> +	test_when_finished "git config remote.fetch_upstream.url \"$saved_url\"" &&
> +	git config remote.fetch_upstream.url ./does-not-exist &&
> +	git checkout --track=fetch -b local_offline fetch_upstream/fetch_offline 2>err &&
> +	test_grep "failed to fetch" err &&
> +	test_cmp_rev refs/remotes/fetch_upstream/fetch_offline HEAD
> +'
> +
> +test_expect_success 'checkout --track=fetch resolves through configured fetch refspec' '
> +	git checkout main &&
> +	git remote add fetch_custom ./fetch_upstream &&
> +	test_when_finished "git remote remove fetch_custom" &&
> +	git config --replace-all remote.fetch_custom.fetch \
> +		"+refs/heads/*:refs/remotes/custom-ns/*" &&
> +	git -C fetch_upstream checkout -b fetch_refspec &&
> +	test_commit -C fetch_upstream u_refspec &&
> +	test_must_fail git rev-parse --verify refs/remotes/custom-ns/fetch_refspec &&
> +	git checkout --track=fetch -b local_refspec custom-ns/fetch_refspec &&
> +	test_cmp_rev refs/remotes/custom-ns/fetch_refspec HEAD
> +'
> +
> +test_expect_success 'checkout --track=fetch on namespace bare name follows <ns>/HEAD' '
> +	git checkout main &&
> +	git remote add fetch_ns ./fetch_upstream &&
> +	test_when_finished "git remote remove fetch_ns" &&
> +	test_when_finished "git update-ref -d refs/remotes/ns_alias/HEAD" &&
> +	git config --replace-all remote.fetch_ns.fetch \
> +		"+refs/heads/*:refs/remotes/ns_alias/*" &&
> +	git fetch fetch_ns &&
> +	git symbolic-ref refs/remotes/ns_alias/HEAD refs/remotes/ns_alias/main &&
> +	git -C fetch_upstream checkout main &&
> +	test_commit -C fetch_upstream u_ns_post &&
> +	git checkout --track=fetch -b local_ns ns_alias &&
> +	test_cmp_rev refs/remotes/ns_alias/main HEAD &&
> +	test_cmp_config fetch_ns branch.local_ns.remote &&
> +	test_cmp_config refs/heads/main branch.local_ns.merge
> +'
> +
> +test_expect_success '--track=fetch on bare hierarchical remote name follows <ns>/HEAD' '
> +	git checkout main &&
> +	git remote add nested/bare ./fetch_upstream &&
> +	test_when_finished "git remote remove nested/bare" &&
> +	test_when_finished "git update-ref -d refs/remotes/nested/bare/HEAD" &&
> +	git fetch nested/bare &&
> +	git symbolic-ref refs/remotes/nested/bare/HEAD \
> +		refs/remotes/nested/bare/main &&
> +	git -C fetch_upstream checkout main &&
> +	test_commit -C fetch_upstream u_nested_bare_post &&
> +	git checkout --track=fetch -b local_nested_bare nested/bare &&
> +	test_cmp_rev refs/remotes/nested/bare/main HEAD
> +'
> +
> +test_expect_success 'checkout --track=fetch handles hierarchical remote name' '
> +	git checkout main &&
> +	git remote add nested/remote ./fetch_upstream &&
> +	test_when_finished "git remote remove nested/remote" &&
> +	git -C fetch_upstream checkout -b fetch_hier &&
> +	test_commit -C fetch_upstream u_hier &&
> +	test_must_fail git rev-parse --verify refs/remotes/nested/remote/fetch_hier &&
> +	git checkout --track=fetch -b local_hier nested/remote/fetch_hier &&
> +	test_cmp_rev refs/remotes/nested/remote/fetch_hier HEAD
> +'
> +
> +test_expect_success 'checkout --track=fetch dies on bare remote name with no <ns>/HEAD' '
> +	git checkout main &&
> +	git remote add fetch_nohead ./fetch_upstream &&
> +	test_when_finished "git remote remove fetch_nohead" &&
> +	test_might_fail git symbolic-ref -d refs/remotes/fetch_nohead/HEAD &&
> +	test_must_fail git checkout --track=fetch -b local_nohead fetch_nohead 2>err &&
> +	test_grep "refs/remotes/fetch_nohead/HEAD" err &&
> +	test_grep "git remote set-head fetch_nohead --auto" err &&
> +	test_must_fail git rev-parse --verify refs/heads/local_nohead
> +'
> +
> +test_expect_success 'checkout --track=fetch on bare unknown name does not suggest set-head' '
> +	git checkout main &&
> +	test_must_fail git rev-parse --verify refs/remotes/no_such_ns/HEAD &&
> +	test_must_fail git config --get remote.no_such_ns.url &&
> +	test_must_fail git checkout --track=fetch -b local_unknown no_such_ns 2>err &&
> +	test_grep "no configured remote" err &&
> +	test_grep ! "set-head" err &&
> +	test_must_fail git rev-parse --verify refs/heads/local_unknown
> +'
> +
> +test_expect_success 'checkout --track=fetch rejects <ns>/HEAD pointing outside namespace' '
> +	git checkout main &&
> +	git remote add fetch_crossns ./fetch_upstream &&
> +	test_when_finished "git remote remove fetch_crossns" &&
> +	test_when_finished "git update-ref -d refs/remotes/fetch_crossns/HEAD" &&
> +	git fetch fetch_crossns &&
> +	git symbolic-ref refs/remotes/fetch_crossns/HEAD \
> +		refs/remotes/fetch_upstream/u_main &&
> +	test_must_fail git checkout --track=fetch -b local_crossns fetch_crossns 2>err &&
> +	test_grep "refs/remotes/fetch_crossns/HEAD" err &&
> +	test_must_fail git rev-parse --verify refs/heads/local_crossns
> +'
> +
> +test_expect_success 'checkout --track=fetch dies on ambiguous fetch refspec match' '
> +	git checkout main &&
> +	git remote add fetch_ambig_a ./fetch_upstream &&
> +	git remote add fetch_ambig_b ./fetch_upstream &&
> +	test_when_finished "git remote remove fetch_ambig_a" &&
> +	test_when_finished "git remote remove fetch_ambig_b" &&
> +	git config --replace-all remote.fetch_ambig_a.fetch \
> +		"+refs/heads/*:refs/remotes/ambig_ns/*" &&
> +	git config --replace-all remote.fetch_ambig_b.fetch \
> +		"+refs/heads/*:refs/remotes/ambig_ns/*" &&
> +	git -C fetch_upstream checkout -b fetch_ambig &&
> +	test_commit -C fetch_upstream u_ambig &&
> +	test_must_fail git checkout --track=fetch -b local_ambig ambig_ns/fetch_ambig 2>err &&
> +	test_grep "fetch_ambig_a" err &&
> +	test_grep "fetch_ambig_b" err &&
> +	test_grep "tracking namespaces" err &&
> +	test_must_fail git rev-parse --verify refs/heads/local_ambig
> +'
> +
> +test_expect_success 'checkout --track=fetch rejects invalid refname components' '
> +	git checkout main &&
> +	test_must_fail git checkout --track=fetch -b local_invalid "foo..bar" 2>err &&
> +	test_grep "valid" err &&
> +	test_must_fail git rev-parse --verify refs/heads/local_invalid
> +'
> +
> +test_expect_success 'checkout --track=fetch,inherit rejects invalid refname components' '
> +	git checkout main &&
> +	test_must_fail git checkout --track=fetch,inherit -b local_invalid \
> +		"foo..bar" 2>err &&
> +	test_grep "valid" err &&
> +	test_must_fail git rev-parse --verify refs/heads/local_invalid
> +'
> +
> +test_expect_success 'checkout --track=inherit,direct is rejected' '
> +	test_must_fail git checkout --track=inherit,direct -b bad fetch_upstream/fetch_new 2>err &&
> +	test_grep "cannot combine" err
> +'
> +
> +test_expect_success 'checkout --track=direct,inherit is rejected' '
> +	test_must_fail git checkout --track=direct,inherit -b bad fetch_upstream/fetch_new 2>err &&
> +	test_grep "cannot combine" err
> +'
> +
> +test_expect_success 'checkout --track=fetch then --track=direct drops fetch (last-one-wins)' '
> +	git checkout main &&
> +	git -C fetch_upstream checkout -b fetch_lastwin &&
> +	test_commit -C fetch_upstream u_lastwin &&
> +	test_must_fail git rev-parse --verify refs/remotes/fetch_upstream/fetch_lastwin &&
> +	test_must_fail git checkout --track=fetch --track=direct \
> +		-b local_lastwin fetch_upstream/fetch_lastwin &&
> +	test_must_fail git rev-parse --verify refs/remotes/fetch_upstream/fetch_lastwin
> +'
> +
> +test_expect_success 'checkout --track=fetch then --no-track drops fetch' '
> +	git checkout main &&
> +	git -C fetch_upstream checkout -b fetch_notrack &&
> +	test_commit -C fetch_upstream u_notrack &&
> +	test_must_fail git rev-parse --verify refs/remotes/fetch_upstream/fetch_notrack &&
> +	test_must_fail git checkout --track=fetch --no-track \
> +		-b local_notrack fetch_upstream/fetch_notrack &&
> +	test_must_fail git rev-parse --verify refs/remotes/fetch_upstream/fetch_notrack
> +'
> +
> +test_expect_success 'checkout --track=fetch,inherit fetches remote-tracking start-point' '
> +	git checkout main &&
> +	git -C fetch_upstream checkout -b fetch_inherit &&
> +	test_commit -C fetch_upstream u_inherit &&
> +	test_must_fail git rev-parse --verify refs/remotes/fetch_upstream/fetch_inherit &&
> +	git checkout --track=fetch,inherit -b local_inherit \
> +		fetch_upstream/fetch_inherit &&
> +	test_cmp_rev refs/remotes/fetch_upstream/fetch_inherit HEAD
> +'
> +
> +test_expect_success 'checkout --track=fetch,inherit errors when start-point does not map to a remote' '
> +	git checkout main &&
> +	test_must_fail git checkout --track=fetch,inherit -b bad main 2>err &&
> +	test_grep "no configured remote" err &&
> +	test_must_fail git rev-parse --verify refs/heads/bad
> +'
> +
> +test_expect_success 'checkout --track=fetch on local start-point errors' '
> +	git checkout main &&
> +	test_must_fail git checkout --track=fetch -b bad main 2>err &&
> +	test_grep "no configured remote" err &&
> +	test_must_fail git rev-parse --verify refs/heads/bad
> +'
> +
> +test_expect_success 'checkout --track=bogus reports an error' '
> +	git checkout main &&
> +	test_must_fail git checkout --track=bogus -b bogus_branch fetch_upstream/fetch_new 2>err &&
> +	test_grep "expects" err
> +'
> +
> +test_expect_success 'checkout -q --track=fetch silences the fetch output' '
> +	git checkout main &&
> +	git -C fetch_upstream checkout -b fetch_quiet &&
> +	test_commit -C fetch_upstream u_quiet &&
> +	test_must_fail git rev-parse --verify refs/remotes/fetch_upstream/fetch_quiet &&
> +	git checkout -q --track=fetch -b local_quiet \
> +		fetch_upstream/fetch_quiet 2>err &&
> +	test_grep ! "-> fetch_upstream/fetch_quiet" err &&
> +	test_cmp_rev refs/remotes/fetch_upstream/fetch_quiet HEAD
> +'
> +
> +test_expect_success 'switch --track=fetch -c picks up branch created upstream after clone' '
> +	git checkout main &&
> +	git -C fetch_upstream checkout -b fetch_switch &&
> +	test_commit -C fetch_upstream u_switch &&
> +	test_must_fail git rev-parse --verify refs/remotes/fetch_upstream/fetch_switch &&
> +	git switch --track=fetch -c local_switch fetch_upstream/fetch_switch &&
> +	test_cmp_rev refs/remotes/fetch_upstream/fetch_switch HEAD
> +'
> +
>   test_done

