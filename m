Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C9A1AD9D4
	for <git@vger.kernel.org>; Wed, 14 Aug 2024 15:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723648389; cv=none; b=LPmTrFKH+9IhZjDiLeIcnhSAFk/3F27hBZiT1+N8joc8/BQwK8i9Co7m8SFKczMswOdsCUFjuoOyewgd4guD8v6QzNRozpgGxYISMWp25ddcqpVWYu6mflVu1Yv3IWEQC9lm2UE+jbbKQyqcZfKXK9L89emaJo0guBbTfrLP+UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723648389; c=relaxed/simple;
	bh=7jF//p5iueCwpluE2HL3dDxTE1Ar/F6MwPaTNxJATpc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OU+pEAPg7CaHPUiFXq/nAKGTbGy9iIgMYYoO7ghGD5kn/kw8+cljGvellpdV+MJjOSGwHsQXWUEeMhTOoUSMT+YDmeVlmRHGVFVb+WwiG+1m/+C+5P506UVw2KOO4K+3aREZvpstkVyc0QXdrprph9bRdx12PCYqqd3dY6CC9o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mi54PtGD; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mi54PtGD"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42809d6e719so51719845e9.3
        for <git@vger.kernel.org>; Wed, 14 Aug 2024 08:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723648386; x=1724253186; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=oQZLyf8IN5Jsq14wP516GJYw/+cPXjQic25G2f3qyJg=;
        b=Mi54PtGDxZ3mSpzKl+sbGD4xTyH3xIQxLu6mVyD6t6YETFgjjpGLYb5hpMjb+2O1sf
         Rbw7uRifpph6u0bSGvF7LlXLIyJKJgjFo5PHVHrnkFbzFtG5GhTky6X/xhSbhkFiq/fj
         Sect33tKuVG7X+vgBPYWnhwdkx8EJWWitVJTjt4hHFAytY175OGTfXJSdpAA+onEYO6E
         Nq0kF3UPF7j/mHYxydG2dxTCMyEAAXwgMqeg2/hSgug9orAOJnjO1TnYTfeXabFtTHZj
         Ow93c1/htXu3E0nT1/5TpqjtndLUypMdJDnBYLwcHD1WbczGacECnGAKj19aINJPVrnH
         X8Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723648386; x=1724253186;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oQZLyf8IN5Jsq14wP516GJYw/+cPXjQic25G2f3qyJg=;
        b=uSdlG6GwCv5z5FOn5A69K+zeRojjN9ykoAYWbK3aWEODUDCPHUMtMkylqJ/o3f5tW1
         y8lKKIozW47qpdNUH8U0PNWM4z86BgQ8fuOvD9iUCtFx6tx5i2Xg8kDrT4HLjxbQaRCp
         obIn1D7hCEnVVsQA7vyUuLPNhPNF0OuQy7wo1jHDNzQJ33ef/bH4gQwmNxExWz7pukps
         VDvDYVmeGBP2gtPdlTLlmY3aGYUCQ5Vtr67DuunJ/Eyug0TIk8U06IZef5LxGejZAta5
         hCCHDEW2loUrg+yecG5lMMrBO5fGspTrFGj0O6dI34h/nw0DSlj1FOQCaxGtM8JvFgOJ
         I6Vg==
X-Gm-Message-State: AOJu0Yz9q9YE544FPi6diQDdFFsdUKbQWPTOALx+HEmHbYqExwrvotpX
	broCvb4lwgPcXtTkC+YkNpvRouXeAsrDAOxAvC9OHu4sakyHBou8
X-Google-Smtp-Source: AGHT+IEcshJC5UhUDR3dlDn5BbtSQMxbXvDd+VXFaH2Ocl6H9ufYHA/mwGRkgm6+c7w8kJ9hfOzarg==
X-Received: by 2002:a05:600c:4688:b0:426:59fe:ac2d with SMTP id 5b1f17b1804b1-429dd2666edmr25020635e9.32.1723648386016;
        Wed, 14 Aug 2024 08:13:06 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:69b:eb01:545f:b423:671d:5e99? ([2a0a:ef40:69b:eb01:545f:b423:671d:5e99])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ded80241sm22453235e9.48.2024.08.14.08.13.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Aug 2024 08:13:05 -0700 (PDT)
Message-ID: <a3e9a4f9-baef-4c11-9f38-f30ff333e87a@gmail.com>
Date: Wed, 14 Aug 2024 16:13:05 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 7/7] builtin/maintenance: fix auto-detach with
 non-standard tasks
To: Patrick Steinhardt <ps@pks.im>, phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org
References: <cover.1723533091.git.ps@pks.im>
 <8d6cbae951177718b49d5cfbbeca2d5b0073e266.1723533091.git.ps@pks.im>
 <779795d2-eefd-4fac-b29f-9943f98bc83b@gmail.com> <ZrtKoVFci6cdvMS_@tanuki>
 <a02e21f1-b2a4-499a-b767-3426876d31be@gmail.com> <ZrwvWIhjZuFkRNgl@tanuki>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <ZrwvWIhjZuFkRNgl@tanuki>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14/08/2024 05:15, Patrick Steinhardt wrote:
> On Tue, Aug 13, 2024 at 02:19:20PM +0100, Phillip Wood wrote:
>> On 13/08/2024 12:59, Patrick Steinhardt wrote:
>>
>> Oh, I  misunderstood what this patch is changing. So despite being tagged
>> builtin/maintenance and talking about "git maintenance" it does not actually
>> touch builtin/maintenance.c or change its behavior. What it is actually
>> doing is changing how other git commands run "git maintenance --auto" so
>> that it is always run in the background unless the user configures
>> maintenance.autoDetach=false. That sounds like a good change.
>>
>> Thanks for clarifying

Sorry my message sounds grumpier than I intended.

> Yes. I should've probably prefixed this with "run-command:", not with
> "builtin/maintenance".

That's a good idea, I think the important thing we want to convey is 
that we're changing the way we run "git maintenance --auto", not the 
behavior of "git maintenance" itself.

Thanks

Phillip

> Patrick
> 
