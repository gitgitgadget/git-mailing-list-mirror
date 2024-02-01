Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0987208DD
	for <git@vger.kernel.org>; Thu,  1 Feb 2024 07:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706773921; cv=none; b=OY0v05ZVhiWs2jxuoUgFN0f2gYgkajrpbmf78k5sdcdY+MhfPEvGMf0d40F0OGO2vIj3VcwCg7wKhel0R4+y3p5iUbXbGaNOW0y0TtsLimTtPh1fMLEy/08+tLQvt8ErWKPryVMvXK+Bj1cjnzDee7+mrMXq9TvVFoz3Cx8Hb34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706773921; c=relaxed/simple;
	bh=r4DmIFu4t2K63JYYiU0X9sgcB6XPtwXW8At65UzB69c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IMLU3daQD3GTp1RNFJnek6SmKPAFtqv8FSJzRDeJdftxEsAoxWRd/sd+viVy9n1jyJnRf9CuT3kjd/FOxsHBbxPTsgIxGQH6q1+Y37HAkqPcyvynWq8WbqX5lF5vV+e4HPA/wC5WcUO/hxKQdNViVZZ8wOCE9frntiJzOu3WW9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Erkxpyjz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hj2ivwFk; arc=none smtp.client-ip=64.147.123.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Erkxpyjz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hj2ivwFk"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id AEF843200B1F;
	Thu,  1 Feb 2024 02:51:58 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 01 Feb 2024 02:51:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1706773918; x=1706860318; bh=dYUWnAVp5X
	njWH3o1UxZZ69RE7J1F6CmF3YqpoWU/F0=; b=ErkxpyjzzDgQUeDvi+0x0axEYz
	FH2JybfPZDCkq+8HpgApC0aMGpalb1TVcdgmmeAA2XwzV3Xp/GkBv0BylJ+U6yMu
	vTeK/cajjvPGmz1ruD/uNNLreXm3vFondT0AgR0Z2+YBTfIhAZfj/utdjKiBvrFT
	hRZd5eUfAmDYti11mWaPlDKTdR2yld4/jTnvubIv9Hcea7m8G2UXjdBtA9gysnwp
	ZlnOmNY8kv9y9YKqqvZfP+npAhBmiV1mrH5wG6QsXjJEio9R/NCEhV7QyVL0KYtP
	6baGZS6YXn96GzrG2PE0Xg1wA6/t3ema0Jr73f7QG1Y2q75Le+kUqC62RjzA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706773918; x=1706860318; bh=dYUWnAVp5XnjWH3o1UxZZ69RE7J1
	F6CmF3YqpoWU/F0=; b=hj2ivwFk+eGJfhJKSOddKVA4TwjoQeafQ2z8MS3jWx5p
	1CZpZhj0xRq9J6gSNlO6bLJne7RThg9jYUo13j9sFYv06yd6vUBROULDhTgEA2V8
	QiVMY/G4zkCxg41f/V0QOCA0yUZ9cq8okFiyCb21/v18bCccju75s82SBp1sEol7
	gVTKg5dvqNUAD7pIncQmlGwMMdw830fyQgwsjwVeo5gWkrQQei3R4EyO0hIRfmfs
	bbomOICfNVB/UsLLsCjK4dPj3CqmmC18vVSQkrS75vMpUVVf0DUSLvIQUeZ1IrdS
	Aj1L/JEoZ2T09YgGEK7ozVHbj6CHXbC7/pue7iE3Uw==
X-ME-Sender: <xms:nU27ZZh_oe89Q7CfaSXmNZy3qCSkK_75NnuIbmC9YqXz-r-39zTnlA>
    <xme:nU27ZeD_e9jHlgiCDb3qi6Co5qm74Ph_Wf68uzYuxELhMtpIrdwnfAwiKDGVjSO9H
    asiQnVzmt_oX_5ozg>
X-ME-Received: <xmr:nU27ZZGKj65BdpOABUzUGOvoKnhqVG2nGWeHbxwgPm4ThsJPSHAhB8UBzhUBsEciggSPOerfm3_iex_g_dtcpAUDFPvMpnWm3xdNUHEQKWaCIg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedutddgudduudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:nU27ZeSxKwpFueU1nSX9PuTNAaab9z1PQ2ZehoVqBh05E7PRRn5cSA>
    <xmx:nU27ZWxa4YiWbN6pKs1M5Nd19qB0OiI-oHS51jPHl70hwbSY_lHUDA>
    <xmx:nU27ZU4kp0PZ3xVdTX7MkilH6Eq95cWuQZGq3h5d5RoS0_cPeNRa1Q>
    <xmx:nk27Za-FBh8Aar2-dIKmVDlEvfZTPL1gY3PH_GBmuFC022ZwWHFcrg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Feb 2024 02:51:56 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ce8e537e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 1 Feb 2024 07:48:32 +0000 (UTC)
Date: Thu, 1 Feb 2024 08:51:52 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Toon Claes <toon@iotcl.com>,
	Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: [PATCH v2 0/5] reftable: fix writing multi-level indices
Message-ID: <cover.1706773842.git.ps@pks.im>
References: <cover.1706263918.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1jVeiK7RfFNeAGnE"
Content-Disposition: inline
In-Reply-To: <cover.1706263918.git.ps@pks.im>


--1jVeiK7RfFNeAGnE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this is the second version of my patch series that fixes writing of
multi-level indices. There are two minor changes compared to v1:

  - Slightly rephrased a commit message.

  - Dropped an added newline that resulted in a new hunk.

The patch series continues to build on top of jc/reftable-core-fsync.

Thanks!

Patrick

Patrick Steinhardt (5):
  reftable/reader: be more careful about errors in indexed seeks
  reftable/writer: use correct type to iterate through index entries
  reftable/writer: simplify writing index records
  reftable/writer: fix writing multi-level indices
  reftable: document reading and writing indices

 reftable/reader.c         | 30 +++++++++++++++++++
 reftable/readwrite_test.c | 56 ++++++++++++++++++++++++++++++++++
 reftable/writer.c         | 63 ++++++++++++++++++++++-----------------
 3 files changed, 122 insertions(+), 27 deletions(-)

Range-diff against v1:
1:  ecf834a299 =3D 1:  ecf834a299 reftable/reader: be more careful about er=
rors in indexed seeks
2:  88541d03be =3D 2:  88541d03be reftable/writer: use correct type to iter=
ate through index entries
3:  b0982baacf ! 3:  b3de0b7f3b reftable/writer: simplify writing index rec=
ords
    @@ Metadata
      ## Commit message ##
         reftable/writer: simplify writing index records
    =20
    -    When finishing the current section we may end up writing index rec=
ords
    -    for the section to the table. The logic to do so essentially copie=
s what
    -    we already have in `writer_add_record()`, making this more complic=
ated
    -    than it really has to be.
    +    When finishing the current section some index records might be wri=
tten
    +    for the section to the table. The logic that adds these records to=
 the
    +    writer duplicates what we already have in `writer_add_record()`, m=
aking
    +    this more complicated than it really has to be.
    =20
    -    Simplify the code by using `writer_add_record()` instead.
    +    Simplify the code by using `writer_add_record()` instead. While at=
 it,
    +    drop the unneeded braces around a loop to make the code conform to=
 our
    +    code style better.
    =20
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
    =20
      ## reftable/writer.c ##
    -@@ reftable/writer.c: static int writer_finish_section(struct reftable=
_writer *w)
    - 		w->index =3D NULL;
    - 		w->index_len =3D 0;
    - 		w->index_cap =3D 0;
    -+
    - 		for (i =3D 0; i < idx_len; i++) {
    - 			struct reftable_record rec =3D {
    - 				.type =3D BLOCK_TYPE_INDEX,
     @@ reftable/writer.c: static int writer_finish_section(struct reftable=
_writer *w)
      					.idx =3D idx[i],
      				},
4:  9c6622c409 =3D 4:  89a88cf83e reftable/writer: fix writing multi-level =
indices
5:  7850e65878 =3D 5:  c3492bbd42 reftable: document reading and writing in=
dices
--=20
2.43.GIT


--1jVeiK7RfFNeAGnE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmW7TZcACgkQVbJhu7ck
PpR5/A/9EuZFzrBxYps+8u44OfDxfoGQv8qcOZfqvX7lURB6Hm2pzvBgzoyOEZ9Z
7tFdtzWm8vNj5FpLzahJXnk1tvTMpwAoKGJtVl1Jl7HKr/gjRuBLr4y7D8yzXP10
jQWG7Zje8gk0D0DTy93sqahb8lz0S+F6EkuhIqNr93RKuBpeF2LvTEZwWmhVZb6a
LgmQwTGzkbPMGnH5leLdlM1GHXzd7D5/4T28PwI5RBLayUf2qWekdOGGsnkHaYyH
lRaamfQoAwUa77bQKdCemYiua2nw+zghrhbJRZo336/rmWG7blqB7l3HGCuJj3DK
SePaw6MnmAO/9rQfLGH3flyJuD9ajJtgJtgaAnApxLA0ed0Mdfqjx4HkKSWXgAsY
plfYT4vv38MaVmb42jhsu3/WG8yknlkiVjeGvu7KykbiWtHuJExeCX3Kfm/B/FfL
RrrRaDNIwsDqaZ0mV72jUA5xTKZ8SvE9IG3PvoOtXyRA6kDN2cVNIhRLY9dEpsNm
/8Qqc3QMqNG4Jkc1S2QPYVR2OWyxCtHzZc/iE9KTW2cBzbZ0kvS+8UrCeyxUeZaB
Hu2EYl0PooilLWYFQ9RN/zpXZ+q7YMMyN27cKBC9zpa55x26TtK6DiXTF/uSZ2TQ
VPK2GfTXgNT/tZxAwgKZTkAnrhj3a84FUw4e5zZyQDb62ww89+Y=
=NDs9
-----END PGP SIGNATURE-----

--1jVeiK7RfFNeAGnE--
