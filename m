Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B631338936
	for <git@vger.kernel.org>; Wed, 22 Jul 2026 15:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784733348; cv=none; b=WTQLlI5ZdL5xtQ6RxwEQd+kYH8L7e/tFBcfrvoS7VpsPLxSbLgc3/6rkVysx2HD2G3kOh/kfBj780ongOzckRx51c+exYOFM3KTIqS2l7xHxbzy7Qe+SZOEIwN6Cksz5jEkZlXkK55nt+0B4WCprskEtJpHjV8NqZwLBqYL9VqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784733348; c=relaxed/simple;
	bh=w7Z5LfI9qrCH1SqM/wrA7CZ16O1PyDViXiD8cGTcIds=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CjxPn9lXM6tsWnx7tot4TV5v90wk6CxnHFnFv1tsmN27S3xNQGXz9NNOgeSG5XPiti4/c+QK1DNJpY8Dzep0ZjD7Fb3PCOyZ/PvqAjKzEQ03K38q+beC4DJ/sTDjusfkIVI6JMuEiiUcnLEUmAMa/LXPCgwb1UPzo81igect7Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hDw6nz3x; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hDw6nz3x"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-47f81a3ccf9so1465795f8f.0
        for <git@vger.kernel.org>; Wed, 22 Jul 2026 08:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784733346; x=1785338146; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2ZTya5zIBL19U/eov9mZdv7WKP8JOvnqlayOO4FvNB0=;
        b=hDw6nz3xbwGNy9OxfXRkAF276GtcRs+CBV27W8VlPlTUvNGpC1YyShy9quLkUGNvz4
         PiyH+6OIN0DDnQUhUFEFsp9FVa11sradMZofbExEitw3K+RRcvre6lfFBCCvYmP1lklp
         KICr3Hpa8NyhL+kX7C39z4WftjjtONk6REZ4CvJn8a4rV3C18OOf23VFaArQ+rac6lvL
         h3oKx5QoEuxkBLOl13LMKYn7Sq+Ck2fea9iCIGBuFC3E3RHiUdC+b1bjm/l3xJHpFLgl
         y8Y/ychByFwM0mZ5407DQo8remqmRYfQ3P9MM1BtS1p8AMIFdyV9HpilVi3A4JiBPc4I
         JDsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784733346; x=1785338146;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2ZTya5zIBL19U/eov9mZdv7WKP8JOvnqlayOO4FvNB0=;
        b=PCaCwyAu8B9JD+C92KU3WBdiq1ksvkT+hmjDfskty9Be2X7hZrswI/UdUYcDijWetA
         6RrGryrOBZEoRb/eqtlkGAWcivNeFMdNjaqLDKNNwcrd845VHLHFTjm6Qm3hy1sA3XSH
         BWr8t27zG6t3nabIoaDgIg79qrYjEjuQKqSkpkzxY56vf8+l1qdJHjERWjoIlsZk3XV2
         S9MY3EyO+0AcJ3OC37I9gV/0VC39HWkY4twbuh5KfoUMSNW8Pp1B3vdkCDx3GBPNe0BN
         FA78KvFRIH4nisd1WcAGxZmdesqT7djXkQA1xcfPlfsPrG9j+HjyfhHKlBFVJkzPunvX
         Ueqg==
X-Gm-Message-State: AOJu0Yy9LCc1GbFxkfY+WC2euiXeHLBEdx2FHFZSsKnmwgoBLSU02Olp
	U2QJ1TahpF8l0+cbVfHZVmqUXpXyoG8Y/m5wCEJgqQafq3h02lCja46E
X-Gm-Gg: AR+sD11JQp91qYJQZ/ah6GWz+sKfMHPMFqHAlYmVUAyEGjCOkNCiQ3FfDxnivFl8Evw
	5I9PLbkOYu1Z6++9z+bUpu/7fVt7vqtaQdjF7eBYUq7KWHfcHO7A32fpl1lHcXZJHdN8sk/KFVb
	IjyPSvlsJY701hCMzYq1LLo1VukkKw6ASgTOyJHZQHwgSQQ7vDC3HHKrFxwwOWAUAIbFRILb7Uo
	YWF1Yl+H7Att4T1YhTI4Z2acLHJsJN6Y7c70m8eRxtuFF/1MD7AFKv/+o9I3NP4FV/LbIA34o19
	8uTLj/D/8pGm6pI8xexF5WeJ+O0ysjq4/kWiio+Dlngb8HWG327VP+uuGFd8uMvVG3axqCf7rcD
	ZVsh0BIoL7z+wiwsayh2p31Mhj5yZavIlxTSwiYOFQSbE5pQJxRaHmrvzjHh2kQ9b3teGgDJTtX
	36nz/pyaFKLs1fb5uwR2/9AlSxSETuVN1IB3rf4pYO1C3Ie0jcuy/oBxr+gJTONsln9qo=
X-Received: by 2002:a5d:5d84:0:b0:47f:6f9e:1e82 with SMTP id ffacd0b85a97d-47f6f9e1ec1mr22772882f8f.9.1784733345394;
        Wed, 22 Jul 2026 08:15:45 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:17bb:9901:c6b0:b529:d03b:36d? ([2a0a:ef40:17bb:9901:c6b0:b529:d03b:36d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85b9a6d7sm7318330f8f.2.2026.07.22.08.15.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jul 2026 08:15:44 -0700 (PDT)
Message-ID: <2c76d406-62d2-4e55-8f14-5b5f8045ae10@gmail.com>
Date: Wed, 22 Jul 2026 16:15:41 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 0/9] sequencer: do not record dropped commits as
 rewritten
To: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,
 Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
References: <cover.1782833268.git.phillip.wood@dunelm.org.uk>
 <cover.1784128921.git.phillip.wood@dunelm.org.uk>
 <xmqqecgyn5gk.fsf@gitster.g> <al4RYuWKqAr-IlFC@ugly.lan>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <al4RYuWKqAr-IlFC@ugly.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Oswald

On 20/07/2026 13:15, Oswald Buddenhagen wrote:
> On Sun, Jul 19, 2026 at 12:29:31PM -0700, Junio C Hamano wrote:
>> It looks like this is now ready to go?  Any further comments?
>>
> you can add whatever footer is appropriate for "i read it, it seems to 
> make sense, but i didn't double-check" for me.
> 
> (same for phillip's new 2-patch series.)

Thanks for reading them through - I'm glad to hear the commit messages 
make sense now.

Phillip

> (it feels silly to "spam" the list with such low-value verdicts. i 
> really miss gerrit code review here, where i'd leave a +1 in passing.)
> 

