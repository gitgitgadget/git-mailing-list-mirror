Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA23013DBA0
	for <git@vger.kernel.org>; Wed, 24 Apr 2024 08:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713945728; cv=none; b=UfVWrW8+ZNG8DuxkMTSsLjOSxNoFLpOzXikorxuERGKeYIaYCQwx9eCIluav75keMshinZ2YuRi8wW22hqvIRD07mr4g0OdEU6e3uMY8uWrfE5jMg7ZtTcUuVnIFMerYzHwW1sQakGrokdmOpRyktmMSAWdMvJ+ZMD6BoxyyrB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713945728; c=relaxed/simple;
	bh=NUGLghrrvqrl9sFGFZ4Ot4MHMeXI/6XZEQdprwQIjmk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XwUKLDV58NO/9lx4baDELNlT7c4PbityOBgmbAJLicZAoh3zY8At4b4cPZUBY92N+Il1BT7wp8SCPtWNc4+fxw5Iou91/HtwPcvZfr10KK4exVNR/yeMeRw3SrSbYp0p/TOzu60c6VkkkLKNMMSTT20x6lSxBn0AyXzzMehJ24A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=SrONmTKE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eA71Ts1c; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="SrONmTKE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eA71Ts1c"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id C93351380154;
	Wed, 24 Apr 2024 04:02:01 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 24 Apr 2024 04:02:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1713945721; x=1714032121; bh=d0ZXeuxXvF
	rdfVqposICQOnNtRG+fxV4+UndQKQ3o34=; b=SrONmTKEUmrGbXrNs2wCX3Eb5M
	YpL7pcNXflvBFQm+mBJTXmUbIGOWI31JS3vklFdR0rPUNSScH6KfPwe8dJUxhiGx
	9NpiW81XcZa43I+uEOgcJe68lT7YtJyMo/Ty8ctT93Lkef3HxbtHihsuSCrJnA7/
	UUZ/lsPUfrYbpiRbAQlOvOp9R2W+RhWeds1CZzwjCLSD8x5T13KC2/4CmtcBQx0w
	4CERHoefh7Afteq0BKNnbYGwmSmznraudjihgwpjUWTTEMZVrUnwzX5l6IOWsQhI
	ECPNL15Kf00zhrm3nR5s9B/8YJA5G5J3y6G70gI/BCr/3Xrf0SSGc2vbZj6A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1713945721; x=1714032121; bh=d0ZXeuxXvFrdfVqposICQOnNtRG+
	fxV4+UndQKQ3o34=; b=eA71Ts1c73ORRMhEFRaGQccvYQgOa26tcVdVFnbiR4ch
	zEPRXPeGZGlUgT1pWjkB9sY+ihyjA/W25vIxAl6Wzh7kzvBslFa3lbHCPlt9oIsd
	dSl22LQTyYwa5YlAFEY0mPZjA2xMu+afBW9PvhmEOaWGslZzJ6EAiFxitWvhUG1h
	aVUhzmoP1kkEGnCusIdshOd30ijZa+YkWlMukLmz0lTC0u0r7ydI6QX+7pNIQPvi
	GqGxVelxm/3X1hhWVhO829qlNx+DtUSPSSjvwi+qwzSVLhXcPeobVvFq14hoKise
	gXMT2eObMHKte1ZSKjWjOL8VvBStx+xisispVfPlRg==
X-ME-Sender: <xms:ebwoZk-BSbtt7OIGPaJePjUl6PlQ84cgbOTih8ShB_bVaJ1kHvGnNQ>
    <xme:ebwoZsskQ8cQzt-wb8vu9A51g3z_AlgnL3mBGaWbeW534LB-B0YBVT60WOxYF2BGG
    V-bvzdRGNOC6B8YmQ>
X-ME-Received: <xmr:ebwoZqBkKRedXjQEFk-2sYGwPjc4tOou70XPZBLg3SIj4_JjOTf2UsG08pKr_PmtMeP8er89dWyQHXxXp7f7BdQzgqn7fnjOM_IlUd6YR6D-C2iUiA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudelvddguddvvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesgh
    dtreertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhs
    sehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeige
    ekleduvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:ebwoZkcEa9WDGnXybwTHwjAwe_JXGn8EC1zkEK6RhfZLN8cAZrv2Wg>
    <xmx:ebwoZpNgIMSoDeCaP-sznfe5Uc7Zhwb6OcH5S1ZPQUkzGa10h3K5iw>
    <xmx:ebwoZunM95oeFrCNO1KCcWQ_Ny6ZtuNsICvf_m_LMJqaT4f-nspSsA>
    <xmx:ebwoZrsmBQWwJ-UNym0R5rEiWhLrJH7-wWAMapdJhbhzKCBRDhbn4A>
    <xmx:ebwoZqqGixxN9_olVcSXYTy0U8e_nGy-5w1uDHxDPsvuOLOvsBzDeXrp>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Apr 2024 04:02:00 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 9be0ac32 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 24 Apr 2024 08:01:49 +0000 (UTC)
Date: Wed, 24 Apr 2024 10:01:55 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Teng Long <dyroneteng@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v2 7/7] builtin/reflog: introduce subcommand to list
 reflogs
Message-ID: <Zii8cxOxM-Ggwtu7@tanuki>
References: <d7b9cff4c360147e65df17316533fba0b4f2ab7d.1708418805.git.ps@pks.im>
 <20240424073047.53755-1-tenglong.tl@alibaba-inc.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="QuLmNCHQWQXzcBv6"
Content-Disposition: inline
In-Reply-To: <20240424073047.53755-1-tenglong.tl@alibaba-inc.com>


--QuLmNCHQWQXzcBv6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2024 at 03:30:47PM +0800, Teng Long wrote:
> Patrick Steinhardt <ps@pks.im> wrote:
>=20
> +#define BUILTIN_REFLOG_LIST_USAGE \
> +	N_("git reflog list")
>=20
> Doesn't seem to need a translation here?

I was following the precedent of the other subcommands, which all mark
their usage as needing translation. Whether that is ultimately warranted
I can't really tell. In any case, if we decide that it's not we should
also drop the marker for all the other usages.

Patrick

--QuLmNCHQWQXzcBv6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYovHMACgkQVbJhu7ck
PpTd3g//To4znCJJvWPVPBv3ATHaHABu1xEVrKY8L0rusxqyGTIXQkpRCU8DEAlr
+sJxFBS2dLIz5sp3lNWz+81NCpf/8m2ldZmZoenxdGOOu5NW5nTqueQgTrY36p0n
zPp3efX7V/9lCbHREXLqme+Kcj3IOGew0FA66l1RisRli8NzQyF4agxtbA1q+KDK
+sqI63op6mcGQ4kovaavPQ4X07yMCKzy8tN6xNPXb3O1eW3xno8W216dBCAgqw/v
0MLLQjzSreVJpirxmdJKhwuK5p/32xwynh0gwHvIY2ibEjoX6hNF+RwajwEgm/Mx
mtALdwUaqbPNCxZHLnmk9CfnqN1ZK2eE3ipCwh0fPnkE9UI12Ov5GxojlDpHgKfd
CZhiCNzU+nTEiUJQgxxLDxJAucSQEfOkXD0jg77cR3qipPVVWID+hw2olvEsQhs3
soYNwcq13mzkDDyz1rWDimc0p1MdB2GhbsLNzZvnN8ly7bobQpp7UkD83X5tgK6B
9HWYwPhfOYLQUIrdp2AsFtCp9m7LfSMN0UlwrikB6tuUBv+I9VA718B8vgFdkpVD
wM3H8zZKeP+tb5JNvxlrmjVQtbWZ9kkYCOr7D8k3+2IpQ8kkh6r/O1b5y3XVEH9Z
vO5zT6+nmngt2gPHRyWqUk3PWmhVdF3s4h53XnQmGPO4AQJfHr8=
=K7CR
-----END PGP SIGNATURE-----

--QuLmNCHQWQXzcBv6--
