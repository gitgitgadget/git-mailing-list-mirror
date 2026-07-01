Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F37E48BD39
	for <git@vger.kernel.org>; Wed,  1 Jul 2026 13:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782913073; cv=none; b=mCfmEQQa6EaKoc9IugVI4iGD022ic6IX8sdZRDSrO2QrMpxq4YaV5rjWdS8PoMXkO05LGYrCSIUFQS0hesFuYUiMk8KJyoNJ3KYadjpR+4xdtb4/bbN1xRLrisCr0T1lKpt5JFwJFpN5WqaCZcSbHRUj/nouaSGbzBbIo3TWxgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782913073; c=relaxed/simple;
	bh=46f012XekYWZGOZ4Ri5BSQet/fqRO+OfzyQOFE1sb2c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pc3Sfpfga/xUSVwtPfy5donadLQ7CH+7Ag+QJsPoZfnC99rZg0IkyXoiuZENHda1wo936WS+A1k9eHopaGV9WZ78jh3SltQiNQek3vnZd26rrvOyFNCl2pvZW2T/O9mgLpyRBZ6LKthZtMXzZ3uCMy7etRbP7NnpEKZ7ZCt+WaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BEvdmPAM; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BEvdmPAM"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-493bb510ce4so5050945e9.1
        for <git@vger.kernel.org>; Wed, 01 Jul 2026 06:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782913065; x=1783517865; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KC4BMOvMxLdBAaj4m+DDl+xXvzdvGEwDzajLY8Fpzqk=;
        b=BEvdmPAMfWqnJChf98Zsx3T7LU6665kI1OqSrKZoIq+eTJRSRKF27pSkYy+XHZJZy8
         HFPkbceYEzi0TJR4LCPEMox8iztWbB/QJuAI0n8GEUqMzc3Lq3GZfaUjcrMKvSdU5dw+
         B7kJYhSj8KX/Ys+MUgIoMaE52qAQr4jt4fhOkMEuhqrG3+LhWgbaPJuaHzkqEGxufji3
         MIoHHbTAYAGuowNxOU6StneofPo9eLHbsvr++R5GdtD+YlWQ5aFDIVyVnpFwHhXRCFSU
         i50sauN8ElErW2aonrr+r5l0hwyqwleY0wFrd1Ux3YMnFmTeVM2x7uYdM9/ebPF5iXbT
         VByA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782913065; x=1783517865;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KC4BMOvMxLdBAaj4m+DDl+xXvzdvGEwDzajLY8Fpzqk=;
        b=Y4WewcNBMVLIE1msm+Z1clxTFO3yvaF0jUz4l1HuMv9vJdexFVY9Lmu+tIPa+snBsV
         kH4WlQBH841pRMlzTyig2mAV+HDU5qQnly8zp/yIMu0iuLHspqc2epb38jEcHEGdZiR0
         XchvZTxzVGs5BgmY+3DiThldGY3cY2cXuMp7DZVybUhyN/j9PWKIaZ1WUiTW0EalmiYY
         1SYwLOSbKm7W+WwSzSnMbI/hjfjmPU+64vCYBR0CVOQV6E8pQLim6fDv9Pn8n1Ra1vVm
         Emnbw7fMkn4hVVd+SMKn+anFAMjcqX3/4/Q+8J8DX9KAEvMRcrEpM8RE++d+nguOHB9K
         9cNA==
X-Gm-Message-State: AOJu0YwR/KSN8O7JF3gF9BN8XJQViGUbq8Jo+8qmkpxvRN/vyeTzD/KH
	0Rb1eHPCKaUv6m/ZNLW33z9q/pglUovUmxx9g51KIi3Pl9JfVLXHiqinkZn6vw==
X-Gm-Gg: AfdE7clRGlLBWkNP1H/nWmJf2fgE7STEa7/kOsxPSMu8LLLIblhFrC6C8l6FOY9pcEO
	rEVN30+jVOZqHeEoJZEaermz1Q7eBi4w7WORRtdbE9bQNkC32okrNttRoMxeLlBErvgmthbAfNX
	g3H8videqKFcgycS4indpoXRswKrACf5k2IL2VVIVcWehGmhza1Sjc+Z/kWBU7gXp0cbQTt5yek
	YSjHvLJz/p6INAHYG8guJsICKEh4JKXNb10INrGt9m+96QSDaQz1erPg3fRMreuHVAfGMgXSmnX
	6vCzJ6LTa3kr/Vr0H3igC4wy8FeOBwC+KsaJ9e7A0SDGHJ5yRs4rW6HWeUoyuKrHJ4CBhdZWRLE
	4Qf4iLMtL57BHfBSHa2YWeE1La6nROokaLMzptdl1yhTMNGoSYHC2N39XWt/+Z1QqBRL6R2DNJa
	xdmHalgwXhgyYGW6PffOB9eOF5RELiDxn9TcDk72H2lqkTfNNPoCkSjhYkJFQUH00jZ4+Rw0TTb
	8enAQ==
X-Received: by 2002:a05:600c:4ecf:b0:493:ae5d:8c40 with SMTP id 5b1f17b1804b1-493c2b95cfbmr26661905e9.27.1782913065185;
        Wed, 01 Jul 2026 06:37:45 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:69a:b801:201a:26ab:8d41:fb43? ([2a0a:ef40:69a:b801:201a:26ab:8d41:fb43])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493be4d8f5asm115167285e9.8.2026.07.01.06.37.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2026 06:37:44 -0700 (PDT)
Message-ID: <3c397d49-58cb-4a2e-b187-04840bbe75b9@gmail.com>
Date: Wed, 1 Jul 2026 14:37:43 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 00/11] sequencer: do not record dropped commits as
 rewritten
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Phillip Wood <phillip.wood@dunelm.org.uk>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
References: <67dbfb5c-5f07-49b8-aa32-a4635c585028@gmail.com>
 <cover.1782833268.git.phillip.wood@dunelm.org.uk>
 <akSuP-IWiH2wPd6S@monoceros>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <akSuP-IWiH2wPd6S@monoceros>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Uwe

On 01/07/2026 10:38, Uwe Kleine-König wrote:
> 
> With my very little knowledge about git internals, this looks
> reasonable, and it behaves as I expect in my test case. I installed a
> local
> 
> Tested-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>

Thanks for testing these patches

>> Base-Commit: 6c3d7b73556db708feb3b16232fab1efc4353428
> 
> BTW, b4 didn't pick this up, for me it says:
> 
> 	Base: not specified

Oh, my script generates the same trailers as GitGitGadget but I see "git 
format-patch" uses "base-commit:" I wonder if b4 expects it to be all 
lower case.

Thanks

Phillip
> (and I applied it on top of 2.55.0).
> 
> Best regards
> Uwe

