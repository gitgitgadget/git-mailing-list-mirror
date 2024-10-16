Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B604616FF5F
	for <git@vger.kernel.org>; Wed, 16 Oct 2024 16:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729096306; cv=none; b=Vp+2I2hETNCyq7r675jhRrYbD11NYsKukg8gOy23gGP04NxEMUlm+W9yGdD3obGKYu5gDoVKv6M7G5eG+Hb2DynzgpLdrwe6dW/2AwO83lDUk8939A0nXMK84uHfHhpxGXpb+eFJ0sMsXOScZxc3jK/dgOdZPnZomGoQaLuTEdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729096306; c=relaxed/simple;
	bh=nm7fXZPp2niaPZnYsVA2dnBSHJjfGWyPw+dZeegfoE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EXzp7NXpvLK2DbUa02dIaQwzryJEAoM1TZ2gcyD++dANEnZ+Q+OM8dOGL7N/lu9ge6COso/LVjI/45RiSLMVUubVCDgJtr8BDmr8zF71KD8QrlL9hSh01JQN0447OLWjBeoByBECOdExrvV53AdHWZmZ036jutafqKd872T6YNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KmWntVLe; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KmWntVLe"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7163489149eso5645268a12.1
        for <git@vger.kernel.org>; Wed, 16 Oct 2024 09:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729096304; x=1729701104; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y/ydC6Vy7E4zLrnjs15Nkg7oP/9KdLynwrKcUFsbhWQ=;
        b=KmWntVLeSnBqmOa4QUSN6p5iFjQGIgNKN93lzph626C14sq9M26ceDeTR0ASnv4LVi
         0k+aXl0umKQqQk5ggjr+EPRZcq5sPhS++/bJHeDtRFiK3ugPQf3mb6rKCKfmYW6domuv
         BAr6zR1QIVMf6SboKSxtb/pqYxI/pYsqShR31TdjA4xLiV3i64r+pZhBUlcF6lvVRnON
         EcNaFxS2Yxqq6u5OmS1VzhoQ/Dn6uqpFl79Hb0vkRLE85R55aBCR2b0Yq8+lbdX2PQ5b
         5dWmPoHv+DB6sCe2E5ikjtNRSJmo+qMeC/RB9g40I+SYmjL+8lNWUcuUwh3Uz/tXA71b
         3tCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729096304; x=1729701104;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y/ydC6Vy7E4zLrnjs15Nkg7oP/9KdLynwrKcUFsbhWQ=;
        b=Dl5WMxcZwV9yPv6nP0D1vBPG2V60m7ipFugWe+wX5UMGmBst/2IQiqwJHeyl2X2Kfb
         y+Voflv4F84+7FzEaQueRSC3lGfKPwyW0XVFgWh1E7I/EAgLO/hx/ReC7c2YRWxWbatM
         dRhzuHenf8ld4i/k7h3j/cmD5Vtf6gNNNRBKYfSEZhE+hiO1ybAPqBQ/ZSItDuOA+u3p
         hS/dwxq6N7SYTxB4SkqjB8tn+0YUlpchxzI3S8G9/nyiXphRVXbTsy0gD6j4eG2fvKqq
         hY1ItA01RYzon58Tcc3aaRLQb3oyG5Tf16X+dzzrtWroGbim9wn3FWfd2AKtY+wv2oC1
         Ah6g==
X-Gm-Message-State: AOJu0YxuLDVRwnaPQYXSBsj1hoa75Ncl4IFOsweP4juDPnVn+w/OAaYp
	o/AOp8C073oTm1JBH0tubzAIiaIvvn3LnwGrin+PvVi+Dyt6oKcf
X-Google-Smtp-Source: AGHT+IFEl85I0mmv4KsNjZAo4StcmE0A5kL+Bm4rm5BDbkLN6r+IQ8P9qsx4I7+C/kDak+arSH4rhg==
X-Received: by 2002:a05:6a21:3511:b0:1d8:fc17:ab02 with SMTP id adf61e73a8af0-1d8fc17ad21mr7749823637.33.1729096303768;
        Wed, 16 Oct 2024 09:31:43 -0700 (PDT)
Received: from five231003 ([2405:201:c006:3236:dcc1:5355:4129:c7c3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e774a41d5sm3252874b3a.129.2024.10.16.09.31.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 09:31:43 -0700 (PDT)
Date: Wed, 16 Oct 2024 22:01:38 +0530
From: Kousik Sanagavarapu <five231003@gmail.com>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 1/3] repository: move git_*_encoding configs to repo scope
Message-ID: <Zw/qan9tu/SqKbPf@five231003>
References: <20241015144935.4059-1-five231003@gmail.com>
 <20241015144935.4059-2-five231003@gmail.com>
 <Zw6SsUyZ0oA0XqMK@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zw6SsUyZ0oA0XqMK@ArchLinux>

On Wed, Oct 16, 2024 at 12:05:05AM +0800, shejialuo wrote:
> On Tue, Oct 15, 2024 at 08:01:22PM +0530, Kousik Sanagavarapu wrote:
> > Move "git_commit_encoding" and "git_log_output_encoding" to "struct
> > repository" and amend the functions associated with peeking at these
> > values so that now they take a "struct repository *" argument
> > accordingly.  While at it, rename the functions to repo_*() following
> > our usual convention.
> > 
> > Doing so removes the implicit dependency of these variables on
> > "the_repository", which is better because we now populate these
> > variables per repository.
> > 
> > Signed-off-by: Kousik Sanagavarapu <five231003@gmail.com>
> > 
> > [...]
> > 
> > diff --git a/config.c b/config.c
> > index a11bb85da3..656748692d 100644
> > --- a/config.c
> > +++ b/config.c
> > @@ -1690,13 +1690,15 @@ static int git_default_sparse_config(const char *var, const char *value)
> >  static int git_default_i18n_config(const char *var, const char *value)
> >  {
> >  	if (!strcmp(var, "i18n.commitencoding")) {
> > -		FREE_AND_NULL(git_commit_encoding);
> > -		return git_config_string(&git_commit_encoding, var, value);
> > +		FREE_AND_NULL(the_repository->git_commit_encoding);
> > +		return git_config_string(&the_repository->git_commit_encoding,
> > +					 var, value);
> >  	}
> >  
> >  	if (!strcmp(var, "i18n.logoutputencoding")) {
> > -		FREE_AND_NULL(git_log_output_encoding);
> > -		return git_config_string(&git_log_output_encoding, var, value);
> > +		FREE_AND_NULL(the_repository->git_log_output_encoding);
> > +		return git_config_string(&the_repository->git_log_output_encoding,
> > +					 var, value);
> >  	}
> 
> There are many builtins will execute this config setups by calling
> "config.c::git_default_config" and then "git_default_i18n_config". If we
> need to use "repo" pointer, we may need to wrap this pointer. (This is
> not the problem and it is not hard).
> 
> But what if the "repo" pointer is NULL? We still need to set the value
> of these environment variables. Because when using "git-mailinfo(1)"
> outside of the repo, we still need to set "git_commit_encoding"
> according to the user's config.
> 
> So, from this perspective, I don't think it's a good idea to put these
> two configs into "struct repository". Because we can use these two
> configs outside of the repo, if we put them into "struct repository", it
> is strange.

Makes sense.  Now that I've read this, it does indeed feel strange to
put these configs in "struct repository".

It also raises the question of how correct would it then be that these
configs and the configs similar to this are guarded by
USE_THE_REPOSITORY_VARIABLE macro - since they may not necessarily
depend on "the_repository" too - ie in cases when we are running outside
of any repo.
