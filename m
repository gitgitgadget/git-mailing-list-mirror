Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833EC25B1FC
	for <git@vger.kernel.org>; Tue,  1 Jul 2025 19:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751398426; cv=none; b=U57M1FynUDTo/uMki28bIcDNfKs4rs55S5K6ndGkMPpdFk/AsoLgXzlNrkaDhRQj2lzXFL/GqsnyUuhp8dfY2x77kofn9R0aIrzurwO2XIRB94Rexioc7IrXrzorIFmCSjUOOh1Wx2O4JtMblHfeX95zTdSeW4gKwBBYYOkULvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751398426; c=relaxed/simple;
	bh=0W7awO0bRelqASzZfzLF+zIx4tw8bH3ArMNh1UCY4CA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=nPhIOw9ZGmtN38vRBPPd4vlgz7HoCdz5pu9qOS4tVxd8bfbe2pmdo8ZjWepWt07RI4Z8du43wb96B19XqXIYn+f5Yq/vEAQ4YyCX0mDeF2bi2qTnk/uYEhbpCLozm8xhC4JgFMTkrI5616OrmE8v6AgH7dnIwsz7UpwFPbXWUR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mM+/w8dG; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mM+/w8dG"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-451d3f72391so38409075e9.3
        for <git@vger.kernel.org>; Tue, 01 Jul 2025 12:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751398423; x=1752003223; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fFI2vj1SwvVshpyFurGtdM2rRWUsnPfuP0hEuIroa0A=;
        b=mM+/w8dGCnbbYbrooagoGwsfEoP0T29py4a1tzZlxCpUcsSMQlAAoHm9j0vjXlGlDO
         G55pajvm/qDWAIzkqqZyjS/Kd5BWHt1vjEm0PcCvtyahERwKqBJbJNulS9SmVEKa03bY
         3ZnrEAgEJOV0tF4BLxXk4ijfkgn0Ln+JnK966E3s5HbxxE+qa/OsLlyy4Q9UGKmFBB4j
         kvQ7UpG3P3JirhQE67L6tFvLT3JytmuYSNq7i8hXKdDP/Rn6vnfsRxH4j154yW7ox/Uk
         S6ESaPEkO7T07vWulGPhzym/mnh0215g2YnIkFFJ4GCea0VCmbcGWvPJfHEdYq5+C0x0
         yGXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751398423; x=1752003223;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fFI2vj1SwvVshpyFurGtdM2rRWUsnPfuP0hEuIroa0A=;
        b=A4ceHZ6pnXQI7suiA6jEG0mO0YTWFntt27eTrWsNKBw0whD3XCD3bVTNAZ5hpUHyV5
         9HHYT0id10CuBvxkIVlOsVNOKZlZoIhZ3UgQml2a6A/g6cx9Xm7RcXlXOMs2WRtjQM4+
         mudITOieazf4bjdZ7gdwpEOnlPnnC2NDbKHfwuveaywGkX9drdQEJE9GyNLRrMP+ehWj
         V/vXsa2BWWZKOBx/jtEcTvTCNoZPVUZztik9268p0cQ/YpGl+b0oHovoLvblXv5O5GP5
         I6udU2XwmJb6eGWcn4tMI8huQJ6sk74kiXaFYnpDezsM2qPBVFDjsV/AzSP0scThdpdc
         vHiw==
X-Forwarded-Encrypted: i=1; AJvYcCUl2Iqn+8kpoiwC8gzGusvhp/vggymBRegjCMA79Yf6vWlxaLzPN+2y0oxteIk65ct9DO0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHujGQ+F4jM0R/ySHK2JHUfbXWWgQvuua4kzGVhHwigAYptYqa
	HGAdTTk7usyIUDkR7WqbdqB0RLe4JuZCBFkPLGZ8EWvqOULtsSvVIGWK
X-Gm-Gg: ASbGncvoEum8oqbOsSDA3FBF3DNMM9C086/ia1g0yrn6zxaDX4gyihH9ky8sCR1g6wW
	Vg2pTvfYJiyOKOyweUR0S1qKjhuIsxP0UUUXh9XqUB+ZWJKgL0xrW7UtIBCNOEPOG7zt4BFHO/4
	BUBvzimu7dRbMH6Jd3MCGDE1z5e19COXwvOGzjhbxA5F3jSWD/Ee+UZ08VXgofAs32G1EmUcdFn
	ucYIK395fgfVZ8BJ52DSSTZbsinbJ8G4m1+1khNsAAhvxVD4UHxY0t65/Z6flsip/6k9pnKrYIA
	sSExIgHJPxkw8e9CS769x5zLD+R2P82Yp7PXpdTsPBMhmIo4TQiDeejwhMePcMpDFAm5DecORIr
	xINpudDZ9pTIpSjBcEywReN6sEyk1qHaO9NaGOQ==
X-Google-Smtp-Source: AGHT+IG3BohbgOlD8RroqChwH+DQMXuUDgR5LIlG6J/mdw0nG/nG0EUbGCkgEKLO3H1FNVQg5d5K9A==
X-Received: by 2002:a5d:5f4b:0:b0:3a4:eb7a:2cda with SMTP id ffacd0b85a97d-3a8fee64c9bmr15417763f8f.30.1751398422496;
        Tue, 01 Jul 2025 12:33:42 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4538a40766csm176625125e9.32.2025.07.01.12.33.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jul 2025 12:33:41 -0700 (PDT)
Message-ID: <628e4050-912e-491d-b55b-a054623db32a@gmail.com>
Date: Tue, 1 Jul 2025 20:33:41 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3] daemon: correctly handle soft accept() errors in
 service_loop
To: Junio C Hamano <gitster@pobox.com>
Cc: =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>,
 git@vger.kernel.org, yoshfuji@linux-ipv6.org,
 kristofferhaugsbakk@fastmail.com
References: <20250626172159.87204-1-carenas@gmail.com>
 <20250627231404.27100-1-carenas@gmail.com>
 <0d507273-8b8c-42d9-a14f-27a5da0dac27@gmail.com> <xmqqv7od452s.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqqv7od452s.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30/06/2025 16:33, Junio C Hamano wrote:
> 
> Thanks, both of you.  Shall we mark the topic for 'next', then?

Yes, I think so

Thanks

Phillip
