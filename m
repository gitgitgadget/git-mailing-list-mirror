Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66DF1BE854
	for <git@vger.kernel.org>; Tue,  6 Aug 2024 09:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722934850; cv=none; b=LXxphcL1dw/1PYldGcPj3x0rX+BoMCnjQaP0pleJSRBp8QhaNPj5LNk/4pdqRf3f76qAGH0nKqIjn8ckJqGcY5852RRM6wEGsBViZvt+E1F2HrbKGsh51fuNLbVkxoh6opsmOiplKDTZZVWDjxKkG1Mfx7W3L2FlVl+pY4zx4Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722934850; c=relaxed/simple;
	bh=nzk2RiS8u1qBsN5nCPOxYjvyQtSvOskr4XfYrizsUeI=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sf8oJz3NSm+/3Q2DTksV7j0JPfWdUYdyA/xA157SlsN9AlwvpjhpfzXXGG3hHLyVJi4nF9BsHNm0fl0j4WPxCnhK5OpI5kOO3YJGAjr5u0GOirO6dkDwOhCw2sdl+opMZ+vRFszvinTovp51/PowtIDvOyjea1emns8fxmpRvjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=irV2ywdZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Hoi5fRsp; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="irV2ywdZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Hoi5fRsp"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id 085EE138FCDD
	for <git@vger.kernel.org>; Tue,  6 Aug 2024 05:00:48 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 06 Aug 2024 05:00:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722934848; x=1723021248; bh=Eq0cyJuu8U
	vIyB9X8wceYMJ3HCI8dHkzygZhagXyonI=; b=irV2ywdZI3Z+LVrtxXDHoSHOYg
	cZ2qllluwPuuUliDqT51QmYanKi9cQHOIn3E3KrQ8xk7Nr+OMXDWOusEdQUyYEtF
	QLsVe+hh1f6WimZvTzJuH/Sn6vOFp+kPS+pMRYoglHybhB9dA9+19bGRFjr/f7uz
	buuO0ucr3oxz6f+3KL/OwSLXLMwA7BIdoQtqZtZPZC/NvmmH+lOMtxss72GkAPCB
	KUnisY6YD8gpDVs47JGGCJscgpfRhviVF7+1ooZ7ElL4m+nW/SVafCK3d72wzDQz
	Pj/Bqxc1xtfeo9dodkgpbkJRfR6QSmXltNZSqNjaa4lp5ll4mPh3l1NCRJEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722934848; x=1723021248; bh=Eq0cyJuu8UvIyB9X8wceYMJ3HCI8
	dHkzygZhagXyonI=; b=Hoi5fRspVyUsmZZKR2E9TJQcUDNj4zUMYJZuAIdwRTtU
	3/4NfJVpX0Mh6LLs1QZ/siCzZNt9V6GRRMisWLdogUM3wWwMjBhsS6DDeuF7X4so
	MJk1AkUDj91wja6/Qu4gvSK/7s/kPmlltun16hdDKy+BXOqxYcLo2uXo0AxFuBDr
	iwaEbkXxFAXM9gqJQE+LTDI+ECieNRtHrcRFnkxiCOWAFFy9Ti3nSOOrmRSg3S2s
	bGsPgv0VgvaIFJP4Kzwa8lGnMFxvp2nOWEIJaQnV0QKDpqsAsROSvB+mD+UkVEMO
	HNTNWF3eGzYi4Wudg0keP0hTpfLmQ61/qoVr1ida/Q==
X-ME-Sender: <xms:P-axZrqRFmeKWwiXuuE-hnjshb9OdApdQtVCs5XKi_t6SW1QijF9pA>
    <xme:P-axZlpE9xaRgDET4oUZdCvI700s_TdbjCte-G9ILtdpKVtxZyBErsrKsSreht4Dp
    UyD-wsCu1jv1ysbPA>
X-ME-Received: <xmr:P-axZoNOCfWzewuwEbiD_S1JUa8We3QNik2K5QHv06zApNH8PEtKI5Fd5EitiZ6uKCfXoPjYEFmshU5vP5NvHdtZ1n-pPzEtzf77yVLMd6Jd>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeekgddtlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtderre
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeehgefhtdefueffheekgfffudelffejtdfhvd
    ejkedthfehvdelgfetgfdvtedthfenucevlhhushhtvghrufhiiigvpedunecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:P-axZu6LJ_ElGrfDjRG3eDI6zKsNzugG8D0cOKCvgiSh72c5U9X4lw>
    <xmx:P-axZq4sOtWdI8lNrxlY7tzOBWKbRVaqIZn_w2GPcpdpcZ2ZPCtDjg>
    <xmx:P-axZmj2N6OycGOg_FBkuNq_dFyxhu5Ln5Sv8LulPCGNyIo7ft57Ew>
    <xmx:P-axZs7rspAYFy3VKAsdXHIP5x2QpOk_cT-qUVtJ-_Cs_OeQT0HZMQ>
    <xmx:P-axZgTnvsz_6tKS5evAvzIlb1rLx33WKgtXo07AxtUxgl6s93GNn3Ph>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 6 Aug 2024 05:00:47 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 8342e974 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 6 Aug 2024 09:00:44 +0000 (UTC)
Date: Tue, 6 Aug 2024 11:00:45 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 15/22] sequencer: release todo list on error paths
Message-ID: <df4c21b49f86d6e1e9d2b28375ab6465ffa4339a.1722933642.git.ps@pks.im>
References: <cover.1722933642.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ujMohirHACF3eRU+"
Content-Disposition: inline
In-Reply-To: <cover.1722933642.git.ps@pks.im>


--ujMohirHACF3eRU+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We're not releasing the `todo_list` in `sequencer_pick_revisions()` when
hitting an error path. Restructure the function to have a common exit
path such that we can easily clean up the list and thus plug this memory
leak.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 sequencer.c                     | 64 +++++++++++++++++++++++----------
 t/t3510-cherry-pick-sequence.sh |  1 +
 2 files changed, 47 insertions(+), 18 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index cade9b0ca8..fec3c5e846 100644
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
+				res =3D error(_("%s: can't cherry-pick a %s"),
 					name, type_name(type));
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
2.46.0.dirty


--ujMohirHACF3eRU+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmax5jwACgkQVbJhu7ck
PpQPFw//WWLFEOAhkmIuvWfTou83AFQED8VVALe09npysb+0eOIQpk/hSU8FjXpJ
WRVRznPT9dCWHmnQHqeISfvKGZSE54rFyA8dJVYO3mPfmVPkP6hT5CQ0yrTe9Gpu
TJAY/chHSA7l4z7vNN+D6a5RxBQ9zyulkZLE93a7GRSar8uqsr+W6Nqlw2qeuHJI
R1UeLYyjYQ65VnUhmq/GS5+VzM/4r0ln+t4M9K7aTUU38TFSeaqr4MZyd0lr9e2v
k8b1ARf88+ILnawgmh1m4Aciv/FfJOpwoXcG07cs2uK8RXssvR6/447vxN/mZuT2
6vJ6ajKitlN2ZTZmf3QDRfceot+ypsnQXnpE39w4jbPcA3lMlXJGJsHuSIBuAIl9
TGcMNUS2CDBXcc1tenuJIsyjXwON4/jc72jIu8+yB/+cCBleIGq5efjKPNgNcEej
+n+shbijsed76aivU9pPZvYMv7xFlqx3K+VIUWOL95sId2HoWCgR15G/2GRQ7wsK
vBrOADkCTWOwJvpko4q+/8Hb4t5UzOxGj+jcv98hKRfjaYIHbQPmKw5uY7EKUxBh
5HEO3DjrIgMN1fpCMtroh8c47sMLk1c9HmiRGhzCr+kcE0TvVvg+6Ig1SkNbsIO2
fv56AwD6LoFEnAFBV1yA98eoZzIKU7ylpMq6DCKJESoswYvauaI=
=xK1M
-----END PGP SIGNATURE-----

--ujMohirHACF3eRU+--
