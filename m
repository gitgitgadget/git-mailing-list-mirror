Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658E7292904
	for <git@vger.kernel.org>; Fri, 23 May 2025 13:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748006275; cv=none; b=RVioE6pZZvE0sHrbvXAphjgrM8ravTfqYKCRmjY/hAmvlDqQzPikVSnzRnRT33a69hiTVI1lZOBoPaxu4KC6sNN8KV/vGAjeBHF2Dx9w1tDz0skU2Swltg866UtzQI77/fcGNqQNc/h2Xx5qcW0AD4KbGmG4ya6TOr2ddxiKqMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748006275; c=relaxed/simple;
	bh=SScur633Dh91tPQ11YTRH+/yleDJHRHehokWP11S4rM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=axU6y08SXTg2tiv4Fp8KIWLCO9yxUpMI/swCtYanomB5tyPJCkXSlt0vLEzH+SlXYu7xNVkXvrbDFfbm3VW4DqmNBcE9G+jIfCnLx6Xqg4fmo1MpRcW+w3hR8mcz2YFFG/u5yg8SDQix2Mb2yHBQeKHYPhxslvnYKCx14puOqiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=du+RID8c; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="du+RID8c"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3a37d24e607so3235542f8f.1
        for <git@vger.kernel.org>; Fri, 23 May 2025 06:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748006271; x=1748611071; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=46QpnHnDSExqVRAbzUbJ4+HISK+Z6y/GKDKAiR/U02w=;
        b=du+RID8c2zvY9aDzoDj2Bu6ac1t9ZfG/qoqw7PKPJyb2m6baMR0JD4iN4l/bLqXap1
         LS+jd+8iWhYcCKhUDcUtWKxkN+gfMc65cJBYA6r1g3CUnpUjbm0BDcmpj8Lh2PfLS8tP
         C9dG8hYtieKxRkZUo+pPWbR7vQSgbict1B7qubix8U/bs/j+MzhmIEg6eNHr5alBfAsC
         EhtyEGojwgHWfejPI/EA21CdJvOpdnK7QJ2ST4OseVyvP3z4mQv2mY2P43cTYxrEzvso
         nb+BnikVDFWAkwnUgVLGAuh9TBXFBtVGtQ56PP+TMcL34s8FyRpIfjm+FQRCpe0M5+8S
         02qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748006271; x=1748611071;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=46QpnHnDSExqVRAbzUbJ4+HISK+Z6y/GKDKAiR/U02w=;
        b=u8bxVOn0sOHy7sWSkNAqBUHMxRvDiy3Zz7mWR3RFu56qXhly6vNB0oHdUU8TOjMjxd
         GvE3vubgKU1CFmVWmKSAt9PBhP2714+1BA0fUyVjwt69x8uBSccJ12S4jDWM6xrl64yS
         4rLosPkSOQU1xXfdn26gogBhGm83Rk6wyuGh8Zwf8dcNM8yV5MGxiKmlWIgDEuiMl39H
         DV7Wa9i/IDLpmxYxSOvzKcCoikN/snR+qg1NqXSqL8u4sClwYaub6533eO+8MeD77TUz
         GmcdUJEtTpX4ghjS4W0edR1K1KTqO8AX+Ll5TB/ZNpX9C5dpqatHyeRXzG3zyOydNY6h
         WQ1Q==
X-Gm-Message-State: AOJu0Ywtu74Sfec6fLpiRuB+IZ7DVTahRVdRomGDFGzUQAUkYOkx1kOu
	PhqU8G0zLpdmIF/jg0M4hi+XO1JM3oMkVud/W7/EqArN9YmFaFVHbQSu
X-Gm-Gg: ASbGncu9pu6CymZgj8EeX1aTysHxeCSgOgEJncEH6ZMjXjtumilb6IqiZFRzdsLPzqh
	n5kYRVMszXH/0aVCrTB4QrICnBQ0AE3OvLkOgPSFr4euVAqvjJR9ZqHgK36LO+UGa0nsvztW56Q
	S4CcYle8bUfqBhSWNFhnjB5s4Qlvg3GVnR2N5CMpJXJKG8Da0Du8whVLU7YLyHSD7HunWiDIYtR
	5SmxU0esgg2mmyq5JdD9udOATih+alBJDoPrnLnmL/Xj0st83yVsvaD9veJeVf4P9FHM2s/tCn7
	nQUdndOHreyaYZJrfxMbrP3Uu5GK2rNxGgs5JKQZdJw15nAUorcqZY+hFBdWxpM9bE+ccqbLTUJ
	rtX+wmAN5loUmpeQlq3ye166F4Mg=
X-Google-Smtp-Source: AGHT+IF4AGMzAIffgmf2JTZl32ZpNUcBHWKcdx9imGNOckE1R1cm7eXn9++5sMVCyNF17WOnikLeIA==
X-Received: by 2002:a05:6000:4383:b0:3a3:71cb:f0bd with SMTP id ffacd0b85a97d-3a371cbf48amr18557915f8f.23.1748006271371;
        Fri, 23 May 2025 06:17:51 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca4d263sm26119804f8f.3.2025.05.23.06.17.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 May 2025 06:17:50 -0700 (PDT)
Message-ID: <85847c7f-334a-4d0a-ac54-6a3c9b26c282@gmail.com>
Date: Fri, 23 May 2025 14:17:42 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v6 5/5] builtin/stash: provide a way to import stashes
 from a ref
To: Junio C Hamano <gitster@pobox.com>,
 "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: git@vger.kernel.org, "D. Ben Knoble" <ben.knoble@gmail.com>
References: <20250508234458.3665894-1-sandals@crustytoothpaste.net>
 <20250522185524.18398-1-sandals@crustytoothpaste.net>
 <20250522185524.18398-7-sandals@crustytoothpaste.net>
 <xmqq8qmo4aaf.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqq8qmo4aaf.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22/05/2025 22:15, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
> 
>> I'll need Phillip's sign-off for this patch.
> 
> Let's Cc'em, then.

Thanks, I'm glad the fixups were useful, sorry I forgot to add my sign 
off to the last one - here it is

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>

I'll take a proper look at this series next week

Thanks

Phillip

> Ahh, it occurs to me that your pwodd may be a typo of that address?

