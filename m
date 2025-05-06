Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0899D280CE8
	for <git@vger.kernel.org>; Tue,  6 May 2025 13:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746537906; cv=none; b=reqJVinEYwBkatk4s+uSF4FNqSguYmMjl0DToKC/d8adpb7C61M3GDzAeqGZHmJhIegX8fq3xIiCM+mGu44D5QbTX7jrKgy3bZdvoHFq6VBVqbAOYHKPFkqWTHX99b/LlJveipyh9TWoNwA6XQfcOoB/WT82anV89uhh0dZFcDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746537906; c=relaxed/simple;
	bh=s2S03GLAgk4gHokyhNnf+sMdy530BFC+mgWf47pXb/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d02b/fFcXdRqHEAmm+ue6MaDF8acOKazqNe/4NsbPw7rptVIav2QW3ScHwTHlTOpHrxqGD+mm3LkGz3nmRCJv/gSK7Zc2qXY6QW/AwHFcVvJ4cNMqNwTfdwcruHdl1Rye2r7xk8iubXAU0B3/JZO+1HWs9aTKZClPkbZ25LtjeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=02pKXgyu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HPqQelpX; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="02pKXgyu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HPqQelpX"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E16791140154;
	Tue,  6 May 2025 09:25:02 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 06 May 2025 09:25:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1746537902; x=1746624302; bh=VnNfB1kHxH
	DIH4fe2I8MBT6Oe2p+vM/aK7PqbZOIvU8=; b=02pKXgyueP8tA6+A2y9qEqoyD1
	tt8pMRWD0kUshJ70nKoL0DA25ZKtd7kzXEGDION3+llbNB6QZsQOCjUe+jrfoeP3
	VCunmmixYYrpuwBqj6V+8Kjb+vi1JNYS6Ew3isVwBkj35WlpoCOGcXOHshP4ZJ7+
	M9wtEtDkc8FTY36GXS64f+paO8+7O6Hnk/82MAY4erhKf3D4o9N/xliZSiwHnL14
	2lqRUskwUMQ9AIEz6xknHKT3d6rxa9FSd5MXo1r5iBhcSWoeoBip5nRsaQJkl5hy
	CZqINLuP7DHFpLVigq4vo8kmU2UMQnR/+nTziU37fSH0fqsyocUMQGEVGi7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746537902; x=1746624302; bh=VnNfB1kHxHDIH4fe2I8MBT6Oe2p+vM/aK7P
	qbZOIvU8=; b=HPqQelpXt7KIp4uuwfYi3r/FDIAUmZOavNAuHhGYCaPJ0A5q3a/
	bH76h9bfgoIVBnWUH4lHacVfX8cXNGi3HogD0Nu4yizanQGr3rNkJb0QwCHIVtC0
	3koc2etvN0DbGqre5tVVFlZq5Hvq+x5ENxZdxQfkHajbOZf0qLrvMoVPbhk0U+sp
	gnAFKgp0DIMssEEb+tClWHrXFvajswgWTBYvG4V2H0Ydn9Ue1YJ7Ay0D1AGnh2yG
	kqj+QCI8PJfB0mcuzQZn/YSJP4Wejb0TUduam+paVyZ3XGqxxkc6v8EhNoNSnhL7
	YJlBbPkdjKNmYYmO+N+IG4j5/O3IF6dPlCw==
X-ME-Sender: <xms:rg0aaBLGzbtJDI6K_m-ZVjmvgeFzODuxfg-S0jgDaDu91qMlo6HjSw>
    <xme:rg0aaNKdH1Obn83dtzihnaZVIP9Sux6krr3RnTfs0k-tMPc1RJfYN7ufziArez5yA
    9I9Zkor6H8ISOdQjg>
X-ME-Received: <xmr:rg0aaJs2OV3hMsyYt4GWWQdFgvm_XaE6cg16Wjh8pkPmcSbrsH-1s1WhIYXXVq_qQAJ4KNKvhafWN9SsqEcLmc57Ka8OdkwbTaqdKuam>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeegtdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtth
    hopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehshhgvjhhirghluhhosehgmhgrihhlrd
    gtohhmpdhrtghpthhtoheptgholhhlihhnrdhfuhhnkhdusehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvght
X-ME-Proxy: <xmx:rg0aaCbuMh4iW-9pCux5LvNapAgxcxyv7R_TIVaJZZEqH3yGxEyojA>
    <xmx:rg0aaIZO8VjvKCBl9ls-m8z2wsujxypC5-EGpg3ExbxtjFy180FL7Q>
    <xmx:rg0aaGBvucO4ugQgqjVoHHNszepHgMHaOXCZR2FEr5YsmCzNzq_kCA>
    <xmx:rg0aaGY9Ik8FXLXKMyfDb2878Ej-pn4AqthrwCz_T-Pw2WBP5s7izA>
    <xmx:rg0aaEEkzdFTpRnNcEwaOK5MrUf4fhfEK96x0bLXhl6JatYrV0RuEjAp>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 May 2025 09:25:01 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e6dffbc9 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 6 May 2025 13:25:00 +0000 (UTC)
Date: Tue, 6 May 2025 15:24:59 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Collin Funk <collin.funk1@gmail.com>
Cc: git@vger.kernel.org, shejialuo@gmail.com, sandals@crustytoothpaste.net,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] wrapper: NetBSD gives EFTYPE and FreeBSD gives EMFILE
 where POSIX uses ELOOP
Message-ID: <aBoNq8sih36ToGGb@pks.im>
References: <20250503041718.42195-1-collin.funk1@gmail.com>
 <20250506010946.212068-1-collin.funk1@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250506010946.212068-1-collin.funk1@gmail.com>

On Mon, May 05, 2025 at 06:08:59PM -0700, Collin Funk wrote:
> As documented on NetBSD's man page, open with the O_NOFOLLOW flag and a
> symlink returns -1 and sets errno to EFTYPE which differs from POSIX.
> 
> This patch fixes the following test failure:
> 
>     $ sh t0602-reffiles-fsck.sh --verbose
>     --- expect	2025-05-02 23:05:23.920890147 +0000
>     +++ err	2025-05-02 23:05:23.916794959 +0000
>     @@ -1 +1 @@
>     -error: packed-refs: badRefFiletype: not a regular file but a symlink
>     +error: unable to open '.git/packed-refs': Inappropriate file type or format
>     not ok 12 - the filetype of packed-refs should be checked
> 
> FreeBSD has the same issue for EMLINK instead of EFTYPE.
> 
> This portability issue was introduced in cfea2f2da8 (packed-backend:
> check whether the "packed-refs" is regular file, 2025-02-28)

Thanks, this version addresses my nit.

Patrick
