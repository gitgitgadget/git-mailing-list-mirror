Received: from fhigh7-smtp.messagingengine.com (fhigh7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A873B667
	for <git@vger.kernel.org>; Thu, 16 May 2024 04:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715833086; cv=none; b=FAEiI1flR52FLKjpNXbM186znsXtTs+Sh4krdw2HpSF2l3XiF79hk1ELUlTZSLEDNYDyock88Mf8el1RRn0zmtTwjqpO0OsgbRBynrpmsf6jCjwGtaXGKoeAqC5WRjjCP6gpJ/wdaUrdpODP3YE0/ETlQr3fUBs3ppF2PtSYw18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715833086; c=relaxed/simple;
	bh=/0emx9eivVZN9QYYQQKhYfsyzSvMYfzVZwq5/P3/454=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FhHrv4AjfGErVyJH/kdMOjFT/d82K384zBo8ywq5GzXkEk2Z6fEDxvysqWYak2jxsndtRidftcpISFOLVdCLbViCbDBsym69qnkWk8eLUt+Ba/eIYQbhJKfM6Q+eVQJEeUQD/WB26iizyGpRNUtkELIjMd3fSPKzzKEdG2Dh2xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mcwNyA5l; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kcE8xWwy; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mcwNyA5l";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kcE8xWwy"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 90B571140153;
	Thu, 16 May 2024 00:18:03 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 16 May 2024 00:18:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715833083; x=1715919483; bh=ypjg7MC8UX
	eQxK8JDxeyD7A+Ppc5Fv6kNZSS4bCphDc=; b=mcwNyA5lQTD83vOSztuzk8XkST
	Yu85zoZzuodMJp3PxGBMHj52PKRrL05L6ZzfIyksHGbFyjKWhDERv1xpJAla2NsU
	jAHUPPoO6PqMZwIxJCRbLu6vhnHbijmYtZJ2LJBbjGVF9opatlEg8AYVVXskJuWj
	wXX/ABnP/XyvieIl71n9+G4GAMZ99PxshgFe+YJyVv/PPpuTvIVFCmwlnAS/RREA
	44trqwf8bRJtcqeBa6S33gks5HSCDBurlkdUEgi7gzI2jyAUcuKixlcBxYSWWcgh
	t9PtIb+ySFRUw4dbgKTbS5pCjZleJoYdvQSMCf047RhrBocANSutrO7sD87A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715833083; x=1715919483; bh=ypjg7MC8UXeQxK8JDxeyD7A+Ppc5
	Fv6kNZSS4bCphDc=; b=kcE8xWwyaG1l2bjjaFMkzvM7JRUJaT77/p4Q5rXgO2v9
	FePvSriRA21cOU0hPTirOn6TmlRN62RH9RnFgTIhGReKDT6bwJSkw0FsT8uW15sy
	dKBfGGkZGbpOlVPB8pzx4oVchA4A1177OaRbRTX1j11VRskIk5KGIIc3EXxb0Mrs
	Bt0w0s63zV92TGnORWE1ZmlBy5qFD6E7VWvdQHZTo1OnwWPRT6NhqWkV34oBvP4m
	FfRlsp/n0K5AI2QseOXYAS987Ox0R9LI/j+K79kZVafhm4n3WyN9fpLAcfV0iBMO
	xM4jNUnJe0xoXLSWcRHpVXZns8B9Njxt5d/QI3ndNQ==
X-ME-Sender: <xms:-4hFZsiy6hMzOPdWdBzbV2EwwlDXNB2mcYtG-y1YSzJd7HLzMMMfEA>
    <xme:-4hFZlDr4995woOcqAqm09I-1lb1ePJhciY9j9Gnt-CNpFXYgh4EskOcAg1Ex7l3S
    StS3ZRgqLRFDWWThg>
X-ME-Received: <xmr:-4hFZkFplV4aI1Bh49W_R1BqelhNSG1OIpOEruGI2bcKGamxQ-hmRM7qW8XbmItL62XSuMA3qjNSQBJj5aAXjfsiTej6xNd2n3t1-B1TX-2-pkU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdegledgjeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:-4hFZtSi_SxQMn6K2cZFWcPjRw4dnzySD4gIoFNIyEhvynJ3U8fqWQ>
    <xmx:-4hFZpyQ_DcnL6nBR_AI-VinnJUzB1C47_TUqa_wEwfNoBMO2f-ROw>
    <xmx:-4hFZr5WLNkpbEUSg6wlcgUF27GcFbjWuf1V__wF0aY4vDN4oq1LXA>
    <xmx:-4hFZmw0lXtfHKSw4pkObaLyD9QuouYbogwHWPYd6nGabaESA32nQA>
    <xmx:-4hFZk-VtpwHUr17aAtwbrvWTRegn18ZNfWBCmTFLaCqFhldhVz12tTp>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 May 2024 00:18:02 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id f73dcdb3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 16 May 2024 04:17:37 +0000 (UTC)
Date: Thu, 16 May 2024 06:17:59 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Marcel Telka <marcel@telka.sk>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] t/t0211-trace2-perf.sh: fix typo patern -> pattern
Message-ID: <ZkWI9--gMH0Xgv3f@tanuki>
References: <ZkU8VAUnKx_SXU5U@telcontar>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ZdeuzSvUX8u+HVfa"
Content-Disposition: inline
In-Reply-To: <ZkU8VAUnKx_SXU5U@telcontar>


--ZdeuzSvUX8u+HVfa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 16, 2024 at 12:51:00AM +0200, Marcel Telka wrote:

Thanks for the patch, which looks obviously good to me. It would be nice
to have a short explanation in the commit message that explains why this
issue was able to sneak.

Patrick

> Signed-off-by: Marcel Telka <marcel@telka.sk>
> ---
>  t/t0211-trace2-perf.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/t/t0211-trace2-perf.sh b/t/t0211-trace2-perf.sh
> index 13ef69b92f..070fe7a5da 100755
> --- a/t/t0211-trace2-perf.sh
> +++ b/t/t0211-trace2-perf.sh
> @@ -233,7 +233,7 @@ have_counter_event () {
> =20
>  	pattern=3D"d0|${thread}|${event}||||${category}|name:${name} value:${va=
lue}" &&
> =20
> -	grep "${patern}" ${file}
> +	grep "${pattern}" ${file}
>  }
> =20
>  test_expect_success 'global counter test/test1' '
>=20

--ZdeuzSvUX8u+HVfa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZFiPYACgkQVbJhu7ck
PpQyhQ//bA+9ACaoy4pUrAftKiClx8ips/Z2Sb0f5v3JVQ9+B65yCm+zvFoNz2rA
jaGv0dL4Y9tXhqlGBNP867b7wjVUH5fc7J5pw2YYgQzOIoDdmmxfwRI2Qc1U8c9m
zgP3eVxobzpZtvF0RQV6iUdxmDbX/beW0jq1XRQ9QJTJuOrcuHwXDSUgL/Bxqvef
0F5gVi6Yc8ECDuA2Sg+JpLXiGEl3dD4xdRyZgCGLcg9EhVB++aejcjY78eArJ9sd
CBtLLr3iTYiOqFUuWTA50Nlayait5Tiwl4ACeskoOzzQmnEd1YSQldG5b/CUEUsM
YWg8hWC284v9z2jS/N28HXwC17l2RkMzqic5w0oqf2xijVp5EKF+TKiCYmKNkESQ
TUihSsZprm2LU+NsD6OhtBeaqrHysPM039yfNro6p6hhuv3ag3tMYhMYtwXxNCS+
94wUoW7SJuOp79AfXvmJiMhMcU9HVyE92KxulsbZptmptTkHby6B6CCfsW+HDSil
5JbgBG/NcPdjqokVc9kajrwn4yNxBFnOvcY1bryut/BV58a8BVzECKh8i+OF91yG
uVpFIq8wyQ10x5XkpStdjW2J7Y7igvAsV6+c2YLObvZhOut7GgDseFj/zlpikBNg
2uYmlVf2bs/kNJNrWSdKvle9YhShHiIYHaP0vUqOit93jraFIns=
=s6se
-----END PGP SIGNATURE-----

--ZdeuzSvUX8u+HVfa--
