Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D54220F23
	for <git@vger.kernel.org>; Wed,  2 Jul 2025 21:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751490860; cv=none; b=gWybPnASR0huNAbplwJg1DlrmPb7o5hJJfvo/v9tL4Va4AWriOgQBpEwtJE7kZSVKk1j4QyCvo2DwhlWlfmCMskUElTin4hBOCIHL6XlwUYRTBLxQs9mzlmiOOa8zD5rO13WPEtGoJPsryhoBrFMxYpM+cV4ZVaH4/iQ2OHfoJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751490860; c=relaxed/simple;
	bh=RyFl3Y+1/Nk2f70dTgGv2nQbt6orLVCzQm9TkB0UQKg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=f7KkDYVLw5YWbyIkDnNS7U1+EOamsyeAEGq2j3Oox6ADVwE0nUkVZoM6K8RNXe/C43wnYnItf5wEk2T2R94SyndY9bFOVbtcsX4dwHjFKvTcQ+e+dmU9R2Xfqlvvmt1La/D9gBm4B6nyDs9VNDeGMijaBUFwhfLMTZhBrHSqqz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dhBLxM2V; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dhBLxM2V"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2363616a1a6so44619765ad.3
        for <git@vger.kernel.org>; Wed, 02 Jul 2025 14:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751490857; x=1752095657; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:in-reply-to:subject:cc:to:from:sender:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8bETkzV97UXrx43YZEbMB5XHa0uZ8dtZXPWj6ILZY1s=;
        b=dhBLxM2VAw6LnIW9ZmRZL9BTImd9w/z0m39b/UVu5Kt46J3Lw/38c49VzlTm3O6gvT
         q6TXpG3Ejg3e7WJQSxoVfmZiC0Kk9bSSp/r+ZBGVxmgvtA+rQ3s0rE7ozuP9SPyd2LVa
         fETWcaJMECUlH6K0BWGC1zaFB1vwugdvOXeih+7L1uUl5v/s3GGFjtHIJFbnnco+MYER
         va1K75mHZlifAxHWL8J8fLByXNQOCn+4AlH3SBeIfIEFiO3x8O/rlumrS3vywZWXbyb9
         3zg7asFxpLeYLCo7ecOdyQq4djzC1YCRWAN6Q2f9Mf02qsaIUZ4qKoYF4P1wtbzVSwGJ
         6ZYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751490857; x=1752095657;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:in-reply-to:subject:cc:to:from:sender:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8bETkzV97UXrx43YZEbMB5XHa0uZ8dtZXPWj6ILZY1s=;
        b=PHRPGRduqDt0SmCiu3bnntsRvbbb4mR5Z3N4h5AEYsQ6vbdfF4vb8aEoLO1kWVHKd0
         GlL5YinL+xtsMWJGQzJLjA9clok3SR9nj0yYnXdr765P/2zleb71FcNEb3QjDk+YBfSV
         pjjK+rW3LMicJFtkHsuEpXdogxMucNNjLtWCGsHY1CfCpTskaODW54zDvO+0yiNX7tUL
         Bu4AbPzEOwoucLkbCg7NmFzJ9a1USlYCS7zvymuKeCzMb+M7+izbmUQ3g5KRa3BI7MT/
         pC3WiEBnwjRfkD+xVtA+ZgFYkBgDeKUILZwTwM5flOlTNOaw7i0oz0LwkIxxZVWZ5uJH
         F4BQ==
X-Gm-Message-State: AOJu0YyVnLrxbxY5e5/TKtkMdwYIXezhLo1pPbRh0fqjVgAZho3pgNy+
	ovg9flcsBM8M9LZyKftimyqmMRdD36oMrv35458K7ylksHEm82/dsW4D
X-Gm-Gg: ASbGnctpgOUKInyK1IXXeURY8rtOzHMvVu3deoCpb4tDZL3yO+Fi6UyPoCZZ5Vp+R5U
	1c4r0Fp4VEtljStgVct8rk1nVh14az0qQIsOC4u8m2pQWSWW9E2sLumHZQMN10k4GRtPibnt6OA
	YobMWVed1TCTZvRe6skIB/ye8EOgbrVkCuiSqWnxREd828zFF4DWPGQirLEWAuh+AiRPItl9Pby
	L5sg3vH6QmrqCVfkRQcnOLGuSHqMqNcNtsrXlY+gbbPgG5g//KNFNwJKRFICuHbvLl/I+222W6C
	6OYRlfuGYdyt7dADWYCjbnFChOp8sAE8xd/2rsW1LxKlY+1KD4RsxcGLGKQpheGqe7RSUkqfnU7
	KhQlV92nmqakjie9wkL7u88Ta6zk=
X-Google-Smtp-Source: AGHT+IExs3GdEsduK7Hzsu0omZXRaJY10XjEUgIsSS7d3bYaUUJjJ4iqfkCw/T2JRvdm9OO9nt/v1Q==
X-Received: by 2002:a17:903:1b4f:b0:235:779:edfd with SMTP id d9443c01a7336-23c6e570636mr50882245ad.39.1751490856988;
        Wed, 02 Jul 2025 14:14:16 -0700 (PDT)
Received: from localhost (209.255.125.34.bc.googleusercontent.com. [34.125.255.209])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-23acb3bdfcesm135307825ad.206.2025.07.02.14.14.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 14:14:16 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From: Junio C Hamano <gitster@pobox.com>
To: Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc: git@vger.kernel.org,  brad@comstyle.com,  collin.funk1@gmail.com,
  pclouds@gmail.com,  ps@pks.im
Subject: Re: [PATCH v3] builtin/gc: correct total_ram calculation with
 HAVE_BSD_SYSCTL
In-Reply-To: <20250702202118.48742-1-carenas@gmail.com> ("Carlo Marcelo
 Arenas
	=?utf-8?Q?Bel=C3=B3n=22's?= message of "Wed, 2 Jul 2025 13:21:18 -0700")
References: <20250702154649.44210-1-carenas@gmail.com>
	<20250702202118.48742-1-carenas@gmail.com>
Date: Wed, 02 Jul 2025 14:14:15 -0700
Message-ID: <xmqq5xgacn2w.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Carlo Marcelo Arenas Belón <carenas@gmail.com> writes:

> -	length = sizeof(int64_t);
> -	if (!sysctl(mib, 2, &physical_memory, &length, NULL, 0))
> +	length = sizeof(physical_memory);
> +	if (!sysctl(mib, 2, &physical_memory, &length, NULL, 0)) {
> +		if (length < sizeof(physical_memory)) {
> +			unsigned bits = (sizeof(physical_memory) - length) * 8;
> +
> +			physical_memory <<= bits;
> +			physical_memory >>= bits;

I do not quite understand this version.  Does the correctness of
this depend on the machine having a certain byte-order?  

The system call treats &physical_memory as a mere blob of bytes, and
may tell us that it filled only 4 bytes out of 8, but depending on
the endianness, left shifting 4*8 bits first may discard the real
information (i.e., big endian).

On a little endian 32-bit box, it might give us length == 4, filling
the lower half of the i64, and shifting by 32-bits to the left and
then shifting it down by 32-bits to the right may fill the upper half
with 1 if the result in the 4-byte long is more than 2GB because
the type of physical_memory is signed, and then we cast that value
to u64.  Which does not sound correct, either.

Would it make more sense to pass &u64 and return it only when
length==8 as you did in v2 while removing the need to cast?




> +		}
>  		return physical_memory;
> +	}
>  #elif defined(GIT_WINDOWS_NATIVE)
>  	MEMORYSTATUSEX memInfo;
