Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C21B49E147
	for <git@vger.kernel.org>; Mon, 21 Sep 2026 13:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789997295; cv=none; b=tWzdOod5f9b62KcGSjwvKNVsi9Xt4W+48Txkiz2HnzaJQy+EPT2CL9u0oo8bRZ0SEVRf1eEe7bJphE00fnHSTBlkoZb3OK5gSIHmyI0BrWSQP7BQF7F5s59VE9wo+4GERFwE8n95iD6YRIvXytQ2FbUVnMzfjJI6dEfU6kVS8WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789997295; c=relaxed/simple;
	bh=2clAwAIthPrzSAu16MFuvn079DTg7je+qZYao0oFZVo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IbIS2CyniPixavIMbL21qaxKgCVnvO8l9ObgCW8rTyPCqg2qwbWfnyWD22Q7P4B89ISv04ERFMwNn/G2D/JDUtlrPx4IpaOKKiz/ToRW/PE1y5myWvl95r2PDKQM9C2dy0DSn96KnweBpZyX2JqZ3fL+1ARtEaLDxrQdzv/BVaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LcvjZWUQ; arc=none smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LcvjZWUQ"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a9adea43b6so3840228a12.0
        for <git@vger.kernel.org>; Mon, 21 Sep 2026 06:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789997292; x=1790602092; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=0AUMTkq560z3A58AtcK70sz/eFX3L0DlrhWgDZaAnOA=;
        b=LcvjZWUQJhT3cCYNf3lpRaMonlOMK+GTnbiZ6pX+QgnmkTvRzZInh60ec4853Dijcg
         QAXWiQvQ4y6IU6tZNrWNKJoFCg2re90flcBBMWIf0r9dpR0PbOUR+4TXLGU0zoF2Ewjo
         heflJRjvHMnmounAyOSJh62QnY2bgQ9ySiRiuVQD8FfAfQGcPS6++A/rsNJWKiBO5m3W
         IrJFQKbHw8f5nmq918zPM0LtefS6NNcdFSReVou+0jR8OReI5l3rm6oUMnpA2xbGg730
         r38iJxfIiik4xX4bYk1YUAtYNXs3kFqjRBHEppF4HAtHsltfVWLDeCXzCI2ejNTGREnU
         rm7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789997292; x=1790602092;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=0AUMTkq560z3A58AtcK70sz/eFX3L0DlrhWgDZaAnOA=;
        b=ivgKgQOgMvgiQ3ZQtdPTdsJfQd2UectiG9vGoLU8YjPHbmDIZZYPjCMozBGzIZLhQt
         9RtWQsbU2cbYDkRK7nkuFBj1pLj+4z+uKMEibYifoFeX82B16xLCHcZpr4htcx//EXcs
         PnkkrboWiqh2UT+nsqNHAT9LDSd6d5Or0XFuzmwan3r5XQMhPcFfc8Je377z6hmyOE3n
         dDt4rjlu4SZ3mKgldaw7SvJSCloWHTMJPdjP1dZ2vDSN4Kxih5Ta/rTqBUC6DZSxKcoY
         FwvRTxEtJ0h88/l27ac8JKdeRdMI+jUBxs7WaFB9PUuJ5grxsb2j6unt2cu7YIbUD7ti
         vDRw==
X-Forwarded-Encrypted: i=1; AKwUvBwf+DZDhUReSdg6F1Zfa1Q9xZqb3MoYcyjdp1kE+l6gF6jSl4LPsmcL2PbDPSeQDGqOer8=@vger.kernel.org
X-Gm-Message-State: AFuF++lWX2HmdvJ6T6RHZnGyOiobQ/MYqDM2DZmNv9kyH8R7GWZAxCo/
	yC2aKQj7ungi9cfD/QmJmEosO0WZwAPJOv5w3ZKRHh6pTANLRRR5mT1l
X-Gm-Gg: AYBFou0lEDRh3cMq7Kvy04YkaPx0VFi4RGPTWtkZM/lxXY/KLWJos7uwr6jqbpipH2v
	gSb8QMRaJV3+go7M+IYJhNyy7zd/x1qGl2tyacWU6IDRtpEbzYTwXIEaydo+stqzw/glAok+Seu
	VRlR2laHZDZR4z5jZgwPmnMQs0+RiYhZAxRTg2qN1Hl6yBT2A9oRMeWlfAtQYrEN7aOSde3rK+A
	0ppai0Ch9W5v3W7mR2hzKfA57A43+hf2zBuabDLclhjdpMQQ+fR4vY5/TJEy/XKL+vCrnw4wFu9
	o4VNg7Mm1R20DeLO9HM9gO2FY4bLgHtbgRr3f67BmleTplY5DbJRSZCZWyXcan3gHMvuOTjtGLe
	adB9GjDcGG8KQSVkqJSYzisfrSJp9X3xV2GovyBSSKaYW/G6gMFpD0HzEFu6sJf5k8efbU+Wiov
	NQpXcVRdyH4wgmaQ4KkvGzc7NZ3AiazecU5NQG+cHh14D3pKsC3BFq+7HjxCSd7LPwkagXr230O
	NOLUqXWWB+xMc+2xrgkJYQg8qu5BbA4JYLNdqnV8S4QC0AEu2XSng==
X-Received: by 2002:a17:907:960d:b0:c29:d3ad:4f72 with SMTP id a640c23a62f3a-c2a157da677mr848194966b.16.1789997291681;
        Mon, 21 Sep 2026 06:28:11 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2a3574c22bsm315782866b.39.2026.09.21.06.28.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2026 06:28:11 -0700 (PDT)
Message-ID: <7f084e4d-f738-4bd4-9b4d-cad995f04be8@gmail.com>
Date: Mon, 21 Sep 2026 14:28:08 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] fetch: add config to avoid fetching every branch in
 shallow repo
To: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Harald Nordgren <haraldnordgren@gmail.com>
References: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Harald

On 19/09/2026 15:47, Harald Nordgren via GitGitGadget wrote:
> From: Harald Nordgren <haraldnordgren@gmail.com>
> 
> In a shallow, sparsely checked out clone of a repository with many
> branches, plain git pull can take minutes or hang outright, even
> though only one branch is actually being worked on.

I think the sparse checkout is irrelevant? It is unclear to me if this 
is talking about a case where there are many branches in the remote 
repository and only one of them was cloned, then adding a second remote 
created a wildcard fetch refspec; or if there are intentionally lots of 
remote tracking branches in the local repository and you don't want to 
wait for them all to update. If it is the former then we should think 
how we can improve the behavior of "git remote add" in a sparse 
repository to prevent it adding a wildcard fetch refspec and instead 
setup the new remote to fetch only the branch(es) we're interested in.

Thanks

Phillip

> Add fetch.shallow, off by default. When enabled, a fetch or pull for
> a shallow repository that isn't already scoped to specific refs
> fetches only the current branch's tracked upstream, instead of every
> branch the remote has. git pull ultimately runs such a fetch under
> the hood, so this fixes pull the same way. It has no effect once the
> repository is no longer shallow, and no effect on a fetch of a remote
> the current branch doesn't track, both fall back to the existing
> behavior.
> 
> This is opt-in rather than automatic because it changes what a plain
> fetch or pull leaves in refs/remotes/<name>/ for anyone who currently
> relies on it syncing every branch of a shallow remote, not just the
> one they are on. Scoping remote.<name>.fetch by hand already covers
> this for a single remote, but that requires knowing the config exists
> and applies it permanently, even to branches that are not currently
> checked out.
> 
> The remote's recorded default branch (remotes/<name>/HEAD) is kept up
> to date the same way it always is, only the other branches are
> skipped.
> 
> Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
> ---
>      fetch: add fetch.shallow so pull doesn't fetch every branch on shallow
>      repo
>      
>      Add fetch.shallow config for big shallow repo, so git fetch/pull doesn't
>      hang by fetching every branch.
> 
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2412%2FHaraldNordgren%2Ffetch-shallow-narrow-refspec-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2412/HaraldNordgren/fetch-shallow-narrow-refspec-v1
> Pull-Request: https://github.com/git/git/pull/2412
> 
>   Documentation/config/fetch.adoc |  15 ++++
>   builtin/fetch.c                 |  18 +++-
>   t/t5537-fetch-shallow.sh        | 146 ++++++++++++++++++++++++++++++++
>   3 files changed, 175 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/config/fetch.adoc b/Documentation/config/fetch.adoc
> index 00435e9a16..e63e54a463 100644
> --- a/Documentation/config/fetch.adoc
> +++ b/Documentation/config/fetch.adoc
> @@ -145,3 +145,18 @@ remove the value for the `fetch.bundleCreationToken` value before fetching.
>   `never`;;
>   	Never create or modify the `remotes/<name>/HEAD` symbolic-ref.
>   --
> +
> +`fetch.shallow`::
> +	If true, and the repository is a shallow repository (see
> +	linkgit:git-clone[1] `--depth`), a fetch or `git pull` that names no
> +	explicit refspec and would otherwise fall back to the remote's
> +	configured `remote.<name>.fetch` refspec instead fetches only the
> +	current branch's upstream, when that upstream is on the remote being
> +	fetched. This avoids negotiating history for every branch the remote
> +	advertises, which can be slow on a shallow repository that tracks
> +	many disjoint shallow histories. It has no effect on a fetch that
> +	names an explicit remote or refspec, and no effect on a repository
> +	that is not shallow. Defaults to false.
> ++
> +`remotes/<name>/HEAD` is still kept up to date per `fetch.followRemoteHEAD`
> +while this is in effect, only the other branches are skipped.
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index 533fdfe7d8..b22f7fe5f4 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -111,6 +111,7 @@ struct fetch_config {
>   	int recurse_submodules;
>   	int parallel;
>   	int submodule_fetch_jobs;
> +	int shallow;
>   };
>   
>   static int git_fetch_config(const char *k, const char *v,
> @@ -175,6 +176,11 @@ static int git_fetch_config(const char *k, const char *v,
>   		return 0;
>   	}
>   
> +	if (!strcmp(k, "fetch.shallow")) {
> +		fetch_config->shallow = git_config_bool(k, v);
> +		return 0;
> +	}
> +
>   	if (!strcmp(k, "fetch.followremotehead")) {
>   		if (!v)
>   			return config_error_nonbool(k);
> @@ -1958,15 +1964,19 @@ static int do_fetch(struct transport *transport,
>   		refspec_ref_prefixes(rs, &transport_ls_refs_options.ref_prefixes);
>   	} else {
>   		struct branch *branch = branch_get(NULL);
> +		int tracks_this_remote = branch && branch_has_merge_config(branch) &&
> +			!strcmp(branch->remote_name, transport->remote->name);
> +		int narrow_to_tracked_ref = config->shallow &&
> +			is_repository_shallow(the_repository) && tracks_this_remote;
>   
>   		if (transport->remote->fetch.nr) {
> -			refspec_ref_prefixes(&transport->remote->fetch,
> -					     &transport_ls_refs_options.ref_prefixes);
> +			if (!narrow_to_tracked_ref)
> +				refspec_ref_prefixes(&transport->remote->fetch,
> +						     &transport_ls_refs_options.ref_prefixes);
>   			if (follow_remote_head != FOLLOW_REMOTE_NEVER)
>   				do_set_head = 1;
>   		}
> -		if (branch && branch_has_merge_config(branch) &&
> -		    !strcmp(branch->remote_name, transport->remote->name)) {
> +		if (tracks_this_remote) {
>   			int i;
>   			for (i = 0; i < branch->merge_nr; i++) {
>   				strvec_push(&transport_ls_refs_options.ref_prefixes,
> diff --git a/t/t5537-fetch-shallow.sh b/t/t5537-fetch-shallow.sh
> index f323ceebd2..8143af9fc3 100755
> --- a/t/t5537-fetch-shallow.sh
> +++ b/t/t5537-fetch-shallow.sh
> @@ -13,6 +13,24 @@ commit() {
>   	git commit -m "$1"
>   }
>   
> +check_upstream_refs () {
> +	git for-each-ref --format="%(refname)" refs/remotes/upstream/ >actual &&
> +	cat >expect &&
> +	test_cmp expect actual
> +}
> +
> +check_upstream_head () {
> +	git symbolic-ref refs/remotes/upstream/HEAD >actual &&
> +	echo "refs/remotes/upstream/$1" >expect &&
> +	test_cmp expect actual
> +}
> +
> +check_same_tip () {
> +	git log --oneline -1 "$1" >expect &&
> +	git -C "$2" log --oneline -1 "$3" >actual &&
> +	test_cmp expect actual
> +}
> +
>   test_expect_success 'setup' '
>   	commit 1 &&
>   	commit 2 &&
> @@ -261,6 +279,134 @@ test_expect_success 'fetch --deepen does not truncate' '
>   	test_cmp expect actual
>   '
>   
> +test_expect_success 'fetch.shallow setup' '
> +	git branch narrow-side &&
> +	git clone --no-local --depth=1 --branch main --single-branch \
> +		.git narrow-default &&
> +	git clone --no-local --depth=1 --branch main --single-branch \
> +		.git narrow-enabled &&
> +	(
> +		cd narrow-default &&
> +		git remote add upstream ../.git &&
> +		git fetch --depth=1 upstream main:refs/remotes/upstream/main &&
> +		git branch --set-upstream-to=upstream/main main
> +	) &&
> +	(
> +		cd narrow-enabled &&
> +		git remote add upstream ../.git &&
> +		git fetch --depth=1 upstream main:refs/remotes/upstream/main &&
> +		git branch --set-upstream-to=upstream/main main &&
> +		git config fetch.shallow true
> +	)
> +'
> +
> +test_expect_success 'a refspec-less fetch expands to the configured refspec by default' '
> +	(
> +		cd narrow-default &&
> +		git fetch upstream &&
> +		check_upstream_refs <<-\EOF
> +		refs/remotes/upstream/HEAD
> +		refs/remotes/upstream/main
> +		refs/remotes/upstream/narrow-side
> +		EOF
> +	)
> +'
> +
> +test_expect_success 'fetch.shallow=true limits a refspec-less fetch to the tracked branch' '
> +	(
> +		cd narrow-enabled &&
> +		git fetch upstream &&
> +		check_upstream_refs <<-\EOF
> +		refs/remotes/upstream/HEAD
> +		refs/remotes/upstream/main
> +		EOF
> +	)
> +'
> +
> +test_expect_success 'fetch.shallow=true still creates refs/remotes/<remote>/HEAD' '
> +	(
> +		cd narrow-enabled &&
> +		git symbolic-ref -d refs/remotes/upstream/HEAD &&
> +		git fetch upstream &&
> +		check_upstream_head main
> +	)
> +'
> +
> +test_expect_success 'fetch.shallow=true with followRemoteHEAD=always corrects a stale HEAD' '
> +	test_when_finished \
> +		"git -C narrow-enabled update-ref -d refs/remotes/upstream/stale-branch" &&
> +	(
> +		cd narrow-enabled &&
> +		git update-ref refs/remotes/upstream/stale-branch refs/remotes/upstream/main &&
> +		git symbolic-ref refs/remotes/upstream/HEAD refs/remotes/upstream/stale-branch &&
> +		git -c fetch.followRemoteHEAD=always fetch upstream &&
> +		check_upstream_head main
> +	)
> +'
> +
> +test_expect_success 'fetch.shallow=true still updates the tracked branch' '
> +	commit 5 &&
> +	git -C narrow-enabled fetch upstream &&
> +	check_same_tip main narrow-enabled refs/remotes/upstream/main
> +'
> +
> +test_expect_success 'fetch.shallow=true keeps git pull narrowed too' '
> +	test_when_finished "git branch -D narrow-side" &&
> +	commit 6 &&
> +	(
> +		cd narrow-enabled &&
> +		git pull &&
> +		check_upstream_refs <<-\EOF
> +		refs/remotes/upstream/HEAD
> +		refs/remotes/upstream/main
> +		EOF
> +	) &&
> +	check_same_tip main narrow-enabled HEAD
> +'
> +
> +test_expect_success 'fetch.shallow=true has no effect on a non-shallow repository' '
> +	git clone --no-local --branch main --single-branch .git narrow-full &&
> +	(
> +		cd narrow-full &&
> +		git rev-parse --is-shallow-repository >actual &&
> +		echo false >expect &&
> +		test_cmp expect actual &&
> +		git remote add upstream ../.git &&
> +		git fetch upstream &&
> +		git branch --set-upstream-to=upstream/main main &&
> +		git config fetch.shallow true
> +	) &&
> +	test_when_finished "git branch -D narrow-full-side" &&
> +	git branch narrow-full-side &&
> +	(
> +		cd narrow-full &&
> +		git fetch upstream &&
> +		check_upstream_refs <<-\EOF
> +		refs/remotes/upstream/HEAD
> +		refs/remotes/upstream/main
> +		refs/remotes/upstream/narrow-full-side
> +		EOF
> +	)
> +'
> +
> +test_expect_success 'fetch.shallow=true only narrows a fetch of the tracked remote' '
> +	test_when_finished "git branch -D other-side" &&
> +	git branch other-side &&
> +	git clone --no-local --depth=1 --branch main --single-branch \
> +		.git narrow-other-remote &&
> +	(
> +		cd narrow-other-remote &&
> +		git remote add upstream ../.git &&
> +		git config fetch.shallow true &&
> +		git fetch upstream &&
> +		check_upstream_refs <<-\EOF
> +		refs/remotes/upstream/HEAD
> +		refs/remotes/upstream/main
> +		refs/remotes/upstream/other-side
> +		EOF
> +	)
> +'
> +
>   . "$TEST_DIRECTORY"/lib-httpd.sh
>   start_httpd
>   
> 
> base-commit: d38352cd43ab9745686d697872408bc3249a153f

