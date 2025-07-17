Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91DC1EA7C9
	for <git@vger.kernel.org>; Thu, 17 Jul 2025 15:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752765679; cv=none; b=DHVgz4jU1O1JZxO+WAWDcfbRmMY2iJZdPEzMLjFsmgKXeJbspALxWHWM2tDHdKZ2AhsWpMmXZNqmqyCUCdY32uG4jn+m7ttBSecr/7nWM47NdxupCuFQtTbDSp+GhRCx16dwQL/5eb/W0yq/DVWY98SDFq/WJnFKlKLUsC3G2es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752765679; c=relaxed/simple;
	bh=FpTBfck0kziHzgypFF4edW/7vxfAIZhcnTfw61IrqeU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UKKuWimxvadL+3oihQ0EEMCpK9OQJTX2XhBlxwRMt9HX/oj2BTtsRU7iflGtsrWnmiKJbwXmkcH3R70/ZRiuTd9wowHBDmSddkKaz1qeFj/lUkHZ/BF/Ngjlcd+nvkANs3F++cPMAk9i60f7wxZ41NbBZzyb/A9Ch/Oh9mPDUoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OHT6AHaF; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OHT6AHaF"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3a52874d593so849402f8f.0
        for <git@vger.kernel.org>; Thu, 17 Jul 2025 08:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752765676; x=1753370476; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jHKvXL9xnaOkwbvlqGJbGNOg7sXpqPxOyvNU7vMCois=;
        b=OHT6AHaFyui/iVNO1WtZ+cdIbi7lRrla1ZaaTXWDWX/gbuDmzWeBhEHaf1jhS7nSeB
         +haC54Kydob9dTCXZ6VkrGeVDlIeNx09LggNP+JHu4f4Izz4NQgNPY8KsQKS51kxbZA6
         rQzT2s9OOPQkXUlMoexzzy/O4zQFmN9JqvGO+NQ8uYD3N4+hoapXKtA7nN9pDEp/jgQ6
         2u/dU8OdbIa5PJoeYkceU2HbYGyi9R8XgmNIL9K3SvRJRW/LEuMx4dC1bqWN2leJaK09
         5RzFhEy2lF23e9BJOs0XD0PLuC26nzOd36MS97ddVScbR2ph7Y7QhcsNM69aEW7i55Tn
         T2Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752765676; x=1753370476;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jHKvXL9xnaOkwbvlqGJbGNOg7sXpqPxOyvNU7vMCois=;
        b=EEVULpFDwojd9QcbnOJF//pjLoLWXpdLd+Djy79FT8SRxaaxKb6spRyYfS0Gw6gyE8
         7nUnIuaEhrChPN2JdnPU+WppurqmB0L3joMuGV3C91yK1qr+x261NG/MiUSaRnm78fq3
         okNEXyi0S8RKc7EoD0AOIc+xo0H7CYEN4jQ7xvuXMzMVd9vBhhXC/PN7PSEjGrO1/r8f
         pp6ys8kqbs7igVwA+uqMaG9Xqq3GKpj37xtSiDNi50W/eT55RuO225Gf8LUfMhicaMFE
         fN29WPSbky2Binlznq+GSBA6yppV5/rZfP2Nx7fehromlxBWtvHZFBJebzDpigaPQDb8
         m0mg==
X-Forwarded-Encrypted: i=1; AJvYcCVKFhRIw0gVppirZcaruwvgk9+qAw9d3ieGeCH4eSi0/cESPtb3C8cVRBVpnc6gvK+zYvg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJg8LCpl2QQErTqss8fo5bJAXoaiu4XjAshqW7JdfENWmM3unR
	HlmYpoNG9P7o9wl3/o/XjbZ0eLYEs4jClLa7u80o3lqppT8/LPt653ub
X-Gm-Gg: ASbGncumhRq4u6RoUzFzF/brU1MxJexZXeih2IhRUuW6slqi2ofIu8+ohUBUGbZtx0E
	Pn6CoEQUN8LNf6yfbgTpwvIQqiWVdLQxp5eFFbVLcWXEZjOoe6zgiar+qP1Wb2I4HLs3F2Hsg6H
	G10J62B1UiGeaaZB43XeLulKeYB+gnom/I9CamfpSKWvZ8GCJxB9Xm+ML2tPUD+pV21Q5P79qQO
	20vkS4fasVQuz+nkczIfoLssTQc1nn48TVPxBJoHWuO5LYxJDm3UKYBA2DIVA/U31G+sJDSOlTu
	dikRvqc6zsI9NESu+2jWeLAaU/8IpT0vSFvDjlCSUuGsn3Xx/FZUzVrvryaTqZ3eBxc+EM+So3e
	d+BERE+M1Y6KLwpaQqS+INw5hOtGwkikGdVoShPRwRoEIn0n6LzSKLpxWveJX6YBmlaScpBbruZ
	Jy
X-Google-Smtp-Source: AGHT+IEAUWsnTytlWJc1Dxpxywc8fzjKMvuEnQ+kN9u/GWaehCuKC/J2iX3PfaZ3CykGYTmBCQRk4w==
X-Received: by 2002:a05:6000:2309:b0:3a4:dfa9:ce28 with SMTP id ffacd0b85a97d-3b60e4be284mr6151814f8f.5.1752765675790;
        Thu, 17 Jul 2025 08:21:15 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c? ([2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45634f85767sm25566055e9.24.2025.07.17.08.21.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jul 2025 08:21:15 -0700 (PDT)
Message-ID: <3e799a41-fa68-4d22-8e8e-930fcab807f8@gmail.com>
Date: Thu, 17 Jul 2025 16:21:12 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 0/3] C99: declare bool experiment a success
To: Karthik Nayak <karthik.188@gmail.com>,
 Phillip Wood <phillip.wood@dunelm.org.uk>, git@vger.kernel.org
Cc: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
 "Brian M . Carlson" <sandals@crustytoothpaste.net>,
 Elijah Newren <newren@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
 Jeff King <peff@peff.net>
References: <cover.1752499610.git.phillip.wood@dunelm.org.uk>
 <cover.1752658700.git.phillip.wood@dunelm.org.uk>
 <CAOLa=ZSk5O0sQRN5Yf+i6Jh2Dk_pafQhLYNY5eBp_S5y-HoC3w@mail.gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <CAOLa=ZSk5O0sQRN5Yf+i6Jh2Dk_pafQhLYNY5eBp_S5y-HoC3w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Karthik

On 16/07/2025 11:29, Karthik Nayak wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> We've had a test balloon for C99's bool type since 8277dbe987
>> (git-compat-util: convert skip_{prefix,suffix}{,_mem} to bool,
>> 2023-12-16). As it has been over 18 months since this was added and
>> there have been no complaints let's declare it a success and convert
>> the return type our other string predicates to match.
>>
> 
> Neat, I didn't even know we were running such an experiment. Thanks for
> getting around to it, I think the patches look great, added some
> complaints from 'clang-format', feel free to ignore.

Thanks for taking a look. I would have fixed the formatting but this is 
in next already so I'll leave it as it is if that's ok with you.

Thanks

Phillip

