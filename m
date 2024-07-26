Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63777156898
	for <git@vger.kernel.org>; Fri, 26 Jul 2024 05:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721973507; cv=none; b=Hm05QnxAHCSWA0CIuVfJ34WssBRmHxdNVMC4CmnGhawLwAEEHUgbBc3vm6+uYNRKz2l+9gGk6dmAJvy15DPZl7oUip1Ve9RNrQMF/+bEKDCp99Uq34X684pecF+SP6LCSrucjHw+IYItdfKqjGingP6nZ8gJAHmbVeGwmrKt+OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721973507; c=relaxed/simple;
	bh=kgQSLfeM75sjjX+p8RiqPmXl0kMP8xWUALQFR8vdeWg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DmEP08KecEWdbLUtz0ZfYfXOwjHavQtbpBqdDmy1wj2P1AByBu7GzurhnkFAx6Q3ItJfw1zP+17MJz5xi091DgxelT1JgNGwdnYwXr/zw7ezAHCiTlipmvoilt2PeBjObQz/yjYMFiZ8i1EGp0URkrehvWRMEyKhf84si+YmbhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FHSqikJ2; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FHSqikJ2"
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5d5bc93e09dso375562eaf.3
        for <git@vger.kernel.org>; Thu, 25 Jul 2024 22:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721973505; x=1722578305; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:disposition-notification-to
         :from:content-language:references:cc:to:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XqgdbBrXBoshvH6S44L5xF6DlGmYdL8TCNuJijouq5g=;
        b=FHSqikJ24SgJt2QgyX8BdPEpbwgKvFTngtMivCze9UsBW2IY5Xk3YcmvuShOQrg7Ob
         +nIZVCs3AFzYXEGpvsuXfB6c5oXF+cH7HmzZsp3RLwwW/t54zQIISlAmXljykaWw6yPT
         EcNYPqH/VJWEFfnQEutE+dKRSGnOon4zbVZabavSRphDbmO84LeHPaDILTbm9Y3OnSHN
         XeDwZ1rqdEujS0pIrTGBN9i+wX6uwncWEQm/q1OS/NY9NYsxdWAilXWLuThwvXDnrDhf
         CHM7CGNDyjXzZv64dcfT0W1uEsuM5DHf8UytL0skeip7TVPUI3Fx7bb+JGQcWbsHoqk/
         e+bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721973505; x=1722578305;
        h=content-transfer-encoding:in-reply-to:disposition-notification-to
         :from:content-language:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XqgdbBrXBoshvH6S44L5xF6DlGmYdL8TCNuJijouq5g=;
        b=v+aM+a14VpmApfT0W08xbzO5YvC9ckfxe9nVet5jQmUfmzvpCPBmbvfSDoGnef70J/
         wvCPjBtDNMei1lX0oATASSq9b+1zFFF4eZHpNwtwIdbRGGn8d0eWhh7nLLfIfmVjZGiN
         jK5siTPAxvcqSXRWpwdRl1orE0sxi+vVFGN7EgYkPLSf4KGaqaaopBmscRAgUFjQVrrY
         fAeSCcYW9OxHzKToFWLjQv9CFVOTy/ocJNV832rkn4cQ1Fg+ZUlwzFax7kTDWp6K/AsN
         sU9sSMhOfi4AEV9KSRqkUXioLKX4G+9O74TKh3drsv5LulCeQT4AlUAIS8vKLH9BaItu
         vLqg==
X-Forwarded-Encrypted: i=1; AJvYcCWpnyj4yy6/1IZiAYLnrk0e52oBzT0pkROHl8kXT4+SIAcyQbHy94VwUGpMs3mn27twSpZG0rnRtxgYZvBMa5uaR/3k
X-Gm-Message-State: AOJu0Yx/112ttr/Uyl8FaVRoI24NTKUx9QxaJC1p0nOE7ZxeStCeMTpL
	14ydMvzYVs5iYnPGU8/jP28u5pwmsaJlgQBgldaYpIM1iTyTLr3T
X-Google-Smtp-Source: AGHT+IGzz3JHlCeoMBVWGd6/zHYyA8GG01hLFhsv4QmiRF6pfkopVRNzGEGIbz1pm4s6FpDuDGFLLA==
X-Received: by 2002:a05:6871:33a3:b0:260:e2ea:e680 with SMTP id 586e51a60fabf-264a0c8f175mr5304449fac.10.1721973505279;
        Thu, 25 Jul 2024 22:58:25 -0700 (PDT)
Received: from [192.168.6.104] (mail.3111skyline.com. [66.76.46.195])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2653e7a0050sm582993fac.25.2024.07.25.22.58.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jul 2024 22:58:23 -0700 (PDT)
Message-ID: <5747ba0d-7268-4538-9705-11650a7d6e35@gmail.com>
Date: Fri, 26 Jul 2024 00:58:22 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Local git server can't serve https until repos owned by http,
 can't serve ssh unless repos owned by user after 2.45.1
To: Jamie Landeg-Jones <jamie@catflap.org>, Johannes.Schindelin@gmx.de,
 gitster@pobox.com
Cc: msuchanek@suse.de, git@vger.kernel.org
References: <d9a83e5b-5075-47c6-85c8-e0b550cf859b@gmail.com>
 <xmqq8qz376fb.fsf@gitster.g> <20240617211513.GM19642@kitsune.suse.cz>
 <20240625072419.GU19642@kitsune.suse.cz> <xmqqr0cl6lxl.fsf@gitster.g>
 <202407260038.46Q0ctEV083266@donotpassgo.dyslexicfish.net>
Content-Language: en-US
From: "David C. Rankin" <drankinatty@gmail.com>
In-Reply-To: <202407260038.46Q0ctEV083266@donotpassgo.dyslexicfish.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/25/24 7:38 PM, Jamie Landeg-Jones wrote:
> Junio C Hamano <gitster@pobox.com> wrote:
> 
>> Dscho, the f4aa8c8b (fetch/clone: detect dubious ownership of local
>> repositories, 2024-04-10) is your brainchild and people seem to be
>> unhappy about having to adjust their settings.  Are there any advice
>> you can offer them?
> 
> This thread has gone quiet. Is it going to be fixed? The issue isn't that
> settings need to be adjusted, it's that it no longer works whatever
> your settings are.
> 
> I had to go back to.2.45.0
> 
> Cheers
> 

I too am stuck. It's a damned if you do, damned if you don't Hobson's choice 
of git repo ownership on the server. All worked fine serving both https and 
ssh prior to the change, now it is either one or the other but not both. So 
either your read-only pulls and clones are hosed, or your read/write are.

If more info is needed, let me know and I'm happy to privide it.

-- 
David C. Rankin, J.D.,P.E.

