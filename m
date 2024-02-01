Received: from wfhigh3-smtp.messagingengine.com (wfhigh3-smtp.messagingengine.com [64.147.123.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5859D15A4A7
	for <git@vger.kernel.org>; Thu,  1 Feb 2024 07:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706772796; cv=none; b=YOejrXFNpcXvQzWB5CwzIfWYHL/qilTzHoXx8lZYGAqOFxdl8wzNzfVIfBY1mWty+zRNPmtTwJ8utjsEiRo/EPO72pfOgt+qxjkugZNpvqTJAXJxRpMdib86k3EAqxpPNyw06p1s7Lch/yKENkIjdVoEEAyuKi5f2CQXmi1rc2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706772796; c=relaxed/simple;
	bh=ruDhRxZc6F8BM6ntlIo/OFLidJLUQkESiFAA3ssUS5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B+oV8p8/NkOZVDZ3XylRewd/lgzo9wv5SX/nfuHFgqtesRbVDBAydhqwzUuDkPH+SVC0PP34zJ4OFb+YUk6vrQysgiurdNuwMuaGtLvZ25+kVy3hBNsPy1Hy7UdJTokgfLSH0wVuja+qvAC/KqQKfxzAG8o6OI64z2M3/ex3xFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Rh/sv6Zb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MzXZPZnO; arc=none smtp.client-ip=64.147.123.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Rh/sv6Zb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MzXZPZnO"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfhigh.west.internal (Postfix) with ESMTP id 6CC6F1800085;
	Thu,  1 Feb 2024 02:33:14 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 01 Feb 2024 02:33:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1706772793; x=1706859193; bh=UfhdZo0+dM
	Tvae4WJbNZZY1yLMuG3ZBzY42wlaRwnb8=; b=Rh/sv6Zb538FUeDoukasaN3aW8
	EZxXAn2IofRGJvMb98nR5METoqT735RcHuEHywheb6w5E6eLkAwwlr2ZKSCzb7io
	Ne7GjA+KnaK+Lyd/e2QFLipmDw4rxke6y79wsI5eY4sZ0F+kbAYCRlr4HItGTYcm
	OLmjkufpKBRRhCCB6s2fxdL7igDL13LpkHWeqcIp7EJQQSHMbqQNgUTOC9w3oO2l
	SF2V3FPrUqpCr9HG6pnBRQKE82/vt/JdIEqwvnpl3X5S64arTkDMfyJFCOvsXqJf
	TR3dyvn66G0dLZFKH25gDArNjDUNROfFuDT4qmM53WLfGO23Eet+j4I52u8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706772793; x=1706859193; bh=UfhdZo0+dMTvae4WJbNZZY1yLMuG
	3ZBzY42wlaRwnb8=; b=MzXZPZnOlqmJ7pfzp/qzfNppckVOPDXPB5JDGqJbC6Sy
	o8lsoyq6gpRwvp4Zf6UUgybfDVFzfm+t/B3ksu4smglkwFMjvt1sHIUkeCgkIbQo
	qE9CqOIvR9xifcAEwWYmrFeq938t0KcyTeSvspiSNUzbfPtgiled9gVUGMdEz9H4
	1PVV6kpFPHQxFXXS+DPhX12W1L32DccUsnr8hIQdYBSrBh6UoHlVwRUvYm3pfTxr
	NLXJU9Eke3ZvXt8Pbd1agCKPO9pR8mJlECXwug2nhuD+Gl33jTXwId6CvuDxirBn
	V8vK5jnoMA3knjwzF0BRU98QD6nTAYvDx4gkyRkBXA==
X-ME-Sender: <xms:OUm7Zaf7hnqpLmd07Thi5t9l2JWxNAYNeXQecS3WIWVsoZiPoUUf6A>
    <xme:OUm7ZUNMe4krGg5wsr18V4_FPCKvuJfq23-iYEVO_FP6F3dv2McRZ9BcV3rN6JMA0
    J8wJssc4W1guLFsnQ>
X-ME-Received: <xmr:OUm7ZbgCKK-e1rMfUZKQ2T3iuyViIf1wgxx2n1Hi5t9LIOqiheGIyySUanfoIYx3_tpzgQUZSZHmdyMCuMGmg8FMYWNe61hGymA90iyH_ZYjbg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedutddguddtjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:OUm7ZX_k_dxuQZjT_yBhm8X0Ade8QqOUyLH1zJDLTwrIS9FKbiL3PQ>
    <xmx:OUm7ZWsovDYYczAXbIBadHASU6hPesoGWYhB9XxjFctp68KIBFtAfQ>
    <xmx:OUm7ZeHz9-cRpR3ecGHJy4AQ0LBrMLFCU9FaHZe7ia-Jqr_XpZq75Q>
    <xmx:OUm7ZaKUnMtFAA_HExhr1wr1hdL9kCkF93cpWUZPSBbRJ2xCIXgYDcXveXI>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Feb 2024 02:33:12 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 864d3d73 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 1 Feb 2024 07:29:50 +0000 (UTC)
Date: Thu, 1 Feb 2024 08:33:11 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 5/9] reftable/stack: use `size_t` to track stack slices
 during compaction
Message-ID: <a5ffbf09dde32fcc8b2b9198875a82813b3de0ed.1706772591.git.ps@pks.im>
References: <cover.1706687982.git.ps@pks.im>
 <cover.1706772591.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mGWmrwhTQsmsmXsF"
Content-Disposition: inline
In-Reply-To: <cover.1706772591.git.ps@pks.im>


--mGWmrwhTQsmsmXsF
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


--mGWmrwhTQsmsmXsF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmW7STYACgkQVbJhu7ck
PpTLFg/+JW+vsMNQ0mmNAGK1/6uqQnkBwecOSKex0bCN9ZV7/90wtn9F1wUcXttN
oPBO5FNfLoGJvWtzcqPl6+tCCSl++twoUWq49EB9mF0t27/J9wX34/aNkiGXbBYF
puSNbnv1o9bPpRcQJZDWm3PCTIMPXXdcT2cwVGV8+4jZJetwNLjjp4YWZhEtsiXr
cjkQQv3ooEF7fRN26uoCcOCU2UT+X7itFK6plQZxgr0lZdMovwYRWy67pRm3Uaon
MdeJ+rvT9ao/GhUtpfUjDQdD83/O8g5ot/WGX6OwS6Xvi4xwkfgnVo4RtH7vipl3
/y0EH4ULvuPo2/k1nO6rmk2towKA35BiPa614p/DLSD9m7TdUSQb/ACqzgSxavqw
ObgL0Kf23VBp9h1P3ZYbJG3ijfvQeda8L84c3i93MOSaeUwc+IWtj9iIDp8WJiHR
Kz+r3fpiuGzxjxhTQlXjyvfUE8sDUpbJu9/G357dQ+5fG7MHSN+ftiK0heXCjC+/
EwCE+NhNyrn3fR2wCHOh9G0Bg2agYqomRsDhHmLIgEBHyiXyogVHj3lySto4rwOc
A8uluxJPTN2vBfk0RRq6Y4T/hYI5aFWKmoG57MH3l0EffJSVsKZadLzWWc0gm7Wo
cEgvKG4KkwVe8JeZWnqtoGeFxs406H8jgbJBPIGKKQuANQi58Xg=
=XE+d
-----END PGP SIGNATURE-----

--mGWmrwhTQsmsmXsF--
