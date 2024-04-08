Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86E4446D4
	for <git@vger.kernel.org>; Mon,  8 Apr 2024 09:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712567232; cv=none; b=HyQnSJB/5n2GzZ+NqtEBoSeq0NYXnlutBaQYEz9fbE4BzrsfQ8q1FL+R7Z1SZmREPOeRHFO3HGYP6e0a8qKS3+fThAay22RPJmKPMX+evrm1KvrswJUexh+D78EzHoqrlT9DteefQC729LEOJxrczTJK7XdzyOGyw5Yzb8A4i1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712567232; c=relaxed/simple;
	bh=RclUgTTZu1i6GsOuoqbnVLI9tuarve5V9+xqwA32a58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yd6VE/VeLFW7eDESG5CRnlLlhfTPnfTDS4s9ab+A+7YNfcIMjxdt7rRy01YphQcEB0u3xTxSP+MBhSVj82W9E8yxEJXdj30BhuybY5szyv64qoD18rJ2klHyxP6qmP8Fq3PNSs010Wv3NUGrXuZMPhBHyR72DibHzrjL6CYKvIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Apn195i2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=g7GuPprp; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Apn195i2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="g7GuPprp"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id C4F4211400D4;
	Mon,  8 Apr 2024 05:07:08 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 08 Apr 2024 05:07:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712567228; x=1712653628; bh=RclUgTTZu1
	i6GsOuoqbnVLI9tuarve5V9+xqwA32a58=; b=Apn195i2YmmhotnwVDUpy4Rr+Y
	FVrDGHMmqGrtD4AKihAut4bLXz7hVxuDFlOAY40UXU3ICc+iuKJFgWKTKLech6GC
	djslKyu4q8KSjFr9LRhStcbZ5k0u5l7JPbAd52PaxFj6/YLYD8pBgQagFG8VJ4OQ
	AWXwdCVCeECFM9D9WnqQk6ulfotA54ZQkGqa9YmPlWwz0z4cKVF7NIgEFQkeRjUo
	I13A4ro8xIMJkIflGy4++DnH8Gst18VqZVwa0RTFSDVl5ZQT8KntLbyilPLHz2jy
	W6YvtC3BM4t9dUIhC+HxXNHkhA0dOiKaDsEAjuxu+6JdyaVQruchMNXrAXuw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712567228; x=1712653628; bh=RclUgTTZu1i6GsOuoqbnVLI9tuar
	ve5V9+xqwA32a58=; b=g7GuPprpEKYOg63OqirySKXXT1eMszuKQ3rp/+kj9xkP
	gMujgj7qU0NGbh/SBGRFResJnkdIrfIkeadzDzVxonYzZQON8vOtDRWnInFseSYU
	S4DOrw7nC63m5Ot+NVgvBOmUcYtIjCj7LIqGoFhFrjoAiMQijPmDtYPdz52M2lZB
	QibqMCt9QC93GSuXxjjG3er5qyfzaFiQ2io06swLCYHToYkGyo3zUlFPEKxiEhqR
	CcM87ENVK0+ExAYYUabMnqP2wVV8ia/lKS2G49iiligh7v8ZPT6SsELcJ4q/szxd
	PP+fP4/m/xepayaBfyuS28b5w03z0HwHjnbjPqdHhw==
X-ME-Sender: <xms:vLMTZkoxghRehpUYt0ogLAPnBiWFxG_kVBt6670mnssStEdRLkXXrA>
    <xme:vLMTZqqU5Zcko2yxdb_HvcSLJb3bTxZVkdfCiZw7tIXbRU9sJ7QOoMKoxN3VTrJ9U
    5RFhNpvXsjUpWiJIg>
X-ME-Received: <xmr:vLMTZpNgaWDhu8jpagyI2fbvsknVth-WMb6ctT-cDVZfn6xHLlteWnIHLeHzQsQloIp8zV-4zwBdBIf_jDL0eXDrHongfDrs5vHK9GFxMx_Gcq850A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudegiedguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtjeenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepteeuvefhhfdufedvgeeiueeileegtdfhgeeftdeuveejjedtgfejhedujeeutddu
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:vLMTZr6cCYASCKIM8JpaaF46CXj_lLhWmv6YICd0mWaIGq9d8fYjxQ>
    <xmx:vLMTZj41VqZ5CirZWPjYJOJUTKop8SzoJd5AMXr3nhWCUjzH3YjvNQ>
    <xmx:vLMTZrj7mKB9CrknItCr8nynMf_IQ-auwdbFWrNaindgwUuwk4rfjw>
    <xmx:vLMTZt4OiON1_Ph0eppBokBQOjhMTkWObmZW7ugXPMe2enRyVovQlg>
    <xmx:vLMTZmad5WsCmRZz4k24UgO8NyAuxEh2RfxK0Y03qoIcMUECTD_1JUeY>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Apr 2024 05:07:06 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 9769cdf3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 8 Apr 2024 09:06:59 +0000 (UTC)
Date: Mon, 8 Apr 2024 11:07:02 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Thalia Archibald <thalia@archibald.dev>
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 0/8] fast-import: tighten parsing of paths
Message-ID: <ZhOztsTfuEjCqpD1@tanuki>
References: <20240322000304.76810-1-thalia@archibald.dev>
 <cover.1711960552.git.thalia@archibald.dev>
 <A820E635-14FA-403C-B932-D7F9FE57C092@archibald.dev>
 <CAPig+cSu5dLoDew-efAB-H95B53fteDGNO=_1jc9i_MUqdpw-g@mail.gmail.com>
 <ZhONyBIFlWbNHNwN@tanuki>
 <1B15EC5E-E0E7-474E-A0D8-3089918394A5@archibald.dev>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bKf0iUwPWa3u8Hcn"
Content-Disposition: inline
In-Reply-To: <1B15EC5E-E0E7-474E-A0D8-3089918394A5@archibald.dev>


--bKf0iUwPWa3u8Hcn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 08, 2024 at 07:15:35AM +0000, Thalia Archibald wrote:
> On Apr 7, 2024, at 23:25, Patrick Steinhardt <ps@pks.im> wrote:
> > On Sun, Apr 07, 2024 at 07:46:52PM -0400, Eric Sunshine wrote:
[snip]
> >>> I have several more patch sets in the works, that I=E2=80=99ve held b=
ack on sending
> >>> until this one is finished, in case I=E2=80=99ve been doing something=
 wrong. I want to
> >>> move forward. Thank you for your time.
> >>=20
> >> If the additional patch sets are unrelated to this patch set, then I
> >> don't see a reason to hold them back. Feel free to send them. Even if
> >> they are related to this patch set, you may still want to send them.
> >> After all, doing so may get the ball rolling again on this patch set.
> >=20
> > Agreed. Especially given that this is your first contribution, the
> > quality of your patch series is quite high. So I don't see much of a
> > reason to hold back the other patch series in case they are unrelated.
>=20
> My effort comes from reimplementing fast-import parsing as a Rust library,
> following the implementation, not just the documentation, so I=E2=80=99ve=
 noticed many
> mismatches between the concrete and abstract grammars. Perhaps it would s=
ave
> reviewer time to submit those around the same time, so knowledge of fast-=
import
> needs to be evicted and loaded from cache less.

In this case I think it depends on whether or not these patch series
would conflict with each other. If they do it's preferable to land them
sequentially. If they don't conflict then it should be fine to send
separate patch series and parallelize the review to a certain degree.

Patrick

--bKf0iUwPWa3u8Hcn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYTs7YACgkQVbJhu7ck
PpTDAA/8DrP1ZF9ZYguHLPjbRop21fOtR7vuc3Gg/YNphqwweMeAO+NujGRvuU2a
FS4xeimRwiQF5F/eoJGDjx1L12GGbG6kRqkgDNCmLN0WaFVsGgHNrA2v1l6CknSK
BCKz9FPWIqTWzpEooxtzhOT3rPx1QrNrnaa9P2y5toPGNR5nGXMUcEA5mw6Vw0FY
z/plkpk9ALI0nv7deTjm3THGnvChKCrrBSbxcf/1yS3aZXjTCc5eTx03gLIbkW9u
Tp+yCfuQVlfLs2XfC8oUqhM/7G05bLkwMO6VRe0/XboI2TxEsncJxYyzmOzGFKkD
G0iRE4e8WHcosKuvDnwBhk8NXFg+JFTLkqIZAMssXHD+B5ICHf+067Z5mgG9twWH
1XImYw0+NVQQBeywOqzSfZl3cVNUt4pfAlXefPBj8d9yb45JguQrjjpTNQ9/DjbR
O5MdBqFgT9qyPsKEK9d2n9dJzq7ZPrKCTsM6D3I7NFRAyU7qWhqvYNz7jkZ9WjSd
YPHeQmjDkd56SvBBUtX4K3/8nXxM2FvVb826KNYaNrbhZbr4eMlpEVNOgMClgsS3
MB4Q3hzQs0hpj/I89UK+tA5RW1AxONdECXB1Rp9o2ATqZgiEbEtpy8ovrckzLbE/
aNw0FzwYAAwI3PT680QyQg7F95BufZERi2XFP0Bf+rtmcgCGVyc=
=x277
-----END PGP SIGNATURE-----

--bKf0iUwPWa3u8Hcn--
