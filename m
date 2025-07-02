Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84D71DD543
	for <git@vger.kernel.org>; Wed,  2 Jul 2025 14:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751465652; cv=none; b=bmlF2Wwt8GBFEiXpSZzBnlTdl52hubvketbbQX2TSpiTmo6jnc8sciuZk4SpSzbt/3lt8f3VGc7+H6bjtXXAqWI1b1pT2tTZOMXNQDQUjPMaj4hhnURi4AwJWcKyYO16DRb9GItqL4UBkkmXvKSo+jMXZt+SkV0Z+Q+u0LueTIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751465652; c=relaxed/simple;
	bh=stvUpkMIFHAEaiDfuYAwNYTJwfZXVKgPS23IA29k/HU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Ap5qCq3w8nHzDcIkgoahAPotnH6uN3p2atPLFq6VXM9uIFKwEhai1n1LZqav0qaw2MMdiWrjtTJt/17jNIHuWSGomTzgjkyEcRa7ErFEeujRmJePgO+gmspKt1YkvmiFc2Rr51DzI7/STe8P3PZC/y8BLgDcaaTzvdROmSwBHo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iRsTmzEv; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iRsTmzEv"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4535fbe0299so26687955e9.3
        for <git@vger.kernel.org>; Wed, 02 Jul 2025 07:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751465649; x=1752070449; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=FGoW8WeBjC3bbYCAopRs923APaQPYZzxeCYCS1F0j/A=;
        b=iRsTmzEvhrWBIlNAqI21io0WgU6zToG8wAB8W6zyLxY1CAlcOyQkZYdcpgR/LA+YoI
         5TsY4Ke7h9Q+9xdKY1/NJo6i8Jgc1uKnPdUqlQn2bG+KtrVrO/8qes0XDXUU0ExSndiF
         R4VH4S+Vb7U8I/Dil9F4o100WQYIdH73uMjrNqHZC3B6lyoFwus29jUfyf2P4J39dMOb
         j7V5J6CwD5SiAoKzn10tnE/766SulJkisnDWyna74rJB9b1A9PWOCjseOC+uY8yURN9N
         iV49/Endn2FCMsxCfHab8usBJ2R0bndDcb13Vftxae8e996E5pjw5dxgvK9uxVFi23dB
         bSDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751465649; x=1752070449;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FGoW8WeBjC3bbYCAopRs923APaQPYZzxeCYCS1F0j/A=;
        b=hhKkYwI2ZzznCSQWVGeNLV9qVttzzQJs5sJpieKdSIElKS4/RvsQaMCoTiCmNWdIYT
         /2dQyLhcORM7Nz9Gbe+TQ/XjIu5wpuxcHVXrSQr1z2pmF7Bgsu3hqTYIZ54gyaapgmYz
         5HvWlCmKgsn6Rg+COqq46lqafqJie8EUrUub3BtBca/Qr8nLhKHDZarY5AGxrdeAJ1Z8
         Gk1G8zSD3ZZe/epwV6w4Z5TeDAeEsj053n9INZqVd2aeICqXvdR87vB7wl3z0QmtXt0k
         7+UvFQFoWanHxwa/QJX8wtEbTdJ6xF7dvHbcn1c1QDtfTAldfxOgtrDLWNnAccpLWWhv
         7HNg==
X-Forwarded-Encrypted: i=1; AJvYcCVtM1m09Ov/FqvxxB5mj/1eqDL3ng58Hxbg5I0PnQ2bfG1wH+jSoncGI2RQKbdpxsUwgy4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5vd8iLSucMS9D+I9u88ph6OFVNT3zkDtwOLyTXaLXNpQ+esmG
	dQIgvOg4NfqO0lNX6d3kY7BJFOckgQ8j//7ApZIOTs9bLVjmYOblNhxc
X-Gm-Gg: ASbGncsDpbqsulTcxMVtN5/L3SwWLLtRsQwif+wv2z6yhcTAyk5uwEgSoUTedUPhgXC
	qcuSx6mE8CPLGlvBOhuo98uDHfNH8yTTHd+p2YIEJ3v2w1uaXF8rK3Q6S12jX/nAIyPhegU/px3
	XGg2CQPp3FmInr0U5TJuJ0d0OvRJs3BgHps/nSI6gkxz21Te7Dk9FWKJf1x52YPfl9A4Qc4dvE4
	rBLo9EvJ3N+K1kWlg048wk+O0H0UYHmvEL9dmxgiogOBqMBDxWeVn+bjJhqSd2hGwa7HIbTM7U+
	ctzNdR0l6OHpnjtNQTM8pOmGIoJQMDIp4lEed2LUMcSXwzOVJW6zdPWE/ve3H92MUPWyjgfjFuU
	DO/eNDk8OUzGYkh7IDq3wy5hKn9QDJLAGg3EwlA==
X-Google-Smtp-Source: AGHT+IG8WJapkERZz3J6ArSoiHzu4FlpZsfwTrgYnqTRNimBZxUxB8pyz076oJazAewO3j2XXCA3Sw==
X-Received: by 2002:a05:6000:290d:b0:3a3:6a9a:5ebf with SMTP id ffacd0b85a97d-3b1ffdcd82amr2630398f8f.20.1751465648833;
        Wed, 02 Jul 2025 07:14:08 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a892e59628sm15931257f8f.81.2025.07.02.07.14.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Jul 2025 07:14:08 -0700 (PDT)
Message-ID: <5e9b3ef1-931b-4b70-8275-5aed5da3d6f3@gmail.com>
Date: Wed, 2 Jul 2025 15:14:07 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 0/4] for-each-ref: introduce seeking functionality via
 '--skip-until'
To: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org
References: <20250701-306-git-for-each-ref-pagination-v1-0-4f0ae7c0688f@gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20250701-306-git-for-each-ref-pagination-v1-0-4f0ae7c0688f@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Karthik

On 01/07/2025 16:03, Karthik Nayak wrote:
> 
> This enables efficient pagination workflows like:
>      git for-each-ref --count=100
>      git for-each-ref --count=100 --skip-until=refs/heads/branch-100
>      git for-each-ref --count=100 --skip-until=refs/heads/branch-200

Doesn't that require you to know the name of the ref after the last one 
returned by the previous batch? If the use case here is pagination then 
being able to provide a numeric offset might be a better fit. For example

	git for-each-ref --count=100 --start=200

would show refs 200 to 300

Thanks

Phillip

