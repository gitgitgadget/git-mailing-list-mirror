Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706691BE250
	for <git@vger.kernel.org>; Tue,  6 Aug 2024 09:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722934825; cv=none; b=TmLFw7J+080Tnkhn2+hzJnNinwQlX8vAZnKx/Nkld9R3F9qosraPRXiYMkFY4dX/8lOWpMHs1DUMcRRPhiEOKRpx95RU6075TBIYJ5NQ6CCglUZZv4y1rztYbAmHS2nYo5zKo8C/eLJqos8d8E7VOCtOEsfJFyjRhI3M3Qu5NRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722934825; c=relaxed/simple;
	bh=Uma7j2iW77+YOunJ85U16KGJcFwWCqFol3Fy1hNWbYA=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jDux2g73VYSBf248bZ1i/a9iGqtjUN+sZRmmKDO7UoxF3AYGUYE7c6+Y6IfvXKLsYLsmQhYJwEeFa91Ri2oits7IAMe20ApdrwUdK6llC3sxQDGEKQmk1c9RE58nxAyDjPaU4plAfK/paXgWbqeNQk2TbBaZTmlgee2jaBFEn5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=VE7e66Eq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KIiIClV5; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VE7e66Eq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KIiIClV5"
Received: from compute8.internal (compute8.nyi.internal [10.202.2.227])
	by mailfout.nyi.internal (Postfix) with ESMTP id BB3E2138FCB9
	for <git@vger.kernel.org>; Tue,  6 Aug 2024 05:00:23 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute8.internal (MEProxy); Tue, 06 Aug 2024 05:00:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722934823; x=1723021223; bh=917GmYz5Ml
	f2BhUea/ZPfAZa3Hes4ea4dK2D+MvQES4=; b=VE7e66Eqpw4mQeVhf4PedZ9+n8
	qwQYsocqzexbp657Ie1qIOB1M+fVkOs5PribIl8ONWDLcOs6Tdi01IHQhWAVXHMF
	MYCsVPfscMGXhnuB/+P0M89XtpYuZhWuGXfRYGt688hEG4uRN+H0uacBe8Xl7W8A
	5gN+g/lmahuOY/j6+QD4OSpIX+p6+jXo0uwKWOOy7tDDd3TVBv2hXeM780WwM61A
	jt7oHP1i267/FGjLNkIa91fAPJaJIikVKJWxXlElvtB5TId3A/o9X6/Ddei9CyyU
	GXZjJRlYsO+ajIibUL3KOmG96XOd8HTqIJoRn035pcgqYbFJlDNiF1N9MMxQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722934823; x=1723021223; bh=917GmYz5Mlf2BhUea/ZPfAZa3Hes
	4ea4dK2D+MvQES4=; b=KIiIClV57o6Gs2xyjcPWRdJoGsN0M+dUmfPRETuwLPJA
	SPzLwAqO4FXwFUlfY+EbEqLyU3XoonkmEIa3gidqhPp+wM8L0LTYGejfNIAijpHe
	7elbQSrV9VhWzalyHG0J9ob9xCQeW9Olf6UE0u38vR3og/0SMRL+9LrTJmEFh5a2
	KPqX1S2L2y8ZnitjMKFVjkUtVg2DYJcueqt8Mb0QbG7+qKDrtMxm3N98zJSZC3K0
	INle/KumXhK/Ff5nVxZTDimcrxfSfDPfuVVIdnpIGlzgq6uU1FM2JgjdsCy8OF/L
	7BjDgL/M1Ty6bcx1XBvkRbQ6YDiJ8CtceCOPBcWYRQ==
X-ME-Sender: <xms:J-axZpwKiL13ewDZj-s7r2cPzuKMkA9oxDlbCpEB_YMwHlBfoFZiYg>
    <xme:J-axZpTIOkQsSW4vYCRHZ6k_IkcCnzx7v6tQqiKPI3o1XPQyH1VlSbUT0-opMWHWo
    0oEwFIPWCLrkyN5nA>
X-ME-Received: <xmr:J-axZjW3DBU1DEc9s5ByxbR49nqmEW4UPOWmkmamxmnAKtN4Kt0M79qmh4mEcfHuaFnyFnixwKFwlL-HchyU-Erv4RnSN7ILigxv6-qstY9W>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeekgddtkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtderre
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeehgefhtdefueffheekgfffudelffejtdfhvd
    ejkedthfehvdelgfetgfdvtedthfenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:J-axZrgLw4LkiXKV8zdoNasc18PyJuAOTJAsRRIvtjsMa9gZeBFjeA>
    <xmx:J-axZrARd4MO2ZCENpPzLIw7fe5dGlcrpMu9UE75RGtTR2g1KtsLgg>
    <xmx:J-axZkJEvWKfInTZ-uh-L5Lg-ZeXMnqMh2SCrVqXZqb4Dt9z5R2EBQ>
    <xmx:J-axZqDtXrGyWFP7bQZmmV4AjE2FMJAnnQki8QOsSyjC02V86yr33Q>
    <xmx:J-axZg7WWhTnEoNdJDGbwwYyYzvYlPDZAjT-j4Vqn_McSbDhByjbndYl>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 6 Aug 2024 05:00:23 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d9dd962d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 6 Aug 2024 09:00:20 +0000 (UTC)
Date: Tue, 6 Aug 2024 11:00:21 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 10/22] builtin/notes: fix leaking `struct notes_tree` when
 merging notes
Message-ID: <4f5d49007484e8c201f62f84ffec101da00548ae.1722933642.git.ps@pks.im>
References: <cover.1722933642.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="m+oebQJElDs/46Sg"
Content-Disposition: inline
In-Reply-To: <cover.1722933642.git.ps@pks.im>


--m+oebQJElDs/46Sg
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
2.46.0.dirty


--m+oebQJElDs/46Sg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmax5iQACgkQVbJhu7ck
PpQmTA/9HitOTkDSgHsd6LNI7iAaLxV3V0b/1IPELs8F5cti/4GqeVQiBK9sYNqX
U0U0cQ5lCLi0IP+VwuGhc3we+9SdBmq6laq8gDljni3oJubqf7K6iTGrmXoSE+At
WxW4SSX/Vhb7MtCF2HiTkyhnJz1CWgcs6rEZenBkvsXhmK9LN3sgyNoBJaA1kwev
LekSNss4oa106eQ30NXQBhRJeR14w9wOzjYZE92Jo+vcOurRadhilJg8y5PFg/YK
lpTxWjSDlhfwq10PW2Nzv2jI6lVoZnu+AHks9x28cW/FAfB6aUhq3fE3r5YeDy9T
VQwH9LukFiwwViL8mSM+6Psp9z1/8Un5Fmx6CMjWg3LBEVb07YS5DDIJux/rnW1p
ieQhUOgE+U+blUdFmY6SnNOevPFq4Fly8KpS8Xpxf2JpEJoYMNrja6Hbe7aXVdAA
kAZmXtM/acLXu0T7ioTfHLoKDHPki0b6QgGhRVLdNxqhF7+0KFQxOQdfbKtsluMg
/8eiwYw0WdgTs2Xa5kM+jD0xHMve4OxTrGqCEjjowprvVeBYhvKPcyxThodHUM/Y
Nt6UioOwlSfueSgKQFyL9pyIO6o7Y8HRhYT09KNNugA1pRA8lUIxZu94Pi5FRX57
TLMqovG9XxV01+DRYnxf48y/B1j6M4zxgwhHwCQRJ8lFuFcowT8=
=wRXe
-----END PGP SIGNATURE-----

--m+oebQJElDs/46Sg--
