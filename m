Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22511B422F
	for <git@vger.kernel.org>; Sat, 18 Jan 2025 20:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737232390; cv=none; b=neCUIE/ws6HnZA1XCj6UqeG+MGdG0wprNPUylFiUvhQrAXnQ99zvv6SfbsrzIz6g6JTxRt/cvOUTkbUXxLR13+xrXueHoCtyxEaljRGlMbFfzlzBMwfZYACv6HNrYqWkePy4+cmJf1JJNYJhwTm30hIIpaK8vrxx6gU77qyyaBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737232390; c=relaxed/simple;
	bh=HipogfrHzWhSr65Hjc0mqjlOlbEq+Bk15vLMRpf+vT0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=gKVF5OzL2BQJSgLTtPLTpG7FwYKpWtmR/KQPe0woHhwXkdYoXf76q78PBEnLj7tDyMcKNWZ1aJVy+vhVBuXkur9a62irUXONJlnRmV+AJ8/MkNeVrt/DyHZY54IZiKV3nK3ePKMvKQjFixmp15ZKJTsvv60cnaRmgBYdaH5vusQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WjOfRnRw; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WjOfRnRw"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-436326dcb1cso21549775e9.0
        for <git@vger.kernel.org>; Sat, 18 Jan 2025 12:33:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737232387; x=1737837187; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ynNY4smXM9rAiKGRrW/owbNTpISvzw39aUCb05g8txs=;
        b=WjOfRnRw6V2nG9jrZJRLrD3qdhWDIY5ni/hmJUcxyWzR2tUa9bnkqpfuGDjr9GOuW9
         v8oRiOKARpde13/oC85IZckdjM7vDPOpAM9ysij/E7380iD2L9rXkFsO8K7ish/iswWG
         sHT1A5gkF3/ftRbjJfpR/mlIkvDFDcQewsLH2/XOL4TfZZ+1JejSwmE34dyNIcvvCMkz
         CWxXHXmL7yZjEEumdJ8YK4/a4SECA96iXibThEVwRGowKe/udVJOJrz7BUFfaB59zGY/
         PH49Nd5Ib2snLAozdkYO44/fSHv4HtUc5id8gB5+VQ2kClO+ePYLsosGl2r7ONQp5HhI
         ALjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737232387; x=1737837187;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ynNY4smXM9rAiKGRrW/owbNTpISvzw39aUCb05g8txs=;
        b=C7I6UQUvjeNMGyuOZek8DDANOE3oZh0m8LS4IF2J49ke5LvPNbbUCt8vms13plqcmn
         QVwb80xHc+H9bNy8JgtaQGsui/CPEUJRerMGszpDRd4KTMDKWTOJZntazVEVD3Bopvpd
         vnoPNaM5ED8OtC3ryWDHgzQzBEZ8DbIh2qJM+fI45iAlpmfzSCwfgITPMdaJM+6JUF5w
         eFuavA1GAErHbwHfjg/lRwxEAZQ3eQJH4IfkLdbW3a5QgQz/wBHimVweRzmHjjf8RSKc
         sgFWix3wflAVlGEDLJN+T0EsQo56PQ2qEzd64gY4A5QlDGXS/zzV3XZJt2zSVtaBfKqA
         uvIA==
X-Forwarded-Encrypted: i=1; AJvYcCVeX12NDmfsIfMpBD676QlAGBZXPzVxmhrZ5UyJkz2eCGpyLwTYvFiQYwXk2nxL1wVhUEc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZua6dW9sPpDY4QnZEi2qcA78Cr1VElsCRWC45bPFvWOCBYPFn
	Ok46TL/6ZDTcE4DZ9AAfOPqg52TRyXOU3GXAMw5R2E4n9TDN+JwK
X-Gm-Gg: ASbGncsQupPpQoTWLpDfatnNkbbUwo3+zE5k+VOKOgOpo+XbEH90b8p1SpgQNPspaO5
	qibhk0q4A7CqirQp4YjnFY+MRzG+F1u1V8LhgXNl8izwdCokLcaQgghhq9kJvY7c1KfpWyxqnIm
	I5g/U+KEcYtAE9EfVnD6buiTiiPeMWlNqrZzsRwVPoMp9Tls7BVA9FWezYiqQvpU1fIYj3Oi9bn
	ZKwc1+OCEZox7Dj7J2jwQcWZZ9nWv0o2kTL5Y80QUF2W1/bFI05fX/aR64yJpEAMf5xVrPnLVLN
	yJafBLJYeCqY7pSPfA==
X-Google-Smtp-Source: AGHT+IGv5J/BP9AuRMpU2TY5f1eAXDhNGJsVPXtHBFh6Q0BNd/9xCeMPVyW2REwcIBr+DKZZwzXmPw==
X-Received: by 2002:a5d:614b:0:b0:385:f13c:570f with SMTP id ffacd0b85a97d-38bf57a1e51mr6169997f8f.33.1737232386898;
        Sat, 18 Jan 2025 12:33:06 -0800 (PST)
Received: from [192.168.1.186] ([2.26.170.204])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38bf322a414sm5967723f8f.47.2025.01.18.12.33.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Jan 2025 12:33:06 -0800 (PST)
Message-ID: <77741bb3-be37-4e63-9bf8-0cbeac50ae24@gmail.com>
Date: Sat, 18 Jan 2025 20:33:04 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: transfer.credentialsInUrl should warn about personal access
 tokens in user field #leftoverbits
Content-Language: en-GB
To: "brian m. carlson" <sandals@crustytoothpaste.net>,
 Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, stolee@gmail.com
References: <20250110210500.675629-1-mirth.hickford@gmail.com>
 <xmqqh6665p8j.fsf@gitster.g> <Z4GZ0oiZCC2Wl3bN@tapette.crustytoothpaste.net>
From: M Hickford <mirth.hickford@gmail.com>
In-Reply-To: <Z4GZ0oiZCC2Wl3bN@tapette.crustytoothpaste.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-01-10 22:06, brian m. carlson wrote:
> No, this is Basic auth.  It's just that GitHub will look at either the
> username or password field for the token.

Thanks Brian and Junio for the discussion. I understand your aversion to 
introducing GitHub-specific PAT detection logic.

The better solution would be for GitHub to stop accepting PAT in the 
username field. Hopefully that will happen one day. It's undocumented,
so its usage ought to diminish.

To speed that along, I've edited the offending StackOverflow answer 
https://stackoverflow.com/a/70320541/284795


