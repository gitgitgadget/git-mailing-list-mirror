Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B6B134B2
	for <git@vger.kernel.org>; Thu, 15 Feb 2024 08:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707984905; cv=none; b=DSsuZg46rDx98ZB1eZp8FTmArMxWmeJX45W0Rm+agrQ/HIPZvkodmHmd0KxHHJk92M5ysxXu/cqDxHvjQjnjsQE6G3+Mo7pa3vTU/LILaTmFRoF/OuKaTgAPw0gZK+jwjFT2DxjD8m2i87tvhWiZKfOZOluqadxAqo0U6g0tX8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707984905; c=relaxed/simple;
	bh=eWgD3d/CtnO3kwYTDrYP0eOuyEdym1v9VtmhjXxQi/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MI6cbbLxAM+5BBlZLGeQ1xobSVz/uOZAc8u7TVBAcKUq6L833UHpK0Zyed5ZB5bfzlb68yebe0lCAoI4lPlqB8TTd0268tbIHZIFOTbSIOSOq9UW2Ad9ym8WfW2hLJRuozOZepnITtY3Qd/Um3UYAX2FxenIKMc4TTzvDxbmG1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=oTADfNxE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aPP6DluZ; arc=none smtp.client-ip=66.111.4.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="oTADfNxE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aPP6DluZ"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.nyi.internal (Postfix) with ESMTP id 92E775C00CD;
	Thu, 15 Feb 2024 03:15:02 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Thu, 15 Feb 2024 03:15:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1707984902; x=1708071302; bh=eWgD3d/Ctn
	O3kwYTDrYP0eOuyEdym1v9VtmhjXxQi/8=; b=oTADfNxEqCK90Fp86YLVXunJsg
	FkuINXP1Z38kZUO01r+KW9dB4E89md6O9GJvT4cVI/3qIFlsXlTDdPzhOimDb2sR
	IHuOFI7CxCLJubsx3jW/zCKMsHpRukcMEjBFZkzKNe9004dVjJv3+lchRRO1yd0R
	/IGGNUJCI4xI/MF8DFHvm+dVhJbskltu0Z9i21cIw+KpuI/R8x2wBn/2t2vaHuCz
	e03CWURwiGWZFKmXzgRNMxXvpz4q/ZQguXv7lFlnq13HlELd881Q7JjxfJiMnfOU
	EXr04Pa+RBhs+3sGyy4mhS10NnwFBOvFI66lGxrq0+kkThlIzRcmrYPS0fEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1707984902; x=1708071302; bh=eWgD3d/CtnO3kwYTDrYP0eOuyEdy
	m1v9VtmhjXxQi/8=; b=aPP6DluZ6FEBUlISXiae4e2A05nbSHXUF5wbiuTYEb63
	j8OaFLOqw5jRFbr1LjuLPNmuUqUdwyHkulaPuazMlhltr+wQ+CQC4Wzyh/lcWh6T
	Ox+RKKshWchJFCx3TnJPpiOIjIjkDU/J0iGTZo6AWTL/uYbzCWNN/NnoAtlvfQCv
	zdFivaSCKFgFHNtiwOjPzSB/HsESHi+YOFFFsw6Ett2UTjaoAWOcRxZA3zzsdrcX
	iEyaUouMPf12jHXeQxUnzZpkgxnBLKEkvtPEo2Y09kiP7q3KIJGh0zpBq/O1liY6
	Mw988P3BCcHVqZ+2CQEeXTfqLb5HrUCe27gjvFYHmg==
X-ME-Sender: <xms:BsjNZfq8iNaj3H63BNTTezRYmwbguY23rpTLCLAXZvkF1UbpN_1mDQ>
    <xme:BsjNZZoub3yGsE83YAKSMYbk8FRMtlPTcqerk6NGwjqmPcfLJP_KXrxdTRQgJvLPp
    g5IbKj4ex2TBPIdLg>
X-ME-Received: <xmr:BsjNZcOLjVhE84xx2SD5GRlhlAPHFFqGEuoUBwRlZRx1kdUw6Hire7LdHa5ZJ9Cq3lVQE96p1C_HdmS5mrgw7M_IVIMF8j8-kwn8HyNdW0Um>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudelgdeifecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeigeekle
    duvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:BsjNZS4gfRaLQXfCOgRV7sluHLZHq4_qUK6fr7eq0Pu6gEIKksYrKQ>
    <xmx:BsjNZe7L28iVl5x01YmxHRFZvX0GO0tZCNjnKsMmjkFa24aRQtqsWw>
    <xmx:BsjNZahEHOPKOX-5C9fmkryPpmEvX_GA4nyjfErdMowf13dtVvA4dw>
    <xmx:BsjNZUTDGvGbttG0mHx-t83fKMY2jDBwJFmyi7_ICm2FbpdjrjW_QQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Feb 2024 03:15:01 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 8655899b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 15 Feb 2024 08:11:07 +0000 (UTC)
Date: Thu, 15 Feb 2024 09:14:57 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/7] t: drop more REFFILES prereqs
Message-ID: <Zc3IAV9qeE-VyOTi@tanuki>
References: <cover.1707463221.git.ps@pks.im>
 <xmqqzfw2skf1.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="07ikkVIEGGUno5iY"
Content-Disposition: inline
In-Reply-To: <xmqqzfw2skf1.fsf@gitster.g>


--07ikkVIEGGUno5iY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 14, 2024 at 03:20:02PM -0800, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > this patch series is another step towards less tests with the REFFILES
> > prerequisite. Some of the tests are simply moved into t0600 because they
> > are inherently exercising low-level behaviour of the "files" backend.
> > Other tests are adapted so that they work across both the "files" and
> > the "reftable" backends.
>=20
> I've read this through, and except for one of them (I left a comment
> on it), they all made perfect sense.

Thanks, also for being extra thorough with the first patch. I'll send a
v2.

Patrick

--07ikkVIEGGUno5iY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXNyAAACgkQVbJhu7ck
PpTIFw/9ESYp1MGDqhkhFi757JXUYg5EOIeaDlchARkpjWGaXBX5meO27fcLBPdO
dRs1l8AU3uNnfPsUimjMnh5Hb5PTNSvI585IOlXNTXLFALi7kP/T1lFkZzzzBp/V
4IIOknHNgDYb3KiOUOcJizgEYRAvEwpu/cH9L0u1ILfeYQ4vqYfDhgRqgtTNBElH
qEw9yTO1eZvj4Du0wbuvmZW9BkEd5//ES3+19DgKZe43PtVmGr8jQwm47TZe+KMU
EIv9uskRPWdqnEsnOrMqEi7MMiGC1aohDk/3zRoJV0oQQEjka8VaUC+NIygI5IWt
P00gipSZwoDF+NLvnCdJN7QX3QeEMQjIdHHSPkpmhQY1xKsHO59e0EEWi7iXijKU
TLyKODysfw3ryR9IwskYUq6uExLbbgRDMP755466RILCg0AlukQc2D73d5ZxXoaS
oUqWaFUcpr0EBb7RbR+5+Ep2uq6mWWR4l55pVA5u7ofgHevytk2T0Wf/BYNkDc0H
NPgVn0jearKDpO0Os1CUp5+LgxGrykeDSMvrv0FHO84zCzwr1Ugjc/SrsfFfgQKv
BtjPxa+Dx+1qUXL2GQ9923AWbQ9XZBN+atziThQS22uqcHY8vd/n8Z8r/r4/w8l/
XMnxfSCC5VXYzZiMk6BCNevKENUHiVH9Aj1qpU+hDXeTl9NSLkU=
=VxD0
-----END PGP SIGNATURE-----

--07ikkVIEGGUno5iY--
