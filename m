Received: from wfhigh8-smtp.messagingengine.com (wfhigh8-smtp.messagingengine.com [64.147.123.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A582F84A3B
	for <git@vger.kernel.org>; Thu, 21 Mar 2024 13:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711028924; cv=none; b=HNcyy+M5VBcpVSPfNIRrJcxp2QLaewgAdpW2TAY4gO7sI73XNghQ47h6iSWboIqdoWMP1C8c4OIFf8VjQFkxcDyusorSns4wVjbdLXl44PHeN9NaBPoE7ZJCF3R3Db9YIOluXCmyRT66zmiFSwYEwqc2WOgoJ5RgygK+/PHpCtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711028924; c=relaxed/simple;
	bh=9kR34oSZaseKBZMjxBLt767Nrwr7/6vWPjFUlTWe+WI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s4jaIJ5yWa19HqHpd2PyRboocMPDZjkXO75tIulxQ/rIg3Y7FtyPHpQCXf+/DycbZVMoBPv1MRgmAHqNCsDsHsRZag0U8G3QFPpydadRfObAUNOqy+sKlKrwOh9QKyndP47qAUawHKU2azlDrfs2DLtEIXRw3YsStlM+0JKMBv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=XXMN19z/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=r3rymds9; arc=none smtp.client-ip=64.147.123.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XXMN19z/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="r3rymds9"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.west.internal (Postfix) with ESMTP id 9C3CB18000CA;
	Thu, 21 Mar 2024 09:48:41 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 21 Mar 2024 09:48:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1711028921; x=1711115321; bh=9kR34oSZas
	eKBZMjxBLt767Nrwr7/6vWPjFUlTWe+WI=; b=XXMN19z/jEm/YJ0M0dwaVTABop
	mdZheN9Q+wmW6caXts7w+z2R1SOkJb7vUAbj+tyxOKigGlrOAThIGciAK16vmqsc
	3HHXpnWvGEuQu5+0//9FDcBU/xpiqO5XSYNdQYtc7tmPzXZo6gJqFzHStrIe7aOE
	47pBae8XsLKrJYtf9bo+bipt7hXxdK1MLKp27m2ikffYzFpjZqXMry5x9aYhvXDs
	658UQrC42S6Maa1rd8WFE5ToBuHI582hh5VsgM4fC+wPxn71Zojc0PWOmG5LcFOZ
	MeB58bQ6LWEncoJ9Go5NVgK7SeuCauPUPT9v/KSdLsBZiWhAs3kSPZf0uyMw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711028921; x=1711115321; bh=9kR34oSZaseKBZMjxBLt767Nrwr7
	/6vWPjFUlTWe+WI=; b=r3rymds9ddInDROWVUGwXUsEccAyBfLceNjxQtGxMf/R
	7PFLHBGDxpLJNGp1vdOD+xZbkGCthuVFUAW8P2AA+W69MWrzMgzACMn+5hbjwsHC
	D9NXvUlosTnmmPjovXfIvKAEUXf5+YVRHXqPmkb+EC8pkJxukTVuqYZzsQZdoZJq
	0/eFUDbpBAJjb5ckoySOzqszTV4B9ibfUGfCeWEprmsTxPsfFA1wVjkev/XIgZVz
	uoNK5A0NMlqcuOK7KofIy6jDuMa4skcXW8R4ybk8Ow/RTRcQ3wYYpcIMoRDJYXHU
	XjDgicwKMQmsu1sXjqz/V+DtQFwew/eVFIgxm3yzsQ==
X-ME-Sender: <xms:uDr8ZTPEB6KMgvtgbnmBHiGh-PZFep-9EcHAYQTyl0XurDbtR9ZRrA>
    <xme:uDr8Zd93jljOVv_BxnnFDv--C8bDfjn7qzim231Sf7Lfb1VuXz6ibFwVvFDuyPZGt
    CrfAWjLUf0k1bN9Eg>
X-ME-Received: <xmr:uDr8ZSS8T49tpTlXIDTdLEU-IVDj6l1sOTL9vS9lrZVpBOKWhedPGyymo8uT4l9HDTY-xYIVHNVfju-xLgqXGNQDCab7Ngd8rfwIve7QnGEIlQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrleeigdehiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepieevkedtgffgleeugfdvledvfedthfegue
    egfeevjeelueefkeegfeffhefglefgnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:uTr8ZXvfDpYA8Qw3rIsZL_3YZ9LdxKk1NF4at-YAxZFUUtNFDLK9UA>
    <xmx:uTr8ZbdtxSyLBnXkxDiaBV4XsuE8AP1VYXA72Cl_PV45ZTJUzjOR4Q>
    <xmx:uTr8ZT29PMhUiUwrHqDbAiC8GZIk-7lfNd8hpoh0oKzdwb9zlmujBA>
    <xmx:uTr8ZX_yuqCqqO2VzKoR9fxLcAuKbSe_Fi68vGuRLXdIyzsup8n8hQ>
    <xmx:uTr8ZS6yAhdecsJKqcpud7bPxqCIfHXi1cJO3ma-JmQh7Tkzw7L8DRZw0CE>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Mar 2024 09:48:40 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 056c28b5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 21 Mar 2024 13:48:35 +0000 (UTC)
Date: Thu, 21 Mar 2024 14:48:37 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] t7800: fix quoting of looped test bodies
Message-ID: <Zfw6tX-79WisvYsL@tanuki>
References: <cover.1711028473.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0iAOq0LOaZAMdzJC"
Content-Disposition: inline
In-Reply-To: <cover.1711028473.git.ps@pks.im>


--0iAOq0LOaZAMdzJC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 21, 2024 at 02:47:20PM +0100, Patrick Steinhardt wrote:
> Hi,
>=20
> SZEDER made me aware [1] of a quoting issue with some test refactorings
> in t7800 I recently introduced when refactoring the tests to run in a
> loop. This patch series fixes those issues and also adds a paragraph to
> "t/README" to document how this is supposed to be done properly.
>=20
> Thanks!
>=20
> Patrick
>=20
> [1]: https://lore.kernel.org/git/20240308221229.GA1908@szeder.dev/

I forgot to mention: this is built on top of
ps/difftool-dir-diff-exit-code at eb84c8b6ce (git-difftool--helper:
honor `--trust-exit-code` with `--dir-diff`, 2024-02-20).

Patrick

--0iAOq0LOaZAMdzJC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmX8OrQACgkQVbJhu7ck
PpSkXg/9H6+bzCKRLqxZsbLofEyKHyBZ7dYav0VciF+2mhdj63Gdnag9IaDOlW89
gAumvoFxTSIesWJS7rxVcqcHVyEZN7AKL4WFRbIWUA+b3x/a3cOBrIZI+sO945Ym
ANp+OgiaciHoi0opUMV+kBqeFKPJIlnuB3CKCbdolQGbLAU9EXJ2mgBRctjrV+dU
hHDbKHbLYU6lU3EACYeW0A1Twkk2BtUSuxbvLhbCpgk5TQYroKCTgY1oOYqFkzH0
zp0R1mbO7kAPXmtZxNNxgNeeGR7r6y7myXC+FlHDJr8DLJN264QWcjH8/Osnjk/9
OzzYiOSnD8oRbwAfqxINzb2CUjySK6k0TD4bprjJMGPVQq///Ma3DVqdauL28WDK
NMADhkR/dWPY1MG6wPADDXSkla8k/r6S/qDsMKbRlcIfdtHEq54IK83fU3Su1myh
7yGv8d69ynRMwvADxFtY3WbiKukMw4F7NSwTt6eJmXkhrCZe37tcV5CkDxXnfKZl
/WNdOHPqE278eBY6T4RCguzyOXnDxeQe8+HB+02WlWJIBFc3kipobA9Os5gGS85P
EX/BumThMp7JrzBlAl8edY0EokvaU7tHn3dS94paIgKBswzoFJc2li0ejG4KYBJY
Pyye1gckU1sk3GEaXs/pbV+0lP/r2dFdGvPhxqR+TCeYc4eVTDM=
=5K8j
-----END PGP SIGNATURE-----

--0iAOq0LOaZAMdzJC--
