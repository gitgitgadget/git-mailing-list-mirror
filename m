Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3B82C1A2
	for <git@vger.kernel.org>; Wed, 11 Sep 2024 15:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726067783; cv=none; b=bjWpZkmTnyTNWo0OEhgUwQGwLWeR/k0QAVNwFFfEowhLeeF6keZnxJEF4HPQoNuxmV+dL0pe+ZC0PS609sVTTtPYq5lRQv/cIDKhE56QWDrJkVaMRPUO6hnHrN2bpPEazbLkox86PQD+HeKajIaoNJxCcBUqjNaAvEg4v19uEi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726067783; c=relaxed/simple;
	bh=O75BX+oDjq6UK4xvmuX9wj092U9yMpZ4x10cobdUrm0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oRIpW2oA0lGcfaJnrodUdTbq9VjBrNwJD0ieUg01dahZqGFeYseb1JEuo5h/jqWIatk7IqM71RCxLNBEeXXrArLRpDnyNU6un0EC5JWJRb9SUMfceJCfUGuAInSS0+RJOvyhKytE+WNYmGVoSGqpGPomzdw5PK6ZjCQppajZh+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gwzR3b5X; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gwzR3b5X"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-27b88b8a24aso2618752fac.1
        for <git@vger.kernel.org>; Wed, 11 Sep 2024 08:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726067781; x=1726672581; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PjIccEHI7cYJSBPWA135MxE69/BoYG5fmkgr6FYTyFU=;
        b=gwzR3b5XBNTIJ7ZWMf8dLxFaar/WvnTOWRmv7jMtE0HbPPVPcuOvbFR7V4u5tdeo/r
         nj1t2f6t01MPMfce7CrV7wgzgRDVwAH2DF4DLUd1F0XDMqjNqiRu5KN8x86gczJg5q8w
         ldHxpA3J7oxpOIdXKJQfauLGl15aZUr9u3Zk0ZetTHS1n1tfYhvZr0kzBASdqfR2Wyzk
         F9VlmgRn7ZCBmEy9B9KGPG7P5JG2jMny0KdX8IMIvsyxygc8DFHwxoUrL/QT/pDSoGR9
         M42EDpp2ObDPDYvWfYE9+cdZ3ZbFrX3d4V89Nl2udFYPr9pY/Qx+2lBTWD8t5aL5R+Ph
         W0wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726067781; x=1726672581;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PjIccEHI7cYJSBPWA135MxE69/BoYG5fmkgr6FYTyFU=;
        b=SyvGTnY4R8vXmpUDTm1yaCqEFBzcpwpv8P+8QnsSpWdqEjewRkTQ55HXnbdalMV/tC
         uSkMxh5hI0Em++XuISeqqqOPxiDAXzYQNyqzQkFq/ljYX94hwzr1mOWshMaXfsSu8atZ
         Rl2XznY1MzUk5iz6+xuJXDtIEBFaTnZ0N5UqZVobXdjZ6yHEarH/oK9yETHgEwaKA0l0
         uULgCmkw7jqBm3Vmi+h7xARvqhiseeOdyp4HwDghnHckj/CV9ZfcFC57qYX1kTGI4Jtd
         DyhmLHeixOVxfwvtsRg1KTLKnVCjb91PrPkrLaG3fdciiImlIrBsn8EQtyWJQfQGy+wT
         jyIA==
X-Gm-Message-State: AOJu0Yyq9spLw/q8ySqamhGMZuDLqh3k5akBJTYzPYsGgpcmtXBqZvoa
	dtOiMRSaUtEYoMW7IYPFAwyhz/4NWZ+1djoNhe26kvSOQJVegKcU
X-Google-Smtp-Source: AGHT+IFjn+gwRX92L2RcgDgjF3nH3vP/d0sw3bOtxRa0/vK/3m7OXUY06HLYHg/4NxG9rP9QHVaKjQ==
X-Received: by 2002:a05:6871:808:b0:278:bfa:87da with SMTP id 586e51a60fabf-27b9d92a7c9mr9918151fac.10.1726067780963;
        Wed, 11 Sep 2024 08:16:20 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-27ba3e49e18sm2639641fac.11.2024.09.11.08.16.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 08:16:20 -0700 (PDT)
Date: Wed, 11 Sep 2024 10:15:06 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Calvin Wan <calvinwan@google.com>, 
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 06/21] environment: make `get_git_work_tree()` accept
 a repository
Message-ID: <wnorpwj5stwekbdvqzz6oyom5ppqhcsg3afvujslmy45r2djdb@sn6voa5d2e5v>
References: <cover.1724923648.git.ps@pks.im>
 <cover.1725008897.git.ps@pks.im>
 <22e9dcb28a981eaa1a37a8b41e8d061347ed6c2e.1725008898.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22e9dcb28a981eaa1a37a8b41e8d061347ed6c2e.1725008898.git.ps@pks.im>

On 24/08/30 11:09AM, Patrick Steinhardt wrote:
> The `get_git_work_tree()` function retrieves the path of the work tree
> of `the_repository`. Make it accept a `struct repository` such that it
> can work on arbitrary repositories and make it part of the repository
> subsystem. This reduces our reliance on `the_repository` and clarifies
> scope.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
[snip]
> diff --git a/repository.c b/repository.c
> index cdefcb4002d..92238da3d9e 100644
> --- a/repository.c
> +++ b/repository.c
> @@ -126,6 +126,11 @@ const char *repo_get_graft_file(struct repository *repo)
>  	return repo->graft_file;
>  }
>  
> +const char *repo_get_work_tree(struct repository *repo)
> +{
> +	return repo->worktree;
> +}
> +

Now that `repo_get_work_tree()` is accepting a `struct repository`, it's
only functioning as a simple accessor and seems somewhat unneccesary. Is
it preferrable to keep this?

-Justin
