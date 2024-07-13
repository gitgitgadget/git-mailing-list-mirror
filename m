Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0461CA84
	for <git@vger.kernel.org>; Sat, 13 Jul 2024 13:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720876679; cv=none; b=WFCOzoKhruWCNZjDy7ONt1CtRs35XvSepozlVy2NxFQZsJbn1Xkbdl619ZrnP7J3VZEgnjX6MhgRl9nKloXdR8HgZ1TgcBwEyQeUjle0F4e85PjExvSiXAiEWxx3QAA3a2oFnXCG4eRvW0KqelF8wZuVuiPbBsN2OFiUS46gzT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720876679; c=relaxed/simple;
	bh=clzr+YP4PW+ZbjXnHt0zl5ygFt7ur3/XR4VMXue2rns=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=LDe8n3M66+ewy4m5UBBb6UUx8izPpx8Sj58Y+pystUlreCbyRBb9UK+DtRsIjm5wycbtuZSu8fjYNf7QeqaZz/SgeaoK3LpEwew/zihbDsEEkhWTHtVRc/7opYQQ5wGMUXwt1xWFkE4m8Nt3Cy85wd94wzAd++PbF8BIFBhxpLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lsYOsStF; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lsYOsStF"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3680667d831so769488f8f.3
        for <git@vger.kernel.org>; Sat, 13 Jul 2024 06:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720876676; x=1721481476; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TKEe5iGqQ2wty79qpV0cpmu1OYJ6WYC1J+ydegf2WeE=;
        b=lsYOsStFm/tb27wEOY9GA2aZWQ/o1DotVMvWJqHEiw14seFxCOskxvRXa5C0jl5XjT
         pOz/YWIO+zwBHvlDmG5ciPIDtzQWTTWIcgTeJWvG+3BcZXjUI+39GFpDV3lJdOm1Ey2y
         gh3Le1DsiblNoLZ7ih1T79Y1gVY0PAPf4zp00cphqBmxPcEdqJd2S+PkYL+BOmGUi3iW
         GnaVx7fDC39e+66YIEhw/6rmZRI/EkokvoCbgNlAAVtbFkHDUPza633vxGppMZJ/K5dQ
         EkNj2HY+tG+ztW0+eSadZZVv/pe8SrlUlFjOPqCPCeYCqsJsgmGz2Q8earWUUohHjO+e
         o+zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720876676; x=1721481476;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TKEe5iGqQ2wty79qpV0cpmu1OYJ6WYC1J+ydegf2WeE=;
        b=JbRy+BjOYJNE0R11AAVf1leUieDWAihsL2uVhTE7Hjn12ML7GR6QYkKjkl9ih2KAvr
         WGi7V5Y6bpsaI/Tra/JIRXA0aepTrNi8h3xupaZA/gss2PdSIbjuMJgHUD+Hwk/xLQYo
         s/+Tteamm1N/VT/UqVU5jaOKkZLCZYYLnaWEWXEMVKNDiEmAHLW1kvMTYXrYMZRBwOMP
         0mlIlNv0t48fYa9k0ooMWdDQp+Lyk/tPA27jK7vlJKMEhjkL4ILPymNfNml42xZEJtBm
         bnBi7PrOv0z/8ZV/ziZn45p9tuc7/mvCbzDDBaV4ok0qV7vKSYSrl1gtwnInls3d9XFg
         sOog==
X-Forwarded-Encrypted: i=1; AJvYcCWNnKfbhZFKELMdro09MG/p5SF5eAQLF337AdgCvIbhODqD7bbdB/+ZlMDtFKmtyY/7R92ShwFM4lFtDssD9wD3Q/iq
X-Gm-Message-State: AOJu0YyCf7cd/gekEXeiqIx66BrcYXVxD5tZW8v+vF8wkVgPwGWlODKM
	CjppSRXteElkOiYgB/+/iXfrgoKzaZp4596pnF8SaFHsEb7V6osk
X-Google-Smtp-Source: AGHT+IG0GKYgFKpetV7ijvzsfGf49bHBe18gg5/1//dyIYd20g7jH3cT+LqqyJ1pRwwlw+rrpOJ9Ig==
X-Received: by 2002:adf:e64b:0:b0:367:9795:92ba with SMTP id ffacd0b85a97d-367cea73740mr9157854f8f.23.1720876676128;
        Sat, 13 Jul 2024 06:17:56 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:600:8501:575d:f6b:be83:bc74? ([2a0a:ef40:600:8501:575d:f6b:be83:bc74])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3680dafba03sm1385275f8f.76.2024.07.13.06.17.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Jul 2024 06:17:55 -0700 (PDT)
Message-ID: <9a2feb36-f8c4-4ea6-91a6-a3a24f359a6e@gmail.com>
Date: Sat, 13 Jul 2024 14:17:49 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 4/4] add-patch: render hunks through the pager
To: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>,
 phillip.wood@dunelm.org.uk, Git List <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Dragan Simic <dsimic@manjaro.org>,
 Jeff King <peff@peff.net>
References: <2653fb37-c8a8-49b1-a804-4be6654a2cad@gmail.com>
 <5effca4d-536c-4e51-a024-5f1e90583176@gmail.com>
 <803b10ed-1cb3-4314-82c9-cf48d5d0bb90@gmail.com>
 <ba8ad59d-d125-41d9-a482-ee8eda187762@gmail.com>
Content-Language: en-US
In-Reply-To: <ba8ad59d-d125-41d9-a482-ee8eda187762@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/07/2024 17:24, Rubén Justo wrote:
> On Fri, Jul 12, 2024 at 02:26:22PM +0100, Phillip Wood wrote:
> 
>>> +test_expect_success TTY 'P does not break if pager ends unexpectly' '
>>> +	test_when_finished "rm -f huge_file; git reset" &&
>>> +	printf "%2500000s" Y >huge_file &&
>>> +	git add -N huge_file &&
>>> +	cat >expect <<-EOF &&
>>> +	<GREEN>+<RESET><GREEN>22<RESET>
>>> +	<GREEN>+<RESET><GREEN>23<RESET>
>>> +	<GREEN>+<RESET><GREEN>24<RESET>
>>> +	 30<RESET>
>>> +	 40<RESET>
>>> +	 50<RESET>
>>> +	<BOLD;BLUE>(1/1) Stage this hunk [y,n,q,a,d,s,e,p,?]? <RESET>
>>> +	EOF
>>> +	test_write_lines P |
>>> +	(
>>> +		GIT_PAGER="head -1" &&
>>> +		export GIT_PAGER &&
>>> +		test_terminal git add -p >actual
>>> +	) &&
>>> +	tail -n 7 <actual | test_decode_color >actual.trimmed &&
>>> +	test_cmp expect actual.trimmed
>>> +'
>>
>> What is huge_file doing and what happens to the single line of pager output?
> 
> The huge file is to make sure we are receiving a SIGPIPE.  We don't
> really care about the line "head -1" produces, only that we don't
> break due to the SIGPIPE that occurs.

As Junio said it would help to explain that. I'm still confused why we 
don't see any output from the pager - shouldn't the pager print the hunk 
header as it does in the example below?

> Maybe a test like this would be clearer?

I think explaining in the commit message would be best.

Thanks

Phillip

> test_expect_success TTY 'P does not break if pager ends unexpectedly' '
> 	test_when_finished "rm -f huge_file; git reset" &&
> 	printf "%2500000s\nfrotz\n" Y >huge_file &&
> 	git add -N huge_file &&
> 	cat >expect <<-EOF &&
> 	<GREEN>+<RESET><GREEN>frotz<RESET>
> 	<BOLD;BLUE>(1/1) Stage addition [y,n,q,a,d,e,p,?]? <RESET><CYAN>@@ -0,0 +1,2 @@<RESET>
> 	<BOLD;BLUE>(1/1) Stage addition [y,n,q,a,d,e,p,?]? <RESET>
> 	EOF
> 	test_write_lines P q |
> 	(
> 		GIT_PAGER="head -1" &&
> 		export GIT_PAGER &&
> 		test_terminal git add -p >actual
> 	) &&
> 	tail -n 3 <actual | test_decode_color >actual.trimmed &&
> 	test_cmp expect actual.trimmed
> '
> 
>>
>> Thanks
> 
> Thank you.
