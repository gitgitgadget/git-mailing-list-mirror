Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8882B2FD1D0
	for <git@vger.kernel.org>; Tue, 12 Aug 2025 17:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755018772; cv=none; b=MWoAogNY1fjxvobNXAqsERCHVBMSjdei31Y29LlKpq2GPTY6wzMDYKlMch6PXhb8LeCxwJi0M8KvciCxN8dvaMWTl34ha1g6u3aDAw1qCQP1haSGQTZxRDB63YT6VmOXzzycGCer3gXXzHy2bKGE7vnkD6rOj6ccVA4aesfL/7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755018772; c=relaxed/simple;
	bh=VAJ9eoKs9t7ef9kg4QDisNJDul0Qp2LxR88Ra+bFTyc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GB9/MBcbZheXmSX3OG7b/STOT8JHMntiVKhyiw7gsnNkRfF0IBLrdzjsXNZCprDekMbfxqXmcE6Pj5d8+owso1/E4FqiM9KHnbYTLe79NSzOKgIjlzrLn+u06XJ9hwSWsYGJcy0G+17YI6thV+SodArxqPtQiQifawo/NoINPfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dmcDAn3u; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dmcDAn3u"
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-61b86237e65so425336eaf.1
        for <git@vger.kernel.org>; Tue, 12 Aug 2025 10:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755018769; x=1755623569; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XXlGKLn1qTFaNoT2Lgz7XJ55deOMo+Skd1qoJOdz2I4=;
        b=dmcDAn3uR1edr+MISTJWIkzZLgxOq1vbr6/DlAbSyAUkJTVYr+qa06OpJf1pK0hsWT
         wT+OJ3J9X8nfdEFRjP3QxqbI1fM7f/ae9DkNojILHh0+NY6U4RdJfYL9raBovJV1o+j/
         4WYXq7544aQ9o9Yoid1JKatTc23/lsSrdRfJr6WvAG/splgkZcM02S6OJARojoGcuu0e
         jxms7ji2b9+jkCnDfr0meII40FQCfUpW9iVSI24xXsAfKR+zmGuCt1Mf9h2DjgvBjRHC
         RXAYEiPwIOPmeWp6BdZnMyICNzGMxpvIqJubEnMvD16TqmdQE+xSIALC7AREJphE+IA+
         yvmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755018769; x=1755623569;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XXlGKLn1qTFaNoT2Lgz7XJ55deOMo+Skd1qoJOdz2I4=;
        b=ARpLCIUWgGbPMJT2abtH+DfcjIoJOjc612GnpJ/MXRuO3aTxm8tHITxBQycG5qoOkt
         yY0uWtCbDaftWzVHaOMRayRbBcgCguowJg/0V7BnmQDis5n674Tc+VjgOHDPHDVEY8aN
         4dpFb5zKfzqkZ2cdZeMNbRY6EotetK3x4ye7N0SW9IIJx8hyU4zIU57AI7UnIpg6bxlI
         M/yJKeiW4bCWTdWPHGRGznfaNBCFM4Uvu6PCZyxOw6k4ak9SJXbFIQlYc/gw6uhT8GbO
         fpGl1agnkKudOrlqVyWxrRZSh7UhiQIbEJKPeYqqvmBMSBGD6rst7JfmbniBZvdrWSOv
         ZuOQ==
X-Gm-Message-State: AOJu0Yyedx1qeAF381MzRWK4sA4Atlar4tOJifkgy67kq7mybGFzgCUW
	tsIYq8XTXThfVr6zeZzaEcT05Y/jSN9cCAKQb+MTolF+jBHiHhVAI5oIJ9ty+GBo
X-Gm-Gg: ASbGnct+zyn1HPe8WxnGrgGHTdv+j9uMAeFsaT3FGyzZweRUQ8Y0oBXhaPVeRk6p9y3
	jU3xidrq6O3vLc00Q6es0hKoUWBrNrAr6phiTbgZDc7i42CxyWnYFt/qO7/c2M/NpmxbYuJmkWi
	68TFOlVPqgRBr8jDgvCWPufhj/ahUE1f+2B0DjZD0bg+yzjxHHS0rt22KsbGh5wrjAnGXYYKZ6p
	2jZVmkjcngzVvqFcjpVLOTuplqLMrqrIMRW8ZNvUOrHtdpCE1bUSVSe+hmeAk2jCRXDfdYn8Dft
	Mcm0I9BFIt0fZIv4UjoJv/Ws2mKQX1UpvOwpusctrvEZdABlKUzOgBjOTMhXvobTOggao3ey0+E
	0OStfhBZTCWURu4Y=
X-Google-Smtp-Source: AGHT+IFnLTOyU0zyiRJa3BZFhnlry8JfZBMhDknj9hJii569jt7YK4h6wTDcANEG2NrqK6MGyxMEZA==
X-Received: by 2002:a05:6808:d49:b0:433:fd5b:ca78 with SMTP id 5614622812f47-435d4221a1fmr70458b6e.31.1755018769226;
        Tue, 12 Aug 2025 10:12:49 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 5614622812f47-435ce85a014sm256839b6e.19.2025.08.12.10.12.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 10:12:48 -0700 (PDT)
Date: Tue, 12 Aug 2025 12:12:48 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>, 
	Junio C Hamano <gitster@pobox.com>, Carlo Arenas <carenas@gmail.com>
Subject: Re: [PATCH v3 8/8] refs/reftable: always reload stacks when creating
 lock
Message-ID: <hxbcsuqwb2clzft4vuyxhxwzvft2lfhtgv3de6yx6aqftyqc76@57gtrzgik54z>
References: <20250812-pks-reftable-fixes-for-libgit2-v3-0-cf3b2267867e@pks.im>
 <20250812-pks-reftable-fixes-for-libgit2-v3-8-cf3b2267867e@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812-pks-reftable-fixes-for-libgit2-v3-8-cf3b2267867e@pks.im>

On 25/08/12 11:54AM, Patrick Steinhardt wrote:
> When creating a new addition via either `reftable_stack_new_addition()`
> or its convenince wrapper `reftable_stack_add()` we:
> 
>   1. Create the "tables.list.lock" file.
> 
>   2. Verify that the current version of the "tables.list" file is
>      up-to-date.
> 
>   3. Write the new table records if so.
> 
> By default, the second step would cause us to bail out if we see that
> there has been a concurrent write to the stack that made our in-memory
> copy of the stack out-of-date. This is a safety mechanism to not write
> records to the stack based on outdated information.
> 
> The downside though is that concurrent writes may now cause us to bail
> out, which is not a good user experience. In addition, this isn't even
> necessary for us, as Git knows to perform all checks for the old state
> of references under the lock. (Well, in all except one case: when we
> expire the reflog we first create the log iterator before we create the
> lock, but this ordering is fixed as part of this commit.)
> 
> Consequently, most writers pass the `REFTABLE_STACK_NEW_ADDITION_RELOAD`
> flag. The effect of this flag is that we reload the stack after having
> acquired the lock in case the stack is out-of-date. This plugs the race
> with concurrent writers, but we continue performing the verifications of
> the expected old state to catch actual conflicts in the references we
> are about to write.
> 
> Adapt the remaining callsites that don't yet pass this flag to do so.
> While at it, drop a needless manual reload.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  refs/reftable-backend.c | 23 ++++++++++++-----------
>  1 file changed, 12 insertions(+), 11 deletions(-)
> 
> diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
> index 3f0deab338..66d25411f1 100644
> --- a/refs/reftable-backend.c
> +++ b/refs/reftable-backend.c
> @@ -1006,10 +1006,6 @@ static int prepare_transaction_update(struct write_transaction_table_arg **out,
>  	if (!arg) {
>  		struct reftable_addition *addition;
>  
> -		ret = reftable_stack_reload(be->stack);
> -		if (ret)
> -			return ret;

Here we don't need to reload because `reftable_stack_new_addition()`
immediately following already does this for us.

> -
>  		ret = reftable_stack_new_addition(&addition, be->stack,
>  						  REFTABLE_STACK_NEW_ADDITION_RELOAD);
>  		if (ret) {
> @@ -1960,7 +1956,8 @@ static int reftable_be_rename_ref(struct ref_store *ref_store,
>  	ret = backend_for(&arg.be, refs, newrefname, &newrefname, 1);
>  	if (ret)
>  		goto done;
> -	ret = reftable_stack_add(arg.be->stack, &write_copy_table, &arg, 0);
> +	ret = reftable_stack_add(arg.be->stack, &write_copy_table, &arg,
> +				 REFTABLE_STACK_NEW_ADDITION_RELOAD);
>  
>  done:
>  	assert(ret != REFTABLE_API_ERROR);
> @@ -1989,7 +1986,8 @@ static int reftable_be_copy_ref(struct ref_store *ref_store,
>  	ret = backend_for(&arg.be, refs, newrefname, &newrefname, 1);
>  	if (ret)
>  		goto done;
> -	ret = reftable_stack_add(arg.be->stack, &write_copy_table, &arg, 0);
> +	ret = reftable_stack_add(arg.be->stack, &write_copy_table, &arg,
> +				 REFTABLE_STACK_NEW_ADDITION_RELOAD);
>  
>  done:
>  	assert(ret != REFTABLE_API_ERROR);
> @@ -2360,7 +2358,8 @@ static int reftable_be_create_reflog(struct ref_store *ref_store,
>  		goto done;
>  	arg.stack = be->stack;
>  
> -	ret = reftable_stack_add(be->stack, &write_reflog_existence_table, &arg, 0);
> +	ret = reftable_stack_add(be->stack, &write_reflog_existence_table, &arg,
> +				 REFTABLE_STACK_NEW_ADDITION_RELOAD);
>  
>  done:
>  	return ret;
> @@ -2431,7 +2430,8 @@ static int reftable_be_delete_reflog(struct ref_store *ref_store,
>  		return ret;
>  	arg.stack = be->stack;
>  
> -	ret = reftable_stack_add(be->stack, &write_reflog_delete_table, &arg, 0);
> +	ret = reftable_stack_add(be->stack, &write_reflog_delete_table, &arg,
> +				 REFTABLE_STACK_NEW_ADDITION_RELOAD);
>  
>  	assert(ret != REFTABLE_API_ERROR);
>  	return ret;
> @@ -2552,15 +2552,16 @@ static int reftable_be_reflog_expire(struct ref_store *ref_store,
>  	if (ret < 0)
>  		goto done;
>  
> -	ret = reftable_stack_init_log_iterator(be->stack, &it);
> +	ret = reftable_stack_new_addition(&add, be->stack,
> +					  REFTABLE_STACK_NEW_ADDITION_RELOAD);

Here we change the order so that we now acquire the lock first.

This patch looks good to me :)

-Justin

>  	if (ret < 0)
>  		goto done;
>  
> -	ret = reftable_iterator_seek_log(&it, refname);
> +	ret = reftable_stack_init_log_iterator(be->stack, &it);
>  	if (ret < 0)
>  		goto done;
>  
> -	ret = reftable_stack_new_addition(&add, be->stack, 0);
> +	ret = reftable_iterator_seek_log(&it, refname);
>  	if (ret < 0)
>  		goto done;
>  
> 
> -- 
> 2.51.0.rc1.163.g2494970778.dirty
> 
