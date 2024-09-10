Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FFC8339AC
	for <git@vger.kernel.org>; Tue, 10 Sep 2024 08:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725958232; cv=none; b=eyR/ndFyS8OrOwPp2LStRAVXD0SBtZ/DYIAxXQfl2nVgwkFFMDVHXNaDSMbvQ3rC0+L35ywSn4vel4LhWSQIBbyOncun7THRyla+vuziyu6wY5dnBArSnbV//ztaNhhPVpYidv3+a/33RINitVmsBH7tidxJoVe4LAkfWZ4a+1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725958232; c=relaxed/simple;
	bh=d0gb4VTZzEMbVQLI+m9DzMwsqENMLmxiMxIb5uIXC1M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y7imax4bWKh8d/IYHexLTTkTQTE1HV3iocnx4mv42iSHuZSrcDo5Lu+J6mYeIutu4xOSs7OTOzfMAZoE2itabGQjUARRk0Tl8pNr814UgMrr+Mxg5/R2N2JLdhZPF+LPBD8s3n1X2iHizWroNACX/HqfDHPz2PFR7/NnClqHR1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bhIFer6L; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bhIFer6L"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42cbb08a1a5so4819685e9.3
        for <git@vger.kernel.org>; Tue, 10 Sep 2024 01:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725958229; x=1726563029; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zYMAuud05LOiP7TcQutGfEalT15AyepgCJA/kwhCeKA=;
        b=bhIFer6LPSsJ2FgEDN6hRGef5oZ8VbfyJfO4C6K3PeTbOmaU+1fVyeD2Xi8t9oHl1v
         Upr1ifOVar42fO8/zeQd90DjdBXV7bCdScpSMVFXJO2HF2bm3ih9MATcyDUcvvvZ+j2R
         qOCLsRMLjlYGgaBa9z+5vXI00iGtyft4Wlr7kjn+lhut5dpZqzKWaYHMZLpUgnyd5x9z
         Cap0EK0bqdxlIyuE+cZJu3rQa5GQ2d4cN0oSxHj0vTynL4Lylf6uW6JsKf9j8h9TACpw
         xGOqVg1x7Lv27/ve5r+0lAqg00oJIT/UnujpaDc2AbjilgbNNowS7i6VpxuT9a+PmxSn
         8JVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725958229; x=1726563029;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zYMAuud05LOiP7TcQutGfEalT15AyepgCJA/kwhCeKA=;
        b=rVXb6bcmGfyV5fZSxvDKylxnHF6Bogz/Owm7qwOop1L080YGo2d0c0NG4bax3nXVXK
         3OiGGsO55W2QPqI7kwrIHgomf43hnM69OcxhnzG1oNx7u17qSoX3Pq68jfKCKD/Bwx22
         aDx7OgcpBW3ylT0u5Ycmjg0OjpHuQkWs36izcfKeFnR+pTq/ByGb9sIyDjTsqto51KkT
         sDP3YpKj3wsJ6ddgVwxWhrf585TPddsdw2sp5IF9RoKL7heYH0JCMLEgxK+8RndZ/sEr
         yJOtkDkrchfH+Us4f+xgKGQMuYq4lqEGfEL3iAECNYzVJ2NLHK1GpSXHZP3YN6p5nEEB
         /UVg==
X-Forwarded-Encrypted: i=1; AJvYcCVAu++z3x2qPA5hWDAOts1s+7jt6c+WYVJEX+fkLry4K0L3paWxHTrfbUc5tf4p8x14y78=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0ocBUdUleKGPmAcplS3twqLPdeoQGk0umHI/etfAe2bue4pMy
	87hvK/af98HC0Pa9pNYrJAcdQPinW0syZPmn9pp+n88stdo51upL
X-Google-Smtp-Source: AGHT+IFWEVI6mkYnPXeYJ5wL+O/DpW9oHZfpkp0yhYNCHXJMtoqMv8kdrD84KHESgPSo+almbGduhQ==
X-Received: by 2002:a05:600c:1e29:b0:42c:b22e:fc2e with SMTP id 5b1f17b1804b1-42cb22f02f8mr64761515e9.15.1725958228831;
        Tue, 10 Sep 2024 01:50:28 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:6d3:8001:7151:e3a9:f71b:e7d9? ([2a0a:ef40:6d3:8001:7151:e3a9:f71b:e7d9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42caeb33489sm102895085e9.19.2024.09.10.01.50.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Sep 2024 01:50:28 -0700 (PDT)
Message-ID: <c8d65466-a9c3-4556-84c1-3daf0c7cea14@gmail.com>
Date: Tue, 10 Sep 2024 09:50:25 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 4/6] config: add git_configset_alloc() and
 git_configset_clear_and_free()
To: Patrick Steinhardt <ps@pks.im>, Eric Sunshine <sunshine@sunshineco.com>
Cc: Calvin Wan <calvinwan@google.com>, git@vger.kernel.org,
 Josh Steadmon <steadmon@google.com>, spectral@google.com,
 emilyshaffer@google.com, emrass@google.com, rsbecker@nexbridge.com,
 gitster@pobox.com, mh@glandium.org, sandals@crustytoothpaste.net,
 Jason@zx2c4.com, dsimic@manjaro.org
References: <20240906221853.257984-1-calvinwan@google.com>
 <20240906222116.270196-4-calvinwan@google.com>
 <CAPig+cRKbvWT3Bx65-ULAYRSrrKTCL0C7r6xpNSdN5JjLBPjCQ@mail.gmail.com>
 <Zt_qM8ZGN4fnqUoY@pks.im>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <Zt_qM8ZGN4fnqUoY@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/09/2024 07:41, Patrick Steinhardt wrote:
> Is there ever a case where one wants to
> allocate the configset, but not use it?

That was my thought too - I suggested providing git_configset_new() that 
would allocate and initialize a config set in my response to the last 
round [1]. It is good to see that the struct in now namespaced in the 
next patch but separating out allocation and initialization makes the 
api harder to use than it needs to be. I'd also like to see 
git_configset_clear_and_free() become git_configset_free().

Best Wishes

Phillip

[1] 
https://lore.kernel.org/git/47b18fa4-f01b-4f42-8d04-9e145515ccc1@gmail.com
