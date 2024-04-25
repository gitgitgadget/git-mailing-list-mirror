Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137C15A0F9
	for <git@vger.kernel.org>; Thu, 25 Apr 2024 06:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714027009; cv=none; b=fkeveAMkDrC45dOK+zv/loUc27S2J6brUZoZN3Eg0f/4tytCbWdBWoQnivLj8dRkTI8Dz2++MU3Lu9sbWIpDcBE22+QOta7l0QVTpbl1Qc6FOHNF4Ew6o8/iKZNRDju+USNb9CpLtQMiQrJ/brjSdnln+4OFAix0/g7K8On0HYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714027009; c=relaxed/simple;
	bh=+gFcFJywc0MKfRIo2Cvi5XEbBHcuNvX/8E5VMyEQeZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fj+sFLpOIkdDScoLf2XIPFXZ4WSKtYSdtrj3aTjlzM7Mtl6rw7s2v9TSTlUPY/wjDiN+0NsFKL4Lmz8UVL6pVtdtFBinbHDSc8hSTRCMBO2iDxCAfxjmXwhYr7QsHg4DRw6DAmneeBwl1BpfJ7nXMtShx7IVmrHLrnpI3U2B1ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=klbXRdJW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fvx8JyZ0; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="klbXRdJW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fvx8JyZ0"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id E289F1380071;
	Thu, 25 Apr 2024 02:36:45 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 25 Apr 2024 02:36:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1714027005; x=1714113405; bh=lccWbdgPLp
	SCFC8l2PKo9J0sDHhA4wzq/yikweorv+M=; b=klbXRdJWIJ08HhD7HhYwzZhOrq
	Ff7SdeSlkgsNqjy7NacIVLoxEjLTlHm79U1CAPiGEVGeZxnCHB5jR86eV9uQnUvS
	oWqJnpHfImwyB3CbCNZ2lBmucQfip9w0GKx/Dig2tTtvVxIzJxUGzAjzJfPZpyj5
	+kFl5wfLb1J7Ti824ZGz46j2zdWvkoXCPViEJQwJAdTVW/0hqeY1hBerbBhLD6c6
	EqONY/D/2FT9HGoADUXvbG8YHk6y31PhTy5iqzL+g9NOTVmLx2sDt0aQ8YL+Yzk4
	GuKMyw1EeFgsHsQAOp5SCYeNVHlQmk/ExpSbTq/tR0hPnwHXZM3Ma3mUuUPQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714027005; x=1714113405; bh=lccWbdgPLpSCFC8l2PKo9J0sDHhA
	4wzq/yikweorv+M=; b=fvx8JyZ0sqamsVqd90TqSM56XH+mDr8of8+81WkZhEjp
	OvKqrGmnF+ko8QzAq1PoAzvtxJ7IRv/6nMC41gfbE5sXO9KC9Ia+yxW6VrTJX7EY
	MoeZWtkYUjUmTn5tgzDPKrXTTpTDufT37pZYfUakrkoEbeAWndDmBhiwTYgTkgci
	0wOKygB59mTsbodU/TfSw9i62nil0Pq+fdR6CkNrvj0NAr5k8mznCWdqYJkTYwhV
	KRVaWe6NyqBoleS4mrtMJNF9JzfwF22yUlrczIEZ5s3BXWXdPu+2KWyUaEYX3TOa
	ToT0tM717gAWzTq21jxxqb6+kCDBD60hMORssEg1YQ==
X-ME-Sender: <xms:_fkpZjcBn2zeytyBoXenixknGYUeG99Yr8Te-DRucAUXF6mG0pg06Q>
    <xme:_fkpZpMKdTPNGDDDrhHHcZgCUinczU6Iv72CVrODxhUdnSv_6bWmC8kNk40NvblpG
    rvuh7VnYrEBxQrmxw>
X-ME-Received: <xmr:_fkpZsjqOUG1FBCjpFgEUeWbNgP5j-ZQ5T0Xw368FF8r0OFv4NYpz3Wv9yz9Uzpm-BkIElIyw_CYvP7lMGIDRpCOX1NGNvKs3yohCgBnwHvXHXM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeliedguddufecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeljeetffevheeggeetkeetieduieeiieegieegtdffheegkefhjeehfeekhfev
    leenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:_fkpZk8T3POoVBXJdA5hcnUmtIwc34PpmB5d-luYGI2qxKp36J38Gw>
    <xmx:_fkpZvv2JBn8j_CS5Nr8a7vEvZzfmY34ziJQmCaeRGLTi7y3cSDgBQ>
    <xmx:_fkpZjFH7cTwshiKsSm9kzRjYc5UkLz7xLRXsJi6JdzoOyvaGEx05w>
    <xmx:_fkpZmPnxpiG8I-u1yZoPMoBwKTdeYZngKYVDkH6CIrtVRiyuIF4uw>
    <xmx:_fkpZlVTr_fFsJpJPGlbrI_6acXfYoLfEe1aL6R7fhPT4QQ5MeqpbBui>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Apr 2024 02:36:44 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 11099475 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 25 Apr 2024 06:36:31 +0000 (UTC)
Date: Thu, 25 Apr 2024 08:36:39 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v3 0/2] Use a "best effort" strategy in scheduled
 maintenance
Message-ID: <Zin59zAZQyLg0iXR@tanuki>
References: <pull.1719.v2.git.1713444783.gitgitgadget@gmail.com>
 <pull.1719.v3.git.1713975299.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rNcEUZoj0pOL5XtL"
Content-Disposition: inline
In-Reply-To: <pull.1719.v3.git.1713975299.gitgitgadget@gmail.com>


--rNcEUZoj0pOL5XtL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2024 at 04:14:57PM +0000, Johannes Schindelin via GitGitGad=
get wrote:
> Over in https://github.com/microsoft/git/issues/623, it was pointed out t=
hat
> scheduled maintenance will error out when it encounters a missing
> repository. The scheduled maintenance should exit with an error, all righ=
t,
> but what about the remaining repositories for which maintenance was
> scheduled, and that may not be missing?
>=20
> This patch series addresses this by introducing a new for-each-repo option
> and then using it in the command that is run via scheduled maintenance.
>=20
> Changes since v2 (thanks Patrick, Jeff and Junio):
>=20
>  * When not passing the new --keep-going option, the exit code is the same
>    as before.
>  * Clarified in the documentation of the --keep-going option that it is 0
>    for success, 1 for failure, no matter the exact exit code of the faili=
ng
>    command invocation(s).
>=20
> Changes since v1 (thanks Eric!):
>=20
>  * Changed the option's documentation to reflect the current state (inste=
ad
>    of the original design)
>  * Fixed grammar issues

Thanks, this version looks good to me!

Patrick

--rNcEUZoj0pOL5XtL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYp+fYACgkQVbJhu7ck
PpRA8Q//fp0PvTDzd9DaTUxOjYnYvyNyR++0Q/PeIzdIcNNRQcjjGA5qVtLpJJbv
2lDcR1YZnV3d0La9730JELK/4kB/59MK8iwmHQuNNHogOO62BkSzolUJm5dlL+IH
VmmB4WX3ygAwCgxLRNuU67QkL2wnqNxoKvN7siU4jIPWopJ4Qjps07NAH1eEyHzg
EUP9UKx99o7ItZtz8MR0k/DLlzAXb+pS/5sQDCiEKljxI6YD9fCcOgDNPPAplpyo
vNegbKPJnvZfOPqyW1EaW89eLZP3dOehh3Angvz3K1tJBPePMAw5FIbVObvsp+nb
UrlA6McRabQRh+yIPx1YACqlB0lJ9CbR0fJBdHYXYb7N1rrmjR0v8ztuGJ3TvEVl
X7pyWN2JF55jAI2eRTIolQEpGbEvc1uZjCPdinMwp//6QAz5f0DzmI+vDVAHT7y+
/RerOlK0Mq4QYRqYO3mI/7LzBsn5I5NOc3GJ6YnOsbqlY+YjywwPVGoZWWKg9gS7
CJn1M5T8EC4TlRCMZyUTUnLxADU0TAbRHQoCkSzm74M2HQ07/Zoig+zimVFggt+/
G8ajLTYM7FrIFTdS43bdYpixZyp6jk/mZ+OBKug6cJw9kqzYM3oo2peovrWYhPXa
vwFhvzqBy4CFGJ43ooKV7i/wuYjm6oRRHCI5PLJvOkwtT3wRMYw=
=WUdc
-----END PGP SIGNATURE-----

--rNcEUZoj0pOL5XtL--
