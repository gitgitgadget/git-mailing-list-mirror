Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE9E3ED5B0
	for <git@vger.kernel.org>; Wed, 25 Mar 2026 17:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774459178; cv=none; b=mj2l1AAMpKSW7L1WAO+7g+UZgHzSWtUQQzVqAhTvg0Xv8mmFHuKlp6EF/jijrxMw784+GfPnZrnCqtZ+gyVe+JhIo9zQG9UcSDlNER35hcVRo/g1dYZri97M5g8cZEAfTZ41ts6MQZssNc+HgzDdsfFE/oxJUlZUwCeStQpO//8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774459178; c=relaxed/simple;
	bh=w6YlxKsmcev9QgGhFQwhxqjFYiltmasPABnWTL+6OEU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tmb5MbebPD5uBJdz3WhExY318LaDtrr3TcSiiw/Oq2FQLOnz5Fq+72gcoeOZV7f7NVunWbmbAJWK3ck1wd6OlAYkGPSljBvZDlw83ebFCOvkwSLu06mlXn8G+yt75AbgoGN7D6P+zk6fo2a37m8ltJn5koI+000sSI9XQDTs07U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rhZS6ZDw; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rhZS6ZDw"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-35c116887b9so11079a91.1
        for <git@vger.kernel.org>; Wed, 25 Mar 2026 10:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774459176; x=1775063976; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZLSUsCfwl22sOIIGRBR1FxaI51Hg64mhPL2/NDsJ5V8=;
        b=rhZS6ZDwS6eUFsuqt/PtiOkhXj5YIYTfDgBLGbQY/c6XDXU7w55OUtf41ze8pmxT9p
         NAKrNBBdt92GnrhdJRFJIWnTmGlyCObfaj2TE8p0xrPrWnxtW3mpZq1Xqd3EqxdhhnAp
         FLTK/EcSTFDbbN6SJ388Z6fmKH3DZ/CIzp/XRJTCNjvio+iWAxagaIpe7x6IwkoXTxID
         xaWazZe8bVmXOp5R1aQGA6BAJ0FILSK6dQ8e1eqTKondXs55qDGJV/g6mRJLnaVd4HAZ
         uSJWVPoX1dW08MdwiHrLYNGlJiIXH1XZBVijUKCHJaqNMGFIxE0sKXKAf/mKWZmlz4yb
         oN/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774459176; x=1775063976;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZLSUsCfwl22sOIIGRBR1FxaI51Hg64mhPL2/NDsJ5V8=;
        b=AvRgE4SXFnGzQija6cGSBJjPnmigQYWrjn7KDJeICZ0PcvkSiPAE3cWxkE3Il46nkx
         jyDoSv5Xw9SwssBJipyd9OBiX0vrDJ5/UQvZ0/G4OK1EEMxK93XqVaf8kiUKuqrB7AWF
         lXMcJd6wSuyiDMSVy1u36uBg5wvu8+txzm0NqHWv7oLlKgvO65ljpGzQtBZF+pFTYxln
         NmszECd2yGuzcwRGwyVWhl5xjQUBkF4N6UY25l3q0FF/+gzkRknlU8qbVM4zzUuAaMNm
         Un9tbT8ObvV6TSESYA/n9c479oaxNsqS7nn2Fg65oKUfsi+0fgg3HhuPJnVs7GxVbix/
         UkvA==
X-Gm-Message-State: AOJu0Yzv/eQ1o7wMWMJwIrrRI57R3k0755LBXWswDrO8LcYsvDTqiPZ1
	tFGvBPFtpyAYaQZt/4lJ8Qn7vrttu2q8+JNkeyK1eo2L7FFae7ws2N4j
X-Gm-Gg: ATEYQzwubrPlLgGrX2zQpbQDEJRqOxsGAa1MHcf6xZI2bUckiYqUDwL3IWd5MA0SdFN
	Yb+NkWGEDcrkwyu56GxtaDjyxjD5ZAXIEcaqnCCMoP9k92Ol/sBOjcnsqfqu6NskSL65AoDYJLE
	wwQDb2J2K20uQIHpiL4C3QKb+Fbaww46dWzbBP/z8VGddnRsfoJilVotAyBIFftDULA73btGAeC
	iUnpigeADGHFIlFP7dMRLOOwHpO6nXmmNN5pc18gr5mUuJ0XqOkaRXcJYo7qO58Vjx0+llJ848s
	9Vm7g5eLtkjmiteW6gv+WWnDNrcMGGs6R6x6HLcrU6BsRcrjGg2QiOfvugpAhll6bLoVHmMBE+y
	63emS3s+J716pOKrC0H1puMwyk0ojBwwylxmzGmlMiQBRlrVPlQvHajeHfiik2YUPaJG2LKtNEn
	TAzEcMO5t+o0iodv/e0bq9FUoLTVdKc6M49/ixbU6sbnhdpmbdNrHj//QuprPbsoZF95nygyKu3
	GwVjfniVc8=
X-Received: by 2002:a17:90b:2fcc:b0:359:8812:7c00 with SMTP id 98e67ed59e1d1-35c0ddaf02amr2871628a91.7.1774459176145;
        Wed, 25 Mar 2026 10:19:36 -0700 (PDT)
Received: from [192.168.0.109] ([155.69.180.3])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7673978668sm52754a12.27.2026.03.25.10.19.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Mar 2026 10:19:35 -0700 (PDT)
Message-ID: <8dcc9e74-80a9-4963-aa9b-56f28e5edf45@gmail.com>
Date: Thu, 26 Mar 2026 01:19:29 +0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] t/pack-refs-tests: use test_path_is_missing
To: Jayesh Daga <jayeshdaga99@gmail.com>, gitster@pobox.com
Cc: git@vger.kernel.org
References: <87jyv1jqb9.fsf@gitster.g>
 <20260324161329.71047-1-jayeshdaga99@gmail.com>
Content-Language: en-US
From: Tian Yuchen <a3205153416@gmail.com>
In-Reply-To: <20260324161329.71047-1-jayeshdaga99@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/25/26 00:12, Jayesh Daga wrote:
> Replace a raw '! test -f' check with test_path_is_missing
> to use the standard test helper.
> 
> This improves consistency with other tests and provides
> better diagnostics on failure.
> 
> Signed-off-by: Jayesh Daga <jayeshdaga99@gmail.com>

I think what Junio meant is that it would be better if you explain in 
more detail *why* such change is nice.

For example, under what specific circumstances might the original 
approach lead to bugs? How does the new approach address this issue? 
What exactly do the codes do?

To me, phrases like “improving consistency” and “provides better 
diagnostics” are essentially empty rhetoric unless they are backed up by 
the specific explanations. Even though this is just a simple one-line 
change, I think the principle still applies here — if a future developer 
(let say 50 years from now, human programmers will no longer be writing 
shell scripts by hand) sees this code, he/she likely won’t be able to 
quickly understand the intent and purpose of the change just from the 
commit message, right? :P

Regards, Yuchen

