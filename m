Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254C31BA882
	for <git@vger.kernel.org>; Thu, 29 Aug 2024 20:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724962602; cv=none; b=tMgQuUJK2RhD+UoOEbdEBtEOm3fJnm9JLwQqm78OMZR4yn39RrEnldCU2umbyI5NqT6VzPBNa3a69IkulZIO23K7LcmZ6nxOgiHK0mR2L63et4REd8su2VRTV8xMSvqz+pyBCs6BHGzSSm2KTEcmu1lCTkOMxSwQHLuHPX7VGQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724962602; c=relaxed/simple;
	bh=DvgjveYipN7E0GW+g52fsVYRvu9x3C8Wqjb4SCrfbEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=POEf5xNT9hJNcfgJYE5Bm6/2rb7vmyp9OIm1X2FpdvpkCiHGZB1jRAiWvVgzKwkOlH6JDKDu4Toajg0NMZD0g/u6FsRhWxZBRwqoNhd9hrGF8Lc9uLIb2fcQMEQ9xFenPLkc6MDJNP3Vo9r8lMkLvIYRjyysfx5jifvwI16gKao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xbse/aAf; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xbse/aAf"
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5df9a9f7fe2so656575eaf.2
        for <git@vger.kernel.org>; Thu, 29 Aug 2024 13:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724962600; x=1725567400; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BM2qkjtQb29LYYbG9pm/9GIW2uINuY0JJxpA9FxLCk0=;
        b=Xbse/aAflfPwDwdzoi8FVBV25qeKurqQOH8DW5J0hI+5mjFoSkaLiUamTyrvwQIIyn
         tEqn3zODLJoEppQ6DB13o8QnZjps1cEECcX8MYXQ1o/Cn8eux8QCO5ePgD7cf8C/Sz3e
         ervm5BOfJajU3G8N9cSBzElJhAzedh8Sqb6j11pP8DDadMXnGo2eGmUU+z/XJuFd5FnE
         gtC5jtle3VEughi2X5YcCfNTJ3qT2PZCutxHFPhxbp1xwDxTZWEZZI5azF6RuxbhpoXQ
         afWFRRenRNSSKcXRYOZbTwzzVWQY+xYj47lMN51VF/TZ/1NHH4W3hRq6ipnk4NcHIUnu
         ztPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724962600; x=1725567400;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BM2qkjtQb29LYYbG9pm/9GIW2uINuY0JJxpA9FxLCk0=;
        b=aZnAI5EprtyqbAyAidRndPAsqLPeOYeRxw7i5+tB0h8CF0X1ZOTY/rFnmVdt4J4bIZ
         BDkIDC1/6dU4xEyt2Ej3oRTwaIG/tJWk0mPMka4NdzsYU1TdhUVin+iMElfYLwZR7ndx
         hZiL4yixjCicYtqJA/jzz5SmXzmrklvOZl0oXdH9KncpOKJ+GlSr+wFDWkDnNN6Mm4Il
         YeAWTMj99ak1lMD9XkmYI0v5Fus1OY5ENU4dnyudA6q045aCm/hOZV9WNVD6r9Av+LH2
         yxhLoI7RCe9CXaVjpgsWB4H+UYEPxHOVLf7u/ZsYgmVfpswE/uLuQ7N0jbh5/WEyd7Zd
         dEVg==
X-Gm-Message-State: AOJu0YxhQVyhO1NqEhrA2Wspk8FQjb4GzN94UjNuMuMyJCW8xWG9E2pv
	pf9C1lXdMueClt06YWCaJ2HJib6F5zhOXpr4ey6zDn6HFvkGZbZW1XQdyHzt
X-Google-Smtp-Source: AGHT+IEP9Md+zyDj+GiE82fPjhHQm0fHRJBDmFd7UnmvWCXyj2i208K0DmHrdX2ae9jnQzAX6qWt/A==
X-Received: by 2002:a05:6870:b52c:b0:270:172c:32ae with SMTP id 586e51a60fabf-277902e3bd8mr4629358fac.32.1724962600042;
        Thu, 29 Aug 2024 13:16:40 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-70f671cf757sm61601a34.81.2024.08.29.13.16.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 13:16:39 -0700 (PDT)
Date: Thu, 29 Aug 2024 15:15:36 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Calvin Wan <calvinwan@google.com>
Subject: Re: [PATCH 01/21] environment: make `get_git_dir()` accept a
 repository
Message-ID: <3fvisdomxvcepnfbx2aruzyhqj2ntfjaapk7escwhylxxuq7r4@inhrmm26blg2>
References: <cover.1724923648.git.ps@pks.im>
 <0fe3e3e1cccf2eae7d81ccecf431da623b39fa79.1724923648.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0fe3e3e1cccf2eae7d81ccecf431da623b39fa79.1724923648.git.ps@pks.im>

On 24/08/29 11:38AM, Patrick Steinhardt wrote:
> The `get_git_dir()` function retrieves the path to the Git directory for
> `the_repository`. Make it accept a `struct repository` such that it can
> work on arbitrary repositories and make it part of the repository
> subsystem. This reduces our reliance on `the_repository` and clarifies
> scope.

Seems sensible to me. We are simply making it so `the_repository` is no
longer implicit to the function.

> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
[snip]
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -407,7 +407,7 @@ static const char *prepare_index(const char **argv, const char *prefix,
>  
>  		discard_index(the_repository->index);
>  		read_index_from(the_repository->index, get_lock_file_path(&index_lock),
> -				get_git_dir());
> +				repo_get_git_dir(the_repository));

Now that the `repo_get_git_dir()` function has been moved to
"repository.h" should we also directly include this header in the c
file? Or is the implicit reference sufficent? From our coding guidelines
is seems we preferred to be direct.

It looks like there are several other hunks missing direct references to
"repository.h" too.

[snip]
> diff --git a/builtin/fsmonitor--daemon.c b/builtin/fsmonitor--daemon.c
> index 1593713f4cb..c54e736716a 100644
> --- a/builtin/fsmonitor--daemon.c
> +++ b/builtin/fsmonitor--daemon.c
> @@ -1311,7 +1311,8 @@ static int fsmonitor_run_daemon(void)
>  	strbuf_addstr(&state.path_gitdir_watch, "/.git");
>  	if (!is_directory(state.path_gitdir_watch.buf)) {
>  		strbuf_reset(&state.path_gitdir_watch);
> -		strbuf_addstr(&state.path_gitdir_watch, absolute_path(get_git_dir()));
> +		strbuf_addstr(&state.path_gitdir_watch,
> +			      absolute_path(repo_get_git_dir(the_repository)));

In this c file, now that `repo_get_git_dir()` lives in "repository.h",
is the "environment.h" header file needed anymore?

-Justin
