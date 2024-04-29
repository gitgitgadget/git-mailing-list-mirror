Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE13128393
	for <git@vger.kernel.org>; Mon, 29 Apr 2024 15:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714403563; cv=none; b=JnabrThGEaVE57qYw5GdNOuK+PKaZX49CFxrQVxQ8OfK8TW0RRUo3Im6pmjlThZhkm/8YBzo43Q6IQKJTxa5sZqI0H1yY/OUEZhV33pZf9K7otIZsuppv4rWmnv6/oXfDFQeVy3Ea/YVsMhtqzvzfUMHU1B5VGTBkSRszbZ4GZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714403563; c=relaxed/simple;
	bh=65dn/ZGqeE9q1yXMxW/rB9E9VHFiORrGDZFd9ns14Qc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GGnO0kvUYovDsJ3gEazcZ4e3hyia4p+tx56lceE4c9wO6oezzaaDT4GaVyK6u2ktUHcR+SeClBTuF25pyE0RtsVoUl9P63L6TZMgA2gGW0QhnSgWmjEGjMAZsepwOifwpfLcdH3KXCPeBrRuUIJ+OEU6Ax5/jUCsMQ3VZdAOnaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dPFirjSP; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dPFirjSP"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-41b79450f78so23568055e9.2
        for <git@vger.kernel.org>; Mon, 29 Apr 2024 08:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714403559; x=1715008359; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=46l/cFxWOS/78EOzqQfQWsCDFFjmMMVpS3nB+IIsA5I=;
        b=dPFirjSPPHFNYKwhJ5JSH+Wvdc7c1nZLDMoWu1aJuL/u0PgCaO0SuikEhhKCwQSL8D
         b4wMgnMJgXGP86bRRv7+8h+nlNIqlHwLNFQiCWFIIsgwlKwnoFpR34kPGZY2dZ68qQB5
         Rk8OI31eBd9Ug9o6KF8Kqs2CKYoL2siWQXt8xFOk1PxNh4KindR6zO9/YSmcROwJrcVI
         OQPRZv+NarXdKKPHKxh56Xs9EE5YrohOtm0XZmWs3mld2ZIk8M/e48bwWgTpicrEEIyZ
         NUTvJ4Y/TFxTv+PMruFy3YFW2AVGxaV0MhSoTZ5du5MLaZcROw1Vtu0TsQTnaARaWCjD
         aSug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714403559; x=1715008359;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=46l/cFxWOS/78EOzqQfQWsCDFFjmMMVpS3nB+IIsA5I=;
        b=Yu9c1q1N+iitQX60usOsRq/675Gpk8ZotC3U/ZRVmsNN6MLPXSggJnYWEGsU/7jSdG
         l0WSjOze7ROcY0pNoyXPOx3ruCcDveEifkY7HJovdIrR3C4LHikjr//L/7r+EkJVvzVw
         yQHq8prEc5k/RkEC9I+p+BSKpxCtD3F5MqrPw4xkitPG0BEKSTasJU+5T/5TMkXvkPg0
         QKdkxgnPUVqao+KyUGxZzLhAyqweOJkjPtMdu/xe86I/gkYgkYwV1u9YNVacaOPcLiMD
         bTGQ4LkWCOgtT9ZY5AMRmZx9Cye1vRkGBeOpVGRUguJONjfp6wMyCUdUjBPgdbVQFCV/
         WUWQ==
X-Forwarded-Encrypted: i=1; AJvYcCWhyg/GeDS1IC/cvlgnJzXmrzTobOpLaH0Www5UWvkXoltjdeqxG3HWbAAdIBV506PHo2rHS/ZqSC+No0uJKF1/DjaF
X-Gm-Message-State: AOJu0Yzgvs5E/x6t4x+d9Y65245apGf1w2QVvSg3kgp/1GJplhYLpEPk
	M3Kh9gCQyGEJ9DxxjSpMDvkogSp7ZVF1xl+Y60QJ4CIf7bf1Lllo
X-Google-Smtp-Source: AGHT+IGPcs6eMk3pi7bZvs4ELPcjG9JR2UAbqTvVhvssixmTPH14hsBdR2rAAx/g4lhmdJXou8f4Aw==
X-Received: by 2002:a05:600c:1d17:b0:41a:a81e:441 with SMTP id l23-20020a05600c1d1700b0041aa81e0441mr10391098wms.25.1714403558951;
        Mon, 29 Apr 2024 08:12:38 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:62a:701:9864:4109:be00:6ff6? ([2a0a:ef40:62a:701:9864:4109:be00:6ff6])
        by smtp.gmail.com with ESMTPSA id e6-20020a05600c4e4600b0041c04022336sm7230873wmq.9.2024.04.29.08.12.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Apr 2024 08:12:38 -0700 (PDT)
Message-ID: <e57ed591-5006-453e-bc93-6c53fcab2aec@gmail.com>
Date: Mon, 29 Apr 2024 16:12:37 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 2/3] refs: do not label special refs as pseudo refs
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Karthik Nayak <karthik.188@gmail.com>
References: <cover.1714398019.git.ps@pks.im>
 <b5e7ddb1e30acb7e3871a189beb2c828b18f9e73.1714398019.git.ps@pks.im>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <b5e7ddb1e30acb7e3871a189beb2c828b18f9e73.1714398019.git.ps@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Patrick

On 29/04/2024 14:41, Patrick Steinhardt wrote:
> diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-content.txt
> index d71b199955..4275918fa0 100644
> --- a/Documentation/glossary-content.txt
> +++ b/Documentation/glossary-content.txt
> @@ -497,20 +497,28 @@ exclude;;
>   	unusual refs.
>   
>   [[def_pseudoref]]pseudoref::
> -	Pseudorefs are a class of files under `$GIT_DIR` which behave
> -	like refs for the purposes of rev-parse, but which are treated
> -	specially by git.  Pseudorefs both have names that are all-caps,
> -	and always start with a line consisting of a
> -	<<def_SHA1,SHA-1>> followed by whitespace.  So, HEAD is not a
> -	pseudoref, because it is sometimes a symbolic ref.  They might
> -	optionally contain some additional data.  `MERGE_HEAD` and
> -	`CHERRY_PICK_HEAD` are examples.  Unlike
> -	<<def_per_worktree_ref,per-worktree refs>>, these files cannot
> -	be symbolic refs, and never have reflogs.  They also cannot be
> -	updated through the normal ref update machinery.  Instead,
> -	they are updated by directly writing to the files.  However,
> -	they can be read as if they were refs, so `git rev-parse
> -	MERGE_HEAD` will work.
> +	Pseudorefs are references that live in the root of the reference
> +	hierarchy, outside of the usual "refs/" hierarchy. Pseudorefs have an
> +	all-uppercase name and must end with a "_HEAD" suffix, for example
> +	"`BISECT_HEAD`". Other than that, pseudorefs behave the exact same as
> +	any other reference and can be both read and written via regular Git
> +	tooling.

This changes the definition to allow pseudorefs to by symbolic refs. 
When is_pseudoref() was introduced Junio and I had a brief discussion 
about this restriction and he was not in favor of allowing pseudorefs to 
be symbolic refs [1].

Are there any practical implications of the changes in this patch for 
users running commands like "git log FETCH_HEAD" (I can't think of any 
off the top of my head but it would be good to have some reassurance on 
that point in the commit message)

Best Wishes

Phillip

[1] https://lore.kernel.org/git/xmqq34u2q3zs.fsf@gitster.g/

> +<<def_special_ref>,Special refs>> are not pseudorefs.
> ++
> +Due to historic reasons, Git has several irregular pseudo refs that do not
> +follow above rules. The following list of irregular pseudo refs is exhaustive
> +and shall not be extended in the future:
> +
> + - "`AUTO_MERGE`"
> +
> + - "`BISECT_EXPECTED_REV`"
> +
> + - "`NOTES_MERGE_PARTIAL`"
> +
> + - "`NOTES_MERGE_REF`"
> +
> + - "`MERGE_AUTOSTASH`"
>   
>   [[def_pull]]pull::
>   	Pulling a <<def_branch,branch>> means to <<def_fetch,fetch>> it and
> diff --git a/refs.c b/refs.c
> index c64f66bff9..567c6fc6ff 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -905,6 +905,8 @@ int is_pseudoref(struct ref_store *refs, const char *refname)
>   
>   	if (!is_pseudoref_syntax(refname))
>   		return 0;
> +	if (is_special_ref(refname))
> +		return 0;
>   
>   	if (ends_with(refname, "_HEAD")) {
>   		refs_resolve_ref_unsafe(refs, refname,
> diff --git a/t/t6302-for-each-ref-filter.sh b/t/t6302-for-each-ref-filter.sh
> index 948f1bb5f4..8c92fbde79 100755
> --- a/t/t6302-for-each-ref-filter.sh
> +++ b/t/t6302-for-each-ref-filter.sh
> @@ -52,6 +52,23 @@ test_expect_success '--include-root-refs pattern prints pseudorefs' '
>   	test_cmp expect actual
>   '
>   
> +test_expect_success '--include-root-refs pattern does not print special refs' '
> +	test_when_finished "rm -rf repo" &&
> +	git init repo &&
> +	(
> +		cd repo &&
> +		test_commit initial &&
> +		git rev-parse HEAD >.git/MERGE_HEAD &&
> +		git for-each-ref --format="%(refname)" --include-root-refs >actual &&
> +		cat >expect <<-EOF &&
> +		HEAD
> +		$(git symbolic-ref HEAD)
> +		refs/tags/initial
> +		EOF
> +		test_cmp expect actual
> +	)
> +'
> +
>   test_expect_success '--include-root-refs with other patterns' '
>   	cat >expect <<-\EOF &&
>   	HEAD
