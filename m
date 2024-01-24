Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411A76D1DE
	for <git@vger.kernel.org>; Wed, 24 Jan 2024 12:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706099500; cv=none; b=WevoGQbQ7YF4/aO3YfBba1Kgp8XfxeFcjYpB+6rK1C3glBbrmKcw2wh4RRdRCq/DeKWLBkgT7gPpRfxMf2gGGubMyVHuzaIfljkFjBnLpwmbAUNb3csBy/EMzbFqECLMUwqQptmAtm7lj/nSlNwCjDKBj1GllgQo2jalXN1UXr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706099500; c=relaxed/simple;
	bh=7ETwRw9WNE9+2vbjAsQ1SRmFm9aGpI6XH54nH2xOuU4=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qlscNxGUrMfUPD4VQ/OTmdkew6gWFQOJ8NdZqI4Sl+Yl3VqEQQfX7FZOUDt/5Vx2HDIgyGqcyJkvSLHrP571T/8JUCz3189zmDNre6B3z2G/1z6IHYR7mr72HY536mp1KdemE5UUR1t9Q4bWcxbPO84kMGuIOdmJR/t1+JlOU+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fjGpikNm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bEzBGEMR; arc=none smtp.client-ip=64.147.123.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fjGpikNm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bEzBGEMR"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.west.internal (Postfix) with ESMTP id 605683200AFA
	for <git@vger.kernel.org>; Wed, 24 Jan 2024 07:31:37 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 24 Jan 2024 07:31:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1706099496; x=1706185896; bh=cpQ12u7knP
	ht4+6H24dsb2zZb3GcNo0CKFSIydIioKg=; b=fjGpikNmoxM93YZ/Ykg07yTjGA
	KsFeza3vNEpENyYK61DdyY1bfrGJ2K+DAPq66WC6391RoE+mkZjIh5FWOIg9wQ9C
	PELt+QFiEcHOKOMfUptesNJiR6d2XgeWonS2b+SSUo2uxPBcVdY5AiIMPo2pvNuQ
	8e6UaI65JnYU5bqJctrHkDt+LXnwg8OxwM7s5iRgGCoPxI4pSYDVoOsHzMQdRtbi
	RbmG+MDh5fOxr7H18VxeDKLBKU8/isdec1h/a7Xb+b548jz2rG3kO+9u5nwlLWv2
	ysDHccpXXWeeqEzh5ncLkyWi91WvMqackzzIGWeinHVvNptoC+SIZgVsEVVA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706099496; x=1706185896; bh=cpQ12u7knPht4+6H24dsb2zZb3Gc
	No0CKFSIydIioKg=; b=bEzBGEMRRn85JjYZObGP7vBichAHDPx8ChwmD213tuRv
	laicxlFzSxbVFoZgAIDFMtBHVvHzWaRbvLGfmmU+TZE7NEJroSqydAIva7hN7DRD
	i0RlKbRs4qw60r+uUSq+trt3uZArxc1lqEgrmAZPiEHxqbv+cWdFQ8DxJbRomXn0
	J3NFjOjAO4XhoCkvuLBLjX8il34QPoBkxHi6gGpzs7fgGZoTIqQ10my0Ny0VuOD3
	3XL2DW9Z380QDd1hr2ENeUUG4DJTJ9iLYwocUEeps2xvPUMlUU+woImXeygnn+6R
	PG8eqFR5aeSqpC/v2Qk/zSeBpVJr80n02ApsTp+5eQ==
X-ME-Sender: <xms:KAOxZX6FUSXTGGYI1W1dAEkrM_m5PuCwTvo2mCoPLWlvIy5auAqgdw>
    <xme:KAOxZc4mw709Q3KjPJ_uGoCIKiVdsCrbtNCSvfpW94kUGt-3CS09PImyRNP77DwOx
    u7iuNRg_BdAH9t85Q>
X-ME-Received: <xmr:KAOxZefxPILIDkMPCQEjQZW1MeReyKYBNc0KshDBrOV6LKeoK-0ABCSmFS_P2cuQ9Vi66aKCs5AhehlIk-ny3HXXxCfFHmJcp-nb8um6DQj8tg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeluddgfeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:KAOxZYL1H81UUdcolfcIpTOvvd_KGjjwg9JCbyvJRAWVo8_3UXrwdw>
    <xmx:KAOxZbIYSlmR1xNYXsOl9pTNL7VVE-v-W66X2um5nM90hqAhMY7Uig>
    <xmx:KAOxZRwMuzfNorPJh-vmVACSz-URWbAG3V3-jfrX__eHV9WGIkkpjw>
    <xmx:KAOxZWklzKiZjHE3wJYVh0Nqs6yPgbRvVJDcjSgDK05psJQzffeo8w>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 24 Jan 2024 07:31:36 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d4f57f8c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 24 Jan 2024 12:28:30 +0000 (UTC)
Date: Wed, 24 Jan 2024 13:31:34 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 1/2] reftable/stack: use fchmod(3P) to set permissions
Message-ID: <4b8d76789b41c6540878810ee2312c49b199026e.1706099090.git.ps@pks.im>
References: <cover.1706099090.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3B94ctfqjRTKOvNC"
Content-Disposition: inline
In-Reply-To: <cover.1706099090.git.ps@pks.im>


--3B94ctfqjRTKOvNC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We use chmod(3P) to modify permissions of "tables.list" locks as well as
temporary new tables we're writing. In all of these cases we do have a
file descriptor readily available though. So instead of using chmod(3P)
we can use fchmod(3P), which should both be more efficient while also
avoiding a potential race where we change permissions of the wrong file
in case it was swapped out after we have created it.

Refactor the code to do so.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/stack.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/reftable/stack.c b/reftable/stack.c
index 7ffeb3ee10..c6e4dc4b2b 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -467,11 +467,11 @@ static int reftable_stack_init_addition(struct reftab=
le_addition *add,
 		}
 		goto done;
 	}
-	if (st->config.default_permissions) {
-		if (chmod(add->lock_file->filename.buf, st->config.default_permissions) =
< 0) {
-			err =3D REFTABLE_IO_ERROR;
-			goto done;
-		}
+	if (st->config.default_permissions &&
+	    fchmod(get_tempfile_fd(add->lock_file),
+		   st->config.default_permissions) < 0) {
+		err =3D REFTABLE_IO_ERROR;
+		goto done;
 	}
=20
 	err =3D stack_uptodate(st);
@@ -633,12 +633,12 @@ int reftable_addition_add(struct reftable_addition *a=
dd,
 		err =3D REFTABLE_IO_ERROR;
 		goto done;
 	}
-	if (add->stack->config.default_permissions) {
-		if (chmod(temp_tab_file_name.buf, add->stack->config.default_permissions=
)) {
-			err =3D REFTABLE_IO_ERROR;
-			goto done;
-		}
+	if (add->stack->config.default_permissions &&
+	    fchmod(tab_fd, add->stack->config.default_permissions) < 0) {
+		err =3D REFTABLE_IO_ERROR;
+		goto done;
 	}
+
 	wr =3D reftable_new_writer(reftable_fd_write, &tab_fd,
 				 &add->stack->config);
 	err =3D write_table(wr, arg);
@@ -967,11 +967,10 @@ static int stack_compact_range(struct reftable_stack =
*st, int first, int last,
 		goto done;
 	}
 	have_lock =3D 1;
-	if (st->config.default_permissions) {
-		if (chmod(lock_file_name.buf, st->config.default_permissions) < 0) {
-			err =3D REFTABLE_IO_ERROR;
-			goto done;
-		}
+	if (st->config.default_permissions &&
+	    fchmod(lock_file_fd, st->config.default_permissions) < 0) {
+		err =3D REFTABLE_IO_ERROR;
+		goto done;
 	}
=20
 	format_name(&new_table_name, st->readers[first]->min_update_index,
--=20
2.43.GIT


--3B94ctfqjRTKOvNC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWxAyUACgkQVbJhu7ck
PpTOYg/+M3T0MeFwkpu8E1Zipv0rYWV1Tc78TgdN/5i4LSGmOV+nar96kDA8p00c
8UaWA9WBusH6OoLxj4idvRQ284xHfnELMhvcc8X1Utao3RrAoLT4Yn6elIqiow+n
pTxF2/aR9eMG+qx7iOeDZQG2uUathxHZ+OiJFuZcG5piBwe0f7+hfudAdQD458Bj
yWGlGQkfZMGCUGmo4rm2Pj+SytGrweu1IXBScEcrMIUUUGPINGr3Jvb5YWAhYT7T
eVKwoTkbUi+yj5j1ov6U/cJUlqT9YZ7JkSDeovwOYN0EZ2/APyXFpdAsh6ie+BSY
0Re+HjkY+yDPyTYOvGcor5Yt9ZnN+kmd4QxiO+aGgQnHp/cvDS0qsgMr97nvJRIF
RSt9uZ8u1G0551Y89tIXIYZiWuwm4lNlL36ibMmqu/g9CIZwRgPvsj4ta7JlPcYB
N0RgZXSLsMgOqr8nFTe0JLddVo2K/cRcq20MuvsXBTPpsjz378fRJv4Lp8zenKxa
aCQ4alsJMVsA2rhwPumh8WKi8DPteiHc+ndVdsTK4ztVNHWZDUFEERNUGp+kYqsh
F+0DG7oQvPNZgwzyGwzTEGV0M198ZRQZ1H8uhhgmWpjQrtYTOIcUvMDbx6dNA6Ee
3Q5IjEIF0RmbkFN2p0V4xKTGvVrGqLRjSMmDiH3pWxDKMQMO34Y=
=B/P0
-----END PGP SIGNATURE-----

--3B94ctfqjRTKOvNC--
