Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2F22580D7
	for <git@vger.kernel.org>; Tue, 25 Feb 2025 06:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740466765; cv=none; b=Ns5Zyi7ohbhkN19ZtWDilCjCfqh551jV9+64yO74MECKC77PEfOT4J65iAYQrUJX3YwwUhRRwZlwLm6QhPPiTjLxzkeJ2cZP6v0AlY48i97VUspkRFizR7dkPAV/hfzYdbCunCkURdhabltfonFks8+TWUVTOD8wtF6Sbs5NLxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740466765; c=relaxed/simple;
	bh=k+vkHx8ve+kecABgGQSsAp8cwCGcUYY0Xl5QYHw0f64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LxPfj6HoqoUDbuaVDcETCEC8azls5oL0zH+IRinkG2Q8R5oD1kreYun1UUQqkTl4k44Og+4ZwVGw92dtufH2G0vekEtoH/Ru6u2+uVxbfMMWWIj+AdgkJKu1NEjHwavlDZnHy5BRUUPM4KeFSsuXI5wglDL2LoywiqlUPFhR66g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=amTPSfnI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=3yx3tFzo; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="amTPSfnI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="3yx3tFzo"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id 8D4181140158;
	Tue, 25 Feb 2025 01:59:22 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Tue, 25 Feb 2025 01:59:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1740466762; x=1740553162; bh=yba99+Aqq4
	DsKJ+PBuCBMt/3ZEzCgKygbSt3DJNVu5o=; b=amTPSfnIneBD90nkbB90T81HJF
	2NC5znhGdZPg8ecHdrWks98lbG8RnXEwfv9RaQy0A14KqyeYhLONhG2K4mi8ZwRJ
	KNeADPjHs48zeBmZWbobas9xwE6i2FpqPxo2xaIjXzCfqP50MHf5ST7cmXWPrjel
	mwSNfscl275ZTzcSMX9phl8pUc89DzzGloMRysZlt7mYzeJzxhVgs3erLgilcn9w
	KZfdsEvELStr+dnCKZTV+/lA0+ymdbAaf9UCFRMldY87fqr5bMdkqlECXc6ec0RZ
	C2CidXMzP3HWbMPIU3nMBB6T/qM+l+x+eTocXQoC2WIOaZoR1D6SNqj0Rtow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1740466762; x=1740553162; bh=yba99+Aqq4DsKJ+PBuCBMt/3ZEzCgKygbSt
	3DJNVu5o=; b=3yx3tFzoOrBgmSr9+ZAMA0aWBDMBUvhmgo6upwrMll3HOiy/G+o
	fv6uUhx1goH4+VGjbIzFIBlMalIFds93L8vKI1VY6nLxo3VsjCOzp0LK4s9VYyXO
	8VsWCE+lVNz00Vz9NNbGnmMtGDOr/+c6TpCMwHSgj5WjW3LUX3xP80iyCzesC5hI
	R57uDkYpYHl0N5JyXwKklhAss90ZujIdWRyJDxeFchPVnh51Rp68coGgGHYB702R
	nB+Icrp/Y7Md2dnMvrS2/CtAFqgSWVp+FUqP4fPLBco4c0+S3kr9z0WNwj/x2ndK
	am9F9CGFJxcVEjwnhurO7AK2p+0xHlcB61w==
X-ME-Sender: <xms:Smq9Z1wNS9yIKQ7anFEv6cNM1iQxiwtqf6dtImBOc2RbYc46XplaOA>
    <xme:Smq9Z1R0u5qaWz4ZnXAlYyAy13TGA8_ft5ZjmHOeSdMdi75ckeZoJG5hfX2dcIm19
    1d37u_ElUHPf06pjA>
X-ME-Received: <xmr:Smq9Z_VXJFlxFCeC3VVEjFZd32PZlt1g0FdYgpdB0KeOsImSa21tsR5ysStAd8iR7lUhxlyWvbeOjfU2Qae9VBcAqjaoFIZqNKEqIEZNfhuB0w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekuddtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvf
    evuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepveekkeffhf
    eitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsoh
    igrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomh
X-ME-Proxy: <xmx:Smq9Z3j9PmxzM5qrxUBbjpGIyfxqfb8ocH4EUy6phgiT9x6LicNZBw>
    <xmx:Smq9Z3CAb6XbL_S5dyfsz_A3utyC0xVXOwB9SX2OCxdBTndjTddV8Q>
    <xmx:Smq9ZwLsBKbe2WCRNczu_2VSxWakrlmY9lcevL5yraMLNVMedgWbRw>
    <xmx:Smq9Z2Dal9zDKgXb3JHpka1muvUVl-YMQiCVaTWAfEPKlPw5gfus2Q>
    <xmx:Smq9Z-MPKrWYYMWbQosRhuu0cZFn893ajm3WruGMbAxoCHOmHyR7l4D2>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Feb 2025 01:59:21 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id aadd62c9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 25 Feb 2025 06:59:19 +0000 (UTC)
Date: Tue, 25 Feb 2025 07:59:14 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: [PATCH 6/9] pack-bitmap: expose function to iterate over
 bitmapped objects
Message-ID: <Z71qQvlqtoOwDabu@pks.im>
References: <20250221-pks-cat-file-object-type-filter-v1-0-0852530888e2@pks.im>
 <20250221-pks-cat-file-object-type-filter-v1-6-0852530888e2@pks.im>
 <xmqqseo35ic8.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqseo35ic8.fsf@gitster.g>

On Mon, Feb 24, 2025 at 10:05:27AM -0800, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > Expose a function that allows the caller to iterate over all bitmapped
> > objects of a specific type. This mechanism allows us to use the object
> > type-specific bitmaps to enumerate all objects of that type without
> > having to scan through a complete packfile.
> >
> > This functionality will be used in a subsequent commit.
> >
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> >  builtin/pack-objects.c |  3 ++-
> >  builtin/rev-list.c     |  3 ++-
> >  pack-bitmap.c          | 65 +++++++++++++++++++++++++++++++-------------------
> >  pack-bitmap.h          | 12 +++++++++-
> >  reachable.c            |  3 ++-
> >  5 files changed, 57 insertions(+), 29 deletions(-)
> 
> After 2189649b (pack-bitmap.c: keep track of each layer's type
> bitmaps, 2024-11-19) added <type>_all bitmaps to the bitmap_index
> struct, this step would need some adjustment, I am afraid.

Hm, does it? I understand that this commit only makes the bitmaps
accessible individually per bitmapped packfile, but the bitmap indices
part of `struct bitmap_index` would continue to be the union of all of
those bitmaps. Oh, but that changes in the subsequent commits indeed,
where we start to use an `ewah_or_iterator`.

I see that Taylor's series has been sitting in an unreviewed state for a
couple months already. I can review it with the hope of moving it
forward and can then pull it in as a dependency of this series. But I'll
wait for him to chime in first to see whether anything changed about its
current state.

Patrick
