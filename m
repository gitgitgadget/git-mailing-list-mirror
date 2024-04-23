Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30D020323
	for <git@vger.kernel.org>; Tue, 23 Apr 2024 05:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713848868; cv=none; b=WzfDb3AwCy8kdRR4Tq/tWS4fh/7TN2YqN5EkRENLvoLYeC+04t6KKmT7aDwbEOPAdSDlG0YDcVmeByzsh3mUhp9ZxVrvla0YhJ+nJzKcs2HXTpZJHw0rT80/rynFH80vMF8p0Sgj186stgTQXY9bOTs5E11wQ7masy9koirHgT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713848868; c=relaxed/simple;
	bh=bgDgmJ5p9yF3x4jbsTXocZQAwRTUOP7VWYuBXFnBE1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cj2uyUZabVTsE8wQf7m5tSqPYXouJqpTrPdw1Zlrc5gGOv9yIujcx2HlTFg2NtGcPIibXHStZAiTWsdgyrWs6KcFiiDRwxdhz/6koAfowjLg+CS1eNZXGuQc5f88zOcNpVXnkUP714HRBIvHBm3Ev/WT4TY7u8y8KVGR4NExd3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mucgMfhs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=T6UD96kW; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mucgMfhs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="T6UD96kW"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 42EAB1140163;
	Tue, 23 Apr 2024 01:07:46 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 23 Apr 2024 01:07:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1713848866; x=1713935266; bh=AegkeGNK2M
	5e7Zq8fP0jrG9qLNF+ku7wE5Cyik17kOQ=; b=mucgMfhs4oZ9brmymewl0Mp5ib
	En5XlrDfU2hjDmbNSd6zF28zycuPiqcepuW6G8FjDGEkkqV38D1ApAWjY9Ikvhmd
	LoqDlnAWystrQ9h3hIMMlQzQSSWHTo6xnC0dqysu1/UpkfHFivxUA2OVrIA0O/0H
	WHlr4iymH5KpbWwmr8e14H1YfUe754EuTSJ0Z+6IRbdF7lLhfkgwgYDYCNN4ObxY
	AIL98kqoIyz1AnL9MJZkHVs1H02j5i52HdZvjMa2hdojl0q1Vkwb6zusRwh1sZLC
	WE+bbBOVIAgQTHtvXbW9hYjD9pLykwQIR2yulCF4h8CAYOj/yiziwPE0mGfA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1713848866; x=1713935266; bh=AegkeGNK2M5e7Zq8fP0jrG9qLNF+
	ku7wE5Cyik17kOQ=; b=T6UD96kWhpmFRuT5vRhI8svSGdjMSevpq3c09enSC3fa
	Qhow7KNXPrO+FRnjIbAWemkj+yb+HHcZEuQH1KCwR9o/okiHoDgbdrR5fyQszWkF
	E9dWjcoIJEoMv6u/w9IrCQlPqLtvzFj1nFcratFB5isECfLmgGuAfl3aHv/OMJeK
	IdotHMrSz20d7u0v2054qpSyYt5ic7zd110mDf6/PH/Ymf5MfiM5l0YaNC4wbuus
	4n2KOjOEgtQHZ4FBme6/C7AQBOE+QiNecXNGc9o/ijDHDXeqnNjjqaGxCmqICGuN
	cMTOitxDgdA+Rupb8dCg8Kq0mK3AFB65W2WX46jsjw==
X-ME-Sender: <xms:IkInZugYcgWi0sATpjhqznWIQuE1CeVGZFP9zyrBxw9XCDEnWQppqw>
    <xme:IkInZvAmy0Gg3gOKC2zBwE7Q1QM3TDSxto3peqmKFtczjisf0wUDQS0tDjdy-Enic
    XVJNJ7SviHxZ2ZBLQ>
X-ME-Received: <xmr:IkInZmGMG4WaJKmjOOK2D0V3NHT4eJIK03zfzbrYhd1PR5K4GObWC8Ds4yTF3SJ7oYwkMf7CCkAvnJE5r42BRFP_dtXZ9nO9kVroyqbL2TGFO2cF>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeltddgleegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:IkInZnRXKTk4lde_XKu_HKtzajfxUw7O6cimRMAKw6rnBpREZTSXhA>
    <xmx:IkInZrw4YO7JflJEZWkqIUqL34XLBRPidD1NuT2WlX9lG5IX4qLGCg>
    <xmx:IkInZl6sJ8gGASxW0XTWiL5HAP58zBfIYn0eu4-hZCkz9G1YfyecnA>
    <xmx:IkInZoxpBrtbxCxDHmahr8HJngizYWNYuM-zwpW6apHwCOZ31atJeA>
    <xmx:IkInZtsdj6GA7JaUgHkLXR8DnfsN37dqSjx37iP-56baRF9c3xxIuDa6>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Apr 2024 01:07:45 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 4b6e6074 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 23 Apr 2024 05:07:37 +0000 (UTC)
Date: Tue, 23 Apr 2024 07:07:42 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 04/12] attr: don't recompute default attribute source
Message-ID: <1b5f904eedfd1bd3bc5d79cd43baf5e7a83b96aa.1713848619.git.ps@pks.im>
References: <cover.1713519789.git.ps@pks.im>
 <cover.1713848619.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="BI+d+NgszV4bHoJF"
Content-Disposition: inline
In-Reply-To: <cover.1713848619.git.ps@pks.im>


--BI+d+NgszV4bHoJF
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
2.45.0-rc0


--BI+d+NgszV4bHoJF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYnQh0ACgkQVbJhu7ck
PpRgBQ/+NMFY9RcONGwq0pO2zUPzevRaETmkO1Vs4p1gVIbzQaBHhQa+QGmslSel
hnWXYphXSDnZ/RfjQkbawYUzf1NcyCVunpiK5mki22GexzMf7Pb9MPB4KBfGmgUF
S6ei6vXLpm+mNnVA6OpNLeW64SMQwOSVorIQhPK6imNnIZ6kghum0Sx5TuMkR5sn
X6w0uLOeAKabFKLhyUMZGQkHikHvRHjTqVKaZojs50V0vRV7siHbubwpkR/4kloe
31p1EaQamd+xCER+l7M+dRzk2wyjkPXV95MuUAx2ELzvbpjF9emgwHtxt+ENj/cD
PVv020vqeKFA5VYCLvvT0SCXmlodr0+xFKFldCjfYLsqg7gKoqOQY6p/3PfxvcN4
SVh+zLI5+hhV37N/gOOUHa+XbDfVPrHah+61qAw37yiL2P0MidpVq9HB8KKnRFTl
KN+orQw43o+sB6PPz0Qvh0kb6v63yRbENjJ8g+vgp2pmQ7wJry9gsrkJk5MtvUJ+
rb4flyM5m5yniMRd8kFSYTad6u3Q5SDLYuDf+s7E6qk5PYK2OewnIUg+ZF1uFO7x
E7QBxoBaHUt67PgdShDwwVbaybyC+YXGI6WVAwhrIKF1DD0sruuhzm2q6KZ28II4
kkgNBtPjlBHZEDXIXN/B3DYeB1L6bvH/zyk/+bbSwp2g4WYGEo8=
=gCf0
-----END PGP SIGNATURE-----

--BI+d+NgszV4bHoJF--
