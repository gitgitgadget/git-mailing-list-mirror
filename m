Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70BC6346A02
	for <git@vger.kernel.org>; Mon,  6 Jul 2026 13:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783345173; cv=none; b=WcSWmVjLkF5tLhPyiik/Oiji565wLmXhON5FcTX7o91yJ+au4c1Go4chmv2CHQSHAZOogXmW/ffgAc2CGQ8MJPGuPwpn6IuCZY3vnlMqkZDk4tGSmgXM9/ph7xUUEKudIwv6A3VJA8XqAyUUiWUuLhp9bK3KFphuEPFRUVrX5I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783345173; c=relaxed/simple;
	bh=3U4KyAlUgrKJtedhZ62uz5/nqo60HHDKWl+FcgPawSY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nf5mOkw3Nbfccf1ANMn3R5Ie3/gmsxMRcA8TY57pDk/ltL4gAyGZbq214UdHV+YeuDALo2KnhyzLF59oFnnF7HMQx/VTRajsX5Q/2HOlLgFKgTliLnZDxnDeQBMJ3gdftWl5sNcBCU0j8DvJ6CftuPC1NXqU9gclqW4ltyphBAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BIK9dCaX; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BIK9dCaX"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-475881b9a4bso2647005f8f.3
        for <git@vger.kernel.org>; Mon, 06 Jul 2026 06:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783345171; x=1783949971; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=VSDcHJUfbrSOPSbAI7nF5q6U3H2TdGO+1tcjs87lCQI=;
        b=BIK9dCaXnBsusm4bmpjwlnxQcTapC6g8dTfut4WIBCb51XqYSF3mrkcoJV3g4F6UrP
         JRR2BF4txYz96SzNXTG7Z/HPe/jqXGFLPz8RS8Nj6HVp0g4Jxr9b52l/B2WP8IFyAFsg
         ITvQTBIhGcmPSZjEIaM5JJFbZut+Gkd/IH1Kcm6QuTdrAbAEjyQcnYlJe/lSx0SzF7Zo
         JYcfaLroCHPLCw02kFQWGsBaZ5C/ihWimKG8ZPfK3bPJX2sjyuTIsiwunBc6MkxkSQha
         m8BrM2e4ShzjnldjadSJDQMXtjcBcswYx16c4cOok7T1MIIManBV74WgQDG0MkQOwGlt
         QG9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783345171; x=1783949971;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VSDcHJUfbrSOPSbAI7nF5q6U3H2TdGO+1tcjs87lCQI=;
        b=JMdkhlLViO1CAxNtBKmO/Tk8JBXBqhvFGsPUiVh14xoqkCjs7kncxsbaAEvju98vhT
         kIwhWnQVQf37J/3rFeef3jlgGRuDYs9EwUaSm2OC5rkHBa9YXZDyO68GjIhS/+p1UlB9
         wZ0laW+wb4CVLKhh/7zJVHV2sapExI5L5jQVE0PuNpZtxO74xuLOdvlu9+YQeH7G0Uix
         uNY2Fv3WsZql6XCgXr1kP+lvaf+m61NeHOo/t9FVb+5wrWm2ecyxb7NlAt1ZeIT++6Zb
         n7y1ce/bwNfHWLj2mtaH5Ps3G5y6AM+2vltNM+1xPW0YW/hl4lHF8wAMpvnYgIxl1vRT
         NwPA==
X-Gm-Message-State: AOJu0Ywxh7nZEaZZicAiZXkPzxn2NPTDxQuaMJcGO+bIZPIFMsWN/qtj
	6m0oAf+6mW2/3F+ujAsM50zgqYLmAcB3NMamJWbORqpUTG/4xkDiQqAV
X-Gm-Gg: AfdE7clns19vwV30Mngo7qa8QoQhB6qHnJ7YBu02Sjtwfy0rJIw1NefIJvq9X9Yo3l1
	yIMDrTxjMKCODBtGzF8Grl5NY6ZVXlCeTdTJJecNd2wX9IaKLX8ZYiX/+1WG2Sjceubw7wuGA/l
	ZPytS3K/PVUXgY/hQR6s8MZV12jfjdRFeL1dPKG/Ipm+7p29iUH43QxGAt5oTSXwDwJgcNqJMwN
	nPtJEFyOgCzvi+w2+t1S1NYNA+vsDc5vx9UM0ZZ5Eglq+zrvIPsYu6771gq8q8XzXQavRHEnWUV
	hIv8u+xFzNIY50Z7HdNFZvgGM2a6Sg8s5BPiNB1wP4YBPTrsJWt4FYUzNBHDqrlsaZGL2arGVCT
	laDQ7at0XH1fthB2A79MWVC4u01RexY80ERAIBaC+XpZCnHum5lxLE3sQlWykrhWItMlfNhezYb
	4IhaR9xJHmyQhsFoBhOr0bdC/btD3RVoZOZfyL9opfXrkCcuO71VVHCnTA4ltDJqb2tcA=
X-Received: by 2002:a5d:6910:0:b0:475:f100:35fe with SMTP id ffacd0b85a97d-47de66fe2d0mr150356f8f.59.1783345170593;
        Mon, 06 Jul 2026 06:39:30 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:69a:b801:201a:26ab:8d41:fb43? ([2a0a:ef40:69a:b801:201a:26ab:8d41:fb43])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0f2186bsm24369480f8f.36.2026.07.06.06.39.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jul 2026 06:39:30 -0700 (PDT)
Message-ID: <9771702d-49c4-496a-a77f-22c244acc443@gmail.com>
Date: Mon, 6 Jul 2026 14:39:23 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 10/11] sequencer: use an enum to represent result of
 picking a commit
To: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,
 Phillip Wood <phillip.wood@dunelm.org.uk>
Cc: git@vger.kernel.org, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
 <u.kleine-koenig@baylibre.com>, Junio C Hamano <gitster@pobox.com>
References: <67dbfb5c-5f07-49b8-aa32-a4635c585028@gmail.com>
 <cover.1782833268.git.phillip.wood@dunelm.org.uk>
 <e4050ead27f1e01ca72acc849fa16bd67e0d1c4b.1782833268.git.phillip.wood@dunelm.org.uk>
 <akuNmMFST8W2H2Ru@ugly.lan>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <akuNmMFST8W2H2Ru@ugly.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06/07/2026 12:12, Oswald Buddenhagen wrote:
> On Tue, Jun 30, 2026 at 04:29:00PM +0100, Phillip Wood wrote:
>> Rather than using an integer where -1 is an error, 0 is success and
>> 1 means there were conflicts use an enum. This is clearer and lets
>> us add a separate return value for commits that are dropped because
>> they become empty in the next commit.
>>
> have you attempted widening the scope of the enum? the three conversions 
> between the new enum and existing int return values irk me.

I know what you mean, but how wide should be go? Using the enum just one 
level up the call chain means converting a whole load of functions which 
creates a lot of churn that someone needs to review. I decided to keep 
the enum limited to this scope for now to avoid that.

Thanks

Phillip

