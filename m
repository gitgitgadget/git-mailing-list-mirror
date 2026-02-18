Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57C630497C
	for <git@vger.kernel.org>; Wed, 18 Feb 2026 11:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771413104; cv=none; b=m8f8RRQXU0vWJHYzoeh3XxddbsHOuKWamg50fPH/xd+Byzg4ythQUEc+B9D6zv/kgSyH2zt7h6WjzkgqCk3MEB5ZRDHUK/YrxZteA+FDJ0Oj9AFcJvrHmwz1UxfJQMuUSnK828GHa5Emcbn5Dq6EgBKSUbEWVEbLC9D26CXacsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771413104; c=relaxed/simple;
	bh=ymrLB20g8dNb6l5Ha9K+/hZQ1IvYacVvQL4Z6UoCoAo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R2QIH6/j9cO8HUJQ7CHW3jp2Ffn1dx5XRJ/R4VflbtiT+oAaA/CFLf3JADtW38DMWcHl0ZyqGk3Arnfp9z0poexLs4JsaVAE3l0Y9yckVdLIXeMmCEM/ZlffTqFTIrD6AImO/CtCqP6xNSZu/9uzizpTGDRStcHrnIzViLhdYXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MNe/k4ac; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MNe/k4ac"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-354bf10f057so533398a91.0
        for <git@vger.kernel.org>; Wed, 18 Feb 2026 03:11:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771413102; x=1772017902; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j5X7dHWyzzzk/c1uT/ztH5PZMG4wXxkTqdFXQToMCaM=;
        b=MNe/k4ac7dUoBFNNIDNFHkxBjAnzHpyOOi6hcN67DNcVgzG+1nDCrHiSufJDnRlRAk
         nnpED+0yKenU+mbMwoWnncL63J2kqT9h+DfEfNCB0wHAjbm9NmE42PW69DnnL5eGbzZm
         nfTvLWh18rpCOxJL4M7Ti3K+DppDDkQ7DeHCMviesI8rMUGXFKsnstHHn4zdlogkgcfR
         DN+SwYKml6FhGHzVusT5d3JE7TRNHraqzE+FczQDJvEWgWvtqXgBYPn/saNjvxsygdme
         NoOE61WFYLkdf2a5pLUSpWreJ/N2zojqbgGxau6R1lD8Sg1zJhq6rQeX7WVOjQx6a5Ir
         O0VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771413102; x=1772017902;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j5X7dHWyzzzk/c1uT/ztH5PZMG4wXxkTqdFXQToMCaM=;
        b=PwG67D/5qXUqgSIo1tJ/9EwOLdBpLZv48SLqF8aqHpm9BcVHI1vpLVvD28uBgnW2Nf
         9bVav7zgVSLLjdMS1RG1DCYAYgvtk3I/i/Z5+UiiU4Oxi/fDdkI5t90MEW7k4lOQ3Jin
         1F/Rux4KLwRbDWRq58XohSJ0m7dG+jqHAqtReEEZscqA/MIdSyb06HBD58xBj2um7VRi
         90sbwM03oFNznYDUMUxD3llRwCKHvy9kQXFBZdRN2FwEFQk6ehKR3OkZ5WzXlE0oZGJ8
         msae2yEgMnECLUsmUACDSJT1wW1y9lU8y8/TLEZcsbsWQFzMOiVSCPiW3C7MRO1o6OmZ
         x1rA==
X-Forwarded-Encrypted: i=1; AJvYcCWLlGi9TcUmYVrH6MAStryMi+zxSdbiM4tn9AEWq2MJRTi0UbzYcBG6lnIaRKQgFTu8dyQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnFrYampo1OgvqakMUuPJbbBsfP5eCw4SXXLeO/xW0Rz4khviG
	n8+ajOTSjtavpxmpwMukoAO9xKl4l/YK1CuFm2y75+LYpdCpA1Plm7f2ELsfsA==
X-Gm-Gg: AZuq6aJYDZkhnirCupLwRkQQNnWrWO3ynTtNtIwrFp6GIgf24flL6u3EQBHCw4gtwe7
	DoWgp+7JvtIZSYfxJ1pPq/ey7ZdJ+DX/G8jDdCTvebcUdTOFl7PFMWU4J+Os8rkybVKo8QQW81r
	k9v1qis49fFmGRuORuwab3xulPSiATYht1q9REMjDQKX5DaE668weD01IeR+/Rgxqxhd9CmKWuy
	x5njo95cQPI2xWb8WGzEbrHCEL1IXJfTTrc5c6GjiG0UJrhk08N3PzEa+XJl4O3C6EH1mCnpbHK
	Ag+MtnTrSYVeLcAnRfAoLnwVSBMRi/t85ycc16ByGBzcFJ1haEu6KTeywgMWk5Mc+rWYcJcEyKs
	JBzOyF8WKnrM54+y3nFGvJelxpU+KVrsmuZaG/0JkIiT34WMt9aV/KhdO3ZvK4+UifIaupa5Dfa
	MmvR7X/ONtbtBqHdGN6acfFCMtIQc=
X-Received: by 2002:a17:90b:5843:b0:356:24f0:af05 with SMTP id 98e67ed59e1d1-356a78d8696mr13556933a91.1.1771413101859;
        Wed, 18 Feb 2026 03:11:41 -0800 (PST)
Received: from [192.168.0.106] ([155.69.180.3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3567e9fb4bfsm21218489a91.8.2026.02.18.03.11.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Feb 2026 03:11:41 -0800 (PST)
Message-ID: <85978d52-7bdc-4c10-8f8e-8c4c2a804cfd@gmail.com>
Date: Wed, 18 Feb 2026 19:11:39 +0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] setup: distingush ENOENT from other stat errors
To: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org
Cc: gitster@pobox.com
References: <20260217084124.150366-1-a3205153416@gmail.com>
 <20260218051850.164972-1-a3205153416@gmail.com>
 <20260218051850.164972-2-a3205153416@gmail.com>
 <CAOLa=ZR_tH6A6JEj7NwziwYaVtezkHMez_cZNYyU1TQi5D8=XQ@mail.gmail.com>
Content-Language: en-US
From: Tian Yuchen <a3205153416@gmail.com>
In-Reply-To: <CAOLa=ZR_tH6A6JEj7NwziwYaVtezkHMez_cZNYyU1TQi5D8=XQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Karthik,

Thanks for the review!

> Nit: For this function it should be okay to return early. But I was
> expecting a break here, since it was using 'break' before, ideally we
> shouldn't change it unless there is a reason to.

> Would it make more sense to do 'not a regular file: %s'?

Points taken.

> So why didn't we add the tests here for the changes made?

I think the reason is that this commit is a refactoring of the internel 
error handling. The actual logic change that triggers these new paths 
happens in the next commit (2/2). Without the logic change in the next 
patch, the system behaves identically to before, doesn't it?

> Nit: I would even go further to even separate this into two commits:
> 1. Split 'stat()' error into  ERR_STAT_FAILED and ERR_STAT_ENOENT.
> 2. Introduce 'READ_GITFILE_ERR_IS_A_DIR'.
> 
> But I'll leave that to you.
I appreciate the suggestion. But since the changes are relatively small 
and closely related, I'll stick to keeping them in this single patch to 
avoid excessive fragmentation.

Regards,

Yuchen

