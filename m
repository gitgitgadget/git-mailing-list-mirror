Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BBC9421F1B
	for <git@vger.kernel.org>; Thu,  5 Feb 2026 16:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770307708; cv=none; b=GfgsmOruSIOjGJ3sjOLwE4JElJiHmvbekQrMKFouu0x2LSiQ6eCVIUYQIE4IW3LlNMeCtpE/sScxzmkrZEJbyGhOzjOEvf5tlcckaW7HtYCP8i40DlUgbBxJMg2AzY6nogoRrMH99Gq+WJD3hA3H6lhLHZ7zJ9BRshkYjqLpu58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770307708; c=relaxed/simple;
	bh=i+wNF1vGeCbZ7/yNG5xnfdZRrIY8S/L0lkPilGlo1s8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=lHHcrp3TWqS7N0bnnNoNDSiXLrWtyBGABoXARYl0G3kGFnzYsELb38NrI2fL2Ow7PEib2X1hsYzXRE2U8a5xImr5yfFTKXjjVuDRbOP13wib9VurE9/ddMI17Olom4A7xReM60BXvj3kawD+FEhQysoDbxTJnGKV6VlQ0oO178U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LtaV9Mn9; arc=none smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LtaV9Mn9"
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-42fbc305552so1244584f8f.0
        for <git@vger.kernel.org>; Thu, 05 Feb 2026 08:08:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770307707; x=1770912507; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zRPxu5OgdhOZtP9gq7jRmnKT/O1DVlvAHF0c/6+juEs=;
        b=LtaV9Mn9Z/YwJqA0fgtp+vTXV6nHDPKVdzVc61McyXCm43xUjyR/n05f9Ap8Jh+u6W
         RapZm0wmkj1jzYaafeRN8SHKf/3ruUs3fzu/LdiZqdA3DL47Gz490kTYfpWox+h5EeqG
         aLKQMqJ5zpCLoolM/PRTPsRHIF5DhmsOHIvTaxQxlb9x6IbYtJg0/0Nu+BVBtQtU57eE
         c2Ynb3Zuo3Xe3XZ2AbWo5XAQL7iar5kXstnBzhbu5WLXWvFaYwIeGVY44kh9EV35IUtd
         By0pDXKeyhQReG5zjumTjSOLs3fzL6HvTR0VqRN1DajXTqyO0WiFlFGvvNPQDvD6Yn+Y
         2fLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770307707; x=1770912507;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zRPxu5OgdhOZtP9gq7jRmnKT/O1DVlvAHF0c/6+juEs=;
        b=MdWeBnlkGzxvuDKPiy8kpk9KU1kkW1O6UVBfpj/NP60rIixbjAwanw4FBjTKLglfOG
         iky7uYLBcwgJD01IzIMc/1GEDE+2P6m+JetKZwHm5xvNwG1bvdVMOh3rjo2U9gTGI3at
         kiv9HpeiH0Z5snTzOPHU0ZoKNEpFiIPFJewCFwRIFHTqaDW8A6tdneS9oaeX29/NH11R
         RbgL3b9yiM3Bsv3Bf+s0SDyEwDCcDtDPTkRRVQem3NemLpBefZbpTdGbTW/kdg7mdP6z
         IjLjjFh26Jl1HGFxItXB6LECXle1MwGHU228XsvNX5cFcl0pNZ5aOK61s0TLSi+DTs15
         +AeQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjnZr/dDof19km8PNiIWlDJrSsd6Wc4F8NAxcaQXrMSV35YAk5ovfm69tMJr38KBwns6M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjvAe0ysGKoAbQ8rUekJ/anu6U856Te2la31HNCEc2V8+pqfLl
	poqd4a3RyMcEBafGL/C9iNoMCK50o1L8gmx5iBfuHFHzrme8BF+K+HJd
X-Gm-Gg: AZuq6aJISmnfDPKEUpxaWIv8qi5aAMFghXkw43X3TvRzb4p8UX0iWLS2eMUylEV8mDg
	jb13DrBv7JHnb6GZQoUMlb3XWYPYKuucWfMXfK5sofOueqcxv7N37m4Z7QrIxj1ePP1xIco9C3d
	dSN1LozrjKzX6aXYgm5zgPBIjCS9PmWHEGmh+bp3ikZnI4cS0NrsMXcFF9cV6Dbpy4a/0pw5Mxl
	FZn9mbeNMAbybPhy7loj111HTrI/ibzxlGmQLXBovMK6tuUyZVR8a5Ec71/j74iikyHTqbmhGNI
	alK1uULlmSYUo7iGdrtTv1XmUm3loCUcU0VcYPF2VoOoEx0bBNuD4JN/LDkQEfqLzhXQ6b2ANj3
	ypRTZcqkJPJLxWQ1Yl4FutB1tx/FEUc3OaH9WANUTN3rIvzuzIzomFo2dGbD0B4S3Y93hSWJFA+
	wMlYvDvg9MSxYz4XcORNv3eMaYPtoIXJbxaAqoX9o+ulTVCAbPcG2m6aUcQSchY60AUAagFVJFb
	lSo
X-Received: by 2002:a05:6000:2909:b0:430:ff81:2961 with SMTP id ffacd0b85a97d-4361805d057mr11296375f8f.51.1770307706499;
        Thu, 05 Feb 2026 08:08:26 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5? ([2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-436180588bfsm15088190f8f.26.2026.02.05.08.08.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Feb 2026 08:08:26 -0800 (PST)
Message-ID: <c1349ba0-656f-43c0-a451-14a97dd158b8@gmail.com>
Date: Thu, 5 Feb 2026 16:08:25 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH V2 1/3] wt-status: replace uses of the_repository with
 local repository instances
Reply-To: phillip.wood@dunelm.org.uk
To: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>, git@vger.kernel.org
Cc: gitster@pobox.com, karthik.188@gmail.com
References: <CAOLa=ZTFUZF_8YFk=TkMXVYptP6q9_bJRUoBYYsjCMW02NKc7w@mail.gmail.com>
 <20260205121839.38752-1-shreyanshpaliwalcmsmn@gmail.com>
Content-Language: en-US
In-Reply-To: <20260205121839.38752-1-shreyanshpaliwalcmsmn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 05/02/2026 12:18, Shreyansh Paliwal wrote:
>>
>> One question, did you run the entire test suite with these changes? I
>> would hope that we have tests which would fail if my inference is
>> correct. If not, there's a gap in our tests too.
> 
> You’re right, I hadn’t run the tests initially, as I assumed
> this was a refactor-only change.

The whole point of regression tests is to check that refactors do not 
change the behavior. If you have an account on github or gitlab there 
are some instructions for setting the up the CI to run when you push in 
Documentation/SumbittingPatches.

Thanks

Phillip

> 
> After running the tests, I do see failures, which confirms the issue.
> I’ll make sure to always run the tests before sending a patch going
> forward.
> 
> Thanks for pointing this out :)
> 

