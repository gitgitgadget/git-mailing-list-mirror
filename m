Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63ADD10E9
	for <git@vger.kernel.org>; Mon, 23 Sep 2024 01:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727055588; cv=none; b=eySehyWxybDmO/9CspH6PD9ltnj6/TMxiKKltNMKhYb2/6o170ZeRWt3u8jmhZGHUOFbOg8+xXreCoM6nNtsZ5cdZ/iu2wL+g4TDUDpdPY21NWJKJZiGlIunj87wY3PDKVFevdD4akS5O9I595mVfv9pgPT5cb2abbaMNZU6HuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727055588; c=relaxed/simple;
	bh=+ozmjlPPOT/CkANC6fKeGNl3bCR13gMiFczBiqq3bMk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UOv+q//sayURbkCgVtL+sKBrlQyKVtZelcV5bYELeDvsZqx40as1JN7GvapeduOdHlVLNeat9jkdGC7MXqwyi76hMdo0XDwgh61ls43cHhydIWa6ZVWom1BaKYt8tb2PSi9pqmB4PoB/YROtU8vvgwShoUZPZ7N6iwLkmxl68tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mTT7JgyK; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mTT7JgyK"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2d87176316eso3424224a91.0
        for <git@vger.kernel.org>; Sun, 22 Sep 2024 18:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727055587; x=1727660387; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RNgyGq7NCGa69kZ4GiLd2+OJQxnSbtaBIebEcaJ8FJE=;
        b=mTT7JgyKjO83+fZVBHQmd/kslNzcUFqpnonlQ5dasuLUDmTT/hIwDO5tZ+rahZYXCU
         YqqJvVeTmiw7+RlsIAQZxLod/bXq+8eSE66Kb9SnHnrEQXjz5iR97OwzPJuPYi/dQ+vI
         KITHuO2i0tQrEPPatlzJvm+rhzbMZVfn7DUiody+WphA8auJYBJYo2w9TfjnT15Era8I
         O40gHTTQZgDNL7HIz+KqVaWpBhB4uRScGjFUMhkurMnWrPOEjk8av2733Qg432V1kjzz
         TcVOoXevtY9WFOUes157XMwcyUACkzFaIXDBYSTpByfYA+ddhCAmSz1FYQKTJeVe3Jdd
         iNfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727055587; x=1727660387;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RNgyGq7NCGa69kZ4GiLd2+OJQxnSbtaBIebEcaJ8FJE=;
        b=sEVuxk6+xJXmYlFT6HiRbBPIXelv0nwyo9dbEAFAaimwtBbtDfeHNVRld4iHNDy/tM
         wSAnN8p4ZF0+nx2kv7SmFRz5F2WR8xs+Q92pEw3oHEBbHV6A5kUOglujc7Wci/dYOmIQ
         zs6Spn6g35MWMMzR/8TPiHJRMp9SKkNXVOxlxhqxiCI+Ofb9pto6prBKCyKmcDxieObP
         18pv4MURakwgSedA2qOgYNP2jsJmfAQ7ZU2hBhB1wrzAEY0c+7pJ5I8lvJG5UXqJpMHk
         JGXhO9XPoUcj5ilpNW+/rZyZJgi1jdcCyscFOonSQ4YQ8e8E4sXZhXH/KiTD7dkw1UlQ
         FxWw==
X-Gm-Message-State: AOJu0Yx8imJtHUu0ovCsMfaojXEIXN/hVMkwnBpjpYD/m0PrqQswXkiI
	S4+9Uv6VJ0ZP2rqGi9DVrHNvQlqnEGb5P1QUzDqVfvTa5ApeiDT3
X-Google-Smtp-Source: AGHT+IFKC3X0RAlk5VgJJeh+QeWhN2J48v2QMoPMw6qsuljR0bTm4hlNYH1sBHiGMrIRCojBAbKLMw==
X-Received: by 2002:a17:90a:f3c6:b0:2d8:89ff:db1a with SMTP id 98e67ed59e1d1-2dd7ed060cdmr14825470a91.8.1727055586511;
        Sun, 22 Sep 2024 18:39:46 -0700 (PDT)
Received: from ?IPV6:2600:1700:60ba:9810:1803:188e:65b0:6321? ([2600:1700:60ba:9810:1803:188e:65b0:6321])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dd7f871ad7sm6061300a91.26.2024.09.22.18.39.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Sep 2024 18:39:46 -0700 (PDT)
Message-ID: <9cd3e993-3273-48af-9990-7a18c8bb668b@gmail.com>
Date: Sun, 22 Sep 2024 21:39:44 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] pack-objects: add GIT_TEST_FULL_NAME_HASH
To: Junio C Hamano <gitster@pobox.com>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, johannes.schindelin@gmx.de, peff@peff.net,
 ps@pks.im, me@ttaylorr.com, johncai86@gmail.com, newren@gmail.com
References: <pull.1785.git.1725890210.gitgitgadget@gmail.com>
 <pull.1785.v2.git.1726692381.gitgitgadget@gmail.com>
 <48b3876a10247d2ba65a6e5f1ff8ed3a662813f8.1726692381.git.gitgitgadget@gmail.com>
 <xmqq34lv5lnn.fsf@gitster.g>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqq34lv5lnn.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/19/24 6:22 PM, Junio C Hamano wrote:
 > "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

 >> Second, there are two tests in t5616-partial-clone.sh that I believe are
 >> actually broken scenarios. While the client is set up to clone the
 >> 'promisor-server' repo via a treeless partial clone filter (tree:0),
 >> that filter does not translate to the 'server' repo. Thus, fetching from
 >> these repos causes the server to think that the client has all reachable
 >> trees and blobs from the commits advertised as 'haves'. This leads the
 >> server to providing a thin pack assuming those objects as delta bases.
 >
 > In short, the tests are based on broken assumption and checking
 > bogus outcome?  Somebody familiar with the partial clone area should
 > probably take a look into it and fix the tests if that is the case.

That is my understanding, yes. It is a common issue that I've had when
using partial clones with multiple remotes and forgetting to modify the
filter for each, so is also a usability wart that could use mending
(say, by adding the existing filter when adding a new remote).

Thanks,
-Stolee

