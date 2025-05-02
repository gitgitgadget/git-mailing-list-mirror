Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9973433987
	for <git@vger.kernel.org>; Fri,  2 May 2025 14:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746196787; cv=none; b=BdqjhU72KnXRf47d9XQkomlA34xtv6az6fTuI5SHmQJwPxP4NYIztymq2J8/DyrZqmSszt3zdIeUQP+IqiSqPgsKDrjf2JyBiCzsxQY0zBbTyrwyAsc65IE4+aMYjDRe1O1EwNN2U4Y2Cj4GppN0oyzKFZYVk93HRsq2+8vmEwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746196787; c=relaxed/simple;
	bh=TY3kZIdGcz4kp2yOqHXI1bVhfNAf+qKNdNE5/epm0Hs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=Vw873JPtnlykkL1HcKduRTkxIstyfJ3qotvxXwtl7Q7UmMgBFo2jOwEJrdZEkvtFDeMxZc7csU7W2397BYLF7RP1lRBV5I4/3layFgP98SNEL/uXgksg6wsFmiy5+Paq9pKEeQA+WO+sIu7kuKyG1SzMFZqGnMDnVqDSJ7WnU34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CZBGxi8g; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CZBGxi8g"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43cfe63c592so19410895e9.2
        for <git@vger.kernel.org>; Fri, 02 May 2025 07:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746196784; x=1746801584; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=I05T4TrGD1wkMRka8dbN/z2EbqpSme+pYyFqwiRitTM=;
        b=CZBGxi8gB3z7mf3AyHKsiqFhGOZPkrpsxqPyZ5ilHoUR3+I5E1Ods00gcOEZjYnJxK
         7Ky8q7fiP90ToOMo2CAUkOhPxhuEVRRg2Rj90H15JDCjyFQqPwjvZ1y6XXrKqbNfSoN7
         du/qOA2+tStzKIJ5U7Pn7+pFCvKgLrMp37Q3UE2DpKFEWWLzp0GEDrpQRXhVnUDv34qk
         Aqk4bPrDy4gKdsISBUgJRUrlbCT6thXFQA6pFWqI6t/aMJH9sWqLihnhQnAepnFbG8sC
         npCyPXgk2T2J3GkkpxbAShNhtAPRHiyvOVt3HGohWqR+b9uw4DRD4rBRhb0gGN0MFGzR
         VB5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746196784; x=1746801584;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I05T4TrGD1wkMRka8dbN/z2EbqpSme+pYyFqwiRitTM=;
        b=kzv3FVBCQ0X+g3DKHOQEA09Q/Czu/eyd81XKdgHnTkaY7YKApTGb5Q1OnFPIy7jnr4
         eUIhu4g6t8rXC5XEPzs5Z/TyODlPZ1BoQohb4p8PY18ZuwfZB4px+II9RaOloYtpsNiT
         dOX3z5EbKM1DsNHIlwh0e+TD2jOCKIsTl0G7gVZo4/WuE0la302VL2IUyvEqe2ugMWLW
         2ih61L97Xbf6aUQOO/pUEcOzgniIO+quxyjPYLNGXcFClIDCEqMBiMrOeGeHSyyAi1Z3
         X9/1uVtZ5HLxQErtdjzh2AkSq/qs6uM8BbnHmydpzcaCvgNl5XYu7VdZFm9DW6JAJ1b9
         o2tQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVZeFXYZd0X+1gQJxWSMiw4aY+YweHdtFsGmmGbbsBH0Lb7XYCEe4PJ4S8AF+Ny28qkWU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCacPvSdj34rCecbBnq3DB4pOTCmi5vHaq/KozMEhPYe9FJnp4
	UkzS528dO6ggORRzGafxVx+rC6bY/cmEgKyAadBgSjjvBBNtpMuVs9z/rQ==
X-Gm-Gg: ASbGncu29ugft5aB63icLnwE1GXw480A6lABfYx6FWzT2FnKoYDCLGOwMAm0O7qKsJS
	mfAli5EvGYh24+/AjSmmQdptpfB/6uWRCw0Ux529HdPN5Ykqs6C5muLhxz9NXqOAYq6t62Q4wTP
	7ApZl9JXoBuc7HZmIw1wASBF8hUA1oSoXq6m1baKr3vSTuhdldIU/+iG5TtbcQhYfpcdiDQseFN
	dXH1SoqCqca2Yvsn/s/v4VpeqQBrIas4ZYVxUqCODqvrCjLu5KHDto2Sohc4sxEp792lyoDNpLj
	2G30ypA9KmppSUd3MJZ7DOkV38GBzmJ9AsmYla1UhH6p7hlW6l3seg4UQUFvOvU9mnz8L4Pz6+2
	fhMt9qf4BCdexJ75C
X-Google-Smtp-Source: AGHT+IF0vU5bbikphUl8q4f8G57wNECmrgwvaShsksv72DQy0D+J/uQ8OnH29Rag/O3op64D2yuzaw==
X-Received: by 2002:a05:6000:184c:b0:39c:13fd:e50e with SMTP id ffacd0b85a97d-3a099ad3eeemr2857552f8f.10.1746196783506;
        Fri, 02 May 2025 07:39:43 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a099b0ffbfsm2263951f8f.80.2025.05.02.07.39.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 May 2025 07:39:43 -0700 (PDT)
Message-ID: <bf7f6606-e719-4c3d-b7ab-ef7351f66f37@gmail.com>
Date: Fri, 2 May 2025 15:39:25 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: Discussion for interactive --patch commands to get --unified
 support
To: Leon Michalak <leonmichalak6@gmail.com>, git@vger.kernel.org
References: <CAP9jKjGb-Rcr=RLJEzeFdtrekYM+qmHy+1T1fykU3n9cV4GhGw@mail.gmail.com>
Content-Language: en-US
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <CAP9jKjGb-Rcr=RLJEzeFdtrekYM+qmHy+1T1fykU3n9cV4GhGw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29/04/2025 10:16, Leon Michalak wrote:
> 
> (https://stackoverflow.com/questions/6711670/git-show-more-context-when-using-git-add-i-or-git-add-e)
> which mentions you can do `GIT_DIFF_OPTS=-u<number> git add -p` which
> does work however isn't very user friendly or convenient.
This is a question for others on the list rather than Leon - is it 
intentional that the plumbing diff commands respect GIT_DIFF_OPTS? If a 
script that wants to create a diff with a certain number of context 
lines runs `git diff-index -U <context>` is it helpful for that to be 
overridden if GIT_DIFF_OPTS happens to be set in the environment? 
Looking at the history it seems that environment variable used to be the 
only way to override the default context setting but that's not the case 
now.

Best Wishes

Phillip
