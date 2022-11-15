Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 886B6C4332F
	for <git@archiver.kernel.org>; Tue, 15 Nov 2022 01:00:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237802AbiKOBAa (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Nov 2022 20:00:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237952AbiKOBAJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Nov 2022 20:00:09 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C6021E724
        for <git@vger.kernel.org>; Mon, 14 Nov 2022 16:59:27 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id p5-20020a170902e74500b001884ba979f8so10173685plf.17
        for <git@vger.kernel.org>; Mon, 14 Nov 2022 16:59:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xjRRfJegPnb9s1LCMVCZYXoqIP5EmLbC0ycppuGr64c=;
        b=LSUYd0UIpYbtYoInLi4KhozMRwEWbIcmzj+dXNuxUTvWTPtLhcCmnJkwkUXVjiRFLG
         fe/EBYKhzPLuGo0HMpNceP31VrqQguNNRNOQp80HdsD5y2WBBnA/ID6gBIvNr0dQmAuk
         Lds+fZEJFib+9ZE+i9EvlCsJEzsZX8MWZXNABwFzu8GQ5WHi5E5NaG6y9nm3RHxHKLJ/
         Yi1tTdeiMELvDoIcurJ9itQueKBFb9W29Ca1ae5ItxESiU2dpk9uBvOyIdpGtA9XZR7f
         fSmmAg/j6Jq+So1Pq3oezNr20p/mWx8FSPxB3q464XPG/YnjkvaHJl89OalbMPWgLVQ5
         Tw4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xjRRfJegPnb9s1LCMVCZYXoqIP5EmLbC0ycppuGr64c=;
        b=tCSaeRUot1Dvu3okRyacTTQ2XUl27g93SwsXCQTpkBQ+yCMLzNrJzH+XYB44YWqNcV
         OPudVpVkauX3fjCmRSfyTzyfmyjxyxLUKYK/OC97LrEQCmloiY7qNgBK6jxqh7pQcU0S
         9Gi8908GjAf5UwWvtPnc3xWmp+OKgIfk36mG9CBQJwC+Nx9pJegOC67ALHzAPtIcp8w/
         xrrdZiBfaDiCehk6enZayvExsgEMLJOjDzdYJEBwH/Iy5C0NKfq8Oou1D2+0fzvDcNln
         Dm3OKmJe13fUHUAb0FMw4sn2QXmM9snUOdyC7z4WuKGlTozDmKr4dcuHfix+dppHches
         aObA==
X-Gm-Message-State: ANoB5pl59bqu4LsXoRW+K0rKKJHcAPqUEIJG868AF/cHCyWLkfDA9XcC
        fFhFmvrDUJUw/E+z3YhYFS8xPSbzwrODyA==
X-Google-Smtp-Source: AA0mqf7Cfx9BwP6FO/TJJi7MRrjMtPrf/zJ0qm3vyWEmUW1aL+k6RMuAmm/x8f2svgvvBUiu0OmpxWUGSvyZvA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:903:50e:b0:188:4f8b:dc59 with SMTP id
 jn14-20020a170903050e00b001884f8bdc59mr1716406plb.50.1668473966948; Mon, 14
 Nov 2022 16:59:26 -0800 (PST)
Date:   Mon, 14 Nov 2022 16:59:25 -0800
In-Reply-To: <20221114213713.2341945-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20221108002553.3836987-1-jonathantanmy@google.com> <20221114213713.2341945-1-jonathantanmy@google.com>
Message-ID: <kl6lcz9pnic2.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v2] Doc: document push.recurseSubmodules=only
From:   Glen Choo <chooglen@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, me@ttaylorr.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> - For me, the most important thing is to explicitly support (with
>   documentation) the push.recurseSubmodules=only configuration.
> - Between the submodule being able to decide for itself whether
>   recursion continues, and the superproject deciding everything, Taylor
>   thinks the former is more convincing.
>   - The former is also the status quo.
> - Glen makes a further point that either scheme (the status quo and the
>   behavior in v1) would not be the ideal behavior, but that a CLI
>   argument overrides all config, and in the absence of a CLI argument,
>   a submodule should be able to decide for itself whether recursion
>   should continue (except when there is no config present, in which case
>   it should defer to the superproject).

Ok. I find the status quo argument convincing, so I'm okay with the
approach in this patch.

That said.. I find the status quo very surprising and unergonomic. As
demonstrated in a test below, if a submodule has push.recurseSubmodules
unset, recursion doesn't occur. At the very least, I would have expected
the submodule to respect the superproject's config since that's still a
statement of intent.

I expect that we will have to change this behavior at some point, and
hopefully my "ideal" behavior makes sense to users.

> diff --git a/Documentation/config/push.txt b/Documentation/config/push.txt
> index 7386fea225..43338b65e8 100644
> --- a/Documentation/config/push.txt
> +++ b/Documentation/config/push.txt
> @@ -110,18 +110,8 @@ This will result in only b (a and c are cleared).
>  ----
>  
>  push.recurseSubmodules::
> -	Make sure all submodule commits used by the revisions to be pushed
> -	are available on a remote-tracking branch. If the value is 'check'
> -	then Git will verify that all submodule commits that changed in the
> -	revisions to be pushed are available on at least one remote of the
> -	submodule. If any commits are missing, the push will be aborted and
> -	exit with non-zero status. If the value is 'on-demand' then all
> -	submodules that changed in the revisions to be pushed will be
> -	pushed. If on-demand was not able to push all necessary revisions
> -	it will also be aborted and exit with non-zero status. If the value
> -	is 'no' then default behavior of ignoring submodules when pushing
> -	is retained. You may override this configuration at time of push by
> -	specifying '--recurse-submodules=check|on-demand|no'.
> +	May be "check", "on-demand", "only", or "no", with the same behavior
> +	as that of "push --recurse-submodules".
>  	If not set, 'no' is used by default, unless 'submodule.recurse' is
>  	set (in which case a 'true' value means 'on-demand').
>  
> diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
> index def7657ef9..5bb1d5aae2 100644
> --- a/Documentation/git-push.txt
> +++ b/Documentation/git-push.txt
> @@ -409,10 +409,14 @@ Specifying `--no-force-if-includes` disables this behavior.
>  	all submodules that changed in the revisions to be pushed will be
>  	pushed. If on-demand was not able to push all necessary revisions it will
>  	also be aborted and exit with non-zero status. If 'only' is used all
> -	submodules will be recursively pushed while the superproject is left
> +	submodules will be pushed while the superproject is left
>  	unpushed. A value of 'no' or using `--no-recurse-submodules` can be used
>  	to override the push.recurseSubmodules configuration variable when no
>  	submodule recursion is required.
> ++
> +When using 'on-demand' or 'only', if a submodule has a
> +"push.recurseSubmodules={on-demand,only}" or "submodule.recurse" configuration,
> +further recursion will occur. In this case, "only" is treated as "on-demand".
>  
>  --[no-]verify::
>  	Toggle the pre-push hook (see linkgit:githooks[5]).  The

Everything up to here looks good.

> diff --git a/builtin/push.c b/builtin/push.c
> index f0329c62a2..60ac8017e5 100644
> --- a/builtin/push.c
> +++ b/builtin/push.c
> @@ -466,8 +466,16 @@ static int option_parse_recurse_submodules(const struct option *opt,
>  
>  	if (unset)
>  		*recurse_submodules = RECURSE_SUBMODULES_OFF;
> -	else
> -		*recurse_submodules = parse_push_recurse_submodules_arg(opt->long_name, arg);
> +	else {
> +		if (!strcmp(arg, "only-is-on-demand")) {
> +			if (*recurse_submodules == RECURSE_SUBMODULES_ONLY) {
> +				warning(_("recursing into submodule with push.recurseSubmodules=only; using on-demand instead"));
> +				*recurse_submodules = RECURSE_SUBMODULES_ON_DEMAND;
> +			}
> +		} else {
> +			*recurse_submodules = parse_push_recurse_submodules_arg(opt->long_name, arg);
> +		}
> +	}
>  
>  	return 0;
>  }
> diff --git a/submodule.c b/submodule.c
> index bf7a2c7918..5cd21252d8 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -1130,6 +1130,12 @@ static int push_submodule(const char *path,
>  	if (for_each_remote_ref_submodule(path, has_remote, NULL) > 0) {
>  		struct child_process cp = CHILD_PROCESS_INIT;
>  		strvec_push(&cp.args, "push");
> +		/*
> +		 * When recursing into a submodule, treat any "only" configurations as "on-
> +		 * demand", since "only" would not work (we need all submodules to be pushed
> +		 * in order to be able to push the superproject).
> +		 */
> +		strvec_push(&cp.args, "--recurse-submodules=only-is-on-demand");
>  		if (dry_run)
>  			strvec_push(&cp.args, "--dry-run");

When we pass this magic, undocumented value, "git push" will warn about
about "only" and override it with "on-demand". We always pass it when we
recurse into submodules, and we assume that no user will pass it, thus
we get the warning iff we are recursing into submodules.

In that case, it sounds like "--recurse-submodules=only-is-on-demand" is
a synonym for "this is a submodule that is being recursed into". In that
case, wouldn't it be more self-documenting to have a hidden CLI flag
that expresses exactly that ? e.g. we could add a PARSE_OPT_HIDDEN flag
called "--is-recursing" and check that boolean value. This seems clearer
to me at least.

>  
> diff --git a/t/t5531-deep-submodule-push.sh b/t/t5531-deep-submodule-push.sh
> index 3f58b515ce..302e4cbdba 100755
> --- a/t/t5531-deep-submodule-push.sh
> +++ b/t/t5531-deep-submodule-push.sh
> @@ -512,6 +512,56 @@ test_expect_success 'push only unpushed submodules recursively' '
>  	test_cmp expected_pub actual_pub
>  '
>  
> +setup_subsub () {
> +	git init upstream &&
> +	git init upstream/sub &&
> +	git init upstream/sub/deepsub &&
> +	test_commit -C upstream/sub/deepsub innermost &&
> +	git -C upstream/sub submodule add ./deepsub deepsub &&
> +	git -C upstream/sub commit -m middle &&
> +	git -C upstream submodule add ./sub sub &&
> +	git -C upstream commit -m outermost &&
> +
> +	git -c protocol.file.allow=always clone --recurse-submodules upstream downstream &&
> +	git -C downstream/sub/deepsub checkout -b downstream-branch &&
> +	git -C downstream/sub checkout -b downstream-branch &&
> +	git -C downstream checkout -b downstream-branch
> +}
> +
> +new_downstream_commits () {
> +	test_commit -C downstream/sub/deepsub new-innermost &&
> +	git -C downstream/sub add deepsub &&
> +	git -C downstream/sub commit -m new-middle &&
> +	git -C downstream add sub &&
> +	git -C downstream commit -m new-outermost
> +}
> +
> +test_expect_success 'push with push.recurseSubmodules=only on superproject' '
> +	test_when_finished rm -rf upstream downstream &&
> +	setup_subsub &&
> +	new_downstream_commits &&
> +	git -C downstream config push.recurseSubmodules only &&
> +	git -C downstream push origin downstream-branch &&
> +
> +	test_must_fail git -C upstream rev-parse refs/heads/downstream-branch &&
> +	git -C upstream/sub rev-parse refs/heads/downstream-branch &&
> +	test_must_fail git -C upstream/sub/deepsub rev-parse refs/heads/downstream-branch
> +'

This test demonstrates the behavior I find surprising.

> +
> +test_expect_success 'push with push.recurseSubmodules=only on superproject and top-level submodule' '
> +	test_when_finished rm -rf upstream downstream &&
> +	setup_subsub &&
> +	new_downstream_commits &&
> +	git -C downstream config push.recurseSubmodules only &&
> +	git -C downstream/sub config push.recurseSubmodules only &&
> +	git -C downstream push origin downstream-branch 2> err &&
> +
> +	test_must_fail git -C upstream rev-parse refs/heads/downstream-branch &&
> +	git -C upstream/sub rev-parse refs/heads/downstream-branch &&
> +	git -C upstream/sub/deepsub rev-parse refs/heads/downstream-branch &&
> +	grep "recursing into submodule with push.recurseSubmodules=only; using on-demand instead" err
> +'
> +
>  test_expect_success 'push propagating the remotes name to a submodule' '
>  	git -C work remote add origin ../pub.git &&
>  	git -C work remote add pub ../pub.git &&

The tests look good, and are quite readable.

> -- 
> 2.38.1.493.g58b659f92b-goog
