Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FCD42E3E1
	for <git@vger.kernel.org>; Thu, 29 Feb 2024 19:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709233259; cv=none; b=rG3Q99S2vkWyAKAf+GAalTSeGGGnRexuJz8lpI80yqdua6TFQN01w0z6Q9F3AfSTNmQQinKNaA0Iy0DmO578I6u2lbHoAvVvtr4N8PBhym92d9ZyXxMmuGmXaVWMAZrtUpthwTxSZrSwPtNjaYgvMLci9x1+WlItvZ+kkrLzguw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709233259; c=relaxed/simple;
	bh=S5iqm2SzMC8BCBgY2uc0R6bc/+xfHzlLWdmz/Zjebk8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=EUrMsAvNrPrWYvYO7WrJFc5KE1X3mf/qCWdwe61VnpnUMgWuJIh3oKtGbK2tPFtBDpR4Gxs1XjEbuYHhZ13J3ZgUS/YqUfzRoqQXYLiqjKNUZpbS1W/M/FZ6tK7S30mCfPVW16EBbA/TmDaJVhHhTnO5v5ZFGfe56CAqG1qW7ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k5naxzH6; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k5naxzH6"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2d208be133bso14628341fa.2
        for <git@vger.kernel.org>; Thu, 29 Feb 2024 11:00:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709233228; x=1709838028; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0r4w4S5FcVMPaibmBmG5a8rAVfEtQ3nnnuwVHBPff6g=;
        b=k5naxzH6H4MW8WiH8NdF8hwML91GyBiXL9Eiim5idcQXd3m6U6AxginjTnqLfUXAXX
         3c8//pnS43HS6EXjovBbKT6I9tWD+7KUazMfhrgN7AUcmuBc5f7dwwKhqGARIBs/D1hN
         yST+6lBBu6lSYY+hWyFGFmcuGxyAnmqUL3BlTcxSEmnqU6AJ2G6zseqTYhUD4+jrpwFs
         IOQ49BBpYy5ciTpZ5LG7+BMBfYh2cRftk9CMqfznAMc+sidsT9PIeV9DsFb7bzb4zfl3
         6Lu6Upe0dS+QStxXzE7GnMT3uh9cRdZpbKvBQNEqMK3IFGQ/WrsC4tP7loLox434I3U+
         IP5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709233228; x=1709838028;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0r4w4S5FcVMPaibmBmG5a8rAVfEtQ3nnnuwVHBPff6g=;
        b=dtuYHiMJ6KLMuWfXpSMdiCy67qPGQgQXlKcdIhrjOLBZQcDjXVlLxDzs+NZalg7NYQ
         lGQ+SBMgYJcCd7XCcF0sUwCTLR6wKo9qk1Y2A29nvEfc88UmkWlCJ8A0JuUuSy6QLyTi
         BU0veErLPcffWDrRafhsk9rp2XRD6RPemtln4ku+ubWETQ3pnRRO+yigOSX7itqfG3hT
         3VWlVXaPulWn1OWMgESRlD38vdc1WpZfSMVldAbVcWPF7u7544MQIrZoyKIqQQ0TAHb+
         2H586c4hAWxmi/K1KH5k9WyqDED3aDSjZzdAcClNOpLw17g4V0TeSEn5AIXaMwWmu4tj
         gTzQ==
X-Gm-Message-State: AOJu0YxTY9kkpmiQeV8MeuvI2/tINvhNN/XwJSeHnF8G7pFebGUqMnGE
	XFnDDkD+mPgUdKfPTzFFaHXYlsgrFEYQoiv54AvsCLymbaUwxsD2PFwtwFcs
X-Google-Smtp-Source: AGHT+IExmIjYuWUwGaw7XXVy1ySa8oYNkxX/jzNuGPGfmmhaXq0F+roUws2f9Q6KgGp9/oouU+FOrg==
X-Received: by 2002:a2e:3c08:0:b0:2d2:d3de:44fd with SMTP id j8-20020a2e3c08000000b002d2d3de44fdmr2376383lja.29.1709233227973;
        Thu, 29 Feb 2024 11:00:27 -0800 (PST)
Received: from gmail.com (243.red-88-14-45.dynamicip.rima-tde.net. [88.14.45.243])
        by smtp.gmail.com with ESMTPSA id n9-20020a05600c3b8900b00412a813e4cfsm2892638wms.34.2024.02.29.11.00.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Feb 2024 11:00:27 -0800 (PST)
Message-ID: <ff1c650b-5776-4881-ad0d-c39d311fa7e7@gmail.com>
Date: Thu, 29 Feb 2024 20:00:26 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] completion: reflog with implicit "show"
Content-Language: en-US
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Git List <git@vger.kernel.org>
References: <98daf977-dbad-4d3b-a293-6a769895088f@gmail.com>
 <5991b58c-770c-4aaa-bce5-f396d9f7f16f@gmail.com> <xmqq8r4cnfju.fsf@gitster.g>
 <dd106d87-3363-426a-90a2-16e1f2d04661@gmail.com> <xmqqwmqyr3mb.fsf@gitster.g>
 <abe1c96d-48f7-4355-8688-e1fb05c67448@gmail.com>
In-Reply-To: <abe1c96d-48f7-4355-8688-e1fb05c67448@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, Feb 21, 2024 at 07:06:36PM +0100, Rubén Justo wrote:
> On Tue, Feb 20, 2024 at 17:46:20 -0800, Junio C Hamano wrote:
> 
> >     $ git reflog sho<TAB>
> >     shot show
> > 
> > That is what I would expect.    
> 
> Thank you for responding.
> 
> Of course that's the logical expectation.
> 
> However I'm not sure if it is sensible to offer completion for
> sub-commands mixed with branch names.
> 
> Furthermore, I am also worried that such an approach implies making the
> user pay, probably unnecessarily many times, for __git_complete_refs in
> cases such as:
> 
>     $ git reflog <TAB><TAB>  ;# the user may be just exploring the sub-commands
>     $ git reflog s<TAB>      ;# the user may be lazy and just want "show "
>     $ git reflog show<TAB>   ;# likewise, to complete the SP
>     $ git reflog expir<TAB>  ;# how often a expir... branch is expected here?
> 
> The experienced user, if not most users, should be intuitive enough to
> circumvent the corner cases:
> 
>     $ git reflog <TAB><TAB>
>     delete expire show
>     ...
>     $ git reflog s<TAB>
>     ...
>     $ git reflog show s<TAB>
>     ...
>     $ git reflog show shot
> 
> This is why I choose to fallback to __git_complete_ref only when no
> other option is available.
> 
> If you think, or anyone else, that these concerns don't make sense, I'm
> open to make it work as you described.

I am happy with the current iteration and I still think that mixing
branch names with options is a source of confusion.

However, this topic in the latest 'What's cooking' is marked with:

 Expecting a reroll.
 cf. <dd106d87-3363-426a-90a2-16e1f2d04661@gmail.com>
 source: <98daf977-dbad-4d3b-a293-6a769895088f@gmail.com>

I am confused about what the expectation is.

Consider this message a ping as maybe the message I'm responding to has
been missed.

Thanks.
