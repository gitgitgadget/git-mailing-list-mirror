Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E2E21D3C5
	for <git@vger.kernel.org>; Thu, 20 Mar 2025 11:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742469044; cv=none; b=QYCyGKFleDBE1FKd+uepLuKbodDNktD+I3QAPezHbrKdNKo/b8WL0QM7p+BamWhIZZRttaHu+RQ9wuVwQh6g59Kid/NMlnbf+techyrR6O3cDUaizukYsOGjUxY8q9iAeiLofnWEY+OBlYpNsYz0W+T3bAkMeXFo5E/1s6tt1oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742469044; c=relaxed/simple;
	bh=Ii/bEwYorVKPMAhxNutZw+3yGafAo9Gcctl/dnKn50s=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Au6zTxS12sz9+wnf8hW9q8EaAImZvAaAjyH2XmhbfoJaJKBMVNlZRXbu1dIQggrbDLWaoCiTRcwlStd9275pkunEfsXdjb3kIZQ6l3iUSCWzrrM82rgixfBW7OfnaiDJdnpGMrzlMn+hUaRjukyLFoqGQ9yNuc3ulyvQtVViIk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P+2Ri2lJ; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P+2Ri2lJ"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-39149bccb69so559466f8f.2
        for <git@vger.kernel.org>; Thu, 20 Mar 2025 04:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742469040; x=1743073840; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=W68Gb4dkTfKHHkxuDwaAQNgTR0jwjomm0F8UPhfFGto=;
        b=P+2Ri2lJiU5uWLfXV8PoxcGvZm+FmvCXAGhi49cv47fRE1lfFaJcCC58u5az7I6UAG
         SPJaPEsSGQjWKSkA5EyJKCbtb1fmz2ikplU1yfTtFAbJBtgoINSgGOXKObDWpas9yvfD
         n196u6Gq12nBmqxYqNT6uFUXPNw/qBIJ65fq6p/vY3Ux0cSOYHirTbRuDT3rXKLxk2fJ
         qeEixBDK1YMbbVQjomiB9EZ1nQOiheQbU6b2fnq/Ft1GXa8KA0jNOB+wLVlHriqx5wlP
         1ToUw/hXw3mRyWGhj7eSoa+y0fwKBuSvWUgbpsvT0u3Nnl8d4RGFKqGPGp3Y34mTHsRw
         5cJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742469040; x=1743073840;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W68Gb4dkTfKHHkxuDwaAQNgTR0jwjomm0F8UPhfFGto=;
        b=ldBeHVcnHsO9uIN+5AcE9bKGlFjnAaywERv0UwnU7JRaJjCaZojWSUsHqB14+ZY3dP
         6k4uR2SchfRh0vV0DZk9abd6QQAkEWnTGzC83UFz5Qr5+9EZvveFXw/BDBf9Rc6z3VLT
         m/eSw/6z6zN7FndL99Hig3wq226HysuGYVrne6aP1DNACMWwowlVHIQ5gmBIyuScG3xV
         3U015lX8qE9IYhZJXKLB42hhdoKi1xyX+9GwfBNTLGeiW5dcvbABjNZzEEI9s3h9ceZ2
         X2SuuBgyFA+MPBOJD1I6r1mKItRr4mlsR5urd9GjvCk6sF/64PYybK3FnK58qa0pgmqn
         nvZg==
X-Forwarded-Encrypted: i=1; AJvYcCVo/IDm9QZtd0pGh3AHue7B2b8LtmxfEnwK8L7mgwUrLRjUDnfxMFcuogFMZhSdUD20nRo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwF7F8cqINcByEzNe4F3BATvINjE/Zvj1KzPe9RjRfwg0EJEi5U
	cpAF6VmfcYWbmQIh0U8Zp0qGUn1VGhZFpQ7TTkEgR4duVfSLsJjP
X-Gm-Gg: ASbGncuwQUBLV34BpJ7wpGZu7q++GmtjEDR/FidqwoGWNg2rc+ycB3iYN0GRPwXZrHv
	LCYOPbKNjFOifXfIhQKdkwEWL6jwI+uc7ZiNLrLbecYLOH41B+iiJffLcbcnVfQMUCqTsb8sq57
	12hiApaCTOhSJyDCFzUjACmNaov0ABXdn8i8tlcShKapSYZKEhFLXrb9d+5n+VGQJ1C+kKslPel
	/oKJ8nv5llIqb5Dy77OAo9xVmaDFmef2d+u1c6haoZ1xG6PpQ7uVOgSboacmLKXCgkcs5hDysuQ
	cBCAb9EJ6khcEJ3fGpzZZMEYd21LahhRxvYuzLtesK5s3f4Nbwmo/UV9r99UEY5a2zf4UPkTsMA
	OzpZeqha8jWMgkbk66mbl
X-Google-Smtp-Source: AGHT+IEKYO5pcRw9GdJLbM8y3VTQnNNmK2AogZdxneQZXEbHFjratuwu6RTIuzaXTHEbFGTCVHz69Q==
X-Received: by 2002:a5d:5f89:0:b0:391:4231:414 with SMTP id ffacd0b85a97d-39973af92a0mr7257920f8f.40.1742469039554;
        Thu, 20 Mar 2025 04:10:39 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c7df3506sm24184740f8f.11.2025.03.20.04.10.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Mar 2025 04:10:39 -0700 (PDT)
Message-ID: <03110f30-54e8-49c4-86bc-f4c0f5641f41@gmail.com>
Date: Thu, 20 Mar 2025 11:10:38 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [RFC PATCH v1 2/4] libgit-sys: add symlink to git repo root and
 clean after build
To: Josh Steadmon <steadmon@google.com>, git@vger.kernel.org,
 "brian m. carlson" <sandals@crustytoothpaste.net>
References: <cover.1742339107.git.josh@steadmon.net>
 <d592a3c2e3f56aa4f6915a07307a2ed349296272.1742339107.git.josh@steadmon.net>
 <uu4s2acl4lwhj2rycojebnkygwqvdhge7iwh6uaedsmvkphchz@vg75gxitvqvn>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <uu4s2acl4lwhj2rycojebnkygwqvdhge7iwh6uaedsmvkphchz@vg75gxitvqvn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Josh

On 19/03/2025 22:23, Josh Steadmon wrote:
> On 2025.03.18 16:24, Josh Steadmon wrote:
> 
> I'm currently working on an alternate solution where we build the object
> files in Cargo's working directory, rather than in the source tree. This
> will (mostly) avoid the need to clean after the build. I hope to send a
> v2 with this change in the next few days.

Meson has builtin support for out-of-tree builds which would make 
building in Cargo's OUT_DIR trivial. Our meson build is still 
experimental though so you may not want to rely on it.

Best Wishes

Phillip
