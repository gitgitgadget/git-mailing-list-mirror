Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8EB6469E
	for <git@vger.kernel.org>; Fri, 19 Jan 2024 06:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705644312; cv=none; b=pXzRt959NjPmLfbwluHGLlV76+FZJmATSDRqiSYm362SIdWjpX0OJXN+ILdLNLl9TlPh+q8Sl0aYJIsvFbk0BHGYOpTzOCEuOpa3mJRwCWNwtQoD08FLVnHCue4GcIn1gLmGpFzY0dknboZ2Yuh17/6RnbESDg6BodrPbEeX3Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705644312; c=relaxed/simple;
	bh=DHRpqHL5f3rUhlK+gyjwBRHqllYZINUlj/fIW/ztxzA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l1DuhoLSuxLkl+QNhS754E2ssrnyx1d2oOQ3Ev5+3HWuOTpkmb3mj2YXYrRV1NyE62V0HzVX0V1szahCbzCAHXMxpw31RtGzssBo6vJGNrzhgBOYInPYLvO3Z/FVeE09Y6wgQXutSfNdB3he3E6OEF1kRBjClsykcxfvoWviNN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fO/pFbyf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Z4RxNitv; arc=none smtp.client-ip=64.147.123.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fO/pFbyf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Z4RxNitv"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.west.internal (Postfix) with ESMTP id A4CED3200AA5;
	Fri, 19 Jan 2024 01:05:08 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 19 Jan 2024 01:05:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1705644308; x=1705730708; bh=DHRpqHL5f3
	rUhlK+gyjwBRHqllYZINUlj/fIW/ztxzA=; b=fO/pFbyfF0/2mC3OwF3uYu/+Y8
	TJU7OlEhQ26HfSuc1gUvE7H9y5Tykdx/1BkE8flJzcgmuVzUylhoy45J59u9r1Rt
	ui3ybeCX04zQJRd7/pczTi0deT063E/TPTJyiSz7749FfsjtjqasnAuvHjKXR0pQ
	SvoaRrAQOwjkk1QhnMPTSD6mekGqTT+LVQ+IDKMS4QJpcdmQhXLc5vi6R7j4EUZj
	V2hy33anj5cYAAalqt4gjQFQNOX7PyD9Nfon2Xl+2S/x1dnicCHadF+WqleHb51h
	i8z4RJNFv/CipI4dTmV21SEN/fzjO9lOUDqpJVQQwajix53yVwvD6wDLgMhw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1705644308; x=1705730708; bh=DHRpqHL5f3rUhlK+gyjwBRHqllYZ
	INUlj/fIW/ztxzA=; b=Z4RxNitvK1EYpe+CGLtpDKBmWpww/7d5sxBzDFk2gP/P
	8zC/9z0OuIligUfH3vqWqgnHhqzQyPi1ObvZcPAfU2lj93CotWcVGLZ0OaC9DtAI
	fCDHI7W5XzWQFPnlbbyuUhb3+a67t2J/oZIclbXZ9HYebjnj73TMSZinoe4Xoqw8
	HRgHv6P8GMGHRDWZKTANTgmAHxmNuC/jrtVnPVblErqZ+Z9d1VEFvfToXOnUe5Fh
	3/g29oaeDrnxHoNCOEbDFx+FLVYlJpg+iHqvlzE4r/Gu0S18UpBKVjA8zVm7H1uh
	AKir8IMxMA4enAr9rGYF6W77AVRsiCiln7wo/7NzSg==
X-ME-Sender: <xms:ExGqZUw9hxUenzJ6axfH_jWoxB9Ab0GgIxjLulL-eSH5-vuZB0IUJA>
    <xme:ExGqZYR9rV30PH_AcymANV2beAAhu42Dm74JFWMufDmTfAE4KEBYzVvdbf2CbrtZ4
    KXnKQ4EX3TN_ijqWA>
X-ME-Received: <xmr:ExGqZWVhs-bdzG3V0v-jQvFMNeUQ7ugnaPfWeo3rz3M7XjZUwBouWcckTB6i_AXi4bMYrSKEPA5i1Rfp21I7OwXKK1IofWxvgo1IHSRgjCy0hVg7rg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdejledgleduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtroertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepheefhfeutdevtdefieetueeggfefleegleevheffueekleefhfeikeetveduhfff
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:FBGqZSii4AdFWRyYVDjRX7g7Zdj75MLrNb75oE3KEpY_YDuOvZ7Svg>
    <xmx:FBGqZWC_eJUTF6n-ZJ5MyiF78iU8ncbeN0hUTaneRJ7WHM8biG3GTA>
    <xmx:FBGqZTJYwE18T9CEZsfShZpTVGfT9t2CsyLGY_nTCajCOdpnwDiPcw>
    <xmx:FBGqZZNYGEkAXCB8y1tS7ai92mc0NWIk2zdyjskAxhmz0gFxVF1-kA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 19 Jan 2024 01:05:07 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 5919aa83 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 19 Jan 2024 06:02:07 +0000 (UTC)
Date: Fri, 19 Jan 2024 07:05:02 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Victoria Dye <vdye@github.com>
Subject: Re: [PATCH v2 3/4] t7450: test submodule urls
Message-ID: <ZaoRDniGoIBXmjVx@tanuki>
References: <pull.1635.git.1704822817.gitgitgadget@gmail.com>
 <pull.1635.v2.git.1705542918.gitgitgadget@gmail.com>
 <b6843a58389170a45b5ef7809e0335a6425eadaa.1705542918.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="iwuSr1tr/ID3nO6/"
Content-Disposition: inline
In-Reply-To: <b6843a58389170a45b5ef7809e0335a6425eadaa.1705542918.git.gitgitgadget@gmail.com>


--iwuSr1tr/ID3nO6/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2024 at 01:55:17AM +0000, Victoria Dye via GitGitGadget wro=
te:
> From: Victoria Dye <vdye@github.com>
>=20
> Add tests to 't7450-bad-git-dotfiles.sh' to check the validity of differe=
nt
> submodule URLs. To verify this directly (without setting up test
> repositories & submodules), add a 'check-url' subcommand to 'test-tool
> submodule' that calls 'check_submodule_url' in the same way that
> 'check-name' calls 'check_submodule_name'.
>=20
> Add two tests to separately address cases where the URL check correctly
> filters out invalid URLs and cases where the check misses invalid URLs. M=
ark
> the latter ("url check misses invalid cases") with 'test_expect_failure' =
to
> indicate that this not the undesired behavior.

Nit: this should probably say "to indicate that this is not the desired
behaviour." But given that the other patches in this series look good to
me I don't think this warrants a reroll.

Thanks!

Patrick

--iwuSr1tr/ID3nO6/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWqEQkACgkQVbJhu7ck
PpQcHA//USUbeQ9yBzsZW3ePqxHmDqqlfe6wjX6Tf3Y2TSFOqCuCyLdSUnNPBT9M
4KE/GcY6Ve15c/tOIKsr+Ht0IBas5/vE74cWgHzdS1/o3hg4L4Lm6oa+n5Ia6+xV
lCau5UKHSp1S6Y922eZx7EF1BJDMu3vHGlYkKeWWeFwSsPgQ0HfDnaLFcEel29uu
fF/3C7fglpdv1RGvbwHHzifCg2y7wERX3s47wV8IjdKxubjbjMOyuDviQIz37DBc
ENiOrKd37x5L5l/cEMdUdbZewC3fhA6pxiR6a98ihsycIP9L9RAMbkh/SDsGRqTu
Y/e/v2uplJ12MW50k6GU//pDccPMQCbNUbI59kShJFzEs0A3ASkSma2sLEe2686F
OsE9CLol2isxqMmFzux1x6+iPGtCYf2kDlOPOlB5IlCvabC4qLuWSrh71PO+0qcY
gFbWlQPrQJbCVEuxIRaE/PItYOLxXJqHSxHE+HuQ95WfTaG1qk5wDUF/fKVOYIUf
hzucw3OxEIA4Ztf/wvK7j4lbl+Rfr7C2Vmj4vdntD5lQT7wjXZBPQcXwFvVzuf24
6jcaFy+uJCYXUV7KEpnjPq7QbWb3kayFNoLJG8zosY2c7GIGJe+0/qdiOnyRwkHr
jtKO/K3T2DQI5WzoZ5XfwMykoH7vftD/4jzaWZQtYuwYqZ5gUQc=
=9SRi
-----END PGP SIGNATURE-----

--iwuSr1tr/ID3nO6/--
