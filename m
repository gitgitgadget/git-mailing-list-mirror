Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285E14087C
	for <git@vger.kernel.org>; Mon, 22 Jul 2024 22:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721685615; cv=none; b=SVCjS6YWf43evRc6ZAsec/f/LCkRd8D+EioHr++jL48kQe83snPUmMv6SN9xD2iVJ6Vgygf6zWnKnmqFyVWTvXYF/lv7JpsyPenXvvVlQLOZfu/vIw1kHnEHNiKG64sni0N3G2godQUMxhwm/oowif4ENFJNhHm9cqCl6+9moek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721685615; c=relaxed/simple;
	bh=atXQsER/pf+ftph2jtcsSkvCP/u1FK09zk9ZxXfGUr4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LDlyhskY2RKXt6YMam8HdhK/WuJGuxBAJ2O+MBPFp2xRs6Qlqn8PSYF2XSN4CUyVL9xk1fFG48RmSoBkx6DTATCX/Eu4XW25eb4pGij+qeyYZGivTPbGutnNuIBvhGM7q46xxOQoFZvT4zk46y3amk+1NmtJZbV+DK3O7H0uxEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FskUEGeQ; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FskUEGeQ"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4266ea6a412so34638315e9.1
        for <git@vger.kernel.org>; Mon, 22 Jul 2024 15:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721685612; x=1722290412; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6F5gW6x/9YtWZgJBTh3DAXIXDw78SM6NJ++IljO1tyE=;
        b=FskUEGeQ25+LdYV5+Vpltxe7/Qv1GwII25HGhWcnRQXUen7dNmDsyYJVn9000FnqrF
         jEGHmfouWM/gWlD0mUwVl98aeH5/J1GERMmw2UCiNvf2GD5/HFcP2t2Um8ytCrTx13vb
         O2kTEqB8ff90wXJ6zbEvbLHolja2T5cg4VZfqdFaEANhALLBw6B1YGvER6WbtN+QRmfH
         I/QsPh6gJKcl1Ii3HlhlLR/8B7OBlRyb12CoS5Lgq010uNELBI1jRmsMWoiJBXJ2phmp
         tGWm7T2J54D9pzSYfVB5b1jy/PJi/g4dLSR8c4I2FGeXTjIXzV20LEFdAsmxNPkmwmm4
         nmhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721685612; x=1722290412;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6F5gW6x/9YtWZgJBTh3DAXIXDw78SM6NJ++IljO1tyE=;
        b=reaHQt0qdUGVqMFe8UgoSEJ6MjO6hiuauGeMdY7GNm0V9GsWMFcm+7p31FpOr636YR
         pbuSzcP9YJjgbrYdNoGsuJNGvtvqiqcPKPJUj3EGE3p39DnmLsa8JSbNYEEP2lFuU20S
         MBL9CJ+gNwaun2HGaN/k0ZP0tm5wD5Lg6hsTGqfN551g4rhGc1bxpfKHUJHGstKywyls
         tM/u3PCCYPlIJpWrZ8qJOu3//lFvmE/vumEdKItJ2KMDJZj988grHJ1D4nYtji8yKDhz
         Jrq9cukG+aaYlS2xQjqAVrbH2UF3MUOKVd08nGA1OZmhlkYLuVNM6WXF+l4hE1GuFsTC
         z9fQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZtNTX+aQgcnCWtVkVH2bnId3b+bF/H/L9QJ4F0dcLikaD/FjZiPF7ahNZsgMnmJzpoI5A1IOCk6+KxBH9bvCv0GnN
X-Gm-Message-State: AOJu0YwGhOYbR0bOHd/zWtC/jyRm/HovozKvuzrE0BA30401SlQ0FcrY
	0LMpnacMcyivcBX+qWjrlbPLQDb6GkZadBBcYrqIRkEkpo6qwTZA
X-Google-Smtp-Source: AGHT+IGlcRAfT2b8gzISYuGXxCqhF3IUNXVAdZUhBWy3ElIXk0GclZ1Kt7p5o6f8roVOZ3MFv03y9A==
X-Received: by 2002:a5d:6b02:0:b0:368:420e:b790 with SMTP id ffacd0b85a97d-369debf8ba2mr660940f8f.14.1721685612229;
        Mon, 22 Jul 2024 15:00:12 -0700 (PDT)
Received: from gmail.com (89.red-88-14-41.dynamicip.rima-tde.net. [88.14.41.89])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-368786949f5sm9614788f8f.57.2024.07.22.15.00.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jul 2024 15:00:11 -0700 (PDT)
Message-ID: <0385c0cc-fb3e-4d12-9655-a409aea22c38@gmail.com>
Date: Tue, 23 Jul 2024 00:00:10 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Re* [PATCH v3 4/4] add-patch: render hunks through the pager
To: Junio C Hamano <gitster@pobox.com>
Cc: phillip.wood@dunelm.org.uk, Kyle Lippincott <spectral@google.com>,
 Git List <git@vger.kernel.org>, Dragan Simic <dsimic@manjaro.org>,
 Jeff King <peff@peff.net>
References: <2653fb37-c8a8-49b1-a804-4be6654a2cad@gmail.com>
 <ebcba08f-3fbb-4130-93eb-d0e62bfe0a8a@gmail.com>
 <efa98aec-f117-4cfe-a7c2-e8c0adbdb399@gmail.com>
 <1dc9ebad-768b-4c1a-8a58-8a7a5d24d49e@gmail.com> <xmqqttgqyzwa.fsf@gitster.g>
 <2b57479c-29c8-4a6e-b7b0-1309395cfbd9@gmail.com>
 <88f9256e-04ba-4799-8048-406863054106@gmail.com>
 <a2ea00e2-08e4-4e6b-b81c-ef3ba02b4b1f@gmail.com> <xmqqv80xcpe5.fsf@gitster.g>
 <079901fe-7889-4e1f-bb91-610e1eae25d3@gmail.com> <xmqqa5i9b51m.fsf@gitster.g>
 <xmqqbk2p9lwi.fsf_-_@gitster.g>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
Content-Language: en-US
In-Reply-To: <xmqqbk2p9lwi.fsf_-_@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, Jul 22, 2024 at 02:06:37PM -0700, Junio C Hamano wrote:

> So we have an answer:
> 
>   https://github.com/git/git/actions/runs/10047627546/job/27769808515
> 
> tells us that the problematic shell is used in the job.
> 
> It is
> 
> ii  dash           0.5.10.2-6     amd64        POSIX-compliant shell
> 
> running on Ubuntu 20.04 that is "too POSIXly correct"[*] and behaves
> differently from what the tests expect.
> 
> Somebody should write this combination down somewhere in the
> documentation so that we can answer (better yet, we do not have to
> answer) when somebody wonders if we know of a version of shell that
> refuses to do an one-shot export for shell functions as we naïvely
> expect.
> 
> 
> [Reference]
> 
>  * https://lore.kernel.org/git/4B5027B8.2090507@viscovery.net/
> 
> 
> ----- >8 --------- >8 --------- >8 --------- >8 ----
> CodingGuidelines: give an example shell that "fails" "VAR=VAL shell_func"
> 
> Over the years, we accumulated the community wisdom to avoid the
> common "one-short export" construct for shell functions, but seem to
> have lost on which exact platform it is known to fail.  Now during
> an investigation on a breakage for a recent topic, let's document
> one example of failing shell.
> 
> This does *not* mean that we can freely start using the construct
> once Ubuntu 20.04 is retired.  But it does mean that we cannot use
> the construct until Ubuntu 20.04 is fully retired from the machines
> that matter.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  Documentation/CodingGuidelines | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git c/Documentation/CodingGuidelines w/Documentation/CodingGuidelines
> index 1d92b2da03..a3ecb4ac5a 100644
> --- c/Documentation/CodingGuidelines
> +++ w/Documentation/CodingGuidelines
> @@ -204,6 +204,29 @@ For shell scripts specifically (not exhaustive):
>  	local variable="$value"
>  	local variable="$(command args)"
>  
> + - The common construct
> +
> +	VAR=VAL command args
> +
> +   to temporarily set and export environment variable VAR only while
> +   "command args" is running is handy, but some versions of dash (like
> +   0.5.10.2-6 found on Ubuntu 20.04) makes a temporary assignment
> +   without exporting the variable, when command is *not* an external
> +   command.  We often have to resort to subshell with explicit export,
> +   i.e.
> +
> +	(incorrect)
> +	VAR=VAL func args
> +
> +	(correct)
> +	(
> +		VAR=VAL && export VAR &&
> +		func args

Just a small comment; maybe it's worth adding an extra line to make the
example clearer:  

		VAR=VAL &&
		export VAR &&
		func args

> +	)
> +
> +   but be careful that the effect "func" makes to the variables in the
> +   current shell will be lost across the subshell boundary.
> +
>   - Use octal escape sequences (e.g. "\302\242"), not hexadecimal (e.g.
>     "\xc2\xa2") in printf format strings, since hexadecimal escape
>     sequences are not portable.

Thank you for digging into the test to find an explanation and for
adding the comment to the documentation.
