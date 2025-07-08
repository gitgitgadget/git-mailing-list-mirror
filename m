Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D472EEA8
	for <git@vger.kernel.org>; Tue,  8 Jul 2025 13:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751983184; cv=none; b=aSDWzttUHmmZLLBtzopvf4LccvBE1NzgelwGSNCAAm8hfyWLaPU9oZp+K4s7eKVI3GyviMq8crFA9oMEyOdux3IGcFa3X3lFJ63wHSHpaNcOqZd737580ay1E487qmgwy8RhhgHQV17U+lYOL10O1JqO8sIVXcIXk6oWx9nUvkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751983184; c=relaxed/simple;
	bh=x47Oax6XaFdzA77YeQmn42K7iaYsI+IiDrWmlbHSyg0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y6Fvelx8qoX3PJ6uBBkXEZTa72mEGkR07W6bNjtohyspg3XB63o2ivIJuHSPitQzoM3NFY4AayCO915dtwGiEFh63khvIZSD8wVLBoxcJj+4hAi1tckmnKdnRN+lDthdGJdsSRxD9rLYJJ9pM+zOZBgsW4Fzb0+l9/RHOeulIFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dsMbVxZl; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dsMbVxZl"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-451e2f0d9c2so32202615e9.1
        for <git@vger.kernel.org>; Tue, 08 Jul 2025 06:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751983180; x=1752587980; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QbHBG8qDq10apHR5c7bnNKvg49E92pRjpce+BLFt6fg=;
        b=dsMbVxZlTgmtasSDu5y6iAlxenrITlB5pgXv8zWjdaDCV9M2k3fbEnI0Mqr8UbHaQI
         KS211EayAudpAm3kHMKyyGzMRCU/9BhDY+7bT2TyEFJNKG92A/9KtuDtqdc+mOgbbvxJ
         ImRIGT4U64CZvLJZPG/P/M36NrkC/PPZvUWwxHWAO5wnBTKNJ9qlVpI+nnXz97GDezx6
         2mSW4HbYyI/hU3Us2d1Aj5asHFO9BteuSmxLVRwwFOcH+ab99wAd85VNtxEe6Kol5EfN
         8wDzGv0N+bPzJrnAQrccRh5RVVNsK7amYQszuRK4WSeHkWZ7QYXRm8UjNmxL1DQnPSGn
         WPMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751983180; x=1752587980;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QbHBG8qDq10apHR5c7bnNKvg49E92pRjpce+BLFt6fg=;
        b=G102/9lhBxV01MqfwL624R60GR2krmM1TLmNhMba6s+Y1hfPMZkMngCgjlPEIeOC3K
         8GgU9WJ9R1nStedMPFC2ELOpVD4PQ13zTFJQ7SY0WJjPZVp0WZ9Zsmi6QkQBaefUhRBg
         1W71FeioX6HYn4FMTZXZVTINJOiXQrDex8oKcfVa++LCP2ob6ZHgWrjn+5SZ0aN2KrgX
         Zkzq9MKhZTVpsJyGG9fah8bE44SbEB623f6rAyeNjZmfVOIVlXbLdbc7yCAUB0Ugx2gk
         JgZUUvg6/5+j9dFRrann9NzM6gldVUdb/pSAh9MFhxHEm0b5GTspQ6gC3uTmoo32BPfW
         E4bQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZfnfVJf8FrT70stdpRhMZx5Mx4obdX9X2CSWSnO36QAk+7dAYRUMj8FauKrYr3xTMaVw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRaJo9BP6s837xIpI1QQ4etel5ylJNIL8Cv7ZRN2VegJYgq3GM
	fV9RxLlUFr5hJDylbus5d00rG2T6IwzSBmeTtSfma0f+4YkJ254Pv5CDPKsinQ==
X-Gm-Gg: ASbGncv5lMRtDJVLwVjxE468AYbz5On/j3UJrxedImi2g25/EMKoe8Oyswji2nrppa2
	mrntaShk51+GSK3eIOusJqk9rsoIK9oK3snbRkgvH9Ihg7VwyjZirINFxt+AalzSgfagsSOAHcM
	+IR7rN7hctIX3eUaFAO65w7whvl0n8DRfJW2AbmjqJuzbhap5A4qdYNJbRehHmwCHND//mY1BjT
	Ds2v89wN64VL4kqa3dGA77a/piEkW5aAWxGODzDVWQjkEIa6CB04E8CkW/e/5wzAiBbF7NyP6vt
	GUT+7L8TME9WYWDG4MRRWxHbGO/I6ZLzXSyFe1OGdyAeRM7BCJiK95Gs1Bynd/84tRuq5hTGlDd
	N0/N1OybKugmb+nOmrgKYWppXId2oV3onY6c/5w==
X-Google-Smtp-Source: AGHT+IG8Vkso3fHzrqqDtcrRWJpU+YzcIIMXt0kRBuN7CEqd3UWH9p5MY2T6uEomtMSvYi+saWIEeA==
X-Received: by 2002:a05:600c:4b95:b0:43c:f509:2bbf with SMTP id 5b1f17b1804b1-454cd78f125mr20662175e9.15.1751983180192;
        Tue, 08 Jul 2025 06:59:40 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454cd38fb12sm23627945e9.3.2025.07.08.06.59.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jul 2025 06:59:39 -0700 (PDT)
Message-ID: <94caee19-b915-4678-900a-03095663e8a8@gmail.com>
Date: Tue, 8 Jul 2025 14:59:38 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3] ssh signing: don't detach the filename strbuf from
 key_file tempfile
To: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Cc: redoste <redoste@redoste.xyz>, git@vger.kernel.org,
 Jeff King <peff@peff.net>, "brian m. carlson"
 <sandals@crustytoothpaste.net>, Phillip Wood <phillip.wood@dunelm.org.uk>,
 Elijah Newren <newren@gmail.com>, Fabian Stelzer <fs@gigacodes.de>
References: <20250704230829.29696-1-redoste@redoste.xyz>
 <20250707184852.16010-1-redoste@redoste.xyz> <xmqq4ivn4t30.fsf@gitster.g>
 <aGy_DEehFgw4A6va@pks.im>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <aGy_DEehFgw4A6va@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08/07/2025 07:47, Patrick Steinhardt wrote:
> On Mon, Jul 07, 2025 at 01:57:39PM -0700, Junio C Hamano wrote:
>> redoste <redoste@redoste.xyz> writes:
>>
>>> v2->v3:
>>>   * merge the test with the previous ssh-agent test
>>>   * export TMPDIR in a subshell to prevent the environment variable from
>>>     leaking in the next tests
>>>   * use test_must_be_empty instead of test_line_count
>>
>> These sound all good.  Will queue.
> 
> Yup, the patch looks good to me. Thanks!

Yes it does to me too, thanks

Phillip
