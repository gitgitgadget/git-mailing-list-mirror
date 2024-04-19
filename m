Received: from wfout5-smtp.messagingengine.com (wfout5-smtp.messagingengine.com [64.147.123.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17D576402
	for <git@vger.kernel.org>; Fri, 19 Apr 2024 09:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713520300; cv=none; b=kLwaLHRs97Mq0yhNCCkjzWKeh31b/8OVB3GGNuCs8Ihih8NYoMaZV+0n9DCYtghv3zGeQ+litNRI/lx1se7FLjLvEQx+sgqkWGQVPN7/jBBTdpX5qG2874gjFuE5CfU8jZO0+vFPrvAuZYHwpdQul8VrUQWz4zHzaGAAsbkY2PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713520300; c=relaxed/simple;
	bh=PONfmiGeRHTRM7v9AmD3ETWgTxwok7Ks6ZiHcgFPHA0=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c2/Qdb3eNkH2l408nEWfVdRGKkE0HKgr648q4IuLKFwMO+gKH8tWZRYGUgLoGD30xGIueBafUGH9754qmPtOcoHS6S6CaBmw8Icb9dIp++wNLl9hm073M+SQ0NGvn/BnlL47m3wFgZ2gsUZElTIfRvxfgx7DPCA89HPbnSGk0Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fKtxkdKM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Q4ntT72m; arc=none smtp.client-ip=64.147.123.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fKtxkdKM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Q4ntT72m"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.west.internal (Postfix) with ESMTP id 6B4511C000CE
	for <git@vger.kernel.org>; Fri, 19 Apr 2024 05:51:38 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Fri, 19 Apr 2024 05:51:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1713520297; x=1713606697; bh=5FVypehmGd
	HDkCBluyaMY64AfAPbSoZNM/Wr9qpEtvY=; b=fKtxkdKMYhn63fIfEte1ca1M3I
	Ix5nzWVOBRO0W3PqfFu2TR+qqkCir7FfrFmpg6K3Ye7ej2NquvA58ATVBtzUiyo8
	4htxhNOA6oKiSzeTYbeKdgD8nqppg5UKnY6uzHKmYyDNSHkssWMwri4Z3gLKalhW
	2B+g6tz/OktqTvh2WjLTBk+rYEG129LVi71YGKK0GuaJBccPybuMyj3v1ftjPtaa
	IBcSgp2PbsmySF92vcqZ5d5rhrxshvdMq8MzTUQiWks+neuQRSdztz73vA7YoS4Q
	gYn4EQ+RVRl2pKNqQpd2W8uJK4EFKcDu+vnI5t5Tk55FI+HtXQ/7YZ99w9MA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1713520297; x=1713606697; bh=5FVypehmGdHDkCBluyaMY64AfAPb
	SoZNM/Wr9qpEtvY=; b=Q4ntT72mVwErpxsXspDSd3EALq17cks0aAb60av/qKoe
	WGyZpx3Q+17JnIvk3/itJlKBIynSipVSvLmoGILEWajF+L+SLQD53+sN6gjHBVEt
	7jYYG+XAOpWNO58Yau82oAq1tSWlT6Sf+DmK7sQtfOFooFVl8UrNyUpAgI9sBFwK
	5//5L5OYenbVueJayMrY0l4AUHWsnJJjixOYYCd9l7+fbWTeiOrq3AWtc08FUFxy
	k3w88/3xoDqx1vWq555Q0BU+U76ZKtXP22fH8RcPs68Mzg8EKwSE7gaHmlKGznlu
	pyz1usWhWq9Mhxx4lvSTf5yFnKMw9oLRWwkAdsKLZg==
X-ME-Sender: <xms:qT4iZkRxb4A0WbgKH8H7PjXhAQSnRBZzEuwDWNebAsOU9BP-xdCRlg>
    <xme:qT4iZhxu3HkJW3jeJ_qYBUYYyOgsZPtXDduJMa8yg_2czVrsPE6hQS-K_LrDdnthQ
    qxADtEz86NxlwQ3oQ>
X-ME-Received: <xmr:qT4iZh1i-K5pfugLI4oh2uXjUFclb5ufrgj16kO99SoP975nJTKiaf_bEy4Mal4NoBPmBjgvgObweQda3EpH4_MmUK4O4wWJvFzaENwNVv65dBv8aw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudekvddgvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgepudenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:qT4iZoBAh4UpPc_3fKuJ8UYtLQ2xfIbpaklNsl4Tfu8fnQzWmHJxzQ>
    <xmx:qT4iZtg6zRC2zonb8c6Y1sZG1byfTVFGiOCmPk531kj-s9K1gnsBjA>
    <xmx:qT4iZkq6RpqvbQVLBXhEt_EwbLiGlW0Fb5xwnnrAjKpo0Nh9nO3ZtA>
    <xmx:qT4iZghfUZYFSnI3P_hqG_selv-ExTjO22tbQ55fvRM-UWxjcb4flg>
    <xmx:qT4iZtbbVSUUZ-H0nW4aCbGVodsPEnUZVYrT2YtGg9iFoeC3Bs-JLmpF>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 19 Apr 2024 05:51:37 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 8733714a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 19 Apr 2024 09:51:09 +0000 (UTC)
Date: Fri, 19 Apr 2024 11:51:34 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 06/11] builtin/rev-parse: allow shortening to more than 40
 hex characters
Message-ID: <9cb7baa50c6df77adfc2017a16883b3cb0c587e2.1713519789.git.ps@pks.im>
References: <cover.1713519789.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="aKZq5boCMbvzLO21"
Content-Disposition: inline
In-Reply-To: <cover.1713519789.git.ps@pks.im>


--aKZq5boCMbvzLO21
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The `--short=3D` option for git-rev-parse(1) allows the user to specify
to how many characters object IDs should be shortened to. The option is
broken though for SHA256 repositories because we set the maximum allowed
hash size to `the_hash_algo->hexsz` before we have even set up the repo.
Consequently, `the_hash_algo` will always be SHA1 and thus we truncate
every hash after at most 40 characters.

Fix this by accessing `the_hash_algo` only after we have set up the
repo.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/rev-parse.c  | 5 ++---
 t/t1500-rev-parse.sh | 6 ++++++
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 624182e507..d7b87c605e 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -687,7 +687,6 @@ int cmd_rev_parse(int argc, const char **argv, const ch=
ar *prefix)
 	const char *name =3D NULL;
 	struct object_context unused;
 	struct strbuf buf =3D STRBUF_INIT;
-	const int hexsz =3D the_hash_algo->hexsz;
 	int seen_end_of_options =3D 0;
 	enum format_type format =3D FORMAT_DEFAULT;
=20
@@ -863,8 +862,8 @@ int cmd_rev_parse(int argc, const char **argv, const ch=
ar *prefix)
 				abbrev =3D strtoul(arg, NULL, 10);
 				if (abbrev < MINIMUM_ABBREV)
 					abbrev =3D MINIMUM_ABBREV;
-				else if (hexsz <=3D abbrev)
-					abbrev =3D hexsz;
+				else if ((int)the_hash_algo->hexsz <=3D abbrev)
+					abbrev =3D the_hash_algo->hexsz;
 				continue;
 			}
 			if (!strcmp(arg, "--sq")) {
diff --git a/t/t1500-rev-parse.sh b/t/t1500-rev-parse.sh
index a669e592f1..30c31918fd 100755
--- a/t/t1500-rev-parse.sh
+++ b/t/t1500-rev-parse.sh
@@ -304,4 +304,10 @@ test_expect_success 'rev-parse --bisect includes bad, =
excludes good' '
 	test_cmp expect actual
 '
=20
+test_expect_success '--short=3D truncates to the actual hash length' '
+	git rev-parse HEAD >expect &&
+	git rev-parse --short=3D100 HEAD >actual &&
+	test_cmp expect actual
+'
+
 test_done
--=20
2.44.GIT


--aKZq5boCMbvzLO21
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYiPqUACgkQVbJhu7ck
PpTzaA//Z6dlvTFxDR11Cx658taKbaLWf3m7dbsFiLELz6MJLeN1EH688MujozLH
amRugKHeRJtvrLykfzfp+64pMVt5VHnron2M7nSOF4jQMOPSJG162QUz22CuvXcU
E6m4vHEB2dMMrlVCJO0mwcXDqXKRlE7q2WxQknhSbL/u5IyFA4tUz217dWpTF2xW
5V57TPsIDV8AwcX+L09Ljg8Fg8GiMdDET1ARCrZ7s2r2GIRggZQV5UZdaDwgRWuD
NegBWM56Mz3XGR5m5S02nrvH4oKzRUVYq5YtddUHWDu63FN2QsNdEMMWfJKa9hIw
/dr7Ti05e0ePDbgq5NyhYO9d7CD9jT6RFTBnsuo9sL79TuvKRr8VZZRd5p6O/3Er
05Km0kirVCpHgGSF6TCC+2jccn3tDcrvtvrSTkuTDEGhDCkAlR4SDHTQN2LH2f/l
EA+8llN57LHiz+IG4ihKUidq9J4x+fCbaUuoCIQeXZZsuVM8YijN6JG8Un0mScNU
7banebNurWvqLMYA1XlruyVC/3+WnZeZmMtW8CMeHYbt8yGWiRp3sSQu0Cj+B+jV
1nTe5Ymxt3aohVrRalElotZH9t/MWu0ktqX3Kn09Q9OPVXH+IvtKAPgaVXbtAn3M
qFBLImideXjfcCQXgeP/wixjNBINXs0AvozED/XJC5gmkOcYWe0=
=RDuZ
-----END PGP SIGNATURE-----

--aKZq5boCMbvzLO21--
