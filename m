Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9300F17B50F
	for <git@vger.kernel.org>; Sat, 14 Feb 2026 14:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771080421; cv=none; b=TW10hQMY1H39ET+Iw8QywNg/h2G/e43kSqfkxEfFF8rwSH48qJw4emo+4egcITa1amhF6VbA8urqm8q9IAzIFMJk8mRVezOj/NqzVadMG/1SoaGszhUVWrB2Hj43L3OKX/aWAZQ+V6mdNhUasFOKg05JP4zlfxiL33nZ6mIeDAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771080421; c=relaxed/simple;
	bh=FS6vNrhLZcWS2XNXNN4p2+HLllCcjF27TXYNNgSG4xA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=lDd05SuQKDSg/ySkaN45kaTm3QYinVj6p3GUYyZAMbStwbU+D5J6HUe8BDPPuXFtbParttT78kUqauX1YAPzneKVfl0E9je7YtEY2WCnHn36LLIJgDbBdjtWLXpEVbS9MWIad47ii0teRvH8sUslEIk5SLnK3oqKeUpVkHVuMIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PWdVmDiW; arc=none smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PWdVmDiW"
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-436e87589e8so2130565f8f.3
        for <git@vger.kernel.org>; Sat, 14 Feb 2026 06:47:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771080419; x=1771685219; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z0Eg7cV5QGxDq9aiVhtvUyKP4wYuT3Wv48wdo0V035E=;
        b=PWdVmDiWWXKgCLcfyBJwNxTLGeJR2INp4w/udizZSc3oxVaLPsWvysjvGrc9VnXKw3
         ymziusDGYJC2OauIoMS2U6q1hRHod+FV1i/r3WFCa2rSF8gJIpRDG0R3ORh8ADuQ6oVl
         wSwzGxj4f0XdrsjV0jPjm0S5ElZjMgQTCxi8REHq854Pa9a0DuHx1KCsEETZO4ypqmEX
         iXHnthyS8RhNTUAQEjdtqr0kZLP+uGmDxbOBCAZdXyzz6cL1H63N+FgCn/5+sKECPuhS
         oc34Tkb5CkxefOHwhBj+SF/7w850MAK9g3Rc/IfsAt+HLdXs+Z89amqJovYhQqLnccXf
         fXnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771080419; x=1771685219;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z0Eg7cV5QGxDq9aiVhtvUyKP4wYuT3Wv48wdo0V035E=;
        b=GukGiw+bTBB5VdozslsK1BPVYspZ9gVZztWeIF9SONiA040AJDLATceJB5QSYaOH0K
         FSVbZQct8+mEm3falDx3nR0MVJKKLv7y+b/tj4aEO5M1dDw5xVxd1sL6h9+wZI6tsGTr
         M6l20Zapw8nz15GEzomcGxFxiXqwgzcY4nDLF4exk9w3aduEC06zAjyvdyveYMI+t7IU
         58NDMqj3Cz1EZAOJ6AA4oxvbm+JRoYjeKoyKvZ5jpqIaF6xqfKE/m67SNfaXVqdzt02F
         fbjT1ALE2yYntr9iYMbALUGtoqCHH74WBtVlSdzZjmyoUsttyz8ynBnp9ksgHunp0R7Q
         xv5g==
X-Forwarded-Encrypted: i=1; AJvYcCW6QZ9DEm3LgC6oEkgRwAiYdowss6RoUgdX6h8Mp/b2xmdrqHZ/yYYqbaVaFFs5FoGdmRE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxuf1JA+eg3gKc9uFM2g/1u//6jmFaSv3359nV6myzkjCEYY6W8
	R0BssAErjBLnT+l6ZtklceXnsDT7dbV13wpjj2M81BcQMG2k9DE0oGpN
X-Gm-Gg: AZuq6aIIlrf2qJ7DfbQ6g6UBy38iMxmNnkSFPSk4nt7QvEFN5WTeqYfdtBcwiFaHPnm
	JEEzwJEwN09dN3/NIJQNV4Tw2mcaXkrAS3TMXJegLhQS1CcGkBr9V/K/azmb89Vsr3gg/yz+Iuu
	eLe2daVEVb4bDK1apcKM0KRt0FjntG4emnlMB8JQOFm+DKtIx+eEFTC0QRZBLqajXRIPNGKV3I/
	uzgKrQK0KLo5389JWzRFx26jb4xryuPzZDMO7msF3zXSw7c6dEuroS5Z261U4soJLWoz14KxRZN
	jMKVG5LIY9ZleECVeYGOoMP6HLcd2rq0/EA5MQFgpPHZ17Xy32heaZUQs2ri0m6XS0dhE8avat6
	ncOz/Kz916YvBD3rVCOs9RPBSCpCtBrPKaEji0qqlDI79J36sexBWjTwG6/R/CMcT5b/Zwc4IA4
	Sel4b0cyjSEUW5dDuu3yzCejZ0mGqQ1IISXmL2tmWjAmYi93X+wvYsFVRWxB7T8a9abIj4N65Zu
	HUQKg==
X-Received: by 2002:a05:600c:4e56:b0:480:20f1:7abd with SMTP id 5b1f17b1804b1-48373a58997mr95622845e9.31.1771080418748;
        Sat, 14 Feb 2026 06:46:58 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:68d:f601:6840:9d65:3109:8533? ([2a0a:ef40:68d:f601:6840:9d65:3109:8533])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4837f4c46b3sm14192005e9.4.2026.02.14.06.46.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Feb 2026 06:46:58 -0800 (PST)
Message-ID: <93221c40-90ad-4883-b494-1f74230afe03@gmail.com>
Date: Sat, 14 Feb 2026 14:46:56 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 2/2] templates: detect commit messages containing diffs
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 Phillip Wood <phillip.wood@dunelm.org.uk>, git@vger.kernel.org,
 Jeff King <peff@peff.net>
Cc: Matthias Beyer <mail@beyermatthias.de>,
 Jacob Keller <jacob.keller@gmail.com>, pyokagan@gmail.com,
 Junio C Hamano <gitster@pobox.com>
References: <20260206090358.GA2761602@coredump.intra.peff.net>
 <cover.1770993281.git.phillip.wood@dunelm.org.uk>
 <494f4df6865f81eba42584ead81327c9a305d0d4.1770993281.git.phillip.wood@dunelm.org.uk>
 <7bf9cdde-de61-46fd-8730-592f87017a19@app.fastmail.com>
Content-Language: en-US
In-Reply-To: <7bf9cdde-de61-46fd-8730-592f87017a19@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13/02/2026 16:42, Kristoffer Haugsbakk wrote:
> 
> This works for me with `git commit --cleanup=scissors --verbose`.

Thanks for testing it.

Phillip
