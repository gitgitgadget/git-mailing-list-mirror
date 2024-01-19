Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8DC4F21A
	for <git@vger.kernel.org>; Fri, 19 Jan 2024 13:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705671622; cv=none; b=XGmfNxZZ1glZ2JdhYTo7xQ9cdtmTCRRuTb1ui8T0EX0LJ+e2rfC4No/v1vZeUJmwoGPhaWkZtUI7JyEXJxB/Dwt2V9rWo4g3T7O7WNGImi+e0TJwMfItLyO/YP7p6MWyFNqeRGPjFTX70vgyw3esBx0AASdFTxYjg31Dcr+nMKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705671622; c=relaxed/simple;
	bh=qko72L9LQIis/6nCH9Wty05NsVGMSx6BpB2D+oDrbCM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X7b2jYwUu1qdmlC0dAbsXtsjtxtrS2XlgtPmvyzAgtGi4lRJ9VXgTdEYK9FHRsFEdnFIgVPu69nzGiy86hLBZjxeNQxe6iSncuQ17oMPyi6QJNS1ZrHECdLhuU20Tvf9eeC+1wJI7Uk9s1HWdihmgYpfUug8xIgH9sODYHT94ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=qqBGrnRb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Qu281uzB; arc=none smtp.client-ip=64.147.123.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qqBGrnRb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Qu281uzB"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.west.internal (Postfix) with ESMTP id 56EEC3200AA6;
	Fri, 19 Jan 2024 08:40:20 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Fri, 19 Jan 2024 08:40:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1705671619; x=1705758019; bh=1MAa9lioo7
	0P60w8CMV8cid+TzQ4lb7/Av7N9B7BqoI=; b=qqBGrnRbiZGr80Ads2wPUfXgBK
	8Oj98usAgsa1GLnfZfGVroCAYEBANwTU0akCXZhHT6LjzPRpqrv89AWYYb70Ox34
	dRWVYyuyZXzAAEtPLljNteKwKzl0cay1hVx9c4AKmXS4o4ohsFM11rHIdFiXoRqt
	vh9ysMx91CxBdgVL8z2Z4unftaqkPwEyz/tqF8Jyf2lCFb1fQ4NSN3H/yP1MI3n/
	NrzSIxPfMZ8LDF5+SdVw76lkBKmWmA7y/CQRdvqDFbMJYZ3I2dcqKTzGnKYFsN1J
	Awd9aY/fPLorj7Xc5Rmf6XQwEcq+qp38xIteX6QP+eqZFPiHLNr++gCQHTlg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1705671619; x=1705758019; bh=1MAa9lioo70P60w8CMV8cid+TzQ4
	lb7/Av7N9B7BqoI=; b=Qu281uzBlszpq0q3bbx1THi091oxIdsGU49rb/S6kgD2
	lQwl13qS3BW4YfTqiFPy0FOtDz0+oO6S29UgFTYooYGlwrQV70TW9uJbtFRnbxtc
	2vk2Ost07H1lIryLqtROvpRd96rHFpST4u30dYUgkuyP83SiUxXlgH5BsKiovrni
	VUn0gWgjrgX0rbSWjXZs9ynWz0To82Rt6BXE27Lli4X2gE+nHXYxK8e2YquFEdu1
	NAqJmY36ieYSeYccApTgcwdIqCsDAGgSRaamZd/aYKUOc001fAZ158AtS0oEMynx
	qnbG5/4G3AF6xkjdfbyuN+MKD8ejd0iFc7wS6aw6dA==
X-ME-Sender: <xms:w3uqZVL6NpyyXx3xI1sgbp7LayFwy_ar4T-TrhvMjOLkHIDh-bts1g>
    <xme:w3uqZRJd3A_WBzQ9af4kE-Q31TwM76c9NF4k5HPs8h8TqsRytnYvorEWfIoGXyDWQ
    fS1Pmajc7r60b4EIg>
X-ME-Received: <xmr:w3uqZdskahwod3m3YxklO9YW5ICK0DT5MhWou74plP7DtUDV7LbxpLjGnePN7gNajCrfbJEnhtihO_2SPlGik9vBODgF_wnnMwoFwTwNlnQxGuJp3Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdektddgheegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:w3uqZWbfFZ_rZ6scSi02-lpq4Jo2ArPXkZNPDoPmu43Dm7B5OcIsBw>
    <xmx:w3uqZcaGUQWX1QJT7WsfGjeWOnw7ayOZDDNz8-gGC5itvrm7hbJaDw>
    <xmx:w3uqZaDiOvZz-DjFiG_RAwEJDpKzxbEokRreP0D_sCHgmaQ937BrxQ>
    <xmx:w3uqZXwxp9ZFsU-i34fqGgqQcgcSa3BOfq4NT1PrRAfsS2_1HWp1BQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 19 Jan 2024 08:40:18 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 070095cb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 19 Jan 2024 13:37:20 +0000 (UTC)
Date: Fri, 19 Jan 2024 14:40:16 +0100
From: Patrick Steinhardt <ps@pks.im>
To: John Cai via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, John Cai <johncai86@gmail.com>
Subject: Re: [PATCH 12/12] t5312: move reffiles specific tests to t0600
Message-ID: <Zap7wPW8qwHRuCM0@tanuki>
References: <pull.1647.git.git.1705521155.gitgitgadget@gmail.com>
 <316a20ed17950e4e45d7ea13d8f6e8d4e064821e.1705521155.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8plPlKlEdXeD0dVQ"
Content-Disposition: inline
In-Reply-To: <316a20ed17950e4e45d7ea13d8f6e8d4e064821e.1705521155.git.gitgitgadget@gmail.com>


--8plPlKlEdXeD0dVQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 17, 2024 at 07:52:35PM +0000, John Cai via GitGitGadget wrote:
> From: John Cai <johncai86@gmail.com>
>=20
> Move a few tests into t0600 since they specifically test the packed-refs
> file and thus are specific to the reffiles backend.
>=20
> Signed-off-by: John Cai <johncai86@gmail.com>
> ---
>  t/t0600-reffiles-backend.sh | 30 ++++++++++++++++++++++++++++++
>  t/t5312-prune-corruption.sh | 26 --------------------------
>  2 files changed, 30 insertions(+), 26 deletions(-)
>=20
> diff --git a/t/t0600-reffiles-backend.sh b/t/t0600-reffiles-backend.sh
> index c88576dfea5..190155f592d 100755
> --- a/t/t0600-reffiles-backend.sh
> +++ b/t/t0600-reffiles-backend.sh
> @@ -571,4 +571,34 @@ test_expect_success 'log diagnoses bogus HEAD symref=
' '
>  	test_grep broken stderr
>  '
> =20
> +# we do not want to count on running pack-refs to
> +# actually pack it, as it is perfectly reasonable to
> +# skip processing a broken ref
> +test_expect_success 'create packed-refs file with broken ref' '
> +	test_tick && git commit --allow-empty -m one &&
> +	recoverable=3D$(git rev-parse HEAD) &&
> +	test_tick && git commit --allow-empty -m two &&
> +	missing=3D$(git rev-parse HEAD) &&
> +	rm -f .git/refs/heads/main &&
> +	cat >.git/packed-refs <<-EOF &&
> +	$missing refs/heads/main
> +	$recoverable refs/heads/other
> +	EOF
> +	echo $missing >expect &&
> +	git rev-parse refs/heads/main >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'pack-refs does not silently delete broken packed re=
f' '
> +	git pack-refs --all --prune &&
> +	git rev-parse refs/heads/main >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success  'pack-refs does not drop broken refs during deletio=
n' '
> +	git update-ref -d refs/heads/other &&
> +	git rev-parse refs/heads/main >actual &&
> +	test_cmp expect actual
> +'

Should these tests be moved into t0601-reffiles-pack-refs.sh instead?

Patrick

--8plPlKlEdXeD0dVQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWqe78ACgkQVbJhu7ck
PpRc0Q//TuqCiak/PVvovLGhqGYdPRYdtNUjEjx7Fnrf9MGZSVbKtai6V+uzuphd
7yIcRaw9SMHOrHAXXrJwxi4Dl+vSdCjSbqTU4VH/ndYVQz1EGF2a3e/S5iEyVEw8
j2UWxBg7/mxwB0y/Ec7AaSwxMpZxYUuM1VgpkER0KyReXAugUNpyFSTI0vrgEcsh
WxMWtUrIxp8ljsX5QpltMrNPebT0fIEObqU7aSPDPv901I5IzFBGGz3EA3eysZLE
vFAnLoCHWSzpDC/xuowEp0QFEm3NImi8h2qOpda5v6TVzATulXp8QqYzuHvmvwE4
4NQjStMsewO7tfqRTAJhQbba5FrYIHYMzZ5vp/5yYNUducpb5HPbfMeN926dqD54
pquUWNeG/isozj4DjnvWlUFBzcTXHq8skwA0mi/0B+H5juAHOrEY3P6SqApSDKO2
xisSB15lFW2YIJQrXyB01r4JTA7SSYsFM19yUjT3kTPLsjhz2d+Y8Sy4J+HN9tWj
iB4l0/mkZgGsSS7zPKXJ6KqM9ZxBp8FIOtdp6CW6gSmZFU5xffyLRxeMWfMJN/KS
PVXA1Th8vr3Zo+m2WZPnNSyGMRbh7SzqAEYI2Yt46zFyTUWDCNNuOxq413xKVoF4
/7W8H7EZ8O0SXy7ykZeNYxu/d34Ou7xaiRj0Z4QDtO9r+7FolQs=
=exx2
-----END PGP SIGNATURE-----

--8plPlKlEdXeD0dVQ--
