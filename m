Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6557B229B12
	for <git@vger.kernel.org>; Sun, 30 Nov 2025 19:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764532506; cv=none; b=ZBXW+DnusHfiI7TWcai67MA4L/8pIgymdOsoRUV0h/lrQDTQYprAo3lLJ6ltjATgg8UadHGweoigSJCnd7qS1DcR8WgHcp268tF5A4P4UL5hrbiERtfhc5Vo3Ar7Q9XUa6Jf0CyFwPq00WD3Npd/AzpFjE2eyazzM1uYfzaKfgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764532506; c=relaxed/simple;
	bh=wiSDmi5CIBABL3XmUWTuWIYQkqRtEyikznyrjunJs/Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A48WJbsXSkBJjYsi81rzLRAe075JcN72ZznjjA4FOtm418bcyCHoOMGXR/BAOFfWE3OkOqLgIhrU0qvX6+3Rh20SxnSfTqS1sS8mI3RRlhPa4zW5H6O3TH5PvwVDVhzYkNrbOuVJBCUTihA2tmek1gX1SZ70jVMexgx24zo6f0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WTNBAS/w; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WTNBAS/w"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8b0f54370ecso340898285a.2
        for <git@vger.kernel.org>; Sun, 30 Nov 2025 11:55:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764532503; x=1765137303; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2fH0Hb3lR0iabGwJ+s7ygH0AZHxQ2OGtO5dPWKpZnK0=;
        b=WTNBAS/wcDiRBBUjcDYPsrx3/Skqh4NuFjrhcvSsvyzo7QD2n/scHO28dgQqlma4li
         iIfJRtarV0tsmJR/R8ZEiUbWYduoJXapPAOiV1zKRhD+slI7CAJt+3Q6nrEfu4LVGdqO
         ZEu+EYmWM+s+x7UV8WmG5NLaEl+FCp4JNNdgDpEsMi4GK6hbZq3FxJkE0LTiTKOwFdW6
         BI6j0AGb8kXYDn0FF2vR3AAcZOKEOpMBkvjByIMsxbvt5tg7HhaRmLtu7SwFgkgFiOU1
         sf8yw/CSW3ZX/TqZkm9KKWWvdY1Begb23NWRionRNQzawuAuTYdxd4l3oozBic+dkEvb
         Alcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764532503; x=1765137303;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2fH0Hb3lR0iabGwJ+s7ygH0AZHxQ2OGtO5dPWKpZnK0=;
        b=Xxk/7niOZcnj27nIwQbz0QgKGIccZaAslXpMINjFJPZ3Id97S9dwWYLlD+EW/61fwe
         dpyfPJNb6Ye2fk1OtTJCa8Zen7UhaZm7XVwlW/UrTjvKkZWCnoYI0zM8FPYzz7F0DeoD
         rPjrfZ0L+lpg2wO8G98ycu7053IBr6ZopREFXjCQ6W4OPvR7sECCqalFBYvkqQpaShvf
         k2a86F+eHxGM0CUHw4M3Jh51na84YrGMvaDFnejtOKNHEv1b7SpIAXjEIT6nw/hLcjxq
         ey9dx0eanVLShAKwdy5zSSZgW7FRx7TXpzqi/i/TLPTzZvz3mpDY5YpAOgRpFcUHy3Hc
         MP5Q==
X-Gm-Message-State: AOJu0Yw155WoNFlm/9VDUvoFqzRALko2RjJjn+m97TJ6l4zklJty/MOx
	tgVqDq3/VAKsZgxmRZHkgUlNJRrOrOZmfSfDBjc653Z7/68dFNkAR8Td
X-Gm-Gg: ASbGncv4FXtQYkfu8QciuSlRX+g+8ctS5OKCWF4x+k1rI6gAfu5/qCQdm+QNkpUcyfs
	lI9g0y781cHIWMC2OI/Dq/HDbFFZUP+G265qltRV5dX4Z5rixS7Mr1D3pzZjUuURijfXVJLnW8N
	lydCKPFXqMe9OUCNNyYLXwZ8G3+WuoVxbl5QGAJWXmiXqGZMG8OgHmu5VxSOJUdtnP8AEtANxAL
	sepi/RUcMJryTVpUln/GD9MiO82+MOKB0iGEJumuOc3lOT1uBWkd1vP9o4i3BrhTZ688z2qNOvo
	ONakGrRSVBVrgCO0D6aJfCgZAeicNPkmAJ7rgRcg+YMfd9xfn3/Rcc7IdJ5wAAauN+IJelDkzTa
	EEf3dPN9m6KyhKmyytpBkDRxcYGJeT3cNWbWyzXkuoYBBMUMirQkKxFescf4UzmYVwy0p6hFD+2
	8I9jdnSynoMIiXeObL5Vc3SeNWJtsP7J7eGoNR6ZcqGvn3rdJ/GozUe8rDgg==
X-Google-Smtp-Source: AGHT+IEkmzkqOCnPUxwxMdG06cdHm5cAS90d8TQyt+bw91/D5gkZ35fl8rXGRYwpz5xPrYcmq0Lpyw==
X-Received: by 2002:a05:620a:3f85:b0:8b2:f29e:3af8 with SMTP id af79cd13be357-8b4ebdc0bc7mr3404828585a.59.1764532503192;
        Sun, 30 Nov 2025 11:55:03 -0800 (PST)
Received: from [192.168.1.109] ([136.61.121.155])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b529993ca7sm731467885a.9.2025.11.30.11.55.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Nov 2025 11:55:02 -0800 (PST)
Message-ID: <089c3225-82cb-4039-83df-f97ea9fd49b2@gmail.com>
Date: Sun, 30 Nov 2025 14:55:02 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] scalar: use index.skipHash=true for performance
To: Junio C Hamano <gitster@pobox.com>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, ps@pks.im, atthewhughes934@gmail.com,
 johannes.schindelin@gmx.de
References: <pull.2010.git.1764195516.gitgitgadget@gmail.com>
 <1c51dbb81485920e9faf336ffbda9d9258e7dfe1.1764195516.git.gitgitgadget@gmail.com>
 <xmqqldjsl53m.fsf@gitster.g>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqqldjsl53m.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/26/2025 6:57 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> diff --git a/t/t9210-scalar.sh b/t/t9210-scalar.sh
>> index 43c210a23d..91d5964b73 100755
>> --- a/t/t9210-scalar.sh
>> +++ b/t/t9210-scalar.sh
>> @@ -246,6 +246,11 @@ test_expect_success 'scalar reconfigure --all with includeIf.onbranch' '
>>  '
>>  
>>  test_expect_success 'scalar reconfigure --all with detached HEADs' '
>> +	# This test demonstrates an issue with index.skipHash=true and
>> +	# this test variable for the split index. Disable the test variable.
>> +	GIT_TEST_SPLIT_INDEX= &&
>> +	export GIT_TEST_SPLIT_INDEX &&
> 
> Interesting.  I would have expected to see a simple "sane_unset",
> instead of exporting an empty setting explicitly.

That's indeed a better way to do it. Will do in v2.

Thanks,
-Stolee

