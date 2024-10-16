Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2E8208208
	for <git@vger.kernel.org>; Wed, 16 Oct 2024 17:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729099487; cv=none; b=FrIhek0TYcydvmbEbyW30w/hP6v0pVt1sNmPu0CoeqgHTb4RqxhnrC4G8+MM/n+wscmqMhILY0rrHG8TrbUurinZgwxErtcTnyXEiou145V6WpW4i5qHxPxEA3uX9pwOf6P7EA1J1OFoG0jUVdlXi/UQgBAVLuV3SAit8E2SL3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729099487; c=relaxed/simple;
	bh=lChnWxBHb39ak+lF28cViEJQ9IUFrDAjgJe4mYgsfVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gl31MxbH9JSuuCnua7xKiH30TQrohwy3HmHVP4TgdfCxqkw3AJB6SaKnAPyB5yqTDDiHPlvrtu6vC1zqQ3MutKTgCU+CBigCX+QlvVw07i1DvF5PnUR833gH8wliiyOUk2RDd0pV8d5wOKFUSxAHHOPkW97ZxJiJ5AcXg1Y3+Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Enufqcym; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Enufqcym"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7ea7ad1e01fso46324a12.0
        for <git@vger.kernel.org>; Wed, 16 Oct 2024 10:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729099485; x=1729704285; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jIPxatP4yNWckP1BKTM3NvhaojlXy28y67LP8/sxd64=;
        b=EnufqcymXraHxt/C5stUChDbnFGq41j4ozKcrrd1bNEXp1NARR3f0s6ILIJgaT2wJA
         M5fpYBojR2rgDWFWliV8sTh0b8+S6IoIFBiVIiWdbMXIm8SYbRWtobOkf0YmLK1XOY+D
         kLyS17YA6eTA3LCYmHrK4fjmKJobf9jWkyYVCjisK37sN6V4+azaEGofb1kRyxREgZqO
         eUgb3Dp0HxpjbLdZiiOOE6PVsG/krRCS+zHSJ8uPsj+HNzsZQpd7d6kPqjo2vxknr6+d
         xy/K/1uGAB9WHHa1ik2108V9Qsp95IInke0XuUtmGKlsF36Up4FDGsHQiyzoHTZKtmUS
         3/Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729099485; x=1729704285;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jIPxatP4yNWckP1BKTM3NvhaojlXy28y67LP8/sxd64=;
        b=QayhZGP8eRA8Ne23lRx9M8+R1h1HZUGxbfkIQCimNZeTGnKvKrGtJzAY0C25ZTXCNo
         2Nrn0fvA2C03MwUJLXAaxTwCS5pkKUPDGFFJzqA5Q/vGrKyX2PKX/zDJ48scjLmqK0Rh
         PZUZ+ZrV9cVtivNlyWJ/jBO8NffpukcWw3iKEf5TOQ0nNGRPMY2FXnEswSXqjgr/Wiv/
         3NQtWdFU5UJ01XNR3Q8I4Px4XKmoVcu+NZ1DXIcb30jyVVx5uK52Pjde1YpcdZODSpBt
         9fbWhC5zXoYDbhVRGXVi1II94Ba9QPZ7/Owc3RGSfK0eT/qJQEjMCZoqcak6lrOP3E7C
         +Y3A==
X-Forwarded-Encrypted: i=1; AJvYcCUULANMvIeQJCWTbemLbf29wH4EFlXSnAo5BHqJrhhqAWVcbSqtKOUkqVsZErIc205pKXM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSrK7eLqswILM0TxnIVpmBk7nDwjuabgvCp6310x95Vllc9Usv
	hXRw0icLFcREPPBWJ+2/wZe8Bl+faRNfJaC1EXeFs2Llnw9/IFWQ
X-Google-Smtp-Source: AGHT+IHWisz+LxjUAiAvR0nhdRpZKYGng/opybL+zZcW+uRV2t3Js4cGm00kl1mO9/Tso4Q8sPc0nw==
X-Received: by 2002:a05:6a20:e347:b0:1d9:167a:7890 with SMTP id adf61e73a8af0-1d91c6a3e44mr480558637.11.1729099484623;
        Wed, 16 Oct 2024 10:24:44 -0700 (PDT)
Received: from five231003 ([2405:201:c006:3236:dcc1:5355:4129:c7c3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e774ccfb9sm3431200b3a.173.2024.10.16.10.24.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 10:24:44 -0700 (PDT)
Date: Wed, 16 Oct 2024 22:54:41 +0530
From: Kousik Sanagavarapu <five231003@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: shejialuo <shejialuo@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/3] repository: move git_*_encoding configs to repo scope
Message-ID: <Zw/22XHvtOw6IEHe@five231003>
References: <20241015144935.4059-1-five231003@gmail.com>
 <20241015144935.4059-2-five231003@gmail.com>
 <Zw6SsUyZ0oA0XqMK@ArchLinux>
 <Zw9Z_xcHKcjKVUB4@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zw9Z_xcHKcjKVUB4@pks.im>

On Wed, Oct 16, 2024 at 08:15:37AM +0200, Patrick Steinhardt wrote:
> On Wed, Oct 16, 2024 at 12:05:05AM +0800, shejialuo wrote:
> > There are many builtins will execute this config setups by calling
> > "config.c::git_default_config" and then "git_default_i18n_config". If we
> > need to use "repo" pointer, we may need to wrap this pointer. (This is
> > not the problem and it is not hard).
> > 
> > But what if the "repo" pointer is NULL? We still need to set the value
> > of these environment variables. Because when using "git-mailinfo(1)"
> > outside of the repo, we still need to set "git_commit_encoding"
> > according to the user's config.
> > 
> > So, from this perspective, I don't think it's a good idea to put these
> > two configs into "struct repository". Because we can use these two
> > configs outside of the repo, if we put them into "struct repository", it
> > is strange.
> > 
> > However, I either don't know which way we would apply. So, I cannot give
> > accurate answer here.
> > 
> > ---
> > 
> > Patrick, I wanna ask you a question here. What's your envision here in
> > above situation. As you can see, if we put some configs into "struct
> > repository" and we run the builtins outside of the repo where we need to
> > set up configs, the "repo" is NULL. And we will get into trouble.
> > 
> > My idea is that if a config could be used outside of the repo, then we
> > should not put it into "struct repository".
> 
> I guess it would be nice to have a set of convenice functions in our
> config code that know to handle the case where the passed-in repository
> is `NULL`. If so, they'd only parse the global- and system-level config.
> If it is set, it would parse all three of them.
> 
> I also kind of agree that it should likely not be put into the `struct
> repository` in that case. I think where exactly to put things will
> always depend on the current usecase. I bet that in most cases, we
> should be able to get away with not storing the value anywhere global at
> all, which would be the best solution in my opinion:
> 
>   - It can either be stored on the stack if we don't have to pass it
>     around everywhere.
> 
>   - It can be passed around in a specific structure if we pass the value
>     within in a certain subsystem, only.
> 
>   - Or we can parse it on an as-needed basis if it happens deep down in
>     the calling stack when it's used essentially everwhere.
> 
> Now there will be situations where we used to store things globally as a
> caching mechanism, and not caching it may have performance impacts. But
> I guess that most cases do not fall into this category.

I like the idea of dynamically fetching the value of the config and not
caching it somewhere - although in this particular case, ie the
*_encoding configs I'm guessing it would be better that we cache these
configs.

Now the important question is where.  In point 2, you mention about
having a separate structure - do you mean for all those configs which
would not be a part of "struct repository"?  Of course in their
respective subsystems.

Coming to point 3, won't we still have to store it somewhere when we do
need it deep down the calling stack where it is used everywhere, since
we need to pass it around?

Thanks
