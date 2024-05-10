Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7581A172799
	for <git@vger.kernel.org>; Fri, 10 May 2024 16:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715357963; cv=none; b=S4QfvPT1iLcHZppvspBeVIPv1fVfKq/gF3ZAaRI9kcBznvhN9+5m2spTp0G30O3CI5A+lxVFEODVpE+qc6jWIZGRZFXuWjZovWCbUAh0nJI/7A+zoKATN/EK6/dugXZSr56McODmWVG1Knu35fZEMI8+Ikq+/m/5gOyAVWIBkwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715357963; c=relaxed/simple;
	bh=KUq9x8ww8YGLPeAkgC7Qo9Cr2DwIqBKluWp3hVRPTus=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FFpiRmY5oUij8ePrzguw0qyGrRohZsLxyyoXs2gT4PHOlmlEh83xYyrrRTYPC1uqILc1C0oSq93FITD9x7PfJ5xdmuPab9rGC3K6tEl+LKJ2B0NapHnTPrc+4pzdVE/XaNrR2lx5NWDsueXO1r+Mpj7HkUxMxdv/pN6zv90oicE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=PVt5Zt5s; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CfcCuKgx; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="PVt5Zt5s";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CfcCuKgx"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id 4F9081380258;
	Fri, 10 May 2024 12:19:05 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Fri, 10 May 2024 12:19:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715357945; x=1715444345; bh=dxsBv5Pd9Q
	fR32nefEivgqWwJ0WWAU9qVrBM3Bq4s0E=; b=PVt5Zt5sms599r7cXPpF4CsESC
	Eguz4l5UmijnOoaX+8aAvTMyXMWcx4LiTS34FN3VPhrEc8u3atOOxf756KnU/rXY
	VzjovCRCl/8VY98t/JeOWfZ6RtiIb+3F4yrKBmp6BJcYhbwEyn4tMSxvp/jTCPXx
	a7a8wVPU6VBUVjGe9S+P6LPLJbae2E4dWVl10IfxOsEucNKrzVtBYJcPTXzuB3mz
	yFMR18o6fbXwA30MdfCHA4I3FMVYZ0qUb5MbQGoK6et813TOmd2YUV+Zu/koHHix
	EYvNmrltExC6fAEZFABrgKhQrTigWj4FeMuzbvce3aSnWFt21f+YZ+ZJUiyA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715357945; x=1715444345; bh=dxsBv5Pd9QfR32nefEivgqWwJ0WW
	AU9qVrBM3Bq4s0E=; b=CfcCuKgxvJCRfLfKw+vsOuvN2ODTozc/OIm++4+sfbzq
	eT5GEkWpnz/u1QTXupk1dv2B7gwIlm6qv4/XfUcrGxVTK8H7GdNSpe1UDfbH945v
	nmJZG9990mto/6JGrDYsuqwqhghrVunW3yfl0W64UE9IUfBjXRJLNg4uS3jkk+kp
	GbchVUpFQunA9upsSHZci8wLR+dGX1gKQusTQTQBRHbYf6X2zOZhw83iKyeyDJli
	kp0sU9iycc2vxeVrzy9iGY27WwFjjCTY9pg6I4mn/kAr1nuhkjyQc7CXHmKw/uT5
	yaON/+aPniqs3Db2/epcP4sEMmxRYga7FDcLNrZ1DQ==
X-ME-Sender: <xms:-Ug-ZtxwM_PiWkWe7QDstlZTTnY-8JIkV-XoYegvpnwg6XJILOy68Q>
    <xme:-Ug-ZtTREt_RIBu-4puppEiFcg8BOkV63QJ53NL3k9K_zlZMHZERMqcJ_9wZx8-Me
    QxtsVb7Bi7d_g0IrA>
X-ME-Received: <xmr:-Ug-ZnUnWCIwhQZiAAwdyusXz9j3iLDEma5YI1oZBLay1lpzeLl9Ako4GFG4Xl7IQkZkbFq7Hc2F3-EiECwvrt71GKt9FxBOn_vjUOvOU0cxlnBaog>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdefkedgleekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:-Ug-ZvhWu-0ElAd1LSxn3YtFR4WAQHEBOUBZiVwQ1pFywfxPA317fA>
    <xmx:-Ug-ZvCbygHQzrHhaDk6MGmbyrzrI2z0lFzj033_7yn6V1ExGVDQBg>
    <xmx:-Ug-ZoKhhC0_0zSzmE8YrfO8U6p2CDhfItAno0en3ZbXeXCj4g1aPw>
    <xmx:-Ug-ZuAhCZ3R0tpW1yc_YpIc5PFTb2X9JbHx17skdpub7whhVeKsIg>
    <xmx:-Ug-ZmP12jlVKnwkRrfRs7vPMDEGiYylf-k8ERnTRZ8Uyke-i2m7gyLL>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 May 2024 12:19:04 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 20b7968a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 10 May 2024 16:18:49 +0000 (UTC)
Date: Fri, 10 May 2024 18:19:00 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Justin Tobler <jltobler@gmail.com>
Subject: Re: What's cooking in git.git (May 2024, #04; Thu, 9)
Message-ID: <Zj5I9J-l24Pk-10q@framework>
References: <xmqqfruqsjb6.fsf@gitster.g>
 <Zj3SsbHLp-gH_Jey@tanuki>
 <xmqq5xvl7k97.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="l9FfbspKoAVPWk9c"
Content-Disposition: inline
In-Reply-To: <xmqq5xvl7k97.fsf@gitster.g>


--l9FfbspKoAVPWk9c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 10, 2024 at 08:35:16AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > Just in case you missed it, there was a review by Justin already [1].
>=20
> "I read it and have no comments" is somewhere between "an invitation
> to miss" and "it does not highlight anything, either positive or
> negative.  Was the topic that uninteresting and uninspiring without
> anything noteworthy?".

I figured that this might've been it.

> There were mentions of a new document for reviewers, similar to
> SubmittingPatches is for contributors, and it would make a good
> section to document recommended ways for reviewers to demonstrate
> that they understand (1) the area, (2) the goal of the patches, and
> (3) the implementation presented, better.

Right, that's good feedback indeed. Ask questions, reexplain what
happens with your own words to both double check your understanding and
demonstrate it to others, ask for alternative ways to implement
something. These are all ways to ACK a patch series that otherwise looks
good to you already.

Thanks!

Patrick

--l9FfbspKoAVPWk9c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY+SPMACgkQVbJhu7ck
PpRp+Q//S6dPRb7/ou/fY+mdm1wBtpurf+e8gRxsuJ138z6RiL+2l8EROoShGSvY
0y4V4Y1AtpMJg3/QwTN1DJRVoe9a41phuwhG/+SEGcPbZF5cTvm9Nimbf+WtWInr
2knYfkz2RgEt04wpe+OHNGYDpDQrt+0kKvJfEcl70eRPqcV/PlFoHpcEfCmn45du
23PuENE25EgUqETVM+KXiK57MkoaHHmIPHfGsTC8uFS7E0H09BjY2D1Za3+iIeEI
wOyKSi58vz5VtOC7GSDW5acyOqaLNMAme613fVJx9vACARHm+0ir3pHwhVXtTpCf
bf08M62T0YoewU5iui/XsQr/jkigB7WWJ/85k4O3FxsfHWDzyG938J6GtPyoHFzE
4TYppxZaagQpDcoxX59/QaTsleJgHGxggFP1H5lxqjyhhNq9Jf+qua8iTNpoy/ZY
+8wUYjMMrHz6MSj8sxBSiCncVR4S1y9AijMYYRg4IhEttwWTbudaTIuYHSTuw8yi
nfc2iAAkQzgsx1+RchWtWWfSDKkSSVJlgnXisj1WQfIu2/Y3waZwtdQA2gBbyTyk
zSNc3mXKUcRdE0GtsCDlNbIwWxUjWsRZFTTID93bhJqNwfKqZWwwkCsqzWC2BHJh
Hz1elyKd/UzJWI2WPJ/pgr4s50vb4Cc+zhltntXkFZWgQldmdqg=
=tRe8
-----END PGP SIGNATURE-----

--l9FfbspKoAVPWk9c--
