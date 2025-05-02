Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0305C255F5E
	for <git@vger.kernel.org>; Fri,  2 May 2025 14:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746196107; cv=none; b=UnfRPqg02YVAoIx1HV2qZ1fV5KrNXRJyDVbL5dIwl13VYXzvygMfePLf7Hso5uxUaCLoHHFln/RRcMAirYCn2oqYNA/I8CWIXYFlu6NBRQ5pXni8U8uXmiU4N0KGPUw0v9kXvZAueKERRsF1wxra0Q0H5PEAYlvdWtiJYEgWYtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746196107; c=relaxed/simple;
	bh=CEARxnvCF9qydxjvREglYXqgKZveaRGOk7o1JaoaTsQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RjPrs0ydv83AAa1OTF9bw67Yv8mQ8LEmCPSPVbRCDmX84v04b+qpty1qrT2ZOGZx6RxJg2TYQRptfZwuHZjI24pZjRyZhFWkCXKKZrfqKQZkc5QXuluEcDfwbSUH1QVnTXRy3/2/3QU6cru7SZDQyf77tCHrcPxPg5CuBpFeGxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fvAVr7Yw; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fvAVr7Yw"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-441ab63a415so19832615e9.3
        for <git@vger.kernel.org>; Fri, 02 May 2025 07:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746196104; x=1746800904; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=sGz7ixe5Od0xxnZfEPPKyPMyrog6wrvxSJvaQuoSxqE=;
        b=fvAVr7YwGdhsv6R7kQElibn0WCZAqDvbXz9ZuBcTkUTU4IhAN9X0Ds6lDbQYe5TIsL
         smVkdvwSAL9gbBp8x2KxBlodHCHsGwFUPJz1WA42Vmy17lyqUcnCJj7p4aARnVJCpgd9
         bLlR26+UtqLO6ECHUUH86I6sbzt+V8+UtT5ovEdJFK5sgSEOsUIHOfZ/ZJPgMrEsM4KZ
         dNGEt0quXZZDEPhZiTrc+N7lQqc/NDwHVxyxOfduyrOdJL5ocxDN0d2+TDE7x4UNuuTI
         Oepiik0fR3IgC+9nplZhocISIQhNtmLq7WLDDdBPP9aVWpYp4VPRUwrrDU8vzUhBZrM0
         RFYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746196104; x=1746800904;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sGz7ixe5Od0xxnZfEPPKyPMyrog6wrvxSJvaQuoSxqE=;
        b=UobxxHuFdd7vXvdqCRGcSNkQ0H+pBaR64hdo1NnLPgNeL2gsI9jy58owLc+AZ6I1AE
         T3Zf06GyMCF7X2xCdAvvyuk/mExP5HiED68UCNHaXq2MAsq+i9bIs6adx47GKznZjn6l
         X8gQ5TJfn6EeGWquD5WM4i6oQL6mwJr0lK8y4hWkfWRLfjPyqVGeqQNuZQNukmjLt4TG
         +b+Xy2x2yjduXduay6yNQQc6+GbDLRwocTndtblr9vYWZiSBq92UVaBXRWbpXFuegPCH
         sy4myh2t8dYfDU4Nia/rGCG5bQowAIHl9QVAvLmdedcz7CJWTneGyg8Hj/n5w3sckiE2
         slnA==
X-Gm-Message-State: AOJu0YwzJVtFOc8pZOv0GX3Syid2JKQB8DmP/7kNjWPw44gEpE8zhgPd
	mCuMEEFqqjYEPVdralU4NhEGvUqBsGYHFi6PTI0W1nL15gV+KjT2
X-Gm-Gg: ASbGnctT9lxJVs+s+a/WDygJ/O6xfLSDB3FQpw/SJ/iR/Zmz6Rxgtj8mRjR5V1gMHX9
	Q6MmRQJcMIi2nern93VH3EKE4BZbVJZmd0QfhQtqHTWQQm8RcY/9D7wtnBM9AO6VF4jX0wV+hJg
	e3fvMlNiDxeoTEx2Jq9+RrsMetGEn7qvskHmbEmwAB1x9cBBTVaZbRfh5hxrVcsC//Is2nDv+fJ
	gvCreNYZXndHAtuAt0XXsEDzh5bkSi8BSaF4gpCyO4lJbc5u1codtmCkMQRZ+8ZlFuxOYUOszko
	HypcJDogXseC4RsSB+UFCuiMduqUoDRxtTu3lS3OxJ89GYTZ6SRvHdxz+839iIgLhva12bUhXDE
	2PH42k7sUR9E3g9f7
X-Google-Smtp-Source: AGHT+IHpiuZtG8/SBjNfF2AlXXFsQ/3rR2Czp59rFEBV9T1gWTKsmJK3JXVZYffS2QzKY+yf2LcO0w==
X-Received: by 2002:a05:600c:870d:b0:43d:1824:aadc with SMTP id 5b1f17b1804b1-441bbf3db9cmr22933635e9.29.1746196103979;
        Fri, 02 May 2025 07:28:23 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441ad81c19fsm88423925e9.0.2025.05.02.07.28.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 May 2025 07:28:23 -0700 (PDT)
Message-ID: <c492a392-8914-4fa3-8356-c583f0a3fa81@gmail.com>
Date: Fri, 2 May 2025 15:28:05 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 2/3] config: values of pathname type can be prefixed with
 :(optional)
To: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
References: <CAPig+cQUycUyto6=cDadaCahzDBQ_GDngAEEtK0bshLr15ok8g@mail.gmail.com>
 <20250501214057.371711-1-gitster@pobox.com>
 <20250501214057.371711-3-gitster@pobox.com> <aBSHugZcH8NusOcI@pks.im>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <aBSHugZcH8NusOcI@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02/05/2025 09:52, Patrick Steinhardt wrote:
> On Thu, May 01, 2025 at 02:40:56PM -0700, Junio C Hamano wrote:
> 
>> ++
>> +If prefixed with `:(optional)`, the configuration variable is treated
>> +as if it does not exist, if the named path does not exist or names an
>> +empty file.
> 
> I can see why it may be useful to allow for non-existent paths. But I
> wonder whether we really should be skipping over empty files, as well,
> as it may be assuming too much about the semantics of a given config
> key. In other words, are we reasonably sure that there won't ever be a
> usecase where you may want to specify an optional and empty file? And
> are there any use cases where an empty file should be ignored?

That's my thought too - ignoring a missing file sounds like a good idea 
but why an empty file too?

Best Wishes

Phillip

