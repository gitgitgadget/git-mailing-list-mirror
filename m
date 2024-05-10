Received: from wfhigh1-smtp.messagingengine.com (wfhigh1-smtp.messagingengine.com [64.147.123.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378EA79DD5
	for <git@vger.kernel.org>; Fri, 10 May 2024 10:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715337018; cv=none; b=AQIFAIGND5uLfKK6HrQWZVczHpLvuRfY0sR5wQmVJcWYK8rbxz/dhmrdbe2evNnz4vfbWODQVCWXfC8L3rZm2Qz65GGDrhy8A2DF80nVnhVfX7Hpt3yt1uaUFuAfZRR9d60uiBGEA2088otZl8krmAFUQcsHSZuHf/Q/wBwRjUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715337018; c=relaxed/simple;
	bh=Gl7ZTVMOJ/h6fzUrAqsNOuGAtq0XFZAu7QvREBWZ7Mo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M2ZVGiZL05Ave4S0tVK6+07tW6fmES0kHYrgNNsIWcfm6Jq8aiUBmweM8KzsRsL1PdneAZWsv8vuQECgeizgCLpY/mxMNmCKprxLUNMKzbOqrVIJZbDKOxvnSmjPKFDQqq/CrewwnqJ+bywO8f1zu+kCH48Wvgl6Ylv34HNCFnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jJuIwMy4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BiKNm1RH; arc=none smtp.client-ip=64.147.123.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jJuIwMy4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BiKNm1RH"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.west.internal (Postfix) with ESMTP id 50F4118000BA;
	Fri, 10 May 2024 06:30:15 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 10 May 2024 06:30:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715337014; x=1715423414; bh=fSMPnY6FHe
	5yndlLV7GMeubYQklGc0YtLWSPOUuSBNE=; b=jJuIwMy4NSRvGlSwIq4fydkty8
	7wtRs9USH02H6I5Ovo6N+0ynXcX2CB+DuAJhk8q9YIZr5VioyEI6t+iRAu/Bg+QN
	eNDMw4uZA1QxjVDXy3MQXtbQIqoBKnk9DflosWAdRRup7cXF1uqNJhYJFRwaz4UF
	9GOAln0gwE0tV4zQ7aSULY1XcuvMDymE04xj6SvV9RO8VCgm/ef3Q/PeAVm6fS2p
	2G9Y9ZHUS/NC7ah/ZQrVUA5edxy6xMxiKzcy0vQ2pVKJ85k4tbwGPkji/yAeaaMJ
	eOfB8yuA4qpeskQPH1Lm3P3yuwrpfSYhpQGfvzvAxzX20roh3eOcJjsHXrlg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715337014; x=1715423414; bh=fSMPnY6FHe5yndlLV7GMeubYQklG
	c0YtLWSPOUuSBNE=; b=BiKNm1RHhBUVA8OXjqJ3akO6/D24lYOuJgKrCBO9Cg+M
	5HzlHY/q543Zq+2fzrEE6aBQJrRr6LRvryqi4J9/Tao+cfxVwtudRHEiEXDxdXxY
	0uPEatnL7mAd4fa+6FLWFwA8NaV4jNK9CaEAZwwOqlrFC5Czmf+h6UNYEBJx7PjE
	j6I0jDtFKMKm2IIgj9cshXYk1UsV2WBhOKWBWLi2Q8JnTpA4JP0D5yWsf0YKek9r
	GTtyWQ2fu3sQg0rTxTVZJlw46Z0QRzGmTPOwByZXeENVQDIQc4UEEbmEuk2ZthyC
	oDfoUCvU2zBB0GVreI6Fke9Cik739JV2bdoDaU/Dmg==
X-ME-Sender: <xms:Nvc9ZtIYrPcRKTcnZ2KmisSM76B1DwEQCApARCMdQRUPOe1Kjnbdlw>
    <xme:Nvc9ZpJZIVitMoBVHTh5fpJzxBAl7L-mqxDs2xxz9o5s0uMUfXGhSiyA3VQp1EGWP
    XltcPLVPLexivoA8w>
X-ME-Received: <xmr:Nvc9ZlunpKKtdzABUcl_MIOMyLzF9ej-e4Rk0Scu0Exi-SzyhuxsAJp4o39cqpD-ah6Ihw9RzJpQ87MA1Lx8yTQiCtNPPQxNS1R2SGXpWG8n5w-4jQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdefkedgvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepieenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:Nvc9ZuZvPqVhOHmUJue3KKhfVZ2XCJU0v_0pSQV8TC-YiOAcd24kxg>
    <xmx:Nvc9ZkYNakwJq6IpDcRBsOlr3AZcJYcYbXhvMiCwll8FVsqoPYeqlQ>
    <xmx:Nvc9ZiAng0LvwndkPFPpnZNBThnnxyHFKcL_3PIL0UDSMfegvJs_tQ>
    <xmx:Nvc9Zib6G2sLisHkhOlrUwuqz-dJegis1VKXS9-tLNO1Vwte-_KrQg>
    <xmx:Nvc9ZsFQfXVVX0Mjv6qyQdI-_wGh_o06-qdXr97J4-9QU3c5IpsDFYlJ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 May 2024 06:30:13 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id b284ffc3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 10 May 2024 10:30:01 +0000 (UTC)
Date: Fri, 10 May 2024 12:30:11 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 11/11] refs/reftable: allow configuring geometric factor
Message-ID: <e1282e53fb182dcb23255c360da38adb531be297.1715336798.git.ps@pks.im>
References: <cover.1714630191.git.ps@pks.im>
 <cover.1715336797.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="KlptZqDabQ0IQqs2"
Content-Disposition: inline
In-Reply-To: <cover.1715336797.git.ps@pks.im>


--KlptZqDabQ0IQqs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Allow configuring the geometric factor used by the auto-compaction
algorithm whenever a new table is appended to the stack of tables.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/config/reftable.txt | 10 ++++++++++
 refs/reftable-backend.c           |  5 +++++
 2 files changed, 15 insertions(+)

diff --git a/Documentation/config/reftable.txt b/Documentation/config/refta=
ble.txt
index 6e4466f3c5..f928d1029b 100644
--- a/Documentation/config/reftable.txt
+++ b/Documentation/config/reftable.txt
@@ -37,3 +37,13 @@ reftable.indexObjects::
 	are a reverse mapping of object ID to the references pointing to them.
 +
 The default value is `true`.
+
+reftable.geometricFactor::
+	Whenever the reftable backend appends a new table to the stack, it
+	performs auto compaction to ensure that there is only a handful of
+	tables. The backend does this by ensuring that tables form a geometric
+	sequence regarding the respective sizes of each table.
++
+By default, the geometric sequence uses a factor of 2, meaning that for any
+table, the next-biggest table must at least be twice as big. A maximum fac=
tor
+of 256 is supported.
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 63b75f770d..c4bd0fe1f9 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -249,6 +249,11 @@ static int reftable_be_config(const char *var, const c=
har *value,
 		opts->restart_interval =3D restart_interval;
 	} else if (!strcmp(var, "reftable.indexobjects")) {
 		opts->skip_index_objects =3D !git_config_bool(var, value);
+	} else if (!strcmp(var, "reftable.geometricfactor")) {
+		unsigned long factor =3D git_config_ulong(var, value, ctx->kvi);
+		if (factor > UINT8_MAX)
+			die("reftable geometric factor cannot exceed %u", (unsigned)UINT8_MAX);
+		opts->auto_compaction_factor =3D factor;
 	}
=20
 	return 0;
--=20
2.45.0


--KlptZqDabQ0IQqs2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY99zIACgkQVbJhu7ck
PpSmiQ/9Hg62p6QZo/IzCNBKVN4L3+XY6kj5rrn+0LnVremEYJ50tdOiDNvO+LwQ
08H9L9VNndFsDoVxdIHCP62pxU6+TuhETKN6116Q3OSQ6vZVtct8N4xgDhASRgck
bHV6i3Cz+Vm2PGw+84b+/VkajT/OyXM6hytHiunsmkMhwqDIUrIy4vaWT3QVtnCL
QnZUzOYr8jmnzcGqUSoZPK0UbyKORgQPxZjY8jZ/atkhfHMHJgbRLDEaCbPWDKc4
3vOWW+fiU5k1bsPU8rkV49ZmXCSaeBFBr1MPoPs2j0YB8HMXC4oiEMakuXAopLPC
m3oDHxTof0gV1x+qF2B7Ww27eE9mlP416s5WkCZNGWEEHrAU8TyjgbA7igaxfx0w
U2G5UjPiWAlXsDGYy2J5dTCpKeaqgIkncCRyiQDMZdkcakcAESj5I3mPM93dJqEZ
F2gJD3fjERw9q2PIDk1gYQqrjVGsQuJd+gIrv5gdvkcOgGjHU22yEAnOjm5thwwK
ml3VvAQqdIAByDotCuWbGB0ZERd9WLdZqcLE2l31IMht97EYT8VAR1wnTEuRWau0
XqsLIk6vo0/Gu2UI6gTsqFD+lR4ILX+L83trUz1EBfbjdxzO4BY6lJOrZ0WAhoC+
0Uur8HAPCIGvlyPDYHKFRsi02dAC5ViyDC736/CM1QlOAtT+ho0=
=rK1E
-----END PGP SIGNATURE-----

--KlptZqDabQ0IQqs2--
