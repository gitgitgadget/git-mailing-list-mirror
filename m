Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87E71D1305
	for <git@vger.kernel.org>; Tue, 19 Nov 2024 15:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732028877; cv=none; b=n9OhogOeaIdCQtvTjt5aNVMNws+pBi0hmob6qEyFPlNvKx9TDn5TsZTR3hI714y6sKsqd5VasQ6BcQ9BPZleiWEtscTKxHAJGU3O6SX6Ltd2bP9a8nECOH45WVAR33ObxDI6zSnAJ05NYGINJKeTB2T8VLwph/28oWZJ8DtBhxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732028877; c=relaxed/simple;
	bh=fZFPsojHTpNw+RAbYHPHZAPnLSOnEv1ck6RMbY99zow=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=MtLQPq3m7Wsju+okvO+MGw6P2Aq69dFrqS9crTSKp8jMCmoGUH9R31jzsXIukp32Os58zvQjJUGraAvOskPUBwSqlAF0MEmWllO/NWASbUFjZGQQh7AgV80qtLHVNdLpO8l0SyRATQbMHepHIodH6uahVUpbLYfNlXghh5yDjDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dHYuT6Mr; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dHYuT6Mr"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4314f38d274so45968455e9.1
        for <git@vger.kernel.org>; Tue, 19 Nov 2024 07:07:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732028874; x=1732633674; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=F2i2hzswKhQt6NH5TKOPjFLVePQ00wNTHMrsNRYV1Pw=;
        b=dHYuT6MrNRRbwtB721vEcljU9eJsKdV/wWmxH/WlNn9IUCjXg7JMXilH7PN7yX+Ego
         +PK63JDxLuxtw7O1/J2OK4kJMhK/tricf6Wcr2RbhwD3NGIYi3Kpuw5Auf1fErICe0g7
         6kvlfyd93p8WNWrwTC1btkNv6+F8vQrL5uTVE+BQxf7VDTStF8IJ0gi9Lk576XNTSVmW
         pMM57vPoFJesmOU/eOGKNcuWv6cz6P5TA6sTF/XocvsMSEsSSJ7ZN6Zt+4usMCmFSJrw
         gtkO0fIg1BYTgtSuEvOBV4AN4UhwqVyLcUcPAmx+krbJk7p3hrKQnkauBUB4k7Nzff7K
         shlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732028874; x=1732633674;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F2i2hzswKhQt6NH5TKOPjFLVePQ00wNTHMrsNRYV1Pw=;
        b=T39CpzqM2fIAo5rybK2bsdbtispqeILMNVoOihbgtEkvzbPnljXO3jp58KyqVGaKZb
         g8Zmf3r1OXC7Uio4LuY68Y91A4a10FKjSkPLNmzq7dLjQykx84NVvXVhdel5IhOaw6sR
         ohZJvB6V4cgUcR/xOJpm1VS06CUNn0ZcfiCi4JD/l8K8ExnsgV7joPii6G1C7ZvWGJV0
         x/hwGLAwriDGw2UnqgRvGGCWkeoNUlZgvYtA5pp7NURLLkrPzqm3EM+wLywfSM/ENCJj
         nK4lcJcfWRK7iFBqqQkfFCut2jOXpGXUHZo5DP8/TQZxJUKTe3er9ZqjNSw/J3UsfV3m
         Fb1A==
X-Forwarded-Encrypted: i=1; AJvYcCWuCZLrDVptliW/q9wgjixMCxgjJQLSSNx7uofmoHJ2+/bCfbninS4YZhiP6q5ZYe9iss4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJdliG9YfpBou5vplI2Rv2OBtxCGGw/lhkLVKh/Sk6E20MUDQV
	rtvOrJekPM+3Rb+f+KqmDimH4vze07FOMZxb7I8V1Z2DFFCu3Zx6
X-Google-Smtp-Source: AGHT+IHURwSJYRN1XqEUZarADVbBTXGWtleTVy/MHS+K2XILMeaQymuQXyVvB1V2Qg48wPtyX93tqw==
X-Received: by 2002:a05:600c:4e8d:b0:432:bb4d:cd77 with SMTP id 5b1f17b1804b1-432df74fda2mr174573325e9.19.1732028873732;
        Tue, 19 Nov 2024 07:07:53 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:6a8:b801:610:d596:f87c:e591? ([2a0a:ef40:6a8:b801:610:d596:f87c:e591])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432da27f4f8sm196948995e9.18.2024.11.19.07.07.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Nov 2024 07:07:53 -0800 (PST)
Message-ID: <47f2b6bf-1e10-4b01-8365-467cc5ca7779@gmail.com>
Date: Tue, 19 Nov 2024 15:07:52 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v4 2/8] worktree: add `relativeWorktrees` extension
To: Caleb White <cdwhite3@pm.me>, git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
 Eric Sunshine <sunshine@sunshineco.com>
References: <20241031-wt_relative_options-v4-0-07a3dc0f02a3@pm.me>
 <20241031-wt_relative_options-v4-2-07a3dc0f02a3@pm.me>
Content-Language: en-US
In-Reply-To: <20241031-wt_relative_options-v4-2-07a3dc0f02a3@pm.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Caleb

On 01/11/2024 04:38, Caleb White wrote:
> A new extension, `relativeWorktrees`, is added to indicate that at least
> one worktree in the repository has been linked with relative paths.

Out of interest what happens in the later patches if we add a worktree 
with a relative path which sets this extension and then convert it to an 
absolute path? Will we clear this extension or do we leave it set? I'm 
mainly curious, I don't think it's the end of the world if we leave the 
extension set.

> This ensures older Git versions do not attempt to automatically prune
> worktrees with relative paths, as they would not not recognize the
> paths as being valid.

Sounds sensible. I'm not familiar with the code that handles repository 
extensions but the patch below looks reasonable to a layman.

Best Wishes

Phillip

> Suggested-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Caleb White <cdwhite3@pm.me>
> ---
>   Documentation/config/extensions.txt | 6 ++++++
>   repository.c                        | 1 +
>   repository.h                        | 1 +
>   setup.c                             | 7 +++++++
>   setup.h                             | 1 +
>   5 files changed, 16 insertions(+)
> 
> diff --git a/Documentation/config/extensions.txt b/Documentation/config/extensions.txt
> index 5dc569d1c9c77c15e32441493289f9c9dd5e7f0b..5cb4721a0e0ae1ed64f90492c0dc18b96473cb33 100644
> --- a/Documentation/config/extensions.txt
> +++ b/Documentation/config/extensions.txt
> @@ -63,6 +63,12 @@ Note that this setting should only be set by linkgit:git-init[1] or
>   linkgit:git-clone[1]. Trying to change it after initialization will not
>   work and will produce hard-to-diagnose issues.
>   
> +relativeWorktrees::
> +	If enabled, indicates at least one worktree has been linked with
> +	relative paths. Automatically set if a worktree has been created or
> +	repaired with either the `--relative-paths` option or with the
> +	`worktree.useRelativePaths` config set to `true`.
> +
>   worktreeConfig::
>   	If enabled, then worktrees will load config settings from the
>   	`$GIT_DIR/config.worktree` file in addition to the
> diff --git a/repository.c b/repository.c
> index f988b8ae68a6a29792e7f2c980a02bd0e388a3b9..1a6a62bbd03a5dc4fdade3eb45ea2696968abc23 100644
> --- a/repository.c
> +++ b/repository.c
> @@ -283,6 +283,7 @@ int repo_init(struct repository *repo,
>   	repo_set_compat_hash_algo(repo, format.compat_hash_algo);
>   	repo_set_ref_storage_format(repo, format.ref_storage_format);
>   	repo->repository_format_worktree_config = format.worktree_config;
> +	repo->repository_format_relative_worktrees = format.relative_worktrees;
>   
>   	/* take ownership of format.partial_clone */
>   	repo->repository_format_partial_clone = format.partial_clone;
> diff --git a/repository.h b/repository.h
> index 24a66a496a6ff516ce06d47b7329b3d36eb701ca..c4c92b2ab9c9e3b425dc2974636e33d1f4089c69 100644
> --- a/repository.h
> +++ b/repository.h
> @@ -150,6 +150,7 @@ struct repository {
>   
>   	/* Configurations */
>   	int repository_format_worktree_config;
> +	int repository_format_relative_worktrees;
>   
>   	/* Indicate if a repository has a different 'commondir' from 'gitdir' */
>   	unsigned different_commondir:1;
> diff --git a/setup.c b/setup.c
> index 1e5c2eacb19eb6b230d7c9954f66fc7ae0b05631..39ff48d9dc5d67b16159c6cca66ff2663bbba6cf 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -683,6 +683,9 @@ static enum extension_result handle_extension(const char *var,
>   				     "extensions.refstorage", value);
>   		data->ref_storage_format = format;
>   		return EXTENSION_OK;
> +	} else if (!strcmp(ext, "relativeworktrees")) {
> +		data->relative_worktrees = git_config_bool(var, value);
> +		return EXTENSION_OK;
>   	}
>   	return EXTENSION_UNKNOWN;
>   }
> @@ -1854,6 +1857,8 @@ const char *setup_git_directory_gently(int *nongit_ok)
>   						    repo_fmt.ref_storage_format);
>   			the_repository->repository_format_worktree_config =
>   				repo_fmt.worktree_config;
> +			the_repository->repository_format_relative_worktrees =
> +				repo_fmt.relative_worktrees;
>   			/* take ownership of repo_fmt.partial_clone */
>   			the_repository->repository_format_partial_clone =
>   				repo_fmt.partial_clone;
> @@ -1950,6 +1955,8 @@ void check_repository_format(struct repository_format *fmt)
>   				    fmt->ref_storage_format);
>   	the_repository->repository_format_worktree_config =
>   		fmt->worktree_config;
> +	the_repository->repository_format_relative_worktrees =
> +		fmt->relative_worktrees;
>   	the_repository->repository_format_partial_clone =
>   		xstrdup_or_null(fmt->partial_clone);
>   	clear_repository_format(&repo_fmt);
> diff --git a/setup.h b/setup.h
> index e496ab3e4de580c2d9f95a7ea0eaf90e0d41b070..18dc3b73686ce28fac2fe04282ce95f8bf3e6b74 100644
> --- a/setup.h
> +++ b/setup.h
> @@ -129,6 +129,7 @@ struct repository_format {
>   	int precious_objects;
>   	char *partial_clone; /* value of extensions.partialclone */
>   	int worktree_config;
> +	int relative_worktrees;
>   	int is_bare;
>   	int hash_algo;
>   	int compat_hash_algo;
> 

