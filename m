Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B7116EB6A
	for <git@vger.kernel.org>; Fri, 12 Jul 2024 13:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720790787; cv=none; b=iom+YrAbd93n0DtsNMGf3e+sRq13I8XzywuqrE25zuh7a6qtH5dxZS60eMm+/G9XKGVT07XaRWloNGj+2+5ZJ3gSFKxwOa0tF2ot46m7VQRoIXXNQZUdPcJJ1+11XYx7v0/n38a3vbHbB7AQafLYqMz+N6VYyqJSFfRrmVzekmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720790787; c=relaxed/simple;
	bh=X3F4qP2p4sS0OJuc6hKKFL/4tq1x/14mf7+IMbMHOfQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LEBi/kkKoYFdrpnRA5htb2nwdamDmQ0SvKZvNDpqhCHYj9snUMIyxaRMgf+I/kVFR7VXi2lKp1EbvDw/Ys6xb52GO9ZLvTp4vqM8IWWQvrmfFMyiVNszNRoFUoDH2puPfNHpbfQbsebh20102Heq+/zgOgHGPNe9TRctsuWGda4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hs7lodE4; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hs7lodE4"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42797bcfc77so13624295e9.2
        for <git@vger.kernel.org>; Fri, 12 Jul 2024 06:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720790784; x=1721395584; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Ff6NEumjC2t4m1hjHFkIijkoJPlnLLATlW0Wn9lnmYs=;
        b=Hs7lodE4UPPeefTYQRc3YQzidkFbudqHQioYYSNhM7lo1guxDsP6UA3plMU4w4ogKs
         M4AsZ2rBFhZDXhEuRqTjpf3Dm85NBky5X2JVAvk6Q9BVOT4fD2Ztm4RQ2+wKv6ghPDBK
         Ls0Tix5F0e0P+NnU400gmaPXLGOWYD/PYiJX6MboQ0s452AXazB8OjPKMJrVgieSC99a
         kwzHxUO2jMAIouxrkRomDjmfNAb6lsDbzzUMrYwFvWJ3KuwrJbZ6Q5+FNjunjqWEllJh
         yk/AlxilmfK9FV9QvYHw8Cmua7w8FBMb+iiMm1zco/wuMNp0hiAXIjy+yu1ppH/D+ShR
         XSHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720790784; x=1721395584;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ff6NEumjC2t4m1hjHFkIijkoJPlnLLATlW0Wn9lnmYs=;
        b=FUQDSdPZBVcUY4U//9M3dbZOSkzGKW+27ABGUt2A8950oiG48fxzQ6fGjfJ8+TGLiY
         jsQaePODqhNt5k7tlLDjVkOsFlvfYTIGjgCoNNK2NfPJf7hmZren59K4tI1Mu4iJy2Xp
         KLsnv4z0VpxvOjZsm6B5koRvqKlgW423LBr6LqVCRmFgvgb6BRjifUl2jSgSIHU7i7/i
         fEqDCwacMZmaYbVNLaXRDnNfwg2hG5mIgKxLI3vnrFzWCI9CCnEUfxTNL7z+tkRMpC2s
         1UA02aekr0rB08u1mrdwIanmXZYMQj1WwDL9YIIJCda6Oi/QKw/V9ufpSX4LZ8HNEpuO
         1tEw==
X-Forwarded-Encrypted: i=1; AJvYcCW4pxge9fCCnTezxgVYRj09DvEiNYm2xg/UNKONqI7IdagWgQ6DW5H7o1h7ZrlZ3SSnFXr/SkmWEUf5ZHLEVc8/pqSP
X-Gm-Message-State: AOJu0YzOsy02aQ/fU/h2np2/TWj+2Kg7bx+pkl4kq4s3V45UqUbT5fZG
	GQpiwYrOaQn6X33Un8fbDrEmxR46vLpBszfu+H1+F4HuTFW7MNHO
X-Google-Smtp-Source: AGHT+IEVSbbBi73EDoxyAiZsXxPEPAEcnGIi+1IVdfy3eSk9cU1Frfdc/AZwfc570y951XhjNorjVQ==
X-Received: by 2002:a05:600c:2207:b0:426:5b3b:88b0 with SMTP id 5b1f17b1804b1-426707db78fmr70416575e9.14.1720790783958;
        Fri, 12 Jul 2024 06:26:23 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:600:8501:d2c6:37ff:fef6:7b1? ([2a0a:ef40:600:8501:d2c6:37ff:fef6:7b1])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4279f2ba4aasm25094585e9.35.2024.07.12.06.26.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jul 2024 06:26:23 -0700 (PDT)
Message-ID: <803b10ed-1cb3-4314-82c9-cf48d5d0bb90@gmail.com>
Date: Fri, 12 Jul 2024 14:26:22 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 4/4] add-patch: render hunks through the pager
To: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>,
 Git List <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Dragan Simic <dsimic@manjaro.org>,
 Jeff King <peff@peff.net>, Phillip Wood <phillip.wood@dunelm.org.uk>
References: <2653fb37-c8a8-49b1-a804-4be6654a2cad@gmail.com>
 <5effca4d-536c-4e51-a024-5f1e90583176@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <5effca4d-536c-4e51-a024-5f1e90583176@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Rubén

On 12/07/2024 02:00, Rubén Justo wrote:
> Make the print command to trigger the pager when invoked using a capital

s/to//

> 'P', to make it easier for the user to review long hunks.
> 
> Signed-off-by: Rubén Justo <rjusto@gmail.com>

Thanks for working on this. The code changes all look good, I'm a bit 
confused by this test though

> +test_expect_success TTY 'P does not break if pager ends unexpectly' '
> +	test_when_finished "rm -f huge_file; git reset" &&
> +	printf "%2500000s" Y >huge_file &&
> +	git add -N huge_file &&
> +	cat >expect <<-EOF &&
> +	<GREEN>+<RESET><GREEN>22<RESET>
> +	<GREEN>+<RESET><GREEN>23<RESET>
> +	<GREEN>+<RESET><GREEN>24<RESET>
> +	 30<RESET>
> +	 40<RESET>
> +	 50<RESET>
> +	<BOLD;BLUE>(1/1) Stage this hunk [y,n,q,a,d,s,e,p,?]? <RESET>
> +	EOF
> +	test_write_lines P |
> +	(
> +		GIT_PAGER="head -1" &&
> +		export GIT_PAGER &&
> +		test_terminal git add -p >actual
> +	) &&
> +	tail -n 7 <actual | test_decode_color >actual.trimmed &&
> +	test_cmp expect actual.trimmed
> +'

What is huge_file doing and what happens to the single line of pager output?

Thanks

Phillip

>   test_expect_success 'split hunk "add -p (edit)"' '
>   	# Split, say Edit and do nothing.  Then:
>   	#

