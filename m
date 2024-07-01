Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E126171071
	for <git@vger.kernel.org>; Mon,  1 Jul 2024 19:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719863991; cv=none; b=KH9VWodLFLMQwQAA+ILMvlgUq+NZEyDzbA7UQ6d71LT0Y0vgk//x3cF6mWsbCSnf0nHOSoCjNFargtTNmOpCxUTlv3VsL6ZAtocKow5nrcJ+pUjXMOgUMV8k+VARyX88CWWWwSEyQpxdZ0+fnFptkjROZKjkEoMWgYoepBnb4zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719863991; c=relaxed/simple;
	bh=RpH5TVPQpZgNqzP5lhs4fjNkqQQYQz5x1AOuMDog1vg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=omYjZFO6cXmMYe7awlMOVk/hhx6nBZOo06qanMTl9zrZODb9rWzNLe9u9ELShtDbJiXnR/8HnjqhG0ul4lQC1vHwTS1DWQLYm+22QudFBVU/uxqkzs7bv9fMamFM/9scSL5YecznTtVLFTE0tqVT22u+zxz+p4wS91qpwQVpzmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IFwCvvt5; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IFwCvvt5"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-701fb69e406so1392868a34.3
        for <git@vger.kernel.org>; Mon, 01 Jul 2024 12:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719863989; x=1720468789; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/31QwPEu0hLfdC46DiRtWFLTQbuoorHRDZYSvpF47qU=;
        b=IFwCvvt5NlDn4QggDSQ6J92rVvP3dEGLfD3WAQXWlPR3rFT3ys+B0Gp36ZUYbgiMdP
         NvM1IxpLg2eLz0xcMauTSzyP3fzY/hpc3NPhI4yVKCADTtcoNiSn20un+JXE44WEYnYr
         YJFLzdSnX1OPt9PTh6tAiK4XxVEcVFRJ7zNwJt85YTLdoKV2tDNYJ1aMvxMBQvSs4StM
         TIttNO8yBkAI6sLVR0EENHpDOF2lSDf1YxWmE6V8fvkj9GFSi6yK+bN33qkX1iFrJ4+j
         Y8+pUcZZT/GMyWxXaftaHGYHUHbgn+Y0+R4woKpLQqEb6oN27Kn8bjIv7wPVNFl22emb
         BNhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719863989; x=1720468789;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/31QwPEu0hLfdC46DiRtWFLTQbuoorHRDZYSvpF47qU=;
        b=qTB76Y8hNZdkv09VmQiuOSYA2olIUbCU3nc32nolBgHzaNkInIJVjbtSc2Lm5kMRsw
         ZBKjJboaFEzgLszaOjzHiEihY2JOnD+kZ2ECA3Wnlc/eg/qisdGjlSY1poClH02yLSOw
         +06+MEKzUofaCiBl4cFksFWLGMYGBuz8/dAEb9+Ql81BW7X8qOMimOdhcv/8Ltw75c9y
         pFI7uVlBE5XDgpFqwp45Njd3Om8w5/4hjxmVcgVhPD9SfLKfLx/+vsbLjOiVd9nOTbhQ
         V/FxmfkNLqpWRThNMH0OgSmLrXvtFk+zaETpO2vIOEhjJKf1nc10JS9cYVl3fWCr5j0r
         vSQA==
X-Gm-Message-State: AOJu0Yx1FW3tZ7Rns+I/moxfjw16NdRD1uVKQ+ToKoK/aYqQLZQTLvsE
	WnRbCZpe5SacP9ALcPUUOPvgXFmIuQqKNwlZFyts0oeMyrKB8mfxb0iYhTDfIw==
X-Google-Smtp-Source: AGHT+IE0PexzRodiTSmX5GL5EW0i4DM4RMrAOHaxcNEzAumVY8Ln8qIQRRDAvPdYvcBWubgNZwuzjA==
X-Received: by 2002:a05:6871:5d3:b0:250:756b:b1ed with SMTP id 586e51a60fabf-25db3513df2mr4213841fac.19.1719863989107;
        Mon, 01 Jul 2024 12:59:49 -0700 (PDT)
Received: from google.com ([2620:15c:2d3:204:e464:1819:7745:be03])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70802464b18sm6939092b3a.45.2024.07.01.12.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 12:59:48 -0700 (PDT)
Date: Mon, 1 Jul 2024 12:59:44 -0700
From: Josh Steadmon <steadmon@google.com>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>, 
	Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 0/6] unit-tests: add and use TEST_RUN to simplify tests
Message-ID: <e2mbra55rl2cl746o7knmyczyxrkr3p2u5kacfz4x4e4enfdcs@4fudcpcjtq2b>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>, 
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>, Git List <git@vger.kernel.org>, 
	Phillip Wood <phillip.wood@dunelm.org.uk>
References: <85b6b8a9-ee5f-42ab-bcbc-49976b30ef33@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <85b6b8a9-ee5f-42ab-bcbc-49976b30ef33@web.de>

On 2024.06.29 17:33, René Scharfe wrote:
> The macro TEST only allows defining a test that consists of a single
> expression.  This requires wrapping tests made up of one or more
> statements in a function, which is a small, but avoidable hurdle.  This
> series provides a new macro, TEST_RUN, that provides a way to define
> tests without requiring to declare a function.
> 
>   t0080: move expected output to a file
>   unit-tests: add TEST_RUN
>   t-ctype: use TEST_RUN
>   t-reftable-basics: use TEST_RUN
>   t-strvec: use TEST_RUN
>   t-strbuf: use TEST_RUN
> 
>  t/helper/test-example-tap.c      |  33 +++
>  t/t0080-unit-test-output.sh      |  48 +----
>  t/t0080/expect                   |  76 +++++++
>  t/unit-tests/t-ctype.c           |   4 +-
>  t/unit-tests/t-reftable-basics.c | 228 +++++++++-----------
>  t/unit-tests/t-strbuf.c          |  79 +++----
>  t/unit-tests/t-strvec.c          | 356 ++++++++++++++-----------------
>  t/unit-tests/test-lib.c          |  42 +++-
>  t/unit-tests/test-lib.h          |   8 +
>  9 files changed, 462 insertions(+), 412 deletions(-)
>  create mode 100644 t/t0080/expect
> 
> --
> 2.45.2

One small nitpick on patch #3 and a question on #6, but basically this
series looks good to me. I'll be away from email for the rest of the
week, so I'll go ahead and sign off:

Reviewed-by: Josh Steadmon <steadmon@google.com>
