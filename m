Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0F523A56D
	for <git@vger.kernel.org>; Mon, 13 Jan 2025 09:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736760335; cv=none; b=uvXpB0/qNo0Uv0sQnPNnhJtPqIpE+WWSfGMTvOvtEuEB+Lc0JUSz4jUOgrLNgiKg8ElgrRMhZ00jwkqJuLEUmrLylBbpNZWSLBtctesZnDwBEPqxynp5mQtL75WJ7x/FcGpzY3Ht0VhoD/a8X7tuWRt5M9JnfelEf8lMtV+wEZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736760335; c=relaxed/simple;
	bh=V49bjMr5G5XpNtIZUOtQboOO1NPR25DQQZ6YalZh0yQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XQlpCJFltZlYsqG04/g35CgenBAGV0ajwCNCLFZSAQV1Q0Sbj/RP/sWQQp12rKYecP5R2xyonvsF9QsgEg/KycV4dQ4mmNNgBJuoU6Eqx0jFU1aJ8wY6NGpUHAwuC9Lefm6PgdXftc6tMitDcwu6WCW574atHOg286jNb/ILHlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=E5x+odj8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sxStLGZp; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="E5x+odj8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sxStLGZp"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DD1BC2540195;
	Mon, 13 Jan 2025 04:25:30 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 13 Jan 2025 04:25:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1736760330; x=1736846730; bh=LVR+Yia9km
	11yMvGAnJaRcXZk9ZHflIk7SfmGo3z/E4=; b=E5x+odj8XmoLkZ/zLS0NGdg7ld
	QzlqHHjufl1xVtEYEFmEwmStYjZf0UcnX9bfsTcIyguc3OkvqYsNxZKDUSS6aaWQ
	txbtKAhcqwm2aVGa08XissljPXfXx0oEP1y7xsjpbpFZGDH640mPiLxPSa6dYXy9
	t/Ur5w2Wfr5o/AreiGQYe0amnmSD+oRgqfJY31/DBBAyPSfa7uHs19ZPdyM6gMry
	Fs+/cU8AGWAee2K6rjryH24mfpoMo1qRoyD6a6hTU69JFAdQ3Lrm064kkhgZQ+do
	MJAjBvqG/q2DC2ktJ5SxSESu4VuKzaJ4df6K36mWwDI6gtkpaFWHRZCS14rw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736760330; x=1736846730; bh=LVR+Yia9km11yMvGAnJaRcXZk9ZHflIk7Sf
	mGo3z/E4=; b=sxStLGZptOlGd9KzN9ubiaQODIuOJvb55/OP/P+zSn3Sj2OA6ZY
	zm+5PzMW6K0q5+wSOs7BFQoAWTn54u1kXM3ylT4o0t0JO5EmWy4mLtvoW6PpEY3f
	/+2SOB6/82vX9hKZFXxFGDalLpUz9dviBvdKPCJsHqbNrDCHrRSXkda/XW7rqoHc
	q1Py2O542GKB5bUVyQHphJ21z535bCzGh0Rs3+89D6HJ/bklogJJwLrPsRuEFWq3
	BnLeeVpIShQs9aU+SXxGA/bg8l6n2M3fd/vGC2fw+l8FydbHLfgyoF+X2Ji2gEP/
	S8hB1YBUbDXYRbNVJUDAQbb7pXGGAKlF91g==
X-ME-Sender: <xms:CtyEZ-YU6nrCq2P9Q_sCnlXVxocCB-ylzAqL4UuALutisZp20cXAsg>
    <xme:CtyEZxamb6SBKVull9AzXYR2Z-HOCdnvZuX0pqadT-qzCPdM7OJi4sWZp0Rujk0sO
    okGp1oMLF9l1HqCuA>
X-ME-Received: <xmr:CtyEZ4_TaXrKeSUSbv_gCPZq_kjahNjh-AKG_YAiy11u39WqoZu9r90Ctb07AdWKpI_QnUQN-H-SNLLxkpcFYEncU_1UZ2TlBxU-XaUsCHz8sNmd>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudehgedgtdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepvghstghhfigrrhhtiiesghgvnhhtohhordhorhhgpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegv
    vhgrnhdrmhgrrhhtihhnsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:CtyEZwr62IE6jGM3jaNAEEXQHo-7fnuYvZoMon6ut4gz24JRNYeUvA>
    <xmx:CtyEZ5o2g6MQ76R0mPonh-XqPjMtXiDUsyyXTJu9njdpQs9cI746HA>
    <xmx:CtyEZ-Q3y-RcsExC-68n3OyF-QW8_NCgGZM22lOUvJzaearXNcAhNA>
    <xmx:CtyEZ5o1i69d_x3yztrF-Qe2r8HrGOy_oMaebjR4E0G0xfT0K7-XFg>
    <xmx:CtyEZwU2hUvM7_xwZyTtluhqy-5VxqPRiuc7w-6KpbdWsTp7em8mSdcJ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Jan 2025 04:25:29 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 15b1f7a5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 13 Jan 2025 09:25:26 +0000 (UTC)
Date: Mon, 13 Jan 2025 10:25:25 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Evan Martin <evan.martin@gmail.com>,
	Eli Schwartz <eschwartz@gentoo.org>
Subject: Re: [PATCH 7/9] meson: make the CSPRNG backend configurable
Message-ID: <Z4TcBRt6CX6Q3a5i@pks.im>
References: <20250113-b4-pks-meson-additions-v1-0-97f6a93f691d@pks.im>
 <20250113-b4-pks-meson-additions-v1-7-97f6a93f691d@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250113-b4-pks-meson-additions-v1-7-97f6a93f691d@pks.im>

On Mon, Jan 13, 2025 at 09:33:40AM +0100, Patrick Steinhardt wrote:
> diff --git a/meson.build b/meson.build
> index 5e1373f6a52a91beb527d00d8fd5c55d377c718b..cb352ce6fd50616e3281a776104692c5b2bfa5b2 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -1325,6 +1325,7 @@ if not meson.is_cross_build() and fs.exists('/dev/tty')
> @@ -1421,18 +1422,28 @@ else
>    error('Unhandled SHA256 backend ' + sha256_backend)
>  endif
>  
> -if compiler.has_header_symbol('stdlib.h', 'arc4random_buf')
> +if csprng_backend in ['auto', 'arc4random'] and compiler.has_header_symbol('stdlib.h', 'arc4random_buf', required: csprng_backend == 'arc4random')
>    libgit_c_args += '-DHAVE_ARC4RANDOM'
> -elif compiler.has_header_symbol('bsd/stdlib.h', 'arc4random_buf')
> +  csprng_backend = 'arc4random'
> +elif csprng_backend in ['auto', 'arc4random_bsd'] and compiler.has_header_symbol('bsd/stdlib.h', 'arc4random_buf', required: csprng_backend == 'arc4random_bsd')
>    libgit_c_args += '-DHAVE_ARC4RANDOM_BSD'
> -elif compiler.has_function('getrandom', prefix: '#include <sys/random.h>')
> +  csprng_backend = 'arc4random_bsd'
> +elif csprng_backend in ['auto', 'getrandom'] and compiler.has_function('getrandom', prefix: '#include <sys/random.h>', required: csprng_backend == 'getrandom')
>    libgit_c_args += '-DHAVE_GETRANDOM'
> -elif compiler.has_function('getentropy', prefix: '#include <unistd.h>')
> +  csprng_backend = 'getrandom'
> +elif csprng_backend in ['auto', 'getentropy'] and compiler.has_function('getentropy', prefix: '#include <unistd.h>', required: csprng_backend == 'getentropy')
>    libgit_c_args += '-DHAVE_GETENTROPY'
> -elif compiler.has_function('RtlGenRandom', prefix: '#include <windows.h>\n#include <ntsecapi.h>')
> +  csprng_backend = 'getentropy'
> +elif csprng_backend in ['auto', 'rtlgenrandom'] and compiler.has_function('RtlGenRandom', prefix: '#include <windows.h>\n#include <ntsecapi.h>', required: csprng_backend == 'rtlgenrandom')
>    libgit_c_args += '-DHAVE_RTLGENRANDOM'
> -elif openssl.found()
> +  csprng_backend = 'rtlgenrandom'
> +elif csprng_backend in ['auto', 'openssl'] and openssl.found()
>    libgit_c_args += '-DHAVE_OPENSSL_CSPRNG'
> +  csprng_backend = 'openssl'
> +elif csprng_backend in ['auto', 'urandom']
> +  csprng_backend = 'urandom'
> +else
> +  error('Unsupported CSPRNG backend: ' + csprng_backend)
>  endif
>  
>  if get_option('runtime_prefix')

I just noticed that this generates warnings because we use features not
yet in Meson v0.61.0, which is our minimum required version. I'll convert
these to instead use `compiler.has_header_symbol()` consistently, which
is nicer to read anyway, and will add another patch on top that makes us
use `--fatal-meson-warnings` in CI so that warnings will cause us to
abort the build.

Patrick
