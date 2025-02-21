Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE6B7080D
	for <git@vger.kernel.org>; Fri, 21 Feb 2025 14:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740149311; cv=none; b=QTI6GIOHYAbI/nlCqoM1SX8l4XnbrwaRqv3l5ChLAfnhNB/erxqZQ04yzl+5Z7WpJ7PK7N0vc5ZHtDdESztcLog6v/PT3rIx9oBzAShQilVLXBvyhQWgMH5fO+1koo5VwMgr+XYW06N6hyUK7CYg2PM5nbjQPSMOdYV7WFS0iZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740149311; c=relaxed/simple;
	bh=1pgm6xw0ukTcUgQzqv8UAVQMy62nJKuWk3q/QzK9+QE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ijffFdaEv9sy9Dh4oiVmM+l0PHG6by+lIyVMM1gbCFP7KMVo0UT4QpCRE6WzwU1DdMPui4VquZIAEmGOWoGSSZFdL+XOyzoGU2551qIZ30HA+aWCnpxVYGaP9gdg5KgyFVKDSX7JcuXHbQDmGJ2Zk8IUyfn2FJptS2icIntAvOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kzOflY0S; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kzOflY0S"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-aaedd529ba1so267964866b.1
        for <git@vger.kernel.org>; Fri, 21 Feb 2025 06:48:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740149308; x=1740754108; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/1Xh5uGUaqUTiOBdxlSkOo++7pcxuhkxkryZrsZOlpw=;
        b=kzOflY0SREXpyc1LB5dXy5tZY2Lttx49WXFbqDTJPcO9TfMcZf4kmQH7iGIo7CFpSa
         ZLzM2KCxogFQWtodwTujktQBXmt4LgBY+oJWVOvOAFI+95tsyA0opgotFTekaf02qK1/
         Z5igWZquNKc2WwubcMDACRS3WsghxodQMCrizabT3NcKZO5VTZYs5V0ibWWi7tD5darQ
         Xpjb+1amQuyhmJ8THJWRyPiAzwCMQdjAuGlTtGSVXNyz64V09LIHGo3eoPmqHrASXcE9
         83Kbwe/ZuZqXj4BPCFYZf3BAFm4sBN33f8GzEg0+h5/JXoBMU8qC3ZFqzkhFk4el1pa5
         cCUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740149308; x=1740754108;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/1Xh5uGUaqUTiOBdxlSkOo++7pcxuhkxkryZrsZOlpw=;
        b=bKcPA4+vEtVp+BC8c4uf/GXqdRaaoo0gVfKPcnmkBceBIfRNDsa03tauULg/j3e+Ha
         6zf3jwLljilpulEXftXB2SjconSmF1DyguVrr4McWzp0ZKL2BRtjMaOcoOQupoeFV0Sb
         9ZXXDkJme29fYrsSd9yqZ4CEH6hdDRtdKqAmo6ychs9aHMxxfgr37A4w2n74DnycyzeU
         4nu3hiOXyHT1s/FM8uYjc8Zvr1okDgLuDXI4GSjWyOOVmuxqtTip0uUkXUDfpmIoF4yZ
         3+WS9zwZYk5LdXaELV+M5V/UEKNzf2XKJqdwR20AW//HThcVS2+Qw+W9EqXBKMWm3qL9
         1PQA==
X-Forwarded-Encrypted: i=1; AJvYcCXF9zl0zbCT7w1RUjYUG6U6HemJXVuGDUa6Z9iKk7I9x4If9PQ+o1ZrXSTzCW96cgkwTHQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRSHg7/YZPje8M7v5KAmVsL3WNhSESSthjVMbDQVDmXM4BVky7
	xn76OPq5pX9Wv4x/yUJGFIjDyDUv1QgAZ74uRL0/9BZ6CySJJpQ3V+l8fdEyFPY=
X-Gm-Gg: ASbGnctLfxby5ZnVMeq4HWyjzC2XLWtJ/udgtlCaIpLERTV2zQd6M/FPwPFuxQiB4Fj
	dztp8TwdzZsdOovIlG/tbaG/8JKZ6TsBD+oi0BVI8ppJkNUBgbxtNHEVvF+VNlVO6W/VTcHklsS
	qu/pNxAhH0t/+cKs1VDIojGN8SkGasAgEX/DZ/3QaaKZXXyMMOoqpLZOzxNo6Yn7yHTj8oInWe6
	+lb9d2B2qk6n/iwzLRqm9WibrB049nel8dy+OajEJEoP6U9JkMKjF86ZPNg1mDX4X74y9XIj5aT
	n2DBFxy8/8c+k1uLkVwqkHJKOQlGkF266XpZWjUBfdtyyIUmUvLg4SyKIvyNhoROF2yAlFfAAox
	TK5n7
X-Google-Smtp-Source: AGHT+IHN9zpO8im8NN4xNhe6Smh4iovozZpzBVeUEojFUztaXL9/c4J02RMP/m+bdD2630WrIWngVg==
X-Received: by 2002:a05:6402:388c:b0:5e0:7cc4:ec57 with SMTP id 4fb4d7f45d1cf-5e0b7266ba5mr6467864a12.31.1740149307594;
        Fri, 21 Feb 2025 06:48:27 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:700:a501:27ae:70ed:9eda:7f80? ([2a0a:ef40:700:a501:27ae:70ed:9eda:7f80])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dece1c418bsm14258260a12.24.2025.02.21.06.48.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2025 06:48:27 -0800 (PST)
Message-ID: <2d60f5ae-7985-4400-a4d1-0931dac0653e@gmail.com>
Date: Fri, 21 Feb 2025 14:48:26 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 4/5] t/unit-tests: convert oidtree test to use clar
To: Seyi Kuforiji <kuforiji98@gmail.com>, git@vger.kernel.org
Cc: ps@pks.im, phillip.wood@dunelm.org.uk
References: <20250220082959.10854-1-kuforiji98@gmail.com>
 <20250220082959.10854-5-kuforiji98@gmail.com>
Content-Language: en-US
In-Reply-To: <20250220082959.10854-5-kuforiji98@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Seyi

On 20/02/2025 08:29, Seyi Kuforiji wrote:
> Adapt oidtree test script to clar framework by using clar assertions
> where necessary. `cl_parse_any_oid` handles the necessary checks needed
> for the test to run smoothly.
> 
> Introduce 'test_oidtree__initialize` handles the to set up of the global
> oidtree variable and `test_oidtree__cleanup` frees the oidtree when all
> tests are completed.
> 
> This streamlines the test suite, making individual tests self-contained
> and reducing redundant code.

My comments on the commit message for the last patch apply here as well.

> -	if (!check_int(get_oid_arbitrary_hex(hex_iter->expected_hexes.v[hex_iter->i],
> -					     &expected), ==, 0))
> -		; /* the data is bogus and cannot be used */
> -	else if (!check(oideq(oid, &expected)))
> -		test_msg("expected: %s\n       got: %s\n     query: %s",
> -			 oid_to_hex(&expected), oid_to_hex(oid), hex_iter->query);
> +	cl_assert(hex_iter->i < hex_iter->expected_hexes.nr);
>   
> +	cl_parse_any_oid(hex_iter->expected_hexes.v[hex_iter->i],
> +			 &expected);

using cl_parse_any_oid() means that it is safe to dispense with the 
check on the return value because we now do that check in cl_parse_oid().

> +	cl_assert_equal_s(oid_to_hex(oid), oid_to_hex(&expected));

This is nice - we'll get a message containing the two oid's if they 
don't match. We should use the same trick in patch 2.

As with the last patch we now bail out after the first error, we should 
mention that in the commit message.

> -	if (!check_int(hex_iter.i, ==, hex_iter.expected_hexes.nr))
> -		test_msg("error: could not find some 'object_id's for query ('%s')", query);
> +	cl_assert_equal_i(hex_iter.i, hex_iter.expected_hexes.nr);

Using cl_failf() here would enable us to keep the message so that if the 
test fails we can see which query it was that failed.

Apart from that last point this is looking good

Best Wishes

Phillip

