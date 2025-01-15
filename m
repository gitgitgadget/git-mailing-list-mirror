Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D64213A865
	for <git@vger.kernel.org>; Wed, 15 Jan 2025 14:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736952548; cv=none; b=Z+J6PDEqC9JP14BkEbBUxcX2a2ki9xQ2gduW9vtCR5Sa4Zbrs6Zr47DcePgxXIgt3FyGx6jHf5dJrZum43ZUWDaoiVhPBWmCoR6ITZ79bb2GdlVbtjUIZM4jk0IL02oqXap3QN9aUBMO7bLhHnTQkz96cbubCISLywQb/d/eig8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736952548; c=relaxed/simple;
	bh=6P8h0NWNbjIzLlVgFwy7A82KPYdfBeXc1m/CvrpagoQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HhlSXRoNCIbwX89s7zyp57To5i+lOp0TrqmLDSWRY1dAJMc6+uMGYrPlkFKpOiAqSDOAqvMPerhVhQvTvee0mV6NJJp9/lw0pyJuQQ+J+1j22LSypDQxm2cEmJPjM6KF51VL6fFyInVTTO4Xn+g88Ex+jKcKThJYThBddvHA35s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hfQbfTdg; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hfQbfTdg"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-385dece873cso3398986f8f.0
        for <git@vger.kernel.org>; Wed, 15 Jan 2025 06:49:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736952544; x=1737557344; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=r5r9G3G1Eyd4kypEVbJx8RGatDNs/btsWAmZhmPOph8=;
        b=hfQbfTdgoHZ9ztSGPOnFZzwH7c97AdrJBK7iZcx56gCjcdBscHDczs/tUVc1vZJQP1
         +VhP5S28h1X6awaUdI7SljZFYsCvJkyx1I7vr8MbZR3OR1o9kGXxxr10IrwuOo9VmF5O
         g7Nv29M3Pgbpz8X794uISM/X0isizIZGADtZP7Rior9f5L8fdVjFXLT0bGXWY8fnsdMC
         rEZZGdDSSzZuSF3zHYGeSXL78i76V/NYwdSHI/a//7gfVrMdncfySOtLYT+ccBTnxROL
         fKSJubDYCtj4GgJl3p5ZH0qiI2ba4NZFnT5DDjEx61t1CaJCV9cBRqiCFYEGOaDP92Up
         mjhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736952544; x=1737557344;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r5r9G3G1Eyd4kypEVbJx8RGatDNs/btsWAmZhmPOph8=;
        b=YwoqPk8Xb5y5gyEVPqe+BQ9dA2w6BZ7Q96BDGuqWdGMYdypCDsYmOTqXwlNa1soXz5
         NEd/yIAbuTikffmsjB+ujPi6ll89rz7EP+BKto4sB6iXUzoKlqPAKSGqtHmbri3YxNeP
         oUC0tCGqpgXBUsYn/IYJDEyn/E3Tbjs09gK03/dapLTZV7FfGD3+u7UaMu0RCKRCj/nw
         zVcayz5as6a4crO0WyKS4NUu7PX/YRrgx/UHD4ZRM2VdAJSxwWmaK82brIA8juTG+mS+
         vL578N+Q6sfVKKgyoSKqVOhuAoFIqCoCBoXN+ixwuSTdSbClmSpXfWk/KIh0ppNwYA4G
         Lkqw==
X-Forwarded-Encrypted: i=1; AJvYcCWaKoI8iu/xeivl3Lb+38l6AiUQPKJ+eZV4CKQRDVlSmHwef5UvgJh8wgINDJuZmPDnc+4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw36lDUMi1TOXzjaM3RKFTAxdXbLipG1/xGeJfttBVIstu1nP+H
	X6A+bsd/uBuB/hBomy+fqSaaw90AP7rfy8+1hMEjEqEEj7MVTbex
X-Gm-Gg: ASbGncsxsKdjAGeqhDG5kbjacbxwHcUwVmQPfDwOuPFyZuPFQ1TAWxUa0v8tf4Np9Ob
	ZjZ6obi74D47mYCq58WsgGaYYIv0M12UeYW33DevvI3IVzV6byW0ybWXhPSSZqiatrfUZQsTHa1
	9ut3x5qqrUwxTvFAA58WsEy+Jd2Smiuh2ogQsW04eUguuRQP841TQkMD9YeoUaWOMqGQ5zo3pVB
	U0aiVtv3bBGendBhtkX3rrJWJh5uhsUGhhlW61RU2nT/7hSL/lyt9w/HhN/gk3bWHbyF5ttUKte
	lmOI7bsBVyh1SyvtFM9f4sQXvqUke0Ttz68=
X-Google-Smtp-Source: AGHT+IEvptuMcgbCoHlcvoCxj34qnkEWAjtGhaQQ4zrIj+ulN6/jky7I+/KQHC5W7kkCDyKmDQoHhg==
X-Received: by 2002:a05:6000:1848:b0:38a:8b2c:53ab with SMTP id ffacd0b85a97d-38a8b2c563emr26641890f8f.44.1736952544283;
        Wed, 15 Jan 2025 06:49:04 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:700:a501:27ae:70ed:9eda:7f80? ([2a0a:ef40:700:a501:27ae:70ed:9eda:7f80])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e4c1b2asm17334856f8f.89.2025.01.15.06.49.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jan 2025 06:49:03 -0800 (PST)
Message-ID: <f2ce08c4-f70e-487a-8dd9-286ee5bc683d@gmail.com>
Date: Wed, 15 Jan 2025 14:49:00 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 1/3] sideband: mask control characters
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.1853.git.1736878772.gitgitgadget@gmail.com>
 <f7fb7a38333cf6527345e3dbefaeb2cd8ade6429.1736878772.git.gitgitgadget@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <f7fb7a38333cf6527345e3dbefaeb2cd8ade6429.1736878772.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Dscho

Just a couple of small comments

On 14/01/2025 18:19, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> +static void strbuf_add_sanitized(struct strbuf *dest, const char *src, int n)
> +{
> +	strbuf_grow(dest, n);
> +	for (; n && *src; src++, n--) {
> +		if (!iscntrl(*src) || *src == '\t' || *src == '\n')

Isn't it a bug to pass '\n' to maybe_colorize_sideband() ?

> +			strbuf_addch(dest, *src);
> +		else {
> +			strbuf_addch(dest, '^');
> +			strbuf_addch(dest, 0x40 + *src);

This will escape DEL ('\x7f') as "^\xbf" which is invalid in utf-8 
locales. Perhaps we could use "^?" for that instead.

> +test_expect_success 'disallow (color) control sequences in sideband' '
> +	write_script .git/color-me-surprised <<-\EOF &&
> +	printf "error: Have you \\033[31mread\\033[m this?\\n" >&2
> +	exec "$@"
> +	EOF
> +	test_config_global uploadPack.packObjectshook ./color-me-surprised &&
> +	test_commit need-at-least-one-commit &&
> +	git clone --no-local . throw-away 2>stderr &&
> +	test_decode_color <stderr >decoded &&
> +	test_grep ! RED decoded

I'd be happier if we used test_cmp() here so that we check that the 
sanitized version matches what we expect and the test does not pass if 
there a typo in the script above stops it from writing the SGR code for red.

Best Wishes

Phillip

