Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D6B157A48
	for <git@vger.kernel.org>; Thu, 21 Aug 2025 19:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755803973; cv=none; b=LEES+KTooFEY/hU/7wx6xsspZFLBwoCVG5/xNXMh+DwfVTveUr6FZPoSlEasHwgf1eB3tzJsK3NA26TiyAaS0go6Uk0uQY0dkxP6mx/RzsbdQgk2wPKVYgdBAEwDd5mzDn2W/Oz4+GTmbUAGaRDKLlypTicXkovmGKILwm2I7F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755803973; c=relaxed/simple;
	bh=AVEgebiBlIvXallX648YHKGs4BLCzMSGv9lVR6JRRCg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rzk5etsCIoy4cT6EzjqBmJJhc9yOxmCC8nsf6YPsISnTNq5aTKV0bP1Bt34posAvx265IhVNHSudGAN8oCBOdy2qOnrlo6315TaxxxdFKfvpXHi6fPdWsCUJZWpZKSohuc6ciAquMBYMaaam2Fw6lNE/DnHJRMhhsLxP1D4+GZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l1xfUhm7; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l1xfUhm7"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-70a88de7d4fso12130396d6.0
        for <git@vger.kernel.org>; Thu, 21 Aug 2025 12:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755803970; x=1756408770; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AVEgebiBlIvXallX648YHKGs4BLCzMSGv9lVR6JRRCg=;
        b=l1xfUhm7dR5MbuoK0hi4SKpE0KVcMA2SRlw79bzFUuvqCzH8Y63FSi8HkLmGgwLUyJ
         IPJVv568/+aHbsuKzSzQQDqAhSCA10FeFTCGcrtifxaUBCcI1rPkvm+57bxqgxuXGwul
         VejLqYe5Yy9k3WknpiTeIiAhN87UVuWnGfNFZa1tWmM0LaIDell8TybK7jovhdax8oXf
         8b1MlEHc9aaaDuBPJvZg3ove077ybQ/HBbxrLdqmhSqgCLot0XmOcSKEQiETrrqoUVQP
         cn8o5lGxvJyzVfuonsqAS4BVVcJg/ICqXMwu8li8gNBmw3zJkrqiWrYnXtStyKJAtq3C
         zNxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755803970; x=1756408770;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AVEgebiBlIvXallX648YHKGs4BLCzMSGv9lVR6JRRCg=;
        b=dT/tyalvNv1AcP1yTMu+i9ZUGus0WX+od5ht5iXh3YSid7v1i2SpGsTBTYiFzpZpBH
         8j95BnXuDbxNkytpQ/6O1tpCegVNP528Wi7pG3gwv196NyTIJ/4ccrlaf2Fo7rLOHyAx
         FvXJoBd76I+Y00ICqZuOvXsCnl53n+nz+APlADGAzFtTcxxS1vMM7fWb9fu+VMI79ZO0
         Mxw+zXxbDhLerGc3hk6F8O8FyKkuuw6JmFreQQv2CTlJ5JGj8rve6mlJcym6xHHVPnDl
         0Ll569pUQz0LihJ9BLnfAlRgPmfcEgxkFAy5Nfkfr2pnYcdZXufEW62JtB1VDiwpFz4i
         pYAw==
X-Forwarded-Encrypted: i=1; AJvYcCVsTcq2xktBrHwRj6n/SefW9Rz4UX6GIA/XlSwNqUaqmx+FP+BQYwEQcnx4vgrNTCYiCX0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yykonh6Pil6RgQi5IHxSb2UKUG5BHqZ0ST3rrT0XYLDZHhDbh2P
	tnMLe/G7Po3rqRtqRXG7Sn/quQtwp7x/abZAIaLPEAJJ0bwjqJ8ZvvcH
X-Gm-Gg: ASbGncsmdfRn5v4u7B3nW2N/+vyuI6ianpWYb81N8oTjVtOwwU7bvSy6VGjWGueJtRw
	OkoNuUvMQjJElzflM1vozSSaOswJx8lkrIwCh+fGC7Vnc+2rBkx7TrNEGClwMeCJ7ntO3fslbL2
	Ng/ocm7ONko36zErq/nwwgn2C9lS1bzrSnFa3m3BK1TJaI60E97u8fypl4rhKSyrMAH9VtPvSqD
	75AMdLA48gICnR9DTXJyuUcVJsQrdA+bo6ACUd3JPuD8PRvyS7VLntdpjepS4C/+AyttZJk2ggd
	GDAFPev0M0LncFN5OEyP2D9STiCnDpj1dIbwlDw5ePyE2wcPPDAqCXa+AEUD9z5nBUkMjdY2En5
	x4YYdzxcxjdouyXMJ/lc0ni+rbQU8OejLvGTaDuv+Gp7M6FEmhyEiuBbS5c/EYeoH7FVlk5lxXg
	==
X-Google-Smtp-Source: AGHT+IFE8gsIO3XDvTq5gT29fG1miHuFxD8fFnWnF2b5H7/q/BAVIB9tpXKP9H1Gr1GvV4BDCljGLQ==
X-Received: by 2002:a05:6214:f25:b0:707:4b37:f6c5 with SMTP id 6a1803df08f44-70d971e5a14mr7905346d6.35.1755803969977;
        Thu, 21 Aug 2025 12:19:29 -0700 (PDT)
Received: from [192.168.8.183] (pool-173-73-185-17.washdc.fios.verizon.net. [173.73.185.17])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70ba9300edesm109189806d6.43.2025.08.21.12.19.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 12:19:29 -0700 (PDT)
Message-ID: <e3e52b89-8f4a-4efd-a29f-3967d52440ef@gmail.com>
Date: Thu, 21 Aug 2025 15:19:28 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] git-gui: simplify using nice(1)
To: Johannes Sixt <j6t@kdbg.org>
Cc: kristofferhaugsbakk@fastmail.com, git@vger.kernel.org
References: <20250820152451.20872-1-mlevedahl@gmail.com>
 <20250820165021.24604-1-mlevedahl@gmail.com>
 <27f95ac2-380c-4334-8783-4b3b9ce38e24@kdbg.org>
From: Mark Levedahl <mlevedahl@gmail.com>
Content-Language: en-US
In-Reply-To: <27f95ac2-380c-4334-8783-4b3b9ce38e24@kdbg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 8/21/25 2:59 PM, Johannes Sixt wrote:
> Thank you, that saves quite a few lines. A difference is that `nice` was
> looked up only when needed and now it's on every startup. Personally, I
> don't mind this change. It should not have a noticable effect on the
> responsiveness.
>
> Queued with an apostrophe in "let's".
>
> -- Hannes
>
And, nice was always looked up on startup if a diff on anything was needed, or if running
git-blame was asked for, which for me means always so I see no difference in startup.

Mark
