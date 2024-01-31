Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D08B59149
	for <git@vger.kernel.org>; Wed, 31 Jan 2024 08:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706688078; cv=none; b=NEFo2DXg4SfJkZs7AZuC2/368UMiCP3c1HwSgUjQ66Y8BeBDgspJ2KDBf1geyVgylFRoDjpe8aH4ULFIcwvCRnp5edQeuv9X+gJ9dS8qR40ef4k6LRkhwFms05bUPNlTTT9RwT7O4rdd6+Ttp3YqZVZtD8yNIgGOYaK4ofz5aYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706688078; c=relaxed/simple;
	bh=G/biQ/V3dor4eyT7nJxcuS5TfgRNoAuDAyjTXCcNPyo=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=idRhU1c9GL9n13LqQSbZxWUAaZNH4xFNj+blQYW2ULwbK/bjVngt6FhAuaAQhJkopR4rvrB0MC+WnBbuNEOpddsThhMcjzB/DWpKB/qIo29PrUQLTypR/0jHKc10ZZVcoRY1Io/vA4GLMhIIRPy69ykxMhpc5B7NUbIar/Xuc3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=onx4a92h; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=deMPPExJ; arc=none smtp.client-ip=66.111.4.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="onx4a92h";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="deMPPExJ"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id DFCA75C005F
	for <git@vger.kernel.org>; Wed, 31 Jan 2024 03:01:14 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 31 Jan 2024 03:01:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1706688074; x=1706774474; bh=cTjH54JZp9
	inPl1mxR7p0G9wgwhDutk8HiItgwz3F/I=; b=onx4a92hJXivwemcBss1EUHLDL
	xbfyRL8zuCvnyVWJSte9BQl+nI6nqAXUWootnZHJHvyfzlBJ9KnJMrrV2H0LCiTl
	nq/fovp9rhwols3jx/toXFNfhvwbdKM8jA93W/dK3zkBCfk/FgrY6UdHHDasZH04
	9/MMD2/70cn+tNnyiIjLBNT4uYsSTOSA+2r3FBC26rtEgEhSMRJqPnrf8JIwZvX/
	4EWZGeff36ltDKodaNGfE5r04kTqvvBnIr+e6WC6/BnbHTp0m8MAVXRWHe14rpEI
	xdOlv4Ch/Ob/ViklGA2tsEP0zsKl4wjsidU9QOkBxqKDQfHuGhtd1B3097jg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706688074; x=1706774474; bh=cTjH54JZp9inPl1mxR7p0G9wgwhD
	utk8HiItgwz3F/I=; b=deMPPExJOIDhxZRp2V/g2uQBPc+5vzWLrH/ZQHIj/ac9
	Bv0eFKqdrIO6gM258RNatTWCSNWncVG02oyIZCEaYev6ESdaTZOkKClgZEkXaNve
	M+xRkE4JJNZMouztT9wRTkBN9sKYEJahWnbQq5vN46Mk7TLxhlhWrjpN2rR3wI+7
	pG2h6NJYixM78XufeiMZE5hTtmmn5luuttwc8nSfuLXA8ln4aSOW9hn08vR1D4Zg
	FGda1z4RDWXNpjThfUcNGXSj+5OpTgVIb2Iqp0Og85+ML/LCePQnOLKfaXfl8Wrv
	9cxuinFzwlEyxdcWQhE4nwudDBJCEm83O8KOEBlBog==
X-ME-Sender: <xms:Sv65ZRizF7Cit4pNIAE1p_WZAZ0TOp3Etw_j5I7AGjo81BfhB8Ab3g>
    <xme:Sv65ZWDtFHdhxJX7BKHQYO5R9lgBGCEc8-BvrwavTvtJIHcHeUYsnHqsd6i5LOmSZ
    M40AHWMtK83EuUIAA>
X-ME-Received: <xmr:Sv65ZRGqDY0Ff_PLypyvOXE4CtxuBA74bmV23A6bZeW6jyMYOLjV62qUPsLpG0pxzBW2pxBsrM6MlEbup3lpCcqc0-RW0Bkgl3Zsn76f3K22-Xk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedtkedgudduvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeehgefhtdefueffheekgfffudelffejtd
    fhvdejkedthfehvdelgfetgfdvtedthfenucevlhhushhtvghrufhiiigvpedunecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:Sv65ZWQbLCDAM5_sn41ur07nD7WaQ-xTXfECMRjGgaUAORS1V8dOQA>
    <xmx:Sv65ZexF14eNmkSAmpoUA_AyvHE5jk4x-IRow6DbuqcaUDynCw7Sig>
    <xmx:Sv65Zc5p8d3188V6dgDJiKOM5cS5YnSuurPXA1h4UAAVB1enJG1ztw>
    <xmx:Sv65ZUaYJff_LfM51d9sqDJWqYkREE16J59nP4P4wO28VtpBeAoSxw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 31 Jan 2024 03:01:14 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 03f54737 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 31 Jan 2024 07:57:54 +0000 (UTC)
Date: Wed, 31 Jan 2024 09:01:11 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 3/9] reftable/stack: fix parameter validation when compacting
 range
Message-ID: <e2d05f7c385fd9ec23b1dbb8cc273c97505444e4.1706687982.git.ps@pks.im>
References: <cover.1706687982.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8o/nBQQfv5CV9Rua"
Content-Disposition: inline
In-Reply-To: <cover.1706687982.git.ps@pks.im>


--8o/nBQQfv5CV9Rua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The `stack_compact_range()` function receives a "first" and "last" index
that indicates which tables of the reftable stack should be compacted.
Naturally, "first" must be smaller than "last" in order to identify a
proper range of tables to compress, which we indeed also assert in the
function. But the validations happens after we have already allocated
arrays with a size of `last - first + 1`, leading to an underflow and
thus an invalid allocation size.

Fix this by reordering the array allocations to happen after we have
validated parameters. While at it, convert the array allocations to use
the newly introduced macros.

Note that the relevant variables pointing into arrays should also be
converted to use `size_t` instead of `int`. This is left for a later
commit in this series.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/stack.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/reftable/stack.c b/reftable/stack.c
index d084823a92..b6b24c90bf 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -966,6 +966,7 @@ static int stack_write_compact(struct reftable_stack *s=
t,
 static int stack_compact_range(struct reftable_stack *st, int first, int l=
ast,
 			       struct reftable_log_expiry_config *expiry)
 {
+	char **delete_on_success =3D NULL, **subtable_locks =3D NULL, **listp =3D=
 NULL;
 	struct strbuf temp_tab_file_name =3D STRBUF_INIT;
 	struct strbuf new_table_name =3D STRBUF_INIT;
 	struct strbuf lock_file_name =3D STRBUF_INIT;
@@ -974,12 +975,7 @@ static int stack_compact_range(struct reftable_stack *=
st, int first, int last,
 	int err =3D 0;
 	int have_lock =3D 0;
 	int lock_file_fd =3D -1;
-	int compact_count =3D last - first + 1;
-	char **listp =3D NULL;
-	char **delete_on_success =3D
-		reftable_calloc(compact_count + 1, sizeof(*delete_on_success));
-	char **subtable_locks =3D
-		reftable_calloc(compact_count + 1, sizeof(*subtable_locks));
+	int compact_count;
 	int i =3D 0;
 	int j =3D 0;
 	int is_empty_table =3D 0;
@@ -989,6 +985,10 @@ static int stack_compact_range(struct reftable_stack *=
st, int first, int last,
 		goto done;
 	}
=20
+	compact_count =3D last - first + 1;
+	REFTABLE_CALLOC_ARRAY(delete_on_success, compact_count + 1);
+	REFTABLE_CALLOC_ARRAY(subtable_locks, compact_count + 1);
+
 	st->stats.attempts++;
=20
 	strbuf_reset(&lock_file_name);
@@ -1146,12 +1146,14 @@ static int stack_compact_range(struct reftable_stac=
k *st, int first, int last,
 done:
 	free_names(delete_on_success);
=20
-	listp =3D subtable_locks;
-	while (*listp) {
-		unlink(*listp);
-		listp++;
+	if (subtable_locks) {
+		listp =3D subtable_locks;
+		while (*listp) {
+			unlink(*listp);
+			listp++;
+		}
+		free_names(subtable_locks);
 	}
-	free_names(subtable_locks);
 	if (lock_file_fd >=3D 0) {
 		close(lock_file_fd);
 		lock_file_fd =3D -1;
--=20
2.43.GIT


--8o/nBQQfv5CV9Rua
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmW5/kYACgkQVbJhu7ck
PpR/bg//aW3XcIXpklq8aZw5fsUw6GJcXlB/qOJi3QdOmNydH+rg8+HpPamKSE6H
9vQpAn0oGWfupNz28ZhJX8HyRPzTB9ZRoJDkyBrlw3nnQ1+iPZpwLnVzIvdok18/
lvnIsnn7A6jadrvAIrm/Fqx4lUamVIhlXjJI4UnOqs6C6+jz1iTmebVjS3G8oXSE
cSFoll465+Gz9QdpQsIeNHPfyxMrKk100APIjAdqydYq6FcV/WAfq9EaiRTZFENA
eJelEkI8aUJdxmljEkueoJ1DyjkyrJO+dfX/rOxuBrljh1NI60JXZv+t763RMeOO
z4/k6KnfldtXUqF6UILVdzb3YNR/53o2gK5ryIl0uUL7LFK/S3tAcBF7iFyugGPo
V7t0zYx5lg1lM8R7vt0Qvp/ii4F+x1hP2/65Kj+MFx7LaPBxAP88SRFBxxrGJbb7
S3mk1TywmQEfQd8GD2qeXkqNBYPDMdjgiA5k7LVU6uWmcFOJmbfdZljTLo4ZrXaf
ZZ4hn7HvATyyk7c34nVBYir/f4USpbRpoORzQlZ1UAZrX79cxhYtT6lt2qmxIqOC
iS4dzIWwbuI/hnbRoFElfmAvow7Y55Z35yFXVeCM7/8bOpWAxJIH+LF+Mjl/eiij
Shm8gyKrWBldRNT8JotzcKnqm79GO5bwxdADafdo+hvDhO5nOeQ=
=aOZZ
-----END PGP SIGNATURE-----

--8o/nBQQfv5CV9Rua--
