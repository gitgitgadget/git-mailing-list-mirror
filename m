Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ABE5A3D
	for <git@vger.kernel.org>; Fri, 26 Jul 2024 12:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721996135; cv=none; b=fgvWwuyvJ5ZYndachKss2Es6pYaUVv/WTjX7R3Ou7p4CO5uDifP3lvdFf+TqzLDqKlrFANb5jeF6k8XLe9wJnkw2tAMV3T0kccRe1HY8AQsmBC44UX3KzEXrwC0zZI9GMbnAQ+GF2+yKHopjwP/Uz2FAL7/p4K0eNW34mAAsVSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721996135; c=relaxed/simple;
	bh=1hdQqrtx6rsU1Gfxt0kfKvJDVWXPRD4GJeNLtvOoMa8=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SwIDTSf5wFOkKC2GOgwcQcWAPqdrtT/N4Z4qKDWGva6kG36XLDvtYPLGGICv/VRgfCklOnBIylLY7zgiTSXMtWW3o5cSQtPbSfVj7i45vDtKgG3Lda0mqvlw8KHEjvWrzJkS5XtKOMTs7kGzBaOvcbvC9SVomGQ24BDlEO3h2Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZnrU9PTP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HJlwFEdY; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZnrU9PTP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HJlwFEdY"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.nyi.internal (Postfix) with ESMTP id ABDFF138066B
	for <git@vger.kernel.org>; Fri, 26 Jul 2024 08:15:32 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Fri, 26 Jul 2024 08:15:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1721996132; x=1722082532; bh=dTd9b77c7A
	S6O/4xOhKLZyUx4c6zN8HIApT6K9jumxw=; b=ZnrU9PTPD3p6yLFET1cKd1NtJr
	OOoQbpPk5567iqBs4/2PYNPDfU11snxuGO49VU2mGWfPvW57PHFa2GlkHmgratud
	kV/oC5Zo/gVnzSR6+2YfgKMwBxoh0dOnyHTZcMMVzgiVcJLch7p+f5S9h9xk+Ik/
	0yrqE12t3dFe/x78ZvDwR+xx7u1N0b+dAkvzbR3O2851641ifEW+El7b2p50ViBS
	iRWvkPnsfclpbWMw4+snhGcDWdOaEzQeT4TjKBRphuwLeVmcoyw9vnD9WXbpkq9b
	WpX+mlZUk9vm8Wr1Z45u2l+1vQRI3XENWWkaLdOZ157+L/I8g29qi4vzLYGw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1721996132; x=1722082532; bh=dTd9b77c7AS6O/4xOhKLZyUx4c6z
	N8HIApT6K9jumxw=; b=HJlwFEdYgnZWbzhTgWqx4hMVPMtBIOL2c05drk1gNYSZ
	rqUuIJFVDCWuWOzcR++2c5dXD8UQjzRm1SRSrvBmTezaI2+TTSi3CWJdB2EjT2Eu
	HOmGxb3lbouIYMwhUCoCA9IQKOZY3NJ91ZlI9ybt/wE0pCRdfnDoQj93Jeng9cZt
	ycEc7MDDFdjnX9Z2PlM37VT223K9eSFalwHTgVEe42NCksI8X0YTzIgk4x3khTay
	KqISpytRrwzmMTlY0mqUp/REgb2cev34w5WPfy0AyGTQUxmgRlTeAu/r+qUubN1r
	fTdhFdS0wIByfb09AknMDf4pqVwNsoCPirp31Ig1TA==
X-ME-Sender: <xms:ZJOjZm-8ZtnqmPxxnLPkbGERcTjrxpAHLqs2GZyTEm1qdAhJseVuuw>
    <xme:ZJOjZmsRVB6gKz2fWIxuzQ74-AMxOelLcgZEydbTqCiJ9SeyWPDESPvgRNGYdDppw
    wSl2tyGD_yrfZ_1SA>
X-ME-Received: <xmr:ZJOjZsDkdUGIkCNsxWYgM_wTfplicUnlQZtObtSlBztj7_K9hi6HyEt7D7C8BH3Ic_M4hTMO1vZ-j-fARLeLD9aBZ0IXA7robNtk-R8CLnL2aVa7>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrieehgdehudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtderre
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeehgefhtdefueffheekgfffudelffejtdfhvd
    ejkedthfehvdelgfetgfdvtedthfenucevlhhushhtvghrufhiiigvpedunecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:ZJOjZudRmnCbDeeRMW11pTj-dSdbbwSoVcqcZgxZu4vFm5_ig_lCBA>
    <xmx:ZJOjZrMtgqa1eL0jSZIFKMKUTDouW_KNDu2tsTv1z525tYb8x1jnWQ>
    <xmx:ZJOjZonjZraXM36sO0XRJBHmOQJiOn7kh0nLNmOus4I8EH7Vlkp6kg>
    <xmx:ZJOjZtuIJR1HOIe-OBXs5Qp6J09qST2422fCZh3PsXKGKotvKbFm3g>
    <xmx:ZJOjZh0TfccD6-Ynvdf76wnA2Q3gD0KhoIW__jrfrFtQbqddIU_mqTvw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 26 Jul 2024 08:15:31 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 62138296 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 26 Jul 2024 12:14:11 +0000 (UTC)
Date: Fri, 26 Jul 2024 14:15:24 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 08/23] builtin/ls-remote: fix leaking `pattern` strings
Message-ID: <d42152654bf91e90b8b417316f255746a3a75155.1721995576.git.ps@pks.im>
References: <cover.1721995576.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5AohA/eV1QVDNFjq"
Content-Disposition: inline
In-Reply-To: <cover.1721995576.git.ps@pks.im>


--5AohA/eV1QVDNFjq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Users can pass patterns to git-ls-remote(1), which allows them to filter
the list of printed references. We assemble those patterns into an array
and prefix them with "*/", but never free either the array nor the
allocated strings.

Fix those leaks.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/ls-remote.c          | 11 +++++++----
 t/t5535-fetch-push-symref.sh |  1 +
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/builtin/ls-remote.c b/builtin/ls-remote.c
index debf2d4f88..500f76fe4c 100644
--- a/builtin/ls-remote.c
+++ b/builtin/ls-remote.c
@@ -47,7 +47,7 @@ int cmd_ls_remote(int argc, const char **argv, const char=
 *prefix)
 	int status =3D 0;
 	int show_symref_target =3D 0;
 	const char *uploadpack =3D NULL;
-	const char **pattern =3D NULL;
+	char **pattern =3D NULL;
 	struct transport_ls_refs_options transport_options =3D
 		TRANSPORT_LS_REFS_OPTIONS_INIT;
 	int i;
@@ -96,9 +96,8 @@ int cmd_ls_remote(int argc, const char **argv, const char=
 *prefix)
 	if (argc > 1) {
 		int i;
 		CALLOC_ARRAY(pattern, argc);
-		for (i =3D 1; i < argc; i++) {
+		for (i =3D 1; i < argc; i++)
 			pattern[i - 1] =3D xstrfmt("*/%s", argv[i]);
-		}
 	}
=20
 	if (flags & REF_TAGS)
@@ -136,7 +135,7 @@ int cmd_ls_remote(int argc, const char **argv, const ch=
ar *prefix)
 		struct ref_array_item *item;
 		if (!check_ref_type(ref, flags))
 			continue;
-		if (!tail_match(pattern, ref->name))
+		if (!tail_match((const char **) pattern, ref->name))
 			continue;
 		item =3D ref_array_push(&ref_array, ref->name, &ref->old_oid);
 		item->symref =3D xstrdup_or_null(ref->symref);
@@ -158,5 +157,9 @@ int cmd_ls_remote(int argc, const char **argv, const ch=
ar *prefix)
 	if (transport_disconnect(transport))
 		status =3D 1;
 	transport_ls_refs_options_release(&transport_options);
+
+	for (i =3D 1; i < argc; i++)
+		free(pattern[i - 1]);
+	free(pattern);
 	return status;
 }
diff --git a/t/t5535-fetch-push-symref.sh b/t/t5535-fetch-push-symref.sh
index e8f6d233ff..7122af7fdb 100755
--- a/t/t5535-fetch-push-symref.sh
+++ b/t/t5535-fetch-push-symref.sh
@@ -2,6 +2,7 @@
=20
 test_description=3D'avoiding conflicting update through symref aliasing'
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 test_expect_success 'setup' '
--=20
2.46.0.rc1.dirty


--5AohA/eV1QVDNFjq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmajk1sACgkQVbJhu7ck
PpR7vQ/+NjFYJ6htNHeXScBJxM/3atw3u/BckmysgNDPT7LT8W15KcBEGQiTHZbx
vMY5o8YfUxY5F91xcWIfE709F7Q1GiDf2Dnb2b/AJYWhlOMtRm+T8lXRGWJPQE4e
m57xtb+7z5hDbBJs2/CagI/yUOz/U1QWBkuXUnarx3ZBUz2aXls0o3VGvXbsAlLT
nRg8na0IJNhCN7Cbokt3B+2ld+v00piibYn2emRuecZmc5CxY8giqQEu6g2/txyq
4uoFDDfHdkI0EL8ygwYNsA0FTRrhbIA2J7e3Ei9SXmkY8d+4o4yxagWVru+hnzzz
aO/yCpVjKZuQJ/2/7P2dalWtoJv/0vN9a7K8UzYkreuxXbjHqD+Kn+gA2fSicEGd
iUpXC3EAaFauanf4Acx/bQkJOlSnv3CP51BYvcvzCippT/AHwceOImKT7OEba2Vj
mJDqcwNt5SsWh70S3fRl06dWDwgs1n5ZuVvXu3gU5MOL64YQwWN+ol8FAAyCvsvN
qfYNllx+bAH1uNyDZWrOgPbArDf7bOPW6nKvjpaeICEP6ZyynX6aMO40w3/RR55H
nTcESFrHxMH2sdXUXBhXSqeQViCAb5OVmpAnKymbzhgeTzviiUyknmbrGKbgLlMi
/quJK8Tqheoqqt2cvaG86NK92GDUOCk+fE827/t7sKiRH+dH3zg=
=Xwb5
-----END PGP SIGNATURE-----

--5AohA/eV1QVDNFjq--
