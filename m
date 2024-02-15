Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F406129A9D
	for <git@vger.kernel.org>; Thu, 15 Feb 2024 11:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707996454; cv=none; b=jh4/6Eb12nWAD4fj3F2CRweypKj1HfDSlaOmHpmhQoR+4+BVWeCOzY0YxK/nwJibzNeP1ObwKX6dLsEnr/14LOBVIuAd/QEiwRbGGNH1LxplqzZsUGkqL1Z0UykofN/8jwljedM9kd16GKQRNkaUVGfqraTC4zXXKbuCOmwDsNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707996454; c=relaxed/simple;
	bh=B3uK01jKR80ecY/ytt8bn3Aw1Z6/xUHHE653qajNWG4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GFhUBH+uR8EVnBBhO+F2wYlPbJi/pnisB9fDiqfuCaRLLKuAM6I7txfEpJbgtfBiXeDHo03ZawPg0yjXKPW80AYmFBsr9ovQ1kvCQximH16nT/vtrnQEwgWAVwY89FdwhEMKXioAreyhY2Qb1xQWmDnHOz1YY7dnzA8HmcJQ6Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=AQqy9g59; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Gyo/S8F8; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="AQqy9g59";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Gyo/S8F8"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 2A8E31140085;
	Thu, 15 Feb 2024 06:27:32 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 15 Feb 2024 06:27:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1707996452; x=1708082852; bh=EMqiYST06T
	3unJhHPMgkNC0hBDaVxCC8e3LzHyTnuio=; b=AQqy9g59Pi1cEQ6JTRQ/50z2LT
	vmKQLqt+ZKKDg3Blzr6y2NZtvVGfH6bTSZMnyFTtdP+Ck4mpIilgKMqdgNMA/r1X
	ecaumyEDn5tW8RvM/va1nWLdjfyH6d2PH/6lQCxGHLZKbj3zATZiF0jqdIlgB+tH
	bOR8IYiD9db4Y1ZZw9//7ziq8YdoEXtBcKX/JL0fFdujCPPaI5Cu+IzHNLDkzn76
	K7AAsfizOfq4FMlsYthgAUtiM+7KQkPs6xoB1pkO0NdRUR02WGpEnsxCNMjjgX/u
	HZryD3E9XVI1utOX5ZLoJfhXvUGPHF43s4GG55UA8qv2AlmIucUOx0J+DesQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1707996452; x=1708082852; bh=EMqiYST06T3unJhHPMgkNC0hBDaV
	xCC8e3LzHyTnuio=; b=Gyo/S8F8VVcbHqoIt1lXQYJzjongFBFjBc/pOil10ikI
	eZUxTSvX8CxI6GIpURjURWfov12EydNNk6b+uv51U3efeHk+qNyBPA1znRbqLVwH
	d3ciPuMpLu1s9DnfS7eHZoRsY7piWXD2NszVyMAopws7/0JVtFk3ipz0cWcfTUbG
	6s9CmZVep6PkzBqTF80nfJv4odOlJXaX0Z+yzdsBpqIbcNUPLUj3XJKuRuqLK6fo
	Lotc3E6gSsRyF7vzP1GEHTAEWn8vorATpi7uJ0cbmLPpYpqBTFojQVUyAmcBUePG
	E+GNE4vr7TV/dFGP2GqMvrPo7U6nHlQ5ZLTU1/T3sQ==
X-ME-Sender: <xms:I_XNZegFXh6mCASdX0Y5ECh_POvQrxNJu53nHDxuPkxe8Z7KJGdj_Q>
    <xme:I_XNZfAPLVGO9GKrAdpfQwImCsLZXlgVgMAt-XTjby8dqEOw0u3CXtQmciB4SjVEH
    3iy--ABzvSdrjIeQg>
X-ME-Received: <xmr:I_XNZWHBIdVnhWzz9hrfDa8HhS7zBW2IoBeKO085aK5v5I9SQbkPnWCYeJEGLuoUlilSzLpgkbxTW1whcQ_XRLBWu_7Z_zFgzA8HEil6_R31>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddtgddvkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:I_XNZXToa7tZ5_gXiZNJo9NJGljeAFoM_xfVDiCi9-hrGzED4z6SQg>
    <xmx:I_XNZbz1_d7h1NOJ3FIN_JdPxCSbS7cQHsnQ_A8WMK775fQOWpbPQg>
    <xmx:I_XNZV4lHy8FX1S4sntY2PL4SEs9h3NbRyxANzGaaNE2rkjKu-ATwQ>
    <xmx:JPXNZSm1eMqlu8ejirgarFQ3iF35HGVSmlYSK6L8ZZ1nAgNHQ81B_g>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Feb 2024 06:27:30 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id cc0da16f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 15 Feb 2024 11:23:36 +0000 (UTC)
Date: Thu, 15 Feb 2024 12:27:27 +0100
From: Patrick Steinhardt <ps@pks.im>
To: "Eric W. Biederman" <ebiederm@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH v2 00/30] initial support for multiple hash functions
Message-ID: <Zc31H77MyE1WLf_L@tanuki>
References: <87jzsbjt0a.fsf@gmail.froward.int.ebiederm.org>
 <878r8l929e.fsf@gmail.froward.int.ebiederm.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="c+KbqYjk42i8MQM7"
Content-Disposition: inline
In-Reply-To: <878r8l929e.fsf@gmail.froward.int.ebiederm.org>


--c+KbqYjk42i8MQM7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 01, 2023 at 09:39:09PM -0500, Eric W. Biederman wrote:
>=20
> This addresses all of the known test failures from v1 of this set of
> changes.  In particular I have reworked commit_tree_extended which
> was flagged by smatch, -Werror=3Darray-bounds, and the leak detector.
>=20
> One functional bug was fixed in repo_for_each_abbrev where it was
> mistakenly displaying too many ambiguous oids.
>=20
> I am posting this so that people review and testing of this patchset
> won't be distracted by the known and fixed issues.

Thanks! I've reviewed this patch series up to patch 7.

I think the most important question mark I currently have is scalability
of the proposed object mapping format. The complexity to load the object
mappings is currently O(nlogn) and requires reading a file that is
easily hundreds of megabytes or even gigabytes in size.

I have a feeling that this needs to be addressed before such an object
mapping would be feasible for production use, or otherwise it would
incur too high a cost to be useful. I'm afraid that this will make the
whole series more complex to implement -- I'm sorry about that.

I've added comments and ideas regarding this issue on patch 6 and 7. It
could totally be that I'm missing the obvious though, or that my ideas
suck. Please don't hesitate to point that out if that is the case.

Patrick

--c+KbqYjk42i8MQM7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXN9R4ACgkQVbJhu7ck
PpRCRQ/+NFHCneLn6Trq5WF4HF2jv4dy3XC4+vc8Yp2FzE1PnB6SEa2XH2taR7ES
7NMiLAb0+3cPLa2blfBxkctmNmWiU6n2YJJ2YB354Fj1f7FYUR9vUcAuKWGI36M8
yo9fLKdbJEMpVviSo5SR4HmB95iJwLjSZEpfApn+kjKZN8YbpaOeMwL4zI+W9UhC
Dv/WGXm6Sh+W+OFo2eB9Biut7Cn6p7s/WnT9M6cZOOQ6KFQJMuMBtClc/5+Ljfmm
aE3fVwkE57yCAeHKnw1qrGKSSJozE1Gsi8QuchB8KxvXgFk3JKclIxhY8jkON6AM
30bNUwmaPIhjwlon04FzyordQ/cT8Xkuk7jqqFkFmoHa0md5rKzzR9/66pD5N7vs
2uM/wJWPeYzUoOrcbxvVYZ3rHzNsOz2L5l6eVdc78dzwvWH39aOoGv7cXTnm0bQQ
52ayzUsCrHFT95+Tv0JekEyAta0Mm06mDiEPEfLWia4mmKGwnWOqiKbtpC/YY5k4
+HLg/5LZnEhHPmPRldyqnbg3K+hyeR0RPtZuPVEODzZcY1DQAhkwxgMdgqthzS2t
gMcxKqccNSPsQ2vq7IC2EKwp533LX8vma1faa6udajWX5/oZ/7CN6KqEIA5Lqtrw
8GT5g8nCe0Uo10hdjpPJ/r/hqa0kVkkGSzwPCDn7yuAL3vlv81k=
=HSfq
-----END PGP SIGNATURE-----

--c+KbqYjk42i8MQM7--
