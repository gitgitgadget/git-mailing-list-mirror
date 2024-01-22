Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6B647F5A
	for <git@vger.kernel.org>; Mon, 22 Jan 2024 11:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705923076; cv=none; b=uMoqjSkXvtzXo0ub/HhfMcqvrxiLCsTs/UgJO88fNiBOpW1S/Wk67QiO73OFZXCeuNTbY8kfLSeFLC6XmTwYhSMfw6sLRv00LJVirhfEn9fAw+XhyH45CJeqjvfpoVn5bElvrdSZVK34oTGnaLz6NMPUItVSU4V6YLYd/VRfwok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705923076; c=relaxed/simple;
	bh=BxPGxTa0vUkrxZncLQQWZqb8CexmrlaZT5Z2boDr238=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CNpuZ6V2+PQQIoieHixnShd9w/P61AhHybmwbC2ujvbbn+R1nqaNBZI8BZHUoO23UFEtjpJTMKq5c5pnYZy3sXhoC/dYEj2uB0LhNb77mD8jlbT0Zlg1cxEb7Oqbud0POF2mbmnBkWodbd3aivqRGqHkwJJg9JS2huI//Lh2wAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=HH1BpchV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VvWlg47U; arc=none smtp.client-ip=64.147.123.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HH1BpchV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VvWlg47U"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.west.internal (Postfix) with ESMTP id 6AA0D3200A64;
	Mon, 22 Jan 2024 06:31:12 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 22 Jan 2024 06:31:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1705923071; x=1706009471; bh=zeJiHpJiWk
	DG6MN+mqLwIQWQycLHNPxlJkESheQubVg=; b=HH1BpchVVFOHwWKJZK9M+lJocG
	fK1NSwCQG8nXsfObK0cLAtZw3gIfnw2qhtTIjqeHgr/vq0rejlRcyCwBrtV+BGI2
	h0eox1PK06GO7T8y3K1BD1p9yT5mHI7meYwX0Lbq/30DLXKo+Qvl4PpktLSIl/ER
	Fgggc0Sc1nDnKYdNdxuL7f/vlWv4eITtLhrAH2Fbobo0cMkrJwWIpgVaQGbACxHL
	gbj+4xRFWj8VFXTlJychpBxV+lnh3mE7jFafY7j1kVgB9bMcjQU70Y8W5M2hhT64
	ZRxZjgCmx61QqV5Wkpill/RS5kjamwvoEzKbSVrJu3k1TQsOxgfLTd6E8G3A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1705923071; x=1706009471; bh=zeJiHpJiWkDG6MN+mqLwIQWQycLH
	NPxlJkESheQubVg=; b=VvWlg47UXVha7KTHHGqAMxbGzwWOvMCi8qNUn/Gi56Sw
	OTMSDEuRur5Lo0L3WTJP7Gv+soqE0nrgGVUUO3Uosqt/ipfECx0Bg27SgGYQi54K
	S/lE8+Dzd1k9m/VWGoM47tSEq+UfI32PGsggntxWHh1RPYYmbWq3XvtW1w5npX6/
	hMNCtC0plHbItwQF9Qs5/qQL/0cLgApcUG8EWq5crKs1tbdcBzxcOIcnIVCRXCj1
	neziIFqRDBQtRAFohUZxT7beEm8gWudtekI5epguoRaozxToG/uZhuAu0niQFSek
	PhzBczdrJBOXSaVlaCjbuuCw4eFHC7SrdEBTtZRSCQ==
X-ME-Sender: <xms:_1GuZUMnbz5JaYoT9YKemzRRPCUYPzBCR4BeWGiSLOEymHxImqBqug>
    <xme:_1GuZa8FVAa4T5dlLernP8Vhz8bN_0N5-IAbYvIOc57yz1Jo3fc1wfS9LR8cAe2D7
    lLDvy7o6JRM5Rnnig>
X-ME-Received: <xmr:_1GuZbT9lSVc-lva8g0BOVLZurhcv5u17XgtxUibfj410U49wLbojdAs4xn998_wEHZ5XcNkXBkkPH91TqiOmZjQZfqiMP4S3I2tjDXoOb8GE1Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdekiedgvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:_1GuZcspoAHuHOlqI9yKJ4vbV8e_nilPQB5JpSYtL0sCiOPUpx6I6w>
    <xmx:_1GuZcfxJWTiB4Z555tFHX3bSljKz-Ma9jWhsn6k2qW4s6YWiTgquA>
    <xmx:_1GuZQ1Yu7ED0YIDHT5qxQaIiHscILKzpE0oF0ThIttdk4r9HDKtFw>
    <xmx:_1GuZYGDSOogtAeIZxkI4yaZrbixgu-HKSmUHvfpc2wbwmMZM7Y8yA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Jan 2024 06:31:10 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 56fc7d7d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 22 Jan 2024 11:28:06 +0000 (UTC)
Date: Mon, 22 Jan 2024 12:31:07 +0100
From: Patrick Steinhardt <ps@pks.im>
To: John Cai via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, John Cai <johncai86@gmail.com>
Subject: Re: [PATCH v2 01/12] t3210: move to t0601
Message-ID: <Za5R-5fhhFYqxt-U@tanuki>
References: <pull.1647.git.git.1705521155.gitgitgadget@gmail.com>
 <pull.1647.v2.git.git.1705695540.gitgitgadget@gmail.com>
 <ca65b9e6122d10a7b43d06a6069dae00e645a392.1705695540.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="EqnwzPiIVeHiBF/T"
Content-Disposition: inline
In-Reply-To: <ca65b9e6122d10a7b43d06a6069dae00e645a392.1705695540.git.gitgitgadget@gmail.com>


--EqnwzPiIVeHiBF/T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 19, 2024 at 08:18:49PM +0000, John Cai via GitGitGadget wrote:
> From: John Cai <johncai86@gmail.com>
>=20
> Move t3210 to t0601, since these tests are reffiles specific in that
> they modify loose refs manually. This is part of the effort to
> categorize these tests together based on the ref backend they test. When
> we upstream the reftable backend, we can add more tests to t06xx. This
> way, all tests that test specific ref backend behavior will be grouped
> together.
>=20
> Signed-off-by: John Cai <johncai86@gmail.com>
> ---
>  t/{t3210-pack-refs.sh =3D> t0601-reffiles-pack-refs.sh} | 6 ++++++
>  1 file changed, 6 insertions(+)
>  rename t/{t3210-pack-refs.sh =3D> t0601-reffiles-pack-refs.sh} (98%)
>=20
> diff --git a/t/t3210-pack-refs.sh b/t/t0601-reffiles-pack-refs.sh
> similarity index 98%
> rename from t/t3210-pack-refs.sh
> rename to t/t0601-reffiles-pack-refs.sh
> index 7f4e98db7db..f7a3f693901 100755
> --- a/t/t3210-pack-refs.sh
> +++ b/t/t0601-reffiles-pack-refs.sh
> @@ -15,6 +15,12 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
>  TEST_PASSES_SANITIZE_LEAK=3Dtrue
>  . ./test-lib.sh
> =20
> +if ! test_have_prereq REFFILES
> +	then
> +		skip_all=3D'skipping reffiles specific tests'
> +		test_done
> +fi

Indentation here is off as we do not typically ident the `then`. So this
should rather look like the following:

if ! test_have_prereq REFFILES
then
	skip_all=3D'skipping reffiles specific tests'
	test_done
fi

Patrick

--EqnwzPiIVeHiBF/T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWuUfoACgkQVbJhu7ck
PpTfyA/8CgqEpIGMAscNzJs0eNGYy66rbjcTPcvksIFzbQbUglBWFCl0ASFpeRIF
PaXFQdnIQbSuIVUAKlcqM6luy2l6dEdsnVzVm2DSoRY99qlEiwc6ipE8hG2Jt4bg
Sx8kSgRCdBUInUWoep183pWConPYkYX0ydVybxRVqmCC4HtE/9KqIE72GU5BSial
//+hKWE/eney4c5p5u5vdUS65XgdVUS/jwjxi9Mx6KV509M8im38PZS+sUdrUhks
2RZbp40B7aOyL2aOB0p0loq3UJAMFe1Md3tWcBvy8gfcDKiW2SE5/r/Q9BS8Bmiy
bk7ZddzTl9kEsr4M0yeddB1aD0pz8IY7X1lrn6eYV6bVWQ0GmXcFNFMyNMuq7RWE
W9810z08hS1u9rekfoTuwxAjLZxWx4q6Xd9DdEmCwWkSSCeAZN4h5N78fNu03sYF
50nR0R8PebD45Ih/zOuDhoE38V4oyNDjA5gX3QIK2d+FkEogkhCWD3gaUgOzQeBR
R64qydEq8Jwwnnvf1lA24jic1jdcZlTFhPpOBt58MpfD9OCFu6G16ECTc/FG3Rsq
oe/wBRr+39SNaRNRUhUkRkgCEo1DKBlTUrDUwZh9tE1ymstGImo5sBCAL0rT3Nmm
htiY4JDrq2F8Dc4IVSTc/u01C+ZlIV8T0OUUOmGh0E6NJ77eYCQ=
=Ka/j
-----END PGP SIGNATURE-----

--EqnwzPiIVeHiBF/T--
