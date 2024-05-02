Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2102823741
	for <git@vger.kernel.org>; Thu,  2 May 2024 07:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714636065; cv=none; b=C6mJN/YASv+oC2XMwnQfeavXpJzTDsNeuYTXi35DCL8nSSSBqdyP3jYMD7zz9Ix19xYR228nlW3dngtgQhQHVw8P8Y0DZr044ccnvHwsqnqh12wdP6uw1gCS0tYWnG0VpJ2PZdDCZwVc9UUKvyMNdW7VISZtAYowI1JUC4G5YvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714636065; c=relaxed/simple;
	bh=iHgD5R67vcoK9LMdyRF+YLjayOAMWxH2BSC39L4Yo8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qfGAxBPUywQ2KBwcQUPIcuRkeZAu8V8OGNfzcGa+A+To0WUlPIw2RGMszlA8S13wLCjtbH73IPvhJTqAujp7nD1Ji1SstOtWNkYVfk5oHiPUqkPtYrNwhOD8CEvUfIkpP+V7iK6juKTgrheZOLUcoef3h6d25A/ijAXnTA8aj3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Jsh+ZX84; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SK9TpSm9; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Jsh+ZX84";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SK9TpSm9"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 25A00114011F;
	Thu,  2 May 2024 03:47:43 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 02 May 2024 03:47:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1714636063; x=1714722463; bh=iHgD5R67vc
	oK9LMdyRF+YLjayOAMWxH2BSC39L4Yo8E=; b=Jsh+ZX84Ts+wihSBvvIGoV5cRA
	8K/0OuuwY76rrSOrL97DUMj026O5RLbgSwn6RDnSQc+a7zlcrKGDeJH9Yjhb8cNs
	5MERcahTddntAqPDjmV7s56RehW2KBjZtunsHz9cEX19hPXG+b224O6KwOnycMze
	YSmALqEeZPPHC5A6257P4EeB2QPO76Ij5f5kCdbSJ0k5/rHSQ4MUfwJhS918SCeF
	kWCvioDdNWrgcx5VFmoGK636EPIzyAr6b+qfXO3F2Sxq8Jl7PhHG/gxbEDzn558S
	9JijQ+yDAVzRAlZZ5JBwgk2RfWwHNcGm8DqYIYh+Nno/+Sp+ZKCHzdg70HVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714636063; x=1714722463; bh=iHgD5R67vcoK9LMdyRF+YLjayOAM
	WxH2BSC39L4Yo8E=; b=SK9TpSm9DCdehXooCd9I5A7gs97oIsS734lPjEJWbL5y
	MrchlX451EQYAfnd/ApJ1TsmMMnuZbfq2NDgCjj8rKwSYULSUt9qEhlk9RDyd1C+
	GrYxl0WfWGg2ZU7jOJZT7CT23SaoManu0E6S921kET0+8Epd0nWW1axa3WJGjurp
	vcmh/bZoGQ7wYniHpYI1+TQgDTinJrmN6UBoi5YB73hT29AbbxQ/FlxjH+9TmNpf
	zv+MY6d3urFOXVu7uHjJ0w8jVq7ho1fpVyWiDrtZUbzeATk1dkkiC3tOrvnLCNg7
	EOqOYhR4tntbJE/CZ0yVevEoP1MEMym268gKIu5Hhg==
X-ME-Sender: <xms:HkUzZsMJkSiRHtlyeE4PA7gthyocURfyzin0789memtMBDSCG-bX0g>
    <xme:HkUzZi92QPaRYypmDaK-2DBpiwd5tW3u3Oocp37n3VgFs3of9RtZp8D9oDmXoCnFM
    OPSIl2V3F-BjsVSVQ>
X-ME-Received: <xmr:HkUzZjTkVHBXQIh72-4LJ_e8yhFls5SZH3Y6OmUz9udjF1sSQPOYBMe_aDVXwwEbFHtTDbOZp0AF9sgUVy8c0WuGDWVzrAgtkgVPLQAsvsmLlOw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddujedguddvvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:HkUzZktO_9Xbxe8M_SxqcZ9wIR1KALNIBY3G2fYXRyZnU9fUza8VKw>
    <xmx:H0UzZkd8c_GjHu6QT0Jv-TSlBqtaUlHg3OR-cAeyXZMCB5XwrMKmZQ>
    <xmx:H0UzZo1QLjRxFKnWC4O98ZNZNtfd3RZupU-Wz8tFgPvR6Y93Li1fPA>
    <xmx:H0UzZo-LsM6payvcYfHC3321Uz3gGbBHDo7SpwOwivB3A3vdtH8S2A>
    <xmx:H0UzZj5dDJ3cIvmbpubW-UrkOQQDIDZv5QwK7BhDRKILXm39XjdafqfA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 May 2024 03:47:42 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 35dca3dc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 2 May 2024 07:47:16 +0000 (UTC)
Date: Thu, 2 May 2024 09:47:39 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: christian.couder@gmail.com, git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v5 7/7] refs: remove `create_symref` and associated dead
 code
Message-ID: <ZjNFG5Ztnoj9DMzB@tanuki>
References: <20240426152449.228860-1-knayak@gitlab.com>
 <20240501202229.2695774-1-knayak@gitlab.com>
 <20240501202229.2695774-8-knayak@gitlab.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3dd9Otog5ZFwRoS1"
Content-Disposition: inline
In-Reply-To: <20240501202229.2695774-8-knayak@gitlab.com>


--3dd9Otog5ZFwRoS1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 01, 2024 at 10:22:29PM +0200, Karthik Nayak wrote:
> From: Karthik Nayak <karthik.188@gmail.com>
>=20
> In the previous commits, we converted `refs_create_symref()` to utilize
> transactions to perform symref updates. Earlier `refs_create_symref()`
> used `create_symref()` to do the same.
>=20
> This means, we can now remove `create_symref()` and any code associated
> with it which is no longer used. We remove `create_symref()` code from
> all the reference backends and also remove it entirely from the
> `ref_storage_be` struct.

Very nice.

Patrick

--3dd9Otog5ZFwRoS1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYzRRoACgkQVbJhu7ck
PpQuBBAArL+UfT88rkKNzr1sJ3p+WYVLVHmFia7DWzgyKqWougq0xHYAISPS+3XB
vd9hBEbuqK0u2GiCuqkngt1RLSC4DA2KMMWgiEaWkrJSIpqEZYqjfhQzrH8Th4Rd
eZKGCaLSF6VRuejinHu4FuZdFPHqcH42TXZ6/9ilsCBVaqugFFD9q+ztBExN6Rp0
2/e7ynlsMOH1eAfEZ5cnNycqJ17ZNch0xB1huL25h210U1MNDX+dOK40OhhA6aIi
hDCx/wTKBuIVFdBx5F1HbfIBN8YXdmWMjSlZMGK1RfgsFj9WrvOZ4CJRhjMAJo5j
nl6fxUyTPZqlTyFU4hLTvbr3HMO0vb1k8puzMB5i9C52zBExBxez1PFUtwkOs87H
PTGgw/0W7z2YM1gulrZwcRWWhFdnrcIxVWP+UG4pT+ST3HeJkdbSH4r210JIFtbz
qX+9xwqtrqOyUYQ0HLIR5U/YZmt9PAvFP2UVJ3C3aLcDHcBxFtBY0/Kuek+QKmGW
9Yr7aD6MRuS5zuV96Uon0AKPDjVUdayxmOpQkujJ+mNln1RHoei+onApo7Snzjns
E6Zl5Kd+QstQDWjaM9rGlPpsGPEyGLA47ADaPvJK09gMEuBd237OQ32YsCXTl7jT
yO0SEB6PWZoKIwOgOCLKoDFgoU1XDjq3gh6NoIRynwige09cuNs=
=qcor
-----END PGP SIGNATURE-----

--3dd9Otog5ZFwRoS1--
