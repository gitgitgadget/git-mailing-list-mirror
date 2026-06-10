Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633202264B0
	for <git@vger.kernel.org>; Wed, 10 Jun 2026 09:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781084043; cv=none; b=qmuO/cDkf59AYasNwSs8u+d0ieI8cXaLNnv5SBOkthjuy5822eO3/G8Qdr+QGi969jgb5ixSxOA/Zc71B5RLGIqsFCExk9T65oFPLZRIzbjOcivbKN0C4Dufp4cWF9EgBSBbQ5u+y0SZGpxr5EdL9VlJwUSjJF7GGTmnb/uhefA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781084043; c=relaxed/simple;
	bh=e8AhWeGXWsrxSj41Wru9hOrIbzgryUa1+qOqf9NwL3w=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=s6k7n6VKOVyY55JiDaBIZeIw53K0inXGkpkVTvOL8WGfQSxVz0o/xTLwT6eaJ1UJ4dW+e1wH+MdFGsWsghG3T5DYmsLSiKHcUpbFyPHwJMZcYEY8VVoH2b/gaFzolGhHktvnE+D4d9uP4kzu7/S3QXeFG3ql0kLeUdJ3tWJks2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IwXJSW8n; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IwXJSW8n"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-691c5776f95so5583158a12.3
        for <git@vger.kernel.org>; Wed, 10 Jun 2026 02:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781084041; x=1781688841; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E663UeBiGJEr20yGssKT7W6A/zV8nsiAE0hvFWq+Y2Q=;
        b=IwXJSW8nOpV3fHQWnifUibKtKfIQTUjihzz1Y2gi6E93CHyHIDEECbMCHUglJmvkJu
         EaXabNOaLqThF4xSAWqiHw+qIywiLHflz5ypJiKq43NN2WEhd2Uo+8vHk8XG4zOWdvBq
         kRqSuviZXXjc7S6/Ljo9kQCsfXU9EeySz5XFBGmLz/r1IldZiEBFHz03BrvPpIcCsvOs
         wJoBT5rWNWEKzKo3jL852iY0GDz+2sIzKVY8quhbOnu3QxxvtwqZ2HzbidsqJd25EfKO
         s1VlczCNc8MAsMh/CtAzXKr2yh+CVNc91ACuby2fGw/6KALuCt3YDWSlKFvJvC/ZiaBN
         ZxuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781084041; x=1781688841;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E663UeBiGJEr20yGssKT7W6A/zV8nsiAE0hvFWq+Y2Q=;
        b=WviCFJj4Wp2PNacQ2CVy+lKqcYtcCRoO9eVGJp66b3x5jrvw1VLjFGjJoYhzWpZ/dP
         WQnCGu+MUqwk+cf6RL5T+hzQYujEXPAyFML82+m8+u9Qsy/ZQt9rRSYQQDHH/erfdDPW
         DRdAdAhLcf3TNhaOfFEz/D5UkF+FAQWAcBVwQKXh+7Oex9mAtm5jv9dDxRXjbFVyCy35
         7o82MD0sqOdvHoPO90WscgrcyaVyKgECdSjQ0qbNvDkaUMPDtnMFDagKXnrlJQC64Lnz
         V9ICe8itYOR6bYmGP3Uc4uQBn9cIzxeQjtJMUDdEtCHDFdqZYZnyPjQ0vpYx0EXlYvVw
         0imA==
X-Forwarded-Encrypted: i=1; AFNElJ++db7j7fK7Tzqkj/KZL2QCsDV6Fmcb/barPThuq+KJZMlBlFaSovep4gUbd9WcPipIz44=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWpr42nzh90oJd98unnF8ppifRCX+42VWDsb1M7PR1sK0WzqEG
	vr0sXLqPatTydarqZWXE77CYNGQgiBV3FR8iT1A8mjEPde3tlPfXjjIH
X-Gm-Gg: Acq92OHzSvCU8JUt0As9jl+g7wfD0ZjUvYOh85kN83ySeesUtNhygfhF906JZd3D1z7
	thM5ksBxIA6K+Nb/Dg5tN4MA6P+KrY55VRrMoRpXN9JhmzTMrzaYnPtOOjtwMcH5BKurAa/Lhu5
	uyPkmbPIg+Km1D24yhGp1XRjPpgn8zsPWo19ZekZ88zPekcHpk7LxLZQaNMNVmMOZlFHPgSBLtt
	IVM3I8KKXLAc1w51Nb8x8ug0a1gu5SsYU15ysR8EmQEGNHmKQDbykLL6Q9y8cc8Jr5xE+/zPutt
	heeTUQyMPkGSMngCvZXFZh24UEv2byBfu6YXHW+IcBjmlA0vtJf1XzRCDFWqRm8zGAJzVV0XyYs
	N6uM/CGSQQua2IICCbe+PJ4BokRs4lWqXBIQAcfh2suJN/J4fdtSWUjOowfO/SS+2WLSlPRrQby
	5GTnpTYWk6jUPB8GVno/VqvYPflVo9RFIv0QTOcsEFI3wimnOR4As4JbLxTXUOIUqvZOj3uFLQV
	7+NrSqj/oiIoasg
X-Received: by 2002:a17:906:8a57:b0:bc3:7b0f:91ea with SMTP id a640c23a62f3a-bf370e585a8mr767415566b.19.1781084040374;
        Wed, 10 Jun 2026 02:34:00 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:69a:b801:201a:26ab:8d41:fb43? ([2a0a:ef40:69a:b801:201a:26ab:8d41:fb43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bf051c85e76sm1184197366b.15.2026.06.10.02.33.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jun 2026 02:33:59 -0700 (PDT)
Message-ID: <e033b216-d8e7-4c16-8fb5-0455125b71a3@gmail.com>
Date: Wed, 10 Jun 2026 10:33:56 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH RFC v2 2/2] builtin/history: abort reword on same message
To: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Cc: Pablo Sabater <pabloosabaterr@gmail.com>, git@vger.kernel.org,
 cat@malon.dev, kaartic.sivaraam@gmail.com, ben.knoble@gmail.com
References: <20260607-ps-history-reword-v1-0-ba43a3cbb81b@gmail.com>
 <20260609-ps-history-reword-v2-0-a0e6028ca9b4@gmail.com>
 <20260609-ps-history-reword-v2-2-a0e6028ca9b4@gmail.com>
 <54bd36e9-3d21-4f83-86d6-2882a14779de@gmail.com> <xmqq4ijbsn2m.fsf@gitster.g>
 <CAN5EUNRz9F+njb_O=Q4DzVMec-q+rDf83Ow+MPJE4yLCBq9qww@mail.gmail.com>
 <xmqqbjdj1q1s.fsf@gitster.g> <aikMLBCC9Rc7q9S7@pks.im>
Content-Language: en-US
In-Reply-To: <aikMLBCC9Rc7q9S7@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Patrick

On 10/06/2026 08:03, Patrick Steinhardt wrote:
> On Tue, Jun 09, 2026 at 12:17:51PM -0700, Junio C Hamano wrote:
>> Pablo Sabater <pabloosabaterr@gmail.com> writes:
>>
>>>>> I wonder if we should check that the committer identity is unchanged as
>>>>> well in case anyone is using this to fix commits after committing with
>>>>> the wrong identity.
>>>
>>> I think that if you reword a commit committed by someone else but end
>>> up with no changes I want it to be kept as it was.
>>
>> That depends on the reason why the feature to "reword" the commit is
>> being used, and the use case Phillip is talking about is a bit
>> different.
> 
> So the answer is "it depends". Maybe we should do handle this the same
> as git-commit(1) does with its "--reset-author" flag?

For the case I was talking about we'd want to reset the committer but I 
agree that making "reset the committer" explicit and just comparing the 
old and new messages when deciding whether to skip rewriting is a good 
way forward.

Thanks

Phillip

