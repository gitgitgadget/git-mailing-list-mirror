Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C7833F5B2
	for <git@vger.kernel.org>; Thu, 14 May 2026 19:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778785964; cv=none; b=lR8nXHE9ktO6WinjLIEl/AmcRikTjidhEEv5p6s9ijEJIxDLDVuUQSelfKGAJAnxbT8X5GPbvs7wm+0VQbFajYvr9HHltB9T6rll/uJZGSj6pgkoLA9VXVVhYsQeRymQ78Um/Sb2dKQgaJB9JlaC/7kr/iy0FlihTeZWK/GB9cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778785964; c=relaxed/simple;
	bh=cDHzvKAHlFIiP1eK/hwptaCac5RG7nEmaw2qurBWZXo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BiodncioCi/PqH82O0ME/ctZodQcIVylh/kOJjAIJjislX05adknVS3oBHXal5xg9E+ZXVTIFAdT2JcXVpiqGWDjkZSlH+ZLiWJWj75LPopk1azk6TV2ZeZ8Wt6M97WGH21uzJP08QB/BEd/16nKB4MsJfTZFwHpQxtRVX4dayw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=WoiR8xV1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nUr9hZO8; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="WoiR8xV1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nUr9hZO8"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 622571400011;
	Thu, 14 May 2026 15:12:42 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Thu, 14 May 2026 15:12:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1778785962;
	 x=1778872362; bh=CkRsQeSxIAv2sRJxYls3yNLwED1gQnsHxB5LcqSfHe4=; b=
	WoiR8xV1qQB2m3KwnHE4YBJoDuOSwWOkYYAPPK9txgygqjncZCkHLXF3FrnZmwDQ
	aH8CvUZJ0BTnCMXivfppnpQzrv8zHmMToRd0saH9GXsXWJxfKVXr+s4WK0l7nFV5
	+URCxjdk5VOPwpmV5cqf6V0o+GnNH7vQY0eBcftQWqGk0x/3fWOYvmd1hLzTVTI0
	kNjq9HAsZxGOj5pBSTXPxHv+Dul+h3J6387d4bQK7Pt97JjcAlS147MI9Uz3o6sh
	RgO7C5kr7Acv3my4tXwVYPcYBtXXZiq2gJYno/KYPBfoAkNXm3I5UbYg522f/bmp
	GhXVagIAi1rhqqqSElU8yg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1778785962; x=
	1778872362; bh=CkRsQeSxIAv2sRJxYls3yNLwED1gQnsHxB5LcqSfHe4=; b=n
	Ur9hZO8jjLUv6Scxj7T+eO6vtzsbrTH4AtBi0kGzLvsbM5PfqPKv1Fa3S7+VJXGC
	p6jrf27HPEwNW04KQb+1C0qOMXZ8TmvSU9dgIcxy9lqMHNu0PXQVx25pOwIWkXQ2
	oe1gEAfIFuvzV0LgNiKCfSfgsO4rhum04J2V7N626UnIzD1JFLgq8tCVerE4NES5
	rMMqvfQ2Nh5Xk3m9oxwq1EvnURhMQzbT5oyRbMVOa5l95FtNzUbOFswGwE/09J4W
	S7EDR4qi+Neebr2t2IeG+rJA2/Y1WiUJgK68Hfsw7KBkbTyIhDXzyzmHbgXstQk+
	1YaMH55BSTWZG/i4UVL8A==
X-ME-Sender: <xms:qh4GaseM4QjKAKovON4jQSCHY6r1SSlPodG0DZkPqbL5L5aeCAqD4g>
    <xme:qh4GalN7JimYillzLXyiwZhPB63Jd4N__BDLmeE24JqGJTy16NZNB_N2bPjOgUkbo
    GxACT7qDhpexLP1xlhiAnxmqCYkmgL1vSUPcUtyF3a94t9CZr2F>
X-ME-Received: <xmr:qh4GaiginTBkxQygVTmRb26fhlG00Uh_WLU7tRCtwpLI7hHBMkZ0rHlcIb0CjmvPp4pJ_HR9l6cIlMwK4eW7xecvtaORw31b7w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduvdekfeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtgfesthekre
    dttderjeenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhes
    phhosghogidrtghomheqnecuggftrfgrthhtvghrnheptdffvdetgedvtdekteefveeuve
    elgfekfeehiefgheevhedvkeehleevveeftdehnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnh
    gspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhdrshdr
    rhesfigvsgdruggvpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithhsthgv
    rhesphhosghogidrtghomh
X-ME-Proxy: <xmx:qh4Gag2Jl-Ujdnl3A_O3SPrt_yulrl_s5lkENYwXBkl2cx1Hgda3BQ>
    <xmx:qh4Gakg-5DHn31BEhlHhjbn17iXrxXEBT8snW-CqEQLPPy80Ka_c8g>
    <xmx:qh4GaoeCGXdft23tZj0zFl2jO2hYFxraZ7_u_QfzLWzJFfbMKlKp9g>
    <xmx:qh4GavnwgI__eC11IsHysRmi8g6NckqSMz2DmLD5t4pyLDA409fVng>
    <xmx:qh4Gah1iCzPVidtScrbRKG9Mg7u2uGGMSdQ9wCQ0dE_EUycFFjGGi8Fi>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 14 May 2026 15:12:41 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>,  Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] use __builtin_add_overflow() in st_add() with Clang
In-Reply-To: <0ded6062-f66a-4713-af24-d1b5aa654823@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
	message of "Thu, 14 May 2026 17:13:46 +0200")
References: <c6e9b337-c4fc-4cbd-ac32-e8d3814749b0@web.de>
	<0ded6062-f66a-4713-af24-d1b5aa654823@web.de>
Date: Fri, 15 May 2026 04:12:40 +0900
Message-ID: <xmqqjyt5g5zr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

René Scharfe <l.s.r@web.de> writes:

> Provide a variant of st_add() that wraps __builtin_add_overflow() to
> help Clang optimize it.  Use it on all platforms for simplicity.
> ...
> +/* Help Clang; GCC generates the same code for both variants. */
> +#if defined(__clang__)
> +static inline size_t st_add(size_t a, size_t b)
> +{
> +	size_t sum;
> +	if (__builtin_add_overflow(a, b, &sum))
> +		die("size_t overflow: %"PRIuMAX" + %"PRIuMAX,
> +		    (uintmax_t)a, (uintmax_t)b);
> +	return sum;
> +}
> +#else
>  static inline size_t st_add(size_t a, size_t b)
>  {
>  	if (unsigned_add_overflows(a, b))
> @@ -621,6 +632,7 @@ static inline size_t st_add(size_t a, size_t b)
>  		    (uintmax_t)a, (uintmax_t)b);
>  	return a + b;
>  }
> +#endif

Makes me wonder if we tweaked unsigned_add_overflows() to take an
extra *dst parameter to match __builtin_add_overflow(), which of
course requires us to all of 18 callsites, it might make the whole
thing a bit simpler.  New uses of unsigned_add_overflows(), if we
ever add them, would automatically benefit, right?
