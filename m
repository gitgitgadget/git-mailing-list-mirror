Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0A31B5A4
	for <git@vger.kernel.org>; Mon, 10 Jun 2024 19:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718046579; cv=none; b=s1XflhHHmgBs3W1jLZMiZSZMRUHRjfKf9UTRGZSk/vAlV70bNt0alkQNDDOdowg1Kdd5eWop5p9IdjQvbDaoZPWbc0aRFbl4hQUxgoZZM4gDVVkHZ/SR6lTl1GhYSQVZ8xUojkWri+1eBKicfOlkG474/Gt6PJPuGBpfriW//+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718046579; c=relaxed/simple;
	bh=ytwDQV6vPUXUcdG04ILC9YGp+IFkt2cwxdwKmWedzhs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P3Gn7q7CxgCTQ1vYdqetcJwBQEVinNqzWvh3Ml6r63GQA3Zbl7/QiE+vT//4pRlUdFTccU0cixPFDULi0TUTDzfqRpYea/TITqcCAt36FsSyxR4smb1G9Hnje3zRek3A40EZB+SNBBHhNi2NRqq3rGa5/vMpdr0NseW6pg99/Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gPc6oGD1; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gPc6oGD1"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-35f1bc63981so1359734f8f.1
        for <git@vger.kernel.org>; Mon, 10 Jun 2024 12:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718046577; x=1718651377; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PvaW6RgnbbyWPrHs9A+D6Oqk1Xe9DI6jSvyscWawKn0=;
        b=gPc6oGD1xbUMEbNKEQKRsM/yUw6d58ioWTwTg5iu3t/cIkDGqxUfr7bEM+sVAJSCpo
         9UnuY4dzG75D9PLNFqsTAKlf1whd0IQly5rFMDMCyz60DtmJVlxlCVZYZHcCG8xcmh11
         Tw4LMFzOuzcU9e7oW8ESCu/FGm2SpV/6j+OC9iwRJm4VK4xxELCiG6trqPb/SAF0YVJP
         Zu5k20f0Kd54L3XNiWAtWLq1Pob8dzx723cLQyEnBfDa1X95ltjtfBoJGsOgShQVqQwk
         MHnEQWDv5qpbyPmf7k4CIbuzOkX1gZC3OmTeJ870Pydlza5wSbPaKSGnvvZDEbwcA4us
         OuyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718046577; x=1718651377;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PvaW6RgnbbyWPrHs9A+D6Oqk1Xe9DI6jSvyscWawKn0=;
        b=ZgpAydtGpmyW9FDoy/Q3xbflY6on7DLka2hgOHK6u2Ili6pcjveX73QHYj9I3iHPXi
         lbmvHiJS4+JybDcGH/8V4TzJ1Tmj6Aio43UQDM4OmnNPqEHj7W/Ie6ua7J/51vhibhnO
         9nMkxr+t7z4XHPSaMjmM3kfKA+uF6TPh+cWcHHwyiA4wynkGX4nL/K00Nsvwv4vrfp44
         zDIKJMYqUeGkd8NN7xEVaXr00OBZ1TexRQv6jCAl+z+xTz9wRxchb/B4nhx/oqOe8xT5
         PrbquAsJhR01wDoPkr+AjLQ0PdVFDUXLy29ZHB3fS2xu8XOj0qUPfichL8SAhqbCKyLp
         UWEw==
X-Forwarded-Encrypted: i=1; AJvYcCXpQum4pYBCrBzb7lWqBC4BoFHDqWwgypmnwD01ezeGEYNDgYi2L5ezEpRRRBygiumLN6CTHCXDDfoM/2JJu4ymFBPw
X-Gm-Message-State: AOJu0YxbrbKQt0qeXxnRkrORpwf8WTVhIquwhmKdB8F9eMOs2zC+TtSl
	lYbWGf5MdogF58cA5U64/sNxI6Zdb47MSZKhnAdU2Z1f3nejUoi5
X-Google-Smtp-Source: AGHT+IHmJif4+wIg5K2EyV6Z6VE5gRjge0OA2EaI8AAWYQXUbILL4RRpDBfw6LY1uCAxMcysajno9A==
X-Received: by 2002:adf:fd10:0:b0:35f:bb3:56b1 with SMTP id ffacd0b85a97d-35f2b225fa6mr646658f8f.0.1718046576354;
        Mon, 10 Jun 2024 12:09:36 -0700 (PDT)
Received: from gmail.com (62.red-88-14-48.dynamicip.rima-tde.net. [88.14.48.62])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35f29116506sm1777431f8f.60.2024.06.10.12.09.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jun 2024 12:09:35 -0700 (PDT)
Message-ID: <c4f54fdb-bf89-405b-a48a-acb58088557c@gmail.com>
Date: Mon, 10 Jun 2024 21:09:34 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/6] use the pager in 'add -p'
To: Dragan Simic <dsimic@manjaro.org>
Cc: phillip.wood@dunelm.org.uk, Jeff King <peff@peff.net>,
 Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
References: <1d0cb55c-5f32-419a-b593-d5f0969a51fd@gmail.com>
 <199072a9-a3fb-4c8d-b867-b0717a10bacc@gmail.com>
 <b7e24b08-40a1-4b18-89f6-e25ab96facaf@gmail.com>
 <20240604101700.GA1781455@coredump.intra.peff.net>
 <xmqqikyo207f.fsf@gitster.g>
 <20240605090935.GF2345232@coredump.intra.peff.net>
 <6056d585-6380-43e7-adf1-9f9aadd2a7db@gmail.com>
 <a8d3415e3913e3a0798a748ed7f7a093@manjaro.org>
 <219a195c-74d0-4c21-bf54-0752bb5b01df@gmail.com>
 <7937845d7cb7ae0179c4922ed154c5c7@manjaro.org>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
Content-Language: en-US
In-Reply-To: <7937845d7cb7ae0179c4922ed154c5c7@manjaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sun, Jun 09, 2024 at 09:57:20AM +0200, Dragan Simic wrote:
> Hello Ruben,
> 
> On 2024-06-09 09:44, Rubén Justo wrote:
> > Some concerns were raised about controlling when to send coloring escape
> > sequences.  Several ideas were discussed to address this, including
> > introducing a new command ">", a modifier for "|": "||", and others.
> > Alternatively, we could leave it up to the user to filter as needed.
> > Or, simply, do not send escape codes at all.
> > 
> > So, looking back at the ideas discussed in the thread, perhaps a
> > reasonable next step might be to reintroduce the 'P<program>' command
> > and let '|<program>' be the way to send raw, uncolored, chunks.
> 
> Actually, it would be better to re-introduce the "P" option, without
> any parameters, which would display the current hunk through the
> already configured pager

I'm sorry, but why limit the "P" command now?  

I understand the caution expressed in another message of this thread
about playing it safe, but I think the user won't be surprised if we
respect here the "color.diff" setting, just like we do with "p", and
...

> and let "|<program>" be the new option
> that pipes hunks _without_ coloring escape sequences to "<program>".

... we'll offer the command "|" to allow the user to process the raw
chunk.
