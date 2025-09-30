Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7993043B8
	for <git@vger.kernel.org>; Tue, 30 Sep 2025 15:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759246010; cv=none; b=n82Rhb368yylK4rIz0WhKU9noDClLJt0IrM/rnmZz7zj1NmrQl4a6OND3XHr9GjeawujiAbBa4egIClCuwtV0/2HiPQcXRelV3Fh8FyVM1UhWoAgLFV4QShoURO8sJNjnDs8IGkYDE4bm86J6+HdGm37jDxR6bZythtE5TU3OXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759246010; c=relaxed/simple;
	bh=+qnL9ginlXT65fEmj1sZd0fWZ88YqnO8t/QnXPn5wPM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=jDSSua/IvFe2332ylQ9fmCmiLruwvqOlEXTSvqXi3W9nIeJE/3bYJ9YTXTTNEHjycoLkMD83bQQnU2If4mfBRs+Qzqsu4wI9migzhy1cpywFi3fQfe6UyoByZtURAQethbYQQNYT7G6qu1eV/uryD2cFMK5inCXqBF25VJ0nSgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AyHM5z6L; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AyHM5z6L"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-46e37d6c21eso41534845e9.0
        for <git@vger.kernel.org>; Tue, 30 Sep 2025 08:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759246007; x=1759850807; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QTQ9vXEcx+OUOzp69h4/3CDiCinlC0+l3SOX5zUIqgk=;
        b=AyHM5z6Ljm2JLtUYcs0zqRaXIWNllYJrgA1TAAxw/EWED5OrJef/ie5QT6Yhy/sCqa
         EHfFXe5Eoy/DMfxMCFERHitBc5NFnXeCcMznWckf8HTN38OVT1GGcRg/Rp4dRml/szEP
         s14PU9RSp/fAwGaOWqHgt1VQUgpRhKAUxw14Z6AnxvsuPobzppSOrz9F9QgJ1ysqMTlW
         L06Tjv4JklvwgZbeadsTWT6Lst3MeNMfwQhP5QGZZvxmFCZht0DUKG31xk4/fFhEKnnG
         rtSb8dsMEB/+zyipY+HqaTuHsZTMKh2vYKVVq4fQ/ZquA1KAoF/rbRpLy5SPsnOn4mTb
         nxjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759246007; x=1759850807;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QTQ9vXEcx+OUOzp69h4/3CDiCinlC0+l3SOX5zUIqgk=;
        b=M5izqZ8O9QuyEfoLgd/cTe12GNmu5A9O2CtBD78IrYW6pP8drJMLubQWRK+T4vVDuQ
         NQXNK06AtsVIlIPdbiFFYYljVOVz1asp/EsFBSJH8d3lkzb5KlgulQsW+6lEPQ36DeJA
         iPPJmEI4Hqd2swZTzLUAUxITFpmdkO+duKo7niG3/teU1qkvIx4WY0CUz3Q2KPn0G+85
         XZ1bKbGGmJ0edvgs0ZoPd02WJ30pekMwsInd6n1WDwgA9mV9YhRTJ3KfYzL9UUDN8z/U
         7sMNC0LcB32G0/F7hHXu0kLqXV+lYk4YW3sFmm+Klw2owukcz/wzKNwFGTS7vkDDISAv
         mR+A==
X-Forwarded-Encrypted: i=1; AJvYcCVWUeObtFTe1Knjsmi8wbcaFdcmSZ2ABwtBoSDJZ8HgKEykv+9rZMESfxF7EbkmeCKa5RU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUoE9rrCdHvXsK2jWkjq7RquSao1mss6cHBvJ8XwyZru4kUgvA
	sGn69Woot2LEf1yfaExY33kR+PHYUcGGBabNtgORrA+YU7fniZnxzyPBfjDGG3BZJ3Y=
X-Gm-Gg: ASbGncvtJRMzyyQPvexoRM+gl0uMBB7O2HE6nGSo0HGNqviCvdo26CcPQ0O3wFTeMsD
	UJ7nqwYvKsyKElmXxdW6TKViVmfvERUTOZCHFPMRsBG0LbF+IkUP55C1AJYFrrL8E49qNvui4z5
	BHo62Wjmn+Zm6FwfzC0ctasG1iHGqiYf3mnRbyuY5oNlwVhSWMmJS3Nb3R8wxuy0s+N/V/nO1Wp
	hYImn11WJ9VwrumM9NBJfSvWdg0gqJ+W9WIT2YneIZyb4RYslybcYlJZPfxCMUDQNFqdU4nzQvv
	g3T5hCvOVSMg6W7ZheD92oV0lNfWJH6rT3aI+aGRJ8pw81FqAKOB4SFUPonY3En7WmNLZdjTjmX
	C23zkkJ78ePR8M+G86CU/3XdbNOTGRPF4xZxLdyWLJDaNQ9dwvNyKm7bZ8Tonn5ICw1Xp7oNiYk
	jQYbWzsLpO6RE9Z69oVC90Re0+xWXe6GwnXQ==
X-Google-Smtp-Source: AGHT+IGISW2P5LOS2GONeZF24hpRr5peb2VzBykrOUa5JHzv7B7lIXwAgx4+A5nREbWVmvffgVpEbA==
X-Received: by 2002:a05:600c:4e53:b0:46e:3dcb:d9a3 with SMTP id 5b1f17b1804b1-46e6127dfb8mr2433745e9.12.1759246006467;
        Tue, 30 Sep 2025 08:26:46 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:62a:101:611a:6fa9:aa15:af04? ([2a0a:ef40:62a:101:611a:6fa9:aa15:af04])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e2ab31ea3sm271589645e9.12.2025.09.30.08.26.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Sep 2025 08:26:46 -0700 (PDT)
Message-ID: <e8755a04-bd44-4ead-ba44-c603bffcc75e@gmail.com>
Date: Tue, 30 Sep 2025 16:26:45 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2 3/3] parseopt: values of pathname type can be prefixed
 with :(optional)
Reply-To: phillip.wood@dunelm.org.uk
To: "D. Ben Knoble" <ben.knoble+github@gmail.com>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
 Noah Pendleton <noah.pendleton@gmail.com>, Patrick Steinhardt <ps@pks.im>,
 Thranur Andul <thranur@gmail.com>,
 Michael Grosser <grosser.michael@gmail.com>,
 Eric Sunshine <sunshine@sunshineco.com>, Taylor Blau <me@ttaylorr.com>
References: <20250501214057.371711-1-gitster@pobox.com>
 <cover.1759094936.git.ben.knoble+github@gmail.com>
 <5f7057c236c9af3152bd531eed2e4ad0ac35e291.1759094936.git.ben.knoble+github@gmail.com>
Content-Language: en-US
In-Reply-To: <5f7057c236c9af3152bd531eed2e4ad0ac35e291.1759094936.git.ben.knoble+github@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ben

On 28/09/2025 22:29, D. Ben Knoble wrote:
> From: Junio C Hamano <gitster@pobox.com>
> 
> In the previous step, we introduced an optional filename that can be
> given to a configuration variable, and nullify the fact that such a
> configuration setting even existed if the named path is missing or
> empty.
> 
> Let's do the same for command line options that name a pathname.

Sounds sensible

> +Magic filename options

I assume we're calling these "magic" to match to pathspec "magic" 
options? I wonder if that is a good idea but I don't have a better 
suggestion.

> +~~~~~~~~~~~~~~~~~~~~~~
> +Options that take a filename allow a prefix `:(optional)`. For example:
> +
> +----------------------------
> +git commit -F :(optional)COMMIT_EDITMSG
> +# if COMMIT_EDITMSG does not exist, equivalent to

This doesn't quite scan for me, maybe s/, /, it is/ ?

> +git commit
> +----------------------------
> +
> +Like with configuration values, if the named file is missing Git behaves as if

I'd drop "with" here

> +the option was not given at all. See "Values" in linkgit:git-config[1].
> +

> @@ -209,21 +208,31 @@ static enum parse_opt_result do_get_value(struct parse_opt_ctx_t *p,
>   	case OPTION_FILENAME:
>   	{
>   		const char *value;
> -
> -		FREE_AND_NULL(*(char **)opt->value);
> -
> -		err = 0;
> +		int is_optional;

This can be a bool as in the last patch.

>   		if (unset)
>   			value = NULL;
>   		else if (opt->flags & PARSE_OPT_OPTARG && !p->opt)
> -			value = (const char *) opt->defval;
> -		else
> -			err = get_arg(p, opt, flags, &value);
> +			value = (char *)opt->defval;

I'm not sure why we're changing the cast here (or why we need one in the 
first place assuming opt->defval is "void*")

> +		else {
> +			int err = get_arg(p, opt, flags, &value);
> +			if (err)
> +				return err;
> +		}
> +		if (!value)
> +			return 0;
>   
> -		if (!err)
> -			*(char **)opt->value = fix_filename(p->prefix, value);
> -		return err;
> +		is_optional = skip_prefix(value, ":(optional)", &value);
> +		if (!value)
> +			is_optional = 0;

I'm struggling to see how value can be NULL here as we return early if 
it NULL before calling skip_prefix()

> +		value = fix_filename(p->prefix, value);
> +		if (is_optional && is_empty_or_missing_file(value)) {
> +			free((char *)value);

I think we want to call is_missing_file() here. If the file is missing 
then we do nothing which matches the documentation above - Good.

> +		} else {
> +			FREE_AND_NULL(*(char **)opt->value);
> +			*(const char **)opt->value = value;

If the file isn't optional or it is optional and exists then we behave 
as before - Good.

Thanks

Phillip

> +		}
> +		return 0;
>   	}
>   	case OPTION_CALLBACK:
>   	{
> diff --git a/t/t7500-commit-template-squash-signoff.sh b/t/t7500-commit-template-squash-signoff.sh
> index 366f7f23b3..c065f12baf 100755
> --- a/t/t7500-commit-template-squash-signoff.sh
> +++ b/t/t7500-commit-template-squash-signoff.sh
> @@ -37,6 +37,16 @@ commit_msg_is ()
>   	)
>   '
>   
> +test_expect_success 'nonexistent optional template file on command line' '
> +	echo changes >> foo &&
> +	git add foo &&
> +	(
> +		GIT_EDITOR="echo hello >\"\$1\"" &&
> +		export GIT_EDITOR &&
> +		git commit --template ":(optional)$PWD/notexist"
> +	)
> +'
> +
>   test_expect_success 'nonexistent template file in config should return error' '
>   	test_config commit.template "$PWD"/notexist &&
>   	(

