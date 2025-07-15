Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874542D5406
	for <git@vger.kernel.org>; Tue, 15 Jul 2025 09:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752572671; cv=none; b=Fls8LWCWo6Kjz8a9g5OGLD6n+OfO9Oc+g9PXXPkEnMig/hTJVC7qhJTyRO0zk/BcJvRt9BgcFAGfFOXpmNGjSLa0dHczx0qLrwB1keD4xB9DfFjMnA7rWWqYvsgSqLjKNyOKZ2Rt9Xvzu8AIlEg2tP2lwR3sMhYg4WUNpWEDoKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752572671; c=relaxed/simple;
	bh=oXWpBWlX6iULjtDBjtjwiHMVbAKTrWj7OLDcbMb6Jfk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gtmiBRcBFfWmJrmxQzzND2pBTj2bJ0g8X59PmRCeNgFvieVkQ8LPFunqU2uf6aNCK53JIuDlnWdiykLemu44ECtNKVgWbpQ4nujXovMtEGMvKhvrhyj0k3aCx62P/ErhlDDPwzPdrD2oDE53EUebaCsWefUrh3VMzopqaEY13nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bOErdBkW; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bOErdBkW"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-451d54214adso35110635e9.3
        for <git@vger.kernel.org>; Tue, 15 Jul 2025 02:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752572665; x=1753177465; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=EXpqIm6N9ec6PD05u8iIs8G2FagGKux+sAqgrJ4j0L0=;
        b=bOErdBkW8ZjbSSF34rAhJJPe9bYpkRn6DjrbqFxjzNlsgncOTXOEgSjqPwVffEj7gz
         /mq61rKa/UnpYU2hXyiDPk7YBcnzNa/+9nqyFCnVU9jmOjovNLUwUX+O0oEKyUsW8Qch
         yftRadwKa5Kp/SaIh3aukMnXHVPqyH+oDrtEj6L6gID8QxlKKrzVFvLpKI5gInpezL6z
         1b98XaTei1UjylIecDY/t7gaURjV6lOZG6ThS4awgzS6pg44ujVLNKpFWaJfYfDUeFIh
         MPITCI++BWcFX94U3ASSOIeHgYMJ5oNo4AxiN45j4icMfQkDCAz+FxaJdrbeSw5PHPmE
         WplA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752572665; x=1753177465;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EXpqIm6N9ec6PD05u8iIs8G2FagGKux+sAqgrJ4j0L0=;
        b=AP7z1MbCNX7rXK5YfbPLWj0vLxlUo6mEpYlZ5cRxnkmJafMYPFP7oXPYO/UQh1dzZR
         3+Sq29cscxo9pMUJ2XrD4QOr6t1r+kPdnNo/kJfp+r1JkCsnpkHhEuRq2X32Mr6H00P6
         L4z+cVzpYffteGqqLKkl1DyXsFrC9jkCuNn9LdK+aPVAKBizFR+Ji/zzYau1Q7IeSs+E
         vgUYVjIKNW09Z4KXUv4N2Fc/w16hFTm5tLI3WrpB6UKSElDgkY5cYidzSdA6UYSWXEJb
         VS9a00pJLmSf9BkQvW3fOQjdoEloozCGV59GvJrs2fb5SSwVp4wtTzRSue5ChrwC9U2U
         0U9A==
X-Gm-Message-State: AOJu0YzAMxVozEKEypgq4pgPtK/3QnHFl1mfputOs7fE9qXL4n8pgG5A
	slJx2BxuNaj4BExepPN1GSks/44xa6JkHU02KMSDOFwnbWRtlCdxtV7H7eQDcg==
X-Gm-Gg: ASbGncvzf+Tp3HibPPmD1AziQyijSiHIWM2+A2zHET6W7hcUOHBO4Z3dCDtWPr1UtCg
	qn1tBK7UqCwBdV9U8/KK8MOVDNDJM8rgdU1U4v23eV6+oBMkCxhrlwaCSPrE4hi9fvYsgzNz833
	YSfisHtvqNyJNyf8l3roCXlwFtD7MvjtpZks5S546mnpc7Vvp2mKl1p9/RxdWgzH7igGtV008Q8
	Vv7QtsexiQTWJ6CCxYJ9l996LmXXRy9jdx7n+n+aMYHlyt7QdH4U9yl+d1aJXIysxFbP6eUPCDp
	HYreN935ObthYP7+keX/cQZ7dwSIyKCh2dtZHpfdFAjwXKmeK8RXPZzMk7pxaO8SmyiW5uAXxeR
	cnTnESeAfoZLyo75+HmAO5bEpWdGQ0sWh2RhUJT8R7R4cUkCZ+O1J9/4NTgzvOglY5UN5S++5WU
	fQ3rgvRoJLK8U=
X-Google-Smtp-Source: AGHT+IGAUX3XdhkgQHsTuPHv+YXZ9fwcwVKRm07QSR6ALdjTNY/EquI7elWkdlKE77gNOBwdOcoZVQ==
X-Received: by 2002:a5d:5e90:0:b0:3a5:5270:a52c with SMTP id ffacd0b85a97d-3b5f18168e9mr13123656f8f.0.1752572664546;
        Tue, 15 Jul 2025 02:44:24 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c? ([2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45617dc1fccsm66182865e9.5.2025.07.15.02.44.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 02:44:24 -0700 (PDT)
Message-ID: <fb14ecec-a169-4182-a474-42f8567f5537@gmail.com>
Date: Tue, 15 Jul 2025 10:44:20 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] strbuf: add compound literal test balloon
To: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
References: <7ac55a5096c261b706f47ca239c381f71db2b67a.1752499653.git.phillip.wood@dunelm.org.uk>
 <xmqqa556x2z4.fsf@gitster.g> <aHYXJ7EmRQE1P5xe@pks.im>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <aHYXJ7EmRQE1P5xe@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Patrick

On 15/07/2025 09:53, Patrick Steinhardt wrote:
> 
> We already have a two test balloons, both defined in
> "reftable/system.h":
> 
>      #define REFTABLE_FLOCK_INIT ((struct reftable_flock){ .fd = -1, })
> 
>      #define REFTABLE_TMPFILE_INIT ((struct reftable_tmpfile) { .fd = -1, })
> 
> Both of those are getting used in a way that'd break if those weren't
> properly supported in "reftable/stack.c":
> 
> 	for (i = 0; i < last - first + 1; i++)
> 		table_locks[i] = REFTABLE_FLOCK_INIT;
> 
> 	tab_file = REFTABLE_TMPFILE_INIT;
> 
> Those are rather recent additions though, released with Git 2.50. I also
> totally missed that we didn't have any test balloons for this syntax.
> Should we maybe retroactively mark them as test balloons instead of
> converting and marking some new sites?

It would definitely be worth marking them as test balloons. So long as 
it is not possible to build git without the reftable library then they 
should suffice without adding any more. I think it would be worth adding 
a section to CodingGuildlines.adoc about the balloons we current have as 
well (I didn't add that here as I wanted to wait until we knew the 
commit id that introduced the balloon).

Thanks

Phillip

