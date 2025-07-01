Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0447726B775
	for <git@vger.kernel.org>; Tue,  1 Jul 2025 17:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751391129; cv=none; b=dt89DpuYCisUIyFo87VX8bTPL2FISlszWiHXOXu3sFoQwqz+dXRl+f4GBzXhFmwsNpV233Humq66+pPnDPPggFdxSiQB/RocOwU/MT/CB7tEWOiNJ9GASubxmRw3pltwz1J0Q2IG8VQWp+Z8RyEb7Bip4DHUHjvXOTI7gnLtPnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751391129; c=relaxed/simple;
	bh=bY5y+JzZr42Fd+B/3lTpqsKw506vZosV2PbRwJMGK34=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SUJR4zvevVlCkswtKU68Zr+EJV8gAtzisWHiG95mfPhsQOyu6VsjZU9yiNRKOK3WRFuJgODm4uTxpGL+WTYtHqPo8zxB2nLfVakppM8t3p5cAyRntd0s2Ywc7zpSY0WXgvnDCl0P/rFpATsZdD4P+3AukMCIdApFmL637S3EsMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LvYgW/4f; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LvYgW/4f"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-237311f5a54so31816685ad.2
        for <git@vger.kernel.org>; Tue, 01 Jul 2025 10:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751391127; x=1751995927; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7m64qPoH7lcYKS9ZP/oyC4hP0u5r8KJbOPBSmicxA8Y=;
        b=LvYgW/4fSdVCZfFa4xY7FsehVuIOEQaWkfMu9bIkuV+clg+r2pp3M9AEmrfHDT2KuA
         QFoG6Y2eKT+y1WejH0lpWuIuBKZ93lxYtELTZBZedw/FZ3XJIKHpFwhfEHKptxOn8Yyb
         4mNMT12USpsaQS607CHQ/d1ttfxw2ezf7CJmYEL4/DXCdaTR//rK7Rw/jlnjxH7CWFjA
         G7z/l7sb41w4kCVBsFrLCvg9loZ5UrF4Y6v2aUqKEJEtfL/10UJVoQxi5r3rcmNEL5T4
         lNljR1aN/6r0hOKUD1TSFmEzLiJ58Kd29vsKf81sJsiQhXRl98vJIkzYjZGd9V6+Gmq4
         Mdrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751391127; x=1751995927;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7m64qPoH7lcYKS9ZP/oyC4hP0u5r8KJbOPBSmicxA8Y=;
        b=mvL0FBS5E9afX9qYYCCE5edIFU1gWDEJCtiJ2hS2LF+KOY3udaV+9LF8JSJsEKXewH
         4bhHtaUykzlb6Kuxd40w9ZXnk6XQBQBzNg3fOTWpxDYkPna6X5apequPwQU4qswNigI9
         F5wn8+C+peAHiTumGoUFJTdW0gG1aUmB8LZk31OPSwgTtAvCXlVvELkzDXfrQ8rMwBK9
         XF3+yizwLhZNxMQ6PolY6/ZWLYvuKMPnRw5b5QoIIpNw036m5sm1AZgXumLHBOXF65M+
         kaYhJdpn80tNba55PMlDJEo4VlJYMwaxV/2+k/tSbIzqw3OXtD4Tk5cW4wNPrhMgkVEG
         z6yw==
X-Gm-Message-State: AOJu0YyP8cPIAMnskLBty3wnagu1zR6GztNSD9ecU4XrmwCC5/e1rWsi
	8DmWAJqHMwv2Q+fph3fsoDulKV/wSzisBjbeR6Z1LlqWmKxAjx+wswl4
X-Gm-Gg: ASbGncugDP25T8Ln3O1h8IOPKXEl4stVEVJTUrb0CIlqWu0UbMDsX7ckrcAyVo34VA5
	XIE9R9lPE6KhLlOrxsAA1EyRPGcGfdhDT4snY7nC3nbKrAbKgZdX6kkra7C9xvrYHIFFgIPZshK
	yFAoKbQt7KJkxwOxqstulaUpaqo24eIZoy9fEGHvqv/8MUxjaW6oZpufMEjtWrOqBcU8xu4pfBn
	sSLqW/0i/0wGQEcKgFI/yDqIRftlxniRSzpz1u28Qu2vDLyTeTIRi/xSgxwygzwBSoTKNyKpE5u
	y93UpWe1D1bKvOLdLDsMnFmvOI8qbYwoKUd3OUyeNa6QB1bqltL1wITd4HuUqhK++RW3xmQnLAJ
	MtJ9QPSDMWLGSf7BZmcNuTBf3jm4=
X-Google-Smtp-Source: AGHT+IFKn9aNu72r8teIKE39rbf+y+RmfW/dfFP+WABxzhQPhWu72Euiae4XZ7yMtiU1MiW5rdyxnQ==
X-Received: by 2002:a17:902:da8d:b0:234:e655:a618 with SMTP id d9443c01a7336-23ac45e217dmr267545425ad.25.1751391126924;
        Tue, 01 Jul 2025 10:32:06 -0700 (PDT)
Received: from localhost (209.255.125.34.bc.googleusercontent.com. [34.125.255.209])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-23acb3b5009sm113984295ad.162.2025.07.01.10.32.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 10:32:06 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From: Junio C Hamano <gitster@pobox.com>
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk <code@khaugsbakk.name>,
  Patrick Steinhardt <ps@pks.im>,  =?utf-8?Q?Jean-No=C3=ABl?= Avila
 <jn.avila@free.fr>,
  Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 0/5] doc: config: update for the
 ps/config-subcommands series
In-Reply-To: <cover.1751382830.git.code@khaugsbakk.name>
	(kristofferhaugsbakk@fastmail.com's message of "Tue, 1 Jul 2025
	17:14:27 +0200")
References: <cover.1751310455.git.code@khaugsbakk.name>
	<cover.1751382830.git.code@khaugsbakk.name>
Date: Tue, 01 Jul 2025 10:32:05 -0700
Message-ID: <xmqq8ql7lsve.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

kristofferhaugsbakk@fastmail.com writes:

> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>
> Update git-config(1) according to the ps/config-subcommands series
> (fe3ccc7aab (Merge branch 'ps/config-subcommands', 2024-05-15)):
>
> 1. Document `--show-names`
> 2. Document `--value`
> 3. Mention `--value` throughout instead of the deprecated
>    `value-pattern`
> 4. Mention `--url` in the synopsis

The result of getting rid of "value-pattern' looks really nice.

This round looked great; I haven't run tests yet, but I know this
time you already did ;-), so I won't until I finish today's (1st)
integration cycle.

Thanks.
