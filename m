Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C2A173335
	for <git@vger.kernel.org>; Fri, 21 Jun 2024 11:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718969291; cv=none; b=G7EVlziDH4A9qz7XCyG6SuGOW910Tn4WiYhZb6vbKyexzBkIc1V8Af3PRFaN2p00zO8iP4jqPdTsAeyxwTStbfJhhhS6gl90YQvf4MOjp7mMAHgU7kgg4o7bdewNYh0n7GQZncJR4DhaGn7d8GmFzUgx8EO8E0X297xgB/EhjhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718969291; c=relaxed/simple;
	bh=A3HnbVPZJGw1t62CS0BZzz2LdLW7m7YR77lng86mFf4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C2uwF6VVl9jsPPoFTpzhtHKnE6aW/9ivPSwQB+HXZhbxXQkkoZuUxRmtBEQGG6CyAEdWZsX1KXJeDYFE4e6vnVrgJoPBOnZofs5P1QxFMYGOzHS6+sbI1S115AsBICnFE9JLSBMo/ysC2t4ZO/Ai7RVDdBLTxrdSfltBKI6BI38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YbJ22JYn; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YbJ22JYn"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-421820fc26dso17770745e9.2
        for <git@vger.kernel.org>; Fri, 21 Jun 2024 04:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718969288; x=1719574088; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=s3/cjQonMyMmM/90Zye824EY6obdq8EfW/NCYYESG7E=;
        b=YbJ22JYneer1iUjwDIevGFJoOUgcEHaLN8ib/9UdjtK0Qyama2nq6eTK3e0mnY+m7C
         ns8D2tfLnPsPpsOLf+RzuxjBAU8ZxNnOVqRWFHn9Yhgi41bhPWFztBuRkRsGTsnCzC9z
         ntf9AAB1LgvFZJ7rglIVlXtHMNuF5ZCQUEnleP4ZzQ1Cm4/viKpabzTfQhyUyLUnU+85
         GXt3bE/NglajnFIx+oZFRTDdFR0mwzp+GKRgQMB40yIYHya1sB8GYCyVcCWZXhPqVznY
         PadIbe1pauGzXJBWCcEr8/lnRg4oUzik/lXW9xfqrcHf7wsU/Qg9Mw96nkSEX8ZUuxyT
         z+OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718969288; x=1719574088;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s3/cjQonMyMmM/90Zye824EY6obdq8EfW/NCYYESG7E=;
        b=uFYNmSey2wPoWQZ50ug/gsC625ZQqjp903a4i7QQ5jRFkcavFSZ0lgIWZlr4Dy0PWP
         WpZEfH+4oXGBV38xUGy1iotPbWH1JZjNC7Z/pLMWBVtusyJS8MtmyPz6pvg3FlkQCM7F
         S+8+yD+m+HRfjE/W8XrHgIV6yDAmsx0b5Vcjm6g4pqYE+hNfOy9uGwewNu2UJ6WM0+go
         t20HBcJW8EnZQLZO+YgH+wbRrRiGLSiglRHqdQ/z2/n/otzvX537QqDTzdV564lMnDwG
         gSBDAzjwW4nCEYIZkKz2p074GN/t44772Bl1cUfZUo/8pNivqWYK5CMMgkZNfVq+VD7c
         7e8A==
X-Gm-Message-State: AOJu0YxvEpQiEdV/ZlnLZJrO3aiBVv+YTvBBBdO232kj2A+iismLKI4M
	TIn3864p2LxubQxSa+IFzAvhtNOvQMVJO6n93jpE1ZOZcinNK2zCKsb73w==
X-Google-Smtp-Source: AGHT+IHNJVM+zJtLcWcpH5wOkHAWN3HC+LnH0yZU7b1wjYNsFNK/G4lzOee5n4iG8Hx2ChBC/vhnMA==
X-Received: by 2002:a05:600c:1c94:b0:424:798c:120a with SMTP id 5b1f17b1804b1-424798c1341mr51482625e9.24.1718969288010;
        Fri, 21 Jun 2024 04:28:08 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:64f:8901:b1e3:645a:b3c0:7476? ([2a0a:ef40:64f:8901:b1e3:645a:b3c0:7476])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-424819224fasm24510455e9.46.2024.06.21.04.28.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jun 2024 04:28:07 -0700 (PDT)
Message-ID: <ab50c9e6-e43a-47fb-b64a-136d6a768f75@gmail.com>
Date: Fri, 21 Jun 2024 12:28:10 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] pager: die when paging to non-existing command
To: Junio C Hamano <gitster@pobox.com>, =?UTF-8?Q?Rub=C3=A9n_Justo?=
 <rjusto@gmail.com>
Cc: Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
 Johannes Sixt <j6t@kdbg.org>
References: <f7106878-5ec5-4fe7-940b-2fb1d9707f7d@gmail.com>
 <xmqqsex7tp0c.fsf@gitster.g>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <xmqqsex7tp0c.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 20/06/2024 20:04, Junio C Hamano wrote:
> Rubén Justo <rjusto@gmail.com> writes:
>> --- a/pager.c
>> +++ b/pager.c
>> @@ -137,7 +137,7 @@ void setup_pager(void)
>>   	pager_process.in = -1;
>>   	strvec_push(&pager_process.env, "GIT_PAGER_IN_USE");
>>   	if (start_command(&pager_process))
>> -		return;
>> +		die("unable to start the pager: '%s'", pager);
> 
> If this error string is not used elsewhere, it probably is a good
> idea to "revert" to the original error message lost by ea27a18c,
> which was:
> 
> 		die("unable to execute pager '%s'", pager);

Either way I think we want to mark the message for translation

Best Wishes

Phillip
