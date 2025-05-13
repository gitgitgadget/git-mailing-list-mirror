Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AAFF20C461
	for <git@vger.kernel.org>; Tue, 13 May 2025 22:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747174963; cv=none; b=aX5iIXgUu5eXejM7s6l2SjusUPhBP3wMsXnR7Tszt0MK7Spju2+zv6O7f7tmyQ5VUKEFuPqcSxqQmX2vf2eQ0sNQ3HVmLM/34CO/5viZdE1zangoziCAsL/W4QqOVAq6Y4flQlYv9hm5Z537Lb+2HTZaBYYBOsGuttuacARt0Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747174963; c=relaxed/simple;
	bh=cGQYoxY0lX7K5xYcfyTksp8IhadvO0bSUH5ndOjFvxk=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=ipD4MiynNN1Cg7XQQe2V/7rJkYDAgg+rp/UF7bFGZS5achqtsuYhv+PyuZA212lH5CZD0IMgtJQcp8ENBwmIflxVkmay1fq8O8nLUdUARfxBwj5DzvhIjkZU4+dSOD95kXtOCrU2AP8tMHUlThz+Yx8f54vZdkdSJ++/ERQA+oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NkrlvQ/T; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NkrlvQ/T"
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-52c7aa0c371so2124731e0c.2
        for <git@vger.kernel.org>; Tue, 13 May 2025 15:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747174960; x=1747779760; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cGQYoxY0lX7K5xYcfyTksp8IhadvO0bSUH5ndOjFvxk=;
        b=NkrlvQ/TCpPPgcX5VDoyBcmXTj91K3J0lsWodbGAcsMqZqqwganFSbof2fNVq8FtNp
         W5vcJIGA9pV8uc72LhmpSPdu7+Yq01IwDV8sj1MffNEo5Gjr6Pw+o8v1GsjExyGXHDz7
         UkYF2odTR7AnNn2BGa2TvR4/u8JTDla/8BWX8GGuOG59b+66OPFqJQrCSSFI6S2WDm8H
         RAVa/xoiuCtf22ZJbqC6tzBarg7HmK1cGNKPNwCJbOM0yBsUxNUqYvBalNUTH4Xng3fK
         yHjiiz9UWNdzYzjCEBSh9mqYsnGZR/Vku8ZSl47mQC2/Cm5urV11y9lL1Kt7nf490VcA
         po1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747174960; x=1747779760;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cGQYoxY0lX7K5xYcfyTksp8IhadvO0bSUH5ndOjFvxk=;
        b=C1bt6l6/zPg1r0snsopkm3TwcsDXK84UCoEhXH831x/zkSdDfWZj4xTzuFLbjwqxYx
         M4fokHTAsoAwVY+vxMJ37CbP703YqggOZrHzoApoLswxC4NmtxNzqIzU6ySRKcPwGxZc
         YU/gvg4YNnoqFMXxccovMQ6VL/O6HaRR05BlQo0MCtLBs9v7mYTN+OdXPDAKBmU8qFUR
         GuplAHzO7iN0kPAZPpnFwwLWRRjgxJlf2Y+k4DIT9PnGhl7sqM5bNyK17hqaAGCb9Uiv
         TZ6cpviKjd/JGuV2g1lFNzGxjpuiiEAqc6/uXfJnWkZly4VKC0z0K4rFW3Dx70/AjxeS
         K7Vw==
X-Gm-Message-State: AOJu0YwiXUpE3sAuQDnNulcB/2oJNY9cEji23HUQXgLRrGsadZ5YMoLj
	mQ3gAsf3Dl3G1q3+ga9awGLlZNcFEUwmqk4rq7Vzo8rO8J/qvSXL
X-Gm-Gg: ASbGncvHV5r7gTHehPAnKJw/FgjYOlL6FGkGU5EL4tO4hjTaHW+tAlCHYDXnPZwJgoC
	2jylCcFqOtKfjKjsrVXC05/aLQDnX9C5bj7hjxIruSu6w5u0bj8/M30/ouw3ppbPLCIYX/7DMQj
	QQsTXHOfilLw0Bjx3DnvDNyn13I387JNaQkGdLNJG1Z6/Vx37lmOeZkSBVCzAtDl/7NJm1knRvb
	pg0iPVrXUaZTp3Z/9wMA4WQDfeEyJ2ztu2PnUkC8ETEMdOaDCdrPng3fIM3Xz5bMDlnpS2q2R7r
	AHntJSoEat6if3kZ0GA1QGLFyFVHaThvgiDhCWJV7wSMubTeQxcL3/mBIMPMuKhdyU9DCI37Z5w
	=
X-Google-Smtp-Source: AGHT+IExVzR2ued5YK1nevM7hZIPBlcY3Agqz0feluIAkenA+8OWhHaCCiuGXjfl3O9e0qyXy2527w==
X-Received: by 2002:a05:6122:65a9:b0:52c:5590:72c9 with SMTP id 71dfb90a1353d-52d9c5f2061mr1165461e0c.5.1747174960147;
        Tue, 13 May 2025 15:22:40 -0700 (PDT)
Received: from smtpclient.apple ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-52c538a7156sm8382792e0c.46.2025.05.13.15.22.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 May 2025 15:22:39 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.500.181.1.5\))
Subject: Re: [GSoC PATCH v2 2/2] json-writer: describe the usage of jw_*
 functions
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <CAOLa=ZQooC0TsjGG109MY_njoTm5GjW-WNf7-L2W6BN8umRL2Q@mail.gmail.com>
Date: Tue, 13 May 2025 19:22:26 -0300
Cc: git@vger.kernel.org,
 gitster@pobox.com,
 ps@pks.im
Content-Transfer-Encoding: 7bit
Message-Id: <F862E606-C784-433C-BAB1-283C678E20D5@gmail.com>
References: <20250512020935.73140-1-lucasseikioshiro@gmail.com>
 <20250512020935.73140-3-lucasseikioshiro@gmail.com>
 <CAOLa=ZQooC0TsjGG109MY_njoTm5GjW-WNf7-L2W6BN8umRL2Q@mail.gmail.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: Apple Mail (2.3826.500.181.1.5)

> Overall this looks good, but I do have to wonder if it is needed given
> that your previous patch already has documentation for each function.

Agreed, it looks like too much information. This second patch was
created after the review of v1, and to be honest, I think that this
overview is more clear as it focus in the what we want (write a JSON)
instead of documenting each function.

So, if I need to choose one of them, I'll choose this.

> But I'll leave that decision to you.

Ok, I'll keep the second!

> Thanks for working on this!

Thank you!
