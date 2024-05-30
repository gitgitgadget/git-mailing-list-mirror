Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4D8495E5
	for <git@vger.kernel.org>; Thu, 30 May 2024 20:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717102641; cv=none; b=pqYsQiI9lpP5Fc0L61u0QVQBJEqg7IfX1mmc0TPPv4ToKeKgMLrQaxN8cr/nTQkd2+s9CIzjr9DtjEhr1EDrVAaNd09PzAMJhyPAXPwWGWuy2BiM5qZuLTglbyFbNMJAZ5e7/N+VwQ5tlsbBLjKoaf/7Dpjdaz+t+7bkyCrlyWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717102641; c=relaxed/simple;
	bh=lIo2Q7lUv+07fvHbsvYB8QeVEMRIZDyof9Miv07gnJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sWO6hoBw6Byrj142b1znHjuj6+RCs+KGo6grL1N/rlqnv3/MzmFN+0RDO9PShP5dOMbe3qc1ssAhgnLhN36W4oL4H0zj5iBEjslcrR0ukLWEBoDkzuR0V8lnD54RAz3A8vBzO7pqEPsrrOB8ipufljUTiiQraOk+kyG+B5yqTRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Q5XonCIi; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q5XonCIi"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-70244776719so88249b3a.2
        for <git@vger.kernel.org>; Thu, 30 May 2024 13:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717102639; x=1717707439; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rhBosOwP5r7eBWOLfWdH1kLQIwNf8lpV5mCfwnnIc7E=;
        b=Q5XonCIiejbkVhsi5i+mu4PL+o/1rFtiIkcSfxCLGUurKvOQljoDovcGJXa2+vtrPD
         wgFGQg4QEDOq115ACWLA6bhO7IaF7SWjLTfwo8YnpAdzJQ54WLPdavzTNirp7jmB2UOq
         YgFSuzXBwepPsSCk96dMBF2cEWvMSJtnrBC8JvmCfdQS4RRH6jtwJ7ynIYE8WAca6Pva
         bUkqytQAgActUUyp19Izp1XN9L9wnzYvbS45Kq+jPog3SHKzSZkkuEIkoh+T9WOd01g1
         QThfx7jGvP61q5/666LUoXkGkXJpTyFS6a3RMN+irQUZ1z/pfkZN6/aKHvf5QL2aPHrC
         A0pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717102639; x=1717707439;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rhBosOwP5r7eBWOLfWdH1kLQIwNf8lpV5mCfwnnIc7E=;
        b=VGgw1fQjLVJEvAO9iGbsYg0zWg1sxr0J6GNVluzhqbh2PoI67FVgBqMjG5P9tjGG2q
         rIUod+vajXOTHFqxg4+v/sx32DiqZdKYNZEuVcjzhwDbw0Vl92CatCAhBT7Oa6Ym/9P3
         LixTSTEta6Kl9s94Xr2q4K56X5BsuNhfPW7aA5kC9F2xJWAsOdaylYneWaqxTyvvss+Z
         /Argl+mYr/nKaUj3md7IoHCjPzj9JA1xpBoMHkflslwbBsMHPCfytcOGD/JwvffWsq//
         /7arywDy3e/owPl5OEiqqW+LyMOdNbeVwFgeOSJTC6sYbsozaHYCtnSLZOi1goZIgELx
         GA0A==
X-Gm-Message-State: AOJu0YxiA37AQCoyRBsXI5uRqs5ilkUDGh4FGjy7J+dS7M4VMYWa6U7Y
	KF7X1e095BdgaL03iZFI4hLGm/wGkf5TozoaxsOhUdOLHTQqfwQJ/kHukuGwG4gmozX7c9PfUxd
	PAcAo
X-Google-Smtp-Source: AGHT+IFfDsB4+T1cSN0E7VHyo4M132TY6JcfRaSH26Uh96hYv93vRtsC3u+9KmXGd2moAbqHofXtUQ==
X-Received: by 2002:a05:6a00:1bc9:b0:6f3:ef58:2dd0 with SMTP id d2e1a72fcca58-7023110c955mr3287099b3a.8.1717102638829;
        Thu, 30 May 2024 13:57:18 -0700 (PDT)
Received: from google.com ([2620:15c:2d3:204:e7f:cbca:98b7:654])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70244486e5bsm85297b3a.62.2024.05.30.13.57.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 13:57:18 -0700 (PDT)
Date: Thu, 30 May 2024 13:57:13 -0700
From: Josh Steadmon <steadmon@google.com>
To: Marcel Telka <marcel@telka.sk>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] scalar: make enlistment delete to work on all POSIX
 platforms
Message-ID: <v6q5pahyzcoa7c6tp2x63awvtc6xvjjpi4kl5okgk5qi4god7f@yg55zwwmcuzt>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>, 
	Marcel Telka <marcel@telka.sk>, git@vger.kernel.org
References: <Zkds81OB7C5bTCl_@telcontar>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zkds81OB7C5bTCl_@telcontar>

On 2024.05.17 16:42, Marcel Telka wrote:
> The ability to remove the current working directory is not guaranteed by
> POSIX so it is better to go out of the directory we want to delete on
> all platforms unconditionally.
> 
> Signed-off-by: Marcel Telka <marcel@telka.sk>
> ---
>  scalar.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/scalar.c b/scalar.c
> index 7234049a1b..331b91dbdb 100644
> --- a/scalar.c
> +++ b/scalar.c
> @@ -361,16 +361,13 @@ static char *remote_default_branch(const char *url)
>  
>  static int delete_enlistment(struct strbuf *enlistment)
>  {
> -#ifdef WIN32
>  	struct strbuf parent = STRBUF_INIT;
>  	size_t offset;
>  	char *path_sep;
> -#endif
>  
>  	if (unregister_dir())
>  		return error(_("failed to unregister repository"));
>  
> -#ifdef WIN32
>  	/*
>  	 * Change the current directory to one outside of the enlistment so
>  	 * that we may delete everything underneath it.
> @@ -385,7 +382,6 @@ static int delete_enlistment(struct strbuf *enlistment)
>  		return res;
>  	}
>  	strbuf_release(&parent);
> -#endif
>  
>  	if (have_fsmonitor_support() && stop_fsmonitor_daemon())
>  		return error(_("failed to stop the FSMonitor daemon"));
> 

This looks like a straightforward change; none of the formerly protected
logic uses anything specific to Windows, and tests still pass on Linux,
so this looks good to me.

Reviewed-by: Josh Steadmon <steadmon@google.com>
