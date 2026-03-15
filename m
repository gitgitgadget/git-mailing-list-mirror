Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38791C2324
	for <git@vger.kernel.org>; Sun, 15 Mar 2026 17:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773595328; cv=none; b=V3ko7iynKp/kDQHME1ovmEhvLCwMiuhxub4pgpumT5Rvi7umBDt6+FqRWCjuSRTsz1QOC+VSFN5VvDZv/0wP8SmF20BwlmUBv4oClQX9teaFTVJhyRG4Hu3VOkwbD9tt0+wnBPBKm7qi6i+EeQibysO1Bi65q5TilVtEbRNt3Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773595328; c=relaxed/simple;
	bh=6iTy42/xj4CJXfQUXe96F0EX7TwGSoDNOumMgZY1n74=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=mhGz4DHWCE5KLBFMZiHgh/dENBwckjEcbn5rpiXPlr6DCNf3g1BycGh1yHpxk5SvyPKOadg9c0pd2hZQnaw7DqplczIK7waarN8rUSOx11joScvpybxot06cWhNxBng6+YJ9cjfgwK0YIAXJOVXPhlqi0E+am1uu1e9UOXo3zkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=imJgR46J; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="imJgR46J"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c73819dd2daso396960a12.2
        for <git@vger.kernel.org>; Sun, 15 Mar 2026 10:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773595327; x=1774200127; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GfmD+BPeEK8Ul5CHlXxzE15xrRRbit7B15kT/LhetJc=;
        b=imJgR46JiLbVQSuRV6MnaqiGyyPtNTGyYc1JwUVv8rcUsiwudCiljHgdxyOID6aXFj
         cFNEzE/It+MYLIxqaA9yDpRf+TOSDQNJotDzxhdV+7HogxBf1da8q7YNjMHXANMfHiLK
         6zAAWKlMbcjicrPpgjCzw5TpGLd1+Dm5IYdip/+G9mISzmMSFhkb2bNSBksTzYN+lqB/
         UpdQaxD0/6MwsjuotV8nppRNlm+8IqsN8BbTEW5pSlw65J4rsELCi80bG6STuL3mx6qw
         e5a2Eu/XK/BXC+Wev9923PPOj2dV38qbbaISI0CNwIqIGvN99JCWMBesuWHPju0WJDT6
         wxPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773595327; x=1774200127;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GfmD+BPeEK8Ul5CHlXxzE15xrRRbit7B15kT/LhetJc=;
        b=Hx/koOVHK8N/c28kNNShS0WdGuayFnTZfVh3djcS9ccA+sTliXgJyUDPpkq5HObQT9
         E9fNkXXoZwgnTFwoFOdtMUsJugkuetr9aEjzzBz0AYfycMd7uttK6SNCH/zjiONgE8ZM
         hBbV0D0636v7wKk2LGzJcx14BJ6ABYWfYR2LjIfQkbM7xR+NSd/qce8JL7exwsASayRc
         1XMITF81WjhTzPHvtCm+E62lPqKTh1CXcySzcKFh5iCl6ksbsU8PbY+K7XKecEmtL/OB
         mVvjxiQfAiEmbhZbjGJ0M6++GQP+9USZI+X43VIaHx7CogUHzTeP4pMyYMSRzORttNPF
         rGdw==
X-Forwarded-Encrypted: i=1; AJvYcCUYO8Peesz9h2Z4+2vB3FZDxLguVB5ZpAHeSIUjBro7qEC7uDkFk0zVOgqmQ7mhDsT0wB8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1Rvdk4UkqkeiVcdUvsY5XT/rrHTsfNtuR325O4sDW3BYnocRA
	OwaecIXQ1wOQ9bourL9gZW1kapg2oiRIRdlEAvFTFYm6PA8IrU8LuYSvLxUg2b15
X-Gm-Gg: ATEYQzwJfI7yGmQRD6lvrwVIQ7atIMbNaH4kXfVVElBi+k0d55FBlAGyM5QmnrJi2GG
	0vfPSXsjrfUxG2Ec7ZphEyBdQS6p+4c9bdzScon7oaVyOEXyB54XV2oN24g9uiBVwtWOOfUDrok
	+gP+ePNKZoTJtUvbBozMjDutgTPLMTN2J05gdHq/lfINLTVe2KgnGACk8PimmvA+PYxs1aU1rql
	U3kZKH6stUswSIJGt0in/VTm9Vle/3lu3rFKzB+9xXUqWUHM4NjpHLFCDXAH8OOTjQkwbAsmvb2
	9eY2nuznQE3IYupnFuG6qfyO/Gco2gVGhQCw1nZAxGLCfGtDXtUiYkhKLS9nXcL/Vq5wIMUwKuF
	PsrIgSynTg1ZOM9//pUjFdI6uJhFplRXw6mg67rzuQ8yk9UIRw8glkeRTEpWFBEOWVvZTICRsgj
	de6SxMvf4c/1D9R2nL//J8O+Nl4clpaIwNxuvWk0Ef3eTgNbhvbatyODGIy6Aakc8ezHiEqrg1v
	6tNETN3EI399Qa3T/Leh8Y=
X-Received: by 2002:a17:90b:1845:b0:359:f825:570f with SMTP id 98e67ed59e1d1-35a220b4660mr7083086a91.5.1773595326901;
        Sun, 15 Mar 2026 10:22:06 -0700 (PDT)
Received: from [192.168.0.109] ([155.69.180.3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35a02e19708sm18796590a91.3.2026.03.15.10.22.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Mar 2026 10:22:06 -0700 (PDT)
Message-ID: <eda5f191-7dfa-4bc0-8ab9-225b20a5e88b@gmail.com>
Date: Mon, 16 Mar 2026 01:22:03 +0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] apply.c: fix -p argument parsing
Content-Language: en-US
To: Mirko Faina <mroik@delayed.space>, git@vger.kernel.org
References: <20260309232700.553168-1-mroik@delayed.space>
From: Tian Yuchen <a3205153416@gmail.com>
In-Reply-To: <20260309232700.553168-1-mroik@delayed.space>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Mirko,

> +test_expect_success 'git apply -p 1 patch' '
> +	cat >patch <<-\EOF &&
> +		From 90ad11d5b2d437e82d4d992f72fb44c2227798b5 Mon Sep 17 00:00:00 2001

<<-\EOF should swallow the leading tab, but since you're using spaces 
for indentation here, that would result in a space at the beginning of 
every line, right? I think <<\EOF is correct here.

But Junio said you don't need to worry about it, it's all good ;)

---

The rest are just minor flaws (in my opinion) that you can safely ignore:

> +	if (strtol_i(arg, 10, &state->p_value) < 0 || state->p_value < 0)
> +		die("<num> has to be a non-negative integer");

I think something like:

if (strtol_i(arg, 10, &state->p_value) || state->p_value < 0)
die(_("option -p expects a non-negative integer, got '%s'"), arg);

might be a bit better;

> +test_expect_success 'apply fails due to trailing non-digit in -p' '
> +	test_when_finished "rm -rf t test" &&
> +	test_must_fail git apply -p 2q patch
> +'
> +
> +test_expect_success 'apply fails due to negative number in -p' '
> +	test_when_finished "rm -rf t test patch" &&
> +	test_must_fail git apply -p -1 patch
> +'
> +
>   test_expect_success 'apply git diff with -p2' '
>   	cp file1.saved file1 &&
>   	git apply -p2 patch.file

The 'patch' is created in the first test case, will it prevent the 
subsequent test cases from running on their own?

Overall, the patch itself looks good to me. Thank you!

Regards,

Yuchen



