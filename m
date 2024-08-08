Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7EC1EEA9
	for <git@vger.kernel.org>; Thu,  8 Aug 2024 13:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723122322; cv=none; b=Gdzt/D6FlfUpTOKQfOqUHVnRlGJyDtBQgD+unv5wbyvouJ2SSAfJtXlQRcOfqsid/7qHmsfNfhtYSzOVsilhFzMt8OeIJVrfF3eJ9qH6WFM0t+bI36feZ7LBd2/jo4JuFVjVNP82wXPE6KfhrY5kxUFXZ8uJiABEPuyNsRdi0eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723122322; c=relaxed/simple;
	bh=YkNUPnukO+LAwYE3miTCQlN5SqlGB1MUUlG+dOzSSEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SM3Z8GpricU+4jE1o8Cil3GOrW8F9Ekrf6ZdGEsPgmIKrgcoCFbIEMt7N22gi/JASOv1in8CATIMAVhNxILt9IcPwKpqL0QGQuCIBtnZY3osb1IA8WQNmfRFy1E/Xr0CYygOC8fTD6Yr1FW/gVRBgGC2jXeKu4zpRFOlQ2dZNP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=oOTILM/E; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HPisMOM9; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="oOTILM/E";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HPisMOM9"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfout.nyi.internal (Postfix) with ESMTP id 4AC6D138FC3A;
	Thu,  8 Aug 2024 09:05:20 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 08 Aug 2024 09:05:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723122320; x=1723208720; bh=y7T9YAxF68
	Rx/lcy5gU0XHzWcJspUY4UkFg+NAkFM6c=; b=oOTILM/EfBAJgPcmAuCP9ctNHO
	WoHmn85SXtdF4TV839+z3UFUp/9nq/bYMX8CvVFHKOXVMx6nBSnsbu0CLtz+8TtU
	xGzYAtzbb9+ImvdlMtfHTyiDQWKHtKeUzBfRoTqIEe6kQWfepS3QHHcWLEru+i7A
	zRLW+L472DIOqBGLaRHOvX1I4VCduw55UMApCkqZ91UFA/7I1ByATPm47MA92mAp
	xtPxKC0RkX/EkSbnOBLfFN4Mwntv2iK92pABKEPhFYzvjcnViGZFK0QR4S/Flk1+
	lWH1R+xi5G6hd4nozlyX3lZKGJEFx1OsA5pK2Ou9HXQAqK+pucjGohI+rEhg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723122320; x=1723208720; bh=y7T9YAxF68Rx/lcy5gU0XHzWcJsp
	UY4UkFg+NAkFM6c=; b=HPisMOM9dzK+H2ewgApMqi4XGcSf7BJUV3m+1WcVi3Gv
	Hpar9ps7gvuA3/OJxGGjW35m02f7DswauFYxqJyAqPJMSCt+EYApqefYMbt+67sP
	jk0A0GDDefDpHdqwC7M637zjEYZqW2VIGbLdftCGMQUsild6bE5mYEELzj3fiD5k
	byKd4aVrQg3oPuicoz4ijioDTHjSQtGgd7l4RRF5IwTDdGX2H/txIKLa2fYfc6/4
	LYnqkdUcv1wPq2/zj5qq2Yuabsvt6HtdUuYSx5lS0x4TBDcOQOG5GAcEsmBA1nS6
	8/OpzpQYMrzfiPrr7Y944sJCN3IEZzhzUg9XPJ0fsA==
X-ME-Sender: <xms:kMK0ZvBFD3bGoDYZZM7N3DOByYQ_80Ubwqc8hwNVPQl43NHRvl_BpA>
    <xme:kMK0ZliDjN5YP3uYLuRnPRg83IWr2YcXrUgWXc6hfCjOkSNuXsBWpPE0a3bFrQEFY
    RE9jRNvVXCPAnfX-Q>
X-ME-Received: <xmr:kMK0ZqlUVVwX-i4kVYdaSD3dzR1pvGcAVxkTNacXQXV-3m5smnGzlFuadJIeOwpPOAwdP4_0IppHOgetKhrNqDajT1NXozBhMyvp6PxtwJVSm4ru>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrledvgdeitdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeeh
    gfeltddtheejleffteenucevlhhushhtvghrufhiiigvpeehnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphht
    thhopehjrghmvghssehjrghmvghslhhiuhdrihho
X-ME-Proxy: <xmx:kMK0ZhxOFNmJr2573MplFLaADDGxqkJH4ZaVKuS-i5fW00ESx2aULQ>
    <xmx:kMK0ZkQu5jEu2GKEqrePmqDo24Th8Faa7xRjLU7MIhAV4zciFJs6-A>
    <xmx:kMK0ZkZnKSzKO_eVvPudAN5j5Br2rzsLl6idaZmZvPDZ32oEB0sqzA>
    <xmx:kMK0ZlRuj1sy_1t-GC-DLyLsgoTuXEI6PkggbWMGQAEOSqh3_zuuTQ>
    <xmx:kMK0ZqcvQbU95mxPLC0gbL2ww4olZaDQorFyDV4-rL9sPbESmAK46u1G>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Aug 2024 09:05:19 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b62b6b85 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 8 Aug 2024 13:05:11 +0000 (UTC)
Date: Thu, 8 Aug 2024 15:05:16 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: James Liu <james@jamesliu.io>, Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v2 10/22] builtin/notes: fix leaking `struct notes_tree` when
 merging notes
Message-ID: <c886b666f72637fbc16e5c5ec0b2a05718328866.1723121979.git.ps@pks.im>
References: <cover.1722933642.git.ps@pks.im>
 <cover.1723121979.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Q3kHePocmPcVsDwW"
Content-Disposition: inline
In-Reply-To: <cover.1723121979.git.ps@pks.im>


--Q3kHePocmPcVsDwW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We allocate a `struct notes_tree` in `merge_commit()` which we then
initialize via `init_notes()`. It's not really necessary to allocate the
structure though given that we never pass ownership to the caller.
Furthermore, the allocation leads to a memory leak because despite its
name, `free_notes()` doesn't free the `notes_tree` but only clears it.

Fix this issue by converting the code to use an on-stack variable.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/notes.c                       | 9 ++++-----
 t/t3310-notes-merge-manual-resolve.sh | 1 +
 t/t3311-notes-merge-fanout.sh         | 1 +
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/builtin/notes.c b/builtin/notes.c
index d9c356e354..81cbaeec6b 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -807,7 +807,7 @@ static int merge_commit(struct notes_merge_options *o)
 {
 	struct strbuf msg =3D STRBUF_INIT;
 	struct object_id oid, parent_oid;
-	struct notes_tree *t;
+	struct notes_tree t =3D {0};
 	struct commit *partial;
 	struct pretty_print_context pretty_ctx;
 	void *local_ref_to_free;
@@ -830,8 +830,7 @@ static int merge_commit(struct notes_merge_options *o)
 	else
 		oidclr(&parent_oid, the_repository->hash_algo);
=20
-	CALLOC_ARRAY(t, 1);
-	init_notes(t, "NOTES_MERGE_PARTIAL", combine_notes_overwrite, 0);
+	init_notes(&t, "NOTES_MERGE_PARTIAL", combine_notes_overwrite, 0);
=20
 	o->local_ref =3D local_ref_to_free =3D
 		refs_resolve_refdup(get_main_ref_store(the_repository),
@@ -839,7 +838,7 @@ static int merge_commit(struct notes_merge_options *o)
 	if (!o->local_ref)
 		die(_("failed to resolve NOTES_MERGE_REF"));
=20
-	if (notes_merge_commit(o, t, partial, &oid))
+	if (notes_merge_commit(o, &t, partial, &oid))
 		die(_("failed to finalize notes merge"));
=20
 	/* Reuse existing commit message in reflog message */
@@ -853,7 +852,7 @@ static int merge_commit(struct notes_merge_options *o)
 			is_null_oid(&parent_oid) ? NULL : &parent_oid,
 			0, UPDATE_REFS_DIE_ON_ERR);
=20
-	free_notes(t);
+	free_notes(&t);
 	strbuf_release(&msg);
 	ret =3D merge_abort(o);
 	free(local_ref_to_free);
diff --git a/t/t3310-notes-merge-manual-resolve.sh b/t/t3310-notes-merge-ma=
nual-resolve.sh
index 597df5ebc0..04866b89be 100755
--- a/t/t3310-notes-merge-manual-resolve.sh
+++ b/t/t3310-notes-merge-manual-resolve.sh
@@ -5,6 +5,7 @@
=20
 test_description=3D'Test notes merging with manual conflict resolution'
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 # Set up a notes merge scenario with different kinds of conflicts
diff --git a/t/t3311-notes-merge-fanout.sh b/t/t3311-notes-merge-fanout.sh
index 5b675417e9..ce4144db0f 100755
--- a/t/t3311-notes-merge-fanout.sh
+++ b/t/t3311-notes-merge-fanout.sh
@@ -5,6 +5,7 @@
=20
 test_description=3D'Test notes merging at various fanout levels'
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 verify_notes () {
--=20
2.46.0.46.g406f326d27.dirty


--Q3kHePocmPcVsDwW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAma0wosACgkQVbJhu7ck
PpQ2NRAApCeOU0S87bp7fGC91chBMDwKtuVPBhO05+z8B8Ly8NbeutvH+291Y35J
2TsGDMcd239FeJpWeIQu2qruImCZBuhwTyC5WDdk6GldhqWqwEsYMlBpKXzXzmJ3
wJLAkoOjOqDiCguAYNfmipYIu8zulnlbqg5MtUFfTih+wvuFTtr1BZf5I8zgV9wJ
UwHB/6nbzmcKbMcxqLFHg3CNjVeZO/0Bin1OBeRP8WGXkU2BdI7biYdwy0QLvx8A
+HGcVRZjlIuW0wj7Js9exDGBe8xkynbCvmvvuwP4G19rJpgOPWAhKw8DIO0N2eec
rxs/KZcpaGUyJQXhVxwRUiVKzojEZAGAc/fNnm4yP+vxaaitAu/uZneHrKUnRRyl
77+CB76frcD6mLZMloHJphXt+Oug5tn+KVSrrihsJmQCqLcFw5QbQxswPOQFjbzu
nooTaWZ0OnuGAxac/a0n6h/+cnOcaPCtZ1WTNCKXq/usn23FVvvEPvSdl4Vu9qyu
9IuiM+bA9j2N0BCJpDVQK01KqBuAqaFrayWfujvlSqkOK+ysmPMoG5n4GRSaQHVG
DU7T9xf3tJLYzmMiAAVvpelnQryqju5qkEm6A93BWQxLNyhNVfdHP/81+OGIEO/C
NDs7RXoSRXvuxUDv0BOR270hhYxqsIAaXThOlVE8aXumFnJTBbw=
=BQw6
-----END PGP SIGNATURE-----

--Q3kHePocmPcVsDwW--
