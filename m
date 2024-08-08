Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14097148307
	for <git@vger.kernel.org>; Thu,  8 Aug 2024 14:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723126014; cv=none; b=X60rcroge+r82OxGUIAG2ucyymJ9e5Z9NZwpEol6f9wsygr3h0Sj2iinry0rRfrRm0NDRY0VZJjX87tf87D4Ivr84XFhm1DGCPD4zrVg0j8LanJqouIY0H6wF+nalKl0rEBGwSEZ3eJzFrjZwmB/Djaq+7xF2Uy3FxviyZQh3Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723126014; c=relaxed/simple;
	bh=t4yAJCX+7IgPbw8zA5TXYoyHUrkDDHWQYBoBpEAHyKE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kvJtG/xBIO+OcM0IvvxRfROWFLO8JX5U28Eay7pzZTpTSSxoY89CTIhMbkEAdXeT6pqO66uUfBzZPJPzosxq2WlvmozBwTnExvAx9K53vE6pmcr5ffmGpLlgouYGkC2ZZYlKlw5CYuY8hdGE3pFPnk4jWzDYY5hLMzhYKrpLR5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DnTPIh5y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rp+HHL3z; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DnTPIh5y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rp+HHL3z"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 2E65411516C8;
	Thu,  8 Aug 2024 10:06:52 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 08 Aug 2024 10:06:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723126012; x=1723212412; bh=/VNKo+zVFR
	BiaLdr9WUcsmyqqfXbhZljSe8XhVaIKG4=; b=DnTPIh5yqMah9hC/IlsdWACEOg
	AP3h/HFwp63gb+dFJjZiFfuJCH1kgUjeRMKYEALN2hMkK8AkMAZDl2GiKRYO8kAQ
	1mpl6+pufcarWaYuQstrQ1kd8Yi9WovkMCjJrXFD2Aq4bUvBmbY9AMusmmZ/4a6s
	Ny5itFqdAxrcvzrVQ1C3FB9k9Ju9xXAKwvTh2JiIEkeq/qCwOkt+1ObtIWP1GPsL
	wUorKzD7hWuh8r4QnJpc8X8a46aECkneNg39q5lS43LqEcU5kkIhYLoAF5fzhYAI
	dF/lqP0E5uVmlmWHXOvA48cfXOFXYJusHLcsY0n2FI8iN4D7dbtvI2n+JrNw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723126012; x=1723212412; bh=/VNKo+zVFRBiaLdr9WUcsmyqqfXb
	hZljSe8XhVaIKG4=; b=rp+HHL3zc8SEgZ5YvMk7zgZb+H4C28qkCTRHSBalLdkv
	00Vodte1qEH9xoHAT3wALyY3DT4R3Pbgr8dgM+aExWOQyb8QZXJZHjdF/y2GBwn2
	ko+E/dCpUnf3J18yImSW61xCT7ejo9AHYY7bX+y8cwGeQguke24TRvCOd4sZqzle
	IULLRS92sUUV1ukal1PgWkbTFewMTnUSNnNac4f7ObRm6roJWAJLHl6CE1McvxgL
	VzgvEUAGXwGvIms5Jv/hv+QstgvHCocFjVP4ZoblPdJGvFu/YYE/pNlmiwoR4L1I
	FWiQl2YT9U2jB0i60KS4mSWQCeGG9B4i13GN8KzW9A==
X-ME-Sender: <xms:-9C0ZmUmhyNbJ31BJJRnFLq-uxe36sjVtRLHnysXQCOFAAm509OThA>
    <xme:-9C0ZikzHNDKNQvEN-b0sNotU98jGjKsJNMMybxQatAY3XQlN1Ld0BSG8rGjfTy4K
    JlxxVwFjz_5qngqkQ>
X-ME-Received: <xmr:-9C0Zqb2JKGsiT3xGPLA9dG7O-1hT8jlSaVglylgXk6Wo-4iFQr4z5GLdvBDr95biejq1qNB2ICG06B4Zjt4-pf0oWbwqBLA9VEorUYE1i3dpVRJ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrledvgdejvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeeh
    gfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrrhht
    hhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpoh
    gsohigrdgtohhm
X-ME-Proxy: <xmx:_NC0ZtWUQWza72V_1s307E8FyX4eKJxXnQdmvtj3a3FB9r8uQtADXA>
    <xmx:_NC0ZgmBQyps-qQE26bFo9cDRcN4BI615YVlTk6o4g-CSqGsf3Ldxg>
    <xmx:_NC0Ziej3udo0NjLmRaefbHx3Jy4Q1yZL-fzUBpNbU_MMLCi65i0SA>
    <xmx:_NC0ZiET8mwiZDxMjLjXCoB4Pys8MJGyBv6PXTPMreUbdgAZx0vVag>
    <xmx:_NC0ZhCFzPyYXo5KGyI8vC9C6V1JimowL4i54xmdN-5pRjMRrgryX9LP>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Aug 2024 10:06:51 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c7076626 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 8 Aug 2024 14:06:44 +0000 (UTC)
Date: Thu, 8 Aug 2024 16:06:49 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v3 7/9] reftable/stack: use lock_file when adding table to
 "tables.list"
Message-ID: <37a757649a621ec193e27ef2939f1d79aaba818d.1723123606.git.ps@pks.im>
References: <cover.1722435214.git.ps@pks.im>
 <cover.1723123606.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Y93Fk1sA6B0cTGgR"
Content-Disposition: inline
In-Reply-To: <cover.1723123606.git.ps@pks.im>


--Y93Fk1sA6B0cTGgR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When modifying "tables.list", we need to lock the list before updating
it to ensure that no concurrent writers modify the list at the same
point in time. While we do this via the `lock_file` subsystem when
compacting the stack, we manually handle the lock when adding a new
table to it. While not wrong, it is at least inconsistent.

Refactor the code to consistently lock "tables.list" via the `lock_file`
subsytem.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/stack.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/reftable/stack.c b/reftable/stack.c
index 9ca549294f..54982e0f7d 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -567,7 +567,7 @@ static void format_name(struct strbuf *dest, uint64_t m=
in, uint64_t max)
 }
=20
 struct reftable_addition {
-	struct tempfile *lock_file;
+	struct lock_file tables_list_lock;
 	struct reftable_stack *stack;
=20
 	char **new_tables;
@@ -581,13 +581,13 @@ static int reftable_stack_init_addition(struct reftab=
le_addition *add,
 					struct reftable_stack *st)
 {
 	struct strbuf lock_file_name =3D STRBUF_INIT;
-	int err =3D 0;
-	add->stack =3D st;
+	int err;
=20
-	strbuf_addf(&lock_file_name, "%s.lock", st->list_file);
+	add->stack =3D st;
=20
-	add->lock_file =3D create_tempfile(lock_file_name.buf);
-	if (!add->lock_file) {
+	err =3D hold_lock_file_for_update(&add->tables_list_lock, st->list_file,
+					LOCK_NO_DEREF);
+	if (err < 0) {
 		if (errno =3D=3D EEXIST) {
 			err =3D REFTABLE_LOCK_ERROR;
 		} else {
@@ -596,7 +596,8 @@ static int reftable_stack_init_addition(struct reftable=
_addition *add,
 		goto done;
 	}
 	if (st->opts.default_permissions) {
-		if (chmod(add->lock_file->filename.buf, st->opts.default_permissions) < =
0) {
+		if (chmod(get_lock_file_path(&add->tables_list_lock),
+			  st->opts.default_permissions) < 0) {
 			err =3D REFTABLE_IO_ERROR;
 			goto done;
 		}
@@ -635,7 +636,7 @@ static void reftable_addition_close(struct reftable_add=
ition *add)
 	add->new_tables_len =3D 0;
 	add->new_tables_cap =3D 0;
=20
-	delete_tempfile(&add->lock_file);
+	rollback_lock_file(&add->tables_list_lock);
 	strbuf_release(&nm);
 }
=20
@@ -651,7 +652,7 @@ void reftable_addition_destroy(struct reftable_addition=
 *add)
 int reftable_addition_commit(struct reftable_addition *add)
 {
 	struct strbuf table_list =3D STRBUF_INIT;
-	int lock_file_fd =3D get_tempfile_fd(add->lock_file);
+	int lock_file_fd =3D get_lock_file_fd(&add->tables_list_lock);
 	int err =3D 0;
 	size_t i;
=20
@@ -680,7 +681,7 @@ int reftable_addition_commit(struct reftable_addition *=
add)
 		goto done;
 	}
=20
-	err =3D rename_tempfile(&add->lock_file, add->stack->list_file);
+	err =3D commit_lock_file(&add->tables_list_lock);
 	if (err < 0) {
 		err =3D REFTABLE_IO_ERROR;
 		goto done;
--=20
2.46.0.46.g406f326d27.dirty


--Y93Fk1sA6B0cTGgR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAma00PgACgkQVbJhu7ck
PpS/lw//VT18E3nytevDPzX7M5+llTbaIgZB7mayxH71RIRYyQVgzC0XkiMoDtF3
ovkdMDCmhD3SGkIVc/EJ3Mr+PLIxzwbH+aBwFc76pplkQOBVIJwdO/YxaiNQMj/6
Y+cdqXkLyak3cFABQw1Tv6hSeaqJomxG6b/txcut3eRscacWmZirNdJ4rPVfsfor
8gL0PXkSnKC26IoVbla3K1o9S1du26NrYNjApoU0z49EEVms/T5gcSOZ6mLgPhqr
bye2Z4jEOVTDSKeH+yQkFGc3fEuSQJXACbSTpEvwIO4/J+bFURx/MaFXQkoBdoUZ
hJuplEIhyl+uUueN5uQ5Bskh4WfQbqeGLphgg3TU9cOQP7/9dGXjYa9m9TIzdyqJ
Nq5/M3g/qe2ZpTSg7rYz93JbvsMvUUFhFmbz40kXhWYRPUfqfb27H53KQ3832KQ6
LTOmOJZcQEApcb8BezWR7jazyrvoHUVnz2YzozKEZulL0aJwIMg+69C6lVhCg+5t
siHsqeoIeyjjd/yk28moSY6en5PNBrJKAqlYBfHWqET5OOqecAsMlEljJK9pBUPe
Ds6FOIpw/GPCgMN+fes2/Zwz/EmGemU2il/LNmw85C4p4ux75GbbW0SinIh6kYXo
ydxWAWdkILTf9+/coQY1k3xa4K0B+05ip7Moh3WeeTk5EH9o6iI=
=dhYo
-----END PGP SIGNATURE-----

--Y93Fk1sA6B0cTGgR--
