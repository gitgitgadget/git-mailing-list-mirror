Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315C2175A8C
	for <git@vger.kernel.org>; Mon, 30 Mar 2026 17:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774891410; cv=none; b=qkc+EG50rfKZgyj5z3jlgvN/YYpiTlIH1N9/pvWIrCb9EswiMxH6LWAmblNzea/h1sK3BF5YfVG7d/9oS9PFGEHs8fg/Rb5S1KYLvPRlqg4hzOgpKiLK91nky0x0kpoAs+pzhfrXJw0bp8OKfMpc/78SuRqHHOUoBuNtFaIV2nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774891410; c=relaxed/simple;
	bh=B5oRW+mObp+u1X35uRLpHTweUZmKLd1CTLJHGXl7qxs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bSpYhzHkuqurHhHjkeh1k5DRWaVBjRm84Afsvn+xapaPH1vQfAeeQLQeIYhj2x0yvvp1ns5yEUiysxgyGCUDgTW7Qa7aoqujhpdo12tpV+PkYfveVect2/zfhxQ7FoXW8PIEesas+wSGWakLrSC5kHz24xkJOZ970HZakJjdOyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IIq2QzGP; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IIq2QzGP"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-824bcb2011bso691375b3a.3
        for <git@vger.kernel.org>; Mon, 30 Mar 2026 10:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774891408; x=1775496208; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iJz/W1i8egh7k9ZVtGchwhhOwO6sswaTJbSVT3F1g7o=;
        b=IIq2QzGP0/SkYGtVr/iCvLlQXipvHWRgLIlQCs3NnKG4suJtTvoIdbv4XA5QWeAkXx
         rZrguV/nDj3b4bwW8w7jvkeGCxOB/Bn6KK7/0ewr7pu7iuS1b456fwSsYPUpYGVt8UR4
         Uj/OyXekw4MRhXt53LKci3w57OtvXoASlj/6ARkVIrR9tR8VDO9ruMUgeKmGofZyKA/4
         Bo+ABH46WUSnrqJlhjr3IAVxjRSuCNfgpUTrenNHhZLkgduoJ5caHQ5d46hIdDr3JJZ0
         SAADJ0RdnvU/LYFqHtOQv+hsI3ebpVvz+QFXEwv/ei24tTY1HrsFi5i9xkSIon0HqT60
         G0MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774891408; x=1775496208;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iJz/W1i8egh7k9ZVtGchwhhOwO6sswaTJbSVT3F1g7o=;
        b=R2McVFFnhvHQpTQkhEu2jUPAnk6YbzHP4rOvIu9sd47RRhFYGtkTKdyJcRvcRYYrvp
         Maxu1onc9gRa7Wrc78OgoluYLWc58ODlSkbJ0z3uzwpID9pqXFYjYT4dg9QqIkEkWCke
         QrsdrWQM8nfV6v9lqyx/snW4rrUAXZU88bzQ3c4r/ASA+Gv9wP7hq3kMjRkcproEO24h
         fDdONY1k0Mn4HyFIq7PEEn3zR0YVys9RfxRzYyD48VpQ2O7gKpJg/Kus2A/0OkE5f1c6
         JLQthj/mlzU90iGZGQVj8UJm05Do6JFQvKp2fZAQ5KEXzjJkgC1PtcmWrMky+HP+n8he
         6fRg==
X-Forwarded-Encrypted: i=1; AJvYcCXpwBDAQ1u+keH/xXYd7STj17DzR9x7a4ztWbrpkydoxhw6TDdRriWLKf9BUwMNxOoK+vc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7jRlfZmAKXlLjVqDrcFTpnvkyh5WrSwv5JsWHEWCTri0ZZyYS
	webx0KQbv9Prf0t8FyBj7UdwL5e6aYcveSXO3NOSkXpkN6ci4K+KAn37
X-Gm-Gg: ATEYQzzqplORSbFqxv1NaED7X7EzU8zl30kcQW7utJCCmKWZvWg7Fqnfz6ojyjFIvVE
	5LpkeavjZ/94/fCzC7DryXxSRyCM5nhQJKZpeVn5GvZQI3IBG3QQ0MLq1blQDt/kHxZ8LK9eQ2S
	MLg/fANFRM4O6jr4WfCu8rf5zeJF3q5Rf1AL9DN6pSr4ayfST+oJVbrrGTwH31VldkeZOQxvIv5
	3sGE5B30oUK7+IB+WbAOWLP4ylxzvMeQgTOxWsGM9uP3KadfOU0s6rXJLTKOUlDVOePcgMnnxXB
	xWPmQs5LoRtZ/ZCvNC9baJq4SgAU00aKgch2OKOJoXjxYxu4beKCgqB9AUHcnWarcFtUvnodTzD
	dICA7Udd3HvAmuqk9iPPgzukZQoVArkASzPnAEsQaR8AUAo4ghP3LuiT2qf0WMUQR+gxq0RgALK
	fBgNMHXQmKL70k3iZgBynQZSMys8/I+vudiRUoknYA2zsWzh8t5q1kJY1dyKKXLINqQcLABVkql
	kfOucVd+IY=
X-Received: by 2002:a05:6a00:1ac8:b0:823:b2c:4aa9 with SMTP id d2e1a72fcca58-82c95e86ef7mr8408255b3a.2.1774891408472;
        Mon, 30 Mar 2026 10:23:28 -0700 (PDT)
Received: from [192.168.0.109] ([155.69.180.3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82ca863063bsm7547976b3a.59.2026.03.30.10.23.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Mar 2026 10:23:28 -0700 (PDT)
Message-ID: <1cf080ba-61a1-43b0-abff-c7c156c1c4b1@gmail.com>
Date: Tue, 31 Mar 2026 01:23:07 +0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/2] replay: add --revert mode to reverse commit
 changes
Content-Language: en-US
To: Siddharth Asthana <siddharthasthana31@gmail.com>, git@vger.kernel.org
Cc: christian.couder@gmail.com, ps@pks.im, newren@gmail.com,
 gitster@pobox.com, phillip.wood123@gmail.com, karthik.188@gmail.com,
 johannes.schindelin@gmx.de, toon@iotcl.com
References: <20260324220401.47040-1-siddharthasthana31@gmail.com>
 <20260325202354.10628-1-siddharthasthana31@gmail.com>
 <20260325202354.10628-3-siddharthasthana31@gmail.com>
 <05959eb8-4b8a-421e-bf5f-9e6f0b59a313@gmail.com>
 <6427d088-e41c-47ff-ab6e-4d7679e85d3c@gmail.com>
From: Tian Yuchen <a3205153416@gmail.com>
In-Reply-To: <6427d088-e41c-47ff-ab6e-4d7679e85d3c@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/30/26 00:17, Siddharth Asthana wrote:

>>
>> This is a fail-safe design intended to prevent users from entering 
>> commands like:
>>
>>      git replay --revert main f1 f2
>>
>> This operation is indeed undefined which should be intercepted. 
>> However, considering:
>>
>>      git replay --revert main HEAD~5..HEAD~3 HEAD~1..HEAD
>>
>> Is this operation also intercepted? I think the reason is that the 
>> condition 'rinfo->positive_refexprs > 1' is a bit too simplistic.
> 
> 
> Yes -- positive_refexprs counts each position tip, so that gives 2 and 
> the > 1 check catches it.
> 
> 

What I mean is, this operation shouldn't be intercepted, right? In my 
view, it is valid to select and operate two (and more) periods from the 
same linear commit history, but that is blocked here.

Never mind, it's nothing important. The rest looks good to me. Keep it up!

Regards, Yuchen

