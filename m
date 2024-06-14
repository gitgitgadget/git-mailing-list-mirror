Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1D81474C4
	for <git@vger.kernel.org>; Fri, 14 Jun 2024 06:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718347366; cv=none; b=U/QTI7DzvJnwmwLJRIrBzhKpFsHL4Ipfx+nzWU10woKprrlxXi/+SPJPxz2piaZWx1HquhbYf1x95vdS2FJkOLCAsQL+I5NN3BTtN3M9zZ70WKokun4PibrxPAZgCwRtPZgvyyRKVqNOyT20zGGL7SnAEzFQfHfHJecEewRNCxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718347366; c=relaxed/simple;
	bh=LOfVoy6doLAahEFcvTQJFxRcSZkV2+QoE03CoGIOVgw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hnrOOQOURZWoUBt5eeNYYkkKbYYEVl4duZrtVEAHaGF2BhlUc+uNuxbodm/HXznDuhcXgCfJxcAWqG/1Y57K3ild8nHmbn3VgqwcBhsKYmuy5WsvLh6/L2LxZqc++q2o9O+CPxipozITaDpJ4ljTMzmwZV9cfwcDCZZ62hKJoC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=EQp1bspg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iheYLqGY; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="EQp1bspg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iheYLqGY"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 92B35114021A;
	Fri, 14 Jun 2024 02:42:43 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 14 Jun 2024 02:42:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1718347363; x=1718433763; bh=3ElLNi3yT0
	xR3rB97C21WF7wJ2CoZVU61SsOlk49X0Q=; b=EQp1bspgcypVnxpL+HAPS/i/se
	CJu3yghF5++FifVUayqcvYP6ayTELqEQhUwBO52vfq+MXBUMe2OjXEBnNkRzgYKa
	api9whVN8/MQCXTbkhWtEIx/OVhI+XBcBLvdQrEofawdDku5eXlFGuNAmXrDizpj
	UxFX6WWliRPpZvZJZDWJwEtRfBZJ8KOlrfQ9VoInKbahwKhltlYFkCxb+j6w8elA
	VstCw2f3foSuo0Kk0mvgHn/Ss4nNHiZAKTGD6SQaDOE8TRsX1DIxWIqluCTy/Kao
	uweUMQIgGDIpnlzVN0YJHrt+TmtTdRqFy2L+xShJGuGP2b8rzAjy33PTqQGQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1718347363; x=1718433763; bh=3ElLNi3yT0xR3rB97C21WF7wJ2Co
	ZVU61SsOlk49X0Q=; b=iheYLqGYTUiLXA/xqRvC8W0c35MbNG5emr9BEJget/WV
	Q3NWT4rtwD9aiIqmixaZSJB7KaHeJmloGuTzysXnFXx7+iMNnb0MDUCOX+nxDug7
	Lmymm9ZjbIphBcsJ+4mrEZjl/pRfbop02oAbox8jWWYklG2FtfhFtL0DWT4sf+Ce
	T5medn8iqUL1E7ApHGPyfKd0KC+nmtB+DEbbZd+8LLJpHL03cPUpGzS4+Fk8PQH5
	7WMansSo6cWaKHn2JrNBAai7ANQd0P3P6pyQm8pyF8GPjPWSbH7cLCSdbRjhwKtB
	+ANk+x+fTuNoQgU4lzgaPjul/0ZQRq5l2c8kWnfN5Q==
X-ME-Sender: <xms:Y-ZrZiYXlpw9XPtwRY2qqSvW3S-tDzmz8Ag0DprDlguxrX5dxcwuGw>
    <xme:Y-ZrZlYbshdzcnWmdxoASHX9Sr65C1k8ZYI0rIN5frobIQLQ7G_voo_Ps7c6z2zUE
    2UVasUW-jAMrRFXSA>
X-ME-Received: <xmr:Y-ZrZs8_Ddru_4bSgyojO9LHKzShrrBhrwua3Mb3KfJ3ibOTjxgkhoS35DInb5TQ7wzELiqXukBhGbeJ6vGArHUuN2C8hlxMDj7Pgy3jQPWUFQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedukedguddtvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:Y-ZrZkqRr1gDbhbopbasUwYAKOkK_0wUPL1ZInOjrFFzqnrBC6X85A>
    <xmx:Y-ZrZtocxdeL2QFhTOimNhPEES0cT80Bf0s3mqmlYKSYiQi3gY6TWQ>
    <xmx:Y-ZrZiTBtxzLSFer2ub5rSTS9lEuQvxAzQttMeJM-6w7Ihx62VGfqg>
    <xmx:Y-ZrZtolkQn1nxx_C1HanOH9WXIo4z-ThyE3mmQAgqju_ouIsoacLQ>
    <xmx:Y-ZrZhe6VzkrZAZ3FXm4rGFTsQFqufjKv3d84ag3_IyHVd2hPzqaDSb_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Jun 2024 02:42:42 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id a49c0d06 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 14 Jun 2024 06:42:26 +0000 (UTC)
Date: Fri, 14 Jun 2024 08:42:39 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Justin Tobler <jltobler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Dragan Simic <dsimic@manjaro.org>,
	Karthik Nayak <karthik.188@gmail.com>,
	Todd Zullinger <tmz@pobox.com>
Subject: [PATCH v7 2/4] BreakingChanges: document upcoming change from "sha1"
 to "sha256"
Message-ID: <d0ec38a25ab4fbdcb8ffa726931ead3fc68662b4.1718345026.git.ps@pks.im>
References: <fc1a9fa03de7330f79dc56b0f2712834cb236b5a.1715070296.git.ps@pks.im>
 <cover.1718345026.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="U89kB4lNpwzlZlQv"
Content-Disposition: inline
In-Reply-To: <cover.1718345026.git.ps@pks.im>


--U89kB4lNpwzlZlQv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Starting with 8e42eb0e9a (doc: sha256 is no longer experimental,
2023-07-31), the "sha256" object format is no longer considered to be
experimental. Furthermore, the SHA-1 hash function is actively
recommended against by for example NIST and FIPS 140-2, and attacks
against it are becoming more practical both due to new weaknesses
(SHAppening, SHAttered, Shambles) and due to the ever-increasing
computing power. It is only a matter of time before it can be considered
to be broken completely.

Let's plan for this event by being active instead of waiting for it to
happend and announce that the default object format is going to change
=66rom "sha1" to "sha256" with Git 3.0.

All major Git implementations (libgit2, JGit, go-git) support the
"sha256" object format and are thus prepared for this change. The most
important missing piece in the puzzle is support in forges. But while
GitLab recently gained experimental support for the "sha256" object
format though, to the best of my knowledge GitHub doesn't support it
yet. Ideally, announcing this upcoming change will encourage forges to
start building that support.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/BreakingChanges.txt | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/Documentation/BreakingChanges.txt b/Documentation/BreakingChan=
ges.txt
index cb7e30312f..68ad42d805 100644
--- a/Documentation/BreakingChanges.txt
+++ b/Documentation/BreakingChanges.txt
@@ -70,6 +70,36 @@ be changed to or replaced in case the alternative was im=
plemented already.
=20
 =3D=3D=3D Changes
=20
+* The default hash function for new repositories will be changed from "sha=
1"
+  to "sha256". SHA-1 has been deprecated by NIST in 2011 and is nowadays
+  recommended against in FIPS 140-2 and similar certifications. Furthermor=
e,
+  there are practical attacks on SHA-1 that weaken its cryptographic prope=
rties:
++
+  ** The SHAppening (2015). The first demonstration of a practical attack
+     against SHA-1 with 2^57 operations.
+  ** SHAttered (2017). Generation of two valid PDF files with 2^63 operati=
ons.
+  ** Birthday-Near-Collision (2019). This attack allows for chosen prefix
+     attacks with 2^68 operations.
+  ** Shambles (2020). This attack allows for chosen prefix attacks with 2^=
63
+     operations.
++
+While we have protections in place against known attacks, it is expected
+that more attacks against SHA-1 will be found by future research. Paired
+with the ever-growing capability of hardware, it is only a matter of time
+before SHA-1 will be considered broken completely. We want to be prepared
+and will thus change the default hash algorithm to "sha256" for newly
+initialized repositories.
++
+An important requirement for this change is that the ecosystem is ready to
+support the "sha256" object format. This includes popular Git libraries,
+applications and forges.
++
+There is no plan to deprecate the "sha1" object format at this point in ti=
me.
++
+Cf. <2f5de416-04ba-c23d-1e0b-83bb655829a7@zombino.com>,
+<20170223155046.e7nxivfwqqoprsqj@LykOS.localdomain>,
+<CA+EOSBncr=3D4a4d8n9xS4FNehyebpmX8JiUwCsXD47EQDE+DiUQ@mail.gmail.com>.
+
 =3D=3D=3D Removals
=20
 =3D=3D Superseded features that will not be deprecated
--=20
2.45.2.457.g8d94cfb545.dirty


--U89kB4lNpwzlZlQv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZr5l4ACgkQVbJhu7ck
PpQm3Q/+P9dGP0uxCwsmlJlmvSvtEnkDW4s2bAJyjG0lw5BQzqD3Vknb8zN3QB+x
RSALx5glekaNSdG9Bkd+srRUweJ5wEU81N/5YG+N+2fvg5kIW06Qn87OOwxIGN/k
fFmhgM1WhC10BD1bRLQzK6bpd9E0Go754utQGA8AZE3P7O1VyjNJYkNBjQir2URM
Jf4MFdL6igqUr06OxzqX/bABUKiQw/hJ8mehzhZWrtessOHMTqIIyIWci3N5eQRF
69SXhzGc9Xa8vloD9l+GSY7ww3Erdyi8u9zDta6AH9nMHz2QTgLwcZh+4vgm42F2
xBcFRR4l5KZLnCKZsKETTYWGbR/j7FTKqvmO1eVAtehwoYG5HrWXX0E9/QBGmhiY
iFqfVBP4KzUzAnlI0+IYAh9+YgW2dZ+sfi0xk175+be29meTlYNFyDp2iG7t1WXP
gZOrmBAJxIeLIMa2ZB8xbYwNp4h3/XamolHBAbhp3/cBXJ17t5VSVn8Y/0I0Jkcy
VVHP6EiDuFL75tXbTzQVlcI6iOGai6ttR9uFpY4bUHRGvtidK+j1mfGhsK67NMkP
JiGv06YuWnaXi0VmdkDPqsBguso8StfmZAM6/2KwPMmKZ6CqhbzcrAg8B3CiVL47
vYid3my5b/wjR03kkJz4YhuDn8CWMa2plEmzvNa74M+IcvE+Z/k=
=bcmi
-----END PGP SIGNATURE-----

--U89kB4lNpwzlZlQv--
