Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE64502BE
	for <git@vger.kernel.org>; Thu, 25 Sep 2025 10:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758795117; cv=none; b=L1OrjjlYXHNYyAi/g2+fl3QjekXVIsq8MFrgNJTcQCvh4HL0dXrgRskdATEMU1zn/NTKLtv1Bas3y6/yirT7BNr+WbhwHF98zGpfmxCFxkOrsDpV9ZwKLjPT3NLTcmqBbJEPACEaAqiT3rQv5b0Lspir/rg2h6KDPPUGEC3+tcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758795117; c=relaxed/simple;
	bh=AlNwqLj/i16Zfk9z3QoIEl4ZFGamqqckaq/3KzoXtAA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eFjK/1ncUuBvaC0WsjgzAMviqx/ribTybc8aAIhIxrdzWX/VQWdMeWPadmgV8K+0chncoD4omSmkJsiy4LEvdU7bIrQB6ji3tPcKsF+R6CcWhvjPYp46n1qQ9BPC9u0lv0ijwd6f5n9qO7h6hA8bLskFJcdhQ0HgqgxsuncqbPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EPsiFYvr; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EPsiFYvr"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3ee1221ceaaso502515f8f.3
        for <git@vger.kernel.org>; Thu, 25 Sep 2025 03:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758795115; x=1759399915; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qZUaxEnj4Ki/aUbG0dogUdxTTeN0p14uOxqojuz4uE8=;
        b=EPsiFYvrqJAU1az0MiRxNQ8MhSdNDPPHC0hylvIKzlKPHVXZ3hvkX2kj/Q3ib3ru1j
         JeNEBEr0ottzbiVcI/LSX59TNZs1Co4puTD5ZwcksLDPmK9O1+TKMGrndco7suD2PIiC
         46u4oR/ATp4GRJyt+5g6kbgE0dlm7A38MSlpypLJ5PUJ6BVqsV/BWP+inhJaaTubc2vP
         WuWWQR+LD/IrIlGrxXVm3x7Nap3u/G/Rc7HYzO2ItxnSEJElEnl8Wvq+XCmiy7hrhpii
         6wdUENCLuh48rucCucL8hAMNOpiS4FqfDleaS0xq0vXysQUE5ghMHHKd8m9rWVoYdRNR
         m1bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758795115; x=1759399915;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qZUaxEnj4Ki/aUbG0dogUdxTTeN0p14uOxqojuz4uE8=;
        b=Ih7GTVrduqDGL8VmVa9uex+I+CqGUSu+9qggt2es8VrwqwDsZ5NtaOQCWz1VS8qG+L
         gZyrZuPD8VXT9ENVBhlYo9MlSkMn/oI1i1gbYso8Z5Sy6pdqw5Filj1/i6LetJcSU5u6
         DsG0rshacEpsKloqwCh0MJ/1TvqUyKk7CGAOy/K3BUVUDqKs0IL9qvtwI6+VM99f7mQq
         nXQJnFFPx0giNuPfP5tAlwUxMl9RPd5EkQZeOhLy5GEUyzJdSQLO73NEy8sjNPN4jOFn
         mszo4wfZD23+mvM5xTbO/QAhhsBl9qZHIkW0XeneK1pfjmMhcZm0c2br2bCSjdkTZMKM
         ooSw==
X-Gm-Message-State: AOJu0YyrTb4/Sa+XYmK2LYftslLMOKoHbTV4HYObGpuYHLsrVuBiIYo8
	9wXKgHubQGLVF/7W3O7N9D6n5IA7tkhvwemKJRRHhlpm6dCkRtiMoHmBhIBq4w==
X-Gm-Gg: ASbGncu6EsviE/FKaellw0fD4ZEUgsl+xeV2dP5FtqUs+5ICirVtyHT/ewpSYBVmXG9
	wGVsn1UrBABvPJjm3d0SqZD1vR5GM3ksd8e4EWWArIFTOOt4kiW6ENls5YtoiZvHzeqLwGw2R4S
	xb7BWb0PESjWXCPw7eDIxP2RiAvVzvpITJ7qkSDkPK/rOHcr3x6JoZ1KilQUX+zMzILhcMbq8og
	us4HgEcE2pYLroCrQTzIXUO6AWFvYDRWyGIpVwre7IL+rxc3gnSKTxnHqO9VwkPEg98BsashtOC
	q66nlSAz+1QjOAEL9D1oA/13UAYDFvVJKWa6BWYqdANylxPeE+zYKkB5cuj3K6rwzq7qyIHrq9y
	JAQxrQdk4Feqfd+QIhInSlVg5Ijx7f24yogfWVI79dtz6ISx66aZhQO3oDAp71ysyjbXCpYKadP
	g/LrWk
X-Google-Smtp-Source: AGHT+IEXTq7OffOXseGWDAY3yZrun1Q+sZ1wOQYGsvppUdROOueWN+HxUHKwUuxf9ZP5J0Vj8FUpMA==
X-Received: by 2002:a05:6000:2285:b0:3ec:42ad:597 with SMTP id ffacd0b85a97d-40e4ba3a899mr2527883f8f.37.1758795114509;
        Thu, 25 Sep 2025 03:11:54 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:62a:101:8237:372f:a3d9:7aa3? ([2a0a:ef40:62a:101:8237:372f:a3d9:7aa3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e2ab48c28sm70367485e9.18.2025.09.25.03.11.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 03:11:54 -0700 (PDT)
Message-ID: <12659f80-2934-4158-9a22-7a4c11060679@gmail.com>
Date: Thu, 25 Sep 2025 11:11:56 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rebase -i: use same commit's message and date with f -C
To: Mathias Rav <m@git.strova.dk>, Johannes Sixt <j6t@kdbg.org>,
 Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>
References: <92d4d585-09e9-4f1d-a471-1ad6b312fa61@app.fastmail.com>
 <xmqqldm4onma.fsf@gitster.g> <0a14a93e-7da2-43e1-9d71-c58a69c7a4af@kdbg.org>
 <7de3da11-6191-4fa3-bd0d-842dc45690e7@app.fastmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <7de3da11-6191-4fa3-bd0d-842dc45690e7@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Mathias

On 24/09/2025 16:21, Mathias Rav wrote:
> 
> I have never used the "amend!" autosquash feature and I was not aware of
> it until I stepped through the code in sequencer.c to implement my
> proposed change. I think the `git commit --amend` manual explains quite
> nicely why you could want to keep the author of one commit and the
> message of another.
> 
> Before discovering "f -C" to achieve the "fixdown" behavior, as Hannes
> describes, I used "x f" to invoke my own single-letter shell script to
> achieve the behavior I wanted, and I guess I am fine with going back to
> that for the cases where I want to preserve author dates (which, to be
> fair, is often not that important to me).

I'd be happy to see a patch that implemented a new option for "fixup" 
that copied the author. As the discussion that Oswald linked to shows 
this is not the first time someone has wanted this functionality. The 
issue is that we don't want to change the existing behavior, not that we 
don't want to support this via a different option.

Thanks

Phillip

