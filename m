Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66A633986
	for <git@vger.kernel.org>; Wed, 10 Jul 2024 04:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720586809; cv=none; b=JqaIL3kPYFNZDQmKh/YnstHFF+6YO9I2vL4XPBjwF15izy4KkXmVHGI0+78tHM8JrlYJQsYo88Rv1gQtocz1rcV8kmzh0k/C4qMJrfW0V3ykBytqKMd5QuCyj8P0XCUrADcimJKfSFaa/4d0Krs9dMQg7yHqftc/Etj7TaI3Mm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720586809; c=relaxed/simple;
	bh=apoP1gRNbDZJaNQ424uCE4Gsae/Zsj5r0qBz4XAXy4Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RsOf8byxWzVp+qfK7IMfmkWiEtMRUOQVyaZj6ZnKXpJppZ//UhN++8YPoOF/TxhEj+VpX72p6ftbhPL7VnfTxlD5jcqoQpp+3TunWTX7IJuuhEQszVPtQnme5GLA0u4q20WIJSYuUZveiYOkz+bkzDaU9/JY4KyQix/afeZY2bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B4zeOXUf; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B4zeOXUf"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-761e0f371f5so303092a12.1
        for <git@vger.kernel.org>; Tue, 09 Jul 2024 21:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720586808; x=1721191608; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d+Oev0mrkl8DuZRnUJqKrN0FKmDENdJPZmKQVCSHkR0=;
        b=B4zeOXUfBtSahjszF87UmKZoFEbo7uMtHvbYxUCq4+1XXUnUJMGPcRmzKiLsDB9PMW
         GJbSeAuK8x2ZzM/C2zKQjyMXa2hqQUT+7DzDWzTXVTCdok6f1FAEWur2FHV5WtaHtgJJ
         5oDGvo8FoXQxIF0CcczjjzR1bqGcyUF1ubdmt2NDimlcHxu4Isq3DBrPYY2CvOPSQBNQ
         kwjTj4Ka8CipFiiRj2Fs+zgFTrlLfBVsxwPx/bJEgxhZ0DCobohHjSIMi+ar9PJswBVQ
         vWdPeJrmFXz28JVXOIHaZ2UswQw8JX8NkJmILfLp78dp4LvVIZE+n/ybCAceJZebTRTh
         wFDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720586808; x=1721191608;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d+Oev0mrkl8DuZRnUJqKrN0FKmDENdJPZmKQVCSHkR0=;
        b=rs4JEHmnLj1edu1KKIXXLO01Odeets6m/Td/50hpZ/DyK+KClUMbvgnNfYIlSrMSlZ
         sa+9qg7Dgh78a5gsqc168syjH3tfH5f6d/9uDFUw4gk+yziwPigzfkMqB2QSBUFaxhe8
         Pmy8MCl71e/GxYlH8fZK5cmW24W4K976gJuQIDL8MhBcLnTnzlwgsG02VaHs0icze0Qg
         QvFBfFuEdcyRQr1JEs7lyMYG4yfXMnSpAHD39WlgQrxZjqHLJrFeVV/K63N4mA0Z12wN
         y9uvhk/HYqiNxei/tCn1krQLQRDHZ9rGqWXykwm/mJGW4CfsDoAj6jZsGDjUcTdATMOE
         aQDg==
X-Gm-Message-State: AOJu0Yyb+2tuR0i9i7NKUstzBPVB/gR9HcienTrV11/FB8A64uYhm6nL
	9sxCBgSes1qIPp9aZ1qjvtFQPjjIjZ7+wvZCszpHxJvissWyRT9A3NbCfw==
X-Google-Smtp-Source: AGHT+IEopJS8eXznZtmasu3T+ziikzrScfsqqMhqd7qD19zmOg5eUiLkI0mzEFjgdof1AN+lq4oulg==
X-Received: by 2002:a17:90a:de8e:b0:2c8:4dd7:e8a1 with SMTP id 98e67ed59e1d1-2ca3a7d18d3mr6066653a91.14.1720586807889;
        Tue, 09 Jul 2024 21:46:47 -0700 (PDT)
Received: from ?IPV6:2401:4d40:b860:500:f3ed:6301:1dd:4b62? ([2401:4d40:b860:500:f3ed:6301:1dd:4b62])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c99aa65507sm10869144a91.46.2024.07.09.21.46.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jul 2024 21:46:47 -0700 (PDT)
Message-ID: <f5d3f63c-5d17-402a-854b-edcc8708f3df@gmail.com>
Date: Wed, 10 Jul 2024 13:46:44 +0900
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] test-lib: GIT_TEST_SANITIZE_LEAK_LOG enabled by
 default
To: Junio C Hamano <gitster@pobox.com>
Cc: Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>
References: <598149bf-6541-4c9e-8c94-a108e3ee7fd7@gmail.com>
 <d5c307e3-79c5-4795-838d-4a425b012ec0@gmail.com> <xmqq4j8xaoe7.fsf@gitster.g>
Content-Language: en-US
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
In-Reply-To: <xmqq4j8xaoe7.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On Tue, Jul 09, 2024 at 08:58:56PM -0700, Junio C Hamano wrote:

 > > I used, more or less, the text for the message that Junio
 > > suggested.
 >
 > Hmph, the above doesn't look like any, but as a standalone patch it
 > is very much readable.

Ok.  I'll apply the simplification as a separate patch and then remove
the reference to GIT_TEST_SANITIZE_LEAK_LOG.

 > I won't be able to apply this to my tree, with
 >
 >     warning: Patch sent with format=flowed; space at the end of lines 
might be lost.
 >     error: corrupt patch at line 22
 >
 > until these get fixed,

Ouch.  My email client is set up incorrectly.  I'll fix it.
Sorry.

 > but is this meant to apply on top of 47c6d4da
 > (test-lib: fix GIT_TEST_SANITIZE_LEAK_LOG, 2024-06-30) which is
 > cooking in 'next'?

It is.  I'll use "git format-patch --base=47c6d4da" to reroll.

However, will wait a bit for confirmation that this patch is heading
in the expected direction.

Thanks.
