Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA41614659B
	for <git@vger.kernel.org>; Tue,  4 Jun 2024 12:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717504703; cv=none; b=iKXBNJOhtUpJrgURzxF01lM2VDhAsWAUTTnP0NG2Rjp/rznZmgYAet+wyGbhpiu2NyR6XEjFpT3T+CqmI/MZ/DwQnHndapdmw1UWthvlU/kssUtrKvHvVANa3hyENBV0bqZF6lPpUiXcc3+Ut3Evu7ZfI3DZyxO1bIotaieUSqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717504703; c=relaxed/simple;
	bh=EBKM4s7WiC6Zf/Pg3SUa8z8Uz3mp0d1E490oFO/PAkI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=igZpzhB4oTQweem66Br4PtwtfGQ88mMmAEM8KmlAYS/s1FGV5xAMGH9DK2NherhRkbXldx6/lMCnfia9C7Uqm5iOYRSp1xwLbOP6lDPi21NUntQSBt5DaIY+OsyxKq4aL2x3w26N8tNReIlMDMBUXKpsFxjwRP4yifX4mp8r7SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KWbWN9J8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CiZzY4fe; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KWbWN9J8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CiZzY4fe"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id 19572138015A;
	Tue,  4 Jun 2024 08:38:21 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 04 Jun 2024 08:38:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717504701; x=1717591101; bh=/6Vn63Rvo8
	Lztbm5AW+kX+ECQGVatHGB3jpWJbcfu7A=; b=KWbWN9J8OtWiPPg9udYjZqMMiG
	/LxDn9Yxaf0wI5PyJawwme8Ph76ePzPB1CRKlgKYCRrYOf45JbxGzLA1TrQKib+D
	9kWASJTAkbkUl+5K/oH1BgnKduR0WeHXrT1BXjMFmuWPfojZfAtOarJVkWrXK2rf
	DdiDaUofeAkclmQdKbSR5PSWpnFyxj6lcpgMERGkYfp8OXO/WHsYhsbUEvCip4hR
	ft+7PCjUYmmJkB+/l6IteFyXfaSrzzSOdivxe3f6LcAjBzF65JyAnjdart0wbZgy
	g6ZAbHGXEMjvlr6X4esvGx9E0B0Fcw1VXhPHaN8ljoBIpelGjwRRXTdLLgew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717504701; x=1717591101; bh=/6Vn63Rvo8Lztbm5AW+kX+ECQGVa
	tHGB3jpWJbcfu7A=; b=CiZzY4feJqz/bo9ivJFDj4X5s8zSV7OlqizbSI9T2HXj
	GRi8qwp8/4PbTJ3KsSv+57PAIrpg64uDLbJ7jthBIqIt4LsD7PTNhQVIxKxK3TGr
	R1JGYV+doOMcbGAn0s8JDGdmB6Uz5RjyU2ffhA38tnYrQ1hjPhtkG2PbiA8iiqvK
	bcsPPNT5OgRRE3pVOekIRdywyHPtdBWLJIATh/fwhnRS3PL7KJ73A/uqxC1JTrMI
	DnqaHDdhb+BHlk+DoMWfoxN43Yf3QkrlTKhvwgxS5UoI87RBkkw6g7AuFtnwnA/o
	BQ42++qLw51nLmT19SlWEcN56+sPIuGZN2kE6sX3WQ==
X-ME-Sender: <xms:vApfZlRfoVpT0dq7lMCVaV_IHeObo3r_2fRL0iOzseF08XhnpP_a6A>
    <xme:vApfZuwqwZP6FmC5jfPia-wlRzawvgg8tJ8b2-xf93uuqw06DeZ6mV2FDrIegXsr4
    KU0e5XJPs-OW9M2Kg>
X-ME-Received: <xmr:vApfZq2mv6Y9YTd0x3wZwdqPJtr3yI67CV_k7q-zq7Yp7r6PfLgVsNXLD8zxwHOn-oMC8gdHMyjR_Sx36OmqjMnzT36rOxeQHk8vd5ERa6Y3h763>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelgedgheduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:vApfZtDRuCH0nkc4GZHmdBUnm-gwB8FckaOyZJ2i49smZzfvsJTnYw>
    <xmx:vApfZuj5NXCYKG1fkktX2PFQphzk-Jza7SL_Flntz6HudOqPWfeWHg>
    <xmx:vApfZhp0SFim-liglNV8SelOHbhUW9iJX-lkAD9xBwtra4KD-RNcHw>
    <xmx:vApfZphcvrXK52TyF7qxdnyKf155xYvTjbaiYMQQygaNuc4xFsqprw>
    <xmx:vQpfZmfm9cfwaz_OpCVg_QPEBLZF1UPXQIiYWS0lQxUIKXpA49ok-2tl>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Jun 2024 08:38:19 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 780812a0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 4 Jun 2024 12:37:52 +0000 (UTC)
Date: Tue, 4 Jun 2024 14:38:17 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v4 18/27] send-pack: always allocate receive status
Message-ID: <4019b532f96536f57161ce90f75c5958939b29ce.1717504517.git.ps@pks.im>
References: <cover.1716983704.git.ps@pks.im>
 <cover.1717504517.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gtgpuJmRPvaqdHxW"
Content-Disposition: inline
In-Reply-To: <cover.1717504517.git.ps@pks.im>


--gtgpuJmRPvaqdHxW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In `receive_status()`, we record the reason why ref updates have been
rejected by the remote via the `remote_status`. But while we allocate
the assigned string when a reason was given, we assign a string constant
when no reason was given.

This has been working fine so far due to two reasons:

  - We don't ever free the refs in git-send-pack(1)'

  - Remotes always give a reason, at least as implemented by Git proper.

Adapt the code to always allocate the receive status string and free the
refs.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/send-pack.c | 2 ++
 send-pack.c         | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index 3df9eaad09..17cae6bbbd 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -336,5 +336,7 @@ int cmd_send_pack(int argc, const char **argv, const ch=
ar *prefix)
 		/* stable plumbing output; do not modify or localize */
 		fprintf(stderr, "Everything up-to-date\n");
=20
+	free_refs(remote_refs);
+	free_refs(local_refs);
 	return ret;
 }
diff --git a/send-pack.c b/send-pack.c
index 37f59d4f66..88e96d000b 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -259,7 +259,7 @@ static int receive_status(struct packet_reader *reader,=
 struct ref *refs)
 			if (p)
 				hint->remote_status =3D xstrdup(p);
 			else
-				hint->remote_status =3D "failed";
+				hint->remote_status =3D xstrdup("failed");
 		} else {
 			hint->status =3D REF_STATUS_OK;
 			hint->remote_status =3D xstrdup_or_null(p);
--=20
2.45.1.410.g58bac47f8e.dirty


--gtgpuJmRPvaqdHxW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZfCrgACgkQVbJhu7ck
PpQ7HQ//V+swzJI2wdDAC5qfSx7Aa8yeX3BuaWGF1LT+GYUdacGS1QkI6JIh5vv5
n2MICod/KhtIn6vcOVsi+uvbUJNeOZjj8H2lmIAwCLv2FhK5pksYZkTbbV6oK359
cuQgBA6H2bsFWmJks6h4aXcWI3lO0QzXCAJzFOBx/gJYJMgtO/OXlxnfez8QIfBN
ES0uW8ktBuW+OTayjTfQpZRHcVznEZZki2xQyV9G7DYzhpJNam8D/qFolNX/cZN6
DUzbOiN5fzVtQPPhRNIzBQO/olVjhDPQfvTDQeUskddrlN0DQ4iaWgMI5iP5NyAY
n006V0qIgGHK786h6M645gtlDUKhwo2o1KBDSUk3TviA7BbKVxdw/3QhZaPOvocn
nPBHXt2ha1l2AYzYE16YOjxIX58dv8MpvPo3cT++Yj/AL+LTMqqKIYf2QJ/rkFoR
PgJ3ePgrQns6qd3+nYqQ8TS+GrM4pN93EW6Wt501vo+dAIglPvBTLGCZOTjL4BU3
2Dtc1w/VtzaS1ENX1IqFtHUONNO1ufy3/fJRL9Y9Mfb5eftA7BnYctlGB4MducdA
P0PmZEMrdZoX3AkNbXpWhzCTwUt50LcksGcKhPMTOxCBnpxMUQ9VaYKRYp1QAYyX
QFiRUeowE06jy/c5PkjWK8/hCu7mmD+rAI2HCiRcT4cnX5woGJ8=
=3WM/
-----END PGP SIGNATURE-----

--gtgpuJmRPvaqdHxW--
