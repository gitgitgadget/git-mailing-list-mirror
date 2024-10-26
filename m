Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD99E217F3B
	for <git@vger.kernel.org>; Sat, 26 Oct 2024 12:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729945043; cv=none; b=kEfxouyZDZBMDNHNZYay/kTwaCh3f0IA0qJkG7VUqYR7BsQmbdLzAh9IEPfJLHvB3NQ5EhwajNu2CrmdaOengRia0KHj3rWJEVZzfbbGILrtdbaN2X5+BEVsJvUQzG2PPER/UpR8HBFizL5Gxezs2tHAfsNaZeGlDkmlQZEOzYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729945043; c=relaxed/simple;
	bh=7rU8ObmwS86Xy3JfKc0bkQeU/KwfmFtWMbZhi0RB5zE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nyNa8VAwRPW4YU1dMf+qz5H98rFrrcL3BUfjz4JNYCDDaS1NDS5zu+Mqr0OrUhXHYZdR/09m5/WIKhn3H9lMWahpyxDMHMu/QtR9F6xi6wdzXK/PInwBDm+c5xAx6mSlwbB9Xr5kSUhVh0SpZqxs1I7awY1KiMqyD3qfXX1MdOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GRND3dI4; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GRND3dI4"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-20cbcd71012so29402235ad.3
        for <git@vger.kernel.org>; Sat, 26 Oct 2024 05:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729945041; x=1730549841; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EIZ2f53jp5xjDnH9r4EG3piKyvCjf/40PEeHzFkKey0=;
        b=GRND3dI4X/hzTSyCNh7eTxXVV7QeY6B8LUgWnVe+GM5CTqBtv7LFup2W1RLjfCqtBD
         V6MRMSXrhUeDiCFHWYJPQvcPhAT9SkSVSKa6MnBvoBPu3CIW/6JuM5/kIfHbviSrPKTh
         TS/fUjGE89K04l+FSZoqxXEgzS6KPw9rMHoV5T9XKM/g9s1mDSZsOevuGNTF8Ui2Kvuc
         2Cf3AiIz9LRrvHbRMTxSg+cGiqaJ+EZfsfbBBmYR3XoL+wUFmZxK0UYT3Q98T0wC7u5J
         Xbei8jykPIKO9wHbSvq2LaauHgSj6qm3wj1GJAfUES6QufREXPFIaZCrBIMxqE0DDGvA
         S+Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729945041; x=1730549841;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EIZ2f53jp5xjDnH9r4EG3piKyvCjf/40PEeHzFkKey0=;
        b=bz+3RLB1iLzdG3ftsNf2KYsnU+0v5YYgovoEf/tTNx/Kq4YdUXwy4uay6AMv1D1UmC
         bXNJZ0++SjJHAzubZKl3kBs6sZyUiQ5iuZu71L5iYCVbVsBe9bv3rK6O68myoNeNwDAl
         gUzPbMv6PIBAR4imck2u0M8woXcst6t7ha1qpH99FhcKC/6jwR7Igv2l+eSVfGBcGSK6
         896TdCFe7QF/3zN/AEiTginQ3Xz31gZj6XnFm9LlQ2Jzhic/1Kb6tfFnl8KM5PYCcqKo
         LLnSprGqEBjQCm8K4nPDc+u90vDKQVj3whnndS5fiu/cH2ZXoPHoqYo+SAGer3YwgB53
         i+gg==
X-Gm-Message-State: AOJu0Yw2fjFDqSmVC3v4E1OIdOIohRPi1GAD1+tYKxHRc+zbfrK4JaG9
	IjVoWARttF4YgqSw5enbpQKLWcNkWXpNuMofpgwJhvv+WLC2klQ/SaRXqXD5
X-Google-Smtp-Source: AGHT+IEyo48LPBGOyEOZjvSITY7NIeAJVdMJq+1cRzINShKRkL0VhQETogyyydKrgYcEqlgL3OaDEA==
X-Received: by 2002:a17:902:f60d:b0:20c:ad30:6b97 with SMTP id d9443c01a7336-210c6c6c57cmr34404665ad.38.1729945040748;
        Sat, 26 Oct 2024 05:17:20 -0700 (PDT)
Received: from ?IPV6:2409:40c2:1008:2f66:58f8:4a21:44e9:ec8d? ([2409:40c2:1008:2f66:58f8:4a21:44e9:ec8d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bc04b8bbsm23281715ad.244.2024.10.26.05.17.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Oct 2024 05:17:20 -0700 (PDT)
Message-ID: <03c602c4-8b53-485a-9a42-c989258acc57@gmail.com>
Date: Sat, 26 Oct 2024 17:47:14 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Re* [PATCH v2] show-index: fix uninitialized hash function
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, "brian m. carlson" <sandals@crustytoothpaste.net>
References: <xmqqbk32oc7g.fsf@gitster.g>
 <20240715102344.182388-1-abhijeet.nkt@gmail.com>
 <xmqqzfqi4oc6.fsf_-_@gitster.g>
Content-Language: en-US
From: Abhijeet Sonar <abhijeet.nkt@gmail.com>
In-Reply-To: <xmqqzfqi4oc6.fsf_-_@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Please excuse the neco-bump.

On 15/07/24 21:52, Junio C Hamano wrote:

> With that, your patch would become like so:
> 
> ------------ >8 ----------------------- >8 ------------

I misunderstood this as "I have made these changes to your patch on your
behalf". But looking at how this was never queued and the commit does
not appear in any upstream branch, I realised that I was supposed to
send another iteration. Apologies.

I have sent another iteration (v3) just before writing this.

Thanks

