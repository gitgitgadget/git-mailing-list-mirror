Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F9A2D6600
	for <git@vger.kernel.org>; Thu, 12 Jun 2025 20:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749759020; cv=none; b=HjcsUSYEVv3bBT/CCCBkerom8sZeYvISUD0zML2A7aDKItGT2jJE2DIwT9l+eHY3xRGBJfsLtSJsX3ZiU1Rm6LD7wpGCfR82cl9HuQZcL8VOpc6SOelTanL0GhdiXYBRUp7kfEN70Ukm4sMBPzz2+94NihvHqCJ3/r3vGxNSROg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749759020; c=relaxed/simple;
	bh=J0dz8WK3kkiaLHOqXMppCmQiVUacX7cpGM935LkWAWc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=A+IAlFM+yTaN7IhwK3PjwlBMfOQKAOVUNKLjXW9MIScSiF9JUdRT3JTg9OOJUjt1vwHX4gprRjbzt+ASy/bsXcTu1Er4Gfp4rewmbHUODa5or+jBkGhBVYdNZTUMM1iqtK1p2D8wYWfB/3AgFV2f2rz+0eJ/KoZW7NopUj0XUXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=e0Vgj4Xo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Pa4M3eH1; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="e0Vgj4Xo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Pa4M3eH1"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 2DF2211402B5;
	Thu, 12 Jun 2025 16:10:17 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Thu, 12 Jun 2025 16:10:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1749759017; x=1749845417; bh=gAZwd6mUgk
	KdpDv1mGgb4ub7LwUfSm0d8lMZgdfgNYA=; b=e0Vgj4XoDQPfkVR9bRaC9lCO9T
	WlhRsrA2xFYoxyDeaPY9X7tUiX/DgU6wNzUihkdnBAdPMdyFH3KZTpxWRMU6ZVIu
	eewySMXfbcyMXoT//+mo9z/t8L7FmjsivUIYSclY59OKSDdUN/GRdmkJhbXRdgeI
	jwkRgYA0kXU17lKbC+v3j7pjBM1520r4tghOT4BG8sDKhB6PUIRHzmC4LFNJ0aLf
	/udYkpSCN2fMq1n1OeLz0unGSNMs2lLOUrbsmip0gzZeHSXP2cVqfP5yRf0FOuoe
	idjuUN1MXrhh/O6BCeOuWMafG6nc1Q2GCqYDjq+E+9GFH9zXs08U6e5jjuPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1749759017; x=1749845417; bh=gAZwd6mUgkKdpDv1mGgb4ub7LwUfSm0d8lM
	ZgdfgNYA=; b=Pa4M3eH131qfjixzG2EGzwVB0G9zf0MaMaD5+ywG6hQoeO2OvNG
	jTb2v2ViDWtNH9W753M1CRKXyfYcqB3hyptafq8gd/WWnNrRUIoqP5/hVQ4089WG
	qwj7u/dXhRQae6abSZV7VdM8lPHH1++ypkBb7tBops3CP0+6cWmWkMW7LJP+oFQD
	iAXkia0IuJY/B8bsyMQrCiD2xFEdHYCqG/SUPV6KnskxAab/eHSSiJHERQHjt3Ez
	TFnLAxb1+cy9fb5XxlK37rJFfJzWPQy4wQnqS2QOGjK0H+RIQz+lXTNdHbix7CMd
	FStK8v79HW21Vb5NBO+jW7NR4hi7cCEblnQ==
X-ME-Sender: <xms:KDRLaCfaQCog0EGQVS8Wf4jubvErF6aVyKrb-ENWF8muA4pkLJJ2VA>
    <xme:KDRLaMMIhnceDz-00j7zSI8OiY-Y4kok-tdJ1V0yFcK80XuR_EjcjJBVd_eYJ-44P
    fm66SAKRS6q_e6wbQ>
X-ME-Received: <xmr:KDRLaDhFFXVIElZTnUxTEVLIAH3KTy4OyZ3CNFwOZDcoF3uteVJW07AXwbZA5LEm2ULM7mcCrpJIm8C_0ihpbjIClbuK94bHsyVO>
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
X-ME-Proxy: <xmx:KDRLaP80wpr0W5AC2qx2GOI6PQWivYU_F79KgCRpy6l5G0W23MZoKQ>
    <xmx:KDRLaOtupZnFZC6yX5pQv-PFm2Dkcq1n877tpMIOWdKPiKmuQ2Hm0A>
    <xmx:KDRLaGH4oZgK3TfMv5NDfSPBCYXbw3dkhLt_Xxcm50_I9kmbdRVamg>
    <xmx:KDRLaNN4JwzKSaP3gDEw82hrVffCiaAHjgWgRKJRp-ehIY_zyVgLDQ>
    <xmx:KTRLaKfplN-0AyyDFKa1a2BI06C-gKmjX4q4druJbFMvIjMn-WxxMsG->
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Jun 2025 16:10:16 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 2/6] bswap.h: Add support for __BYTE_ORDER__
In-Reply-To: <20250611221444.1567638-3-sebastian@breakpoint.cc> (Sebastian
	Andrzej Siewior's message of "Thu, 12 Jun 2025 00:14:38 +0200")
References: <20250611221444.1567638-1-sebastian@breakpoint.cc>
	<20250611221444.1567638-3-sebastian@breakpoint.cc>
Date: Thu, 12 Jun 2025 13:10:15 -0700
Message-ID: <xmqqv7p0d8m0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Sebastian Andrzej Siewior <sebastian@breakpoint.cc> writes:

> The __BYTE_ORDER__ define is provided by gcc (since ~v4.6), clang
> (since ~v3.2) and icc (since ~16.0.3). It is not provided by msvc as of
> v19.43 / 17.13.6.

I think it is more confusing than illuninating to have the last
sentence in the above paragraph.  There probably are tons of other
compilers that do not support it, and this patch does not target any
of them, including MSVC, which is the topic of the next step anyway.

So, I'm inclined to just remove the sentence, or replace it with
something like "Even recent versions of MSVC do not support it,
which will be dealt with in the next patch."

> The __BYTE_ORDER and BYTE_ORDER macros are libc specific and are not
> available on all supported platforms such as mingw.
>
> Add support for the __BYTE_ORDER__ macro as a fallback.
>
> Signed-off-by: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
> ---
>  compat/bswap.h | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/compat/bswap.h b/compat/bswap.h
> index b34054f2bd728..0a457542dd76a 100644
> --- a/compat/bswap.h
> +++ b/compat/bswap.h
> @@ -116,6 +116,12 @@ static inline uint64_t git_bswap64(uint64_t x)
>  # define GIT_LITTLE_ENDIAN LITTLE_ENDIAN
>  # define GIT_BIG_ENDIAN BIG_ENDIAN
>  
> +#elif defined(__BYTE_ORDER__) && defined(__ORDER_LITTLE_ENDIAN__) && defined(__ORDER_BIG_ENDIAN__)
> +
> +# define GIT_BYTE_ORDER __BYTE_ORDER__
> +# define GIT_LITTLE_ENDIAN __ORDER_LITTLE_ENDIAN__
> +# define GIT_BIG_ENDIAN __ORDER_BIG_ENDIAN__
> +
>  #else
>  
>  # define GIT_BIG_ENDIAN 4321
