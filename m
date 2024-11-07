Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247D020FAAB
	for <git@vger.kernel.org>; Thu,  7 Nov 2024 16:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730995440; cv=none; b=a1bb46K89N9dNLKwj8ed/k12m5McxjVEHrdzLOU+e5OooSTuy8pd29rRf/OOkAFILVe6kmtFHVaFCuTyblkpWNunyh6AukEHSGXRIBsZrcWqZG1+k+7zU/tulKbQwf/xcJ1ofx7beTkQ9ST8HYX8wsJ1FRU91zNJIVv9pxmpKvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730995440; c=relaxed/simple;
	bh=Hbd/AqkJjSl8r8YarayFvU/rFnBDUNc5EHkgQcKg07s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BYVfDJFsEKr5zw1dyhXTLNGdrJ1FrRP5pPBFRTUvXdoFKwKAIAXV4RBnajkSxWEf5C/bibTdW7ZFbZZCjE9fBkiBrNF9QpOlCjojUFbSW7msKx1rIrS7zVntQxQGYIuNHFw0IRG/gJ8vwdD/teV+v7jD8uB2KLOb/LMBlRD4Ogs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qc0e6OjM; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qc0e6OjM"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-20cbca51687so11630035ad.1
        for <git@vger.kernel.org>; Thu, 07 Nov 2024 08:03:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730995438; x=1731600238; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+QHOyzbLPAVws5o8GPmTQjIqPd3juH6d3dUPgIH7Hn0=;
        b=Qc0e6OjMn89/Gw+l05tT7plY6mk/nBdeeN2lZhU61YK0rxF+8a9G850KP4tMJ5lAzE
         Tne5BBw19tW/VdE2pWd/zgiz6xWdutxt0A+6HROCaZJ3RogKeKYVVWl+gB0uzXSHN3rV
         3km0Rs4Bd9BCn2/1BS5HuwnS+qX5MMjwZKhcNahi65UE/8Fq5+y9QD/pMChqZBkI18kr
         zOzuzyEATO2xlbH40ufitcUcfzohKq26H8zPAuIxfxlKnaMOq+Eii/kIUbAn8M8ZdIU/
         AkSYPZpn/qkjMbKIG4sR7hq69RI1Rk4aUicMhN5Isr1s+cqk0z0mqQKugb/1/rKJtYQp
         9F9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730995438; x=1731600238;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+QHOyzbLPAVws5o8GPmTQjIqPd3juH6d3dUPgIH7Hn0=;
        b=SocSAxsvwKvbl3yEPN+W9HsJKM5O9A5eNO4bB1fwseYIaQIzjW0ymS6tY2CrfXn7xL
         NX9DIxEA2mfjG3RDGhsSDnG+93iAMTuKG8jz/42mpaDtRZGcu0+4Ad7ZjXgk/t7JMf6w
         a0U4pmzVSDa0bP9DtyXq79khtPdivvaHBrVMVcaQIv9CmZVmCDX6FY3v24DKPFr1y6uN
         Y3ZopMvz0mgFs1kqSyGkf7qDNnZR5S67u7HJQO/cGhL5Ca/9VkLKyJUU6a9d+3kCguXW
         Qk2hjWuGCZDmtcTMYCewWrbrkgCYj1pNjISLorPGazYabj89Cub/VMilgGna7hby4zoW
         rT+g==
X-Forwarded-Encrypted: i=1; AJvYcCVtQPH792bVv7ZXAZu8eQLKyjlwYAowZzG1ffj/s3DzDMS5qb32wzyqQtu5MbkecVX0IfA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTyFJ1UtbWjC+AWwEViSApnZvC3je32aJy8yXnp4TK60EabM6u
	+u1KtaB4rlI7QIUAgFZ+7+9+WMt/kdYEbvY13rfDg6+ofB6NwRGHsJX63kDd
X-Google-Smtp-Source: AGHT+IH1ErednWtEXDyJBwrWaYfVA7MjZ1l/A35IXwh/kGcX2TrS4sTWbJ/Hug+vFAb+O8RQttW0Xg==
X-Received: by 2002:a17:903:22cd:b0:20e:5777:1b81 with SMTP id d9443c01a7336-2111af6f21cmr333556665ad.50.1730995438148;
        Thu, 07 Nov 2024 08:03:58 -0800 (PST)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177dc9f17sm13876605ad.20.2024.11.07.08.03.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 08:03:57 -0800 (PST)
Date: Fri, 8 Nov 2024 00:04:21 +0800
From: shejialuo <shejialuo@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: John Cai via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org,
	John Cai <johncai86@gmail.com>
Subject: Re: [PATCH 1/3] git: remove is_bare_repository_cfg global variable
Message-ID: <ZyzlBZnL-K3S7Env@ArchLinux>
References: <pull.1826.git.git.1730926082.gitgitgadget@gmail.com>
 <3d341a9ae4ef1d2776734fa82a45913f91e6083c.1730926082.git.gitgitgadget@gmail.com>
 <xmqqv7wzsijc.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqv7wzsijc.fsf@gitster.g>

On Thu, Nov 07, 2024 at 02:46:15PM +0900, Junio C Hamano wrote:

[snip]

> >  int repo_init(struct repository *repo,
> >  	      const char *gitdir,
> > -	      const char *worktree)
> > +	      const char *worktree,
> > +	      int is_bare)
> >  {
> >  	struct repository_format format = REPOSITORY_FORMAT_INIT;
> >  	memset(repo, 0, sizeof(*repo));
> > @@ -283,6 +288,8 @@ int repo_init(struct repository *repo,
> >  	repo_set_compat_hash_algo(repo, format.compat_hash_algo);
> >  	repo_set_ref_storage_format(repo, format.ref_storage_format);
> >  	repo->repository_format_worktree_config = format.worktree_config;
> > +	if (is_bare > 0)
> > +		repo->is_bare_cfg = is_bare;
> 
> When repo_init() is called with anything other than &the_repo, who
> initializes repo->is_bare_cfg?

I also want to ask this question. Actually, I feel quite strange about
why we need to add a new parameter `is_bare` to `repo_init` function.

For this call:

    repo_init(the_repository, git_dir, work_tree, -1);

We add a new field "is_bare_cfg" to the "struct repository". So, at now,
`the_repository` variable should contain the information about whether
the repo is bare(1), is not bare(0) or unknown(-1). However, in this
call, we pass "-1" to the parameter `is_bare` for "repo_init" function.

When I first look at this code, I have thought that we will set
"repo->is_bare_cfg = -1" to indicate that we cannot tell whether the
repo is bare or not. But it just sets the "repo->is_bare_cfg = is_bare"
if `bare > 0`. Junio has already commented on this.

This raises a question: why we need to set up `is_bare_cfg` in the
`repo_init` function? I guess this is because we need to set up other
"struct repository" parameter like the following:

    if (repo_init(&alternate, sb.buf, NULL, the_repository->is_bare_cfg) < 0)

And I think it's better for us to use the following way.

    alternate->is_bare_cfg = the_repository->is_bare_cfg;
    if (repo_init(&alternate, sb.buf, NULL))

And we may create a function called `repo_copy_settings` to set up the
common setting inherited from an existing repo:

    repo_copy_settings(alternate, the_repository);
    if (repo_init(&alternate, sb.buf, NULL))

I agree that we could put `is_bare_cfg` to "struct repository *". But I
don't agree with the idea that we need to pass `is_bare` to `repo_init`.
I think we should know whether the repo is bare or not before calling
`repo_init`. And from my understanding, this is what we are doing now.

Also, I think we may add a enum type instead of using (-1, 0, 1).
(However, this is not the main point of this patch).

Thanks,
Jialuo
