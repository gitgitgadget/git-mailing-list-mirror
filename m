Received: from wfhigh7-smtp.messagingengine.com (wfhigh7-smtp.messagingengine.com [64.147.123.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE64127B67
	for <git@vger.kernel.org>; Mon,  3 Jun 2024 09:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717408008; cv=none; b=DVZY3YZuyAAb9SndWhDqwhj0zFIlhdtXqHarAhyU2sIw3rTtyyULpLmrhzp3jWZfbNQNPSpXMOun7X3VK1e/reB22ThEfuYYsOx6hTk41v55CRrBVtUQ3gocPaXSwKmxL7D885mBT6Wei54esKGaKyC+BCfjZMIBEYFdNo+hlhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717408008; c=relaxed/simple;
	bh=xMBzTS+QJ3XPrblx0DBDvTCn+V6MBClVuraNlFMcsqs=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FtWqu2HdoaIONpNdblHekO2KU+MTkGChX81dToGmrJRPiaBkC+MAFRrDzQ/GITwndg4RMCnI8R51tYfRgOVxtxby+sg+7ejyX9oqO8+CHJQromOjlCEzGC+rh8jpEJ7u27SW+bc12AP8OpifnBKo8xp5HKA4ea5XzFLEQSIOGf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=om1yGuDh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MYlRM707; arc=none smtp.client-ip=64.147.123.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="om1yGuDh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MYlRM707"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfhigh.west.internal (Postfix) with ESMTP id 29067180009A
	for <git@vger.kernel.org>; Mon,  3 Jun 2024 05:46:46 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 03 Jun 2024 05:46:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717408005; x=1717494405; bh=KlSva9prd8
	AHhi47XCaqbHhZz5Ea03tJcBEaLUcFFPA=; b=om1yGuDh7gisGCBEp9wec0EBHz
	tw1BhcbNUNvaA5hUdVzkkyZe3CBtI/AJt/KOIG3g9FYsbXEexd6smDhKPvxVlciu
	oL3jMKqB390R8J3daj+DAfDYVJtgH+8Mz96uMhziWmUonlsD8qwf+zIKIdTLXmzO
	vZCYBq/kBr+TlgpqULK9iNUOBsNP8+j1iUAaJ+bG81B+rkik81Z8mO4JSxuVOPeZ
	NaiXkPShgTfX1S+h4lO2gJ5rozzDg5aYLWUwKAomN3mx7CqjktQ6/qbO7hmTWhUg
	OduK4JjSMUaeCipf3tEmz+iYUklZR/sy13zZxfqdit4p+b96I59N5/SXzJKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717408005; x=1717494405; bh=KlSva9prd8AHhi47XCaqbHhZz5Ea
	03tJcBEaLUcFFPA=; b=MYlRM707Ziskg0WQxVDycVb3qQ3xLN4hBN9L1l2pcprd
	ZspYNJBbvp3jZxgegpb18avhTslmHvylbRv7qQHujOm7XKFtVWA789sVhCHNhP/z
	YIg2zrrVXUBuT7rXIsuRpYaSw3liEnkP+d0/MKGHoypP8f6QLTpFLg5RZKuu6YoX
	AoPcldFsuQi8SzNNxu6GrsMi7aDiRM9TGfAaikLEl53QYp2rrUP57+2LGR2/T29x
	wQnjkjo/IKCSSvYDd0bFkBePSQ3zsV4DzonwURfyBFEaF92T0Zu0FqDH7yu5vOg7
	WyGbJqrBanDamCsNd870T/nG3o6jb+db6aU7So6izw==
X-ME-Sender: <xms:BZFdZjceayBsI8Y-hVxfJ09FkRgrDToVTV7GDNw2JrXkG_1SCoxXeA>
    <xme:BZFdZpNja98gI8coSTmiULhc60liAShql2j3MEURfOaAn3Dfw6VuSJ-hsz9Np9gz9
    eUTMC9ZIjTtwS4rZg>
X-ME-Received: <xmr:BZFdZsjPE9l3xDvb83b0Cy4z66wGefLb4QT7u5iQanv-QmPLAYY5h1mow1HFRfLvmDLLdYovBu9txVz-RMpqrmmBO2RWus3ibzjU0I2KA2k7MDa9>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelvddgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:BZFdZk-UYHv3WBkswDCnxjdTIdKLCieBR56i43I79iQaqSkPFgrrwQ>
    <xmx:BZFdZvvjdcSuNCufix2NIH1_o3iGZ6w4b2FC3z_SbNmWZWNNZ9fJlQ>
    <xmx:BZFdZjEwUOfv6t37xhNHrLOje0emjWzxiVU35AWE4Uk7lf4aGv8FgQ>
    <xmx:BZFdZmMcOuZLt4qSsoY9IpuKNCIOmfLtpVvgYAdWkK0vKxWhg22Hmg>
    <xmx:BZFdZoU6Un9gpGDxXbsHAPiRe56n5ziRcvgTDZyCPK34RBY12ZMhp-kW>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 3 Jun 2024 05:46:45 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 2f2f475a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 3 Jun 2024 09:46:20 +0000 (UTC)
Date: Mon, 3 Jun 2024 11:46:42 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 04/29] bundle: plug leaks in `create_bundle()`
Message-ID: <0c8c97cded4b5070f9c1d4b35729636279f87b96.1717402439.git.ps@pks.im>
References: <cover.1717402439.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qN4j0iw7OdA8GxCN"
Content-Disposition: inline
In-Reply-To: <cover.1717402439.git.ps@pks.im>


--qN4j0iw7OdA8GxCN
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
2.45.1.410.g58bac47f8e.dirty


--qN4j0iw7OdA8GxCN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZdkQEACgkQVbJhu7ck
PpRIjg/8Cre8cGnkeFoo1y6F0WpqL/RqQxatlLyDe/oYOtBez3MATr6RSuvKVdil
Wu3VokdCWsD561Id3K3GS2dn4EhtzIdvpoJ7a3HpqhyHqaD1VHp3xFTA5Lpe4dq7
GW+mo85m3lgL30MuUs6U6G6A42cgySVDhbl7csjmjGN3g69R/D/sFn7m2vasDz1o
INnxtjelzYjRZUwMi6FnlAqE/t2FWAeBxLhEklBtgw8tPGpXPBUbzCvB/CvsZgMr
VSsZCBtukrXvATRrnNbHs8Z0hiJhfnfPVypnAEO7pdzgOx3mRj534UbMvXP+FpgV
oZ5uo10auKPIwyTIXJwd8MsD6/6EpD6EMoyjd1Ey1Yw8VWcKUNTL5K1FxmYy8n+F
lKdFV1+kTVRXI4JbPfndbjXGGFY0JIj364BxnVbEqVs2YKwFrsifdWtFoFzLyNPV
GaMnYJ8alvZTno0hagpR8Xk/IVugABOUKJ3SIGoIxt/8oUgCN/br86Gypw6+3UqQ
oCjkLxPcB55BKzRIY0XTqT9uoBspjeV0KXzJ51a8Ux+moeNdibfUx+c87a5rO/SN
C9rmN1kAUacI3rLZSGDB26tnAQYtpVMWxwsQVnRoVkTMVQb/DFzBsxigC9yWuQeN
Y6rdLLQJiVHOTu4eEbYJqH/PlZGYsjjI29t6C+jbaQ8RjvoviLc=
=pkLb
-----END PGP SIGNATURE-----

--qN4j0iw7OdA8GxCN--
