Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411B476C9C
	for <git@vger.kernel.org>; Tue, 20 Feb 2024 19:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708456501; cv=none; b=lutao0up/hgEoDHDqNBfIMh7mdxQr/N6Wvwr+CyKaRIq52lYlgjW2q2vrnoxhQiIJlLZIKdL5373TOL2Tg7yN17gVZDIAWQkrq/pX/B53PtVNQUEf6znEjMHUeE7I3j8VGoANVCrx4vAVC4+JHH0CaJjrTTQV66xdlXAwUu9JDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708456501; c=relaxed/simple;
	bh=IDT+wQtIoyPfAoeveWjr4EVgucrVww4GqPLxbRsDJsM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=eUyanLrRCPkYxoT5Z+Aaa6vdo+bLYPmCqK2o7BuBPnEk7/iI6PnJqaNwHqUjyxo95y11Dtl6+yZ27ai0isOrXnwkLEo2xgLCtYsNJPCxLl6Jfdg9Bz4Q+42UOUEyaXcU0m4saiQRptf6UZx0ZVp1zK27r4iXOs/P5Ix/lsKSB38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JE6dNLN3; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JE6dNLN3"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4125e435b38so28649625e9.0
        for <git@vger.kernel.org>; Tue, 20 Feb 2024 11:14:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708456498; x=1709061298; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HjdRnzRDSme8T9qViC2SIGhBngPsAyvQO75TnSUq2ww=;
        b=JE6dNLN3IfetqcQawH5QSTgAtHzOhTAEVB8MVGu5p1RYcwrPopg43JX3A+nCtp2+4T
         Qgez7xLhQ8b4Y6CAUisbnXpITGJfqv60DHW5WU8BGGqWnFEy1gQ4Xf6l2vWVV7MejZ2h
         G7wj5wuCyg1D7hWMu8TNhb9EjLc69CK8d//9w0CZZ2M3J4n5Yc1miMJNDZjgTKMqHwFx
         GJAunRSVdpf0d+FNcfQivn7JKaTgTWAxqEqK40r/UIM1F1xAqn3NIY1y51jsVUw0t+g9
         zG9KGIAu6E81xxn9Q9H76ncByaCPVqa7SIHswa7pdeQT0x6/AWIOjMksGJgl/KkLzNVS
         Q2gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708456498; x=1709061298;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HjdRnzRDSme8T9qViC2SIGhBngPsAyvQO75TnSUq2ww=;
        b=d6tSpUfY0QWUaFONLumPonio/ej6MIDU/6LndzPkic99m6TDGxCBOooVEn5CvTZ6Qu
         6zhyIbPTYDvxCgpGiyep7z9rHDIUpXt1uQwpWAEZKuEDwZzVE8wYOkcsu6oT/jqCxaAI
         090cKXCZ5lZmOh0O8cIL5mp5GcNyKuWIv6SvLdpuPyig3KCMyqHqLo1rUoxa2vKWziry
         effse0SGYNBXrfcvpZGKvkzt7qXAxhTfZ1KMwHBiCv7p23cnOA0qOliR9e9ZBMhg72rV
         AFidfsbIJJYpX0+B1NQSPI+QNEYIRZ6oUr9UWAjOiKRpGtasNKdUrhIF8Char8np0w/J
         KGBg==
X-Forwarded-Encrypted: i=1; AJvYcCUhwQl/D1xC7M9kmZF1jPsgVVi8lGK79bNjXQGZNVhFebItYrzza91PVL3pzEHdKDyGpzG9paeTuqnwq0ctDx+VrLmH
X-Gm-Message-State: AOJu0Yw6AHvaEDhMo/UFBF8le43uEx7+BcdZuKmG7JTrly37p8D9PEMz
	kz5QjVKSg6fftzGefH83KDzNGTGES12j2G089bRnCBz4WEF2iMsG
X-Google-Smtp-Source: AGHT+IFXmQ+L26ssbyFqAViAkJ37x6O/lOG3vowogVqaPPREKuEe0dChKkWvYvJO7Lt+FpmMSQPq7Q==
X-Received: by 2002:a05:600c:a39d:b0:410:ed31:9e96 with SMTP id hn29-20020a05600ca39d00b00410ed319e96mr11826842wmb.11.1708456498343;
        Tue, 20 Feb 2024 11:14:58 -0800 (PST)
Received: from gmail.com (198.red-88-14-62.dynamicip.rima-tde.net. [88.14.62.198])
        by smtp.gmail.com with ESMTPSA id bn7-20020a056000060700b0033d3ff1cb67sm9035356wrb.66.2024.02.20.11.14.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Feb 2024 11:14:58 -0800 (PST)
Message-ID: <ad20099a-918d-4c37-8d5c-20c3f491728a@gmail.com>
Date: Tue, 20 Feb 2024 20:14:56 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
Subject: Re: [PATCH] branch: rework the descriptions of rename and copy
 operations
To: Dragan Simic <dsimic@manjaro.org>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <3cbc78bb5729f304b30bf37a18d1762af553aa00.1708022441.git.dsimic@manjaro.org>
 <e8fdd057-2670-4c93-b362-202a339d5f49@gmail.com> <xmqq8r3lnzp0.fsf@gitster.g>
 <2a4de8c4-4955-4891-859c-58730a41e5af@gmail.com>
 <ea15a49aed7b5a74cd9b1bf8a5351df9@manjaro.org>
 <c00f6efe-d1f4-4f2c-99cc-ac7a6d93c9ff@gmail.com>
 <be91f3ad9305366c1385c2da4881537e@manjaro.org>
Content-Language: en-US
In-Reply-To: <be91f3ad9305366c1385c2da4881537e@manjaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18-feb-2024 21:38:54, Dragan Simic wrote:

> Regarding the branch copy and rename operations and their argument
> names, perhaps the following would be a good choice:
> 
>     --copy [<branch>] <destination>
>     --move [<branch>] <destination>
> 
> It would clearly reflect the nature of the performed operations, while
> still using "<branch>" consistently, this time to refer to the source
> branch.  Using "<destination>" to select the destination name should
> be pretty much self-descriptive, if you agree.

Sorry, but I don't.  Actually, I don't see the logic with <destination>.

I appreciate your efforts to provide consistency, but the current ones
seem better options to me: either <oldbranch> and <newbranch>, or the
shortened ones: <old> and <new>.

Thanks.
