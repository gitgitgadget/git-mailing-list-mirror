Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA834134AB
	for <git@vger.kernel.org>; Fri,  5 Sep 2025 01:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757034215; cv=none; b=BoTdUN7XJFlOzA0hvnrH+vxTUXWkKwy2i8bUfwkdrMpo+hHiNeGEqtcT9Stf7icdBrBdiUxcYN3LgKIz0nlvySAaJ9WyAz9etB3gAHHmGDg2IEmOXNa88KtKKsMSL3EXyv/n6wOe8YfTif1Z6B7yMsLhtYoCtXypXcvaWTqckHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757034215; c=relaxed/simple;
	bh=1xmbE6zYhP0hVC3uyQ2633z5TW+xl9PXPIimsZ1Pex8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=hP5cZ9/52XOVpGTi7h45WyY95TeKWmt9gAeTay9hQw4ev8b8FfCoNEfBEeD0CkK03vLCx46EY1hRADt9zQiEAzzXneFmcHRiw5dxu5vohyqOv08AS6wCMqHdLEasL7pVjfuTAkiAzC77VU7YzB1PpW8Tusci38jqQMpeFbqPO7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CIRkUurG; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CIRkUurG"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3da9ad0c1f4so1089198f8f.3
        for <git@vger.kernel.org>; Thu, 04 Sep 2025 18:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757034212; x=1757639012; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1xmbE6zYhP0hVC3uyQ2633z5TW+xl9PXPIimsZ1Pex8=;
        b=CIRkUurGbXZtzp1mqVe5QEnFoemkJ6w7qQw/9OZIbAKlW1/WQDoOUqhE8wIOiXLBEd
         QQgAXM7wUyt42EOGv7uG5/N6jk++BIDRkv8lMeOHewo0nE8dpOaZFEi9tbUn0Hm/qGsK
         HOqz3hWkhixDyYKipmCJJ8pqI+9bQgl8ElEmR+bLxA/HAoc0NuxSTDJqXAHtOrGKtFE6
         xA5JbnGS1hw1593R3AD3EXlNSJZsgixyGKXfMzKa/V8lvGlwkqqsD9eDHLT0GQ7OWdf1
         H6wwzhqJ41tqsBg+roncCm34OquqUR9GBRwpLliGwgbG77hZHulK39ErUCmuUp45HlUY
         QW0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757034212; x=1757639012;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1xmbE6zYhP0hVC3uyQ2633z5TW+xl9PXPIimsZ1Pex8=;
        b=ap4mXefdSHKqgu4lsTd+pQcjG3aj35Vv9JhXaaLDPUYwz3mU6buKQagU61c7AAXdou
         aNrmRHrNEGfwAf69mA8Vj05aTSE4f/qB8vwdEQC1usQTN3jo7I+NuShKu1fNrJK3iDin
         nwdI/MZA2t7TQMUVykaKHDBJ/VIOHEpe89OB7zpFEp81/LUdpz2ICdApzYGnnRPAdlWp
         WWCu+N/qRRtU5HUj0ENwp5CXiUep4hiKGKojKDKXcMiaerryIfpLf8k0FOWPyhsNrC7g
         uWGmiu9L9k6Hw+0ByfEPjlDTnLsLZwmwxvw8aa8hO8YqM3Pdu/CkvzEcuH7my8mLD8kK
         a/TQ==
X-Forwarded-Encrypted: i=1; AJvYcCWpo67utbDRbw6YARbIAiddshwBdSTKFH23c8JXSnB5a9JeKpsssouJOKueAGeiMUh5sPY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoFVpL9/tQ+lkQnBur5nRNYZGe+Nudik1jsQBnADU76vGEfjnq
	qlNE0soZtJXOqIdNWGZs/2YMsTjhj91Orukhsgqj+gwQPztQ3JU7adcU
X-Gm-Gg: ASbGncu0xjSBIsCk3J5PlJI73zH9kR0jWNJw948zqN8kVeQ3ftPEX/DhEt2F0XYw2IE
	W4avl5buXOLph3WTHKZJCWPEKIhhgpa7FDjnteEWNyr0NINiiGU4JdD1gDIddOXxD5AcJ4RFw9K
	Jn2aOovHVKYSiVV698rjdeO09yrHLR6CH88rfNBcZOnLooYEGeVEnilMDTlTTs9D6XFvSc3qtqO
	qHlRXvQ45d8ZeMtDBrJl0J3cTdBEu8rC3n5I3sZq75+5of1RaghbO2SrjDzfZB2ojjGaGv03WJ8
	iZt5uA6YPTRPRXvag8UAD0NdEvmDT4qa01QGX3YU/VmkFmH59MG2oNPI8tuGMWqGCzdPssi9ZOH
	WG0XJ040eBFai7x0f8qdDn3/waxg7iXiX9AAzOXp78kf+Hbr9rl6tiranO1euWgkXBb/sDVw86v
	FkoA==
X-Google-Smtp-Source: AGHT+IFsJcIbf4iasxKRvUbT1mvXKefwyrtRTeM471tUgJCz4S3QWv8cqKZHpnD+XglFsZDSwgcrZQ==
X-Received: by 2002:a5d:5f95:0:b0:3e3:2c0b:dc3d with SMTP id ffacd0b85a97d-3e32c0be08emr737934f8f.17.1757034212263;
        Thu, 04 Sep 2025 18:03:32 -0700 (PDT)
Received: from [192.168.0.4] (ptr-178-51-192-26.dyn.orange.be. [178.51.192.26])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e1dc0bc365sm3263885f8f.40.2025.09.04.18.03.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Sep 2025 18:03:31 -0700 (PDT)
Message-ID: <699b387f-b09a-4003-9f6c-5a4a4b527ed5@gmail.com>
Date: Fri, 5 Sep 2025 03:03:30 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] alloc: fix dangling pointer in alloc_state cleanup
From: =?UTF-8?B?44OO44Km44OpIHwgRmxhcmU=?= <nouraellm@gmail.com>
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Cc: =?UTF-8?B?44OO44Km44OpIHwgRmxhcmUgdmlhIEdpdEdpdEdhZGdldA==?=
 <gitgitgadget@gmail.com>, git@vger.kernel.org
References: <pull.2040.v4.git.git.1756941427825.gitgitgadget@gmail.com>
 <pull.2040.v5.git.git.1757007856062.gitgitgadget@gmail.com>
 <20250904204932.GD30633@coredump.intra.peff.net> <xmqqjz2d7t2q.fsf@gitster.g>
 <52fb3fea-4842-4532-8572-df41537da5f9@gmail.com>
 <88ae6c7b-0a69-48bd-9e73-672331a22197@gmail.com>
Content-Language: en-US
In-Reply-To: <88ae6c7b-0a69-48bd-9e73-672331a22197@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

 > => s is the double pointer (the address of the caller’s pointer)

For this part as well, it's s_ not s



