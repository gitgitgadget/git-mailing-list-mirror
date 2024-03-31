Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663552F3B
	for <git@vger.kernel.org>; Sun, 31 Mar 2024 07:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711868672; cv=none; b=tBcikNZVi2oMhLMaHFFaR1KexrrEZZoY5HbX+XCoP2VIORM1YKSaIH+RfVRLjxUIat8wTDlIz6a8WbsF22Kt6ks2IOn++UDWUfHOXVv2KDXD6BqHDpxFIrrme4ObKnze9j5/woG8xf2BUBhTE4rv3mSojp9mqVQZXfWHx2A9LYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711868672; c=relaxed/simple;
	bh=kRqaq66M0LBN1RpAJwXon7SbYtQndqGo98WP8ucnb6g=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:Cc:
	 In-Reply-To:Content-Type; b=bb4f3f51rXEKDQbRKxB7dePTf4JVEOa4jYRaYhPuJsmZacGc4vWY7LlRlp1rm7yxrEy9it3ECqM5F74+Ap4FqTL/yvD2rhufIDJTO9OabVMLjohwBBphchJ8iDcojoJqJNr/+t52bNvVGBJNVOocnUMKKxDmGEqqj5TYvsxsxhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NV4yiphZ; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NV4yiphZ"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4148c6132b4so23350085e9.1
        for <git@vger.kernel.org>; Sun, 31 Mar 2024 00:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711868669; x=1712473469; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:cc:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Zuw+eJ9sqDPpgW7H2hsuL9ADtjxnPRf5UsY2LYCFqNM=;
        b=NV4yiphZujSnXEOOlqaCWGoBdy4EaejF2h/lm7Z6DvAfi+zTTB+3Ysa/PlDgvHNjLD
         lvcIbVJZu4CjYkdYp+MYXcknOmb85tWIFED8keyb7T7HIGTT3W+7Urwpxnu8OPIx8C6s
         u5+gt6H2ZCef/rK+27u4G9VaZpzC8tLUOY7GdoYvnCQfJEPvaULdMdfgJN+Hhk+Nk0Em
         /J2hN0nZlau7nbZKp1Vsd9s8dEiZVC8xYZ955bZwCv/hlm0yL1gyASHiDRBqME7ETIr+
         byvsFnLqLAl0fRXWHqoP2rBINSfrxLegFXClE9l3QOizncP8fm+FsctSHtksJPHUS276
         cKYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711868669; x=1712473469;
        h=content-transfer-encoding:in-reply-to:cc:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zuw+eJ9sqDPpgW7H2hsuL9ADtjxnPRf5UsY2LYCFqNM=;
        b=uJV6GHbZK72KdGsHgb2j/FhZ9vmWiYcS/hSvz279Y72Zl73Dgs5HP0G3WRGxfvezP+
         ChAmKaGtC4vQ55Jw2dxMk2TiJLEGezmZI3lQY5DMZds04Jtr3pbUteVP0H++BiCD5yiL
         asAN9E4ImjlyNMxSh52IMbrDPN6Q9SdC/2JHpOUUbXhP8rJQx+C6LsH93vp2QeG1R9ge
         cTJIOmIp8RZtUgeLDoZhITd9Sk44IZYvx5XCDk3n4G/No0DzW4jokhNe0BmhKSFcRazr
         nUe1oQ87w6S8NCbBS8rfZgxHemUD5tXQFxmtOEbe4t9HFWVfNWhLRKKgltU1OkX1ubMo
         JL+g==
X-Gm-Message-State: AOJu0YydTn8CuYDO9K8/R1SQmBRlupFjs05qarO2HTX3f7/t0lSbo3cO
	+goi0ZX4R2Dr/9RNBxz6ICzqwEtukAjVcVvI+cTQMy4BebAH7hIv3ySqiire
X-Google-Smtp-Source: AGHT+IG0mQH/DNA7eq0qNJghtga95dEy59mvxmtMIHfFb858BP8aznsvRRiGLZnaq4YTWa0gOJOAOg==
X-Received: by 2002:adf:ec86:0:b0:341:d306:88eb with SMTP id z6-20020adfec86000000b00341d30688ebmr8205930wrn.31.1711868668533;
        Sun, 31 Mar 2024 00:04:28 -0700 (PDT)
Received: from gmail.com (26.red-88-14-197.dynamicip.rima-tde.net. [88.14.197.26])
        by smtp.gmail.com with ESMTPSA id z2-20020a05600c0a0200b00415515263b4sm6634081wmp.7.2024.03.31.00.04.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Mar 2024 00:04:28 -0700 (PDT)
Message-ID: <4f179986-6aca-405a-a122-d0dc058c60d8@gmail.com>
Date: Sun, 31 Mar 2024 09:04:06 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] improve bugreports
Content-Language: en-US
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
To: Git List <git@vger.kernel.org>
References: <35de2d76-a03e-4a36-9bb7-6b6ffa4ea123@gmail.com>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Emily Shaffer <nasamuffin@google.com>
In-Reply-To: <35de2d76-a03e-4a36-9bb7-6b6ffa4ea123@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sat, Mar 23, 2024 at 06:32:35PM +0100, Rubén Justo wrote:
> Let's try to improve the readability of the bug reports we receive.
> 
> The first message should not receive many comments.  The second one
> might.  I'm open to suggestions.
> 
> Thanks.
> 
> Rubén Justo (2):
>   bugreport: add a new line between questions
>   bugreport: add a mark to each proposed questions
> 
>  builtin/bugreport.c  | 16 ++++++++--------
>  t/t0091-bugreport.sh | 12 ++++++++----
>  2 files changed, 16 insertions(+), 12 deletions(-)
> 
> -- 
> 2.44.0.494.g7a0daf3e0d

This series received no response.  One option may be because it went
unnoticed, another because it may not add value.  I'm going to give it
another try and I'll quietly :-) take silence as confirmation of the
second option. 

I'll try to increase the chances of getting a "looks good" by CC'ing
some folks involved in the bugreport tool.

Thanks.
