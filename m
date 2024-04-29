Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 269FE1118D
	for <git@vger.kernel.org>; Mon, 29 Apr 2024 09:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714382927; cv=none; b=lKcnAhxQVf00V0Ie2SzEY5hBSw+MXJCUr+HHTGwa1yeODGKaX5h9MvJLInSsCM/+LijRuqCzTgMcMIzB0xtPyDBcFtQYhkEzzh0Y0gDzxXxqEHcaRPn/tug2f3Rkldvy45SkLIqmmCdbMvwqugTj08GNGvB9sOKbMRvh82OWB7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714382927; c=relaxed/simple;
	bh=nsITg+K5V0BFQtMqFSkjkRvr3jC+Pvgd4GdY9/aqjmE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cGmuq0PGY1typkk1A2qJrHDrqH+tKKvYriFdDL2Nuu5L7qJf3hBb9PHBovFgTaVnWLKrwBlWY25yxrY+8Aurnqr5qMcgSN0sBZ7oKk53gVbjHLMVV5nx9gNgdqFy6ta2EoQaj9CyZ5A0qffBwk8FNTFyNDo6l18pYCN6vrvY4mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=nRobz9+l; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VxkfvyCH; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nRobz9+l";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VxkfvyCH"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.nyi.internal (Postfix) with ESMTP id F29AC138177A;
	Mon, 29 Apr 2024 05:28:43 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Mon, 29 Apr 2024 05:28:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1714382923; x=1714469323; bh=4mKu/Zie99
	PFJNEtQoY0Rdu2R3daH7G7SqHEQQMMIH4=; b=nRobz9+lP/DSOqc0oBrh1iJQ6Q
	ksqY/FZgwLtg8hXefKrizVouB2SiJ8dXbdm752Ung9u5QB/K07CDw8tVDHKW/XyF
	IxTZ8tg3cdC/v1sgpBvuT84++ednlokt+nkD1BRRgRTmrV1qx4CLvnpFfXMJi+vz
	zVURsJVVZm/EI3zaB/+hodb6udZOnk5GNyfsy4CD/Wl3Uk6qDzFYpyTLdaw/VnTg
	uMuKM7m6NL24Jd+DllBdb2DVY251I/rZLy4J5K0pF2m5lt2I0IHD3K8QDejMuq0K
	fMpXUNvqfDZ+MHk4/gw7lAXmtyjqP7WH6ncdoyBPzkFJuo9CXBp/Xva+GpVw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714382923; x=1714469323; bh=4mKu/Zie99PFJNEtQoY0Rdu2R3da
	H7G7SqHEQQMMIH4=; b=VxkfvyCHt10LzMQ7djQgas7ijIXTqpeE6liHPE+SlRe7
	oazmKqX96B6MKNbeJe8GHTLJtmRojYIuyr8u6OAAhiq4a+CcorE6FsuH940Hv77z
	GL5dSxrP9DqSAqRSaOaECb9SF8wo0IYLVnHm3f2rkknQBXmd/LfROEPO2W67cetJ
	mKUJxSJxXabBVpp7Tzj9Tm7E/gKAr1XoBr99Ip1XMPlAGAD1mV5EG4z7NE7VYH9Q
	5PikZaInYa/akUT4N+xuLO9kRWFzJHlBYtIIUCaHWhpVKhcSzpsZOo2mW9k/5b4r
	nXfw4vnizZvq8NboKwDZd0RSyZV2N8PgvXVs/6OcNw==
X-ME-Sender: <xms:S2gvZi44nPkiivhGgmVOzB8zHnLe2AuBq0pum5_gdUAFMiPwaioa0A>
    <xme:S2gvZr5bW5jR98Bc2HE1RrPuBsVbOmX8A867E017TbKXmbH1OiaNMxtPDl6nmAiCS
    aMdM8TKrRDkhPfJWg>
X-ME-Received: <xmr:S2gvZhcc20G2Sy8N7sTjaPotYIMdm0O58IJBa6VE5umKZXjYq2TZnfHZ651qUG2g-97QTalAGQfN_sN8GiqI3FhLLtBHHW8I2YCi2u66eb_ZPZJx>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdduuddgudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeiveektdfggfeluefgvdelvdeftdfhge
    eugeefveejleeufeekgeefffehgfelgfenucffohhmrghinhepkhgvrhhnvghlrdhorhhg
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:S2gvZvILnwFDzn-JMxRFa0gNvGrSKklIsqiZLruvromiW2Bj58y4-g>
    <xmx:S2gvZmJGz7AnyIb7HGmX6wworkSItS_WVeNOA499408S6_i7kXXNrA>
    <xmx:S2gvZgygu-Dv85-a9NnqUQmaW3Q3Kmhck9GtEyhTNPk--XZPphwKWA>
    <xmx:S2gvZqJ-W6cYsgcgFDGEBILPysVAt2eS2EaDPS5Zrav5OqO-6ZwALw>
    <xmx:S2gvZtX9Y07vvuLfqsEaVUX24FsAlT427-malem8ERkyoT5C2RvKFzaL>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Apr 2024 05:28:42 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id df63a8b8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 29 Apr 2024 09:28:20 +0000 (UTC)
Date: Mon, 29 Apr 2024 11:28:38 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/8] tightening ref handling outside of refs/
Message-ID: <Zi9oRuknlhfG1-WX@tanuki>
References: <20240429081512.GA4130242@coredump.intra.peff.net>
 <20240429084238.GA242085@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Hiegqv/ZSlpUe3Ul"
Content-Disposition: inline
In-Reply-To: <20240429084238.GA242085@coredump.intra.peff.net>


--Hiegqv/ZSlpUe3Ul
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 29, 2024 at 04:42:38AM -0400, Jeff King wrote:
> On Mon, Apr 29, 2024 at 04:15:13AM -0400, Jeff King wrote:
>=20
> >   [1/8]: t0600: don't create ref outside of refs/
> >   [2/8]: t5619: use fully qualified refname for branch
>=20
> You can probably guess that I found these test cleanups only after
> writing the rest of the series and seeing them fail. :)
>=20
> It turns out there is one more spot that is run only with reftables (so
> CI caught it, but my local testing did not):

Yeah, that's an issue by itself in my opinion. It's ultimately the
reason why I change this to always run the backend-specific tests in
[1].

> diff --git a/t/t0610-reftable-basics.sh b/t/t0610-reftable-basics.sh
> index 178791e086..c6dbd2b5c4 100755
> --- a/t/t0610-reftable-basics.sh
> +++ b/t/t0610-reftable-basics.sh
> @@ -343,11 +343,11 @@ test_expect_success 'ref transaction: env var disab=
les compaction' '
>  	for i in $(test_seq $iterations)
>  	do
>  		GIT_TEST_REFTABLE_AUTOCOMPACTION=3Dfalse \
> -		git -C repo update-ref branch-$i HEAD || return 1
> +		git -C repo update-ref refs/heads/branch-$i HEAD || return 1
>  	done &&
>  	test_line_count =3D $expected repo/.git/reftable/tables.list &&
> =20
> -	git -C repo update-ref foo HEAD &&
> +	git -C repo update-ref refs/heads/foo HEAD &&
>  	test_line_count -lt $expected repo/.git/reftable/tables.list
>  '
> =20
> I'll wait for comments before re-rolling, but I'll make sure that gets
> added in.

The fix looks reasonable.

Patrick

[1]: https://lore.kernel.org/git/acf0c285506fe7ba275b08cdaf6b2245ec66b565.1=
712896869.git.ps@pks.im/

--Hiegqv/ZSlpUe3Ul
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYvaEUACgkQVbJhu7ck
PpQkRw/9HgKZe+6VC4gcPtncy1DnqRVu8c+4/eTUYc3mivMdkjN9DZp7N5iv5EPG
oVnziYFw4m+3B26WZ4vjTfuq/go1vmfrEtTWSHdDcERT4HH276r+1ZfrOF5pTFav
Gcr9MOhRrtFFmMRwuaLgK6jquD3MZrAjAoxs4cMYIj2R8qV9F5aYnQwx6Vs2B5LA
IQ7C7HLsT7NrsuboKEnkJHhFgVL7VQssb29ZsesHQ8aiuKvNYtP1HpCQVSKURElv
ZMuhAyVAo3HZMH0cLzptC2icSDWL3ApDRf1GWOZ9ZKwOA/qoSBwFdIMdQW7ksAdi
ThWFCb7nX1lCbDftVvXmxopFloUUJ63xF9gQjgew22NvnCeSDTvoDSJAr6CQVUWr
T7X+82oRWJW7NzZUT7zG3Qx2dv4oU+2lOt/okpi9vBEO4y6UuDgZ9iEHEaGgKTLH
k9chs/PrgvwMbtIOBFum+hXJ0nAu+fZZoPZsp0wLmuB2KHLobbh/foAGWgaGm2ls
e+c3PpF1mGLqQ+0jccCFg8lQQ5w1FT+hk1k/yz8ZGMozk7kLQZxQ50LSjrmcdkxH
Gca+2T1OXjzwOw9433j2SLPo4BQ3lwfXyNnRBqVBOSaAXDt6dqa+lecMefbkMo4S
XCwWGfW7VzCZSe9ys6ocEE5x1ud6olNOW17b++my3srOp3ctBcU=
=klzB
-----END PGP SIGNATURE-----

--Hiegqv/ZSlpUe3Ul--
