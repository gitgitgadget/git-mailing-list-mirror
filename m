Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C459327A92B
	for <git@vger.kernel.org>; Fri,  1 Aug 2025 15:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754063387; cv=none; b=AK/9uqEkMU3Iil7ov15AMMFh5LzeZ9C0/t/7c5Z61Z6ixXM5ntU4eNd+aqHor2A6kkeiIb4mOpQVjSYoRxZQyrQ/mcfdh5wTrWfwdyzX4K66EIpKUNZ7veQJeZWzNA67Ntl7TvehOtq4WRcx3OxhYJlPhe6gXWGw+lTTLnF+hSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754063387; c=relaxed/simple;
	bh=zBOhqGG8542kvxle48I1UeRnRkWKIKPNHBENXaBKfaU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cmfBJ4QIa6+IByg7KELdgj3wtofayszzNHoDSrJ9Rnng3I2xluVDwQWp1IcQ6h9HXYj8q5GXMcC4OrKGDutJ671ePKB5koyZ7/epmlhym3vSdYCA4UtZGOz8mztLKPb9UoGw1h6BrnzVIO2c3vOMjYc/zajvm6XmpW6InnzRnI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AKr7OqkN; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AKr7OqkN"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4589180b266so12441095e9.3
        for <git@vger.kernel.org>; Fri, 01 Aug 2025 08:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754063384; x=1754668184; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QO9nsQuATfBlHdkg5UrNGVT26y0tHZOeFK6wkWUnbsA=;
        b=AKr7OqkNfixJBcU+aPg/tkNUhE2M/AVsJRwB+GIkstID/d9Ruhwn2RhkEF9+E/S6e3
         nWLOvedCnA357HaYfzEXt72vuLLORLk+bAphV1G+5Al3Qkktz4s35XriwzBeGcRfJZxm
         fQFIlDjOmuQutK18hfSN+mQib6AckOJDNCYi9H8D6dgk/pnC72lPAg9IXCOUjGo8HzRz
         DUwO8AkMZANHNTUNxYXEiPWTS3ehtXW3kdVtMZVoOrJ0lpE4mDVQhmLji/pG1h9C5tjk
         bnPllImjKszp2J+lCYo7g4iKNbGRQxg7+ayPy8tSQVk+3LyOH7V5v4yWJvgUb6G2liuv
         veJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754063384; x=1754668184;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QO9nsQuATfBlHdkg5UrNGVT26y0tHZOeFK6wkWUnbsA=;
        b=OOyGKJ/E92pxPeyeCE8cDkYtONjOvfh7GnXhaa8C32fNbDCEVeHCI8xRTllJfiQohJ
         5ruMeF8UMsWhiuRNfUU2Xu5hp567lsFmsyjCGePmJ0f75dZVyprttcHRmcTrdNFE3wiz
         Mmx/+ExwUIRMHrGXvd4LkWG0OEyWq/4gCyWtr4iui9wkOl69Hp8r4yUhF+2kMOEmyf5+
         b6JVtYRyvx53Qst3ETePf+iWpOFfpx9TolxTPFQ1ESZAMQ0C66Ou+TY7bnRrzo0M50i5
         bM+P2hSRzy7yJhgV4KeId++V8yh7mEOuVEYuwGa/p1eJpBzDWVzaWO1ggJWmtRiJWNCZ
         Ow7Q==
X-Forwarded-Encrypted: i=1; AJvYcCVIiiu8wg5EDsQT8cOd9+u9wgmVefj4k6wCfjYjI2ty8WcjhUkwXFX1epu9JvHuct1qHVQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1CegWdjjkd+w0cqUXho05bIy+ad5tIwiLibz/WlfVGJ84Vffk
	8bMI0l2tbmG/+fW4LZvrKfYvXmPBSx6pbdEioiGzl/5JAS+W8O37RNuY
X-Gm-Gg: ASbGnctehpmjoc/1Pdm71JCk7+sepdTf5jJOqfOGMtKXz3v/4QqhG5FHB30pW1mUfuR
	6XtkzTQEoyApAPuiq0Bdm3iVZo/+EbXICZvsgirUl0dLbJTiQ4PS9PxRRZ/cIieufQeR5pLYdoX
	lSx4iYZE8d6OoKF67GvHspqUVu5zQ1yWJhpifp4kawdFr4FAhcLFR8FpHJZ/Q0hIktSXFeWUaE0
	uFm7Imx5Q5CnQL6DkNFNCTBkElin6ZCI2fdwmpewDpUkmfbfwDc5pPULyihThyytQh2/iXZwbRT
	BB2iBIuUivOa2tPSf5smZciWkCiH7FMeQghsk962B6qPW3r8HtRDsfc7ZY4Df89v1zU52kK8bMW
	+90WPyfYa0j/xT6iBJgoY9iBBL7vg4MywNUDAkBiMA3JGberEb8KxSuiFcq283hLoyUwu0W3naa
	eQ
X-Google-Smtp-Source: AGHT+IEvRzDGCRNnmmPlOs0+dz5UfiQRrXUqcUKwEHLuJqCyGXy/QJyFD3uddCV0OJxC3nPh44suig==
X-Received: by 2002:a05:600c:c1d7:10b0:450:d386:1afb with SMTP id 5b1f17b1804b1-45892d5e314mr83734885e9.9.1754063383773;
        Fri, 01 Aug 2025 08:49:43 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c? ([2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c3abedesm6403282f8f.3.2025.08.01.08.49.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Aug 2025 08:49:43 -0700 (PDT)
Message-ID: <c4d9b25a-2a62-41bf-90e6-455c62b03aa3@gmail.com>
Date: Fri, 1 Aug 2025 16:49:40 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [GSoC][RFC PATCH v4 3/5] builtin/refs: add list subcommand
To: Junio C Hamano <gitster@pobox.com>
Cc: Meet Soni <meetsoni3017@gmail.com>, git@vger.kernel.org, ps@pks.im,
 shejialuo@gmail.com, karthik.188@gmail.com, sunshine@sunshineco.com,
 John Cai <johncai86@gmail.com>
References: <20250723064313.29866-1-meetsoni3017@gmail.com>
 <20250731090040.1625303-1-meetsoni3017@gmail.com>
 <20250731090040.1625303-4-meetsoni3017@gmail.com>
 <2d2f823d-6e85-44a0-85d2-d45d4dc287fc@gmail.com> <xmqqseibm7ap.fsf@gitster.g>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <xmqqseibm7ap.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01/08/2025 15:43, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>> I find the behavior of for-each-ref quite confusing so I wonder if we
>> really want to copy it to the new command. For example
>>
>>      git for-each-ref 'refs/h*'
>>
>> does not print anything but
>>
>>      git for-each-ref 'refs/heads/m*'
>>
>> prints all the branches beginning with m. Another example is
>>
>>      git for-each-ref 'refs/heads'
>>
>> prints all the branches but
>>
>>      git for-each-ref 'refs/heads*'
>>
>> prints nothing. To me it would be much easier to understand if the
>> pattern always required an explicit wildcard (or possible always did a
>> prefix match in the absence of a wildcard).
> 
> Thanks for raising this point.
> 
> One point you are wrong is 'refs/heads/m*'; it does not list all the
> branches that begin with "m".  It will not show "refs/heads/mid/night"
> even though it may show "refs/heads/morning'.

Thanks for correcting that

> I do not think we want to require wildcard (in other words,
> refs/heads/ and refs/heads that result in the prefix matching
> behaviour that is anchored at hierarchy boundary is a good thing,
> and we should not require refs/heads/* to get it).

It is confusing that refs/heads does a prefix match but refs/heads/m 
does not (unless there is a hierarchy boundary after the m). Maybe we 
should require a trailing slash to trigger a prefix match?
> As the "list the refs with various criteria" feature itself is
> shared with "refs list", it would make the entire system even more
> confusing if their criteria to choose which ones to show are
> different.
> 
> I _think_ the current selection criteria is basically the prefix
> match that is anchored at hierarchy boundary, and a single asterisk
> expands only to a single hierarchy element without crossing
> hierarchy boundary.

Having had a bit of a play with different patterns I think that's right.
> It is very handy that refs/heads/* expands to
> the main integration branches (master, next, seen, maint-*) without
> showing pw/3.0-commentchar-auto-deprecation branch and others.
> 
> What does a double-asterisk currently do in these patterns?

refs/heads/m** seems to behave like refs/heads/m*. I'm a bit surprised 
by that as for-each-ref seems to set WM_PATHNAME and I thought that our 
wildmatch code used '**' to match any character in that case.

> If it
> is not doing anything useful, perhaps we should make it match any
> letter, without getting constrained by hierarchy boundaries?  IOW,
> a "fix" might be to make sure the following happens?
> 
>   - "refs/heads/m*" matches all local branches whose name starts with
>     'm' like 'morning', but not the ones inside subhierarchies that
>     start with 'm' like 'mid/night'.
> 
>   - "refs/heads/m**" matches all local branches whose name starts
>     with 'm' and in the ones inside subhierarchies that start with
>     'm'.

That sounds like a good idea

Thanks

Phillip

