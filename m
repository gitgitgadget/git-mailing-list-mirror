Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8532192F9
	for <git@vger.kernel.org>; Tue, 25 Aug 2026 10:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787653819; cv=none; b=pytzVrnbog6Xkyk9VasEMwEUFdOCuEKgBsbzlhcroFKjAc6Bwp8YoE1xn4P4OYovarHgmtVJUi4kmfJj4ewqpJ4Bit1oM1aCqgF/LyOu2HgBkJB12J5azoUqjorpIxwxP9vMn1G3kOMTtmRQqJ3YhxiFm+ePqt3KBQxlr4bQe20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787653819; c=relaxed/simple;
	bh=KBXF/8hb0bmQPD6Nl2emRWagxnfNc1Af9+cXcHSS/is=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lbIPsVSpoTyP40HjDnKiwwg7C9h7/HPRZBbhvc1VAUZh8AE3PKOrfvAMYlV38ZZ/c4sGzdHP3g9pgvezls4xRSMresI5TflBMBPFM6+1C4fqNTOXB1jaY70vNvQU01xPYHRiXej2Rj1GEwi9xME6H1fKDukRviKtpRjvPSz30FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=B8xzRv/h; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hLA6Qa6/; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="B8xzRv/h";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hLA6Qa6/"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id D4ACFEC0177;
	Tue, 25 Aug 2026 06:30:15 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Tue, 25 Aug 2026 06:30:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1787653815; x=1787740215; bh=Qgs6+bFiF2
	CCq1DNkhiH3SqbR3s7pque/OP5EMzZQyo=; b=B8xzRv/h9bMeg3EwK6PIA2nvxw
	6BN/wC+oKUtzjfsNH7QNNO8/VXehfGF1oY7v2LwWtm+t/V2sQYvnhHDu/1jkoSQ4
	hcQFvkyCqVV1ROYkZ2XmX66F2ypymty4UcYtGNK557nlLoO7VEqZmtGFvkD7GXcX
	p/Hk/vkNs6PRVLOne/6RQD1hyOb4Gaj+X94JTg48yDBr2JT71NT5k+XJjR1ljTeQ
	ENL1UWZmCwx+gQlTv6tj8tqnwP8Q/UDtsNqOmS3ligo7l3gCnqF6JsKbDFD7NZQs
	jbJz2is2e52faWvYN8UGQ4t/S0KwxOWYikclhPLmX6w0cQiXEYYPPJwoPUfw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787653815; x=1787740215; bh=Qgs6+bFiF2CCq1DNkhiH3SqbR3s7pque/OP
	5EMzZQyo=; b=hLA6Qa6/Vb32ldl1iz+mW6D78+5VDMlqwei8o/p+V0gbdfTK2G/
	RzIp1UXem70BEbixWrCEA0iDb1+NkehppED8PXodK3fTMLWsk6NbIwwWShnGdzvE
	kjPdewAXjtMnN6e77EdXsguDuuZAFeTzLdjmHS1FqGlEsnIIq5g6R4BL2d6y4jJ9
	4WbkQ+1bqC7ue2C2UEYfoEN66pKx8gupC3MD38WdcYzdt7VQ/cQf0dHIaPh+MABg
	w3NKsJ3+oK2mh7K67OPKYkJcZBv2NCBZxnd6n05BJDNhsCCKfQx48WUCFqFIIDgg
	cSU5WsvJ4Hw2zE4Ss4upPGHGrzDrcRszjFA==
X-ME-Sender: <xms:t26Nai46jGdqw9mPszYEDmeM3m3mPuUj0XxmwdzpWi6tAB9Sj6n_gg>
    <xme:t26Nai7akPwWVqHvYyJeWvHGEgEpLVrIrWsseqKIvKWGBeMBLwf3dsvBwlvMcyqLR
    6LYFP0GyNdXEaiOW_tgNun40n87yPPEh2LNcE8dwTUq0IRVAtApAw>
X-ME-Received: <xmr:t26NamdHBCImAdv-SIIQ6kqhzfHC_09j8UHS1T7J57uZ-JPQi-61luSp6S308yobBhdpCgybHx-SQuHaSUPWWbZYnuOovIAJbg62aZurtw>
X-ME-Proxy-Cause: dmFkZTFmfgYJ4/BYJYIodLscQQAnkjXJaA02IiJJTKl51ueum2C6c45owdv22PM8xVCony
    tWEvgSWU4IndcLsmEfgVbdE3nrImVf5i+x0mzRYJFUnBZ5RAM2x1dC8znYOE4yFwbm4r2D
    8y7uw8OnArOJ17o4FzvC3rcR3pwQ4VhgNeqyMWCaxbgkz4JcP9tw1n4//e0lzz7fxM3635
    Rdc558C9VX7awJb9lsgaEUyUPhYNlXs7m6arjobsD8zSde8uhCBtQvS0XDO7R2R03KMySV
    31J3sWwMH398eh2AMEmhT6i5+r1U5NO0uXV5dBA5bXfHpG8lsFYCnNBZnLW1GtTIosuAn9
    CtkXbQ/6TH5EDWcT7+9sKqiuLMiUTRbkTwAJqQu+bAzfGPY1vnuwTVL9ivgy7bJMpqZ0iy
    PWSH17RNWLnFfMT+dY6l2XlORySWv6XIpBhrCix7PENhYZD3kozEw/HRMu0n7bZHgKBzzs
    dMN6sH6zp8eh6mUOEmW+IshtoHIFiRYyp96NW0xXes5wvcbGavHJf0z7r5aEOXOR9/EYPw
    Zm9dbQ4UiqczWLIrCUXU7B1hkhl0W11tXyOaEUAUFle884zXvXAcvqhDTNw0ClJc0xkJ+Z
    HiA+GhdGFfiizgQF0Es+MHGNkWGuA8XXYp5U046JRVJXHUqhr73F515pm8Ig
X-ME-Proxy: <xmx:t26NauD-DFKgoloH9nbFNgtuEgK5AH0XL_N8lnAwbebL5x-nKAgqDA>
    <xmx:t26Nah_7RoBznKL4Uk8aCBCfJRYwFMSczqKqqEl-NwwnIjIxYy7GaA>
    <xmx:t26NahIUARVkUUZ6hywf8yoXAGHRihVJY7W9Bq7uKy69Z_OlKLDpwQ>
    <xmx:t26NaijLAI64RuIay4Z2NsrW-myam59yge2dn6K_B0LoawCvXJ7z3A>
    <xmx:t26Nal8UPTxzAE06bXbbVFTCziNJUSv96YNWv1GWCxrJ19q0AFg9BRsu>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Aug 2026 06:30:14 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id fb4b8afa (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 25 Aug 2026 10:30:11 +0000 (UTC)
Date: Tue, 25 Aug 2026 12:30:02 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, jltobler@gmail.com
Subject: Re: [PATCH v2 3/4] reftable/stack: move list lock to `struct
 reftable_stack`
Message-ID: <ao1uqpCxFHlOyTV-@pks.im>
References: <20260824-740-optimize-reloading-the-reftable-stack-v2-0-9c9de2eb0af7@gmail.com>
 <20260824-740-optimize-reloading-the-reftable-stack-v2-3-9c9de2eb0af7@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260824-740-optimize-reloading-the-reftable-stack-v2-3-9c9de2eb0af7@gmail.com>

On Mon, Aug 24, 2026 at 11:31:01AM +0200, Karthik Nayak wrote:
> diff --git a/reftable/stack.c b/reftable/stack.c
> index 703548417c..c3d4deff29 100644
> --- a/reftable/stack.c
> +++ b/reftable/stack.c
> @@ -628,10 +630,16 @@ int reftable_stack_reload(struct reftable_stack *st)
>  }
>  
>  struct reftable_addition {
> -	struct reftable_flock tables_list_lock;
>  	struct reftable_stack *stack;
>  	struct reftable_write_options opts;
>  
> +	/*
> +	 * While the list lock is acquired on the stack, we need to distinguish
> +	 * which 'reftable_addition' is responsible for the lock. This avoids
> +	 * clearing the lock of another 'reftable_addition'.
> +	 */
> +	unsigned int locked : 1;
> +
>  	char **new_tables;
>  	size_t new_tables_len, new_tables_cap;
>  	uint64_t next_update_index;

This feels somewhat fragile, as tracking state via a bit is very easy to
get wrong. I would have preferred a solution where we didn't have to
have this field and instead a more direct proxy. But there's not that
many spots where we have to do this, so this may be okay-ish.

Other than that this series looks good to me, thanks!

Patrick
