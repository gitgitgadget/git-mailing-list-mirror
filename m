Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984F6274FD5
	for <git@vger.kernel.org>; Tue,  9 Sep 2025 08:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757408034; cv=none; b=ezHEb+hSxz0GhL1/qMA4anZPARBOcRtgZLLGkC2zf4t8miHStVooFPWd0MWlfZKxdt+csDmIUjN6UWi3WyAZlf1ueqeSJ2mTWH0cdqr5UtJQ3dSyYTVgmGayYSOd6MtUFVz8OK7PUqN/4/kbIDGh1m63jaLt2jfcyGuZx4C8TFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757408034; c=relaxed/simple;
	bh=1FpyAQZH5i9By0kCNwy2TPGqg2VvhVTF1oGXishVuIU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IoSGh4uGcwOoPdPgH3IK+3TGVdTNcw+rEtzfySOpWyHaHdBHjsAM8zLi8oiIF2DJLpuN+SC4NWn2MwK+PQ09I9j9eh4k5p0Z23nhbto6Ey0V+pTTgDj0hZFQfWr9F4rcIYZieNDNEdpsH/9/NH/iOvu/2GbaFPvGZAheJqwIwFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IDlCDodx; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IDlCDodx"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3e7428c4cbdso1435454f8f.0
        for <git@vger.kernel.org>; Tue, 09 Sep 2025 01:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757408031; x=1758012831; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=YBCAmOO/Vuo6pKnMpRgxRP3C3ZF7x/txFsCoiRukkcQ=;
        b=IDlCDodxXUOR3p2TyIJuGIwfWSnOrQKsCWHMRl7PwgGjpMG4Sqsc11TEoYV3S+e1zN
         QZzFlfDeyJ5nGZF963VW8o8gC2yuvzcCx+1ZDlZDPYZsAG22MYi1kG7z0d4vmJKH/1aG
         Ik9olxU1SGdrBDlmI8XgCDa/1PFQxp+1lGl8niIDQf7XsIlSr6Mr0gBbypAKi4u9sXe5
         kka/528fFVWvihjwHYZs5NJz+i6+xUiDs4VloorEtuaef4QVrC0nueUUM9yslrbOLrkb
         8QrhxSXPXJb6aLCyT+cml/Bx/sIAmDgnWj9SUQb0kYhzGwk9FTuVVPDnmG7x5EyiYfTL
         aonw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757408031; x=1758012831;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YBCAmOO/Vuo6pKnMpRgxRP3C3ZF7x/txFsCoiRukkcQ=;
        b=BFTZYqK37jEMLZkCU6J9WCbqqjp0+rdO7cx7/KopyYv8jL+NqDyy+Epz/N+cSZbAE9
         x4d6UB2MXyl1gEMx+IkJoWwYtA5fzxrOlYbZHPYtXa7VA74QoQZODC5b8dbRb8E20Kq0
         CwPKsS8hvrzBvHwDqw1PhldAH+cNrWVdo8SbgG4XDa98QzApRNWTccZZERJaz/GUAmuP
         2V9d6Cw5cnEED+7ssW8sCFnNShyOnxRZCHv3eMJYdXHcH/Q9ywh+RueoqiTpl5dsZUxD
         vmDLYNpEqbyYsVsnzYYvUVEGPOPEqIIMdNqS2twhcgNK6NVANKD2xnNUhhg39u1Lx8X6
         zcoA==
X-Forwarded-Encrypted: i=1; AJvYcCV0OrTm221aIH+qZFiYc+O6XUakVh/Id86QyKhUH+GUS4hcUlM6hBv9qtI/48VBOLMulGM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHZrIBgyUW1wnD2VBKJTJBmFnUO9O4bOEPD/xP7/50LMyZOlln
	KXme9j7dP51LDLGXGp5hG6U5eCQaoA6jABjN3iKnz67kqtt2d25wriW0
X-Gm-Gg: ASbGncsQZ5L7i1n6hOelLJs6NPMBGStdi44My3rm3+9XcBUZE3xGPsdXKoZKwUCkoCg
	DprJ4nEzKcjVa9Am77Vr8ZFbUV2ffDIMLt8vTsHI5SyN/y79jMsVb20oUOUv4Fqs8LCxB5f4iKS
	BewuQrxo0Q7wNg0dQWwU5EdWTx8f28nhIGGaXqJ5KbkaDmX0wq6KoA5z+aoqV+roKj1qgd0xDpj
	QgNgeUajSI0qkjwXqgl90XN48OxXR2tkQbNB9wqlELzPMFBqMUYaZr7nqa3eXlbDt+TRiibZJqQ
	jgx0vbioOTrHCFRIh9pFpQC7Rx4yEefv71yo4BNRys2rBRskEjqxtgGG4WHDO9vZBtUhEuv91N7
	jxyLsywrMCsXP3m2I7b5jO+8ufPnWer2xCH1LoruhnjIqfPqaf1aKGMnG2sS9VSKBubfcPZgrfc
	nADWIchtJK2ybFxo0=
X-Google-Smtp-Source: AGHT+IG6+sWMgwjWwN6r76MzOM8eCD/uQ0PlIKKrioqNK4AyKsDylujOcHeRUpbiWm267h5vzWk9JA==
X-Received: by 2002:a05:6000:24c8:b0:3df:1a8b:ff60 with SMTP id ffacd0b85a97d-3e305777eabmr12437299f8f.23.1757408030639;
        Tue, 09 Sep 2025 01:53:50 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:1751:3d01:f738:17c2:c65a:d0dc? ([2a0a:ef40:1751:3d01:f738:17c2:c65a:d0dc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45dd3aadbcesm205074915e9.17.2025.09.09.01.53.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Sep 2025 01:53:49 -0700 (PDT)
Message-ID: <5290c591-fd3d-4737-bfcb-fc091751af1a@gmail.com>
Date: Tue, 9 Sep 2025 09:53:46 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 2/9] submodule: create new gitdirs under submodules path
To: Adrian Ratiu <adrian.ratiu@collabora.com>, phillip.wood@dunelm.org.uk,
 git@vger.kernel.org
Cc: Emily Shaffer <emilyshaffer@google.com>,
 Rodrigo Damazio Bovendorp <rdamazio@google.com>, Jeff King <peff@peff.net>,
 Junio C Hamano <gitster@pobox.com>, Aaron Schrab <aaron@schrab.com>,
 Jonathan Nieder <jrnieder@gmail.com>, Patrick Steinhardt <ps@pks.im>
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
 <20250816213642.3517822-3-adrian.ratiu@collabora.com>
 <fc69ee66-815f-48ec-a5fb-99cac5f4d58c@gmail.com>
 <877by9ndzt.fsf@ratioveremundo.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <877by9ndzt.fsf@ratioveremundo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Adrian

On 08/09/2025 16:46, Adrian Ratiu wrote:
> On Mon, 08 Sep 2025, Phillip Wood <phillip.wood123@gmail.com> wrote:
>>
>> Does this need an extentions.submoduleEncoding (name suggestions 
>> welcome) config key to stop older versions of git trying to read the  
>> repository as they wont be able to locate the gitdir of any 
>> submodules  added under .git/submodules? 
> 
> Very good point. I'm a bit unsure we actually need it, likely we do.
> 
> On the one hand, older versions of git can still initialize and work on 
> submodules under the legacy .git/modules/ path ignoring the new one...
> 
> On the other hand, there is a non-zero risk users will get in trouble by 
> switching git versions or can lead to inconsistent/corrupted states, so 
> I'm inclined to say the answer is yes: better safe than sorry.

If we only needed to convert the submodule name to a gitdir when the 
submodule was initialized and all other access went through the .git 
file of the submodule in the working tree then I think old clients would 
be fine because they'd find the right gitdir by reading the .git file. 
I'm not familiar with the submodule code but I don't think that's the 
case in which case I agree it would be safer to add an "extestions" 
config key.

Thanks

Phillip

