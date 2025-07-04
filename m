Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4370B328AE6
	for <git@vger.kernel.org>; Fri,  4 Jul 2025 08:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751617961; cv=none; b=LbexoapwPC3p4/z5YA75kgGxlsuBBKDm1aVqXrnx8Z31Uzoo9JsVzgjCsTk/I5IdtompHl93iKazokF1zAoVElEMzAxSeCYjGkPdxTmYu3czkLqHT27UuZqROnnFKMHlPh4KGLmM3mSCyM7e19XovPQM974DuAOO97BANTrOiwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751617961; c=relaxed/simple;
	bh=iSk3IqtUKeXG6i5fCP80pJxoiZ0ujv5puEWVW/Sp/3Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZlkOFseiFqczH8V38X4ZL71fjJzfbB0MRx7XBGXL4hCn6EJ08QvcUzbfDHuxNaDin3+eNSVVD2zaN8v9djrnCqTQJ/aNOPiaPKcoY8SkFPJX3OpDz8zihAXl4SFnt+hpMfHBvAFTUF43jGQkF9jXU+CQuEIjoK5zX0L+LF6IqWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AhJCs1eM; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AhJCs1eM"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4539cd7990cso3979275e9.0
        for <git@vger.kernel.org>; Fri, 04 Jul 2025 01:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751617958; x=1752222758; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9k8WdJI2gqE5loM6O0EO0EqiB0NvYEkoMvS3grTOHxI=;
        b=AhJCs1eM6kK5AlW4S4gHDAgY43uhUvdfMF9poTbr3qplDjbXB3k2JFNS8NsvvIi9Fr
         2+UdVV30BUzWjDAh2NHpmTqhuy+V15v4oiBIWyLXcnt36lvAraxuvHxuBJhzviEm8d3z
         QXrJ7CYiI/vED1D+jpqjWHat8raUWC3OvBaLBGA0k3CIuya4PjAwo8sg7JTryIDcLWZk
         AGp1oh4JQY3hi13Pqy+efIvNqyJSiZpKPWQ4O0HkLsRyml7rkILSPOOAp17Sn7fkTk1i
         5aTYDRcaGUHcjwraTtgVtsH7jDfMXSfPY4b0LZNcAaTeGaGzcwM0DpEiTib/2tUogBqg
         hPQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751617958; x=1752222758;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9k8WdJI2gqE5loM6O0EO0EqiB0NvYEkoMvS3grTOHxI=;
        b=a+CkIklf863PHIXwgvU//qvutv05opIyeMwMt8U5O9zmVt8Oc/4QC84lTrGtOgzHEs
         nU8f8wAh+eqStxAaPTigTNlIoPMmmcyXWLXCIdIvuQJvNzUZZPgGAf8wmNObnNJ06Jep
         pCO0mx15sMUh+Bq/vb6JkPD9SOTzvEbPOadKtLQ/HJBZXARsqeQse+/Cy9tDTPDmw9zt
         BA4sr3+Co7mfYyl3aUdgZMz1d5+IbXaIg8GQqRUrypQkV5J34aaixRlDreLDbSSY/XeY
         5EymVIe0PWxNzb2l169zLq2WRl37XuL+0cr0r2fqId+FsAdKfU5ywb+5oRz/4o0mWRhQ
         NUYA==
X-Gm-Message-State: AOJu0YxM7fJ+TS5ifPzbCi617Avsie3kHDtJ7BlkRWyJlfSkZP6EkX4g
	KAICIDo/kxVrExujLEoRM9eCJCHFRH2HvEPTDmxJb0giBqK5HLkpuln5OtVONQ==
X-Gm-Gg: ASbGncty/+9tzrTzJCK/3N1711ndOtpUAhApl83uET5Tex/kdc79vuF272APBEcVaDj
	cFClS6duNow3w8xtovKp6UJJJNpRNS75lAkR0m8nnnt/hOR4ZFadimCoWNY4Wn6Pc2QkYJx58t4
	Y0fKd9ahoJqG6ZHxQ64F+EXGrXbGDHc71Rg2TxYSlMDd+JoXKMKo+SmQ/MEr+GrWmsfIwNsNFXr
	6Z3z7vx1PiarDUDEj51wfAvtInZSBeAFhJ0DwvE0jTl2gfQoR6Gb6Pxlux/m3G98/18NricbGxT
	jXdXbv4PRVSM99eRAd7XLDW9lqSdQM2b5tW6Q1+a5ZafKPn8z5OW00kRcic7fjETbfNRaxmoxDZ
	wZTv2DTWBpDIlVBX+/F56ebjO2RlJev7J86NdkQ==
X-Google-Smtp-Source: AGHT+IHn7NHnPWDQeHAo8J2J4CtICpPKWXl3au/+XJfT8nxuYV1DD2EgnZbbwkkMmLLMR3eWg9Jv6g==
X-Received: by 2002:a05:600c:c492:b0:450:c9e3:91fe with SMTP id 5b1f17b1804b1-454b38fa8a6mr14271835e9.0.1751617957465;
        Fri, 04 Jul 2025 01:32:37 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454adc71aadsm36791985e9.25.2025.07.04.01.32.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Jul 2025 01:32:36 -0700 (PDT)
Message-ID: <dbbde8e4-985d-4d72-b879-9110a4410abb@gmail.com>
Date: Fri, 4 Jul 2025 09:32:34 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [GSoC RFC PATCH v2 6/7] repo-info: add field layout.bare
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>,
 Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, karthik.188@gmail.com, ben.knoble@gmail.com,
 gitster@pobox.com
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
 <20250619225751.99699-1-lucasseikioshiro@gmail.com>
 <20250619225751.99699-7-lucasseikioshiro@gmail.com> <aGZqPC47iPMixyvW@pks.im>
 <6DBB30CE-D30F-42B6-A81C-35460B462D45@gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <6DBB30CE-D30F-42B6-A81C-35460B462D45@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Lucas

On 03/07/2025 15:14, Lucas Seiki Oshiro wrote:
> 
>> Meh, `is_bare_repository()` strikes again :/
> 
> Yeah... I tried to avoid it but removing that dependency is work for its own
> patch...

I really wouldn't worry too much about using "the_repository" in code 
that lives under builtin/. The reason to avoid it is so that one git 
process can operate on multiple repositories but until our library code 
stops using "the_repository" and actually respects the repository passed 
to it there seems little point in worrying about using it in non-library 
code. As it is we're currently adding more instances of "the_repository" 
to our library code as a stepping stone to removing other global 
variables. Once our library code can operate on an arbitrary repository 
we can then think about which files under builtin/ want to operate on 
more than one repository and avoid "the_repository" in those. Until then 
worrying about using "the_repository" under builtin/ is a distraction 
from fixing the library code.

Thanks

Phillip

> I asked Ayush [1] about this as his GSoC project [2] is related to reduce the
> dependency on `the_repository`.
> 
> 
> [1] https://lore.kernel.org/git/CAE7as+bTKE5opov-Xn0P8R+cy+=-XRkX9Wpie_W0717XMF1b_w@mail.gmail.com/
> [2] https://summerofcode.withgoogle.com/programs/2025/projects/no7dVMeG

