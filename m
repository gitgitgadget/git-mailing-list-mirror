Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95CD16B74D
	for <git@vger.kernel.org>; Mon, 22 Jul 2024 14:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721659649; cv=none; b=dC13RLtPs/rfM1dCFBwN+4KHtNaq5DFTOr2C7VxlIZ4qP+UJgqxmbZwUFY8aOAhWvXRTVA3ovvY22z/C0zj8gK1lgAzDBrpW301UGaarndLdULzp/xhq/Rh5yVSbay3YtZFwC/+vz7eNGYrBsVGyNxD5Ki+QKRfeU4MRX4gcLY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721659649; c=relaxed/simple;
	bh=suqjh26x42+Ba170kf7tEOzFRrj8rfrlvcgqLMYZZ5Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b6cN/PSL5tFKHQdus+qkC4Cxiydj7KkhtSlvk47ZeBN0Xr+PLkuqfCysyQ78a7wAb7Xprf9WkDRZozCxMhZUNOVOqGphdle/Vm/waZ5XyJBwBQm2ltiLpmKMPgWpCFz9+Svjt5X9Zpd2dht69lQ/9aBnTFJ8Z8zVbLgMeC3lsUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FjAN31mn; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FjAN31mn"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-52f0277daa5so2094528e87.0
        for <git@vger.kernel.org>; Mon, 22 Jul 2024 07:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721659646; x=1722264446; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lskgNNQps+OwMD/xxabCjCEeHdcHlNzoL4PLqIcX7Ng=;
        b=FjAN31mnRwJLn0Z8tAZVucbOHLx1cB2tuTO/7Y0WTB7RxNjaJweQEqbLb/+nFB0v7/
         J79jQqN9dr2oVJXkmiDkJSeu8rIH5/eQZ8TLjBH+rsgJyrsP4QKgQi6Hh+A8rEZjEfKj
         RcRy8Mr75Att9JBn13IaMjjMimBwbL5rhNQF+M567N0yDxfRelICV+o36t0VRVE5UYZX
         +SKxBfQbMGCgYV+a96tmgRhcgPPnKFXhx0pSBzPIG7oVwJM7YnuymbUpB16feZajNM3r
         3pX8SWo9tUEUdGSTR1UdXg0y+iETB2sQlKRy+CiHLgQC0FVdrIP5mBLnaJOmphH+upVc
         pI5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721659646; x=1722264446;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lskgNNQps+OwMD/xxabCjCEeHdcHlNzoL4PLqIcX7Ng=;
        b=Go3ueD+tjSebdtYZb/KhW5ktUxXqFHRUCiW+uWru2Dhx1uv+I/CZz18aLNnXOI9qKb
         hlQ/tzfQwwkyVo4cbfGft/N77GGACRoR2zMRnnpdciU2ONLxGXtv/vgB5in7BjwGzSrU
         9F6keLidXwHKn492IYjnvqS2BHVzMKEFU9dCWTcAyuWeW1rxIAEegxJEzSIQPqYfYqLU
         9QOBsIxCzmQBwJXlW462ZYEmakaH8lk4QGBXHd2I4CZJ31Zv5LHaLe6sC8SukfyVi6RN
         MFLK74P2z/RaNI8LKEaEfeCikhzhM2FMJB/jjlw2yTtOdjjSpk+do4vFl2YGydqcerDK
         J3DA==
X-Forwarded-Encrypted: i=1; AJvYcCULVZsPUGIH88DTPVtE8BDYJb2KQilndkxxlqRTmUSjWgnlNM2CgmkLMzEhGF/vt5b2Q+0OAD3mMJshdjz/yt2/HT4C
X-Gm-Message-State: AOJu0Yy6J/XxWSbcw1wgwwZ46FjJC4qTKNZIfNnREfrCEy7GC2+LOQdG
	S44XOtByqRlh5kDtJbnn5WbZf5CLQsIb4EAKvistL97LgbitNfF6
X-Google-Smtp-Source: AGHT+IFm+yk7zCYR+Uqm/98MpmYzMoZ2XudV6HTHTe9XuxcC6kw/hZPiWQfEMXG/NmUwJP+mn+2gTA==
X-Received: by 2002:a05:6512:3b14:b0:52c:d27b:ddcb with SMTP id 2adb3069b0e04-52efb533c3emr5023368e87.3.1721659645592;
        Mon, 22 Jul 2024 07:47:25 -0700 (PDT)
Received: from gmail.com (89.red-88-14-41.dynamicip.rima-tde.net. [88.14.41.89])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427d69070desm132106175e9.24.2024.07.22.07.47.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jul 2024 07:47:25 -0700 (PDT)
Message-ID: <fd67d8c6-8d8d-4127-9833-5808909dd26b@gmail.com>
Date: Mon, 22 Jul 2024 16:47:24 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] check-non-portable-shell: suggest alternative for
 `VAR=val shell-func`
Content-Language: en-US
To: Eric Sunshine <ericsunshine@charter.net>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
 Eric Sunshine <sunshine@sunshineco.com>
References: <20240722065915.80760-1-ericsunshine@charter.net>
 <20240722065915.80760-5-ericsunshine@charter.net>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
In-Reply-To: <20240722065915.80760-5-ericsunshine@charter.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/22/24 8:59 AM, Eric Sunshine wrote:
> From: Eric Sunshine <sunshine@sunshineco.com>
> 
> Most problems reported by check-non-portable-shell are accompanied by
> advice suggesting how the test author can repair the problem. For
> instance:
> 
>     error: egrep/fgrep obsolescent (use grep -E/-F)
> 
> However, when one-shot variable assignment is detected when calling a
> shell function (i.e. `VAR=val shell-func`), the problem is reported, but
> no advice is given. The lack of advice is particularly egregious since
> neither the problem nor the workaround are likely well-known by
> newcomers to the project writing tests for the first time. Address this
> shortcoming by recommending the use of test_env() which is tailor made
> for this specific use-case.
> 
> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
> ---
>  t/check-non-portable-shell.pl | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/t/check-non-portable-shell.pl b/t/check-non-portable-shell.pl
> index 44b23d6ddd..56db7cc6ed 100755
> --- a/t/check-non-portable-shell.pl
> +++ b/t/check-non-portable-shell.pl
> @@ -50,7 +50,7 @@ sub err {
>  	/\blocal\s+[A-Za-z0-9_]*=\$([A-Za-z0-9_{]|[(][^(])/ and
>  		err q(quote "$val" in 'local var=$val');
>  	/\b([A-Z0-9_]+=(\w*|(["']).*?\3)\s+)+(\w+)/ and !/test_env.+=/ and exists($func{$4}) and
> -		err '"FOO=bar shell_func" assignment extends beyond "shell_func"';
> +		err '"FOO=bar shell_func" assignment extends beyond "shell_func" (use test_env FOO=bar shell_func)';

This is a nice improvement.

>  	$line = '';
>  	# this resets our $. for each file
>  	close ARGV if eof;
