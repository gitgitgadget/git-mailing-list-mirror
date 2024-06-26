Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75B11802AC
	for <git@vger.kernel.org>; Wed, 26 Jun 2024 13:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719407497; cv=none; b=R6hpKLom4Q6aI2DCDiHN1ZySNkxnXkRcuGSZP+PKJMGp9y/zt3fWohv9uYY/FYCc+2KWdGmh1Zh1gVhrWOfmzQ/z2xkZvfaix4Qf3T2xDKoQbYidvo6/JqX36xkIHz9j+NPnc2tHyEN+zzq9KyU8opSRtCs9wI+ajMfdeIpW+Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719407497; c=relaxed/simple;
	bh=WVPb5AXA63yO6u4tsmR6RpTFenSZWCHHsIptRmbes98=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B8iA2wte40yy/ahcUj3AOmLDnGw2nqFmhpnmvoIA/QT0opZuKgh4FRwm6wMdYmm9no5g3l75LwrmpIUkaSOdscamMzzf2kJ+XN1KBAQwq790+FPx3wtbIE7YNQhbbjKs4hGb34yAjACPmK285oDAZLpiUpOi+JmYAyQijIntVhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=USg+Anw8; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="USg+Anw8"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2ec408c6d94so75613631fa.3
        for <git@vger.kernel.org>; Wed, 26 Jun 2024 06:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719407494; x=1720012294; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=JtDq/xdFoOwJzs0YQnG1uIsnWZzFw6s8OsCHRHbva6U=;
        b=USg+Anw8I6DRvfn5Flx8ZRqOiRHHWXqdddG/aUpNjxBqIR7qz9T0B3Kj56Qv5TzTxa
         7anYmahg/UuErHxCo8nu0Zk7BM1lNHTnZNZCJA8Z/hZeAwpYex/PSKwC7z+7YMRGfULY
         8gHnEfN1yPne01vl4sAbE7Vjq9jGvbETSJKnVW+BF+vlLroCshRbtEWIIOt9VuVdGbmu
         SKewsfTCeZNEHvLKBvWtIn801Fhh6qqtEXLAbyDfkgQ/jSlldCvwq2tA5XOJhdAdtrPw
         ip7MsyGijnCv6KcKEhmuZD2PTvoba3j2pAGo6Nk7CKAoUfvNTk8uIUVX0iAA4two4lCJ
         RO5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719407494; x=1720012294;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JtDq/xdFoOwJzs0YQnG1uIsnWZzFw6s8OsCHRHbva6U=;
        b=bhcGIRqZ141JlBdaxxQj5zMLRh3TIkuB1LiKyau3Di6oJzC77oTY5cktmX+70KxuQp
         sEBrqMEVXQsYG4yegRwcnZVDJI2I+jl09fWPj3XN5X1WZJy9Dv7xnMG19WbQ4pWcx5Rb
         N3XHKIyO84XysehF9i2SmM00bGQ2im9Awb/F4DPaoDxxy1SGZc5BnddJaUJgGiP1//tF
         xr30om0e35zrdzSd43BtZUxkbJnq/Mug88fwAIvdjwV6NHwOsJHoFW4gxhj84gxSsbRH
         n+nE4Yqezkjywpe7vM7OGIFHVw4nzGjqRNfWFj2mkpBe+byZGjXcLxOGKWMtIdGqLOUs
         ejxg==
X-Forwarded-Encrypted: i=1; AJvYcCVMYIoEJiyHdIEis7sE3333ahJ+5wKjWq6Y8iLH1mK4dTTodeBaR8JY++MriDyrV7mUGF2CphUnZ/bEGJbs7nLJs5Yl
X-Gm-Message-State: AOJu0Ywqu4s7yiZYbQrBuBvodjyefZBggETmJSQBDxF19EeaczLVkpq+
	WT1oaXhzNCMNt1qyZKtEZU7RN2kmJUvqX+CQUPxvR2iL5pEkGtWo
X-Google-Smtp-Source: AGHT+IEEltRvmGpJEs+EHp3z8RjEuUSK6hhzFOgu2pPHMHuqAVFSPUwh8y7qwnoBEUocEVnTeysVXw==
X-Received: by 2002:a2e:321a:0:b0:2ec:541b:4b53 with SMTP id 38308e7fff4ca-2ec59388353mr86419441fa.43.1719407493720;
        Wed, 26 Jun 2024 06:11:33 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:64f:8901:d2c6:37ff:fef6:7b1? ([2a0a:ef40:64f:8901:d2c6:37ff:fef6:7b1])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-424c8280962sm25306145e9.34.2024.06.26.06.11.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jun 2024 06:11:33 -0700 (PDT)
Message-ID: <9e5b0cc6-e28c-4c51-ab48-663c61c00ee3@gmail.com>
Date: Wed, 26 Jun 2024 14:11:32 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] setup: support GIT_IGNORE_INSECURE_OWNER environment
 variable
To: Florian Schmaus <flo@geekplace.eu>, git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Junio C Hamano <gitster@pobox.com>
References: <20240626123358.420292-1-flo@geekplace.eu>
 <20240626123358.420292-2-flo@geekplace.eu>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <20240626123358.420292-2-flo@geekplace.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Florian

On 26/06/2024 13:33, Florian Schmaus wrote:
> Sometimes more flexibility to disable/ignore the ownership check, besides
> the safe.directory configuration option, is required.
> 
> For example, git-daemon running as nobody user, which typically has no
> home directory. Therefore, we can not add the path to a user-global
> configuration and adding the path to the system-wide configuration could
> have negative security implications.
> 
> Therefore, make the check configurable via an environment variable.

An alternative would be to allow safe.directory to be specified on the 
command line with "git -c safe.directory='*' daemon ..." rather than 
adding a dedicated environment variable. Or you could set $HOME to a 
suitable directory when running "git daemon" and put the user-global 
config file there. That directory and config file only need to be 
readable by the user that "git daemon" is running under it can be owned 
by root or whoever else you want.

Best Wishes

Phillip


> If the environment variable GIT_IGNORE_INSECURE_OWNER is set to true,
> then ignore potentially insecure ownership of git-related path
> components.
> 
> Signed-off-by: Florian Schmaus <flo@geekplace.eu>
> ---
>   setup.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/setup.c b/setup.c
> index 3afa6fb09b28..da3f504fb536 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -1278,6 +1278,14 @@ static int ensure_valid_ownership(const char *gitfile,
>   	 */
>   	git_protected_config(safe_directory_cb, &data);
>   
> +	if (data.is_safe)
> +		return data.is_safe;
> +
> +	if (git_env_bool("GIT_IGNORE_INSECURE_OWNER", 0)) {
> +		warning("ignoring dubious ownership in repository at '%s' (GIT_IGNORE_INSECURE_OWNER set)", data.path);
> +		return 1;
> +	}
> +
>   	return data.is_safe;
>   }
>   

