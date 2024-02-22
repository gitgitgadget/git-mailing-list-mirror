Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2EE9135A67
	for <git@vger.kernel.org>; Thu, 22 Feb 2024 16:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708619718; cv=none; b=kCi8Xbi1pzVR1mjPlmqPazESG/3Q3dG/KH6Z1QunrcwyNxEo5kPo13ERas2NXIbqlYXERv//UQ4IFUuhftc523e1ovbT8YqljMIiNGFX6fCWBqN3WCM3W+xxR3YhnFX1tMawLXLJSaKfIvL/NO0Dm+gO5dgvbV62xMhCfxrM2LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708619718; c=relaxed/simple;
	bh=f7DsMJ+H7XVKLLaHHBdPruE2+r7eKsqR3G7WgZtX5Fs=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=UCoMR5DCVCY05tYKhKHOV/hVWGO9AbbCsSAhOkeHsbYngACb7cXDx87imi6wPKI8tyEs7cQfRDyMydsGVxaL8cV36mtTZDpCAXYl2OD1rmKWTUp1gbiKH+Ql1dQWL73vow/+Cn2aBuZDaysY6SW9jRcTqbdJJ0CzP222lThR/10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NxCzEWpN; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NxCzEWpN"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-41272d42207so19373885e9.2
        for <git@vger.kernel.org>; Thu, 22 Feb 2024 08:35:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708619715; x=1709224515; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ppTIyMXqkNEJoWVsenQhJZ7JZ6FSSjL+1rfUiO2OjZ8=;
        b=NxCzEWpNRB2nAIDYHYNykGxP4LKUxI/J5NpHM2BnHkL0A69508xQWxlupO7tEJ0IVk
         m2sBxLwcoKuGkGtWPQlB+52JAfJs8ZmLfIWDS1K5K9DdGzFDWJHhUikco8+Z6Uka2Wbl
         fxFJJ6YLdIulM+yZB8KMqlAyf5cRRjWaRPnAO1n/gOMsv6H2hdirFPQR3cJKm8r2t0Kd
         gezBhydriiw2PbJf5u5uueuMzEP21PtfxzT2exlSrxiUaKxqVtDsGaFCczxkJQa6nT77
         whDcWQ9fKqGR/JMN22zdbwKBPKNpnX5rUJt5gptf+vFnkYd0QVSBjNcSeMqCjLG08+fv
         k2AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708619715; x=1709224515;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ppTIyMXqkNEJoWVsenQhJZ7JZ6FSSjL+1rfUiO2OjZ8=;
        b=fUvv1O9mq7Yz4nU5qRKW7JxCUHNgtpj4VdpIFTjNlPMt0tud7Z7q00DdLvEs86jZbT
         WTONhqt+n+h9zk+bhqIzEPkKvcnN35MLH254zYTxHp/+5lAqAkP1JpVFCks0AVBuDTYd
         eg8NSY6mxd5yLw7DPqQrRiDexvtYyDvdynNgX5NqPuNtbNBTPAjQqrQUPvzUzPi3a9XH
         8T/jJeVpOmXNmh9EN7DNK/y7+AGcmWDjhNdh571ElE1o6vkpstZRgv5YZ/zoW1YPrP4P
         ZphrpZkDj+Xhuo+1u/PrGKlL9kWNE0K8pl67FxvT/uWSzzeqcw/5Vfe8jJhpG4Q2hHb2
         F0bw==
X-Forwarded-Encrypted: i=1; AJvYcCXRKKSCD3VxipT5vJutPyblzAfR7BFGBjCDsOtSrD677bkkAaJtuF+Yx8/WRbuar/OydJ7Xy15Md+dS4elBkNoh9epw
X-Gm-Message-State: AOJu0YwfdTCFhp/M0fRFLZa2hy3g8bHKgZ6FInTcSNWXnYG1e5WCTqSS
	F9rVt05SstRlZ050TpY/0yDSIA7Bdd8/4crJu/38X3CfouTPcV99
X-Google-Smtp-Source: AGHT+IHkSdYx8vgHyHhES4Rx1PxeUyVcR8MulKp9TxHzVcbBZV7/yCjaYdo86z1T70n905/Hr0BVnA==
X-Received: by 2002:a05:600c:524f:b0:412:8d4d:b33 with SMTP id fc15-20020a05600c524f00b004128d4d0b33mr1015581wmb.3.1708619714966;
        Thu, 22 Feb 2024 08:35:14 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:69d:3501:4b27:339f:196f:f7f9? ([2a0a:ef40:69d:3501:4b27:339f:196f:f7f9])
        by smtp.gmail.com with ESMTPSA id m20-20020a05600c281400b0041214ff06cesm21901857wmb.42.2024.02.22.08.35.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Feb 2024 08:35:14 -0800 (PST)
Message-ID: <84db20bc-94d0-43be-b4e0-f3f9245de63f@gmail.com>
Date: Thu, 22 Feb 2024 16:35:14 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 5/8] sequencer: do not require `allow_empty` for
 redundant commit options
Content-Language: en-US
To: Brian Lyles <brianmlyles@gmail.com>, git@vger.kernel.org
Cc: newren@gmail.com, me@ttaylorr.com, gitster@pobox.com
References: <20240119060721.3734775-2-brianmlyles@gmail.com>
 <20240210074859.552497-6-brianmlyles@gmail.com>
In-Reply-To: <20240210074859.552497-6-brianmlyles@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Brian

On 10/02/2024 07:43, Brian Lyles wrote:
> A consumer of the sequencer that wishes to take advantage of either the
> `keep_redundant_commits` or `drop_redundant_commits` feature must also
> specify `allow_empty`. However, these refer to two distinct types of
> empty commits:
> 
> - `allow_empty` refers specifically to commits which start empty
> - `keep_redundant_commits` refers specifically to commits that do not
>    start empty, but become empty due to the content already existing in
>    the target history
> 
> Conceptually, there is no reason that the behavior for handling one of
> these should be entangled with the other. It is particularly unintuitive
> to require `allow_empty` in order for `drop_redundant_commits` to have
> an effect: in order to prevent redundant commits automatically,
> initially-empty commits would need to be kept automatically as well.
> 
> Instead, rewrite the `allow_empty()` logic to remove the over-arching
> requirement that `allow_empty` be specified in order to reach any of the
> keep/drop behaviors. Only if the commit was originally empty will
> `allow_empty` have an effect.
> 
> Note that no behavioral changes should result from this commit -- it
> merely sets the stage for future commits.

Thanks for clarifying that. I think splitting this change out is a good 
idea. The patch looks good.

Best Wishes

Phillip

> In one such future commit, an
> `--empty` option will be added to git-cherry-pick(1), meaning that
> `drop_redundant_commits` will be used by that command.
> 
> Signed-off-by: Brian Lyles <brianmlyles@gmail.com>
> ---
> 
> This is the first half of the first commit[1] in v1, which has now been
> split up. While the next commit may be considered somewhat
> controversial, this part of the change should not be.
> 
> [1]: https://lore.kernel.org/git/20240119060721.3734775-2-brianmlyles@gmail.com/
> 
>   sequencer.c | 23 +++++++----------------
>   1 file changed, 7 insertions(+), 16 deletions(-)
> 
> diff --git a/sequencer.c b/sequencer.c
> index b1b19512de..3f41863dae 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -1725,34 +1725,25 @@ static int allow_empty(struct repository *r,
>   	int index_unchanged, originally_empty;
> 
>   	/*
> -	 * Four cases:
> +	 * For a commit that is initially empty, allow_empty determines if it
> +	 * should be kept or not
>   	 *
> -	 * (1) we do not allow empty at all and error out.
> -	 *
> -	 * (2) we allow ones that were initially empty, and
> -	 *     just drop the ones that become empty
> -	 *
> -	 * (3) we allow ones that were initially empty, but
> -	 *     halt for the ones that become empty;
> -	 *
> -	 * (4) we allow both.
> +	 * For a commit that becomes empty, keep_redundant_commits and
> +	 * drop_redundant_commits determine whether the commit should be kept or
> +	 * dropped. If neither is specified, halt.
>   	 */
> -	if (!opts->allow_empty)
> -		return 0; /* let "git commit" barf as necessary */
> -
>   	index_unchanged = is_index_unchanged(r);
>   	if (index_unchanged < 0)
>   		return index_unchanged;
>   	if (!index_unchanged)
>   		return 0; /* we do not have to say --allow-empty */
> 
> -	if (opts->keep_redundant_commits)
> -		return 1;
> -
>   	originally_empty = is_original_commit_empty(commit);
>   	if (originally_empty < 0)
>   		return originally_empty;
>   	if (originally_empty)
> +		return opts->allow_empty;
> +	else if (opts->keep_redundant_commits)
>   		return 1;
>   	else if (opts->drop_redundant_commits)
>   		return 2;
