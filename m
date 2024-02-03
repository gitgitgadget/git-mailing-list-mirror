Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C5541744
	for <git@vger.kernel.org>; Sat,  3 Feb 2024 11:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706960495; cv=none; b=Qv/cl9H3sZiyaXZwCICWSrsHG4nfn4F20vyxpBMmHL/t1GUgJzH9ttZhX3j9qIYDeoD7cxswNMavJKE6xfXzUOpJBktaSe7nqS6j/nqelFa5rE+K+x+CIFlITNDXIlV6y9JCPs6mISVN94d8FAv8BG2abUwAkTSwRAGWsqXlxo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706960495; c=relaxed/simple;
	bh=+OExbHyltULrtLgWBocNSH6YorR6+nwZuTdvBAHCwuo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HdvEtxXLBwii+zFdwfoshMn63KtdJ5LuPitlT0WdPESGGG6hzoDCpC+LQ/4JmIjDBIduwD1hcHwVmV4/ngZgPgq3b592F56IKDlNYxR9BLQpbw/7wftwZR+Ao4FPMGyEuw6RMZJ/2tJaFbakvlhwm2eKhASHdgTLHiRoWZuclwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VmmoBUx4; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VmmoBUx4"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6ddc268ce2bso1805503b3a.0
        for <git@vger.kernel.org>; Sat, 03 Feb 2024 03:41:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706960493; x=1707565293; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nuSd6S3waz4WVOKKwl9UTAHnXhMpvafl5IJ6BiwaKJI=;
        b=VmmoBUx4+pcGjrpXmmu/DdoTbBHnJZ7Mbb6+C0H44qay9IarCLdahTMzdW8Cvss1Se
         hDkumbHPIGEQClwp9VljFtYqNS6Io2Rycv+KQ52+o52B/AuS2IaVnC51hsIA9UvQ/khS
         XsFri6C8vnEFDEdwGL83q5Um5Gt9bHLY9xGgOb8vn9UnFlMYX+JG4Wa6l8Jq8Z679tPG
         jX1qgjLO0IyKLL6U9d8CS9DhgCwjHvZxJAtqp9KxyZHA4605TpDFzF/dEOHvinkSETbT
         O4PEBOTlLNU50aWUvJB4+jgsyeN6KmSQJN5DTu9PZUVJDl3Ul2j5saxlwLy/wCNSa9Uq
         mMgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706960493; x=1707565293;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nuSd6S3waz4WVOKKwl9UTAHnXhMpvafl5IJ6BiwaKJI=;
        b=kEXS6Y4Sjhef2L11Tc6J71hiBTqcFuZvS2T/DA63waJ/IR0v5xt8/6C6TYOCWSE158
         rtPB0dwqaorRxAJ27yHHT6f+eCvYkiBPyO/gfvCEoDkf8zGmBikRXJJ2ygNSafobPF7Q
         ziF60yHDlGBwnY2HHZOGjI5Ap4D8LMh0DixbWVw+iBYetOlDQ718kubcQSsUoqDVyIdp
         KyLiuR2HsTBGt0Ps+tTuiahm7iFzLSFiTGqg2NnAi4qYWBCB811JFPpGKzOTzd3Lh012
         kZgqwBFv4JLRG2J8K1FrkteTVIZLgDmR5ppxZG1iPznJCQHRuPoRx0D3w8DxP23hu5vx
         5l4w==
X-Gm-Message-State: AOJu0YynX4Z53otEzPwIIVEcNY2X2jCZojcV+CX3Pt78XsyJ3mavtQn4
	+1SWZOhskh7qmJMgaakDa11DSCeFrWgKOEeeJuuZSAOiEVHqB2s1
X-Google-Smtp-Source: AGHT+IEKYgfHiw3Qg2ucqYp8DmWIMAyuKoHvlJA5bvq2Npwx0q81U4XUCKjsxWI4SpGlK8JY3KNruw==
X-Received: by 2002:a05:6a00:11d6:b0:6d9:aa18:291c with SMTP id a22-20020a056a0011d600b006d9aa18291cmr8812017pfu.8.1706960492922;
        Sat, 03 Feb 2024 03:41:32 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXeVn34+OifBcEb7DiFeWDLCWHeKtKq/4iU2n1t3v3DTjGubBx8zxsUXXibbbgXU0DbMsxcW3OOj+XJ2qRg+Pcoyr9ro8wNzVoxXozq6lPi1uJfsSYZwKkIHPJ8tYGc4moydt6jmDaJDbRFn45fZpN89b3GX0I2GU9cnQ0HXBoKNI3FKu7zwZL5f/MUgW7BbD7cL6FnHg8=
Received: from [192.168.208.87] ([106.51.151.68])
        by smtp.gmail.com with ESMTPSA id c26-20020aa7881a000000b006d9be753ac7sm3216915pfo.108.2024.02.03.03.41.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 Feb 2024 03:41:32 -0800 (PST)
Message-ID: <d4797f27-825b-4e2b-85a6-cc30f33934e3@gmail.com>
Date: Sat, 3 Feb 2024 17:11:28 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Git in GSoC 2024
To: Patrick Steinhardt <ps@pks.im>,
 Christian Couder <christian.couder@gmail.com>
Cc: git <git@vger.kernel.org>, Taylor Blau <me@ttaylorr.com>,
 Junio C Hamano <gitster@pobox.com>, Victoria Dye <vdye@github.com>,
 Karthik Nayak <karthik.188@gmail.com>
References: <1de82b27-116a-450e-98c0-52eb65a8f608@gmail.com>
 <CAP8UFD1VAvnkM6afZvtpdXhA4csDBDwMnF9yUzSx_ut-Ypf+eA@mail.gmail.com>
 <Zbi8pfvGpYrlZXAu@tanuki> <ZbpGzAd6FGEeTdrh@tanuki>
 <c61322de-8cd9-42b8-a04b-a8ae47b25c5e@gmail.com> <Zbtmoo8qTmj-yt99@tanuki>
Content-Language: en-US
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
In-Reply-To: <Zbtmoo8qTmj-yt99@tanuki>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Patrick, Karthik and Christian,

For the note, other project ideas and volunteer are always welcome. So, 
feel free to chime in if you have any ideas or wish to volunteer as a 
mentor to guide potential future contributors of the community. :-)

On 01/02/24 15:08, Patrick Steinhardt wrote:
> On Wed, Jan 31, 2024 at 11:27:13PM +0530, Kaartic Sivaraam wrote:
>>
>> I created a fairly rough SoC ideas page for now including a barebones
>> information about the unit test migration idea:
>>
>> https://git.github.io/SoC-2024-Ideas/
>>
>> Note well that the existing idea's description is far from complete and I
>> mostly just cooked it up to serve as a template for how the idea entry could
>> look like. Kindly contribute towards elaborating the same :-)
>>
>> Also, feel free to suggest ideas you have around refs and reftable backed,
>> Patrick. Those would be helpful.
> 
> I'll have a the beginning of next week and will think about topics
> meanwhile.
>

Thanks, Patrick! It would be great if you could share the same as soon 
as possible. The deadline for applying to GSoC is Feb 6 (18:00 UTC) and 
we need the ideas page to be decent enough before we go ahead with 
applying for this year.

If the elaborate project description could take time, feel free to share 
a paragraph or two that are supplemented with a few references. That 
should be sufficient for applying to GSoC.

Christian,

It would be great if you could look into and improve the detail for the 
unit test migration idea. I just added a very terse description based on 
what I could get my hands on. If you think the description we used for 
the Outreachy round would do, kindly update the page with the same or 
kindly share it here so that I could update the same in the ideas page :-)

> 
> Yeah, as long as there is a co-mentor that can take over during my
> absence I'm happy to do it. Karthik said that he'd be willing to cover
> me, which I think would be a good fit given that he's already got quite
> a bit of exposure to the reftable backend internally at GitLab. Thanks!
> 

Sounds good. Thank you for volunteering to co-mentor, Karthik!

-- 
Sivaraam
