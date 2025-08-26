Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A301991C9
	for <git@vger.kernel.org>; Tue, 26 Aug 2025 13:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756215196; cv=none; b=B3gMsIePx/Ygn7aEn4gm+i/OFnB1NwksTJf66IO1xywUFCs8zgA47XV4H5Z9lIrGM5PVOsGvRv5NUyElkcl1wzm/8oJ7AtaW84vn+fmA8M7o3e3+IdqjzcrhcoXwmbCR4sNcnvvWI7x5Wx0fzbEpOwo3WHpuboSbNLz0rG+mi4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756215196; c=relaxed/simple;
	bh=gNX1V2tRjwFiyu0+waRMw8NM43Yzljrpc9AdBASDQzo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EosbmwE7gn0Pv96JLhSvUyMVLoJ/UL8QUyzlbf0rCxU3QqUf+ac0/YFWaybiW7iwRZtdN02eBm8qKogVLquRnSWZvK86DPHjcfWHRB1NQu+A2FvyMBgzVfIgmaQcERMbqmMkgBVBiN277cXQkJcfm8GWoOsP5BmUVvHrQ2A79zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RUl5zIlT; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RUl5zIlT"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45a1b066b5eso30309825e9.1
        for <git@vger.kernel.org>; Tue, 26 Aug 2025 06:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756215192; x=1756819992; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=e09yyJKHVqZxV3tN95gKHp62NrPL2iU5e1T+ABeXkEE=;
        b=RUl5zIlTi0yrqKk5kJvNe0tbNeCEFB+bAjmvHinC+2OPC+FriRYjxyrYRg9lF+/CcO
         V52Xxa55yFF1QqiO13oUaEdP9KShVckagcooStTQYXsybk9XetVaFr7PUoY468ww5BM4
         iKyayduXVl8yc8rGfeJCorMU3WMkKBULC/g9xe1Drwy+dZtrlHNNuUv5tKKXFbeEuIwb
         uT6M1occyB5eGWaun7rvWHglocRM13/JcKlA3OGN1ffqrgm2HGM3BGHZUC1fLVpUlwlP
         u1WrGwTTUXKVl89cy/AXOQERTHRolFut9QsW4pzoQfb2pxoVu3GTzhfF7iunt0MQtdPD
         iGYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756215192; x=1756819992;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e09yyJKHVqZxV3tN95gKHp62NrPL2iU5e1T+ABeXkEE=;
        b=ECtNok3vvLzw16y7On0HNrZixdZM3NYqZfU2103s2hSqKx4hwoSoaEVfin9AQjzV6Q
         VYjXBWe19Ysl7bZaZQTJkJ65R/US4iYSJItFIaxK5AZzvWkYAD20ufr5FG5AFPBg2O81
         IesQ37k+mN6w6Ea6cJMRWKP9qnLg7l0OFtBR4YwzSP47elDEODGqgd5sxs23glPL46FD
         ZnaHVwqZ/9JrpHWgc52Snuk/htat4hwV9nW7HepWBghr4Bx6mOeAt2BvQ0OoW4x4Ulbu
         Y5e02mqYzzJquEAu4EjMV0pk6Igc2C+8Uwga8sVEbLrDU6EyFWrv7HPANSxhrL+iNWYm
         z4Gg==
X-Gm-Message-State: AOJu0YxVcEJMpw1mkgFCPcgegprcnZtUNGm/eD47BcLNZBPV8zdaW1UD
	XhnGpfqLb3daVYHFJHtwPs4813aHl3JbIcgHUd1dwjFrSCl86W6O3/nf
X-Gm-Gg: ASbGncu4mZLPveBKuh0M71GiZTUIk2Ixa/1hGxi7keJqRLDjUgtoT0wkiGC5Ak27WfF
	s9ubquQpUGgdElXmCRYyJf3kXkSTtlKx2a8ajpiPgveYbYPjoyB0L2tY7idt4uBqJLSxvKV7Jc/
	PX3Kqi2Q0ngXl9Uwf4i0SCda74k8whPFiK068VVSRregFJLCjhX/Aik0cdS7Gba4CTQtkSWvSGO
	UGXaXkvxBKqMirz2Gmii6NQdgpxeU00gqxXTrLptjX/+dLODaVwOT+6HiFMw5xIAJdHImSvFSiG
	KatwYXSXkM2kwrdT2Wtbf7pC8VOS6ux/DcuUbSnyd8dgUmZ3HUfa3/BrASQphTpN0DASVPmVt42
	ciiH1TVhefDOgvXTqVERvVbShesIkzoBQbDH9T9vRS2tLh692joWycqMhlq9di5gA6GH5YxB/Pw
	4N5A==
X-Google-Smtp-Source: AGHT+IH0S41lHm09vFwl0q78vOSERf6gZS7VvHbeCVqVanih720Ygtk1tGt1mEa66RBdS6MKC6s7Jw==
X-Received: by 2002:a05:600c:5493:b0:459:eeaf:d6c7 with SMTP id 5b1f17b1804b1-45b517c2e69mr116846435e9.26.1756215192015;
        Tue, 26 Aug 2025 06:33:12 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c? ([2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b5759274asm151424685e9.23.2025.08.26.06.33.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Aug 2025 06:33:11 -0700 (PDT)
Message-ID: <af0c22b9-5034-4bbd-9cdd-f1f16d933e4d@gmail.com>
Date: Tue, 26 Aug 2025 14:33:10 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 3/3] commit: print advice when core.commentString=auto
To: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,
 Phillip Wood <phillip.wood@dunelm.org.uk>
Cc: git@vger.kernel.org, Ayush Chandekar <ayu.chandekar@gmail.com>,
 Taylor Blau <me@ttaylorr.com>,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
References: <cover.1751983009.git.phillip.wood@dunelm.org.uk>
 <cover.1753975294.git.phillip.wood@dunelm.org.uk>
 <0e7c08b15e5923ae03f5630a8286c7dcebdbcfb9.1753975294.git.phillip.wood@dunelm.org.uk>
 <aIzayan9nFZo4XYv@ugly>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <aIzayan9nFZo4XYv@ugly>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 01/08/2025 16:18, Oswald Buddenhagen wrote:
> On Thu, Jul 31, 2025 at 04:21:55PM +0100, Phillip Wood wrote:
>> An alternative
>> approach would be to advise the user to run "git config --show-origin"
>> and leave them to figure out how to fix it themselves but that seems
>> rather unfriendly. As we're forcing them to update their config we
>> should try and make that as easy as possible.
>>
> your approach certainly helps the user to fix their acute problem 
> quickly, but
> - why should it? it's not like leaving it to the user would cause them a 
>    huge burden, or that a noteworthy number of users are even going to 
> be   affected. i don't think the fact that the update is forced 
> justifies   making it a lot more user friendly than git configuration 
> usually is,   esp. at this cost in complexity.

I think the fact that we're forcing the user to update does matter 
because it means they're having to update their config when they 
otherwise would not have to. I'd much rather it gave me a suggestion on 
how to proceed rather than told me to check my config and figure out 
what to do. There is certainly a complexity cost but I don't think it is 
that high. Some of git's reputation for being hard to use is well earned 
and I don't want to add to that.

> - i don't think i'd appreciate the tool lecturing me about trivial usage 
>    patterns, when the real question in that situation is why the option 
>    was set like that in the first place and whether/how the replacement 
>    is actually equivalent or even superior.

I don't think offering a suggestion is "lecturing about trivial usage 
patterns", I see it as offering assistance to users. The reason the 
advice offers two suggestions is because we cannot second guess whether 
the user wants to use the default or set a fixed string - it is up to 
them to decide.

> - given that it doesn't print the entire decision tree (when   
> encountering read-only files), it doesn't necessarily guide the user   
> towards the best overall solution. that makes it _less_ user-friendly,   
> in a way.

It provides a reasonable way of updating the config that we know will 
work when a user does not have write access to the system config. More 
experienced users are of course free to update their config as they see fit.

Thanks

Phillip

