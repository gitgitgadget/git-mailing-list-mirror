Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E5A47A40
	for <git@vger.kernel.org>; Wed, 13 Mar 2024 16:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710346239; cv=none; b=JrvaxPfDXmC1z3Ct8UjFDagiGeuw+ShqCry/TvXlCc7yPwm50XBcjHWYlGUf1ypGoS8oSmPOOGg7sHwzdnSOzKecJEcoEWv3pibIKRG2NJtN1e+D9StmctzP1PsDeLF5UTHR/ewRB3kqBC8wJsjTtoI/qdodr3hE6T6MGO/o8W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710346239; c=relaxed/simple;
	bh=mo02wuqOgsbF/kzvbuG/ZsEelKtGZI9NyLyW09018aA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=SAl1OdD+f7Qw/oYmN1o5FHDkHgccH5VWPqfewXXqe4HcdipyuJlmNMhMjNnQnYa9SceZG66/M6/ALM5fLL65Y9qp0lByzpKnKygT0ITrkyEpU+wIcaXX2hjW0y01MOB0EkPUOmb/TgxWw/5B0NqNuO6C1ILRi7LCmNWV2WY8UXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ekS9FPvM; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ekS9FPvM"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-513c8b72b24so6992e87.3
        for <git@vger.kernel.org>; Wed, 13 Mar 2024 09:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710346236; x=1710951036; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=JY05neurFr2lE3XPsf3sl0JyjBgyO5vgNCiNZuGyDUM=;
        b=ekS9FPvMDcaVjaEXqF6j5W02EkUcp+ZfT6FYWqHZ0RzrTg8cJhKfYEfqmLeeoDoDfj
         mMwlZ1yC6+0JZrG1HMaYd/rugxEG37xmH3aSG4t2a2+CIdj61Z8ztYa0rhaC6kuRGgK6
         JpFCiyOpx0rz/UeGYPG3mrNQmEK/a30RwOUbMDuBDsJUwJn6YL78ouxljAzItNZMdnl9
         WP6PylxGxNpK5ME6ctaa3SZ3NKhdwHFa7+rbBjgkN6yiHhAbnQTs7gLKf3euTCTHn3RO
         pvQ6/QF7CW1tLhuBHzdzsiHimLH8jDPs86yD0M1Y12Oxaetjj3iwt9lKLYJY5zVYtacv
         /TlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710346236; x=1710951036;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JY05neurFr2lE3XPsf3sl0JyjBgyO5vgNCiNZuGyDUM=;
        b=Cofb56n1Q909mJkT1dWuagsRH5G0wA51mJ4kIkLNBkvT9Iy1gPvCvjAgMwayDZFR4k
         4jsngVGMp9XayrG6n3U/9QVNN5n1hcGV11uK/NS8Egv8mMf3oIN1ven3k5CDkTesztId
         o3pTk+TO/EcELHPFGn1p3IDuX63p748Gts49LdqBUDjxgg4bhZ781RwsdMnKdyB0KBTw
         35pjB4YiymLy2bN7SkSiT8ZGN+5YbxEzHETjpIUyQadD9hz91kRIcMylZhH5r2NuoKDS
         Vy/aiuDhvjIL9JXq2nywgEiF8eto8gRQc+2xCsGEGpmdCYtvg4NLTJA658OHjOSCH1ve
         jqxA==
X-Forwarded-Encrypted: i=1; AJvYcCUkACMdSymC/VwYdjqt2EFHi83iFjE1oRmM+CXWF9xylR78vQ0XREJ6TtI4w2gCHXMNpPwrK8CYXjfws6Yz6Aq3dGRF
X-Gm-Message-State: AOJu0YwRCywShXdmhkKXx/JIYsfFxLLcNZ2OaNSQGZBm0ElWn2yiU/QP
	TowuaKl9nrCIL6qXf1weyNnkNeS74MaDTV0nRQlSjHdwF8kv/nJW/QlIDuY5
X-Google-Smtp-Source: AGHT+IGssFsqBne48/rHeHtuXn/ifGrUrcD/wAPRQ9x+6/6d804wQPm6QbiR85dTFJvU8sHXpwthzw==
X-Received: by 2002:a19:c519:0:b0:512:f3e7:bcef with SMTP id w25-20020a19c519000000b00512f3e7bcefmr3317006lfe.51.1710346236007;
        Wed, 13 Mar 2024 09:10:36 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:6a5:fd01:2d60:4cd4:e8ec:b443? ([2a0a:ef40:6a5:fd01:2d60:4cd4:e8ec:b443])
        by smtp.gmail.com with ESMTPSA id e19-20020a5d5953000000b0033d640c8942sm103299wri.10.2024.03.13.09.10.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Mar 2024 09:10:35 -0700 (PDT)
Message-ID: <d7c926ce-8a2d-4828-a3b0-3c4a9bcfe92a@gmail.com>
Date: Wed, 13 Mar 2024 16:10:35 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 7/7] cherry-pick: add `--empty` for more robust
 redundant commit handling
Content-Language: en-US
To: Brian Lyles <brianmlyles@gmail.com>, git@vger.kernel.org
Cc: newren@gmail.com, me@ttaylorr.com, gitster@pobox.com
References: <20240119060721.3734775-2-brianmlyles@gmail.com>
 <20240310184602.539656-8-brianmlyles@gmail.com>
In-Reply-To: <20240310184602.539656-8-brianmlyles@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Brian

On 10/03/2024 18:42, Brian Lyles wrote:
> As with git-rebase(1) and git-am(1), git-cherry-pick(1) can result in a
> commit being made redundant if the content from the picked commit is
> already present in the target history. However, git-cherry-pick(1) does
> not have the same options available that git-rebase(1) and git-am(1) have.
> 
> There are three things that can be done with these redundant commits:
> drop them, keep them, or have the cherry-pick stop and wait for the user
> to take an action. git-rebase(1) has the `--empty` option added in commit
> e98c4269c8 (rebase (interactive-backend): fix handling of commits that
> become empty, 2020-02-15), which handles all three of these scenarios.
> Similarly, git-am(1) got its own `--empty` in 7c096b8d61 (am: support
> --empty=<option> to handle empty patches, 2021-12-09).
> 
> git-cherry-pick(1), on the other hand, only supports two of the three
> possiblities: Keep the redundant commits via `--keep-redundant-commits`,
> or have the cherry-pick fail by not specifying that option. There is no
> way to automatically drop redundant commits.
> 
> In order to bring git-cherry-pick(1) more in-line with git-rebase(1) and
> git-am(1), this commit adds an `--empty` option to git-cherry-pick(1). It
> has the same three options (keep, drop, and stop), and largely behaves
> the same. The notable difference is that for git-cherry-pick(1), the
> default will be `stop`, which maintains the current behavior when the
> option is not specified.
> 
> Like the existing `--keep-redundant-commits`, `--empty=keep` will imply
> `--allow-empty`.

I think this is reasonable. git rebase defaults to keeping commits that 
start empty so now that "git cherry-pick --empty=keep" implies 
"--allow-empty" it will behave the same as "git rebase --empty=keep" as 
well as matching the behavior of "git cherry-pick --keep-redundant-commits".

> The `--keep-redundant-commits` option will be documented as a deprecated
> synonym of `--empty=keep`, and will be supported for backwards
> compatibility for the time being.
> 
> Signed-off-by: Brian Lyles <brianmlyles@gmail.com>
> ---
> 
> Differences from v2:
> 
> - `--empty=keep` will now imply `--allow-empty`, consistent with
>    `--keep-redundant-commits`. See [1] for more information.
> - Tests for persistence of the new behaviors after `--continue`, etc.
>    are more focused on user-visible behaviors rather than implementation
>    details.
> - The new empty_action enum uses -1 for unspecified instead of 0.

Thanks for reworking the tests. I've left a small comment below but this 
is looking good.

> +--empty=(drop|keep|stop)::
> +	How to handle commits being cherry-picked that are redundant with
> +	changes already in the current history.
> ++
> +--
> +`drop`;;
> +	The commit will be dropped.
> +`keep`;;
> +	The commit will be kept. Implies `--allow-empty`.
> +`stop`;;
> +	The cherry-pick will stop when the commit is applied, allowing
> +	you to examine the commit. This is the default behavior.
> +--
> ++
> +Note that this option specifies how to handle a commit that was not initially
> +empty, but rather became empty due to a previous commit. Commits that were
> +initially empty will cause the cherry-pick to fail. To force the inclusion of
> +those commits, use `--allow-empty`.

I found this last paragraph is slightly confusing now --empty=keep 
implies --allow-empty. Maybe we could change the middle sentence to say 
something like

     With the exception of `--empty=keep` commits that were initially
     empty will cause the cherry-pick to fail.

> +	if (opts->action == REPLAY_PICK) {
> +		opts->drop_redundant_commits = (empty_opt == DROP_EMPTY_COMMIT);
> +		opts->keep_redundant_commits = opts->keep_redundant_commits || (empty_opt == KEEP_EMPTY_COMMIT);
> +	}
> +
>   	/* implies allow_empty */
>   	if (opts->keep_redundant_commits)
>   		opts->allow_empty = 1;

--empty=keep sets opts->keep_redundant_commits above so this makes it 
imply --allow-empty - good.

Best Wishes

Phillip
