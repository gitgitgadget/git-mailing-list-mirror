Received: from wfout5-smtp.messagingengine.com (wfout5-smtp.messagingengine.com [64.147.123.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08F17CF17
	for <git@vger.kernel.org>; Fri, 19 Apr 2024 09:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713520291; cv=none; b=nMyx9MgCcLPLe3X7/I5FWAvxLPycPeGzAoB9a4Jj1YSPvCYSIMP+Qh6SeRAKm1OEj/Cq56E8H6Mvg0B/I2OCp8qepsKcYDrXrmorBwSjgkng3H0gFvWfQtzvk+1xk2oMYbLf98RgIaDkg8ekY0VreKfKbfQyj3Y+Bf/chyrKB/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713520291; c=relaxed/simple;
	bh=KqXq2Xu+bSPdPJzPxdBlUECFMJvzyExtByOLQ2+gBDY=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nPxHbscZHGmfeO+r5ZrCqz6Vuk7YeK1xohzWWcK+/G8i5w5/FEcbu0RwKsyfOMPHAwmtq58uH6EpdL+o1lTl/3s1gdL5S4KytCaCq6EaaD+UfhkfxKtDp27TZQJtnF0I4vx8w8UjusjTUEi2rA2U1IAe+3DAy0TXmpaMDkQTYi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jsP4qLi4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BeCsm3pq; arc=none smtp.client-ip=64.147.123.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jsP4qLi4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BeCsm3pq"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.west.internal (Postfix) with ESMTP id 028501C0008A
	for <git@vger.kernel.org>; Fri, 19 Apr 2024 05:51:28 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Fri, 19 Apr 2024 05:51:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1713520288; x=1713606688; bh=6+8uq3MDGQ
	VjY6pjK00jntgOR1dI8zDflctoRtJ4x1k=; b=jsP4qLi4aPbtYDUtIj0UwYXzNJ
	TGm8RTMtwOiZM/beIVvh6XVhg1VqsvXWDs83tagGrFluWl2pafbYmsW/F9suHf5H
	r8Aw/bNXh26Pn1rHdmlhJGchBD5Lr4BuO5feMKzAiUUlqBbgqTTrfwezKsYwfNwJ
	iUMWGJGp08bpRd+0DXb7ZPkXY9VdKxjSEYwwXldBNsP9frJUkXmAXhAxK+5dL3g1
	WJbEGGM1JLjTt5TyzweAnU8juZ844bBWS44rXiiqsvIaTaVq+ehUwsJyyZArDtRS
	zEC29pm2aFU4K6nytHKcpaKhquEK3dW0KMYpzvsak+USgx/tQ1r2RbdCe6/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1713520288; x=1713606688; bh=6+8uq3MDGQVjY6pjK00jntgOR1dI
	8zDflctoRtJ4x1k=; b=BeCsm3pquHXNvMQ9PnEniX3RxpHi9uTkvRK8gLAwvY+i
	e543+bKFm61eYs2E/F8p605NCEsBtdMwtWcNs8GigFF5TNMxxB+ekp+YEgmqHrIi
	iJNocb96UF/NVif/i9dxozpXzB8/8n8kBXkEzD8xq5SLgyABK4fEfKx+4mrqvDRW
	2odyrsEoJlY8YteM4gWU5cZ+Udi7Jifs64aw08IyIexWhEORbEKZOsL47Cmj8qfJ
	iaSBs2I1h2jnuQn0ZIZeSp/k6S6WOqNtEHz9hboXi9HNEM1/kaCwuhjnlCgiXkOi
	aAc5g5wo/KNGpy7VN1mVGTfFZmYVk1PeyADrOEdsDw==
X-ME-Sender: <xms:oD4iZr2Rg-Nz8OJD6tnHy3FC4GxXzH0X1LjhIY6nU0vGPIK982znBg>
    <xme:oD4iZqH3Jpw2stqwGD_vxtibVTjO8w0neC8M0zWnhiEt1kvQycmTZGQ3trD6kvuBe
    Y0jdndvIS9yRZVsAw>
X-ME-Received: <xmr:oD4iZr5t3lxgAFimOFQ2NLFqfKuVeCbY9MDa9XZOAga2lRzIjYo9AkGZ06s_i2YNcMT7NExywtkdfPID0lMwuRstJmcALZnZToH3xFG9Hl-gs8LzWA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudekvddgvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:oD4iZg3aWJU5OVCYRQ_QBsOsn5x-m9iMzmFuaCv7IL4mFEORLD5KTg>
    <xmx:oD4iZuFJ_PA8f3IiReP4OWbnQ_7jQ388UfqC-iptEV-c4GZ4yLIw-A>
    <xmx:oD4iZh83HgCRY4P_HKl3bohMUrPvVRHTvnRWbl_wp4PtKMxq2F7GhA>
    <xmx:oD4iZrnjlFeF3iMguAmjiKX7PMbC3dZSXpSuDxLR1352JdHZMVH1pQ>
    <xmx:oD4iZgM6GiJoIP7z2OQw6bmnj2AjTkjenDoCKkj-eNM3nEQqPxieeFNJ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 19 Apr 2024 05:51:27 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 419c4ade (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 19 Apr 2024 09:51:00 +0000 (UTC)
Date: Fri, 19 Apr 2024 11:51:25 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 04/11] attr: fix BUG() when parsing attrs outside of repo
Message-ID: <53c8e1cd7c62e641439b19447525194137a9285d.1713519789.git.ps@pks.im>
References: <cover.1713519789.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="PmZPsRo73tzjERBM"
Content-Disposition: inline
In-Reply-To: <cover.1713519789.git.ps@pks.im>


--PmZPsRo73tzjERBM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

If either the `--attr-source` option or the `GIT_ATTR_SOURCE` envvar are
set, then `compute_default_attr_source()` will try to look up the value
as a treeish. It is possible to hit that function while outside of a Git
repository though, for example when using `git grep --no-index`. In that
case, Git will hit a bug because we try to look up the main ref store
outside of a repository.

Handle the case gracefully and detect when we try to look up an attr
source without a repository.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 attr.c                |  6 ++++++
 t/t0003-attributes.sh | 15 +++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/attr.c b/attr.c
index 9d911aeb31..4bd09bcb4b 100644
--- a/attr.c
+++ b/attr.c
@@ -1234,6 +1234,12 @@ static int compute_default_attr_source(struct object=
_id *attr_source)
 	if (!default_attr_source_tree_object_name)
 		return 0;
=20
+	if (!startup_info->have_repository) {
+		if (!ignore_bad_attr_tree)
+			die(_("cannot use --attr-source or GIT_ATTR_SOURCE without repo"));
+		return 0;
+	}
+
 	if (repo_get_oid_treeish(the_repository,
 				 default_attr_source_tree_object_name,
 				 attr_source)) {
diff --git a/t/t0003-attributes.sh b/t/t0003-attributes.sh
index 774b52c298..3efdec54dd 100755
--- a/t/t0003-attributes.sh
+++ b/t/t0003-attributes.sh
@@ -428,6 +428,21 @@ test_expect_success 'precedence of --attr-source, GIT_=
ATTR_SOURCE, then attr.tre
 	)
 '
=20
+test_expect_success 'diff without repository with attr source' '
+	mkdir -p "$TRASH_DIRECTORY/outside/nongit" &&
+	(
+		cd "$TRASH_DIRECTORY/outside/nongit" &&
+		GIT_CEILING_DIRECTORIES=3D"$TRASH_DIRECTORY/outside" &&
+		export GIT_CEILING_DIRECTORIES &&
+		touch file &&
+		cat >expect <<-EOF &&
+		fatal: cannot use --attr-source or GIT_ATTR_SOURCE without repo
+		EOF
+		test_must_fail env GIT_ATTR_SOURCE=3DHEAD git grep --no-index foo file 2=
>err &&
+		test_cmp expect err
+	)
+'
+
 test_expect_success 'bare repository: with --source' '
 	(
 		cd bare.git &&
--=20
2.44.GIT


--PmZPsRo73tzjERBM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYiPpwACgkQVbJhu7ck
PpSLfA//dq/RL9qS7GRHxhUy+BMXyd0rBCal676i4ZByiy6Ig+NHx1iM07o6CHqg
z5azJgNQbAVX8D8uWEw+takaHfgaWUKirlUflJXKiHwbeNJfARs2zPh3AQa8quO1
+RhSl07Ud+9V3N9KxVEzrt9wIpaYU27VGfcLnq6zuG0Gc1+MXfAYFcexjkV/jVpH
bCssYCnrYXWzvbCS8J1jBNgZ5DPoUseG4CBOJYylCgM1otBhZVs32efnHamqgbKc
MpflP9R7esE0DPRRPJg594wzu7gH04cTj6tkjzUJiLbJVqKkDwSvOo3s3gBk1OeT
vg9U5+Tzqd8f64u0GcPkfKGCrIGo9a4jevlyGThKdpvXaqvLWJH+n/CwZ2+gDCkk
a1wvyTFGzRNrYFzlLv3GvJwajUsO/gfzXWO5q3FXj0i1WYWWwogfzBB2pOHoabCq
t9+K+UrEAwlS9fuYrVXL8F/pGWYGx1FTezMYBkLOduP/gCkGcvAv/5RUFVxTkXx4
ZfIe9A/W/PD1gx4hpILyVf4Vv3oakck7zBTlFJu94D541LECkxLY4RQDi1rwempk
OiBfUIvcUncjaGDHGEIsz1Sf54pPxmAFkAH4k9AusyT5Fp+2bzmAkn+8A/DEByKa
veMGPtH/nJBiHhjc3aWg+mdAYKkP98ArfG77zXGIYLruvdGCofA=
=18CK
-----END PGP SIGNATURE-----

--PmZPsRo73tzjERBM--
