Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC925301460
	for <git@vger.kernel.org>; Tue, 28 Oct 2025 09:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761643113; cv=none; b=RjNWLmJlYIsvWX+nULLuji6l/su5sB8RaQvJGt30AJazFUHfUOGv6Bo5qjyfFZ81UMv5ULbhEdZnkbsnnUAT7yHAr2dJDyRGP6OS6nuDGtykAUvxUFm+3bqHNmZKkfHE+Oe2iTaABN2s9sJ6zHiHljWQnee1ev/pk29ILvxYHkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761643113; c=relaxed/simple;
	bh=BxyWBicwsQg8PEBXosCQP/nT+/f89Bx90IzuN7fcmtU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KHNPjRhB6G4cWyNwhcJ8dtd1SYsfCxOxIERcKSjWTDNk+SD/AxygTgv23HB5PRgqDuPz/xzQ+kvv0l03Cmf1/Y5C9CPqJT8mRt+H5YHbBQ1yyp3cr/evGv3x6r9ncuz2948j38zyq5o6eCjdLley1zRRldcHXc3sGS3iUrFU05g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ESxWPnTg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QaqrhGba; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ESxWPnTg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QaqrhGba"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 12CBA14002DC;
	Tue, 28 Oct 2025 05:18:31 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Tue, 28 Oct 2025 05:18:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1761643111; x=1761729511; bh=B4ZvsPMTny
	eNliaG7wJ5LqbF+YGgpWnCkl9STs+tJ0w=; b=ESxWPnTgxhkESradY4bHhkw509
	WCPo/jflOVpWbEVWQhuvFCp26QeM+jI0x6SF6vV1mOyM3LibXooMz81rS3OYR2X8
	FYivCs/At6hTIpCbFu0T2NVhH7X2j2PfJRxKeTV4E2c5dNIig1aMtB9uRR9pc9T2
	5PazAksFyiOJ6/G0gmatUZC8/ioOejmETRyUmKZ5lypOizDzKpx/xWh4rotv0/Xw
	hLOtU/UZlUqwDsfMXHIM7f5WH2hrycEFERO82r6tO5sXF6MrWVBsJEa8QCPg4mdt
	cawt4F5rXhixU84gYceSfeO5OqAe6SHVVteJpGN9u5TByR79eKT9Mbn8u/ZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1761643111; x=1761729511; bh=B4ZvsPMTnyeNliaG7wJ5LqbF+YGgpWnCkl9
	STs+tJ0w=; b=QaqrhGbadTTUf2XuZ+zA6TVt7N/ddmdyX7HY0UZh+qiquJ91Cb1
	GahHzsuTh4RFyslA2+BddgeeKfoZu4JgMwKzLiy2WJ4JLE9hlx05KEJ/uq28zcjp
	4w1/xb6ZtpXDr+K+xbsv4ITssaDrJXMhQENFv5vvunmNtO8srT6PeMJeZ16wQPNA
	Zz6Nq9CnM9y/VcspPLVzNM18BVMcySPYMPickO8SaI+wK7OAqAvOfCIyfAaF//LQ
	yAyPi/NDGg4gI1KvgkjxeTWQPIj1b6qEvJWRSFDXXAiopEwzk+4EJcj9B2jxwpjd
	Eaz3czMRwMpf27RJAhtKej+t3TLTmsrJuDg==
X-ME-Sender: <xms:ZooAaT_4mToq_S0GQqql58oU5ZHfp53kiY4ocueOoACoYnv83w1M-g>
    <xme:ZooAaWsN2ie9t_hxnifdADLRp5bjyvm8EYDoNhpd8RhIv5ZTIQUnimtcD9I960jeU
    gxCw4nijplNf-Pv3MxkIBZ4E96HiJTp61sRbt13Ak5SwiBIS7F6mA>
X-ME-Received: <xmr:ZooAaWDmc3a5eH7DeuCoKqV__ml89NBWVFEUBjfOJWQI1G8Va5SLKtrKgvY19_lYF9Ir0PJa9Vt0f5bvlvs3RBnEQW-Ng6Rd3md71Xgu1g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduiedtgeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepvgiivghkihgvlhhnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehgih
    htsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshgrnhgurghlshestghr
    uhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepghhithhsthgvrhesph
    hosghogidrtghomh
X-ME-Proxy: <xmx:ZooAaeVk8wl9j36DTeLiuTouNPZzumSuQ2ddwFRHdjDoz3DmjLHiag>
    <xmx:ZooAaUDppC9cdrUDm5BZjsj_0UX_blSKACea4G9UANaWsEdvD500AQ>
    <xmx:ZooAaR8eXUhnsRg_FgBwcC3S_UwCftWfcepjn3dGRx3DURw1ahbNFQ>
    <xmx:ZooAabHANKe_pTCHQ6GohxC5dIiYePgHLls2W0Xh8AVPTFqZUf-LIA>
    <xmx:Z4oAaZG38nugDghTVCb5nmvA7eSNN4VswgyiCZELrBTmAROyyfYqpoFX>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Oct 2025 05:18:30 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 32da9d33 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 28 Oct 2025 09:18:29 +0000 (UTC)
Date: Tue, 28 Oct 2025 10:18:26 +0100
From: Patrick Steinhardt <ps@pks.im>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Ezekiel Newren <ezekielnewren@gmail.com>
Subject: Re: [PATCH 11/14] rust: add functionality to hash an object
Message-ID: <aQCKYtvzaP6SXmDE@pks.im>
References: <20251027004404.2152927-1-sandals@crustytoothpaste.net>
 <20251027004404.2152927-12-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027004404.2152927-12-sandals@crustytoothpaste.net>

On Mon, Oct 27, 2025 at 12:44:01AM +0000, brian m. carlson wrote:
> In a future commit, we'll want to hash some data when dealing with a
> loose object map.  Let's make this easy by creating a structure to hash
> objects and calling into the C functions as necessary to perform the
> hashing.  For now, we only implement safe hashing, but in the future we
> could add unsafe hashing if we want.  Implement Clone and Drop to
> appropriately manage our memory.  Additionally implement Write to make
> it easy to use with other formats that implement this trait.

What exactly do you mean with "safe" and "unsafe" hashing? Also, can't
we drop this distinction for now until we have a need for it?

> diff --git a/src/hash.rs b/src/hash.rs
> index a5b9493bd8..8798a50aef 100644
> --- a/src/hash.rs
> +++ b/src/hash.rs
> @@ -39,6 +40,81 @@ impl ObjectID {
>      }
>  }
>  
> +pub struct Hasher {
> +    algo: HashAlgorithm,
> +    safe: bool,
> +    ctx: *mut c_void,
> +}

Nit: missing documentation.

> +impl Hasher {
> +    /// Create a new safe hasher.
> +    pub fn new(algo: HashAlgorithm) -> Hasher {
> +        let ctx = unsafe { c::git_hash_alloc() };
> +        unsafe { c::git_hash_init(ctx, algo.hash_algo_ptr()) };

I already noticed this in the patch that introduced this, but wouldn't
it make sense to expose `git_hash_new()` instead of the combination of
`alloc() + init()`?

> +        Hasher {
> +            algo,
> +            safe: true,
> +            ctx,
> +        }
> +    }
> +
> +    /// Return whether this is a safe hasher.
> +    pub fn is_safe(&self) -> bool {
> +        self.safe
> +    }
> +
> +    /// Update the hasher with the specified data.
> +    pub fn update(&mut self, data: &[u8]) {
> +        unsafe { c::git_hash_update(self.ctx, data.as_ptr() as *const c_void, data.len()) };
> +    }
> +
> +    /// Return an object ID, consuming the hasher.
> +    pub fn into_oid(self) -> ObjectID {
> +        let mut oid = ObjectID {
> +            hash: [0u8; 32],
> +            algo: self.algo as u32,
> +        };
> +        unsafe { c::git_hash_final_oid(&mut oid as *mut ObjectID as *mut c_void, self.ctx) };
> +        oid
> +    }
> +
> +    /// Return a hash as a `Vec`, consuming the hasher.
> +    pub fn into_vec(self) -> Vec<u8> {
> +        let mut v = vec![0u8; self.algo.raw_len()];
> +        unsafe { c::git_hash_final(v.as_mut_ptr(), self.ctx) };
> +        v
> +    }
> +}
> +
> +impl Write for Hasher {
> +    fn write(&mut self, data: &[u8]) -> io::Result<usize> {
> +        self.update(data);
> +        Ok(data.len())
> +    }
> +
> +    fn flush(&mut self) -> io::Result<()> {
> +        Ok(())
> +    }
> +}

Yup, sensible to implement this interface.

> +impl Clone for Hasher {
> +    fn clone(&self) -> Hasher {
> +        let ctx = unsafe { c::git_hash_alloc() };
> +        unsafe { c::git_hash_clone(ctx, self.ctx) };
> +        Hasher {
> +            algo: self.algo,
> +            safe: self.safe,
> +            ctx,
> +        }
> +    }
> +}

Makes sense.

> +impl Drop for Hasher {
> +    fn drop(&mut self) {
> +        unsafe { c::git_hash_free(self.ctx) };
> +    }
> +}

Likewise.

Patrick
