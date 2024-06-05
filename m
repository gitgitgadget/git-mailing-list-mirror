Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B1B13BC3E
	for <git@vger.kernel.org>; Wed,  5 Jun 2024 22:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717627844; cv=none; b=tOJfKRAiVJ8vfOoC8XQw3ncKCdv7Bx1hGGPNy0ichh314OlQ1GVDvwM8dSVFlxhQEykFchrjss0twrcZW+FfAof9SvtOUuXyg4ikWlC/xNGVXVu2GMUqhzOL/PY93/bcB9v9XbcFyDdtPYALEIpBCYnLUPcMuusFV5kHS5cWubM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717627844; c=relaxed/simple;
	bh=khGLfr9wODtQpNZ3JCJalFHfjq/6IKRjiIP71eY5acQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dX+n4pbBxTNRHPVQBLw+YTMLf1jfKNQOcfnLmcAR+6iq3OtvTUSLRB76pT10I1W2abY4WO90GN0TsysurVpqpbcQY4URochkHHsc+4QofTPtXKRCFf9e8cNZHXMqe0uJbmo5mB6/DPEPyq0faVwJWySyri+RbIy5E/WorpdAAtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IYSzHFlN; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IYSzHFlN"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-35e4d6f7c5cso332296f8f.2
        for <git@vger.kernel.org>; Wed, 05 Jun 2024 15:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717627841; x=1718232641; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J4lHQLaeqfZ5HtEPAq2dv+WW4pYnNq3aZOREreA2K4U=;
        b=IYSzHFlNxBSa4semw+VAKIHejTzu3tyXMH8sKLQs9dNz8WtkNNAyPcGzbZBIY9wpct
         CYxUMMSUtfZMhTb7ozDwLCExojE4C2ARuXMSmlid0TEuPPsF1JzEz90pNZ7TxR8h+If6
         96U2OUFQCYKmKRL/lAKnU4AWlMkDq8sHqmit8aprXxk9BVckuT3QhlkXQSi8irb1CQTP
         Y0N9SKFC0Tx+xE9Z0cHyIrNFMUkWEjMwrr83TYL/EOSYYphDWPl+U+1gbnQEie/7x170
         1eNqBIOmTkSVNKoHvAKEHDFmfK2lZuTaZ/OrdtpmPrsUQGo5xn6AGhfh1U80tPVUrT5y
         Rq7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717627841; x=1718232641;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J4lHQLaeqfZ5HtEPAq2dv+WW4pYnNq3aZOREreA2K4U=;
        b=XOWcthzVYRlMs9VRi+n+mmymIuEPZNLr1lJfSScg9tdke7EK8SCbJaHzwBpQyymWkc
         LapjFe2hslA34DkLpSq+X4gRPfiMSNF6kU4eoBYq+U5fSr/4YDSYkyOR2eUs14xM2gP1
         fpIVhjxEJnnX6pvDVKZ07FhVDHmA/bC4jjmtKDCq/Y+Utqkf4X2mvxSKJcsf/2cMQ/Dp
         wL/gxQD1KwO1nB4Upzi0q483ewqeFGey0SzCbIzp9EFPcCMWB5c3DUJLmoNJcnBaYtxI
         yOinwfGFSmH1GM0rSA6ZpwTjt59vRwFM7V6/uxdkpcg/hF1u7nasgOAooutTf4/8UJh6
         pO/g==
X-Forwarded-Encrypted: i=1; AJvYcCU1GaEoJ8sj7Yg55OK8r2pSjGFdh0gvJG1L0zXBkFcLM0XTP3aXEqRfjccLszimo2Va+g+w4BdtqguIk/zNSLIKAkc5
X-Gm-Message-State: AOJu0YxqIu+CQDyBQ0O1tAVaHY7DQQPY7aG8KyQvz4tfQf9+l7xiziP4
	No167JOvlSu6ZYeHEeZD+ys8sEFyM63Xpj9OgLXgTeGQoRbgzQiZ
X-Google-Smtp-Source: AGHT+IHvVbhO+OK3x0U6UT01WxOJUZoCKSKF5mH03n5tlXBfX/B4S/0UAyKnr0NrjYPYrmZSwDqD6w==
X-Received: by 2002:adf:ed4e:0:b0:352:9e0c:f9d3 with SMTP id ffacd0b85a97d-35e8833a1a4mr2532173f8f.31.1717627840974;
        Wed, 05 Jun 2024 15:50:40 -0700 (PDT)
Received: from gmail.com (52.red-88-14-62.dynamicip.rima-tde.net. [88.14.62.52])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35ef5e991c9sm4067f8f.70.2024.06.05.15.50.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jun 2024 15:50:40 -0700 (PDT)
Message-ID: <9c76f1f3-f858-400e-8fc7-8e3bc9764e87@gmail.com>
Date: Thu, 6 Jun 2024 00:50:39 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/6] test-terminal: introduce --no-stdin-pty
To: phillip.wood@dunelm.org.uk, Git List <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Dragan Simic <dsimic@manjaro.org>,
 Jeff King <peff@peff.net>
References: <1d0cb55c-5f32-419a-b593-d5f0969a51fd@gmail.com>
 <199072a9-a3fb-4c8d-b867-b0717a10bacc@gmail.com>
 <b7e24b08-40a1-4b18-89f6-e25ab96facaf@gmail.com>
 <1ef0ac3a-3be5-4fc2-93f8-46610f3d1880@gmail.com>
 <d95180fc-8f8a-4e1d-987d-3aa0811be7de@gmail.com>
 <600d27c1-f9e2-4a03-af24-4de8f66526d6@gmail.com>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
Content-Language: en-US
In-Reply-To: <600d27c1-f9e2-4a03-af24-4de8f66526d6@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Tue, Jun 04, 2024 at 11:05:15AM +0100, Phillip Wood wrote:

> Rather than adding a new flag to work around a bug in our script it might be
> better to try and fix the bug by using a loop that reads blocks of data from
> the source and writes them to the destination instead of calling copy.

To be honest, I've tried.  I haven't found a way to fix it properly.

I also thought about removing it.  I agree with Peff, removing the stdin
redirection makes more sense.  IMHO simplifies.

But, perhaps we can happily live another almost-decade with this new
--no-stdin-pty, before finally removing the stdin redirection in this
helper. :-)
