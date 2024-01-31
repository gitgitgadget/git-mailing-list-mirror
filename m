Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8CEF5DF17
	for <git@vger.kernel.org>; Wed, 31 Jan 2024 08:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706688085; cv=none; b=HIT8rRfnrwfQyLIfYdrPiGE5V+zx4cGtH6dCoFwdR62qodZKeYMZwmSiTXoihFPRT8clsZ0pYMBmy/YlK06VHE61YFkubZRklurqtfYIV8f5rurQsNTn3/h8SzLxBV0S9JdTMUUBQ0BHJ66W7YWwFIVET4cN58GaJdpSveoEonk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706688085; c=relaxed/simple;
	bh=4nB/NsZP/xYrzYmKfNzHdV/3nm71/H1xcUlc5rygZxM=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nPP5OdyaNJp6nNTdcD2mVrbJ5JxSkw+JElOTmExjPc8ZRhX5cO/w0jVVtKHOGa6qzpMdQw9M4ruvXa013J+1YCN+rYuorrDpzCjmMAoX6F3K6Bajmlu66SHmpt4hs7Do1oagIKzEFYd3FDAKKCSS0wxqsF9lytVqa+/35fH/iFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GIdGwD+N; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MD3JqVQ6; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GIdGwD+N";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MD3JqVQ6"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.nyi.internal (Postfix) with ESMTP id C90361380055
	for <git@vger.kernel.org>; Wed, 31 Jan 2024 03:01:22 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Wed, 31 Jan 2024 03:01:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1706688082; x=1706774482; bh=mt0GRmci8m
	rza66qAbRK7bruz6akpl9rEp7CbueN0mY=; b=GIdGwD+NlKN3g3urVs6Yw/ztH/
	l8VFNcztOdMG7U7jVKKcn6+kDO8pn+a4AZYiKF/HlmyWOe5Y4zQT3JsUOQu3NsW0
	PXKGl8HcRwU4NwtmZQz/eYDR3rsRJvW9Y4/PQWMbWYs6UfTMVHqgl9apa1TuBF0c
	fosc+oArf0ITlCX7pHmjp0BeInUGTib0aMLL9THOXn0Jv1XjUR4cayTL53t4gpwq
	beweKarcRM442g3QSRAQKGbN6qfcC1SPSDz1v4SOh4EnNuK5U/YozItsdKGytxAX
	DaBl0diEwZ7oQViZx0xrK8KKh2FBCkLad6GPwFwVht3WwaCtMG0/s6OWs4jg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706688082; x=1706774482; bh=mt0GRmci8mrza66qAbRK7bruz6ak
	pl9rEp7CbueN0mY=; b=MD3JqVQ6xoRaYt/b5AajelgPv5mz/lnlwlqhpnObM+9Y
	fEwtEAJYguB8hoU4gkDIpwaoYZDmPvbKDvq4SftCFlFV+y6M9HEP7tHIjQwIXEJJ
	cQDI3/pODR//wixVUfgtfE6/JhERN9ZF0kGArEVYqNOHKZOwgP7oMIBBHXuDgg3J
	SKL6Ff8vzNzFsPjW1PvMd2feuzj560m8bI5+LAKK5hHEVLovFlLcHGwQehh0jyHF
	hU2dbr7SpsJfubg2BhdzoAIVRKy36TcYv2Nfp4rkKBJniyOUOoAN9PmMicCPFVE8
	krQ2zAL1JeDEEydAweKi69aNOKar3AreGEc5hqT89g==
X-ME-Sender: <xms:Uv65ZdZ03oFhJ4yksNBPg0OVWRC7WDSQHodhBxzzcZBDJqPm3r1ewA>
    <xme:Uv65ZUYf7rk6JWSDJYWgsr9zU-9Hq60PfWSs9y5Eq7WL3RnONbj64AJP25YTG_eq9
    f1_iH817aQSuojjWg>
X-ME-Received: <xmr:Uv65Zf-MZJrwRBO945L9jgtvlrMH0G8epyPZ8IM6ddi9cJaPMpQOqvPeiB-TYLWdJtxFKjIH00KX-yzBjZKCwCPmeZ0ZgiFgUOaA1haEnPQsMXA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedtkedgudduvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeehgefhtdefueffheekgfffudelffejtd
    fhvdejkedthfehvdelgfetgfdvtedthfenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:Uv65ZbqOdHWpa4kBUFiKEo4KJTarvw2UevFCGc-QOkvKbuQ5jTRN8g>
    <xmx:Uv65ZYqll9Zn-bFi-hrq0-kWu0BA36IZTsRvU6obwNtS71ve1XvgPg>
    <xmx:Uv65ZRQUamUioaGRw54pYDVIWQ1krqCcO26SZi1CA3-U4zt-WcqTEw>
    <xmx:Uv65ZVD35MrPY5tgk4Md8hT3iHhzJuOFYaEkEECE-6W3wqjtEu8tfQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 31 Jan 2024 03:01:22 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e771f8fa (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 31 Jan 2024 07:58:02 +0000 (UTC)
Date: Wed, 31 Jan 2024 09:01:19 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 5/9] reftable/stack: use `size_t` to track stack slices
 during compaction
Message-ID: <2f6a69aa14ddb865548bafa5f3005d0579ea09f9.1706687982.git.ps@pks.im>
References: <cover.1706687982.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="iWSSeUxz/RLfoIur"
Content-Disposition: inline
In-Reply-To: <cover.1706687982.git.ps@pks.im>


--iWSSeUxz/RLfoIur
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We use `int`s to track reftable slices when compacting the reftable
stack, which is considered to be a code smell in the Git project.
Convert the code to use `size_t` instead.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/stack.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/reftable/stack.c b/reftable/stack.c
index 2be3d1e4ba..c1f8cf1cef 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -24,7 +24,8 @@ static int stack_try_add(struct reftable_stack *st,
 					    void *arg),
 			 void *arg);
 static int stack_write_compact(struct reftable_stack *st,
-			       struct reftable_writer *wr, int first, int last,
+			       struct reftable_writer *wr,
+			       size_t first, size_t last,
 			       struct reftable_log_expiry_config *config);
 static int stack_check_addition(struct reftable_stack *st,
 				const char *new_tab_name);
@@ -820,7 +821,8 @@ uint64_t reftable_stack_next_update_index(struct reftab=
le_stack *st)
 	return 1;
 }
=20
-static int stack_compact_locked(struct reftable_stack *st, int first, int =
last,
+static int stack_compact_locked(struct reftable_stack *st,
+				size_t first, size_t last,
 				struct strbuf *temp_tab,
 				struct reftable_log_expiry_config *config)
 {
@@ -864,22 +866,21 @@ static int stack_compact_locked(struct reftable_stack=
 *st, int first, int last,
 }
=20
 static int stack_write_compact(struct reftable_stack *st,
-			       struct reftable_writer *wr, int first, int last,
+			       struct reftable_writer *wr,
+			       size_t first, size_t last,
 			       struct reftable_log_expiry_config *config)
 {
 	int subtabs_len =3D last - first + 1;
 	struct reftable_table *subtabs =3D reftable_calloc(
 		last - first + 1, sizeof(*subtabs));
 	struct reftable_merged_table *mt =3D NULL;
-	int err =3D 0;
 	struct reftable_iterator it =3D { NULL };
 	struct reftable_ref_record ref =3D { NULL };
 	struct reftable_log_record log =3D { NULL };
-
 	uint64_t entries =3D 0;
+	int err =3D 0;
=20
-	int i =3D 0, j =3D 0;
-	for (i =3D first, j =3D 0; i <=3D last; i++) {
+	for (size_t i =3D first, j =3D 0; i <=3D last; i++) {
 		struct reftable_reader *t =3D st->readers[i];
 		reftable_table_from_reader(&subtabs[j++], t);
 		st->stats.bytes +=3D t->size;
@@ -963,7 +964,8 @@ static int stack_write_compact(struct reftable_stack *s=
t,
 }
=20
 /* <  0: error. 0 =3D=3D OK, > 0 attempt failed; could retry. */
-static int stack_compact_range(struct reftable_stack *st, int first, int l=
ast,
+static int stack_compact_range(struct reftable_stack *st,
+			       size_t first, size_t last,
 			       struct reftable_log_expiry_config *expiry)
 {
 	char **delete_on_success =3D NULL, **subtable_locks =3D NULL, **listp =3D=
 NULL;
@@ -972,12 +974,10 @@ static int stack_compact_range(struct reftable_stack =
*st, int first, int last,
 	struct strbuf lock_file_name =3D STRBUF_INIT;
 	struct strbuf ref_list_contents =3D STRBUF_INIT;
 	struct strbuf new_table_path =3D STRBUF_INIT;
+	size_t i, j, compact_count;
 	int err =3D 0;
 	int have_lock =3D 0;
 	int lock_file_fd =3D -1;
-	int compact_count;
-	int i =3D 0;
-	int j =3D 0;
 	int is_empty_table =3D 0;
=20
 	if (first > last || (!expiry && first =3D=3D last)) {
@@ -1172,17 +1172,17 @@ static int stack_compact_range(struct reftable_stac=
k *st, int first, int last,
 int reftable_stack_compact_all(struct reftable_stack *st,
 			       struct reftable_log_expiry_config *config)
 {
-	return stack_compact_range(st, 0, st->merged->stack_len - 1, config);
+	return stack_compact_range(st, 0, st->merged->stack_len ?
+			st->merged->stack_len - 1 : 0, config);
 }
=20
-static int stack_compact_range_stats(struct reftable_stack *st, int first,
-				     int last,
+static int stack_compact_range_stats(struct reftable_stack *st,
+				     size_t first, size_t last,
 				     struct reftable_log_expiry_config *config)
 {
 	int err =3D stack_compact_range(st, first, last, config);
-	if (err > 0) {
+	if (err > 0)
 		st->stats.failures++;
-	}
 	return err;
 }
=20
--=20
2.43.GIT


--iWSSeUxz/RLfoIur
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmW5/k8ACgkQVbJhu7ck
PpT9pRAAlWV7occSxvuydWALiuLFoq6RQ8SU8HEuDO/8/512l4rVjcl6xtvMtK1R
PGR8IECtjqVfRhcoMNd4o0Yfm2Srfr9jeaLzSaDRycAw21lFSAVShdzZ6xdngrhS
0RHVN373nr55fdbZQU/UgppJb9Wfj+M+p8GQnDC4Hf/6fpT8mnhhjvwdHY1RTQYa
kn6SaT4yWXMNDFIlGLR2nVztCXs6cVQyv65Hff2sDp5wdwHcLI50PBeuClB5r68e
HXgi6BbcVw2+ht9bsL1/rqujyWWPlc6dPAATv+99EqC2P89N/BDg7EKGsMfGyZ9j
KpkJCa/zPKEKKj+WLsiQRV036nwpL0QJMQi5Jv4TTqHeCy7QblXwY44e38A9ZgSE
phgWrIVnunIlia5k1dYd/y+1pvuVvLLtR7N1nVjIaWbnZyXMGxBlUzMC86VLjK1O
cOCPJDvhBg01GR66gZDiWBekSnt4BeofQ3dpNcEOt7PbDXF+wGgT+ublss5ZXmW7
WNKNmutjBYVg4KVZkAjxL9EwraKBOjd/BAkXNi7V+zQPvTkH2UgVvm9WePA6O35L
jaW6fR4RsnmVJahGAhvU7XXEvsnaaP+d71kJX3ibKyaBDxVuFBciz+mkLTEnTKE5
M9gJiBCPufW4P0DPLd+uJjZXhwanFqQevnE0strJKw8vY7auT6s=
=19k0
-----END PGP SIGNATURE-----

--iWSSeUxz/RLfoIur--
