Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CBDD154BFC
	for <git@vger.kernel.org>; Fri,  7 Jun 2024 06:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717742358; cv=none; b=dyP3vrGM0sanE8+morbd9Tnb33kCU6+cG7hILgNRcoOK5ejZi8TokVMBi7cxN0tLTbOgnWmNYKKhUBD+7xrKXy+d7ml18YbMXH3xJu3MmY0779Rt9iTLdRRZ4uowIpv2X/sdCRFK0nDHRTYWhykYDXOV9N+tyUKi45WT0B7DYT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717742358; c=relaxed/simple;
	bh=JkuE6Qi1kMzmmeQznGDSZ1EJsL85SDJr+4UYMndQO+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z7OQDnH3E5XTUi3oIYRuebMVwioG5Ytmv6ekbsrPaOVZfdJSbRAMtXslhN4PNf8SvKQi8RsO/Uw2rxwe+DTkkPEMi7qmZMGd/syvrtiKw0Rg9KttJQwhQcUky2DDDJoIi1HcdLIQy3DUi98S5Jsn8TylBfJeMu5YUrFlnkFPTak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Fxq9LanF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gnQmxGz7; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Fxq9LanF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gnQmxGz7"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id C5FCD13801ED;
	Fri,  7 Jun 2024 02:39:15 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 07 Jun 2024 02:39:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717742355; x=1717828755; bh=SUBWm2opj6
	PpXrW1m/zDiziM1t4dTjfIFOLIRSt+1+A=; b=Fxq9LanF9x2JHcJiLGZmYNOOxk
	uPTm5TP/C5JQ8Twfxa4t9MsjcJdnTtl6Fszgwyxp94pN7gui/SSAAUWBJJSPYjh+
	boNTgKVQuCjEu19VZkVDPuxpPUXCjiBJhnz0ItsF6zQ66uZ1EezJ+ZO1UUnp4n+3
	QhpFg9uCZk7crSO03UXMCDLyWHOGcav1SGUhJOP84Rc3zaeXj8RotARdWLv10Zux
	z0R9NqeEftwVxPTotPr4/OIGOF7uOxPsjPt93WFZxP4mz3mdKNv1ARxt1XXgZuKJ
	Z0Xp1JJqZOsmRwegaLzLXhD5/8RXaUpuB6GKwUOjcynYKRP3eNHvnnMizDfA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717742355; x=1717828755; bh=SUBWm2opj6PpXrW1m/zDiziM1t4d
	TjfIFOLIRSt+1+A=; b=gnQmxGz7oIDD4oUuO12XYWDsTwHWOIK30quwx65nR6c2
	sWUMB2yZqojhMNKgq/uWH84g7XGDFlVOXXLIWDyQXHdZdXQ9hLnLG7zMUukOG2Gz
	DRvvM3TnlW1PhBJH2Eskp8KT6DICB/gHLjDVwFB4RXbHYDQ4c2BCicYMPRdpGAG3
	6YL77OxOAFbaxaBejodqnKWdcoGnEpT4qvK6g7Up/0zEp7eX6x/WLnQ0HYCBVKaK
	Mq1Uybh4/wIDVMgouzSrOMlBhXJmpplFVyxIaMFBpYL3YtRcox9D3B4UblcCq/Zy
	GMjd4nWEMzvpOW6/M6EpSlFKdQez4AWYZai2WeExTQ==
X-ME-Sender: <xms:E6tiZkR4nyKiCiF_l0-IT5GnY75b7ROqdqFt6JeyBqUJW_tmir5XaQ>
    <xme:E6tiZhxpmSJ216t99DTTkCSgqDMGCgNfVDGFFab0XGmt7ycouWx-2VXaVudD-__uK
    aOAOgyNDSAwyDhpeA>
X-ME-Received: <xmr:E6tiZh1B8bTuj7Ya8iSRXkeglmlrTZVcEAouw3PYcAFCh-RXVgCA6JVeG_25I_biW7nXoS7R-b8YrTPoXX_ccG15CTpZkZiOXvq2riN3g5YL3Z8a>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelledguddtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:E6tiZoAz2Dy-zY8mu4qroq_o4d-MIv4dDdMmLfV9pvrgYuKX7bUs4Q>
    <xmx:E6tiZtixltxuWP4urAIUoXXasDyzjoXzEz32a4E_Cc2CyQBugVXF6Q>
    <xmx:E6tiZkpl-BNjokoAOYhNYIIqH_hBKz69oC-6chJ9v5kZPJcLaMCGCw>
    <xmx:E6tiZggumarkONGVirNOk7Efm_S4GUhmcCCbedOUKFuAIMONEZXngQ>
    <xmx:E6tiZtd1bxXRdUPjtRMnfp73navQ1jyYd6RwOgJyk5I8wgYr1OOmOLwN>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Jun 2024 02:39:14 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 63351a3e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 7 Jun 2024 06:39:13 +0000 (UTC)
Date: Fri, 7 Jun 2024 08:39:12 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v6 21/27] mailmap: always store allocated strings in mailmap
 blob
Message-ID: <2bb96449e2a65f3398048b3430822bc7b95d31f0.1717740366.git.ps@pks.im>
References: <cover.1716983704.git.ps@pks.im>
 <cover.1717740365.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/TgzWyr0r2hnLFER"
Content-Disposition: inline
In-Reply-To: <cover.1717740365.git.ps@pks.im>


--/TgzWyr0r2hnLFER
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Same as with the preceding commit, the `git_mailmap_blob` may sometimes
contain an allocated string and sometimes it may contain a string
constant. This is risky and can easily lead to bugs in case the variable
is getting re-assigned, where the code may then try to free the previous
value to avoid memory leaks.

Safeguard the code by always storing allocated strings in the variable.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 mailmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mailmap.c b/mailmap.c
index b2efe29b3d..3d1e092fef 100644
--- a/mailmap.c
+++ b/mailmap.c
@@ -216,7 +216,7 @@ int read_mailmap(struct string_list *map)
 	map->cmp =3D namemap_cmp;
=20
 	if (!git_mailmap_blob && is_bare_repository())
-		git_mailmap_blob =3D "HEAD:.mailmap";
+		git_mailmap_blob =3D xstrdup("HEAD:.mailmap");
=20
 	if (!startup_info->have_repository || !is_bare_repository())
 		err |=3D read_mailmap_file(map, ".mailmap",
--=20
2.45.2.436.gcd77e87115.dirty


--/TgzWyr0r2hnLFER
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZiqw8ACgkQVbJhu7ck
PpTuZhAAlnFCcnFZd45X3oMeQjw2wW8/FlwNJHPVcqjuPMvDlkRuQsDKY6Qytt1S
pblXN9OytG1r6CbNBR8QxX+o9ZQaRgsTpgpBbGai3YI9XVEMnqj71EEcnnASMyT+
KX4KbwkMZzTxo3sONkHTz12kIEb9QBy46KMMVKcdg5Aj8lvENbrb9gXuxB0V/cAJ
K7TPfXkrEVGQ4vZipp+pA0+9GMhs1uLh+t7rRufPBiRuCjrFK93PtgqhAgakJsSc
UxQ7zZ5Gka4nyPIN43xsNqj3jo8evuBaCBhaJ6wFhoWNLW94RkKe8GmLWIw0WpXT
GTkdVYO0dvgQfObgK/dtUVbwP64/tEPqNUGKiOqMjRDh6zzd3S1hjwsI9TELICh2
vws7MzhviR0+2T9EznEirbSZN65opIRNVs2KyoaiDRDbOjvsvDty0M7HvsAGQItG
PnT1zA9eM59wS88k0I70uiK32QgzUSxUJGikZ/HSmkB7D2t3dgLqjIX82aLGWRKR
ej6G7DVkOdsaLkLY/DjXpm2aQjIsY7ne3tUOoMo345R/K+F3tX/Tu+m/RjCqYuOF
GUz9DUmlpnsZf5d/6SAgQRnuOG1uUzCpD5v91SMtdWeBYsOrfXjhoDzEdRQbAxi4
mGlnGN2daD5ieYUzQPLmMzO4mPrbXF81w5jXH3TBRq3KDhiKo9k=
=dFVY
-----END PGP SIGNATURE-----

--/TgzWyr0r2hnLFER--
