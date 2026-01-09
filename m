Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A622BE655
	for <git@vger.kernel.org>; Fri,  9 Jan 2026 14:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767970604; cv=none; b=TLnafqapU5sf/GyPwT+sWqQvVDss5APMOv77I3XEdJAX2tBjEPICoRzBOBJolmH1vDcJYgK/o+hvkyMKXRVnA660qMuAjQffpdR1+tFI23A5yuN4oAF2NnvFcuWPWhQmE4eU/f9akDaCvkOcdxp3t/s+b+mNywwgSDt/vhg1okM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767970604; c=relaxed/simple;
	bh=mc1urxV98VbKPxnD/sx2QbtkYB2Gq1NBrFkSZD92XHo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uyBOqG3/13JSqYV7u0pBOlQ10cNABSHbCD9OvAUxUWoJurXVj4j2Wjsf3m2Qd0uFxaZY3kcYOhpxWz0t0XKM8qcSIDyASB2Rjxk/1H98dtJzaJEjr1tHR//XL3xpwIF4ZydRylWdcPeoD1hvjW81WMiYwveSlCbpwi7RRt29mgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j3MbeKcC; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j3MbeKcC"
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-4779adb38d3so30629335e9.2
        for <git@vger.kernel.org>; Fri, 09 Jan 2026 06:56:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767970600; x=1768575400; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=lbf+Lek3yRmGNl9MPFbDFYVbojPcv9d8dbziXvyeWmw=;
        b=j3MbeKcCSf9kyx1S139M7YVsX/im2/csxwi9Srl1Pv2sO4ccCZ5vHzM6NpybiP7iHg
         4vlLBA1Q4R08DSy/GRmxMJvnmkimI2zv5ieGxi48KkduxTRLzIMqHQezonyG6P5kv+T3
         AFJF78XsQQupyyKgCEo2BK7hiCnK2Vka4qj67CasZCewHIdIFcv2yvTfMlKw2OKedTRl
         ar4q4Dbaj/7NR+jfcsdQhsveY2Fsh9AyZjpOquchFAR4Eq7cqXgnDobw2ziIEhy2p3Al
         /ZosBhA/76fvTUoJ+SyaPwXGViI9TJIxx8Nlm8yWCjDTJlBFh54iNVouMJUr82egiwR1
         vjzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767970600; x=1768575400;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lbf+Lek3yRmGNl9MPFbDFYVbojPcv9d8dbziXvyeWmw=;
        b=RV9FpgMy+ne6x7OceZAdcXpLs+zh7pLdxiPNBd1XM2BrLb3l+kdyxALxC6NxuDbas8
         Xo8TvbZ9LFjZwgZQxqec4sXDUwWcGHu9BEo//PInsp/GTri3i2u0IbMeQLMHoPePMpFr
         0zgO1jIXBfy6ZK6uoxx5cIv8/3tEr6rpLKrTTKd7yN+kNLSnJNF9pjMNn3TQg1yvh8su
         I97kbYsYSvyZyGuXR3ZwRu9EmVk8pNWOdwghrqGvZo7T6kC41M/zxTVJ9hcxpeoRoiAC
         +aZL3nxp9rwqu2kfDVgdZ+T9Ox6FisuUKONU3jJSQqXwhjnxnbB0pF42MA/zVZKXIZg8
         Yx4w==
X-Forwarded-Encrypted: i=1; AJvYcCXFHH1mr9ig1DyTSyZ5/v4YBDIOuC1kwLW5sed6A8YN3XjlIx0im347Nqdm6r/ZnudCMDA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxSLp3WzHnk/4Sb1oqbDz613cOe9AIxCZF3WoqGPTxmph73VEk
	bu9olBw+/nPYXsgMEJHu/rglT9p3hftUN2880jjMOWTsW6zGM1NB/QnR
X-Gm-Gg: AY/fxX7SrmckgspHSVPJXhX66/yx052zqa6hyFexl1qZTNtbphY5dT+kiqDeDW4jbrp
	xem9M5Vu5FRKmuI/+AyCJtGDGtxJBOGr3HbUy4LnOJVNxy0vfKrdPtl4OJH+E8y7ZHOX8zcZawh
	iGce9aYsB33z4WlMUrxnK4nb+suCBTeCjF2sF/lqbbrbzhNQ1doWfjXwTNgC+jeYftQwuBPeRgR
	2eDhvzr3RsyialxF/M8sliphq86BKfH4Bid7gIlskEUUv5Y/daxeu4Ibjhtv+/Ru1tRugjFZZGX
	9TMEYo0fr9ORka7aKjr2+fghIf08IcCxI4/cIyyJlBUFQ+0m7XENB4MCKnBwfIUOPocqZ15SXHr
	f2pfmRsZctqDvmrxqiK1rEuCeNf6wYvQvVzUitDj3xT0cesvTR59qTvvGkUbWLJ/KDvTvjNuJCt
	tzVFcZqImfXYRVBEsYlQBaS5jaiYLu13T8S1nf0dkMpeFFfMccrPBun/vvYnQQOZgXzA==
X-Google-Smtp-Source: AGHT+IE36UwlL2i4wbqFmTJycF4DhxA0CODb4Ephgixq3bpCDtuWK17f4n/MKK0psm/R9rvQqQWI9Q==
X-Received: by 2002:a05:600c:470c:b0:477:79f8:da9d with SMTP id 5b1f17b1804b1-47d84b3b522mr127104135e9.24.1767970600088;
        Fri, 09 Jan 2026 06:56:40 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5? ([2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f69e802sm216547535e9.8.2026.01.09.06.56.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jan 2026 06:56:39 -0800 (PST)
Message-ID: <ba2b65a5-0e2c-41a5-a480-ec3f5ec2178a@gmail.com>
Date: Fri, 9 Jan 2026 14:56:38 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v17 2/2] status: show comparison with push remote tracking
 branch
To: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Harald Nordgren <haraldnordgren@gmail.com>
References: <pull.2138.v16.git.git.1767568882.gitgitgadget@gmail.com>
 <pull.2138.v17.git.git.1767608269.gitgitgadget@gmail.com>
 <1348542edced5d17c1220ee6bd30afd943acdbcf.1767608269.git.gitgitgadget@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <1348542edced5d17c1220ee6bd30afd943acdbcf.1767608269.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Harald

On 05/01/2026 10:17, Harald Nordgren via GitGitGadget wrote:
> From: Harald Nordgren <haraldnordgren@gmail.com>
> 
> "git status" on a branch that follows a remote branch compares
> commits on the current branch and the remote-tracking branch it
> builds upon, to show "ahead", "behind", or "diverged" status.
> 
> When working on a feature branch that tracks a remote feature branch,
> but you also want to track progress relative to the push destination
> tracking branch (which may differ from the upstream branch), git status
> now shows an additional comparison.
> 
> When the upstream tracking branch differs from the push destination
> tracking branch, git status shows both the comparison with the upstream
> tracking branch (as before) and an additional comparison with the push
> destination tracking branch. The push branch comparison appears on a
> separate line after the upstream branch status, using the same format.
> 
> Example output when tracking origin/main but push destination is
> origin/feature:
>      On branch feature
>      Your branch and 'origin/main' have diverged,
>      and have 3 and 1 different commits each, respectively.
>        (use "git pull" if you want to integrate the remote branch with yours)
> 
>      Your branch is ahead of 'origin/feature' by 1 commit.
>        (use "git push" to publish your local commits)

The advice looks good

> The comparison is only shown when the push destination tracking branch
> differs from the upstream tracking branch, even if they are on the same
> remote.

Sounds sensible

> diff --git a/remote.c b/remote.c
> index 7163a8ec28..1f87b85b22 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -29,6 +29,11 @@
>   
>   enum map_direction { FROM_SRC, FROM_DST };
>   
> +enum branch_mode_flags {
> +	BRANCH_MODE_PULL = (1 << 0),
> +	BRANCH_MODE_PUSH = (1 << 1),
> +};

Using an enum for a set of flags is a bit confusing.

> +static char *get_remote_push_branch(struct branch *branch, char **full_ref_out)
> +{
> +	struct remote *remote;
> +	const char *push_remote;
> +	char *push_dst = NULL;
> +	char *tracking_ref;
> +	const char *resolved;
> +	char *ret;
> +
> +	if (!branch)
> +		return NULL;
> +
> +	push_remote = pushremote_for_branch(branch, NULL);
> +	if (!push_remote)
> +		return NULL;
> +
> +	remote = remotes_remote_get(the_repository, push_remote);
> +	if (!remote)
> +		return NULL;
> +
> +	push_dst = remote_ref_for_branch(branch, 1);
> +	if (!push_dst) {
> +		if (remote->push.nr)
> +			return NULL;
> +		push_dst = xstrdup(branch->refname);
> +	}
> +
> +	tracking_ref = (char *)tracking_for_push_dest(remote, push_dst, NULL);
> +	free(push_dst);

On reflection I wonder if we should be calling branch_get_push() instead 
of remote_ref_for_branch() and tracking_for_push_dest() as it respects 
'push.default' and so the branch it returns is the one that "git push" 
without any arguments would push to.

> +	if (!tracking_ref)
> +		return NULL;
> +
> +	resolved = refs_resolve_ref_unsafe(
> +		get_main_ref_store(the_repository),
> +		tracking_ref,
> +		RESOLVE_REF_READING,
> +		NULL, NULL);
> +
> +	if (!resolved) {
> +		free(tracking_ref);
> +		return NULL;
> +	}
> +
> +	if (full_ref_out)

I think it would be simpler to just return the full refname and let the 
caller shorten it.

> +		*full_ref_out = xstrdup(resolved);
> +
> +	ret = refs_shorten_unambiguous_ref(
> +		get_main_ref_store(the_repository), resolved, 0);
> +	free(tracking_ref);
> +	return ret;
> +}
> +
>   static void format_branch_comparison(struct strbuf *sb,
>   				     int sti,
>   				     int ours, int theirs,
>   				     const char *branch_name,
>   				     enum ahead_behind_flags abf,
> +				     enum branch_mode_flags advice_flags,
>   				     int show_divergence_advice)
>   {
>   	if (!sti) {
> @@ -2252,7 +2311,8 @@ static void format_branch_comparison(struct strbuf *sb,
>   		strbuf_addf(sb,
>   			    _("Your branch and '%s' refer to different commits.\n"),
>   			    branch_name);
> -		if (advice_enabled(ADVICE_STATUS_HINTS))
> +		if ((advice_flags & BRANCH_MODE_PUSH) &&

Why are we checking for BRANCH_MODE_PUSH here? Don't we want to show 
this advice regardless of the mode?


 > +		    advice_enabled(ADVICE_STATUS_HINTS))
>   			strbuf_addf(sb, _("  (use \"%s\" for details)\n"),
>   				    "git status --ahead-behind");
>   	} else if (!theirs) {
> @@ -2261,7 +2321,8 @@ static void format_branch_comparison(struct strbuf *sb,
>   			   "Your branch is ahead of '%s' by %d commits.\n",
>   			   ours),
>   			branch_name, ours);
> -		if (advice_enabled(ADVICE_STATUS_HINTS))
> +		if ((advice_flags & BRANCH_MODE_PUSH) &&
> +		    advice_enabled(ADVICE_STATUS_HINTS))

Having to test the flags each time is a bit cumbersome. We could define
a couple of local variables to simplify this

	bool want_push_advice = (advice_flags & BRANCH_MODE_PUSH) &&
				advice_enabled(ADVICE_STATUS_HINTS);
	bool want_pull_advice = advice_flags & BRANCH_MODE_PULL &&
				advice_enabled(ADVICE_STATUS_HINTS);

Then we can simplify the above to

	if (want_push_advice)

>   			strbuf_addstr(sb,
>   				_("  (use \"git push\" to publish your local commits)\n"));
>   	} else if (!ours) {
 > [...]
> @@ -2285,7 +2347,8 @@ static void format_branch_comparison(struct strbuf *sb,
>   			       "respectively.\n",
>   			   ours + theirs),
>   			branch_name, ours, theirs);
> -		if (show_divergence_advice &&
> +		if ((advice_flags & BRANCH_MODE_PULL) &&
> +		    show_divergence_advice &&

If we don't want to show this can't we set show_divergance_adivce to 
false when we call this function - why is it guarded by BRANCH_MODE_PULL 
as well?

>   		    advice_enabled(ADVICE_STATUS_HINTS))
>   			strbuf_addstr(sb,
>   				_("  (use \"git pull\" if you want to integrate the remote branch with yours)\n"));
> @@ -2303,6 +2366,11 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
>   	const char *full_base;
>   	char *base;
>   	int upstream_is_gone = 0;
> +	enum branch_mode_flags base_branch_modes = BRANCH_MODE_PULL | BRANCH_MODE_PUSH;

Here we set an enum to a value that is not a member of the enum.

> +	int push_ours, push_theirs, push_sti;
> +	char *full_push = NULL;
> +	char *push = NULL;
> +	enum branch_mode_flags push_branch_modes = 0;
>   
>   	sti = stat_tracking_info(branch, &ours, &theirs, &full_base, 0, abf);
>   	if (sti < 0) {
> @@ -2314,6 +2382,16 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
>   	base = refs_shorten_unambiguous_ref(get_main_ref_store(the_repository),
>   					    full_base, 0);
>   
> +	push = get_remote_push_branch(branch, &full_push);
> +	if (push && strcmp(base, push)) {

This is good - we only show the push branch separately if it differs 
from the upstream branch.

> +		push_sti = stat_branch_pair(branch->refname, full_push,
> +					   &push_ours, &push_theirs, abf);
> +		if (push_sti >= 0) {
> +			base_branch_modes = BRANCH_MODE_PULL;
> +			push_branch_modes = BRANCH_MODE_PUSH;
> +		}

This combined with checking "push_branch_modes & BRANCH_MODE_PUSH" below 
ensures we skip the push branch if push_sti < 0. That's good but it is a 
bit hard to follow.

Thanks

Phillip

> +	}
> +
>   	if (upstream_is_gone) {
>   		strbuf_addf(sb,
>   			_("Your branch is based on '%s', but the upstream is gone.\n"),
> @@ -2322,10 +2400,19 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
>   			strbuf_addstr(sb,
>   				_("  (use \"git branch --unset-upstream\" to fixup)\n"));
>   	} else {
> -		format_branch_comparison(sb, sti, ours, theirs, base, abf, show_divergence_advice);
> +		format_branch_comparison(sb, sti, ours, theirs, base, abf,
> +					 base_branch_modes, show_divergence_advice);
> +	}
> +
> +	if (push_branch_modes & BRANCH_MODE_PUSH) {
> +		strbuf_addstr(sb, "\n");
> +		format_branch_comparison(sb, push_sti, push_ours, push_theirs, push, abf,
> +					 push_branch_modes, 0);
>   	}
>   
>   	free(base);
> +	free(full_push);
> +	free(push);
>   	return 1;
>   }
>   
> diff --git a/t/t6040-tracking-info.sh b/t/t6040-tracking-info.sh
> index 0b719bbae6..cf5a926dcd 100755
> --- a/t/t6040-tracking-info.sh
> +++ b/t/t6040-tracking-info.sh
> @@ -292,4 +292,266 @@ test_expect_success '--set-upstream-to @{-1}' '
>   	test_cmp expect actual
>   '
>   
> +test_expect_success 'status tracking origin/main shows only main' '
> +	(
> +		cd test &&
> +		git checkout b4 &&
> +		git status >../actual
> +	) &&
> +	cat >expect <<-EOF &&
> +	On branch b4
> +	Your branch is ahead of ${SQ}origin/main${SQ} by 2 commits.
> +	  (use "git push" to publish your local commits)
> +
> +	nothing to commit, working tree clean
> +	EOF
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'status --no-ahead-behind tracking origin/main shows only main' '
> +	(
> +		cd test &&
> +		git checkout b4 &&
> +		git status --no-ahead-behind >../actual
> +	) &&
> +	cat >expect <<-EOF &&
> +	On branch b4
> +	Your branch and ${SQ}origin/main${SQ} refer to different commits.
> +	  (use "git status --ahead-behind" for details)
> +
> +	nothing to commit, working tree clean
> +	EOF
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'status shows ahead of both origin/main and feature branch' '
> +	(
> +		cd test &&
> +		git checkout -b feature2 origin/main &&
> +		git push origin HEAD &&
> +		advance work &&
> +		git status >../actual
> +	) &&
> +	cat >expect <<-EOF &&
> +	On branch feature2
> +	Your branch is ahead of ${SQ}origin/main${SQ} by 1 commit.
> +
> +	Your branch is ahead of ${SQ}origin/feature2${SQ} by 1 commit.
> +	  (use "git push" to publish your local commits)
> +
> +	nothing to commit, working tree clean
> +	EOF
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'checkout shows ahead of both origin/main and feature branch' '
> +	(
> +		cd test &&
> +		git checkout feature2 >../actual
> +	) &&
> +	cat >expect <<-EOF &&
> +	Your branch is ahead of ${SQ}origin/main${SQ} by 1 commit.
> +
> +	Your branch is ahead of ${SQ}origin/feature2${SQ} by 1 commit.
> +	  (use "git push" to publish your local commits)
> +	EOF
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'setup for ahead of tracked but diverged from main' '
> +	(
> +		cd test &&
> +		git checkout -b feature4 origin/main &&
> +		advance work1 &&
> +		git checkout origin/main &&
> +		advance work2 &&
> +		git push origin HEAD:main &&
> +		git checkout feature4 &&
> +		advance work3
> +	)
> +'
> +
> +test_expect_success 'status shows diverged from origin/main and ahead of feature branch' '
> +	(
> +		cd test &&
> +		git checkout feature4 &&
> +		git branch --set-upstream-to origin/main &&
> +		git push origin HEAD &&
> +		advance work &&
> +		git status >../actual
> +	) &&
> +	cat >expect <<-EOF &&
> +	On branch feature4
> +	Your branch and ${SQ}origin/main${SQ} have diverged,
> +	and have 3 and 1 different commits each, respectively.
> +	  (use "git pull" if you want to integrate the remote branch with yours)
> +
> +	Your branch is ahead of ${SQ}origin/feature4${SQ} by 1 commit.
> +	  (use "git push" to publish your local commits)
> +
> +	nothing to commit, working tree clean
> +	EOF
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'status --no-ahead-behind shows diverged from origin/main and ahead of feature branch' '
> +	(
> +		cd test &&
> +		git checkout feature4 &&
> +		git status --no-ahead-behind >../actual
> +	) &&
> +	cat >expect <<-EOF &&
> +	On branch feature4
> +	Your branch and ${SQ}origin/main${SQ} refer to different commits.
> +
> +	Your branch and ${SQ}origin/feature4${SQ} refer to different commits.
> +	  (use "git status --ahead-behind" for details)
> +
> +	nothing to commit, working tree clean
> +	EOF
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'setup upstream remote' '
> +	(
> +		cd test &&
> +		git remote add upstream ../. &&
> +		git fetch upstream &&
> +		git config remote.pushDefault origin
> +	)
> +'
> +
> +test_expect_success 'status with upstream remote and push.default set to origin' '
> +	(
> +		cd test &&
> +		git checkout -b feature5 upstream/main &&
> +		git push origin &&
> +		advance work &&
> +		git status >../actual
> +	) &&
> +	cat >expect <<-EOF &&
> +	On branch feature5
> +	Your branch is ahead of ${SQ}upstream/main${SQ} by 1 commit.
> +
> +	Your branch is ahead of ${SQ}origin/feature5${SQ} by 1 commit.
> +	  (use "git push" to publish your local commits)
> +
> +	nothing to commit, working tree clean
> +	EOF
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'status with upstream remote and push.default set to origin and diverged' '
> +	(
> +		cd test &&
> +		git checkout -b feature6 upstream/main &&
> +		advance work &&
> +		git push origin &&
> +		git reset --hard upstream/main &&
> +		advance work &&
> +		git status >../actual
> +	) &&
> +	cat >expect <<-EOF &&
> +	On branch feature6
> +	Your branch is ahead of ${SQ}upstream/main${SQ} by 1 commit.
> +
> +	Your branch and ${SQ}origin/feature6${SQ} have diverged,
> +	and have 1 and 1 different commits each, respectively.
> +
> +	nothing to commit, working tree clean
> +	EOF
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'status with upstream remote and push branch up to date' '
> +	(
> +		cd test &&
> +		git checkout -b feature7 upstream/main &&
> +		git push origin &&
> +		git status >../actual
> +	) &&
> +	cat >expect <<-EOF &&
> +	On branch feature7
> +	Your branch is up to date with ${SQ}upstream/main${SQ}.
> +
> +	Your branch is up to date with ${SQ}origin/feature7${SQ}.
> +
> +	nothing to commit, working tree clean
> +	EOF
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'status --no-ahead-behind with upstream remote and push branch up to date' '
> +	(
> +		cd test &&
> +		git checkout feature7 &&
> +		git push origin &&
> +		git status --no-ahead-behind >../actual
> +	) &&
> +	cat >expect <<-EOF &&
> +	On branch feature7
> +	Your branch is up to date with ${SQ}upstream/main${SQ}.
> +
> +	Your branch is up to date with ${SQ}origin/feature7${SQ}.
> +
> +	nothing to commit, working tree clean
> +	EOF
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'checkout shows push branch up to date' '
> +	(
> +		cd test &&
> +		git checkout feature7 >../actual
> +	) &&
> +	cat >expect <<-EOF &&
> +	Your branch is up to date with ${SQ}upstream/main${SQ}.
> +
> +	Your branch is up to date with ${SQ}origin/feature7${SQ}.
> +	EOF
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'status shows remapped push refspec' '
> +	(
> +		cd test &&
> +		git checkout -b feature8 origin/main &&
> +		git config remote.origin.push refs/heads/feature8:refs/heads/remapped &&
> +		git push &&
> +		advance work &&
> +		git status >../actual
> +	) &&
> +	cat >expect <<-EOF &&
> +	On branch feature8
> +	Your branch is ahead of ${SQ}origin/main${SQ} by 1 commit.
> +
> +	Your branch is ahead of ${SQ}origin/remapped${SQ} by 1 commit.
> +	  (use "git push" to publish your local commits)
> +
> +	nothing to commit, working tree clean
> +	EOF
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'status shows remapped push refspec with upstream remote' '
> +	(
> +		cd test &&
> +		git checkout -b feature9 upstream/main &&
> +		git config remote.origin.push refs/heads/feature9:refs/heads/remapped &&
> +		git push origin &&
> +		advance work &&
> +		git status >../actual
> +	) &&
> +	cat >expect <<-EOF &&
> +	On branch feature9
> +	Your branch is ahead of ${SQ}upstream/main${SQ} by 1 commit.
> +
> +	Your branch is ahead of ${SQ}origin/remapped${SQ} by 1 commit.
> +	  (use "git push" to publish your local commits)
> +
> +	nothing to commit, working tree clean
> +	EOF
> +	test_cmp expect actual
> +'
> +
>   test_done

