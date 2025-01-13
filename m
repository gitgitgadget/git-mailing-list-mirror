Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3641C5F0F
	for <git@vger.kernel.org>; Mon, 13 Jan 2025 21:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736802755; cv=none; b=R5qF0wCwA09jxIe84J1gevGlceq4bWi9f7Ap+egHlGvGKA9h3l7dmK171IpgRN2a5sFxQqvkyv7tc+VsmmJG+1POqDmJM9+C3e3H3/Wjej8WBPFdELS9tfWZ7RN8HfYKEY7DIwytljuGSqXn/V6QsXj9UpuXqrCzWSrmQcFq/pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736802755; c=relaxed/simple;
	bh=UzxuVpkAbDPhNE93Vpl5VrTuaR9puSHLMVQLI8pxms8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UtYM1S4Oq4CYNn6tu12UNWeY2VUHwXYj2pvGZqqYJWGhw/zaiTuarwoJ4MdS6+ho1Z1VeCMZa0rjVMAnpujnaI5hb9xOlirbGuqjP3Ra+9VIOQGEUcCPQyAOK1/j7GfSETgzUAqT4njlpXHU07VYmraevId2WrpuLCi+g7ICprs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UYs4X/eo; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UYs4X/eo"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-385ef8b64b3so4160519f8f.0
        for <git@vger.kernel.org>; Mon, 13 Jan 2025 13:12:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736802752; x=1737407552; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1qHuRQZjpvIkZUTk/UHmzjidF6NS7Kqp21oKfR21fx0=;
        b=UYs4X/eot5VPbk0rHJ7CKsuJ1O27/VVjXyFRSQcWDPghioJZgRaBHbGk3+MTyxlPCj
         H1t75ZTnRBqhy8MTVHw82q4G2vZZB+mz9FvTnLBtQQRlo2V4RCG958BNZky/KQNSCYZY
         Ad8PBnP7XStWV5CjD5vLNE+0u1lqp79BqAN4nh7AqvjDtTplKyK553B7sVMMQlGYtZjM
         nNv3tcs33fkbdAb3YftJjYcbUvKD0jJqf0sVYfMuTGIwXVLtNSCtB4hpZYEzIXyC2k/O
         DAwlnhVtPlTGVJ4DnjCYLE5pGYLXSiRewX2SlDFKD8jPpfe6dAgolgF+w4Cd8Ty05MSF
         fjIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736802752; x=1737407552;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1qHuRQZjpvIkZUTk/UHmzjidF6NS7Kqp21oKfR21fx0=;
        b=XCmH92hgRpe8gTvy6iyssK9Lb+IKz2o9vJUz8skW6IlzkBvtrK7ciIKpeLed8wYN/b
         WfDZGazGowKuB1zKhenVrY9Us/xehFzS4m8LOoGAxuq2hvQRWTJBJNDyvDB6iKzm3sck
         IME/Oow+XyENOL6fcuznEz8CCOwi8Lp34FeVly+r+bI+dSJ2OYKEDvn6TRCT7i2hVT1K
         7P+jhdQPuczJbc9cs4sR4xRkCaIVETq47Y1vOhPw63qGS3Q/501L/COSXg6oUQAVs2lb
         iyg6+9u13Hg6Lew5AvzqyMGU9jt+RQBrMpMR2ix+EnayVXr84PpH6zo736Forfsu1/vs
         sWiQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhcKLbk9Zr5mzvsJX7T4I0EOhsyJOfleiU7ipayFqvV5fLk1P0jqn/0FUTnEAJsXA8qNk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5kw+W7VMYbuVANUn+kpHMeW1vBvlrWrRyetVA3DZeWYNNTQRb
	Yr6Dl3mNzm/137qU/u9c83U3W1teW4U9iMm12dsuWglJqWgt/3aXTOmIT5Ab
X-Gm-Gg: ASbGncsFFvsC5SyBMDap6bD8HuyaUm42v49Isi4UBNYtpeWHlLi7dW8spf2cxLzahVx
	G5MjB9PrmO/puGgiBvw9DOuhr33wmy2Uuo7Aj6OgT+wJjzLvdfPHZBWwY7+SuntgiYhdeIvdG1V
	3Q/AFXDbQUWTZVezloqVufCiUpRSCxqEcqF5H5m5QKkq1Tvy2wIZo4aRx1PmyzsHtwL3ZFvfNvK
	7/3EIFptW/wTOd+vUFiwm6ofb6bK6NM9S0qlWJzhRaD8M0krqN5wOLiE3wWimZtV5WHyABhCWkM
	BiBS
X-Google-Smtp-Source: AGHT+IEqeqeFr+3oL7Qd1RGbWxkLs9EgtOH33o+BaFlMJLskXuBkBs83QGdGMWcwff9HZFiQl4HmhQ==
X-Received: by 2002:a5d:6d09:0:b0:38a:418e:f3f with SMTP id ffacd0b85a97d-38a872cff32mr19645921f8f.3.1736802752055;
        Mon, 13 Jan 2025 13:12:32 -0800 (PST)
Received: from [192.168.1.186] ([2.26.170.204])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e383882sm13197941f8f.34.2025.01.13.13.12.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jan 2025 13:12:31 -0800 (PST)
Message-ID: <6df239ab-eb04-41d0-898d-7cafe925b13a@gmail.com>
Date: Mon, 13 Jan 2025 21:12:21 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/9] meson: fix compilation with Visual Studio
Content-Language: en-GB
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Evan Martin <evan.martin@gmail.com>, Eli Schwartz <eschwartz@gentoo.org>
References: <20250113-b4-pks-meson-additions-v1-0-97f6a93f691d@pks.im>
 <20250113-b4-pks-meson-additions-v1-8-97f6a93f691d@pks.im>
From: M Hickford <mirth.hickford@gmail.com>
In-Reply-To: <20250113-b4-pks-meson-additions-v1-8-97f6a93f691d@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-01-13 08:33, Patrick Steinhardt wrote:
> The Visual Studio compiler defaults to C89 unless explicitly asked to
> use a different version of the C standard. We don't specify any C
> standard at all though in our Meson build, and consequently compiling
> Git fails:
> 
>      ...\git\git-compat-util.h(14): fatal error C1189: #error:  "Required C99 support is in a test phase.  Please see git-compat-util.h for more details."
> 
> Fix the issue by specifying the project's C standard. Funny enough,
> specifying C99 does not work because apparently, `__STDC_VERSION__` is
> not getting defined in that version at all. Instead, we have to specify
> C11 as the project's C standard, which is also done in our CMake build
> instructions.
> 
> We don't want to generally enforce C11 though, as our requiremets only
> state that a C99 compiler is required. In fact, we don't even require
> plain C99, but rather the GNU variant thereof.
> 
> Meson allows us to handle this case rather easily by specifying
> "gnu99,c11", which will cause it to fall back to C11 in case GNU C99 is
> unsupported. This feature has only been introduced with Meson 1.3.0
> though, and we support 0.61.0 and newer. In case we use such an oldish
> version though we fall back to requiring GNU99 unconditionally. This
> means that Windows essentially requires Meson 1.3.0 and newer when using
> Visual Studio, but I doubt that this is ever going to be a real problem.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>

Thanks. This fixes the problem for me.

Tested-by: M Hickford <mirth.hickford@gmail.com>

> ---
>   meson.build | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/meson.build b/meson.build
> index cb352ce6fd50616e3281a776104692c5b2bfa5b2..831da1d43cafe85a8c9ac872e141476adbc08188 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -171,6 +171,14 @@
>   project('git', 'c',
>     meson_version: '>=0.61.0',
>     version: files('GIT-VERSION'),
> +  default_options: [
> +    # Git requires C99 with GNU extensions, which of course isn't supported by
> +    # MSVC. Funny enough, C99 doesn't work with MSVC either, as it has only
> +    # learned to define __STDC_VERSION__ with C11 and later. We thus require
> +    # GNU C99 and fall back to C11. Meson only learned to handle the fallback
> +    # with version 1.3.0, so on older versions we use GNU C99 unconditionally.
> +    'c_std=' + (meson.version().version_compare('>=1.3.0') ? 'gnu99,c11' : 'gnu99'),
> +  ]
>   )
>   
>   fs = import('fs')
> 

