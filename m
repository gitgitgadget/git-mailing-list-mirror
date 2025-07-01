Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E71427B519
	for <git@vger.kernel.org>; Tue,  1 Jul 2025 16:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751386463; cv=none; b=jzDFQPNEOOMKEALBd5hvYAY05WyTbkDvLiLI82jR8jwJDmydHm1ZoxTBvjeNrmgwYpu70eXt+0T1nL1lN42vFMN+pueOUeAQoAKHV8XUJLeAIrKt+F98z1W7pvN3axKxEcrxblkWwyFTAdqFQiPbxHp+ql+KUA5AaM7owhYV43Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751386463; c=relaxed/simple;
	bh=+rJOILKcnvW+z7mOmC2GCsvGvCUz4d2ajuA0DqklR1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cVM2Q9THmaW9j4MUIy9/7o6W+O3pz/JUmIK15EI/wYLtRqKb8vYlpvdk3oX4gWRkIB6BVgG55O95hmAulPpEcy6GU7jrJCk69WaH/TqW/IQJi8+S3p0pH2Sz5k50ySO6VsreFu61vM7mIUko7Uoke9SXCTXi6XlP8wZUTETySuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wwx8SPmD; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wwx8SPmD"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-2eb5cbe41e1so4136661fac.0
        for <git@vger.kernel.org>; Tue, 01 Jul 2025 09:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751386460; x=1751991260; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sz1IQjfCn9WI6+6F7fGwqNdZuOyWdSBCvqdatP4IZLY=;
        b=Wwx8SPmDPYqw1ed3j2J1uEiXsdxd33U8w36SmKhNU9Amf2lAlIv0lXOIt91MspNFVs
         fgDe2/zv2clFnjPJIJPONz8NBF5lDPvL+ir5DtgFQhm7zE5vJA+PT4rFSJ9/KWsnxItJ
         rtnNsOIbmKDxFcYqI5gbJ2YOESFuIXAgs9UH55Pt4nFd4fDdpDXGwfeqNhg9CVSfk+/F
         DrqrF4A7GEojR+3tpqLi1SAKYKfvPqwnGSA+9M/m77vUb22NC2B4q7unBR+7+/xCkkyv
         66ZZkDQytf11D+UbCkveyRBQtZPbBMprbuncpz3UfUOlSfEXFLIh6+T1icvePdnKnE59
         Q7SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751386460; x=1751991260;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sz1IQjfCn9WI6+6F7fGwqNdZuOyWdSBCvqdatP4IZLY=;
        b=co8jjLhMDYVAVWIPCkq0pbIQVI2/VsuJeNBG0i/1WXQHPU1q01p+ZdecWIPWwpx+Cr
         eiofV2sQwjsPBhVGYyNxw6ktO0/ck0jVtSoLZGL/0MnKA5G6Asu4IuydQWIODi/oYCc6
         h9498uRuqtS9ed8Q9OI+apG+sdR1+Ac54f9mnHGDpabLqkZUEYLICKlOJo4CqNDTllXl
         xozzLElVsHDU0mnyW2nF0eS8V/RGM0e/lECe/4RUeTN2cOfcHUU5swRUZbiBEqTjziZB
         KHK/ZIdibxyKBmln+AUXVZV5Xe01XtgzayzLal6VaMLaxj0arXO5tA6KlUFCYKhtrnjI
         Kp5A==
X-Gm-Message-State: AOJu0YwaxNC9hivlGXA/m1CXV8UXR5HORwraVe+4bbUM682VngwBGEgI
	1osVS46pRYESZ0hY14wKx0eh5PWdq8fGuwIESTkdR3PACksHXuqnUcdrlAccLQ==
X-Gm-Gg: ASbGncvuPocgxd47fDR/hyGtZcHpmMDYzrayqz/O+F3/NiNtNhGupYk42GTk7MnnGzz
	jD0mimaI0uhobgWxC6TTg2JVKqyFFS9trvFCBi2TKnWbmINoabBJKcNOEJ4OjY74lYUAjDuCO0R
	sU9RRe+ZGkmTI4PDzQ8U42zG7+Wj+/jBiuT9sgoachztf39TJSIx9shcyhM7qPesJMS6KIX0lDd
	IMx64S4kd17dlhiHK1mxS+OgBn6PFwyLIyqr5shWjpe+lf6Daq12l2LQHG/48mZDQY+ieUV0YmE
	A4tOxy9OKEobEi+Br0keIUj9adkLddERwOb5yhnpmhfqdgSaiwfETbQ=
X-Google-Smtp-Source: AGHT+IGQg7KaxHfECfvl2erWjCFkz0uUj/cSDErVypHvqq5863eSK4oTvIovBdWJXLL9RWZGa76b1Q==
X-Received: by 2002:a05:6870:b404:b0:29e:3921:b1ea with SMTP id 586e51a60fabf-2efed7149a0mr13144851fac.30.1751386460296;
        Tue, 01 Jul 2025 09:14:20 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 586e51a60fabf-2efd4ea5d9fsm3353184fac.10.2025.07.01.09.14.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 09:14:19 -0700 (PDT)
Date: Tue, 1 Jul 2025 11:08:52 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Han Young <hanyang.tony@bytedance.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] read-cache: report lock error when refreshing index
Message-ID: <t4czubzmfuihxzmefwwhcel5qyss35gmodhfhvkfyiwitb5osw@d33acdbtds63>
References: <20250701115719.85226-1-hanyang.tony@bytedance.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250701115719.85226-1-hanyang.tony@bytedance.com>

On 25/07/01 07:57PM, Han Young wrote:
> In the repo_refresh_and_write_index of read-cache.c, we return -1 to
> indicate that writing the index to disk failed.
> However, callers do not use this information. Commands such as stash print
>   "could not write index"
> and then exit, which does not help to discover the exact problem.

Ok, so `repo_refresh_and_write_index()` returns -1 when the "index.lock"
cannot be acquired via `repo_hold_locked_index()` or the index write
fails via `write_locked_index()`. The function returns 1 when the index
refreshed fails via `refresh_index()`.

Callers of `repo_refresh_and_write_index()` currently do not
differentiate between any of these failure types though. This patch
wants to begin printing an error message if the lock file fails to be
created. This would provide more insight into why the failure occurred
than simply "error: could not write index". That makes sense.

> We can let repo_hold_locked_index print the error message if the locking
> failed.

It looks like `repo_hold_locked_index()` already has the
`LOCK_REPORT_ON_ERROR` flag which will print the message we want.

> Signed-off-by: Han Young <hanyang.tony@bytedance.com>
> ---
>  read-cache.c     |  2 +-
>  t/t3903-stash.sh | 15 +++------------
>  2 files changed, 4 insertions(+), 13 deletions(-)
> 
> diff --git a/read-cache.c b/read-cache.c
> index c0bb760ad..50e842bfa 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -1456,7 +1456,7 @@ int repo_refresh_and_write_index(struct repository *repo,
>  	struct lock_file lock_file = LOCK_INIT;
>  	int fd, ret = 0;
>  
> -	fd = repo_hold_locked_index(repo, &lock_file, 0);
> +	fd = repo_hold_locked_index(repo, &lock_file, gentle ? 0 : LOCK_REPORT_ON_ERROR);

Here we begin passing the `LOCK_REPORT_ON_ERROR` flag to print the error
message only if `gentle` is not set. Makes sense.

>  	if (!gentle && fd < 0)
>  		return -1;
>  	if (refresh_index(repo->index, refresh_flags, pathspec, seen, header_msg))
> diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
> index 35b85c790..39098ade4 100755
> --- a/t/t3903-stash.sh
> +++ b/t/t3903-stash.sh
> @@ -1571,11 +1571,8 @@ test_expect_success 'stash create reports a locked index' '
>  		echo change >A.file &&
>  		touch .git/index.lock &&
>  
> -		cat >expect <<-EOF &&
> -		error: could not write index
> -		EOF
>  		test_must_fail git stash create 2>err &&
> -		test_cmp expect err
> +		test_grep "error: Unable to create '.*index.lock'" err

The test now checks for the explicit lock error message. The check for
the "error: could not write index" message is also removed even though
it should still be present in the output. Should we also continue to
grep for that message too?

>  	)
>  '
>  
> @@ -1588,11 +1585,8 @@ test_expect_success 'stash push reports a locked index' '
>  		echo change >A.file &&
>  		touch .git/index.lock &&
>  
> -		cat >expect <<-EOF &&
> -		error: could not write index
> -		EOF
>  		test_must_fail git stash push 2>err &&
> -		test_cmp expect err
> +		test_grep "error: Unable to create '.*index.lock'" err

Same question about testing for the previous error message here.

>  	)
>  '
>  
> @@ -1606,11 +1600,8 @@ test_expect_success 'stash apply reports a locked index' '
>  		git stash push &&
>  		touch .git/index.lock &&
>  
> -		cat >expect <<-EOF &&
> -		error: could not write index
> -		EOF
>  		test_must_fail git stash apply 2>err &&
> -		test_cmp expect err
> +		test_grep "error: Unable to create '.*index.lock'" err

and here

>  	)
>  '

Thanks,
-Justin
