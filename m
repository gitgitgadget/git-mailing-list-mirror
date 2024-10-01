Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513051B0119
	for <git@vger.kernel.org>; Tue,  1 Oct 2024 04:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727756493; cv=none; b=ZDudpbNQb4UZYAkr6dRGA5pkyX6A6QYT9sRHuujMNrLxu+LMfY7aahIDp1E3zLITaqe/6OMroKlfCnxOR4WgWzjr93S4nzDMzxCuPPE0U9QGbbDarGu14qtVbkeXXQ78NRva7VmDMgiydVcXj/M6JZ6YgVxaWAnFC4tALvGGbAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727756493; c=relaxed/simple;
	bh=l1vUO5t08pKVz2W7G9Zklv6kHMOrItMLv7dVyY3ViB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=onP1Jbog5I+Y6QB1z7e86uBdBA+N9FkkaKNwsr0EH+6mRejd2MIwVVIb7YMTIWAMhl+BjhlNH5ShrRRxQu54q6Hp0f+OAX9cA9pO06bYfvJQ5/JjFmhAX3rcqyeNm5Fs/PCF8z6JDfBkKlmEJZ1/uuMoLylazaGptxr36fa0rA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KGO3gbnN; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KGO3gbnN"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-20b0b2528d8so56040145ad.2
        for <git@vger.kernel.org>; Mon, 30 Sep 2024 21:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727756491; x=1728361291; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=d7SxXFE1UMESVJZb5j9rQthuDBTMqEMX/ZLRDo1qhxs=;
        b=KGO3gbnNdniJmnR9zPWUJy+F+hBAjHDqEq2G38Z9lNc2tu/u/k2chGhHg4hvr9q64M
         QP1dDjcd4HTOPL7DR55mK1xyBFCiRZ46x8cJwOUemUXGvrGHqw/XWX5wEbVjPVjbm+Z1
         brKfwo1wy0Av/3d0Q0g2oYtedD0on07seTr1A9/pAF//S6hsT6YOgh/Ou8lD0FggpE7G
         ZDXNkA42/95+imH2EcgBqsD4A8n6wSVqGaonfUkntd9Y2Bo6E/sCMYSv+GC9v4jLrCKe
         N4rRWcT+1MLUPlemu0PAm/mLGZWgKeRu0zQPMJMTj1Ii0WxJY2jzehfJizPggPGBAui7
         6FyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727756491; x=1728361291;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d7SxXFE1UMESVJZb5j9rQthuDBTMqEMX/ZLRDo1qhxs=;
        b=pLA4g3KpSHBfcSa4cAIA7RmGQ7v3grZN2aT7PNIpp1yDlr+mnc/skSZBzzZ7AlsHd7
         Mjwg1MTuXPz3AWbZqaNpoCdZFqiDQOZJSNNYG7N9QDTE2lxZEHRKDEypNOdTbkjhbuw/
         Y6Lj1d1eChV24SroSem99PsDVxzyjhuNfaRf49+007nIc2Oo2J9svxwTVx9VUhqDjBoe
         MYNq447F3R5EwHZFX1W/3GduqikuNMA78MyJiekV0penRElXz0BV2zbRMtYdnlYrBwri
         D1CtsUMeHzywkIvpLQ9WM71Y31Ve8nCOMElZH7ThiC7ZqcmRCF3/6E+S34QKXBfHErpz
         TwXQ==
X-Gm-Message-State: AOJu0YxCCIumE06sGZd5HwI8NVfrF7u8ytOgMWOZyrNGtJhnNKVe3RoI
	G0EezfcjqGZeFHgYp75Hb9vdBHs4iFnSKZqvP1Ihv/xud/TcrBYE
X-Google-Smtp-Source: AGHT+IEQwSqCwWJy3ZSNShpe3fq4vZF3dMFlJqkcCda9rZtryBh6V4oI5uvUp+RwFTOgKkFSN1d1jw==
X-Received: by 2002:a17:902:ea02:b0:20b:b26e:c143 with SMTP id d9443c01a7336-20bb26ece59mr9665795ad.57.1727756491418;
        Mon, 30 Sep 2024 21:21:31 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37d60e4fsm61835445ad.42.2024.09.30.21.21.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 21:21:30 -0700 (PDT)
Date: Tue, 1 Oct 2024 12:21:32 +0800
From: shejialuo <shejialuo@gmail.com>
To: John Cai via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
	John Cai <johncai86@gmail.com>
Subject: Re: [PATCH v2 1/4] git: pass in repo for RUN_SETUP_GENTLY
Message-ID: <Zvt4zILqF5Ujorn6@ArchLinux>
References: <pull.1788.git.git.1727185364.gitgitgadget@gmail.com>
 <pull.1788.v2.git.git.1727718030.gitgitgadget@gmail.com>
 <5d72c31c6f3b97b7f5f7d3b4fa9a8b1587597670.1727718030.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d72c31c6f3b97b7f5f7d3b4fa9a8b1587597670.1727718030.git.gitgitgadget@gmail.com>

On Mon, Sep 30, 2024 at 05:40:27PM +0000, John Cai via GitGitGadget wrote:
> From: John Cai <johncai86@gmail.com>
> 
> commands that have RUN_SETUP_GENTLY potentially need a repository.
> Modify the logic in run_builtin() to pass the repository to the builtin
> if a builtin has the RUN_SETUP_GENTLY property.
> 

We will parse the "repo" to the "run_builtin()" for "RUN_SETUP_GENTLY"
property only when we know we run the command in the repository. If we
run the command outside of the repository, we should pass the NULL.

However, the above commit message is not accurate. If a builtin has the
"RUN_SETUP_GENTLY" property. We may pass or not.

> Signed-off-by: John Cai <johncai86@gmail.com>
> ---
>  git.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/git.c b/git.c
> index 2fbea24ec92..f58f169f3c7 100644
> --- a/git.c
> +++ b/git.c
> @@ -443,7 +443,7 @@ static int handle_alias(int *argcp, const char ***argv)
>  
>  static int run_builtin(struct cmd_struct *p, int argc, const char **argv, struct repository *repo)
>  {
> -	int status, help;
> +	int status, help, repo_exists;

This is wrong. We should initialize the "repo_exists" variable here.
Because we never set this variable to 0 in the later code path. It will
always be true for the following code:

    repo_exists ? repo : NULL

It will always evaluate to the "repo". This may could answer the
question raised by Junio in [PATCH v2 3/4].

Thanks,
Jialuo
