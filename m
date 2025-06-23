Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795231E487
	for <git@vger.kernel.org>; Mon, 23 Jun 2025 13:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750686133; cv=none; b=qjLtvzooS4ys0YykK/4PSo+VB93xlLzfvuow8icbN4ChahuCa8dbQeh7VFZ5u8eVbrnJwzSobVBR44mNd1D8B2ww12ChjeXpsmTNBkWoM87lCHGdKaVrClHrcprzbNuuezJxzNgckvCvwjrsnptsK0BFtV8PZ3NtPvXZGdVKry4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750686133; c=relaxed/simple;
	bh=hmBrRVh7Kp+jiQr33DtYSkDzKZTFl9Y2/8kVH4voPaw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hO7P/IilI7bsOcekaHENzBr+JoSsHJLELpErI8I2FHxwwVEYKcKQoH/y0c86r3eanqiK6kq0MGN1I5zAD3c0RYEdY6OreFSoJeDqKDcUJvI5TV24hUGxYeby4QGLLQWSTvuGODQ512ybT7sJhLs66C5McIX8VjOVo0AlEOg0WiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZSFW1oNC; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZSFW1oNC"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-453426170b6so30985055e9.1
        for <git@vger.kernel.org>; Mon, 23 Jun 2025 06:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750686130; x=1751290930; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wQdRAnRXqS0IpHl4C+APfMFN/Y+ehN/xbY3qBp//hRc=;
        b=ZSFW1oNCl4k8hVtWo/QSvSlWaPhIiACNB4mBeL+3GbBCiWjQoI30dUXsRANqU6DDy7
         cP1JKgQ7ifM3pZmC6TKCLrbZ7m6w4BBxlCM3eQGsPbyZXLnUNZZW0UWXvQND8emuxBqj
         Wma0YhIBHyhHbxuqPflBXnX19Fc2AONd4P9o0y2SB68pNf5c6SRMYecFasTEQoasLkNe
         lCWgUMkMFd5LBMrlX+EFShG+jvuaoSv7yxGapNSrtuu2cQFVoMAfImIN6xl4T9RqMsRZ
         hYTxCQ4lyf0C5VrPV0E2Kt/b8Y64KeTnWpjOLyYM+1uUPqF4SQQjkVPQUt5opp0aoSYJ
         svvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750686130; x=1751290930;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wQdRAnRXqS0IpHl4C+APfMFN/Y+ehN/xbY3qBp//hRc=;
        b=NU+M59vvqqq1SfphSJ1sEiFsuqb9J5G77K7khtMAdAYx44yuze/DYxcd58to6uCnNK
         RYqNmZPpgmPLymNLecEIvGhNDn8/bri0afH3F5Ot7cbGSz8texWlNrQ9m2Qx5tpewdrG
         Q1HGuLcXIuPUzOHJ8k3LVN0u9qbfvPvn9cZgMJG1SMUrcFpwrTcn9yg96ixpIclgZA0a
         Sh/Y4EYA67JMO6eBAuqDpWkKI1yDb8p36ZGa/4VYztzqTnvKXVYKwJ7acKHZokP4iaxB
         oicWUVpndGtA5M7eEybhf1Q6AQlHnRiIvuDkAXtzStHeRsUlKk9tIodD9s5kvTQhQSc/
         XbFQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1wQ/b4HXgmVyGDk1FPMy3dTe296g0D4mqE/tC1+YBVC5hmVeeJGFIK/HlfAT6T/95ECQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/eZVNx/0mXt6wdk/eTHHxhMLIhPgoY3s21zc/L7ndz3pZ7AmU
	eSM4CRhdxDxLvfdHJzHKwT62jEQlPrSqRTE3+RfLvbI3IiRnj3ZHPHqb
X-Gm-Gg: ASbGncs4FGADpZlkpGRQko0pz1fs3E2jVbzMMNdMvTQnSwey8QGDMJ03wDuh4fOFhMF
	ET1eRYaMLNQOSz5pShbO4WW8mTxKIhu7yRoUDCug3LR/Wzd0yf5Be6Ig+dI0KWkzyj36PaAkifs
	Qok6D+rSOPhl4V8ZaEoqdA7/ThdtyGycQN/lvsDiK85KvPaGTwk3k47a6HeWlqml0tecD2OtXZn
	TyNdB9sAH6UqDQXBfNu+VSWxfKMyIIQ6jvQ7c1t3aX+CKtFhXn1fm+8R7o21UMC9E9GiUeAzaNd
	DdMQ6Jirqao6Lg0LAlQqTWNRolgmMd4bt94+2e8SFzyECugWWRJi5LxT5jNH9semIitLwa/GWoN
	IPoqEO0ppaaVRHg05R7s6WF6Ve87XcxtXZIwN0w==
X-Google-Smtp-Source: AGHT+IFbLbX1mDMfuhX9ZSLTdv2xhK/0nUCaMBKcmwcyjrplrDOxaZ5xuCuSTdo44QpNbw/SK/jS0A==
X-Received: by 2002:a05:600c:8506:b0:440:69f5:f179 with SMTP id 5b1f17b1804b1-45365e4f969mr116319995e9.7.1750686129623;
        Mon, 23 Jun 2025 06:42:09 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6d0f1011fsm9508819f8f.7.2025.06.23.06.42.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jun 2025 06:42:09 -0700 (PDT)
Message-ID: <af27af92-73d5-4f0a-84f4-9c91de6ab6e6@gmail.com>
Date: Mon, 23 Jun 2025 14:42:08 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [GSoC RFC PATCH v2 0/7] repo-info: add new command for retrieving
 repository info
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>, git@vger.kernel.org
Cc: ps@pks.im, karthik.188@gmail.com, ben.knoble@gmail.com, gitster@pobox.com
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
 <20250619225751.99699-1-lucasseikioshiro@gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20250619225751.99699-1-lucasseikioshiro@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Lucas

On 19/06/2025 23:57, Lucas Seiki Oshiro wrote:
> Hi!
> 
> This is the second version of the repo-info RFC, and these are the main changes
> introduced since v1:
> 
> - The plaintext format now returns its fields in a key=value format

I think that is a good idea. It also now quotes values that contain 
control characters. In my experience quoting paths works well when one 
is processing the output of one git command and feeding into the stdin 
of another git command. In cases where the script itself wants to use 
the path having to unquote them is a pain and it is much more convenient 
to to read NUL terminated input "lines" that are not quoted. I think the 
output from this command falls into that latter category and so I'm not 
convinced that a LF terminated output is particularly useful. I think 
using an output format generated by 'printf("%s\n%s\0", key, value)' 
would be easier to parse. This format matches that used by 'git config 
--list -z'.

As this is a plumbing command I think it would be clearer if the caller 
was required to specify the output format and the information that they 
require with an "--all" option for "show me everything" as Junio 
suggested. If we were to set defaults for the format and keys now we 
would be stuck with them forever.

I've not seen any discussion of how paths are going to be encoded in the 
JSON output. As I understand it some JSON decoders only accept utf8 
input but the paths reported by git are arbitrary NUL terminated byte 
sequences. How is one expected to parse the output for a non utf8 
encoded path using rust's JSON decoding for example?

On the subject of paths do you plan to support the equivalent of "git 
rev-parse --git-path"? That is very useful in scripts as the script 
author does not have to worry about the details of where exactly each 
file lives and for paths like "index" or "hooks" it takes the relevant 
environment variable or config setting into account. We should design 
the output format so that it can accommodate keys with the requested 
path. I think it would be reasonable to reject requests for paths 
containing newlines which would be compatible with the output format 
suggested above.

I'm not sure what the future plans for this command are but when I'm 
scripting around git it would be nice to be able to a single process 
that I could query for the things currently returned by "git rev-parse", 
"git var" and "git config"

Best Wishes

Phillip

