Received: from wfhigh5-smtp.messagingengine.com (wfhigh5-smtp.messagingengine.com [64.147.123.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FCBF178375
	for <git@vger.kernel.org>; Tue, 11 Jun 2024 09:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718097591; cv=none; b=KcWXHiMW1p7w1vf78QyGHbZMdkZcndFYknOpQmtu81YNv98V+BvzJ2BzCc8O4FjM+we4aYr82Bjt+xJm3TftCgjV41TvupADlqOVCb/4p42TMlJRzfpGxcwBTwoIk1bTowam/sRF4QF/YJ3/6h1URqYZi2BSKYJgUTcJDTG66BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718097591; c=relaxed/simple;
	bh=kA4pWSwg0ovdt5B+TW0ajltMBZBbdNEmFl0ni8c/uTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a3ORqR6huc7nxdV2wEVk/Sx35kHE3yNjSgiQKFlHt7XvCsdm/rMiPpZ5hLLgBFznyxNyT5ldVAuV3FyF5msQp9Jaawg/Sq0EXDgBGAxKWLiGswtOe6Z25jiMzMuSFHdd/nk32fTwkbmzgushyW0BH8Tdy3a9MEl5hyO00H+7/oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=pcWWpNT7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SYdDj189; arc=none smtp.client-ip=64.147.123.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="pcWWpNT7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SYdDj189"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.west.internal (Postfix) with ESMTP id 773A51800121;
	Tue, 11 Jun 2024 05:19:49 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 11 Jun 2024 05:19:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1718097589; x=1718183989; bh=aNoc0KtkQR
	gM6tcgGZujNc6gHgKtZDPr+JtGFRXTE54=; b=pcWWpNT7tAyh+r0sAJFI/nAG5C
	2e4LPMxg8zbLBsdChYDoOhs/xh3zCs3cpiS/bpVp0AM3BANXIKU8zlMa4+CJr5Di
	6iYvvi9gs0YzCIBZKR9GA432EbYsqueuPW1KPfueMBXTQLwrVLtokXPBYv/mL6se
	jiFztHuvz+/xWUmgkjN2JDNgcOUXm0VPXAvojmUqA7LWETky2chJy7vtlS554oLm
	s24DHw9+WAPGLf+K/4v//V3Jwprgn/gP54ET7XlxUi7egQjnujN/p5fjgIko4pM0
	4lIk9bxIDrPnbpfFGKXLMGX9sY/30KmewTuc7TRDBxIAhFeS9r5uDLVxJmiQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1718097589; x=1718183989; bh=aNoc0KtkQRgM6tcgGZujNc6gHgKt
	ZDPr+JtGFRXTE54=; b=SYdDj189SuL/0pVEoaNlo8ccwzgQmLfgGCjwAwCJHCgD
	sDfQZ69Jqr2iluYlEfs4KZEX0uf1Txkbx3NaK/HoHUnkypx4p7SwPG0n/zoTIQ6A
	rOZFYBSnY/CeqImbwv1qH2dlQ44v4FPMt4Bo9GIQAuWeej2Px3bs0OWmVoGiHPYl
	FuIZh/vslfyYvn9QY2/veRUbr0JXNGJAK8pJAftUcm1eqMmPTi0mBg1vKOqZ3RXW
	EH/vH7w1J4MSsXWzgWvMUWAuUgGZ9HnjTdYuZsQbjqKixp71kmkXc9NipUMHrU4V
	AcMrYQ6hOZwb2Ejk5UWbL7vgjSaQ0z9AyiYhjduKlQ==
X-ME-Sender: <xms:tBZoZhW29DklK5KGpMW8KmY8jLnI7pW8gVpmMwfABV5zATrYQ_CPKw>
    <xme:tBZoZhmBGuI141ILy55P391fEESi9V8PQaFQYO7SbHtNju66HQLfP4GNnqJ6sEODl
    Tkl2a1ZeFewHBxOig>
X-ME-Received: <xmr:tBZoZtbFsb0f23Lr2FlO32Ma62KhrVtD8nLMdS9YLFBPIZeEIJByCkTwp7GtytIZokYHj1J2L8UbXxFcJv8spdwAfmpMsSCgSv70zjemg59VZWAc1koi>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeduvddgudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:tBZoZkXsmraZ1pbixjU1mLPPDNLvnFg6zPW-Az1rTlrMUQ1u92saoA>
    <xmx:tRZoZrlbHNI9-m-LtVbSywfn3j1a0qT5GK1wLn5xkNPKwgGbI2Tevg>
    <xmx:tRZoZhfg7W1Fmx3uYPeVI0jBsIK0rox1NEuw9LdF4Z8xtU424MNyLg>
    <xmx:tRZoZlGlbn-8NKbOjhYh64llQEkIKZavUF8BeTxAQeZUhz1SBTDoPg>
    <xmx:tRZoZpiR03vWYqj9fsmYCzNixPSo9tOLPzuNvN4sd04JmmnlflOEtyp9>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Jun 2024 05:19:48 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 0cd5ad63 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 11 Jun 2024 09:19:39 +0000 (UTC)
Date: Tue, 11 Jun 2024 11:19:45 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v2 07/29] revision: fix leaking display notes
Message-ID: <b9c3a34ae17e5e865ce3860934c990a3ed6213c2.1718095906.git.ps@pks.im>
References: <cover.1717402439.git.ps@pks.im>
 <cover.1718095906.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="O5dxCOySv0ULMiWO"
Content-Disposition: inline
In-Reply-To: <cover.1718095906.git.ps@pks.im>


--O5dxCOySv0ULMiWO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We never free the display notes options embedded into `struct revision`.
Implement a new function `release_display_notes()` that we can call in
`release_revisions()` to fix this.

There is another gotcha here though: we play some games with the string
list used to track extra notes refs, where we sometimes set the bit that
indicates that strings should be strdup'd and sometimes unset it. This
dance is done to avoid a copy of an already-allocated string when we
call `enable_ref_display_notes()`. But this dance is rather pointless as
we can instead call `string_list_append_nodup()` to transfer ownership
of the allocated string to the list.

Refactor the code to do so and drop the `strdup_strings` dance.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 notes.c          | 14 ++++++++------
 notes.h          |  5 +++++
 revision.c       |  1 +
 t/t3301-notes.sh |  1 +
 4 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/notes.c b/notes.c
index 53ca25c814..6a157e34ce 100644
--- a/notes.c
+++ b/notes.c
@@ -1060,6 +1060,12 @@ void init_display_notes(struct display_notes_opt *op=
t)
 {
 	memset(opt, 0, sizeof(*opt));
 	opt->use_default_notes =3D -1;
+	string_list_init_dup(&opt->extra_notes_refs);
+}
+
+void release_display_notes(struct display_notes_opt *opt)
+{
+	string_list_clear(&opt->extra_notes_refs, 0);
 }
=20
 void enable_default_display_notes(struct display_notes_opt *opt, int *show=
_notes)
@@ -1073,19 +1079,15 @@ void enable_ref_display_notes(struct display_notes_=
opt *opt, int *show_notes,
 	struct strbuf buf =3D STRBUF_INIT;
 	strbuf_addstr(&buf, ref);
 	expand_notes_ref(&buf);
-	string_list_append(&opt->extra_notes_refs,
-			strbuf_detach(&buf, NULL));
+	string_list_append_nodup(&opt->extra_notes_refs,
+				 strbuf_detach(&buf, NULL));
 	*show_notes =3D 1;
 }
=20
 void disable_display_notes(struct display_notes_opt *opt, int *show_notes)
 {
 	opt->use_default_notes =3D -1;
-	/* we have been strdup'ing ourselves, so trick
-	 * string_list into free()ing strings */
-	opt->extra_notes_refs.strdup_strings =3D 1;
 	string_list_clear(&opt->extra_notes_refs, 0);
-	opt->extra_notes_refs.strdup_strings =3D 0;
 	*show_notes =3D 0;
 }
=20
diff --git a/notes.h b/notes.h
index 064fd7143a..235216944b 100644
--- a/notes.h
+++ b/notes.h
@@ -275,6 +275,11 @@ struct display_notes_opt {
  */
 void init_display_notes(struct display_notes_opt *opt);
=20
+/*
+ * Release resources acquired by the display_notes_opt.
+ */
+void release_display_notes(struct display_notes_opt *opt);
+
 /*
  * This family of functions enables or disables the display of notes. In
  * particular, 'enable_default_display_notes' will display the default not=
es,
diff --git a/revision.c b/revision.c
index af95502d92..75e71bcaea 100644
--- a/revision.c
+++ b/revision.c
@@ -3168,6 +3168,7 @@ void release_revisions(struct rev_info *revs)
 {
 	free_commit_list(revs->commits);
 	free_commit_list(revs->ancestry_path_bottoms);
+	release_display_notes(&revs->notes_opt);
 	object_array_clear(&revs->pending);
 	object_array_clear(&revs->boundary_commits);
 	release_revisions_cmdline(&revs->cmdline);
diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
index cf23c06c09..536bd11ff4 100755
--- a/t/t3301-notes.sh
+++ b/t/t3301-notes.sh
@@ -5,6 +5,7 @@
=20
 test_description=3D'Test commit notes'
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 write_script fake_editor <<\EOF
--=20
2.45.2.436.gcd77e87115.dirty


--O5dxCOySv0ULMiWO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZoFrAACgkQVbJhu7ck
PpST/A/8Dv0UAvxb+h6C/gzQ1vx7ZL8IgzRb6Bkxc2DqRqE0HenNe23CCH2NVVcY
xRDmAoCwdXV7Z1D8IJbAVrjkHjkNTksKQz+xpmGY7HvD9A6N0TkEC2v0DFswTElH
YlI4m33bysq8tbQbtVG45N+pR/EjifRZWaudnUXND/Jd8gizD4gchYdy3TJ2Nlk7
dfR4RFreECsMTLQX8d6yCGrI+6GRxTU3KCn3xWkt2MImtKOgNQ9sHQGZJv9Nd0QL
gj/gXPkF/cLAl7VYedUzwF9TS8QiE1ZEegQt5oogIqs/bLvVMpXM469n0OpvsVGW
Y75jtG9a4oPfi3i5IKRmnRbpZH5qJ9oJQ1MHFqpbmV+v+G6JSTtAzd8x1fHPndYT
mcwIJ8RP2xBhwrSe1HMG9+6NSaCv4tmLiEXillnqP8t8ysIZQ6sAZFNonOfg4uh2
9F95LGmY5iehYivf7vrYLgy2DaQj+Hqd/GFGcJnsTHX3sR5ZHE5B2cDWXlIj9r3b
FdH4urzllgzhCfKoDuNBO8c/Z+J24mvvbFBeyZH3WmflMIlZrjsHZEMV5hAdPjQY
Uz3K9eMusE/cn2WV4nBkkXZNfnJUU3pj/LsDbhVvPYzZKOxqmmZsA07IMkVme1Xe
yb55D8jmVCaWX4vQ4UUiB3PEX9jD1R/mIlGq8oy3EETa5Tr6m4o=
=9fMq
-----END PGP SIGNATURE-----

--O5dxCOySv0ULMiWO--
