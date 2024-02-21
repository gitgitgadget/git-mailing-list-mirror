Received: from wfout7-smtp.messagingengine.com (wfout7-smtp.messagingengine.com [64.147.123.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901A66930E
	for <git@vger.kernel.org>; Wed, 21 Feb 2024 12:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708519045; cv=none; b=j4auv1cNJa7Kz0swfxnxcu5ugChQ5Y942uhJbJpoZkRHbN+vu33KjN1OPsrCKmhH17paAcVRU/nrNQBzONFdKztTOVOQsK9HFCofQC/Rels78wslDgTQcXMArsD/iUISXOHnE2Ihi0w8aqTKKfShwN33kmivdyw0U+UTiF6Q2/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708519045; c=relaxed/simple;
	bh=eRFyd00vKvAJIgtznjiOAeUI+YKwc9tbpBniBQPrNow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dvqrTqKfn4ND3baAhbxJ14SgWueU2n1fpqTzzowBzgstDaPVcGG4UL+5YCvyDdaTkZFicm/QQNxn56V8BrriLCjbv1x++GTnnApvwU3vvsNoQklrERsVQp7qOakK3gM7ASAJRwY3EE9CX6OCFUlkn3v3lDtP7h1dY1tsK6ygm3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=WTy1iJRO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YdfV57eh; arc=none smtp.client-ip=64.147.123.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="WTy1iJRO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YdfV57eh"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.west.internal (Postfix) with ESMTP id 71CEC1C000A9;
	Wed, 21 Feb 2024 07:37:22 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 21 Feb 2024 07:37:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1708519041; x=1708605441; bh=loJKqbXcfO
	NY/Y93VaMP6yWIEP67iztKQzMnar0goEQ=; b=WTy1iJRO29UwulfHkHF6i46qup
	tV9NBTaRaPW9o8ukJ1tjOPNljcmXZMMFVxaQZrkvw5Z6X2KVVf/WNh9iy5dTNzqF
	brQJ6P6jfHHwGEWHw/mo2OWneR3RDZGAsTMUefHg6rg5aKUlqBfcObFpNbWBPwd5
	WI8BMeEFqnuNlKchBHhFjutUGzWq4glOVUlfCqeXv8wbJvyFr1Z+2kTjFq4FFEeH
	2ZsH6YQGqiw/0xKW/qeOxECYU0WlsYta7AMB6r/NxwKv2QXmA8k54xRDDFY+Y69b
	J4qQIkFD7OOwnb8vgKeiwt2PSUc+dMiI/bPRqRX1osISdyP9SNYefyxQEekA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1708519041; x=1708605441; bh=loJKqbXcfONY/Y93VaMP6yWIEP67
	iztKQzMnar0goEQ=; b=YdfV57ehF/v6+NkXSQbePmIolS0KJJqj9Bi9azjn59MN
	OBpjiqdeUB5XdNa6Pfso5pQCQ6cYTiK7faYUiktvzdM/7vxnmfltY1eKBVPAn3Dz
	TbbSY8Tnl0CRzGFUKCyi3WjUBSXpdtThj/7Kk1GXAwsYyvLB0ibP1EDlIlXkkdBZ
	v8N2XqPCRNuVrvHgVWSaHPJm7zfOHr6AvmF6F4LFXiM35PasyCAbHNsb48UfsCi4
	0pJYh93oJwyTIR4OA6y3ULrhiA3nCwNENe2kD5AiGBHPx01/p8obw4qgmHNPKFbI
	Uo7A46nwwJi+XBTQVrKfc6LzcbA2U4UT6Gsvy3wmww==
X-ME-Sender: <xms:ge7VZQjQkRXzMDOULQd4L0lIMhsiJ3voQRTtDoIg-QN3XgY9uuUG_g>
    <xme:ge7VZZDfUi8870JqcCjl75KC8rv7Q917a1OUnmaQ0ZL8-wG-BisWtTYsSPQgA1GJl
    rTXPrL0h7LmPI3ynw>
X-ME-Received: <xmr:ge7VZYHoRItatXPG2kHSz9Yi-fDPT318lvBX2Ys87oskMeXuqiIwhrsgdppGi41s69VHQ3tUZTWvXGVpW8M1xJFmXG67fxXRLFb1hzsSg52k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedvgdegvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeigeekle
    duvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:ge7VZRRRCq8V7Kg9KsKUVOeG7FKzMFm_yy8pan3qYoCO1Z4w-4vAVg>
    <xmx:ge7VZdxB8B4RO8r4hW4I1jBxPLhJ4-d68PFxdOsBwL0mUfJxh9vA-w>
    <xmx:ge7VZf5OLgcaR8ZXkPoB-NoLOWR8-7SF4S0N13WvFq_7VQpmUFyGUA>
    <xmx:ge7VZY8udxvrTRjuD8gls5uXexHIYzKIzzzBiGE2qifgKW0n-IgXk7unXjQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Feb 2024 07:37:21 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 22473552 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 21 Feb 2024 12:33:16 +0000 (UTC)
Date: Wed, 21 Feb 2024 13:37:19 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 1/8] dir-iterator: pass name to
 `prepare_next_entry_data()` directly
Message-ID: <d474f9cf77232e0b37dd7312ed1a4eceafcc861f.1708518982.git.ps@pks.im>
References: <cover.1708353264.git.ps@pks.im>
 <cover.1708518982.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="in/zRfuEe5h4iVU4"
Content-Disposition: inline
In-Reply-To: <cover.1708518982.git.ps@pks.im>


--in/zRfuEe5h4iVU4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When adding the next directory entry for `struct dir_iterator` we pass
the complete `struct dirent *` to `prepare_next_entry_data()` even
though we only need the entry's name.

Refactor the code to pass in the name, only. This prepares for a
subsequent commit where we introduce the ability to iterate through
dir entries in an ordered manner.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 dir-iterator.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/dir-iterator.c b/dir-iterator.c
index 278b04243a..f58a97e089 100644
--- a/dir-iterator.c
+++ b/dir-iterator.c
@@ -94,15 +94,15 @@ static int pop_level(struct dir_iterator_int *iter)
=20
 /*
  * Populate iter->base with the necessary information on the next iteration
- * entry, represented by the given dirent de. Return 0 on success and -1
+ * entry, represented by the given name. Return 0 on success and -1
  * otherwise, setting errno accordingly.
  */
 static int prepare_next_entry_data(struct dir_iterator_int *iter,
-				   struct dirent *de)
+				   const char *name)
 {
 	int err, saved_errno;
=20
-	strbuf_addstr(&iter->base.path, de->d_name);
+	strbuf_addstr(&iter->base.path, name);
 	/*
 	 * We have to reset these because the path strbuf might have
 	 * been realloc()ed at the previous strbuf_addstr().
@@ -159,7 +159,7 @@ int dir_iterator_advance(struct dir_iterator *dir_itera=
tor)
 		if (is_dot_or_dotdot(de->d_name))
 			continue;
=20
-		if (prepare_next_entry_data(iter, de)) {
+		if (prepare_next_entry_data(iter, de->d_name)) {
 			if (errno !=3D ENOENT && iter->flags & DIR_ITERATOR_PEDANTIC)
 				goto error_out;
 			continue;
--=20
2.44.0-rc1


--in/zRfuEe5h4iVU4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXV7n4ACgkQVbJhu7ck
PpQOOw/+P58+DWr1l/zCoaqnf+yTYoehymtWyiIVsTz56NWEGAhKL3qCC33D89AW
3Xmf1Pky2c/mS+aIyvjuA8feC9D33esrofWgcdNu9uIN/12oyTssxWCnp8vGYITA
3DaQOoRt2RmA3T3/RZ7VLZgci1GnyXoPlUWbKBj+wV3PczUYHYLL2dFRzvInSq1Q
bKuhJ6sv853khH5u0mQy3OMlqEFv/MqjVZFVYSYeYWHTayOh/89OXuhR9VKE6+aB
YhYt5Ln0B1LU7+xF7zc52IeJEFJ24iWiVthgQpOC58iNT01Nr6qNV3JIdKKffdks
mVABM9bey8x639Q1sGcoHTXK1LLce+IeTNwsHdgBaXv8SzAw0pw6kLD0KOi3qX6L
uoGatuIj1ytABdF4aNvpcSVHn5nliBspJubSajmNDvja7cSHcf/eb+2XqBcq5Z/b
lhGakwvooyIlwJwnNM16QIpXhUdB4p4CUeEzRgZXZwz1OspUXvS+65ACutMAN9Rh
1OuDntW8iaH8x84rJgr50PMVwrKl+tJ4NMZI6LjURI+kapXkPwcHQ/oF3tQX19ra
SjXBgvvvTFRjacMcFQOvnuC84LRnexR6mz+hfsdKvAJplN4jJMh39VUxm7MUn1I5
EsQJhex+2xVtFfyTd2P3IUXczod1BQq4FwSyPu8VphDbDN/SGlw=
=UFew
-----END PGP SIGNATURE-----

--in/zRfuEe5h4iVU4--
