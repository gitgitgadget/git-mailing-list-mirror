Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4405328DD1
	for <git@vger.kernel.org>; Wed, 17 Jul 2024 19:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721245154; cv=none; b=PhLGTVsHK8/RRzam3jB/4BvatxURCWt9q3ZkJk6K+0vlqroz5jvv98/eFOsNuYnZDTrpLqbRVjeStqz5+MQDyP//HhK/SyE6Lz4q+edMIgE+hvyuZt/CZkhIRyo4frW7IshZVmVYE8JFhzpFcBnOEj8wo+UK2uA6g/CCu48CTbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721245154; c=relaxed/simple;
	bh=wiKJlyw+yeX04QkcZ9ICpYvN887HR9+4ldHLVC+mJKo=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=G9+nm5XK8KgIhszKu9VjcB5qz1VPSpdz903cVRomwzJDvVoxEm/LRh3PAw4DOTG9L2kvVvzkSVEUyVEBzW5R2Pmk2YcOBhOxhrWLzRP/ZwripqDybPv3ltyWkt1trQ+fRR8wl5tiLr4LUe+xcM6i3gKmZnm0w+b8hE1VoVI8xpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gXdDhJ8r; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gXdDhJ8r"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-36798ea618bso48068f8f.0
        for <git@vger.kernel.org>; Wed, 17 Jul 2024 12:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721245151; x=1721849951; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1vAEknQPeb9utYa+SSTKP1FoVGTn8C/ngG+BqoLDYc0=;
        b=gXdDhJ8rWYMR2tcEMgmX4tS2UQ3f0vZtZEojwPo9ZShbRfJqHuPBYGUMuF/rDpdPXV
         RsB0iewmZd9DpHoDRYn3ZzCe4LsNl97uglrcJLJ2wKfPOnsVdb/UEWg/a4UoyYo4Z7Rb
         gJA5LY1Ql7wfmzkZ1Eg5qkLturtG/JgiH4Jw8Zna+jGHJ5n8Ul8Pl+Smm2ko7MwJRyIw
         Scjl34ubO8N8vAD2Gllwueg+Bs8Tt7aEyEHu/wiVO617u7mCf7fArRq7oE3PG0751mdM
         5AZ1JX3FyyptGX6fdtLEN/g+ri8Q9iEQ5rpQ6LO/SaLhuYlqb0b1CrdWA6US1Vj/BZ7f
         Z4dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721245151; x=1721849951;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1vAEknQPeb9utYa+SSTKP1FoVGTn8C/ngG+BqoLDYc0=;
        b=vuAt9nfzNuDKHUXbaY3IvMkYsoOAByUkUtb44JJpYoVD3gjFny1CywMMHyT9MKEFE4
         mBY25P9oh9Xres/0krhdEZdUMu6prHS5qlhJoWNO+vjvZkyd+vx+ur8KEliIdbA8ieMq
         NhyEsF9jXzZl6Uby2xUHhXLCKx3FK9E6dZY46Sqg2wdfC/NbLV7+s411Cg3kStdWkCdX
         awRLWqW5/EuOE9UxBvHtfwxCeEjTiqAgyntiWBM1kF4i5GPCtfJpIxeXIkge5dvnQKDL
         fm0z23OF9c6zFdcHMmmzPo7vMoqyAhyJvXUCmDQ5+vLD1L+CSXHNMVsUuYVtSid6uNtR
         uq4Q==
X-Gm-Message-State: AOJu0YxDNdmhL3B7Jfkoq/YHEYOvSraiPIemyLBqwQB1GZynJx7t3zTx
	/N8Mmsl83N1KVJfJFaPT5IeWjLbB1bSjfii4gRAMeIMOednRGt5+
X-Google-Smtp-Source: AGHT+IHL40Am/YhozfldhgNqwR+deQHHf7QamfV3rSPOO2Ra0yZ/vgiuuq5/XCERdnKh/YwSNg2cWg==
X-Received: by 2002:a05:6000:1a47:b0:367:83ea:9a6c with SMTP id ffacd0b85a97d-36831609504mr1632455f8f.24.1721245151244;
        Wed, 17 Jul 2024 12:39:11 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:600:8501:575d:f6b:be83:bc74? ([2a0a:ef40:600:8501:575d:f6b:be83:bc74])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3684b9bd6e6sm314709f8f.43.2024.07.17.12.39.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jul 2024 12:39:10 -0700 (PDT)
Message-ID: <88f9256e-04ba-4799-8048-406863054106@gmail.com>
Date: Wed, 17 Jul 2024 20:39:12 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 4/4] add-patch: render hunks through the pager
To: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>,
 Junio C Hamano <gitster@pobox.com>
Cc: Git List <git@vger.kernel.org>, Dragan Simic <dsimic@manjaro.org>,
 Jeff King <peff@peff.net>, Phillip Wood <phillip.wood@dunelm.org.uk>
References: <2653fb37-c8a8-49b1-a804-4be6654a2cad@gmail.com>
 <ebcba08f-3fbb-4130-93eb-d0e62bfe0a8a@gmail.com>
 <efa98aec-f117-4cfe-a7c2-e8c0adbdb399@gmail.com>
 <1dc9ebad-768b-4c1a-8a58-8a7a5d24d49e@gmail.com> <xmqqttgqyzwa.fsf@gitster.g>
 <2b57479c-29c8-4a6e-b7b0-1309395cfbd9@gmail.com>
Content-Language: en-US
In-Reply-To: <2b57479c-29c8-4a6e-b7b0-1309395cfbd9@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Ruében

Thanks for looking into the test failure.

On 17/07/2024 18:20, Rubén Justo wrote:
> Squashing this fixes the test:
> 
> --->8---
> 
> diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
> index c60589cb94..bb360c92a0 100755
> --- a/t/t3701-add-interactive.sh
> +++ b/t/t3701-add-interactive.sh
> @@ -616,7 +616,12 @@ test_expect_success TTY 'P handles SIGPIPE when writing to pager' '
>   	test_when_finished "rm -f huge_file; git reset" &&
>   	printf "\n%2500000s" Y >huge_file &&
>   	git add -N huge_file &&
> -	test_write_lines P q | GIT_PAGER="head -n 1" test_terminal git add -p
> +	test_write_lines P q |
> +	(
> +		GIT_PAGER="head -n 1" &&
> +		export GIT_PAGER &&
> +		test_terminal git add -p >actual
> +	)

That's surprising, why does running git in a sub-shell stop it from 
segfaulting?

> ---8<---
> 
> However, this error has exposed a problem: calling `wait_for_pager` if
> `setup_pager` hasn't worked is an issue that needs to be addressed in this
> series: `setup_pager` should return a result.  I was planning to do that
> in a future series, for the other commented command: `|[cmd]`.

What was causing setup pager to fail in this test?

> I'm wondering if the best way to proceed here is to revert to:
> 
> diff --git a/pager.c b/pager.c
> index 5f0c1e9cce..5586e751dc 100644
> --- a/pager.c
> +++ b/pager.c
> @@ -46,6 +46,8 @@ static void wait_for_pager_atexit(void)
> 
>   void wait_for_pager(void)
>   {
> +	if (old_fd1 == -1)
> +		return;
>   	finish_pager();
>   	sigchain_pop_common();
>   	unsetenv("GIT_PAGER_IN_USE");
> 
> This was a change already commented here:
> 
> https://lore.kernel.org/git/3f085795-79bd-4a56-9df8-659e32179925@gmail.com/

My worry was that this would paper over a bug as we shouldn't be calling 
wait_for_pager() without setting up the pager successfully. How easy 
would it be to fix the source of the problem?

Best Wishes

Phillip
