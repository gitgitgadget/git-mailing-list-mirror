Received: from wfout7-smtp.messagingengine.com (wfout7-smtp.messagingengine.com [64.147.123.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307C813774D
	for <git@vger.kernel.org>; Thu, 13 Jun 2024 06:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718259280; cv=none; b=htT7HzAP8KK6l9dZgRvai99moen2QHgsM0nRUldGfM1H3utO1kOJUDSGmRB9j7OYA6evBSnzIoE7hMSg716PXHCwX+/sFxMAE33KFa3s1Km/SqTg4yijSLVDJKueXbJj0Y/BY6dEKaHMHzTd2h493IrxwoEj69PWascBZfCtmAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718259280; c=relaxed/simple;
	bh=IBcmFi5VJ2ghnL5mOzKzGvbbzCyAc0IkA/0DAuXsTxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vw0zeiUm8z7rBF+8JzFuCeRyv7brTMzg8Ayma6jp8S8QpvKIuehHB3SEmaWfWSzxzM6tTqC2P4ljaBbOBuh6EpXYKHl+iip4TFw2zBCywmXWN05M0a8VTfpuffaILbSELDqsmLwWRtG3XDS1ZFXD7zmZKeyx4xUsThPncFl9kX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KqYyABwe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=btGIYhmR; arc=none smtp.client-ip=64.147.123.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KqYyABwe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="btGIYhmR"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.west.internal (Postfix) with ESMTP id 537B91C000A6;
	Thu, 13 Jun 2024 02:14:38 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 13 Jun 2024 02:14:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1718259277; x=1718345677; bh=GulEfDp2uH
	FPnCOXRb+o+mQFUzfzQsWoAPinEwl6+XY=; b=KqYyABwexB2O6iNKgzEDz9DWts
	6r6eZXJ4CBU/jcZfdPfJADyYcZvboYrdyHhFB7O31p6tLL0QeNgg7qUGsmrhL3qR
	hRIG8NQlqJa3TOn7tnjlAlUQkCmtwbni11zkv4hYIsuI6Uwff0D8pLg3esgoArmL
	n+ulFT2KgoL15onV6ApAUwdhigiTG5MURrz2MvWXMVDDVRPLuoUF+TBlzmEitWP0
	d0pJ218mtxMWEnmiuP1O+7FD5ruEujSfAgH3oR29TYF14bSQ+kf7OW7PjkwltirA
	E9XwQ3CCWacnZw8IBEkSKE/fud7fAUmJAmzMS8YojekHTy0hBtEYoS/halKA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1718259277; x=1718345677; bh=GulEfDp2uHFPnCOXRb+o+mQFUzfz
	QsWoAPinEwl6+XY=; b=btGIYhmRfdv29YfDCc1CdqzU9w7/XL/W8Xa7wcV9ZX35
	M0RJWO4SnZbAUZslQOzTYof2jyb7mIZxYNRAEJNQo4/SkECBKFUclM2D0+/cXEM+
	ZPBS+6GgdzDspRM02jQL0wPtAZWp3uadTRpx9bkq6BFlFnbf+0tZg20fKqMVr0T5
	PsXA3eFCnwd0iiun4QhQEFYttlMu8BCv30WZ8vf9e9V4I8c5vqbRuZIZaRjdn5fY
	N/stQdcjx1MPPDzkuh2tiFBf25sxvF3/GKaUO5Ti4oTpz7Lmm8Q090cSIc4suQyV
	Yf2bzWYrSdJ6YRDU+cbbFvVPXX81vEVsoklm9Ii/+w==
X-ME-Sender: <xms:TY5qZpS0Gw0adhyBFOvQSUXEjvEkUEOHMhmaWu1artbdwml8MgSVtg>
    <xme:TY5qZiz3bpFGOBZFaQv2P4UoSop78cb1GlVMY0ekiQxk842hGc9JmMEOz8XimvDkT
    5RIK29xr6XmaxsTug>
X-ME-Received: <xmr:TY5qZu0dQZoZwXr_MPzh1zFDHHNRoG_yBbZMAvkd9AjlGCiO6T7PwrOsTkt_n4lP6vYF7qAdVXgMVClS_WuSw8DBSMH9CcBu6gNSd-IXP1c1bubxOwU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeduiedgjeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepfeenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:TY5qZhAY_I_vSUM2Y7kQB1k66fK87FVYGMhtaleW3ugh5cjI6EnkDA>
    <xmx:TY5qZihj-BYRga3UG25CxVA2yXAecoxYElaoZWyXq-9qsO5bJifmsw>
    <xmx:TY5qZlrEnorjI6adDALOfymnAdUq0CSSIMSqhoYjkjIdpl9hvMbw6Q>
    <xmx:TY5qZtgHmCsY8fugyuMPbpeh8r3m_cO211AvtTv7FeG97yhmEqb0gw>
    <xmx:TY5qZjubFafU8uawQtp-Uf6BMf9T4lDruD9EUcQlmPXumQOxsRuY8YkR>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Jun 2024 02:14:36 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 37d4a98f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 13 Jun 2024 06:14:23 +0000 (UTC)
Date: Thu, 13 Jun 2024 08:14:34 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Ghanshyam Thakkar <shyamthakkar001@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v2 15/20] replace-object: use hash algorithm from passed-in
 repository
Message-ID: <9ae4fdb8f1cd7dee969a6f813289d100a003c099.1718259125.git.ps@pks.im>
References: <cover.1718106284.git.ps@pks.im>
 <cover.1718259125.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pukPfmCSZdJvgLmv"
Content-Disposition: inline
In-Reply-To: <cover.1718259125.git.ps@pks.im>


--pukPfmCSZdJvgLmv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In `register_replace_ref()`, we pass in a repository but then use
`get_oid_hex()` to parse passed-in object IDs, which implicitly uses
`the_repository`. Fix this by using the hash algorithm from the
passed-in repository instead.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 replace-object.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/replace-object.c b/replace-object.c
index 73f5acbcd9..59252d565e 100644
--- a/replace-object.c
+++ b/replace-object.c
@@ -20,7 +20,7 @@ static int register_replace_ref(const char *refname,
 	const char *hash =3D slash ? slash + 1 : refname;
 	struct replace_object *repl_obj =3D xmalloc(sizeof(*repl_obj));
=20
-	if (get_oid_hex(hash, &repl_obj->original.oid)) {
+	if (get_oid_hex_algop(hash, &repl_obj->original.oid, r->hash_algo)) {
 		free(repl_obj);
 		warning(_("bad replace ref name: %s"), refname);
 		return 0;
--=20
2.45.2.457.g8d94cfb545.dirty


--pukPfmCSZdJvgLmv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZqjkkACgkQVbJhu7ck
PpRbag/9GCnKKAuHmjqCb3ZmFZ2fCNQSrF8m6WfKmyc6UpJC5ZZmFp3QWQ1rMlOH
+nNy3RIs3O0YcXruYZxUGHMImkyAzQbyGC8fTD28Z6FcBd7xh5cjwygejWS0D6Cj
mKYRdDwhmZTGrbazbQ49L4iJL08B/2uw3DPxfvdXS7+0oVZXCVieZWfYvrMl9L2J
3AnrHLii+PhldX9eB+ybnEluiwf6J2yPRqooLiRE1uCppiIhCLy2QiISvju/t54N
MSJFOKolcBsq82g7kJQJZC7vXsuAvdnvn9UnXnt6dIQl5/Gw9gNqK7wj1/+dsTj3
tHu0R6SUPsFsfkZ84uSiXci4Wk2g92vasbp+LrHxuzcG306u986kYhX/Cj0PLsKq
NtW4qEbpY0zD435yr4zVYSVAH97jKghsEKVFXpoh/8hNYVthn/DSzrRtxIVSMuh3
7O/Z1H0Xrgbfrzh8Zi2mS7eUTIp/l/iPM/yVcgiJrExuZ3ON4np36LL2rsUQIP8C
H5IyrHTd8HBlho45xkMRz/4rLKyjb4l4+ZxOSAO1fIHW68uYovzDzJKU6YFZWGxU
eWy8HaQwCogY0St5rFpOFjhaQhKMbNyi8tLXqTw4mCqAL6AyteT6L2i6R22gA8/9
H/pQBG2thGY7hnFpl/qXWPmtcS/wsdJNKo0bvB9wU3FScoCV1x0=
=P6Ee
-----END PGP SIGNATURE-----

--pukPfmCSZdJvgLmv--
