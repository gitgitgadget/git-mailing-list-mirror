Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5B21304BA
	for <git@vger.kernel.org>; Fri, 22 Nov 2024 08:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732265513; cv=none; b=Ksxi5/saCmxxAi5RMWOZQDLuGWCdRCv6tn4DKNdT33j7X5QWknA7QCjgtgtkh2mw+U46Pig0gzH9AzBKYS1wgf/Syvph4b8AGAB3QoVlbbwdB+XzkXd5HsCDTOZ5/zOkBMRMggCk3tHW1DMVQ7JfudbjlCjTIYcinTUYZYVbLw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732265513; c=relaxed/simple;
	bh=AjKSocgtmmfqTEo70loIU/oVvduThHE2Sic6mkuhapQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FrtazEhvop5X3LYc/V8+zBNM2eOC8yEDhas3p9yLS9hAA5cPsIArHBw7zizqQNaTWoZ8IgRzIpEMXQGz515EIzUsWHOoiDzz65CqQb/gqagUVdS37+Lkf/i4FUu/bpAvHhpNS9yJZv+ccsZPvbXTJgkIFGRFgOAA2NYOAaQoBbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=koS0pl9N; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="koS0pl9N"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-211f6e1c865so2939565ad.3
        for <git@vger.kernel.org>; Fri, 22 Nov 2024 00:51:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732265511; x=1732870311; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6WEtqF8inr1Q4aMuwOdMgjYjJ4BunOUOgh/ZhH1lQUg=;
        b=koS0pl9NMDWoS9JLf2BqMTSNBXCG83Co+GbnOA2lPWVyzzOTNEH0vVQxYLosdOyQOg
         L0qk7Ff5w1OyRwRAZkyFgL0EWNq4Qr99likuptAuqRLVm4kYllg47EFBKvKGKpBuddBn
         RD502woTNaTzQ4rD2SCmIRMQ3Gm7MdvFSJdPsiYgVRjxjYLytlsdni2wdHmEfcVur6xt
         pRfz3qn7D4FAXECsLMSu6AMX6OlUD93ouyxfMWeBf5vMCcojyOrWhS3TC4o8l5b65MgZ
         qnmykDO30CMDxs/pnvIurKgQX1rTyaA0d5yG1+ZTAmt4OPqjR4zF+npiW0rpkMw/O+DU
         Xoyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732265511; x=1732870311;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6WEtqF8inr1Q4aMuwOdMgjYjJ4BunOUOgh/ZhH1lQUg=;
        b=aaOzsnynhg9Pmmdo12l6xRUuKRUAmDxnrqB0vQrHq7XrVMWs+x1BFN6SWmAmu9rpt2
         N4MwHaRLO9DmWHIowtKNLJPOm0lCpn6FOD2Kx74aRERSdlhGo2EEd3EgpoZAMh0s6rmU
         8hRNVF15ZiAgOy5Dc+r8hfxpexnuNZusKoHltFr4OhDNcMiFZCRlV+kYU47wEB/6Ht/s
         bJPTa6X6wjwOXRgtzCPtvNpfWB0CKXf+19WTY2SlwEmBLCctnoGMpBOdqIryO9v9dyS7
         Gyl2NhELGB/SB9RzQRwuUlUGYxZJn0mnjUspSk8aQBDuIJz5EBMwuIdbqZz6HPFCyX3S
         y33w==
X-Forwarded-Encrypted: i=1; AJvYcCU94dlwlxDsskNCIwG54z+egSR/thc5rYmbqfTjCTCwBbeFQOD3Vb3VvVMC8kibJizysSM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLMEaGiQq0+f7vyephy7XcW+8SxuflBzzf2JFk37MrVD9niLHn
	kiYS6JsEeWmkiVG8cYn+2DxyzMp5Sk+tQGusGvvhPIEy9CG4HqQb
X-Gm-Gg: ASbGnctBuHDL4VxNW4e1dRtH1DFiXQj3KLdlHNdjriFgudOlCTkLRDKU56yRlcaEl0X
	Hpvo8zqfreFv2cUHBzqyLV7kLYMu8y/CnVidhA7OVSuKFJWON1i0ftKxScFIosPlK5m73BvRTDU
	lyU2U+atxsm4TTzUIuSZWnDM0mvP38/2riZ6dc51pTQE3pDp/+BmUGsdA0AT/R1kLjqYhQlW+fu
	GjFg9pUcEZoSQEyvCx2n9zeTgeN6y3I8LF9GOiDjY7OXdZXfNx2zSY9ETg1Q/DgM8Ro8K5gini2
	/NOpNdEsEXT/Axk=
X-Google-Smtp-Source: AGHT+IFELyzkl6EhAz9tZMpyiH2Y7iLyxkaRr8cbIV/OF1VhkWIOQP2jUHfD3SfwcHQNWyelig5RhQ==
X-Received: by 2002:a17:903:41cb:b0:20c:d04f:94ad with SMTP id d9443c01a7336-2129f31dd67mr12379705ad.4.1732265510920;
        Fri, 22 Nov 2024 00:51:50 -0800 (PST)
Received: from ?IPV6:2606:4700:110:879d:83c0:a91e:5f7e:c6a7? ([2a09:bac0:1000:686::dd:19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2129dba3022sm11339825ad.65.2024.11.22.00.51.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Nov 2024 00:51:50 -0800 (PST)
Message-ID: <dd8b5cdb-2ce8-4ad6-ae96-197fa898b206@gmail.com>
Date: Fri, 22 Nov 2024 14:21:47 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External] Re: git-blame extremely slow in partial clones due to
 serial object fetching
Content-Language: en-GB
To: Junio C Hamano <gitster@pobox.com>
Cc: Han Young <hanyang.tony@bytedance.com>,
 Jonathan Tan <jonathantanmy@google.com>,
 Burke Libbey <burke.libbey@shopify.com>, git@vger.kernel.org
References: <20241120185228.3204236-1-jonathantanmy@google.com>
 <xmqqikshikgz.fsf@gitster.g>
 <CAG1j3zEEN5EJwTsM3q87gCSqXG4+=DZVvcQdDhoj5Epe-S0nPw@mail.gmail.com>
 <972d0904-650b-4161-a13c-e3081d55a212@gmail.com> <xmqqv7wf8ydw.fsf@gitster.g>
From: Shubham Kanodia <shubham.kanodia10@gmail.com>
In-Reply-To: <xmqqv7wf8ydw.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 22/11/24 1:59 pm, Junio C Hamano wrote:
> Shubham Kanodia <shubham.kanodia10@gmail.com> writes:
> 
>> Junio — would it make sense to add an option (and config) for `git
>> blame` that limits how far back it looks for fetching blobs?
> 
> No, I do not think it would.
> 
> What would our workaround for the next one when people say "oh, 'git
> log -p' fetches blobs on demand and latency kills me"?  Yet another
> such an option only for 'git log'?
> 

I'm guessing `git log` already provides options to limit history using 
`-n` or `--since` so ideally its not unbounded if you use those, unlike 
with `git blame`?


I understand our concerns regarding adding new config options though. 
Between the solutions discussed in this thread — batching, adding server 
side support, (or another) — what do you think could be a good track to 
pursue here because this makes using `git blame` on larger partially 
cloned repos a possible footgun.


