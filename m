Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D2F22DF95
	for <git@vger.kernel.org>; Thu, 12 Jun 2025 20:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749759092; cv=none; b=sFDWPVFk3j/wx/+ESnzWIvJcXlHktSZYS9+qq5bA+UvHwRP7aAwSki2uN+8vuKQqyP8ib7RxFpi6czlC8SZ2cgbMC2jiQ9MrqFx8v0hVGtGlCJMFOrPKPcKDLHmcnRtMFxuvEUs4Fkq3h6On9ib/tJWKtYo5geU2DA/L9QtoqV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749759092; c=relaxed/simple;
	bh=9BibdMzLRSBW2Np9h1o843PPweE3HLAnC8cbJ/83H1M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YUCs+Dmy9xh386wz7lD9sqxFvOBZASvhze2QxWhfp503JdsnaNgy3DviVcuxoTMEZrpkwOhEXegMS+YOze8skquw3B+52DK/kd1MYRtgxRQoMRuiyd5NlSGeIc05m3TWhdWGcRi3elVH1wTOYVor4NhTTR2U0tG2qklGzwOhYxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=uLS41M95; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=I6wAfV2d; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="uLS41M95";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="I6wAfV2d"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 95ABE114020C;
	Thu, 12 Jun 2025 16:11:29 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Thu, 12 Jun 2025 16:11:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1749759089; x=1749845489; bh=OoO3f+6t55
	yBHZJpi1F1iEtugl/8raiTOYpdG2ElNjU=; b=uLS41M95y9+fS/YCcD3L/rZS+S
	XyOBoeU/Yaainf+7ELP6zIp1ZBM90LjzGDk33foLda6SZDKrpfU8TnDJrWgIwWkZ
	4RbF+AuPBq3Z6J7ETynTzBRrxAvI61m9gZ4cGhYe9UmdN5ew6CHRLF8UFUXxm4JG
	x0jdvonj5v9oNHj+brgO9QWkH01+can3xt6g+hUPgZQB4Nxsyvic/v92k+iAkiNM
	SbbgJ8BjytYDm/xFAu1PzlHGeRF7u+Yh07VYIv1kW1+Hkrmo6MKqlU4tsAzHMqrU
	gl/2hTvGhpFcuC4LL9tK1U5nVeEZTxhrSK0y+r0wHA35P9cA/hlBTLKsEfAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1749759089; x=1749845489; bh=OoO3f+6t55yBHZJpi1F1iEtugl/8raiTOYp
	dG2ElNjU=; b=I6wAfV2dBiKo6JVpTAhN+/Ww0x9F/zfUcZvAZPysZ1fNh2N0PTX
	NN3bBNwJLpbbBae1YecxeYvhzIQB+P9vye/auxet3a7hcwKXvfPwwdbLs5FSMnGH
	MIZjsxwIe4IaNouFBXcw8sjllE7ZoMjgt24x7X1YIIPK+ENfv8VfrCVJtnOxgsFs
	+ftHI94yr9SfJeCawr9+sqOZBwELW2b2k2ANseRhnf7fnPdrUn/HJ9uHpdAHZ7Vx
	Sdhi63++tT3YWTWDPEGaqGqHyxcssH6BjTJ7LhON++U28nNrxaMd9pMuTQh3Y/PF
	OG1dmXvEOaJatwS8AS0Oz4eKJmlo0NHJQ5w==
X-ME-Sender: <xms:cTRLaDpMIuAK05k7dlYyCH6tRQyCTkT5Cworl_IN6HBgnpDyDkmnfQ>
    <xme:cTRLaNqshBgGKJ6RSErbt077eYrv8K6tZUWOSEVXDMdJbaGSGIo_8HnbpNwUmVxUv
    kXK5DP02woH7jyDKw>
X-ME-Received: <xmr:cTRLaAPNIQA1zFh60aMUR2Gbmcq4q6CUE9kWcWaPsMZl6VBvLHmkkXP-Krfa5-28lXGZpa9PYgJDgqHrOYknIQIOlfF_gPLk2WSN>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdduheellecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehsvggsrghsthhirg
    hnsegsrhgvrghkphhoihhnthdrtggtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:cTRLaG5oPEqzCJlL6uPa44-N1wyKEWuxhayU0qqDEBDp0sUQG2VJ7A>
    <xmx:cTRLaC4PN8dA31ldXlWTjSKllpgCpot4qKmDKkR7G7PsnMOyZOY-Rg>
    <xmx:cTRLaOhmY61pSXzIGLldZAPCyDFIUKlqWm_c775WmTTEn0ScsCMT4w>
    <xmx:cTRLaE7SRKK6p7OB21eHL2KGMfH2CuxroVtbqKrSIkVAakp7Q232aA>
    <xmx:cTRLaK4nq0q1ZMvEg5SarBzyq_jSa6VGuCavgXKxPE7LKuRIoTuSIXEx>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Jun 2025 16:11:28 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 3/6] bswap.h: Define GIT_LITTLE_ENDIAN on msvc as
 little endian
In-Reply-To: <20250611221444.1567638-4-sebastian@breakpoint.cc> (Sebastian
	Andrzej Siewior's message of "Thu, 12 Jun 2025 00:14:39 +0200")
References: <20250611221444.1567638-1-sebastian@breakpoint.cc>
	<20250611221444.1567638-4-sebastian@breakpoint.cc>
Date: Thu, 12 Jun 2025 13:11:27 -0700
Message-ID: <xmqqqzzod8k0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Sebastian Andrzej Siewior <sebastian@breakpoint.cc> writes:

> The Microsoft Visual C++ (MSVC) compiler (as of Visual Studio 2022
> version 17.13.6) does not define __BYTE_ORDER__ and its C-library does
> not define __BYTE_ORDER. The compiler is supported only an arm64 and x86
> which are all little endian.

"an arm" -> "on arm"?  Just sanity checking before making local
typofix while queueing.


> Define GIT_BYTE_ORDER on msvc as little endian to avoid further checks.
>
> Signed-off-by: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
> ---
>  compat/bswap.h | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/compat/bswap.h b/compat/bswap.h
> index 0a457542dd76a..fd604d9f7b74b 100644
> --- a/compat/bswap.h
> +++ b/compat/bswap.h
> @@ -81,6 +81,10 @@ static inline uint64_t git_bswap64(uint64_t x)
>  #define bswap32(x) _byteswap_ulong(x)
>  #define bswap64(x) _byteswap_uint64(x)
>  
> +#define GIT_LITTLE_ENDIAN 1234
> +#define GIT_BIG_ENDIAN 4321
> +#define GIT_BYTE_ORDER GIT_LITTLE_ENDIAN
> +
>  #endif
>  
>  #if defined(bswap32)
> @@ -122,7 +126,7 @@ static inline uint64_t git_bswap64(uint64_t x)
>  # define GIT_LITTLE_ENDIAN __ORDER_LITTLE_ENDIAN__
>  # define GIT_BIG_ENDIAN __ORDER_BIG_ENDIAN__
>  
> -#else
> +#elif !defined(GIT_BYTE_ORDER)
>  
>  # define GIT_BIG_ENDIAN 4321
>  # define GIT_LITTLE_ENDIAN 1234
