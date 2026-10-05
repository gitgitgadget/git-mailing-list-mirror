Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0F4448B9C
	for <git@vger.kernel.org>; Mon,  5 Oct 2026 09:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791192870; cv=none; b=WnK5U5H95TPA7q+863MObi7Oa0Yr0bSyjqDCv37F5OiTZM0r5EitzKdhtjLSz0eGyH2K/8mz8021O3oFpIi4uouFJxpGd+xmr0JMjC0zKWzj2ZPZl7f6q3vHqC9EqTxKPbtJlPwdTGxWU/RpgCZOqbtH/SArkw8Ao59xtiRFVgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791192870; c=relaxed/simple;
	bh=14CCqXf2SDL6y22+bD0EB0mcnpD29sijQkH7MeDbxpM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WbVgz48XsE4Tnqn30pUF+u7EtxgEaRinA5v11kGizXZ8kAKsJPdcZCOPdFOeQL5PPMCK63FMd7vH/HbVTuUXxAQcZDCyLg8nBDs1iR0HiBQKh9XXNoVqPMJGVnbxjsU8gFAguuc47Jxwt/eYC/AkmbaoQ73tr0YYayeJjhbW3no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UTxtAbjF; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UTxtAbjF"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc1cea4bfd1so349497a12.0
        for <git@vger.kernel.org>; Mon, 05 Oct 2026 02:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791192860; x=1791797660; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Fh84t+SO+o9lnYPuB2wN6wEgpai6URhyyAXtn9SD34I=;
        b=UTxtAbjFu6pmBciyoLt7X+55oB8adH3umS9OEJ7TZsg6H/psPHP7GZXaJfK+mf3UOO
         NkQ2FaSbGKyZuFo4V0wPdC+lfICqJ7YC27XCKfHup9F9646HapiMWQzAAm8cxRKUbYfN
         PtPlCZRsOD4jHYIluVZ2DkTwtSEePLgIRYuPwmlj+YYamB2d4HPjDfEnr3KUuFuwQ92X
         GXlLvrcJInyIHySoUwrhblhLijdbq8Dah+B63lnVQeNV87eJC5y9YKZO+1g1VnrKtHw6
         m1JJr+qQhTFe+ChVBqzCu7g3/McBZE503+GRyWryLaNCHbFEw1jCV7pKTwraqrRNgHlf
         f2qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791192860; x=1791797660;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Fh84t+SO+o9lnYPuB2wN6wEgpai6URhyyAXtn9SD34I=;
        b=2SgoytQQ5YFwqQqOVeeQdX+UIAisEziQiz0NNZ3B1viV62WAHug1qg3jXIGUCecUjV
         ijNxVHY0xDFggt5mRedmOZRZ6mesj2Anou8uP6R5fwAIs6Ui11IP2inaUUCHEAawzwUi
         puFeu6yxNO8ixNoqdF3AajhsIXCfPQhZBi1PKzIkA4MFcl//3eD2QALAyWBjq9Xx2N1t
         095MLcLAzOXTWWtZ8b1kd9Q+wIL3Lyu5FZiJYD+3zUSTa5vrwe8u+S43YQE1HR7CGORf
         3Cb9uY9BZf1LAHQDgAcUuzcxsnIsaEsMMJl4VFpdFqZhwycFWXsY7myQNI+261wBpA5R
         +Ypg==
X-Forwarded-Encrypted: i=1; AKwUvByhCf8hTfSLzFgWc+9+Y9qJioOrQT6kifz5cmCuNCVAJPTSUteZSJGuTEAKv5yXmvYRHC0=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ9wIQ6fo7h2XPQ8nb90+TIxXIJledzn5Eyr4w+aZs8I+i6nIk0
	CT6Y+vwMB/4wgnuQ2ivn4TN1f5ZvYKAlzhtGXTuN9tkmvvPDzhXM6C29IT9h1hTh
X-Gm-Gg: AYBFou37Wbrhy9WyFLJWkvQjECxBdjdnw1KTtip4p0QS91Q4sgLzJzHOi2r9IbhiaTH
	peXuO2yGSseR0k38wtmb425rhvWQQ8gcF6wAOrZLM7jzcxwtRfZxC/mGyF1X5x79coJsbgGMbI3
	A6XyPD04aaKcAPZrODGleS0P6GY8mEOtVj74bIy7HdE2LVj5KHYEIUDhhPsR9BTt2SULe/uwAov
	Bmj3IvV13CoVfPdLEMgo1rgO8xx02AStvSTrG8BcKXKsOsLgrK7oiq9thaXNtpawv7W85h6X5h7
	HGrEA4pTk2gK+rD3iw61Uz3nXRx5IV1z28OQn3F2vK2JdOEV/C/LjvAb3ozmAILqy+933heuAqW
	4dCXCgEQ/UXyrja0s4ymXbJVfJ3Wndjigax+b6FuQBsCU+mWw72LY5FegCRpv/bNlNBvnKOT3i6
	TYSZxhawXeopeld2nnIyncecgXi7QCP8+uDiPam4M/dMQSJBbuupHlIMGkbDGlx3TOLZPs/9/DL
	raNC6kFuA27BA==
X-Received: by 2002:a17:90b:4e88:b0:3a7:8707:a0b9 with SMTP id 98e67ed59e1d1-3a78707b7bemr2445229a91.31.1791192860010;
        Mon, 05 Oct 2026 02:34:20 -0700 (PDT)
Received: from [192.168.25.219] ([115.108.41.154])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a78d65d85csm10243406a91.4.2026.10.05.02.34.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Oct 2026 02:34:19 -0700 (PDT)
Message-ID: <eb0432fa-a595-4690-bf13-baffb306cc3a@gmail.com>
Date: Mon, 5 Oct 2026 15:04:16 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] meson: use precompiled headers for unit tests
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20260924-pks-meson-improvements-v1-0-90b7f79f1c4e@pks.im>
 <20260924-pks-meson-improvements-v1-4-90b7f79f1c4e@pks.im>
Content-Language: en-US
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
In-Reply-To: <20260924-pks-meson-improvements-v1-4-90b7f79f1c4e@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/24/26 19:39, Patrick Steinhardt wrote:
> 
> diff --git a/t/meson.build b/t/meson.build
> index 3ca7b27104..9f1ee9ad59 100644
> --- a/t/meson.build
> +++ b/t/meson.build
> @@ -30,7 +30,6 @@ clar_test_suites = [
>   ]
>   
>   clar_sources = [
> -  'unit-tests/clar/clar.c',
>     'unit-tests/unit-test.c',
>     'unit-tests/lib-oid.c',
>     'unit-tests/lib-reftable.c'
> @@ -49,7 +48,7 @@ clar_decls_h = custom_target(
>   )
>   clar_sources += clar_decls_h
>   
> -clar_sources += custom_target(
> +clar_suite_h = custom_target(
>     input: clar_decls_h,
>     output: 'clar.suite',
>     command : [
> @@ -66,6 +65,13 @@ clar_unit_tests = executable('unit-tests',
>     c_args: [
>       '-DGIT_CLAR_DECLS_H="' + clar_decls_h.full_path() + '"',
>     ],
> +  c_pch: '../tools/precompiled.h',
> +  link_with: static_library('clar',
> +    sources: [
> +      'unit-tests/clar/clar.c',
> +      clar_suite_h,
> +    ],
> +  ),

Compiling this separately as a static library is cool but now clar.c 
does not get the libgit_c_args it was getting through the dependencies 
of  the unit-tests executable. Is this something that we need to correct?

>     dependencies: [libgit_commonmain],
>   )
>   test('unit-tests', clar_unit_tests, kwargs: test_kwargs)
> 

-- 
Sivaraam

