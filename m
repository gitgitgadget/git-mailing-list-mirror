Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379ED43AB2
	for <git@vger.kernel.org>; Wed, 15 May 2024 06:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715755839; cv=none; b=QKNcWRPYkNL4xA//Ej5KTcM/5p9Cn5AILNrhNmT6UdHJGJeSzoDIu7LIGIyZwLVD/YK2PIikccQzIV6NzH9LbnPkwRNhuggpicWyUF/C31Yk7ra3oKHE5tEpc3meBwnKChKnIbt4uz98foE0cBH+cu2Raebw3easf2UjjMDYJeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715755839; c=relaxed/simple;
	bh=g61NCzUgQ5wxo1NBKBysVOM6Krak7gqzjacm3v7lIvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S0Kn3Krmr/OGjGuVnY7aAdANUffa/RixRm9fP0qAOTzNoBJ+H1Kl0MkhAR7jh/HYkce1rwArsOmDI52DriZ64snJy8qsTLty3LUNPEGHSnAvbAiWRtoXeA36NeJt3HnqouXGbFOg9H8jrmfd2Ep+l9yRTbBNloeQ+gtxCHTcJLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=S4Mw47Ib; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=au4tP9QA; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="S4Mw47Ib";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="au4tP9QA"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.nyi.internal (Postfix) with ESMTP id 5C63F1381184;
	Wed, 15 May 2024 02:50:37 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Wed, 15 May 2024 02:50:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715755837; x=1715842237; bh=KbNzE4ifKO
	0ckRyFhup0opHv7FY7WeR5GMQz9qmlIjw=; b=S4Mw47IbvxxteBTKDs2zGdMcQk
	QNcyTeFrZMWIl3q3wwnVroZKHYSjnUZ+o0qgGKXb78QP5Ng2VeFubHpfc+LJVPyr
	RlBAM9oLhDyNZCfuLN1XWjUDZQoLtUQPT1Af2Wto7KP+NLW3fFRxZB0nKKQbwp6p
	b0Ti4yZqnY9IrAdGuBE2nYH+qNEYuYBNBDqOLOkx2s3oUWxI+0MoMOPvurDvIU80
	hwunsOEX3GmMcuZW4M0DW+3eZuNPa694FSFaAgDrGi5t+kz21lo2lm4qX7C+7POn
	D4LyLiTkk3yGhXZRBrwT3EowMP304QGh5sHL7oQkwUk6WJ6/QAHPWh/ZdgHw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715755837; x=1715842237; bh=KbNzE4ifKO0ckRyFhup0opHv7FY7
	WeR5GMQz9qmlIjw=; b=au4tP9QAD4DrO289YGhHuTdY6xH6FHWfjzjsBpGSopts
	VpH4dbaYElCfE4hMB4hvhBdV/CfciPAnoitzrI0EzNWx/YvzH6x3kiX3ABwf+78h
	Bfz3g/11T67IHhv1sFg0Yu0SNxWJIBymB6IWg+M5WPG38ISAoAzXP9KMRUMfCNrd
	LoKRzo7jBqRk8ZHp+vAworu3p28nj8gtU5QrBbPVdHYFBDTkGgOuKDzl25deH9Qw
	AtLTcTkV9vS+zdE3478b3l5cYpgMKJexfBHussiS2J/RPC+je3hir8n0asExNuCu
	r8p6N6oKp1R61cP9YHVQTy0mkPeU2FB3Ufvkh5F8eA==
X-ME-Sender: <xms:PVtEZh2x68VA-QLGIFm0dcdn3HDLJCiV5bQO2bbyUSq4-SJNYCyEUQ>
    <xme:PVtEZoGTLLs9R1K7lggsSEI_3BCJxUd9KRVjgNy-6OQ88PTypJZeol5BlvCzJiI2w
    Mj9SQULZsuYjQbQLA>
X-ME-Received: <xmr:PVtEZh4MzY5yOXviWoS5FAe-l6l3mmC0wpOLVY4fC2h3tby_suqwcVE6rlbA48HX6UD9lsCmphBC0--_SLOLCZxxzagY0w2mq9X7V4GTf_iu8moa>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdegjedguddtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:PVtEZu2IvHp-MG-W5QRi8aDFgeb-xoZKFHZP231b5oG40Dwrw1tPVw>
    <xmx:PVtEZkH_CqKocUQwvSYZC8QeqIPvXdnjE8-RrLqyzkKme5AavyC8eA>
    <xmx:PVtEZv-w1Q6uAs3wR09aNJGlNY2OeAv-V-znawW3XW1bKsimOWinVQ>
    <xmx:PVtEZhkIsw3n4xBeauXOr4UL8_YIe3WR-ng603QHlSfSXzbmIq33fg>
    <xmx:PVtEZiY4b9Gk4jFe4DZPPGp60Jpm1gQj9bnoMTa6xwsL9lsmqPG9xdoE>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 May 2024 02:50:35 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 9e7a1ea7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 15 May 2024 06:50:12 +0000 (UTC)
Date: Wed, 15 May 2024 08:50:33 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Karthik Nayak <karthik.188@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Justin Tobler <jltobler@gmail.com>,
	Kristoffer Haugsbakk <code@khaugsbakk.name>,
	=?iso-8859-1?Q?Jean-No=EBl?= AVILA <avila.jn@gmail.com>
Subject: [PATCH v5 02/10] Documentation/glossary: clarify limitations of
 pseudorefs
Message-ID: <d328081c528e73f6fc179d386d829f130bf46a6c.1715755591.git.ps@pks.im>
References: <cover.1714398019.git.ps@pks.im>
 <cover.1715755591.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fLZUJ43d2h5WHmKT"
Content-Disposition: inline
In-Reply-To: <cover.1715755591.git.ps@pks.im>


--fLZUJ43d2h5WHmKT
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
index e686c83026..d8c04b37be 100644
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
2.45.GIT


--fLZUJ43d2h5WHmKT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZEWzgACgkQVbJhu7ck
PpSl1g/+JVfIB9QC/CLWWU2Iqykb2sLWXZGYsK71gR7Vgkr/5EwkhdqTS3V9nDvo
pDC8yt41L4JQ/WOklnLo5aA9+JtaJj0z8KKkWIjUQJAjoYYVaWcBj3qbbzGekx+9
Sw4c3sVQ5oTOq5UF+iS6GfuYMQrmfANG6K4HdRqDoKkvtGCROJi+QRwl7P0w/cLR
FxV0C8spjNkLZ3ywjEQWKzXXztYFWHFLOGSsiFyAB0VVk4aG2CniD9cxjM+4tjc5
5V3ztCE8W/OLuXp0Q53+PgGuF02zXArVhmkDl93lyTY2zrdhWFcljJezOyjKoZHj
A1IjHFvhXi8o7NMuIopKQFDTSYu1LRH7dE2/xrJY8KQ85BfIdH/AJVUdk9hvI1it
rvgHQbUWg4V5oyAErpQxtTVRo3prJW/J/rAgZdQoG9gtQvhezfRQGD3Ebz83QgUb
TL/bS2X2OdSdgnfY4fqYob0OU1evT7/4BtbhqugirYVFOSiKyqYqR/3CP8rOSR2J
uD9e/JsrsPJo5AbeG/F0Z7nXPye0KB6AQ/Q4+O/Umcu2GYYSojaGF45MRjq973rg
XZnObbl7v1tzGyFc4/A533wYaycQZ/7V5xwD3aHG2JmSeOE1tQyrIJDM4NnujGLM
OzoG1x0SW0EsNmk/+47BtyS+7V2MF9E7a1cbWqADvpIESqnXQdw=
=1OwS
-----END PGP SIGNATURE-----

--fLZUJ43d2h5WHmKT--
