Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3AF225D6
	for <git@vger.kernel.org>; Thu,  2 May 2024 06:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714632708; cv=none; b=ur5Mioo+YTLRhVwNoHHQafaGc6uBjSz8J/HXPSg8WVGzZvbVdqA+jFwhXLl3X66mvk4iMGujnt8SZrz7MKP4QEGl9qry69e9DH6MVJrp5lq4uuMliIia7pqeaeslexDAm7lVXWqcYzfn1ZlmkqPogXERp08c8lXJtu4YxXxxZqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714632708; c=relaxed/simple;
	bh=u263LjXluUEDJfg1Jt1LBJ/dfzS9bYocg0nPZv/yWYE=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W4dp1Oqodc4W5wPtJAd6NLBqMt7Gk1myBH44bjQwlhSRdgvEcLSZReUIuyNclnQ4M8bC8HUfryD0711rs74WuJHpS2SIK0Whzd/epVfMGdBL4mRAUt/7gVTE9Vu3KbCgA55ChifVydMp5BygSl3BgKWYEn25Gv9ozh+5qMQOKsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hK9wHrdS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Eg01xCly; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hK9wHrdS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Eg01xCly"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.nyi.internal (Postfix) with ESMTP id C7EE21380394
	for <git@vger.kernel.org>; Thu,  2 May 2024 02:51:45 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Thu, 02 May 2024 02:51:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1714632705; x=1714719105; bh=wsVg0F0Vpb
	pWrQ5OGAYm1ym135bAYULGznb7wQXP+Is=; b=hK9wHrdSp6CE2zvKs9aINnZV2e
	gAur2oT7T3M2u6Ts+5EEIojvwTxypwnge9wcjr0h25KE4rEAoGh1yRiM/4mzBmFn
	0Lb7KhpSo5Xm4wefkrTrt7MD8XXnWOhtqdO4e1tRILvNDhbdRryyy46s3f9jT5yL
	PzmrsLv1rV5NQGOmletkcHTBfRFS2CRM83GSmNUQVirzZpCPy+Wn7HWgP67l6p/E
	Ed/5nJr3s51fqnS8dRq/msAzCkOL4INBf5f8xrHyrbt9atEuPGR38z6sxrnLplh1
	GpzpaU3CF33pGnQT6vLzNGa5SGCy7csP0sGOdu0jjjjrc3VEFBW9Ke/yu7lg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714632705; x=1714719105; bh=wsVg0F0VpbpWrQ5OGAYm1ym135bA
	YULGznb7wQXP+Is=; b=Eg01xCly13hpfuD+fHx2CJt8Ru4pBwUUIcuRdRbvYb9j
	w7F6y5zgSQd7RMpMKe5Lce3FK6VAX+tQ2id+apYnGsjfHhFhMo2bpEGMAf+G7TCW
	iqiPFbmoS0xhx3j/0FSJdYqe7GwwuYwbXgdMYTqW0QeAdt4i3Khi1BcV6oZt/oXR
	lverN5f7ISZGWm69D8G4DGat/Z61roTcvAtqujl0RJV79LRzxCtafyL5bJewhUBx
	nBilr6shjsO2Za2PdMiCv51T7tlWAEBQ3BPVT+eiXo4QxiCg27NEgXyW2Lljd7M0
	K3nXxJq4svUdMO2tqQHPpKe0CbYUFnUhMKUB/SuIQw==
X-ME-Sender: <xms:ATgzZhcOC-zW1jn2k1qhSmVoBfPNbWAwdDrJTjepzPEIcWciLS2gzA>
    <xme:ATgzZvPFh6aknJwpG2VETx0IhofpdDvs7KmZJJmbV4Z593nvHWHTtDz-Xa7ix4PjJ
    Mslq8z-J6j4zxiNRw>
X-ME-Received: <xmr:ATgzZqjyCxE6DYQr5EDRF-UzUvrNAE_rgWXXfZgj5QUV9Jk18ziMwjGCXPfz8EoZS2mPXp2r3q3pXeVS4E0Uax3g4ELQPPobItR_MXbA7soTphg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddujedgudduudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeehgefhtdefueffheekgfffudelffejtd
    fhvdejkedthfehvdelgfetgfdvtedthfenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:ATgzZq-t3KU5hCvuC4ON9-il03CR4CH8WgLkF_noI9LFck4X06xZwg>
    <xmx:ATgzZtvxmP6laOo35XmPBE0uhw0wRhR0LkYqur5hDDka18qKMkmWEg>
    <xmx:ATgzZpFYNDHGGek-2S1rYBAvFn5k2bg12wKR4n9-SsKb0Nwwt_RifA>
    <xmx:ATgzZkONJdH0ZcWt18pSzfig_9wYbUep75ErrHNy585C6ykvMFlz-w>
    <xmx:ATgzZuUf9Fc7Yd1nV8ApLMP7LI-M4K1W7fYq0lf6srTt3KU-bH4slVBL>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 2 May 2024 02:51:44 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 2821365e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 2 May 2024 06:51:19 +0000 (UTC)
Date: Thu, 2 May 2024 08:51:42 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 03/11] reftable/writer: drop static variable used to
 initialize strbuf
Message-ID: <c040f81fba66cbbf783e7a9188fde116fe413702.1714630191.git.ps@pks.im>
References: <cover.1714630191.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="MY1OR4IzTDOzsXBW"
Content-Disposition: inline
In-Reply-To: <cover.1714630191.git.ps@pks.im>


--MY1OR4IzTDOzsXBW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We have a static variable in the reftable writer code that is merely
used to initialize the `last_key` of the writer. Convert the code to
instead use `strbuf_init()` and drop the variable.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/writer.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/reftable/writer.c b/reftable/writer.c
index ad2f2e6c65..7df6e53699 100644
--- a/reftable/writer.c
+++ b/reftable/writer.c
@@ -117,15 +117,12 @@ static void writer_reinit_block_writer(struct reftabl=
e_writer *w, uint8_t typ)
 	w->block_writer->restart_interval =3D w->opts.restart_interval;
 }
=20
-static struct strbuf reftable_empty_strbuf =3D STRBUF_INIT;
-
 struct reftable_writer *
 reftable_new_writer(ssize_t (*writer_func)(void *, const void *, size_t),
 		    int (*flush_func)(void *),
 		    void *writer_arg, struct reftable_write_options opts)
 {
 	struct reftable_writer *wp =3D reftable_calloc(1, sizeof(*wp));
-	strbuf_init(&wp->block_writer_data.last_key, 0);
=20
 	options_set_defaults(&opts);
 	if (opts.block_size >=3D (1 << 24)) {
@@ -133,7 +130,8 @@ reftable_new_writer(ssize_t (*writer_func)(void *, cons=
t void *, size_t),
 		abort();
 	}
=20
-	wp->last_key =3D reftable_empty_strbuf;
+	strbuf_init(&wp->block_writer_data.last_key, 0);
+	strbuf_init(&wp->last_key, 0);
 	REFTABLE_CALLOC_ARRAY(wp->block, opts.block_size);
 	wp->write =3D writer_func;
 	wp->write_arg =3D writer_arg;
--=20
2.45.0


--MY1OR4IzTDOzsXBW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYzN/0ACgkQVbJhu7ck
PpS2DQ/+Ja+f67Xovo66WTqs30RIkx1nzEaB0IkZvDE89pHY8DGzPAKSag/F/AuB
XeEOunFe6ghdv8ft1+OACg/O7LurCAzaKnZ1gaKEJoEC2PxS6effIqxpdffMuya/
niFNBFV2YOhhnJ9lqR77YWNZWuSJQCCDxQVmxFRZOsssT1Bhw6x2pj5P8M7qPHm9
NdGeFLoGwbm6ml6HeZDsVdCnez3r7OUR/t75UjfvNTLkrwB6R9RZ+xSK1wFGoRxI
tZDv03QzZTxcrER4dUw0Ge1EXccPFfx4sJP+FFmOwXvVGHIUARxvs8T6DLrunjsq
vv4VAWTPi1tc8+hYA+NfZB3QIxomy+Nkp6Xry8gYt4MY22d/gpswunf97i++sBYl
nV2FD3Rf6YDvK5uM3i6LT0wVQ/W6adTFPt0XonceWc9UCXVfox+mKIKLxZM6PHNY
vv8yAQqfCC3AmLQ4QYEsSydt30tdrY9/zq0sqbxhEvfat8hotDGz6Y69OsEDJQKU
C0oszr7h9PEhrTdhVjTL/eM/1K/EZ8lv4PKzqMkeAxjiA/V1s3aW41USn5+puNMQ
vfJNsnXOrVjlBpNfC0LlQV5W0AK7zTo8Oy16oI5haWtJxI3eXn2TKATkt3KHRIBE
64KIddRfsQ8tajCI5zLzCNhKRQ7DdswQFsdx3pkTPkOhJRIhMmM=
=uBhk
-----END PGP SIGNATURE-----

--MY1OR4IzTDOzsXBW--
