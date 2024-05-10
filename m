Received: from wfhigh8-smtp.messagingengine.com (wfhigh8-smtp.messagingengine.com [64.147.123.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653A215F40C
	for <git@vger.kernel.org>; Fri, 10 May 2024 08:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715330902; cv=none; b=V0emNWU3CSTnCccHSHjDq+Z7Z6HtFMlWXQQX10znYnxmmSPFoox34upQVeSVE1/FoyZFGJOHC3cDw0FKlmtvHgAIwEmTrwtUBb+CsL1OWKC27Pn3OFsyo3svx/pHfnnq/Fz+lwY9B5Ysh/6aOAMfErRqQXIK2KoEZ6MTQp1ptvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715330902; c=relaxed/simple;
	bh=l5tvIdZC9TD3rJEbVcdBmxWq7V8VsLHeRsfGn2HeVIo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gHKIQ3T/o4Bc/gN2nM2OSXW0SMSwCplh9wKvW3RZ/I+Uu9f8TfLeJnzth3D4Y6j/UrTtxWOE3Z6Pq04t8rEWMDBTQUMY6Xxac4zI+gjXQBYxH2Zbyt/psM3EoXYGypyLwg447mWTDw/20rgICI9gzAvGberumsBa7Jy3471dgnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=WlR3xera; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Na11S2dz; arc=none smtp.client-ip=64.147.123.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="WlR3xera";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Na11S2dz"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.west.internal (Postfix) with ESMTP id 3B1011800109;
	Fri, 10 May 2024 04:48:20 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Fri, 10 May 2024 04:48:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715330899; x=1715417299; bh=53tIwq2Ih5
	cIx0HpLrFJrek7tknxrouW/va3dv5TS8M=; b=WlR3xera8hoTpkAfdaVvXdYRHw
	2Eo9CKwr1bOHJaM2A+cFNmYMzRs69iKjzHfW91uhRSBNn+W4kPwW912BXsVNimWO
	os/nZBdMJNQLOTS1tbQ0oFejFR+i45c9onQD4PFzoWgE1d7RFVm1SbFybvNIVvwW
	q/pnxGZHt90PPPxWyWuQ3640sIjmwCJ2tHHF9eNuubAa5mR4F7lL7fbsL93Frp+J
	EEK6oVZvO8N3Zn6m1dQu9Y7zOWI6eqG2SgMwaW0FV+wRZ0EdmAYZS5Twnrc5Df6W
	YlTiGJ0afV9jUK3p6qjxFfl6zQTaGkMwJxURkLds0NXDX9oeD8jU/KqT5czA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715330899; x=1715417299; bh=53tIwq2Ih5cIx0HpLrFJrek7tknx
	rouW/va3dv5TS8M=; b=Na11S2dzHAd9FhQTblES+WGU8M5XmET5Fd04lakJbdMd
	LLfDjY9CA+NeahubE9RlaTLrSEuNLpg6LvkCXItYtQT+gq5PxofA1eEysI5cEdlY
	5+JcRazKM9pVMXJcNKU6dDVDH04sykrjjVf/cgf1rHS9aWalppLFi51qtlKIp32N
	CBFbpzncSFxoBpajprSaIK3LISHU6HisLkDNdERR0Y5rAXJxyolbzwpV7a0q0zhI
	bHdAWlFItbyqL6Fo15yvu/bD6kAkGsahbb57piCjgK8IKvczWz71yEEGvIglOCxl
	jtH5uebrV6wQL57a526ko7dLrM9vz7CoQ0Mgh2Cnug==
X-ME-Sender: <xms:U989ZgP9eDnbUyEQ8pqhes9YZPKVS9T_0-vGNqAqRJXqrJxHh7iIxA>
    <xme:U989Zm-Ijkw4lGrL6tVKVPIIiS2wYCxHs7gkh9U4S2jCbYW4rPVb0JavrpNkgiY8U
    w9q625A1YRpCx5pTg>
X-ME-Received: <xmr:U989ZnQp-KZniIA7MIlp7Nrc5lNOCarHLRJswSt3k8lAQ8Z-hcjxhL6qZks09YfVhukeLDNNjRGPSVFCj-aeQIjpRScrUVXcobdUTOLfaKAXK3U69g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdefkedgtdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:U989ZotKuyCPoNZ5QKpbIt-DMQcablKUOG73u4UGvnBe5zyaPbnOXg>
    <xmx:U989ZodjH7MNZZ4z3ekAtoBRXAsRDcl7b54-oB5QzE4eSa7DLbvJUQ>
    <xmx:U989Zs1GI8tXuPBp6Ku1zuPDq_ggjqeBNWOVWDq0m8T3xuDDv2cxCA>
    <xmx:U989Zs_kOq3fZ9E1H7yaLnKQcnktz-GioF0RXWPslH7gj7y_3_0A4g>
    <xmx:U989ZvxWlNWDcZ4FO2dchqeA3s4h1qNBVZcZh5ieMJpFTfRz255CHFJe>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 May 2024 04:48:18 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 06be75a7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 10 May 2024 08:48:05 +0000 (UTC)
Date: Fri, 10 May 2024 10:48:15 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Karthik Nayak <karthik.188@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Justin Tobler <jltobler@gmail.com>,
	Kristoffer Haugsbakk <code@khaugsbakk.name>,
	=?iso-8859-1?Q?Jean-No=EBl?= AVILA <avila.jn@gmail.com>
Subject: [PATCH v4 03/10] Documentation/glossary: define root refs as refs
Message-ID: <79249962f5798ac31724d32233ce814d99afd649.1715330206.git.ps@pks.im>
References: <cover.1714398019.git.ps@pks.im>
 <cover.1715330206.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="T3WHd0m1L2fjLMKi"
Content-Disposition: inline
In-Reply-To: <cover.1715330206.git.ps@pks.im>


--T3WHd0m1L2fjLMKi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Except for the pseudorefs MERGE_HEAD and FETCH_HEAD, all refs that live
in the root of the ref hierarchy behave the exact same as normal refs.
They can be symbolic refs or direct refs and can be read, iterated over
and written via normal tooling. All of these refs are stored in the ref
backends, which further demonstrates that they are just normal refs.

Extend the definition of "ref" to also cover such root refs. The only
additional restriction for root refs is that they must conform to a
specific naming schema.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/glossary-content.txt | 32 +++++++++++++++++++++++-------
 1 file changed, 25 insertions(+), 7 deletions(-)

diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-co=
ntent.txt
index d8c04b37be..c434387186 100644
--- a/Documentation/glossary-content.txt
+++ b/Documentation/glossary-content.txt
@@ -550,20 +550,38 @@ The following pseudorefs are known to Git:
 	to the result.
=20
 [[def_ref]]ref::
-	A name that begins with `refs/` (e.g. `refs/heads/master`)
-	that points to an <<def_object_name,object name>> or another
-	ref (the latter is called a <<def_symref,symbolic ref>>).
+	A name that that points to an <<def_object_name,object name>> or
+	another ref (the latter is called a <<def_symref,symbolic ref>>).
 	For convenience, a ref can sometimes be abbreviated when used
 	as an argument to a Git command; see linkgit:gitrevisions[7]
 	for details.
 	Refs are stored in the <<def_repository,repository>>.
 +
 The ref namespace is hierarchical.
-Different subhierarchies are used for different purposes (e.g. the
-`refs/heads/` hierarchy is used to represent local branches).
+Ref names must either start with `refs/` or be located in the root of
+the hierarchy. For the latter, their name must follow these rules:
 +
-There are a few special-purpose refs that do not begin with `refs/`.
-The most notable example is `HEAD`.
+ - The name consists of only upper-case characters or underscores.
+
+ - The name ends with "`_HEAD`" or is equal to "`HEAD`".
++
+There are some irregular refs in the root of the hierarchy that do not
+match these rules. The following list is exhaustive and shall not be
+extended in the future:
++
+ - `AUTO_MERGE`
+
+ - `BISECT_EXPECTED_REV`
+
+ - `NOTES_MERGE_PARTIAL`
+
+ - `NOTES_MERGE_REF`
+
+ - `MERGE_AUTOSTASH`
++
+Different subhierarchies are used for different purposes. For example,
+the `refs/heads/` hierarchy is used to represent local branches whereas
+the `refs/tags/` hierarchy is used to represent local tags..
=20
 [[def_reflog]]reflog::
 	A reflog shows the local "history" of a ref.  In other words,
--=20
2.45.0


--T3WHd0m1L2fjLMKi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY9308ACgkQVbJhu7ck
PpQ4Ig//ZN4bN4p+6urKveKgL91K72pdZibM36Y4+kz0eQRMghdSAlvc8yG48rSC
bHe6U7nWzJnlOAySI60pN6Naj3Z7vpY6PD3ES8YjGDGDHT9Agn7Kxs0wm4L5IPfw
i9+gufY2PcP4/Eug3KFoep2OtBB3tEPJS2Sz5RSgOoh02KDJF//G95hqAE7nZEyP
sMCYmrNS4s/HpOjG2Y+PffX+kZtsPouCU2YN3wMs8xY7dAZiSezYB8hbRTspaKfq
ECrEigbVRMCXoBZCPnQJ2trxTFY8aIPLOm4eOZDVD6uwVGjL78lJLfzQbWL/cQBi
FqGIwybjHW0pGNEeVWbQ7xFix9OM2lA10EvH/Cxe309oYzyUyDoJwBcUOHuUljGf
pdSQ+1ZTlPVZk9buva1+fHEGpyILMrdh3iYSatWn8tAjgPBCwYbRb/OEVKatzG+o
19fWaaaiAz2eGtvgSx9qbLg6DohVyAcGa248tOl6q/CtTq7KhDqG1r0bOOEs+RkV
Mum3L8goGwH/31N+yzt4ZfGFX0p1/9coYKi5n0rIimq+J5arqmTqMky+eQmS+114
F61dfrLR2oUVRfvM2eOn+8UE8jDMdzVUqKj5wpzU2aefqXDN8z1PXUWyrzFzJzTK
aQBX0ggE/IwDq+6RIyK1TZVccefuQ1dQp95iueZYlphCkOt7tS8=
=baPG
-----END PGP SIGNATURE-----

--T3WHd0m1L2fjLMKi--
