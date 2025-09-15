Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DBC78287E
	for <git@vger.kernel.org>; Mon, 15 Sep 2025 18:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757959780; cv=none; b=q5s7nochf9pLL+UNX7lsY2DXQ5omZmD+XSGCksm+PTliDx+NHYLJ1Mk25Ac1QGkzIKnYq5wbNWb60c7GKtv3d+SgxCTnC7tX72tjW3CpJ60Ya+3XwzNlRhoN8+aIqvo0mUVEhe8esoErTEe5BDx5k7D/KZRRyZYI3QWhHKPjIlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757959780; c=relaxed/simple;
	bh=C0eMrJVn/IVKiSvaK/+skRFX8damYr3Rb3l5VT55iHQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BZrU+ZVUFN8QN/RKppAm3M+1FHh9RM6T2JxbgUi2YfHcnW9haRuTMNgIO7sxTFUsZVEzfnx15Ftw5k9FhhCY9FlvAuT8ncvL+ig0NbwJw3pjP4XY+jOfwkg6Qkc2GCuCGragcSbgUcg4NWU4qUnJTDdULcB4oAk45n/h5BdtII0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ajdeXztY; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ajdeXztY"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-80a6937c8c6so537548085a.2
        for <git@vger.kernel.org>; Mon, 15 Sep 2025 11:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757959778; x=1758564578; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I28R2Vwyfqu2AS3rfqiaNzbijp8e7pv3rOo4Qzh0nuI=;
        b=ajdeXztYYYalKpW1FjfCkJ3MXmJ978TraeOrT6jdDUEqx14l/7YkysIV9uDf2YTW1N
         AY9CUg8SFKAKtAeDpXQlkdDW+MjH0Nv9JG/ku4c9ydxlgz01CPDdJ8uNDDvT4YeKFnxQ
         gylyQAEN0k7g1hzVlVX4gFVVWH5MiNE1ISiZR0N0UEeufv7O3Da7BSQmbYerTWUBmooi
         ZltxM6WnTUYW4w2pyokoMb8Zi4slHDzWyLUAXwjDRZiLQuaU/D7d6giCp78DmYbySwA2
         UMUYeiXUkYZp/ybKWbDbcBsdNh2P3jpc/VfSdrpojmFQNOIXwvgByMpKQl414C5JnzC0
         v5ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757959778; x=1758564578;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I28R2Vwyfqu2AS3rfqiaNzbijp8e7pv3rOo4Qzh0nuI=;
        b=MFx40/yyhsHgoMHbfzF6kYEBISj/+PcsVaYzXhVlDz6XF6m/jcG7uATgH3T9svSIN9
         yl91xa4poAeVHL8SamTdnn6jSR8wP+GUeuBXylqcznVw4fWbgmCD00Tt0Fq3aFnN1mF4
         S9dN5br+IxH0t7rb4q0Ad55QtKwvshGS0j83XRgYESg8a+EitZAhItDDoGQYwMuVFh1T
         em9Z6nQHcoV3yP3yIRjjC5mS9yfqoIUhshKykRjr1+QX+kdR8c6XUsXj+DPg9nFMjI1y
         c+B2DCYoUtiMKSu4qwXYYmA4XW4OG2SOCOk2SiAqr/83Oovk5easucHUbvVgWX6QBpsY
         /T8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWNlaOmqo+ZDXg2JasjDw47zDRxmh2gMQOL6rfBKTDGiW71P0bACIYhn+MzI9UZLMo90Os=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs+tvsex0gYyQbvjxvLQ08koeP/osH5Lj/mGNUnEoMYZWJOYfw
	NV6ZABKo1yHhkBA1rLdWj85KAvDCn/qH4zoXHMJR2r2O9sA3j2nc6oVccp13wA==
X-Gm-Gg: ASbGnctoiJUlLVMDGoZlr1bLOobadmpIoRKi4zaCbAHj/cWjTkIe1V4vc6WwBWFdL4t
	0Th6E1hUiKzmvuLTU4VPlLilIpzYVf93WXumV7XB0bu7heGRTaT/A+M5Wc1FPJGq24p75+qA0ZJ
	h7qQUyV/7gtEKBspGzDc2PNXnrPiHTZcDa2+zLdEVYwNZEp5vjoKt1qscSLiBAwbybhi7dJWHg2
	MjiKJh7+n3SlHjjeHlOCL7wZekZFapgPLaS6UHKHZowK+HJGo7lbA4+Aqk+gcx/j+qpQPB4czDQ
	NnqWgfxb/XQ8tQcPdZtSH9sTDdZXQtlSrrvPyob5OPGeZ9gtzWH03wZ0FV9GGzHR2y2UWZKRkKq
	p6CHYLCuMkok42GYtKQ5EVZXB4A2eQ1gZkIc=
X-Google-Smtp-Source: AGHT+IFXe0vTCI3wDPnNLSuJJ5lgPv/UV3KHCwYW0XCMH7HH7rbA1AJcjSLYdjfE4ORjIXyHKBojgA==
X-Received: by 2002:a05:620a:3905:b0:820:e8c:7911 with SMTP id af79cd13be357-8240018450dmr1792334685a.55.1757959777704;
        Mon, 15 Sep 2025 11:09:37 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.70.92])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b639dcd8f8sm73386951cf.44.2025.09.15.11.09.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Sep 2025 11:09:36 -0700 (PDT)
Message-ID: <373d3441-6489-4b46-bd80-bc1ad68f0e9a@gmail.com>
Date: Mon, 15 Sep 2025 14:09:14 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/7] sparse-checkout: add --verbose option to 'clean'
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: gitster@pobox.com, newren@gmail.com, Patrick Steinhardt <ps@pks.im>
References: <pull.1941.v2.git.1752716054.gitgitgadget@gmail.com>
 <pull.1941.v3.git.1757673011.gitgitgadget@gmail.com>
 <2cde464fd4c225144489c222537e5d7549f81849.1757673011.git.gitgitgadget@gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <2cde464fd4c225144489c222537e5d7549f81849.1757673011.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/12/2025 6:30 AM, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <stolee@gmail.com>

> +static void list_every_file_in_dir(const char *msg,
> +				   const char *directory)
> +{
> +	struct strbuf path = STRBUF_INIT;
> +
> +	strbuf_addstr(&path, directory);
> +	fprintf(stderr, "list every file in %s\n", directory);

I don't know how I missed that this debugging output line snuck
in and stayed through my testing. This line should be removed.

> +	for_each_file_in_dir(&path, list_file_iterator, msg);
> +	strbuf_release(&path);
> +}
> +

Thanks,
-Stolee

