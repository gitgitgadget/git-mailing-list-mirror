Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A4953814
	for <git@vger.kernel.org>; Mon,  1 Apr 2024 19:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712000035; cv=none; b=kHHGK7hhaU/A1DlAf4HYuTaR5TN7v7AuzeuQ4wwK0aKDN2Dc1VA1aj0DtZ1NH0hW6NNffIMFG3eN3KqnjDbr5NLnDaIZHLl04esKsQ41UqHpEB5qhcQsFNrvu0q1Hjcn2F5Jgza3cxGkOgRZK+RLH71JDDaFKxiHXk6EHTlGMGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712000035; c=relaxed/simple;
	bh=7vLhhDZ4slOTDwinYzUNvrW0isMNQf1TNLFWGLiLs2Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VVfj6esnboKH/ZpRZB8TUHRxmeMF2Fr+eag7YQsbhUIUNDWJQcwKjaMSPbfOWA8Pdxx1oPCxQyA+j/opJWh1E00O8n+4rg5404V0lSE3dsdxAEsgZGMkXimwXW1jZj9HoEcazyHlrQrMHqd+LrjCv7F13GKzokPldAjoEZSRB1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TYwxM0ar; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TYwxM0ar"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4156684ee9cso7260915e9.1
        for <git@vger.kernel.org>; Mon, 01 Apr 2024 12:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712000032; x=1712604832; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XZsYSAgABduTqTbUAb4ftUbGEssYns/d8egdanrZsl8=;
        b=TYwxM0aropPZH7hdnZMkPiKMn/UaosZXbnP14nOdHhqCdecm02XiuGfDknloOlQoJ4
         SV6ZrHzCqzieX5x9sgzn4QFwvZPoIJhrPC6bswOmk7GvX4YYtJLX/FVa+WUmKWlOtF3c
         3JcHKWGCmwuxsXHCKTJA9cpJq4JW43zZQbulm+OldNTINQBv+yyqNNbz1r/vshgEPVPC
         R5eK880MHi8ZW0+g1zon3dyw4ICd7c8czLbbm5FuPz/zbGG7HMY0HJIXn4SQXSe1R3qc
         LPEvPJWAF4YM3DxkbF1fLi7roF04z1yfrpJk5jm1b39h2BG/kREYbMJ28uG6WLihax71
         /rVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712000032; x=1712604832;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XZsYSAgABduTqTbUAb4ftUbGEssYns/d8egdanrZsl8=;
        b=vBVj9+H4iP68qW5aNh1/tQkz/gzREP418TPSzeutmithCCtVRRFqnc3yh+FupQHRZH
         SkR8ciIAqjnau59plgFhSIgn/W3OOZlG8LWgN6tmBpklRW+rqqJJpmXUG+crJRbUGWcG
         +8oGpAm362BYUXrZEsLPK10p2APltQwo7lw7vfB4I1ryvyrUCzfWWWs4O84JRJNiQERq
         U5z8GBWy3LlFtslAsGx4cnd86TRU7z+re9JZ3QGzUbm4xtIGk73sH2iIH3ZR6UtNpg47
         0bEyX6CLayNQ59+zQoP9R6YegoKNM4YnnbBbDPynBeR/iDATj0EGZFQvjiL68RhkQBst
         EGog==
X-Gm-Message-State: AOJu0YwxOu7LJG645NmfeLZg1Y58mDv/a6a6Qup+Vk5DfyltYbF8lJ4f
	098JsairO6H27y2D0+Zfbckrys6FXPvVt8uIe592VZ31Afvn1TOPaRhyxbYK
X-Google-Smtp-Source: AGHT+IHILtOaT8VSMvbXyuXiDfDRq+C5wVAUJ0AsJ2zyPwh2qzQKLUylLXcB4rB3tIG8+0PXkimNRw==
X-Received: by 2002:a05:600c:468c:b0:414:1eb:3010 with SMTP id p12-20020a05600c468c00b0041401eb3010mr7469161wmo.17.1712000032078;
        Mon, 01 Apr 2024 12:33:52 -0700 (PDT)
Received: from gmail.com (4.red-88-14-47.dynamicip.rima-tde.net. [88.14.47.4])
        by smtp.gmail.com with ESMTPSA id m31-20020a05600c3b1f00b004146750314csm18917405wms.3.2024.04.01.12.33.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Apr 2024 12:33:51 -0700 (PDT)
Message-ID: <85769d41-e0b8-4f68-b709-511e97c82c37@gmail.com>
Date: Mon, 1 Apr 2024 21:33:47 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] bugreport: add a mark to each proposed questions
To: Kristoffer Haugsbakk <code@khaugsbakk.name>
Cc: Git List <git@vger.kernel.org>
References: <35de2d76-a03e-4a36-9bb7-6b6ffa4ea123@gmail.com>
 <1117b5b1-fb9e-49b8-b1c3-47b985adce35@gmail.com>
 <bb4cd824-c9ca-4adb-8339-885273aed9bc@app.fastmail.com>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
Content-Language: en-US
In-Reply-To: <bb4cd824-c9ca-4adb-8339-885273aed9bc@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 1/4/24 21:30, Kristoffer Haugsbakk wrote:
> On Sat, Mar 23, 2024, at 18:36, Rubén Justo wrote:
>> Include a mark in the questions we provide, to enhance the readability
>> of the reports we receive.
>>
>> Of course, the user has the flexibility to choose a different format or
>> rewrite the report entirely.  However, including these marks in the
>> template may suggest that we value some structure in the message.
>>
>> Signed-off-by: Rubén Justo <rjusto@gmail.com>
> 
> I like this. The questions and the answers not being differentiated
> makes things harder to read.

Thanks for your response.
