Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A2612BF1C
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 16:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711384744; cv=none; b=R39esk+Rwfg3zDO5IijYATs44WoFkh1c20wWu+8nk+cXEEM+WrqQu5FPB+sXmaOYqiIKc1GoGHzbKz2ebtEP+rI8o7YK0I0kK9CFdF9/1m3VlL5yCEK2XPEVUOWYRBDsJzWIpqSnAWaxbXy/tI4S5fZaGJIRdfODJuevVMSPJcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711384744; c=relaxed/simple;
	bh=4Xfsxjo6Ske2mFCJ2Ba5pX71N/8uhkxCsgVL+llcvTY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=CkMPbam82s+dOkCeN0o0GXKqPR8h1EfohIdgKmV78tgMhyHNdxXYSF1RyjDvgvRUMskhd1mE+P5SWjN3BZ34hcNCf7DyVWvanMNRq5KzKOwfHEL32V2DIAdJDKv5elgXV/e2D1AZw0VkSMHkmFlz2X1Jgs8Kl7FXQ50+n8Cj5+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rmv0MpIc; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rmv0MpIc"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a4a39ab1a10so141729166b.1
        for <git@vger.kernel.org>; Mon, 25 Mar 2024 09:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711384741; x=1711989541; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:cc:from:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8Zob7iFRetCRwmZ4tSSbSPtsIyLqgbownxr00j7pMEE=;
        b=Rmv0MpIcvgedxSsIdihmHhirCqL3Qx9wsoa6yHa40sv0WAv4mvYhi8AUNmwZyT2prW
         UrwfmcMIbbUwXSqoJjnetM5+acYWT50MLiJvnxGLyy3NZVM3qZ3PUvSloGfIZ5f/e4hj
         RKWOsZxsrpaFrjf2OeWboWExikWjjS8HTAKyjlYnM/1C72vFXOjZWtbVEq03YDuy+NNB
         9nzpRb/9o+8a5CzSJgWw35OQqY/6MsyzbbaeXVUSG/vDiO6ZFrl6rYuPR1saZsHChogU
         6j3WEAfcupLAtHggl15Px2dGU3Km4tlrH0cjlQ4lWNz7u6yAHXLQxGE6u1iJIhq8bK3o
         27WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711384741; x=1711989541;
        h=content-transfer-encoding:in-reply-to:cc:from:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8Zob7iFRetCRwmZ4tSSbSPtsIyLqgbownxr00j7pMEE=;
        b=t3GH79QO+gsDi25tJSWH/S2NOsZj++U9d05hlgqMLWXtGP7oLPX09+6fdof5TdDP/A
         ytcNSEwyWoCbmhzXhdZKDOZrEcvSFe1rG8lUuDNXrhEr7tZUyvRByEHCC+iBvxtJcQHj
         xPchPCEAQIerqwp+f0QtvXGBzKQjH09R/q1X15/uxh5h4Cuey23zfhyJonK79u6RhNNw
         vmPnbH45CzqXQ1+81BpahDjfdYnSxvv2SQ4tX+2geUWmO150gTy6GJIBz9YpasNTQ96s
         3kQ18VUI5VKq19Z03dEyPrs1dQgYgLvbIxY50YBXjSm8ZzQAU2MDDP5KyROPBUZZ5IRF
         zjuA==
X-Forwarded-Encrypted: i=1; AJvYcCVG1+YKqXu3lJAQOooGvA6f+bcczlhu5mScLOtlxKaCjXfJ/mLcFl0QM0cv3URZ+ioxD5SAycJ02VORTLYcLPgAEqZi
X-Gm-Message-State: AOJu0YxuvzAA8Kl0Dmu6MXFyRBEzuJPjgPsbhJOt7nPwDoloB6le+1v4
	d3cWbh212Tcf+6mrHXKFssC2AFY7tC2mdaxpi+8ehCEbotGAxw1H
X-Google-Smtp-Source: AGHT+IF/D1+Hv+hw0Am9c5kaG1ExiQ+THP7YfRFY38FqwOyiTiHZjqOwbFeaDCJ+TdQ2DX+2Af6WFA==
X-Received: by 2002:a17:907:26cb:b0:a48:45e7:5d46 with SMTP id bp11-20020a17090726cb00b00a4845e75d46mr3273563ejc.22.1711384741062;
        Mon, 25 Mar 2024 09:39:01 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:68c:c401:12ba:addc:3daa:a3e? ([2a0a:ef40:68c:c401:12ba:addc:3daa:a3e])
        by smtp.gmail.com with ESMTPSA id l12-20020a1709062a8c00b00a45f39b2d16sm3220130eje.200.2024.03.25.09.39.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Mar 2024 09:39:00 -0700 (PDT)
Message-ID: <16e7bca8-2701-4b33-a7c1-32e0e859e2cc@gmail.com>
Date: Mon, 25 Mar 2024 16:39:00 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: What's cooking in git.git (Mar 2024, #07; Fri, 22)
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqedc1zs1p.fsf@gitster.g>
From: Phillip Wood <phillip.wood123@gmail.com>
Cc: Brian Lyles <brianmlyles@gmail.com>
In-Reply-To: <xmqqedc1zs1p.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Junio

On 23/03/2024 00:54, Junio C Hamano wrote:
> * bl/cherry-pick-empty (2024-03-20) 7 commits
>   - cherry-pick: add `--empty` for more robust redundant commit handling
>   - cherry-pick: enforce `--keep-redundant-commits` incompatibility
>   - sequencer: do not require `allow_empty` for redundant commit options
>   - sequencer: handle unborn branch with `--allow-empty`
>   - rebase: update `--empty=ask` to `--empty=stop`
>   - docs: clean up `--empty` formatting in git-rebase(1) and git-am (1)
>   - docs: address inaccurate `--empty` default with `--exec`
> 
>   Allow git-cherry-pick(1) to automatically drop redundant commits via
>   a new `--empty` option, similar to the `--empty` options for
>   git-rebase(1) and git-am(1). Includes a soft deprecation of
>   `--keep-redundant-commits` as well as some related docs changes and
>   sequencer code cleanup.
> 
>   Will merge to 'next'?

The latest version looks fine to me apart from a couple of rather long 
lines, I'd be happy to see it merged as is if you're happy with it.

Best Wishes

Phillip
