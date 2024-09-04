Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A4663D
	for <git@vger.kernel.org>; Wed,  4 Sep 2024 14:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725460542; cv=none; b=m5CSevI+G08ZFlu3vnDyrxH4Jg8N2mhUeo1rT9aWWUDxR0JS/dJ3b2AmK5RKDEexmLyULEox0mEfcrFJ9LCm+HqbEFcZ8kDnedaIawR5SXRW5cvXrEOXmdGebQqwnpJKZ656ZuiPWJTyMNhs1rJwPNJdAo9/yqDGK/bRvGWXMCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725460542; c=relaxed/simple;
	bh=qWppLOT+beBhwS5WIbZa7ewXraRiBJIASflTL/K7tbs=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=jmUqC2j+y2xJmScKY54oBYh+deKjqd1YIKcB1ktlTTF2rS5iktS+85I8mIcLWYg42aqAi0Qz+3KaelR45sB8tPzdRlsSPonPoI5uCCSQ9awuCEDKuqxaAvFDoc+XByKtACKvzjPKgGLx0cjlxGpaHQHSbcuFg+dKTv70N85pkwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kpO3XOsT; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kpO3XOsT"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a86abbd68ffso160557966b.0
        for <git@vger.kernel.org>; Wed, 04 Sep 2024 07:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725460539; x=1726065339; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ob9aMwFyxwP/E34xyLiRl3MYIHYmrrWi0Z6VPllhi6w=;
        b=kpO3XOsTLrUwU5m9tSvC1On8+5paLK9HS9ngaFKmFqW8TSr+eH8UCJhJkzG/y8CXB7
         +S7uZN/K7rIXavXIDHW+HRxdCPwwdMWrP7OHUxVXYAY74wjQUm9n86o5T+7F5A+JTZix
         lvb93cspqe8rPjaAqaS4dLW+/QVNBBdV3AJhaqtlzfUx2QJdy1O3/9kBTqZJbWy2M2MU
         4bT9kwd/DZVAH6H+eY/HlPqKVfAj5wjqK1hL43el8/4WqBhqyW9TEyDQxxInMPuBmdRP
         lwtFd1pMbnfzOyM8HTsx6PleMWRvfICBB6lxqfHW3siRLGYC1uwEI/oMj52l9a8QC6gO
         PVdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725460539; x=1726065339;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ob9aMwFyxwP/E34xyLiRl3MYIHYmrrWi0Z6VPllhi6w=;
        b=cTXbbKLPtd97qz5ChNV0aYPWD2N08XFtRV4p9AYSbi7iRH3MhzdEMdKbl090edz8cl
         Ojja3vgfi/j+QU+2siAdnj0Mw2xxZbGZK8B/8QCXQes9g26nJm75NFl/0+HJaqqLV+ih
         94CQsSyKyqgu+KBO7VXRIwvxXGncXnFpV8qNEeA0k6ghSq4dfFmwvZtD+4VdBJNYm7k6
         hgFWdBv1+WpPcOMgUTfP5Ujlxc600NM5u9NZRoEwPbRyQ/F2lrF/JZl9J18Ne23x1ib4
         s+yy+Gkw6vWTQ8n3wg9vHtmhA/kP6moPGyc2y/KW/8T6fjBrJEEvZxl1dv52mUAeRDmz
         3Wng==
X-Gm-Message-State: AOJu0YwsmRPeFTmTM5Y0LGBZkGWvnyTn6JoFwjQSR3b1r1t7jhckijWp
	qzuOqmar0FtDsUx00hYtF3v0wpnnPM0wuqLOLAP+3LuAHYEWoE14
X-Google-Smtp-Source: AGHT+IHeTnyHAdtLkUwKOEsTfwnkDFiG7JlUfvMoNkVLyG15/zl5AUbIiU5hz5ybtrSz/Q3j97mlMw==
X-Received: by 2002:a17:906:f59f:b0:a86:91a5:4d09 with SMTP id a640c23a62f3a-a8a43151434mr237388366b.26.1725460538012;
        Wed, 04 Sep 2024 07:35:38 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:6d3:8001:7151:e3a9:f71b:e7d9? ([2a0a:ef40:6d3:8001:7151:e3a9:f71b:e7d9])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8989222588sm807174366b.200.2024.09.04.07.35.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Sep 2024 07:35:37 -0700 (PDT)
Message-ID: <6e941da7-cf7d-473c-bd32-56bebee6277f@gmail.com>
Date: Wed, 4 Sep 2024 15:35:35 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v7 11/14] t/unit-tests: implement test driver
To: Patrick Steinhardt <ps@pks.im>, phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
 Junio C Hamano <gitster@pobox.com>, Kyle Lippincott <spectral@google.com>,
 Josh Steadmon <steadmon@google.com>, rsbecker@nexbridge.com,
 Edward Thomson <ethomson@edwardthomson.com>,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <cover.1722415748.git.ps@pks.im> <cover.1725349234.git.ps@pks.im>
 <8bd5b3e2b2989a30b597da2103eb8d9699cf3d7f.1725349234.git.ps@pks.im>
 <e435e05a-376c-4928-9852-6925df855399@gmail.com> <ZthqtWVntB-PgSH-@pks.im>
Content-Language: en-US
In-Reply-To: <ZthqtWVntB-PgSH-@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Patrick

On 04/09/2024 15:12, Patrick Steinhardt wrote:
> On Wed, Sep 04, 2024 at 02:35:20PM +0100, Phillip Wood wrote:
> Oh, that's a plain oversight on my side. It is easy to wire up given
> that the clar already supports it via "-Q". Also made me notice that I
> wrote "--immediate" instead of "immediate".

That's handy, I'd missed clar's "-Q" option.

>>> +		OPT_STRING_LIST('r', "run", &run_args, N_("name"),
>>> +				N_("run only test suite or individual test <name>")),
>>
>> It's nice that this option name now matches our integration tests. It would
>> be helpful to show the syntax for "name" (I think it expects
>> <suite>[::<test>]) but I failed to come up with a concise description to add
>> to the help here.
> 
> Isn't `<suite[::test]>` concise enough? I certainly like it.

Sounds good

Phillip

> Patrick
