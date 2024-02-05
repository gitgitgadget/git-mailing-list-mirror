Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5F31AB7ED
	for <git@vger.kernel.org>; Mon,  5 Feb 2024 22:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707171727; cv=none; b=WA1Bab+hRd+rd3LkjkaV9yzDVzzbEduJLwa9rgiRg7NrTvWIIbu13F6Ovx7DuTk4xIJG16g8gKYOZSVzhmVhAfPgan+ImXjIBWEPvfwE5kxFsLq5rcc4EdBzYTqzNQbXR7vGPUYKNAWx5iva69xHy5JA4ZEtglEu5qEGevg3RFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707171727; c=relaxed/simple;
	bh=DwwaBrqVW1lk8Bulxa3MDqTHi/Ms1QW7wDqlbgsNnGU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FxRbHBZ360tgxMDIIRXngYDbKAQRrYCGMDCmALPW8LNg7l7+kjEy4Z603bA6SlS/FUZQQ577R1MwazF7NINSC1ZEdGftfF3ONH1gafgEBzYuvWjNTcMMFg/ZwwFSyq/cUEthy30b8ZUguJ7TxJbWc4X8hFadVn7+9wf+yy0V63o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qoj0rvxl; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qoj0rvxl"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40fe0641bb4so2900355e9.3
        for <git@vger.kernel.org>; Mon, 05 Feb 2024 14:22:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707171724; x=1707776524; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jqxgEKgBg8lP2EcAcQgTZMYhbFv6vy/DV3drMRz1CWw=;
        b=Qoj0rvxlLs9nNkfARoYJlmRGzfJqvE7jD3af5I7eC1D4mSQ41fCpR/JWIjQGAzECwv
         UM2RSWpGSSHz/iF324Fw42zixU9A5BYlJAEGFBdLLtKzq4NuA4QXVf5x1XuShX9gwhVH
         d2JYulX/j45UaZK7VOuGdbYt5FHJvM3R88aEGdr+XAgSKl5dDho2HU3xjW1bB6ujFJtX
         5zsQuZxk2EmnBOKGqyF9NNw/XOSIOxFwg2e1zih3bwRDet9NeLazSLhpblH3hXcSOi87
         uPZOjovG0rB5z2xsJ9Mfh4qxhahCZuZX3rQuhOIH2xFWWEL3MBpfoLi+pU9MeFnCJeis
         3B2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707171724; x=1707776524;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jqxgEKgBg8lP2EcAcQgTZMYhbFv6vy/DV3drMRz1CWw=;
        b=YY8MOGVMLHMnILLEkaRZ2JJuFbIAXVS/QOxrUYfAt54FWVeaDxrhZNdmn9ZXF+tWJa
         SVe+ItR8UnEOGApSEe6mxPB/QLlFiuHyrj/TV6Ww5WoWG5UidbMelizk+kJXab7/CM+X
         jXlcBV+exSRbzDJd23h0csFzZTE4bV69BrAJawkymG1wkdkpaTrk5Mxd2Eoi5YKD6A8h
         xxtbGFNKcEfq5C/RUUfLDmzkv2KSyEAupCeFAM2Jo7H8kJYJWA0alvtBvLQGTcL2NpKS
         7viJ1ZhzqyI4SKTlqXg0MFmrLMlQbwtSAnzVDVsDZ24QenGPKdk0yzDbakfz39+YX1pM
         KmYQ==
X-Gm-Message-State: AOJu0YzJjAI5wOIXbYcj1WN7YKt1y8JjI5Fhf6ss6lJn2X6j8U8QWIXI
	v/euEfQGHSk+UoHe8rmyH+9lOjphx5goFeYs4k7Uvygngn0JSke6
X-Google-Smtp-Source: AGHT+IF1fJfGrWAHkfTXLxPwYRsEp/tbq+qMFsX3fwYniekLxEYm4zCsh7muH3SSTNKSsD2cfF5mDg==
X-Received: by 2002:a05:600c:4510:b0:40f:dd18:a152 with SMTP id t16-20020a05600c451000b0040fdd18a152mr204177wmo.41.1707171723537;
        Mon, 05 Feb 2024 14:22:03 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWGG/9Xs3sscOiQg71Wq+9tnbBsSUv93MJ5tHWvx3Zjt0Sd9p53JrAntz1NzrBcHvE71teHiI3kvo6AnjloV6XNonCp
Received: from gmail.com (77.red-88-14-198.dynamicip.rima-tde.net. [88.14.198.77])
        by smtp.gmail.com with ESMTPSA id s9-20020a05600c45c900b0040fddaf9ff4sm2751313wmo.40.2024.02.05.14.22.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Feb 2024 14:22:03 -0800 (PST)
Message-ID: <f07d33e4-5595-43e3-838e-fd89c5621485@gmail.com>
Date: Mon, 5 Feb 2024 23:22:01 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] builtin/stash: report failure to write to index
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: moti sd <motisd8@gmail.com>
References: <CAPvDF0P7_s-iy_V7FNSHtXXc9v5E3Fm=AdgduDDsd0rM-zNg-g@mail.gmail.com>
 <2cd44b01dc29b099a07658499481a6847c46562d.1707116449.git.ps@pks.im>
Content-Language: en-US
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
In-Reply-To: <2cd44b01dc29b099a07658499481a6847c46562d.1707116449.git.ps@pks.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05-feb-2024 08:01:04, Patrick Steinhardt wrote:
> The git-stash(1) command needs to write to the index for many of its
> operations. When the index is locked by a concurrent writer it will thus
> fail to operate, which is expected. What is not expected though is that
> we do not print any error message at all in this case. The user can thus
> easily miss the fact that the command didn't do what they expected it to
> do and would be left wondering why that is.
> 
> Fix this bug and report failures to write to the index. Add tests for
> the subcommands which hit the respective code paths.
> 
> Note that the chosen error message ("Cannot write to the index") does
> not match our guidelines as it starts with a capitalized letter. This is
> intentional though and matches the style of all the other messages used
> in git-stash(1).

Your message made me curious, so I ran:

   $ git grep -E '(die|error)\(' builtin/stash.c
   
   builtin/stash.c:168:               die(_("'%s' is not a stash-like commit"), revision);
   builtin/stash.c:214:               return error(_("%s is not a valid reference"), revision);
   builtin/stash.c:261:               return error(_("git stash clear with arguments is "
   builtin/stash.c:303:               return error(_("unable to write new index file"));
   builtin/stash.c:487:                                       die("Failed to move %s to %s\n",
   builtin/stash.c:523:               die(_("Unable to write index."));
   builtin/stash.c:544:               return error(_("cannot apply a stash in the middle of a merge"));
   builtin/stash.c:555:                               return error(_("could not generate diff %s^!."),
   builtin/stash.c:562:                               return error(_("conflicts in index. "
   builtin/stash.c:569:                               return error(_("could not save index tree"));
   builtin/stash.c:610:               ret = error(_("could not write index"));
   builtin/stash.c:630:               ret = error(_("could not restore untracked files from stash"));
   builtin/stash.c:702:               return error(_("%s: Could not drop stash entry"),
   builtin/stash.c:721:               return error(_("'%s' is not a stash reference"), info->revision.buf);
   builtin/stash.c:872:                       die(_("failed to parse tree"));
   builtin/stash.c:883:               die(_("failed to unpack trees"));
   builtin/stash.c:1547:              if (report_path_error(ps_matched, ps)) {
   builtin/stash.c:1763:                      die("subcommand wasn't specified; 'push' can't be assumed due to unexpected token '%s'",
   builtin/stash.c:1773:                      die(_("options '%s' and '%s' cannot be used together"), "--pathspec-from-file", "--patch");
   builtin/stash.c:1776:                      die(_("options '%s' and '%s' cannot be used together"), "--pathspec-from-file", "--staged");
   builtin/stash.c:1779:                      die(_("'%s' and pathspec arguments cannot be used together"), "--pathspec-from-file");
   builtin/stash.c:1785:              die(_("the option '%s' requires '%s'"), "--pathspec-file-nul", "--pathspec-from-file");

Certainly, there are some error messages in builtin/stash.c that do not
follow the notes in Documentation/CodingGuideLines, but it does not seem
to be "the style of all other messages" in git-stash.

However, your message is clear ...  What error messages are you
considering?

> 
> Reported-by: moti sd <motisd8@gmail.com>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  builtin/stash.c  |  6 +++---
>  t/t3903-stash.sh | 52 ++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 55 insertions(+), 3 deletions(-)
> 
> diff --git a/builtin/stash.c b/builtin/stash.c
> index b2813c614c..9df072b459 100644
> --- a/builtin/stash.c
> +++ b/builtin/stash.c
> @@ -537,7 +537,7 @@ static int do_apply_stash(const char *prefix, struct stash_info *info,
>  	repo_read_index_preload(the_repository, NULL, 0);
>  	if (repo_refresh_and_write_index(the_repository, REFRESH_QUIET, 0, 0,
>  					 NULL, NULL, NULL))
> -		return -1;
> +		return error(_("Cannot write to the index"));
>  
>  	if (write_index_as_tree(&c_tree, &the_index, get_index_file(), 0,
>  				NULL))
> @@ -1364,7 +1364,7 @@ static int do_create_stash(const struct pathspec *ps, struct strbuf *stash_msg_b
>  	repo_read_index_preload(the_repository, NULL, 0);
>  	if (repo_refresh_and_write_index(the_repository, REFRESH_QUIET, 0, 0,
>  					 NULL, NULL, NULL) < 0) {
> -		ret = -1;
> +		ret = error(_("Cannot write to the index"));
>  		goto done;
>  	}
>  
> @@ -1555,7 +1555,7 @@ static int do_push_stash(const struct pathspec *ps, const char *stash_msg, int q
>  
>  	if (repo_refresh_and_write_index(the_repository, REFRESH_QUIET, 0, 0,
>  					 NULL, NULL, NULL)) {
> -		ret = -1;
> +		ret = error(_("Cannot write to the index"));
>  		goto done;
>  	}
>  
> diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
> index 3319240515..770881e537 100755
> --- a/t/t3903-stash.sh
> +++ b/t/t3903-stash.sh
> @@ -1516,4 +1516,56 @@ test_expect_success 'restore untracked files even when we hit conflicts' '
>  	)
>  '
>  
> +test_expect_success 'stash create reports a locked index' '
> +	test_when_finished "rm -rf repo" &&
> +	git init repo &&
> +	(
> +		cd repo &&
> +		test_commit A A.file &&
> +		echo change >A.file &&
> +		touch .git/index.lock &&
> +
> +		cat >expect <<-EOF &&
> +		error: Cannot write to the index
> +		EOF
> +		test_must_fail git stash create 2>err &&
> +		test_cmp expect err
> +	)
> +'
> +
> +test_expect_success 'stash push reports a locked index' '
> +	test_when_finished "rm -rf repo" &&
> +	git init repo &&
> +	(
> +		cd repo &&
> +		test_commit A A.file &&
> +		echo change >A.file &&
> +		touch .git/index.lock &&
> +
> +		cat >expect <<-EOF &&
> +		error: Cannot write to the index
> +		EOF
> +		test_must_fail git stash push 2>err &&
> +		test_cmp expect err
> +	)
> +'
> +
> +test_expect_success 'stash apply reports a locked index' '
> +	test_when_finished "rm -rf repo" &&
> +	git init repo &&
> +	(
> +		cd repo &&
> +		test_commit A A.file &&
> +		echo change >A.file &&
> +		git stash push &&
> +		touch .git/index.lock &&
> +
> +		cat >expect <<-EOF &&
> +		error: Cannot write to the index
> +		EOF
> +		test_must_fail git stash apply 2>err &&
> +		test_cmp expect err
> +	)
> +'
> +
>  test_done
> -- 
> 2.43.GIT
> 


