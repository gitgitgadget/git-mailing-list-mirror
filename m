Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0613B6A8CF
	for <git@vger.kernel.org>; Tue,  7 May 2024 04:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715057594; cv=none; b=hf5HgO/WAAmeClgra3RnKRKT54ewiK9i47yUo0aqguzkEwubmiQ/QIkYlm2yAaFCVL/I0CpMbpOicvLiwMMW0xNSjiGVDIemiDFASTM9gbwkMeWphwkoHHB043pd2Qp61F5Up5iT/exvVvBzaeUsyXMQYR34Gwc6PRyDnX6Wqoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715057594; c=relaxed/simple;
	bh=eVSKxBKG5Zcaks94GkwuH9/ZK1uXYptOvHxFszcIwnw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l7xL+y4SpsOzenr6nn8CcRNxC6tpHTPG+0Xq573QEQ8aXq5Y79YlT9ciQMamSAD3gt7bdKZ01r+Ws84YboBgCZjEo9OFO6ZVkDB8asiM5GzHZwgRcWAlXgFvoSfqPOommeOWiAX9dmJs3qaA8FhcRAH0PAs51q8JjgWGNqesze8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=l+KbtFxt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ritcu0Wq; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="l+KbtFxt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ritcu0Wq"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id A1E5D1140156;
	Tue,  7 May 2024 00:53:09 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Tue, 07 May 2024 00:53:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715057589; x=1715143989; bh=yUjhLdCJR3
	wpC8t5zUGcB6E0Qq8OZxSX099He/dQgyU=; b=l+KbtFxtTAC0zhhniXYiXZZ+NO
	WmB1bLQoRqSaLuCt7gCfcVmQp9neA8Rq+DykiJvmPxDe7KVzePRvDRq0SmVoM8gK
	0RVhcX6f+f5jwKysFyO9tAHSta32FfC6rtljYnMygy7kk8EyMdYGH49bdbsmSX2I
	l63rzqKlPeclxnYRr0X0coW2fm3FvvgAZlELNYYRXtpKyZLlzJ7SCBTFwAHDBH2+
	wFFnjx3sB1EZGSKnU88vMPggaHoIU7jIsPZEM0Wum6wxMLShw+u6ekl0P/LBj3ov
	X5QLx3tdU6ZUauIOJqlD0Xs5317jASHTZLT/eDPMvzHcSQhvyKuzHULTMxeA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715057589; x=1715143989; bh=yUjhLdCJR3wpC8t5zUGcB6E0Qq8O
	ZxSX099He/dQgyU=; b=Ritcu0WqUQgPWdcu0aE/j/ZmmkeiHYLEwmzFrec3XCN/
	4951S2+VTxeD0XtdQ7xRRgZisY+kQOzn9hjpq7GonrRRZ+gW3C/KeYT8XZZtCGag
	s/dDPODjWG8Jm0zu2fHMFbsvQ2aJ93ryS2SPFTgCIGhyIWFBH04DP4Ftor5Y4X3+
	G7JrERE95WgT/8aqGN5B5QFlgaH10FDqXJ759l+QHQ6zRyutwY56wwH4CK7AEvgL
	QL/RQvaV/0qFJuEs4v+7WcHTgERVAWGUe5KcnWx9p2WRJLYJC44bzmMCsRDUVc0/
	jY6fQZMZQEBjMunf3oYzkZphKHLLv8dbEghqWlj4Zw==
X-ME-Sender: <xms:tbM5ZpOGvjQkSmHhsiSqQ8EeB26jZgWbpKoooZj3slRYlFAqLy6KEA>
    <xme:tbM5Zr96gXMF1QDclL1RYhU8j0Z_Lofpy_WH4KOtdFFzYQeeKopCzaJz3iRkw0g2f
    zJ04UQWg06XnBh3cQ>
X-ME-Received: <xmr:tbM5ZoQ13UNYBlDVkKpPp3w9MZ38cvV3MGOr8oX-hEisM1nRnebYxqGGn5sj-ljDdnmp7MwW2TNFnSp15Oa4SWSOPyRln_FyWuARgSYa_HLUVvx-QQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddvjedgkeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:tbM5ZlvN17V353BxjAr4gwJ-8uqpH91GYFcr8W75FFOuib94TcbA1w>
    <xmx:tbM5Zhf2icU2BLp62druB2W7AJpoL18ZYt_Z7JzaB8Dw5fCTrgvOLw>
    <xmx:tbM5Zh0O8V5cktpHkgDdh-4qsUZkbJZBf7x-EXXxLv7_OC7hWvrAdg>
    <xmx:tbM5Zt-hqpqDZOlBa9jsoZ11K9_zsp8cyYXqDAUs234LeRm0FBkqtw>
    <xmx:tbM5Zo7ttCV6af_9RgFi3FmRDAVa0POlbHPKu-8XRpK8_S3c_Mo8s43e>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 May 2024 00:53:08 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id cd89540c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 7 May 2024 04:53:00 +0000 (UTC)
Date: Tue, 7 May 2024 06:53:05 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v4 05/13] attr: fix BUG() when parsing attrs outside of repo
Message-ID: <f098ce9690f03bd42411b47c4cea23ecc8d96dee.1715057362.git.ps@pks.im>
References: <cover.1713519789.git.ps@pks.im>
 <cover.1715057362.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="AARL4WP4hA1iJZv6"
Content-Disposition: inline
In-Reply-To: <cover.1715057362.git.ps@pks.im>


--AARL4WP4hA1iJZv6
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
index a5b717e4ce..c89ab3478e 100644
--- a/attr.c
+++ b/attr.c
@@ -1226,8 +1226,14 @@ static int compute_default_attr_source(struct object=
_id *attr_source)
=20
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
 		if (!ignore_bad_attr_tree)
diff --git a/t/t0003-attributes.sh b/t/t0003-attributes.sh
index d755cc3c29..72fadca1e8 100755
--- a/t/t0003-attributes.sh
+++ b/t/t0003-attributes.sh
@@ -433,8 +433,23 @@ test_expect_success 'precedence of --attr-source, GIT_=
ATTR_SOURCE, then attr.tre
 		test_cmp expect actual
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
 		attr_check_source foo/bar/f f tag-1 &&
--=20
2.45.0


--AARL4WP4hA1iJZv6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY5s7AACgkQVbJhu7ck
PpTogA//ensYeu0uHI2mPBVRmwChDFoqDYZrbNMG4YpX0QLSivGu99BC1Z7JY14+
GAit33rVyRM21Lxrpm8Ulx3f6DKf9HX2w0+qAjc1pQe+Ks1oLZkiiuMm4lq3vp+x
cTm7EhfnRB8Fl1lQbZi+mzVVEb6uFQtxLUsmhirEiFxJDnEEE6voy+1MIkaLRsrL
8+TY/xcNNJnCXMc1wdkPyFQUPk1BvTa/zJ1xkcV0wbb1PkqFyAiD0dSBCQSzc54d
dTJoiWxLgevNKA5KiBnJ7u6DotNY0CJfDlu503EO0Vmdzg5aN04Yp2lThflQNMeU
Aqi4lye+tofQDdw/cvx7poOShMMg0oRX+p9SqQmYF5GBBWpqU1gFAdu0xZwFW8pE
k1L7YseFIxJcoh9BC+kQ+bBk59/2o7souUt5YqmC6CEqkDukH66ANsZgrIeD0GKh
E8eXdGG4U6RUCGgGdi/nU2i3qwzauQMs1jEUfMNUpqy6vibueREBM/4ohrMDE5y/
nLIcleA4aPqkegMOB6KCVSr7Rnqv35DEZgE3ilO/xTc2WvxwIEq7yynN21qSTJNU
LneEu5i996SQkZcGJgwcGO1RAsERFONoOEH/po3twMJQUSoEdFPFAv4w2iTrJPOx
BakOcQ+SVKsnFBCc7yGOplFE9re48Vobxcf40R+uaOJMzwHFNUQ=
=S5Db
-----END PGP SIGNATURE-----

--AARL4WP4hA1iJZv6--
