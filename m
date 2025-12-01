Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15D3253B58
	for <git@vger.kernel.org>; Mon,  1 Dec 2025 15:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764601891; cv=none; b=nCk8SbHpUXUxUcts5BihvJsJVTpfseHzSwwgKa2nkATrufTqzxeZjwlsUwEv8vNYxfWEaP4T39AqBWqizP/S0vQv9IjGH1f5ULhsno8XU+4bRKWpJc5p4gC7b19HuYXbnbdJG1JohSdImgsE5+QHM9ur02zKSYnuItNOf6XObxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764601891; c=relaxed/simple;
	bh=sC5qFZjVMFYhBYI4wYfPkjKswO7RREguIMediiYw1sM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P8S5V27GKJe7A+plUfq9FCg/fY0R9hGyN5rXavV98y3j2gX+f2NousbntnrJk1bO0GlKEvif5DR486cy5czCR966ncuVEiumQVArVm9KTGTZFyRf7ljNt6Rrmgc80Fg4GzUkL1Xv3AV9c6kFXiujYNOoIJRDiow7sEcOAurbOeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cpTltqY8; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cpTltqY8"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-3e83c40e9dfso2555800fac.1
        for <git@vger.kernel.org>; Mon, 01 Dec 2025 07:11:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764601889; x=1765206689; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=J29gHt+MH+Ichr5f0kAWEGW2qEh4/0eiPWNaTBXvUxk=;
        b=cpTltqY8ATjM+Eo+MnUAihuklhijK9muZg1Jpkl/GgtZbEr1HLpZ471he1x5YYNeld
         JiheOdj4z4U1m/Fyd53g+FdjCjaKaewePmjM/Ah8oS2IC94wJ5PfOykhZia50qX/4QbB
         3RFW2Zu/juHhk6SlUlVJ3MRb72+6adICD9RF/UD9ydHCMUVZjNU1eNALNw3FN4ltDVSC
         NXbkilCaNaELyEH7emnNf9sf5pSJ3BGinl4PtISEsMO8lXsiDf8flIZoGA+vo6IKObax
         SoBvN6qUFsiZjd1Ngy3yf2UtlVNOTnqloXk7k7xUkaPlHPe34UxXeKpHCyH79MnMaTW5
         +Wgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764601889; x=1765206689;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J29gHt+MH+Ichr5f0kAWEGW2qEh4/0eiPWNaTBXvUxk=;
        b=s+UaTIQtvuCrMHrD0mVR7qyl7KoeP62nzFd6vRTajMadRHnaY6C2LfsBOcjmNkuVVT
         jn1Z/zkLkoUlNyAatWpXa1/q2Rl9SpX3eIIa5kd7NUzpf4CHV3u4SrlkGksdGuayHDgH
         2g1SoHYDkIiRdNJ6/U6KvcGw0SU9+d72GdVmBQWzvP3UgHwMgF2JlSgd6N/7TMdXeuwZ
         GrLEgfvRnJw0GsccRsgQCwrIiL/lRVKNAJGkkIpvkNDtVFYhS+eE3Ty2k8QQ7S8TQh4+
         XhwkmzKnOPbgZp051Px/Jz4uuyGcegVe64+DPpbdJcYrmRuQPxKCwlA39I/c3ADljs7c
         DYkg==
X-Gm-Message-State: AOJu0YxQhjICPmF4A/AQXmNfILc3SHVJZdcZRzjKBqRfsddXymTpPK2I
	Au7zmQcHHWYu8hB9Mb+rbJuK0csnE5GvrTxc1syG15Ela/Lm2SmIFr5RSyt8Ww==
X-Gm-Gg: ASbGncuitzN8rL4AW/qR+YUJJXoQtHuXWi9zJLTezPAZDNv+mDiIrYkZPZN9Z8qrzvS
	cHwgKd/erCmH9tuJM5mayOe9PkjK4pw9iKMz11IEiOZCbKpzhyJ6mtdBL7iORCfT8gRAXT4/Ln3
	wbV6V2Wc+pndEQbLS4fDUoYL+N0TYfZ5jQ0l+N65g3Qt86qvdAa/QoUX9E7T2K4VoqPxJbeKBr9
	Ibdibomcz8gDUqwq9jhWcwpvxGx9w+4GE5gV89zRNwdOVx+NwgSf4nxPnzZ5HPmdRropvHZx7uf
	J8Dv4lBcgOOVg+7LGxVHS7W5Gn2b8ojQr14XxAYrsc3CISpb5LePNITmsjkcrWfPWNqb6BEzZjp
	krpdGD6oZByR5mI2V4kTIR6ggKS1IeXlHKP0TACurinrorEkRRvHHQCoOAq7XN9VxH+wLca//lZ
	7/CHli
X-Google-Smtp-Source: AGHT+IGDITqr01GQatvJhOeZd1lIolndjcZiYqYUlxcLZgzpy9wtGnNi/KqlXSQdHa5k2b0yq0BnxQ==
X-Received: by 2002:a05:6870:8328:b0:3ec:4d8f:f952 with SMTP id 586e51a60fabf-3ecbe5ddfafmr20206711fac.43.1764601888664;
        Mon, 01 Dec 2025 07:11:28 -0800 (PST)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3f0dcfdba71sm5343087fac.12.2025.12.01.07.11.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 07:11:28 -0800 (PST)
Date: Mon, 1 Dec 2025 09:11:24 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] repo: add -z as an alias for --format=nul to
 git-repo-structure
Message-ID: <3hzpywampwjfsckljdqhyabhkupqmrzbcsc7fhrkg2cl4rjzzm@mygtkda7soxj>
References: <20251130203456.28437-1-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251130203456.28437-1-lucasseikioshiro@gmail.com>

On 25/11/30 04:59PM, Lucas Seiki Oshiro wrote:
> Other Git commands that have nul-terminated output, such as git-config,
> git-status, git-ls-files, and git-repo-info have a flag `-z` for using
> the null character as the record separator.
> 
> Add the `-z` flag to git-repo-structure as an alias for `--format=nul`,
> making it consistent with the behavior of the other commands.
> 
> Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
> ---
> 
> Hello, again!
> 
> Since git-repo-info and git-repo-structure share the same format parser, this
> could be done by only copying the OPT_CALLBACK_F from repo_info.
> 
> I'm cc'ing Justin here, as he was the author of git-repo-structure.

Thanks Lucas, looks like you beat me to this change. :)

> This patch is based on top of master b31ab939fe (The fourth batch, 2025-11-26)
> with lo/repo-info-all merged.

Any reason this isn't just based on master? It looks like this patch
should apply just fine as I don't see any dependencies.

>  Documentation/git-repo.adoc | 5 +++--
>  builtin/repo.c              | 6 +++++-
>  t/t1901-repo-structure.sh   | 6 ++++++
>  3 files changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
> index 70f0a6d2e4..8820954f7e 100644
> --- a/Documentation/git-repo.adoc
> +++ b/Documentation/git-repo.adoc
> @@ -9,7 +9,7 @@ SYNOPSIS
>  --------
>  [synopsis]
>  git repo info [--format=(keyvalue|nul)] [-z] [--all | <key>...]
> -git repo structure [--format=(table|keyvalue|nul)]
> +git repo structure [--format=(table|keyvalue|nul)] [-z]
>  
>  DESCRIPTION
>  -----------
> @@ -44,7 +44,7 @@ supported:
>  +
>  `-z` is an alias for `--format=nul`.
>  
> -`structure [--format=(table|keyvalue|nul)]`::
> +`structure [--format=(table|keyvalue|nul)] [-z]`::
>  	Retrieve statistics about the current repository structure. The
>  	following kinds of information are reported:
>  +
> @@ -72,6 +72,7 @@ supported:
>  	the delimiter between the key and value instead of '='. Unlike the
>  	`keyvalue` format, values containing "unusual" characters are never
>  	quoted.
> +`-z` is an alias for `--format=nul`.

If we want to match the format in the section prior, we should add a '+'
character on the prior line to separate the sections. With how it is
written now, this line will just be appeneded to the previous section.

>  INFO KEYS
>  ---------
> diff --git a/builtin/repo.c b/builtin/repo.c
> index 2a653bd3ea..1c06207a39 100644
> --- a/builtin/repo.c
> +++ b/builtin/repo.c
> @@ -16,7 +16,7 @@
>  
>  static const char *const repo_usage[] = {
>  	"git repo info [--format=(keyvalue|nul)] [-z] [--all | <key>...]",
> -	"git repo structure [--format=(table|keyvalue|nul)]",
> +	"git repo structure [--format=(table|keyvalue|nul)] [-z]",
>  	NULL
>  };
>  
> @@ -529,6 +529,10 @@ static int cmd_repo_structure(int argc, const char **argv, const char *prefix,
>  		OPT_CALLBACK_F(0, "format", &format, N_("format"),
>  			       N_("output format"),
>  			       PARSE_OPT_NONEG, parse_format_cb),
> +		OPT_CALLBACK_F('z', NULL, &format, NULL,
> +			       N_("synonym for --format=nul"),
> +			       PARSE_OPT_NONEG | PARSE_OPT_NOARG,
> +			       parse_format_cb),

Reusing the same `parse_format_cb()` makes sense and also matches what
we do with git-repo-info. Looks good.

>  		OPT_BOOL(0, "progress", &show_progress, N_("show progress")),
>  		OPT_END()
>  	};
> diff --git a/t/t1901-repo-structure.sh b/t/t1901-repo-structure.sh
> index 36a71a144e..5a50acf345 100755
> --- a/t/t1901-repo-structure.sh
> +++ b/t/t1901-repo-structure.sh
> @@ -101,6 +101,12 @@ test_expect_success 'keyvalue and nul format' '
>  		tr "\n=" "\0\n" <expect >expect_nul &&
>  		git repo structure --format=nul >out 2>err &&
>  
> +		test_cmp expect_nul out &&
> +		test_line_count = 0 err &&
> +
> +		# Check -z
> +		git repo structure --format=nul >out 2>err &&

Did you mean to use the -z option here?

-Justin
