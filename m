Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C7228C02A
	for <git@vger.kernel.org>; Thu, 10 Jul 2025 23:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752189980; cv=none; b=f5Sn/EdMcVr4arhkJARBWARjJ+2+bo+Au14hRGofOwQRjmKQeCqh0XUtxihSMEGvNRwuUPMyGTeOa/sqVJ5RST/kcCcqQdbNxWYzmh1Nc9i75+R+r2BrubaqzLnVh83UxBjclzXdzSkjelIHmAhRvMkWht0kuyC/V5zu0NWoTSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752189980; c=relaxed/simple;
	bh=rBIbHVTl5FCOo3XsAJ//bUcgEAwGhwb1qkJ5k1gnR+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k6lPnaHof01iEBzsvGc/tnGk4H2xqaXRA8BdZEgf5BpbCRVLmuPTqtVmxxCprxxY8JbduPQ7knDl0s35pbejXv+/yK2TysnV/rEMnKL7qhDE/sQnZueVdMvuBrMUoSt1ddm4nKrpHdq8EHjW6ZAw7S7DPAsMrAsJcQyM5vsipPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=X1oONtUp; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="X1oONtUp"
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e8b62d09908so1412383276.2
        for <git@vger.kernel.org>; Thu, 10 Jul 2025 16:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1752189978; x=1752794778; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rBIbHVTl5FCOo3XsAJ//bUcgEAwGhwb1qkJ5k1gnR+U=;
        b=X1oONtUpyh8ReKFbqzuoxPDbTjyTXTx7IfJK4pmoKcGpkdt4zTZt7x+jiq1ApMfsaF
         wik+uJIWWjFTsAMZjuuS07lJOol9nNBWwVIKaQyOHZnfoCavDnhH9ufwQgVb6AnsZFzk
         0j08zegWK3muN1RWR5NMg1aEHir49NJCae2aSFWZhMch2V7hBE82H/qYpC7n4I8sAFAp
         feDAsFJuZnk6Odn1y8MiTcYSBpZKWDfuCySRlt3Gt/l2tRUBTjcBayQqk0vjTfM5VgIX
         z7Mctxi8Z35+oQqjtsCejR0PvIJrAVdydjkNDZePC6LhgOTk4wf+m6dyj92xK6jhw0NQ
         o9ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752189978; x=1752794778;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rBIbHVTl5FCOo3XsAJ//bUcgEAwGhwb1qkJ5k1gnR+U=;
        b=sxFoRGYCNKEguNdfg56Py6fBK5isNVtjCNGXIesuTVf2tqGX4UTglcKNHJ3hMqvUrR
         VQJJcW0yoOGvnrrzlXSmyxrosvy5mY1vYUhXfDrGNwzAxbIFfixTjwDxiGlWG2lN3DLP
         Lj7Wq/Nfj5GmoRwHPuu3VJAyFWw1Cv/QhSMh2SQSqiGF3Z/HKdFvaztxN0lMJcljD7uQ
         upv2Sj2jJ5TWANF/u6lkpW5Y2L/5wugew374Ujt+rglkGDCNjr57TV6Lk/kPKg+I5vhV
         bQLg0Xta8nl0vDMEF8nLLLiqUPclnXooAbTH4wag0LwjI813hU+die5ime2BVygLT4Ke
         LiUw==
X-Forwarded-Encrypted: i=1; AJvYcCWuJ1J4HfAKH2wlwNweJWQMZEKp5aiFXO//Ccpz7GaX+uc2Uq+Xi/FtJ+9jjCpBbSM9EQE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9PLOKKQSCGPiC4pD0e4jHKamniVAwSV3D8Es66RXg9bNOqLRH
	ey0zq+C6VapFixaytK7MUF1QnEAZTnEwqu/xuoqCyJWEizem6RO7RVm20RQ7Cmta+wI=
X-Gm-Gg: ASbGncvz+Rnwn9Is+V776eGbRkv8T5DyKlRUC5LBWhDngdC6H5sY3Ct5zVT69rr8exY
	F4aeXqL6HrL93PwUZoOcOm0osl2GckDWKWQukoWf6yBYPVAa9+zxW+1W+vNrIL/wTne+T7HNzdr
	3SeYRJJLWS8wqkDeCLaR2Qnl/c7UCz4pEgQBnwEWZpEyG7ga9cqf3ODTHzw0ZRc1QqAt8Yc1yKk
	vAZJ/QzCzrKFwqsZrBxik2Ek4gZQ/OJsjBbGgDFxwBWcIJht8tfJmVlV7+5sNLj/5B1QSJGjqJQ
	KbEW1RsxuOwzIwuN4V31SDI7txOm4luMPOc7T7xPxz9wA42EH/kyy1pHxdPv8e/iDw7HN5dnvFc
	A7t14j2lMFVgKa2eybNrZu3g7vKM+lcHIGTxaw1cvip5Z3ZEwjsUmYthc08N0iNXZjqKbaQ==
X-Google-Smtp-Source: AGHT+IGKreakWCA5GtqRdE2yAU5Mx4FGct8Ldx7xyov4LUzQQnR9soTrB/1jlZgFgcxslQkEgK6XZA==
X-Received: by 2002:a05:690c:708a:b0:70e:142d:9c56 with SMTP id 00721157ae682-717d7a1c4fcmr16616557b3.26.1752189977854;
        Thu, 10 Jul 2025 16:26:17 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-717c61b4d04sm5097937b3.57.2025.07.10.16.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 16:26:17 -0700 (PDT)
Date: Thu, 10 Jul 2025 19:26:16 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Justin Tobler <jltobler@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: [PATCH 4/8] midx: track whether we have loaded the MIDX
Message-ID: <aHBMGBHaD/Yfx/uT@nand.local>
References: <20250709-b4-pks-midx-via-odb-alternate-v1-0-f31150d21331@pks.im>
 <20250709-b4-pks-midx-via-odb-alternate-v1-4-f31150d21331@pks.im>
 <kmprav735ntlgo3x47ptxyhqc6c5n7tyyub5c545gw2g4achng@sst72rcazce4>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <kmprav735ntlgo3x47ptxyhqc6c5n7tyyub5c545gw2g4achng@sst72rcazce4>

On Thu, Jul 10, 2025 at 05:16:12PM -0500, Justin Tobler wrote:
> Looking at `prepare_packed_git()`, it checks
> `r->objects->packed_git_initialized` to see if it has already been
> initialized. If the intent is to start calling `get_multi_pack_index()`
> for each source individually, doesn't `prepare_packed_git()` still only
> execute once regardless already?

I was wondering the same thing. Perhaps that packed_git_initialized
field is going away sometime in the future and this is its logical
replacement (at least for MIDXs)?

In either case, that would be worth clarifying. If it's not doing
anything (i.e., because we have no plans to get rid of
packed_git_initialized), then I agree that this patch could probably be
dropped, but I suspect that I don't have the full picture in my head yet.

> > Address this issue by introducing a new variable that tracks whether we
> > have tried to load multi-pack index of a given source.
>
> The contents of the patch look good, but I'm not entirely sure
> introducing a separate variable to track if the source has attempted to
> load a MIDX is useful.

Yup.

> -Justin

Thanks,
Taylor
