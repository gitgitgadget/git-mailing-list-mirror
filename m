Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724B03FB8D
	for <git@vger.kernel.org>; Mon,  8 Apr 2024 08:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712566614; cv=none; b=fNmBRdk6/7Z1vfqGg0sEFu0gi8+VBuANYijntrpznsEYflr8PjHGwi915JK1fZTeWyZV6RpT0rlfWqOdVj/VWZybtffnotajn3lSNigcElRBMuceJxmY0LxnwjJC1aV1mL0zMwtmPPfKKTElFhR/4HXRVcHyJb1fclRjivbPTRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712566614; c=relaxed/simple;
	bh=fcUQjrA62H7/q7ih5/50etUz2m1IE3MgjD/KqUUDZ18=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=efxL2TrBhBK5Tz9Zsz2O7VZtRBuuiT8zocuYPKmmozftbm4AGQfsIT/yosW4BIdbDLzlDU+ZJYpKGhp1ULLuCrbIqs1TYOX2Oe0S9+xbNqKk2ofVv+DCSuwsFjNNxCKjOTrVHOYX+uSfMqmi4aPpCobrECJf/v+HXQZPyd+8NvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=pljKHVMm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TNQlbUXr; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="pljKHVMm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TNQlbUXr"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 3FDFA11400CE;
	Mon,  8 Apr 2024 04:56:50 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Mon, 08 Apr 2024 04:56:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712566610; x=1712653010; bh=fcUQjrA62H
	7/q7ih5/50etUz2m1IE3MgjD/KqUUDZ18=; b=pljKHVMmHuIVzl/BQsOReQc5sd
	5qyY0H+o6kMdRd6q40ZseZswJWp8ExgDdmICFodo5fPC5nYDCjUhTtIdjrUMs1/8
	YrDAY3buwK3IxMm+/7/WeN+DcBOYaeClszVyy4NSNuhMGiN0ZZjDVB7KFByBqmUm
	F2Djzvp7qWvH8TcxscKYGwf2TU6P4f38NSRDfsMi4+LurtwcEhacOpENuU2ior6E
	BLwctkF3r1NYT/r88mx+1vtLAfHuZuvHyyp7YRzRCqOnBz8NmyYMXPQ4znCY3jz9
	GyH0fkYUiFD6YcEER55CiLXS4C058KG2tZ+5VDQn1otTuzEMy5fzsOkR7iMg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712566610; x=1712653010; bh=fcUQjrA62H7/q7ih5/50etUz2m1I
	E3MgjD/KqUUDZ18=; b=TNQlbUXrBRseg+ZJ0gEeELhTvcnmPYPXAnyLxWC561DM
	MPuHh3o409SnwhvagXGWTqvZxVb0DybZFIm+M65ZVlxUCx4OnNUrML0lkkEXhoFs
	OevgjDCfIGcPgl1yhe0E+/g7N3cHHxwl+RnN23OtiAvFiHvbPlcBlQmLtfvXqbyj
	4ZUQrc2nAQm4TTqD+ueRfy69/tJ83j4Bvuk0crchSIraySBQOxhX7+H0NndOCOr7
	lrxgsEvwsTJGrPOlnQadeKJQADiSZCf9qffeWagYC8l+jDv1Jw6UF3XbwwRDOqkM
	EhSJrwkxx9O1EGFEA4bMHSlpnj7yZSxCwmswVDpnMw==
X-ME-Sender: <xms:UbETZknYl8uYMciBeXRjYKNIxruqCvlfKHfkc23tNqlir1QA_VoDVA>
    <xme:UbETZj3JOhUUwVDODU8HPk1WlF-RS4B7dL_PUvDFappHeQICG93_inaZvJtXzW8aR
    FiJ5N_pjY2oJELNnw>
X-ME-Received: <xmr:UbETZirVcDwFQ_gedYlMfCxnT0C-63hht9zo0KZMxA6yPH0FwMQfNwD-02YUV05-dSOz4kWeRZUoB2orHpLg7Fgqjk-IDgN5bClAtsUERO1tOG-WvQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudegiedguddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtjeenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepteeuvefhhfdufedvgeeiueeileegtdfhgeeftdeuveejjedtgfejhedujeeutddu
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:UbETZgnrKU8ikmUHJOkpZryNQHAE68Skvi6h91eIuYWX6QY5PsvS9w>
    <xmx:UbETZi3tkhTflLNpeqPaJ4dT-52ge7J42z3etKCXUuv5oMM6aHgWuw>
    <xmx:UbETZnsGCPC6h2b8xiTG1bV9mGSgNyklIho2WpyzYNX3k-DtLkZaxw>
    <xmx:UbETZuXVPn-Kzu12OepIonFeeR2YyKtwGUpTiZdZdoUbd0-1cPtBNQ>
    <xmx:UrETZu-9jJG6qsA2_yKLz45spDPCszlGBNAXLKMMbqHji2FhO_xsvsF1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Apr 2024 04:56:48 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id a4f20fdc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 8 Apr 2024 08:56:41 +0000 (UTC)
Date: Mon, 8 Apr 2024 10:56:44 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
	Josh Steadmon <steadmon@google.com>,
	Luca Milanesio <luca.milanesio@gmail.com>
Subject: Re: [PATCH v2 11/12] t0610: fix non-portable variable assignment
Message-ID: <ZhOxTHSE3wBqKUmR@tanuki>
References: <cover.1712235356.git.ps@pks.im>
 <cover.1712555682.git.ps@pks.im>
 <cedf5929d1ea989cbf87bad48e35c0d191b624c3.1712555682.git.ps@pks.im>
 <CAPig+cR2cN=oKiy4T4_Ue85VEAWXwxq_3Rh3mHuYWNx2DFv_Lw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="IbxB+Sy6vv6Xj4LA"
Content-Disposition: inline
In-Reply-To: <CAPig+cR2cN=oKiy4T4_Ue85VEAWXwxq_3Rh3mHuYWNx2DFv_Lw@mail.gmail.com>


--IbxB+Sy6vv6Xj4LA
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 08, 2024 at 02:57:04AM -0400, Eric Sunshine wrote:
> On Mon, Apr 8, 2024 at 2:47=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wro=
te:
> > Older versions of the Dash shell fail to parse `local var=3Dval`
> > assignments in some cases when `val` is unquoted. Such failures can be
> > observed e.g. with Ubuntu 20.04 and older, which has a Dash version that
> > still has this bug.
> >
> > Such an assignment has been introduced in t0610. The issue wasn't
> > detected for a while because this test used to only run when the
> > GIT_TEST_DEFAULT_REF_FORMAT environment variable was set to "refatble".
> > We have dropped that requirement now though, meaning that it runs
> > unconditionally, inclluding on jobs which use such older versions of
> > Ubuntu.
>=20
> s/refatble/reftable/
> s/inclluding/including/

Thanks, fixed locally. I'll wait for more feedback before sending out a
new version.

Patrick

> > We have worked around such issues in the past, e.g. in ebee5580ca
> > (parallel-checkout: avoid dash local bug in tests, 2021-06-06), by
> > quoting the `val` side. Apply the same fix to t0610.
> >
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>

--IbxB+Sy6vv6Xj4LA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYTsUcACgkQVbJhu7ck
PpQHEw//UPWFymwRmkfJ8wy2Ygt++QkaYI4RhDUqYdw0OZ/dtFP8SuQCpV7284Mj
zg8fa5t8v91ydbYdrmZivKR+jDMIeNR3OXwd+8zNugzPlhXuVU1cnSVlCB9P8sM1
I8P7HnV5lHwJHOrw5NF/47UYyx3yFkWpAO+9aUjLdvx+O0TAu0Y9a3dZIZV4Hisg
AcbFURcH+BvTW5BOPQyLWraZn+gE4vvZo+gG0ghTeZqu4Jmvr9GysVA+oOIYwn+3
db106p2oylrmmJ5yMR7nfc4RZeaHi+Dufu8koMONYOJlQWPlXckbAkmLljBQ9PF4
SbJmvfOBFMDbTRfnXKCCEfXmNmkHQOa5hInIv0jVOFNzYCcL7HLjN6ASK7Peb6Nh
h4bW1R4YNWA4+bt2AaSX5yVb80Xwt1etY7lS0HcxYeeV+yru07L94rOvp2tJJf99
JFuya7+Um+6qeQ6OzVYpIP1pSNVvc5sfpdwcKKByaHZeA/z3lXcbA2BYL7fPDM5C
iB/YgpsUUgPybZFxLz22oyEF7sYqwv5585kt6CS0HAfJ1Or9aSgv0BWt82VeVKVB
m7OGEbqhJNWy+FKldJaS0G7Aurtsa9Pcfx8nCrTr57dq4mkweaRmqXeG1QUxi3bL
kco279qWEhunHqM2dTOg7DTvBGSl17ZCU2rMehChcIf3IFR1ii0=
=vuu3
-----END PGP SIGNATURE-----

--IbxB+Sy6vv6Xj4LA--
