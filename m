Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE4C204699
	for <git@vger.kernel.org>; Thu,  6 Mar 2025 10:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741257107; cv=none; b=CkECdMABTX5broCG6YX0WFBlBDKHmvFL4VdYxIcejH5sZRRSDbLj9mREHWLZZl6U4RXBCOEe7KJNc+nKSZ+AYke37ePWFriP5yfqa0vzS13AB2xqxLv5NdWVMmDkwCQz15OiebVY2lktNgQX9gPpm1fu8JP36QTeruXFHWU3iUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741257107; c=relaxed/simple;
	bh=XoGcgt+lPAJJwoyghEEWmD0pMwxiCulrgVJFYfqIcVk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U2mCZMFnJf0lyuaeIYGVJQgJTXedJVt/ibrX+MtAAVKyfCIjvh2Ekmksce5gqt3lD+GJfrdarwBa8IjJdq5OkUkzYIRbDMzEDRd/io/45pUG66OFThdPOGjWfxrjMV4Eob/ZSTVxToVIO/Ps1pbYMMJzXgfSO9KVAVbt+q1yT7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Xtjekp18; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QL7KjLaK; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Xtjekp18";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QL7KjLaK"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 5938911400C1;
	Thu,  6 Mar 2025 05:31:44 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Thu, 06 Mar 2025 05:31:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1741257104; x=1741343504; bh=4n8sphnLKv
	5QqcuLR4UNSSKx9AzwdOApnMA9EfQ/MYQ=; b=Xtjekp18qBgmkgSFh9k2V1+ddU
	FDjX6ftRnNtxn3F9k3RSb7KVWPInSIjGz/HfjDUfBNFu7Eq6+wqxjYNa7LDAbSt6
	h81wliO2ZO0llTnrlzkEitiwis68gIxIgdELU+jwookYXvtOjkPFxPJvaPjY8eGG
	j85BxF0LApBWygzEbeL9dRGoIl9QcNfmQYfUNk7Fnb3oXAuYDAy+ixVdayx4N4nr
	mjB6/Zi31hjKTTBiAcpcQVV0tNyEpGevu8q+34ID/zdmPLl2BalLjSafH9PMdHNc
	n6wX7uGmjrFpK516+aY8JdkSR7SYBewQ2F9wTx5Vx7Xi/RD6gMk3UOHGU15w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741257104; x=1741343504; bh=4n8sphnLKv5QqcuLR4UNSSKx9AzwdOApnMA
	9EfQ/MYQ=; b=QL7KjLaKUkpgb9n9Ld/TLi+qi3A6MsE/DodNoIoI1Cx3T3ipLqz
	LR8iLoYr25Gpx+ux9+OqP1LSJpJISOJMx3WvJ99UHXfaW/Yex5y4gvtjNvx3R9Ok
	v+K+xqyJ1DQfghCS1RW+Q6ZnbFsVBZDQH/sXxsEkdNBmtgXOkyjCGgcB+gAfoUoA
	f8jLV9Jg5/18RrDULN2VtwGy2CQLL90WlDyZ57DbJgmCj1Vt4zkQV8PCutkfpxFI
	bLFeC0Aowx4fV3tQFp42RJdFK9AWeDWitKtXw6HHW/x/HadpBHHp5gDfkMyOwB2Y
	L0gX+4LljIukonbfnf/CRfslTJBaH1nSejg==
X-ME-Sender: <xms:kHnJZ8dxJXAmaZ2XeVLTFHjgSJx_pbHP865bb4ngLzJhU9oJLnP7rA>
    <xme:kHnJZ-NXlCGXlKBgJVGqAh3VL2w5dlwrpghx6Hh-jHyPF5BUEaXV9JHJqY82AEcXp
    g69wl-QzBRclN39SQ>
X-ME-Received: <xmr:kHnJZ9i1w2ndO6EywKbLFM83IdgF9n-tRPz6Krht38hLdd-gyaX8fUASuukCmAAT9lEPe4DArh-nn1ydEi8VH0OAlIP5THfBlXMh_Xjvw0XMew>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdejhedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehpvghffhesphgv
    fhhfrdhnvghtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:kHnJZx_ptxVh1FIdkrji27ficVQYoexuMBgyDON1J1_JWnU4bMNnNg>
    <xmx:kHnJZ4vgl4FC9YxmJZeXKFY9Z0NDZHzURuMtavh_RlIJ4CWOf3-IPw>
    <xmx:kHnJZ4EZcqwbZUY-g53-rbnwbtu1DvCeUGa2Ob77VWUXbhguVqga1w>
    <xmx:kHnJZ3NTCMPblqYrc1suA_FgdZjiND9eeWyBZfwQ4URcBPl9WmePjQ>
    <xmx:kHnJZyVA_FXavn6U7nwzzVmLjTUdBTdI_cD-nbhJOtuUVh1nk3cPXl8b>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Mar 2025 05:31:42 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a175dcf1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 6 Mar 2025 10:31:40 +0000 (UTC)
Date: Thu, 6 Mar 2025 11:31:35 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v3 1/1] builtin/pack-objects.c: freshen objects from
 existing cruft packs
Message-ID: <Z8l5hxNjEOALl_g-@pks.im>
References: <cover.1740680964.git.me@ttaylorr.com>
 <cover.1741133712.git.me@ttaylorr.com>
 <6e93471f9a8e6a3dde36342088748ba17e4f7f95.1741133712.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e93471f9a8e6a3dde36342088748ba17e4f7f95.1741133712.git.me@ttaylorr.com>

On Tue, Mar 04, 2025 at 07:15:18PM -0500, Taylor Blau wrote:
> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index 58a9b161262..79e1e6fb52b 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -1502,8 +1503,60 @@ static int have_duplicate_entry(const struct object_id *oid,
>  	return 1;
>  }
>  
> +static int want_cruft_object_mtime(struct repository *r,
> +				   const struct object_id *oid,
> +				   unsigned flags, uint32_t mtime)
> +{
> +	struct packed_git **cache;
> +
> +	for (cache = kept_pack_cache(r, flags); *cache; cache++) {
> +		struct packed_git *p = *cache;
> +		off_t ofs;
> +		uint32_t candidate_mtime;
> +
> +		ofs = find_pack_entry_one(oid, p);
> +		if (!ofs)
> +			continue;
> +
> +		/*
> +		 * We have a copy of the object 'oid' in a non-cruft
> +		 * pack. We can avoid packing an additional copy
> +		 * regardless of what the existing copy's mtime is since
> +		 * it is outside of a cruft pack.
> +		 */
> +		if (!p->is_cruft)
> +			return 0;
> +
> +		/*
> +		 * If we have a copy of the object 'oid' in a cruft
> +		 * pack, then either read the cruft pack's mtime for
> +		 * that object, or, if that can't be loaded, assume the
> +		 * pack's mtime itself.
> +		 */
> +		if (!load_pack_mtimes(p)) {
> +			uint32_t pos;
> +			if (offset_to_pack_pos(p, ofs, &pos) < 0)
> +				continue;
> +			candidate_mtime = nth_packed_mtime(p, pos);
> +		} else {
> +			candidate_mtime = p->mtime;
> +		}
> +
> +		/*
> +		 * We have a surviving copy of the object in a cruft
> +		 * pack whose mtime is greater than or equal to the one
> +		 * we are considering. We can thus avoid packing an
> +		 * additional copy of that object.
> +		 */
> +		if (mtime <= candidate_mtime)
> +			return 0;
> +	}
> +
> +	return -1;
> +}
> +

Minor nit: it is a bit unusual that a negative value, which typically
indicates an error, is used as a boolean value here to indicate that we
don't want to have the object.

> diff --git a/t/t7704-repack-cruft.sh b/t/t7704-repack-cruft.sh
> index 959e6e26488..f427150de5b 100755
> --- a/t/t7704-repack-cruft.sh
> +++ b/t/t7704-repack-cruft.sh
> @@ -304,6 +304,69 @@ test_expect_success '--max-cruft-size with freshened objects (packed)' '
>  	)
>  '
>  
> +test_expect_success '--max-cruft-size with freshened objects (previously cruft)' '
> +	git init max-cruft-size-threshold &&

Let's also delete the repository via `test_when_finished`.

Patrick
