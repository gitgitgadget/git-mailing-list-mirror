Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB9B255F2C
	for <git@vger.kernel.org>; Thu, 23 Oct 2025 16:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761235409; cv=none; b=m2jLwIxErDWNvqMfG0SKumKVA9YsU0JOeK9gTc6HZ5k+HwwZ9GWodX3fzxx1E2wJGKUakcW7xPtGJW7T7u777j+YgxazYWI7eGrD5nqIJfrmvEcq/zRLDWBsvaEUIV3/lkdyN2ju0vrB6sqyTPsuy7ctI4iSX2QYuG+M/2K9Q0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761235409; c=relaxed/simple;
	bh=JfEB0dvpza4/rY6BSR9AiSFui5zcWqUsVCEKPBdShDk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bPQWS14ki9rQcUOWpxQdHYBAAycnAISFb5EROP4OapcMRTqFfnTTUnfKzZzi+3PXDOh+9nECfqLP5wXQk7DBrAhgjNPb1E2tjx50G4sJI3twDhQVqperz72Ltik1cgFepyR193LjCTAa9C+4UTrHaYEl/Jdz8XMrd3OGXxiH1ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ih7Gy/Cp; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ih7Gy/Cp"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-47103b6058fso7724635e9.1
        for <git@vger.kernel.org>; Thu, 23 Oct 2025 09:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761235405; x=1761840205; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5WqUR7OYVp1XYrfMpdsSqjKsAVJW+c8PxnfEom1m5Gk=;
        b=Ih7Gy/CpE1JHVrIITVJOXFpJsh0rpEAB3xHFU6yE5oHfFe3sTvxYyC8pdE/JIHTMUf
         anH4iMk57PtrkO30CHW7UY8gu+42sHuILfpSurS8JV8dPSNQSfmKIwtwRbnOlBQxtr7G
         NSoNTcDDqJ4/VqY3iSKRTAFQY4vzzkPmGlV2pVfXPavYAG1cAfJZ79sAEfd9mheomLu+
         wYesEmE2rkcIEgDWlYLkOT+iwFMTghgyZLpiiJqdpzDQELQ1+I/c4HThPnd8twAiVckv
         c+66bX8qZuym3n4UjTfgFltGz2e2iflyS9Lmrnh9zY5CkavZrqymkxtSPDzpGd4t0Fkp
         3xOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761235405; x=1761840205;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5WqUR7OYVp1XYrfMpdsSqjKsAVJW+c8PxnfEom1m5Gk=;
        b=XxGGkEQ07bRp+7RwVYKNyyzSbIWcDdY1cuEGQBmgB0WxahBx8KCbdzPjXKDE477YF0
         10ejNlOCzuGFdm6XxsW4ilzaaJbat4H0xZnEuyeMZUzal28/JnJs6FxfRVYcJ0dCw6KS
         Nb0XAwJEdlzcSeDbaKKCaAtwqx9LHktG/z3zZmR7cXd9qkxJxM1cmSY0Ios8fGSHNjoJ
         D772hKvEtJhNuJBPxQl2ttFuIUcfyUn5Hfn+g//VyelxSub4wiXyuocMy8ZX6wboiX5+
         QqBiH8QD+oweGDQJmWYgGLPdcfIgs3Zmr6Lows9UmFAHVCz1lbqH5g+SF6LUc/+7AfmR
         x+AQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqEIq5rgq3tKmAKXRD0MgYd5+NOvSDW1HzHnDg1cUqRjMQITQhTMj+ZLFtAlgbd6h9ARc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmMWWn077ZDU/9u75XmVH6dhjKY7VBiuN4mZtPs6hxkcGEn7+o
	5Xk5tsvCuQZCllJJdfJKUgAM74yBtMUEZ72QgeWxrjhCP7TaKpibxAPf
X-Gm-Gg: ASbGncttXYQqVxaAGURXQQEwE3bbY90ZTZrl4zUQ2RH8yABONsDUivxnWN+TMotnnMV
	jaDHHuljgv1QkMNmFR93S2AfjD6LOgG0suviRCbjbYbIo/eRRME+l7Hz9a6YZOyZTNTSNwHbgDB
	eV2nAN0Y/H2Qmkl8VotSoUr98MJy6Yu93XYBU6b4Golu/xJDbATMTOs/9MZAg0asD8UEdGI17ve
	uGpWGIps8KUbrVxxVwytTKQwy1A8Cf4sHDP40hHbMzSt2aIvIHkRrQQJ3/1Pfk7xnFSWkQpuXhw
	RtEMkxS+K2Ww3V33GpgZuwJK7y1MLNEHdt4jrvtiYb44JCW5eurWaSg0bT+kAGFaFPTrtb4IPRO
	Xys6UZDAhNwzbmho1ABkS/r5yjyR4H+fQ3JkFYytIk47EMUfdgPiCDFZtP1Gf668iDiZ2xWlKF6
	fzfFaJt9lJfsjO31tjzOpPhGKmDN62DDKOkC3Ob/aKgUuEtMTktpc0GtHxNMFhCfDQuFx3zZrJL
	w==
X-Google-Smtp-Source: AGHT+IFrSxHNBOMi6djj+PS/fRhJtKEfhp2abDenH2qXjRX1M8CgXe3nYFAjn3PYNoE6TsjZ959r7Q==
X-Received: by 2002:a05:600c:3f10:b0:46e:6339:79c5 with SMTP id 5b1f17b1804b1-475c3fa1f3emr64575055e9.5.1761235405239;
        Thu, 23 Oct 2025 09:03:25 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:62a:101:611a:6fa9:aa15:af04? ([2a0a:ef40:62a:101:611a:6fa9:aa15:af04])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475caf2eb9csm44145505e9.14.2025.10.23.09.03.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 09:03:24 -0700 (PDT)
Message-ID: <0d6019c7-5e73-4195-b5d2-b43f2cb6399d@gmail.com>
Date: Thu, 23 Oct 2025 17:03:23 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] blame: make diff algorithm configurable
To: Antonin Delpeuch via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Antonin Delpeuch <antonin@delpeuch.eu>
References: <pull.2075.git.git.1760972162827.gitgitgadget@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <pull.2075.git.git.1760972162827.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Antonin

On 20/10/2025 15:56, Antonin Delpeuch via GitGitGadget wrote:
> From: Antonin Delpeuch <antonin@delpeuch.eu>
> 
> The diff algorithm used in 'git-blame(1)' can be configured using the
> `--diff-algorithm` option or the `diff.algorithm` config variable.
> Myers diff remains the default.

I think this sounds like a reasonable thing to do, although it is 
technically a breaking change.

> diff --git a/builtin/blame.c b/builtin/blame.c
> index 2703820258..177b606e81 100644
> --- a/builtin/blame.c
> +++ b/builtin/blame.c
> @@ -779,6 +779,19 @@ static int git_blame_config(const char *var, const char *value,
>   		}
>   	}
>   
> +	if (!strcmp(var, "diff.algorithm")) {
> +		long diff_algorithm;
> +		if (!value)
> +			return config_error_nonbool(var);
> +		diff_algorithm = parse_algorithm_value(value);
> +		if (diff_algorithm < 0)
> +			return error(_("unknown value for config '%s': %s"),
> +				     var, value);
> +		xdl_opts &= ~XDF_DIFF_ALGORITHM_MASK;

I think this should be

	xdl_opts &= ~(XDF_DIFF_ALGORITHM_MASK | XDF_NEED_MINIMAL);

as you have below for the option parsing.
> +		xdl_opts |= diff_algorithm;
> +		return 0;
> +	}
> +
>   	if (git_diff_heuristic_config(var, value, cb) < 0)
>   		return -1;
>   	if (userdiff_config(var, value) < 0)
> @@ -824,6 +837,26 @@ static int blame_move_callback(const struct option *option, const char *arg, int
>   	return 0;
>   }
>   
> +static int blame_diff_algorithm_callback(const struct option *option,
> +					 const char *arg, int unset)
> +{
> +	int *opt = option->value;
> +	long value = parse_algorithm_value(arg);
> +
> +	BUG_ON_OPT_NEG(unset);
> +
> +	if (value < 0)
> +		return error(_("option diff-algorithm accepts \"myers\", "
> +			       "\"minimal\", \"patience\" and \"histogram\""));
> +
> +	// ignore any previous --minimal setting, following git-diff's behavior

Style - oneline comments should look like

	/* comment */

> +	*opt &= ~XDF_NEED_MINIMAL;
> +	*opt &= ~XDF_DIFF_ALGORITHM_MASK;
> +	*opt |= value;

"git blame" also has a "--minimal" option which now needs to clear the 
diff algorithm when it sets the minimal flag.

Thanks

Phillip
