Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943E7301460
	for <git@vger.kernel.org>; Tue, 28 Oct 2025 09:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761643099; cv=none; b=aN7Q3odGyhG74imHViUZZPtlrPH4UHV+ntQCe7Yxo2y9elVjVRYqVqgBVVoHNUTZj26P8MiF7H0wWOb9FobI9ttnwrs65GihRRvRTPRh+ZFoacmv5Vqo6IBJXbV33kMp8Zwuvt+5T3DrQnODf9/6Xuyc4HcB/O5TBxHruMA+dW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761643099; c=relaxed/simple;
	bh=q0wqW+x3ruIbh3cN/gAv/w9SHerI0VMjN7kdymWPPDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MfqqjPp2MOFQc85ys4zDdgwXccYkrJ+pxVxLDnoIiE6aLzlbTUKyIR3DY+goVk0tcczhvFJoXTRciFp3mG6j9jfQQEg1upWciJvs53oN9jKAMCPrygU5Acf8snX948RZLSc/TNymDmRQklbSeseOVqCXZl6Jbd1pSw/XZwCMoXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kiEQ76AG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=t/ateDlW; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kiEQ76AG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="t/ateDlW"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id B7FB2EC030B;
	Tue, 28 Oct 2025 05:18:16 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 28 Oct 2025 05:18:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1761643096; x=1761729496; bh=qv7ihuKT+e
	jr1GMMyR3w86qKcRH2x7m0krGaXhmZGhE=; b=kiEQ76AG23uAvd0mpb8CuQbEY2
	oheHD/nk97PYiTxRh8RwVRixcgdOVjDmhRHibWkgRdGwUut6ukmhBcDE0ghcVAI6
	fMbw5p7SlH/Ba4UWMcMdyBjwVgdkybFSfDMP+fT7ozo+DHzvwCRVOXr0BJoUQTXh
	ZbKN6NE8HuAQTVXi+pPJHFIGaL4NKj2Su/2jlIprxaFZqYyPc+Vzj49PMjctpWOs
	QPoHZ/Mu/fy04W56aJJ7mZtL7OeksbOxifc3sdNRoC5SgTPsBt1bqmIME5vWzqmp
	W+ew5k6S6GHeM42417PY+t1vHbH0daSoTTgmoBw8pYGSPJRIOp7/WpMoaFhQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1761643096; x=1761729496; bh=qv7ihuKT+ejr1GMMyR3w86qKcRH2x7m0krG
	aXhmZGhE=; b=t/ateDlWA2TuaAMrKbspsuUHaEMan0enZDG3fRfprTl0Dw66qsI
	HOfGaMnf76xg5uUrZt5SJ2fMpUNXy4VfOCeg7rdlXksu9WEU98lRQ/oRoMFAHvar
	E+iSMPz+zjnrrEi0n4iKuDIChjjHotfJBnUcSNoOnpQKYUR3ZlbQbIlcOPHLk+HF
	7fIrmelcAmp3PNujPATsWgkI6gdN9xtl8nlZFtueEWI0lPG4SrbhEmCsj1tmVZjV
	3kpFTNZeZk1aLyHoNDFWUfiiyo3G1kPEyNitLpQCSMEhxWyKsBfLL28uHz6r6ryQ
	oFbagTGf7GZTtGUwpzhG0IrI52FVcpFjCOQ==
X-ME-Sender: <xms:WIoAabkZIzTWw995542XcPr_BhlreTNZusfs8ztyg1ipN29XfsxsyQ>
    <xme:WIoAaV3qyEORz8ASmEpbl8LMJPLW6B_siBgyIVg6ycaMMEZSXBv4o2WvCcyKORNUk
    x7u8zJRz9bmOwelsSYJxig7LK25JZMkX3NH8swvWV1Q_Ha9JAr85w>
X-ME-Received: <xmr:WIoAaWplwYCRJFIOIL7ZvekbNtJCy3Yk_s31XKOFhVeVM2Oyk16x0NaeK8asyPOe-iI6wq2Iw3EL6dXvVcQwD7luJpJLpXC8XUUIFjx3NA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduiedtgeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtrodttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epjedttdegffekudejjeegudehgfehtdfgtdeiudelueelgfeuteehledugeeuueevnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvgiivghkihgvlhhnvgifrhgvnhesghhm
    rghilhdrtghomhdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhph
    grshhtvgdrnhgvth
X-ME-Proxy: <xmx:WIoAaSd4TdaDK6v1dWGvubr9ecD7NkJE3NaK7JlFe5vqmC583B4h3A>
    <xmx:WIoAaVpoJBybxXSYrjSIZurMefZa2jKgbieixHwP8X-3123lGn1TPw>
    <xmx:WIoAaTGYzz4y7weijNX3dvvPp-alMH1Auqe0_-SlJDVQ0ky3q5of8A>
    <xmx:WIoAaVvmNpTLHp1M2pwSR4t-zXIYkpkr_muGnsK3XXA6QSDUeLLmww>
    <xmx:WIoAaXsoMGaF2-b0zp6-kR1gwfMBfH1EILeHA9RSagbUZGHrwGaNPGtP>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Oct 2025 05:18:15 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c3342e61 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 28 Oct 2025 09:18:15 +0000 (UTC)
Date: Tue, 28 Oct 2025 10:18:12 +0100
From: Patrick Steinhardt <ps@pks.im>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Ezekiel Newren <ezekielnewren@gmail.com>
Subject: Re: [PATCH 06/14] hash: add a function to look up hash algo structs
Message-ID: <aQCKVGmhekVBthTh@pks.im>
References: <20251027004404.2152927-1-sandals@crustytoothpaste.net>
 <20251027004404.2152927-7-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027004404.2152927-7-sandals@crustytoothpaste.net>

On Mon, Oct 27, 2025 at 12:43:56AM +0000, brian m. carlson wrote:
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

I think we should have some safety mechanisms here to verify that we
don't cause an out-of-bounds access.

> diff --git a/src/hash.rs b/src/hash.rs
> index 1b9f07489e..a5b9493bd8 100644
> --- a/src/hash.rs
> +++ b/src/hash.rs
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

I guess eventually we should replace such declarations via bindgen. If
so, we could also pull in the `struct git_hash_algo` declaration and
have the function reutrn that structure instead of a oid pointer.

Patrick
