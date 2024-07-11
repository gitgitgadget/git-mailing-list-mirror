Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0B2155CBA
	for <git@vger.kernel.org>; Thu, 11 Jul 2024 10:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720692338; cv=none; b=sh1zFnm6hs7k4Yzy+PaH4sGBRuW8CKvsvCQrHRQiD9ts9dg95grTd3RkGG/mer8Kd7F1YluLDnI//A2BXGSfNc/rd0cTc+hzDVcH8oo+l3ROo5FmINxnwVmmNEITtDFPnE66HgfQSFrL02OSv7KgCZSdjA0e9txLOZ8esCGIfTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720692338; c=relaxed/simple;
	bh=z3RmxZZaVsvjiQD10UELJMKebO46EIintnelxlgcK0A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PuI3vudIPQy/vtgQSLK00KOl80yLK4YM8mqAfqv/ZhxPX1bBmTI/t4eLwXh2/zc7hovMC/m3oXpMjbWp2CQGSsZZLiShMg3wWCrPdsjo/5DH53doX9hy3DvVdNb2D6oQyXpwQgvGvZT45Mn701cwmjbnAuSpXUv7JQ8ZtzJI7yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OSgQMPzN; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OSgQMPzN"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-426685732dcso4551935e9.1
        for <git@vger.kernel.org>; Thu, 11 Jul 2024 03:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720692336; x=1721297136; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wzk+anBmpIO4Ov1IVDmQoKJXfQbUmRANDPpRic4zhY4=;
        b=OSgQMPzNcfvBrcj61hzHlDxGUjDJZF2jVSg77tso4HGnoD/2GhrTesdV02GIlTMXya
         Tb7mPVPh1XGGqngb7TY/U6+0YYUCJop3AqzBxzt10MJT/hSy6qpbPoC2h3mR0CvxAfSV
         If68zACHSJgTh170PTGdTKqrS1A9LjEh2Wbed7zTKzR8Ns9u/g2Zl/XpkSXSmp+vmmIT
         fvBzZ54peLfEajSLnLNUpPfL+4/+60cKOi9Ze+vi23HPelMXQnJckBlRbyRoXtazulli
         s3G9cWg2UAKwE4KJansm+mFiHsJY8z7RVDAtp6X+DqEMKn+DtT9GSxOxAjeAYaEt9PUQ
         CTgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720692336; x=1721297136;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wzk+anBmpIO4Ov1IVDmQoKJXfQbUmRANDPpRic4zhY4=;
        b=CcdupLYfQXB/YMTXPLWsreA+BJH9gqqsDTrlY8KNyGSVTObhKNQHWuXsVAljRlrnFQ
         a/EYvVXvaarqlIUo7qkOXGiNWS6OmNfzE4tUWFDDbazA7hEwFN8oUbAiqqM7JMxgfkAu
         CHr6E9cs9QfaLU5ytDVWAlu0HXkuoMmeYVjyiZ7DK+sTzu6j3MuGGQynRk1PML1B4jMm
         aJ0ncbVMqOW15ABYDO80SCxsEvG0puy2K5DHItg/8tjfXmaSlRH7O5JpmLB+LnK8NMse
         aAHq2ifBqjwEUo6BRKyj+onxArfko24C5s0YsPa2hfvu6yOctfMrP6bII1ZJ1JWN5qSd
         V0HQ==
X-Forwarded-Encrypted: i=1; AJvYcCXu+ryA7hu5XY1MC0B/ZBT1QhOiRzM75hqLuOtURupl81CeBmddKMSdn6IsjQ/JiaCyUKdyFpL1/DiZcW8coCgLM+Au
X-Gm-Message-State: AOJu0YzwdgvBkKA61ymeT7baGTy7HKRn06gmiRfub/JOUqIY8ePZBzXT
	nHedRKK/GDxLQHWdhUEqcttccEppTLDhRLLXMkOkla+Rt1N2BnMD
X-Google-Smtp-Source: AGHT+IHqOPMpBGfB0yaG3rwlWm9Cje7eU/mvJ7JPnPkIxmxxQqso6ctmR/iudcHxTYrcw1cZD/W6Og==
X-Received: by 2002:a05:600c:2184:b0:426:61e8:fb35 with SMTP id 5b1f17b1804b1-426707cc03dmr56208275e9.4.1720692335494;
        Thu, 11 Jul 2024 03:05:35 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:600:8501:d2c6:37ff:fef6:7b1? ([2a0a:ef40:600:8501:d2c6:37ff:fef6:7b1])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-367cdfa0650sm7365835f8f.69.2024.07.11.03.05.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jul 2024 03:05:35 -0700 (PDT)
Message-ID: <38c962cd-2691-4664-b262-6eb78b8a61b5@gmail.com>
Date: Thu, 11 Jul 2024 11:05:34 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 0/6] unit-tests: add and use TEST_RUN to simplify tests
To: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Cc: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
 Phillip Wood <phillip.wood@dunelm.org.uk>,
 Josh Steadmon <steadmon@google.com>
References: <85b6b8a9-ee5f-42ab-bcbc-49976b30ef33@web.de>
 <xmqqy168uc8i.fsf@gitster.g>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <xmqqy168uc8i.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/07/2024 23:13, Junio C Hamano wrote:
> René Scharfe <l.s.r@web.de> writes:
>
> So, looking back the discussion list on
> 
>    https://lore.kernel.org/git/85b6b8a9-ee5f-42ab-bcbc-49976b30ef33@web.de/
> 
> any loose ends still need to be addressed?  I didn't spot any
> myself, so I am willing to merge it to 'next' soonish, but please
> stop me if there were something I missed.

I thought René was planning a re-roll to avoid using xstrfmt() in Patch 
2 c.f <97390954-49bc-48c4-bab1-95be10717aca@web.de>. Also I'm not sure 
we've reached a conclusion on whether to include the "if" in the macro 
or require the user to write "if(TEST_RUN(...))". My impression is that 
there is a consensus building around having the macro include the "if" 
but we haven't decided what to call it c.f. 
<62d221cc-532a-4a6d-8e96-b5a246ddeb1b@web.de>

Best Wishes

Phillip

