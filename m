Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C2056B63
	for <git@vger.kernel.org>; Mon, 11 Mar 2024 21:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710192601; cv=none; b=csBPaMpQjj6QnBunOo3+YtHA4DC7/FNGkHAafjUj7e48sUQ7gAgsAgmsDbte3z/lX6uQqejdutBZEs4Z7pUKY4dcO9n3r9ZQn811H6iKEXDrzKuU31Mcq6B2q/2Xz8Ps8S2oDjd9QGBgR8hWlszxDZTg3JZAykzKmYzcD4bBOsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710192601; c=relaxed/simple;
	bh=shfoRAOpYtdske9BtOe29+G6liAlD5WpFiZnVck/47w=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=VHjRssbdCUEmIAtOB4T/zni7mYP3RW5Rd6GjLTkOC6aCcTq48SBt0BEVU5hGoSTBLw7hY1XGNNeU5D/p/MLe6UhygRDFnPXl0813ROXH6UNd/glDy+7hhFWpNcYCvhakBLKtXRod51Bj7AdHMN2oSTxHm+GgLmfQpIgLz9Azt5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZHLkxFV2; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZHLkxFV2"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-56759dc7ea6so6358409a12.1
        for <git@vger.kernel.org>; Mon, 11 Mar 2024 14:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710192598; x=1710797398; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=D6qDOY6Dl1pLKRRNkkwdD/Bxfm2kQQlCaqyXmbYMTAk=;
        b=ZHLkxFV26CQ2/yICx5187A1Enu/IqTgPB5TmlDcg05Y449fXBtur3wZmfsmqEzZfl2
         6W1qFY6jbi0bJsqTT4GzKQpPuk5CWPHpJAArAISpmJ54xK1CTZBzxEIN6qsuUo5IJTx/
         7hr+IXdoEoZY20hZwqEsYcijCajdjHOJEk9josUHuZtmktJxqCwaF8Ru+u+MWF1NyH8v
         ddknrhqUr8Z+WMmGKCJLyT8dZIxUTStHCA5C1mXuMZ9P5/NSObJwKA9YSF/UQfdWXcQl
         YX2WWc9zxQmGBGEsuU1zjN48q9tkYMa5UWaJLKuCJEAB8i8Z+Vby4K95Jyv2tQtEfYH4
         pz6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710192598; x=1710797398;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D6qDOY6Dl1pLKRRNkkwdD/Bxfm2kQQlCaqyXmbYMTAk=;
        b=ntHDIMelegP8BuiwQj7vxW4pcaOt5ajdqMulmez7u+61GiVYFoEd35+ek37MC5oYFu
         sxZTpZmS+5KrvM983iMTIh6O4Ap0UErzCZIwArCmfn7TCgYfunIXNGynV5d3FLLVBsBE
         Go0AjvthTO7YG/IycXPQX3bSVsGophjUo0+IojY4nz6nO7DhQkW6iir5i8KR10zEKcOn
         Ro7RWXKs02HKz+5QgP3GUgca9tX4/ZCwEMERN3gXesphWzH18hELGSVs++io5v4OKbfY
         pa1TRMmsvlMdzCEi3vcgueGsM2YSEMMEsflJ0qe7Yb9gyeodNrEgZHARS3C4JBixS9yS
         yXyw==
X-Forwarded-Encrypted: i=1; AJvYcCVvuSLWC8LNcXMcXoJjfyYQUmaEYRf26WxA+8SWmWKfCSVGRvq3gBYeP4eTGvw6KMkTrbx+QCe6NMYGQRk2RPW2eM1x
X-Gm-Message-State: AOJu0YzPkKwSvDugnvIWmPM50+dxrosEgYuwyovvI63M+301L0ichZmo
	TgnJNaYjs2riZMfi0uEBPBHT+bv47pWfyMA0CLWM//Qk0SaIwAOg5Ym7kAua
X-Google-Smtp-Source: AGHT+IFZWc4lwbKvKYAhYM95/Z6m9lZpDgdaLfzZ2yN0nNyEZkdPR/Xn0Kwx5WwqGF5qyUGAjhtJmw==
X-Received: by 2002:a17:906:99cc:b0:a46:3755:e995 with SMTP id s12-20020a17090699cc00b00a463755e995mr1390237ejn.44.1710192597623;
        Mon, 11 Mar 2024 14:29:57 -0700 (PDT)
Received: from ?IPV6:2a04:cec0:103f:4e2b:599c:222:2133:41a7? ([2a04:cec0:103f:4e2b:599c:222:2133:41a7])
        by smtp.googlemail.com with ESMTPSA id lr1-20020a170906fb8100b00a442e2940fdsm3235824ejb.179.2024.03.11.14.29.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Mar 2024 14:29:56 -0700 (PDT)
Message-ID: <53ea3745-205b-40c0-a4c5-9be26d9b88bf@gmail.com>
Date: Mon, 11 Mar 2024 22:29:53 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] format-patch: teach `--header-cmd`
To: Kristoffer Haugsbakk <code@khaugsbakk.name>, git@vger.kernel.org
References: <cover.1709841147.git.code@khaugsbakk.name>
 <f405a0140b5655bc66a0a7a603517a421d7669cf.1709841147.git.code@khaugsbakk.name>
From: =?UTF-8?Q?Jean-No=C3=ABl_Avila?= <avila.jn@gmail.com>
Content-Language: fr
In-Reply-To: <f405a0140b5655bc66a0a7a603517a421d7669cf.1709841147.git.code@khaugsbakk.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 07/03/2024 à 20:59, Kristoffer Haugsbakk a écrit :
>  
> +format.headerCmd::
> +	Command to run for each patch that should output RFC 2822 email
> +	headers. Has access to some information per patch via
> +	environment variables. See linkgit:git-format-patch[1].
> +
>  format.to::
>  format.cc::
>  	Additional recipients to include in a patch to be submitted
> diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
> index 728bb3821c1..41c344902e9 100644
> --- a/Documentation/git-format-patch.txt
> +++ b/Documentation/git-format-patch.txt
> @@ -303,6 +303,32 @@ feeding the result to `git send-email`.
>  	`Cc:`, and custom) headers added so far from config or command
>  	line.
>  
> +--[no-]header-cmd=<cmd>::
> +	Run _<cmd>_ for each patch. _<cmd>_ should output valid RFC 2822
> +	email headers. This can also be configured with
> +	the configuration variable `format.headerCmd`. Can be turned off
> +	with `--no-header-cmd`. This works independently of
> +	`--[no-]add-header`.
> ++
> +_<cmd>_ has access to these environment variables:
> ++
> +	GIT_FP_HEADER_CMD_VERSION

Better use a nested description list like this:

GIT_FP_HEADER_CMD_VERSION;;
  The version of this API. Currently `1`. _<cmd>_ may return exit code
  `2` in order to signal that it does not support the given version.

> ++
> +The version of this API. Currently `1`. _<cmd>_ may return exit code
> +`2` in order to signal that it does not support the given version.
> ++
> +	GIT_FP_HEADER_CMD_HASH
> ++
> +The hash of the commit corresponding to the current patch. Not set if
> +the current patch is the cover letter.
> ++
> +	GIT_FP_HEADER_CMD_COUNT
> ++
> +The current patch count. Increments for each patch.
> ++
> +`git format-patch` will error out if _<cmd>_ returns a non-zero exit
> +code.
> +
>  --[no-]cover-letter::
>  	In addition to the patches, generate a cover letter file
>  	containing the branch description, shortlog and the overall diffstat.  You can


Overall, thank you for correctly marking up placeholders and options.

