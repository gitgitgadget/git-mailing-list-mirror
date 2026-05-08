Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B644434F25C
	for <git@vger.kernel.org>; Fri,  8 May 2026 13:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778245335; cv=none; b=F+ADDnHTKJ29koq9axMiweeJQaJvLyk1AUPL9h+H82ExF4Z/GK7nfflFjq3wfPy6TsfwwlaS/ZoLkjVmJEfZBh8Oz6dVoMDQMAfP5HxWtnXvYxj7RV++C8dvB5LEy1YFHVFJuey0oNEbWcCS0p9tA9pFouzWJPuKPyN5HIxzraY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778245335; c=relaxed/simple;
	bh=bwZIYxG9DxnGKtFv7Iw000LNRaqAxZznBTPj6SMLDn8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=INZGsFaMa9tTkdzs6OX96lgMK895hOoGFukcedeF4BM8BfPOwooWarej4DDxKdBZiDWtUsMs0qlzcrH4ElB65DLsW66a7XwKtJSj24bGNAlm3yNofocRA3eDO8Da1PGL6N2BS3ypkkAgT2uW9fDMrsr8eUl74w6CarUEaA0qa+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b39jWvEp; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b39jWvEp"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-488b0046078so16620585e9.1
        for <git@vger.kernel.org>; Fri, 08 May 2026 06:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778245333; x=1778850133; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nCdVoKQv0OQjdXSnthzxJk0y2SzEjYXL/0AA81W2Jl8=;
        b=b39jWvEpcUhLZRL206bwfbIHmhES2iDBFHcJjMxHnUTKzUdjPALccpdJPAXDwqvLOC
         7lv9ww6qnv3fTXWjmcuBshtA8msx3r8KLa2MLDdYLr8aOkzU1Yqwi8o8D7hTlN2mOb8w
         nyEroV5WF09lM6rNOtBOQMMiCU22DneuYCPxbDzrVS/ZoyrCvV8708318PDPkdlccZ3u
         /fHR9DY9gdZx4VcNn2PCF7TeYCMaxdGgwXJ41btXMaZ23D/BklJIl94kecyT5bfMDOF5
         bXrESKOOE80yZwUYkFjfVPfgOAc2SgI5vtQdw0xsG/QCBLoX6L9vHTljbcesP0T0ehDH
         w0MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778245333; x=1778850133;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nCdVoKQv0OQjdXSnthzxJk0y2SzEjYXL/0AA81W2Jl8=;
        b=DTmUS9N71ujEx3JraQuQDvGAJhhIQLHByVwo83f0T4OHsre/7UV/i7jfN83MCZkQ1I
         5M5Lsf4X2glvM7hSvzOtWpeLuKSaJpHcvRT8x51SUUn8c0b2ieb3tRzvjMrOGS3hYFJJ
         ErOaRhSB5uXtTinccA0uWTvk7TcWJqFRQLyTvdGVpC2ePi954ZntM/FIbrBlTtHWNzgY
         6t4o6S5d3xWxFm8fjUMqD7WkfB1lYdk2g8G7P0jqB6hkY7g4RSTtpgzrdSbikp6FDHq1
         vMyPrW+RzMan3y8tmlLp6FW1IK25WOv+pRS8dI1a0NETSsMwau1nJ3c3mzaua3bIntKT
         Aggg==
X-Forwarded-Encrypted: i=1; AFNElJ9ymdSRkYx/YybfOKhlLyI5yBs9852A1jT8ICHVRA5k5Z5MUrjQ8SqFjs9aOnkbwPW7MeA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMzERHFi7sdJ96Sw7j+nqlpFeIP/F9eE1MeY0BCudVEEbsPnJb
	yRyeG9/Z0B8mXRUJ6BZRgKz/1WWWBJU6dNoBUuGRhFTdcSnVzpjmLIKq
X-Gm-Gg: AeBDiesHRXkewHlGlcuylO8IocutGqO4j4TETEh8kT5Dan6bZ+Ed9oOlsjTpqLas/kp
	J2Rbiz+GXFd9xWwBg5SxF2ZY8p5TXpn7b59pZK6u/3v828fqFb+N0te8PQ1La2gDGm/MRJ69Os6
	Cy5sKit7dl+Bnp1gurZAx42Ihx9EsO5E4nVK7RsROQywizXFbsjv7Qw/Cr1GnauE/ueaXD515SR
	KNyxE8VRxT7llpRFIsekbHy3cuP02/S45oPlUnpvuFPFn/QiqG4mLzUOOcDVZCyzD/giGLGC+WC
	qQc7CruL1CzAPvOmpNhjVH4m7o1h073i/aVBW5gmuFBet38R0PaHSF13nqRrBhNvUQKk4bpy5S9
	mYmPFbbk89w/715Opl3CxVR1wZ30YNU7Wqm4Wx4TD+ldzdzLz4dwTs9KmMGJyvFOlXlH/BXdsGr
	0dz/Qwz9xqdNQD6XbbZsdbuZO1B35ag8GTIRj6UYxRtMmR/hbeuhC/Gq07Moi9342n1ey4wIhSp
	MBI0k70lDDweLU5tnQgqg==
X-Received: by 2002:a05:600d:8451:b0:487:219e:42d with SMTP id 5b1f17b1804b1-48e53f33f08mr136939275e9.11.1778245332750;
        Fri, 08 May 2026 06:02:12 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:76d:4c01:4d98:a9b5:d032:1731? ([2a0a:ef40:76d:4c01:4d98:a9b5:d032:1731])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e68e35177sm49374635e9.0.2026.05.08.06.02.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 May 2026 06:02:12 -0700 (PDT)
Message-ID: <852a731f-ae6a-465a-9af3-9140adb4fa01@gmail.com>
Date: Fri, 8 May 2026 14:02:20 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 0/5] checkout: 'autostash' for branch switching
To: Harald Nordgren <haraldnordgren@gmail.com>, gitgitgadget@gmail.com
Cc: chris.torek@gmail.com, git@vger.kernel.org, peff@peff.net
References: <pull.2234.v16.git.git.1777401552.gitgitgadget@gmail.com>
 <20260507201112.41110-1-haraldnordgren@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <20260507201112.41110-1-haraldnordgren@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Harald

On 07/05/2026 21:11, Harald Nordgren wrote:
 > Is this ready to be merged?

You can see the current status by reading the latest what's cooking 
email from Junio. I don't think he's officially back online until next 
week so I wouldn't be surprised if this hasn't been merged yet. You can 
always check

	git log --merges --grep hn/ origin/next

to see which of your topics are in next.

Thanks

Phillip


