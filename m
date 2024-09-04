Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B551E6339
	for <git@vger.kernel.org>; Wed,  4 Sep 2024 20:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725480219; cv=none; b=rZwzZNQmfJ/kaIKZFCzk1kzkBhVFfCYyGQWSyfWVerE/ha7RLvd4n0TgdGT6Nrd1YhwH0AvMk54ZH5JuATJQaot6/OHdJjtwYdL2EroP0lkuRLjYf+NoiuE1LHoIy+g4zc05rYEIs0kFmm6LhGz2GrZjDSr0zSx+ykUa8GA7f74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725480219; c=relaxed/simple;
	bh=2jjXzsZpelt25nUkzQN9vSZZZvOdnR7VULH4N41xL8U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BzjoaIqyNjSswNWD9CHesjZ7jzsriIzVejoNPJfXlCFJPoV+k+vIyeTLpmbpZ/592PvScA6QYMXetC+r2790NUMUX2KxTImPkuVtk8NG2bhC6TxjUano7rp7Q7Jq4uNMD3Dsb517kwiDmVC7ktmBF563S19GbuZVfoJlLYcAZwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eNpI0iYt; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eNpI0iYt"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-70f6cb5518aso28038a34.1
        for <git@vger.kernel.org>; Wed, 04 Sep 2024 13:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725480217; x=1726085017; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DhrGGUu0Jd11REFhvcBbXWRBUIRmQC9//m+5NxDYcSs=;
        b=eNpI0iYtn1eYGkat9FXfgWXDEt8Y32YE88BJQX/A4s+rt1TJA+gpxqI9xb4zUOLVYI
         Tc2CU+Djfyg9cmLt5Kso6YtUnICAzYX26GWhpKpjorouo0hLdZZAExSd7XlYUckSVvN2
         DC6gTuJyNT3O91R27PpMIWXgxHmUBSkh6xtK5JSRXcF0DwgGdAbmB0Rfbm/LAZ7Snm5e
         AT9mFSU4Lb8L7+XJ2T4ihXPmpGwNCO4Ex9/RxIibTSuW38lN/EoUT9gX39SAkuQ8aGm6
         /SAS3/9rdnMeEKYySRFibZlVBJIWKs4qkz7In2P5Ou44nJlsGAG78ItHyIa10mGcTc9u
         ZDOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725480217; x=1726085017;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DhrGGUu0Jd11REFhvcBbXWRBUIRmQC9//m+5NxDYcSs=;
        b=I+gaZH2FiFJwaS3VABNtqxk/TFiJ5sHLIXb3EHLynobGo1v7fPq0bARysnM9J4iFce
         Wm1XR1q1brzKeyPo7lRNSjmxvK6lAXgPx/6vJ1d/U/5otwYp/f7tU+KM0Xa72feA7vB3
         a3xlJM8pRgsRy5W0wWccMbxXm0Yv+W4vOLiepsWcAFebrlDyH5fhepfw+DRaihuAxR/V
         4+GX47GbtQFkZgtkSDlOGA8RPrkrNIdYNXVa5wAsi/kL0VfmrFf4dpu7ruLpOjq5+eiv
         N+dew5Xqcbj+M3Ik3JLQnxxuoM/pvvMIz7W/poRE4TMiYjWfNThOn0yH0Epf6lDnQAP1
         dLaQ==
X-Forwarded-Encrypted: i=1; AJvYcCXS5Z3ahTyLJU6jM1WIjYROsiVLHs3F8B9Uv7BUUA8ODPCMKSJ/0YyVGIRNlPJ/e6l2OBE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLX+INgI3t+BSQkW9Fwih4omtFJVx8H8B+Z/B7RAykduHGry8b
	XOveB7z10AF5FoF9BQhrXxiyJTfXM9sZB8bwgj4KNNGChC+cbEFsfWquyg==
X-Google-Smtp-Source: AGHT+IHnQu9XqnylPyTi+537pzfLC+jd52uxdvqOApfboFBh5FgM+lCju84A/MdCWkc7cshy3cID0w==
X-Received: by 2002:a05:6830:490e:b0:709:50e6:489d with SMTP id 46e09a7af769-70f71ee99edmr18586994a34.3.1725480217044;
        Wed, 04 Sep 2024 13:03:37 -0700 (PDT)
Received: from ?IPV6:2600:1700:60ba:9810:a1f3:c77b:6e39:8f9d? ([2600:1700:60ba:9810:a1f3:c77b:6e39:8f9d])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-70f6fe3e57asm2531940a34.75.2024.09.04.13.03.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Sep 2024 13:03:36 -0700 (PDT)
Message-ID: <e8232cdc-7a5d-485e-84f7-2c05e17f9907@gmail.com>
Date: Wed, 4 Sep 2024 16:03:34 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] remote: prefetch config
To: Shubham Kanodia via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: "Patrick Steinhardt [ ]" <ps@pks.im>,
 "Junio C Hamano [ ]" <gitster@pobox.com>,
 Shubham Kanodia <shubham.kanodia10@gmail.com>
References: <pull.1779.git.1725472799637.gitgitgadget@gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <pull.1779.git.1725472799637.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/4/24 1:59 PM, Shubham Kanodia via GitGitGadget wrote:
> From: Shubham Kanodia <shubham.kanodia10@gmail.com>
> 
> Large repositories often contain numerous branches and refs, many of
> which individual users may not need. This commit introduces a new
> configuration option (`remote.<remote>.prefetch`) to allow
> users to specify which remotes to prefetch during
> the maintenance task.
> 
> Key behaviors:
> 1. If `remote.<remote>.prefetch` is unset or true, running
>     `git-maintenance` will prefetch all refs for the remote.
> 2. If `remote.<remote>.prefetch` is set to false, the remote
>     will be ignored for prefetching.

Thanks for this contribution. I think this is a good idea for extra
flexibility of the prefetch task.

> In a future change, we could also allow restricting the refs that are
> prefetched per remote using the `prefetchref` config option per remote.

I agree that this would also be of interest, but more complicated. Thanks
for starting with this simpler modification.

> +	if (remote->prefetch == 0)
> +		return 0;

In the Git codebase, this would normally be written as

	if (!remote->prefetch)
		return 0;

> +		# Run maintenance prefetch task
> +		GIT_TRACE2_EVENT="$(pwd)/prefetch.txt" git maintenance run --task=prefetch 2>/dev/null &&
> +
> +		# Check that remote1 was not fetched (prefetch=false)
> +		test_subcommand ! git fetch remote1 --prefetch --prune --no-tags \
> +			--no-write-fetch-head --recurse-submodules=no --quiet \
> +			<prefetch.txt &&

I'm happy to see this use of test_subcommand to validate the behavior
of this patch!

This is a very good patch and I only have the one style nit.

Thanks,
-Stolee
