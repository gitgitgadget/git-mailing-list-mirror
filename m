Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3036D3A1B0
	for <git@vger.kernel.org>; Wed, 15 May 2024 04:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715745888; cv=none; b=jECRvbvh8gNRDbYf1dT5G/rCazIBUdRcE4+GqnhAFOlasxNC2OpVdGA0Awzsxh68mAL5dktZzMi1bqu2RH9KL/2ISE/opzNXtlCCHXQr4YjrwoWRQ05/+X4SqAPNA35hsGoUL+u345Lt/yD+OYrGLSXo56BQObP0aYUBna+gQt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715745888; c=relaxed/simple;
	bh=mtaRL4Ok/21/KpoTVANoDnLii2c+YPxgUfn53uAvro4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jsl5UQUY9dh/e+6ruMCQ7rVOgDraeFvLL3u+6CIDpMcnGSTfGqnjERg8HEq1P+3rRmit+Oy4I30wjPWL7oOGpuEzaIEYJ/6OBspnFBjHAd7I7vue7e5OHPRS0JMOBiKt+xfVfUOi+r5AXWo3AHtWsY1+c9NgzkwXWXSmJP0M7Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=E90/EGtR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Zdf/RZFD; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="E90/EGtR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Zdf/RZFD"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id 105071380255;
	Wed, 15 May 2024 00:04:45 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 15 May 2024 00:04:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715745885; x=1715832285; bh=XG2596Krol
	FY9tNmv80X95pzuSiI32Hy5ruWghrnXdo=; b=E90/EGtRIK5KWSqqH/3NSvzV7N
	CKFw/Y8bVMYKC5Z07efrb794J3r22lyx213C3Ug9R7T1DoR6wj/ybHD/hdMs8iCt
	t5945r5/aKECR3z7UWGzRgTNSsjEOuaFdMqTpsz7iLShfJ93nYIIwWPZDFXgROb1
	EUWC7Te7Mfc7vPTtTo2qjp8syIn2lRkxkA/cDVOd6h8L6LHVPKZ8cm3V3w6jf6dB
	t1xJZ+yzgIoEdhGy0I07Vxf33RXvOcnHijMFw+YE7XhlHFY3wC29X2YYumX6gK64
	M0H8laEa5mbeW5HG/pmhXlpLLyy5Lwh0QWJ9EpayWjJSGnJ+fnQfEyHUwXzA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715745885; x=1715832285; bh=XG2596KrolFY9tNmv80X95pzuSiI
	32Hy5ruWghrnXdo=; b=Zdf/RZFDPEaRVIjKPzJ7XzIn+SAzPqAz09AXNSIeNLNw
	gfJmJD4HAAi4Vqf9dxAy4aBZXlBT+hrgLso9o6GnkiCI5qpytgOSAuj4+LGs62ze
	mfmBXgNmRLzyO+zVnqHbx27FO/3EETpRLRtcne7beF22MigCG1zri5KXzesUpJ54
	ItC7TPopVDndbrrE/en3I2JM8+kcK1wDHls2vofVU+ftHK96XUXd+mm3sBmD8IDV
	gTwi5QXzSt+qd4cqS2UGah2K3ilZMS5DEFGu92SdvIILmiFgRpX5ng/Bb3Ba4dUB
	lusvl9Pbf+enW1on0YNkNWZfQCvhA9kIYvoZULZ5zQ==
X-ME-Sender: <xms:XDREZg4qWMsP7cKSwNRseXPKAbaY5MbLRfjEhecFTvNTf3_HbIHgcg>
    <xme:XDREZh6YMPvOiE7btzs28c4OP544wGkZmqXwvwyTAn5iGwCsftqACtZXMCnUXayiw
    q3LeNYT5rzcDhbAsw>
X-ME-Received: <xmr:XDREZvcQZNNap9XTlrEJXoQzkP5rP_oh7oYjpGKIDSIM-Ocf4AqVhmtJJXSdlMcBgDBnMEVjccruMDWqVkm7lTl3Qg-_tK5YbchYHuy-I2RS1Ns3>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdegjedgjeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpedtieetveevudekkeehieeuvedtiefggf
    ethfekleegvedtjeeuleelffetueeiueenucffohhmrghinhepphhkshdrihhmnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrd
    himh
X-ME-Proxy: <xmx:XDREZlKPcAOwCVuWKLmx6Ea8zmnU-7aezUf98jmUoGbvOyD0KCvqZg>
    <xmx:XDREZkJ2jA9B2UJMHpTZCWMOIFrYIrlbZWfAys8sF1LRceCXjPfBSQ>
    <xmx:XDREZmxCzJLDiT7A6GUX_ufBJbiWk2JOgv5oqSegfaF3-FLEC3noaQ>
    <xmx:XDREZoLh0lpqYa6268_q8_DOOAjZz5R6UB2dvPcRNHLp7WPPUZP-9A>
    <xmx:XTREZrVJ4xAaXkspzc5nQDshGMMVkFaNP7yMWI3xj4R-McdAYJrB6hsq>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 May 2024 00:04:44 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id bbb011fe (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 15 May 2024 04:04:18 +0000 (UTC)
Date: Wed, 15 May 2024 06:04:38 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (May 2024, #05; Sat, 11)
Message-ID: <ZkQ0Vpa0HIYejyPT@tanuki>
References: <xmqqy18ghqqh.fsf@gitster.g>
 <ZkGp9TqxO8Y5_kM_@tanuki>
 <xmqqbk59hdrk.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bQ6kEp3PAc2dW3/R"
Content-Disposition: inline
In-Reply-To: <xmqqbk59hdrk.fsf@gitster.g>


--bQ6kEp3PAc2dW3/R
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 13, 2024 at 09:34:23AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> >> * ps/pseudo-ref-terminology (2024-05-10) 10 commits
> >>  - refs: refuse to write pseudorefs
> >>  - ref-filter: properly distinuish pseudo and root refs
> >>  - refs: pseudorefs are no refs
> >>  - refs: classify HEAD as a root ref
> >>  - refs: root refs can be symbolic refs
> >>  - refs: refname `is_special_ref()` to `is_pseudo_ref()`
> >>  - refs: rename `is_pseudoref()` to `is_root_ref()`
> >>  - Documentation/glossary: define root refs as refs
> >>  - Documentation/glossary: clarify limitations of pseudorefs
> >>  - Documentation/glossary: redefine pseudorefs as special refs
> >>=20
> >>  Terminology to call various ref-like things are getting
> >>  straightened out.
> >>=20
> >>  Comments?
> >>  source: <cover.1715330206.git.ps@pks.im>
> >
> > There have been a bunch of comments on these topics already, and overall
> > they have been positive. Is there something specific that you want to
> > see here?
>=20
> I did not get the feeling that we have given the series enough time
> to be seen and get commented on; indeed v4 has not got enough time
> to get any comments yet?
>=20
> Also you haven't responded either positively or negatively to
> comments on v3 07/10 by Peff?

Oh right, that mail I completely forgot to answer. Thanks for the hint!

Patrick

--bQ6kEp3PAc2dW3/R
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZENFEACgkQVbJhu7ck
PpStMw//UP+8kaQCZCl2LFUkeqaBmJsi0ntqfmc0jZdM3P3XL4UsUPFIC4CWX2/Y
xLFCcAu1DQwhwLNDvxUL5aC7aflD06P0jcVMlNULdlBqTaxbQ3HRpvNr4UmPv6ax
RawKhxZ++lz+O4tP2zTtkm1bVH2haLJjI00tZLC7B8Uw6T7y0k3HaEPUv69XuSrQ
82EZN9sMhFZ3KmqlOzlPaddiHk8lTz70uMN9D1NunML2d/1ONUqorF7Eqy+Ez/6k
EL36ETzhhKm1yOzaoJxT/dkz2ThnXb05cs839I3ynPTrX6V/10OAN1xFDgAHuneI
iDYnF6+hcvlhwmzGUSqOrFEHY3uisHTuQ8CA7zgMe5RiGdoFDV49tM1NmnThfz2M
Viz2gxg3lrSzlP4vBcsdduwS6wsheCD2WHybxrAxS9ukGFeJLE4MZ5DZFu4HxIPr
7WqQvP2ruE3Eb5aLuU2vDTXpLDRckS5umPCcAmpcOLzoITYFIjo3VbwWj0ZL040o
nsLuZdEu6Ys6UXkoNJDk6Rl6p7KCbIWAiVVpAeT6tUdcHoQcaYkLN2b+juAAvbVp
c69/4nemHjLj7b0hWiSxKPeAhWEGWwx1ZCArgU/mYU6qlvVDz/OFa9bgvvRliXVP
9uMr2aFKyOrPOYw55tNpmd5ehQp67r0YW5lLz2y7hzXJVv2A6Ec=
=iQD7
-----END PGP SIGNATURE-----

--bQ6kEp3PAc2dW3/R--
