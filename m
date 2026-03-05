Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D068A223702
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 14:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772721489; cv=none; b=YTAnaOyBC58C92z4yZ/b4dMd0X73ekjiR6jEVOSKE8M52mjuJexfFFF0LLyku0NZOowqWGjf/PoT0hUO/V+B+rzkTgS/7sTpsUOfGh+Vhji/atAljJKWFFhzfEazWIxupzFgBx+9zlCblXrVYBQ5A7tgR0/Mh/BWcijcf5P8ixo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772721489; c=relaxed/simple;
	bh=iaOZM38lpqIKGnMpaSu6JgU5fmwV3BaB9PdVX+zsANQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vChryi/g/ZZAAJHKUwOiUjTJ5rcTQ5sBmMCICxolaNyzmxiAk9xmm2ixHufwLeISnEO7HiI9ZxowBssL0x729B0/mLV60eD2io1bMoGRx5U8O36H47aay1HJU+Ac9xCG6eMo2jaUVbgP16EriM0I/PpOrDccv6+c00ohgmoNHVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XDF+00LJ; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XDF+00LJ"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4807068eacbso68203275e9.2
        for <git@vger.kernel.org>; Thu, 05 Mar 2026 06:38:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772721486; x=1773326286; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CyVuksSTgiiXixQ4gf6L8JICu7Q4dF+F0SaXFKDKpPI=;
        b=XDF+00LJp9S7sHaqVEX1GezKAMDljKejxvxE8YP98QMztc4az99At3EP48noJmD/jg
         c/j6cZVCwV5qkILmPEJvy675P8bVBsY8jLS8poptBtcwU0yE80UFPGrXbeI9QEij9B5t
         RMNWOGIxZVanDJwyDBQVqrql7/z1mtut9XPY2Tou7iRiTzcf93eQPCmkuFeROxlhuAdb
         qbMRVcsRTdkmLhI+sA68ekeVfwiy2yW3D75hU+EMWIVDVyHSJyseS21j1dWLkNnhcUSN
         kSjPkKHPauurE7vPa+2TeDAK+nnK91YUyNRKTAGtNEVrdBjLnM33hWhKjz48apsYJGBc
         6W8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772721486; x=1773326286;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CyVuksSTgiiXixQ4gf6L8JICu7Q4dF+F0SaXFKDKpPI=;
        b=DSUsARLAx2Niu+u+jM/GqGkJVCnvRXACP4q2iwl3jc+ZFBJeCwa7WPplfVq5a13sba
         nXYmiVu5+gIX3eKozQ2pWSXVbd+gNSMLgXrogseAp6MO1rTXKyEmxLZm3OtNF9GcY7+I
         2S5KuujwDD8DD9144qT6sEWI1IIwAZiuEB996MCCz64a/s0T58KXSrO0FgwL6niRkrKk
         FzllRhowgSaekZohTPrMhy1SPRkzmuXLEq0XCIVlYC+hMgZYJSN2Pd9DY+0sj5UmuJJd
         aERcb0SO8xXcGR8sGOfaboE0njdazVwGlm70MEQi3Y7Y1oceA17gjDTCvTQWbZGOUCcf
         QiJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXke9tU8ioa9kesWe9sqfRQe2v7F3u9gcHY3eQEeabdIvcm3Vc48h8YxzIcpqOqyxsQyPE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNtdfWMXHDQAeiPz839oxmXD5qldkQShLNSpxzSBABFXIwmzXB
	XaLw8ntN2COmLLtjV7UKQvVPfgqD4+9kAawBntnDxX0qAfxwg2k0IgDk
X-Gm-Gg: ATEYQzywQ2GVaqzTyW7sGHVKWloh1bw9AUzoJOoEJjMQQx1xJarOdtM5mcoXQH+axw0
	QyfIBbh12F+GI/b9VJbPZCJEntZ9YhG+aw+1VwtgR1veoAnjaAmg58+LOx65Tbzw1CWHaaoLFSY
	CuwsKye3OF0OohY9WDYKZaIPW4/trCfPZyc855u9fJn4S4bblEVl2RMKD35MVT3sbtNqlqd8QZi
	fPtEosc4m+lkGSoTmrM1y/1cs37682Ua3gZjuvcY5TPVsH0VY0/uCYUw0MOJ4uhAoYdiawTX0o0
	VnS+M042rep1xi/QhQte8cK1yEWaEvVNw5UZDdK5DGRnTUtUCgtNNwSA6gKSK4f81Wd/DwqHqmr
	aWyhLh7uUsSgu+3flfpzFwl4h/I5fMuuHNDBTuSqXRwVZX4EBUi6jBSG9V1O2By8NU53BJqpIw/
	aEbMGgKW49vIGgpIiKly5xX/c9T17LAOliOIJ8OePRNN6GwFV/vxppMcqYhEa908NHyavXnoH5a
	DNkFNnw6X4=
X-Received: by 2002:a05:600c:190e:b0:47e:e970:b4e4 with SMTP id 5b1f17b1804b1-485198c1000mr107949225e9.29.1772721485805;
        Thu, 05 Mar 2026 06:38:05 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:1785:c801:fc8b:3720:4a41:644? ([2a0a:ef40:1785:c801:fc8b:3720:4a41:644])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4851fb33815sm94370565e9.12.2026.03.05.06.37.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Mar 2026 06:38:05 -0800 (PST)
Message-ID: <98531f78-cf04-4e64-ac7c-6a13e52aee54@gmail.com>
Date: Thu, 5 Mar 2026 14:37:46 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] add: support pre-add hook
To: Chandra Kethi-Reddy via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Ben Knoble <ben.knoble@gmail.com>,
 Adrian Ratiu <adrian.ratiu@collabora.com>,
 Chandra Kethi-Reddy <chandrakr@pm.me>
References: <pull.2045.v4.git.1772710566599.gitgitgadget@gmail.com>
 <pull.2045.v5.git.1772714253412.gitgitgadget@gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <pull.2045.v5.git.1772714253412.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05/03/2026 12:37, Chandra Kethi-Reddy via GitGitGadget wrote:
> 
> diff --git a/Documentation/git-add.adoc b/Documentation/git-add.adoc
> index 6192daeb03..a3ff4ced83 100644
> --- a/Documentation/git-add.adoc
> +++ b/Documentation/git-add.adoc
> [...]   
> @@ -42,10 +42,11 @@ use the `--force` option to add ignored files. If you specify the exact
>   filename of an ignored file, `git add` will fail with a list of ignored
>   files. Otherwise it will silently ignore the file.
>   
> +A `pre-add` hook can be used to reject `git add` (see linkgit:githooks[5]).

git-commit.adoc has a separate section for HOOKS, perhaps we should do 
the same here. It would be clearer to say the that the proposed changes 
are rejected rather than `git add` itself.

> diff --git a/Documentation/githooks.adoc b/Documentation/githooks.adoc
> index 056553788d..90945a590e 100644
> --- a/Documentation/githooks.adoc
> +++ b/Documentation/githooks.adoc
> @@ -94,6 +94,36 @@ and is invoked after the patch is applied and a commit is made.
>   This hook is meant primarily for notification, and cannot affect
>   the outcome of `git am`.
>   
> +pre-add
> +~~~~~~~
> +
> +This hook is invoked by linkgit:git-add[1], and can be bypassed with the
> +`--no-verify` option. It is not invoked for `--interactive`, `--patch`,
> +`--edit`, or `--dry-run`.

I'm struggling to see how it is helpful to the user for "git add 
--dry-run $path" to succeed when "git add $path" will be rejected by the 
"pre-add" hook.

The other options all use "git apply" to apply a diff to the index so 
they could apply the patch to a temporary index which is then passed to 
the "pre-add" hook. If the hook fails the user should be given the 
option to re-edit the patch or re-select the hunks so that their work is 
not wasted.

To me this hook would be much more useful if it also checked changes 
staged by "git commit" - it is still staging changes after all.

> +It takes two arguments: the path to the index file for this invocation
> +of `git add`, and the path to the lockfile containing the proposed

Calling it a lockfile is rather confusing - it is just second index file 
that contains the changes that would be staged.

> +index after staging. If no index exists yet, the first argument names
> +a path that does not exist and should be treated as an empty index.
> +
> +The hook is invoked after the index has been updated in memory and
> +written to the lockfile, but before it is committed to the final index
> +path. Exiting with a non-zero status causes `git add` to reject the
> +proposed state, roll back the lockfile, and leave the index unchanged.
> +Exiting with zero status allows the index update to be committed. The
> +hook accepts or rejects the entire proposed update; per-path filtering
> +is not supported. Both files should be treated as read-only by the hook.

If we don't enforce them being read-only people will write hooks that 
update them just as they do for "pre-commit" hooks. Once they start 
relying on that they will complain if we stop supporting it. If we lock 
both index files before running the hook I think that will prevent the 
hook from being able to update them.

> +Hook authors may set `GIT_INDEX_FILE="$1"` to inspect the current index
> +state and `GIT_INDEX_FILE="$2"` to inspect the proposed index state.

We should be explicit that the proposed index state contains all the 
changes that would be committed so staging changes incrementally will 
check them multiple times.

> +This hook can be used to prevent staging of files based on names, content,
> +or sizes (e.g., to block `.env` files, secret keys, or large files).
> +
> +This hook is not invoked by `git commit -a` or `git commit --include`

I would be more accurate to say that it is not invoked by `git commit` 
at all as there are several ways of staging changes including `git 
commit $path`. We should also be explicit that in order to ensure that 
all staged changes are checked the checks in the "pre-add" hook must be 
duplicated by the "pre-commit" hook.

> +which still can run the `pre-commit` hook, providing a control point at
> +commit time.

While I've commented on the documentation, I think it is really the 
design that needs working on. I like the idea of giving feedback earlier 
when staging changes rather than waiting for the user to run "git 
commit" but I think we need a more coherent approach to when the hook is 
run.

Thanks

Phillip

