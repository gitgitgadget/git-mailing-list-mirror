Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23F92C68B
	for <git@vger.kernel.org>; Wed, 27 Mar 2024 11:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711538062; cv=none; b=D4jYyv9N8jIrLXwkBy0VEBdZd5DGQVE+MqJPxjYYIF9v3vxmHHmOAyTNzZiCX/W5Wrarv78+9ktUnPHTjRwhR1BxiMsW5vzq8tLF6SnE/0iBkwqxdGythFi9Zu+eSHbC1R0WG9mNBZ1Gj16KZhzr3mE30vtjnETZ+PrzXMuGBHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711538062; c=relaxed/simple;
	bh=lp5k1jWklfaQcVoX7PBRBGxgQPmmBNEROAYDQkL8xgc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bf6K1cnhB4AyB8Zsn+CXjrwBxODZi/FC037jPlvum/94K/SLWWri5+/4si3ojv4UgTeb2g7G4+r+0wctMZNeKqQxHEfuDTCKr9+/CbQbTm6XcyyroFiloj6H4CUg7e/T6cC1EwWN3LbY3/exDFjdbe9fKXReOBEwNtv8pIcO/j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=boLkuI5d; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="boLkuI5d"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-33ed7ef0ae8so4678326f8f.0
        for <git@vger.kernel.org>; Wed, 27 Mar 2024 04:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711538059; x=1712142859; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=PxW88FCKnran6YuMiNKOEafo9MAkEt/m1xz4nIolwgY=;
        b=boLkuI5dlt1AFM3wIniUSbhpH8XZnMdDttxV9jHnniZ0EynkWlU4XPsVevzYt8iMef
         +//D9ILn4+yjhgm++1FrxJ1IsWQqm+EXxV0cVNCuhnmaIOt0rk6z/9/sPvBFrVo6BWwO
         QhJlXFHXD/1YPalzxkzo6wKCqG2Bj4xZTgcNGpr+g8FE+M5G9u/B9DJ37+kdvxt+/Oqj
         5/BJkjTDwHqdKZpNfksQ+fGsQx7lkZ7I5j/HjZy5/jPkVTO5JectOjH2Ay30VlQUykkz
         nsmrz9+bxEIqvyNT+20XPMUpSGj2mI5xj8S/eWOZ3gUET38VepT6ZLNaMVNlgXoV0dKu
         a0wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711538059; x=1712142859;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PxW88FCKnran6YuMiNKOEafo9MAkEt/m1xz4nIolwgY=;
        b=SeBg+FMpIZoGS92nmbmS4iBPrwrjzhbW24xhdid/hKtbFKdNdGo964SmCUHM1+umw1
         gIp5jqyaKqAtFaUXdAAWb9VGC5Ei92SObH0WUsmoSUUMboG7GwPf/kysrKmlmHlnWz1I
         m3DnU2KQxrUvoQ44uOOZU/loxgp8jYUe4rtqomVAU5yj6otC76s1437GCSLrsg7a+3Jd
         SRKYv9v5BY+YxATRK56X39Qzb0Zy9sKkxDffabCnn4kMqC07EIcQklLDT/Uw2aiMRWBH
         3w8aLd105nM77qvX5Dri/qggefosY8QIsNsXoSQje82HVaw1OzVMzSYx0jo+DFenqrAv
         6W7g==
X-Forwarded-Encrypted: i=1; AJvYcCWOl4AlpPOx/W+uM/34t1yxCYOKBHMdXdqioTzj+W6NkJGGXPzoUz5CLlHma1fntVvx0x6EQgdWQWse0qpP3d2Q/eqF
X-Gm-Message-State: AOJu0Yx2Ts8UNNg/Vhjwzodf/FHJq0I7sGdNLqE85ao6Xx/IWR0+YLg/
	nBxy4xkUtRJ3oOOgVcvpnr3QcDhuMeBuNyOCVpuO7lFd0/u5cMjtXUHo84IO
X-Google-Smtp-Source: AGHT+IE4RcfThtYeor9X8CPnSXLgmiBzEYVD/P+V2PJoXRvnccTPrun2+X2Sfhcxek9cOAbudseIzg==
X-Received: by 2002:adf:f48d:0:b0:33e:9113:a228 with SMTP id l13-20020adff48d000000b0033e9113a228mr1002702wro.35.1711538059134;
        Wed, 27 Mar 2024 04:14:19 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:68c:c401:d2c6:37ff:fef6:7b1? ([2a0a:ef40:68c:c401:d2c6:37ff:fef6:7b1])
        by smtp.googlemail.com with ESMTPSA id ch9-20020a5d5d09000000b00341c6778171sm10268756wrb.83.2024.03.27.04.14.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Mar 2024 04:14:18 -0700 (PDT)
Message-ID: <8a05d7f7-6d94-4228-9507-d3af44f100e7@gmail.com>
Date: Wed, 27 Mar 2024 11:14:18 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 0/2] improve interactive-patch
To: Junio C Hamano <gitster@pobox.com>
Cc: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>,
 Git List <git@vger.kernel.org>,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <2c99dee8-fa6b-4f4f-93b4-3f7a8e0901f9@gmail.com>
 <6f2ed406-2152-476b-b463-3010afe7e11e@gmail.com>
 <59f19783-a663-449d-a1ef-3a9ebc43cc59@gmail.com> <xmqq5xx9dn6q.fsf@gitster.g>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <xmqq5xx9dn6q.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Junio

On 26/03/2024 15:31, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
>> I think this is a good idea, I've left a few comments on the patches.
> 
> Thanks for your reviews.  You raised very good points, all of which
> I agree with.  'r'edisplay may work well (and I wonder "r | less" or
> piping the hunk display to anything in general would be a useful
> future enhancement).

It would certainly be nice to have some way of paging the output in the 
future.

>  Response to an unrecognised command should
> probably be a two-step process (a short "'h' is not understood. type
> ? for help" with list of commands upon request).
> 
> I however am unsure about omitting 'p' from the list when we did not
> skip.  We do omit 'k' when we have NO previous hunk to go back to,
> but that is because we cannot do it even if we were asked to and the
> only possible outcome is an error message.  That is quite different
> from 'p' where we can always show the current hunk when asked, even
> if it is just after we have shown it already.

I agree there is a difference between omitting a key that simply does 
not work because there is no previous hunk to omitting 'p'. My reasoning 
was that 'p' does not do anything useful for the user, if they press it 
they end up with exactly the same content being printed to the screen 
and so I think it clutters up the prompt. I do think though that if the 
user happens to press 'p' when it is not in the prompt then we should 
just re-display the current hunk rather than printing an error.

Best Wishes

Phillip
