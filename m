Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C001DED56
	for <git@vger.kernel.org>; Fri,  2 May 2025 05:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746164288; cv=none; b=Z8ymVzvdNPlGh7h7UdJ4Mt3aNErI9O9NtKvHPaeSUTmkEpyEbpsSvfmw0n7LikGF01lI8REZliR/6CtQsgkSFLUyKRK8wtrzUcivhsYTiK9HjlLm+YZ9+6YJyRqeu3zNKfx0XzEf1lXacvcwFpwckdE14altQGfaACgD4PqkRkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746164288; c=relaxed/simple;
	bh=FiM7AvMhziG7gyiKjUYW3hQGds9jUKhe7FtFX6LiYA0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=a78Es42CWgQJ6F5FW7QlHIbWJVqPYgC6+5Ygp5S5UEHvmAEFTFe7KPheOnhVCkAxgZ7sQmtSPivpexSHmOW2pDiBY1f04r1WYK9RoKFgO8rRo4ZgRQqhif3IIaJt7HE4o+RV6XspD0H26bn4HkiONIA0TvuNDqo40meCI1JBq6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=diGY7G15; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="diGY7G15"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b170c99aa49so1092537a12.1
        for <git@vger.kernel.org>; Thu, 01 May 2025 22:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746164286; x=1746769086; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=A9LqXkR7yoW3lvehde4Drkq02cMqYrhBl1aefKjMmzE=;
        b=diGY7G152Nl65mMrynGFGy1c5kNEqXhxtoTAkTTkcypAeGL7Fos+ESRxUnwsx+MNzQ
         arvMlS5Y7zJeXEOY782zBU3Vs1FSrMxREjmYtnzlm6K2HxY5yhWBrFPL30kaWhRSabit
         MQyn5nwyggcuBwmdCI7pyK9VdXUanblBU4HS0XXlfNnCHOrBTHWf9jR0qh821ef0kWm1
         Tc1ARCZFPZ+2VizXdFF4KEAxN2edOSK3Em3hjI0Kh2u7oCgYkGWVS5V+h50o41qtgP1A
         NCasm7gD9GIzl8WJu8gD4QUPrB+RdxrgjggoNmz8AV+W91knXEi760N0j3apsPyGR0mt
         44QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746164286; x=1746769086;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A9LqXkR7yoW3lvehde4Drkq02cMqYrhBl1aefKjMmzE=;
        b=fSafEfUwtlyhcjPw1GO9QbCI9ptcgr1dSgwIsqdOCVJDD+O0tWHCVUYrzwHOpfC9QE
         U3eLNp6xQmTcSFLihG3PtUjgzDQPdOT5b1ZRymG+6MpK6dtsFiccwo/pZZ78df8IAw3T
         9hjgzYYu8Vlvt8q4vbSnJZzIek2kKUjSdWg9emUJ+8vaXjbvERoK34JaW3839E5TgTsj
         eZSh1uTMV8e+RJHU1ZcrU4XHa0V889g6tEg10mITcy6Mvbv+Rkj0IRK7MsqP/HweT1Y3
         2F5YGoUV7WEPKveeDIIpxgcK7R2reRseR4/wolacJy7uQrs1CSkBpkAGqGb8sleFFAgX
         gnGw==
X-Gm-Message-State: AOJu0YwdHn3TjYm0WJk/c33RWpJKe9enMgwCwMKvn+7UQEHoK/+t3bwn
	SSP/+knLdB4NRLt89UW3M0dwwneidYi9bJYi4NQJldKi40sUBCL7
X-Gm-Gg: ASbGnctCqPF83ZRpNmkxbUN6dbsLhKGNOmZzIc38uJsv+o56qWE7eo4vNo5mWmeA6Rr
	D+TKTe3cKPB4t+sq6nuspH1dwFhoPIPei3H+YvpouuhGNP6uRoe31zVOQFEijNgaitvQz0EHbYG
	kYsn3HPO9B6a1un2T4MjUKaoF2ScR99s84SzDfCoLurmR3BCl2rEWn5uph+x2rJC+l3+H4zOnNe
	7JOcYrZ60GMrmrcnVHWJkejcxlUlxcXrVUtumK2kWLmmKXOujobprCM4qDVKHJWa8DTea6XSH3O
	10Mo9+wOb/Dz6eVJ9qb5tLZodgFgv3FTY2yoUYbkXFsvuND+HWTBmMUm2lFP0qgRnsAJYs29yo2
	CqrYS7tlv2snDZ6tnoCfqgcwA
X-Google-Smtp-Source: AGHT+IGKMi2Wb5v5SHRLLwSMjKGHLJbmO0U624IBgfFDhcuxz3Li23qFAHABdYLGG3y+JJZ8Sg/V6g==
X-Received: by 2002:a17:902:f745:b0:224:78e:4ebe with SMTP id d9443c01a7336-22e1033c82cmr29108545ad.33.1746164285774;
        Thu, 01 May 2025 22:38:05 -0700 (PDT)
Received: from ?IPV6:2401:4900:263d:5de5:447a:38aa:3207:4f89? ([2401:4900:263d:5de5:447a:38aa:3207:4f89])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e1084da3esm5949225ad.6.2025.05.01.22.38.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 May 2025 22:38:05 -0700 (PDT)
Message-ID: <b37ce020-a3f8-4666-ae7a-99301a175a9a@gmail.com>
Date: Fri, 2 May 2025 11:07:57 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Collaborative community interview for Git's 20th anniversary
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To: Elijah Newren <newren@gmail.com>,
 Luca Milanesio <luca.milanesio@gmail.com>,
 Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: Git Mailing List <git@vger.kernel.org>, Junio C Hamano
 <gitster@pobox.com>, Christian Couder <christian.couder@gmail.com>,
 Markus Jansen <mja@jansen-preisler.de>, =?UTF-8?Q?Jakub_Nar=C4=99bski?=
 <jnareb@gmail.com>
References: <85ea4aa0-c595-4f0b-a2ac-d0113aca464a@gmail.com>
 <CABPp-BH2yH4iJ28Bo7Q=uryu68LLk7a0Tvb2SzAbAiHK8QpRug@mail.gmail.com>
 <e41dd273-faa8-4b23-bbf6-dc7b0d512f08@gmail.com>
Content-Language: en-US
In-Reply-To: <e41dd273-faa8-4b23-bbf6-dc7b0d512f08@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Excuse the noise. Include Luca and Lucas in the thread.

On 02/05/25 11:05, Kaartic Sivaraam wrote:
> Hi Luca, Lucas and Elijah,
> 
> Thank you very much for your interesting and detailed answers! Apologies 
> for the delay in getting back to you on this. I've finally curated your 
> answers into this month's draft. You can check the same here:
> 
> 
> https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-122.md#community-interview
> 
> Kindly let me know in case of any corrections.
> 
> Thank you again for taking the time to give us your answers for this 
> anniversary special edition :-)
> 
> Lucas,
> 
>> PS: can I share your questions in local Git communities?
> 
> I know its a bit too late to answer this. But feel free to do so if you 
> still want to. We can possibly include interesting responses in the next 
> edition :-)
> 
> -- 
> Sivaraam for the Git Rev News team.
