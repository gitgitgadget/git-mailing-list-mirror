Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A4D2D04E
	for <git@vger.kernel.org>; Thu,  2 May 2024 08:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714637844; cv=none; b=iEq3DDy5Ph7vhsI6JsdoNRVYB6Nkj2mr8hY2G8RzLni96RuzP9wreRoFCcu2OJJ4Ugzb6IZHpLG0sHvvxwvO7HrrVpgDozC0Z4L/QaEFuPDXyf9hxfTQuKsJj2I+TEX77yIdnJLdKs39eXpOsaJKyry0L3bTkmWmBM3MhfdiOTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714637844; c=relaxed/simple;
	bh=kaPR3KzjQxklruE4IAb4rvGmn9h4iozBx/uOprBhSTk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rDjBN4iK9n1tIKBmKBhiVmZs1H47WXwLaiFkD0d7K+WE7tmprIBEDUcAYUxA9qZ3JWV+Ls94Wct1pxgkTtRqXs1piWg5iHgaXUyIl+PsMs5KVJCYA7I8SBUA+k27BPA/XnvL2YL2DXGy/6ALqbGKB4QonU/6LZIYlm0mWEf7P9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QW5ikPhq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SdQ1bJa9; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QW5ikPhq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SdQ1bJa9"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 0AA0D1140112;
	Thu,  2 May 2024 04:17:22 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 02 May 2024 04:17:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1714637842; x=1714724242; bh=J24HJ/+P2+
	Pnz+Wvv23RmRL2ggKgoPOG9pDR5AyEXJ4=; b=QW5ikPhqdVTt2EuWMpj3UHfaEZ
	nEDAHF0bH+BBXg5CSXquZDVPvIdamTYUmfhWBnYBWGdhc26UT1fWTFwYh0mByKUg
	VjsisFnEGEpM/TQ0TVoFeLiaG5a0DptetYJ0xc4rcDDapOieQYre4yR8PD8s7aD3
	CjNMZyRLSdsNURlGGJUVBMQf+ndtGk1edL5AoND3vl4KGpyXyYnnBkQB8WMfFdPm
	oe3ZBMKf/zUk5aBkVStTrqochXItJ6PQkICXP4aBTP49YCEaZB0t8h+wyBPOQcC9
	Z956ZhOJV3W2D3ZlkVy/9iHKlekpVF8NjEY09QAiwOP6Fv8FuyjJ8Y3vdJpQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714637842; x=1714724242; bh=J24HJ/+P2+Pnz+Wvv23RmRL2ggKg
	oPOG9pDR5AyEXJ4=; b=SdQ1bJa99t9+OTzNZrqN2ThIR57nKK1STEuxaQie9sjw
	bGmxziX4UyEgouBOcs9N7Kxivut0Fvc9c+bQU5CSDYiSjTJAY4r5Hip7twlJXD/X
	kgyVQCng+XEfhuMk30aNoKGJkIg9M12PLmmZKXQIGes8csyQ1Q8DKRt1DO/iCTjS
	fdtCMOLQkMt2FFpCyK1eB93jsOkXc9snLz+FZ8/0wdEmdN4TdtW6PmrBgemrKUgH
	gfeVYKl6qfemSrIb/F9h8c06AifLp80Uea+E/S1FYpkKQB0Le3wsN52H4w3VMpG4
	qu46Uc8CnsO2ga8RZ/DPfGgalVEeyLvYcml4KwZ1Kw==
X-ME-Sender: <xms:EUwzZuti6zwWdpJl0NH07zPn9nuB01X7AaV1Vv4atmMpHf5qeV3fSQ>
    <xme:EUwzZjdcsq28QEwudml-lZShTpQTuEaXRRQ1LiUzSOYGYm-8ShxnI_Fth6eWHw3uj
    dlnziJsRVmog4Q4zQ>
X-ME-Received: <xmr:EUwzZpwF398LUKawgRbhxh8wgEDTQkapqL_tvz6KBO4QnqO7BGkB1pzPphYkyQN89LpbG-J-BWOslyv-vqiKgw2cx4OXBmtdyJBAQdgumj1L4g8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddukedgtddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:EUwzZpP3smnykXTUSZWkaC2jEYNnFfmMkf_8sb3NvZSt-YLrrlUEEA>
    <xmx:EUwzZu8_ab2XuOjXaHMcr88FAGlt7JSuHdLPZSRR1Ti42vSLYuN9Zg>
    <xmx:EUwzZhWPe-gafXNeA0hMbKxtoEzpoOyrZnMbCZqt4-ic0yHu4DgrXg>
    <xmx:EUwzZndbIo_r8ArDsT8HOZ2OHfilC9hdy3g4iI63cnwoxS_Mntc5ng>
    <xmx:EUwzZjNiV9or_4PdOk5Yx-6wdlKEK7dVRgy4ZqYc8f64sU-Q3aVMU_-u>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 May 2024 04:17:20 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 65aeba0d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 2 May 2024 08:16:55 +0000 (UTC)
Date: Thu, 2 May 2024 10:17:18 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Karthik Nayak <karthik.188@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Justin Tobler <jltobler@gmail.com>,
	Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: [PATCH v3 02/10] Documentation/glossary: clarify limitations of
 pseudorefs
Message-ID: <66ac0461328409fd880ab1dce92dae5c012ceea8.1714637671.git.ps@pks.im>
References: <cover.1714398019.git.ps@pks.im>
 <cover.1714637671.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="QL1dbBTtyNuMcLQX"
Content-Disposition: inline
In-Reply-To: <cover.1714637671.git.ps@pks.im>


--QL1dbBTtyNuMcLQX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Clarify limitations that pseudorefs have:

  - They can be read via git-rev-parse(1) and similar tools.

  - They are not surfaced when iterating through refs, like when using
    git-for-each-ref(1). They are not refs, so iterating through refs
    should not surface them.

  - They cannot be written via git-update-ref(1) and related commands.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/glossary-content.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-co=
ntent.txt
index ca04768e3b..b464b926d5 100644
--- a/Documentation/glossary-content.txt
+++ b/Documentation/glossary-content.txt
@@ -498,8 +498,8 @@ exclude;;
=20
 [[def_pseudoref]]pseudoref::
 	A ref that has different semantics than normal refs. These refs can be
-	accessed via normal Git commands but may not behave the same as a
-	normal ref in some cases.
+	read via normal Git commands, but cannot be written to by commands like
+	linkgit:git-update-ref[1].
 +
 The following pseudorefs are known to Git:
=20
--=20
2.45.0


--QL1dbBTtyNuMcLQX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYzTA0ACgkQVbJhu7ck
PpQOGQ//WBxgD7EX6mUiao7lywZNQTJsVCo+dipmDFsqxJkcP1GEbRn5mZbMElJX
M6AY8HFugG+jz2XAOhgT6GpBJro8q5Sllz9ViyDxBKujaiTeDl43Axaci9f7yLb3
qzUd32q+1wR/C/oyAZlCqLqdfiWTiuVseZxOdEd+Y8oBtmcekaeLjoHtrV96v8AI
pcxlVsu6KoK8++ACbK7NvVTcPvHUGTdQwNBNzFImMJPRqlidU18F2361o/7+iMtQ
tKy5JoOBcU6os+4zhSiY8UnyN5eYlGpA7gAP4hIq0+27UD+fw0Olhf1wEISlYpCx
lhtTHu22DjxpkkXEynIEBrbLvaJb1hi+p36mzg1eRaOKoPXQ7UrGpPvpZnEy5oae
Pt54Hld0p1KXK3+IxdCIpNIyrQvje3lqM3ZnREGVaRtMpIcArrbDbkZLvNaEmLvf
zRiS6D3lohOJFOVhjIs31DNv/BbIsAFXLYD8ffJ8fBlroJLXqmJVq5sRSV7WaMcT
0W3PFezFB9F4w9oFL1jRS9RUpOqB0w0LJcWasW4Qo7wViJC1bwQwBmPnq664+1/g
ftXz0wuZKnUba3zX244oCDBKFDUday+w72N0gHTzZvhy3Jca50elDDpxelOsqYnP
IaFIpFaGdK0u8UsWnA72jFldDUaPA+/ilo1U9/7T8eQA7950vzg=
=T6Zv
-----END PGP SIGNATURE-----

--QL1dbBTtyNuMcLQX--
