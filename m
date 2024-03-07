Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BBB91BDD5
	for <git@vger.kernel.org>; Thu,  7 Mar 2024 06:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709791255; cv=none; b=PgLRq6mXylyBcMWRGkpk744ajlKVF5PqQFfKV1DpJn0HG6agcTHSAe5MDyBpnly5ENiT3ZMz7X9BEvLsxpSY+luJOPirJIMV2c/RnnF2cD6l0zr4dMwqwcB1c1JP5jw5fFNU/ph8Pgj/vb1+I4dvDRF//UzOVmZJ/Y/nT4TbRec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709791255; c=relaxed/simple;
	bh=H6tLeYtaq0fj86xK4A7ufnqGBWDCuNtSB1n2beO9iFY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L/4loDtd7EpESIyshOZnP8qVQoesBKxpPNx1OgjPuLk6JF+nKFFonkIYv8CVzUwWndmZzEO/aoVhglDI5Icru1EKQqG3OcLuYCIVexcKPJ+BiK5nBsp9x2SWxW9p0NDAx/2dKcMXc8GxrjgAX1gIGXg+L5L+V4wuHs3JAQ3JNU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=q08P4GPV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NkGeY+tZ; arc=none smtp.client-ip=64.147.123.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="q08P4GPV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NkGeY+tZ"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id 1CAA53200A01;
	Thu,  7 Mar 2024 01:00:51 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 07 Mar 2024 01:00:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1709791250; x=1709877650; bh=H6tLeYtaq0
	fj86xK4A7ufnqGBWDCuNtSB1n2beO9iFY=; b=q08P4GPVaoktGvIno7lnQZj+Kp
	suv8RxggwnxS66w5NjJtm5v/oDYXxlh1S8yGVGxZavyJgmO/py1514575SnelwO6
	OS1Unr6BEiXnbI6zs83fKT/BYaKX45AjX2gilVKrh1lNkwYpYNhlbvU4Kd21qZjE
	8fuFAQDaqhKgpKhF2+TRf6uZCXRsLmvXi5j+GOGXarYPnQFaIIukz47JFba4OXHJ
	/XWExe2t5KnLH7kREY3Hy8AokONNzUPLJyGWMGubODYYHcHN+j6M8VMZPY59nfQb
	DXJFQ3/wGAGh93Xzp8vdD0BLkLGMTBXrXnbsgRxfUWpUoXmLXjBKWTTfOorA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709791250; x=1709877650; bh=H6tLeYtaq0fj86xK4A7ufnqGBWDC
	uNtSB1n2beO9iFY=; b=NkGeY+tZPXg/bGFv7zPhmucTdy0zqCYCogCNjNGOMFCS
	SUX6eC8Rb72y55b6kiwobr3V1t099wANwI9ULNIMXLl9NHTcUZ6M1ALJSsAK5JWP
	bzhcawDKFLB+vXzV+XkJ+M+cdJtQcrh9z1OIT0aVc9qSmVM7bLSmlsoE8HiTMH8y
	Fl/QdCzGTZVdZqb+A85OUxigdy+yaAqhOQpGWiFYC2ZAqsdUCTwpFIKPYNTC4FHp
	5VgVUs+2giOs0sh/zW5tzjtaziaTBmQwzxUe0iILHdEixjiToBU7E8z0EAaOn3OC
	A7mGtp5n+GoeXDZNdXdu7o7krr87BNzbcEfLeYkkTA==
X-ME-Sender: <xms:EljpZSVrskTYtgzhgjwvPQYUhul8EsuAHxAKeYVa8eqngLPbpiQriQ>
    <xme:EljpZen4TLA0Dso2LJQ_7_gl7jbdUl2LeLPlpDtuWoujEamjv7T3ko6gM4GfEBhGd
    imBV-AyGFxXNgpt6g>
X-ME-Received: <xmr:EljpZWapk7SulAxfNMXqb93McnomXayVZ9E2vYLgxRP9oy-QvaoIHksxqYgopexidnlDrDnadHTdignKaTaQ1i7mRmROP6g1L_7niU1jt6Rlsw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledriedvgdekkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:EljpZZUw_G8pZc36O59rY10lKBtVntymTDO6OGyvLMmTo5bfOCxRgQ>
    <xmx:EljpZclRpn1LcaEXP8NNbISZ08aJaeFfM3cNDd3dqZV6j4iLfbdTJQ>
    <xmx:EljpZecEfiG9s5LlrgXp4_odG8ph82nbHY6U6HvfaAFHw-E5PCYyFg>
    <xmx:EljpZYvZjr0KuAqHLCxYndv-AQSqr_oZfHPl2t7L9g4wKUcJ5tg2Rg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 Mar 2024 01:00:49 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 2450edda (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 7 Mar 2024 05:56:17 +0000 (UTC)
Date: Thu, 7 Mar 2024 07:00:45 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/7] refs/reftable: reload correct stack when creating
 reflog iter
Message-ID: <ZelYDafU7fExs0NP@tanuki>
References: <cover.1709640322.git.ps@pks.im>
 <b0414221ecad1920c84f4ab498e55edec57f06b6.1709640322.git.ps@pks.im>
 <CAOLa=ZRQ6sYLBqjWiMXGS7rcv8pJ7jSEneiJ8ZcHtALrrcwMeg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jSay8zRavqFXOtSR"
Content-Disposition: inline
In-Reply-To: <CAOLa=ZRQ6sYLBqjWiMXGS7rcv8pJ7jSEneiJ8ZcHtALrrcwMeg@mail.gmail.com>


--jSay8zRavqFXOtSR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 06, 2024 at 08:13:39AM -0800, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > When creating a new reflog iterator, we first have to reload the stack
> > that the iterator is being created. This is done so that any concurrent
>=20
> Nit: s/created./created for.

Indeed, thanks. I've fixed this locally and will wait for more comments
before sending a v2.

Patrick

--jSay8zRavqFXOtSR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXpWAcACgkQVbJhu7ck
PpQyNQ//dq+qBa1IwJ0Qi83kO+77OKRCwZQHbOn33eVvyJP+82Ev/kf6rZzSdFTd
1QoftRrUcIZGMXM5o048UmiYlzeYQqv8oX0yHMW5XsZJVqe6xkDdc0FHxKzwUnBN
3rAnu2jIDQ6GTJZ9JmAC9XiW9EQEgEu8eoWb4B5Vo9Yls2SYO+3eTnuFGYH16Hbu
G8kLPzZbqd/rMyMEYqpbvDGt20ni8ayRGkujPS6Hy7GJv3u9L0ysdKcqFUGV8Cjj
hQDk0tquqaDjrbDc+XA1EOjqtJZiDiu3TpfH9r5FqlrcZzF95D6PruLMHj2qkv+N
bvL/gy4TsnP4WgIalryYUCo7xDomOTUtRlYoEcCpOOrdwgKLMdNa1EErps/6iIY7
rHbNyjB0UOd0/csFvtAjhACWI917hTqkhGUVgySbBiROs1i76PCooBwKnkf+tD2T
7ltHoF+QJ2QeCmv/INxDlfa29683phaGJ5N5KJFMFgSCBiNqJvmN8ETmf2grYfO4
k6TbrPcMxS8Jw/Sd4ZmqxNAA+FICpT+RM/qWUm8E4itUsgNvvLRJbRufZJ+n0F2j
5T3dAvKhgYPttgYFNSW8K8WJ1hjj5BHljYAy7EhSzjs9gzxMaZkZcNDSCnH6GqIn
70k3iA3u7lY9CfBpLs2cWNrZAtSIByybUGl7RJWLctX65gDWuM4=
=DPuk
-----END PGP SIGNATURE-----

--jSay8zRavqFXOtSR--
