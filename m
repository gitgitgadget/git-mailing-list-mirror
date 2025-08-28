Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9821DFDE
	for <git@vger.kernel.org>; Thu, 28 Aug 2025 20:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756413941; cv=none; b=hjEYgK74Lv+ZUF9S7THZenPzUtd3fdjBAGg/yvds8WXKyij5SUtFaYxEW6zVau+AP1Acw4BJgacNxbGCgcfW6+F3tcV8MkDWa4AJDNU0fWnMXyzBkUDu1NS7mMkYW6VBMz0DFDy/ajxSh/ml0p05xE0Gnznf22yxa9swqy2ebr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756413941; c=relaxed/simple;
	bh=lzRFj2s3qM4BBiPgLz2Wqt2fob+rFg/9Cd0w1PD3Q+4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qtbsKkvqJCKwmZ4HhTrrqDohULh433PwqgO2Y7FgPTK4t9HqN96LtjbYogMrDmylbYCuZ8nu1fRaKMLPG0/4X17wGfxitYogsxYCK2YYohSZQv5xxPYNsKRbIkiZI+aqtxoF+9V186qSRP9peNc/obp3aqUBDNMsY6vKcwOmkE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=VVsuNMHg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TDfktt7m; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="VVsuNMHg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TDfktt7m"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id EB6B01D0006B;
	Thu, 28 Aug 2025 16:45:38 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-07.internal (MEProxy); Thu, 28 Aug 2025 16:45:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1756413938; x=1756500338; bh=Ystt0ow84/
	0pDIuMhZsTv/iZxWgDJf7sJ7OQsfCLc5Y=; b=VVsuNMHg5zexhTRcte1stnLmma
	g7ZPPCUYnRu3XXPLHIxtMOBAtOBr5LwpDuqks0Q4gFe82440EeX0g5slv9Vhonqd
	eyXm9ijmBxleQiPLjxtNd3oLsxFuDrjbSUKOq53Xge60tZWcZU9N75uujn4mBchx
	qNrWKaMD4uLWmAGA23WqNA+i//mDoPdLlE6x9e8CyFh3wY4vk6SIS46uGGQCWS+K
	I9vJbwW9WvY5ybfI6TcLdFfoPtC8EeaJvpllHXzgpwaavpn/V3XDFyySaWT+lPXa
	KlubvRO/evLsIJQUfJ6ec9zkG4IsKOjvlCIJ0O/KnbBlsIEmywK5BgcQnxRA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756413938; x=1756500338; bh=Ystt0ow84/0pDIuMhZsTv/iZxWgDJf7sJ7O
	QsfCLc5Y=; b=TDfktt7mTvwnd8uE0DvLHMs8A77GQONp3jJx/PxoLDxFpfvAy6u
	FlbU5H7VjYWmhp18UHRCY2JlmQwrMlJPyPNLpDEkWtAjl5uls89y4DPuoOHFOC08
	Dad9bHFPXBdezPamzLOai2j6MxxRZSHiyK7jFs9VUVtK32l7jcXVI5oGeuG2addp
	2mzgA5bXiYgdWDmyfqeIZOGVrrOjUBiX4nVeF6LD9KDHoGktzd3Mu762gvtn8Mrk
	lMC+69zREYodP1OopcRioY2PLKHTYdiwhz1Xw0aG4HUtkyN7h/6OAX//uCDH2rSV
	D1PUTiXtN5jLQkAIt6nb8IavNG8frFQoXtw==
X-ME-Sender: <xms:8r-waGxam7ObwoX0UzSuOnux6-u6LndnFU-dfqGXeRlg_UW9_cOoUw>
    <xme:8r-waNwaBbN6-02iQr95DQKQQql66sjKn1Ga8jljjcJ9ETuSZd5DfulHF5vDEbWRP
    mitxc4VWxffhzkPEg>
X-ME-Received: <xmr:8r-waOxBv99fSeHvGF7v6DWAzIoBvZTAf8fTBtNdWWkiHfuPWpixBLsmIS__JnIxSdwkSoCBTNRa150-tRnebKSSWlyYUuh-yH1mMR8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddukedvtddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepshhtohhlvggvsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:8r-waHbWTrychUhJNv52hq5HZt3FTN9dXuD0OTAVQJCxsR77pg_-fA>
    <xmx:8r-waPWtAw-YIMpVE7fSnP2-ajEZ-B1NZ5WkZrHNiCldT1DR5dLp_w>
    <xmx:8r-waFh38Nxg6-CvJlDk17kEawdX4WWIOVlXl0FRTdMJ8qrjhDKiLQ>
    <xmx:8r-waNshLWqiFtWVhbYjpoUD730gYGHNb9rxpy0hxFqHr8YKF-owWA>
    <xmx:8r-waPXF9KplucorOBQ5YX_iAwX7LubUC8hTeKKF8Cb1IU3JkipnxiB9>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 Aug 2025 16:45:38 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  me@ttaylorr.com,  Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 2/5] midx-write: put failing response value back
In-Reply-To: <709555c5316014b2b4d6648db407d15160769146.1756402795.git.gitgitgadget@gmail.com>
	(Derrick Stolee via GitGitGadget's message of "Thu, 28 Aug 2025
	17:39:52 +0000")
References: <pull.1965.git.1756402795.gitgitgadget@gmail.com>
	<709555c5316014b2b4d6648db407d15160769146.1756402795.git.gitgitgadget@gmail.com>
Date: Thu, 28 Aug 2025 13:45:36 -0700
Message-ID: <xmqq1povuqdr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <stolee@gmail.com>
>
> This instance of setting the result to 1 before going to cleanup was
> accidentally removed in fcb2205b77 (midx: implement support for writing
> incremental MIDX chains, 2024-08-06).
>
> Signed-off-by: Derrick Stolee <stolee@gmail.com>
> ---
>  midx-write.c | 1 +
>  1 file changed, 1 insertion(+)

The cover letter made it sound as if [1/5] was the only fix and the
rest was clean-up, but unless all callers of write_midx_internal()
ignores the return value from it, this surely would change the
behaviour of the program, no?

And the results from write-midx_file_only(), write_midx_file(), and
expire_midx_packs(), the three callers of this _internal() function,
all seem to be used in builtin/multi-pack-index.c so wouldn't this
also be a fix?

Not that I endorse "0 is success and any non-zero value is an error",
but this does not look like a mere clean-up to me.

> diff --git a/midx-write.c b/midx-write.c
> index d8f9679868..85b2d471ef 100644
> --- a/midx-write.c
> +++ b/midx-write.c
> @@ -1106,6 +1106,7 @@ static int write_midx_internal(struct repository *r, const char *object_dir,
>  			m = m->base_midx;
>  		}
>  	} else if (ctx.m && fill_packs_from_midx(&ctx)) {
> +		result = 1;
>  		goto cleanup;
>  	}
