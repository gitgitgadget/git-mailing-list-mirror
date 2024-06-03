Received: from wfout4-smtp.messagingengine.com (wfout4-smtp.messagingengine.com [64.147.123.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D580D495CC
	for <git@vger.kernel.org>; Mon,  3 Jun 2024 09:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717406919; cv=none; b=XZpZOTO6Qzg7SelxRF2N+uazkUMjcTTYR1ERZCzhzR8PF3wZZD9EwebKuZJHpV1hpZ5zhTcPcLJs8jc3UQ3ij1uRWbk1QO9NnTAIsdTYT1XCAc2p47teN0rgFuyjfszgO+6OjefYf7I4z+kHLCFm3FJz1RUA0RfbtPEr41Ga9Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717406919; c=relaxed/simple;
	bh=YFdGbWVXzP9q2vtAEp9V8YT90kNpzwJf5cJMbWK2v4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SJhhJGvnmipSRXxYF2imcYoNQSavcxEZ3fti2I6mHIWp5etlVsbSC7ivrtGPRuvJrGjFBsKUu4xtI2TDBmg9gugLc/JeabX59gbLu59oZV9ZTkQtqUW0roAQKqIKysVNXsWfrFxkG4Gii06sOaJECOk5qZ+lotY7PFheXMyTBPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DynvOZMA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LY25D6xk; arc=none smtp.client-ip=64.147.123.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DynvOZMA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LY25D6xk"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.west.internal (Postfix) with ESMTP id 9DEB01C000E6;
	Mon,  3 Jun 2024 05:28:36 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 03 Jun 2024 05:28:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717406916; x=1717493316; bh=Mg7OQkHzqQ
	oczvZGJg7KSHzDHIOcL4HhnAOORkiM+48=; b=DynvOZMADqvbiaFhtrkBsfBEgk
	f2RM4kyAlr8V7jhM7nLW6vUAPhHZDvYdWjJdPUfe2aN/l7dPFMxJTC0G5Yz3T+Zv
	iCmx/LIUkn0WPJsKy9jlR7ySLJhSVbXK8bHEfWzMnXBdYpDGd6ppkrxbyNgm1Pv8
	QyWtweKFByyest2YW+GVSDC46kAYe5yc+aDbbYqHY4nYTGT3rafnElsJ8nb1+2qr
	B1Fd5EsU+oUC0+j3cC24BRdN0J4RIgmddxNA25K87dpTMGPrHNTP/j6KOgwSauv6
	62cqjRf1pRO3Nb3JowijuI8TmbhPAPAGr38VVca/XIvJ+3XP7IE6FPc5xs4Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717406916; x=1717493316; bh=Mg7OQkHzqQoczvZGJg7KSHzDHIOc
	L4HhnAOORkiM+48=; b=LY25D6xkjYVHrVLcSujIqYfzOGm1Fgdwy2SbANMX8k3g
	VX++GzdcXaNGa3PChRUsso7iIt5AJOVRvtEhgVy22BliB9Ed3c3CWRHdW+79yyhd
	hDp+KaMhu2KU/j/bzCJLoY8t+NX+iVnDkgA3IPJ37oM3NKUEKozqeTPNLpKSkfaD
	zw0+TYSrzkoaFAvXoQ/+tFRAaB8OZ1zglmLR1WMCg/8fe5KM7u8YogZI3BAhVURs
	rHAjt21vNdiaMUs+fFNt+UhW3CHltawrZZSAcHh+pM5DlkJpn5cucwYOXR7z180B
	uVpvxCgOqOyzO00/RTIdHYYlSEgWZNH5mLHZtrcN2Q==
X-ME-Sender: <xms:xIxdZoNK8Q8ZmgowkCeTObLf8M1VXh7ueRbI8R2vFpfTnZNo9V7Gtg>
    <xme:xIxdZu-HaCXI1pWlCpQogenvuDHn36kDWYhX05jg0qWLdYEcSEJyvFsh0lQy7VIzO
    HS7qihTlVmAuxGing>
X-ME-Received: <xmr:xIxdZvTyVmFmFIjViQeC3JVhhpzkJfKnJGvk1AUO6aGgnuao1VWxzdTYZr1Vs7I5tW3dP_rwBx3mg1-viE25oHFKiV6EluJRCdEjcZheIYpU-_Wf>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelvddgudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:xIxdZgsWIGa3nkpM0Pze_ftEZ_ODgWQpVhwMb8KWQoLsj9YrzH8I3w>
    <xmx:xIxdZgcJ32eM40nDR87cH3c0CWF07zXN0BX9dhL8gyJPcRpsq9HE_w>
    <xmx:xIxdZk2-bYHLFYPiffjieQc5kIuMhq-F1LgdD7xLKal9lLkj4elVDg>
    <xmx:xIxdZk_GTFzyzkg1b44U3Bp_8qqZF0JemB4U--_WImuvVw5Q2dvMPw>
    <xmx:xIxdZnyAODOdymGE0mvTn-ewtoVL8NDxiVW5mmOGhveid6itLZtB5ZxE>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Jun 2024 05:28:34 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 40807d34 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 3 Jun 2024 09:28:10 +0000 (UTC)
Date: Mon, 3 Jun 2024 11:28:32 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Justin Tobler <jltobler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Dragan Simic <dsimic@manjaro.org>,
	Karthik Nayak <karthik.188@gmail.com>,
	Todd Zullinger <tmz@pobox.com>
Subject: [PATCH v5 3/4] BreakingChanges: document removal of grafting
Message-ID: <4142e472ac54f5008b0566fdb967f86677171491.1717402497.git.ps@pks.im>
References: <fc1a9fa03de7330f79dc56b0f2712834cb236b5a.1715070296.git.ps@pks.im>
 <cover.1717402497.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9MjfFU4HWsrsthkg"
Content-Disposition: inline
In-Reply-To: <cover.1717402497.git.ps@pks.im>


--9MjfFU4HWsrsthkg
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
 Documentation/BreakingChanges.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/BreakingChanges.txt b/Documentation/BreakingChan=
ges.txt
index 904857a636..b5088dcce2 100644
--- a/Documentation/BreakingChanges.txt
+++ b/Documentation/BreakingChanges.txt
@@ -87,6 +87,14 @@ Cf. <2f5de416-04ba-c23d-1e0b-83bb655829a7@zombino.com>,
=20
 =3D=3D=3D Removals
=20
+* Support for grafting commits has long been superseded by git-replace(1).
+  Grafts are inferior to replacement refs as the mechanism can lead to
+  hard-to-diagnose problems when transferring objects between repositories.
+  They have been outdated since e650d0643b (docs: mark info/grafts as outd=
ated,
+  2014-03-05) and will be removed.
++
+Cf. <20140304174806.GA11561@sigill.intra.peff.net>.
+
 =3D=3D Superseded features that will not be deprecated
=20
 Some features have gained newer replacements that aim to improve the desig=
n in
--=20
2.45.1.410.g58bac47f8e.dirty


--9MjfFU4HWsrsthkg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZdjL8ACgkQVbJhu7ck
PpTzag//cZVN3FWlIO/jLziHxKLDmuIz4MEFWcnnEZtuUxvd8hK8nkepXUChCh9z
eaHtyBTG5O4Zg2A7dfQ1nHCk2/h68oP5F948f0w3FF6ERUSwwfnyv/J63r6xgfKp
j9ixyAn4W7qXHGvMUjvwZEVztH30OimIvUgIKkfwUGkVHaD9BPZ8kTn+5AIHDZc+
9rcZUc5npSzYkqapFWpOYrbtF1c/+qu12JLuvhoxV/sNAAcrVK3uOjz6AYrVAaTm
AQbkNTFT1pHFPIZTE5WTouTxjIm62eO+7Rb3DCgB6n7eqfUddj5tyIy4q8pAOvk0
UV8n1rpr7z/KxS5j71msQPKvfRYMlQqxGATWr6Uah0nke2mtD7p7LwNDU2Cb2W37
WtURtaj0CLgqeeHvpBaKAHNnBHcwTjflwILRhsCfE03VDX+fU9iUI53XQ7g6gZgJ
vDEkfre8tRLnLcwlBy29W+q6d1P+mqyVjfGTGRmCzH1t48ved6J1If+qTYiuN/o7
Mp71bLkUSLv4go7d0jFLOKvcYdZ+4+MhvSJ2MeKQJascqh8amMwkGPydS3hua744
laeslFxXgqgU/G7eHUdSXCre11EcadeYXm8wtQsc0PEBrvjG56MBIZ+9x1iAXilz
CLEVzusBXx3euTLjkwaWymsebpk/wT1rgR+Xe99D5oEU66Z52Fk=
=Zn8Q
-----END PGP SIGNATURE-----

--9MjfFU4HWsrsthkg--
