Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64032134BE
	for <git@vger.kernel.org>; Mon, 29 Apr 2024 06:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714372474; cv=none; b=s904CvmuN6wwuvUO1YdjNp+vdHPtfMNVVdoAcozaWJrRMgfvj4pGn53QxxLCVPqvco8HG/ZfIEZ0JlmMngQA7mqVoY9ZzLszWZelU1ePa54/F7yRUr8tzQUiJTa0a/nyodD53SQAYjDXnLKCFQbq9/Hzrtio8eNta9LBx9oYHFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714372474; c=relaxed/simple;
	bh=p/X1yBt1q08IomtAyxeha6FvfE6uMvpiNgZujoQk9Kw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RfKX3rm5tkVFP50PJVbciL1yNv6iI6HhIF3w+odS8RxnKdeXhQ6LMXnz1SkeSXbl9bx4w6VbdaTZcDCfMuDVd3Y9TKv3tDTmvg7/aGdwgSukIegAtd+OdBhbFuSoP5wuSWciWU/5T5GkCilAwSKZ9KITEFTe8CeVpVaXE3cKUTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=C3EdX5ce; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Oo1yp3zM; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="C3EdX5ce";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Oo1yp3zM"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id 80A381380388;
	Mon, 29 Apr 2024 02:34:32 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 29 Apr 2024 02:34:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1714372472; x=1714458872; bh=ywSYOnWNB2
	iP06q+nHlh2dy9PYmPNclr8uRKOMQvpBM=; b=C3EdX5ceFXm5VBWkdyMSSKa0yW
	75EsmyoxU029+07R/1gxa7nrRNw9yYsot1o2UHiC70FXsNepr8gidfg50VhyGKVK
	PwpVGTe64n1/EyKC0mHXApEfkXLXGzucRKTv0UyHqKwZyu8h5JIxdqWIy+FVPegp
	iLWOZ2eVeHn8w5SPOcE/wjcABIIcrg1EXLaYHFKxFvagxMnsiZOGyDIi23oMODVQ
	Gae0KV/nVdk5z1YUYiJih3WvODFtJvetvzzGHTMPMi+G0qxv+ezjFyG0UCSz4S/h
	V5JA5CdZJ1xhlK9ekgUFUqYKiAE3si0XwpuNVeFiPwEpx8fXLfhcUGywrTSw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714372472; x=1714458872; bh=ywSYOnWNB2iP06q+nHlh2dy9PYmP
	Nclr8uRKOMQvpBM=; b=Oo1yp3zMIMcFjRPwDvhrZ0xcXA5cuWK8b73GZm8Iqp3P
	5IGy+FfYSK2ZbYKqv6honyJorO8vfiXwZVB6a61uNrwxk0T5gsX4KtIZBV740OJH
	qT6RE/cqQqE67Ue7sc3134hgy0it2D/N9BkW6a2xMmqeteuKXmvhIjQy9RD90F4r
	l9hocSjKYMySUHyif6jgYUlScsUDyqREOQrftvn+/qzD+WULUcMZ5uG+RGqof9Ii
	3FDA/iUOwE5iTS05WGWB+bTfZk3IPtOlldb65befJFQLxYuLn/YvFqosp5hpsEKk
	vnQdcV0SLVn2WucqyGmH7WJuu1dtB1IsODefJPzbow==
X-ME-Sender: <xms:eD8vZm6X6Ht4IfsFjZdGu4OkXidIpuTBwKqFBXdA0TK-P5QvnUl4ug>
    <xme:eD8vZv5pc_8Y2hZuAoIAho4dZMH3dvPfzOLDK4T9XFXChZoWTZC3LaV-lNaSNABLI
    HzErAt2n8umUIFaYA>
X-ME-Received: <xmr:eD8vZlet5mZYvDSrr7DLW8AZ9iZG9iJsW8ixtG6zU6EYEzPd6ITwV9tI6X_3SuHTElSVBgMRc12Z2T8CfLxxGJIdezlkxv_XgXYeYEy3CSbzoIhR>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddutddgtdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:eD8vZjJkC5PNs1sv2i5_PMCnm2xYshmvdmK-oN1G4jA8lVpxMr_Fsg>
    <xmx:eD8vZqJZOs6nvVvvt0Rnq97kAXSIoSaQhXZ8r7uZGwhJBml55NRJVQ>
    <xmx:eD8vZkxSntnKoswTQIzD1ABWGPDPmQlqi5pbfwGQ2kbsOJZVpiaEpQ>
    <xmx:eD8vZuLjBh_sjdF2sVoxpUYX_Dw3x8UbuGuFjxSKHb9zZF2BtqOg4w>
    <xmx:eD8vZvFMCOq4swWAW9jwrwwQo2KTGk_zxzuKmJp4kx_HJCwXZws36mqP>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Apr 2024 02:34:31 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 4da46d85 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 29 Apr 2024 06:34:11 +0000 (UTC)
Date: Mon, 29 Apr 2024 08:34:28 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 04/13] attr: don't recompute default attribute source
Message-ID: <929bacbfceeb1627b257f68d9f66155878a11e18.1714371422.git.ps@pks.im>
References: <cover.1713519789.git.ps@pks.im>
 <cover.1714371422.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="l1iMgK8H29VsY8SZ"
Content-Disposition: inline
In-Reply-To: <cover.1714371422.git.ps@pks.im>


--l1iMgK8H29VsY8SZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The `default_attr_source()` function lazily computes the attr source
supposedly once, only. This is done via a static variable `attr_source`
that contains the resolved object ID of the attr source's tree. If the
variable is the null object ID then we try to look up the attr source,
otherwise we skip over it.

This approach is flawed though: the variable will never be set to
anything else but the null object ID in case there is no attr source.
Consequently, we re-compute the information on every call. And in the
worst case, when we silently ignore bad trees, this will cause us to try
and look up the treeish every single time.

Improve this by introducing a separate variable `has_attr_source` to
track whether we already computed the attr source and, if so, whether we
have an attr source or not.

This also allows us to convert the `ignore_bad_attr_tree` to not be
static anymore as the code will only be executed once anyway.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 attr.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/attr.c b/attr.c
index 679e42258c..9d911aeb31 100644
--- a/attr.c
+++ b/attr.c
@@ -1206,15 +1206,16 @@ static void collect_some_attrs(struct index_state *=
istate,
 }
=20
 static const char *default_attr_source_tree_object_name;
-static int ignore_bad_attr_tree;
=20
 void set_git_attr_source(const char *tree_object_name)
 {
 	default_attr_source_tree_object_name =3D xstrdup(tree_object_name);
 }
=20
-static void compute_default_attr_source(struct object_id *attr_source)
+static int compute_default_attr_source(struct object_id *attr_source)
 {
+	int ignore_bad_attr_tree =3D 0;
+
 	if (!default_attr_source_tree_object_name)
 		default_attr_source_tree_object_name =3D getenv(GIT_ATTR_SOURCE_ENVIRONM=
ENT);
=20
@@ -1230,22 +1231,28 @@ static void compute_default_attr_source(struct obje=
ct_id *attr_source)
 		ignore_bad_attr_tree =3D 1;
 	}
=20
-	if (!default_attr_source_tree_object_name || !is_null_oid(attr_source))
-		return;
+	if (!default_attr_source_tree_object_name)
+		return 0;
=20
 	if (repo_get_oid_treeish(the_repository,
 				 default_attr_source_tree_object_name,
-				 attr_source) && !ignore_bad_attr_tree)
-		die(_("bad --attr-source or GIT_ATTR_SOURCE"));
+				 attr_source)) {
+		if (!ignore_bad_attr_tree)
+			die(_("bad --attr-source or GIT_ATTR_SOURCE"));
+		return 0;
+	}
+
+	return 1;
 }
=20
 static struct object_id *default_attr_source(void)
 {
 	static struct object_id attr_source;
+	static int has_attr_source =3D -1;
=20
-	if (is_null_oid(&attr_source))
-		compute_default_attr_source(&attr_source);
-	if (is_null_oid(&attr_source))
+	if (has_attr_source < 0)
+		has_attr_source =3D compute_default_attr_source(&attr_source);
+	if (!has_attr_source)
 		return NULL;
 	return &attr_source;
 }
--=20
2.45.0-rc1


--l1iMgK8H29VsY8SZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYvP3MACgkQVbJhu7ck
PpQI6Q//eEZV+EMbCnxf8OZ157HL2ZgE6UUqTgJoBi6Oo6DKGe6GOVeQeYnQq8M0
deisHBMzPxu3Gn4I7xTcRbYHvIiFTUK5HpDoLOC/oa0eNLHKD5ImOI5ucRnI81Bg
Seeers4gSJ6TTYF/RM7Pfx7fKUVEhpBRYML41Cn/Z1lof+6HTclQVhxqSiZuJJ7W
G71dGCcY966HXPC8O6+5WxoObOn5HIjUWbmrGkd6gyQNjwjvfZjPb3IrMYrAipmP
VL/Jg4E4cuq6+wU/EvTMtO7Y4BBlaNlXZf/Hel9GSoDiUFn11uCP7Vtc31V1I76u
+aclKEjJn8mW4ltfr7m648GTMkAZyT0YYMAPE0xa0gTYlX0Cwc4ZWkw97tSY7gZS
cq68onFQuMSj6ZydwhOd7Hg92wmfFGTtU2I7LmZcPT+fkBQVQkTEhHGeUqezw19I
azgTxRCWAOPYN8DzG6BCJ90FrktcyAyzUFdDDp0xIoflMSPmBduAPBDB48dwTy9v
UL02RPRUAp9K7FoBooJZXojFnOoyN2h5OduRLhqSY1lQ6nSnyFWFMkqqPAk13pGG
w19Xy0LDdBdtUJCXt2X7S9Sx0x1hTRHEDW+Ynq3quDG9ibfrJFTjNs9AxB5QQ/PX
G0pciBfTjLqD3buAM+W6rLUqGIvM9YUtXvjTtF/ne/Lk3gswv1g=
=4BO/
-----END PGP SIGNATURE-----

--l1iMgK8H29VsY8SZ--
