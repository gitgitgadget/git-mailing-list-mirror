Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57CC148307
	for <git@vger.kernel.org>; Thu,  8 Aug 2024 14:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723126010; cv=none; b=ILjfmYsXkmWsNqRDi7MPk/HkyXRx16f6757oH8Cn1yzKl5lPPiL+M5vHCwWT/FNOwI9XB6WYAZNl56XYSj1eP3QcaHGkB+nS1LTSMVCrNhjQflovYYelcMlezHFR84IHyMIjNpYzEscZEqSmUM8JwC/Hvv/M4z4W4w69ZdhM2IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723126010; c=relaxed/simple;
	bh=hhmvRLsvNZdvLn+8yJThx4CuP5laQ024gXI7O6AvciA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VSVIBtg1wishuuV2ZP2CcFqchiPpPmb0E2etMMPoX0OZfQn7j9tBkbkmti4nO9CgRyNf4kfRzkNVkshvH/VIxZ/zoTMi3w0N8Nv/HqOOvngwNzfhVjGNVuNJCdezEMd30UZz1jyPu4l0H1KqblvhcXoCVO/cZhQ3EZjsTlTnjmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=iBVBlytg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=o7DgSdt9; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="iBVBlytg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="o7DgSdt9"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id DAFBD115184B;
	Thu,  8 Aug 2024 10:06:47 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 08 Aug 2024 10:06:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723126007; x=1723212407; bh=jgT4oE975B
	Byomd8SmQaN2zgz7UwtLH89YKkFjHDpK4=; b=iBVBlytgsNIMt82Z4QcnQ2k19i
	MXLrMSrbOsg9ZNZBMJMkTa8OIHRxdlxdZe7MRHyCRU6jB3L5pQS+sw8RkTB/P3Sn
	ij8jmVUiwImp3IWeENlH0gRB23LU+YcAYKfjCUMe/kkrj0lGMz5nQBb5rjceWCar
	VjEWm3jt4BnsOEWDY1GKGpWBqDY2IRGtb3Fzfybv3J+/CKHjXA10PYD2laAJeA8G
	W06lJ2SR34PliNs02LdCab8/kjsoxX0SgqAIOap71kBtq1gnEw90556HLIoiuIKx
	IdSNt5ix8rHjZspjwBwgqp0SO4if2v6eWkctvg6PSFyLf0fwV0PxXbcPdrmQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723126007; x=1723212407; bh=jgT4oE975BByomd8SmQaN2zgz7Uw
	tLH89YKkFjHDpK4=; b=o7DgSdt9XXTmUTXSoDvLNpIk5xR2yGU7gu3PqRlH22oB
	dJsuWgnU2DbZU8/N0L39pG7ZvQJA0Bei6Q9UVRc8e7Ve3aJyqm6CnOrxJ/o8A1sh
	ygsCI0NyYDionoLdmD7GjZGjvTYBUBE6wWMEIjflvUPbHVnAltu+W5pwG/XsWbQu
	vZ9mOcN2JVZbnR1X9aJStjxhGGlMTy3wg7ps7N3ZS0dMSUh6sf0vo/Cnj+n+oC/N
	8ddZ4S0lFVTcdq9sz7hzmdKcE+RP4Ii1g4XwNjbYKNr4Hf5xvKL4LR/BxmIpTm6h
	wNpvRXpzqfMP/4KPwVktMmCteXW/V/7T8udA1QmbLA==
X-ME-Sender: <xms:99C0ZpyM-YOq4YnBoYAsAGBG_Ex1dP793DKLbQ3D0bGhvJ2YYkBsXg>
    <xme:99C0ZpQiW5WI41jm2Ilh5IRkyY-J84tg3tu_RmhoqUxC3HpPu1KK2hqfo_mUD4tLq
    omElqw79W3Ok2004A>
X-ME-Received: <xmr:99C0ZjUJr6gGj3H3H2xBICVuUY0zxfKKafIUYuqX-nNETydfu9M6iTBneuSlhyrahWgLXAuCvRFDifzVRzgfsxK_W-sx-B-cqvr_6ntwgUQUDU0i>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrledvgdejvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeeh
    gfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhlthhosghlvghrsehgmh
    grihhlrdgtohhm
X-ME-Proxy: <xmx:99C0Zrj1i8z4mWYpqMlM2pQRJs7wQ9niUzibFenhp0j6ozUSOukAjA>
    <xmx:99C0ZrCzPihbEPqv91qnTQkHwUyKfH1dvCLkRbdaSncLrkeZPfxLyA>
    <xmx:99C0ZkI-ST_T-fqP_CxKGrKID8qEvBJcBmGNfb0XbdOnFV4k5sDKLQ>
    <xmx:99C0ZqBflNPdQkSMZLyugITD-DoeBqrxPtKTYLkeIYc3TwnFQRK6cA>
    <xmx:99C0Zm9ClvRDPO5rrSaYtIq1Z4KZHqUk1OsgW1PJj8Fgd0RE06OGwkOC>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Aug 2024 10:06:46 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 7e628f56 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 8 Aug 2024 14:06:39 +0000 (UTC)
Date: Thu, 8 Aug 2024 16:06:44 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v3 6/9] reftable/stack: do not die when fsyncing lock file
 files
Message-ID: <d7d34e725396423426601c8d07f85e8d8ecb3ebd.1723123606.git.ps@pks.im>
References: <cover.1722435214.git.ps@pks.im>
 <cover.1723123606.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="S1NB4sKG53XUpeyo"
Content-Disposition: inline
In-Reply-To: <cover.1723123606.git.ps@pks.im>


--S1NB4sKG53XUpeyo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We use `fsync_component_or_die()` when committing an addition to the
"tables.list" lock file, which unsurprisingly dies in case the fsync
fails. Given that this is part of the reftable library, we should never
die and instead let callers handle the error.

Adapt accordingly and use `fsync_component()` instead.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/stack.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/reftable/stack.c b/reftable/stack.c
index 07e7ffc6b9..9ca549294f 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -674,8 +674,11 @@ int reftable_addition_commit(struct reftable_addition =
*add)
 		goto done;
 	}
=20
-	fsync_component_or_die(FSYNC_COMPONENT_REFERENCE, lock_file_fd,
-			       get_tempfile_path(add->lock_file));
+	err =3D fsync_component(FSYNC_COMPONENT_REFERENCE, lock_file_fd);
+	if (err < 0) {
+		err =3D REFTABLE_IO_ERROR;
+		goto done;
+	}
=20
 	err =3D rename_tempfile(&add->lock_file, add->stack->list_file);
 	if (err < 0) {
--=20
2.46.0.46.g406f326d27.dirty


--S1NB4sKG53XUpeyo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAma00PMACgkQVbJhu7ck
PpRwHw/+KKEKbCZjP0S2IZUBcHF+5c3XusN4nSwHGfh3IZYu1uo9SukCSRspYdXj
HjBJCQ5B7tKmVcyuC7PcGRYpXBbu3HSjveqlRCkLr83EmCOrWHolSq3A51iimwU4
eJLE/uz3bENgi6VvviYQW6PDJCgBvWT3pgzOjrklUdKnVxqXFOp+GgqVB+06Wsxy
vNa9BxAxd4L7NoEX1MWwSwg2GiQjlbPr/TO0aKJwQ6ozi6Rx+oWPrtwtYZPpHcZ6
cCL/L/bKT18s1pLzgXmQvAcsRmruT8rJnlGkKL13TcJrymjsTQMioFFCUaXdzxEw
FkLFeCsca1tcVCoCuCp5U2ZQr7asMEgqeFVq66q5wiFn1BF8mcZ0lslk0b1ToB++
e7PjCorohQYbYVUGUczdOl+wQZ8IDSy1p+AWrdIjUVuYiQS3szlLtA5v+L+lXSBL
jRof0tjRO33QKaoXSOgnzKFvKftnPSl8FL4TCuDiyx10MgPZxJH77BfVTIGbVxHZ
rabBqnyU+7VfcZZLrBtG3wUQDrYbO7uVxRN/eAHdtOYr2MWGKPm1P5+7uRTLXt4r
AOTNQqNt79mwok3bJxm7PPSoefPtFA2IsdDhTiX0TBQH/23Zc7q6Q55mSZWUaT7z
Feq2Ung5jFUAOfAEdGcuLauM1dIX8jKjvCc2UD9i7tMUo8DG9iI=
=Dukm
-----END PGP SIGNATURE-----

--S1NB4sKG53XUpeyo--
