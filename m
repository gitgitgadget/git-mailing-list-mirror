Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8653A8C0
	for <git@vger.kernel.org>; Mon, 12 Feb 2024 10:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707734688; cv=none; b=pI9pdbP/Fq/R/uY0X+Tcjdf0VzK/yj/1Y/S0LcBrdyjKXKqUEq+mU2V+LyN+tqLRTrHhOv8RSZzOBvHYVdF5UrOVwTJYhSFRGdZywaFgZ8XvsWgh6UdpOESebP8JA4be5D8CfePKJjuFAzSNrZUf49VVT+PJdSv3hqNLF+esIoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707734688; c=relaxed/simple;
	bh=DiAWb241YuEet4/5L1OHdPD8kHuFOlw7YHz3rYvpkYc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TZ0RdkfUYJC/J3iUuesYOQupXw2D0Kiz2NvkqEBDGnHq7jUosT2EMoFSLZfGmdZhhV4zQRjfJRKjnlLRYPkRwkmFMaTEw38GfcCkDWfKJku3jyHIkFklQxlt4YRiLqsLKbfflxOv6we7q7ucxvdRo0hDhgiYczdjh6wG5u7gRmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j4MFFJtU; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j4MFFJtU"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a26ed1e05c7so401599166b.2
        for <git@vger.kernel.org>; Mon, 12 Feb 2024 02:44:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707734683; x=1708339483; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=LuzMqqwVCYjc1WWmhd9Jr1x+bZRkpPBWY/VucGlfhv0=;
        b=j4MFFJtUIQ9auDoufVDBah1niUdG1azaC5UFXjpcOPrle0JahBxtFSnQaFbFnqulSI
         2twsjC/zxWYR6l0sxueg1bINv42Hl0CLXLcR8E2zX9miXr+hK6k0OewTcd1RQNKqUM2z
         +yPqnUuyiRk4CeLKhmU5irpo/KvtNdNDoW9MmCf1sEc8QAGT1N1pcyyEhKKVDmt/2dKU
         Z9t6T8JjkNen9QzL+EeBfmHDWAMgN6YUTHoyvFkc5aH6GWbPpWwMtl+xqUvu+MZJG4rM
         wDfbhkteWROsTtBy4LYB+kEGYOXHBpXChST/nQ1RSV4QKhTx1Rciy8QHwbGVl+rLpsY6
         nGXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707734683; x=1708339483;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LuzMqqwVCYjc1WWmhd9Jr1x+bZRkpPBWY/VucGlfhv0=;
        b=RbQhs/EH//L4Zd+o5FauxpIEX4ZcxF6BqbabhcnbIkkUrWr34+xkrJsPRGDdIPYgQv
         rvJPEHb1KzTdRbJj0boBOlgs06B8b2HF/1zXtY5RS17hOJF20tUA2b7bsP3XYhC9kggr
         O43uRCXaRxiQxSjkWhFtCVA+rFigLLOcU+JbgndpmusfdB2TszVgqExsoQr33b8FVJrm
         YLKIF2lkuJZkpeRUDMskhwIvcrW+odU4e7Lk2cVNQH7FRHIYuLtLIflJVp43asBZStsx
         bF7Etu1S22Fu3BwhM5bM50HtXEaT5xCJtab/A66AHMd69w2B0bXuwN4ywBy9GIBKEKIE
         BBtg==
X-Gm-Message-State: AOJu0Yxh+wrk6v4dQmoNdHt4AagXqVWAVrWfChOV9CQttqMwC5t24OUa
	YkF4LFb9uOekvftzfGLi71Dp3pwRfw7NvcK5uc8c1+Ltx7wrtQPb
X-Google-Smtp-Source: AGHT+IF7Pw4NBTRs1lM4bvLQ/qNbPLrXh9s0FpYiFh64hW5m0wlo88QhZVwYdvNh+Gueln2p23qZbQ==
X-Received: by 2002:a17:906:3b5a:b0:a3c:63ee:ad82 with SMTP id h26-20020a1709063b5a00b00a3c63eead82mr2503279ejf.19.1707734683186;
        Mon, 12 Feb 2024 02:44:43 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUCRFsN/nWz84myvSmllPVq2/q9ee9OeHyilHQU/EiNlJsgWzpS1NZJJtDrBqCA02AwbK7tfx2HeSavpa9QnEXQ7ROK61KMWK2sV4NWogWJRdWOlJISIywgcH+5SsKlMZWMSA==
Received: from ?IPV6:2a0a:ef40:62e:a901:d2c6:37ff:fef6:7b1? ([2a0a:ef40:62e:a901:d2c6:37ff:fef6:7b1])
        by smtp.googlemail.com with ESMTPSA id gz9-20020a170906f2c900b00a3515b35be4sm72920ejb.104.2024.02.12.02.44.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Feb 2024 02:44:42 -0800 (PST)
Message-ID: <c625239a-a847-475a-a228-9deb622c67bf@gmail.com>
Date: Mon, 12 Feb 2024 10:44:41 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2] unit-tests: do show relative file paths on
 non-Windows, too
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Johannes Schindelin <johannes.schindelin@gmx.de>,
 "Randall S. Becker" <rsbecker@nexbridge.com>
References: <xmqqttmf9y46.fsf@gitster.g>
 <6872b42d-8763-44dc-9502-2362d1ed80a7@gmail.com>
 <xmqqle7r9enn.fsf_-_@gitster.g>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <xmqqle7r9enn.fsf_-_@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Junio

On 11/02/2024 15:58, Junio C Hamano wrote:
>>
>> We know which separator we're expecting so we could replace  the last
>> two comparisons with
>>
>> 		prefix[prefix_len -1] != needle[1]
>>
>> but as I say I'm not sure that is worth re-rolling for
> 
> There is a larger clean-up opportunity to drop the need for making a
> copy, which probably is worth doing, so I folded the above into this
> version.

Ooh, that's nice. This version looks good, I found the code comments 
very helpful

Best Wishes

Phillip

> ------- >8 ------------- >8 ------------- >8 ------------- >8 -------
> 
> There are compilers other than Visual C that want to show absolute
> paths.  Generalize the helper introduced by a2c5e294 (unit-tests: do
> show relative file paths, 2023-09-25) so that it can also work with
> a path that uses slash as the directory separator, and becomes
> almost no-op once one-time preparation finds out that we are using a
> compiler that already gives relative paths.  Incidentally, this also
> should do the right thing on Windows with a compiler that shows
> relative paths but with backslash as the directory separator (if
> such a thing exists and is used to build git).
> 
> Reported-by: Randall S. Becker <rsbecker@nexbridge.com>
> Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> 
>    * I found that the diff relative to the result of applying v1 was
>      easier to follow than the range-diff, so here it is.
> 
>    diff --git c/t/unit-tests/test-lib.c w/t/unit-tests/test-lib.c
>    index 83c9eb8c59..66d6980ffb 100644
>    --- c/t/unit-tests/test-lib.c
>    +++ w/t/unit-tests/test-lib.c
>    @@ -64,34 +64,33 @@ static const char *make_relative(const char *location)
>     		 * prefix_len == 0 if the compiler gives paths relative
>     		 * to the root of the working tree.  Otherwise, we want
>     		 * to see that we did find the needle[] at a directory
>    -		 * boundary.
>    +		 * boundary.  Again we rely on that needle[] begins with
>    +		 * "t" followed by the directory separator.
>     		 */
>     		if (fspathcmp(needle, prefix + prefix_len) ||
>    -		    (prefix_len &&
>    -		     prefix[prefix_len - 1] != '/' &&
>    -		     prefix[prefix_len - 1] != '\\'))
>    +		    (prefix_len && prefix[prefix_len - 1] != needle[1]))
>     			die("unexpected suffix of '%s'", prefix);
>    -
>     	}
>     
>     	/*
>    -	 * If our compiler gives relative paths and we do not need
>    -	 * to munge directory separator, we can return location as-is.
>    +	 * Does it not start with the expected prefix?
>    +	 * Return it as-is without making it worse.
>     	 */
>    -	if (!prefix_len && !need_bs_to_fs)
>    +	if (prefix_len && fspathncmp(location, prefix, prefix_len))
>     		return location;
>     
>    -	/* Does it not start with the expected prefix? */
>    -	if (fspathncmp(location, prefix, prefix_len))
>    -		return location;
>    +	/*
>    +	 * If we do not need to munge directory separator, we can return
>    +	 * the substring at the tail of the location.
>    +	 */
>    +	if (!need_bs_to_fs)
>    +		return location + prefix_len;
>     
>    -	strlcpy(buf, location + prefix_len, sizeof(buf));
>     	/* convert backslashes to forward slashes */
>    -	if (need_bs_to_fs) {
>    -		for (p = buf; *p; p++)
>    -			if (*p == '\\')
>    -				*p = '/';
>    -	}
>    +	strlcpy(buf, location + prefix_len, sizeof(buf));
>    +	for (p = buf; *p; p++)
>    +		if (*p == '\\')
>    +			*p = '/';
>     	return buf;
>     }
>     
> 
>   t/unit-tests/test-lib.c | 61 +++++++++++++++++++++++++++++++----------
>   1 file changed, 47 insertions(+), 14 deletions(-)
> 
> diff --git a/t/unit-tests/test-lib.c b/t/unit-tests/test-lib.c
> index 7bf9dfdb95..66d6980ffb 100644
> --- a/t/unit-tests/test-lib.c
> +++ b/t/unit-tests/test-lib.c
> @@ -21,12 +21,11 @@ static struct {
>   	.result = RESULT_NONE,
>   };
>   
> -#ifndef _MSC_VER
> -#define make_relative(location) location
> -#else
>   /*
>    * Visual C interpolates the absolute Windows path for `__FILE__`,
>    * but we want to see relative paths, as verified by t0080.
> + * There are other compilers that do the same, and are not for
> + * Windows.
>    */
>   #include "dir.h"
>   
> @@ -34,32 +33,66 @@ static const char *make_relative(const char *location)
>   {
>   	static char prefix[] = __FILE__, buf[PATH_MAX], *p;
>   	static size_t prefix_len;
> +	static int need_bs_to_fs = -1;
>   
> -	if (!prefix_len) {
> +	/* one-time preparation */
> +	if (need_bs_to_fs < 0) {
>   		size_t len = strlen(prefix);
> -		const char *needle = "\\t\\unit-tests\\test-lib.c";
> +		char needle[] = "t\\unit-tests\\test-lib.c";
>   		size_t needle_len = strlen(needle);
>   
> -		if (len < needle_len || strcmp(needle, prefix + len - needle_len))
> -			die("unexpected suffix of '%s'", prefix);
> +		if (len < needle_len)
> +			die("unexpected prefix '%s'", prefix);
> +
> +		/*
> +		 * The path could be relative (t/unit-tests/test-lib.c)
> +		 * or full (/home/user/git/t/unit-tests/test-lib.c).
> +		 * Check the slash between "t" and "unit-tests".
> +		 */
> +		prefix_len = len - needle_len;
> +		if (prefix[prefix_len + 1] == '/') {
> +			/* Oh, we're not Windows */
> +			for (size_t i = 0; i < needle_len; i++)
> +				if (needle[i] == '\\')
> +					needle[i] = '/';
> +			need_bs_to_fs = 0;
> +		} else {
> +			need_bs_to_fs = 1;
> +		}
>   
> -		/* let it end in a directory separator */
> -		prefix_len = len - needle_len + 1;
> +		/*
> +		 * prefix_len == 0 if the compiler gives paths relative
> +		 * to the root of the working tree.  Otherwise, we want
> +		 * to see that we did find the needle[] at a directory
> +		 * boundary.  Again we rely on that needle[] begins with
> +		 * "t" followed by the directory separator.
> +		 */
> +		if (fspathcmp(needle, prefix + prefix_len) ||
> +		    (prefix_len && prefix[prefix_len - 1] != needle[1]))
> +			die("unexpected suffix of '%s'", prefix);
>   	}
>   
> -	/* Does it not start with the expected prefix? */
> -	if (fspathncmp(location, prefix, prefix_len))
> +	/*
> +	 * Does it not start with the expected prefix?
> +	 * Return it as-is without making it worse.
> +	 */
> +	if (prefix_len && fspathncmp(location, prefix, prefix_len))
>   		return location;
>   
> -	strlcpy(buf, location + prefix_len, sizeof(buf));
> +	/*
> +	 * If we do not need to munge directory separator, we can return
> +	 * the substring at the tail of the location.
> +	 */
> +	if (!need_bs_to_fs)
> +		return location + prefix_len;
> +
>   	/* convert backslashes to forward slashes */
> +	strlcpy(buf, location + prefix_len, sizeof(buf));
>   	for (p = buf; *p; p++)
>   		if (*p == '\\')
>   			*p = '/';
> -
>   	return buf;
>   }
> -#endif
>   
>   static void msg_with_prefix(const char *prefix, const char *format, va_list ap)
>   {

