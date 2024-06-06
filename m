Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362472E639
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 10:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717669732; cv=none; b=BPq8GzaGRvpBIF6HK7l5MDG8DBtHPJ2Z7AengsdElxA8y1XQObRMxgkRKLlBjKrHG4KyZV5ktXrpXJ9S2bztCflR8EtQct5VYVo4ZOcAym8PJ3+/u2OECuw0wjf+zG7rbfmjDAoWjGqeozixlo1V0wYuNrRmy8TiBOgKWSrVFtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717669732; c=relaxed/simple;
	bh=S7pNYq8sUxkS4WMnKi4+XIRef0cFxBTkb2ye2Y3fPQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iMH0d6l1J+qbvtol1G0h4aYPTOaBsKHFwqa3N0MPrcTZZoQJTzOpvqR/qRoXH9UiZTvK0W16yAszW6opDBMvfigg6W+33pi5tRDKMkA3w2LvIGCSx1tNrHCXpK4W682r/6ydyD4fCl38lrD4jsMDVVBjlVfY5u6qmpSfT2IKupA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Y4mQBcPA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=W5T8bScW; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Y4mQBcPA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="W5T8bScW"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 3C10C138016C;
	Thu,  6 Jun 2024 06:28:50 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 06 Jun 2024 06:28:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717669730; x=1717756130; bh=XnvRst57is
	kanhb14a9rF3ak8Xxi3kYkn77vMmFHDik=; b=Y4mQBcPAURQynjBNMXlULaJSMo
	vcPQHot1eXdwYkOYQvyMW7f6ge2t9EBPAfuqrqXjUxYqxRJQEDlIBoh/rA/onKpn
	hjJiiSCnhdCYvpQ55sdW6hH0J9vhGZmwC6hKpJOH/INB+OOzdB/SxqI+oYAdFwoE
	XVWnZ1IHi98TjctPq/ENNyns0kmzk/UrvK1tLNs7qagGNbOszVKt9IjwtBgHA/LU
	wbQ6nCyFQqJ4Km03WszysvKLDGCbOKAL9S8VNyhWr3Tw0cqwXxga9qh+MEDwVFJs
	UsWprWR/Epl9lyv7xcZd/ft8u3KatSKLspUTLuxucwj2JT8NPG5Uw00NoELQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717669730; x=1717756130; bh=XnvRst57iskanhb14a9rF3ak8Xxi
	3kYkn77vMmFHDik=; b=W5T8bScWi35xudtGq9Rf2W9fk5VVVeW2RjOt/CIGLmpP
	5c0K9nFbWGVKA0S17ex2DkekTiFpqHMNaAw2pUQ06JomBLWZIvvJwuclNmrrvcgm
	JDWAzH8LCd+EF/Rf/GX4GylLvVILL0vBUGwPHp3Z22Qbnk6MBHKrT/7wzF2aAmOM
	PyPPvEXcY7m9KV8ml9EAWjbTDCmWTOg5JEjmHcmYAfdJbbTXX7UECb2++S8BKH0B
	SYKkau0CwlTZ/jurIs/8Qe6hfI06/7r/E1jIkpxviDyYn1QgDbZlWDq/rwaJlLTo
	PdFuFlsK8srjDJ/Ecqog0Z4tMqlBsX/zrkjGk4Y/Qg==
X-ME-Sender: <xms:Yo9hZna141_fH9Rputgn7CMtgHk0Hu6R7X01Y5dC26Go-FE4XQPcig>
    <xme:Yo9hZmZjuk2ZAKoBqpYYckeHzwCxxaVq-yQGGjdt-oDb4K5Y2pDlP-sjpSm-zodOU
    XQ8yt1OPjIWznK1aw>
X-ME-Received: <xmr:Yo9hZp9OEpuSORY4Oc9Kpmn-whga5HHThgDh6UcmGDTbgKASLIFMAF3f2sOJji2WF2rcJrCb2qMXQOxpE3Q7rhKmYqKmXO0V3xnI_YfAfp8Z4ZV3>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelkedgvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:Yo9hZtq_5RoMXGnctualxhIi5PfWqwL7c-IaCx0nqFD5boq6v1CCNg>
    <xmx:Yo9hZipQbANQOALKk1kUGCgUMW9Av5LsSD93UTad5l4Uf7aPWPfplw>
    <xmx:Yo9hZjR6wpgJZaKY_f1ItBvE9RbnnnIP4E0iq-UTGsmSGqG80xAsjA>
    <xmx:Yo9hZqpRJveA-xPky_e7lJifcVALueEu26IoGBlJAmtfJ8IuzH9ztQ>
    <xmx:Yo9hZrmrLGHiC__QDwJ2p81HSKJzah_gVBYJrtllG2KK0TUOLDZMKPFQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Jun 2024 06:28:49 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 9cd43a59 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 6 Jun 2024 10:28:18 +0000 (UTC)
Date: Thu, 6 Jun 2024 12:28:46 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v5 13/27] object-file: make `buf` parameter of `index_mem()`
 a constant
Message-ID: <69d904ddcec17519ee981a5db2a73f467c7e747e.1717667854.git.ps@pks.im>
References: <cover.1716983704.git.ps@pks.im>
 <cover.1717667854.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jHYp1sfo42F1oHfI"
Content-Disposition: inline
In-Reply-To: <cover.1717667854.git.ps@pks.im>


--jHYp1sfo42F1oHfI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The `buf` parameter of `index_mem()` is a non-constant string. This will
break once we enable `-Wwrite-strings` because we also pass constants
=66rom at least one callsite.

Adapt the parameter to be a constant. As we cannot free the buffer
without casting now, this also requires us to move the lifetime of the
nested buffer around.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 object-file.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/object-file.c b/object-file.c
index 6309b24387..2d5bd3a211 100644
--- a/object-file.c
+++ b/object-file.c
@@ -2487,12 +2487,13 @@ static int hash_format_check_report(struct fsck_opt=
ions *opts UNUSED,
 }
=20
 static int index_mem(struct index_state *istate,
-		     struct object_id *oid, void *buf, size_t size,
+		     struct object_id *oid,
+		     const void *buf, size_t size,
 		     enum object_type type,
 		     const char *path, unsigned flags)
 {
+	struct strbuf nbuf =3D STRBUF_INIT;
 	int ret =3D 0;
-	int re_allocated =3D 0;
 	int write_object =3D flags & HASH_WRITE_OBJECT;
=20
 	if (!type)
@@ -2502,11 +2503,10 @@ static int index_mem(struct index_state *istate,
 	 * Convert blobs to git internal format
 	 */
 	if ((type =3D=3D OBJ_BLOB) && path) {
-		struct strbuf nbuf =3D STRBUF_INIT;
 		if (convert_to_git(istate, path, buf, size, &nbuf,
 				   get_conv_flags(flags))) {
-			buf =3D strbuf_detach(&nbuf, &size);
-			re_allocated =3D 1;
+			buf =3D nbuf.buf;
+			size =3D nbuf.len;
 		}
 	}
 	if (flags & HASH_FORMAT_CHECK) {
@@ -2523,8 +2523,8 @@ static int index_mem(struct index_state *istate,
 		ret =3D write_object_file(buf, size, type, oid);
 	else
 		hash_object_file(the_hash_algo, buf, size, type, oid);
-	if (re_allocated)
-		free(buf);
+
+	strbuf_release(&nbuf);
 	return ret;
 }
=20
--=20
2.45.2.409.g7b0defb391.dirty


--jHYp1sfo42F1oHfI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZhj10ACgkQVbJhu7ck
PpS8bQ/+P/GBf+rGw0yq58i2zFULQHjkFNzupzyoaAbvu71lKkZfspQ9EHDCvQAv
fuN9prJR8Rz2UI+NtMdyHhBBhLC8YdgOev9A7RV304t4JFLwXXeBLCMSxnBxNK8J
Ke5g88/N1kyaNSp6EyCG1m+k6x8iINSXcXXq9AKmS4xcajXEHsJ8a5MvFFsoIb21
jaZdVybJZ05uFDrvcj4i21+qs3AGxAqeswKzlyCmnGLUx234SOv8rBLW5J9i9V92
val8ZT9oA7rYJ9uqcKMkqY9R8YIdfuSCtzzXdOE70U5PLEgp/u4ecNftTqNqdoaC
L0eb+NDnmmnbngBBY8xzPHG4LHOzCHf2mJWVovdYiTsrNOiVjhB8X4udWCJvt4uR
1W1eTXibevK0uZgyQ/DIFRyMV3l2fm7YgfnoqBlvCe8rddZYDRbH4dT/4anxr4q2
pDGiUlGE6QhKh4e+FQg1Jg7WWCdsylnlolvBRhLm9lHon+4WFtTfACj2CerV3qb1
QveW0EHpIft6ioUNr1+uO/LLF1wYcp1XCHKaJhqHfDnHWJg2eARc/CQkHwaeLA0/
Z5wbzM3qIuPMT0xLjTlKEOSYiFb34SSCNxAxRQ19SlF4cf3NTglk5YdIwTxJF/ik
hGHGKJm1HWJnE58r9FcWVqHHo8xyvJFcQVJcZN6kgADVhscH9Rk=
=/oAl
-----END PGP SIGNATURE-----

--jHYp1sfo42F1oHfI--
