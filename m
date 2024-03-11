Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18AD54FB7
	for <git@vger.kernel.org>; Mon, 11 Mar 2024 18:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710182078; cv=none; b=tmhH9oav1kH7f6hOez8sfGKiy87at4nh7FMGfsETI0Xvzf14pq2K6tzY8PMJSAoCkcTRrVrxfJLJ+Ujx8pb0VecB6bi3J49Lrn4eDwrbezDbGRYLxx0Rr7/OtWUmqhxA4rrx932qcrrYS//FQ+43KPPC0J6KzlhUJDMOftp5G/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710182078; c=relaxed/simple;
	bh=n8T9GfshtVo3q3h7zB33DJQ7rNeekLSXjMMmkS0V91s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mQ1b1IclRTgcHtmMM2CKLsf4mhbADPwtrNrgj0ek96qoEAhxkfJTii9EYh1Mmzx0cQYTv0miny0kDMXZjJldsGrkmjcxQNvzrJJAw+39+KeOfWGoGznhwOEBJHhfNeoNn9yTxH5AqXBLR2aMUBikXxHeledXHlEk6GM5wooL1NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Bd8xznC7; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Bd8xznC7"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6e4d48a5823so2463801b3a.1
        for <git@vger.kernel.org>; Mon, 11 Mar 2024 11:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710182076; x=1710786876; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=snsNGpJZr0czhCrWikI/peor1bqZ6NVLmQ4W8zfNbv0=;
        b=Bd8xznC7uV9uD9aO3uVt7WqjwL8DJ/yuztL7Cv236yrVOwNiT+TnEFO/WmtTqcCHGF
         oGEpLoabvV/q8WVkwDXVQupboPX667frdmG72KxQQr3yi96CNhwU4JL0l2VXjTA9T3v1
         7G64BQyHZd4YT3M9rj+51uJtI6c40KbfIOlpQdipn7uehagpTujw6OKJBvKLny8XhnmK
         sVVQfYUXMx6we0W5qXKlM3t3qg3ABNZpDDJw86j6EcwIk6QwqXVekUyGooFMKpCdVLmd
         HIxLBS6nxDxByexLqCAT7Ifhc+0KVXcebQAhym5DmMn6yZaxjH2WTqbIPZCACrZHYF6b
         J/dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710182076; x=1710786876;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=snsNGpJZr0czhCrWikI/peor1bqZ6NVLmQ4W8zfNbv0=;
        b=vueMqNsIFEvgsQUwt9Y1rmxyKBB2HAMCLJp7kIE4ICkRua4ADQPzLI5shVBJHUF54J
         eWssYBfn7Wo2xGTXEIg0LeZH9phn/qT2Axidw3NQgM471mo/E+QncNGUV1nktb+6Zp/V
         nQxd27D7/ueezSz2vAMYVWkPotqJtZolVs2OEjJB6gOxEGnsNEUdDv/mKgkQCSuKA/AB
         sOYtSBgpCiDAv2LvBIYHIAh8lh8g4QG/e4Q/rEvI5i30wG1dIxLt7EeJSr86tsolstHO
         k2b0/EHX8mqHb8vg8TNVFa99HVaME+F8Gb2bTvbRmVUw9UP19DrgyT6JYYuPJKAHGzCy
         Lu0A==
X-Gm-Message-State: AOJu0Ywsu+kU79dIl/UhRaMc++IYiwb6M1FFUIrnpWCHR3+/taaxTXtk
	ROyOzmt3M8KxcaL2ZiOJoucyNDsltYRBogYL5sCIZYFhSlWaLlj+SHED7dIZYXKziyNsm46t3BG
	dvA==
X-Google-Smtp-Source: AGHT+IF3rFuhLl9cRknYWEZROT9XxRFVz/d9X5tT6b2UCpHEm2R19Dy7s9QUnmrYoGr363zsFlQMOw==
X-Received: by 2002:a05:6a20:a105:b0:1a3:1469:38cc with SMTP id q5-20020a056a20a10500b001a3146938ccmr4050215pzk.16.1710182075881;
        Mon, 11 Mar 2024 11:34:35 -0700 (PDT)
Received: from google.com ([2620:15c:2d3:204:ee9a:b4b8:1c56:1478])
        by smtp.gmail.com with ESMTPSA id n4-20020aa78a44000000b006e64ee44f51sm4696128pfa.71.2024.03.11.11.34.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 11:34:35 -0700 (PDT)
Date: Mon, 11 Mar 2024 11:34:23 -0700
From: Josh Steadmon <steadmon@google.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/7] refs/reftable: reload correct stack when creating
 reflog iter
Message-ID: <Ze9Or6vctPJGOV_l@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
	Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
References: <cover.1709640322.git.ps@pks.im>
 <b0414221ecad1920c84f4ab498e55edec57f06b6.1709640322.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0414221ecad1920c84f4ab498e55edec57f06b6.1709640322.git.ps@pks.im>

On 2024.03.05 13:10, Patrick Steinhardt wrote:
> When creating a new reflog iterator, we first have to reload the stack
> that the iterator is being created. This is done so that any concurrent
> writes to the stack are reflected. But `reflog_iterator_for_stack()`
> always reloads the main stack, which is wrong.
> 
> Fix this and reload the correct stack.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  refs/reftable-backend.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
> index 249a618b5a..f04be942ac 100644
> --- a/refs/reftable-backend.c
> +++ b/refs/reftable-backend.c
> @@ -1682,7 +1682,7 @@ static struct reftable_reflog_iterator *reflog_iterator_for_stack(struct reftabl
>  	if (ret)
>  		goto done;
>  
> -	ret = reftable_stack_reload(refs->main_stack);
> +	ret = reftable_stack_reload(stack);
>  	if (ret < 0)
>  		goto done;
>  
> -- 
> 2.44.0
> 

Is it possible to write a test to demonstrate the bug that was fixed
here, or is it too much of a race condition to reliably trigger?
