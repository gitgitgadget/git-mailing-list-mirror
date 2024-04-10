Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E90F15EFBF
	for <git@vger.kernel.org>; Wed, 10 Apr 2024 15:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712762640; cv=none; b=mgjQRgnQB658/Wm3nIOSSfw5PBkocvWyIX1aBaL9Z/cZW8PBDd5TtSO23Fp/FJnP+ZhCAn72Afou+HQv3OwWgbguTrjNJYlLwa9iPreSlfaOdbS2YX4nNtcVAHsUjocUxq9MiejmRKZgk8LSngglwoHaYhNsBz5gwnQ1AfCPc58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712762640; c=relaxed/simple;
	bh=gXEd0BJxKpVA+ciSdqX/6k7Z+5xt+GXYZWrrhL2c5gs=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=H9p95ll0Sy58xNzzIUlm0rkc5NBjTHf7ZTpZWu1NGy+2br2oii8xGf/U1KS0ydsjDjcHM0f6JsJsb11tvlzuKjAspcBXT/gEbWxw9gVtk0qXFC5t/R764WloJzw5C9VEBD1ibsMkR51B7KeG7kKm9Wy0B6bg5Ecd20xYpJ6073E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IPoWOqd9; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IPoWOqd9"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-34339f01cd2so5083845f8f.2
        for <git@vger.kernel.org>; Wed, 10 Apr 2024 08:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712762637; x=1713367437; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IPBj+9pn8D3ewuE5fZUnBZMoMz+KnqVRk1djZMLjt2g=;
        b=IPoWOqd9FoGuJpAbrPYtX4zI0ONpFQcZgT68n2LiqgBx++4S0VxEAMXx6KXI1l42gu
         krlkyOskdGsK1u26BC3eq4ba2xB7RA5ozrF5dWXMEitPmd2rNljUGVMAva5cyBxRaZco
         FeDyPPggwFWR/3SHHmhKEE846BXS/TiGaPLQ3e2y35z4CqrKfWDLlNkITmiAFC2Hd0vb
         x8nVJriiZ+STMwF5GQWaOQXgWJfjmz5p6qjOb2RWrrws+UXWW5tc8Sy7enYCIJ7DW73c
         Hg7/MQzkLu1qTrP9KBXiyHPftvrQGoxDBa4+o3k+Hc74TN8d+SwfvorfJNSiukbEhlUb
         SdIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712762637; x=1713367437;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IPBj+9pn8D3ewuE5fZUnBZMoMz+KnqVRk1djZMLjt2g=;
        b=olozOVaXnpuBXkiafRl43MXaZzFsChnBkdWu72F9UGjLmL7qArBgOUqNjFvgIc/gug
         F/LOvFgvvhI0ageiN4kddw4FdIiqSVHv8wrWj898JsyODoNvDxpjF+buG29NRB3cw+Zt
         11WUunm/IzoxKJSBIoe8Xg7Xx0IjuEsKQb83aLlKmY+kee0LRaqjAY4HxNCRG49zxg+y
         SLAEJGy5/klD4tBWAMSRLggOFFsM33JvbwNmfrVyC1AviiJhv0k/7KbfhtEm9plmJSei
         wJopsl/0ErCErbCRLDkNweVbq2JXq4tAnFSDgSNWhyEMD+D9g1J8ya9qoqvvz0HGo6pl
         tftA==
X-Forwarded-Encrypted: i=1; AJvYcCVfBYTWvsnYQtDZw5mHEq4VsqQwl1UJwv3oqph/L1OrmCv61zQFI2g6U0ABhbQR6inW69CjdHGRyxc+WsukjheBY4qA
X-Gm-Message-State: AOJu0YzmmGLh3c+7G0BGDi3C71JRcnzoC93hL6rQ57MlrV2CWoON3dPx
	/1DP5jzydP+XNbOQ3+2yxKl7WkkfhB1uRsEGPgNTyBt2Ro4e2cFj
X-Google-Smtp-Source: AGHT+IGi5IQbnImmufsc2rrctK38jVKGi+ijm4ltjTd+qOMq9/viKf596awXfCpsrWBsO5Jb4IQxyQ==
X-Received: by 2002:adf:a48c:0:b0:343:69b4:b527 with SMTP id g12-20020adfa48c000000b0034369b4b527mr1725686wrb.18.1712762637183;
        Wed, 10 Apr 2024 08:23:57 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:68c:c401:12ba:addc:3daa:a3e? ([2a0a:ef40:68c:c401:12ba:addc:3daa:a3e])
        by smtp.gmail.com with ESMTPSA id je4-20020a05600c1f8400b0041628f694dfsm2566679wmb.23.2024.04.10.08.23.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Apr 2024 08:23:56 -0700 (PDT)
Message-ID: <5e0ec9eb-2e2c-4cb6-91e2-eef6b5c4300c@gmail.com>
Date: Wed, 10 Apr 2024 16:23:55 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 3/3] t3428: restore coverage for "apply" backend
To: Junio C Hamano <gitster@pobox.com>
Cc: Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.1713.git.1712676444.gitgitgadget@gmail.com>
 <b45af37e3c0a22cc9e0514eb681300be0b968e02.1712676444.git.gitgitgadget@gmail.com>
 <xmqqzfu2yw00.fsf@gitster.g> <6ab115bf-7b78-4633-a64c-9a0925d68e3f@gmail.com>
 <xmqqjzl5z4a9.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqqjzl5z4a9.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/04/2024 15:22, Junio C Hamano wrote:
> phillip.wood123@gmail.com writes:
> 
>>> Hmph, doesn't this lose coverage for the merge backend, though?
>>
>> I don't think so, we had coverage for the merge backend from the other
>> tests before 2ac0d6273f as all of the other tests in this file use the
>> merge backend. We're no longer testing "--signoff" without specifying
>> some other option that selects a backend but it seems unlikely that we
>> could break that without breaking one of the other tests.
> 
> OK, so we have "rebase --merge --signoff" tested elsewhere and we
> are replacing "rebase --signoff" with "rebase --apply --signoff"?

Exactly

> Thanks.
> 
