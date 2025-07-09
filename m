Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39EEC944F
	for <git@vger.kernel.org>; Wed,  9 Jul 2025 01:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752022809; cv=none; b=nnO9GsfGII1AiN6V+ywe7t7bK11nZVSFyywcWGD8bjRprYhuD7QkpY1HC5dKDcJsxDGLuG5jxweRA+LxcMDIQaq1dBaXBXT69V8dBYo+LyrwJU8QmFxo4Fyw9mgKijR8QZ/ssd5ja8YO/Vsjoes0s10d/jtKJ8nlnLuPCB1G3Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752022809; c=relaxed/simple;
	bh=hIRj/VW3SmhIlz0mw6heWspczFw7VMg89COsiU0rVjU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jzs0BMKyB5b/8n5ee+WyRVGgBg8JLc54plJo5P2EAlLDJj8FmlaBK1edDqkG6pwPzp7soc85N2d7voSALY+MM/zNj+9CYWiI7A7snHKahYE+8nFEwbP9OQD2Da5LZfXGnTBGnCBRedWfNvf7oPgqeNRgKzInd7QZDnItoiRyWU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j5sUMq1j; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j5sUMq1j"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b31e0ead80eso3827423a12.0
        for <git@vger.kernel.org>; Tue, 08 Jul 2025 18:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752022807; x=1752627607; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OH07cCuvwHut531FkVtAaqcF1/30qVWMt9+tuI1UgaY=;
        b=j5sUMq1jwFedFi5WIwKnXkU4XH2iNj15cp6Bm598E5vwYui8Qdfc8O4pNSSWQtiNiO
         5ReUKh47v7XgdLpXJThV4bwwvt5FsVsDCrH78+cw82MVDBKq+QwclxKgXqCYQXs1O03I
         Ez/XG3gZyHXJuXNwTeIUOV4s7gpV6VzRM9j4G8TUw5jWHwZKMdESP69G4y8Um4U+btQr
         JNX00wiDev8jplvJOcp0wgcLLwCvLsPkIzgq4nxq/oBV6gvSh0u+yR/icHhV52isuYuZ
         TMEBCPK2e7I+4DpZshfD5OL3VPJWHuDoT7FLqc8wabttiebfvCkL69UismlN9t786zYU
         W/5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752022807; x=1752627607;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OH07cCuvwHut531FkVtAaqcF1/30qVWMt9+tuI1UgaY=;
        b=rF+LP35oRwtdrDm/OpKjYyIp+VtF306/6PF7HPCmOceO8nw1WuQAOnN8CB5tu8HzZ8
         9Nfwvaojrt1RbBgjFefJzaWcO4RKZ7c/60O7tR06B3khhrOv+8En9UycyzEynGoHtQeF
         4Oz0qdo4LXK3UWsHA5rsS4koZ7y+1w0nRSsOCu/fqgrU5XNod5buKND59K+Xg8KCyfW9
         TZDBGKQWz5WDXNJNQTq0tLk7/Wx2i3pqmQga/6npxlxZPzegswobgE/oPp1kPS5gWkLp
         KmYuvzyIGtHllq2XwfiaFDwgDFJyYXf66qTKgoteaNle+vyqaQ3iWxw+l3TDFAi4yuWH
         kcYQ==
X-Gm-Message-State: AOJu0YzP1Rr9qb1mNVJGwLolrOIy/vluhDjNux6R6ipZu3DLFhYVdQl6
	hiARnbEsfNMrmmEKzCC/3Bc2N9T/yObbFLWaihjC9JBuE75TFA4A0cqt
X-Gm-Gg: ASbGncvmCbzD2MgFH+bZfO9wyv16DhxMo/D8p3XKgFa7h3mthWmt580w0pA3X4RHsTR
	BD0SKRVGuO9W+WCOkiHAR/dzuUHreGl4HUSJeImT7OXzwo6yZ8BFHjaRhRq4na7Ezsy9OcV7omM
	ucT3KuYC+YBL9vhLYVjBaaUJr97a/WztCV4CdcIJ21mDJov3bPj08JwtKvGTIneXhIKflSt56Id
	9U2sP9me0Aoohh/FH4SeQa069bYpntytOSCWVrjHfo+OzNqUtYdssebZ3JUjO9XKzyudcCZY8pc
	XtcsHLXObjUjFpVIVO0qWlG2IFeJoP+kQxWM6Q/y0X3K5G843onDvcgRZaJ3MLzt/DqVH10=
X-Google-Smtp-Source: AGHT+IE0lQhHc38191/c6lR/eZDQGFNauaZ9jjSXqmIQ9sXHmveaVh1CQdDbgHOf3VU/Gtlf25mvdA==
X-Received: by 2002:a17:90b:1b08:b0:315:aa28:9501 with SMTP id 98e67ed59e1d1-31c2fddc381mr1029243a91.24.1752022807210;
        Tue, 08 Jul 2025 18:00:07 -0700 (PDT)
Received: from [192.168.1.5] ([103.80.119.54])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c3007e53fsm357978a91.19.2025.07.08.18.00.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jul 2025 18:00:06 -0700 (PDT)
Message-ID: <368ceaae-e8af-4b9d-9e4e-26cddaf689aa@gmail.com>
Date: Wed, 9 Jul 2025 06:30:03 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: locally storing issues/comments/projects
To: Eli Schwartz <eschwartz@gentoo.org>, Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
References: <3e964e0d-bb90-4074-a9ae-a10fb02b3f50@gmail.com>
 <xmqq4ivmtlnf.fsf@gitster.g> <3a8590f3-ab8d-4155-b8c1-7cd34dc9db00@gmail.com>
 <c629f3a6-4749-4ac0-8fbb-fd1fb9db1d0a@gentoo.org>
Content-Language: en-US
From: Sahil Gautam <printfdebugging@gmail.com>
In-Reply-To: <c629f3a6-4749-4ac0-8fbb-fd1fb9db1d0a@gentoo.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 7/9/25 6:11 AM, Eli Schwartz wrote:
> On 7/8/25 8:21 PM, Sahil Gautam wrote:
>> On 7/9/25 3:01 AM, Junio C Hamano wrote:
>>> It would be very nice if these hosting providers can agree to make
>>> project metainformations interchangeable in an open way.
>> it's not just about migrations, it's about a repository being self
>> reliant in itself. think of some git
>> hosting provider blocking my account because of some ai algorithm, think
>> of some disaster striking
>> some data center or some malware deleting all the data on the servers,
>> all these are quite possible.
>>
>> having git store that data means that you clone the whole thing and
>> doesn't matter what happens
>> to the hosting provider, if you have the repository, you have the whole
>> thing.
>
> You may be interested in https://github.com/git-bug/git-bug
>
thanks Eli,

i will look into git-bug try it out and see if it
does the job. i think like docker-compose, any other feature requests such
as this one have to first prove their worth in the wild, and since your 
suggestion
gave me a hint that they can exist separately, i will take that route.

