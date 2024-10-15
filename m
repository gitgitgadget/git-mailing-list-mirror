Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7A01CB9EB
	for <git@vger.kernel.org>; Tue, 15 Oct 2024 16:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729008309; cv=none; b=gEWNgsSkWkNN8U+rNP9TP8sxo9WqMPLMJL/luWDNHF0YudWKBm4tiqHs8EgSkYTCHtQ4vx2xzvSEU8yBMs1pKu9NYLuc6r1Rlq+E2QRH4/0FgT6Q+ejbka8g632eiWihlT6Z59UVU3MXqz0K/ACeyU+IbknDGBOWV+EcM+J8IAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729008309; c=relaxed/simple;
	bh=QOEwvzQ4kKxT2MmUW/0NrVFOhhJ1BnwRkweH/tIOLUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L84o/eqRdLIUXJWIpVXQdek9ds9eIDDnYR0PkgCtzq+Emhyn3JSGRfaRbhFNMjhJrkoN9M7pzH/pQsg1xR/PLKDqFB9Hjj1fZ3Ei2Ud+XIiSjMRjD3bEP2LBqURPAzA+F3s856XpzBkojaZeF/NCMN6s9PQDGCcYneci2x5bH9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bS1yTgXo; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bS1yTgXo"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-71e67d505ceso1470980b3a.1
        for <git@vger.kernel.org>; Tue, 15 Oct 2024 09:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729008307; x=1729613107; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2xC/Ew+Jzbafkk1pCYxE8cH/RGk4Q2KiNqqbHM0kEg4=;
        b=bS1yTgXopVGvEg4OkguI9tcL6Ta5LUPVRqulIplzTMvBjQR6Rip4JwNrT5Ga8+ar7z
         aRaG1XKKn+ueQi7sVDYqXciH8eOUoBx0qOkyur1PlA+t++8PoL5vrb9jBDea2PGXbb/M
         1/KJLcSjHo4g/GkG1Z5VRT8crMfsbPm5daJd/0h5YKQe2ezyLTccTthZiUYFhpYWAhkB
         jKW8iSaSGyYWlP9z7L8s8WWUARLm55Ebx+R5aeKY7uLePJ0VePgfN8bvU0HyAk5EvJFT
         KkSuy0I71F0AnvqPVk4oLIxfrOUfRDC0y2rx4LFCD3fpBMFY2v966yYi4a/O0t8w9YXs
         LcoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729008307; x=1729613107;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2xC/Ew+Jzbafkk1pCYxE8cH/RGk4Q2KiNqqbHM0kEg4=;
        b=ZninqCPgQPIgVImi6ni7+SGgWbQQHo7ZaBCeQpDP9RQtKpasSNqTszn3FFJ9zYcOOe
         elGNsXvgvg7aNIY2yycXFbPHZiT5ITPyvxqHmDNM3DI3pts/1EKB/IlleNUQ9iJ6hhMg
         2rGQxwuzkdyMBXRJ33sAMlineyo53Fe/8elBGmSF2xPN9UYuiBP+u4OXsDb/Ok+ffzkR
         dwRmbt16nzhB/4LLM4rQUsa2AqKLwnNiWpbfEC7ES84AfiBFk/cytcuFusyE1w0MxAL6
         o1CFwNEB4oiZ54vKgoEngRrbmzfyXygl3EuHnLQAVVYXVl6VVuezDasL+pYI/paw5xb4
         Lnlg==
X-Gm-Message-State: AOJu0Yzyav1/xMYsADWnl2ge3fsaVjaHEsijZboG1XX0oLfasSHzfgsX
	Q33+Pq+BxO41f23D7AI4ZNaKCt2y+Fq5xQ2XrNOziccNy6ngZWgl
X-Google-Smtp-Source: AGHT+IFaypqgH4pFi/ph+kOZPyQHoqXLa5TLZh3Y0ZO751Vrkk1WGLw7czA/lYBDQ0eExW2YUdmnWw==
X-Received: by 2002:a05:6a00:148b:b0:71d:f2e3:a878 with SMTP id d2e1a72fcca58-71e4c13dd50mr18604075b3a.5.1729008307059;
        Tue, 15 Oct 2024 09:05:07 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e77518a5fsm1420227b3a.214.2024.10.15.09.05.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 09:05:06 -0700 (PDT)
Date: Wed, 16 Oct 2024 00:05:05 +0800
From: shejialuo <shejialuo@gmail.com>
To: Kousik Sanagavarapu <five231003@gmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 1/3] repository: move git_*_encoding configs to repo scope
Message-ID: <Zw6SsUyZ0oA0XqMK@ArchLinux>
References: <20241015144935.4059-1-five231003@gmail.com>
 <20241015144935.4059-2-five231003@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015144935.4059-2-five231003@gmail.com>

On Tue, Oct 15, 2024 at 08:01:22PM +0530, Kousik Sanagavarapu wrote:
> Move "git_commit_encoding" and "git_log_output_encoding" to "struct
> repository" and amend the functions associated with peeking at these
> values so that now they take a "struct repository *" argument
> accordingly.  While at it, rename the functions to repo_*() following
> our usual convention.
> 
> Doing so removes the implicit dependency of these variables on
> "the_repository", which is better because we now populate these
> variables per repository.
> 
> Signed-off-by: Kousik Sanagavarapu <five231003@gmail.com>
> ---
>  builtin/am.c       |  6 ++++--
>  builtin/blame.c    |  2 +-
>  builtin/commit.c   |  8 +++++---
>  builtin/log.c      |  3 ++-
>  builtin/mailinfo.c |  3 ++-
>  builtin/replay.c   |  3 ++-
>  builtin/rev-list.c |  2 +-
>  builtin/shortlog.c |  2 +-
>  bundle.c           |  2 +-
>  commit.c           |  9 ++++++---
>  config.c           | 10 ++++++----
>  environment.c      | 13 -------------
>  environment.h      |  6 ------
>  log-tree.c         |  4 ++--
>  pretty.c           |  2 +-
>  remote-curl.c      |  4 +++-
>  repository.c       | 13 +++++++++++++
>  repository.h       |  6 ++++++
>  revision.c         | 10 +++++-----
>  sequencer.c        | 17 +++++++++--------
>  submodule.c        |  2 +-
>  21 files changed, 71 insertions(+), 56 deletions(-)

For "git-mailinfo(1)" and "git-shortlog(1)", these two commands could
run outside of the repository. If we incorporate these two configs into
the "struct repository", we will have trouble when we remove the
"the_repository" global variable.

The patch in [1] will pass a NULL pointer for builtins with
"RUN_SETUP_GENTLY" flag.

[1] <d59b85b529865793c652d983d71a9fbb7e16b3e3.1728594828.git.gitgitgadget@gmail.com>

> diff --git a/config.c b/config.c
> index a11bb85da3..656748692d 100644
> --- a/config.c
> +++ b/config.c
> @@ -1690,13 +1690,15 @@ static int git_default_sparse_config(const char *var, const char *value)
>  static int git_default_i18n_config(const char *var, const char *value)
>  {
>  	if (!strcmp(var, "i18n.commitencoding")) {
> -		FREE_AND_NULL(git_commit_encoding);
> -		return git_config_string(&git_commit_encoding, var, value);
> +		FREE_AND_NULL(the_repository->git_commit_encoding);
> +		return git_config_string(&the_repository->git_commit_encoding,
> +					 var, value);
>  	}
>  
>  	if (!strcmp(var, "i18n.logoutputencoding")) {
> -		FREE_AND_NULL(git_log_output_encoding);
> -		return git_config_string(&git_log_output_encoding, var, value);
> +		FREE_AND_NULL(the_repository->git_log_output_encoding);
> +		return git_config_string(&the_repository->git_log_output_encoding,
> +					 var, value);
>  	}

There are many builtins will execute this config setups by calling
"config.c::git_default_config" and then "git_default_i18n_config". If we
need to use "repo" pointer, we may need to wrap this pointer. (This is
not the problem and it is not hard).

But what if the "repo" pointer is NULL? We still need to set the value
of these environment variables. Because when using "git-mailinfo(1)"
outside of the repo, we still need to set "git_commit_encoding"
according to the user's config.

So, from this perspective, I don't think it's a good idea to put these
two configs into "struct repository". Because we can use these two
configs outside of the repo, if we put them into "struct repository", it
is strange.

However, I either don't know which way we would apply. So, I cannot give
accurate answer here.

---

Patrick, I wanna ask you a question here. What's your envision here in
above situation. As you can see, if we put some configs into "struct
repository" and we run the builtins outside of the repo where we need to
set up configs, the "repo" is NULL. And we will get into trouble.

My idea is that if a config could be used outside of the repo, then we
should not put it into "struct repository".

Thanks,
Jialuo
