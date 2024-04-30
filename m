Received: from wfhigh5-smtp.messagingengine.com (wfhigh5-smtp.messagingengine.com [64.147.123.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A48C134412
	for <git@vger.kernel.org>; Tue, 30 Apr 2024 12:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714479988; cv=none; b=aoma6Hb/jdsE/spbtsKVV5rvCmRV2O+yZ8vhMf7uz+9CizlCij/jk+2yJG7/6IXbaXb386M0zvjqKMAhTXknRaqfr4N2O66AqkO6BAujSLw877MHqRrku6LDB7HD8DZsJy8z7KZMDs3h/lL3wisGIJsdSyVnncVWkvruUt1c57I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714479988; c=relaxed/simple;
	bh=+P5Xw7vJKvR3PhwsrkU8/JiWPwGpVvCVBuhEZjj9sm4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RoQ7uHQNaYlEM4Hq3AxQ1L/A7nTLkB+H7CEw0wKPFvj6+CUkjVygE4nRxu6k+qzhFsES5E/jnNbgqSCz64xCFbkB3ku8HFWHlxOqBZPwlh63zMwreAPxB8X3HuvAu2ISpmkEz06oba1VOT3BcIwCVqQ3RBE1wfbTgbYhGe4i2Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=i8qkAT3j; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YNW3qy84; arc=none smtp.client-ip=64.147.123.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="i8qkAT3j";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YNW3qy84"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfhigh.west.internal (Postfix) with ESMTP id E0A651800155;
	Tue, 30 Apr 2024 08:26:25 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 30 Apr 2024 08:26:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1714479985; x=1714566385; bh=+8ZUnyIpQc
	eM4Q0i9zqi15gfEPzeZdChxrvLO1dYZ3A=; b=i8qkAT3j9LTZhphLFIx8WPlmpv
	zG7FGHa71nqmlMF/r6LzgBbhCwljpRuPpQa93V/24JJrdRlvrfRnk6lN8dZAnG30
	oNnyJRI3Zjm9fJ6emcPLPk8b9z/PQprhn45vKPVGGRXeI/33uEzIN4KTGIFVaSKo
	kQHceE4LhtAxxMqZXRhcENi3592V4S8pFFopf7pCx+U9Vug+e3hsQ8Wk5yUPa0V8
	KY3AIvvFIzrOTRPLc6js5Xegx6IHgMHmxIcUG9qvziOnIah1+v7yG6z+yG8i2pDA
	BPSKJV6U4NEce0Q6UoTSik8TTCd7UpOD1u4Y+3OCF/9oCJOSL/06YlLihzMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714479985; x=1714566385; bh=+8ZUnyIpQceM4Q0i9zqi15gfEPze
	ZdChxrvLO1dYZ3A=; b=YNW3qy84mZw1NC5iDN6oBElLDKeq3Gc2xiIny9DCZ6lQ
	e99i6C16WwFWBuIdhGDRGY9BTCjBdYX2WrG8k9OWxHrtRQLe+AzJNcs7Nm1rAPMx
	YImDK4IkB/SnPtt8YSwBWBRVeKnXPgt2w++eg31v4guP0MncTUuuszIM2dglYcEl
	IJcaFk1aOY9v2Q9ubE/QB32z7alXgGiB9/9RqBK19WXT42aNxvI32AihvDH4DMhP
	0/C+SzS30N/jwXJCaIxa8MCf6kMt48BAnH4+OYMOszvrfdIdjXgyITO8lzPsb3x7
	V9a9Uf/Pjygij2um8cPsTkDwW/Z1SfeBBE+51G3TkA==
X-ME-Sender: <xms:ceMwZm7xyzJ0BuMm3Lkqo7PvF3La7-RMSWxviHt-tB8_c7TM0uI0Ug>
    <xme:ceMwZv67HBlX-gNxwjfb0dHm73Ln6eB0zr1iPvVY2YxruWWLxKXFLCw80hXKV11v4
    IlbFImTwPvrcLEW0w>
X-ME-Received: <xmr:ceMwZleXqguaoRlzugrvW_i8UNxq0IGfIVFGBti6xmizqOX6y_RISBtp9SFkzMC5u1OYKv1vhDaDiMtqSojEWSl7GyAwFj7TxQBkQIkdeooyRsuXc_Cc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddufedgheduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:ceMwZjIGsnbP9wOSKXiYRwuKRnAoEc_3PN5LoLlXylevYMS5M4MYiA>
    <xmx:ceMwZqJTucmCUXuVuQ93Fkp3_CX8cyRpZPbZKEGY3W4aoMgZQmDWYw>
    <xmx:ceMwZkzESns2O0COgtW0nO_kaBzGIQr_aDHtWFWQzeb2JJVIF7qQ7Q>
    <xmx:ceMwZuJt3_tPhGy47I2XIlxOIkJ2IBUtqEayNM8ho8_3HAYLlwPxWg>
    <xmx:ceMwZi-O8M5ni4h94LI-VfQ4xdSawUKfg_PV5Qro25XI4DmcZQEJbRuY>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Apr 2024 08:26:24 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id cc450f36 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 30 Apr 2024 12:25:59 +0000 (UTC)
Date: Tue, 30 Apr 2024 14:26:19 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Karthik Nayak <karthik.188@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 00/10] Clarify pseudo-ref terminology
Message-ID: <cover.1714479928.git.ps@pks.im>
References: <cover.1714398019.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lU2ubLnQBsnj1w2C"
Content-Disposition: inline
In-Reply-To: <cover.1714398019.git.ps@pks.im>


--lU2ubLnQBsnj1w2C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this is the second version of my patch series that tries to clarify the
pseudoref terminology.

As I have alluded to in my first version of this patch series, I'd
really like to return the pseudoref terminology back to its original
roots. Namely, a pseudoref is not a ref and does not conform to the
format of refs as they may contain additional metadata. With the new
definition, we really only have two pseudorefs: FETCH_HEAD and
MERGE_HEAD.

This has multiple consequences:

  - Pseudorefs are never stored via the ref backend.

  - Pseudorefs can be read via tools like git-rev-parse(1).

  - Pseudorefs are not surfaced by tools like git-for-each-ref(1). They
    are not refs, so a tool that goes through all refs should not
    surface them.

  - Pseudorefs cannot be written via tools like git-update-ref(1). They
    are always written by the respective subsystems that create them via
    the filesystem directly.

  - All other refs in the root hierarchy are just plain refs. They are
    not special. They can be symbolic or regular refs. The only thing of
    notice here is a bunch of restrictions that they have in place
    regarding their naming.

  - Special refs are no more. Or rather, special refs are the new
    pseudorefs.

Overall, this significantly simplifies our whole terminology around
refs that most people didn't really understand in the first place,
including myself. Furthermore, it makes it so that the ref backends
don't need to know about any policy except for what is a proper ref
name. Whether refs should be symbolic or direct refs is higher-level
logic that belongs in the respective subsystems, and the ref backends
should not stand in the way as generic vessels for refs.

This patch series makes the necessary changes to out glossary as well as
the code.

Patrick

Patrick Steinhardt (10):
  Documentation/glossary: redefine pseudorefs as special refs
  Documentation/glossary: clarify limitations of pseudorefs
  Documentation/glossary: define root refs as refs
  refs: rename `is_pseudoref()` to `is_root_ref()`
  refs: refname `is_special_ref()` to `is_pseudo_ref()`
  refs: classify HEAD as a root ref
  refs: root refs can be symbolic refs
  refs: pseudorefs are no refs
  ref-filter: properly distinuish pseudo and root refs
  refs: refuse to write pseudorefs

 Documentation/glossary-content.txt |  75 +++++++++---------
 builtin/for-each-ref.c             |   2 +-
 ref-filter.c                       |  16 ++--
 ref-filter.h                       |   4 +-
 refs.c                             | 120 ++++++++++++++++-------------
 refs.h                             |  50 +++++++++++-
 refs/files-backend.c               |   3 +-
 refs/reftable-backend.c            |   3 +-
 t/t5510-fetch.sh                   |   6 +-
 t/t6302-for-each-ref-filter.sh     |  34 ++++++++
 10 files changed, 207 insertions(+), 106 deletions(-)

--=20
2.45.0


--lU2ubLnQBsnj1w2C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYw42oACgkQVbJhu7ck
PpRnkQ/+N5f7Tqd0urS8CJD+FhoYM/Qh+Zv7QkSlvWyLykj6WT6HRbU5GPZsmY7R
fVuanTx2ep619cO7QJUJXO8P+X8nJQN92BMx1hz67H726MzFDT86Px//VFzKBjuB
v6dRlS1TI6EtyKhB1BorFx2YdXV+02hd569hlxznqMHkrZ77bm0q48uhs65MlEmD
mrv1FMNKbv3PmC2qn/m7DH01vqQ+ARN0mYgsnW3idjIIemx2o8og/7NtD0BnaYPj
l88tm4cOMwbZdG9CmlIbdsuVtwiS+agmzoC4DaXXMMv8/9hRkKQFBp8X6Vjr19Qu
dvBte5YsmCV2vnmA55BKO50oL0ysEfvhm/4siDF8z87M00Iw+n/UlnQHWYyNe5Vv
puOHscN1ssjBLBcpESa7DcySN4jD7NyPefS+Pxch784OHckMnjFclZfDAGLfGESn
ggD0/lc8z7okvKaHNWBsP2uwnzbUUcC+3n3YrGQS0sfCEDXy/FPXpSYo/5hv+jRS
ErR7SbwAkwiPst+qhFGbnntBP92eghhISKGCfyyij6yWVdojRPK7sA3GecqXmAzd
TAcxs0ujCiknuAY6bN7hkHbVh4VHlF9f74GtE/3mTM2FllGRCRahIfcpWY7pJU7O
uEkNeifxs6LMB+uDZg6PO21tnl4onWFWpKTte6blT9b8i/XEtuU=
=+5zs
-----END PGP SIGNATURE-----

--lU2ubLnQBsnj1w2C--
