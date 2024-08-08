Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F246018CBEC
	for <git@vger.kernel.org>; Thu,  8 Aug 2024 13:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723122346; cv=none; b=sEx6ZIgOdNJhkUslyJYLSTTt6A+JLIhhwJDj1oVH8z8qY74YNxpp50kibiMLDc9aDG29gzxue2/te5mztkZq3z1xvej8bmnMilC7bklN1CqqxPD1PMQTGx1gmwCHz/I6kZKSL7faaxO/Qf+6EcghA+3MLBfMeVlAWAOyNS6tqWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723122346; c=relaxed/simple;
	bh=rhP4cgZ8/2QkgMOPLr2lm+02lIck7bhb1EK+3JXdxbc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ghfrdEbnvksDfB1ZMcZoxHmrPHxfoa9cXfb+yK0j9Ddo6loNlHGoScY0qrJhfi1Wlo0v5OADq4OId5/jOcDbpIRHJ7ZxU1ZOOVVVZCj2qlrwKVf84hELnuHIK+Ros5PcCqNEm5tLZBVau8GOKOWmqSuHHB7gm+J2Awl3otNv9KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=INkyfufU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uDHNTjw3; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="INkyfufU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uDHNTjw3"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfout.nyi.internal (Postfix) with ESMTP id 242091380522;
	Thu,  8 Aug 2024 09:05:44 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 08 Aug 2024 09:05:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723122344; x=1723208744; bh=fGDbC2lrxg
	mHtTVpLXeAprYMxN9RyFYnJvt/N/UKvm4=; b=INkyfufU3PuFfQQHdzMxpqh8LG
	nIEMDAa38no94t6tVlICY4JWJ7VRJwXUixB2sZfek2mVeKKMEmmgSYnAnegpmaPL
	6OUm4EZewCXrAEXI2fRO+s0Bu42+bDYX2XdAbadtkM51uIIHna8/EpcPsNiisxMs
	UjtNVqhqvnzzzDpEGjon4G7FsGfPmH45gDMWKU8QhuqU/DglhR1tBBOctIjcpK1q
	HKMAIx6n+i9l4VesuahCRPB5e471oHPSTntJ0bt5FhYLz6rEqHPEs+1rCM2qS5vF
	N7f6pIrRAp6TWxJn9CEVunkXl6Hwp6z8tmJmE8R7uyb8Ft5e/XNTaOfSrPGg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723122344; x=1723208744; bh=fGDbC2lrxgmHtTVpLXeAprYMxN9R
	yFYnJvt/N/UKvm4=; b=uDHNTjw3CRBMtGhf4pKdgapdA4HtOF0pEdyoy3/GLUQH
	KaWeVY1PyLMasSoR+q6G65wV640CsDvOQvurGzUrVzDVuHqViDzgsprUync/M7Ro
	p9QAX4yUEkjeyUkI4k4akKDGyA5YJlyfNr4SEW2JcIQkIUe7XU3YcpSxSjYs+2Oe
	I5WL0VC0NusXiVj8IZ4uKwHqAG+20ClXGaBOKEOgGu3WraQ0lEF5nyx7HbI57h+L
	D7SDibTDuzVxdld2S0YEdRCmkUuRerpcD+Mgbura9RkIsrGuAstNiOrMAAi007Rq
	SGb9NK6bW2tBep4rrWfsMn5brCFxF+bxYiYZoZLjkg==
X-ME-Sender: <xms:p8K0ZoyvjT3USCt6GvQoE8t9TkJlLY7iTXjo-D0_5XnSg7Y2ROTOpA>
    <xme:p8K0ZsSiEQZ9MLXmsfmSDUhZSruO7zrF65N6MwecrFNMc_lI8fVZPIItZSnL9H7FH
    PN7RCuzoWqDiby8lA>
X-ME-Received: <xmr:p8K0ZqW9zml-DL9XrxUDi1Q-rxIEuYsQu2dU2-b4HnyJHsXiympGt67BtRkLZ0dlhCkqADrQl4qJ2rrfYvCDrhBcPwLbJ_ivqEBnuptyaG-zEZWY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrledvgdeitdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeeh
    gfeltddtheejleffteenucevlhhushhtvghrufhiiigvpeelnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphht
    thhopehjrghmvghssehjrghmvghslhhiuhdrihho
X-ME-Proxy: <xmx:qMK0ZmhpaPp1TYnpN0gq2J0EnKZcVyPwEyTYesT3GbDh7yxNB-j7fg>
    <xmx:qMK0ZqAVTAVw7bcVhTd39g19v8E7y_RdoAO6vsCfoGweFs1NFns-gg>
    <xmx:qMK0ZnKROc0oH9ptjoXWgsqFDicoaT1h5TMSqatl82RvFrwh0xZxFA>
    <xmx:qMK0ZhDr5H1spC03uxr1bCQZHBl22F6ErH329j5Q3OA8cPvtqGb6SA>
    <xmx:qMK0ZlPz4-7KC1s4u-WX8UmWZB4xnYnZBK-aaNmgmaCxFaBJo3lDouIT>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Aug 2024 09:05:43 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b80517d0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 8 Aug 2024 13:05:35 +0000 (UTC)
Date: Thu, 8 Aug 2024 15:05:40 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: James Liu <james@jamesliu.io>, Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v2 15/22] sequencer: release todo list on error paths
Message-ID: <ea6a350f31b7c6cf9ada714759afdddf3c672692.1723121979.git.ps@pks.im>
References: <cover.1722933642.git.ps@pks.im>
 <cover.1723121979.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zlkXitS/PCSPFFoG"
Content-Disposition: inline
In-Reply-To: <cover.1723121979.git.ps@pks.im>


--zlkXitS/PCSPFFoG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We're not releasing the `todo_list` in `sequencer_pick_revisions()` when
hitting an error path. Restructure the function to have a common exit
path such that we can easily clean up the list and thus plug this memory
leak.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 sequencer.c                     | 66 +++++++++++++++++++++++----------
 t/t3510-cherry-pick-sequence.sh |  1 +
 2 files changed, 48 insertions(+), 19 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index cade9b0ca8..ea559c31f1 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -5490,8 +5490,10 @@ int sequencer_pick_revisions(struct repository *r,
 	int i, res;
=20
 	assert(opts->revs);
-	if (read_and_refresh_cache(r, opts))
-		return -1;
+	if (read_and_refresh_cache(r, opts)) {
+		res =3D -1;
+		goto out;
+	}
=20
 	for (i =3D 0; i < opts->revs->pending.nr; i++) {
 		struct object_id oid;
@@ -5506,11 +5508,14 @@ int sequencer_pick_revisions(struct repository *r,
 				enum object_type type =3D oid_object_info(r,
 									&oid,
 									NULL);
-				return error(_("%s: can't cherry-pick a %s"),
-					name, type_name(type));
+				res =3D error(_("%s: can't cherry-pick a %s"),
+					    name, type_name(type));
+				goto out;
 			}
-		} else
-			return error(_("%s: bad revision"), name);
+		} else {
+			res =3D error(_("%s: bad revision"), name);
+			goto out;
+		}
 	}
=20
 	/*
@@ -5525,14 +5530,23 @@ int sequencer_pick_revisions(struct repository *r,
 	    opts->revs->no_walk &&
 	    !opts->revs->cmdline.rev->flags) {
 		struct commit *cmit;
-		if (prepare_revision_walk(opts->revs))
-			return error(_("revision walk setup failed"));
+
+		if (prepare_revision_walk(opts->revs)) {
+			res =3D error(_("revision walk setup failed"));
+			goto out;
+		}
+
 		cmit =3D get_revision(opts->revs);
-		if (!cmit)
-			return error(_("empty commit set passed"));
+		if (!cmit) {
+			res =3D error(_("empty commit set passed"));
+			goto out;
+		}
+
 		if (get_revision(opts->revs))
 			BUG("unexpected extra commit from walk");
-		return single_pick(r, cmit, opts);
+
+		res =3D single_pick(r, cmit, opts);
+		goto out;
 	}
=20
 	/*
@@ -5542,16 +5556,30 @@ int sequencer_pick_revisions(struct repository *r,
 	 */
=20
 	if (walk_revs_populate_todo(&todo_list, opts) ||
-			create_seq_dir(r) < 0)
-		return -1;
-	if (repo_get_oid(r, "HEAD", &oid) && (opts->action =3D=3D REPLAY_REVERT))
-		return error(_("can't revert as initial commit"));
-	if (save_head(oid_to_hex(&oid)))
-		return -1;
-	if (save_opts(opts))
-		return -1;
+			create_seq_dir(r) < 0) {
+		res =3D -1;
+		goto out;
+	}
+
+	if (repo_get_oid(r, "HEAD", &oid) && (opts->action =3D=3D REPLAY_REVERT))=
 {
+		res =3D error(_("can't revert as initial commit"));
+		goto out;
+	}
+
+	if (save_head(oid_to_hex(&oid))) {
+		res =3D -1;
+		goto out;
+	}
+
+	if (save_opts(opts)) {
+		res =3D -1;
+		goto out;
+	}
+
 	update_abort_safety_file();
 	res =3D pick_commits(r, &todo_list, opts);
+
+out:
 	todo_list_release(&todo_list);
 	return res;
 }
diff --git a/t/t3510-cherry-pick-sequence.sh b/t/t3510-cherry-pick-sequence=
=2Esh
index 7eb52b12ed..93c725bac3 100755
--- a/t/t3510-cherry-pick-sequence.sh
+++ b/t/t3510-cherry-pick-sequence.sh
@@ -12,6 +12,7 @@ test_description=3D'Test cherry-pick continuation features
=20
 '
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 # Repeat first match 10 times
--=20
2.46.0.46.g406f326d27.dirty


--zlkXitS/PCSPFFoG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAma0wqMACgkQVbJhu7ck
PpT/6BAAgzpWCNbIGNBIbnc1bSM3FXOKWkC3xSKQH1gkcBTihWc9lOpkCZhfaRMN
mZDmsbQ8BtzcUGGIa24m0QK1t86KUYmgwGBPEHJS1t9ZYx5NAxw79f+YzFDLIXN0
fqSAHrUTSjPuCExvOBYZVaLTmgtADEmJmvMFMPYNhiU7ovYtBfH2NVxMzO5WcJvv
X9t5jGVS3HudX52UMFqtwX1BKO0RPaSVka4fYoqriIOylFyglO2uzZOx0z8+lPvG
C3m4ILB7IQVimTCdMflhJ3lXUj1/W7oAE/kE1QIvkW3ArsRyWpDCqXTSuZBVn/wE
2AUyIkgl0A7TDNAQYdg+UIWLt6fid/V1wTxL4SwqUjwON9yQ1qhsgICNuUTLAfyH
tLwqU1pvKXLsudK900HEVraZuiQL9h/vjkIv0m4drSVbWg1yWrFdR7E24nKL3y3V
m047jc/HMDYJsF/EfG4L0UaLYDPbAX8yQh8JEAtGAiZXHdS9bQoqC2GQUX2uTmTZ
SF6h0Gg36wONbgpPhXS5vMj1a96b8YkVt39ZqMqyX+/DqmIB8nX3uz0LcEawCcag
OLBNvpNWqMZorUJGSpAVJ8KLxWVOp/0KDSpXHirMoVVLzL14tk9HAVVg9RprrkWm
nrjDdIw0cJmNq6/XlLvIbn2VYlCiZt5Prvt+CN9HIUysN+MeS00=
=1yDy
-----END PGP SIGNATURE-----

--zlkXitS/PCSPFFoG--
