Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4600A59C97E
	for <git@vger.kernel.org>; Thu, 10 Sep 2026 19:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789068912; cv=none; b=Fh3ULKJC4F8WlcZ8natNSkbJIwosAXt4xQI6iRFoLopsufOlolBOEkye7vl+LP8KEEFrbtaAoE6dqt6HhEN8m+HEdC4UNPLwUCLde7sIq3mF7quLL9icteASAeYk6QwnwEeTlW7EIFHf3QHHm5HqPKq15exU6oMq4A/eVJucfPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789068912; c=relaxed/simple;
	bh=CqgaHFNvqYn/2i/zMja/Q2XC3k5+p2r/SUGmuquqqM4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QEJKOCr/BI7Gx7+8gGI1wgj5KAnLQviid4IPQ5X040+9RYjGqTi3Asi32kRiUOvrGuwdKAATikDUH9NlW7x9CC6WizJbxOcnxAtT5/pKr369ViEleMo6D0D6J7qPsuM2ucAT4bB3y4WYFP0HyOxhDf3H2QpH7ic21i+pkxX44Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g4dYRfGW; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g4dYRfGW"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-49cca4ffdcfso1884915e9.0
        for <git@vger.kernel.org>; Thu, 10 Sep 2026 12:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789068908; x=1789673708; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=SdK7UeMqaWiQA/0xLCLHDh0xeB+P8k2ZjfxfvahtO6I=;
        b=g4dYRfGWaPH2EpSdPRRhgUP+eVUyMRrpr5cpW8npxlTSfNuC9KymdeK7A4otWdO4bZ
         F2KSBIL7n1Q2vcskYJsO+/O8Wxx/Fi9dDZtD18dyv24HE7b7wu2h30JJzpDdv9UPjlIL
         pddnid0NZspTb6KIwU+in29bMIvSwGiLRbuDS05nZuOnl2LNXfsyGytQXVTAzBaq7RLj
         npiI0brhvMxQrWM2F153H6SEyVmBdwbaTcFQVhOsxGS3jSKJ7tz9hD4WWH66XbyQUoea
         m03bv1L2kGOyUHjGb90ORTxQYJzHXWu0xeyJXc45HXto9Si5TdlOiTk33MEUH22q4PY/
         Pq+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789068908; x=1789673708;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=SdK7UeMqaWiQA/0xLCLHDh0xeB+P8k2ZjfxfvahtO6I=;
        b=Wp7PIILIcwPMMAlFW9+JqG7vxTRg4DfvQQ7+HR85vX90vRoVeUD/FkNaAwe/kN3iMG
         BjCEmb1T63OeznTnmLX7ZlUs5Js/ojMvamO/EL9Lcm0xAG0yixrA81e7hgXocOBCwmHp
         0g90uC5/2viQ67w4nf675VWDlkqRvzMaRBLZE+EQFsNLjQ2AcGtCfOGIvpdrhYQxyZ8N
         TGe8A1RMYOgkWjwenQuJGRIdtzbt70W9FWRYtbpSO2k88QNihpW3zRIHgA/meUVNkCub
         5/RQhJkKRRAaVmjOm73xx26zKSVZ4E97SOT6Vz8hb+XCF6kURUr5M63hFoNIncxwSyVu
         iG+w==
X-Forwarded-Encrypted: i=1; AKwUvBwLEkJtLruZ8YYQyXKyqs3qpk47eLr6WV15WM1lDENPHdAcYypYx3mhecbOODP69xA2wbk=@vger.kernel.org
X-Gm-Message-State: AFuF++mYnoa84u4O+Q5vxDGO20u219LTuWewsVuNlQUxqvggz+e04/9P
	2S8DB5LSpNbahH6e6rMc7+NsmpQ8vSS+/bJKqC0eon+UlstHiwsQHf6LuL0tTg==
X-Gm-Gg: AYBFou3m3B7kjZJtVDe9DBJ2Dw9soUyXNVTUrxKkMmiMHLGoHBwIIkJkmTYkVkYzuKx
	oWqG3XWK+ErNGkO++E3NQOwG4mBskLqfUgXYuwvSjP4BsTEKxRgdQTV2Am5M8+IwLOZUoGr2I2t
	+oRa95fnI64kObR4ABrhVNPMtf4QZIbLwJW5pkhEq7CnfbqNoJeLB1vLcbgl8LRiS3D+4RaOBMA
	q4NhzXBfHwvu+oQ+Zvyj0CuNkajyDT408H8mMeb8l1xNdrgN24PelV+ozXVYAnPms1Jz4VCnn7H
	DeTZ119fmTuRarSoh3yVcIg67PXx8IXX4joJzFeZ8wF58E8to9/vz1VLwS8XqHia/bdWY7kEkDw
	wfa5nHANAMI1jDZ1tOtBUS07g4lNNgaZl+4fcsX/UCELT+tbDRkTjW0lvT2eKM6cJ610PwvRwWz
	vY1ijEnpjSG9kxvkrLJQi2wvKjcLf4fNdRpKBWm1KeTausKAYGqzZNQN0YlIoUtOsBUjbSITyWX
	IGG7zndtbWPqCjLGo6Er0oCnYyPA+jTBF9y8hR2pdWtgOpHNz98kw==
X-Received: by 2002:a05:600c:4703:b0:49c:fc6e:a3d7 with SMTP id 5b1f17b1804b1-49e619bfdd3mr5290035e9.22.1789068907524;
        Thu, 10 Sep 2026 12:35:07 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d26c1bfc1sm113867075e9.4.2026.09.10.12.35.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Sep 2026 12:35:07 -0700 (PDT)
Message-ID: <dd99bc04-09e8-4acd-956a-056eeb666702@gmail.com>
Date: Thu, 10 Sep 2026 20:35:06 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [ANNOUNCE] Git Contributor's Summit 2026
To: Taylor Blau <ttaylorr@openai.com>, git@vger.kernel.org
Cc: Scott Chacon <schacon@gmail.com>
References: <aqBRDSkgC4wrUUL4@com-79390>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <aqBRDSkgC4wrUUL4@com-79390>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Taylor

On 08/09/2026 19:16, Taylor Blau wrote:
> Hi everyone,
> 
> With Git Merge coming up next week, here are the details for this year's
> Contributor's Summit:
> 
>    When:  Friday, September 18th, 10am–4pm (UTC+1)
>    Where: Audrey's, Santiago de Alfama, Lisbon (private room)
>    What:  Contributor's Summit
>    Who:   Git (& related projects) contributors[^1]
> 
> (If you're not able to attend in person, but wish to join remotely,
> please let me know off-list. Our room has AV capabilities, and I'll send
> remote attendees the details as we get a bit closer.)

Could you add we to the list of remote attendees please. I'm not 100% 
sure I'll be free to come but it would be handy to have the link if it 
turns out I am free.

Thanks

Phillip
> We'll meet alongside the unconference, with lunch from 1:30–2:45pm. The
> full Git Merge schedule is available here:
> 
>      https://git-merge.com/#Schedule
> 
> As in previous years, we'll use the summit to discuss topics of interest
> to people working on Git. If there's something you'd like to discuss,
> please add it to the topic sheet:
> 
>      https://docs.google.com/spreadsheets/d/1ianyjHMV8EHVfHvwFfNa3SAFu5NIIBLyKyD-pU8LArQ/edit
> 
> Please include your name and a short description, along with any
> relevant details. There's no need to prepare a formal presentation; an
> open question or something you'd like feedback on is plenty.
> 
> We can leave the voting and note-taker columns blank for now. We'll vote
> on and prioritize topics together when we meet.
> 
> Safe travels, and looking forward to seeing folks in Lisbon!
> 
> Thanks,
> Taylor
> 
> [^1]: if you're not sure whether that includes you, please ask!
> 
> 

