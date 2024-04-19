Received: from wfout5-smtp.messagingengine.com (wfout5-smtp.messagingengine.com [64.147.123.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0194F7EF1D
	for <git@vger.kernel.org>; Fri, 19 Apr 2024 09:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713520286; cv=none; b=QrMfyGlEv8ycCJAuySPe2/N2kHxnUX177Lt8S3fgvJy19ifSQNrPf5bZClh8YKbDNEhS1fE0PMFSllyw/w+GThydel6JQH2ijO/PHCqWqQKj260XVJib76BrCuiutt4G1pn05b0UbuPLLGh4bvNrAoul/SsN7cmC/4HLLLWfslM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713520286; c=relaxed/simple;
	bh=Sqi5IsOHQj4VL0KH8ywbMnnrwarM5PJAMKl/XZy56+k=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nAxXeK8A7lZmJyzT1s3WFQILhrDO10Bxlz3KDTt3meGFjLXzBew8ZW+xWAYdLrWAZhH7tM9K4PgIBV1uluxOYeQxylmGey1DOqkgC43hcP/9N5Kl0K2G5ea11J5Qq/A8UaUmXrdte+nSvaPF4hpq8hDylEA6rerUTGmeL9h4vKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=aQ9uuilz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BuBOljBZ; arc=none smtp.client-ip=64.147.123.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="aQ9uuilz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BuBOljBZ"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfout.west.internal (Postfix) with ESMTP id 49B531C00065
	for <git@vger.kernel.org>; Fri, 19 Apr 2024 05:51:24 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Fri, 19 Apr 2024 05:51:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1713520283; x=1713606683; bh=+91OPIMdlZ
	sv806CmkuEY1Uu/HnAyYmOwciQVm6o2Rk=; b=aQ9uuilzMvlEh54Amj0iYq1gcm
	7Da/Eqx74S2i4U7JBTV0mnIzpQxmta5GQn0c0yIeo6d+qVFwpStA75uQZTbF7rkC
	WAsR1LZZcVqiM8AJAms9L822nqx+QXIbAvAyD8IFfsCI9hRlykgBEKe0+FSSStik
	fIbmZsk5gWn0FmuhIIi639KShHyUwPTiwae77ojzI2JqZUVoyYRvp789e72piTFp
	RM/M65DLjt/HpA5AQ/wXgfTYsxCEThj5H0dvwN08jsEFBWI8D/vaY4ekCJTBxjYJ
	3PeTFddze4zXjXCS5Igb220yL+IBfwITZ9iiWy10xNfL1Ors8+OO91qvqvuA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1713520283; x=1713606683; bh=+91OPIMdlZsv806CmkuEY1Uu/HnA
	yYmOwciQVm6o2Rk=; b=BuBOljBZ/Bazy5Ohv92P1fakyMBMzgUP7MEpqVlFDelS
	QsLb08LYVSalF26CQzwRcgACvSynGXTW8EEAwlpWQn2N61dlD7KC0so0q37/HpVD
	MdtUZw3tL4S2FEXOVOLh2YctIREInzzn/3EndfXkFgsx4qb+oFnuUQACNsVwx4xW
	IFN70XF/uPQMyCn/OwtBArCWRAfk8iHwoqZ1dc2zpicgd8jnbN6isRFTqehHpjuA
	+bKerE7MflvZMv2Csgff1Zn6N82tupmV66Ta4GoIAaRpm63m/A48hg8+NQCawAd0
	YzEDE2Cvvxo5RDSEsWOR/I723lmGQstSDTzTXasIUg==
X-ME-Sender: <xms:mz4iZuhZui7dP5q6YI0IaO2wYDE7WAFtLK1aEVqFzto582aTnzW8HQ>
    <xme:mz4iZvDT9KvWAM2P4AT2gmPOOucl8CMLrZwemPMskrsOtarVmhghqk4Gricb75V5b
    QP3CuZJTHUptJ8SzA>
X-ME-Received: <xmr:mz4iZmE1SKYFuoF3V8gqYoME4RKWZS01lsu2Ta86Tl0YeASuKRgDMQsg0xoC7n6_kdrLFfdXpjwHMFQxMilta8Gd7e5qvXHeuKCYoAZ6BlvUm8BA_w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudekvddgvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:mz4iZnRMA0UPqB_7HzwyiL6zDSGwvUpAaZdythDu0Gf5cb60GzamMg>
    <xmx:mz4iZryJS6iEXpz7VqwNpo_ocdamKRadsBhb1wUazAyBhEavrbVS6Q>
    <xmx:mz4iZl4pHwifszuLtSj2dUQZsWQXVxNUKcFUTgHnH0SxYVj1t7h17g>
    <xmx:mz4iZoyitI1xfY0HYjlNZ6xf5auZ3MPv0PwYHLy4F_2E7pIJ-5Z3oQ>
    <xmx:mz4iZkryAybYeAwYuL0_yCp-_jbQ1w8E-u_FOkITkHITrcXFx4Ivza8J>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 19 Apr 2024 05:51:23 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 049e9f0a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 19 Apr 2024 09:50:55 +0000 (UTC)
Date: Fri, 19 Apr 2024 11:51:20 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 03/11] attr: don't recompute default attribute source
Message-ID: <ae91a27ffc0158f36758cbaf903db2422df21d74.1713519789.git.ps@pks.im>
References: <cover.1713519789.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tMI7BXFHH5hzmEkV"
Content-Disposition: inline
In-Reply-To: <cover.1713519789.git.ps@pks.im>


--tMI7BXFHH5hzmEkV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The `default_attr_source()` function lazily computes the attr source
supposedly once, only. This is done via a static variable `attr_source`
that contains the resolved object ID of the attr source's tree. If the
variable is the null object ID then we try to look up the attr source,
otherwise we skip over it.

This has approach is flawed though: the variable will never be set to
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
2.44.GIT


--tMI7BXFHH5hzmEkV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYiPpcACgkQVbJhu7ck
PpQMGw/+K8NHgcVp+WRav9xVobgEpSYhFmUTfxunGJFRHPBWUoTY2vprXmSAmchO
NkzS7ah8TStRmNeHeYPcKSCoq8uG10+XyyCb4EnFTaGtLNgOPoHA5iy8JuaF7d/H
BZmbwFw5qIq8q73ua+uup8KUFYrjhF2GALsK5d7JvM0JwQoJUnmR0IbPiLqVg0Lu
WObLDqJWk/bsosil4D3VEqK0WZf2g27G5EZQsOVHKBOLS7E7cFk6lLrI/toatVXb
M4tWt6oyxv/jHnLoL0EHkXIGyrteQuTkXp3fqIjxaM+mHKUjuJKHZi3/9ZWkSC4b
ql3d6RbqPtCtfKIaZjxfjEDM18de/7Vf8UHzDbOa1rOWnYq/E1BbGi/bMSR6tQIU
scD9ziyuECt4g2+f/6soNLkVHv70SxXbKYkggVNr0rUTR6Y1IQuQA+cYvB3yQEJt
UVSAjCyKb3odCiWqfGbD6e5HgYrBK+j+eElnaZlgMcDCCJ54ay0QRMujXq/0Lg4E
zd3629C8Dmx7w7ihDy4kde6HN2VmuekN+jb9NwL8LKRaiRIqiDZwQ8HBSzWi+QBK
dbYb//1wpbSQHZ/x3b55RGz9IbOF+3hLhOq0KZm2B+wOc/33U7Arf91ePUOEnPbv
P2NSntN4tm4aHmCamyevkxkdgrEep+ln3WmF6suGgjSqHiLigS8=
=/qPW
-----END PGP SIGNATURE-----

--tMI7BXFHH5hzmEkV--
