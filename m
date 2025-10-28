Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E90F34EEEC
	for <git@vger.kernel.org>; Tue, 28 Oct 2025 20:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761682356; cv=none; b=Nnlw0+sKaHLX8yqiWHpz0dTJnk1spw7WejD1YYQXNfaTvHkNM+UbzY+FuCAah4ynAtq/BwKRCyQ81WQHfvFkZAUY+h6I0A1TlOZk+wpukQchDzA/5kxU1sJmTt8hHuOOGe41JADaVB29trq7Py2OgwsRW1qK0EH4MOCmw2lMxBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761682356; c=relaxed/simple;
	bh=YONGfv2tUc/ysA34KNQUL8782RV+GBXuSoY6p4uA3K4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kenRFsl8+P/cZth1iGQnasVenztjYy1fAxSh7szKQkylYfXqIEplo5uTS55kJ+XEwozkWlxFAxPtNbDzw+SaWw1+dhuhqRvbHO9HbHoJ3gSQpwXslUjWQFD4wLQ/Z+ccshjT/otkafhiiz+218ZVenRgka1UiEmoPn42Rh+B9ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=J915vmZ6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eVEtaYh9; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="J915vmZ6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eVEtaYh9"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id BDE521D000BD;
	Tue, 28 Oct 2025 16:12:32 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Tue, 28 Oct 2025 16:12:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1761682352; x=1761768752; bh=Nv3HFoWaUg
	kMFw5OCwgH+cPO4pBQdxHomnvtEZ3l8e4=; b=J915vmZ6S8raRNnuoIKIf+qAnB
	PvuSIRzQHH6+qojbgc0ZYsZ6bIRdnvDoeHrHeFcqR0RDpTbWygxx9YVfJsrFbHcG
	YWK4VofllbYPPIIYGcSnem6Tt8fYoCvgF06GC9IW8XROlmmh58rBbZEMh7x6lyt7
	E4VsR8pdPLkyym6nZjLPCIGDeacvhd4XJDL41sgajsVdJEbsm83sc06DZnbXXiWs
	31gs0YuBFqR13Y0aSTqnCLJ37G9ACJQBQFCPMjMFL+L1BkVqVjgnRwDYN6BE4Gav
	pYZrjKzhEui1iLGxvDvwcPw48hnjBlTj5bGtZqh+flv57T4lV333sRA8Gh5A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1761682352; x=1761768752; bh=Nv3HFoWaUgkMFw5OCwgH+cPO4pBQdxHomnv
	tEZ3l8e4=; b=eVEtaYh9ogrIBZJJoqrvxX+vMDbi5S8yjEBEvlxvKIfVA8Vd5n6
	j4+bcbNd/lgRMGnGQWWlN8QEDyEanBi4VxUpVt28vQaqI2+8dzAiVR4mq9OVbUKN
	MJ5/C1rGImQSZMEgb+F9zq/aAHrOA2pHpRsV47dKXQiPfDcbt4d/P8M6pMII3PhL
	6bVP5fxYw4hkpiDfwvsYpKhd72h8ZrSpoV6sJjvI2eGRKTvL/rmq2WC0iXR+PtPl
	GT7jZN+5bi8BKHjxjL73MPLDfxrGFn383rU+a+o6DTh2e+Lr89uKFPILjObDvkzd
	UtpOZKcA8f0AQ2tpOJm7oduWTMAxwK8VhWA==
X-ME-Sender: <xms:sCMBaTUU7aV-Qdos5qzO4ROWS0CvFELZR4yzTdSPDn_PhXDrCu0UwA>
    <xme:sCMBaScfIlj5iDoC54Ro_xMHheHFko5TtLeBgpyZKnn_kilaGz2O8hKACrOZXReQt
    c0ez2h8YtsZj8PIq25QT6zYMKUWhRnwShLIDfSHl0xswWJD3c0wiQ>
X-ME-Received: <xmr:sCMBaXvgilsM6Q8twJ5bVB4H2GjX3_1dUNSBo4V9qg32oOWoEAjOXH1XwGPagUb9qyJQch7eTfd39q9df9gjdQw-m7CCWYq0_80g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduiedujeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprg
    hsthgvrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepvgiivghkihgvlhhnvgifrh
    gvnhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhm
X-ME-Proxy: <xmx:sCMBaZ9A1eC4y3XjMopulBPPsbcAHj8x1RpDYs2fP_hLjuSik9noaA>
    <xmx:sCMBaa0ahfysEJCSTs5Bq2CSDBKVoow0bDY640HHSMfEA2_golkvnQ>
    <xmx:sCMBaWAjHLw9pGYw3JqZcBd7xl1JKX63q40hvy4R_7PyYAfCUE297w>
    <xmx:sCMBaeeXfJKPXNWqMnF0vB0cvqEHP3ngZ1XZi_2H_PO9tBtNB9Jdig>
    <xmx:sCMBafux8BXNsL3RTELEgKW477qzDzsbaGj5UTuFVvyAM3LF8fvcPCed>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Oct 2025 16:12:31 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: <git@vger.kernel.org>,  Patrick Steinhardt <ps@pks.im>,  Ezekiel Newren
 <ezekielnewren@gmail.com>
Subject: Re: [PATCH 06/14] hash: add a function to look up hash algo structs
In-Reply-To: <20251027004404.2152927-7-sandals@crustytoothpaste.net> (brian
	m. carlson's message of "Mon, 27 Oct 2025 00:43:56 +0000")
References: <20251027004404.2152927-1-sandals@crustytoothpaste.net>
	<20251027004404.2152927-7-sandals@crustytoothpaste.net>
Date: Tue, 28 Oct 2025 13:12:30 -0700
Message-ID: <xmqqwm4ebxap.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> In C, it's easy for us to look up a hash algorithm structure by its
> offset by simply indexing the hash_algos array.  However, in Rust, we
> sometimes need a pointer to pass to a C function, but we have our own
> hash algorithm abstraction.
>
> To get one from the other, let's provide a simple function that looks up
> the C structure from the offset and expose it in Rust.
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  hash.c      |  5 +++++
>  hash.h      |  1 +
>  src/hash.rs | 15 +++++++++++++++
>  3 files changed, 21 insertions(+)
>
> diff --git a/hash.c b/hash.c
> index 81b4f87027..2f4e88e501 100644
> --- a/hash.c
> +++ b/hash.c
> @@ -241,6 +241,11 @@ const char *empty_tree_oid_hex(const struct git_hash_algo *algop)
>  	return oid_to_hex_r(buf, algop->empty_tree);
>  }
>  
> +const struct git_hash_algo *hash_algo_ptr_by_offset(uint32_t algo)
> +{
> +	return &hash_algos[algo];
> +}

Hmph, technically "algo" may be an "offset" into the array, but I'd
consider it an implementation detail.  We have hash_algo instances
floating somewhere in-core, and have a way to obtain a pointer to
one of these instances by "algorithm number".  For the user of the
API, the fact that these instances are stored in contiguous pieces
of memory as an array of struct is totally irrelevant.  For that
reason, I was somewhat repelled by the "by-offset" part of the
function name.

The next function ...

>  uint32_t hash_algo_by_name(const char *name)

... calls what it returns "hash_algo", but the "hash_algo" returned
by this new function is quite different.  One is just the "algorithm
number", while the other is "algorithm instance".  Perhaps calling
both with the same name "hash algo" is the true source of confusing
naming of this new function?

> +use std::os::raw::c_void;
> +
>  pub const GIT_MAX_RAWSZ: usize = 32;
>  
>  /// A binary object ID.
> @@ -160,4 +162,17 @@ impl HashAlgorithm {
>              HashAlgorithm::SHA256 => &Self::SHA256_NULL_OID,
>          }
>      }
> +
> +    /// A pointer to the C `struct git_hash_algo` for interoperability with C.
> +    pub fn hash_algo_ptr(self) -> *const c_void {
> +        unsafe { c::hash_algo_ptr_by_offset(self as u32) }
> +    }
> +}
> +
> +pub mod c {
> +    use std::os::raw::c_void;
> +
> +    extern "C" {
> +        pub fn hash_algo_ptr_by_offset(n: u32) -> *const c_void;
> +    }
>  }

I am somewhat surprised that we do not expose "struct git_hash_algo"
the same way a previous step exposed "struct object_id" in C as
"struct ObjectID" in Rust, but instead pass its address as a void
pointer.  Hopefully the reason for doing so may become apparent as I
read further into the series?




