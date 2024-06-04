Received: from fhigh7-smtp.messagingengine.com (fhigh7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE69D146580
	for <git@vger.kernel.org>; Tue,  4 Jun 2024 12:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717504668; cv=none; b=TvDXWtmeQeGrv8DjbhBEowP5FJPW5D6hkSFg8+bfQMFD97o2N+MbTW0n6GDuqukQqZTkCv3GCMHofuHEc6RdcvDct8cY1HUa8xI8kX7rgjHLaUvNbQXp8k4lkQ0bNn+eFV4c5CllFNMM55uFNOedJn9fWT2IjUp6Y5H+72yFNzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717504668; c=relaxed/simple;
	bh=F9MdeYxHJSbuHVws3CJbA9Op6bTfHt5gij+QvqK6mxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=txB2Q0pLjngaofJB3bAM27LiuFJbGWzNLBC2ifhoBSJvk8lPntDOk5O3DdzkTuasfmIQGTTxmQ4dcF19tFImVLhVAH9XLt6miJCIWA9OT5IYvaWhj9wGwIA1GkQAnz1msD8DO2PASuCxD+oCELjM4EBwThxRhcctF1Ie5fwWFwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=XUYz1e0n; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FtWw2v+0; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XUYz1e0n";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FtWw2v+0"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 4971111400DB;
	Tue,  4 Jun 2024 08:37:46 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 04 Jun 2024 08:37:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717504666; x=1717591066; bh=U4AnBVFym7
	0QabwAv69jqBNsnQur21/Cpg0OVRqs4Mk=; b=XUYz1e0nkLTkqkLTtHJ+i5xEBW
	Fuj247gtQ/C8msFkNsglQLc3lgjPBJZyZzvazALZLWXn4rmSkuIhBBx9R1WYQCjg
	XJ6bDcKeACTsR9p8vt9DgDMQmg+Ppiv7Qw5epM3cE5qhcT3VGb0I+/jQdFgndg1l
	rhECgR7ussp7c2f9Tvjw21C4c2SkgKVsPIu+lzwtrjsdrWTH5ruvZGpuF079JvsH
	My17H1JtxGc2X8K6/4cH+8ndD3N/1dTlw9ckvHMo97U9/5lVfXkpQ/t8rZWoQBNI
	pP9LW9ffapNrCegkgM1gmUdD8Vo6DWXbMHjEZXhkCoddC/lwRe8z8z4laJow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717504666; x=1717591066; bh=U4AnBVFym70QabwAv69jqBNsnQur
	21/Cpg0OVRqs4Mk=; b=FtWw2v+0O4kG8Pg7edgVBUSgyPC90JT/3Rbt2goYmIxu
	iKyxFBQQWk5zdpDYMCcEaMn8wzGuY9nSSnM9O1Gnbxp6FB3Rmw0al0dbYF2yx0vS
	3wbec2HEMVy9XPS4pgIv4BKtHP1rGEJu4ZvQ93Q/+x04jH+REPX1dtp5dL5gGvNW
	xQK7eBY2u5vm5TgH4Cn7AzqKrwe1O0RgUMGKbHiUkOxtvvEUWwts0WtPQHb4AaWs
	4JSbtTYhfeOoUFpMAV/XGge0Mg6b3cSONLPz0tkutJw2P9m6FiTn2YbDAyiPSwHJ
	b6sp4dQKGMvd5jiBDlwiHOl5Zb4+QQMr/0lEKImiug==
X-ME-Sender: <xms:mgpfZhqsxJxDUs5KRQLkiNJcy3SGxKBvFTr6S23rLnVk1S4Eo2xPDg>
    <xme:mgpfZjq_Su47j2bkRAKYKFN19CDaq9nOLcH7Ntwg03dD-wa5Xfn5cGTipl9S4a17E
    Ax-8HhVdqnH5KJEDA>
X-ME-Received: <xmr:mgpfZuPfeSrjhX9kgMCA5dSn2emnOW72WIk_jOJVZ13iolRLGUQhdCnXlPxtz48_sXnTPzrl_AgBpu_IvWjco3ljjsaN-143SOQAg6r2vkA6ELBu>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelgedghedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:mgpfZs6xMRl3cmpOYodL_1D_noNaSaGSkPrRY_OZ7HeIYq3GVPp9UQ>
    <xmx:mgpfZg6NEypkvj61lZcYliAQ9MYyG9Bi-AeynmCpwCJazzN3Lp5DNQ>
    <xmx:mgpfZkg_3CiJA7jHWTRukWtU8UkSpMDtYWhnxsamDUrLtsUpEnJzXA>
    <xmx:mgpfZi4zn39tX8aZ4ROnpraK9LazSlPyu-d8W1hASVV2K9NvdzgKOQ>
    <xmx:mgpfZr255qCs6w2K3_Cg3_SMEfafPEDCxFH5oU-2Ht0aX0jH3BQlMcMc>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Jun 2024 08:37:45 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 24007acf (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 4 Jun 2024 12:37:18 +0000 (UTC)
Date: Tue, 4 Jun 2024 14:37:42 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v4 11/27] ident: add casts for fallback name and GECOS
Message-ID: <030dbd0288170eb1cc8fa0186f3b5e022ff67c40.1717504517.git.ps@pks.im>
References: <cover.1716983704.git.ps@pks.im>
 <cover.1717504517.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yV6zZw1xtEgITp2T"
Content-Disposition: inline
In-Reply-To: <cover.1717504517.git.ps@pks.im>


--yV6zZw1xtEgITp2T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In `xgetpwuid_self()`, we return a fallback identity when it was not
possible to look up the current identity. This fallback identity needs
to be internal and must never be written to by the calles as specified
by getpwuid(3P). As both the `pw_name` and `pw_gecos` fields are marked
as non-constant though, it will cause a warning to assign constant
strings to them once compiling with `-Wwrite-strings`.

Add explicit casts to avoid the warning.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 ident.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/ident.c b/ident.c
index cc7afdbf81..caf41fb2a9 100644
--- a/ident.c
+++ b/ident.c
@@ -46,9 +46,9 @@ static struct passwd *xgetpwuid_self(int *is_bogus)
 	pw =3D getpwuid(getuid());
 	if (!pw) {
 		static struct passwd fallback;
-		fallback.pw_name =3D "unknown";
+		fallback.pw_name =3D (char *) "unknown";
 #ifndef NO_GECOS_IN_PWENT
-		fallback.pw_gecos =3D "Unknown";
+		fallback.pw_gecos =3D (char *) "Unknown";
 #endif
 		pw =3D &fallback;
 		if (is_bogus)
--=20
2.45.1.410.g58bac47f8e.dirty


--yV6zZw1xtEgITp2T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZfCpUACgkQVbJhu7ck
PpR9qw//RbmA5mOSjs1L0hKS9hQpvtbN7wpQ00cBBWxmgiCSwJ5fzmHiB8jP0kuM
6/F++Cwq6Q3gOLWnWYCCxsUeAx5t/Mtwyf6ia2HkBU8M0J1C4KW1pC2Sh8kDXkNI
qjBloCo0u8xffOjWOtaFyOq+jIl/tLqjjg3WpmnKVgbIX5pOayaGizbHEr5TJZgH
gd1EJGT1yAj7z7ovGKy/OW1YoBZAW7aSolEf11ULmNweeUPINnRygic45Uu7HnGr
08cQZXUelgcbNSOQZIOru6rtm6S0Ccff5R+dFQDLBYU6WjEIbbd1Za0Ff55+BtP0
S7Ix68PgeCTnh1HQVk+rfyAS+tSWrLpmdkEbaT1FNmOAGaG6gCdJHYheqixOna2f
TC52jyxjxcsXBPibvDOf8H2e5oFDwTLscWCvm39DX+h627EJGd4CJHXehkSyZt5e
OJunNbWCRFJybUqwe838XaMbV5ymoBbBN26WNmfzBhkzk9Iykgm1aXWat11W0qU3
ORxFB8VRyE90qfh78HhmodSytiQudeuEW+V4ZIjKR8OVr62Bn+vQ7RqRUS1LjaPY
XbYkpN2mdKAVXrB052qPq6Oa8F2Wokm7d72FY20YHLrWLeJJxu19y3GS5LSjmfH1
WcaWijfoBAa09e0dvqQR74yTaQ/VsYwJSVXs2Y6doUBBnuCLSfY=
=vXnq
-----END PGP SIGNATURE-----

--yV6zZw1xtEgITp2T--
