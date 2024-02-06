Received: from wfout4-smtp.messagingengine.com (wfout4-smtp.messagingengine.com [64.147.123.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B99128810
	for <git@vger.kernel.org>; Tue,  6 Feb 2024 06:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707201337; cv=none; b=NlH0/DzpPPQ+mOQbSb7zjLcZ3X9Cq3AaLjpI1Ga/NPhLhlI/VjezoLxZ1DcbCDh8UFSlo71c4ptk9jzoL5rhgJ5iZECQzFiL6G0hdDDGJFDpQxIXHwppyv+o6ROuIsuREskvBGROAZECZTCOAsRve76MnWhBYh3ylRwTIRv9MJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707201337; c=relaxed/simple;
	bh=gJIC8e471W0GQiO2WwWC4u85WIbvRtBNL5y1D2L+Km8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kvYiGLftfnl3GYutnStFJBPXWbqo1tonqkdRtyAQ//VAxEC5S6sywS23JoEJVz+vhUO4KqKpl1OpJD0uOxjk4dspEzuSiXhvM7ldEiczEiD87iRS/VDnQymEuL7+KPlEPAI5PNKxQHlXyfJac5W2gbxOS8WfGJnGQFoVGeH8HRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=YlLtBfZL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=o68tnyrj; arc=none smtp.client-ip=64.147.123.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="YlLtBfZL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="o68tnyrj"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.west.internal (Postfix) with ESMTP id 0185C1C00079;
	Tue,  6 Feb 2024 01:35:34 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 06 Feb 2024 01:35:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1707201334; x=1707287734; bh=w0MbeE3MGv
	LdhudkaJRo40D6s7aVFQkBIeQ68+RVn7g=; b=YlLtBfZLs1ynfempHbULnpBuBm
	NKFoxwBW7u+CHtl4YlMXVv/IC6ozFwxn2Mbv/m1tgw+7DpnB2GDJjqhrluwlUZlI
	l75x71uaMYz0l53OaDR4SpjdHsb4JhZLLKrfenNNEQB42nd71WoY5SFYTUdhJvYw
	nO3OhGVZ238Xbiamiu9/2weqKiVgXqJIT6KSVbfkST0Q2Ob7jqh9Xol7Yxk7DNmY
	aGuJR7ilrBvv27dvsuGaze2+x64ZUXY38sofbhMgq4hw0NkNBw39sSLyeD90qmTU
	SJpkpa8WLzpLjXzPrFgH0juFOlKxF1o6LI1hNYKVaKcv13GWBqiVYHbbKJwQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707201334; x=1707287734; bh=w0MbeE3MGvLdhudkaJRo40D6s7aV
	FQkBIeQ68+RVn7g=; b=o68tnyrjhca3TvQktEwx2f15EipZ/gVtVo+FEMM//Vm4
	IaG+lF0NXaUjk8gq/MaxexB8iD6bXUfpAAvH7HsK/ZKosSpkjkEEeHULyH25HBpj
	l7GzfcyKppplM/hPkf81Qi7yVZlGGTC56KpRqOD2hMRvMhQsWdP/a6vxYJJXi55F
	qH4D+W+8uHPossWYajxzCCNf0e4FNGhQCbzx09tAFwJfdH+SF2X8i3YgSk/moAIU
	p8OG1A6MNVQB+KB2pksh6AIz3edV1jRR38Cqvopbo04B9tZfr/D4XcN26z0Asxo3
	gIJvgqN8LDA6eLHGRyEb7QgVjD/VnW+smR+alZojiw==
X-ME-Sender: <xms:NtPBZdyi9_yH6KDxHCMaAkJDDS8UcilLM-O8StpW8Bsoo5SUlvNkQg>
    <xme:NtPBZdQbiGQcb5SF1YDzl7jdq0U2WfMfmACC-Xrl_Z9FP13n42Lr-qVMeYlWCkZZK
    tP_BFXZUIKK4ObStg>
X-ME-Received: <xmr:NtPBZXWpxI3aB_-bUd4_JFj8s-Q_2RFNm21kK36IHMx0DzCddt9HY68RNW3DMdIveMWVNDzRQmbDJk-YGh3xUFaWrERXswS3Hap5dvjHmKbih5V4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedvvddguddttdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:NtPBZfiwuv-osSELKAwsW5E7I06n4EmeNlD14fDhGEWS0ppAFAutOg>
    <xmx:NtPBZfDtXw6WL6T4r-e8-uq0IWuVA896j0xng_GhyXeZbDPayR6ZjQ>
    <xmx:NtPBZYKLxEhSM970sCtmwRNud1sdlIkrO7GFzXRYhCEF2xpZVF7kRg>
    <xmx:NtPBZa7QXJJoZqJPw9U2Z4iUCZa2C2ldejeTcZh_cDWkHuywecGy10zmCVY>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Feb 2024 01:35:33 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id dae1357b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 6 Feb 2024 06:32:03 +0000 (UTC)
Date: Tue, 6 Feb 2024 07:35:31 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>, Toon Claes <toon@iotcl.com>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v3 3/9] reftable/stack: fix parameter validation when
 compacting range
Message-ID: <f0e8f08884769fef048997ef6ba2c8dd1633a1c5.1707200355.git.ps@pks.im>
References: <cover.1706687982.git.ps@pks.im>
 <cover.1707200355.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="895bV6IZQfIoyrA+"
Content-Disposition: inline
In-Reply-To: <cover.1707200355.git.ps@pks.im>


--895bV6IZQfIoyrA+
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
index a7b2c61026..1de2f6751c 100644
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


--895bV6IZQfIoyrA+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXB0zIACgkQVbJhu7ck
PpSgxg/+MqbtvzvFI8rB+Gh/KmUbGNH9yK3n9zSenAt1qefJpBFogbGeLo0Vz4Q8
rvzmpt6wQ4NkCx7reb3AxPbQxzhAs6otrEPBNi70gewCKMl6cGMvhK+pTSvQ0uTT
D/xZpWfJ3Z1lr60EMqGNk51SBXaFf2wQSojZKXFgu0ixOWn8AmCRhF/BuDl0WiaP
+0xxCEYBnxs2lylSAwDAcCVb4Fx5ZoIlMFCCPdKyi/R3a5xtAcPR5jU8zVKj/JyN
IKSZlbWiw9N5NL9+f9jdfg0Fhmfx9iFEk+Pff2g+egSdP8wv3MFvTjMt5Rou8nJo
RKogtRogMKvnokyfCbBz+4kK8iAr3SFzMfYIHg5CAIccXuy5J/bZTIzHn5TPaNmq
fatwsHuQadCipQCBVZ6Esb1wU1EhrnjBFLiOnw7xNLWyW8GOgaedGypl7V+NJCRn
gkUPp7B4JyyAbtr9n+P2nYqNWClEwgkpYDuvtraCc0XD05r1/0tcqInn6ooidC8V
YkVPOo/cM08Q7HFqq7uaVQ3BeS/PrgMiWIy6NwRzt9IqupG7JklGTIvCIeH4tkA2
sXkbf6LT8jjn4v/e7WIogbqmhCYvhptgyLiubDGbVYeIiC/GaRki0lY3NDYvAOap
A9Q8N+yQp5Vt/GRcY3TPYtdoWAeQecSavfvzim7BU4e9fXogHlM=
=ypQt
-----END PGP SIGNATURE-----

--895bV6IZQfIoyrA+--
