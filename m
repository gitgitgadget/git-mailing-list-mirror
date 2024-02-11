Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0115A110
	for <git@vger.kernel.org>; Sun, 11 Feb 2024 11:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707649441; cv=none; b=cvYR+UfyzaBYUfUD/GD0Slw/8dH+D6LwaDJEYEOKcZ7wRuTtxLlKNpCJLmhTP+oSbI3pcyf82gwEAWMLP+So8CbnPIdevnplKM+nMS4Dg8EK03z832IYqIf9uG3OlyRsDV/TdGa6cjSqSmBwiJkbBzr+4K9xtYNRBCzCw6LM5Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707649441; c=relaxed/simple;
	bh=xfaM7AJG2RZbzpPYr79GtszUzxyoPixJSU/WWb/tXQo=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=UtT8T1JnkWrmcToVtDWfC/CmFERNFTZfzgSpV5w78xD82D5ABjvwGke/2LpA1u7KjDYO6o5Qawcyb2wCxuwE0GP8yRmY4S9HyWQNwqpt2wR0n4WlGy3WusQPSffWcQkOZwYOUqLEbYLx0iacm+hPTKLeIkHztMpBbucoHsvr7tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eIby/kp0; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eIby/kp0"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-410cb93185dso744085e9.3
        for <git@vger.kernel.org>; Sun, 11 Feb 2024 03:03:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707649438; x=1708254238; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=r7iI73WC/9+tNU+i56dIjSmdmZo9Kd12oMbeArr4wnk=;
        b=eIby/kp0XlPCZC1+L+94RA+B5hpZvOIJOLDyjN3EDlndTV9klYc7pLXN85EjJIHjd9
         eGad0u6S1KX9u6RBsF16MP+oVA4Dd5pl/ZMeYo7u9DH7eHpINBrFO0t6wkBcZ1ggCZ9B
         BTJOp2MHR5LubN40ytqxncmwcGZdeAl2r3hVhOoLY0tHBv+l04oUbgwO3leVTqZ97TIj
         tyW/1naxpD+iHoOJVxZof9xVBPBdlDNstOLI6f30GTswGA+LtDooHF6+kxngqOCLz/eK
         jBq+jLBW6pVPPrnP94C7MD9G8zItr6WCpGn8v79QEmUGozTX1o1RFPbkftJ60JHM+Apy
         UMqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707649438; x=1708254238;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r7iI73WC/9+tNU+i56dIjSmdmZo9Kd12oMbeArr4wnk=;
        b=L7Sv0Y1tvB7SSSTNDTNrpviCZ7YFodBF8GamXYQXOJsgBCDxnBF/fuXrJ0lkz1IFCA
         b/jBXPyKRTnjm5RnaEEk02xrOzMzjm4e/WBMSXI3/6b7nSZQlAO8VeTR2vLuN11u2K30
         ELYCTY/BEUzWV6lxDYA8j7mKH6KucA+NMxsyMU8N+EwF5QAhvXZBj3hNgKp9y/sSY49f
         YvIMkbY9/e48suhpqmW9IrAuY2pH84jl2buJtUsF247a9XQqJjSaULJwzHRRKsu24OgO
         GvQ9Xp2BP+7k1rUHL6ouKXAPqs6UGR8X2SSz3fi3qSES+E668/2TakGMj4FL/BwbxLId
         4CJw==
X-Forwarded-Encrypted: i=1; AJvYcCXh+CZl9mPWa8pLX1boZ8gc5PuVHNWau2Ju8zDyi5p5G6X6JihIPwIDRs0PAfMQn7ic4wJGtq9dSOFHLgeT9+uwDXbM
X-Gm-Message-State: AOJu0Yzh9pP4XUOzAPaft2eAjXYJfhqzaEivUpz31kLsx8PUKqnkl6Z+
	h6ilSneJx5wbh/OVJbdzNdMBwix9CfBHH1xvpiCmoPQGY1JN1BOseyoLEcGd
X-Google-Smtp-Source: AGHT+IEc48asqilvJlDrpvL2RhMZZEtmcwpVxKiwykx8qrEEA52ju+YC3ZfCp2Rd/2kG4fwBN6Kd5w==
X-Received: by 2002:a5d:46c4:0:b0:33b:4d5e:ace4 with SMTP id g4-20020a5d46c4000000b0033b4d5eace4mr3027015wrs.36.1707649437573;
        Sun, 11 Feb 2024 03:03:57 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWcm+Qf+s+O6sC8N+xhYSuVH/zHKYYkyS96zZQ9HL+1gKt7PI+HbEusiRmwECtiJGIlDTSCuQL/my9qLs6hr3E9xjdns01VZ1P/CQWYAoocbTc9yCfM+/ugmmIk
Received: from ?IPV6:2a0a:ef40:62e:a901:386f:d8d1:628a:e68d? ([2a0a:ef40:62e:a901:386f:d8d1:628a:e68d])
        by smtp.gmail.com with ESMTPSA id n9-20020adfe789000000b0033b35da3842sm4017702wrm.28.2024.02.11.03.03.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Feb 2024 03:03:57 -0800 (PST)
Message-ID: <6872b42d-8763-44dc-9502-2362d1ed80a7@gmail.com>
Date: Sun, 11 Feb 2024 11:03:55 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] unit-tests: do show relative file paths on non-Windows,
 too
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
 "Randall S. Becker" <rsbecker@nexbridge.com>
References: <xmqqttmf9y46.fsf@gitster.g>
In-Reply-To: <xmqqttmf9y46.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Junio

On 11/02/2024 08:57, Junio C Hamano wrote:
> There are compilers other than Visual C that want to show absolute
> paths.  Generalize the helper introduced by a2c5e294 (unit-tests: do
> show relative file paths, 2023-09-25) so that it can also work with
> a path that uses slash as the directory separator, and becomes
> almost no-op once one-time preparation finds out that we are using a
> compiler that already gives relative paths.  Incidentally, this also
> should do the right thing on Windows with a compiler that shows
> relative paths but with backslash as the directory separator (if
> such a thing exists and is used to build git).
> 
> Reported-by: Randall S. Becker <rsbecker@nexbridge.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> 
>   * Another change I made, which is not described in the proposed
>     commit log message, is that we now use fspathcmp() instead of
>     strcmp() to precompute the prefix length using a known needle[]
>     string, to be consistent with the runtime check done for each and
>     every path.
> 
>     This is a belated follow-up on <f0b804129e8a21449cbb6f346473d3570182ddfa.1695640837.git.gitgitgadget@gmail.com>

Thanks for putting this together - I was about to sit down and write 
something similar when I saw your patch. I've left one comment below but 
I don't think it is worth a re-roll, this looks good to me.

> +		/*
> +		 * prefix_len == 0 if the compiler gives paths relative
> +		 * to the root of the working tree.  Otherwise, we want
> +		 * to see that we did find the needle[] at a directory
> +		 * boundary.
> +		 */
> +		if (fspathcmp(needle, prefix + prefix_len) ||
> +		    (prefix_len &&
> +		     prefix[prefix_len - 1] != '/' &&
> +		     prefix[prefix_len - 1] != '\\'))

We know which separator we're expecting so we could replace  the last 
two comparisons with

		prefix[prefix_len -1] != needle[1]

but as I say I'm not sure that is worth re-rolling for

Best Wishes

Phillip
