Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEAB01BE23B
	for <git@vger.kernel.org>; Tue,  6 Aug 2024 09:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722934817; cv=none; b=FhMgA6HuhsDp7jrbPesf996xV0K+p2X16Gb+GLDqd5XbcnKMe+1cWjdpg1kTkfeNhlWQmGtB+XGpE+w0JvRjh5ZosG+CRFicnffggPu+vBuQBXVtl+NCYCByAaRrbL7AGXTmsaflYqbUOFjuWin0tejy04A26xNkYJpefyw7XnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722934817; c=relaxed/simple;
	bh=/CuDm0fMBKESj2WVUy7D76pFY++WmdGLl8waC+8ZWu8=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UTcIqzuQ2RSnT1g+UCXrbheKMxX1KlRJTPlwW0azH8JfZbJI5J5zeE2oW/zJpsJQsjDq3/zQdNtqxLC2S8MoIZpKtAz45YlY8uCTQ2xowfjGiXC83XPTTbv5+8e9Xwnr2lgsVdN7ex2f9FW8HBOP8lK/n9ns3Fjkkmb8aB6c67A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=SOJyKR+L; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Xq7VgQYw; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="SOJyKR+L";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Xq7VgQYw"
Received: from compute8.internal (compute8.nyi.internal [10.202.2.227])
	by mailfout.nyi.internal (Postfix) with ESMTP id 27609138FCEC
	for <git@vger.kernel.org>; Tue,  6 Aug 2024 05:00:15 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute8.internal (MEProxy); Tue, 06 Aug 2024 05:00:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722934815; x=1723021215; bh=Jomw26Nr94
	dVQjv0iuGByUVNSGpCfoQLGevmSXxHQkQ=; b=SOJyKR+Ltje9CmydTY2hgymKez
	/taSaFCAbjXRer06SRGhwxalCFF14OIBPShBWLeszYJtR17Pdwf9O5WhHqiVwV5q
	97p4KYn69le1KYNA5LBHscQoeq3tj5EYVv5G4/kWRedLks6AMdvsH/GelWBMCbyF
	fFCfrqcD5KdFeDzNzOXuTATKmu6/L5f5ipkkZV9OV5ybsu0KTgvbc5gUog30by+o
	60jvTh7ih03652q1zr38W5i3tuPQm8YOQf2WY18KOgcL1T9e3OtQwmxIikz9G4m8
	BGEDHDov3PVXu64zp9bTXfcg833tqEiSIPsTb3TpUmHukY12cH5AMFpvAPYw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722934815; x=1723021215; bh=Jomw26Nr94dVQjv0iuGByUVNSGpC
	foQLGevmSXxHQkQ=; b=Xq7VgQYw4wt7l8e1slk3hiBZNa9TysTfRqdh/hDnPLrQ
	8313jIwkuUZ+KUk2hhoHI6eeJY+8MLsTj6tHhPFhUeU838SHradgmzjRoktAmPAl
	BqFJqhF9jMHtbfAR/6/IQ6QbjOG7kOwEB4sA6lmR2lIuK0H4bBNdw0Ayg9NNPwIT
	hKIVQj7lqlzBmKrFqwWsjpSMn8V8aszPqKXmpCa8Gqbo3njcSkN4QBHxr5rTKP0G
	a5tBQs+Zuy2b0pPmtdawuFyZ1t96U2wi9vWldM8XCmGd77Zxy0MH/o2pjnSyHDpo
	S6J5ybUdhpPIy/mxKe+Y5COcdAdDenA9+/L8LrxUOQ==
X-ME-Sender: <xms:HuaxZqAAp49YJs3ruIYm-h42eRFi1y9zeNMdjoIZTiCunPf_kgkhNg>
    <xme:HuaxZkggIdCHZUMNqisYCugnMT8doGDHsvVTueARuJ8HlhX8Qnb6_rXHyLu8A7Jci
    jGlb3m9ALx3AcpzHw>
X-ME-Received: <xmr:HuaxZtnG24rvaPcbhbtIL6DZteIrC6bPlySrwYITX66ltZ9P10rmtmRAAkhRsO52Yhv8M6P809nFv9VKA3VSDeI0YRGscbMQWhmtlwNKHaHE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeekgddtkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtderre
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeehgefhtdefueffheekgfffudelffejtdfhvd
    ejkedthfehvdelgfetgfdvtedthfenucevlhhushhtvghrufhiiigvpedunecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:H-axZowMKlcziU_mYMpI_Ig69oUuOozBUWeNthHWd1oQ_TXjT-Dkfw>
    <xmx:H-axZvTjgBmvP1wN5LDoAroiPYteazOaMceaEXLlc5WvyfOrB9s0_Q>
    <xmx:H-axZjbjhOYV3oCudCRmyL_IBEkRTS28gTdR1DxrgC8TbdfyKadZUQ>
    <xmx:H-axZoTTHEc_zbOfAjrkRX36NpNAM8XJVm_DIoNOOHv3KmSUJ77C4g>
    <xmx:H-axZmKdyTkGyU3ouBi-CXa4G2B61ivFdkUw2PhrnRshEoXHZ-GmljD->
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 6 Aug 2024 05:00:14 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a4930ed7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 6 Aug 2024 09:00:11 +0000 (UTC)
Date: Tue, 6 Aug 2024 11:00:11 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 08/22] config: fix leaking comment character config
Message-ID: <a34c90a5527cb45ec89a0ad44dbca1d61705a0ea.1722933642.git.ps@pks.im>
References: <cover.1722933642.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="MREhpF7zN7RASWst"
Content-Disposition: inline
In-Reply-To: <cover.1722933642.git.ps@pks.im>


--MREhpF7zN7RASWst
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When the comment line character has been specified multiple times in the
configuration, then `git_default_core_config()` will cause a memory leak
because it unconditionally copies the string into `comment_line_str`
without free'ing the previous value. In fact, it can't easily free the
value in the first place because it may contain a string constant.

Refactor the code so that we initialize the value with another array.
This allows us to free the value in case the string is not pointing to
that constant array anymore.

This memory leak is being hit in t3404. As there are still other memory
leaks in that file we cannot yet mark it as passing with leak checking
enabled.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 config.c      | 2 ++
 environment.c | 3 ++-
 environment.h | 1 +
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/config.c b/config.c
index 6421894614..63e0211c7d 100644
--- a/config.c
+++ b/config.c
@@ -1596,6 +1596,8 @@ static int git_default_core_config(const char *var, c=
onst char *value,
 		else if (value[0]) {
 			if (strchr(value, '\n'))
 				return error(_("%s cannot contain newline"), var);
+			if (comment_line_str !=3D comment_line_str_default)
+				free((char *) comment_line_str);
 			comment_line_str =3D xstrdup(value);
 			auto_comment_line_char =3D 0;
 		} else
diff --git a/environment.c b/environment.c
index 5cea2c9f54..8297c6e37b 100644
--- a/environment.c
+++ b/environment.c
@@ -113,7 +113,8 @@ int protect_ntfs =3D PROTECT_NTFS_DEFAULT;
  * The character that begins a commented line in user-editable file
  * that is subject to stripspace.
  */
-const char *comment_line_str =3D "#";
+const char comment_line_str_default[] =3D "#";
+const char *comment_line_str =3D comment_line_str_default;
 int auto_comment_line_char;
=20
 /* Parallel index stat data preload? */
diff --git a/environment.h b/environment.h
index e9f01d4d11..5e5d9a8045 100644
--- a/environment.h
+++ b/environment.h
@@ -8,6 +8,7 @@ struct strvec;
  * The character that begins a commented line in user-editable file
  * that is subject to stripspace.
  */
+extern const char comment_line_str_default[];
 extern const char *comment_line_str;
 extern int auto_comment_line_char;
=20
--=20
2.46.0.dirty


--MREhpF7zN7RASWst
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmax5hoACgkQVbJhu7ck
PpROMw//ZuL4dKULbttYZ0XskEmPdkXye3zKka8Prrcp1aaLx2qndPOD7QBAckJB
tipenUv8K1g7S1AlgeCY79z2qf5UVIaKS+0BgetWGl3TGGqY/NU04hl+SPHFwpUt
YkYTW8GnUOpTgl3F9O0AcWVZGwq4wKX+iRZcOjNMbTnlvYJOIHkOgMJU6D4kdpaq
inp/wxQo13CzjI3PF9zRc/EgBGOQENiFTZZQxJLoWWPoJjf1NnV/xpbntL9dkxWb
Axb2lz7VwWAPmC+8vjUnIpZQyudUO0Ehp0fMIZUNMC6DAlUUX1D7Ng6EhoxMdMgd
wTessrkrEnodVd+wu7YP6kE+c0HPdr3u8tcJIPrPhbkEEpIgctKmNWWT2RPiH2An
S6lhrA2WV+kK2M8g0eljVCHyBOjkuevkloxvBYnLV53nfyyp9st8uK/RGjHOyY/h
CU1yn0Atbi8DSfNu2zLvSaX2Sg1cI5zIpjtbB+/GdVOK8BEC7BUpRlnUGuux6qpl
VaARnxTYzZeD92YlsNgUkPDrCWs/uuOP4xIi53LSuMWpcgwjkxVSZZ+ydmbCGcbQ
WXFRrR6MqX10kZ6iWZKB49N9JQCrvdNe+hbFDQ8MYs15ABHWkCpGq+GqbBmg6Z7R
aFTCp5gv96jz0/TChEZDkxsq8fp24DzjYrCP6ErhOUugY9au9O4=
=bH5h
-----END PGP SIGNATURE-----

--MREhpF7zN7RASWst--
