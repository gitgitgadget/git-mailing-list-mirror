Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312B31DB124
	for <git@vger.kernel.org>; Wed, 12 Mar 2025 10:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741776000; cv=none; b=sIsvho9O0uIcJHvl2flVsIPof03ICoepvv85Bqk+aCgxRD51fbntmT5JrraNLnB4Sdd3pzpTss5bXA5gfwoOMCdqwRFZ80+TIyJR9ie2A8uPlTJkFYecB2NdN2lp2rHQLcyPdX/WwrBncc4Pm2DX3WKBLZMzlo0vjnB/laGSTkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741776000; c=relaxed/simple;
	bh=s+la07KuybP10xyz2M7sEw9hQiVIoeAeJyJ9QiiBUYM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=bpK68hwtcdih8fq3O6ZE/46PEGuzW5azYRJIcRn2K+2LHtkBLZ0TZHa9B9kMSd82vh7rZM2VkTc06cHKQ2vXoN4irM5d2PfmLrhvp4wjdsNMpHL93zOs5JlGb+ek68KGKN9l8dZ6/rC25ifgGTUuBgOzPnnE9yzHHJpoRcO7OE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ToBDxUr7; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ToBDxUr7"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4394345e4d5so38707215e9.0
        for <git@vger.kernel.org>; Wed, 12 Mar 2025 03:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741775997; x=1742380797; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1Lc7GrgZUmbeDwzq3g7XolKn0m+MUiRERiAZqXlZqh8=;
        b=ToBDxUr7dIvxaiwGfBpI8+qyIRbrdTcKuvXqTXYFohnaV8Rojg8mi4KntquT6z3FNU
         pUoQvqhGBLcz7cn+Fbct304ewj+XgIiK4hixdpaZvlXBXrUUF/W8Lu2uJxb7lgyjhUle
         ju99XlYGtmSJI5Wf7XmrpZcN0+nhp6T8j2wsKf5f4wib2W9l3BfTSZXJwChGLKj1RFpE
         VIlqxmNeR0PIXawHpKopZ2n+/3kvQKUrH3+vwH8ANiddvUZvZeFgN3WEhBp3vqLLAIL+
         mr5i5dDpS2YXzV0NHi9nSiKT3p9gqp9cwQJ2wi2nl2W9uv+cDrIB3s9idYmLhD+N/qyr
         qXPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741775997; x=1742380797;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1Lc7GrgZUmbeDwzq3g7XolKn0m+MUiRERiAZqXlZqh8=;
        b=D4xh8MXGaiCnnsHSmJbkN5rd/cnZx4j/jPq9/YyrtckV7IoSZrPjLr8OmWxXwUfGcQ
         pvXlRVOkSqSp1Vy0t3qV0A90OR+DxagM4+rIXnamtf6rv8b5kNRMbNV3Fuh/KKYfeumW
         aVg2bM281h+Rha0Lo/avcu1hjUAkrZTKxbsGBCFgdLA7i1lEXzCCy6mlUMuC45LJ8d6z
         EDcwg1YY1e42rG/TL7ZBjcEXNGGTWn06CLpUHp8ECZmm8gS7ymtMFqjSINSw4NqX5vHI
         Nys0suyn5IF9HRmgnxV2lvoLjxh3VHRi3L/u4y3dXydurZ5Tv33TUpCqW5pPjynGPndF
         xNfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVyz/b67w2p8z7uygr/AZNNTnryq8+2/LI7VHT/t29WELU70k0prBPMMhdazttvh7CyaoQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg59axCzt7nZtw3KvJPP4jyd+bT9wdopZSS5hNqcmOaPuJCTKp
	JDLsWCHydY8OxNNx33RZ3MWor3nt2/zQSzUh2fBgwGwauF8mKhgnXD4AVwg87Nk=
X-Gm-Gg: ASbGncsEfQ8PsggnOklDge6SEFp7gHuXjAUIuLL7wQxywRJhOcUX74uAlY2nJLcTutG
	bX3ix4Pa56hNrx5JRh4mHw7+pAfRhGlaVwvvhCvsumiHXr8ADvlSD+t5BrHSul5Q7hm+S7d8xEC
	IMh0R4nyUQ1tlu82RKdrAXncgdjqCuxov1vSFLkTFbDWDUu6A2XZEI47tOOtZz9FWtEW0sX/hv3
	Yx+9nS3QlL+unZEAolgyHwPydq+fxIpVAgbkXDSAsnoN2txrV26BSZI4jcp0xeniOpT1Xzl7Omw
	QE/0Bqxif51nPEkfBZhjeK3LhQwe2TtCGicg3beJiICeiveWPrVFtyHwFO9LJ5+AUzBBpbeRojT
	8/ALnQWs6MjrfwxXw8VVN
X-Google-Smtp-Source: AGHT+IEulhUYLGUkAOATsim/Rkjkb5F7EuJeytpRjiOSIBcWlluhVeVrL4h87oUxG3/zfzSjLFBZtA==
X-Received: by 2002:a05:600c:4c29:b0:43c:eea9:f438 with SMTP id 5b1f17b1804b1-43ceea9f6a4mr124431355e9.15.1741775997167;
        Wed, 12 Mar 2025 03:39:57 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d0a7310ecsm16972445e9.1.2025.03.12.03.39.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Mar 2025 03:39:56 -0700 (PDT)
Message-ID: <75a8b321-4cf0-4d75-93a7-b616ae818d81@gmail.com>
Date: Wed, 12 Mar 2025 10:39:49 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] docs: fix check-docs with WITH_BREAKING_CHANGES
To: Patrick Steinhardt <ps@pks.im>, phillip.wood@dunelm.org.uk
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <pull.1871.git.1741018310447.gitgitgadget@gmail.com>
 <pull.1871.v2.git.1741171357627.gitgitgadget@gmail.com>
 <xmqqzfhzlbie.fsf_-_@gitster.g>
 <082af6a3-a7ba-440d-af84-6c59827a2929@gmail.com>
 <56cf842a-7c1f-4354-b191-35bcc1e139bd@gmail.com>
 <b5fb3292-216a-4456-b456-e9ed38affc22@gmail.com> <Z86Jze2qZ5s5OyOB@pks.im>
 <Z9BLZWUarN0kC4CQ@pks.im>
Content-Language: en-US
In-Reply-To: <Z9BLZWUarN0kC4CQ@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Patrick

On 11/03/2025 14:40, Patrick Steinhardt wrote:
> On Mon, Mar 10, 2025 at 07:42:25AM +0100, Patrick Steinhardt wrote:
> 
> To set expectations: do you have the time/intent to work on this and
> polish it up into a patch? Otherwise I'm happy to pick it up.

If you're happy to pick this up that would be great. I'm unlikely to 
have time for git related things for the next week or so and you're also 
much more familiar with meson than me.

Thanks

Phillip

