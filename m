Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9522226161
	for <git@vger.kernel.org>; Thu, 20 Mar 2025 17:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742493016; cv=none; b=FD+Zav8m1w+gSRMt7Y3eFB+Q1Mnd58yNNA8gORmwVegW8FJkw+Ix6Eg05QsvuLg6WvEMN9uiwQqAceaHdm3h/8yCeuQhuJxHI5bzq2HOJPXLOWc1g12h8PfEo9LolWP5daTbf/5uQUVTJ8bAxzOVGMNqNdZ5qpxblBOwFKSXVsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742493016; c=relaxed/simple;
	bh=JQVkpDjlyfRUJ+c9aDMuEuvkLw26Xua9vvldsnkxS9M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=grajtdYWjhq/zX3xMUUO9f4mkxwSgQ9EKe1WeHGcGxUdnQYFkKrhjGSQwWva75rIWuu1ix4e9E7vDTxU5G7C/YKeDMOgZHgwnk2RtBzDqaIUgaHhzPZjDW58htF9m/w+J3Gt1iTEPlgfTvHZE9RxPDFunZs5CB5+CVJffOmI+1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=no/TMEIv; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="no/TMEIv"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-22403cbb47fso21527385ad.0
        for <git@vger.kernel.org>; Thu, 20 Mar 2025 10:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742493014; x=1743097814; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4P0Y4sCBHBTD4PHVJdJPwDnwG9HHEzwu3BL3cNyK1kQ=;
        b=no/TMEIv5LN/TDqmzLuoLZLRDTJwB10u4KSRKWrGg3YDwqf49fH0bPIku27kzX6Y3n
         +4Y8zV6YxNyYZIVqiYthPS3QLUU+J3JoLCRW4BKc7YaJxhLMj9IPioHvXd8QiOON/S99
         yCP5fgzbA5AUZLj736Rh485bHn7QBodwDLwa/z9k7DiNaSnoRG88710ZNVG/02FLaZ14
         0DzaWrNdC92eSXjtUj5WkTzQ6f/9DVjBbqAo8XcV8eBUwo+Y+1mgGwbBkmiPe9n5iHNb
         jZ5EgQ2nJMe4NZV7vzeo7uUjP8TB0DZzcNH0qfd8hqOHYcLfRscKB0t8IC/ILf/YdtQA
         GlfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742493014; x=1743097814;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4P0Y4sCBHBTD4PHVJdJPwDnwG9HHEzwu3BL3cNyK1kQ=;
        b=OMb0y9+KDkpJ1chhBIl8r4p6Lz+pv0FuaxEJQlGCXySvq7zRazCOTDvqz93T3+dp9p
         6fxFBQ/Xx08S5PRQKFRmmfnQwhDInoflhBO+eBhxZG8Y3AVu0+gTtgLIhJO2vrBJIm7F
         YLbW6W+AYf1/y90rAbgI+GU11abuI0hi8gmEIe/Laz/f94vhJayMvhPNW6mXwaWDZMu8
         cM6kvXnmgUVbipiq/a7nFzgBCzklX8dVSIvy1ol9UXuFVYju6vNfXEvoAukymA21m1lb
         IcnxxvkjA0CIPuhMqMviRH/Mt2JTAQRRcHML9UMROaqMh+m1av37Z7+kphXh6GFp8ED1
         WeuA==
X-Forwarded-Encrypted: i=1; AJvYcCUl00IKG5v+/TmGQTA3RXwlt9HqSbY7bbfwNjqmQU+En2sgvA0tep7qM7jTO8qkmj36uwU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6DE2sEMsA46TzacTwa4CCEBWYN7hUoPc5Drrzfi7BWRcMg4Vp
	Qjg42sqQLNPJWMq6/kE2aoeokf6E4NwtQeL7ZHQ+IUfpjuvkOmao
X-Gm-Gg: ASbGnctFl+7w3uUK1rSNeuMvWb3iTDY3VasSB+3gRTFNMyE6oZHd/UcQe4UHQqpjiLD
	GbaBGsk53aZ/rYfZwRhkt22MFSM+oUzqSKWV6VJ3+aR4Nzl0wBsQbDzJpwycb34ZLHVYBui1U0U
	U+Q56FwCBp9vyRWguc9jBYhotl7uVtyH3VK4mjy+vqwD6/GIiW6yx/rPR9BiwHRJoNkC8js2ihI
	7CKNJx3sKEF0oCuoVn1yyriRbfMyx2Sor42y76yWKtRItzqFsPj4JbEqatvaPFIill8Y6cUm4qQ
	4Jjzul1Dq+OSXlyZF2MEeldBqklF9t2B3VdL96BkVVSjHATWR97xmA==
X-Google-Smtp-Source: AGHT+IEllK/G3ybP6wAKHMDxUADh7ygyiTGSL9x4AkpzIVBxXT+7ap9cCz7+40VaAaWW/2uc9LFfPQ==
X-Received: by 2002:a17:902:ecd2:b0:215:b9a6:5cb9 with SMTP id d9443c01a7336-22780c55304mr4262855ad.5.1742493014118;
        Thu, 20 Mar 2025 10:50:14 -0700 (PDT)
Received: from [192.168.0.7] ([106.51.24.26])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22780f4c4easm775735ad.84.2025.03.20.10.50.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Mar 2025 10:50:13 -0700 (PDT)
Message-ID: <ffefdd01-ec80-4af4-b011-723ad1260f68@gmail.com>
Date: Thu, 20 Mar 2025 23:20:02 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Git in GSoC 2025
To: Karthik Nayak <karthik.188@gmail.com>
Cc: Jialuo She <shejialuo@gmail.com>,
 Ghanshyam Thakkar <shyamthakkar001@gmail.com>,
 Git Mailing List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
 Christian Couder <christian.couder@gmail.com>, Patrick Steinhardt <ps@pks.im>
References: <8c8e8797-8de9-4684-94a0-f6c17a592dc5@gmail.com>
 <Z432QXJb_TfzNBa2@pks.im> <c39c5424-71d0-4b6d-90b1-a6a70f2ee61b@gmail.com>
 <cd90cf17-6113-4634-a774-6df707b73e95@gmail.com>
 <d5cba1a9-fe51-4f3f-970b-3ef8a7a2e459@gmail.com>
 <CAP8UFD0GEmsJDFzVAV1bgBNeD6K3auH4paWEKE6=f0=_E6gifA@mail.gmail.com>
 <a2a76725-5778-4b7d-a266-c3a1431316ce@gmail.com> <Z6Xmrfut7jdsVAfg@pks.im>
 <fa9ad3c6-3b3c-4f3c-89c6-101ed1b51eb6@gmail.com>
 <D7TVXVKVWRS8.S2BJN32QHZ0O@gmail.com>
 <59004310-f270-468d-a248-c83c97de4a1f@gmail.com>
 <CAOLa=ZRM3bLcR3s6nE8nXFv32zX8-mL6fSh1vbsVetJcp9KFhw@mail.gmail.com>
Content-Language: en-US
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
In-Reply-To: <CAOLa=ZRM3bLcR3s6nE8nXFv32zX8-mL6fSh1vbsVetJcp9KFhw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Karthik,

Sorry for the delayed response! I kind of missed to respond unintentionally.

On 07/03/25 15:31, Karthik Nayak wrote:
> 
> I wonder if with Ghanshyam also mentoring, if this statement still
> holds true
> 
>    Note about limit of project selection
> 
>    Kindly note that considering the bandwidth of available mentors, the
>    Git project would only mentor up to 3 contributors this year.
> 
> Maybe we can do 4 projects this year?
> 

While we do have 5 volunteers for mentoring students this year, we only 
have 3 candidates who could play the role of the primary mentor. 
Ghanshyam and Jialuo only prefer to co-mentor as far as I could 
understand. So, that still gives us a limit of 3 projects doesn't it?

Kindly correct me in case I'm missing anything.

--
Sivaraam
