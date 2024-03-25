Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6DC2157A5C
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 10:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711361001; cv=none; b=ARlYSFRhp4MHdmOl4VuMKYjsJyE1MZJNKKkd2HpIbNRCLuukyF8MG9YFUH9hlsNSMQnZiy4F5yV+gNzAqWEhEJ96lA7zc5nMcgBQrQFdSyKcZn+9YvPosDdyJS3YxDzHAXCeeRKX/pxSwlI7DspV9vNNoMzFHwx8aMoMmh8g+CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711361001; c=relaxed/simple;
	bh=pGC5JOMMsDDm9NrEPuDh4xYSlLvvdRT7azYwwaXS46Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DIG40JHc1Q2yS2Qnm/INME/yve7eGtdrRCwijTYwQlEA2UyWkK20WuZpbCFXXzuy1UTZTV5LIUC7rFioE5YK75qGsRye4nUUiL7Z/L1ma/JKc2/kiW5zmTlsfB7Iy2MsNubSnUE6q7Ri4lpBlZoX0fanNCT+3G0ScwoKDAQFDwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=S0S8um1z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xtOulHBq; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="S0S8um1z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xtOulHBq"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id EAC4411400B2;
	Mon, 25 Mar 2024 06:03:18 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 25 Mar 2024 06:03:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1711360998; x=1711447398; bh=BpxXWxcMvb
	Tp852bBm+Wfny8qNXppmKMMorTPRhfikQ=; b=S0S8um1z3MFg/7Zfxkz9HCQQ6C
	yu97GPcA4euOaf1izCtV9qRj6CRJG/pt6cw0m6gGUYC7Ni5SzVPRWLnPtJbz+8tv
	J7mwFkdkxZ37v6hummEZ8iIwbAYKdT8WxEG/QCP3m48Rm4jDPZqP7JLWpmgvnGJX
	tLjLcX948CFbOLB4mm5ieiJ1v7vlnqoFhsnecmh4+XVhgAigKi0xTvOINy1ss0VS
	6Pq0uSOzKQVQBeCG0OuXnuK5KGULvdgaZS7RuRuBhC/CRL5Y8GeAdE5ZOX5h06Z4
	rv911iDjNqLCVdMhkANfrOdGoLA96MVzkAqNuTILfYJKtFRL7j6kn/SFG+sg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711360998; x=1711447398; bh=BpxXWxcMvbTp852bBm+Wfny8qNXp
	pmKMMorTPRhfikQ=; b=xtOulHBqMEGj7HoHWvuntZ3ZBYFTt3DLQVsu4haG9ylK
	xpmUDn4KG9D0ma70HMGl/Y4/vDs/Xt5gfYxF1MCCcskptHYFcw9/7uwjDv3fxrzZ
	bl5q08By+s8WGGWWiLqmiyn18cE2bqqRXcBVuVLFZfzP1rmQKGgASaZA8c4Zmi29
	soL6a0ShwsT+GEllY/G0jLFf4EBYOJsgG9sB0uuF4tJm0WJAZK7Vb/wQgL9Adqyo
	86DnBMcHbQzmwt5HwoRmE55Xp3Q3uJKpAksrAvaq9+ZD/VQF+UkIae+AdiTZ9CXB
	JA6Z14F10knut4FL+pNTp2xzL58qrJtlyQbFFPSkCA==
X-ME-Sender: <xms:5ksBZpkYZDYuScNUW1DD2DLdihEDDbGjOOmNmkYR3fJcNIHXfd1eTA>
    <xme:5ksBZk0LurlIyXToqXIszXb88kj7Nsgo6_PU2XcS0R-HpHIY_Wd5pf8CyO5PuQ9Nk
    jpFvZwBT6IOUA4SnQ>
X-ME-Received: <xmr:5ksBZvpVumJVLB7br2wiAvRtQb-mds8lAR8zyp1Zj7ynZj7MIPvC30C18ynZUzN1NEpAlCUOdjcfeGW5f57ZAIU_uODWB-nonuff3rSlDrrdOg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddtledguddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:5ksBZpmj8MWEhjO8IDa2aqnJQwrwnEcQ391lEYi8myvy_dogVU3-WA>
    <xmx:5ksBZn3iwDXD9traMShWqsVNqSlACi3qov8CMsua3ifO4YB2Jd4byw>
    <xmx:5ksBZotZv-DMeaE_hfIOQgcEkDhRzc7Te8mo7_NQW6QYwkNP25JC_w>
    <xmx:5ksBZrWTrSTnOuWQK78G94aJShIddVzPVCxm_yxofC0c3eF4pipzlg>
    <xmx:5ksBZiQEOKIfYiuDjILueUko73wUw5mrMWH3wuPrviMtBGwzijhwIw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Mar 2024 06:03:17 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a2e2de95 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 25 Mar 2024 10:03:07 +0000 (UTC)
Date: Mon, 25 Mar 2024 11:03:15 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v2 10/15] builtin/pack-refs: release allocated memory
Message-ID: <23c6c20e4ee62bea22bb35c86baad0119985f426.1711360631.git.ps@pks.im>
References: <cover.1710706118.git.ps@pks.im>
 <cover.1711360631.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9CicF3ngk5gTxz8x"
Content-Disposition: inline
In-Reply-To: <cover.1711360631.git.ps@pks.im>


--9CicF3ngk5gTxz8x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Some of the command line options in `cmd_pack_refs()` require us to
allocate memory. This memory is never released and thus leaking, but we
paper over this leak by declaring the respective variables as `static`
function-level variables, which is somewhat awkward.

Refactor the code to release the allocated memory and drop the `static`
declaration. While at it, remove the useless `flags` variable.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/pack-refs.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/builtin/pack-refs.c b/builtin/pack-refs.c
index 97921beef2..ea2baeec76 100644
--- a/builtin/pack-refs.c
+++ b/builtin/pack-refs.c
@@ -13,15 +13,17 @@ static char const * const pack_refs_usage[] =3D {
=20
 int cmd_pack_refs(int argc, const char **argv, const char *prefix)
 {
-	unsigned int flags =3D PACK_REFS_PRUNE;
-	static struct ref_exclusions excludes =3D REF_EXCLUSIONS_INIT;
-	static struct string_list included_refs =3D STRING_LIST_INIT_NODUP;
-	struct pack_refs_opts pack_refs_opts =3D { .exclusions =3D &excludes,
-						 .includes =3D &included_refs,
-						 .flags =3D flags };
-	static struct string_list option_excluded_refs =3D STRING_LIST_INIT_NODUP;
+	struct ref_exclusions excludes =3D REF_EXCLUSIONS_INIT;
+	struct string_list included_refs =3D STRING_LIST_INIT_NODUP;
+	struct pack_refs_opts pack_refs_opts =3D {
+		.exclusions =3D &excludes,
+		.includes =3D &included_refs,
+		.flags =3D PACK_REFS_PRUNE,
+	};
+	struct string_list option_excluded_refs =3D STRING_LIST_INIT_NODUP;
 	struct string_list_item *item;
 	int pack_all =3D 0;
+	int ret;
=20
 	struct option opts[] =3D {
 		OPT_BOOL(0, "all",   &pack_all, N_("pack everything")),
@@ -45,5 +47,10 @@ int cmd_pack_refs(int argc, const char **argv, const cha=
r *prefix)
 	if (!pack_refs_opts.includes->nr)
 		string_list_append(pack_refs_opts.includes, "refs/tags/*");
=20
-	return refs_pack_refs(get_main_ref_store(the_repository), &pack_refs_opts=
);
+	ret =3D refs_pack_refs(get_main_ref_store(the_repository), &pack_refs_opt=
s);
+
+	clear_ref_exclusions(&excludes);
+	string_list_clear(&included_refs, 0);
+	string_list_clear(&option_excluded_refs, 0);
+	return ret;
 }
--=20
2.44.GIT


--9CicF3ngk5gTxz8x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYBS+IACgkQVbJhu7ck
PpRJGhAAi4bRgt1Xfas1asmuWTP1dWT2WEDxbuYjRmR7rykHwOR40RAk5eD8wRCx
PRH8JZ582l7OOHJCX5FgPts2Uspl2/238oSWGBEqRpr2LkJWKac+0wFwwss355Uu
uVGQaTyabIwNYTjsH0THcGxd/DxgLExg5U7bGbjelSQEvDPu6kCr6BLqaTs6yEhB
+aQQ1F3WNGOMT62MykvkOh5qrepOj7NPJkL+Hn8qZpE60SaVY/u8GG3Z59F0nW+R
UGtuEw0tLRd3sCZoyTeyizdmY7ZJnKeLG5Z3pXl6wBP6eNe0IUItFBMkMHfRierE
k7c1Pu/wH++lgTRlOMvGygRBW4/kMQFa8OhW4icb6Ozpgzk0uWFoSkNEipXIx8Rv
AnuusYL14sbNAPQHyFZGh/crzrDxWYa5dHkKFrmKJc4M7YqlitOH9+wyebCjtduT
xVOik5mSM1wDktgsRK6JwJEPeXM/KrBNzITR16mH79O5N8EBx4yldLKwRTO90izv
vSsP7HkfMgRkqb5T5GjnzDzfmeVjSP2itK1awW2vCjaTTQwviVbXZTlshIUT2Iak
K2Pno2IK5JBWRJg//u+f/7kMOA8AX/EeYajTrcvH7gSsep2Fil3UzM+50R/5Pb8b
rVIcQk7wNYgmnHJU8suV2HKLKfcZ6Jnu1YSDicxZ63tbqgVgACs=
=M+wb
-----END PGP SIGNATURE-----

--9CicF3ngk5gTxz8x--
