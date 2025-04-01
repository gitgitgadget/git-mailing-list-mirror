Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69236194C96
	for <git@vger.kernel.org>; Tue,  1 Apr 2025 16:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743525877; cv=none; b=MQuPnLZlCFYtkDxCsGHYfvTNle+CSf6a0Oj2jb8Ujc6fV68mPAJ+Hiro4pGnyyb7DXIRSJj/PF66L/Rxr0iz+iYLx9jxUT+UWojtPa0o0qf5zjBYXlcMZcheJxgRmDytxAzmWSOO8dsp2RQuAXdmRuc+ky2cqpd9x0uGFEmjjPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743525877; c=relaxed/simple;
	bh=o/7mwvOdZkfJZftuHzH743vbCM3lk8PhCSnu5U5sUqM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cO99otF3Oqvec9NcmawZw2wb+wJCjVVlqPRljuA4jvUvTdEIKS+rquDD9EvawBVH7/c9CwBRv/uu35JEI99obf3a5W/lBhRrv844nBHCDMj9LWKFFCl3KkwPbRBl4nhdTNzrqAB8sbiL7yucsgmneB4Nt0NS23/v8TCq/Mw2kJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BJw4gRRw; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BJw4gRRw"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7c081915cf3so726081185a.1
        for <git@vger.kernel.org>; Tue, 01 Apr 2025 09:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743525875; x=1744130675; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pzvTKs6wNtLMOPdp/im1m6PjdDQ8huKicwKyTc57caI=;
        b=BJw4gRRwlsuQzUvqkhzVeeA0NrF1Uaj4flDJtQzKFSxy9KJocU0ulRc1+ac/Qj3Y4f
         Pf+Me1Jz5A4+4cNlI/UV0Nw4QVPTkeCrsqKCzFz8tN/eSwcx4+kna5cIS+liBwK3RnxB
         LtjKe314FiXmIu6TYdmk9/k5Asz4vnK1pwvL0Wl4ru3SHGCwAUmTPkfrZi9cD5c5HbCd
         q9Rbobi2VQRafLygouYLi13w4Tfriek3YzxErAHIuzFxZ2P4Pp2kqpsi5mGfw9lmhx1A
         mFyIvL2Gomi75qeXLz70rruUg//jtfYyQaRB6my5CV6bJjTyLVXjVn81uUO7bTiSbhCK
         bIcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743525875; x=1744130675;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pzvTKs6wNtLMOPdp/im1m6PjdDQ8huKicwKyTc57caI=;
        b=wLG/7UC8PJ5BzLRNO5tFw/SRvDiHIPB/685MYzzXQm+ToMlTMZFlYsjAvJg5D7XJQy
         HBiu7OY5/D5x75pDAx10B1ux36UvBq0J/Z9K0GAUvcLV/ZuoPqWxoPtk1Wsig+Mg0SEx
         GsPRladxCPaskvwShQt535yJ8R10/V6PFIIdca2sVn8MjR2vhYlpulXMMylqj+wFLEQI
         FBpfARZjzDx1BI6z4fYTBPKk6y6jkVf9ifr8lb/4fuyp+1/cHmpSPUv16QPtCqNwdfhe
         2PR2XnRUDChpovhx08DF8dK6ZVAJcXHSZxOKwmw4C9v2xasDWBDOCcIUUtYxp+z6rgZg
         JqIQ==
X-Forwarded-Encrypted: i=1; AJvYcCXTesIQNv0JDbgk34aOl2iJR+3NWvNTjpK0kjCVwiyvQB9Jf1wV2MK/HLr0cuwM2mHNYHc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHaEYiwQ/UXz5g4JGGnYlAsnq7FypuqBq8ND/QOI6+O1e5IO+F
	lk0W7eflYGS0dzL9ZbdwrbSexFJzCh+CzJ9ItHwTAvhzku+8zGW4
X-Gm-Gg: ASbGncskcwldIJHw62vJT5l8dcBLMKFB8o3GUnA+rFAGimja/RBsr7yvLOhwAQhvj4L
	d8RbQGxgjpcdKbGNRyJYa8x7Mtewoo3H5TS+tSfV+3E4YttBVwJWQnROGhieLMlGxhQ/N8acY3v
	9S+jZykzZP3XKZ/Kwxr69b9zisgYSZC8thDRc4FQ5nU+tqi0mj3dFhK1k9GusClx2GWBgX4cagT
	dctOh1N14v8RAOSHV4M24ztnpf4NG+uFQdSnORbLCqbzQtp1+gH/ffm1N1R3AdHRU5yB/DcvjD8
	rgKeoQYOyuyl4fveq/74oyqm4MoGYjr5IHlNHn9x+nB0fU/w8ElK7sA=
X-Google-Smtp-Source: AGHT+IGeascTa9L9biNJRJsTPgmqpbzcuisfLsWKtpjI045C/8Sohy1Lul0zdSvFCg53KOGhskAZdA==
X-Received: by 2002:a05:620a:4555:b0:7c5:49b7:2372 with SMTP id af79cd13be357-7c6865e89edmr1674070585a.18.1743525875177;
        Tue, 01 Apr 2025 09:44:35 -0700 (PDT)
Received: from ?IPV6:2600:4040:2644:5100::387? ([2600:4040:2644:5100::387])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c5f7764e60sm676973985a.86.2025.04.01.09.44.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Apr 2025 09:44:34 -0700 (PDT)
Message-ID: <5b0f0347-ad75-49f0-8df7-653e893c9a52@gmail.com>
Date: Tue, 1 Apr 2025 12:44:34 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] gitk: override PATH search only on Windows
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: j6t@kdbg.org, git@vger.kernel.org
References: <5b09f1c2-be58-43a2-9908-7243b5207251@gmail.com>
 <20250401030102.297272-1-mlevedahl@gmail.com>
 <3c42af3d-556f-9593-b715-ea689d7b508c@gmx.de>
Content-Language: en-US
From: Mark Levedahl <mlevedahl@gmail.com>
In-Reply-To: <3c42af3d-556f-9593-b715-ea689d7b508c@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 4/1/25 12:10 PM, Johannes Schindelin wrote:
> I really wish that the reviewing process offered better tools than a
> fixed diff for this patch; Inspecting it with `-w` would probably make it
> much more obvious what it does (and make it substantially easier to verify
> that it does not do anything inadvertently).

Agreed. The first patch is nasty due to indentation changes, git diff -w 
is indespensible, perhaps that should be available similar to a diffstat.

Thanks for the review.

Mark

