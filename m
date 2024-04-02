Received: from wfhigh5-smtp.messagingengine.com (wfhigh5-smtp.messagingengine.com [64.147.123.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89C614AD3D
	for <git@vger.kernel.org>; Tue,  2 Apr 2024 17:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712079030; cv=none; b=D0ZlEZBuNZPNfxhH0wovWtl4p0QQxTSIclRI+eom55NZR0jmeQDJCOb3uJMT1V1l9HUm44aGrvPE3U4yOUJ3HX29WpO7Ro8OhQB4vQwDl0W+kJn7SsL9fUCT3F5uomodRlXu7N9496Sq+HfuzqqGf1SS28ZI0GbAWln+KhirZUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712079030; c=relaxed/simple;
	bh=G+BSWqxhIuTM7xTDpoIm0YVo8nh3LsFhhQ76RBlq0IA=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bb6XN8qN2OyE5eKhHKTeWGIYuXs6edymPI3iIur9ToSsfYQFhsGBNHlsbJpiJgPW48ouE8ozLRRsW67G13oHbG0Gp/J+pXu/S8UNyY8jtNCbemsQjHZdNt5gpAjAqmdOHECjv50/+TJWBIcOsD5aI2Toa7pFKypHVNGmBHIfrdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=cxJLW8bO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JVddd6he; arc=none smtp.client-ip=64.147.123.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="cxJLW8bO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JVddd6he"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.west.internal (Postfix) with ESMTP id 57A1B18000B9
	for <git@vger.kernel.org>; Tue,  2 Apr 2024 13:30:28 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Tue, 02 Apr 2024 13:30:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712079027; x=1712165427; bh=B0LIe+bm9S
	lO45oMW70huwR/+SRnXMLTOu8FAgBngV8=; b=cxJLW8bOvLSDEGF+FCTjfwrmnf
	dqReA+oX3fY+cg4UOH4pa1xOYptRo3FSKHw9Gj4i+lvJx4JE4GVcHpmw/GR0WW5G
	wXs8x2jLpG/xCpiPnqGgH6zKUq4HS3rLd5L5qhoMFdfql5X87Ps5iDCjUXs/nmx4
	FZLhfVWBPQGF4Z/M8smlNcslhfxe5b2FISpOlHIRlkOk1cImqhHB7tZDPAlJW3kW
	RZUQN/FGQeqA/Ns7RkSm8GmeCPlvHxe/aKSjy6xKz5QTPa7PnGSdSvNeqD+mQ8th
	dJwLCbI739KqXcuO/H1rwwBBA5A9W8VbH4zalhsejx7MM1iPhf/XWV18+kbA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712079027; x=1712165427; bh=B0LIe+bm9SlO45oMW70huwR/+SRn
	XMLTOu8FAgBngV8=; b=JVddd6hev0HHjReUwaGa6WGoPxV/upAaqGRGQFtA+3Mp
	BX0ik9GQVho0+RqMpn30/rRS4Uebvq0FF/UYxDmQI3R+iksmHELFYXG8JjjmTOh+
	CMhp934BxrWcBpqbt2jW9Ki3iOiXWdwDuEfvr5hB9HrUGEfIqR/lVfMolmLwVCq1
	PC51Gf2zYDPkxneNFUUZ03uf5U+Da0w7iK3+SRyYZy6RNyDgGLDorvgsN72gEUxW
	Rjh3VCxIkHpOsLnJAI4OZP07lhh9lYGfM6ehObzmUsRhyf4aFMQIlnDoXPZbM2ax
	8DzOtbwQrZZ0G2fXUMB+KVjshFEud921FqPoFhPCWw==
X-ME-Sender: <xms:s0AMZlXj2P3qEFN3NP69INBw6E7aIV5d-sy1VgU0mW9MUfWu4BeFdw>
    <xme:s0AMZllF6YHGMx1Ot5frvbk8cJbQK0tVtYeIrJEgKBulv9ghoOt-iPtjKNnjTqGYR
    coZte1vb9LFhgusVA>
X-ME-Received: <xmr:s0AMZhbVDPgCmNQZNQjDePEsFLhgADtczI0wFaj6BalFdPk5t_dOlSNJtmLxgB2cMfqfiryT6YeNjGqDUiDDxauTuUJB3Kg55TgGKbll5tvMTyM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefvddguddugecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeehgefhtdefueffheekgfffudelffejtd
    fhvdejkedthfehvdelgfetgfdvtedthfenucevlhhushhtvghrufhiiigvpedvnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:s0AMZoXqE-582063BgUbRX3gsCJLdHXF6P6TPS2mDUDF116-EUeRdQ>
    <xmx:s0AMZvkcDgj3DKAndJHNPOas9i3N7PciC4S8TWxodPYntWerNPHbVQ>
    <xmx:s0AMZleofEC__4LCnFcjzhAJbQ5XVoGJ7UZ_Lyy5yV-8L2-sTNZ6AQ>
    <xmx:s0AMZpFoI4kI-aSN_L4v2mcYj7kC54ZC-yBwNfxRdCWscMCVkBIFEA>
    <xmx:s0AMZkxwmGHWklSp7I10z-HgBuqns4Y3uaTg2RuQXHXam5mjokNQPovD>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 2 Apr 2024 13:30:27 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 083619c5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 2 Apr 2024 17:30:18 +0000 (UTC)
Date: Tue, 2 Apr 2024 19:30:24 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 9/9] reftable/writer: reset `last_key` instead of releasing it
Message-ID: <6950ae4ea758a92ba87f73d5ce66c5dfb896234c.1712078736.git.ps@pks.im>
References: <cover.1712078736.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kMBmdNSjtLNspvNB"
Content-Disposition: inline
In-Reply-To: <cover.1712078736.git.ps@pks.im>


--kMBmdNSjtLNspvNB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The reftable writer tracks the last key that it has written so that it
can properly compute the compressed prefix for the next record it is
about to write. This last key must be reset whenever we move on to write
the next block, which is done in `writer_reinit_block_writer()`. We do
this by calling `strbuf_release()` though, which needlessly deallocates
the underlying buffer.

Convert the code to use `strbuf_reset()` instead, which saves one
allocation per block we're about to write. This requires us to also
amend `reftable_writer_free()` to release the buffer's memory now as we
previously seemingly relied on `writer_reinit_block_writer()` to release
the memory for us. Releasing memory here is the right thing to do
anyway.

While at it, convert a callsite where we truncate the buffer by setting
its length to zero to instead use `strbuf_reset()`, too.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/writer.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/reftable/writer.c b/reftable/writer.c
index 51e663bb19..4b3a4e3f3c 100644
--- a/reftable/writer.c
+++ b/reftable/writer.c
@@ -109,7 +109,7 @@ static void writer_reinit_block_writer(struct reftable_=
writer *w, uint8_t typ)
 		block_start =3D header_size(writer_version(w));
 	}
=20
-	strbuf_release(&w->last_key);
+	strbuf_reset(&w->last_key);
 	block_writer_init(&w->block_writer_data, typ, w->block,
 			  w->opts.block_size, block_start,
 			  hash_size(w->opts.hash_id));
@@ -157,6 +157,7 @@ void reftable_writer_free(struct reftable_writer *w)
 		block_writer_release(w->block_writer);
 		w->block_writer =3D NULL;
 	}
+	strbuf_release(&w->last_key);
 	reftable_free(w->block);
 	reftable_free(w);
 }
@@ -472,7 +473,7 @@ static int writer_finish_section(struct reftable_writer=
 *w)
 	bstats->max_index_level =3D max_level;
=20
 	/* Reinit lastKey, as the next section can start with any key. */
-	w->last_key.len =3D 0;
+	strbuf_reset(&w->last_key);
=20
 	return 0;
 }
--=20
2.44.GIT


--kMBmdNSjtLNspvNB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIyBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYMQLAACgkQVbJhu7ck
PpQ/JQ/4yeb/ms6CUO96rC6SySQ+sZVlb6InlH6s5EiWIjFtJrKwNZSdCubs6Hld
xBNfVtsxE/tctp9H7NcbmYuzDA+GIvkpo7hQFOWrpM7QQIizPPnMiw7KomN1PL3H
7d3ikDWhDNu7CIA1u3aiYbTodFpq/9UcvyxYtqmW/rbtEPTlL6OxIFGR1Xh3fKI1
/I/8fpJbjTt6G1HwJB1G5nj53VDrCyJ3TvQ6CkK5ktNW+ZYjwCr4tL2EePAbp85J
VqZWVY8mD8WszzAZ9UZmQXT7L0I0nZLapS3Q7v+3NHBiVZIA8ICXkl5I/0QapUkB
YbBe76xMxWRyXA9iMtNmUk3X4Vv19Yy9eBBgdT5qO6OawrlDVQtqIbs0ez1nWGkf
E2sn3gi41BdlniHLJMMmXWacNmF8raonDinxNJ252O0a1j4lk4RjP6tjIGPZLnmQ
6AhWHftE4XlS8B540Qhw2w9Ikz1xpqeL912TBxhtpb8trf639craZ7L270reXTsQ
6mc9twQvKw5mkGEbd0xDmyLAXdf87ppkWnC2LFQGLTq88/sEWOueTkbUTL6yajdG
abQPL95HYNpla3a6fdgCLtyXUUijO0S+Ya1bW7LCpbmhcjsZxaNJJMziIXmYd3jr
N9v74ijykWkn1FRLrZGWsZRK4pRTN/EvpIaBQOk2LSTJvieVJA==
=9lYT
-----END PGP SIGNATURE-----

--kMBmdNSjtLNspvNB--
