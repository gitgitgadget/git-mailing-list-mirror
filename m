Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9C91474C3
	for <git@vger.kernel.org>; Thu,  8 Aug 2024 13:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723123793; cv=none; b=J2uwfeHC8n0HyslDC0jvmgNAC6K4eymHwrAG4xiNwZfPpor2J7EZzYht0DbyCk4AVkpP59k2AIEyvOb2oyaFbJKn2rf3L3AE/GS68j2MBa78hDSC5WOC51ncV5SFxAoWQlip0X0u88qtfoGgOe2Mty3ag5y2Qrbs6JkSLAXbGGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723123793; c=relaxed/simple;
	bh=lkKRhSjZQGxm3VLGrHLKzIVAZY+rVg7h5ImfHWwCQSg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=koHF6dcZBb8CpJykSbuueGDR6YlxBObYUUL/8LBCzd/+2IHc/H7KQMM8bdRNdsg2m/S1mKJalqUU+PS2SMx+HXAjDJB6sYY8iMd7b+GJr4weq00trH68TT2iNudlCkDJ1xAiEPxBG2bBG7M14NST+rRLywAMp4J86G1gxP4F9Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Q/Aa3S6p; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Sd+a34s2; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Q/Aa3S6p";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Sd+a34s2"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id C8D931151AAB;
	Thu,  8 Aug 2024 09:29:50 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Thu, 08 Aug 2024 09:29:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723123790; x=1723210190; bh=lkKRhSjZQG
	xm3VLGrHLKzIVAZY+rVg7h5ImfHWwCQSg=; b=Q/Aa3S6pXLFRLQ55NoTP6nDiWt
	POQTnRZMH6b0Cw08a4ge5R31pYF1CMdUC7AFp4s/XIYECSTm17ylC1XWcKHeqKMN
	ZGKW814NLF0KxGwM5uKAFl60Fz86sHlypuEDGF/fd3U67h7h0FsToZkTQkNjcijH
	qQQdrr0L3/+gaHAi6ScuhmxH1Q/tky1JmRO5gAYZAU8RMLWZwlaJOAiVpphplaZv
	66aGR0WZD193mFO7loH4z8MuR52cq9mP7xSLJBHDrNpMxg0r0UwMt6dwQs+bCE2T
	XcB1QmOhXXL1TirOOouJsUI0b+bREKL0Vz0qqqGxK8B1uMfaoC3OXSjpG0aA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723123790; x=1723210190; bh=lkKRhSjZQGxm3VLGrHLKzIVAZY+r
	Vg7h5ImfHWwCQSg=; b=Sd+a34s2hnGwhn7RxMuVsmyDx489UjuDeX/BIVGiCgBt
	VTVABs+AR6Fq+k4YqMTWbHUE6QEyudJoNZ6oBWLonj0tb1oPzwxppJ8lXzjgPxq+
	bXqbU6KZ2I/VHuDrlUNQpez7y1aeACH5MH9FXKYtDVnIr0IXHzqJxk2hXIsfDhOn
	F1vimmF5L4jCwXOut9cPdHfIagVJUpM/YfG+MdQXzrc6OpXUcDq4vr815D+bdnzW
	8r0pRNLNsIWfhCZ7pG7ISXZzGjsbuMGF24ylzQSR5wRPYCL1XDg1iUFxgImBa3R9
	ToROWzBM1YBCeJ5Lt979bBao1qCq9N6GwQ6Q30ZkgA==
X-ME-Sender: <xms:Tsi0ZhLJcNWYhMovnd6yZzzY6gykwxI7LZgDN8UwdZ9umg2UfwV_cQ>
    <xme:Tsi0ZtLkOXa7rhtYHM4wP-mXWbbqQiIrVcIL0slM7SDUNR0H-FreQkLUNg4aQLSuX
    FXq2Ddvo0qtKYrAkA>
X-ME-Received: <xmr:Tsi0ZptxM1_h7c_Z6sijhowhF1a65B939wBTjlI8vPJ521oorbeEd3Rt0YmFZppHy0HGIf4ZTHF9u1R8ZOQi7-uADEcscFX4cnsnvYGJ8q7Ob6H5>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrledvgdeihecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpeetueevhffhudefvdegieeuieelgedthfegfedtueevjeej
    tdfgjeehudejuedtudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopegtohguvges
    khhhrghughhssggrkhhkrdhnrghmvgdprhgtphhtthhopehjohhlrghnugesghhmrghilh
    drtghomhdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhm
X-ME-Proxy: <xmx:Tsi0ZiYNwCrsJm5r7jdmyKZdMvyVJKaCuut89eM367lwdDUeCZJ7cA>
    <xmx:Tsi0ZoaB4Q6JsfM73g9yCe4RaOj-l_uE32gH72CY2uwHiUYkfJygPQ>
    <xmx:Tsi0ZmAm0QyPr39sY498f5e8ezJkgy35LU_4gh1dBt7ZJqtyBas8Wg>
    <xmx:Tsi0ZmYopXBqMHveGDA1dBMo2luy3T3BBSSS3Fji_9zlzhW_rfyQRg>
    <xmx:Tsi0ZnzVWGPtYjde9Jw4w8U3gGjzgu_QxfIUqKhN99KebZ3aJVGSNFwZ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Aug 2024 09:29:49 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id bf81d0d8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 8 Aug 2024 13:29:41 +0000 (UTC)
Date: Thu, 8 Aug 2024 15:29:46 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Kristoffer Haugsbakk <code@khaugsbakk.name>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Jeppe =?utf-8?B?w5hsYW5k?= <joland@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 3/8] builtin/clone: propagate ref storage format to
 submodules
Message-ID: <ZrTISl6uyaPq43-K@tanuki>
References: <CA+osTZVApTAMogBDMaPDEVViJHrFT=BOer=Py4fjTvpsifzfKA@mail.gmail.com>
 <cover.1723102259.git.ps@pks.im>
 <ed314f533355dc38bf8acbf7a69651e47eb8f0f7.1723102259.git.ps@pks.im>
 <24dad55d-584f-4a38-b6c0-dbedf91fdfc6@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6JrEMtwss8/EpkEw"
Content-Disposition: inline
In-Reply-To: <24dad55d-584f-4a38-b6c0-dbedf91fdfc6@app.fastmail.com>


--6JrEMtwss8/EpkEw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 08, 2024 at 10:03:57AM +0200, Kristoffer Haugsbakk wrote:
> Morning
>=20
> On Thu, Aug 8, 2024, at 09:35, Patrick Steinhardt wrote:
> > When recursively cloning a repository with a non-default ref storage
> > format, e.g. by passing the `--ref-format=3D` option, then only the
> > top-level repository will end up will end up
>=20
> Double =E2=80=9Cwill end up=E2=80=9D.

Thanks. I've fixed this locally, but will wait for additional comments
to come in first.

Patrick

--6JrEMtwss8/EpkEw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAma0yEkACgkQVbJhu7ck
PpQPEw//f40QlOLjzFWX4spOfRyKPdS+uft4MZxI69tkeH4gNUQVJtGGbHTLkEit
JqDi4B1UgZpgkPBoabsqyRXl7A2llTRuQ0gBd4VlO5Rgz+RYdGTR3bihfOBaSy9P
bzE7zFChx4Xu/ONK+5hgLdWQo9Qek172BWv6P2FaKvZjmSmDgmHqIJWP0tvlyBc1
82Ybxzz+Ka3uSI7VavU8ZyahUlq7LTfAsNhIhhEVVo5TQfwjlEZvt1djwEGcjQUn
Ac19tb9y10/RpYLyGowiOy9KKKi52I3+F2NwhQsXa9sJK207nZkIBG6KKKX1Yz0Y
yjdw3c89OhaTaQtg2+YeYDbG1aKCwO0TsScOode8C44TskWe1wAiWBK1uo7u2Tlx
1EFZCaEtOxaW993xfcHXMf2wggkZICWVRLy+i7DWqOy3YC2F2bKKhAzEKZAgVKrb
hJ0lI5LbpID2rw3LDqFqBlOJBSOl05JaDcrdp6R6vAkVScY9lMCSoD9UhpI2D6To
n1QGKYj3LVG1+LKLjATQ5S3xkq/23dn1sF62a0i4XgRqA3hB7PoEziqBV6u6ZCYz
damCgkKRPxxoOAhvOvVFnOTkwU+7u5dFIia3mudvSvGDeixDjz5DIjBQxoo33fDS
AHYPORNHSoBVk5d1EadgKKD9bZDEuecTHS1ClSIpkPwE3h7ctAE=
=tSG9
-----END PGP SIGNATURE-----

--6JrEMtwss8/EpkEw--
