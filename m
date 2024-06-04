Received: from fhigh7-smtp.messagingengine.com (fhigh7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671A5146586
	for <git@vger.kernel.org>; Tue,  4 Jun 2024 12:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717504373; cv=none; b=st41s76/5P3hybpON2bU7nHP7HHsIyCMHUN1LhacmRBZvNbffsQqOyGysn0uNny4vsM39cRQVIXYP7OMEJ0qzr1eROzWsScPokUkb/OdY9dVjMyZWdjerbLsptvhrpoSqad5HS2ecaW6TtBRllB+JS2TCzlwHBy6YyghYAsUzkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717504373; c=relaxed/simple;
	bh=1fwHZdwwJ8LOkyd3c4rg20lSH7jVfdr8AcUHuhBnw9w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uPoXd47OplacgPWuqvi7jrzGcN/ZIp5hRW/lkIwbLhY5Obo7I2I5lM0FO91s4/KwR8rHApounZA18A4y1k8J5zhbLcyXVIha5Nsh87//a9SdOq2vZ5nQuIgOx0zMwtWCikPFae9aiE/tDeMQoxPf5qLxS2L13NEFyEQZ/jua4O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=P65PTmOt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AeZ7HDDh; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="P65PTmOt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AeZ7HDDh"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 8A6061140165;
	Tue,  4 Jun 2024 08:32:50 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 04 Jun 2024 08:32:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717504370; x=1717590770; bh=hGrYK65w7A
	2Fha4oNtbMQLRjwBGPH3fKhymMW702FYw=; b=P65PTmOtRn7502SeNtSjPIpftv
	o4rR6TuQbtOfhld157w/xqy3kkSYihFNchVCzpnD0k45ows+PzMMv8zoNEY03TOe
	Q9rJgdJjLXnxjLQDHciqpmqbCZoPj1NbmojTowLmYHxvewdoU/6Dsm4tGwNvAHCD
	XxAW9frj5NBXMOMsyqe3fCCeAmil2o1wbvcK4jy1oEOMfOATy7F21ZqtjDILdRhk
	FoATOHcUbbEJUxMBrGozRrKxefgHpayPkg6W5AXNx1O4sY36+8Ek6eRImwL5/kob
	eQj7TfLVGYJTLEkPb3dzMS3UM/zzErJp/pPg4evoDtRvV+w+mwQLsCq0hMQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717504370; x=1717590770; bh=hGrYK65w7A2Fha4oNtbMQLRjwBGP
	H3fKhymMW702FYw=; b=AeZ7HDDhKuRcmfDbj5abKpG+RL3x3AcA2zXqgKXlOubR
	sJ+akXObBlECiZAqZrDgucpn7xLio0QdE0cSOLgeYOKrTyO3UPXJGV4T8VtywXzN
	aH8YldG4M/CGj2GBAe55m4maOMLgczsLB+TM4ADX/pkXZiUlh7DI3h7R0/ONpnah
	ZGMjiXuikQdfEQKbuRxVR4RdR8WZq/nH73wjEFuDzxK7tJJ+k1K/SarAxHmOiEge
	pI6ojtH+3q+ZQIZ1yH26mZYmkBWNlcoDaXnhscqEOheXq/D/EeO3dixDnZn97wlv
	D96qWrAb0okRgrW9ln2aOWs7jFAF3fU2j1Xea+aArw==
X-ME-Sender: <xms:cglfZmfGo483dBIqInnLpIlsxx2GNQrX8BCwSCBOlu6Z1Vw10vaDlw>
    <xme:cglfZgMg5s2M82iBE14mo5xwo05jdNq8F9yhc30jF54vFhMbwQtlILWNfNSUYmo70
    fFD6VR5TX1uK3jHAA>
X-ME-Received: <xmr:cglfZnir4n-9xPf0Ls5TElRMKKMagD6rD9T3KrRc97oWL4aE0JoivFLRcvc4y1pt3YKY26kEO0LpWsITc_HgNfPT32-uxekBvf88c3DtZr7gIlCp>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelgedggeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:cglfZj8-FIHmyp4fSPGVNolxE99KHPQhy2smciuTWG9_D7QlL9gkpQ>
    <xmx:cglfZivf4mVo1p8dkGdz9QW9zfJ03qYJFM37ZhJjB5VD4r3X--8Atw>
    <xmx:cglfZqFDpLzyXH23QlqHxQZfRPuDMdyq3vTaked5CZZBR2NtCxNlHQ>
    <xmx:cglfZhMDvU_5B4uxulYHpcsfNzIApTA_oewBtazj-eoqiiuzbJzvfA>
    <xmx:cglfZgBi8yfMAkIT6a34I0fpaC8bg5cAiuXWknRZE-CpzaIZ-mK9GtFv>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Jun 2024 08:32:48 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 1b0b4e02 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 4 Jun 2024 12:32:21 +0000 (UTC)
Date: Tue, 4 Jun 2024 14:32:46 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Justin Tobler <jltobler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Dragan Simic <dsimic@manjaro.org>,
	Karthik Nayak <karthik.188@gmail.com>,
	Todd Zullinger <tmz@pobox.com>
Subject: [PATCH v6 3/4] BreakingChanges: document removal of grafting
Message-ID: <b25b91a5e707f671785012c1b4a68c36241e537e.1717504292.git.ps@pks.im>
References: <fc1a9fa03de7330f79dc56b0f2712834cb236b5a.1715070296.git.ps@pks.im>
 <cover.1717504292.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7acXD1TCDzAuu7P1"
Content-Disposition: inline
In-Reply-To: <cover.1717504292.git.ps@pks.im>


--7acXD1TCDzAuu7P1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The grafting mechanism for objects has been deprecated in e650d0643b
(docs: mark info/grafts as outdated, 2014-03-05), which is more than a
decade ago. The mechanism can lead to hard-to-debug issues and has a
superior replacement with replace refs.

Follow through with the deprecation and mark grafts for removal in Git
3.0.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/BreakingChanges.txt | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/BreakingChanges.txt b/Documentation/BreakingChan=
ges.txt
index 5d7e80aebb..9fb6d8c78a 100644
--- a/Documentation/BreakingChanges.txt
+++ b/Documentation/BreakingChanges.txt
@@ -96,6 +96,18 @@ Cf. <2f5de416-04ba-c23d-1e0b-83bb655829a7@zombino.com>,
=20
 =3D=3D=3D Removals
=20
+* Support for grafting commits has long been superseded by git-replace(1).
+  Grafts are inferior to replacement refs:
++
+  ** Grafts are a local-only mechanism and cannot be shared across reosito=
ries.
+  ** Grafts can lead to hard-to-diagnose problems when transferring objects
+     between repositories.
++
+The grafting mechanism has been marked as outdated since e650d0643b (docs:=
 mark
+info/grafts as outdated, 2014-03-05) and will be removed.
++
+Cf. <20140304174806.GA11561@sigill.intra.peff.net>.
+
 =3D=3D Superseded features that will not be deprecated
=20
 Some features have gained newer replacements that aim to improve the desig=
n in
--=20
2.45.1.410.g58bac47f8e.dirty


--7acXD1TCDzAuu7P1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZfCW0ACgkQVbJhu7ck
PpRXrQ//QNogEsrWZL5WrlVRY3azn31hpw/Mbf8eEMyPnOA9XpwnAGmOiR67588x
2+jdwgdB+UHXWD0w888EoiSASmRaRJAWWxtcC5CleCR4U3opMwuv9IIDrak3qqOn
U4nqjQzogK8+O5XKQA+crhE4Gm6nf84JessoaNkFstrgV1RDufrUcEA3mj3RcNzR
m2dIyFLtngFhT5QtLOpYVkFdv2ug8mebLj7ziI69a7acPgaUm158pd9AZqyoUaGq
9xQvmVKgvO6yFUbSE1pCcIcScgooWJtB0hIJ0zDa+oH0b59+9Jr4LFssjfh9yzhm
6ErQGsyL7yryM5EreMnh0jon+2vEzsusoSRSUzRH86OOBegYD11qHxuq6GE4Wt0j
WcU4LzBt33LsfjZ5EWd4E8sILa9azc7u7pJBS70lyQPyN2smKrD+hMYVNjZRDir6
yTod/qoTIe8yX8m3e4hCYLaaYhSUjKYxOlSz/5zjZsc0G5V7GRwKh8mt3Q3IH+k+
cmza/QjzeHeMTt4fhFLwvIno24M0qJrKDBPNWKTJMtV2+BJYmyq+CKoJKilJEnu8
So6riPWn3vG7Rw/MnRksWbepnNGTf1QMWdwrdSNcV3yqSec6T1fyiBJSfLXBymaS
XoolWYPHC8NK0CLVuTb7QKD97g3VYpgzBQj18U+9ngWr2lmsCnA=
=vHlg
-----END PGP SIGNATURE-----

--7acXD1TCDzAuu7P1--
