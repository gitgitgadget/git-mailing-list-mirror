Received: from wfout3-smtp.messagingengine.com (wfout3-smtp.messagingengine.com [64.147.123.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D11C176FCF
	for <git@vger.kernel.org>; Tue, 11 Jun 2024 09:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718097578; cv=none; b=XeYDYEKmRZYIKOUXjJbSNV6v0I0Qaeqre1fTFNr4AuiPLx259X1N1dEiJk5HIbBgWj/VH/pLl+0HIxovAi7n/y3POOLVIZ+0N+CAnGc3x4FV37UTIgZXZngQxCruSOnECmc6OP6NpYsMOsgT2UKisYyyvVBec+7MiIRCR4xpKHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718097578; c=relaxed/simple;
	bh=jfnDchLVPk/LfBjzVCY8jVPL56k6OYxckc5UtWjiCC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MgYPKdXAZc+BzEGuqkeC6PPtDvw4FeWPZf3HH98UojU39xqPuA0uv8QWz3N2vvV+ttl9r/e+h1dxqrU6eyW3qn9fdoBdqYFb+wA/9x6WnXZcRy4EygT9ugfH/MzfvgDgqaX/lpFvccDYR+uNNune1U7re1oRaXS2RH4b4Gr9oeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=blWACa/p; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fcx781nk; arc=none smtp.client-ip=64.147.123.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="blWACa/p";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fcx781nk"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id A2FC61C000FA;
	Tue, 11 Jun 2024 05:19:35 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 11 Jun 2024 05:19:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1718097575; x=1718183975; bh=oeD9GnH7jN
	Tq5xGWYBpINUi8Cf59CucMTIFDjfe6DQk=; b=blWACa/pLZv6boWPbMR8IUVBcP
	k68XPQ6VeRox6KGGi9u/3207PAW0/Kbxdaixj7mcVOukYP18wvboBLfq592ze3ow
	iYn+ABpenXIqKDxKBVENm4EOpZgRTDbVpruFZr9Ru6Lt3bQ2VUwB8DoIB7C3uUSM
	GXlDrTyhx3GBqJ/MRBicgw5U2hbwXPFXLi4K43T3wxXF9wXzCu0jxi+H8FpOeG1J
	w6+J4o33zTjW2N20yw9lw/P67u+RAlwAcySmIGK0xfDflokPsnNsCzK2Bk3ZAicf
	KWgm4FO6kHbQC+a+D8W2v5BftfHVId+DpWxY9zTfLwslWfzv3yXqRdmcPRwA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1718097575; x=1718183975; bh=oeD9GnH7jNTq5xGWYBpINUi8Cf59
	CucMTIFDjfe6DQk=; b=fcx781nkY//kWAb2HC43N8bmTQ7qnji02anlvR6EGuil
	btSvlF7E7BGeJmx6WASdeMsz8LQOu+FFLylpaCcumHisQebIVDFGBwEO09CoBWu3
	61Wvufqj4fStf/mV3NbQrLFWHj8LG0nYlCI2+7Zpwr3BzVysXL8aG5yrEKVhaq/J
	OCrCa8naXwtXv3O4xhB8zQFlziCOl347+2mT4TnKFjlg15zzX9qzy0O7Fkh8YVg1
	kwmD2giZ5auRvvDrxFs21txt8XQHguJ/crWEILfKRoYkD+0vrStsumJ/0sc8xrVK
	DDQ/dAOBw3JssmZGCAt2TMAvPIWS8nHNNQBEMhOe7g==
X-ME-Sender: <xms:pxZoZlz8CPzLbEgV2segD7YZM9yv7sELW8BDDiMHNrDGJ6z49pbbcA>
    <xme:pxZoZlQ3VBdH9Qx6UC97IPmt7w6YibMppq2xhtC72hDnBIpXzUKHckmQXXewdb8MN
    faqJ0vFlzQsrMy2dw>
X-ME-Received: <xmr:pxZoZvVeYWkyZuBzjrznhI_m-cqAYBK9s7QWsLnu1zmeRsUX7GC3j9NWYWhmh58MvMKvKtYKvzRSUR0PUFESZguFNvGGP0ix5SFU_BlyNDTBqxoDs1AB>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeduvddgudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:pxZoZnj4hJ76IhzdeZwJ_huN6x3H8qbTn12Pk0kTxvrvWInKokR6dQ>
    <xmx:pxZoZnBfvVCMboq2-bRsrUklPtsFJ3XRcENKtnqDRwqniQmA7K4aTA>
    <xmx:pxZoZgLfhiBHRWQyBIdWRebNiAnCwetT1b1LMCOvZ8NyN1IiKmQyPg>
    <xmx:pxZoZmBRPsqnRSkV47WVl2jRdhn0it0el3cJId_J-hbO5yMQi1QS-w>
    <xmx:pxZoZuNi11SQ9FxJ-lPnCfNZKy7SFYs3z7IPK5M6LzcTCY4ZtmdEXpAt>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Jun 2024 05:19:34 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id d8493989 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 11 Jun 2024 09:19:24 +0000 (UTC)
Date: Tue, 11 Jun 2024 11:19:31 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v2 04/29] bundle: plug leaks in `create_bundle()`
Message-ID: <5a1eae2cc9624375154c7534d2f3ab2e487c1180.1718095906.git.ps@pks.im>
References: <cover.1717402439.git.ps@pks.im>
 <cover.1718095906.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="EAAZl2OM1Fbrqi9+"
Content-Disposition: inline
In-Reply-To: <cover.1718095906.git.ps@pks.im>


--EAAZl2OM1Fbrqi9+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When creating a bundle, we set up a revision walk, but never release
data associated with it. Furthermore, we create a mostly-shallow copy of
that revision walk where we only adapt its pending objects such that we
can reuse the walk. While that copy must not be released, the pending
objects array need to be.

Plug those memory leaks by releasing the revision walk and the pending
objects of the copied revision walk.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 bundle.c                | 29 +++++++++++++++++++----------
 t/t5605-clone-local.sh  |  1 +
 t/t5607-clone-bundle.sh |  1 +
 t/t6020-bundle-misc.sh  |  1 +
 4 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/bundle.c b/bundle.c
index 95367c2d0a..9af558c7a9 100644
--- a/bundle.c
+++ b/bundle.c
@@ -500,6 +500,7 @@ int create_bundle(struct repository *r, const char *pat=
h,
 	struct rev_info revs, revs_copy;
 	int min_version =3D 2;
 	struct bundle_prerequisites_info bpi;
+	int ret;
 	int i;
=20
 	/* init revs to list objects for pack-objects later */
@@ -525,8 +526,8 @@ int create_bundle(struct repository *r, const char *pat=
h,
 		min_version =3D 3;
=20
 	if (argc > 1) {
-		error(_("unrecognized argument: %s"), argv[1]);
-		goto err;
+		ret =3D error(_("unrecognized argument: %s"), argv[1]);
+		goto out;
 	}
=20
 	bundle_to_stdout =3D !strcmp(path, "-");
@@ -591,23 +592,31 @@ int create_bundle(struct repository *r, const char *p=
ath,
=20
 	/* write bundle refs */
 	ref_count =3D write_bundle_refs(bundle_fd, &revs_copy);
-	if (!ref_count)
+	if (!ref_count) {
 		die(_("Refusing to create empty bundle."));
-	else if (ref_count < 0)
-		goto err;
+	} else if (ref_count < 0) {
+		ret =3D -1;
+		goto out;
+	}
=20
 	/* write pack */
-	if (write_pack_data(bundle_fd, &revs_copy, pack_options))
-		goto err;
+	if (write_pack_data(bundle_fd, &revs_copy, pack_options)) {
+		ret =3D -1;
+		goto out;
+	}
=20
 	if (!bundle_to_stdout) {
 		if (commit_lock_file(&lock))
 			die_errno(_("cannot create '%s'"), path);
 	}
-	return 0;
-err:
+
+	ret =3D 0;
+
+out:
+	object_array_clear(&revs_copy.pending);
+	release_revisions(&revs);
 	rollback_lock_file(&lock);
-	return -1;
+	return ret;
 }
=20
 int unbundle(struct repository *r, struct bundle_header *header,
diff --git a/t/t5605-clone-local.sh b/t/t5605-clone-local.sh
index a3055869bc..9a1390a98f 100755
--- a/t/t5605-clone-local.sh
+++ b/t/t5605-clone-local.sh
@@ -4,6 +4,7 @@ test_description=3D'test local clone'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 repo_is_hardlinked() {
diff --git a/t/t5607-clone-bundle.sh b/t/t5607-clone-bundle.sh
index 0d1e92d996..ac5ce9b648 100755
--- a/t/t5607-clone-bundle.sh
+++ b/t/t5607-clone-bundle.sh
@@ -4,6 +4,7 @@ test_description=3D'some bundle related tests'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 test_expect_success 'setup' '
diff --git a/t/t6020-bundle-misc.sh b/t/t6020-bundle-misc.sh
index 3e6bcbf30c..fe75a06572 100755
--- a/t/t6020-bundle-misc.sh
+++ b/t/t6020-bundle-misc.sh
@@ -8,6 +8,7 @@ test_description=3D'Test git-bundle'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-bundle.sh
 . "$TEST_DIRECTORY"/lib-terminal.sh
--=20
2.45.2.436.gcd77e87115.dirty


--EAAZl2OM1Fbrqi9+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZoFqIACgkQVbJhu7ck
PpQExA/+Np8PfdjQ5udXeXvgFg3RkySp+27uwRIu4GvpbBRzUyyoGcIcmPfMim6x
36saTZg1WVSXxHXCRUqbOg5psJOJyo373BRrdkEQWqFSPLom/eIUfzUYNQINYmMJ
dHJOTG/ETg4Q3neRTnu7bsOg7kjjapuTdK3GFVauG1hUTs/WGYL6BiQ4NqVYQLbi
h4rVXvY27DUfLViC0nq88b9whb04BuQb9Q2MjMgv+paxn1tRMX810wyoIwkDN2Cv
Rb+JyWb+yFFQN3q6c7HzIDQBkrNvoxBuySNqkVSLSSzcAgDEUQ/DV4WltaEVTKge
UiF25gXbOITlnnReleEP2ee7N8dDoQHfHywv3i9v+cRpJlzjdxiHdelHhqgCk6l0
IPzRkW737ErBdHoHEmtS6t93F9//j2JZiMqn8GcvzG1ggbjZzBMDVCVvg+MN6tJy
bBPLygsV3mAdR7nLW86qh+I2bvECSvmJo+YY0MmjR+Tb90J36gdy/zb33MDD7szd
VqO2Q7wX8vM5D3KG9ueE09jLiaRbBIa1Mq0X8Mr7SlGxyxmdjuIDT5uig8jYJDjA
WuAFpJIinVYdgFFEpFAVP6kE5mKY0rqyC+v7UwP9D5TdRVlBS5eNQ5D007t8vx7y
BCEjf4luGeOgmjuTNVpgUQNYVb7S3dxgzklYbXH1xGQuTUqm+gU=
=QSgL
-----END PGP SIGNATURE-----

--EAAZl2OM1Fbrqi9+--
