Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE93647F67
	for <git@vger.kernel.org>; Mon,  5 Feb 2024 18:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707159339; cv=none; b=kFnFXWH1KDTwlLq0tZpQFPHl3RwJFnM4jzyGCViTqbPCdjlDS7vyN8XXtPRuO97HYKldhbEmZe2rCqtESX1WHbUkVtrCWm7rbcGJD49K0SYrTE2kESIQrTX/y1Z6cxcLurLtswMtRVpUDA+pjmylXtB3fOneW9qzYGK4QyR9b4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707159339; c=relaxed/simple;
	bh=TcLwj9eureKFt8zTK8rXwPZ9qXyv+PR6lRizOXXDx4g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JsbtYDJrKX/ouake6i9e3r77ztnRa1EDJAyUZmUqbfQrBIsRAc93w4IxnnJ/hZfTxAKPWhvBUbn3+uZH91m94aYL126m0RE95Gl6z7wFFytnoifD+5GsJz2Vo67kuWKjq9nee49Szf//BSaGaRbUdmhbpv5YTpbGT7uHVmZaZws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=etdFRmNQ; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="etdFRmNQ"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6e04eca492fso514830b3a.1
        for <git@vger.kernel.org>; Mon, 05 Feb 2024 10:55:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707159337; x=1707764137; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wg+/3IfIYMlXUW+UJD+f4nyKD+KR8u/jMt58QYPT/9I=;
        b=etdFRmNQtNdIzvZch3LJzMooFXQvkj4T2Y/b/Ddh05wu7sqeM6JP3c8ImL/LtEhkHR
         ifPbBKEMNHR4Pb85+87i1Za4mWHet/pyHZzy+x3illcDoWRSkvt02IXnVLE0fvVAxc6f
         OGNG7Xm58lGwymyRKAhH3hYkhwGYdDPKGucoU+KBPmRobG4QFaJ/8ZODG6m2AG0hVC/p
         eUF6vF/pZb9BswSna+IErczoiwywDk353tjGDoxhYCfFAMq4bXYor1yLulYEkeGuUPLG
         4J0a2aQqU1D1cn5JyHzyfZVVmffmRXnCiZnZyeWjQupzywYQD96hp1whK5HlEqC6I/uB
         kk0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707159337; x=1707764137;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wg+/3IfIYMlXUW+UJD+f4nyKD+KR8u/jMt58QYPT/9I=;
        b=oyyZl+JCQILt3oL7UEDXKonHSyWbIDiCwuOQZLH7e248X6lcnIkoz1ELqcj9Oh2PVF
         iQeQwXp7q1sv1LTf00Z/Fid3noagCUVsT6mCt5oAAa1imc1FFTm/5goBh2fSwRQmlr28
         UGGoILyr+QSgB9vPW0sFZ1JbSAL5WExAdrY1vTHMf0i0FeHGmRBlkptkYvkTffO75W0O
         qYxI8mWYjvUx/ghiZq5l8hgYF1U9U2N3HSyCrm6qra2Fclh3QSdpM/9pMU+SNGQDJ0To
         oVQ58BCqehSFHgMZEWl2NCOS+Zcl+v18XUH8XrIAWRLEp+bSj7K5MLC0H7ebzi9I+A+v
         MEdw==
X-Gm-Message-State: AOJu0Yz0tCSseTCT1EUyYCtiPtXGGyQja18MziEeMF84EILAOYegBjIx
	zZ1HPWHNLZdxPW60qU8dkQ3it4pocMHFwYTqcfQOFaC9FL82wjNC
X-Google-Smtp-Source: AGHT+IGSwznyUdVS36/ppBIbdCU/wf+hYpDGSk9bkwEaQXXpIasw2+aunn51G1/bfQGH7NPiVeHxgg==
X-Received: by 2002:a62:ce8d:0:b0:6e0:3d29:8eaa with SMTP id y135-20020a62ce8d000000b006e03d298eaamr409932pfg.7.1707159336901;
        Mon, 05 Feb 2024 10:55:36 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCW4VnR/wuBZhQJhwvZwltM+f5kHVY1V57xNgsU9+Vsrh6tfvlaUb4rg7S7naR39eCzf9TZ5Uhz6L/ShjSE01waccZ5RX90Guf3WPs2i5DRnYqdormEyH9Kha8hcgjUBEog51yQZmhAPIrHcIBFQ3g84CguK5dh4Z2J3pYRWo+K5Kd2+lPQJ
Received: from [192.168.208.87] ([106.51.148.224])
        by smtp.gmail.com with ESMTPSA id x23-20020aa784d7000000b006e04f2a438bsm180428pfn.105.2024.02.05.10.55.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Feb 2024 10:55:36 -0800 (PST)
Message-ID: <e1c04f67-5981-4393-8a8e-a28cc53858eb@gmail.com>
Date: Tue, 6 Feb 2024 00:25:31 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Add ideas for GSoC 2024
Content-Language: en-US
To: Christian Couder <christian.couder@gmail.com>,
 Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
 Junio C Hamano <gitster@pobox.com>, Victoria Dye <vdye@github.com>,
 Karthik Nayak <karthik.188@gmail.com>
References: <d4797f27-825b-4e2b-85a6-cc30f33934e3@gmail.com>
 <106b8e7be9ddc2d24670b01d54347dfcf9aef196.1707122040.git.ps@pks.im>
 <CAP8UFD3F95TzytdpKO=LLf6Y_ejxwh9QtgAxRNKgMXW-72hjgQ@mail.gmail.com>
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
In-Reply-To: <CAP8UFD3F95TzytdpKO=LLf6Y_ejxwh9QtgAxRNKgMXW-72hjgQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Patrick, Christian and all,

On 05/02/24 22:13, Christian Couder wrote:
> 
> Thanks a lot for these ideas! I have applied your patch and pushed it.
> 

Yeah. Thanks for sharing these great ideas! I've submitted the 
application using the new ideas page now as mentioned in the parent thread.

>> +### Convert reftable unit tests to use the unit testing framework
>> +
>> +The "reftable" unit tests in "t0032-reftable-unittest.sh"
>> +predate the unit testing framework that was recently
>> +introduced into Git. These tests should be converted to use
>> +the new framework.
>> +
>> +See:
>> +
>> +  - this discussion <https://lore.kernel.org/git/cover.1692297001.git.steadmon@google.com/>
>> +
>> +Expected Project Size: 175 hours or 350 hours
>> +
>> +Difficulty: Low
> 
> "Difficulty: Low" might not be very accurate from the point of view of
> contributors. I think it's always quite difficult to contribute
> something significant to Git, and sometimes more than we expected.
> 

Makes sense. Also, I'm kind of cat-one-the-wall about whether it makes 
sense to have two projects about the unit test migration effort itself. 
If we're clear that both of them would not overlap, it should be fine. 
Otherwise, it would be better to merge them as Patrick suggests.

That said, how helpful would it be to link the following doc in the unit 
testing related ideas?

https://github.com/git/git/blob/master/Documentation/technical/unit-tests.txt

>> +### Implement consistency checks for refs
>> +
 >>
 >> [ ... snip ... ]
 >>
>> +
>> +  - https://lore.kernel.org/git/6cfee0e4-3285-4f18-91ff-d097da9de737@rd10.de/
>> +  - https://lore.kernel.org/git/cover.1706601199.git.ps@pks.im/
>> +
 >> [ .... snip ... ]
>> +
>> +### Implement support for reftables in "dumb" HTTP transport

Would it worth linking the reftable technical doc for the above ideas?

https://git-scm.com/docs/reftable

I could see it goes into a lot of detail. I'm just wondering if link to 
it would help someone who's looking to learn about reftable.

-- 
Sivaraam
