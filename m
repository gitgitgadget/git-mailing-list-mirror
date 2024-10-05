Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6889D20E6
	for <git@vger.kernel.org>; Sat,  5 Oct 2024 06:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728111079; cv=none; b=PehXdVlMUpkF8kXXD2VlkcqlcaMYERKQ9xhiOpaeuOiXVLDxoCltQWzZLXUtht4WKL4xCQo7GZy/jjYJKVbcrCEQkIDWXzdqjDFz0CYSp2aMwiyWib2ldf6V7SpubKnIQk8ZI8Xyjwzb1Oi63wyC+AwNmQk90A6mTjNO+3oPPUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728111079; c=relaxed/simple;
	bh=HqcSgM/p0GA4aZj6nLV1nVNPaP3SfXsxyogMXfSKn0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LXrak/8mJGPLW4Pnc5FnqYEor+g4He699k5cbcHH/migGWLEd62iyt0GS6XFzjQcDTjfrA9ULuRouRRO4EsnnXV37sY9w+cIgAuDdddVMjl0agLYzBTKvg2KnjMMPF4w2c9Vn1GSgGOIx9eXe3pzMw97+7Mc4zRLQd469U8Sra8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZUn91NFp; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZUn91NFp"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7198cb6bb02so2077058b3a.3
        for <git@vger.kernel.org>; Fri, 04 Oct 2024 23:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728111077; x=1728715877; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aaQaQVYsAI2nhiOw4xD3phJD9Hqlfhc8T3kILjJLWUs=;
        b=ZUn91NFpnHuHiXUobjdrEJSUPFyTQsF6Z5gKVt+FCD9LYo+GApFGwToeQym15qjyte
         ydxSHSJm60AB5bXsPA93qWJdmRk+F9/AUFqIYu5ZccHQWxKGofMyBFZAhHNkQOe3rerr
         jDM1MEfMKr5HnZR0WaQXdnmDG0bU7hIEEHR/SDpVzPCJpli1ZgnNFlRlrQ+QXopJrtAy
         daTE4QDuZilQ2CBhuiMmKrv3IpASSgqPWctcuo6HC6bcBSImlRBOmb56c5J7Sn6O8B3q
         +TYZ54HLC92X85a1DYKprrZSSnCUOGWUg4H101qidT5D8JVkEnwKrUX4SNTHHINK8h+r
         MKNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728111077; x=1728715877;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aaQaQVYsAI2nhiOw4xD3phJD9Hqlfhc8T3kILjJLWUs=;
        b=Qz7mqYHU8o/g4Jopuqis1I1gU+ni0RMTU7ClgyPp6b6Mzf7k/7k4LYxxz8NNKoLeYA
         t8B2onlMD53CTGytvXK7KGfdMqyW65y1qgU1EsKkblJf9/jXTtx0QutZqQ8ED0w1dPmh
         Qpw+YbjRUgp/ichpkzCddm/bjO2qiV6nWRURvhDnQENaX9xpbpQYQjaQNJ8Lgh2ACC46
         DkJgS3fG7YnmT85/DyFNgpzt2tdkEUTkND0WORltRytAXPjVB+vuk+QlLF06bIlGQK4d
         q6lMmW+NrEY6mVRwe/FBK0Z27O1RgMC9H9SvUQpqeBOfGUbikev/weL2kRasXAymJwHh
         8O2A==
X-Gm-Message-State: AOJu0YwIVIcBXNx6GMv7klJbfUqPJoLeBr/wM+khfdbKt2JCbqMXE5Ka
	aGW2w+uM8dQtyILE2RPqO3GkVdRH05xx/jlLcYaZ2E05kahR3omjuvgDRw==
X-Google-Smtp-Source: AGHT+IF6PcJSeJTYbQhtS80a+BaPrrvLNNFU6FN//lGtNom3tSSvPGyz2TZrpNzRiYSN5/NLFgYMkw==
X-Received: by 2002:a05:6a00:1390:b0:70e:8e3a:10ee with SMTP id d2e1a72fcca58-71de2439b6bmr7763545b3a.21.1728111076611;
        Fri, 04 Oct 2024 23:51:16 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0ce0577sm901934b3a.88.2024.10.04.23.51.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 23:51:15 -0700 (PDT)
Date: Sat, 5 Oct 2024 14:51:21 +0800
From: shejialuo <shejialuo@gmail.com>
To: John Cai via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
	John Cai <johncai86@gmail.com>
Subject: Re: [PATCH v3 1/3] git: pass in repo to builtin based on
 setup_git_directory_gently
Message-ID: <ZwDh6XAKIhUF_Lu6@ArchLinux>
References: <pull.1788.v2.git.git.1727718030.gitgitgadget@gmail.com>
 <pull.1788.v3.git.git.1728099043.gitgitgadget@gmail.com>
 <8009fdb38b0b4c3880588119b99ac5387d398540.1728099043.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8009fdb38b0b4c3880588119b99ac5387d398540.1728099043.git.gitgitgadget@gmail.com>

On Sat, Oct 05, 2024 at 03:30:41AM +0000, John Cai via GitGitGadget wrote:
> From: John Cai <johncai86@gmail.com>
> 
> The current code in run_builtin() passes in a repository to the builtin
> based on whether cmd_struct's option flag has RUN_SETUP.
> 
> This is incorrect, however, since some builtins that only have
> RUN_SETUP_GENTLY can potentially take a repository.
> setup_git_directory_gently() tells us whether or not a command is being
> run inside of a repository.
> 
> Use the output of setup_git_directory_gently() to help determine whether
> or not there is a repository to pass to the builtin. If not, then we
> just pass NULL.
> 
> As part of this patch, we need to modify add to check for a NULL repo
> before calling repo_git_config(), since add -h can be run outside of a
> repository.
> 
> Signed-off-by: John Cai <johncai86@gmail.com>
> ---
>  builtin/add.c | 3 ++-
>  git.c         | 7 ++++---
>  2 files changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/builtin/add.c b/builtin/add.c
> index 773b7224a49..7d353077921 100644
> --- a/builtin/add.c
> +++ b/builtin/add.c
> @@ -385,7 +385,8 @@ int cmd_add(int argc,
>  	char *ps_matched = NULL;
>  	struct lock_file lock_file = LOCK_INIT;
>  
> -	repo_config(repo, add_config, NULL);
> +	if (repo)
> +		repo_config(repo, add_config, NULL);

The reason why we need to check whether the `repo` is NULL is that when
using "git add -h", the RUN_SETUP flag would be converted to
RUN_SETUP_GENTLY.

I think this change is OK. But I wonder whether we should encapsulate
the logic into the "repo_config" function. It's a little cumbersome to
check whether the "repo" exists. I also feel it's a bad idea to check in
the "repo_config" function because in the most time, we run commands
inside the repository. So, in my view, at current, this is enough.

Thanks,
Jialuo
