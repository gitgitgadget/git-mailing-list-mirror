Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3FAC2BB15
	for <git@vger.kernel.org>; Fri, 12 Jul 2024 13:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720791994; cv=none; b=FT8CxJ4Jr4euB3hnn97dfMxnfMEudeF1O0TZ8l2z6aH+6Z10busXKSOj7POPE37dZpIaNh9xy+yqPD5qEbaxlwGOT8zkx8vUZbniqoqYJtBfe2YN+uK2F39RYhn9kSM+4vv9edbXXRSfNFvqK/OilzvgWvOVx9nGG3INnrLs17A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720791994; c=relaxed/simple;
	bh=fg6VC1VUGkRG9sEzerMQFd8i93cOkjPgtieYMPO80js=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=r/eQVom8hoU2n7VOW5W8JyUjVbROD2gQzmNfSN7fllsGwZKcNADEE34BggMAyeopJzdZgGIyiuUTkxr/koC6twGS5jnN4Y7b74w2RVFAh8Ns+lO05SIbVx5TMTxl6XykYHSKq+nVNsBPuMInWFLa7GMvJ+U67BpVgJjyfXqSFK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GZqRWvnS; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GZqRWvnS"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2eaa89464a3so22825201fa.3
        for <git@vger.kernel.org>; Fri, 12 Jul 2024 06:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720791991; x=1721396791; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OIm3Ih3IexjnViNSTpxAgjDWwNNg1NW09u5eIbh8Bkk=;
        b=GZqRWvnSTEydpx5dEzU06txEb/zDgtnVBLFV385ZQdteTlRiwrV5cuJC114lgUpkEM
         jfaQfXy8V8V1rkb571dw7yHMOp+3ytA+kQpPnGY8N+X4+DVwNpbnN13K3PPv4KQ07oJX
         MdJvB9ljPelwtUExOHrGgqOzd9Ge71iHNNW4kJ3T2T248BE0DhUlhNY1em28sCiz0eHn
         S+ewIv2nlJuImInqDdM3bICXz0J2HeMYwMjz2VFzQqpfTWySjZQePhfOunoGDbsBBte8
         L90FnJ4C5EbszREZ4gKJpL85VxYPyIQnjsm5PfdK+SKZmCxcsHqXXgbRn/ylxsZ0pDmr
         E7bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720791991; x=1721396791;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OIm3Ih3IexjnViNSTpxAgjDWwNNg1NW09u5eIbh8Bkk=;
        b=DQ0zsFqSDLGQlw0JejFn8h07z/3CjtKOPKLqfjCgu3JsBWX4rG9+5SgOXKRqV1eqVP
         z5eUb1jcZzB4aJA3ZFmtw5t496jkxC4MTd9nsoalllNBSxIdTFfvMLkI4d+8QCJtdLQT
         bQ/JkiiuDfoO3m6LKqd4k+iSxCJoUFEDHCvpEJv8UG3gm7Rb0TCGVddWEHyrTZ/RY+GZ
         AY/DmyYD0BfcgBBa2AVIGIBHQlzpgjPzFPQSeTjjstYbBSCe0t7sm4oeKwA2DDEXhx/2
         VWfsOp7kqKOqZKEf6+ODv3oDk9RihOgOqAXp+cybVLs8Z6MLv/XKJY69JC+n0ODCWdjH
         yRjQ==
X-Forwarded-Encrypted: i=1; AJvYcCXSK8f/4r91JnL/Ihcrx1l8hIV3nwyw0OsdXldTVGIn/AFJS3O8/rScguTw6kRrbMnAdqcb3btmsdnad4a0p8Nc2Hwb
X-Gm-Message-State: AOJu0Yxpc8atYbefGUpoEWziPhCtT3EKDTR7/dNIHkgk3ecTLZ4qxTm/
	iG+ob0uzd1t07QEoRNDLCZ+AmGOD/8l7FfAMKfLB+n3iW+tBRg38
X-Google-Smtp-Source: AGHT+IEiEwEeApXoE9Gu4fKfDti6w0YZo93xWBbtWiG2q+7V40Fe/k+ahayrb+2uEJvSg/FSgujBPw==
X-Received: by 2002:a2e:a7c7:0:b0:2eb:efff:771e with SMTP id 38308e7fff4ca-2eeb30ff061mr96688671fa.29.1720791990898;
        Fri, 12 Jul 2024 06:46:30 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:600:8501:575d:f6b:be83:bc74? ([2a0a:ef40:600:8501:575d:f6b:be83:bc74])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4279f276c52sm24371075e9.22.2024.07.12.06.46.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jul 2024 06:46:30 -0700 (PDT)
Message-ID: <a1913542-ea19-49d7-a694-42540c71df03@gmail.com>
Date: Fri, 12 Jul 2024 14:46:27 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 3/7] win32: override `fspathcmp()` with a directory
 separator-aware version
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
 Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.1760.git.1720443778074.gitgitgadget@gmail.com>
 <pull.1760.v2.git.1720739496.gitgitgadget@gmail.com>
 <a718183bb3b8eabd5ced274d8db124909bcdf493.1720739496.git.gitgitgadget@gmail.com>
Content-Language: en-US
In-Reply-To: <a718183bb3b8eabd5ced274d8db124909bcdf493.1720739496.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Johannes

On 12/07/2024 00:11, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> On Windows, the backslash is the directory separator, even if the
> forward slash can be used, too, at least since Windows NT.
> 
> This means that the paths `a/b` and `a\b` are equivalent, and
> `fspathcmp()` needs to be made aware of that fact.

How does fspathncmp() behave? It would be good for the two to match. 
I've left a couple of thoughts below but I'm not sure they're worth 
re-rolling for

> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>   compat/win32/path-utils.c | 25 +++++++++++++++++++++++++
>   compat/win32/path-utils.h |  2 ++
>   dir.c                     |  2 +-
>   dir.h                     |  2 +-
>   git-compat-util.h         |  5 +++++
>   5 files changed, 34 insertions(+), 2 deletions(-)
> 
> diff --git a/compat/win32/path-utils.c b/compat/win32/path-utils.c
> index ebf2f12eb66..af7ef957bbf 100644
> --- a/compat/win32/path-utils.c
> +++ b/compat/win32/path-utils.c
> @@ -50,3 +50,28 @@ int win32_offset_1st_component(const char *path)
>   
>   	return pos + is_dir_sep(*pos) - path;
>   }
> +
> +int win32_fspathcmp(const char *a, const char *b)
> +{
> +	int diff;
> +
> +	for (;;) {
> +		if (!*a)
> +			return !*b ? 0 : -1;

Personally I'd find this easier to read as

	return *b ? -1 : 0;

> +		if (!*b)
> +			return +1;
> +
> +		if (is_dir_sep(*a)) {
> +			if (!is_dir_sep(*b))
> +				return -1;
> +			a++;
> +			b++;
> +			continue;
> +		} else if (is_dir_sep(*b))
> +			return +1;
> +
> +		diff = (unsigned char)tolower(*(a++)) - (unsigned char)tolower(*(b++));

There is a subtle difference between this and strcasecmp() because the 
latter is locale dependent but our tolower() is not because we override 
the standard library's version. As they're both useless on multibyte 
locales it probably doesn't make much difference in practice.

Thanks

Phillip

> +		if (diff)
> +			return diff;
> +	}
> +}
> diff --git a/compat/win32/path-utils.h b/compat/win32/path-utils.h
> index 65fa3b9263a..e3c2a79df74 100644
> --- a/compat/win32/path-utils.h
> +++ b/compat/win32/path-utils.h
> @@ -29,5 +29,7 @@ static inline int win32_has_dir_sep(const char *path)
>   #define has_dir_sep(path) win32_has_dir_sep(path)
>   int win32_offset_1st_component(const char *path);
>   #define offset_1st_component win32_offset_1st_component
> +int win32_fspathcmp(const char *a, const char *b);
> +#define fspathcmp win32_fspathcmp
>   
>   #endif
> diff --git a/dir.c b/dir.c
> index b7a6625ebda..37d8e266b2c 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -95,7 +95,7 @@ int count_slashes(const char *s)
>   	return cnt;
>   }
>   
> -int fspathcmp(const char *a, const char *b)
> +int git_fspathcmp(const char *a, const char *b)
>   {
>   	return ignore_case ? strcasecmp(a, b) : strcmp(a, b);
>   }
> diff --git a/dir.h b/dir.h
> index 69a76d8bdd3..947e3d77442 100644
> --- a/dir.h
> +++ b/dir.h
> @@ -541,7 +541,7 @@ int remove_dir_recursively(struct strbuf *path, int flag);
>    */
>   int remove_path(const char *path);
>   
> -int fspathcmp(const char *a, const char *b);
> +int git_fspathcmp(const char *a, const char *b);
>   int fspatheq(const char *a, const char *b);
>   int fspathncmp(const char *a, const char *b, size_t count);
>   unsigned int fspathhash(const char *str);
> diff --git a/git-compat-util.h b/git-compat-util.h
> index ca7678a379d..ac564a68987 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -506,6 +506,11 @@ static inline int git_offset_1st_component(const char *path)
>   #define offset_1st_component git_offset_1st_component
>   #endif
>   
> +
> +#ifndef fspathcmp
> +#define fspathcmp git_fspathcmp
> +#endif
> +
>   #ifndef is_valid_path
>   #define is_valid_path(path) 1
>   #endif
