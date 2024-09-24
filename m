Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5ADA1AB6E6
	for <git@vger.kernel.org>; Tue, 24 Sep 2024 15:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727191808; cv=none; b=X6jQpAvbGChOwAOQchZiEeLz/F0WH2HJp6cbvTh0p/BEcCpkJXaTxwClFk9bIwETXs+/jCLZTeYITHGb+Y6mZSIXJheigo82hI4cRF5aC4NMwUviu+UdU4vyiINjHmCrtLrKf9j5JEuHCvo27EuBlqOvuxuf3WrkrH4v+JGaiyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727191808; c=relaxed/simple;
	bh=Q+Ge1Y8yT5a9yTrSVyznMzAS/W7bduflkY969fxnL1Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ccl9OItH4Cx5albYv+gOFw7JvREjNEiCasN5yIUSQcdmqB7/WpTx18i3E9+L2lcjBaZCBovf0BpPypG5yZ3E1EvYMUhJUnegnkeL0GWazU5JnCP+0w7XUqqPRqSM/k2IlFtMhGe6r40o4Z9qezuM33DlX1SeRiOZ26YEkfrhQM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QDISETj/; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QDISETj/"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5c275491c61so7530814a12.0
        for <git@vger.kernel.org>; Tue, 24 Sep 2024 08:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727191805; x=1727796605; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=GJmAbRVs4lW9AU/gaqdk25CYKGOa2LxCaZLWxynjMug=;
        b=QDISETj/pMTT1Kg1Zdm88sjT4/lv77g8eyrOzI4i3DpdgvpCzVl6oWH9+LC2h6+ASR
         46Q4q8CjB1cZaM3oVzDh1FhyoGFggs5lmDlBWaGhlzqsz7UbOZGSFu52nklKsLpkulQu
         uK62Z4ncRz56PcewZ26UmYjuVd2d7gfgXkUkpRizkiYZMUhqikAHDNoS0MVJa4M0jpWJ
         t6fGN6lbZa+fhyI6LjRhFEtzxSZFRzPNw6f8WyiAyfXn/y3AUuq/2EuEgMKu9pmje3kT
         D3T+IHJfQR1WiXhYrNsHQxxzRyCcRUBdpm+9/Qkhio2hDUPHJK8BawAhPbr3TjgM8NyH
         Vy9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727191805; x=1727796605;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GJmAbRVs4lW9AU/gaqdk25CYKGOa2LxCaZLWxynjMug=;
        b=gPXbt4Ah+akq3TO2Cj33q+5fXdqJxfKoBr6odfK57XSxrMk7Apog/HLdu3i5HI7j8l
         Nk5i/9s3YC64BUtzOg5PCTx54hEoun66CWtXqZLtlfpH5t0iuafgjMNPLSEWi56RxxAC
         G5FrqcXXMbsJAdJp/M1gIHfkMqciozhs6a9qjFtnMU3oJF1+UIB5dXh/VfhzZ9GFCdmS
         FOqux/ud0z2PQeawmZ9rvpskrbS+SdCSH91RPlGQhAgVxr6DirTI2+evsEG62d2zI97O
         D3PrRdJYXYW2cgeF5pIUtT+JJbEnSeLwhoXylUC+zRvqrq9jtsQgx8MqxNO9jpNcCDyn
         l1xQ==
X-Forwarded-Encrypted: i=1; AJvYcCXtcEkmSHPDjAXBdZ3jl6cbs6RrCihYfYIuevx7L0CpPkdxMDYENhbvSHO8Twn7OxNlMmY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKqQ6byLxbHRc4/QVacUlrFu02777JrbsfdV4O9WCNPqd6iiLZ
	LF+mXhBDIha/6x2OHvav43RZn2YnEC16Q2iE80ahO8KEZO6qLrZ5XMJO+Q==
X-Google-Smtp-Source: AGHT+IFuC1cPpzRoEE8YBEQKvqcG0lr7hwaHccYNfJCOoQLYX1LxtjILYpVVVV2Spz5B7GT19vydlA==
X-Received: by 2002:a17:907:d2e3:b0:a90:41a5:bb58 with SMTP id a640c23a62f3a-a90d5611798mr1396348266b.16.1727191804601;
        Tue, 24 Sep 2024 08:30:04 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:61a:f001:1402:4f50:9447:3e15? ([2a0a:ef40:61a:f001:1402:4f50:9447:3e15])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93930f0b23sm97297166b.144.2024.09.24.08.30.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Sep 2024 08:30:04 -0700 (PDT)
Message-ID: <18d732da-ad34-4a45-b59f-cf2cb3c7238b@gmail.com>
Date: Tue, 24 Sep 2024 16:30:03 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [TOPIC 01/11] Rust
To: rsbecker@nexbridge.com, 'Sean Allred' <allred.sean@gmail.com>
Cc: 'Taylor Blau' <me@ttaylorr.com>, git@vger.kernel.org
References: <Zu2DmS30E0kKug2a@nand.local> <Zu2D/b1ZJbTlC1ml@nand.local>
 <053f01db0b79$0d885b30$28991190$@nexbridge.com>
 <m0v7ynm7h0.fsf@epic96565.epic.com>
 <00a501db0db2$94d505d0$be7f1170$@nexbridge.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <00a501db0db2$94d505d0$be7f1170$@nexbridge.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Randall

On 23/09/2024 13:17, rsbecker@nexbridge.com wrote:
> On September 22, 2024 10:26 PM, Sean Allred wrote:
> 
> The GCC dependency, which does not currently exist in git, is independent of
> Rust. > Rust has its own rules and runtime. The issue here is that the Rust team
> gets to
> decide what platforms can participate, NOT the platform maintainers. No
> matter
> what my intent, or resources, I cannot get the Rust team to "Allow" a port.
> In
> many ways, this is egregious and is a policy issue entirely on Rust, not us.
> We
> want to do a Rust port but are simply not allowed/approved. It is their
> policy.

I'm hearing that there is a fundamental incompatibility between some 
aspect of the NonStop platform and rust's requirements for supported 
platforms. Does that mean it is likely that rust will never be available 
on NonStop?

> I agree that it is not a good policy to never add new dependencies. However,
> Dependencies must be reasonable and give the platforms a chance, at least,
> to adapt. We cannot in the case of Rust. The problem is not actually that we
> can
> do without new features that are in Rust but not C. The problem is when
> there
> are CVEs. Suppose a severe CVE happens that is fixed in a Rust component but
> referenced by a C component or somehow intertwined. The fix to the CVE
> becomes unavailable and git gets thrown off the platform. That is the
> reality
> of how insidious CVEs are when it meets corporate policy. I am primarily
> trying
> to protect from that.

In that scenario there is nothing preventing a different fix being 
implemented for an older version of git running on a platform that does 
not support rust. It's likely that such a fix would need to come from 
the community using that platform rather than upstream which would 
represent an additional cost for users that have previously been relying 
on the upstream to provide security updates.

> Telling 10-20000 users that their core bit of infrastructure is insecure and
> not fixable
> is not a tenable position. However, it is hard to defend the community when
> the git
> team is hell-bent on this particular decision. What do you need to
> understand here?
> It is a small community with a large number of users in key financial
> institutions that
> have a very conservative adoption policy and an even more conservative
> hardware
> vendors.

I'm struggling to understand why such a conservative community needs 
access to the latest version of git. I'd have thought that key financial 
institutions should be able to fund someone to backport security updates 
to their critical systems.

> Again, it is not the gcc dependency. We have been coping with c99 and will
> have c11
> shortly. It is Rust itself that is exclusionary. It might be easier to write
> new
> functionality in Rust - it is easier in Java, Perl, and Python too. Why
> Rust? Because
> someone wants it, not because you cannot implement the functionality.

It may be true in theory that anything one can write in rust could be 
written in C instead but in I'm not sure it is true in practice. In 
previous discussions multi-threading has been mentioned as an example of 
something that is sufficiently difficult to get right in C that 
contributors are not willing to implement whereas they would be happy to 
do so in rust.

I believe that those advocating for using rust are doing so because they 
believe it will benefit both contributors and users. The problem we have 
to wrestle with is whether those benefits outweigh the cost to the 
relatively small proportion of users who do not have access to rust on 
their platform.

Best Wishes

Phillip
