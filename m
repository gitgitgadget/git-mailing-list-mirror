Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962D12E8B7A
	for <git@vger.kernel.org>; Tue,  9 Dec 2025 01:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765244547; cv=none; b=BWeecAMMM6ChY+Z9OCJnQtujZS9yF8spg0N7IYMjIUpRlKIdOxDX7Hl94GMnBbP04d4MpyHTm9mcwsDgfeJRSjS5ewBEhVR5FvOW5HfewPM0TD9P/ECfpFCw33EMkaUWDKq+d3nw5j5iUG4FrmmNJLokVnU7u7Tha6xjhGAjCtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765244547; c=relaxed/simple;
	bh=+xtkFrIbUsiTAT6Zl/KLEJi5hjuR3QjLVyAt+l0UQ5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RlTjp9OY2pZR4O0BRWcrWIzuIqesgBcLGWXMOL/pMqqgbiYdAFKHejQxC74b4kNksgwVwZqxDIzJ0Qt2NS2Zh2ps2CvwrRwPydcdKiuWNk+DVswhPDI/FwWnWtD2US7YbtFyA5UzIglzwqIfsBATOJ7f5wDvrRYt3nSUbPS+NmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=EXy3U8TH; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="EXy3U8TH"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-78c33f74b72so21359687b3.2
        for <git@vger.kernel.org>; Mon, 08 Dec 2025 17:42:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1765244544; x=1765849344; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+xtkFrIbUsiTAT6Zl/KLEJi5hjuR3QjLVyAt+l0UQ5M=;
        b=EXy3U8THp+Fx/Ok3ELZDSxm8FqtOZlmQ4n4GkNKuzJbjLeLfZekatQG07FwpGS3Iyk
         Cwkg7KgLqPbq2m/GmpEWYb/dzvVNRFS1w1gfe1dUBATwUtdGneDrkPWsqC28qk2vzfUN
         +G6nBrHhP8yUnORH7cTCs/93qpi/pWNcdMwB9DDl7nxc/bn3psRclvTqLDcYtSAiumBn
         sHYwfHF8ES6AuTZHVIH7NuRXQ7S8GxmZMmwrxonV19J/ha0P88/Qklv4VKwl0p6a6wpL
         HfN1/SHuH0YqzA29cabbwJQ6fswalzhJFcIeuj7LJvTlpg0yYui4W30PWgxQGCK53Udi
         wiVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765244544; x=1765849344;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+xtkFrIbUsiTAT6Zl/KLEJi5hjuR3QjLVyAt+l0UQ5M=;
        b=ZhqKAoVGvhMTq1gc3/ZrbRsEJxgVTVMQShAToGxff/6EFANlOCEsFqtjmDxbToSmsx
         UVi/Zh1mm71j5+uSKhTBnh4ymsxBI/JsJtqbcXrtNkdwpT/hmqfd2TITb2sI3OeEcTmz
         EpYa3KpNxRLXaut93T0DC9En+mqu6Rmy9bBLdip4zJLagatzQsurUqLnKYaHcjI4PAEg
         AAO+pIl88IZgYJH3z9lgi51oncTpf0nbkYoKW+KL5R1xR553Q90iECV/7QnUABLa5iDT
         npi8d8QRzt3oz55a+uzXX6K99x2dJ9yQx72qaEtbBHW57vJ3njCE55NmhWw7c9umzxUv
         EwQA==
X-Gm-Message-State: AOJu0Yx0etEsxt8hGW7WzouHd59TKxhEIX2ON123ZjJ9xjoXNiojCKNE
	0i6+nWAwzQ75ld0+EkddlLIV0TVdRLAVrzgZniGiAZOUIvppQUmcIssvHiMgVeQClnE=
X-Gm-Gg: ASbGncvFAd8F5tDsqBho+CvkddhdEfSajkbu0wz9TZ16IBuXij6vV8QhxKEMF97it1h
	vVBZzwMUOKYhGzbg6eaVy6O0CLk6Z87jrk5My/NKRMl81c5x5Q+Eq49hSBZm7ve8JiVEtdSYSKk
	EeNghqZ8JD2RonvjUsUnBVr7KawdKgIKsckzQb2PSQ2ZizS7EbRPpbNhq2StjNFeTZCdXDYbv/e
	arYqV3boKPKYh/hTHhiRT+FVpaebr8+E+PRQINvmxNtYNptVjjhqEhgDfcU4mSnT1z/UXDTJPch
	yF18BObx+kR4VtJHj+w/w4w8TDdVzNLOONW+2oO/Vs4Vcg8yEFyM90z3N6rUA1aNIBpbM3XaWLk
	H2gaxGV0e4FzsfB/qkx0pBhXsxOHX2s2+HIMxfUiYcbI5fpeM2n/ZZAc6c+HuAlp0pdqpcu29Gq
	QSKDtKvpBypDWAj8qShPhJrO5ZR5HtMt+TIlgQaM/7+t+eRD6I4b57ZADi3CJkgLClsMHNXgRg5
	NYGBJ6fODF8bGU6mA==
X-Google-Smtp-Source: AGHT+IF/4Hc4R4Nc3pZuzn67TyT2kMpIOkxv7/YmrlujMck8DogeoZ+xhtl8ebyRXQc8cnlhrU0hzg==
X-Received: by 2002:a05:690c:4c0e:b0:786:660b:82d3 with SMTP id 00721157ae682-78c33b3b6ebmr94020957b3.22.1765244544377;
        Mon, 08 Dec 2025 17:42:24 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-78c1b78e18fsm54314017b3.40.2025.12.08.17.42.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Dec 2025 17:42:24 -0800 (PST)
Date: Mon, 8 Dec 2025 20:42:23 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 02/17] midx: split `get_midx_checksum()` by adding
 `get_midx_hash()`
Message-ID: <aTd+fxpflcLuJXDn@nand.local>
References: <cover.1765053054.git.me@ttaylorr.com>
 <d583a169f08eea9d750622c6e3cf79774a2a68e7.1765053054.git.me@ttaylorr.com>
 <aTcYAdJ6lNCST7PT@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aTcYAdJ6lNCST7PT@pks.im>

On Mon, Dec 08, 2025 at 07:25:05PM +0100, Patrick Steinhardt wrote:
> If I didn't have the context of this patch series I would be wondering
> what the actual difference between `get_midx_checksum()` and
> `get_midx_hash()` is. The way the functions are named seems to rather
> indicate that we talk about two different kinds of hashes, rather than
> two different ways to encode them.
>
> Would it maybe be preferable to call them `get_midx_checksum()` and
> `get_midx_checksum_hex()`? While at it, we could go even further and
> rename them to `midx_get_checksum()` and `midx_get_checksum_hex()` to
> conform to our modern best practices.

Yeah, I think those are both reasonable suggestions; I'll apply those
locally, thanks!

> Patrick

Thanks,
Taylor
