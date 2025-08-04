Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E9D19D092
	for <git@vger.kernel.org>; Mon,  4 Aug 2025 13:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754315502; cv=none; b=Co5k2Bd84t730FLPJRd8Rnqa144lhIsmWWnIJ3TgmYq7nUZc88KihAs3iX1zdOX5/3MuX6DENu9DS8DTzF8UQ8fUUsA4q9MzikSAa+TlTOdtq9ACn8i+q2GAovb5Nr2i80xkLCkVnDqEZ+JXdgyOb6jvveddiRprN6p1duSDYrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754315502; c=relaxed/simple;
	bh=9o11g4J81/Zbky810DFaTecnIdmnrIJl7Izbqc8QL+I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lRgYtGvM2SxgizDnTIVYWeA1LtK/rZ6Ckp7b3B6K3YoWgjRWRiRVk6u1ClH0vCkgHSX8Iu7nrURjbEASbsUW25k0YoAfKzcKyG0NQ/uY1vU324nDKSKCS6U+2XpaK6JX5uHjFbgN/7jBegBOWdmf3ofrF+ltEO1CgRhHGlsv34E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ckrVlGQq; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ckrVlGQq"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3b790dbb112so2411562f8f.3
        for <git@vger.kernel.org>; Mon, 04 Aug 2025 06:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754315499; x=1754920299; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1+mz6KEleJIUumdC43qYvU2TOh51TR25aUtUPFztf30=;
        b=ckrVlGQqmtfTEYLUkVuBCZUlZAZUBblJfuk4Yw8oLr6FSz2zeeJ8YSMuirHGikAAP6
         PDvQcBP3LIH9ELTSnNmepobv2SxMjurELCjyGL+qp6qc67Rpi6RqTXz2wSiWXNUGVx4x
         5C53IyBnzuQikEqJM4bu2Zgyp3mhnGCYC+Bv97wkGwKsOBFndeuytF9EQXzoO+HmI3ZD
         cFhbg34jMV/n7ZOup6w8RR5Yg4OldpjTooSZ9HGYeq/H+givTZf/z5ng9kuelRh7nnog
         BH1gbakBzzYFW7x0Y2OIRLinMyug7OpvbVwkUY/y9Rp2QQpBrlnU9rBvIPJeHceahv+a
         tHCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754315499; x=1754920299;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1+mz6KEleJIUumdC43qYvU2TOh51TR25aUtUPFztf30=;
        b=rMYX8hWFb0qrZmISeByBh38vN8iv1mKu6nlPobMwC0EV6415FKLD1cYrk5ByK0F8vO
         7LCClsvl0HnKJsSRQNGYveEf0ipqlZZDj/OGlErFQhiHdcWtgWpOj6KH4bcyTIP/Fl7l
         W7YcASIQ86JSaufriAVPb72xsNfmEW3VZPV4v28ljB399EVnqLr9YUEO0bLTS8qeTQ0H
         byJWIsC60H30TIy8VM7HlYgFKbBt77dyJCmxQMQaZ4ZB//N9xGsiP+ouap14NZmb0UNw
         P+YHpVtQFUePLUO3J11U6k6bHuzfIWGb9IzrioY3jC30WNQdqhSIpQ7v5L4m41X4Q7Kw
         A01g==
X-Gm-Message-State: AOJu0YyL79gqxtKVMXrIIXQuyIG2sXGFuX5uYFW6aVkYA5EiGJLmVK1x
	mqKdaAmyhtLg86gNEcu1cjyhcRiKOsEwQEWzGm92qsH2zzheytTNySmxl5tNeQ==
X-Gm-Gg: ASbGncuYLeJTSj7gyEu3y0Z1dL+6jG26eFvdZ+13Z6EWzl5Ug9cVFVtW4U0r6fjIWGG
	+kzGCrekQTV3bEJ9XdOQDHYmSe/K3q0TSmcBQlm5QS7C9u88wUvcb5dUDhEMwI7L8vC3dzzk1Zj
	mxyZLuhAY4Rp70ZFCM3A5OCR2r2jZGfQpElYGp/C51Z73dyj0EgVDPdhLetfrtTxcewV1ryjnu3
	iUwLToAMQHh9Tg26OJEx4KZxoiEkivR2GOfMORQYDXOgmJWomW6uCVbmiBWJQMtKiMHUSyCzKbb
	SvwPa2CXnH/yiT/PI950zdl22NHNkbVt1Z34HnanrbV8QoueGWBaX9QL4JjKBByIHDczepa5u25
	kwwjpvjXmTv2aB6ExEN2TuRSQ4gHaSoFbqsK3xIXNdoSzaRtXvkjwPZvEoNiZvHYkTroc9gQtj1
	wZ
X-Google-Smtp-Source: AGHT+IGvRz3Jyuc9OpSRl/yhELl/90aNJzZ7rg1KBNNN/IyTE64Tn6VBk/jxy9HgmbVdiKZKmv0cOg==
X-Received: by 2002:a05:6000:230c:b0:3b7:96cb:2271 with SMTP id ffacd0b85a97d-3b8d94b6e13mr7191578f8f.37.1754315499399;
        Mon, 04 Aug 2025 06:51:39 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c? ([2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459dc7e1ddesm30357075e9.27.2025.08.04.06.51.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Aug 2025 06:51:39 -0700 (PDT)
Message-ID: <ebcc5e06-6d0f-43f0-951a-226558702a9e@gmail.com>
Date: Mon, 4 Aug 2025 14:51:35 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] revert: initialize const value
To: Patrick Steinhardt <ps@pks.im>, Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
References: <20250804130011.GA93475@coredump.intra.peff.net>
 <20250804130141.GA95101@coredump.intra.peff.net> <aJC3OiJoqJRnR_My@pks.im>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <aJC3OiJoqJRnR_My@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04/08/2025 14:35, Patrick Steinhardt wrote:
> On Mon, Aug 04, 2025 at 09:01:41AM -0400, Jeff King wrote:
>> 
>> Hmm, I guess one other option I did not consider: we could just drop the
>> "const". The pointers to it are "const char *", but it is fine for them
>> to point to a non-const variable. Maybe that is less mysterious.
> 
> Initializing the value feels like a pragmatic choice to me. There is no
> downside, and anyone who might be puzzled by the comment is likely to
> git-blame(1) to your commit anyway. So I think the current version is
> good enough.

Yes the current version looks reasonable to me

Thanks

Phillip

