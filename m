Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A764E82485
	for <git@vger.kernel.org>; Fri, 22 Nov 2024 15:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732290937; cv=none; b=QX7PLWW+uZxcMTtsnRx2GJ/wvvjOcMtWEV5wOuYoThnQfEcqYGG/qyr8iv3xTYvEHEz/PnQyCWZtSddC8XM3oOCXWaAIy2/v1wlKmRwZNuGa7/gjqOERsiAthIPQCaNZAUXGSgG4hBxawbrgz9I7j//2JyDuUX60bk3jgR89el0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732290937; c=relaxed/simple;
	bh=d8BVc64Lfeu57Mem/4lMFm0SMLuGZRkmGVsrzXloDLM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=HPbmCltR+0gNqWhhVFgZCEnDqHFBfwcPAkVqKooV3U+ygsmOuGeOtemqJAP0BilfA5t6k4zwkt+nDO08WoS0Tz3PxfEjPOPy7QHacwAfYgbKWCLHqi/dvtFukVDWJiKqZiKL5hRVSlEjNpxqWx5z+3j1pRQU4A8eSMmkuyRvsQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kVghAyxh; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kVghAyxh"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-382456c6597so1640609f8f.2
        for <git@vger.kernel.org>; Fri, 22 Nov 2024 07:55:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732290933; x=1732895733; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BqdMqRvnvROq2X33bFHOfEzkZRXJvqsXGxvZ21hzYrA=;
        b=kVghAyxhfkTT8JOzFHPL1wTNMDc0/yaEvar6Ec84LQYO62kMFevllUFy7Gtlzmbjc3
         AsLZ1x1fSByUGaM4HJQcitqlf1zFUly6y/eAfSBmzKmXJlWtDXBQTScnUUMxSCCkaj3t
         xIdqlglTp/Q1w7Fann8O5hOdLXkst1+5ZJ0QEC7p7mFBGJQncZ02xBwZxSQOBTyYoGAu
         XuPeKF1KJFsvHjWb+wjJMbRDGRxPMD4L20OQgAyZqK1lxrXki5WB6pk4OK46+0FbwmjR
         JIMWD42X6SbgXbykNMA1E4jLxxKOxod5al3DfR0PUDMUuqq6qhiEvuM7AneZbYaa8IcB
         DU+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732290933; x=1732895733;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BqdMqRvnvROq2X33bFHOfEzkZRXJvqsXGxvZ21hzYrA=;
        b=eQGPb5mTTg5RIwuNqWGneWc2M11udr/cr7ym/SNlLHHGBA9HXSjFLRZM5AACF+G28X
         15uTKaWflY69Eir6P5Wgqck62O9cvKaKAy7pqYQ9pcn4hOEJ9IEJ05to4ld82YlAPvi3
         J8VzRi5dt4soJjKluMwZvl3yBNNbmmVRJv/63FqV0u2jANU4BlFNxoRHvI8ZqcQwZbvu
         HtEcDX3ROak7/lye9qheYlbqIW3ojA404Jbjz6lksyygfjTGytUUjWc3yi1mAZYJ5W/B
         R+TLqpyXtbPgDd/hGPZ2oqRFFFS5QY67JT066jqEKdMmRikX8WbNsbGai73GwixQEcTD
         kWow==
X-Forwarded-Encrypted: i=1; AJvYcCXWQchojUOg+jvgO8zuNghM8CwfxlJ3oRumsVk9vZwf5trz0J51HDo2FSXmY+C0trAPZX4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBVn9tayY9dUvnOZAHc66E32oe4CUshtxgGWpVUVMa0dF0beBB
	20XUDRonQB7NA5CSzSUrxEsQ4UvRxp1WwCooCv3/whamyDzjg9KX
X-Gm-Gg: ASbGncvJ/q5CRPRWiPOXyi/g4kSCrr3CVoCUzFTW865GWpAj9/UsT61szN7MV6oUeBR
	fzcjPe5HO/dx/qqrV6FEH+K7pwWzdP/Vjo5KOKeXxXYwxkrP/acFnaKwF2upKCWHpuXPPBQx9nl
	5R66i8Dnhy8Wtz+XK3C3oQabpMOoJxyC1VG3jU4DfOagtmLgG+yYRV2zk9v8XYUL6oTXlSR8bEF
	5134jneLJyuwUcr3Rm0p/V2VvTnv39kcweiCkJ4ZK9J1ZDNNBgA3iHk/ANLSJXQx7m+AAMsVCS+
	uZ2ReCl9n83ToVhxjoru48xeMg==
X-Google-Smtp-Source: AGHT+IH4SclnP35PGHb+nfWmSYn0tiF9amaHH24L+GXwoN03YneQaoPiNXscnWXLl562J7st9+qtUw==
X-Received: by 2002:a05:6000:1541:b0:382:22c6:7bcb with SMTP id ffacd0b85a97d-38260b455f0mr2742616f8f.3.1732290932833;
        Fri, 22 Nov 2024 07:55:32 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:6a8:b801:610:d596:f87c:e591? ([2a0a:ef40:6a8:b801:610:d596:f87c:e591])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825faf9dd2sm2716198f8f.26.2024.11.22.07.55.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Nov 2024 07:55:32 -0800 (PST)
Message-ID: <75b4023a-4005-49ff-a06d-e50fcd1c2b50@gmail.com>
Date: Fri, 22 Nov 2024 15:55:31 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v4 6/8] worktree: add relative cli/config options to
 `move` command
Reply-To: phillip.wood@dunelm.org.uk
To: Caleb White <cdwhite3@pm.me>, git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
 Eric Sunshine <sunshine@sunshineco.com>
References: <20241031-wt_relative_options-v4-0-07a3dc0f02a3@pm.me>
 <20241031-wt_relative_options-v4-6-07a3dc0f02a3@pm.me>
Content-Language: en-US
In-Reply-To: <20241031-wt_relative_options-v4-6-07a3dc0f02a3@pm.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Caleb

This looks good, I've left a couple of comments on the tests - they 
could be cleaned up like the last patch. The implementation looks good.

On 01/11/2024 04:38, Caleb White wrote:
> This teaches the `worktree move` command to respect the
> `--[no-]relative-paths` CLI option and `worktree.useRelativePaths`
> config setting. If an existing worktree is moved with `--relative-paths`
> the new path will be relative (and visa-versa).
> 
> Signed-off-by: Caleb White <cdwhite3@pm.me>
> ---
>   builtin/worktree.c       |  4 +++-
>   t/t2403-worktree-move.sh | 22 ++++++++++++++++++++++
>   worktree.c               | 23 ++++++++++-------------
>   worktree.h               |  3 ++-
>   4 files changed, 37 insertions(+), 15 deletions(-)
> 
> diff --git a/builtin/worktree.c b/builtin/worktree.c
> index e3b4a71ee0bc13d5e817cf7dcc398e9e2bd975de..302151506981718658db1cd338cd9064688f5c14 100644
> --- a/builtin/worktree.c
> +++ b/builtin/worktree.c
> @@ -1190,6 +1190,8 @@ static int move_worktree(int ac, const char **av, const char *prefix)
>   		OPT__FORCE(&force,
>   			 N_("force move even if worktree is dirty or locked"),
>   			 PARSE_OPT_NOCOMPLETE),
> +		OPT_BOOL(0, "relative-paths", &use_relative_paths,
> +			 N_("use relative paths for worktrees")),

By the time this function is called we've already initialized 
use_relative_paths from the config setting - good

> [...]
> +test_expect_success 'move worktree with absolute path to relative path' '
> +	git config worktree.useRelativePaths false &&
> +	git worktree add ./absolute &&
> +	git worktree move --relative-paths absolute relative &&
> +	cat relative/.git >actual &&
> +	echo "gitdir: ../.git/worktrees/absolute" >expect &&
> +	test_cmp expect actual &&
> +	git config worktree.useRelativePaths true &&
> +	git worktree move relative relative2 &&
> +	cat relative2/.git >actual &&
> +	echo "gitdir: ../.git/worktrees/absolute" >expect &&
> +	test_cmp expect actual
> +'

As with the last patch we should use test_config and stop copying files 
just to compare them. It's probably worth checking the gitdir file as 
well as .git here as well.

> +test_expect_success 'move worktree with relative path to absolute path' '
> +	git config worktree.useRelativePaths true &&
> +	git worktree move --no-relative-paths relative2 absolute &&
> +	cat absolute/.git >actual &&
> +	echo "gitdir: $(pwd)/.git/worktrees/absolute" >expect &&
> +	test_cmp expect actual
> +'
> +
>   test_done
> [...]
> -	strbuf_realpath(&repo, git_common_path("worktrees/%s", wt->id), 1);
> +	strbuf_realpath(&gitdir, git_common_path("worktrees/%s/gitdir", wt->id), 1);

We used to append "/gitdir" below but now we do it all in one - nice.

>   	strbuf_realpath(&path, path_, 1);
> +	strbuf_addf(&dotgit, "%s/.git", path.buf);
>   	if (fspathcmp(wt->path, path.buf)) {

get_linked_worktree guarentees that wt->path is absolute so this looks good.

> -		strbuf_addf(&file, "%s/gitdir", repo.buf);
> -		write_file(file.buf, "%s/.git", relative_path(path.buf, repo.buf, &tmp));
> -		strbuf_reset(&file);
> -		strbuf_addf(&file, "%s/.git", path.buf);
> -		write_file(file.buf, "gitdir: %s", relative_path(repo.buf, path.buf, &tmp));
> +		write_worktree_linking_files(dotgit, gitdir, use_relative_paths);

This is a nice simplification

Best Wishes

Phillip
