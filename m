Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3B22DCF55
	for <git@vger.kernel.org>; Wed, 25 Feb 2026 16:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772035405; cv=none; b=uEEvidt+3kSL7aOk8FiTsMkKdyhRUX+cK8dATDjUtVsh1ByT/5zEHeGh7qxkWtRRO+BR2+a01KsZtMgVXPdRF1JSIhfk1x88JTNUY6B3ZlpN4JD6WpVCQ+241ZoykY48gIWnNi+ar8iqLDQlhZun/hYO7B0e9dTkP5+ajhm1wIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772035405; c=relaxed/simple;
	bh=mRB0EUGE/OBnK+YxY6KEYcbSPK8z9aeeA/Gxn0EKjw0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gWRulCpavijGjaNGoxtf3y9Ist7GgSh1cCP78s0qSWm+Y7pGtFlGkE9TEzjpxPirSNktJbj/LVxhNUTqF5tophA9xdgD9tk043AyumqYDUiOsOdWIO5ucVk7fYc+wiaIFU5haMdkbKtq6X+ubYhj1VgUjvylFXkzjijMRg4cPqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iiZ7ZRV/; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iiZ7ZRV/"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8243d189704so305147b3a.1
        for <git@vger.kernel.org>; Wed, 25 Feb 2026 08:03:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772035404; x=1772640204; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MxtyuXCsPg+7zUWFYhO/dmAPBBGTMwC3DmLjEdf08/A=;
        b=iiZ7ZRV/9AhIo1IZi4VTP9/05gBr67JiGMuFfxVr/5e2B48X4eMWMYeCsLkobjW3T5
         xO4uHgkBWZqDqRxEr4DfKYPUEyiVdF4qGOtw0JtbGbwplG2EOmIlH6fQAqKhbjtyDlcb
         Dtm/KxeNbjj7iuUAjZ4F3ufpfcwxGb+dXsmtGIsLAk2EFcQhSIQi1y5HZASrOTsP1Wn4
         A1wAGL3yXSicNiV/EkrZI6mn2oq+mVNjORwSE+qyuJhRcYdPTn1RJ41bhO3j2tvMqwFN
         empm45U9MfFvigsSCnXJNZ40GbFi9mElyQCbz97G0mPLInhmT+0j9i9e9qXqss+JOhg+
         stxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772035404; x=1772640204;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MxtyuXCsPg+7zUWFYhO/dmAPBBGTMwC3DmLjEdf08/A=;
        b=MitpMhcgQB0mDmBCPVf1SovHQXwlPXuN0QNWHolXZ+Ze2jJbq3bfN9AwiI97tmXHE+
         aBAc/y8NMgFKn3RVf10/LVnS6+XyxajsyEHDVouQ0HBWspe9FWZ2XCjgW+Df9nzXVtmZ
         JTuFHcHW5ivWm+SbqRPWwmgkA+mzbHzJlkeQIZHCeNDsvsdg46KK2xGq0n5zdsKvnR2O
         5Ln0Nt4qBxexRNiu4+BvmCe8uqILMFD+PKoI6sSEWk5twix9dLv3mOxgVfVOSvJKVRWg
         TrTqQM2O+fXKUOq5sVFe07urm3KxDIdIxBHwjOQ5foEBm4yWfF2x7LlGu4fzy+MuNLSb
         17Bg==
X-Gm-Message-State: AOJu0YzYFGQ/DKPOfGqIdWa6Z9ARZqrHZL4dKAsumIpsAXgEpI7b9cQT
	kM3nurGgaWNltLru7E0KwH7UuEjnAHCkpEGUK93M7ItdC+VwqCcNikj3p7PuVg==
X-Gm-Gg: ATEYQzyRKsOGnjinmBkh7h22ihXgJRPGmyZv6canEXBeaDSmM87mokV+9nyrFVryfq6
	Jkw5nBy/1EN1rvyi5O95z2CbgwZ83m8pRCkCrhiuUqWxnWU056yIY4PIsQqTSYfxMVgmioBYUqd
	aMaGspgqHhziF1EdLZzvS3Iu9e8elwhFFTs6AGQfiDaGuI2zpvWEdvQ6GlnBdJ/moW2AqGF5NQh
	Y5HUXqb6dU8LH8PZJ5rVm9eIrMzXzghMTXsncWxY+yjTAebOaDeSmRAae6ipUwLo4nTFHSaDrIU
	4SG5pESCJbep73lHn+mf2M9Zi7736kvqnLOoMtC4bKHiRgf9SFGV4SAgfMa/QZ16hhAAy8d9r3P
	974O/ajQC3WNPeHwCYWZRfd1LCOlk/yXG/9iK36Lo3lxPJy2KeVLXUjIz0Wh1fZwol/egg55zgJ
	wxAva6G525c6yF3AMXkvELJQoeUao=
X-Received: by 2002:a05:6a00:1a92:b0:81f:3940:3aff with SMTP id d2e1a72fcca58-826da716025mr9480791b3a.0.1772035402816;
        Wed, 25 Feb 2026 08:03:22 -0800 (PST)
Received: from [192.168.0.109] ([155.69.180.3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-826dd8bf9besm17407263b3a.55.2026.02.25.08.03.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Feb 2026 08:03:21 -0800 (PST)
Message-ID: <28bf5b66-8c08-43b1-b472-acb97c8f0eb7@gmail.com>
Date: Thu, 26 Feb 2026 00:03:18 +0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10] setup: improve error diagnosis for invalid .git files
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>
References: <20260221083001.220061-1-a3205153416@gmail.com>
 <20260222102928.377519-1-a3205153416@gmail.com> <xmqq4in8quxn.fsf@gitster.g>
 <xmqqqzqcpatz.fsf@gitster.g> <5263825f-163c-43af-bac7-152d670919d9@gmail.com>
 <xmqqfr6soxjq.fsf@gitster.g> <xmqq7bs3piz7.fsf@gitster.g>
 <a2b2e581-18ba-42ad-9bf1-a3e16b85f4e9@gmail.com> <xmqqwm03mfax.fsf@gitster.g>
 <e48c68ce-de45-4d45-8bd2-1307686a8910@gmail.com> <xmqq8qchcz9w.fsf@gitster.g>
Content-Language: en-US
From: Tian Yuchen <a3205153416@gmail.com>
In-Reply-To: <xmqq8qchcz9w.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Junio,

> Sorry, but I do not see what such a change buys us.

My primary concern was the function's semantics, though it is indeed 
redundant.

> Yes all this happens in repository set-up which should happen very
> early in the process, no?

Should be like this.

> It is a bug in the way you wrote that multi-threaded git server, no?
> 
> We have the "_gently" variant for such a use case, and I do not
> think we expect the normal single-process git start-up sequence
> should be reused there.

I see. Thank you for the insights. I will drop these overly abstract 
ideas and keep my focus on practical fixes.

Regards,

Yuchen
