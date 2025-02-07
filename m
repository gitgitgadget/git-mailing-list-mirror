Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B06C19047F
	for <git@vger.kernel.org>; Fri,  7 Feb 2025 07:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738913573; cv=none; b=ctVPIAhCJSm0yuNzb7PdcWnCJ+1esf0HKN3ws3Htw7FJrsOM7jSEWJPGi0J8lBPL5D9DBCvERHl1lJDTuUNUyqi5P5E5u0Gtf8IH/JU/jsy805G/D8AtVcr7ntF8myDDZ8stgUbRefHkueQ0anw7/Zi7TLsvKDZknX+vsEYGFx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738913573; c=relaxed/simple;
	bh=ngDWrsDEOw6iVtTy6v8PeaG0QqNS9CLvgCLIQ3VzcXc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TH0oNq/6sqarztEkiSl8/zCo9PwfVLxD0vvaDJawUmB1BCFtCWkKzUnWVpspIOnURdADdtyNwAVK04JQYklnw9lEIBL2dCq8n5hO2/aL8TdsQTvwybEDn9T15E7xMn2oZsUmeu2cVccYOymBkyvVYxW2lGTtguJNZcxAJqgi33E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E72+IBZN; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E72+IBZN"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-21f3c119fe6so33942225ad.0
        for <git@vger.kernel.org>; Thu, 06 Feb 2025 23:32:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738913571; x=1739518371; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SuVzvLq8H8SDzIYf2kkFvBBm1ZdJPm9Et23HvotV5TY=;
        b=E72+IBZN66qHyTvNPL3xGLDJFihisJzaTbYTGVkb4qprGY2OGOSjpwQRq6LdsovTYP
         1E9O5BILCvHGpGboD7Qiq0LMcGyfZdReOTTMaziihDCdCG15WjjdJFUwSJIK4O0Vx09c
         mWKsXaTElZYKQe2pufAuqbPK8rKA5CSy0Szz9JqnmOZLudiSRmY4CTdVIPw604E92Arh
         sjfaAJeY8nFv78UQ3EU2P/bDd0khBMU02eLUwu33l9ZUcN/0lKXFNe8Zkt3ihIe5KskL
         yCcq2kmwjZ2MJSgDkh58o+ftXDvru8n2DLVDIPyF2rfo/kyVNg6z76wCy3cDIp6UpAeR
         vuzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738913571; x=1739518371;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SuVzvLq8H8SDzIYf2kkFvBBm1ZdJPm9Et23HvotV5TY=;
        b=eICyH8ajijsM1qc6Ct4UltBb3r5ruuWuy9IjkmSZ1NqJapsS7YoMSFtpXJZWezNS/+
         3AfYhzU7mQpxzkrITmH9EuVOBHhFinYZ5KsOEFMYdxaJluam+3/910rQjaDrNLoyAqfI
         8NInlbW3L+ajkxQQU6TIajUD2dqO+4yb2DSktikZCDihwAoLX5d8oCapHBiygQOlAtho
         yFwiybyfpp2uEuzPwdRi9WIDWQWHWFoSZghJHmOC3rL0cM7Z+EHsZRqiOf5X7ZAfLp7Y
         EMfVnitLpZge83BANgzHlXluFC3ppG4wiEk5dc0l1bIdwRei51ht+RTpZXII2jYQ0CvE
         RwAw==
X-Forwarded-Encrypted: i=1; AJvYcCUkvxsIY0TcpVjvv66WKLpV7TLDe08rN0Wsv+jN53XaOrXQCD208H5Z5VahtBeJT6V2h9o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXF7wqWiGvxKjQXs3cuQIGsbcNcy2BjWRiJSAjDM8ImfW7jHHe
	pZeQrlNtQMthARjPBX7AlG1A6X6xJ2TeuZvHeVEMj6q4qTJd7NzW
X-Gm-Gg: ASbGncsy0ag+ZgSDl1O7nAhQpqiOZW2biMp0IGLFtJJIPKD4aIUd26D4S3UxwvqHhfM
	o1Xo65TnlM7rtXwj5NxsQLC3Lx+2/IGzXBnEp7pfm/iZ0qvI+bOI1+0xYzqNjcwZI8ZkQqgZ0oU
	bw+pXakrkEBkkaIT4xrL1DE/Z3MMO9KlHGpXAkeNk+H2cgfiQyLCBEBut7UL06pkOheGL/FJvsI
	Nsn87lC1094TRY2fV07ZBrms7lWAPT25Et3sS941BzWJvy1h1ZZUbN4sHsvZGJs435qHjq6ba/k
	5Nc3FPIz2iHJKhYXiymliW98GH94
X-Google-Smtp-Source: AGHT+IHR11tvQoRYx5Pk3UzsLf4ldL3UEQ81LIqcCCD2EAdkEnRBbpq+1qTphza0lFjY6HU/IVcojg==
X-Received: by 2002:a05:6a20:cf83:b0:1e1:9fef:e960 with SMTP id adf61e73a8af0-1ee03a24b89mr4375435637.6.1738913571276;
        Thu, 06 Feb 2025 23:32:51 -0800 (PST)
Received: from [192.168.1.106] ([59.92.193.252])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73048ad25e0sm2464862b3a.54.2025.02.06.23.32.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Feb 2025 23:32:50 -0800 (PST)
Message-ID: <a2a76725-5778-4b7d-a266-c3a1431316ce@gmail.com>
Date: Fri, 7 Feb 2025 13:02:25 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Git in GSoC 2025
To: Christian Couder <christian.couder@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
 Jialuo She <shejialuo@gmail.com>, Git Mailing List <git@vger.kernel.org>,
 Junio C Hamano <gitster@pobox.com>
References: <8c8e8797-8de9-4684-94a0-f6c17a592dc5@gmail.com>
 <Z432QXJb_TfzNBa2@pks.im> <c39c5424-71d0-4b6d-90b1-a6a70f2ee61b@gmail.com>
 <cd90cf17-6113-4634-a774-6df707b73e95@gmail.com>
 <d5cba1a9-fe51-4f3f-970b-3ef8a7a2e459@gmail.com>
 <CAP8UFD0GEmsJDFzVAV1bgBNeD6K3auH4paWEKE6=f0=_E6gifA@mail.gmail.com>
Content-Language: en-US
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
In-Reply-To: <CAP8UFD0GEmsJDFzVAV1bgBNeD6K3auH4paWEKE6=f0=_E6gifA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Christian, Karthik, Patrick, Jialuo and all,

On 05/02/25 18:50, Christian Couder wrote:
> Hi Kaartic and all,
> 
> On Tue, Feb 4, 2025 at 7:33 PM Kaartic Sivaraam
> <kaartic.sivaraam@gmail.com> wrote:
> 
> I have just added myself as a possible mentor. If possible I'd like to
> just co-mentor this project and someone else to be the main mentor for
> this project.
> 
 > ...
> 
> I have just added myself as a possible mentor. If possible I'd like to
> be the main mentor for this project.
> 

Thank you for adding yourself as a potential mentor!

With this, it seems to me like we could at the max. accept 3 students

>> Note that I haven't assigned any mentors / co-mentors for each project.
>> I suppose we could assign that based on the applications we receive and
>> the ideas that we end up selecting.
>>
>> Based on Christian's inputs, we should be able to distribute
>> projects among mentors well.
> 
> Yeah, I hope it will be possible to distribute projects among mentors well.
>

Indeed. From all of your inputs I was able to come to the following
allocation of mentor / co-mentor.

-- 8< --

Consolidate ref-related functionality into git-refs

- Mentor: Patrick
- Co-mentor: Jialuo / Christian

Refactoring in order to reduce Git’s global state

- Mentor: Christian
- Co-mentor: Karthik / Jialuo

Machine-Readable Repository Information Query Tool

- Mentor: Karthik
- Co-mentor: Patrick

Implement support for reftables in “dumb” HTTP transport

- Mentor: Patrick
- Co-mentor: Karthik

-- >8 --

Let me know if this sounds fine to all of you. So, I suppose we could
pick a maximum of 3 projects but we cannot pick both "Consolidate
ref-related functionality into git-refs" and "Implement support
for reftables in “dumb” HTTP transport" at the same time as Patrick
only prefers to be mentor in one project.

Based on this, I'll tweak the ideas page to mention that we could
pick a max of 3 candidates.


BTW, I've just submitted Git's application for GSoC. We should know
by February 26 about the selection result.

--
Sivaraam
