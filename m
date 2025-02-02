Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3492F3B
	for <git@vger.kernel.org>; Sun,  2 Feb 2025 21:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738532774; cv=none; b=OE8rLXH7N/J0HLGTDRHb6AX1qVNIHeeVVUMRqbYVqHTzNBODA4WJGF+j9YP3FiRCLDtmygWt0qso/cBXASjHfrpVSvTSBQkzpFneGyvyoU9jffrMdd3CK9rcs7uhwKbNxDmiLcoa90J9iJVBtH/M2hrNABdGYo5eqnvsjcauiE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738532774; c=relaxed/simple;
	bh=rcMoazbtq9Ivyi4rYNmBq9ZVp8UmjFR9sbmUNMHj6Aw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UGu4JwxtSeZQXmBz2evfzxCRI8EAk79MwwlLFBl8FiemtqJcmCJTRT33iE4x9AKm3FUA5hObYVz1krcSCIhJwtlqpFuQreYGPpux8XI3IBj9W6FAIRp+/rvl86bdwwEQiYMQE9YAG2ojNetzRGiBpmSozi3Q2QjNtX12hY2Djws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T/ezIMBO; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T/ezIMBO"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5dbf7d45853so777952a12.1
        for <git@vger.kernel.org>; Sun, 02 Feb 2025 13:46:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738532771; x=1739137571; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rcMoazbtq9Ivyi4rYNmBq9ZVp8UmjFR9sbmUNMHj6Aw=;
        b=T/ezIMBOajak34EPxhG97+2TIjgJbTaMvBnZSb+CVXXHGPU++p+/29WvAhH8zSOitH
         rkVFEpseuzCt8FPFAf+gU58LDvmvii4s24eijqbVbjvizqkVKUKAvn2qwYnefo/HZvmP
         RUDKCbfRJSIP3X/3ckLuXYeIpXbwbdATMvzXJc0mCuLlQQ2x7IWL/I1rkcj3KvUECjpJ
         sjbt0pzMDWIcYnEp6rnFPr+r7gCcjNWdx3xR6tSwL7YxNJtsrCfQ5zTnjB552XP7hdBV
         /WD8OYP1b8mvtUdi7N8XACCYhaUJUVZ1zCYBySeKQqfvu+yRyU6yuK7P8G5QDDtwrINv
         PVhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738532771; x=1739137571;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rcMoazbtq9Ivyi4rYNmBq9ZVp8UmjFR9sbmUNMHj6Aw=;
        b=bxdPSsHdysXxPcCpvbodwRf6dLsBcsAsEEmN5SAVYqfHcdf/aVKIAc9vOQw5IdhdVN
         Zg7mfaV3sqCeZtK56o3PdcVkvxhHZXtMBpK3RF2W+gdzRJ5+0P5v1x3pCCgzph0LHM/b
         pqL+DdhHvY/lhvzwpqsmcpKybgaTKXWtyIVditeOP+TIFKwZQCnpg9/UwqsStaY1YfG+
         J16sKkrO0vpGtT8V7alIkU3HdmGsE4GWDDUZ2I1hgDwT7DLkYxLPAT4y4JRDTn0q4Gtx
         fy7t8KJf7iI9F/cPVWd/seQPmCVp7rMTS1DwPxl3DZqG7Lk6SmAmIDfWfknNIxXc3X/0
         akDg==
X-Forwarded-Encrypted: i=1; AJvYcCUDReCvRJfLFOWWh3zbeDu9untY8RD+WyhKVucfqijzfCeC0itxpYT7rUIwZ76YCN0Xamo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIojdOrBWmGrBAG4yvDQwIh8v2DTZMr5jxEsR4m8FhHrO14v18
	3V9D1ZNRGpsdjW2Fk5wOVsSWAevNvNDCsPrluoqlLJ8/70RObioCKKFcpYeTClp81RK7relUkQi
	W6x7IzH5HpiUARZrh5q38+CZmPFeNmG0ULrg=
X-Gm-Gg: ASbGncsg7z+D4I2IdD6ZKaB0WT6+kBAfmSUjCSCfwTbG2bJRPtQPkjEBsDy0bz9xKV1
	37NCB74pQ13MUDpATg+AUs5194D7fDDPPdL51GlH9XBEOlhNJ72zL/4NkdNnLFaY6A1n7MAhv+N
	ynbCCF3danwptTodSA1Iq17BgVKTSYlQQ=
X-Google-Smtp-Source: AGHT+IHRsOGY4HZxjKAOayReB6aADqkAeutOMrd+RLFa8dYtvmRrxi/qX7HSSkeEfAfPA6dF5nphZiMzEoxJV850hvQ=
X-Received: by 2002:a17:907:948d:b0:aa5:a60:ad6a with SMTP id
 a640c23a62f3a-ab6cfdbb725mr934940266b.8.1738532770462; Sun, 02 Feb 2025
 13:46:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGJzqsmmq1R9_q=p_AsuFMFr3UzyQ4H186CpfWTnCoAnHu_OXA@mail.gmail.com>
 <89612095-6b10-44a1-a29c-b143d67ce7da@kdbg.org>
In-Reply-To: <89612095-6b10-44a1-a29c-b143d67ce7da@kdbg.org>
From: M Hickford <mirth.hickford@gmail.com>
Date: Sun, 2 Feb 2025 21:45:34 +0000
X-Gm-Features: AWEUYZmJIihizjD0a4omRBW9Hhk8WP6YrRjv_ONzKMsVf2G_xqCW8SwVP1h825c
Message-ID: <CAGJzqsmo988VwABNgozwQEKBe-nyfw9f2G2obygqs8OtuYpeiQ@mail.gmail.com>
Subject: Re: "meson test" very slow on Windows
To: Johannes Sixt <j6t@kdbg.org>
Cc: M Hickford <mirth.hickford@gmail.com>, Patrick Steinhardt <ps@pks.im>, soekkle@freenet.de, 
	Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sun, 2 Feb 2025 at 07:46, Johannes Sixt <j6t@kdbg.org> wrote:
>
> Am 01.02.25 um 23:56 schrieb M Hickford:
> > Hi. Has anyone else found that "meson test" is very slow on Windows? I
> > built Git using "meson compile" with compiler MSVC and backend ninja.
>
> The tests are very slow on Windows in general. Please clarify: when you
> say "very slow on Windows with meson", do you then mean "slower than
> with a Makefile build"?

Thanks, I didn't know about that. This is my first time I've
successfully built Git on Windows, so I can't compare build systems.
(Makefile and CMake never worked for me.)

Out of curiosity, why are the integration tests so much slower on
Windows than Linux? Is it the 10+ ms overhead of creating each new
process? https://stackoverflow.com/q/47845/284795
https://stackoverflow.com/questions/10710912/what-is-the-process-creation-overhead-in-windows
