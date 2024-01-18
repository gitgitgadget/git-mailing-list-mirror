Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25DE210FC
	for <git@vger.kernel.org>; Thu, 18 Jan 2024 10:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705573375; cv=none; b=NSPMpeaWMQpZKkGB9RrPpZ+SLD/kNay2rykkdwKKiSd07uAMqDSi1Qrh9cCpx6EeAS/9NahMbBFmGV9YONPNtnzulq+tKA5or8nwJHEHvmE3s3r/zKYa6bFA8/hdTpsldtPysL+EEhZAyxKMBoT9h2B13DVFC+/ZnXXT4xTgf2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705573375; c=relaxed/simple;
	bh=1dw8XttQcgvvpLrWfd8NAiF4saouaKy9KYt8Nf9uJzw=;
	h=Received:Received:DKIM-Signature:DKIM-Signature:X-ME-Sender:
	 X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To; b=V/wpjHCmIpl/wLjRs9wnvMLIrP4josQ/UkUXrGqdz/ItU1zbOlNgH/I+wxDitP+wqX9Y7XzF+LFwt877XrpOS/bFPLtjq/SzYEEJPV7HMMbjKkfaEhdWkoqa4M6AoofWI5lRGJHJ8rxjS5Bn22b1cBWEAw1HHbSWbZRBSXmQPTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Sp2iNF92; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=R4uawXAF; arc=none smtp.client-ip=64.147.123.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Sp2iNF92";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="R4uawXAF"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.west.internal (Postfix) with ESMTP id B1E2A3200A90;
	Thu, 18 Jan 2024 05:22:52 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Thu, 18 Jan 2024 05:22:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1705573372; x=1705659772; bh=vbcFXvjTjO
	7bPTDQcPDwJjqzq1m40ggdji1KeIr0XMg=; b=Sp2iNF92UQ202DTpOV0+n5NspX
	EtjHgIw1rh0vmDZOQ/KOQUCZtzTt0ztLVKslrZNPuSRQOnd8wTGw9t9j7Drz3pGT
	F2+/Ce5HoO5UOmXmdITFsDUSbfeEMgFAk19h8JdSezHLX2JS0mlfHbgkuXct849k
	+DfgALt4sjOfMRWk29HQYzRepfATMG+lMxIBPHfzXXTq/UCjP7xe10jL6HJ1KGPh
	kfvMx8c6Jopv5NlQlM53EHmEe+YB61soMvKFWQeG50jUTGzlmuU7oNPpoiLNZhqs
	dLFWXSgwn5lvha8Potxt0Of2+kMYDOFUCoZcenuGCBnFnnpQmmovtKbBq4mw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1705573372; x=1705659772; bh=vbcFXvjTjO7bPTDQcPDwJjqzq1m4
	0ggdji1KeIr0XMg=; b=R4uawXAFRNW1katJSpewAFWSUPXoBhi2QeAQfVyOk1w/
	2P2w7klEqD6g37BVxpOXM9+AkcbQkehtnCI8YMJhrEsUivbEnC5JjU8X/sZRbYqD
	sBDf7x017ZQHosAvm7FrLXWvAv/5k8dy++FKiz4Qs1j7r8Bcj7tFX9sD/g9cwyTK
	w/UbO/BK6uxcxpsttpBBJgBVyAisYwysjPx97Xh2sfDwsT7Sx/j6o1yk59SpNTkZ
	efFk2UCM4W3EAHoY69xuq9KmrLMzA6p6uaT/JLGmMRNk9fJf/4OzFp3uOLhSdz48
	zyRRv9zowXkzrgtBDpiyt4PyVuV71PQMLDlP/IQrQw==
X-ME-Sender: <xms:_PuoZZdRXkhxj9IrI-VKPwvJU8GAxVpTB5WPGmt08XUbGFUM9dFw0Q>
    <xme:_PuoZXODoP59Xqz4ncsqPAgXHB9c1GOthoPGaX9-knToI-ug0rdSH9bVNgKaWz86g
    ld6FkBjfi2bYvFGBw>
X-ME-Received: <xmr:_PuoZSii1X_lYDYMBIE0B97az7iDTwl3pVCyjjvfgfYdApFNYlZhuovovMLW4_MQ34zhGqDQPNDartfeGAGT_ubzhs-lWcQ4nn_t3UEXen1PeYg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdejjedgudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:_PuoZS9nac_EGy9nejg5QVkZHeiyskaCxNmbaefAfODtlKhpR4Q6Rw>
    <xmx:_PuoZVvtLCAiqW2WNZuRtZ7gKmx7Umx-rNCgfCYjoum7a3uPqK2SYQ>
    <xmx:_PuoZRFuK0vO-OxYF9XoJ6u9t--arXPWRimPq-AIm8E8zOgHeoeYvA>
    <xmx:_PuoZWWJzmlfbHagNgD2Yytnaxw_xzOnqj9K7gWgBHHopmDrA7xapA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Jan 2024 05:22:51 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 8acc12ab (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 18 Jan 2024 10:19:56 +0000 (UTC)
Date: Thu, 18 Jan 2024 11:22:49 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>,
	Matthias =?iso-8859-1?Q?A=DFhauer?= <mha1993@live.de>
Subject: [PATCH v2 2/5] Makefile: detect new Homebrew location for ARM-based
 Macs
Message-ID: <32d8bd1d783b3f9f2bc31b8a4b3e9de2d13f6b87.1705573336.git.ps@pks.im>
References: <cover.1705318985.git.ps@pks.im>
 <cover.1705573336.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yiAarY2R4wPgtIf1"
Content-Disposition: inline
In-Reply-To: <cover.1705573336.git.ps@pks.im>


--yiAarY2R4wPgtIf1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

With the introduction of the ARM-based Macs the default location for
Homebrew has changed from "/usr/local" to "/opt/homebrew". We only
handle the former location though, which means that unless the user has
manually configured required search paths we won't be able to locate it.

Improve upon this by adding relevant paths to our CFLAGS and LDFLAGS as
well as detecting the location of msgfmt(1).

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 config.mak.uname | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/config.mak.uname b/config.mak.uname
index 3bb03f423a..dacc95172d 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -158,6 +158,19 @@ ifeq ($(uname_S),Darwin)
 		ifeq ($(shell test -x /usr/local/opt/gettext/bin/msgfmt && echo y),y)
 			MSGFMT =3D /usr/local/opt/gettext/bin/msgfmt
 		endif
+	# On newer ARM-based machines the default installation path has changed to
+	# /opt/homebrew. Include it in our search paths so that the user does not
+	# have to configure this manually.
+	#
+	# Note that we do not employ the same workaround as above where we manual=
ly
+	# add gettext. The issue was fixed more than three years ago by now, and =
at
+	# that point there haven't been any ARM-based Macs yet.
+	else ifeq ($(shell test -d /opt/homebrew/ && echo y),y)
+		BASIC_CFLAGS +=3D -I/opt/homebrew/include
+		BASIC_LDFLAGS +=3D -L/opt/homebrew/lib
+		ifeq ($(shell test -x /opt/homebrew/bin/msgfmt && echo y),y)
+			MSGFMT =3D /opt/homebrew/bin/msgfmt
+		endif
 	endif
=20
 	# The builtin FSMonitor on MacOS builds upon Simple-IPC.  Both require
--=20
2.43.GIT


--yiAarY2R4wPgtIf1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWo+/gACgkQVbJhu7ck
PpSZjg/+POw1wz4u8WrXodWz2rikE88tvEvLAqUKR0ItltT1UBix9CLJXvO+6UBJ
/zUP13aK+czXMOQG8KSTdoNJU2CG/2pPb3x05A0BoRdmdAvO+nL8JtB+5EzmL3Wg
T+UBK6hrzj5CzgbAw+PZgdJhkKQ5Z/s1qa6x2s209Lfk4Rh9MkYkJgf/ZZzyhrjT
s+2aejtopesCwywrGiiGTjSuhpfREjV0vzdXI4QeK2vAa6MKaWl3L43cYKiqqhbx
2Q16azUdtpl0UOFN4yKaClr3X85q9j7ayM12NEHsjQijUPjSHDvkS27kRAMOiFA7
snhs5hJ+MVu9hsybgOj9+IsrZGi39pUiqngrtvKSkK67XBhqx5K84I2vzEUQ/ln1
6g99urJ/YPuQa9/KpKBVp4M7pD7QnpUBcT2DzbcJgUrvey/rD1P9WLoRD6Bhow+t
18hAtbc8/V5fnZq09mJCdyihk2+yxjvR1qrFJnEUgk13rXYPYuOIcLXl7IiftIfo
WzHeSEV1+TpcoeBkhC+8XomVN0j51it0cWUwl5z8gYP3L97UFaBS56hDUuKywmhE
jg2nFLu7kXmGz5c4YroRc2TbxyPYphm2wdrtqW2pafYZleCCoYho60wveTNVdgqP
POHAccpTWTqjv+EpMS5ol+L84gnRGW/7m4oqQh/9845a28Ip0UE=
=ssYW
-----END PGP SIGNATURE-----

--yiAarY2R4wPgtIf1--
