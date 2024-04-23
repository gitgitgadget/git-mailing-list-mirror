Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D18200C7
	for <git@vger.kernel.org>; Tue, 23 Apr 2024 05:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713848874; cv=none; b=SF2y7b+iT3W+4Y8iv951vSbn7ouREIedtCMcHh0OJrrb1vx2tUoZQbtZWwPo5z9ew9jTsj42zFVQldIc5BXo1v8dVoxruAkQuDaLSBvjpAEI87y9LY1/F04tp01QUCNJJKAUquQBOds9XWWlKS4HFcHwS5071XzbIbk7HVw+jzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713848874; c=relaxed/simple;
	bh=BQ8ca6VzY8GiMlHg9ntpCgTmC8hg/Y692xya8P+o7pE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OEi21KTQh+Eb7/yWlUDRluuCqEE4oixF1XCJKIlJOs0t00ghYShok9kRNyjY8O/vz55ynlxQwDMae+wc0SutrSYuyiEx3VVvLPUl/a330QYl00a+3wBcwdggkeG4hp9ibYYZsemwgUV48JDk6ijWTdpCbmMQLpDV1k3nqI0pqTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=L8f6vWBt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NPwujozO; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="L8f6vWBt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NPwujozO"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id A4B15138024A;
	Tue, 23 Apr 2024 01:07:51 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 23 Apr 2024 01:07:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1713848871; x=1713935271; bh=balkgB/F5Q
	Gpx7Jlqa00ksChOu/OiszgfGZ/LosQtVw=; b=L8f6vWBt8MQKqVYMSJDcsJ/ldL
	1ctuYEWfBaL4kO0j8Q7LF163EGIyheR2aOtxf4QNcaJwSZEc0oSMWnqa4BlhW2s3
	AX0piho0zpJ1NQd57f6m1pXzhWJF8AKcZ7GesOAm04Y2uuSDuEO4TErQ5xtEEtjn
	NunkpMzssmyMk8jpVRiIW0El8GsYXLlxKbppAfCdOC8I+PjzABTjj/V0IphXlbh7
	eyFE1dwbOQvThHfRZhXRMybCc2i7OZSc56wF1yHi9XCkz20a289w4uQE1go7fG7o
	u0KV8YmExvXCm46TQty47tzaghDmZf6aP5BILmxiTqYbLCf2QMKUxYLxBRwg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1713848871; x=1713935271; bh=balkgB/F5QGpx7Jlqa00ksChOu/O
	iszgfGZ/LosQtVw=; b=NPwujozO0QtDNVQG+6Nf952noaM6ZkxUsv0uq1Uez2fH
	dEEqetkQbIUu+BJk6rHvT3GSb07xwlZ3iDe4cPrVJdVM5X4LJhK0ymI6cUB62wNK
	lf2YqnfKZQRcMWct3EIHRGJ5s0pZhkFQUoOuhvFk2EWuY6rbUowGPkr+jy4yizYQ
	8AOlML/3FmgCt7OEOamEfVc8XRzn0JdfufFZuzL1fINcGF64Tq+dzNph1q5T83va
	FNa2PHcFl+xcTyQp1jriNGIZcGLOvn2FmXiEigkZDVNGtxm651TODO3zie/twjsY
	gjcWA8U76zVe2sux59ZIyQcGQLy24dOIFnoKneiT/Q==
X-ME-Sender: <xms:J0InZnwM0klpuOj_rhN7JjuoOWdKtfTlfEFiajGUqcw5bNl4Ddj8oA>
    <xme:J0InZvTU7HeMCuEiQ8Su55PwD8ryE186vfEjK0FFB1YXjanQkpQdRHdFPO_Bmk6eA
    BO1IR9HyUrsfczIZQ>
X-ME-Received: <xmr:J0InZhU8ercMweZ8Wk9BLzPu8EQLpk3l45uTb3IqvJjhoH3t4x7QrKT37-mvYoW9D5wGzayidt63gNLvooZUh7jldQd8BLPHpSLkKU5baZFHd8ZY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeltddgleegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:J0InZhjfRc8ehbu7Yz3RdQ4vKr1AtU3d-OXiKOtKPCucB6WJ23zZDA>
    <xmx:J0InZpBRk70VFPeUQ8bmLLy3WLQ9OaPv6w9elEdbFlnEalOACi5h-A>
    <xmx:J0InZqK2p6Ta31JOOm3y0HqPignZbwPKXJoavpx9ATH5O5xXUe6IWw>
    <xmx:J0InZoDgcxW960Fv647E9BuKbyC_4SO_5zzqY2V7olr5Ib27YqG6zg>
    <xmx:J0InZk__0APlcSAsRS2QYbyy3yd1a6DKTJSNexTa6_JLENgEVEfRc8Ri>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Apr 2024 01:07:50 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id fbae916f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 23 Apr 2024 05:07:42 +0000 (UTC)
Date: Tue, 23 Apr 2024 07:07:47 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 05/12] attr: fix BUG() when parsing attrs outside of repo
Message-ID: <26909daca4ad416b1f3d0738751facf2d66d1aba.1713848619.git.ps@pks.im>
References: <cover.1713519789.git.ps@pks.im>
 <cover.1713848619.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="RraWBRFH5wkrRPDz"
Content-Disposition: inline
In-Reply-To: <cover.1713848619.git.ps@pks.im>


--RraWBRFH5wkrRPDz
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
2.45.0-rc0


--RraWBRFH5wkrRPDz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYnQiIACgkQVbJhu7ck
PpRbpQ/9GDCUve0h8ZRRIRU90LFOT9jpGgQkfNLAdcx5AmT6w+LegPIJuMkdoxj9
2xFqIhJ5N0Jx92OwBDp90lCXYkDMTaDtpmcsESB2R44NBGIP1MO+4ugjr+FVzYk3
MVWnFe0sjPv7OgdpJWw9uFSny+aJ8eKXO97X+ZI/U6ivXV9lGQyHZHslsK5eP0QZ
3/P56DrYM/f/p3CXqhavSMyZnupCvTJ3pgis7l1HDProk1JdIu1OZXfIAErqSXUD
gp3VopgxjRrP64kC7+CzpO612/Yx3FcgAJFHwTjfR6zxULOFvo0BfCJXP2OoKHGZ
Dov3zzkQ4Dy2AjSyv3/5LDg1D0RGD/9BLDiOnSqq8/jF+VH9b5bwCsM0uFuKZPtX
VR5J1p/dD0AL7h92Yg736U803a3vDRqx5eCkT8oQT0E+jJy5qkXWjCmnO9IUdVQ8
LVQu8yMQelgl0HyZv+m7LeLcQ1I0lCip6S4ya/ufFVDCYwtblGIHsVt95Qqz8NQ4
6Hx48HTsT+1pyYLBKUbX6O+cAmgToaKV2fl0FB2u74puffUDewg4uWN/lCcW9f3j
J6WmMA0z0vs+z6+/yHq0GYyyMUAAimcsNpXmsIPI8y2EzKoNsbNtGDtLH2DvEusV
t8bq1DbSpV1gEc+2H4dxI58erFyqKMCSgE8wOKYXP4EpPD5Wa8U=
=zeP6
-----END PGP SIGNATURE-----

--RraWBRFH5wkrRPDz--
