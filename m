Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5D23F660F
	for <git@vger.kernel.org>; Fri,  4 Sep 2026 09:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788513096; cv=none; b=r7PoTPaN/isE6sVAr3Fv5VxeeIiL0ntq2+kCzXqmRyJq8/NRrn1AzKtu9I7vmv6yVYpIocxI6tKzlvFTwDGVeFcGarELpSGTaS6AiEVbu80wt53LOfRJ1FgyjlqAu/uVyrNCQWiW5V+XOw8H6W6xwhcu7tKr+CqqOyWfjkx61ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788513096; c=relaxed/simple;
	bh=qJuee4fT4R8MKTGtn/7wgNt9qFSYoAONnMTbYxiYjfA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GrtrxjfjfyAxZ7MkcvmWMzLpTVBOHn1lUD3ybDUunEuRsIIoMwLsTcqmozn+3j24o7Mz1XTswDqhilp85UG3+FT6u4POtt4CazuFtNHl7G4I93q3+BUYLrrcmD7SkLqEg0fCui1z0CJ6AchDmZWgbIJEJZ2mG8iDAmOZMD7MmWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FMRQg8oI; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FMRQg8oI"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6a668cacdadso958577a12.2
        for <git@vger.kernel.org>; Fri, 04 Sep 2026 02:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788513093; x=1789117893; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=MVUxL+ETLOxc2gsinPPht31pPT61EnNKWv9g/x5ulkM=;
        b=FMRQg8oI3la2o3TdhWc1x6T1wtLy0n2M8UQGKSffPuVXED+qGeZPvbS1MO5Fc0QcbP
         9wiVj0H0WGcCQp/OGs+QCR5iQAx9FBKKiIpfd/u8iGMGIosyQ6cfyS3Yps4Sy1Lo+TYg
         dQWTjTlA1BIkMVmrkpQ12EU6ahbFxhCMlOvoOSwyCDtmoUs/gfCiHiCFPJH13GcCikNr
         ZOOUbx11pGO1zk/vKL9FCLaHkFmHIK+EyONpUXOjh1s99MQvalccrmig7znhTucTrCO+
         UJRuOBXvhkX0/aMVwZqcht1i9g8kqVVmAhF7Z5Qng8ZDdhdBjRGnW5UMkd2LYG6+uuNM
         hBZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788513093; x=1789117893;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=MVUxL+ETLOxc2gsinPPht31pPT61EnNKWv9g/x5ulkM=;
        b=gkzsKbdTgNSJTCHCpNhuOMKfjahajEbAE039TAWiyRxSGl89Os4j3AMA7A7M4dKvP7
         qrx+C+R2F+AFpEkJ77mAIY4bCO76u9SoSqVVS3KrAPmrMyB02ncJ05nnABJzQKFOP+By
         gpOmTsEycXeMuM3RQh2r2+M8+UgwtJN0VhwrvattfoG+d06TIPY3/czWkV/bX9WWoR3R
         0G4aDmu2rnGpUWmx6QS6I6e6sByMzzcmdBsYDXdlz7qqhimeRovZyJ0DXkgkp7y20WM6
         Ol3p4lrNQY99chyEKViRP702qW67o8BMAiS+iIiGe9VReQUOd2cXUnPRdxmuEkZzYFOh
         nr8A==
X-Forwarded-Encrypted: i=1; AKwUvByKUVvJnTKoIzWUuZYi77qJiOESCPFejPaTqdXnWcOgcpgrA0xBRSKgDUC3P0MqK2yVddg=@vger.kernel.org
X-Gm-Message-State: AFuF++k+ApzRqBjCcvmRYg6sKNio6JtDLSGde89KAZsCi0coJKSG9XYV
	zGCvtsm+9j/CTUtHNpW4+7bnssJ9+/Pvn4/HwsfcVjVuo2x7wqtehpLv
X-Gm-Gg: AYBFou2xYsejcoT7ho8voeY90Up6ik6k4te12AXiC4NQnG4+VoekgogJ/VHWSB7ARZO
	TcCzpAlHFYUCBrHzQx3iapwTXF1u9jgssTaTtRa58sUpRr+qyuEpA+k+wIWVzo6d0568TmsL1R+
	9cmO9zKxkYJOBiyRDPVpAhlooP8h2re9kDbFTNtLOQr+jxPCsx7MRQJrLhDKcZcsjWP1lifOga2
	9GCtvD/7GqPr50RXUAipGHP5n8e7bWVyhp7oKuSS3nL2T2qPHUmvhim+q4MFrsCeSILypvSZUF7
	fa08lqp7FLIeBMWbHWYs+0b7nEHShsdxe8pnE504SjI8+NII61j2TS9WHxcVxMgNe5Sv1hptWiG
	pCdv6QvK5bVg4aeEsXAxVAtdN3U3tUnxhd8S5G97FnQE1VBjbzw9g2aLXyDXmJs6UA6mPzuuGZC
	Kb3JQUzR4xavIABcdjOr/01OH5/T6FOZQvri2jE4eIONMyUqH8hdcV2wj9enSXGlZWsQXIfc+5O
	zx115vWvAy/4WMuD8ar5b5w43kN3FqJb0hAxpr5Esw=
X-Received: by 2002:a05:6402:4547:b0:6a7:ea54:388 with SMTP id 4fb4d7f45d1cf-6a7ea5420e9mr737472a12.25.1788513092106;
        Fri, 04 Sep 2026 02:11:32 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a7e68a6e0esm872362a12.9.2026.09.04.02.11.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Sep 2026 02:11:31 -0700 (PDT)
Message-ID: <5634fdc4-d0f8-493d-b401-3c9753524034@gmail.com>
Date: Fri, 4 Sep 2026 10:11:30 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3] var: support broken-down idents, default key, multiple
 args, and -z
To: Andrew Pleeter via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
 Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
 Andrew Pleeter <andrewpleeter@gmail.com>
References: <pull.2388.git.git.1787690802942.gitgitgadget@gmail.com>
 <pull.2388.v3.git.git.1788403792962.gitgitgadget@gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <pull.2388.v3.git.git.1788403792962.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Andrew

On 03/09/2026 03:49, Andrew Pleeter via GitGitGadget wrote:
> From: Andrew Pleeter <andrewpleeter@gmail.com>
> 
> - Support '-z' to terminate variable outputs and 'git var -l -z'
>    entries with NUL bytes.

Hurray! I agree with Junios comments and have left a few of my own below.
>   static const struct git_var *get_git_var(const char *var)
>   {
>   	struct git_var *ptr;
> +	if (!strcmp(var, "GIT_SIGNING_KEY"))
> +		var = "GIT_DEFAULT_KEY";

Do we really need an alias? GIT_DEFAULT_KEY is pretty meaningless to me, 
whereas GIT_SIGNING_KEY is clearly a key for signing. What's the usecase 
for this by the way. If a script is using git to sign then it does not 
need to query the default key because git will use it automatically. If 
a script wants to use the key to sign something else doesn't it need to 
also know which signing scheme git is using (ssh, gpg, etc) , or is that 
obvious from the key?

>   	for (ptr = git_vars; ptr->read; ptr++) {
>   		if (strcmp(var, ptr->name) == 0) {
>   			return ptr;
> @@ -207,10 +316,13 @@ static const struct git_var *get_git_var(const char *var)
>   static int show_config(const char *var, const char *value,
>   		       const struct config_context *ctx, void *cb)
>   {
> +	int null_term = cb ? *(int *)cb : 0;
> +	char eol = null_term ? '\0' : '\n';
> +
>   	if (value)
> -		printf("%s=%s\n", var, value);
> +		printf("%s=%s%c", var, value, eol);

A key can contain "=" so this format is ambiguous. When the user passes 
"-z" we should use the same format as "git config list -z" which avoids 
that ambiguity

	printf("%s%c%s%c", var, eol == '\n' ? '=' : '\n', value, eol);

>   	else
> -		printf("%s\n", var);
> +		printf("%s%c", var, eol);

It would be worth checking what "git config list -z" does when there is 
no value and matching that. Does it print "key\n\0", or "key\0"?

> +	for (i = 1; i < argc; i++) {
> +		const char *arg = argv[i];
> +
> +		if (!strcmp(arg, "-l")) {
> +			list = 1;
> +		} else if (!strcmp(arg, "-z")) {
> +			null_term = 1;
> +		} else if (!strcmp(arg, "--")) {
> +			for (i = i + 1; i < argc; i++)
> +				strvec_push(&vars, argv[i]);
> +			break;
> +		} else if (arg[0] == '-') {
> +			usage(var_usage);
> +		} else {
> +			strvec_push(&vars, arg);

I think we should break out of the loop when arg is "--", or does not 
begin with '-', and treat the rest as variable names to print. There is 
not need to support "git var GIT_AUTHOR_NAME -z GIT_AUTHOR_EMAIL" in a 
plumbing command.

> [...]
> -	printf("%s\n", val);
> -	free(val);
> +		printf("%s%c", val, null_term ? '\0' : '\n');

Multi-valued variables are a bit of a problem here, they're built on the 
assumption that the individual values do not contain a newline, but as 
they are paths I'm not sure that is necessarily true. With -z it would 
be better to print '\0' after each value as we do in list_vars(). 
Ideally we wouldn't use a single string to pass multiple values around, 
but a simple fix would be to use '\0' to separate the individual values 
instead of '\n' so that we can split them unambiguously when we print them.

Thanks for working on this, being able to specify multiple variables 
that are printed unambiguously is a really useful improvement.

Phillip
> +		free(val);
> +	}
>   
> +	strvec_clear(&vars);
>   	return 0;
>   }
> diff --git a/t/t0007-git-var.sh b/t/t0007-git-var.sh
> index 2b60317758..c437c968bb 100755
> --- a/t/t0007-git-var.sh
> +++ b/t/t0007-git-var.sh
> @@ -276,4 +276,81 @@ test_expect_success '`git var -l` works even without HOME' '
>   	)
>   '
>   
> +test_expect_success 'get author identity components' '
> +	test_tick &&
> +	echo "$GIT_AUTHOR_NAME" >expect.name &&
> +	echo "$GIT_AUTHOR_EMAIL" >expect.email &&
> +	echo "$GIT_AUTHOR_DATE" >expect.date &&
> +	git var GIT_AUTHOR_NAME >actual.name &&
> +	git var GIT_AUTHOR_EMAIL >actual.email &&
> +	git var GIT_AUTHOR_DATE >actual.date &&
> +	test_cmp expect.name actual.name &&
> +	test_cmp expect.email actual.email &&
> +	test_cmp expect.date actual.date
> +'
> +
> +test_expect_success 'get committer identity components' '
> +	test_tick &&
> +	echo "$GIT_COMMITTER_NAME" >expect.name &&
> +	echo "$GIT_COMMITTER_EMAIL" >expect.email &&
> +	echo "$GIT_COMMITTER_DATE" >expect.date &&
> +	git var GIT_COMMITTER_NAME >actual.name &&
> +	git var GIT_COMMITTER_EMAIL >actual.email &&
> +	git var GIT_COMMITTER_DATE >actual.date &&
> +	test_cmp expect.name actual.name &&
> +	test_cmp expect.email actual.email &&
> +	test_cmp expect.date actual.date
> +'
> +
> +test_expect_success 'get multiple variables' '
> +	test_tick &&
> +	cat >expect <<-EOF &&
> +	$GIT_AUTHOR_NAME
> +	$GIT_AUTHOR_EMAIL
> +	$GIT_COMMITTER_NAME
> +	$GIT_COMMITTER_EMAIL
> +	EOF
> +	git var GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL GIT_COMMITTER_NAME GIT_COMMITTER_EMAIL >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'get multiple variables with -z' '
> +	test_tick &&
> +	printf "%s\0%s\0" "$GIT_AUTHOR_NAME" "$GIT_AUTHOR_EMAIL" >expect &&
> +	git var -z GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'git var -l -z' '
> +	git var -l -z >actual &&
> +	tr "\0" "\n" <actual | grep "^GIT_AUTHOR_NAME=" >filtered &&
> +	echo "GIT_AUTHOR_NAME=$GIT_AUTHOR_NAME" >expect &&
> +	test_cmp expect filtered
> +'
> +
> +test_expect_success 'get GIT_DEFAULT_KEY with user.signingkey configured' '
> +	test_config user.signingkey "TEST_KEY_ID" &&
> +	echo "TEST_KEY_ID" >expect &&
> +	git var GIT_DEFAULT_KEY >actual &&
> +	test_cmp expect actual &&
> +	git var GIT_SIGNING_KEY >actual.alias &&
> +	test_cmp expect actual.alias
> +'
> +
> +test_expect_success 'get GIT_DEFAULT_KEY fails when unset and signing disabled' '
> +	test_config user.signingkey "" &&
> +	test_config commit.gpgsign false &&
> +	test_must_fail git var GIT_DEFAULT_KEY
> +'
> +
> +test_expect_success 'git var -l lists new variables' '
> +	git var -l >actual &&
> +	grep "^GIT_AUTHOR_NAME=" actual &&
> +	grep "^GIT_AUTHOR_EMAIL=" actual &&
> +	grep "^GIT_AUTHOR_DATE=" actual &&
> +	grep "^GIT_COMMITTER_NAME=" actual &&
> +	grep "^GIT_COMMITTER_EMAIL=" actual &&
> +	grep "^GIT_COMMITTER_DATE=" actual
> +'
> +
>   test_done
> 
> base-commit: 2c3adbb2c475981e340c79fdc5e7f4f9b5d9054e

