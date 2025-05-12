Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC68B25F7AE
	for <git@vger.kernel.org>; Mon, 12 May 2025 13:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747055444; cv=none; b=Y1I/aK7S9dUHrarrrTqUIP2pBX2/8oLp2WVOKbsTudRPovQVDH6Euws8IquPzQBJrE2cxi4Scvcwxv9sWWcHlKtDtvdPFiHAQlLbMalm6xWa9Y0fGNBgk9V+bEwaqpx5LI7OUPR3zjfiXcw86DJrCWAxd8OUNQzFrcIk5jcDFwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747055444; c=relaxed/simple;
	bh=JEsn8uBRSO+HMyNJ/jthD3qYlashxg/yrubGkGheAfU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kprastd1QYfnkkhh228qVrpo5gffCYh3XPq2nONEDeUT+v7ivwDcqCvpVUS8CPGf7ahdLCKxTNxtmSBStb937zErQVzwNluVyv2sDidXegHEL3OMwHwz0N4UHXqUlXR1Z3bFuXONDcTKhBNsNIZgTqQOV9V/AwfVBa1PRb3Amwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E+k1v/1X; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E+k1v/1X"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3a0b291093fso3408160f8f.0
        for <git@vger.kernel.org>; Mon, 12 May 2025 06:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747055441; x=1747660241; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=JEsn8uBRSO+HMyNJ/jthD3qYlashxg/yrubGkGheAfU=;
        b=E+k1v/1XxqzPgeAXzj9jVQQzHi61eKZLxns90rvDeCCWVniqsviOe63oxHS3bieKE8
         6ZD/hGjOrp22hDM2uYYdtnc2kiaXVpZb04g7ml6WaM/wrh+V0AR859w+RMniRLpjei3u
         zSew5n4Z0rFyi+ybjY7gLJVwIyAEGZIxY6pPW/yPRjEpcZ31+SlekYaTSEoPv9lgt+vu
         CkJg/NehQ23d5SKYiv8f2jDYvesnT39tM2VLgqTflUms7Sri9ScvRx7fjeKvBPYhMrnC
         Q2Itq5WqQLkVTPQSf09dGH9D++m5E620nIoMUVWFzJCeVZj3/AGxTU/70PmYhKLELdlo
         cciA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747055441; x=1747660241;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JEsn8uBRSO+HMyNJ/jthD3qYlashxg/yrubGkGheAfU=;
        b=btUqkqTyWHzq8pYE+ZkHnPBQeIhcRlUQXCv3EutJsvv8Hr1WVj/iVwZrY0wn39r4qG
         2n1S5s7t6klxBUqbOY1n/FggwiFi7MjRYuRyT2C92Z+W19pkdETg9nH2W4h9mlhafzvE
         0HnLCH2HOLPb54v6wpxL9/3CxJdG5LYcfviBYMwd9UqEAnM8kTonrueX4FQiXv6yfm6Y
         pgKuvjwyvVPMrc3mMHPWiYyEHXsYKE6nic1ZHAJLOtv4MM51L0P0rsKU0LzTUz+g65eX
         obrChLbe9R7R9jxSOW9sa8ziLdhKYhO9LBVryUhE0DRp1jCnYv77aYkwaU+hk3LMd/W+
         x60g==
X-Forwarded-Encrypted: i=1; AJvYcCW2fGCJs7dlqpx0fKZOUALEr47qv2lLO18E6Hj/2we6pYwz0cuJ1o6WcjOxfcDjXlhiNBg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn+l9AQ80gVypdT08p8JOV1Gucpz6B2txMpD+JifKWDWqE/UUo
	3Ppzsld2AvFMF7hzhfVSUKcNHlPj5szzSXA/sZUvPmM6axY0Q7A0
X-Gm-Gg: ASbGncs9CaH47dO3WMCelW48Uq+20+XfwzG9KAnIQj6uBrCjCON/58XBDZZrZqe8fUW
	mnaO8Y76SfMBAXMBT1Byaj17d+qHjMucdWMenpquwdHEs4EZym245rG69MCdIEu4lVy6YlMApKQ
	PqSn9zoPyizI8iXEI4wejblMBCi4g1mZJptK/vv9IsR4pFfUd1pxfT19uEeAAJkw7nuOfOy8jai
	c/BsVnmL5agkMJmqS5MBLtLAhV0Gyb1UBazqMD3eRCfAq4VKIW9o2WOxtCFAZLwpr6/k04ql8wY
	dojcb48xWNSaw6PB4nV57nJyXxdQqWwDwX3JFJx08Xr2Eb4TeWH/aEfupJBku53sZR3MHduCWQw
	A3rHyV32epxnolp4zfXQZ9T53hzI=
X-Google-Smtp-Source: AGHT+IGdMgK+BUNCVGm3FWGGHW0nsFYtirxF4UFhQCpRPkUue2VtFTypop7WMzTrtnCyDpMfXpa6tA==
X-Received: by 2002:a05:6000:2dc3:b0:391:1218:d5f4 with SMTP id ffacd0b85a97d-3a1f6c98496mr11030841f8f.23.1747055440759;
        Mon, 12 May 2025 06:10:40 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f58f2b02sm12626117f8f.51.2025.05.12.06.10.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 May 2025 06:10:40 -0700 (PDT)
Message-ID: <73be767c-229d-4914-bc7f-52fff36a9e5f@gmail.com>
Date: Mon, 12 May 2025 14:10:39 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 00/10] Spring cleanup of "contrib/"
To: "D. Ben Knoble" <ben.knoble@gmail.com>,
 Eric Sunshine <sunshine@sunshineco.com>
Cc: Todd Zullinger <tmz@pobox.com>, Junio C Hamano <gitster@pobox.com>,
 Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
References: <20250506-pks-contrib-spring-cleanup-v1-0-e6d5ddd79a72@pks.im>
 <xmqqmsbph3lw.fsf@gitster.g>
 <CAPig+cT6XbdzeOFoeZUmX+ozPa2XNOv=H85xQhY4y8NYmJZ6-g@mail.gmail.com>
 <aBq4J6UTZVPF8rb4@teonanacatl.net>
 <CAPig+cRxDQBmPu_-ci5vEuwtsAHadfCiFOccdYseBSj2F52JGw@mail.gmail.com>
 <CALnO6CDp3Kr_Ma49jzftN_sMkOU95xGZ0sMe2J2boG2pWggCzQ@mail.gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <CALnO6CDp3Kr_Ma49jzftN_sMkOU95xGZ0sMe2J2boG2pWggCzQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/05/2025 21:07, D. Ben Knoble wrote:
> On Tue, May 6, 2025 at 11:55 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
>>
>> On Tue, May 6, 2025 at 9:32 PM Todd Zullinger <tmz@pobox.com> wrote:
>>> Eric Sunshine wrote:
>>>> Although we periodically hear that someone uses it, git-contacts
>>>> probably falls into the "tool has a clear alternative" category. In
>>>> this case, git-related[*] is a separately-maintained more functional
>>>> drop-in replacement which people could be using instead of
>>>> git-contacts.

I think there is a value in having git-contacts in our tree as it
means that new contributors do not have to spend time installing an
external tool just to find out who to Cc their patch to. Given that
the script works and we recommend it in our documentation for
contributors it would make sense to keep it. After our experience with
the maintainer of git-related I'd be wary of changing our
documentation to recommend it instead of git-contacts.

Best Wishes

Phillip
