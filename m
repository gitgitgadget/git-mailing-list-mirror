Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4592F1FDD
	for <git@vger.kernel.org>; Thu, 12 Feb 2026 10:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770892420; cv=none; b=dnm5eenOs2Rzdnzf0EHjTEcU3y7nWzXc2/plGuzjQTYn2zjuV1EebDbxpFOEtXtEXcmraLWCSyKoHTD7data95wWVgPS78K3Ag0DDIGIRsO+XEtXezqxFJLWMTu1EFtoOcZf2PXRBMPy0ZW+Wx9zAVcnp1pOohXppYGIF6UbL2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770892420; c=relaxed/simple;
	bh=yYOP2YB/ssFMvlFtZE19qusiuH/nIhB/pQuwCivSD4E=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=XqUHCGNgf8CZzFGqsAd0T0SjMwvx9azk1zYfYU7vtGhAH1koU0EwE7BZ/Hw342ICTliQMvKWlLATZQW9yh0gOk2xEfhd9CL328rqN/6x4BK+b13SbI1GoDDsVY9qDHwufAYcs0B9QQQnRtw68EqY9gUeZBkXkbiVEHQwahqsGVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J9PBhwYw; arc=none smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J9PBhwYw"
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-436263e31abso5684413f8f.1
        for <git@vger.kernel.org>; Thu, 12 Feb 2026 02:33:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770892418; x=1771497218; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AuDtb2Let7DbEpdmaIUYEV5JtC9iKicLSoBG17xWazw=;
        b=J9PBhwYwTblVMSOSdsKdr9YmawudKp48SantSQ1LG0C3E462ZibOgbYxT+yD21eHVW
         bwXQ+c5iAyKaybyEcdcdd1fw3ThEVOXCBWTPP7Lk918+ERFI74tK6xNK2xjLmkvMh5yh
         oe7fSa91rKNE6xwKeDgjea+43VzLzdY/3bZeBoYhS/bC4niTnythCqkk0l6u7ZlMYKmx
         AIoE8gMizoqRrQwX/6xpfCmA6QrcZ1/y86AyGQfro+T8El5gFnD0hnft3VSQTe71Vz35
         6Ct84nzCiL/8PVcQDDMeQITn5osVEMcH6JW04+qm/768IBdcFjA37GGFN8z63utMGPZh
         qSLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770892418; x=1771497218;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AuDtb2Let7DbEpdmaIUYEV5JtC9iKicLSoBG17xWazw=;
        b=FmxKhJ2Aj0iRbMPQMT+nPPu4KB6Kzc6wRsA6lis910SZAy2zQNYfoivMjOKXtuyKQL
         Kf4V+czxX+G/EJ2yTuiylWC9Z+S5u8qPpjPpapX9WJB034luIFLLpiZkJMtDL9s9pCqX
         k17sERJKENdd3tbe0Zh2sY0SOrG7HuK8Nxnc02Soya8FRns6eJHKvcZaRo3ZNVpndVjc
         sH49193ZP+QpCxbDraC8KWkkhHdIgdQ/Km4FYy7rQJ3jbJ2C0nf3Rlf7X6EdG/51YEFe
         cjbedOX4UmUOLqppPh3P3Z3t+rT4dOK8Nu5Vf3UtDGkOFUp91dwsZJ/m83MReFed32eo
         +5Pg==
X-Forwarded-Encrypted: i=1; AJvYcCVBQsSEmtvTUWYcfOx5b0NJ+abOhgbJ4Twp45dgW0nBYFmPo29qsNXL7yWfAMxGUSV5b+M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/o9yooVYKykYiaKN+oLsvD+jqFnl0EjxuSB8dUWVIyWFguiUh
	jxB/5KvW/DHWUciCCKq3cBQDFerfaVORTmv+OTdO0s1Iv+/vzjSYUqSH
X-Gm-Gg: AZuq6aIOtzsgu9UVDCsF8EjyjdgLlTNazXMA7i9TNVU9D9ebi1k2bNvdCrZyL15k0bQ
	TI58H2TMR6X8vUNxoqAue6LH9YWSjyu8diHs1IJWz95iaDCY2N6hDaw3pf2+rjFQqcuYqWBl5oG
	Y5RDu3Ymu2m3w3TFq1ToSeJNjafJ4K7ksM35rBv+lEqySHa1TQz9zk4U6/Si2Ws7/cCzsLr4BDm
	OJsszOpuDcn/IvGIsJ5NmnmRuIR3TfbXSS7XYxaSO22mhH9oshl3gUSkEazhJ5QLhAKDp8/jg3R
	Y5lN5m0z5vP8ZW+Z+BLUHcb3yGpBuWeZ5sURaXdqLOFs7nMtdeyl7VH6uWZ7MI8YtHwvcggG3KO
	lL9MRFd3M/VetA51whSqpCFs4ubAylpyxUWJL0scBxUIWyJ818voDg1Ov+XVizy89MmHXIz8CaQ
	Z3CS2BYGzZLsGOrCvy14/D5Jc/SJqksQvdT2qriA+mjlJb6JqK/enE/Bi/SWqQ2UkULyp/1syP1
	6sm2UWwhdiB6My2
X-Received: by 2002:a5d:64e7:0:b0:431:62:d946 with SMTP id ffacd0b85a97d-4378acf7da7mr3942315f8f.23.1770892417458;
        Thu, 12 Feb 2026 02:33:37 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:68d:f601:6840:9d65:3109:8533? ([2a0a:ef40:68d:f601:6840:9d65:3109:8533])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43783e0196bsm11870793f8f.23.2026.02.12.02.33.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Feb 2026 02:33:36 -0800 (PST)
Message-ID: <7d9e0e9b-4565-492c-81b7-2471a916015e@gmail.com>
Date: Thu, 12 Feb 2026 10:33:33 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [Outreachy PATCH v6 1/3] environment: stop storing
 `core.attributesFile` globally
To: Junio C Hamano <gitster@pobox.com>
Cc: Bello Caleb Olamide <belkid98@gmail.com>, git@vger.kernel.org,
 toon@iotcl.com, christian.couder@gmail.com, usmanakinyemi202@gmail.com,
 kaartic.sivaraam@gmail.com, me@ttaylorr.com, karthik.188@gmail.com,
 phillip.wood@dunelm.org.uk
References: <aYsEpvFwCSHb5DYO@ubuntu>
 <37abfe28-ff89-460a-962d-4503ec3f7975@gmail.com> <xmqq5x83w7m1.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqq5x83w7m1.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/02/2026 16:46, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
> At the beginning of repo_config_values() in the patch, there is a
> check to ensure that repo->initialized is true and otherwise you get
> an error.  But the initialization is already done in the early part
> of initialize_repository() as quoted above.  So I do not see what
> difference it would make if we rewrote the last line as

In Bello's patch there is a second assertion in repo_config_values() 
that checks "repo == the_repository" and that one fails. I suggested 
adding it because the config values are still global rather than per 
repository so we should only be reading them from "the_repository".

Thanks

Phillip

> 	repo_config_values_init(&repo->config_values_private_);
> 
> I am confused.
> 

