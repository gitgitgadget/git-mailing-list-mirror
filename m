Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8707C8CE
	for <git@vger.kernel.org>; Sun,  6 Apr 2025 18:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743962934; cv=none; b=RSfwHx+EcLSBcOdfJ3vGxBjXTN2Xkmk4IZIPtq8tOwe5El7sBj5Fb9NFHVCeKglBliW5RoRhTwKLKgEkcDCluKBbuWpHp7Jn8wlwNwAe+SM1ivdrQZM0oUz2SCQ8Olrst5ECveZLXhYZAQ/nyeq+36NoLKUZ6/0anOO/VjO8mMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743962934; c=relaxed/simple;
	bh=EXmj/hlTPTHmZ+kUdVIx5C9Mws/H6B2RjtS7DWlCjD4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BjlW9FqFRvQljdsDd9+l8wGbSqEepZ1xYY5I7uUBwOmdvgYtxuIP0GT7+TEhIRbOpiYETKf2Y44mFcxvD8PITLU3/T5RM8EmKWxWyeIj/rjDN3m4U3mpA/IWGPBEmz6+IywVXo2w8U7Xvn6KlNFETvHZpTjc4ZMVFYSpg46v1MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TrEyaK4U; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TrEyaK4U"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-736c3e7b390so3104605b3a.2
        for <git@vger.kernel.org>; Sun, 06 Apr 2025 11:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743962932; x=1744567732; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CVyiZMwsQlWiw7zcoIxF71eKntHJvFY7gaDC6FM6/+c=;
        b=TrEyaK4U/tvz45TORjRWCkkpAaPvZdjmiIcSXiYIFNTGit57tR3eFDx/B02QS7Qro+
         BFJAcqq7AfQnt2ZXn19r2DF8vs6tpaxSKa1FZMkx+uVKbkVy1GKD5bPyFEbzh6PT2UOl
         A3GNL9axCOa+dMah7oC0Osa5f3pICaY0L0s0F/pcvzmdoSiJ9IV1+exxMh8J83fpA0Ub
         GoFznxmuVn0aChULFShn3xCcnFKf/XsX0v8d2fWdhblNq0hBlj+/SYX/AuKDcHUcmvQY
         eJJUrgDF2EdslEn0o0jbnlbG4I0IfsLWVJvzQfRDVgvPHVPyhtBIIIc8kIkMCLUHrlA3
         /hdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743962932; x=1744567732;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CVyiZMwsQlWiw7zcoIxF71eKntHJvFY7gaDC6FM6/+c=;
        b=f0oIPbXnGOXWOdyPC0CqDio+C/JBiPo/4PN8PPd+4+wLBj7nkCu/gS7q4hdQtlCfyp
         GK8olPl/8LXhdrS2d2tWVkbEz+yjQARWN9U7QEEcD2VI88iV3ZceJf38J2HnxdKbsTcC
         4b5+xzrpT1RoejQtx+5jhTv7p7+3PEavB1w0+lrqiWwnEHtl+S5uhyFfWtQawSAxzRD4
         l76fCorbuPY0OCdz0uaKs6AFVrl7wXqPY3Sw0TJIeoC6gm2hfNxQ2sQezM7luwx6G8UJ
         tZYAxEsRuky+shE1TV4SxUFMadYLcuTVkPc2hSxItEzFoWj9G6QkCm1v5ILPvn+qd6XQ
         gCpQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSANyy1V5wbNeN1TTwuAm6SNadU+v7z5VqeM4iIEAlwmrkibhBDD4eDYSWgH0F1khhebk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaEUznfZqRdaGnuos/tiVxFVfTI2V90lK+dj0LPWnSbZCHFP7A
	yrOWBmZipcQ1SSQeQ6yGFYljWS5G9hqYL70O+tMsFkIRLWAJFLso
X-Gm-Gg: ASbGnctIGuyRuRO41QEq+H7EiW63QFN+2LlAXytdSQ0MY1Zqvy5eYh5iO1+qAw6LWBC
	rFVYxHt2GmkMfYqbABqEC2/sqe0635ZSjGK77Dgu2MpwhDc+59OYVMGdfB032Duf37TnOB4jFus
	Xi8ZFLx9rkdP0GAxEFyuWctn4GSaeDpNw5Ma5GDDMv7kr5xrYU5XS7Cmhok91p+jJsY00+fo8hC
	v4fzYyDyoHcZaLP9QrABjSEe0iltJ2nfYkXvPnUsEuPIhL4LEPG/yNx9fafe/eAC0qvgKjV/ZlP
	pl63iksfKuC123wkMcNRR6lI4KiqaXX1x1XX3aW5VZbr5YaUdiZceA==
X-Google-Smtp-Source: AGHT+IGQJSJCBv/AUE2KWuzGCWd3cOeddySYW4vL8Yaaoka8wyqpZHrimC+20AlAQOlBf7WHWuki7g==
X-Received: by 2002:a05:6a00:1411:b0:732:5164:3cc with SMTP id d2e1a72fcca58-739e711fcf5mr12613991b3a.19.1743962931768;
        Sun, 06 Apr 2025 11:08:51 -0700 (PDT)
Received: from [192.168.0.7] ([106.51.24.41])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-739d97d17c6sm6930088b3a.22.2025.04.06.11.08.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Apr 2025 11:08:51 -0700 (PDT)
Message-ID: <f5ba0329-5789-4c20-a2ea-b213365af5a5@gmail.com>
Date: Sun, 6 Apr 2025 23:38:31 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GSOC] [Proposal v1] Machine-Readable Repository Information
 Query Tool
To: JAYATHEERTH K <jayatheerthkulkarni2005@gmail.com>,
 Karthik Nayak <karthik.188@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
 Ghanshyam Thakkar <shyamthakkar001@gmail.com>
References: <CA+rGoLfxZHdns=7FwQuYS=JANrR9zDP-dOpV2AxM1hC1Lc9wiw@mail.gmail.com>
 <Z-5hlL1Gk0oi4fX2@pks.im>
 <CA+rGoLfCTzNTcGXG5py6oHQazeE8Vj0fLsR4KUTJ6rSRFnT_Vw@mail.gmail.com>
 <CA+rGoLeRXUQu8ZbDtaLp2_YbVGA5D1DeA2vSEcLf74qXjB5U2A@mail.gmail.com>
 <CAOLa=ZQCTJLSWV-y-=nKf9J4xKr5miAo+35RktmbGmHPL4Sp-w@mail.gmail.com>
 <CA+rGoLcDt0r0mDBk44SY0NcnG3mNBy5vSNBLzeggsGwJ4d-Cwg@mail.gmail.com>
 <CA+rGoLc9g4werz-k4_ZzfNLLGHjzHoOcFYSmV5V-Krq04drgZA@mail.gmail.com>
Content-Language: en-US
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
In-Reply-To: <CA+rGoLc9g4werz-k4_ZzfNLLGHjzHoOcFYSmV5V-Krq04drgZA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jayatheerth,

On 06/04/25 11:39, JAYATHEERTH K wrote:
> # Proposal for GSOC 2025 to Git
> **Machine-Readable Repository Information Query Tool**
> 

Thank you for your proposal! Just wanted to send in a gentle reminder 
that the proposal submission deadline is April 8 18:00 UTC. So, there's 
very less time until the same. You may want to consider submitted your 
current proposal and use the option provided in the GSoC website to 
update the proposal before the due date (if necessary). This would help 
avoid a last minute rush.

Feel free to let me know in case you face any difficulty with submitting 
your proposal.

--
Sivaraam
