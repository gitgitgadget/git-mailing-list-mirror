Received: from wfhigh6-smtp.messagingengine.com (wfhigh6-smtp.messagingengine.com [64.147.123.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77ED12E5B
	for <git@vger.kernel.org>; Wed, 29 May 2024 12:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716986741; cv=none; b=AcP+EhcS9RUmaID7bp9cyDrcCS1xFa4hT33IASWvu02PGZeP4fmkBUMpc+LiouOCqD/9nvU5d/VP7LoeLHGvMoXdnSucV4Savyx+XCfz1ceyB1CHmT61DbubtFxMUniD0fasPRPL2qFFerXUGhi+hiuH0sCPvt96XLOyJ/7gbdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716986741; c=relaxed/simple;
	bh=gXbJs77wQdZ5la+RCoUDgSdpfGztRSu4HTdgw5H0Ops=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=awtRiO53ZCiX36cLqLvi85dZ0m67gnFpJoPEoX1Dde9WCFnhDSKs2sYrCd70Gh84VSo5/N9zko6Gux7xgbuvgh4wDpA464fLE4DNAp7v9MZIBLcykTTRkpCEPKGeaXhQ6C+7N6iGE0q1qewG8MDx69Tl5an1G7eVjD2TYhkAxYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RetuSXQf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=a+kcBbze; arc=none smtp.client-ip=64.147.123.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RetuSXQf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="a+kcBbze"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.west.internal (Postfix) with ESMTP id 007AC180011B;
	Wed, 29 May 2024 08:45:38 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 29 May 2024 08:45:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716986738; x=1717073138; bh=gXbJs77wQd
	Z5la+RCoUDgSdpfGztRSu4HTdgw5H0Ops=; b=RetuSXQfwwIGsOhtZOD9107Gba
	N03Z0jMfG1ZPK/UyCrmuTH74GKZ9o5H/5l+pA5inwVfla1ydRHBR7oMxsjYvYx6Z
	9NBx0/Kmoz3bZ4A1G87hGYN+Kpxzu1nKD6QR74cK6YETpyUOH7VLo3IZP3lJ4keV
	e4jb73uvbvat8/VqMIk9YHq18N7dDtD9bADSAmYfqOLl0BAxnejQVwJmKJuShCoe
	WCF67z8jr9gKtmg1jxh0ZFDdi3VzfR4lvkyniFCDHTRFHQnekHBBnMVsY8HJLc26
	TsvzUdI599gPb6ot6rT82E/yI3+ZGLBI9r11oZV1lrdYY+wcXC1nTbmfVZ+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716986738; x=1717073138; bh=gXbJs77wQdZ5la+RCoUDgSdpfGzt
	RSu4HTdgw5H0Ops=; b=a+kcBbzeuUyQRalln68lu+hkPdJpv21pCODSuc6dbhKS
	0jvGTCY7PBOGoDphPhG4GnLg8cN003xgs2d1nOP5VGKlv1BbT8NI2Rzh6SzHejv7
	avb+J7uc1rzeEO4uYe66tL1iFscVSaSVvvbSQ/B+ONoqktDOOQTLV+LGtdK2y5e0
	8r/AoU/97XqCBO9LgRDqmysZx3vOY260N6bsIAZX0nSNobO8Zbrvgk88tcWNabdo
	u0e6bZ8sC6RPIBavhKaDX6sypO0uT9czigOvrpe2f+4oHXt/WfjWNX8+j1EKv/k2
	LtnSf/h49LVcEVALBeHLhoMwegDp4ej+XyYldo/+Uw==
X-ME-Sender: <xms:ciNXZgcF8kHz7_eg8AB2KMmeb2wVmIK9U7oNlqOI11H3qHlq2KNF0A>
    <xme:ciNXZiOK-oCFW5vikD209mAyZv8XUCN4AyQ4KlJs-WXeVxTVnF6zbBrkKIanczs56
    f7yPn2eAiA1EWF3QQ>
X-ME-Received: <xmr:ciNXZhibbKym6bTNTnkufp6BKOc3f1IVp7yNjlF8JyqOg0KOzuV-6LI4bp2trK5YTK85wv8wr1hgsVXX4S1Q6kXLiF6rEp2p9LA1WicTHzJj9LIy>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdekuddgheegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpedtkeefgeeiiedugfdvgeeffffgtdehge
    efieetffekleetgeffvdfhveejudejtdenucffohhmrghinhepmhgrkhdruggvvhenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhm
X-ME-Proxy: <xmx:ciNXZl8FmQz_p5b62zKCuf1H6nE1aeF-lX_lVZLcv4dTRGF0dDawsQ>
    <xmx:ciNXZstn0mml0ZgALgN1llpdcJx9KuAugpo75xMLBSkbuAWMSas8NQ>
    <xmx:ciNXZsEv4VEo0hQ94EEQF7ZFeqOkB6fPVsGFaXr9GCbr6hC26QtLkA>
    <xmx:ciNXZrNMUgR4U3ZZUQKSeMInnChpHZJQnvuaQwp6Mjr0NBfNoe39hQ>
    <xmx:ciNXZl6DuCSMlf3DSGSTaEzl43aqbudjL9aEF9xr5i03vt2YvwkE2EPa>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 May 2024 08:45:37 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id fff5cd66 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 29 May 2024 12:45:23 +0000 (UTC)
Date: Wed, 29 May 2024 14:45:35 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>
Subject: [PATCH 19/19] config.mak.dev: enable `-Wwrite-strings` warning
Message-ID: <37e7aaed97df0b902631e76ba82ee7c6473293ad.1716983704.git.ps@pks.im>
References: <cover.1716983704.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kzMLptoPE6KEaL7w"
Content-Disposition: inline
In-Reply-To: <cover.1716983704.git.ps@pks.im>


--kzMLptoPE6KEaL7w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Writing to string constants is undefined behaviour and must be avoided
in C. Even so, the compiler does not help us with this by default
because those constants are not in fact marked as `const`. This makes it
rather easy to accidentally assign a constant to a non-const variable or
field and then later on try to either free it or write to it.

Enable `-Wwrite-strings` to catch such mistakes. With this warning
enabled, the type of string constants is changed to `const char[]` and
will thus cause compiler warnings when being assigned to non-const
fields and variables.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 config.mak.dev | 1 +
 1 file changed, 1 insertion(+)

diff --git a/config.mak.dev b/config.mak.dev
index 981304727c..1ce4c70613 100644
--- a/config.mak.dev
+++ b/config.mak.dev
@@ -37,6 +37,7 @@ DEVELOPER_CFLAGS +=3D -Wpointer-arith
 DEVELOPER_CFLAGS +=3D -Wstrict-prototypes
 DEVELOPER_CFLAGS +=3D -Wunused
 DEVELOPER_CFLAGS +=3D -Wvla
+DEVELOPER_CFLAGS +=3D -Wwrite-strings
 DEVELOPER_CFLAGS +=3D -fno-common
=20
 ifneq ($(filter clang4,$(COMPILER_FEATURES)),)
--=20
2.45.1.313.g3a57aa566a.dirty


--kzMLptoPE6KEaL7w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZXI24ACgkQVbJhu7ck
PpRD+RAAlIjd8oj25WNuLD3SG2fwX/OzSAQBUQwyhIDHPGYKatM0PoqSqrDY2z8m
qK8Ei40Rjr3+I/eLrUm01os+8Cvn/kyiXX26glakzQ/EMxUiGJjaKzkKIWmdwdqX
N3tYxrsXjldaE6DEFS3ss//Q9ce3OhsPZTmFpR4FLSB/gav6/uXEgr2fez68cwRA
yFXDN0xZoZtqgZ9n0oOiRslqfKCu8MuA5JlKw0wa72qNfumo36V4PDXPgHGN7dI0
M5nYZsunveSels82z890xCCN7HvNQ+uZvkbg/rFVLhyujQrDF1ZpyKSH21Y0+pJB
Zj7hbfimJdjB0leb4KuQJSITpuDv3wmB56bSiBz4ubF6+orWNNL3f9q3ONcFPCoI
3RsRrlrvCmELvSfu8FnDdXCqk486dUidPA7VqxOyNPzBSDTZZJ2VUoHeMFuIxuF/
CEl1/NevjidzyNFBFNiCLNnXn/jaVGTpi9xula4+rmOxZksWToPOUh1MvfHKvnco
mKKjWOApdYNWJNUvtzPdA68s7buHqSFivl+Zczee6VAXlgXEHLZfYPuDWLEC0l9G
X/p1szrwUFeNoKXZAu+bRkyK/5VHEVlyXBm0LWs4wQB/fa2d5klBMRV8xJw3Qz9B
pC8xxMvs4T3ioCoPzO72r18D0RVyb4dsZHQ4Pf1sf0bN0QLNRRw=
=hKWL
-----END PGP SIGNATURE-----

--kzMLptoPE6KEaL7w--
