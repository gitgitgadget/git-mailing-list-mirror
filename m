Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034351E531
	for <git@vger.kernel.org>; Wed,  2 Apr 2025 13:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743599537; cv=none; b=HCiJonWEMSdGEcibiLjFO1SfGgZYRVe/F480HkYrloVVR2PdvMwO9k38QuoaePuTmuo1eKtB7UnvPs6oeaSbvD00llcYmEgv5/Na1SjI3GMg4IqhToxfvr68a3GT+5obADp+3CSKPN15XZDOuG4/vxO8vydeIIUKLMr426BeK4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743599537; c=relaxed/simple;
	bh=1lYUbAVLjmSMR2Z7SiFJve/vWpXGJjEMbJPqURA5mm0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=E2D4bNR/fb+D9MOv2u3bHqayVNGxvA1VxpHHHMbIE2Y0woEDE4VeZuYMAAnz9PX/ss3+jQBDeWuRzwWy1tjePNwzaUj0a717lI+05MLC/CsshLnN5eTrzPBW03Wbx6k/Nviw6/7Gb44X5pcnn1GnuXrhZ5cj38qDm5kSVeiIoQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JN7gaglN; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JN7gaglN"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-39141ffa9fcso6601982f8f.0
        for <git@vger.kernel.org>; Wed, 02 Apr 2025 06:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743599534; x=1744204334; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ObUbO/H7v7TITlCK3Iy3ADG/DNCSl9PpJjOfcKdLg3U=;
        b=JN7gaglNdjgMmoFpnQryQYNMV55MrsSw6/wOr5mbzNUCOisRMMeUlErVT4FJ+8Lvlp
         hMvNH7OIUXHRmxt6fdfLZWm9F9dkV4/D6fcYshNgPjwiGwT/Dh1otO+/Sf0oERxQfw/Y
         eebgYY8xTTbypXpoMBejnXeSA1/N8cbyTR5thpO1/vAHaCfCXPspqQpq02gFBHWEHzIV
         J/zKNmj+s8vsR69OJ5/6GRYWaRVrPZ3+c0YSi5KrKERlfgL+jHVSa0KC9DtgZ7V0OYC7
         SYixj+5CDKsR4DO4ob2zO1N5oqzBoJn9AjT8S67GIGqv40CdYnaexd+uYCZubFsmZEUG
         cKMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743599534; x=1744204334;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ObUbO/H7v7TITlCK3Iy3ADG/DNCSl9PpJjOfcKdLg3U=;
        b=cp15rxTTL0yiwoeQa8tuTqxAD2K4OYpypNIVPujSbemseyuGnxHSALCRquZjbPwOTJ
         3cLfKrWrNX2HYXrlszKq68N4+0ZN0rPv+U//2AhpTypsCDQ5wrpek2dj0a7hgD+4PZZb
         W7dISIwafcuNfSKKacnxap9Taimh3dilj2zq0b8uMsXP4agTNUUv+zMBkSV3lyIeyn40
         YLJzdQ139/SjOgePlQOOXPaZ2bIsKJNiIqRpr/EpN3KmTEKxbstrfAQowsvHCLbiqYRI
         YrnHLsGsz8G55D7qu/BcBiHyD8LsLYzOaQGtkgw2tFJVOj35mp2NUZ7xB09vVIztuKPO
         XQrw==
X-Forwarded-Encrypted: i=1; AJvYcCX43eAU6nfH23onc253Ac/b207P80eQ9Kg08ZXnAL4NdNPhxRe+2CCnuS7E4JRsWUIm/tc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAnb9bCmknnzKZq4zOqfMSUMUf0C5GgQ85GAHEyOdMU3blneQn
	gY8QXAJA4dywU5AHby5zIw1YkYO49C5hRm6TD33Xu3zGEcSgWSRA4fgoqQ==
X-Gm-Gg: ASbGncsXjKcSVsdSZLExSL+sjnzzRrf17z7vYFlydPft5DyLvfSCoT8JGX7hRF8Olpm
	RkmRsSCuZILTJ5VQPjn3I2zTqzpqrCk8b2MOncv6WV6VYzrrigJ59W7urjtZyY2TY7mw0n6ubpr
	9h/7uGd8wZGmJ+srtV0tRjpXAXBwq7rjwHgPJRXznyPgEyWsmw6bFL+XSYkEj1N7MVDQxBlNtpA
	FRu5hGGnScPmd6e2HmZU7oW62EsqFaVK0CLIKUoPWgvPdpyrinpK939GpCPek0tcWVFj9ivLAkS
	LFhFVOyQW7U4nZXU/HdHqgG5PkpPtpXlxtWJvHn6HrQ3p1gALeLcrisRf7paGkeO6Pu3qOBxY9x
	ZYeZXFu9gZmtxjW361fOj
X-Google-Smtp-Source: AGHT+IHjWzsjqUcHZw8CwtuVSV+3mlrycK3sBGoQeSvEQf7L8Q9UhXXWWVzf1GCuzrfb5uBqjML1Dg==
X-Received: by 2002:a05:6000:4590:b0:391:4c0c:c807 with SMTP id ffacd0b85a97d-39c29807418mr1585455f8f.53.1743599534250;
        Wed, 02 Apr 2025 06:12:14 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c0b7a4482sm16573340f8f.86.2025.04.02.06.12.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Apr 2025 06:12:13 -0700 (PDT)
Message-ID: <63e79534-db09-444f-8e82-8e01d914182d@gmail.com>
Date: Wed, 2 Apr 2025 14:12:07 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] revision: fix --left/right-only use with unrelated
 histories
To: Matt Hunter <m@lfurio.us>, phillip.wood@dunelm.org.uk, git@vger.kernel.org
Cc: Johannes Sixt <j6t@kdbg.org>
References: <20250330055809.1019090-1-m@lfurio.us>
 <f8a7d089-3150-4212-8ad0-c9bbb3858776@gmail.com>
 <D8TJMUMOGLBC.3FR8DHTTUN4M9@lfurio.us>
Content-Language: en-US
In-Reply-To: <D8TJMUMOGLBC.3FR8DHTTUN4M9@lfurio.us>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Matt

On 30/03/2025 11:54, Matt Hunter wrote:
> On Sun Mar 30, 2025 at 6:11 AM EDT, Phillip Wood wrote:
>> Thank you for adding a test. We have a helper function test_line_count
>> which provides a helpful debugging message if the comparison fails.
>> Using that and avoiding process substitutions we'd write
>>
>> 	sort head >sorted_head &&
>> 	sort cmp >sorted_cmp &&
>> 	comm -12 sorted_head sorted_cmp >actual &&
>> 	test_line_count = 0 actual
> Thanks for that helper tip.  I was just about to send a v2 when your
> message came in, so I'm getting that incorporated now.
> 
> By the way, I had originally wanted to write test assertions that
> checked the actual number of commit ids returned from each of the two
> calls to rev-list - something like:
> 
>      git rev-list --X-only HEAD...cmp >file &&
>      test_line_count = N file
> 
> But since I'm not very familiar with this test harness yet, I couldn't
> actually figure the correct value for N.  It's not 1 (the commit made in
> my test body), and it's not 2 (that commit, plus the one from the setup
> case at the top of the file).  Any appropriate higher value wasn't
> obvious.

Each test in a given file runs in the same repository (this is a 
performance optimization) so the number of commits will depend on what 
the previous tests have done. Usually there is a setup test at the start 
of the file which creates some commits with tags. Individual tests can 
then use those tags to establish a known state.

Best Wishes

Phillip


> So I switched to what you saw in my v1.  Maybe this "no commit ids in
> common" test is actually the stronger assertion?

